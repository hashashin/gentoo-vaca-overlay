# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit perl-module

DESCRIPTION="A pure perl multi-level hash/array DBM that supports transactions"
HOMEPAGE="http://search.cpan.org/~rkinyon/"
SRC_URI="mirror://cpan/authors/id/R/RK/RKINYON/${P}.tar.gz"
RESTRICT="primaryuri"
IUSE=""
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~x86 ~amd64"

RDEPEND=""
DEPEND="dev-perl/POE
	dev-lang/perl
	virtual/perl-Module-Build
	dev-perl/Test-Warn
	dev-perl/Test-Exception
	dev-perl/Test-Deep"
