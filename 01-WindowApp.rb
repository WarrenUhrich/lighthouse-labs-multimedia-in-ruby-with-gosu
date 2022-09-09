require "gosu" # Access the Gosu library

# Create a class for your application
class WindowApp < Gosu::Window # Inherit from the Gosu Window Class
  
  # We use this method for initial set-up
  def initialize
    super 1024, 768 # Window width, height
    self.caption = "My Windowed Application" # Set a title for the window
  end

end

# Create an instance of your windowed application
WindowApp.new.show # The show method displays the window in the OS
