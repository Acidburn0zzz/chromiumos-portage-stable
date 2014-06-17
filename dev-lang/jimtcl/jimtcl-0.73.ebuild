# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/jimtcl/jimtcl-0.73.ebuild,v 1.1 2012/08/17 22:23:51 hwoarang Exp $

EAPI="4"

DESCRIPTION="Small footprint implementation of Tcl programming language"
HOMEPAGE="http://jim.tcl.tk"
SRC_URI="https://github.com/msteveb/jimtcl/zipball/0.73 -> ${P}.zip"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="*"
IUSE="doc static-libs"
DEPEND="doc? ( app-text/asciidoc )
	app-arch/unzip"

GIT_HASH="5b8ea68"
S="${WORKDIR}"/msteveb-${PN}-${GIT_HASH}

src_configure() {
	! use static-libs && myconf=--with-jim-shared
	econf ${myconf}
}

src_compile() {
	emake all
	use doc && emake docs
}

src_install() {
	dobin jimsh
	use static-libs && {
		dolib.a libjim.a
	} || {
		dolib.so libjim.so
	}
	insinto /usr/include
	doins jim.h jimautoconf.h jim-subcmd.h jim-signal.h
	doins jim-win32compat.h jim-eventloop.h jim-config.h
	dodoc AUTHORS README TODO
	use doc && dohtml Tcl.html
}
