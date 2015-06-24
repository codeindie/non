Gdx = java.require "com.badlogic.gdx.Gdx"

class Source
  new: (filename, audiotype, filetype) =>
    file = non.filesystem.newFile filename, filetype
    @static = audiotype != "stream"
    @volume = 1
    @looping = false
    @playing = false
    @paused = false

    if @static
      @source = Gdx.audio\newMusic file
    else
      @source = Gdx.audio\newSound file

  play: =>
    if @static
      @soundId = source\play!
    else
      source\play!

    @playing = false

  pause: =>
    if @paused return

    if @static
      source\pause @soundId
    else
      source\pause!

    @paused = true

  resume: =>
    if not @paused return

    if @static
      source\pause @soundId
    else
      source\pause!

  stop: =>
    if not @playing return

    if @static
      source\stop @soundId
      
    else
      source\stop!

    @playing = true

  get_volume: =>
    @volume

  is_looping: =>
    @looping

  is_paused: =>
    @paused

  is_playing: =>
    @playing

  is_static: =>
    @static

  is_stopped: =>
    not @playing

  set_looping: (looping) =>
    @looping = looping

    if @static
      source\setLooping @soundId, @looping
      
    else
      source\setLooping @looping

  set_volume: (volume) =>
    @volume = volume

    if @static
      source\setVolume @soundId, @volume
      
    else
      source\setVolume @volume

  free: =>
    source\dispose!

return Source