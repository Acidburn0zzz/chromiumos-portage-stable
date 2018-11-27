# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

AUTOTOOLS_AUTORECONF=1

inherit autotools autotools-multilib

DESCRIPTION="A free implementation of the unicode bidirectional algorithm"
HOMEPAGE="https://fribidi.org/"
SRC_URI="https://github.com/fribidi/${PN}/releases/download/${PV}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="*"
IUSE="static-libs"

RDEPEND=">=dev-libs/glib-2.34.3:2[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS=( AUTHORS NEWS README ChangeLog THANKS TODO )

src_prepare() {
	# Fix compability with dev-libs/glib >= 2.31
	sed -i \
		-e '/include/s:<glib/gstrfuncs.h>:<glib.h>:' \
		-e '/include/s:<glib/gmem.h>:<glib.h>:' \
		charset/fribidi-char-sets.c lib/mem.h || die

	autotools-multilib_src_prepare
}

src_configure() {
	# --with-glib=yes is required for #345621 to ensure "Requires: glib-2.0" is
	# present in /usr/lib/pkgconfig/fribidi.pc
	local myeconfargs=( --with-glib=yes )
	autotools-multilib_src_configure
}