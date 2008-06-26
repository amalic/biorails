# 
# To change this template, choose Tools | Templates
# and open the template in the editor.
 

class ExperimentDrop < BaseDrop
 #
 # Special base handling for timestamps
 #
 timezone_dates :created_at, :updated_at
 #
 # Extra non attribute methods called
 #
 extra_attributes << :project << :process << :tasks << :statistics << :assay
 
 def initialize(source,options={})
   super source
   @options  = options
 end
 
 def project
   liquify(@source.project) 
 end


 def process
   liquify(@source.process) 
 end
 
 def assay
   liquify(@source.assay) 
 end
 
 def started
   @source.started_at.strftime("%Y:%m:%d")
 end
 
 def finished
   @source.finished_at.strftime("%Y:%m:%d")
 end
 
 def expected
   @source.expected_at.strftime("%Y:%m:%d")
 end
 
 
 def tasks
   liquify(@source.tasks)    
 end
 
 def statistics
   liquify(@source.stats)    
 end
 
 protected

end
