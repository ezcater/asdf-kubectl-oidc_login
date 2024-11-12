<div align="center">

# asdf-kubectl-oidc_login [![Build](https://github.com/ezcater/asdf-kubectl-oidc_login/actions/workflows/build.yml/badge.svg)](https://github.com/ezcater/asdf-kubectl-oidc_login/actions/workflows/build.yml) [![Lint](https://github.com/ezcater/asdf-kubectl-oidc_login/actions/workflows/lint.yml/badge.svg)](https://github.com/ezcater/asdf-kubectl-oidc_login/actions/workflows/lint.yml)

[kubectl-oidc_login](https://github.com/int128/kubelogin) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `bash`: to run this plugin
- `curl`: to download the release
- `unzip`: to extract the release package
- [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html)

# Install

Plugin:

```shell
asdf plugin add kubectl-oidc_login
# or
asdf plugin add kubectl-oidc_login https://github.com/ezcater/asdf-kubectl-oidc_login.git
```

kubectl-oidc_login:

```shell
# Show all installable versions
asdf list-all kubectl-oidc_login

# Install specific version
asdf install kubectl-oidc_login latest

# Set a version globally (on your ~/.tool-versions file)
asdf global kubectl-oidc_login latest

# Now kubectl-oidc_login commands are available
kubectl-oidc_login --version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/ezcater/asdf-kubectl-oidc_login/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [ezCater](https://github.com/ezcater/)
