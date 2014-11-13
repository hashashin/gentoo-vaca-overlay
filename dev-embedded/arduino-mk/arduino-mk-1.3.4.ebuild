# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/arduino/arduino-1.0.5.ebuild,v 1.3 2013/08/18 13:27:34 ago Exp $

EAPI=5

inherit eutils

MY_PN="Arduino-Makefile"

DESCRIPTION="Makefile for Arduino sketches."
HOMEPAGE="https://github.com/sudar/Arduino-Makefile"
SRC_URI="https://github.com/sudar/${MY_PN}/archive/${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

COMMONDEP="
dev-embedded/arduino
dev-python/pyserial"

RDEPEND="${COMMONDEP}
dev-embedded/avrdude"

DEPEND="${COMMONDEP}"

src_unpack(){
	unpack ${A}
	cd ../"${S}"
	mv ${MY_PN}-${PV} ${PN}-${PV}
}

src_install(){
	dobin bin/ard-reset-arduino
	insinto /usr/share/arduino
	doins Arduino.mk Common.mk arduino-mk-vars.md chipKIT.mk
	if use doc; then
		dodoc HISTORY.md ard-reset-arduino.1 README.md
	fi
	if use examples; then
		insinto /usr/share/doc/"${P}"/
		doins -r examples
	fi
}
