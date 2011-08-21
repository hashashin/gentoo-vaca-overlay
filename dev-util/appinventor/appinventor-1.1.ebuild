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

DEPEND="virtual/jre"
RDEPEND="${DEPEND}"

APP_INSTALL_DIR="/opt/appinventor"
S="${WORKDIR}/${PN}-setup_${PV}"

src_install() {
	insinto ${APP_INSTALL_DIR}
	dodir ${APP_INSTALL_DIR}
	doins -r "${S}"/"${PN}"/extras
	doins -r "${S}"/"${PN}"/from-Android-SDK
	exeinto "${APP_INSTALL_DIR}"/commands-for-Appinventor/
	doexe "${S}"/"${PN}"/commands-for-Appinventor/*
}
