# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_6 python2_7 )

inherit eutils python user

DESCRIPTION="Low-interaction honeypot, capture autonomous spreading malware in an automated fashion."
HOMEPAGE="http://amunhoney.sourceforge.net/"
SRC_URI="mirror://sourceforge/project/${PN}honey/${PN}/${PN}-v${PV}/${PN}-v${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="mysql surfnet"

DEPEND="mysql? ( virtual/mysql )
	surfnet? ( <=dev-python/psycopg-2.4.2 )
"

S="${WORKDIR}/${PN}"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
	enewgroup ${PN}
	enewuser ${PN} -1 -1 /dev/null ${PN}
}

pkg_info() {
	"${ROOT}"/opt/amun/amun_server.py --version
}

src_prepare() {
	einfo "This patch set runtime (after bind ports) privileges to user amun, default is root."
	epatch "${FILESDIR}/${PN}.conf.patch"
}

src_install() {
	insinto /opt
	doins -r "${S}"
	exeinto /opt/${PN}
	doexe ${PN}_server.py
	dodoc AUTHORS CHANGELOG CREDITS INSTALL conf/${PN}_db.sql
	rm "${D}/opt/${PN}/AUTHORS" \
		"${D}/opt/${PN}/CHANGELOG" \
		"${D}/opt/${PN}/CREDITS" \
		"${D}/opt/${PN}/INSTALL" \
		"${D}/opt/${PN}/LICENSE" \
		"${D}/opt/${PN}/conf/${PN}_db.sql"
	doinitd "${FILESDIR}"/${PN}_server
	fowners -R ${PN}:${PN} /opt/${PN}
}

pkg_postinst() {
	python_mod_optimize /opt/${PN}
	if use mysql; then
		elog "If you plan log to mysql you can create a database using:"
		elog "/usr/share/doc/"${P}"/"${PN}"_db.sql.bz2"
		elog " "
		elog "Modify as need /opt/"${PN}"/conf/log-mysql.conf and uncomment"
		elog "in /opt/amun/conf/"${PN}".conf log-mysql related lines"
	fi
}

pkg_postrm() {
	python_mod_cleanup /opt/${PN}
}
