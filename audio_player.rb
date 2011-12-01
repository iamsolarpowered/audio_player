class AudioPlayer < Processing::App

  load_library 'control_panel'
  load_library 'minim'
  load_library 'waveform'
  import 'ddf.minim'
  
  include Waveform
  
  BUFFER_SIZE = 1024
  SONGS = Dir[ENV['HOME'] + "/Music/*.mp3"]

  def setup
    size 1024, 150
    frame_rate 30
    
    color_mode HSB, 100
    
    @font = load_font "Ziggurat-HTF-Black-32.vlw"
    text_font @font, 32
    
    @minim = Minim.new(self)
    
    control_panel do |c|
      c.slider :hue, 0..100, 16
      c.slider :saturation, 0..100, 85
      c.slider :brightness, 0..100, 85
      c.slider :background, 0..100, 0
      c.button :skip_song
    end
  end
  
  def draw
    background(@background) # Erase last frame
    stroke @hue, @saturation, @brightness
    fill @hue, @saturation, @brightness
    
    play_random_song unless @song && @song.is_playing
    
    text @title, 10, 140
    draw_waveform(@song)
  end
  
  def play_random_song
    @song = @minim.load_file(SONGS[rand(SONGS.length)], BUFFER_SIZE)
    if data = @song.get_meta_data rescue false
      @title = "#{data.title} by #{data.author}"
    end
    @song.play
  end
  
  def skip_song
    @song.pause
  end

end

AudioPlayer.new :title => "Audio Player"

