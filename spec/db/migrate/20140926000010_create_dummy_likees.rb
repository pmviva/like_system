###
# CreateDummyLikees class
#
# This class defines the create dummy likees migration in like system
###
class CreateDummyLikees < ActiveRecord::Migration[5.0]
  ###
  # Changes the database
  ###
  def change
    ###
    # Dummy likees table creation
    ###
    create_table :dummy_likees do |t|
      ###
      # Timestamps fields definition
      ###
      t.timestamps null: false
    end
  end
end
