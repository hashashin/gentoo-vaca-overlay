# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/seabios/seabios-1.6.3.ebuild,v 1.5 2012/01/28 15:18:13 phajdan.jr Exp $

EAPI=4

inherit subversion

ESVN_REPO_URI="http://sgabios.googlecode.com/svn/trunk/"

KEYWORDS="~x86"
DESCRIPTION="Open Source BIOS"
HOMEPAGE="http://sgabios.googlecode.com"

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	!app-emulation/qemu
	!<=app-emulation/qemu-kvm-0.15.0"

src_install() {
	insinto /usr/share/sgabios
	doins sgabios.bin
	dosym /usr/share/sgabios/sgabios.bin /usr/share/qemu/sgabios.bin
}

src_compile() {
	emake
}
