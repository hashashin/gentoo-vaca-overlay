# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/phpsysinfo/phpsysinfo-3.1.4.ebuild,v 1.1 2013/06/22 11:02:26 radhermit Exp $

EAPI=5

inherit webapp

DESCRIPTION="Visualize statistics from a Kippo SSH honeypot"
HOMEPAGE="http://bruteforce.gr/kippo-graph"
SRC_URI="https://github.com/ikoniaris/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86 ~x86-fbsd"

RDEPEND="virtual/httpd-php
	dev-lang/php[curl,mysql,gd]"

src_install() {
	webapp_src_preinst

	dodoc TODO.txt README*
	rm TODO.txt README* || die

	insinto "${MY_HTDOCSDIR}"
	doins -r .

	webapp_src_install

	fperms 777 "${MY_HTDOCSDIR}"/generated-graphs
}

pkg_postinst() {
  elog "run: cp ${VHOST_ROOT}/${PN}-${PVR}/config.php.dist ${VHOST_ROOT}/${PN}-${PVR}/config.php"
  elog "Edit ${VHOST_ROOT}/${PN}-${PVR}/config.php and set database settings."
  webapp_pkg_postinst
}
