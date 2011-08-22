# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_bw/mod_bw-0.8.ebuild,v 1.4 2008/03/02 14:56:34 rbu Exp $

inherit apache-module

DESCRIPTION="Bandwidth Management Module for Apache2."
HOMEPAGE="http://www.ivn.cl/apache/"

# new uri  http://ivn.cl/files/source/mod_bw-0.92.tgz
SRC_URI="http://ivn.cl/files/source/${P/9./9}.tgz" # a quick hack to convert ithe version number

KEYWORDS="amd64 ppc x86"
LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=""

APACHE2_MOD_CONF="11_${PN}"
APACHE2_MOD_DEFINE="BW"

need_apache2_2

# tarball don't contain a basedir since 0.9
S="${WORKDIR}"
