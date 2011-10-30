# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Female Spanish voice for Festival"
HOMEPAGE="http://www.guadalinex.org"
SRC_URI="http://v7.guadalinex.org/guadalinex-lince/pool/main/f/${PN}/${PN}_${PV}_all.deb"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

S="${WORKDIR}"

src_install() {
	cd "${D}"
	tar xvzf "${WORKDIR}"/data.tar.gz
	rm "${D}"/usr/share/doc -rf
}

pkg_postinst() {
	elog "To make this voice default edit /etc/festival/siteinit.scm and"
	elog "add (set! voice_default 'voice_JuntaDeAndalucia_es_sf_diphone)"
}
