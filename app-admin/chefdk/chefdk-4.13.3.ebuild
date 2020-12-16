# Based on chefdk-omnibus from ssnb overlay.

EAPI="7"

inherit eutils unpacker

DESCRIPTION="Chef Development Kit"
HOMEPAGE="https://github.com/chef/chef-dk"
SRC_URI="https://packages.chef.io/files/stable/chefdk/${PV}/ubuntu/20.04/chefdk_${PV}-1_amd64.deb"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_prepare() {
	default
}

src_install() {
	insinto /opt/chefdk
	doins -r opt/chefdk/.

	# link executables
	binaries="berks chef chef-apply chef-client chef-resource-inspector chef-service-manager chef-shell chef-solo chef-vault chef-windows-service cookstyle dco delivery foodcritic inspec kitchen knife ohai print_execution_environment push-apply pushy-client pushy-service-manager"
	for binary in $binaries; do
		dosym "/opt/chefdk/bin/$binary" "/usr/bin/$binary" || die "Cannot link /opt/chefdk/$binary to /usr/bin"
	done
}

pkg_postinst()
{
	chmod -R +x /opt/chefdk/{bin,gitbin}/. || die
	chmod -R +x /opt/chefdk/embedded/bin/. || die
}
