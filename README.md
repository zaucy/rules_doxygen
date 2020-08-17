# rules_doxygen

Bazel rules for running doxygen. Experimental work in progress

## Install

```python
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
  name = "rules_doxygen",
  strip_prefix = "",
  urls = [""],
  sha256 = "",
)
```

## Usage

Run doxygen through bazel

```sh
bazel run @doxygen//:doxygen -- -g
```

## License

MIT
