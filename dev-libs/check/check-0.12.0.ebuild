# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit autotools multilib-minimal

DESCRIPTION="A unit test framework for C"
HOMEPAGE="https://libcheck.github.io/check/"
SRC_URI="https://github.com/lib${PN}/${PN}/archive/${PV}.tar.gz -> ${P}-github.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="*"
IUSE="static-libs subunit"

RDEPEND="subunit? ( >=dev-python/subunit-0.0.10-r1[${MULTILIB_USEDEP}] )"
DEPEND="${RDEPEND}
	sys-apps/texinfo
	virtual/pkgconfig"

DOCS=( AUTHORS ChangeLog NEWS README.md THANKS TODO )

PATCHES=(
	"${FILESDIR}/${PN}-0.9.13-clang_overloadable_libcompat.patch"
	"${FILESDIR}/${PN}-0.9.13-clang_overloadable_snprintf.patch"
)

pkg_setup() {
	# See multilib_src_test(), disable sleep()-based tests because they
	# just take a long time doing pretty much nothing.
	export CPPFLAGS="-DTIMEOUT_TESTS_ENABLED=0 ${CPPFLAGS}"
}

src_prepare() {
	default

	sed -i -e '/^docdir =/d' {.,doc}/Makefile.am \
		|| die 'failed to unset docdir in Makefile.am'

	epatch "${PATCHES[@]}"
	eautoreconf
}

multilib_src_configure() {
	local myeconfargs=(
		--disable-dependency-tracking
		$(use_enable subunit)
	)
	ECONF_SOURCE="${S}" econf "${myeconfargs[@]}"
}

multilib_src_install_all() {
	default

	rm -f "${ED}/usr/share/doc/${PF}"/COPYING* || \
		die 'failed to remove COPYING files'

	find "${ED}" \( -name "*.a" -o -name "*.la" \) -delete || die
}

multilib_src_test() {
	elog "-DTIMEOUT_TESTS_ENABLED=0 has been prepended to CPPFLAGS. To run the"
	elog "entire testsuite for dev-libs/check, ensure that"
	elog "-DTIMEOUT_TESTS_ENABLED=1 is in your CPPFLAGS."
	default_src_test
}