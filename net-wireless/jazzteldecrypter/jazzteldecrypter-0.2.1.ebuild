# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit eutils

DESCRIPTION="Generador de claves de WLAN_XXXX."
HOMEPAGE="http://www.seguridadwireless.net"
SRC_URI="http://www.fileden.com/files/2008/10/11/2138272/jazzteldecrypter.c"
IUSE=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-libs/openssl"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_prepare() {
	cp "${DISTDIR}"/jazzteldecrypter.c "${S}"/
	cp "${FILESDIR}"/makefile "${S}"/Makefile
}

src_install() {
	dobin jazzteldecrypter
}
