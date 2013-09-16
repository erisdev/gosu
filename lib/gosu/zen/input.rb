require 'forwardable'

module Gosu
  module Zen
    ##
    # This module provides helper functions for querying buttons and the mouse pointer.
    # 
    # @see Gosu::Zen.button_down
    # @see Gosu::Zen.button_up
    # @see Gosu::Window
    module Input
      extend Forwardable
      
      ##
      # Returns whether the button `id` is currently pressed. Button states are updated once per tick, so repeated calls during the same tick will always yield the same result.
      # 
      # @return (see Gosu::Window#button_down?)
      # @param id [Gosu::Zen::Button] the button to test.
      # 
      # @see Gosu::Window#button_down?
      # @see Gosu::Zen.button_down
      # @see Gosu::Zen.button_up
      def button_down? id
        $zen_window.button_down? Button[what].id
      end
      
      ##
      # @!method mouse_x
      #   (see Gosu::Window#mouse_x)
      #   @see Gosu::Window#mouse_x
      def_delegator :$zen_window, :mouse_x
      
      ##
      # @!method mouse_x=
      #   (see Gosu::Window#mouse_x=)
      #   @see Gosu::Window#mouse_x=
      def_delegator :$zen_window, :mouse_x=
      
      ##
      # @!method mouse_y
      #   (see Gosu::Window#mouse_y)
      #   @see Gosu::Window#mouse_y
      def_delegator :$zen_window, :mouse_y
      
      ##
      # @!method mouse_y=
      #   (see Gosu::Window#mouse_y=)
      #   @see Gosu::Window#mouse_y=
      def_delegator :$zen_window, :mouse_y=
      
    end
  end
end
