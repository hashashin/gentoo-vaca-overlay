# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit eutils toolchain-funcs

MY_PV=${PV}
DESCRIPTION="Tool for creating compressed filesystem type squashfs"
HOMEPAGE="http://squashfs.sourceforge.net"
SRC_URI="mirror://sourceforge/squashfs/squashfs${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="+gzip +lzma lzo +progress-redirect xattr"

RDEPEND="
	gzip? ( sys-libs/zlib )
	lzma? ( app-arch/xz-utils )
	lzo? ( dev-libs/lzo )
	!lzma? ( !lzo? ( sys-libs/zlib ) )
	xattr? ( sys-apps/attr )"
DEPEND="${RDEPEND}"

S=${WORKDIR}/squashfs${MY_PV}/squashfs-tools

src_prepare() {
	use progress-redirect && \
		epatch "${FILESDIR}/${PN}-4.0-progress-stderr.patch"
}

use_sed() {
	local u=$1 s="${2:-`echo $1 | tr '[:lower:]' '[:upper:]'`}_SUPPORT"
	printf '/^#?%s =/%s\n' "${s}" \
		"$( use $u && echo s:.*:${s} = 1: || echo d )"
}

src_configure() {
	tc-export CC
	local def
	if [[ -n ${SQUASH_FS_DEFAULT_COMP} ]]; then
		def=${SQUASH_FS_DEFAULT_COMP}
	else
		einfo "You can set the default compression (gzip, xz or lzo) by exporting SQUASH_FS_DEFAULT_COMP"
		if use gzip; then
			def="gzip"
		elif use lzma; then
			def="xz"
		elif use lzo; then
			def="lzo"
		else
			die "Please set at least one of the gzip, lzma and lzo USE flags as compression algorithm."
		fi
	fi

	einfo "Using ${def} as compression algorithm."

	sed -i -r \
		-e "/^COMP_DEFAULT =/s:=.*:= ${def}:" \
		-e "$(use_sed gzip)" \
		-e "$(use_sed lzma XZ)" \
		-e "$(use_sed lzo)" \
		-e "$(use_sed xattr)" \
		Makefile || die
}

src_install() {
	dobin mksquashfs unsquashfs || die
	cd ..
	dodoc README ACKNOWLEDGEMENTS CHANGES PERFORMANCE.README || die
}

pkg_postinst() {
	ewarn "This version of mksquashfs requires a 2.6.29 kernel or better"
	use lzma &&
		ewarn "XZ support requires a 2.6.38 kernel or better"
}
