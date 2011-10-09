# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
inherit eutils cmake-utils

DESCRIPTION="Yet another implementation of a HTTP proxy for Debian/Ubuntu software packages written in C++"
HOMEPAGE="http://www.unix-ag.uni-kl.de/~bloch/acng/"
SRC_URI="mirror://debian/pool/main/a/${PN}/${PN}_${PV}.orig.tar.xz"
#	mirror://debian/pool/main/a/${PN}/${PN}_${PV}-1.diff.gz
LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc fuse logrotate examples lzma"

DEPEND="app-arch/bzip2
	sys-libs/zlib
	lzma? (
		|| ( app-arch/xz-utils
			app-arch/lzma-utils )
	)"
RDEPEND="${DEPEND}
	dev-lang/perl
	fuse? ( sys-fs/fuse )"

pkg_setup() {
	# add new user & group for daemon
	enewgroup ${PN}
	enewuser ${PN} -1 -1 -1 ${PN}
}

src_configure(){
	mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX=/usr/
		# avoid forcing in LDFLAGS
		-DHAVE_WL_AS_NEEDED=OFF
		# assert for possible boost automagic
		-DHAVE_BOOST_SMARTPTR=OFF
		$(cmake-utils_use_has lzma LZMA)
		$(cmake-utils_use_has fuse FUSE_26)
	)

	cmake-utils_src_configure

}

src_install() {
	# There is no any install target :(
	# So we do all stuff here

	newinitd "${FILESDIR}"/initd ${PN} || die "Can't add new init.d ${PN}"
	newconfd "${FILESDIR}"/confd ${PN} || die "Can't add new conf.d ${PN}"

	# for logrotate
	if use logrotate; then
		insinto /etc/logrotate.d
		newins "${FILESDIR}"/logrotate ${PN} || die "Can't install new file ${PN} into '/etc/logrotate.d'"
	fi

	doman doc/man/${PN}* || die "Can't install mans"
	if use fuse; then doman doc/man/acngfs* || die "Can't install man pages for fusefs"; fi

	# Documentation
	dodoc README TODO VERSION INSTALL ChangeLog || die "Can't install common docs"
	if use doc; then
		dodoc doc/*.pdf || die "Can't install docs"
		dohtml doc/html/* || die "Can't install html docs"
		docinto examples/conf
		dodoc conf/* || die "Can't install config examples"
	fi

	# perl daily cron script
	dosbin expire-caller.pl || die "Can't install cache cleaner perl script"
	exeinto /etc/cron.daily
	newexe "${FILESDIR}"/cron.daily ${PN} || die "Can't install new daily cron script"

	# default configuration
	insinto /etc/${PN}
	newins conf/acng.conf ${PN}.conf || die "Can't install ${PN} configuration file"
	newins conf/report.html report.html || die "Can't install ${PN} report page"
	newins conf/deb_mirrors.gz deb_mirrors.gz || die "Can't install ${PN} mirror file"
	newins conf/debvol_mirrors.gz debvol_mirrors.gz || die "Can't install ${PN} mirror file"
	newins conf/ubuntu_mirrors ubuntu_mirrors || die "Can't install ${PN} mirror file"
	newins conf/archlx_mirrors archlx_mirrors || die "Can't install ${PN} mirror file"
	newins conf/sfnet_mirrors sfnet_mirrors || die "Can't install ${PN} mirror file"
	newins conf/cygwin_mirrors cygwin_mirrors || die "Can't install ${PN} mirror file"
	newins conf/security.conf security.conf || die "Can't install ${PN} mirror file"
	newins conf/maint.html maint.html || die "Can't install ${PN} mirror file"
	newins conf/userinfo.html userinfo.html || die "Can't install ${PN} mirror file"
	newins conf/style.css style.css || die "Can't install ${PN} mirror file"

	dodir /var/cache/${PN} || die
	dodir /var/log/${PN} || die
	# Some directories must exists
	keepdir /var/log/${PN}
	keepdir /var/run/${PN}
	fowners -R ${PN}:${PN} \
		/etc/${PN} \
		/var/log/${PN} \
		/var/cache/apt-cacher-ng \
		/var/run/${PN} || die "Can't change owners"

	cd ${CMAKE_BUILD_DIR}
	dosbin apt-cacher-ng || die "Can't install apt-cacher-ng"
	if use fuse; then dobin acngfs || die "Can't install acngfs"; fi

}

pkg_postinst() {
	elog "Do not forget about edit configuration file and read manuals!"
	elog "   Default file : /etc/${PN}/${PN}.conf"
	elog "   Manual page  : man 8 apt-cache-ng"
	elog "   Documentation: /usr/share/doc/${PF}"
	if use fuse; then
		elog "You have choose to build fuse httpfs named 'acngfs'."
		elog "It's can be used to mount apt cache on server to client"
		elog "filesystem."
		elog "   Manual page  : man 8 acngfs"
	fi
	elog "Please note: this ebuild installs /etc/cron.daily/${PN} cron job."
}
