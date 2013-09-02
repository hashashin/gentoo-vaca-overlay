# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2

DESCRIPTION="Quickly go back to a specific parent directory in linux instead of typing cd ../../.. redundantly."
HOMEPAGE="https://github.com/vigneshwaranr/bd"
EGIT_REPO_URI="git://github.com/vigneshwaranr/bd.git"
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
	into /usr/bin
	dobin bd
}
