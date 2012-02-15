# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gtkdialog/gtkdialog-0.7.20.ebuild,v 1.3 2009/06/01 16:58:01 nixnut Exp $

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
	dev-util/pkgconfig"

src_install() {
	doicon pixmaps/gkvm.png
	domenu gkvm.desktop
	doexe src/gkvm
}
