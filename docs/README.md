![Elementary Audio Logo](https://github.com/nick-thompson/elementary/blob/6bd2ad18946e9b784e70642ac775f4e3b5ce727c/Lockup.png)

[Website](https://www.elementary.audio/) | [Documentation](https://docs.elementary.audio/) | [Discord Chat](https://discord.gg/xSu9JjHwYc)

Elementary is a JavaScript framework for writing functional, declarative audio applications with a high
performance, native audio engine. Elementary aims to lower the barrier to entry into the
audio application space, eliminate the gap between prototyping and production, and bring the functional reactive
programming model to DSP.

Watch the [intro video](https://www.youtube.com/watch?v=AvCdrflFHu8) for the full story.

## Installation

#### MacOS and Linux

```bash
$ curl -fsSL https://www.elementary.audio/install.sh | sh
```

#### Windows and Manual Installation

You can also install the appropriate binaries for your platform manually, downloading
from [the releases page](https://github.com/nick-thompson/elementary/releases) on this repository,
and unpacking the zip file to a directory of your choosing.

Elementary has essentially two components: the *runtime*, and the *library*.

The *runtime* is a native binary application much like Node.js itself, which is installed via the above `curl` command.

The *library* component is what you'll find in this `npm` package. Explained in detail in the reference section of the documentation,
the Elementary library offers a set of convenience APIs and a growing set of library functions to help you construct your audio signal chain.

## Examples

Here in the `examples/` directory you'll find a small set of example projects aiming to provide a brief introduction to various functionality. Each
example can be invoked on its own:

```bash
$ cd examples/
$ npm install
$ elementary 00_HelloSine/
```

And of course you can open these example files, poke around, and edit as you like!

## Licensing

The example code listed in this repository is available under the terms of the ISC License.

The Elementary framework itself is available under one of two different licenses for either personal or
commercial use. Please see the Elementary package on npm for details.
