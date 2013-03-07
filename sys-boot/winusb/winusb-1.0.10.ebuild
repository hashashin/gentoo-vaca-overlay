# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils wxwidgets

DESCRIPTION="Creates Windows usb installers."
HOMEPAGE="http://en.congelli.eu/prog_info_winusb.html"
#not using upstream download link cause is not a direct one
SRC_URI="http://dl.dropbox.com/u/12425024/${P}.tar.gz"
IUSE=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="x11-libs/wxGTK
	x11-libs/gksu"
DEPEND="${RDEPEND}"

src_install() {
	domenu src/linux-menu/winusbgui.desktop
	doicon src/linux-menu/winusbgui-icon.png
	dobin src/winusb
	dobin src/winusbgui
	doman src/winusb.1
	doman src/winusbgui.1
	insinto /usr/share/${PN}/data
	doins src/data/c501-logo.png src/data/icon.png
	exeinto /usr/share/${PN}/data
	doexe src/data/listDvdDrive src/data/listUsb
	insinto /usr/share/${PN}/locale
	doins -r src/locale/default.mo src/locale/default.po
}
