# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils multilib user git-2

MY_PN="DarkMultiPlayer"

S="${WORKDIR}/${MY_PN}-${PV}"

DESCRIPTION="Multiplayer server for Kerbal Space Program."
HOMEPAGE="https://github.com/godarklight/DarkMultiPlayer"
EGIT_REPO_URI="git://github.com/godarklight/DarkMultiPlayer.git"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND=">=dev-lang/mono-3.0.0"
RDEPEND="${DEPEND}"

pkg_setup() {
	enewgroup ${PN}
	enewuser ${PN} -1 -1 /dev/null ${PN}
}

src_prepare() {
	sed -i "s/\(.*PROGRAM_VERSION = \"\)Custom\(\".*\)/\1`git log | head -n 1 | cut -d ' ' -f 2`\2/g" Common/Common.cs
}

src_compile() {
	xbuild /target:Server /p:Configuration=Release
}

src_install() {
	dodir /opt/${PN}
	insinto /opt/${PN}

	doins Server/bin/Release/*dll
	doins Server/bin/Release/*.exe

	make_wrapper DMPServer  "mono /opt/${PN}/DMPServer.exe"
	chmod 775 "${D}"/opt/${PN}/
	fowners -R ${PN}:${PN} /opt/${PN}

	newdoc README.md README
	if use doc; then
		dodoc Documentation/*
	fi
}

pkg_postinst() {
	ewarn "IMPORTANT:"
	ewarn "DONT run DMPServer as root add your user to group dmp"
}
