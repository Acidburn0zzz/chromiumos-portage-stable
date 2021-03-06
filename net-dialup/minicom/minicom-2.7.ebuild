# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/minicom/minicom-2.7.ebuild,v 1.2 2014/01/01 19:59:58 radhermit Exp $

EAPI=5
inherit eutils

STUPID_NUM="3977"
DESCRIPTION="Serial Communication Program"
HOMEPAGE="http://alioth.debian.org/projects/minicom"
SRC_URI="https://alioth.debian.org/frs/download.php/file/${STUPID_NUM}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="*"
IUSE="nls"

COMMON_DEPEND="sys-libs/ncurses"
DEPEND="${COMMON_DEPEND}
	nls? ( sys-devel/gettext )"
RDEPEND="${COMMON_DEPEND}
	net-dialup/lrzsz"

DOCS="AUTHORS ChangeLog NEWS README doc/minicom.FAQ"

# Supported languages and translated documentation
# Be sure all languages are prefixed with a single space!
MY_AVAILABLE_LINGUAS=" cs da de es fi fr hu id ja nb pl pt_BR ro ru rw sv vi zh_TW"
IUSE="${IUSE} ${MY_AVAILABLE_LINGUAS// / linguas_}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-2.3-gentoo-runscript.patch
}

src_configure() {
	econf \
		--sysconfdir="${EPREFIX}"/etc/${PN} \
		$(use_enable nls)
}

src_install() {
	default
	insinto /etc/minicom
	doins "${FILESDIR}"/minirc.dfl
}

pkg_preinst() {
	[[ -s ${EROOT}/etc/minicom/minirc.dfl ]] && rm -f "${ED}"/etc/minicom/minirc.dfl
}
