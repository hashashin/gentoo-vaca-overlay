# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

MODULE_AUTHOR="FRANCKC"

inherit perl-module

DESCRIPTION="github api perl module"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="dev-lang/perl
	dev-perl/Any-Moose
	dev-perl/Crypt-SSLeay
	dev-perl/File-Slurp
	dev-perl/HTML-Tree
	dev-perl/JSON-Any
	dev-perl/Test-MockModule
	dev-perl/WWW-Mechanize-GZip"
