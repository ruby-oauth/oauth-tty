# Changelog

[![SemVer 2.0.0][📌semver-img]][📌semver] [![Keep-A-Changelog 1.0.0][📗keep-changelog-img]][📗keep-changelog]

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog][📗keep-changelog],
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html),
and [yes][📌major-versions-not-sacred], platform and engine support are part of the [public API][📌semver-breaking].
Please file a bug if you notice a violation of semantic versioning.

[📌semver]: https://semver.org/spec/v2.0.0.html
[📌semver-img]: https://img.shields.io/badge/semver-2.0.0-FFDD67.svg?style=flat
[📌semver-breaking]: https://github.com/semver/semver/issues/716#issuecomment-869336139
[📌major-versions-not-sacred]: https://tom.preston-werner.com/2022/05/23/major-version-numbers-are-not-sacred.html
[📗keep-changelog]: https://keepachangelog.com/en/1.0.0/
[📗keep-changelog-img]: https://img.shields.io/badge/keep--a--changelog-1.0.0-FFDD67.svg?style=flat

## [Unreleased]

### Added

### Changed

### Deprecated

### Removed

### Fixed

### Security

## [1.0.6] - 2025-09-21

- TAG: [v1.0.6][1.0.6t]
- COVERAGE: 100.00% -- 296/296 lines in 10 files
- BRANCH COVERAGE: 96.55% -- 28/29 branches in 10 files
- 11.43% documented

### Added

- (dev) kettle-dev v1.1.16 (@pboling)
- (docs) more documentation (@Aboling0, @pboling)
- (docs) Deployed documentation site for HEAD (@Aboling0)
    - https://oauth-tty.galtzo.com
- (test) many new tests (@pboling)
- (docs) CITATION.cff
- support window increased, down to Ruby 2.3 (@pboling)
- (test) added specs for oauth.opts usage (@pboling)
- (test) added specs for all commands (@pboling)

### Changed

- (docs) upgrade Code of Conduct to Contributor Covenant 2.1 (@pboling)
- (test) migrated test suite to RSpec (@pboling)
- (test) ignore Ruby warnings coming from other libs (@pboling)

### Removed

- (test) minitest (@pboling)

### Fixed

- Fixed issues in option parsing by implementing Command#parse_options (@pboling)
  - Use Shellwords for proper tokenization
  - Verified options file loading and CLI flag precedence

## [1.0.5] - 2022-09-20

- TAG: [v1.0.5][1.0.5t]

### Added

- SHA 256 Checksum for release (in addition to SHA 512) (@pboling)
- Aligned checksums directory name with `rake build:checksum` task (@pboling)
- General Cleanup

## [1.0.4] - 2022-09-19

- TAG: [1.0.4][1.0.4t]

### Added

- Certificate for signing gem releases (@pboling)
- Gemspec metadata (@pboling)
  - funding_uri
  - mailing_list_uri
- Installation and usage documentation (@pboling)
- SHA 512 Checksum for release (@pboling)

### Changed

- Gem releases are now cryptographically signed (@pboling)

## [1.0.3] - 2022-09-06

- TAG: [1.0.3][1.0.3t]

### Fixed

- Author name - Thaigo Pinto (@pboling)

## [1.0.2] - 2022-08-26

- TAG: [1.0.2][1.0.2t]

### Fixed

- URLs in Gemspec (@pboling)

## [1.0.1] - 2022-08-26

- TAG: [1.0.1][1.0.1t]

### Fixed

- Circular reference while loading (@pboling)

## [1.0.0] - 2022-08-26

- TAG: [1.0.0][1.0.0t]

### Added

- Initial release (@pboling)

[Unreleased]: https://github.com/ruby-oauth/oauth-tty/compare/v1.0.6...HEAD
[1.0.6]: https://github.com/ruby-oauth/oauth-tty/compare/v1.0.5...v1.0.6
[1.0.6t]: https://github.com/ruby-oauth/oauth-tty/releases/tag/v1.0.6
[1.0.5]: https://gitlab.com/ruby-oauth/oauth-tty/-/compare/v1.0.4...v1.0.5
[1.0.5t]: https://gitlab.com/ruby-oauth/oauth-tty/-/releases/tag/v1.0.5
[1.0.4]: https://gitlab.com/ruby-oauth/oauth-tty/-/compare/v1.0.3...v1.0.4
[1.0.4t]: https://gitlab.com/ruby-oauth/oauth-tty/-/releases/tag/v1.0.4
[1.0.3]: https://gitlab.com/ruby-oauth/oauth-tty/-/compare/v1.0.2...v1.0.3
[1.0.3t]: https://gitlab.com/ruby-oauth/oauth-tty/-/releases/tag/v1.0.3
[1.0.2]: https://gitlab.com/ruby-oauth/oauth-tty/-/compare/v1.0.1...v1.0.2
[1.0.2t]: https://gitlab.com/ruby-oauth/oauth-tty/-/releases/tag/v1.0.2
[1.0.1]: https://gitlab.com/ruby-oauth/oauth-tty/-/compare/v1.0.0...v1.0.1
[1.0.1t]: https://gitlab.com/ruby-oauth/oauth-tty/-/releases/tag/v1.0.1
[1.0.0]: https://gitlab.com/ruby-oauth/oauth-tty/-/releases/tag/v1.0.0
[1.0.0t]: https://gitlab.com/ruby-oauth/oauth-tty/-/releases/tag/v1.0.0
