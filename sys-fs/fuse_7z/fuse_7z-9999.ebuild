# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit git-2

DESCRIPTION="Allows to mount 7-zip supported archives"
HOMEPAGE="http://gitorious.org/fuse-7z"
SRC_URI="https://waf.googlecode.com/files/waf-1.6.11"
EGIT_REPO_URI="git://gitorious.org/fuse-7z/fuse-7z.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="primaryuri"

DEPEND=""
RDEPEND="app-arch/p7zip
	${DEPEND}"

src_unpack() {
	git-2_src_unpack
}

src_configure() {
	cp "$DISTDIR"/$A waf
	python waf configure
}

src_compile() {
	python waf
}

src_install() {
	dobin wrapper/fuse-7z
	exeinto /usr/libexec/fuse-7z
	doexe build/fuse-7z
	dodoc README
}
