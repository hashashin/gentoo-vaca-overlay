# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/logrotate/logrotate-3.8.4.ebuild,v 1.2 2013/06/10 20:32:29 jer Exp $

EAPI=5

inherit eutils toolchain-funcs flag-o-matic

DESCRIPTION="Rotates, compresses, and mails system logs"
HOMEPAGE="https://fedorahosted.org/logrotate/"
SRC_URI="https://fedorahosted.org/releases/l/o/logrotate/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="acl selinux"

RDEPEND="
	>=dev-libs/popt-1.5
	selinux? (
		sys-libs/libselinux
		sec-policy/selinux-logrotate
	)
	acl? ( virtual/acl )"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-datehack.patch \
		"${FILESDIR}"/${P}-ignore-hidden.patch \
		"${FILESDIR}"/${P}-fbsd.patch \
		"${FILESDIR}"/${P}-noasprintf.patch \
		"${FILESDIR}"/${P}-atomic-create.patch
}

src_compile() {
	local myconf
	myconf="CC=$(tc-getCC)"
	use selinux && myconf="${myconf} WITH_SELINUX=yes"
	use acl && myconf="${myconf} WITH_ACL=yes"
	emake ${myconf} RPM_OPT_FLAGS="${CFLAGS}"
}

src_install() {
	insinto /usr
	dosbin logrotate
	doman logrotate.8
	dodoc CHANGES examples/logrotate*

	exeinto /etc/cron.daily
	newexe "${S}"/examples/logrotate.cron "${PN}"

	insinto /etc
	doins "${FILESDIR}"/logrotate.conf

	keepdir /etc/logrotate.d
}

pkg_postinst() {
	if [[ -z ${REPLACING_VERSIONS} ]] ; then
		elog "If you wish to have logrotate e-mail you updates, please"
		elog "emerge virtual/mailx and configure logrotate in"
		elog "/etc/logrotate.conf appropriately"
		elog
		elog "Additionally, /etc/logrotate.conf may need to be modified"
		elog "for your particular needs.  See man logrotate for details."
	fi
}
