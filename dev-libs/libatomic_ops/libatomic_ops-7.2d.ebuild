# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libatomic_ops/libatomic_ops-7.2d.ebuild,v 1.3 2012/12/16 16:31:21 ulm Exp $

EAPI=4

inherit toolchain-funcs

DESCRIPTION="Implementation for atomic memory update operations"
HOMEPAGE="http://www.hpl.hp.com/research/linux/atomic_ops/"
SRC_URI="http://www.hpl.hp.com/personal/Hans_Boehm/gc/gc_source/gc-${PV/_}.tar.gz"

LICENSE="MIT boehm-gc GPL-2+"
SLOT="0"
KEYWORDS="*"
IUSE=""

S=${WORKDIR}/gc-${PV/d}/libatomic_ops

src_prepare() {
	sed -i \
		-e "/^pkgdatadir/s:/.*:/doc/${PF}:" \
		doc/Makefile.in || die
	find -type f -exec touch -r . {} +
}

src_compile() {
	emake AR="$(tc-getAR)"
}

src_install() {
	default
	find "${ED}" '(' -name COPYING -o -name LICENSING.txt ')' -delete
}
