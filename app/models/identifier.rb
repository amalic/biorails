##
# This is a simple table based identifier generator to filling in the name field for 
# new records. If is based on lookup on the model/name passed.
# Identifiers are based on three elements prefix,sequence and postfix
#  <prefix><sequence><postfix>
#  
class Identifier < ActiveRecord::Base

##
# Generate a Id based on the current record
# 
  def next_id
     self.current_counter = self.current_counter + self.current_step
     my_id = "#{self.prefix}#{self.current_counter}#{self.postfix}"
     my_id = eval(self.mask)  if self.mask
     self.save
     return my_id
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

end
