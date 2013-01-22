# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-firmware/seabios/seabios-1.7.0.ebuild,v 1.5 2012/10/17 03:39:28 cardoe Exp $

EAPI=4

KEYWORDS="~x86"
SRC_URI="http://code.coreboot.org/p/"${PN}"/downloads/get/bios.bin-"${PV}".gz"

DESCRIPTION="Open Source implementation of a 16-bit x86 BIOS"
HOMEPAGE="http://www.seabios.org"

LICENSE="LGPL-3 GPL-3"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S=${WORKDIR}
src_install() {
	insinto /usr/share/seabios
	newins bios.bin-"${PV}" bios.bin
}
