# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2

DESCRIPTION="FSB files extractor (extracts from FMOD sound fx archives)."
HOMEPAGE="https://github.com/gdawg/fsbext"
EGIT_REPO_URI="git://github.com/gdawg/fsbext.git"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_unpack(){
	git-2_src_unpack
}

src_install() {
	dodoc README.md
	dobin fsbext
}
