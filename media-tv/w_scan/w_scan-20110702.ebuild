# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils

DESCRIPTION="Scan for DVB-C/DVB-T/DVB-S channels without prior knowledge of frequencies and modulations"
HOMEPAGE="http://wirbel.htpc-forum.de/w_scan/index2.html"
SRC_URI="http://wirbel.htpc-forum.de/w_scan/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="~media-tv/linuxtv-dvb-headers-5"
RDEPEND=""

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"

	insinto /usr/share/w_scan
	doins	pci.ids pci.classes usb.ids usb.classes

	dodoc README
}
