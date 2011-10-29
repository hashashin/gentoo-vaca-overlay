# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header $

EAPI="4"
inherit toolchain-funcs eutils

MY_PV=${PV}
DESCRIPTION="Tool for creating compressed filesystem type squashfs"
HOMEPAGE="http://squashfs.sourceforge.net/"
SRC_URI="mirror://sourceforge/squashfs/squashfs${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86"
IUSE="+progress-redirect"

RDEPEND="sys-libs/zlib"

S=${WORKDIR}/squashfs${MY_PV}/squashfs-tools

src_prepare() {
	sed -i \
		-e 's:-O2:$(CFLAGS):' \
		-e '/-lz/s:$: $(LDFLAGS):' \
		Makefile || die "sed failed"
	use progress-redirect && \
		epatch "${FILESDIR}/${P}-progress-stderr.patch"
	sed -i -e 's:get_nprocs():sysconf(_SC_NPROCESSORS_ONLN):' *.c
}

src_compile() {
	emake CC="$(tc-getCC)" || die
}

src_install() {
	dobin mksquashfs unsquashfs || die
	cd ..
	dodoc README ACKNOWLEDGEMENTS CHANGES PERFORMANCE.README
}

pkg_postinst() {
	ewarn "This version of mksquashfs requires a 2.6.29 kernel or better."
}
