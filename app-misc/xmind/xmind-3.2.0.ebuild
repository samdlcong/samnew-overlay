# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
 
inherit eutils
 
DESCRIPTION="Another Mind-mapping software written in Java"
HOMEPAGE="http://www.xmind.net/"                                                                          
# SRC_URI="ftp://foo.bar.com/${P}.tar.bz2"                                                                   
RELDATE=201009142023                                                                                       
SRC_URI="http://dl.xmind.org/xmind-portable-${PV}.${RELDATE}.zip"                                            
 
LICENSE="GPL"                                                                                                
SLOT="0"                                                                                                     
KEYWORDS="~x86 ~amd64"                                                                                       
IUSE=""                                                                                                      
 
DEPEND=""                                                                                                    
RDEPEND="${DEPEND}"                                                                                          
 
src_install(){                                                                                               
        XMIND_HOME=/opt/xmind/                                                                               
        insinto ${XMIND_HOME}                                                                                
        # cd ${S}                                                                                            
        cd .
 
        doins -r *
        # fperms 755 /usr/local/xmind/xmind
        fperms 755 ${XMIND_HOME}/XMind_Linux_64bit/xmind-bin
        fperms 755 ${XMIND_HOME}/XMind_Linux_64bit/xmind
        fperms 755 ${XMIND_HOME}/XMind_Linux/xmind-bin
 
        # Create openproj wrapper   /usr/bin/filename   exec file name                     exec dir    libpat
h
        make_wrapper xmind "${XMIND_HOME}/XMind_Linux_64bit/xmind-bin -data \${HOME}/.xmind" \${HOME} ${XMIND
_HOME}/lib:${XMIND_HOME}
        // newicon "${FILESDIR}"/openproj.png ${PN}.png
        make_desktop_entry XMind "xmind" ${PN} "Develop"
}
