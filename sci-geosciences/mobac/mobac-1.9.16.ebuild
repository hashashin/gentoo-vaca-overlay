# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit eutils

DESCRIPTION="creates offline atlases for GPS handhelds and cell phone applications"
HOMEPAGE="http://mobac.sourceforge.net"
SRC_URI="mirror://sourceforge/mobac/Mobile%20Atlas%20Creator/MOBAC%201.9/Mobile%20Atlas%20Creator%20${PV}%20src.zip \
mirror://sourceforge/mobac/Misc/mappack-misc.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="jai spanish-maps misc-maps"

RDEPEND=">=virtual/jre-1.6.0
	dev-java/log4j"
DEPEND=">=virtual/jdk-1.4
	dev-java/ant"

S="${WORKDIR}"

pkg_setup() {
	enewgroup ${PN}
	enewuser ${PN} -1 -1 /dev/null ${PN}
}

src_compile() {
	cd "${WORKDIR}" && ant || die
}

src_install() {
	diropts -m0775
	exeinto /usr/bin
	doexe "${FILESDIR}"/mobac
	insinto /opt/${PN}
	doins Mobile_Atlas_Creator.jar
	doins lib/sqlite-jdbc-3.7.2.jar
	doins -r mapsources
	doins log4j.xml
	dodir /opt/${PN}/tilestore
	dodoc README.HTM
	dodoc CHANGELOG.txt
	domenu "${FILESDIR}"/mobac.desktop
	doicon "${FILESDIR}"/mobac.png
	if use spanish-maps; then
		insinto /opt/${PN}/mapsources
		doins "${FILESDIR}"/*.xml
	fi
	if use misc-maps; then
		insinto /opt/${PN}/mapsources
		doins mp-misc.jar
	fi
	if use jai; then
		insinto /opt/${PN}/
		doins lib/jai_codec.jar
		doins lib/jai_core.jar
	fi
	fowners -R ${PN}:${PN} /opt/${PN}
	fperms 0775 /opt/${PN}
}

pkg_postinst() {
	elog "Add your user to group mobac to use the program"
}

pkg_postrm() {
	elog "Remenber to manual clean runtime created files in /opt/${PN}"
}
