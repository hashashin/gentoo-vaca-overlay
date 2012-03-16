# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit subversion

ESVN_REPO_URI="http://sgabios.googlecode.com/svn/trunk/"

KEYWORDS="~x86"
DESCRIPTION="The Google Serial Graphics Adapter BIOS"
HOMEPAGE="http://sgabios.googlecode.com"

LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	!app-emulation/qemu
	!<=app-emulation/qemu-kvm-0.15.0"

src_compile() {
	make
}

src_install() {
	insinto /usr/share/sgabios
	doins sgabios.bin
	dosym /usr/share/sgabios/sgabios.bin /usr/share/qemu/sgabios.bin
}
