# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit cvs eutils flag-o-matic 

DESCRIPTION="Utility to replace a desktop background with a movie, screensaver, etc."
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"

SLOT="0"

IUSE=""

DEPEND=">=x11-libs/libX11-1.0.3
	>=media-libs/mesa-6.5"

RDEPEND="${DEPEND}"

ECVS_SERVER="anoncvs.freedesktop.org:/cvs/xapps"
ECVS_MODULE="xwinwrap"
ECVS_BRANCH=""
ECVS_LOCALNAME="xwinwrap"
#ECVS_CO_DATE=${PV##*alpha}
#ECVS_UP_OPTS="-D ${ECVS_CO_DATE} -dP"
#ECVS_CO_OPTS="-D ${ECVS_CO_DATE}"

S=${WORKDIR}/${ECVS_LOCALNAME}

pkg_setup() {
	append-ldflags $(no-as-needed)
}

src_install() {
	dobin xwinwrap
}
