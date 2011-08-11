# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils versionator

DESCRIPTION="Script para automatizar aircrack-ng."
HOMEPAGE="http://amunhoney.sourceforge.net/"
MY_PV=$(replace_version_separator 2 '-')
MM_PV=$(get_version_component_range '1-2')
SRC_URI="http://airoscript.googlecode.com/files/${PN}-${MY_PV}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

S="${WORKDIR}/${PN}-${MM_PV}"
