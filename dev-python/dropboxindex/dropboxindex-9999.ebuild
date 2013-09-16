# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit eutils distutils-r1 subversion python-r1

DESCRIPTION="Creates index.html for directory contents shared publicly on Dropbox."
HOMEPAGE="https://code.google.com/p/kosciak-misc/wiki/DropboxIndex"
SRC_URI=""
ESVN_REPO_URI="http://kosciak-misc.googlecode.com/svn/python/dropbox-index/trunk/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
