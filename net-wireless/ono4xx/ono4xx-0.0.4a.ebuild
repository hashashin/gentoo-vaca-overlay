# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils

DESCRIPTION="Generador claves por defecto de ONOXXXX."
HOMEPAGE="http://www.seguridadwireless.net"
SRC_URI="https://dl.dropboxusercontent.com/u/210030302/${PN}-${PV}.tar.gz"
IUSE=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-libs/openssl"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-${PV}"

src_install() {
	dobin ono4xx
	dodoc leeme.txt
}
