# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils

DESCRIPTION="Generador de claves por defecto tele2."
HOMEPAGE="http://www.seguridadwireless.net"
SRC_URI="http://www.bitsdelocos.es/SW/tele2dic_v${PV}.tar.gz"
IUSE=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-libs/openssl"
DEPEND="${RDEPEND}"

S="${WORKDIR}/tele2dic_v${PV}"

src_prepare() {
	make clean
}

src_install() {
	dobin tele2dic
	dodoc README.txt
}
