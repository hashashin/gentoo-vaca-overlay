# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit perl-module

DESCRIPTION="POE::Filter::IRCD Perl POE module"
HOMEPAGE="http://search.cpan.org/search?query=POE-Filter-IRCD&mode=dist"
SRC_URI="mirror://cpan/authors/id/B/BI/BINGOS/${P}.tar.gz"
RESTRICT="primaryuri"

IUSE=""
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~x86 ~amd64"

DEPEND="dev-perl/POE
	dev-lang/perl"
