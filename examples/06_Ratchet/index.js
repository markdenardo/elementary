import {ElementaryNodeRenderer as core, el} from '@nick-thompson/elementary';
import { dirname, resolve } from 'path';
import { fileURLToPath } from 'url';


// This example shows a neat trick for adding occasional ratchet steps into an
// otherwise static sample playback pattern.
const __dirname = dirname(fileURLToPath(import.meta.url));
const SAMPLE_PATH = resolve(__dirname, './Contact04.wav');


function pattern() {
  // First we generate a simple phasor running at 8Hz and from that derive
  // our "baseTrain," which is a pulse train running at the same frequency.
  let t = el.phasor(2);
  let baseTrain = el.le(t, 0.5);

  // Then we derive our "ratchet" signal from `t` by a factor of 8 to create
  // another phasor running 8 times as fast as `t` but perfectly in sync.
  let t8 = el.mul(t, 8);
  let ratchet = el.sub(t8, el.floor(t8));

  // From that we can derive our "ratchetTrain," which is a pulse train much like
  // "baseTrain" but running at the ratchet rate.
  let ratchetTrain = el.le(ratchet, 0.5);

  // Finally we construct our primary "train" by selecting from either the base
  // train or the ratchet train every few seconds.
  let train = el.select(
    el.train(0.5),
    baseTrain,
    el.mul(baseTrain, ratchetTrain)
  );

  // And we use that train to simply drive our sample playback
  return el.sample(
    {path: SAMPLE_PATH},
    train,
  );
}

// Await the "load" event, and render!
core.on('load', function() {
  let pat = pattern();
  core.render(pat, pat);
});

core.initialize();
