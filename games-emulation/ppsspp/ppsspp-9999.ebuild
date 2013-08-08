# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils cmake-utils git-2

DESCRIPTION="A PSP emulator for Android, Windows, Mac, Linux and Blackberry 10, written in C++."
HOMEPAGE="http://www.ppsspp.org/"
EGIT_REPO_URI="git://github.com/hrydgard/ppsspp.git"
EGIT_HAS_SUBMODULES="true"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="media-libs/libsdl
	dev-util/cmake
	sys-libs/zlib"

src_unpack(){
	git-2_src_unpack
}

src_configure() {
	cmake-utils_src_configure
}

src_install() {
	dobin "${FILESDIR}"/ppssppsdl
	exeinto /usr/share/"${PN}"
	doexe "${WORKDIR}"/"${P}"_build/PPSSPPSDL
	insinto /usr/share/"${PN}"
	doins -r "${WORKDIR}"/"${P}"_build/assets
	doins -r "${WORKDIR}"/"${P}"/lang
	rm "${D}"/usr/share/"${PN}"/lang/README.md
	chrpath -r /usr/share/"${PN}" "${D}"/usr/share/"${PN}"/PPSSPPSDL
}
