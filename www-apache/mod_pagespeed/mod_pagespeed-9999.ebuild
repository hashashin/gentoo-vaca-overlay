# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )
PYTHON_REQ_USE='threads(+)'

inherit apache-module eutils subversion python-r1

DESCRIPTION="Apache module for rewriting web pages to reduce latency and bandwidth"
HOMEPAGE="http://code.google.com/p/modpagespeed"

ESVN_REPO_URI="http://modpagespeed.googlecode.com/svn/trunk/src"
EGCLIENT_REPO_URI="http://src.chromium.org/svn/trunk/tools/depot_tools"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-vcs/subversion
	>=sys-devel/gcc-4.1.0[cxx]
	dev-util/gperf"
RDEPEND=">=www-servers/apache-2.2.0
	${PYTHON_DEPS}
	"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

APACHE2_MOD_FILE="${S}/out/Release/${PN}.so"
APACHE2_MOD_CONF="80_${PN//-/_}"
APACHE2_MOD_DEFINE="PAGESPEED"

need_apache2

src_unpack() {
	# all the dirty job in WORKDIR
	cd "${WORKDIR}"

	# fetch depot_tools
	einfo "fetch depot_tools -->"
	svn co "${EGCLIENT_REPO_URI}"
	EGCLIENT="${WORKDIR}"/depot_tools/gclient

	# manually fetch sources in distfiles
	if [[ ! -f .gclient ]]; then
		einfo "gclient config -->"
		${EGCLIENT} config ${ESVN_REPO_URI} || die "gclient: error creating config"
	fi

	# run gclient synchronization
	einfo "gclient sync -->"
	einfo "     repository: ${ESVN_REPO_URI}"
	${EGCLIENT} sync --force || die "gclient: unable to sync"

	# move the sources to the working dir
	rsync -rlpgo --exclude=".svn" --exclude=".glient*" src/ "${S}"
	find "${S}"/. -type f -print0 | xargs -0 sed -i 's/\-Werror//g'
	einfo "   working copy: ${S}"
}

src_compile() {
	GYP_CFLAGS="-Duse_system_apache_dev=1 -Dsystem_include_path_httpd" GYP_CXXFLAGS="-Duse_system_apache_dev=1 -Dsystem_include_path_httpd" emake BUILDTYPE=Release V=1 || die "emake failed"
}

src_install() {
	local OUTDIR=out/Release
	mv -f ${OUTDIR}/libmod_pagespeed.so ${OUTDIR}/${PN}.so
	apache-module_src_install

	keepdir /var/cache/mod_pagespeed /var/cache/mod_pagespeed/files /var/cache/mod_pagespeed/cache
	fowners apache:apache /var/cache/mod_pagespeed /var/cache/mod_pagespeed/files /var/cache/mod_pagespeed/cache
	fperms 0770 /var/cache/mod_pagespeed /var/cache/mod_pagespeed/files /var/cache/mod_pagespeed/cache

	mv -f ${OUTDIR}/html_minifier_main ${OUTDIR}/pagespeed_minify_html
	dobin ${OUTDIR}/pagespeed_minify_html

	mv -f ${OUTDIR}/js_minify ${OUTDIR}/pagespeed_js_minify
	dobin ${OUTDIR}/pagespeed_js_minify
}
