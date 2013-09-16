module Gosu
  # @private
  class ZenWindow < Window
    attr_accessor :game
    attr_writer :needs_cursor
    
    def initialize *args
      super *args
      @needs_cursor = true
    end
    
    def needs_cursor?
      !!@needs_cursor
    end
    
    def show
      @phase = :setup
      super
      @phase = :teardown
      $zen_game.on_teardown
    end
    
    def close
      super
      @phase = :teardown
    end
    
    def button_down id
      button = Zen::Button[id]
      m = button.down_method
      $zen_game.send(m, button) if $zen_game.respond_to?(m)
      $zen_game.on_button_down_any button
    rescue
      puts id
      raise
    end
    
    def button_up id
      button = Zen::Button[id]
      m = button.up_method
      $zen_game.send(m, button) if $zen_game.respond_to?(m)
      $zen_game.on_button_up_any button
    end
    
    def update
      case @phase
      when :setup
        $zen_game.on_setup
        @phase = :update
        $zen_game.on_update
      when :update
        $zen_game.on_update
      end
    end
    
    def draw
      $zen_game.on_draw
    end
    
  end
end
