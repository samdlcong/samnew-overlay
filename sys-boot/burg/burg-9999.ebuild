# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit mount-boot eutils flag-o-matic toolchain-funcs

EBZR_REPO_URI="lp:burg"
inherit autotools bzr
SRC_URI=""

DESCRIPTION="Brand-new Universal loadeR from Grub"
HOMEPAGE="https://code.launchpad.net/burg"

LICENSE="GPL-3"
use multislot && SLOT="2" || SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="custom-cflags debug truetype multislot static"

RDEPEND=">=sys-libs/ncurses-5.2-r5
	dev-libs/lzo"
DEPEND="${RDEPEND}
	dev-lang/ruby"
PROVIDE="virtual/bootloader"

export STRIP_MASK="*/burg/*/*.mod"
QA_EXECSTACK="sbin/burg-probe sbin/burg-setup sbin/burg-mkdevicemap"

src_unpack() {
if [[ ${PV} == "9999" ]] ; then
		bzr_src_unpack
	else
		unpack ${A}
	fi
	cd "${S}"
#	epatch "${FILESDIR}"/burg-genkernel.patch #256335
#	epatch_user

	# autogen.sh does more than just run autotools
if [[ ${PV} == "9999" ]] ; then
sed -i \
			-e '/^\(auto\|ac\)/s:^:e:' \
			-e "s:^eautomake:`which automake`:" \
			autogen.sh
		(. ./autogen.sh) || die
fi
}

src_compile() {
	use custom-cflags || unset CFLAGS CPPFLAGS LDFLAGS
	use static && append-ldflags -static

	econf \
                --disable-werror \
		--sbindir=/sbin \
		--bindir=/bin \
                --libdir=/$(get_libdir) \
                --disable-efiemu \
                $(use debug && echo --enable-mm-debug) \
		$(use_enable debug grub-fstest) \
                $(use_enable debug grub-emu-usb) 
	emake || die "making regular stuff"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
	cat <<-EOF >> "${D}"/lib*/burg/burg-mkconfig_lib
	GRUB_DISTRIBUTOR="Gentoo"
	EOF
}

setup_boot_dir() {
	local boot_dir=$1
	local dir=${boot_dir}/burg

	if [[ ! -e ${dir}/burg.cfg ]] ; then
		burg-mkconfig -o "${dir}/burg.cfg"
	fi

	#local install=burg-install
	#use multislot && install="burg2-install --burg-setup=/bin/true"
	#einfo "Running: ${install} "
	#${install}
}
pkg_postinst() {
        setup_boot_dir "${ROOT}"boot
}

