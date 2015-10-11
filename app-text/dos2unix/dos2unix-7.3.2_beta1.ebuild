# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/dos2unix/dos2unix-7.1.ebuild,v 1.1 2014/10/07 04:51:53 polynomial-c Exp $

EAPI=5

inherit eutils toolchain-funcs

MY_P=${P/_beta/-beta}
#http://www.xs4all.nl/~waterlan/${PN}/${MY_P}.tar.gz
#http://www.xs4all.nl/~waterlan/${PN}/${P}.tar.gz

DESCRIPTION="Convert DOS or MAC text files to UNIX format or vice versa"
HOMEPAGE="http://www.xs4all.nl/~waterlan/dos2unix.html http://sourceforge.net/projects/dos2unix/"
SRC_URI="
	http://www.xs4all.nl/~waterlan/${PN}/${MY_P}.tar.gz"
LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~sparc64-solaris"
IUSE="debug nls test"

RDEPEND="
	!app-text/hd2u
	!app-text/unix2dos
	virtual/libintl"
DEPEND="
	${RDEPEND}
	nls? ( sys-devel/gettext )
	test? ( virtual/perl-Test-Simple )
	dev-lang/perl"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	sed \
		-e '/^LDFLAGS/s|=|+=|' \
		-e '/CFLAGS_OS \+=/d' \
		-e '/LDFLAGS_EXTRA \+=/d' \
		-e "/^CFLAGS/s|-O2|${CFLAGS}|" \
		-i Makefile || die

	if use debug ; then
		sed -e "/^DEBUG/s:0:1:" \
			-e "/EXTRA_CFLAGS +=/s:-g::" \
			-i Makefile || die
	fi

	tc-export CC
}

lintl() {
	# same logic as from virtual/libintl
	use !elibc_glibc && use !elibc_uclibc && echo "-lintl"
}

src_compile() {
	emake prefix="${EPREFIX}/usr" \
		$(usex nls "LDFLAGS_EXTRA=$(lintl)" "ENABLE_NLS=")
}

src_install() {
	emake DESTDIR="${D}" prefix="${EPREFIX}/usr" \
		$(usex nls "" "ENABLE_NLS=") install
}