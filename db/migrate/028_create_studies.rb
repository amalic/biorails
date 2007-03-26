##
# Copyright © 2006 Robert Shell, Alces Ltd All Rights Reserved
# See license agreement for additional rights
##

class CreateStudies < ActiveRecord::Migration
  def self.up
    create_table :studies, :force => true do |t|
      t.column "name", :string, :limit => 128, :default => "", :null => false
      t.column "description", :text
      t.column "category_id", :integer
      t.column "research_area", :string
      t.column "purpose", :string
      t.column "lock_version", :integer, :default => 0, :null => false
      t.column "created_by", :string, :limit => 32, :default => "", :null => false
      t.column "created_at", :datetime, :null => false
      t.column "updated_by", :string, :limit => 32, :default => "", :null => false
      t.column "updated_at", :datetime, :null => false
    end
  end

  def self.down
    drop_table :studies
  end
end
