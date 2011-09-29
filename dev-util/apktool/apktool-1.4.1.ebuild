# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit eutils

DESCRIPTION="placeholder text."
HOMEPAGE=""
SRC_URI="http://android-${PN}.googlecode.com/files/${PN}${PV}.tar.bz2
	http://android-${PN}.googlecode.com/files/${PN}-install-linux-r04-brut1.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-util/android-sdk-update-manager"
RDEPEND="${DEPEND}"

src_install() {
	exeinto /usr/local/bin
	doexe apktool
	doexe apktool.jar
}
