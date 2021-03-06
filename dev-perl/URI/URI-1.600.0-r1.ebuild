# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/URI/URI-1.600.0-r1.ebuild,v 1.1 2014/07/26 14:32:49 dilfridge Exp $

EAPI=5

MODULE_AUTHOR=GAAS
MODULE_VERSION=1.60
inherit perl-module

DESCRIPTION="A URI Perl Module"

SLOT="0"
KEYWORDS="*"
IUSE=""

DEPEND="virtual/perl-MIME-Base64"
RDEPEND="${DEPEND}"

SRC_TEST=no # see ChangeLog

mydoc="rfc2396.txt"
