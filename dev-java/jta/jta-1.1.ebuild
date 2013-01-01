# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit java-pkg-2

At="jta-1_1-classes.zip"
DESCRIPTION="The Java Transaction API"
HOMEPAGE="http://www.oracle.com/technetwork/java/javaee/tech/jta-138684.html"
SRC_URI="${At}"
LICENSE="sun-bcla-jta"
SLOT=0
KEYWORDS="~x86"
IUSE=""
DEPEND=">=app-arch/unzip-5.50-r1
	>=virtual/jdk-1.3"
RDEPEND=">=virtual/jre-1.3"
RESTRICT="fetch"

S=${WORKDIR}

pkg_nofetch() {
	einfo
	einfo " Due to license restrictions, we cannot fetch the"
	einfo " distributables automagically."
	einfo
	einfo " 1. Visit ${HOMEPAGE}"
	einfo " 2. Select 'Java Transaction API Specification 1.1 Class Files 1.1'"
	einfo " 3. Download ${At}"
	einfo " 4. Move file to ${DISTDIR}"
	einfo " 5. Restart the emerge process"
	einfo
}

src_unpack() {
	unzip -qq "${DISTDIR}"/${At} || die "failed too unpack"
}

src_compile() {
	jar cvf jta.jar javax/ || die "failed to create jar"
}

src_install() {
	java-pkg_dojar jta.jar
}
