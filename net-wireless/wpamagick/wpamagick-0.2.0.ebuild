# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils

DESCRIPTION="Saca las claves wpa de WLAN_XXXX."
HOMEPAGE="http://foro.seguridadwireless.net/aplicaciones-y-diccionarios-linux/wpamagickey-claves-por-defecto-wlan_xxxx-jazztel_xxxx-routers-comtrend-35300/"
SRC_URI="http://www.seguridadwireless.net/archivos/WPAmagickey-${PV}.tar.gz"
IUSE=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-libs/openssl"
DEPEND="${RDEPEND}"

S="${WORKDIR}/WPAmagickey-${PV}"
