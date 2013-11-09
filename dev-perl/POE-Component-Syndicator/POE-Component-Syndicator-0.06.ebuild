# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

MODULE_AUTHOR="HINRIK"

inherit perl-module

DESCRIPTION="A POE component base class which implements the Observer pattern"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=""
DEPEND=">=dev-perl/Object-Pluggable-1.29
	dev-perl/POE
	dev-lang/perl"
