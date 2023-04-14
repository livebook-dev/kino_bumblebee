# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [v0.3.0](https://github.com/livebook-dev/kino_bumblebee/tree/v0.3.0) (2023-04-14)

### Added

* Image-to-text task ([#29](https://github.com/livebook-dev/kino_bumblebee/pull/29))

### Changed

* Model loading to no longer use `:log_params_diff`
* Updated generation examples to use generation config ([#30](https://github.com/livebook-dev/kino_bumblebee/pull/30))

## [v0.2.1](https://github.com/livebook-dev/kino_bumblebee/tree/v0.2.1) (2023-03-23)

### Added

* Conversation task ([#23](https://github.com/livebook-dev/kino_bumblebee/pull/23))
* Question answering task ([#23](https://github.com/livebook-dev/kino_bumblebee/pull/23))

### Changed

* Updated generated source to rely on enumerable `Kino.Control` ([#27](https://github.com/livebook-dev/kino_bumblebee/pull/27))

### Added

* XLM-RoBERTa models for punctuation and language detection ([#16](https://github.com/livebook-dev/kino_bumblebee/pull/16))
* Zero-shot text classification task ([#17](https://github.com/livebook-dev/kino_bumblebee/pull/17))
* Speech-to-text task ([#19](https://github.com/livebook-dev/kino_bumblebee/pull/19))

## [v0.2.0](https://github.com/livebook-dev/kino_bumblebee/tree/v0.2.0) (2023-03-16)

### Added

* XLM-RoBERTa models for punctuation and language detection ([#16](https://github.com/livebook-dev/kino_bumblebee/pull/16))
* Zero-shot text classification task ([#17](https://github.com/livebook-dev/kino_bumblebee/pull/17))
* Speech-to-text task ([#19](https://github.com/livebook-dev/kino_bumblebee/pull/19))

## [v0.1.4](https://github.com/livebook-dev/kino_bumblebee/tree/v0.1.4) (2022-12-15)

### Fixed

* Numeric parameters that were inserted as strings in the generated code

## [v0.1.3](https://github.com/livebook-dev/kino_bumblebee/tree/v0.1.3) (2022-12-15)

### Fixed

* Smart cell attributes import for the token classification task ([#12](https://github.com/livebook-dev/kino_bumblebee/pull/12))

## [v0.1.2](https://github.com/livebook-dev/kino_bumblebee/tree/v0.1.2) (2022-12-15)

### Changed

* Bumped `bumblebee` dependency requirement

## [v0.1.1](https://github.com/livebook-dev/kino_bumblebee/tree/v0.1.1) (2022-12-14)

### Added

* Fill-mask to the Neural Network task cell ([#9](https://github.com/livebook-dev/kino_bumblebee/pull/9))
* Token classification to the Neural Network task cell ([#10](https://github.com/livebook-dev/kino_bumblebee/pull/10))

## [v0.1.0](https://github.com/livebook-dev/kino_bumblebee/tree/v0.1.0) (2022-12-08)

Initial release.
