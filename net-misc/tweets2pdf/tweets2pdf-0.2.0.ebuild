# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.*"

inherit distutils python

DESCRIPTION="Backup your tweets into FANTANSTIC PDF files"
HOMEPAGE="http://code.google.com/p/tweets2pdf/"
SRC_URI="http://tweets2pdf.googlecode.com/files/${P}.tar.gz"


LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/reportlab
                 dev-python/imaging
                 >=dev-python/pygtk-2.24"
RDEPEND="${DEPEND}"


