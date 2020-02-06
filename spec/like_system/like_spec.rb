require 'spec_helper'

###
# Describes LikeSystem::Like
###
describe LikeSystem::Like, type: :model do
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
    # Should belong to likee
    ###
    it "should belong to likee" do
      should belong_to(:likee)
    end

    ###
    # Should belong to liker
    ###
    it "should belong to liker" do
      should belong_to(:liker)
    end
  end

  ###
  # Describes class methods
  ###
  describe "class methods" do
    ###
    # Should raise argument error on invalid likee when likes
    ###
    it "should raise argument error on invalid likee when likes" do
      expect { LikeSystem::Like.like(liker, liker) }.to raise_error ArgumentError
    end

    ###
    # Should raise argument error on invalid liker when likes
    ###
    it "should raise argument error on invalid liker when likes " do
      expect { LikeSystem::Like.like(likee, likee) }.to raise_error ArgumentError
    end

    ###
    # Should like
    ###
    it "should like" do
      expect(LikeSystem::Like.like(liker, likee)).to equal(true)
    end

    ###
    # Should not like
    ###
    it "should not like" do
      LikeSystem::Like.like(liker, likee)

      expect(LikeSystem::Like.like(liker, likee)).to equal(false)
    end

    ###
    # Should raise argument error on invalid likee when unlikes
    ###
    it "should raise argument error on invalid likee when unlikes" do
      expect { LikeSystem::Like.unlike(liker, liker) }.to raise_error ArgumentError
    end

    ###
    # Should raise argument error on invalid liker when unlikes
    ###
    it "should raise argument error on invalid liker when unlikes" do
      expect { LikeSystem::Like.unlike(likee, likee) }.to raise_error ArgumentError
    end

    ###
    # Should unlike
    ###
    it "should unlike" do
      LikeSystem::Like.like(liker, likee)

      expect(LikeSystem::Like.unlike(liker, likee)).to equal(true)
    end

    ###
    # Should not unlike
    ###
    it "should not unlike" do
      expect(LikeSystem::Like.unlike(liker, likee)).to equal(false)
    end

    ###
    # Should raise argument error on invalid likee when toggle like
    ###
    it "should raise argument error on invalid likee when toggle like" do
      expect { LikeSystem::Like.toggle_like(liker, liker) }.to raise_error ArgumentError
    end

    ###
    # Should raise argument error on invalid liker when toggle like
    ###
    it "should raise argument error on invalid liker when toggle like" do
      expect { LikeSystem::Like.toggle_like(likee, likee) }.to raise_error ArgumentError
    end

    ###
    # Should toggle like
    ###
    it "should toggle like" do
      expect(LikeSystem::Like.likes?(liker, likee)).to equal(false)

      LikeSystem::Like.toggle_like(liker, likee)

      expect(LikeSystem::Like.likes?(liker, likee)).to equal(true)

      LikeSystem::Like.toggle_like(liker, likee)

      expect(LikeSystem::Like.likes?(liker, likee)).to equal(false)
    end

    ###
    # Should specify if likes
    ###
    it "should specify if likes" do
      expect(LikeSystem::Like.likes?(liker, likee)).to equal(false)

      LikeSystem::Like.like(liker, likee)

      expect(LikeSystem::Like.likes?(liker, likee)).to equal(true)
    end

    ###
    # Should scope likes by likee
    ###
    it "should scope likes by likee" do
      scope = LikeSystem::Like.where(likee: likee)

      expect(LikeSystem::Like.scope_by_likee(likee)).to eq(scope)
    end

    ###
    # Should scope likes by likee type
    ####
    it "should scope likes by likee type" do
      scope = LikeSystem::Like.where(likee_type: "DummyLikee")

      expect(LikeSystem::Like.scope_by_likee_type("DummyLikee")).to eq(scope)
    end

    ###
    # Should scope likes by liker
    ###
    it "should scope likes by liker" do
      scope = LikeSystem::Like.where(liker: liker)

      expect(LikeSystem::Like.scope_by_liker(liker)).to eq(scope)
    end

    ###
    # Should scope likes by liker type
    ####
    it "should scope likes by liker type" do
      scope = LikeSystem::Like.where(liker_type: "DummyLiker")

      expect(LikeSystem::Like.scope_by_liker_type("DummyLiker")).to eq(scope)
    end
  end
end
