# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_DEPEND="2:2.7"
RESTRICT_PYTHON_ABIS="3.*"
PYTHON_COMPAT=( python2_7 )

MY_PN="PyAIML"

inherit eutils distutils-r1 subversion python-r1

DESCRIPTION="Placeholder"
HOMEPAGE="https://code.google.com/p/kosciak-misc/wiki/DropboxIndex"
SRC_URI=""
ESVN_REPO_URI="http://kosciak-misc.googlecode.com/svn/python/dropbox-index/trunk/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}
