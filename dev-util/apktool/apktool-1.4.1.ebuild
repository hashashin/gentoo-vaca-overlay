# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit eutils

DESCRIPTION="A tool for reengineering 3rd party, closed, binary Android apps."
HOMEPAGE="http://code.google.com/p/android-apktool/"
SRC_URI="http://android-${PN}.googlecode.com/files/${PN}${PV}.tar.bz2
	http://android-${PN}.googlecode.com/files/${PN}-install-linux-r04-brut1.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="dev-util/android-sdk-update-manager"

src_install() {
	exeinto /usr/local/bin
	doexe apktool
	doexe apktool.jar
}
