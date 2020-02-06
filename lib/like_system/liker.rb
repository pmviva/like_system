###
# LikeSystem module
#
# This module defines common behavior in like system
###
module LikeSystem
  ###
  # Liker module
  #
  # This module defines liker behavior in like system
  ###
  module Liker
    ###
    # Extends ActiveSupport::Concern
    ###
    extend ActiveSupport::Concern

    ###
    # Included configuration
    ###
    included do
      ###
      # Has many likees association configuration
      ###
      has_many :likees, class_name: "LikeSystem::Like", as: :liker, dependent: :destroy
    end

    ###
    # Specifies if self can like {Likee} objects
    #
    # @return [Boolean]
    ###
    def is_liker?
      true
    end

    ###
    # Creates a {Like} relationship between self and a {Likee} object
    #
    # @param [Likee] likee - the likee of the {Like} relationship
    # @return [Boolean]
    ###
    def like(likee)
      Like.like(self, likee)
    end

    ###
    # Destroys a {Like} relationship between self and a {Likee} object
    #
    # @param [Likee] likee - the likee of the {Like} relationship
    # @return [Boolean]
    ###
    def unlike(likee)
      Like.unlike(self, likee)
    end

    ###
    # Toggles a {Like} relationship between self and a {Likee} object
    #
    # @param [Likee] likee - the likee of the {Like} relationship
    # @return [Boolean]
    ###
    def toggle_like(likee)
      Like.toggle_like(self, likee)
    end

    ###
    # Specifies if self likes a {Liker} object
    #
    # @param [Likee] likee - the {Likee} object to test against
    # @return [Boolean]
    ###
    def likes?(likee)
      Like.likes?(self, likee)
    end

    ###
    # Retrieves a scope of {Like} objects that are liked by self
    #
    # @param [Class] klass - the {Class} to include
    # @return [ActiveRecord::Relation]
    ###
    def likees_by(klass)
      Like.scope_by_liker(self).scope_by_likee_type(klass)
    end
  end
end
