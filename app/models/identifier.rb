# == Schema Information
# Schema version: 306
#
# Table name: identifiers
#
#  id                 :integer(11)   not null, primary key
#  name               :string(255)   
#  prefix             :string(255)   
#  postfix            :string(255)   
#  mask               :string(255)   
#  current_counter    :integer(11)   default(0)
#  current_step       :integer(11)   default(1)
#  lock_version       :integer(11)   default(0), not null
#  created_at         :datetime      not null
#  updated_at         :datetime      not null
#  updated_by_user_id :integer(11)   default(1), not null
#  created_by_user_id :integer(11)   default(1), not null
#

##
# This is a simple table based identifier generator to filling in the name field for 
# new records. If is based on lookup on the model/name passed.
# Identifiers are based on three elements prefix,sequence and postfix
#  <prefix><sequence><postfix>
#  
class Identifier < ActiveRecord::Base

  def project
    Project.current
  end
    
  def team
    Team.current
  end
    
  def user
    User.current
  end
    
  def Identifier.need_to_define(record,name)
      return false unless record.attributes.include?(name.to_s)
      record.send(name).blank?
  rescue
      return false      
  end
##
# Generate a name based on the current record
# 
  def set_name(record)
    if Identifier.need_to_define(record,'name')
       record.name =  next_id
       logger.debug("generate name #{record.name}")
    end 
  end
#
# generate a description
#
  def set_description(record)
    if Identifier.need_to_define(record,:description)
      record.description = "#{record.class} #{record.name} created by #{User.current.name} for team #{Team.current.name}"
       logger.debug("generate description #{record.description}")
    end
  end
  
  def next_id
     self.current_counter = self.current_counter + self.current_step
     if self.mask.blank?
       key =  "#{self.prefix}#{self.current_counter}#{self.postfix}"
     else
       key =  instance_eval(self.mask)  
     end
     self.save
     return key
  end
##
# Generate a name for a model class
#   
  def self.next_id(model)
     Identifier.transaction do
       generator = Identifier.find_by_name(model.to_s)
       unless generator
           generator = Identifier.new
           generator.name = model.to_s
           generator.prefix = "#{model}-"
           generator.postfix = ""
           generator.save
       end
       return generator.next_id
     end
  end
  
  #
  # Fill name,description,project and team records of a record
  #
  def self.fill_defaults(record)
     generator = Identifier.find_by_name(record.class.to_s)
     if generator
       logger.debug("generate defaults for #{record.class}")
       generator.set_name(record)    
       generator.set_description(record)
     end
     record.team     = Team.current if Identifier.need_to_define(record,:team)
     record.project  = Project.current if Identifier.need_to_define(record,:project)
  end
##
# Next user specfic reference
#
  def self.next_user_ref
     self.next_id(User.current.login)
  end
end
