# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit perl-module

DESCRIPTION="Base for Bot-BasicBot"
HOMEPAGE="http://search.cpan.org/~hinrik/Bot-BasicBot-0.89/"
SRC_URI="mirror://cpan/authors/id/H/HI/HINRIK/${P}.tar.gz"
RESTRICT="primaryuri"
IUSE=""
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~x86 ~amd64"

RDEPEND=""
DEPEND="dev-perl/POE
	dev-perl/POE-Component-IRC
	dev-lang/perl"
