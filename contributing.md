# Contributing

Testing Locally:

```shell
asdf plugin test <plugin-name> <plugin-url> [--asdf-tool-version <version>] [--asdf-plugin-gitref <git-ref>] [test-command*]

# TODO: adapt this
asdf plugin test kubectl-oidc_login https://github.com/ezcater/asdf-kubectl-oidc_login.git "kubectl-oidc_login --version"
```

Tests are automatically run in GitHub Actions on push and PR.
