# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit eutils

DESCRIPTION="kvm Glade GUI"
HOMEPAGE="http://gkvm.sourceforge.net/"
SRC_URI="mirror://sourceforge/gkvm/gkvm-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2
	gnome-base/libglade"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_install() {
	doicon pixmaps/gkvm.png
	domenu gkvm.desktop
	exeinto /usr/bin
	doexe src/gkvm
	dodoc README ChangeLog AUTHORS NEWS TODO
}
