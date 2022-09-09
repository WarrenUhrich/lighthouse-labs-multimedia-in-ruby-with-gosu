require "gosu"

class BackgroundApp < Gosu::Window
  
  def initialize
    super 1024, 768
    self.caption = "Application with a Background"

    # Here we'll create an image object
    # Pass to it the file path to your image resource
    @background = Gosu::Image.new "./media/newfoundland.jpg"
  end

  # The draw method is where we decide what to show in the window
  # Remember that it will run this many times per second!
  def draw
    # We'll run the "draw" method that lives in our @background image object
    # This method takes in a variety of arguments:
    # * x (horizontal position from top-left)
    # * y (vertical position from top-left)
    # * z (layer compared to other images in the frame - default is zero)
    # * scale_x (resize horizontally - default is 1)
    # * scale_y (resize vertically - default is 1)
    # * color (colour-fill if possible - see Gosu::Color class)
    # * mode (blending mode - :default or :additive)
    @background.draw 0, 0, 0, 1, 1 # x, y, z, scale_x, scale_y
  end

end

BackgroundApp.new.show
