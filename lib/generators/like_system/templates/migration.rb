###
# CreateLikes class
#
# This class defines the create likes migration in like system
###
class CreateLikes < ActiveRecord::Migration
  ###
  # Changes the database
  ###
  def change
    ###
    # Likes table creation
    ###
    create_table :likes do |t|
      ###
      # Likee id field and likee type field definition
      ###
      t.references :likee, polymorphic: true

      ###
      # Liker id fiel and liker type field definition
      ###
      t.references :liker, polymorphic: true

      ###
      # Timestamps fields definition
      ###
      t.timestamps null: false
    end

    ###
    # Likes table likee id field and likee type field index addition
    ###
    add_index :likes, [:likee_id, :likee_type], name: "likes_likee_idx"

    ###
    # Likes table liker id field and liker type field index addition
    ###
    add_index :likes, [:liker_id, :liker_type], name: "likes_liker_idx"

    ###
    # Likes table likee id field and likee type field and liker id field and liker type field unique index addition
    ###
    add_index :likes, [:likee_id, :likee_type, :liker_id, :liker_type], name: "likes_likee_liker_idx", unique: true
  end
end

