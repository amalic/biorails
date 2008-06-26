# == Schema Information
# Schema version: 306
#
# Table name: roles
#
#  id                 :integer(11)   not null, primary key
#  name               :string(255)   default(), not null
#  parent_id          :integer(11)   
#  description        :string(1024)  default(), not null
#  cache              :string(4000)  default()
#  created_at         :datetime      not null
#  updated_at         :datetime      not null
#  created_by_user_id :integer(11)   default(1), not null
#  updated_by_user_id :integer(11)   default(1), not null
#  type               :string(255)   
#


##
# Copyright © 2006 Robert Shell, Alces Ltd All Rights Reserved
# See license agreement for additional rights
# 



class UserRole < Role

  def self.subjects
    Permission.subjects(:current_user)
  end

end
