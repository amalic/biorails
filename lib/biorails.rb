# 
# biorails.rb
# 
# Created on 23-Aug-2007, 20:16:48
# 
# To change this template, choose Tools | Templates
# and open the template in the editor.
 

module Biorails

  TEMPLATE_MODELS = [UserRole,ProjectRole,User,Identifier,Permission,RolePermission,
    DataContext,DataConcept,DataSystem,
    ListElement,ModelElement,SqlElement,ViewElement,DataType,
    DataFormat,ParameterType,ParameterRole,StudyStage,
    Project,Team,Membership,
    Study,StudyParameter,StudyQueue,StudyProtocol,
    ProtocolVersion,ParameterContext,Parameter]

  PROJECT_MODELS = [Project,ProjectElement,Asset,Content,DbFile]

  RESULTS_MODELS = [Experiment,Task,TaskContext,TaskValue,TaskText,TaskReference]

  CATALOG_MODELS = [DataContext,DataConcept,DataSystem,
        ListElement,ModelElement,SqlElement,ViewElement,
        DataType,DataFormat,ParameterType,ParameterRole,StudyStage]

  ALL_MODELS = [UserRole,ProjectRole,User,Identifier,Permission,RolePermission,
    UserSetting,SystemSetting,
    DataContext,DataConcept,DataSystem,
    ListElement,ModelElement,SqlElement,ViewElement,    
    DataType,DataFormat,
    ParameterType,ParameterRole,StudyStage,
    Compound,Batch,Plate,Container,PlateFormat,PlateWell,
    Specimen,TreatmentGroup,TreatmentItem,
    Project,Team,Membership,
    ProjectElement,Asset,Content,DbFile,
    Study,StudyParameter,StudyQueue,StudyProtocol,StudyStage,
    ProtocolVersion,ParameterContext,Parameter,
    Request,RequestService,QueueItem,
    List,ListItem,
    Report,ReportColumn,
    Experiment,Task,TaskContext,TaskValue,TaskText,TaskReference]
  
  module Type
    TEXT =1
    NUMERIC = 2
    DATE = 3
    TIME = 4
    DICTIONARY = 5
    URL =6
    ASSET = 7
  end
     
  
  module Record
#
#  Define rules to link to actual database records for ROLES
# 
    DEFAULT_OWNER_ROLE = 5
    DEFAULT_PROJECT_ROLE = 2

    DEFAULT_PROJECT_ID = 1
    DEFAULT_TEAM_ID = 1
    DEFAULT_GUEST_USER_ID = 1
  end
##
# Get a List of all the Models
#   
  
  class Dba
      #SET LOG LEVEL TO DEBUG TO SEE ANY FIXTURE LOAD ERRORS
      @@logger=Logger.new(STDOUT)
      @@logger.level=Logger::WARN
      
      def self.logger
        return @@logger
      end

      def self.models
        unless @@models
          for file in Dir.glob("#{RAILS_ROOT}/app/models/*.rb") do
            begin
              load file
            rescue
              self.logger.info "Couldn't load file '#{file}' (already loaded?)"
            end
          end  
        end
        @@models = []

        ObjectSpace.each_object(Class) do |klass|
          if klass.ancestors.any?{|item|item==ActiveRecord::Base} and !klass.abstract_class
            @@models << klass unless @@models.any?{|item|item.to_s == klass.to_s}
          end
        end

        @@models -= [ActiveRecord::Base, CGI::Session::ActiveRecordStore::Session]
        return @@models.sort{|a,b| a.to_s <=> b.to_s }

      rescue Exception => ex
        self.logger.error "Failed to find models #{ex.message}"
        return []
      end
  
      def self.retrieve_db_info
        result = File.read "#{RAILS_ROOT}/config/database.yml"
        result.strip!
        config_file = YAML::load(ERB.new(result).result)
        return [  config_file[RAILS_ENV]['database'],
                  config_file[RAILS_ENV]['username'],
                  config_file[RAILS_ENV]['password']  ]
      end

      def self.mysql_execute(username, password, sql)
        system("/usr/bin/env mysql -u #{username} -p'#{password}' --execute=\"#{sql}\"")
      end

      def self.oracle_execute(username, password, sql)
        system("/usr/bin/env sqlplus #{username}/#{password}@#{database} #{sql}")
      end

      def self.backup_db(database, user, password)
          datestamp = Time.now.strftime("%Y-%m-%d_%H-%M-%S")  
          base_path = ENV["DIR"] || "db" 
          backup_folder = File.join(base_path, 'backup')
          File.makedirs(backup_folder)
          backup_file = File.join(backup_folder, "#{RAILS_ENV}_#{datestamp}_dump") 
          
          case database
          when 'oracle','oci8'
            puts "Using oracle export utility for backup"
            cmd = "/usr/bin/env exp #{username}/#{password}@#{database} file=#{backup_file}.dmp "
            puts cmd 
            system(cmd)
          when 'mysql'
            puts "Using mysql dump utility for backup"
            cmd = "/usr/bin/env mysqldump --opt --skip-add-locks -u#{user} "
            puts cmd + "... [password filtered]"
            cmd += " -p'#{password}' " unless password.nil?
            cmd += " #{database} | gzip -c > #{backup_file}"
            system(cmd)
          else
            self.logger.info "Using default fixtures for backup"
            Biorails::ALL_MODELS.each do |model| 
               filename = File.join(backup_folder,model.table_name + '.yml')
               export_model_fixture(model,filename)
            end 
          end
      end

      def self.export_model(model,filename=nil)

        filename ||= File.join(RAILS_ROOT,'test','fixtures',model.to_s.tableize + '.yml')
        File.open(filename, 'w' ) do |file|
          data = model.find(:all,:order => :id)
          file.write data.inject({}) { |hash, record|
            hash["%011d_#{record.class.name.underscore}" % record.id] = record
            hash
          }.to_yaml
        end
        self.logger.debug "Writen #{model.count} #{model.to_s} records exported to #{filename}"
      end
      
      def self.import_model(item,filename=nil)
        model = item
        if item.is_a? Symbol
          model = eval(item.to_s.singularize.camelcase)  
        end 
        filename ||= File.join(RAILS_ROOT,'test','fixtures',model.to_s.tableize + '.yml')
        success =0
        records = YAML::load( File.open(filename))
        model.transaction do
          records.keys.sort.each do |key|
            begin
              row = records[key]
              if row.is_a?(Hash)
                @new_item = model.new(row)
                @new_item.id = row['id']
              else # is mapped to model object
                @new_item = row.class.new(row.attributes)
                @new_item.id = row.id
              end
              #check for duplicates and move on silently if already loaded
              begin
                break if model.find(@new_item.id) 
              rescue ActiveRecord::RecordNotFound
              end
              if @new_item.save
                 success =  success + 1
	          else
	             self.logger.warn "No Valid [#{row.class}.#{row.id}] #{@new_item.errors.full_messages().to_sentence} "
              end
            rescue Exception => ex
               self.logger.error( "Error for  #{ex.message} ") 
            end
          end
          self.logger.debug "Total #{success} out of #{records.size} #{model.to_s} records imported from #{filename}"
        end
     end
  end 

  module Version
    MAJOR  = 2
    MINOR  = 1
    TINY   = 0
    STRING = [MAJOR, MINOR, TINY].join('.').freeze
    TITLE  = "Biorails".freeze
  end
      
end
