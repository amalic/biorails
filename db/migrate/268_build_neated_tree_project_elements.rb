class BuildNeatedTreeProjectElements < ActiveRecord::Migration
  def self.up
    ProjectElement.rebuild__sets # Hides a lots of work to rebuild balanced neated set for whole table.
  end

  def self.down
  end
  

  
end
