# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils

DESCRIPTION="Tail multiple logfiles at once, even if rotated"
HOMEPAGE="http://www.unicom.com/sw/xtail/"
SRC_URI="http://www.unicom.com/sw/xtail/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

src_prepare() {
	epatch "$FILESDIR"/0001-Use-ISO8601-Fix-Gcc-header-Use-C-c.patch
	epatch "$FILESDIR"/0001-xtail.1-remove-SIGQUIT.patch
	epatch "$FILESDIR"/xtail_2.1-5-debian-local-changes.patch
}

src_compile() {
	tc-export CC
	emake
}

src_install() {
	dobin xtail
	doman xtail.1
	dodoc README
}
