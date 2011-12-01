module Waveform
  
  def draw_waveform(input)
    @input = input
    draw_channel_waveform(:left)
    draw_channel_waveform(:right, 1)
  end
  
  def draw_channel_waveform(channel, line=0)
    @input.send(channel).to_array.each_with_index do |sample, offset|
      alpha = (255 * sample.abs) + 32
      stroke(@hue, @saturation, @brightness, alpha)
      height = (50 + (sample * 75)) + (50 * line)
      line(offset, height, offset + 1, height)
    end
  end

end

