# `libclang-rb`

This small gem provides a bundled `libclang` shared library which, should work well on OSX, Windows, as well as usual Linux distributions. It shamelessly uses the bundled `libclang` from the [great `libclang` PyPi project](https://pypi.org/project/libclang/).

The gem version is the same as the `libclang` version it bundles. Right now, that's corresponds `14`, but willing to add lower versions if there's demand.

## Supported Platforms

- `x86_64-darwin`
- `x86_64-linux`
- `x86_64-linux-musl`
- `x64-mingw32`
- `x64-mingw-ucrt`
- `aarch64-linux`
- `arm64-darwin`

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle lock --add-platform $ONE_OF_THE_ABOVE_PLATFORMS
    $ bundle add libclang

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install libclang

## Usage

This gem simply provides a `libclang.(so|dylib|dll)` so it does not do much. It is up to the user to use it in their own way.

```bash
$ nm -gU "$(ruby -rlibclang -e 'puts Libclang.path')"
...
0000000000025e3c T _clang_BlockCommandComment_getArgText
0000000000025d8c T _clang_BlockCommandComment_getCommandName
0000000000025e18 T _clang_BlockCommandComment_getNumArgs
0000000000025e74 T _clang_BlockCommandComment_getParagraph
....
```

## Contributing

[Bug reports and pull requests are welcome on GitHub](https://github.com/oxidize-rb/libclang-rb).

The gem is available as open source under the terms of the [Apache-2.0 License](https://opensource.org/licenses/Apache-2.0).

## Code of Conduct

Everyone interacting in the Libclang project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/ianks/libclang/blob/main/CODE_OF_CONDUCT.md).
