require "gosu"

class EscapeApp < Gosu::Window
  
  def initialize
    super 1024, 768
    self.caption = "Press the 'ESC' Key to Quit"
    @background = Gosu::Image.new "./media/newfoundland.jpg"
    @welcome_text = Gosu::Image.from_text "Welcome to Lighthouse", 32
  end

  def draw
    @background.draw 0, 0, 0, 1, 1 
    @welcome_text.draw 64, 64, 0, 1, 1, Gosu::Color::BLACK
  end

  # Runs when keys or gamepad buttons are pressed
  def button_down id # Accepts an ID representing the key / button
    case id
      when Gosu::KB_ESCAPE # When the escape key is pressed...
        close # Close the program
      else # Otherwise...
        super # Run default for button_down
    end
  end

end

EscapeApp.new.show
