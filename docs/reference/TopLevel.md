# Top Level Imports

The Elementary package provides a couple of top-level exports designed to facilitate easily
porting from one target to another, and to provide utilities for easily composing DSP components.

* [ElementaryNodeRenderer](#ElementaryNodeRenderer)
* [ElementaryPluginRenderer](#ElementaryPluginRenderer)
* [ElementaryWebAudioRenderer](#ElementaryWebAudioRenderer)
* [stdlib](#Library)
* [el](#Library)
* [sugar](#Sugar)
* [candyWrap](#Sugar)

## Targets

### ElementaryNodeRenderer

A specialization of the [Renderer](#Renderer) interface described below for rendering
to the Elementary command line tool.

### ElementaryPluginRenderer

A specialization of the [Renderer](#Renderer) interface described below for rendering
to the Elementary Plugin DevKit.

### ElementaryWebAudioRenderer

A specialization of the [Renderer](#Renderer) interface described below for rendering
to Web Audio.

See [WebAudio Applications](../targets/WebAudio.md) for a detailed description of the
important differences in this renderer. In particular, `initialize()` must be called with
a valid AudioContext as the first argument, and an optional AudioWorkletNode options object
as the second argument. With this renderer, `initialize()` is async (or, returns a Promise) that
resolves to an instance of the AudioWorkletNode in which the engine is running.

## Renderer

Each Renderer instance is an event emitter whose interface matches that of Node.js' `events.EventEmitter`.

### Events

* ['load'](#load)
* ['midi'](#midi)
* ['meter'](#meter)
* ['metro'](#metro)

#### Event: 'load'

The load event fires when the engine has finished preparing for audio rendering and is ready
to handle render calls. Any subscribed callback will be called with a single event object
describing the properties of the audio rendering engine.

```js
interface LoadEvent {
  sampleRate: number;
  blockSize: number;
  numInputs: number;
  numOutputs: number;
};
```

#### Event: 'midi'

The midi event fires any time the runtime receives a MIDI event from any connected and enabled device. By default,
the runtime will be listening to any such device, which may yield frequent MIDI events.

See [MIDI](./Midi.md) for detailed MIDI event documentation, and please note that this event is
currently only supported in the Elementary command line tool.

#### Event: 'meter'
#### Event: 'metro'

### Renderer.render(a, b, c, d, ...)

This method is the bread and butter of Elementary. After constructing a signal graph using
the available library components, you'll invoke `render()` with as many arguments as you have
expected output channels. That is, to render stereo output, you'll want to write `core.render(leftOut, rightOut)`.

This method should be called exactly once each time you need to change your rendering graph. Each
invocation prompts Elementary to reconcile the current state of the rendering graph with the new desired
state, and make any necessary changes to migrate the rendering engine from one to the other.

### Renderer.initialize

This method installs the necessary communication mechanisms between the Renderer and the
backend engine, and if necessary, spins up an instance of the underlying engine. It must be called
once at the beginning of your application's lifetime to kick off the Elementary engine, and should
be called only after installing a `"load"` event listener on the Renderer instance itself.

Unless otherwise specified in the above specializations of the Renderer, this method returns a Promise
which resolves to `undefined`.

## Library

## Sugar
