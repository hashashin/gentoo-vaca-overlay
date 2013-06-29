# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/winetricks/winetricks-960.ebuild,v 1.1 2013/06/15 03:58:20 tetromino Exp $

EAPI=5

inherit gnome2-utils eutils

if [[ ${PV} == "99999999" ]] ; then
	ESVN_REPO_URI="http://winetricks.googlecode.com/svn/trunk"
	inherit subversion
else
	SRC_URI="http://winetricks.googlecode.com/svn-history/r${PV}/trunk/src/winetricks -> ${P}
		http://winetricks.googlecode.com/svn-history/r${PV}/trunk/src/winetricks.1 -> ${P}.1"
	KEYWORDS="~amd64 ~x86"
fi
wtg=winetricks-gentoo-2012.11.24
SRC_URI="${SRC_URI}
	gtk? ( http://dev.gentoo.org/~tetromino/distfiles/wine/${wtg}.tar.bz2 )
	kde? ( http://dev.gentoo.org/~tetromino/distfiles/wine/${wtg}.tar.bz2 )"

DESCRIPTION="Easy way to install DLLs needed to work around problems in Wine"
HOMEPAGE="http://code.google.com/p/winetricks/ http://wiki.winehq.org/winetricks"

LICENSE="LGPL-2.1+"
SLOT="0"
IUSE="gtk kde"

DEPEND=""
RDEPEND="app-arch/cabextract
	app-arch/unzip
	app-emulation/wine
	gtk? ( gnome-extra/zenity )
	kde? ( kde-base/kdialog )"

# Uses non-standard "Wine" category, which is provided by app-emulation/wine; #451552
QA_DESKTOP_FILE="usr/share/applications/winetricks.desktop"

S="${WORKDIR}"

src_unpack() {
	if [[ ${PV} == "99999999" ]] ; then
		subversion_src_unpack
	else
		mkdir src
		cp "${DISTDIR}"/${P} src/${PN} || die
		cp "${DISTDIR}"/${P}.1 src/${PN}.1 || die
	fi
	if use gtk || use kde; then
		unpack ${wtg}.tar.bz2
	fi
}

src_install() {
	cd src
	dobin ${PN}
	doman ${PN}.1
	if use gtk || use kde; then
		cd ../${wtg} || die
		domenu winetricks.desktop
		insinto /usr/share/icons/hicolor/scalable/apps
		doins wine-winetricks.svg
	fi
}

pkg_preinst() {
	if use gtk || use kde; then
		gnome2_icon_savelist
	fi
}

pkg_postinst() {
	if use gtk || use kde; then
		gnome2_icon_cache_update
	fi
}

pkg_postrm() {
	if use gtk || use kde; then
		gnome2_icon_cache_update
	fi
}
