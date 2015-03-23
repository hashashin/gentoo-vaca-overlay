# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/arduino/arduino-1.0.5.ebuild,v 1.3 2013/08/18 13:27:34 ago Exp $

EAPI=5

inherit eutils

DESCRIPTION="An open-source AVR electronics prototyping platform"
HOMEPAGE="http://arduino.cc/ http://arduino.googlecode.com/"
SRC_URI="http://blog.spitzenpfeil.org/arduino/mirror_released/arduino-"${PV}"-linux64.tar.xz mirror://gentoo/arduino-icons.tar.bz2"
LICENSE="GPL-2 GPL-2+ LGPL-2 CC-BY-SA-3.0"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="strip binchecks"
IUSE=""

COMMONDEP="
dev-util/astyle"

RDEPEND="${COMMONDEP}
dev-embedded/avrdude
dev-embedded/uisp
>=virtual/jre-1.5"

DEPEND="${COMMONDEP}
>=virtual/jdk-1.5"

S="${WORKDIR}"/arduino-"${PV}"

src_unpack(){
	unpack ${A}
}

src_install() {
	exeinto /opt/bin
	doexe "${FILESDIR}"/arduino-bin
	insinto "/opt/${PN}/"
	doins -r hardware libraries reference examples
	fowners -R root:uucp "/opt/${PN}/hardware"

	insinto "/opt/${PN}/lib"
	doins -r lib/*.txt lib/theme lib/*.jpg

	# use system avrdude
	# patching class files is too hard
	dosym /usr/bin/avrdude "/opt/${PN}/hardware/tools/avr/bin/avrdude"
	dosym /etc/avrdude.conf "/opt/${PN}/hardware/tools/avr/etc/avrdude.conf"

	dosym /usr/lib64/libastyle.so "/opt/${PN}/lib/libastylej.so"
	dosym /usr/bin/avr-g++ "/opt/${PN}/hardware/tools/avr/bin/avr-g++"
	dosym /usr/bin/avr-gcc "/opt/${PN}/hardware/tools/avr/bin/avr-gcc"
	dosym /usr/bin/avr-ar "/opt/${PN}/hardware/tools/avr/bin/avr-ar"
	dosym /usr/bin/avr-objcopy "/opt/${PN}/hardware/tools/avr/bin/avr-objcopy"
	dosym /usr/bin/avr-size "/opt/${PN}/hardware/tools/avr/bin/avr-size"
	
	# install menu and icons
	domenu "${FILESDIR}/${PN}-bin.desktop"
	for sz in 16 24 32 48 128 256; do
		newicon -s $sz \
			"${WORKDIR}/arduino-icons/debian_icons_${sz}x${sz}_apps_${PN}.png" \
			"${PN}.png"
	done
}

pkg_postinst() {
	[ ! -x /usr/bin/avr-g++ ] && ewarn "Missing avr-g++; you need to crossdev -s4 avr"
}
