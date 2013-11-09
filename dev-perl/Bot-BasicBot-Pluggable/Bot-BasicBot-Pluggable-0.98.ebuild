# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit perl-module

DESCRIPTION="RSS feed aggregator for your bot"
HOMEPAGE="http://search.cpan.org/~mdom/"
SRC_URI="mirror://cpan/authors/id/M/MD/MDOM/${P}.tar.gz"
RESTRICT="primaryuri"
IUSE=""
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~x86 ~amd64"

RDEPEND=""
DEPEND="dev-perl/POE
	dev-perl/POE-Component-IRC
	dev-lang/perl
	dev-perl/Bot-BasicBot
	virtual/perl-Getopt-Long
	dev-perl/DBM-Deep
	dev-perl/DBD-SQLite
	dev-perl/URI-Title
	dev-perl/Text-Unidecode
	dev-perl/URI-Find-Simple
	dev-perl/Config-Find
	dev-perl/Crypt-SaltedHash
	dev-perl/List-MoreUtils
	dev-perl/Log-Log4perl
	dev-perl/Moose
	dev-perl/MooseX-Getopt
	dev-perl/MooseX-SimpleConfig
	dev-perl/Try-Tiny
	dev-perl/XML-Feed
	dev-perl/YAML-LibYAML
	dev-perl/IO-Pipely
	virtual/perl-Module-Build"
