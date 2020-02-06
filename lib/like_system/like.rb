###
# LikeSystem module
#
# This module defines common behavior in like system
###
module LikeSystem
  ###
  # Like class
  #
  # This class defines the like model in like system
  ###
  class Like < ActiveRecord::Base
    ###
    # Belongs to likee association configuration
    ###
    belongs_to :likee, polymorphic: :true

    ###
    # Belongs to liker association configuration
    ###
    belongs_to :liker, polymorphic: :true

    ###
    # Creates a {Like} relationship between a {Liker} object and a {Likee} object
    #
    # @param [Liker] liker - the {Liker} of the relationship
    # @param [Likee] likee - the {Likee} of the relationship
    # @return [Boolean]
    ###
    def self.like(liker, likee)
      validate_likee(likee)
      validate_liker(liker)

      if likes?(liker, likee)
        false
      else
        like = scope_by_liker(liker).scope_by_likee(likee).build
        like.save
        true
      end
    end

    ###
    # Destroys a {Like} relationship between a {Liker} object and a {Likee} object
    #
    # @param [Liker] liker - the {Liker} of the relationship
    # @param [Likee] likee - the {Likee} of the relationship
    # @return [Boolean]
    ###
    def self.unlike(liker, likee)
      validate_likee(likee)
      validate_liker(liker)

      if likes?(liker, likee)
        like = scope_by_liker(liker).scope_by_likee(likee).take
        like.destroy
        true
      else
        false
      end
    end

    ###
    # Toggles a {Like} relationship between a {Liker} object and a {Likee} object
    #
    # @param [Liker] liker - the {Liker} of the relationship
    # @param [Likee] likee - the {Likee} of the relationship
    # @return [Boolean]
    ###
    def self.toggle_like(liker, likee)
      validate_likee(likee)
      validate_liker(liker)

      if likes?(liker, likee)
        unlike(liker, likee)
      else
        like(liker, likee)
      end
    end

    ###
    # Specifies if a {Liker} object likes a {Likee} object
    #
    # @param [Liker] liker - the {Liker} object to test against
    # @param [Likee] likee - the {Likee} object to test against
    # @return [Boolean]
    ###
    def self.likes?(liker, likee)
      validate_likee(likee)
      validate_liker(liker)

      scope_by_liker(liker).scope_by_likee(likee).exists?
    end

    ###
    # Retrieves a scope of {Like} objects filtered by a {Likee} object
    #
    # @param [Likee] likee - the {Likee} to filter
    # @return [ActiveRecord::Relation]
    ###
    def self.scope_by_likee(likee)
      where(likee: likee)
    end

    ###
    # Retrieves a scope of {Like} objects filtered by a {Likee} type
    #
    # @param [Class] klass - the {Class} to filter
    # @return [ActiveRecord::Relation]
    ###
    def self.scope_by_likee_type(klass)
      where(likee_type: klass.to_s.classify)
    end

    ###
    # Retrieves a scope of {Like} objects filtered by a {Liker} object
    #
    # @param [Liker] liker - the {Liker} to filter
    # @return [ActiveRecord::Relation]
    ###
    def self.scope_by_liker(liker)
      where(liker: liker)
    end

    ###
    # Retrieves a scope of {Like} objects filtered by a {Liker} type
    #
    # @param [Class] klass - the {Class} to filter
    # @return [ActiveRecord::Relation]
    ###
    def self.scope_by_liker_type(klass)
      where(liker_type: klass.to_s.classify)
    end

    private
      ###
      # Validates a likee object
      #
      # @raise [ArgumentError] if the likee object is invalid
      ###
      def self.validate_likee(likee)
        raise ArgumentError.new unless likee.respond_to?(:is_likee?) && likee.is_likee?
      end

      ###
      # Validates a liker object
      #
      # @raise [ArgumentError] if the liker object is invalid
      ###
      def self.validate_liker(liker)
        raise ArgumentError.new unless liker.respond_to?(:is_liker?) && liker.is_liker?
      end
  end
end
