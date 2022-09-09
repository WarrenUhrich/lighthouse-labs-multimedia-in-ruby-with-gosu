require "gosu"

class ClickingApp < Gosu::Window
  
  def initialize
    super 1024, 768
    self.caption = "Click the 'Quit' Button"
    @background = Gosu::Image.new "./media/newfoundland.jpg"
    @welcome_text = Gosu::Image.from_text "Welcome to Lighthouse", 32

    # New graphic for quit button
    @quit_button = Gosu::Image.new "./media/quit.png"
    # Where do we want to draw this? (top right corner)
    # Draw quit button # If we draw at half-size, divide width by 2
    @quit_button_x = self.width - (@quit_button.width / 2) - 64
    # Get other relevant co-ords
    @quit_button_right_x = self.width - 64
    @quit_button_bottom_y = (@quit_button.height / 2) + 64
  end

  def draw
    @background.draw 0, 0, 0, 1, 1 
    @welcome_text.draw 64, 64, 0, 1, 1, Gosu::Color::BLACK

    # Draw the button; half-size (0.5)
    @quit_button.draw @quit_button_x, 64, 0, 0.5, 0.5
  end

  def button_down id
    case id
      when Gosu::KB_ESCAPE
        close
      when Gosu::MS_LEFT # Handle left mouse click
        # Close if click is inside button co-ordinates
        close if @quit_button_right_x > self.mouse_x && @quit_button_x < self.mouse_x && @quit_button_bottom_y > self.mouse_y && 64 < self.mouse_y
      else
        super
    end
  end

end

ClickingApp.new.show
