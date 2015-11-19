###
# LikeSystem module
#
# This module defines common behavior in like system
###
module LikeSystem
  ###
  # Likee module
  #
  # This module defines likee behavior in like system
  ###
  module Likee
    ###
    # Extends ActiveSupport::Concern
    ###
    extend ActiveSupport::Concern

    ###
    # Included configuration
    ###
    included do
      ###
      # Has many likers association configuration
      ###
      has_many :likers, class_name: "LikeSystem::Like", as: :likee, dependent: :destroy
    end

    ###
    # Specifies if self can be liked by {Liker} objects
    #
    # @return [Boolean]
    ###
    def is_likee?
      true
    end

    ###
    # Specifies if self is liked by a {Liker} object
    #
    # @param [Liker] liker - the {Liker} object to test against
    # @return [Boolean]
    ###
    def liked_by?(liker)
      Like.likes?(liker, self)
    end

    ###
    # Retrieves a scope of {Like} objects that likes self filtered {Liker} type
    #
    # @param [Class] klass - the {Class} to filter
    # @return [ActiveRecord::Relation]
    ###
    def likers_by(klass)
      Like.scope_by_likee(self).scope_by_liker_type(klass)
    end
  end
end

