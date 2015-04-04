# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/tmux-mem-cpu-load/tmux-mem-cpu-load-2.1.0.ebuild,v 1.4 2013/01/22 19:34:25 wired Exp $

EAPI="5"

inherit cmake-utils

IUSE=""
KEYWORDS="~amd64 ~x86"
SRC_URI="http://www.github.com/thewtex/${PN}/tarball/v${PV} -> ${P}.tar.gz"

DESCRIPTION="CPU, RAM memory, and load monitor for use with tmux"
HOMEPAGE="http://github.com/thewtex/tmux-mem-cpu-load/"

LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}"/thewtex-${PN}-d82a4ab

src_install() {
	cmake-utils_src_install
	dodoc README.rst || die
}
