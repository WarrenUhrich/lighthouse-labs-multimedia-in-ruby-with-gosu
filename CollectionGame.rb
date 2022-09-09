require "gosu"

class Player
  attr_reader :image
  attr_accessor :x, :y

  def initialize image, x, y
    @image = image
    @x = x
    @y = y
  end
end

class RubyGem
  attr_reader :image
  attr_accessor :x, :y

  def initialize x, y
    @image = Gosu::Image.new "media/ruby.png"
    @x = x
    @y = y
  end
end

class CollectionGame < Gosu::Window

  def initialize
    super 1024, 768
    self.caption = "Collection Game"

    @background_image = Gosu::Image.new "media/newfoundland.jpg"
    @welcome_text = Gosu::Image.from_text "Welcome to Lighthouse", 32

    player_image = Gosu::Image.new "media/lighthouse.png"
    @player = Player.new player_image, self.width / 2, self.height - (player_image.height * 0.25)
  
    @direction_pressed = nil

    @timer = 0
    @interval = 60 * 3
    @gems = []
  end

  def button_down id
    case id
      when Gosu::KB_RIGHT
        @direction_pressed = 'right'
      when Gosu::KB_LEFT
        @direction_pressed = 'left'
    end
  end

  def button_up id
    case id
      when Gosu::KB_RIGHT
        @direction_pressed = nil
      when Gosu::KB_LEFT
        @direction_pressed = nil
    end
  end

  def update
    case @direction_pressed
      when 'right'
        @player.x = @player.x + 5
      when 'left'
        @player.x = @player.x - 5
    end

    @timer = @timer + 1

    if @timer >= @interval
      @timer = 0

      gem_x = rand 0..(self.width - 64)
      new_gem = RubyGem.new gem_x, -64
      @gems.push(new_gem)
    end
  end

  def draw
    @background_image.draw 0, 0 # X, Y
    @welcome_text.draw 64, 64, 0, 1, 1, Gosu::Color::BLACK
    @player.image.draw @player.x, @player.y, 0, 0.25, 0.25

    @gems.each_with_index do |gem|
      gem.y = gem.y + 5
      gem.image.draw gem.x, gem.y, 0, 0.1, 0.1
    end
  end

end

CollectionGame.new.show
