# Brigade Project Integration Testing

An example of how to run unit tests against a [Brigade](https://brigade.sh/)
project, using [minikube](https://kubernetes.io/docs/setup/minikube/).

## Cloning

This codebase makes use of [git submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules).
To clone, run:

```console
git clone --recurse-submodules https://github.com/blimmer/brigade-project-integration-test.git
```

## Testing

This project has an extensive integration testing framework. It makes use of
[minikube](https://kubernetes.io/docs/setup/minikube/) to set up a local
instance of the project and run real-world scenarios to verify behavior.

To run tests, execute:

```console
./test/run.sh
```

Optionally, non-default values for `brigade.js` file location and project fixture can be provided:

```console
BRIGADE_JS=./path/to/brigade.js FIXTURE_PROJECT_NAME=my/test-fixture ./test/run.sh
```

If supplying your own `FIXTURE_PROJECT_NAME`, ensure it already exists before running tests.

This script sets up a local minikube with the test project to execute tests
against. These tests also run in
[Travis-CI](https://travis-ci.com/blimmer/brigade-project-integration-test).

### Framework

We utilize the [bats](https://github.com/sstephenson/bats) framework for
writing our unit tests. Additionally, we rely on
[bats-assert](https://github.com/ztombol/bats-assert) for syntactic sugar.

Please refer to the links above to learn more about writing tests.
