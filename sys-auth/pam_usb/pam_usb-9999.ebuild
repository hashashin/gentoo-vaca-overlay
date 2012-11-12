# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils pam git-2 toolchain-funcs

DESCRIPTION="PAM module that enables authentication using an USB-Storage device through DSA private/public keys."
HOMEPAGE="http://www.pamusb.org/"
EGIT_REPO_URI="git://github.com/aluzzardi/pam_usb.git"
SRC_URI=""
LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

COMMON_DEPEND="dev-libs/libxml2
	sys-apps/dbus
	virtual/pam"
RDEPEND="${COMMON_DEPEND}
	dev-python/celementtree
	dev-python/dbus-python
	dev-python/pygobject
	sys-apps/pmount
	sys-fs/udisks"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig"

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
