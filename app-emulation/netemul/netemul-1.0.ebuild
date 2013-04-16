# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit qt4-r2

DESCRIPTION="NetEmul is a program for simulating computer networks"
HOMEPAGE="http://netemul.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="dev-qt/qtgui:4
	dev-qt/qtopengl:4
"

src_prepare() {
	epatch "${FILESDIR}"/fix-gcc.patch
}

src_configure() {
	eqmake4 PREFIX=/usr
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "emake install failed"
}
