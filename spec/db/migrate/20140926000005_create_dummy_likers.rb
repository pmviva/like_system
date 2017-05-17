###
# CreateDummyLikers class
#
# This class defines the create dummy likers migration in like system
###
class CreateDummyLikers < ActiveRecord::Migration[5.0]
  ###
  # Changes the database
  ###
  def change
    ###
    # Dummy likers table creation
    ###
    create_table :dummy_likers do |t|
      ###
      # Timestamps fields definition
      ###
      t.timestamps null: false
    end
  end
end

