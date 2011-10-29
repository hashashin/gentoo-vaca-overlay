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
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="+gzip +lzma lzo +progress-redirect xattr"

RDEPEND="gzip? ( sys-libs/zlib )
	lzma? ( app-arch/xz-utils )
	lzo? ( dev-libs/lzo )
	!lzma? ( !lzo? ( sys-libs/zlib ) )
	xattr? ( sys-apps/attr )"
DEPEND="${RDEPEND}"

S=${WORKDIR}/squashfs${MY_PV}/squashfs-tools

src_prepare() {
	use progress-redirect && \
		epatch "${FILESDIR}/${PN}-4.0-progress-stderr.patch"
	sed -i \
		-e "s:-O2:${CFLAGS} ${CPPFLAGS}:" \
		-e '/^LIBS =/s:$: $(LDFLAGS):' \
		Makefile || die
}

src_configure() {
	tc-export CC
	local def=`usev gzip || usev lzma || usev lzo || echo gzip`
	sed -i -r \
		-e "/^COMP_DEFAULT =/s:=.*:= ${def}:" \
		-e "/^#?GZIP_SUPPORT =/`use gzip && echo s:.*:GZIP_SUPPORT=1: || echo d`" \
		-e "/^#?XZ_SUPPORT =/`use lzma && echo s:.*:XZ_SUPPORT=1: || echo d`" \
		-e "/^#?LZO_SUPPORT =/`use lzo && echo s:.*:LZO_SUPPORT=1 :|| echo d`" \
		-e "/^#?XATTR_SUPPORT =/`use xattr && echo s:.*:XATTR_SUPPORT=1 :|| echo d`" \
		Makefile || die
}

src_install() {
	dobin mksquashfs unsquashfs || die
	cd ..
	dodoc README ACKNOWLEDGEMENTS CHANGES PERFORMANCE.README
}

pkg_postinst() {
	ewarn "This version of mksquashfs requires a 2.6.29 kernel or better"
}
