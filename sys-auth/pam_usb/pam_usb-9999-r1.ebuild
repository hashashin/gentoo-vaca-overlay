# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils pam toolchain-funcs git-2

DESCRIPTION="A pam module to provide authentication using USB device"
HOMEPAGE="http://pamusb.org/"
EGIT_REPO_URI="git://github.com/aluzzardi/pam_usb.git"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEPEND="dev-libs/libxml2
	sys-apps/dbus
	virtual/pam"
RDEPEND="${COMMON_DEPEND}
	dev-python/celementtree
	dev-python/dbus-python
	dev-python/pygobject:2
	sys-apps/pmount
	sys-fs/udisks:2"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-openpam.patch
	epatch "${FILESDIR}"/${P}-python2.patch
}

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	emake \
		DESTDIR="${D}" \
		DOCS_DEST="${D}/usr/share/doc/${PF}" \
		PAM_USB_DEST="${D}/$(getpam_mod_dir)" \
		install

	dodoc ChangeLog README.md
}
