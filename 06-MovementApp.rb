require "gosu"

# Player class to keep some of our data organized
class Player
  attr_reader :image # Let's us access this value from the outside
  attr_accessor :x, :y # Let's us access AND update the value from the outside

  def initialize image, x, y
    @image = image
    @x = x
    @y = y
  end
end

class MovementApp < Gosu::Window
  
  def initialize
    super 1024, 768
    self.caption = "Use the Arrow Keys or \"WASD\" to Move"
    @background = Gosu::Image.new "./media/newfoundland.jpg"
    @welcome_text = Gosu::Image.from_text "Welcome to Lighthouse", 32

    @quit_button = Gosu::Image.new "./media/quit.png"
    @quit_button_x = self.width - (@quit_button.width / 2) - 64
    @quit_button_right_x = self.width - 64
    @quit_button_bottom_y = (@quit_button.height / 2) + 64

    # Set default direction (none)
    @direction_pressed = nil

    # Set up player
    player_image = Gosu::Image.new "./media/lighthouse.png"
    @player = Player.new player_image, self.width / 2, self.height / 2
  end

  def button_down id
    case id
      when Gosu::KB_ESCAPE
        close
      when Gosu::MS_LEFT
        close if @quit_button_right_x > self.mouse_x && @quit_button_x < self.mouse_x && @quit_button_bottom_y > self.mouse_y && 64 < self.mouse_y
      # Check for our target buttons
      when Gosu::KB_RIGHT, Gosu::KB_D
        @direction_pressed = "right"
      when Gosu::KB_LEFT, Gosu::KB_A
        @direction_pressed = "left"
      when Gosu::KB_DOWN, Gosu::KB_S
        @direction_pressed = "down"
      when Gosu::KB_UP, Gosu::KB_W
        @direction_pressed = "up"
      else
        super
    end
  end

  # Similar to button_down, but checks for keys / buttons being released
  def button_up id
    case id
      when Gosu::KB_RIGHT, Gosu::KB_D, Gosu::KB_LEFT, Gosu::KB_A, Gosu::KB_DOWN, Gosu::KB_S, Gosu::KB_UP, Gosu::KB_W
        @direction_pressed = nil
    end
  end

  # The update method runs each frame after checks for a button press but before the draw
  def update
    case @direction_pressed
      when "right"
        @player.x = @player.x + 5 # Number of pixels will determine the "speed" of movement
      when "left"
        @player.x = @player.x - 5 # Number of pixels will determine the "speed" of movement
      when "down"
        @player.y = @player.y + 5 # Number of pixels will determine the "speed" of movement
      when "up"
        @player.y = @player.y - 5 # Number of pixels will determine the "speed" of movement
    end
  end

  def draw
    @background.draw 0, 0, 0, 1, 1 
    @welcome_text.draw 64, 64, 0, 1, 1, Gosu::Color::BLACK
    @quit_button.draw @quit_button_x, 64, 0, 0.5, 0.5

    # Draw the player graphic; note we are always using up-to-date co-ordinates!
    @player.image.draw @player.x, @player.y, 0, 0.25, 0.25
  end

end

MovementApp.new.show
