# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Client tools for heroku"
HOMEPAGE="http://heroku.com"
SRC_URI="http://assets.heroku.com.s3.amazonaws.com/${PN}/${PN}.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-lang/ruby"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
}

src_install() {
	dodir "/usr/local/heroku"
	cp -r "${S}"/* "${D}"/usr/local/heroku
	dodir "/usr/local/bin"
	dosym /usr/local/heroku/bin/heroku /usr/local/bin/heroku
}

pkg_postinst() {
	einfo "To start using heroku, please create first an account at"
	einfo "${HOMEPAGE}, then run"
	einfo " \$ heroku login"
	einfo "this will ask for your login data and generate a public ssh key"
	einfo "for you if needed. To deploy your app do:"
	einfo " \$ cd ~/myapp"
	einfo " \$ heroku create"
}
