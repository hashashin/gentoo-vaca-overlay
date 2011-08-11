# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils

DESCRIPTION="Generar de diccionarios"
HOMEPAGE="http://www.seguridadwireless.net"
SRC_URI="http://www.telefonica.net/web2/amstrad/${PN}-${PV}.tar.gz"
IUSE=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-${PV}"

src_install() {
	dobin "${S}/src/dictool"
	dodoc README
	dodoc AUTHORS
	dodoc ChangeLog
	dodoc INSTALL
	dodoc COPYING
}
