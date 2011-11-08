# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/speed-dreams/speed-dreams-1.4.0.ebuild,v 1.5 2011/06/14 22:00:20 mr_bones_ Exp $

EAPI=2
inherit eutils games cmake-utils

MY_VER="2.0.0-b1"

DESCRIPTION="A fork of the famous open racing car simulator TORCS"
HOMEPAGE="http://speed-dreams.sourceforge.net/"
SRC_URI="mirror://sourceforge/speed-dreams/${PN}-${MY_VER}-r3937-src.tar.7z"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/opengl
	virtual/glu
	virtual/jpeg
	>=media-libs/plib-1.8.3
	media-libs/openal
	>=net-libs/enet-1.2.2
	sys-libs/zlib
	>=media-libs/libpng-1.2.40"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}-${MY_VER}-r3937-src
CMAKE_BUILD_DIR=${WORKDIR}/${PN}-${MY_VER}-r3937-src

src_prepare() {
	tar xf "${WORKDIR}"/"${PN}"-"${MY_VER}"-r3937-src.tar
	rm "${WORKDIR}"/"${PN}"-"${MY_VER}"-r3937-src.tar
	cd "${WORKDIR}"/"${PN}"-"${MY_VER}"-r3937-src
	epatch "${FILESDIR}"/bindir.patch
}

src_configure() {
	mycmakeargs+=(
		'-DCMAKE_NO_BUILTIN_CHRPATH:BOOL=ON'
		'-DOPTION_OFFICIAL_ONLY:BOOL=ON'
		'-DOPTION_DEBUG:BOOL=OFF'
		'-DOPTION_TRACE:BOOL=OFF'
		"-DCMAKE_INSTALL_PREFIX:STRING=${GAMES_PREFIX}"
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile -j1
}

src_install() {
	cmake-utils_src_install
	dodoc doc/changelogs/* doc/history/* doc/testing/*
	dohtml -r doc/faq/*
	doman doc/man/*
	newicon data/data/icons/icon.svg ${PN}.svg
	make_desktop_entry ${PN}-2 "Speed Dreams 2"
	prepgamesdirs
}
