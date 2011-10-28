# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ps3mediaserver/ps3mediaserver-1.20.412-$

EAPI="4"

inherit eutils

DESCRIPTION="creates offline atlases for GPS handhelds and cell phone applications"
HOMEPAGE="http://mobac.sourceforge.net"
SRC_URI="mirror://sourceforge/mobac/Mobile%20Atlas%20Creator/MOBAC%201.9/Mobile%20Atlas%20Creator%201.9.2.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="jai spanish-maps"

DEPEND=""
RDEPEND=">=virtual/jre-1.6.0
	jai? ( dev-java/sun-jai-bin )"

S="${WORKDIR}"

pkg_setup() {
	enewgroup ${PN}
	enewuser ${PN} -1 -1 /dev/null ${PN}
}

src_install() {
	diropts -m0775
	exeinto /usr/bin
	doexe "${FILESDIR}"/mobac
	insinto /opt/${PN}
	doins Mobile_Atlas_Creator.jar
	doins sqlitejdbc-v056.jar
	doins -r mapsources
	dodir /opt/${PN}/tilestore
	dodoc README.HTM
	dodoc CHANGELOG.txt
	dodoc ReleaseNotes.txt
	domenu "${FILESDIR}"/mobac.desktop
	doicon "${FILESDIR}"/mobac.png
	if use spanish-maps; then
		insinto /opt/${PN}/mapsources
		doins "${FILESDIR}"/*.xml
	fi
	fowners -R ${PN}:${PN} /opt/${PN}
	fperms 0775 /opt/${PN}
}

pkg_postinst() {
	elog "Add your user to group mobac to use the program"
	if use jai; then
		elog ""
		elog "You need to manual copy /usr/share/sun-jai-bin/lib/jai_core.jar"
		elog "and /usr/share/sun-jai-bin/lib/jai_codec.jar to /opt/${PN}"
		elog "in order to be posible reduce the color depth of downloaded"
		elog "tiles the library files."
	fi
}
