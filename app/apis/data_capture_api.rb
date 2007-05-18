

##
# This is the basic data Capture API for Biorails to allow the discovery of task and they creation
# 
class DataCaptureApi < ActionWebService::API::Base 

  class TaskItem < ActionWebService::Struct
     member :id , :int
     member :task_id , :int
     member :parameter_id , :int
     member :parameter_context_id , :int
     member :task_context_id, :int
     member :column_no, :int
     member :row_no, :int
     member :value , :string    
  end
  
  class TextData < ActionWebService::Struct
   member :content , :string
  end
  
  class BinaryData < ActionWebService::Struct
   member :content , :base64
  end
  
  inflect_names false

    api_method  :version,
                :returns => [:string]

    api_method  :login,
                :expects => [ {:username => :string},{:password =>:string} ],
                :returns => [User]
                
    api_method  :project_list,
                :expects => [ {:session_id => :int} ],
                :returns => [[Project]]
 
    api_method  :project_element_list,
                :expects => [ {:project_id => :int} ],
                :returns => [[ProjectElement]]
 
    api_method  :experiment_list,
                :expects => [ {:study_id => :int} ],
                :returns => [[Experiment]]
 
    api_method  :protocol_list,
                :expects => [ {:study_id => :int}],
                :returns => [[StudyProtocol]]

    api_method  :process_list,
                :expects => [ {:protocol_id => :int} ],
                :returns => [[ProtocolVersion]]

    api_method  :parameter_context_list,
                :expects => [ {:process_id => :int} ],
                :returns => [[ParameterContext]]
 
    api_method  :parameter_list,
                :expects => [ {:process_id => :int} ],
                :returns => [[Parameter]]
 
    api_method  :study_list,
                :expects => [ {:project_id => :int} ],
                :returns => [[Study]]
    
    api_method  :task_list,
                :expects => [ {:experiment_id => :int} ],
                :returns => [[Task]]

    api_method  :task_context_list,
                :expects => [ {:task_id => :int}],
                :returns => [[TaskContext]]

    api_method  :task_value_list,
                :expects => [ {:task_id => :int}],
                :returns => [[TaskItem]]

    api_method :task_export,
               :expects => [{:task_id => :int}],
               :returns => [:string]

    api_method :task_import,
               :expects => [{:session_id => :int},{:experiment_id => :int},{:cvs => :string} ],
               :returns =>  [Task]
    
    api_method :get_project,
               :expects => [ {:project_id => :int} ],
               :returns =>  [Project]
    
    api_method :get_study,
               :expects => [ {:study_id => :int} ],
               :returns =>  [Study]

    api_method :get_study_protocol,
               :expects => [ {:study_protocol_id => :int} ],
               :returns =>  [Study]

    api_method :get_protocol_version,
               :expects => [ {:protocol_version_id => :int} ],
               :returns =>  [Study]

    api_method :get_experiment,
               :expects => [ {:experiment_id => :int} ],
               :returns =>  [Experiment]

    api_method :get_task,
               :expects => [ {:task_id => :int} ],
               :returns =>  [Task]

    api_method :get_asset,
               :expects => [ {:element_id => :int} ],
               :returns =>  [ProjectAsset]

    api_method :get_content,
               :expects => [ {:element_id => :int} ],
               :returns =>  [ProjectContent]


    api_method :add_task,
               :expects => [{:experiment_id => :int},{:process_id => :int},{:task_name => :string} ],
               :returns => [Task]
    
    api_method :add_task_context,
               :expects => [{:task_id => :int},{:parameter_context_id => :int},{:values => [:string]} ],
               :returns => [TaskContext]

    api_method :add_task_value,
               :expects => [{:task_context_id => :int},{:parameter_id => :int},{:values => [:string]} ],
               :returns => [TaskItem]

    api_method :set_asset,
               :expects => [ {:session_id => :int},{:folder_id => :int},{:title=>:string},{:filename=>:string},{:mime_type =>:string} , {:data =>:string} ],
               :returns =>  [ProjectElement]

    api_method :set_content,
               :expects => [ {:session_id => :int},{:folder_id => :int},{:title=>:string},{:name=>:string}, {:html =>:string} ],
               :returns =>  [ProjectElement]
         
end

