# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit perl-module

DESCRIPTION="POE::Component::IRC Perl POE module"
HOMEPAGE="http://search.cpan.org/search?query=POE-Component-IRC&mode=dist"
SRC_URI="mirror://cpan/authors/id/B/BI/BINGOS/${P}.tar.gz"
RESTRICT="primaryuri"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~x86 ~amd64"

RDEPEND="dev-perl/POE-Filter-IRCD"
DEPEND="dev-perl/POE
	dev-lang/perl"
