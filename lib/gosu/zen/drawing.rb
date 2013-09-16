require 'forwardable'
require 'gosu'

module Gosu
  module Zen
    ##
    # This module provides helper functions for drawing and manipulating the graphics context.
    # 
    # @see Gosu::Zen.draw
    # @see Gosu::Window
    module Drawing
      extend Forwardable
      
      ##
      # @!attribute [r] width
      #   (see Gosu::Window#width)
      #   @see Gosu::Window#width
      def_delegator :$zen_window, :width
      
      ##
      # @!attribute [r] height
      #   (see Gosu::Window#height)
      #   @see Gosu::Window#height
      def_delegator :$zen_window, :height
      
      ##
      # @!method clip_to
      #   (see Gosu::Window#clip_to)
      #   @see Gosu::Window#clip_to
      def_delegator :$zen_window, :clip_to
      
      ##
      # Draws a line.
      # 
      # @note (see Gosu::Window#draw_line)
      # 
      # @return [void]
      # @param x1 [Float] the X coordinate of the start point.
      # @param y1 [Float] the Y coordinate of the start point.
      # @param x2 [Float] the X coordinate of the end point.
      # @param y2 [Float] the Y coordinate of the end point.
      # @param z [Float] the Z-order.
      # @param mode [:default, :add, :multiply] the blending mode to use.
      # @param color [Gosu::Color] the default vertex color.
      # @param color1 [Gosu::Color] the color of the start point.
      # @param color2 [Gosu::Color] the color of the end point.
      # 
      # @see #draw_triangle
      # @see #draw_quad
      # @see #draw_rect
      # @see Gosu::Window#draw_line
      # @see file:reference/Blending_Modes.mdown Blending Modes
      # @see file:reference/Drawing_with_Colors.mdown Drawing with Colors
      # @see file:reference/Z-Ordering.mdown
      def draw_line x1, y1, x2, y2, z:0, mode:(:default), color:0xffffffff, color1:color, color2:color
        $zen_window.draw_line x1, y1, color1, x2, y2, color2, z, mode
      end
      
      ##
      # Draws a triangle.
      # 
      # @return [void]
      # @param x1 [Float] the X coordinate of the first vertex.
      # @param y1 [Float] the Y coordinate of the first vertex.
      # @param x2 [Float] the X coordinate of the second vertex.
      # @param y2 [Float] the Y coordinate of the second vertex.
      # @param x3 [Float] the X coordinate of the third vertex.
      # @param y3 [Float] the Y coordinate of the third vertex.
      # @param z [Float] the Z-order.
      # @param mode [:default, :add, :multiply] the blending mode to use.
      # @param color [Gosu::Color] the default vertex color.
      # @param color1 [Gosu::Color] the color of the first vertex.
      # @param color2 [Gosu::Color] the color of the second vertex.
      # @param color3 [Gosu::Color] the color of the third vertex.
      #
      # @see #draw_line
      # @see #draw_quad
      # @see #draw_rect
      # @see Gosu::Window#draw_triangle
      # @see file:reference/Blending_Modes.mdown Blending Modes
      # @see file:reference/Drawing_with_Colors.mdown Drawing with Colors
      # @see file:reference/Z-Ordering.mdown
      def draw_triangle x1, y1, x2, y2, x3, y3, z:0, mode:(:default), color:0xffffffff, color1:color, color2:color, color3:color
        $zen_window.draw_triangle\
          x1, y1, color1,
          x2, y2, color2,
          x3, y3, color3, z, mode
      end
      
      ##
      # Draws a quad (actually two triangles).
      # 
      # @return [void]
      # @param x1 [Float] the X coordinate of the first vertex.
      # @param y1 [Float] the Y coordinate of the first vertex.
      # @param x2 [Float] the X coordinate of the second vertex.
      # @param y2 [Float] the Y coordinate of the second vertex.
      # @param x3 [Float] the X coordinate of the third vertex.
      # @param y3 [Float] the Y coordinate of the third vertex.
      # @param x4 [Float] the X coordinate of the fourth vertex.
      # @param y4 [Float] the Y coordinate of the fourth vertex.
      # @param z [Float] the Z-order.
      # @param mode [:default, :add, :multiply] the blending mode to use.
      # @param color [Gosu::Color] the default vertex color.
      # @param color1 [Gosu::Color] the color of the first vertex.
      # @param color2 [Gosu::Color] the color of the second vertex.
      # @param color3 [Gosu::Color] the color of the third vertex.
      # @param color4 [Gosu::Color] the color of the fourth vertex.
      #
      # @see #draw_line
      # @see #draw_triangle
      # @see #draw_rect
      # @see Gosu::Window#draw_quad
      # @see file:reference/Blending_Modes.mdown Blending Modes
      # @see file:reference/Drawing_with_Colors.mdown Drawing with Colors
      # @see file:reference/Order_of_Corners.mdown Order of Corners
      # @see file:reference/Z-Ordering.mdown
      def draw_quad x1, y1, x2, y2, x3, y3, x4, y4, z:0, mode:(:default), color:0xffffffff, color1:color, color2:color, color3:color, color4:color
        $zen_window.draw_quad\
          x1, y1, color1,
          x2, y2, color2,
          x3, y3, color3,
          x4, y4, color4, z, mode
      end
      
      ##
      # Draws an axis-aligned rectangle.
      # 
      # @return [void]
      # @param left [Float] the X coordinate of the left edge.
      # @param top [Float] the Y coordinate of the top edge.
      # @param right [Float] the X coordinate of the right edge.
      # @param bottom [Float] the Y coordinate of the bottom edge.
      # @param z [Float] the Z-order.
      # @param mode [:default, :add, :multiply] the blending mode to use.
      # @param color [Gosu::Color] the default vertex color.
      # @param color1 [Gosu::Color] the color of the first vertex.
      # @param color2 [Gosu::Color] the color of the second vertex.
      # @param color3 [Gosu::Color] the color of the third vertex.
      # @param color4 [Gosu::Color] the color of the fourth vertex.
      # 
      # @see #draw_line
      # @see #draw_triangle
      # @see #draw_quad
      # @see file:reference/Blending_Modes.mdown Blending Modes
      # @see file:reference/Drawing_with_Colors.mdown Drawing with Colors
      # @see file:reference/Z-Ordering.mdown
      def draw_rect left, top, right, bottom, z:0, mode:(:default), color:0xffffffff, color1:color, color2:color, color3:color, color4:color
        $zen_window.draw_quad\
          left,  top,    color1,
          right, top,    color2,
          right, bottom, color3,
          left,  bottom, color4, z, mode
      end
      
      ##
      # @!method flush
      #   (see Gosu::Window#flush)
      #   @see Gosu::Window#flush
      def_delegator :$zen_window, :flush
      
      ##
      # @!method gl
      #   (see Gosu::Window#gl)
      #   @see Gosu::Window#gl
      def_delegator :$zen_window, :gl
      
      ##
      # @!method record
      #   (see Gosu::Window#record)
      #   @see Gosu::Window#record
      def_delegator :$zen_window, :record
      
      ##
      # @!method rotate
      #   (see Gosu::Window#rotate)
      #   @see Gosu::Window#rotate
      def_delegator :$zen_window, :rotate
      
      ##
      # @!method scale
      #   (see Gosu::Window#scale)
      #   @see Gosu::Window#scale
      def_delegator :$zen_window, :scale
      
      ##
      # @!method transform
      #   (see Gosu::Window#transform)
      #   @see Gosu::Window#transform
      def_delegator :$zen_window, :transform
      
      ##
      # @!method translate
      #   (see Gosu::Window#translate)
      #   @see Gosu::Window#translate
      def_delegator :$zen_window, :translate
    end
  end
end