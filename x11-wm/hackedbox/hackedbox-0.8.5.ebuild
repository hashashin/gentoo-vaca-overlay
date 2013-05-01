# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils

DESCRIPTION="The bastard son of Blackbox"
SRC_URI="http://scrudgeware.org/downloads/hackedbox/${P}.tar.gz"
HOMEPAGE="http://scrudgeware.org/projects/Hackedbox"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE="nls"

src_prepare() {
	cd "${S}"/src
	epatch "${FILESDIR}"/gcc.patch
}

src_configure() {
	econf `use_enable nls`
}

src_install () {
	make DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog INSTALL README TODO
}
