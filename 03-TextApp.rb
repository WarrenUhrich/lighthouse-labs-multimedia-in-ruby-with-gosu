require "gosu"

class TextApp < Gosu::Window
  
  def initialize
    super 1024, 768
    self.caption = "Application with Text"
    @background = Gosu::Image.new "./media/newfoundland.jpg"

    # Lets create a text object
    # The 'from_text' method expects:
    # * text (phrase you want to render)
    # * line_height (size of the text)
    # * options {:font, :bold, :italic, :underline, :width, :spacing, :align, :retro}
    @welcome_text = Gosu::Image.from_text "Welcome to Lighthouse", 32
  end

  def draw
    @background.draw 0, 0, 0, 1, 1 

    # We'll draw this text much the same we did our image
    # We can use the default BLACK constant
    @welcome_text.draw 64, 64, 0, 1, 1, Gosu::Color::BLACK # x, y, z, scale_x, scale_y, color
  end

end

TextApp.new.show
