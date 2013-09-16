require 'gosu'

module Gosu
  module Zen
    ##
    # This module handles loading assets (images, samples, songs) from a predetermined path.
    # 
    # @see Gosu::Zen.assets
    module Assets
      attr_reader :asset_root
      
      # @private
      def initialize_assets path
        @asset_root = File.expand_path path
      end
      
      ##
      # Converts `name` to an absolute path using {#asset_root} as the base.
      # 
      # @return [String] the absolute path to the asset.
      # @param name [String] the relative path.
      def asset_path name
        File.join(asset_root, name)
      end
      
      ##
      # Loads an image asset from the {#asset_root}.
      # 
      # @return [Gosu::Image] the image.
      # @param name [String] the relative path to the image.
      # @param tileable [true, false]
      # 
      # @see #tiles
      # @see Gosu::Image
      # @see file:reference/Tileability.mdown
      def image name, tileable:false
        Image.new $zen_window, asset_path(name), tileable
      end
      
      ##
      # Loads an image asset from the {#asset_root}, then divides the image into an array of equal-sized tiles.
      # 
      # @return [Array<Gosu::Image>] the array of tiles.
      # @param name [String] the relative path to the image.
      # @param tile_width [Fixnum] If positive, this is the width of the individual tiles; if negative, the image is divided into -tile_width columns.
      # @param tile_height [Fixnum] If positive, this is the height of the individual tiles; if negative, the image is divided into -tile_height rows.
      # @param tileable [true, false]
      # 
      # @see #image
      # @see Gosu::Image.load_tiles
      # @see Gosu::Image
      # @see file:reference/Tileability.mdown
      def tiles name, tile_width, tile_height, tileable:false
        Image.load_tiles $zen_window, asset_path(name), tile_width, tile_height, tileable
      end
      
      ##
      # Loads a sample asset from the {#asset_root}.
      # 
      # @return [Gosu::Sample] the sample.
      # @param name [String] the relative path to the sample.
      # 
      # @see Gosu::Sample
      def sample name
        Sample.new $zen_window, asset_path(name)
      end
      
      ##
      # Loads a song asset from the {#asset_root}.
      # 
      # @return [Gosu::Song] the song.
      # @param name [String] the relative path to the song.
      # 
      # @see Gosu::Song
      def song name
        Song.new $zen_window, asset_path(name)
      end
      
    end
  end
end
