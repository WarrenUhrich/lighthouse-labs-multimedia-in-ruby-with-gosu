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
  attr_accessor :x, :y, :velocity

  def initialize x, y, velocity
    @image = Gosu::Image.new "./media/ruby.png"
    @x = x
    @y = y
    @velocity = velocity
  end
end

class CollectionGame < Gosu::Window
  
  def initialize
    super 1024, 768
    self.caption = "Click the 'Quit' Button"
    @background = Gosu::Image.new "./media/newfoundland.jpg"
    @welcome_text = Gosu::Image.from_text "Welcome to Lighthouse", 32

    @quit_button = Gosu::Image.new "./media/quit.png"
    @quit_button_x = self.width - (@quit_button.width / 2) - 64
    @quit_button_right_x = self.width - 64
    @quit_button_bottom_y = (@quit_button.height / 2) + 64

    # Add restart button
    @restart_button = Gosu::Image.new "./media/restart.png"
    @restart_button_x = self.width - (@restart_button.width / 2) - 64
    @restart_button_right_x = self.width - 64
    @restart_button_bottom_y = (@restart_button.height / 2) + 96

    @direction_pressed = nil
    player_image = Gosu::Image.new "./media/lighthouse.png"

    # Update default player "y" position
    @player = Player.new player_image, self.width / 2, self.height - (player_image.height / 4)

    # Set a timer
    @interval = 360 # Reset timer when this many frames pass
    @timer = 0 # We will use this to see how many "frames" have passed

    # Create an array for gems
    @gems = []

    # Default score
    @score = 0
  end

  # Reset game values method (we can call when we need to)
  def reset_game
    @interval, @timer, @gems, @score = 360, 0, [], 0 # Reset values
  end

  def button_down id
    case id
      when Gosu::KB_ESCAPE
        close
      when Gosu::MS_LEFT
        close if @quit_button_right_x > self.mouse_x && @quit_button_x < self.mouse_x && @quit_button_bottom_y > self.mouse_y && 64 < self.mouse_y
        
        # Restart game if "Restart" button clicked
        reset_game if @restart_button_right_x > self.mouse_x && @restart_button_x < self.mouse_x && @restart_button_bottom_y > self.mouse_y && 128 < self.mouse_y
      when Gosu::KB_RIGHT, Gosu::KB_D
        @direction_pressed = "right"
      when Gosu::KB_LEFT, Gosu::KB_A
        @direction_pressed = "left"
      # Remove up and down
      else
        super
    end
  end

  def button_up id
    case id
      when Gosu::KB_RIGHT, Gosu::KB_D, Gosu::KB_LEFT, Gosu::KB_A
        @direction_pressed = nil
    end
  end

  def update
    case @direction_pressed
      when "right"
        @player.x = @player.x + 5

        # Prevent the lighthouse from going off-screen
        max_x = self.width - (@player.image.width / 4)
        @player.x = max_x if @player.x > max_x
      when "left"
        @player.x = @player.x - 5

        # Prevent the lighthouse from going off-screen
        @player.x = 0 if @player.x < 0
    end

    # Handle timer per-frame
    @timer = @timer + 1
    if @timer > @interval
      @timer = 0 # Reset to zero
      # Keep lowering the interval until it is 1 second
      @interval = @interval - 20 if @interval > 60
      # Determine random point at top of screen to place new gem
      max_x = self.width - 64
      gem_x = rand 0..max_x
      @gems.push RubyGem.new gem_x, -64, 4 # Appear a bit above screen
    end

    # Check if any gems have passed the bottom of the screen
    @gems.each_with_index do |gem, index|
      gem.y = gem.y + gem.velocity
      
      # Check if the player caught the gem
      if gem.y + 64 >= @player.y && gem.x > @player.x && gem.x < @player.x + (@player.image.width / 4)
        @gems.delete_at index
        @score = @score + 1
      end

      # If you miss a gem: GAME OVER!
      if gem.y > self.height
        self.reset_game
      end
    end
  end

  def draw
    @background.draw 0, 0, 0, 1, 1 
    @welcome_text.draw 64, 64, 0, 1, 1, Gosu::Color::BLACK
    @quit_button.draw @quit_button_x, 64, 0, 0.5, 0.5
    @player.image.draw @player.x, @player.y, 0, 0.25, 0.25

    # Draw "Restart" button
    @restart_button.draw @restart_button_x, 128, 0, 0.5, 0.5

    # Draw all falling gems
    @gems.each do |gem|
      gem.image.draw gem.x, gem.y, 0, 0.1, 0.1
    end

    # Draw your current score
    Gosu::Image.from_text("Score: #{@score}", 32).draw 64, 96, 0, 1, 1, Gosu::Color::BLACK
  end

end

# Only run program if this is the main target file being run
# example) ruby CollectionGame.rb
CollectionGame.new.show if __FILE__ == $0
