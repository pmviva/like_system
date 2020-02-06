require 'spec_helper'

###
# Shared examples for LikeSystem::Likee
###
shared_examples_for LikeSystem::Likee do
  ###
  # Let likee be DummyLikee.create
  ###
  let(:likee) { DummyLikee.create }

  ###
  # Let liker be DummyLiker.create
  ###
  let(:liker) { DummyLiker.create }

  ###
  # Describes associations
  ###
  describe "associations" do
    ###
    # Should have many likers
    ###
    it "should have many likers" do
      should have_many(:likers)
    end
  end

  ###
  # Describes class methods
  ###
  describe "class methods" do
    ###
    # Should be a likee
    ###
    it "should be a likee" do
      expect(likee.is_likee?).to equal(true)
    end

    ###
    # Should be liked by a liker
    ###
    it "should specify if is liked by a liker" do
      expect(LikeSystem::Like).to receive(:likes?).with(liker, likee) { true }

      expect(likee.liked_by?(liker)).to equal(true)
    end

    ###
    # Should scope likers filtered by liker type
    ###
    it "should scope likers filtered by liker type" do
      scope = LikeSystem::Like.scope_by_likee(likee).scope_by_liker_type(DummyLiker)

      expect(likee.likers_by(DummyLiker)).to eq(scope)
    end
  end
end

###
# Describes DummyLikee
###
describe DummyLikee, type: :model do
  ###
  # It behaves like LikeSystem::Likee
  ###
  it_behaves_like LikeSystem::Likee
end
