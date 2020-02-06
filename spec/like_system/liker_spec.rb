require 'spec_helper'

###
# Shared examples for LikeSystem::Liker
###
shared_examples_for LikeSystem::Liker do
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
    # Should have many likees
    ###
    it "should have many likees" do
      should have_many(:likees)
    end
  end

  ###
  # Describes class methods
  ###
  describe "class methods" do
    ###
    # Should be a liker
    ###
    it "should be a liker" do
      expect(liker.is_liker?).to equal(true)
    end

    ###
    # Should like a likee
    ###
    it "Should like a likee" do
      expect(LikeSystem::Like).to receive(:like).with(liker, likee) { true }

      expect(liker.like(likee)).to equal(true)
    end

    ###
    # Should unlike a likee
    ###
    it "Should unlike a likee" do
      expect(LikeSystem::Like).to receive(:unlike).with(liker, likee) { true }

      expect(liker.unlike(likee)).to equal(true)
    end

    ###
    # Should toggle like a likee
    ###
    it "Should toggle like a likee" do
      expect(LikeSystem::Like).to receive(:toggle_like).with(liker, likee) { true }

      expect(liker.toggle_like(likee)).to equal(true)
    end

    ###
    # Should like a likee
    ###
    it "should specify if likes a likee" do
      expect(LikeSystem::Like).to receive(:likes?).with(liker, likee) { true }

      expect(liker.likes?(likee)).to equal(true)
    end

    ###
    # Should scope likees filtered by likee type
    ###
    it "should scope likees filtered by likee type" do
      scope = LikeSystem::Like.scope_by_liker(liker).scope_by_likee_type(DummyLikee)

      expect(liker.likees_by(DummyLikee)).to eq(scope)
    end
  end
end

###
# Describes DummyLiker
###
describe DummyLiker, type: :model do
  ###
  # It behaves like LikeSystem::Liker
  ###
  it_behaves_like LikeSystem::Liker
end
