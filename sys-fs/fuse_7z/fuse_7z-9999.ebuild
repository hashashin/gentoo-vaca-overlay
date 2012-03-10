# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit git-2 waf-utils

DESCRIPTION="Allows to mount 7-zip supported archives"
HOMEPAGE="http://gitorious.org/fuse-7z"
SRC_URI="https://waf.googlecode.com/files/waf-1.6.11"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
EGIT_REPO_URI="git://gitorious.org/fuse-7z/fuse-7z.git"

RESTRICT="primaryuri"

DEPEND=""
RDEPEND="app-arch/p7zip
	${DEPEND}"

src_configure() {
#	ln -sf "$DISTDIR"/$A waf
#	python waf configure
	waf-utils_src_configure
}

src_compile() {
#	python waf
	waf-utils_src_compile
}

src_install() {
	dobin wrapper/fuse-7z
	exeinto /usr/libexec/fuse-7z
	doexe build/fuse-7z
	dodoc README
}
