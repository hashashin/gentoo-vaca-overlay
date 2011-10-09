# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit subversion

DESCRIPTION="A free, compatible alternative for 3Dconnexion's 3D input SDK"
HOMEPAGE="http://spacenav.sourceforge.net/"
ESVN_REPO_URI="https://spacenav.svn.sourceforge.net/svnroot/spacenav/trunk/libspnav"
ESVN_PATCHES=libspnav-makefile.patch

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+X"

DEPEND="X? ( x11-libs/libX11 )"
RDEPEND="${DEPEND}"

src_configure() {
	#add system cflags
	sed -i "/CFLAGS =/s/$/ ${CFLAGS}/" Makefile.in

	#disable opt and debug becuase they only add options to cflags
	#which are better controlled by make.conf,etc.
	econf \
		--disable-opt \
		--disable-debug \
		$(use_enable X x11)
}

src_install() {
	    emake DESTDIR="${D}" install || die "Install failed"
}

