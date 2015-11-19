require 'like_system/like'
require 'like_system/likee'
require 'like_system/liker'

###
# LikeSystem module
#
# This module defines common behavior in like system
###
module LikeSystem
  ###
  # Specifies if self can be liked by {Liker} objects
  #
  # @return [Boolean]
  ###
  def is_likee?
    false
  end

  ###
  # Specifies if self can like {Likee} objects
  #
  # @return [Boolean]
  ###
  def is_liker?
    false
  end

  ###
  # Instructs self to act as likee
  ###
  def act_as_likee
    include Likee
  end

  ###
  # Instructs self to act as liker
  ###
  def act_as_liker
    include Liker
  end
end

ActiveRecord::Base.extend LikeSystem

