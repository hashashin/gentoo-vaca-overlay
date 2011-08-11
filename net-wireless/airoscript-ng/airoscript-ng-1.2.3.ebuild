# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils versionator

DESCRIPTION="Script para automatizar aircrack-ng."
HOMEPAGE="http://amunhoney.sourceforge.net/"
MY_PV=$(replace_version_separator 2 '-')
MM_PV=$(get_version_component_range '1-2')
SRC_URI="http://airoscript.googlecode.com/files/${PN}-${MY_PV}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

S="${WORKDIR}/${PN}-${MM_PV}"

src_prepare() {
	rm "${S}/Makefile"
	rm "${S}/Makefile-CYGWIN"
	rm "${S}/Makefile-Linux"
	cp -r "${S}/src/functions" "${S}/"
	cp -r "${S}/src/themes" "${S}/"
	cp -r "${S}/src/plugins" "${S}/"
	cp -r "${S}/src/locale" "${S}/"
	cp "${S}/src/airoscript-ng.conf" "${S}/"
	cp "${S}/src/airoscript-ng" "${S}/"
	rm -rf "${S}/src/"
}

src_install() {
	insinto "/usr/local/${PN}"
	doins -r "${S}"
	exeinto /usr/local/bin
	doexe "${S}/airoscript-ng"
	insinto /etc
	doins "${S}/airoscript-ng.conf"
#	dodesktop "${S}/aircrack-airoscript.desktop"
#	dolocale "${S}/src/locale"
	dodoc "${S}/doc/authors"
	dodoc "${S}/doc/changelog"
	dodoc "${S}/doc/install"
	dodoc "${S}/doc/license"
}
