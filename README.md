# Lighthouse Labs | Multimedia in Ruby with Gosu

![LHL Instructor Warren Uhrich: Multimedia in Ruby w/Gosu](https://github.com/WarrenUhrich/lighthouse-labs-multimedia-in-ruby-with-gosu/blob/main/media/header.png?raw=true)

## Getting Started with Gosu

> **Gosu (고수)**: person at an expert skill level; someone who has achieved mastery of a skill. [*Korean in origin*.]

[Ruby](https://www.ruby-lang.org/en/), originally developed in 1995 by Matz of Japan, is a popular programmer-friendly interpreted scripting language.

Yes, that was a mouthful! If you haven't had the chance to give it a try, you may have heard of it—or its well-known web development framework: [Ruby on Rails](https://rubyonrails.org/).

While Ruby spiked in popularity with the introduction of its incredibly powerful and industry-changing Ruby on Rails solution in 2005, it is capable of a lot more than just web development.

You'll find, if you daily drive Linux or Macintosh, that many installation tools and command-line software uses Ruby for part, or all, of their processes. Okay, so it is great for desktop scripting and automation—what else?

I'm glad you asked! If Ruby stretches first, it is capable of running all sorts of marathons, some of which you may not expect! Today's focus? A [Ruby Gem](https://rubygems.org/) (library / package) called [Gosu](https://www.libgosu.org/ruby.html), that opens the doors to creating interactive multimedia software for your desktop computer.

What do I mean by interactive multimedia software? I mean programs capable of displaying graphics, playing sound, and accepting user input! Sound like a certain type of computer program you may have spent some time with before? This is the perfect recipe for GUI software or even video game development.

Today, let's keep it fun and focus on the latter, as that's Gosu's bread and butter.

## Installation Notes

Something to keep in mind is you may find that Gosu has not been optimized for all popular versions of Ruby. You may have mixed success trying to get it to run on `3.X` versions, for example. I recommend trying with either Ruby `1.9.X` or `2.5.X`, as these seem to be quite stable / compatible with Gosu at present.

There are detailed instructions available for an array of different operating systems, ensure you read up on the required dependencies and install them before trying to write Gosu code:

* [MacOS Instructions](https://github.com/gosu/gosu/wiki/Getting-Started-on-OS-X)
* [Linux Instructions](https://github.com/gosu/gosu/wiki/Getting-Started-on-Linux)
* [Windows Instructions](https://www.libgosu.org/ruby.html)

For more on getting started, [visit the official wiki](https://github.com/gosu/gosu/wiki/).

## First Steps in Gosu

So, you want to build a Gosu application or computer video game? Let's talk bare essentials. Once your Gosu gem is installed (`gem install gosu`) we can try rendering an application window. Create a file called `window.rb`:

```Ruby
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
```

To run your Ruby code, open your terminal, navigate to your project folder, and use the `ruby` terminal command to execute your program:

```bash
ruby window.rb # In this case, we want to run window.rb
```

Now we have a window rendering, complete with a title! Awesome.

## The Documentation

Why did we use the Window class, and what else is it capable of? Well, the [official documentation](https://www.rubydoc.info/gems/gosu/) has you covered! You'll find information on all of the important classes and methods available to you there.

Using [`Gosu::Window`](https://www.rubydoc.info/gems/gosu/Gosu/Window) as an example, you'll note that this class has awesome methods / features including:

* `caption`
* `resizable`
* `borderless`
* `fullscreen`
* `height`
* `width`
* `mouse_x`
* `mouse_y`
* `text_input`
* `update_interval`

Many of these are fairly self-explanatory in terms of function, but if the syntax necessary to utilize these features eludes you, the documentation has you covered! Explore, experiment, and see what happens.

## Adding a Background

With Gosu, we can easily utilize images in common formats or even text to render content in our window. Let's try a background image as an example! For imagery, we can utilize the [`Gosu::Image`](https://www.rubydoc.info/gems/gosu/Gosu/Image) class.

Note that any graphics you'd like to display to the user need to be included in a window's `draw` method. It is important to think about how most any game functions... via a loop of logic! What happens in that loop?

* Check if there is user input (keyboard press, mouse move, typing, etc.)
* Clear old graphics
* Draw any new / updated graphics (often graphics move, change, or disappear over time)

Consider this is happening (in Gosu's case) 60 times a second. Why so many times!? For motion to appear fluid to the human eye, we want around 30 visual updates (frames) per second. Much like we do with film, which is often 24-29 frames per second, moving something in small increments each frame will create the illusion of motion as we're used to in the real world.

The difference in games versus animation and games, is part of our steps are *dynamic*. What does that mean? We're able to use *input* to determine or generate specific *output*. If a user clicks on a button, we can use that to trigger certain logic in the game. For example, this could be a "quit" button, that closes the game when you're done. Or it could be checking to see if a player is pressing an arrow key, to know if a character graphic should be drawn a few pixels to the right in the next frame!

Okay... so each "frame", we need to tell Gosu what to draw. For a background, we won't have to worry about it moving around, so let's just focus on showing it in the desired size and position in our window during each frame.

Let's make a file, `background.rb`:

```Ruby
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
```

Look at that! A background image... our application is already that much more exciting. Experiment with the numbers and see if you can move the image around or size it to your liking.

## Text

Another common thing to draw in applications and games is text. Text can be used to communicate with the user or player, guiding them in how to navigate your app or play your game. In games, text is often used in menus, buttons, notifications, and display elements like "score" counters.

For text we can again make use of the `Gosu::Image` class, only this time we'll make use of its `from_text` method. This allows us to construct a rendered image from a phrase we supply it with. We'll want to pick an appropriate colour for our text as well, we want a colour that will stand out against our background. In this case, perhaps black would stand out nicely against the sky? Have a look at [`Gosu::Color`](https://www.rubydoc.info/gems/gosu/Gosu/Color)'s available default colours, and how you can set your own custom colours!

Let's welcome our user to our game. Create a new file, `text.rb`:

```Ruby
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
```

Okay, great! We're well on our way, here.

## User Input

How do we handle basic user input? Let's start with a basic keypress. Let's allow our game to be closed by pressing the `ESC` key. Create a new file, `escape.rb`:

```Ruby
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
```

Try running your program now. Instead of clicking the "Close" button on the window, or using `CTRL+C` in the terminal, try simply pressing the `ESC` key when your program window is in focus. Woah! There it goes... perfect. We've proven we're able to have our application react to a keypress!

## Clicking

Alright, that's keyboard out of the way. You can always check the `Gosu` [constants summary](https://www.rubydoc.info/gems/gosu/Gosu) for a list of all key and mouse button presses.

On the note of the mouse though... how might we track clicks, and where they are happening? Let's try to create a button that we can click on to quit the game. Create a file, `clicking.rb`:

```Ruby
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
```

Fantastic, we have that working! The tricky part here is taking the time to understand that everything you're placing in your window has co-ordinates. If we're careful about how we plot and calculate based on these co-ordinates, we can definitely find out if something like a mouse click is intersecting a space in our window.

## Moving a Graphic

Okay, so we can display text and images, and we can capture keypresses and mouse clicks. That's some good progress in such a short time! But... how about we ***kick it up a notch***: [*BAM!* Anyone get that reference?](https://www.youtube.com/watch?v=fifveIlcXlA)

If we want to have a player-controlled character that moves when we press buttons, we'll have to flex our OOP (Object-Oriented Programming) muscles a bit more. We'll want to create a class that we can use to hold onto basic things like the `x` and `y` position of this character, and control how these things are updated. Let's think about this:

* If we want our character to move to the **right**... *add* to `x`
* If we want our character to move to the **left**... *subtract* from `x`
* If we want our character to move **up**... *subtract* from `y`
* If we want our character to move **down**... *add* to `y`

Remember that our window follows an x and y co-ordinate system with an origin located in the *top left corner*.

```
           (-)
            ⋀
            |
            |
            |
(-) <-------0-------> (+)
            |
            |  [Visible
            |    Area]
            ⋁
           (+)
```

So, let's suppose we want to use the arrow keys, or the popular WASD set of keys, to move a graphic each of the four directions. Let's implement this feature! Create a file, `movement.js`:

```Ruby
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
```

Brilliant! Our Lighthouse graphic can be controlled via the "WASD" or arrow keys now. In can move in each of the four directions, one at a time. See if you can tweak the logic to allow diagonals!

## Putting it All Together

We have spent time covering a variety of the basics. With this knowledge, and a bit of experimenting with Ruby, we should have the pieces of the puzzle we need to work on a simple game.

Let's say we want collectibles (rubies) to fall from the sky, and our job as the player (lighthouse) is to catch'em. If we miss a ruby, we lose.

Create a new file, and lets give it a shot, `CollectionGame.rb`:

```Ruby
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
```
