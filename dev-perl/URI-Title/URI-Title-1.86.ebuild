# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit perl-module

DESCRIPTION="get the titles of things on the web in a sensible way"
HOMEPAGE="http://search.cpan.org/~tomi/"
SRC_URI="mirror://cpan/authors/id/T/TO/TOMI/${P}.tar.gz"
RESTRICT="primaryuri"
IUSE=""
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~x86 ~amd64"

RDEPEND=""
DEPEND="dev-lang/perl
	virtual/perl-Module-Pluggable
	dev-perl/MP3-Info
	dev-perl/ImageSize"
