# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/scli/scli-0.4.0.ebuild,v 1.2 2011/06/05 13:12:27 xarthisius Exp $

EAPI="2"

inherit flag-o-matic

DESCRIPTION="SNMP Command Line Interface"
HOMEPAGE="http://www.ibr.cs.tu-bs.de/projects/scli/"
SRC_URI="ftp://ftp.ibr.cs.tu-bs.de/pub/local/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug"

RDEPEND="
	dev-libs/glib:2
	dev-libs/libxml2
	net-libs/gnet
	net-libs/gsnmp
	sys-libs/ncurses
	sys-libs/readline
	sys-libs/zlib
	debug? ( dev-libs/dmalloc )
"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/scli-0.4.4.huawei-vendor.patch
}

src_configure() {
	append-flags -I/usr/include/libxml2
	econf \
		--enable-warnings \
		$(use_enable debug dmalloc) \
		|| die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README AUTHORS NEWS TODO ChangeLog PORTING
}
