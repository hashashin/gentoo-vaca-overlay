# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

MODULE_AUTHOR="PEGI"

inherit perl-module

DESCRIPTION="tries to fetch webpages with gzip-compression"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="dev-perl/WWW-Mechanize
	dev-lang/perl"
