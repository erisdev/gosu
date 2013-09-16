require 'gosu'

require_relative 'zen/button'
require_relative 'zen/drawing'
require_relative 'zen/input'
require_relative 'zen/window'

module Gosu
  ##
  # Gosu with more zen.
  module Zen
    
    # @private
    class Game
      include Drawing
      include Input
      
      def on_setup; end
      def on_teardown; end
      def on_button_down_any(button); end
      def on_button_up_any(button); end
      def on_update; end
      def on_draw; end
    end
    
    $zen_game = Game.new
    $zen_window = nil
    
    module_function
    
    # @!group Gosu Zen DSL
    
    ##
    # (see Gosu::Window#initialize)
    # 
    # @note This method MUST NOT be called more than once.
    # 
    # @return [void]
    # @param caption [String] the window's caption, usually displayed in the title bar.
    # @param needs_cursor [true, false] whether the system cursor should be shown.
    # 
    # @see Gosu::Window
    # @see Gosu::Window#needs_cursor?
    def window width, height, fullscreen:false, update_interval:16.666666, caption:'', needs_cursor:false
      if $zen_window.nil?
        $zen_window = ZenWindow.new width, height, fullscreen, update_interval
        $zen_window.caption = caption
        $zen_window.needs_cursor = needs_cursor
      else
        raise RuntimeError, "a window has already been created"
      end
    end
    
    ##
    # Sets up asset loading. Calling this method will extend your game context with the asset loading helpers.
    # 
    # @return [void]
    # @param root_path [String] the base path to search for all assets.
    # 
    # @see Gosu::Zen::Assets
    def assets root_path
      require_relative 'zen/assets'
      $zen_game.extend Assets
      $zen_game.initialize_assets root_path
    end
    
    ##
    # Defines a setup routine that runs in your game context when the window is created.
    # 
    # @return [void]
    # @yield the method body.
    def setup &body
      $zen_game.define_singleton_method :on_setup, &body
    end
    
    ##
    # Defines a teardown routine that runs in your game context when the window is closed.
    # 
    # @return [void]
    # @yield the method body.
    def teardown &body
      $zen_game.define_singleton_method :on_teardown, &body
    end
    
    ##
    # Defines a callback that will be called before the update callback if the button identified by `id` was pressed while the window had focus.
    # 
    # If `id` is `nil`, then the callback will receive _all_ button presses, even those specifically handled by other callbacks.
    # 
    # @return [void]
    # @param id [Symbol, Fixnum] the button id, or a symbol that names the button.
    # @yield the method body.
    # @yieldparam button [Gosu::Zen::Button] the button that was pressed.
    # 
    # @see Gosu::Zen::Button
    # @see Gosu::Zen::Input
    # @see Gosu::Window#button_down
    def button_down id = nil, &body
      m = id ? Button[id].down_method : :on_button_down_any
      $zen_game.define_singleton_method m, &body
    end
    
    ##
    # Defines a callback that will be called before the {#update} callback if the button identified by `id` was released while the window had focus.
    # 
    # If `id` is `nil`, then the callback will receive _all_ button releases, even those specifically handled by other callbacks.
    # 
    # @return [void]
    # @param id [Symbol, Fixnum] the button id, or a symbol that names the button.
    # @yield the method body.
    # @yieldparam button [Gosu::Zen::Button] the button that was released.
    # 
    # @see Gosu::Zen::Button
    # @see Gosu::Zen::Input
    # @see Gosu::Window#button_up
    def button_up id = nil, &body
      m = id ? Button[id].up_method : :on_button_up_any
      $zen_game.define_singleton_method m, &body
    end
    
    ##
    # Defines a callback that will be called once every `update_interval` milliseconds while the window is being shown. Your application's main logic should go here.
    # 
    # @return [void]
    # @yield the method body.
    # 
    # @see Gosu::Window#update
    def update &body
      $zen_game.define_singleton_method :on_update, &body
    end
    
    ##
    # Defines a callback that will be called after every update and whenever the OS wants the window to repaint itself. Your application's rendering code should go here.
    # 
    # @return [void]
    # @yield the method body.
    # 
    # @see Gosu::Zen::Drawing
    # @see Gosu::Window#draw
    def draw &body
      $zen_game.define_singleton_method :on_draw, &body
    end
    
    ##
    # Allows you to define helper methods that can be accessed from within the game loop. Imagine this as a class body.
    # 
    # @yield method definitions.
    def helpers &body
      $zen_game.instance_exec body
    end
    
    # @!endgroup
    
    private
    
    def run!
      window 800, 600 unless $zen_window
      $zen_window.show
    end
    
    def Zen.included mod
      at_exit { run! unless $! }
    end
    
  end
end
