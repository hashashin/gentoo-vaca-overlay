# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/gentoolkit/gentoolkit-0.3.0.6-r3.ebuild,v 1.11 2012/08/26 19:01:24 armin76 Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.[45]"
PYTHON_USE_WITH="xml"
PYTHON_NONVERSIONED_EXECUTABLES=(".*")

inherit distutils python eutils

DESCRIPTION="Collection of administration scripts for Gentoo"
HOMEPAGE="http://www.gentoo.org/proj/en/portage/tools/index.xml"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

KEYWORDS="~x86"

# Note: argparse is provided in python 2.7 and 3.2 (Bug 346005)
# Note: dev-lang/python dependencies are so emerge will print a blocker if any
# installed slot of python is not built with +xml.  This is used since
# PYTHON_USE_WITH just dies in the middle of the emerge. See bug 399331.
DEPEND="sys-apps/portage"
RDEPEND="${DEPEND}
	>=dev-lang/python-2.6[xml]
	!>=dev-lang/python-2.6[-xml]
	!<=app-portage/gentoolkit-dev-0.2.7
	virtual/python-argparse
	|| ( >=sys-apps/coreutils-8.15 app-misc/realpath sys-freebsd/freebsd-bin )
	sys-apps/gawk
	sys-apps/grep"

distutils_src_compile_pre_hook() {
	echo VERSION="${PVR}" "$(PYTHON)" setup.py set_version
	VERSION="${PVR}" "$(PYTHON)" setup.py set_version \
		|| die "setup.py set_version failed"
}

src_prepare() {
	epatch "${FILESDIR}/${PV}-eread-413577.patch"
	epatch "${FILESDIR}/${PV}-eshowkw-414627.patch"
	epatch "${FILESDIR}/${PV}-gentoolkit-304125.patch"
	epatch "${FILESDIR}/${PV}-euse-410365.patch"
	epatch "${FILESDIR}/${PV}-eshowkw-409449.patch"
	epatch "${FILESDIR}/${PV}-euse-422675.patch"
}

src_install() {
	python_convert_shebangs -r "" build-*/scripts-*
	distutils_src_install

	# Rename the python versions of revdep-rebuild, since we are not ready
	# to switch to the python version yet. Link /usr/bin/revdep-rebuild to
	# revdep-rebuild.sh. Leaving the python version available for potential
	# testing by a wider audience.
	mv "${ED}"/usr/bin/revdep-rebuild "${ED}"/usr/bin/revdep-rebuild.py
	dosym revdep-rebuild.sh /usr/bin/revdep-rebuild

	# Create cache directory for revdep-rebuild
	dodir /var/cache/revdep-rebuild
	keepdir /var/cache/revdep-rebuild
	use prefix || fowners root:root /var/cache/revdep-rebuild
	fperms 0700 /var/cache/revdep-rebuild

	# remove on Gentoo Prefix platforms where it's broken anyway
	if use prefix; then
		elog "The revdep-rebuild command is removed, the preserve-libs"
		elog "feature of portage will handle issues."
		rm "${ED}"/usr/bin/revdep-rebuild*
		rm "${ED}"/usr/share/man/man1/revdep-rebuild.1
		rm -rf "${ED}"/etc/revdep-rebuild
		rm -rf "${ED}"/var
	fi

	# Can distutils handle this?
	dosym eclean /usr/bin/eclean-dist
	dosym eclean /usr/bin/eclean-pkg
}

pkg_postinst() {
	distutils_pkg_postinst

	einfo
	einfo "For further information on gentoolkit, please read the gentoolkit"
	einfo "guide: http://www.gentoo.org/doc/en/gentoolkit.xml"
	einfo
	einfo "Another alternative to equery is app-portage/portage-utils"
	ewarn
	ewarn "glsa-check since gentoolkit 0.3 has modified some output,"
	ewarn "options and default behavior. The list of injected GLSAs"
	ewarn "has moved to /var/lib/portage/glsa_injected, please"
	ewarn "run 'glsa-check -p affected' before copying the existing checkfile."
}
