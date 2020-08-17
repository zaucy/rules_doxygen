# rules_doxygen

Bazel rules for running doxygen. Experimental work in progress

## Install

```python
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "rules_doxygen",
    strip_prefix = "rules_doxygen-d0d02cd48bc87b1fc880ee4b8de68cc5afc2d8c2",
    urls = ["https://github.com/zaucy/rules_doxygen/archive/d0d02cd48bc87b1fc880ee4b8de68cc5afc2d8c2.zip"],
    sha256 = "c381d7b476668123881d2afde690686877397a87f372f377bd984335a9cc93fd",
)
```

## Usage

Run doxygen through bazel

```sh
bazel run @doxygen//:doxygen -- -g
```

## License

MIT
