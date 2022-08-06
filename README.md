# VStorm

### A simple app framework for V based on nodes.

Currently in early development, so things can and will change suddenly until a stable version is reached.

## How to install

The simplest way to install and use with your V installation is from VPM using:

> v install ghostnear.vstorm

Then the library will be available for importing using:

> import ghostnear.vstorm

An alternative way to do this is by adding the repo as a submodule in your modules/ folder using GitHub.

## How to use

Everything is documented in the docs/ folder.

Depending on your intent you might want to check out the [dev](docs/dev.md) documentation or the [user](docs/user.md) one.

## Known issues and TODOs:

- figure out mobile touches and make them easier to use trough this. (comes from [ghostnear/vstorm-tic-tac-toe](https://github.com/ghostnear/vstorm-tic-tac-toe))
- wait for a gg.screen_size() fix to work for android so text can be scaled correctly when app is started in fullscreen. (comes from [ghostnear/vstorm-calculator](https://github.com/ghostnear/vstorm-calculator))
- fix relative text scaling for any resolution (comes from [ghostnear/vstorm-calculator](https://github.com/ghostnear/vstorm-calculator))

## Things that use this:
- [ghostnear/vstorm-calculator](https://github.com/ghostnear/vstorm-calculator)
- [ghostnear/vstorm-tic-tac-toe](https://github.com/ghostnear/vstorm-tic-tac-toe)
