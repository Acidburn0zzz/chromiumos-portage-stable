# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libXvMC/libXvMC-1.0.8.ebuild,v 1.1 2013/06/18 14:07:42 chithanh Exp $

EAPI=4

XORG_MULTILIB=yes
inherit xorg-2

DESCRIPTION="X.Org XvMC library"

KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x86-solaris"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXv
	x11-proto/videoproto
	x11-proto/xproto"
DEPEND="${RDEPEND}"
PDEPEND="app-admin/eselect-xvmc"
