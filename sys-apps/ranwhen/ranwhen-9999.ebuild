# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2

DESCRIPTION="Python script that graphically shows in your terminal when your system was running in the past."
HOMEPAGE="https://github.com/p-e-w/ranwhen"
EGIT_REPO_URI="git://github.com/p-e-w/ranwhen.git"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_unpack(){
	git-2_src_unpack
}

src_install() {
	dodoc README.md
	newbin ranwhen.py ranwhen
}
