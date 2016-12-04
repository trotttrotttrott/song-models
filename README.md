# song-models

Generates MIDI data for mapping song structures in sequencers. Typically, this would be done manually in MIDI sequencers with a lot of manual pointing and clicking.

So far, Logic Pro 10.2.4 is the only sequencer the output has been tested with. With Logic, use `File -> Open...` instead of `File -> Import -> MIDI File...`.

_example:_

```ruby
sequence = Sequence.new

sequence << Event.marker("Intro")
sequence << Event.tempo(130)
sequence << Event.time_signature(4, 2) # 4/4 (denominator squared is actual beat value)

sequence.advance_time 16 # advance 16 quarter notes from last event

sequence << Event.marker("Some Other Part")
sequence << Event.tempo(195)
sequence << Event.time_signature(6, 3) # 6/8

sequence << Event.end_track

sequence.write! File.open(File.expand_path("song.mid", File.dirname(__FILE__)), "wb")
```
