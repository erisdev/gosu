require 'gosu'

module Gosu
  module Zen
    ##
    # Represents a button.
    # 
    # @see Gosu::Zen::Input
    # @see Gosu::Zen.button_down
    # @see Gosu::Zen.button_up
    class Button
      ##
      # @return [Fixnum] the button's platform-defined id number.
      attr_reader :id
      alias :to_i :id
      
      ##
      # @return [Symbol] the button's symbolic name.
      attr_reader :name
      alias :to_sym :name
      
      ##
      # @return [:gamepad, :keyboard, :mouse] the type of input device that the button belongs to.
      attr_reader :type
      
      # @private
      attr_reader :down_method
      
      # @private
      attr_reader :up_method
      
      @by_name = {}
      @by_id = {}
      
      # @!group Getting a button instance
      
      ##
      # @return [Gosu::Zen::Button?] the button named by `id`.
      # @param id [Symbol, Fixnum] the button's platform-defined ID number, or a symbolic name.
      def self.[] id
        case id
        when Button then id
        when Numeric then @by_id[id]
        when Symbol then @by_name[id]
        end
      end
      
      # @!endgroup
      
      # @private
      NAME_RX = %r(
        (?<= [[:alnum:]] ) (?= [[:upper:]] ) |
        (?<= [[:alpha:]] ) (?= \d )
      )x
      
      # @private
      def initialize const, id
        @id = id
        @name = const.to_s.gsub(NAME_RX, '_').downcase.to_sym
        
        @type = case const
        when /^Gp/ then :gamepad
        when /^Kb/ then :keyboard
        when /^Ms/ then :mouse
        end
        
        @down_method = :"on_button_down_#{@name}"
        @up_method = :"on_button_up_#{@name}"
      end
      
      ##
      # @return (see Gosu::Window#button_down?)
      def down?
        $zen_window.button_down? @id
      end
      
      ##
      # @return [String] a string representation of the button.
      def to_s
        @name.to_s
      end
      
      Gosu.constants.grep(/^(?:Gp|Kb|Ms)/).each do |const|
        button = Button.new const, Gosu.const_get(const)
        @by_name[button.name] = button
        @by_id[button.id] = button
      end
      
      class <<self
        private :new
      end
      
    end
  end
end
