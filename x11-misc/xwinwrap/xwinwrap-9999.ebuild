# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit bzr eutils flag-o-matic

DESCRIPTION="Utility to replace a desktop background with a movie, screensaver, etc."
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
LICENSE="as-is"
HOMEPAGE="http://tech.shantanugoel.com/projects/linux/shantz-xwinwrap"
EBZR_REPO_URI="lp:xwinwrap"

SLOT="0"

IUSE=""

DEPEND=">=x11-libs/libX11-1.0.3
	>=media-libs/mesa-6.5
	dev-vcs/bzr"

RDEPEND="${DEPEND}"

src_prepare() {
	epatch "$FILESDIR"/Makefile.patch
}

pkg_setup() {
	append-ldflags $(no-as-needed)
}

src_install() {
	dobin xwinwrap
}
