# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils

DESCRIPTION="Generador de claves de WLAN_XXXX."
HOMEPAGE="http://www.seguridadwireless.net"
SRC_URI="http://www.seguridadwireless.net/archivos/wlandecrypter-${PV}.tar.gz"
IUSE=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-libs/openssl"
DEPEND="${RDEPEND}"

S="${WORKDIR}/wlandecrypter-${PV}"

src_install() {
	dobin wlandecrypter
	dodoc README.txt
}
