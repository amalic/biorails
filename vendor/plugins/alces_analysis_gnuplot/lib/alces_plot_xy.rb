# AlcesAnalysisGnuplot
require("gnuplot")
#require("rbgsl")
#require("gsl/gnuplot")
    
module Alces
  module Processor
    #
    # Simple X,Y plot of data
    #
    class PlotXy     
       attr_accessor :task
       attr_accessor :dirname
       attr_accessor :config
       attr_accessor :matrix
    
       #
       # Setup should return a default close to working configuration for the plugin this is build of a AnalysisMethod definition with a collection
       # of associated AnalysisSetting object to allow customization of the analysis. These
       #
       # Settings options
       #
       #   :name => name of the setting to display in application
       #
       #   :data_type_id => Type of data these setting needs to be linked to see DataType constants for values
       #
       #   :mode =>    1 input
       #               2 output
       #               3 both
       #
       #   :column_no => which column in protocol to read from
       #
       #   :default_value => default value
       #
       #   :options => Array of allowed options for the value
       #
       #   :mandatory => is needed to work
       #
       #   :level_no => nil manually entered
       #               0 read from each root context
       #               1 read as vector from 1st child level
       #    
       #
       def self.setup
         defaults = AnalysisMethod.new(:name=>'xyplot',:class_name=>self.name)
         defaults.settings << AnalysisSetting.new(:name=>'filename', :data_type_id=>DataType::TEXT, :mode=>1, :default_value=>'plot_xy.jpg')
         defaults.settings << AnalysisSetting.new(:name=>'title',    :data_type_id=>DataType::TEXT, :mode=>1, :default_value=>'x/y plot')
         defaults.settings << AnalysisSetting.new(:name=>'label',    :level_no=>0, :data_type_id=>DataType::TEXT, :mode=>1, :column_no=>1,:mandatory=>false)
         defaults.settings << AnalysisSetting.new(:name=>'x',        :level_no=>1, :data_type_id=>DataType::NUMERIC, :mode=>1, :column_no=>3,:mandatory=>true)
         defaults.settings << AnalysisSetting.new(:name=>'y',        :level_no=>1, :data_type_id=>DataType::NUMERIC, :mode=>1, :column_no=>2,:mandatory=>true)
         defaults.settings << AnalysisSetting.new(:name=>'output',   :data_type_id=>DataType::NUMERIC, :mode=>1, 
                                                  :default_value=>'jpeg', :options => ['jpeg','pdf','png','svg'], :mandatory => true)
         defaults
       end
       
       def self.name
         self.to_s.underscore
       end
       
       def logger
         @task.logger
       end
       
       def self.description
         'Simple X/Y Chart plotter, adding created chart to the task as a asset'
       end
       #
       # Initialize Analysis Processor with a task to run 
       #  
       # task => a Task object to get the data from
       # config => options AnalysisMethod instance to configure the process
       #
       def initialize(task,analysis)
         @task = task
         @config = analysis 
       end
       
       #
       # Get the current matrix of data to process
       #
       def matrix
         @matrix = @task.to_matrix unless @matrix  
         @matrix
       end
          
        #
        # Get a single setting from the configuration by name
        #
       def setting(name)
         unless @config
           @config = self.defaults
         end  
         @config.setting(name)
       end
       #
       # Get the value of a setting from the configuration
       # This may return a single item of a array of values depending of the level of the setting 
       #
       def get(name)
         param = setting(name.to_s)
         logger.info "matrix #{self.matrix.row_size}x#{self.matrix.column_size} #{param.name} col #{param.column_no} level #{param.column_no.to_i}" 
         return nil  if param.nil?
         return param.default_value   if param.level_no.nil? or param.column_no.nil?
         return self.matrix.column(param.column_no.to_i).to_a if param.level_no>0
         self.matrix[0,param.column_no.to_i]
      rescue  Exception => ex
         logger.error " failed to find #{name} #{ex.message}"
         return nil
       end
       #
       # The the parameter/setting name for display
       #
       def get_name(name)
         param = setting(name.to_s)
         return nil  if param.nil?
         return param.parameter.name if param.parameter
         param.name
      rescue  Exception => ex
         logger.error ex.message
         logger.error ex.backtrace.join("\n") 
         return nil
       end
       #
       # Create a directory for files used in this processing operation  
       #
       def dirname
          return @dirname if @dirname
          @dirname = File.join(RAILS_ROOT,'public',task.project.dom_id,task.dom_id)
          FileUtils.mkdir_p(dirname)
          return @dirname
       end
       ##
       # For each matching context run the analysis process
       # 
       #
       def run
          filename = get(:filename)
          filepath = File.join(dirname,filename)
          File.delete(filepath)  if File.exists?(filepath)
          
          Gnuplot.open do |gp|
            Gnuplot::Plot.new( gp ) do |plot|        
              plot.title  get('title')
              plot.xlabel get_name('x')
              plot.ylabel get_name('y')
              plot.pointsize 3
              plot.terminal get(:output)
              plot.output filepath
              plot.data = []
              task.roots.each do |context|
                  if context.parameter(get_name('label'))
                    @matrix = context.to_matrix
                    logger.info " context #{context.id} #{context.label}"
                    x = get(:x) 
                    y = get(:y)
        
                    plot.data <<
                      Gnuplot::DataSet.new( [x, y] ) { |ds|
                        ds.with = "linespoints"
                        ds.title = get('label') 
                      }
                  end
              end
              
            end
          end
          return task.folder.add_asset(filepath,filename,'image/jpeg')
       end
       #
       # Rport on the analysis
       #
       def to_html
          out = " <b> Plots of Data </b><br/>"
          element = task.folder.get(get(:filename))
          if element
            out << element.asset.image_tag
          end
          out << "<br/>"
          out     
      rescue  Exception => ex
         logger.error ex.message
         logger.error ex.backtrace.join("\n") 
         return "analysis output failed, #{ex.message}"
       end
         
    end
  end
end