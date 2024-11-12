#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/int128/kubelogin"
TOOL_NAME="kubectl-oidc_login"
TOOL_TEST="kubectl-oidc_login --version"

fail() {
	echo -e "asdf-$TOOL_NAME: $*"
	exit 1
}

curl_opts=(-fsSL)

# NOTE: You might want to remove this if kubectl-oidc_login is not hosted on GitHub releases.
if [ -n "${GITHUB_API_TOKEN:-}" ]; then
	curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
	sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
	git ls-remote --tags --refs "$GH_REPO" |
		grep -o 'refs/tags/.*' | cut -d/ -f3- |
		sed 's/^v//' # NOTE: You might want to adapt this sed to remove non-version strings from tags
}

list_all_versions() {
	# By default we simply list the tag names from GitHub releases.
	list_github_tags
}

download_release() {
	local version filename platform arch url
	version="$1"
	filename="$2"

	case "$(uname)" in
	[dD]arwin*)
		platform="darwin"
		;;
	[lL]inux*)
		platform="linux"
		;;
	*)
		echo "Unsupported OS" 1>&2
		return 1
		;;
	esac

	arch="$(uname -m)"
	case "${arch}" in
	x86_64)
		arch="amd64"
		;;
	aarch64)
		arch="arm64"
		;;
	*) ;;
	esac

	url="${GH_REPO}/releases/download/v${version}/kubelogin_${platform}_${arch}.zip"

	echo "* Downloading $TOOL_NAME release $version..."
	curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
	local install_type="$1"
	local version="$2"
	local install_path="${3%/bin}/bin"

	if [ "$install_type" != "version" ]; then
		fail "asdf-$TOOL_NAME supports release installs only"
	fi

	(
		mkdir -p "$install_path"
		cp -r "$ASDF_DOWNLOAD_PATH"/* "$install_path"

		# Assert kubectl-oidc_login executable exists.
		local tool_cmd
		tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"

		# The repository download packages include the binary as kubelogin,
		# so we must rename it to match kubectl expectations
		# See https://github.com/int128/kubelogin#setup
		# Guard in case they change this in a future release
		if [ ! -e "${install_path}/${tool_cmd}" ]; then
			mv "$install_path"/kubelogin "${install_path}/${tool_cmd}"
		fi

		test -x "$install_path/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

		echo "$TOOL_NAME $version installation was successful!"
	) || (
		rm -rf "$install_path"
		fail "An error occurred while installing $TOOL_NAME $version."
	)
}
