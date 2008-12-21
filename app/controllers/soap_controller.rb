# ##
# Copyright � 2006 Robert Shell, Alces Ltd All Rights Reserved
# See license agreement for additional rights ##
##
# This is the Data Capture External API for import and export of task to other systems
# 
class SoapController < ApplicationController
  wsdl_service_name 'soap'
  web_service_api SoapApi
  web_service_scaffold :invoke

  layout 'printout'
  #
  # Simple test function to see it web service API is wrong
  #
  def version
    Biorails::Version::STRING
  end
  #
  # Login returning a session id (currently a little weaks as its the user record)
  # @param username
  # @param password
  #
  def login( username, password)
    user = User.authenticate(username,password)
    if user and user.enabled?
      logger.info "User #{username} successfully logged in"
      set_user(user) if session
      set_project(user.projects[0]) if session
    end
    return user.id.to_s
  rescue Exception => ex
    logger.error "failed to login: #{ex.message}"
    return nil
  end
  #
  # List of Data concepts
  #
  def data_concept_list(session_id)
    setup_session(session_id)
    DataConcept.find(:all)
  end
  #
  # List of data element lookup definitions
  #
  def data_element_list(session_id,data_concept_id=nil)
    setup_session(session_id)
    if data_concept_id and data_concept_id > 0
      list = DataElement.find(:all,:conditions=>['data_concept_id=?',data_concept_id])
    else
      list =  DataElement.find(:all)
    end
  end
  #
  # List of values listed to a data element lookup
  #
  def data_value_list(session_id,data_element_id,limit=1000)
    setup_session(session_id)
    element =DataElement.find( data_element_id )
    element.like("",limit,0)
  end
  #
  # Get a list of matching choices for a data Element for a client lookup
  #
  def data_value_like(session_id,data_element_id,matches="")
    setup_session(session_id)
    element =DataElement.find( data_element_id )
    element.like(matches)
  end
  #
  # Get a list of matching choices for a data Element for a client lookup
  #
  def data_value_in_context_like(session_id,project_id,data_element_id,matches="",task_context_id=0)
    setup_session(session_id,project_id)
    TaskContext.current = TaskContext.find(task_context_id) if task_context_id and task_context_id > 0
    element =DataElement.find( data_element_id )
    element.like(matches)
    TaskContext.current = nil
  end
  #
  # List of of projects for the current user
  # 
  # @return [Project]
  # 
  def project_list(session_id)
    setup_session(session_id)
    Project.list(:all)
  end
  #
  # project details
  #
  def project(session_id,project_id)
    setup_session(session_id)
    Project.load(project_id)
  end
  #
  # Add a Project to the system
  #
  def project_create(session_id,name,description,project_type_id)
    setup_session(session_id)
    item = User.current.create_project(:name=>name,:title=>name,  :description=>description,     :project_type_id=>project_type_id)
    item.save
    return_status(item)    
  end
  #
  # List of all project elements in order parent_id,name for
  # easy creation of a tree structure on client (Hash and fill)
  #
  # @return [ProjectElement] all project elements sorted in tree order
  #
  def project_element_list(session_id,project_element_id)
    setup_session(session_id,nil)
    if project_element_id and project_element_id>0
      ProjectElement.list(:all,:conditions=>['project_elements.parent_id=?',project_element_id],:order=>'project_elements.left_limit,project_elements.id')
    else
      ProjectElement.list(:all,:conditions=>['project_elements.parent_id is null'],:order=>'project_elements.left_limit,project_elements.id')
    end
  end

  def project_folder(session_id,project_element_id)
    setup_session(session_id,nil)
    ProjectElement.load(project_element_id)
  end
  #    
  # List of all assays in a project
  # 
  # @param 
  #
  # @return [Assay] array of assays in a project
  #
  def assay_list(session_id,project_id)
    setup_session(session_id,project_id)
    Project.current.assays
  end

  def assay(session_id,assay_id)
    setup_session(session_id)
    Assay.load(assay_id)
  end
  
  #    
  # List of all assays parameters
  #
  # @param 
  #
  # @return [AssayParameter] array of assay Parameter in a assay
  #
  def assay_parameter_list(session_id,assay_id)
    setup_session(session_id,nil)
    AssayParameter.list(:all,:conditions=>{:assay_id=>assay_id})
  end  
  ##
  # List all the Protocols in a assay
  #
  #  @return [AssayProtocol]
  #
  def assay_protocol_list(session_id,assay_id)
    setup_session(session_id,nil)
    AssayProtocol.find(:all,:conditions=>['assay_id=?',assay_id],:order=>'name')
  end

  ##
  # List all the Protocols(Single step processes only) in a assay
  #
  #  @return [AssayProtocol]
  #
  def assay_process_list(session_id,assay_id)
    setup_session(session_id,nil)
    AssayProcess.find(:all,:conditions=>['assay_id=?',assay_id],:order=>'name')
  end
  ##
  # List all the Protocols(Multstep step processes only) in a assay
  #
  #  @return [AssayProtocol]
  #
  def assay_workflow_list(session_id,assay_id)
    setup_session(session_id,nil)
    AssayWorkflow.find(:all,:conditions=>['assay_id=?',assay_id],:order=>'name')
  end
  #
  # List of releast processes
  #
  #
  def process_instance_list(session_id,project_id)
    setup_session(session_id,project_id)
    list = []
    Project.current.protocols.each do |item|
      if item.released and item.is_a?(AssayProcess)
        list << item.released
      end
    end
    list
  end

  ##
  # List all the processing
  #
  def process_flow_list(session_id,project_id)
    setup_session(session_id,project_id)
    list = []
    Project.current.protocols.each do |item|
      if item.released and item.is_a?(AssayWorkflow)
        list << item.released
      end
    end
    list
  end
  ##
  #get complete process
  #
  def process_flow(session_id,protocol_version_id)
    setup_session(session_id)
    ProcessFlow.load(protocol_version_id)
  end
  ##
  #get complete process
  #
  def process_instance(session_id, protocol_version_id)
    setup_session(session_id)
    ProcessInstance.load(protocol_version_id)
  end

  def data_import_definition_list(session_id)
    setup_session(session_id)
    DataImportDefinition.find(:all,:order=>'name')
  end

  def data_import_definition_save(session_id,data)
    setup_session(session_id)
    if data.id
      data_import_definition = DataImportDefinition.find(data.id)
    else
      data_import_definition = DataImportDefinition.new()
    end
    data_import_definition = data.to_rec(data_import_definition)
    data_import_definition.save
    return_status(data_import_definition) 
  end
  
  def experiment_list(session_id,project_id)
    setup_session(session_id)
    Experiment.list(:all,:conditions=>['experiments.project_id=?',project_id],:order=>'experiments.id')
  end

  def experiment_list(session_id,project_id)
    setup_session(session_id)
    Experiment.list(:all,:conditions=>['experiments.project_id=?',project_id],:order=>'experiments.id')
  end

  def experiment(session_id,experiment_id)
    setup_session(session_id)
    Experiment.load(experiment_id)
  end

  def task_list(session_id,experiment_id)
    setup_session(session_id)
    list = Task.list(:all,:conditions=>['tasks.experiment_id=?',experiment_id],:order=>'tasks.id')
    SoapApi::Task.from_list(list)
  end
    
  def task(session_id,task_id)
    setup_session(session_id)
    Task.load(task_id)
  end
    
  def request_list(session_id,project_id)
    setup_session(session_id)
    Request.list(:all,:conditions=>['requests.project_id=?',project_id],:order=>'requests.id')
  end

  def user_request(session_id,request_id)
    setup_session(session_id)
    Request.load(request_id)
  end
  #
  # Create a request
  #
  def request_create(session_id,project_id,data_element_id,name,description,expected_at)
    setup_session(session_id,project_id)
    Task.transaction do
      request = Request.create(
        :name => name,
        :data_element_id=>data_element_id,
        :description=>description,
        :expected_at=>expected_at,
        :project_id => project_id)
      request.save
      return_status(request)
    end
  end

  #
  # Add a queue to request
  #
  def request_add_queue(session_id,request_id,assay_queue_id)
    setup_session(session_id)
    request = Request.find(request_id)
    queue = AssayQueue.load(assay_queue_id)
    Task.transaction do
      item = request.add_service(queue)
      return_status(item)
    end
  end

  #
  # Addd a item to request
  #
  def request_add_item(session_id,request_id,name)
    setup_session(session_id)
    request = Request.load(request_id)
    Task.transaction do
      item = request.add_item(name)
      return_status(item)
    end
  end


  #
  # Add a Experiment
  #
  def experiment_create(session_id,project_id,protocol_version_id,name,description)
    setup_session(session_id,project_id)
    Experiment.transaction do
      experiment = Experiment.new( :name=>name, :description=>description)
      experiment.project = Project.current
      process = ProtocolVersion.find(protocol_version_id)
      experiment.process = process
      experiment.assay_id = process.protocol.assay_id
      experiment.save
      return_status(experiment)    
    end
  end

  ##
  # Export a task
  def task_export(session_id,task_id)
    setup_session(session_id)
    task = Task.load(task_id)
    return "" unless task
    task.to_csv
  end

  ##
  # Import a task
  def task_import(session_id,experiment_id,text_data)
    setup_session(session_id)
    Experiment.transaction do
      experiment = Experiment.load(experiment_id)
      raise("Experiment [#{experiment_id}] is not visible for user [#{User.current.login}]") unless experiment
      task = experiment.import_task(text_data)
      return_status(task)
    end
  end


  def task_create(session_id,experiment_id ,protocol_version_id,name,description)
    setup_session(session_id)
    Task.transaction do
      experiment = Experiment.find(experiment_id)
      task = experiment.add_task(:name => name,
        :description=>description,
        :experiment_id => experiment_id,
        :protocol_version_id =>protocol_version_id)
      task.save
      return_status(task)
    end
  end

  def task_row_create(session_id, task_id, parameter_context_id)
    setup_session(session_id)
    Task.transaction do
      task = Task.find(task_id)
      definition = ParameterContext.find(parameter_context_id)
      context =  task.add_context(definition)
      context.save
      return_status(context)    
    end
  end
  #
  # Create a filled results row
  #
  # @params parameter_context_id
  # @params values in order of column_no
  #
  def task_row_append(session_id, task_id,  parent_context_id,  parameter_context_id, names, values)
    setup_session(session_id)
    Task.transaction do
      parent = Task.find(task_id)
      parent = TaskContext.find(parent_context_id) if parent_context_id >0
      definition = ParameterContext.find(parameter_context_id);
      context    = parent.add_context(definition)
      context.save
      list =[]
      names.each_index do |i|
        item = context.item(names[i])
        item.value = values[i]
        item.save
        list << SoapApi::BiorailsTaskItem.create(item)
      end
      list
    end
  end

  def task_row_update(session_id, task_context_id,names,values)
    setup_session(session_id)
    Task.transaction do
      context = TaskContext.find(task_context_id)
      list =[]
      names.each_index do |i|
        item = context.item(names[i])
        item.value = values[i]
        item.save
        list << SoapApi::BiorailsTaskItem.create(item)
      end
      list
    end
  end
   

  #
  # get folder as html
  #
  protected

  def return_status(rec)
    item = SoapApi::BiorailsStatus.new
    if rec
      item.class_id = rec.id
      item.class_name = rec.class.to_s
      item.errors = rec.errors.full_messages
      if rec.valid?
        item.ok = true
      else
        item.ok = false
        item.messages ="record is not valid"
      end
    else
      item.ok = false
      item.messages ="record is null"
      item.errors = ["No records created"]
    end
    item
  end

  def setup_session(key,project_id=nil)
    User.current          = @current_user    = User.find_by_id(key)  
    raise("Failed session key [#{key}] is invalid") unless @current_user               
    if project_id
      Project.current = @current_project = @current_user.project(project_id)
      raise "No project [#{project_id}] visible for #{@current_user.login}" unless @current_project
    end
    return @current_user
  end


end
