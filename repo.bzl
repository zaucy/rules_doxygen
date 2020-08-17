
_windows_build_file_content = """
alias(
    name = "doxygen",
    visibility = ["//visibility:public"],
    actual = "{DOXYGEN_VERSION}/doxygen.exe",
)
"""

_known_archives = {
    "1.8.19": {
        "windows64": struct(
            urls = ["https://doxygen.nl/files/doxygen-1.8.19.windows.x64.bin.zip"],
            strip_prefix = "",
            sha256 = "36beda917f395b4160777f3689e86d6b7e4e51f6f9432413db8fe3b9279e6082",
            build_file_content = _windows_build_file_content,
        ),
        "windows32": struct(
            urls = ["https://doxygen.nl/files/doxygen-1.8.19.windows.bin.zip"],
            strip_prefix = "",
            sha256 = "",
            build_file_content = _windows_build_file_content,
        ),
    },
}

def _os_key(os):
    if os.name.find("windows") != -1:
        return "windows32"
    elif os.name.find("linux") != -1:
        return "linux64"
    return os.name

def _get_doxygen_archive(rctx):
    doxygen_version = rctx.attr.doxygen_version
    archives = _known_archives.get(doxygen_version)

    if not archives:
        fail("rules_doxygen unsupported doxygen_version: {}".format(doxygen_version))

    archive = archives.get(_os_key(rctx.os))

    if not archive:
        fail("rules_doxygen unknown doxygen version / operating system combo: doxygen_version={} os=".format(doxygen_version, rctx.os.name))

    return archive

def _doxygen_repository(rctx):
    archive = _get_doxygen_archive(rctx)
    rctx.download_and_extract(archive.urls, output = rctx.attr.doxygen_version, stripPrefix = archive.strip_prefix, sha256 = archive.sha256)
    rctx.file("BUILD.bazel", archive.build_file_content.format(DOXYGEN_VERSION=rctx.attr.doxygen_version), executable = False)

doxygen_repository = repository_rule(
    implementation = _doxygen_repository,
    attrs = {
        "doxygen_version": attr.string(
            default = "1.8.19",
            values = _known_archives.keys(),
        ),
    },
)
