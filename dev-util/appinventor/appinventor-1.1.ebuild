# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

DESCRIPTION="App Inventor Setup package."
HOMEPAGE="http://appinventor.googlelabs.com"
SRC_URI="http://dl.google.com/dl/${PN}/installers/linux/${PN}-setup_${PV}.tar.gz"

LICENSE="android"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND=">=virtual/jre-1.6.0"

APP_INSTALL_DIR="/opt/appinventor"
S="${WORKDIR}/${PN}-setup_${PV}"

src_install() {
	insinto ${APP_INSTALL_DIR}
	dodir ${APP_INSTALL_DIR}
	doins -r "${PN}"/extras
	doins -r "${PN}"/from-Android-SDK
	exeinto "${APP_INSTALL_DIR}"/commands-for-Appinventor/
	doexe "${PN}"/commands-for-Appinventor/*
}
