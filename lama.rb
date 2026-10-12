require "gosu"

class Game < Gosu::Window
  def initialize
    super(640, 480)
    self.caption = "Lamas morötter"
    @llama = Gosu::Image.new("media/img/llama.png")
    @x = 270
    @y = 180

    @carrot = Gosu::Image.new("media/img/carrot.png")
    @carrot_x = Gosu.random(0, width - @carrot.width)
    @carrot_y = Gosu.random(0, height - @carrot.height)

    @munch = Gosu::Sample.new("media/audio/omnomnom.mp3")
    @score = 0

    @font = Gosu::Font.new(24)

    @direction = "right"

    @time = 10000
  end

  def countdown
    while @time > 0
      @time -= Gosu.milliseconds
    end
  end

  def draw
    if @direction == "right"
      @llama.draw(@x, @y, 1)
    end
    @carrot.draw(@carrot_x, @carrot_y, 0)
    @font.draw_text("Morötter: #{@score}", 10, 10, 10)
    if @direction == "left"
      @llama.draw(@x, @y, 1, -1)
    end
    @font.draw_text("Tid kvar: #{@time /1000}s.", 10, 30, 10)
  end

  def update
    @time.countdown
    if Gosu.button_down?(Gosu::KB_LEFT)
      @x -= 5
      @direction = "left"
    end 
    if Gosu.button_down?(Gosu::KB_RIGHT)
      @x += 5 
      @direction = "right"
    end
    @y -= 5 if Gosu.button_down?(Gosu::KB_UP)
    @y += 5 if Gosu.button_down?(Gosu::KB_DOWN)

    @x = @x.clamp(0, width - @llama.width)
    @y = @y.clamp(0, height - @llama.height)

    if Gosu.distance(@x, @y, @carrot_x, @carrot_y) < 60
      @munch.play
      @score += 1
      @carrot_x = Gosu.random(0, width - @carrot.width)
      @carrot_y = Gosu.random(0, height - @carrot.height)
    end
  end
end



Game.new.show