##
# Copyright © 2006 Andrew Lemon, Alces Ltd All Rights Reserved
# See license agreement for additional rights
# 
# This allow the saving on customized options for analysis methods associted with a protocol
#

class AnalysisSetting < ActiveRecord::Base

 belongs_to :analysis,  :class_name =>'AnalysisMethod',:foreign_key =>'analysis_method_id'
 belongs_to :type,      :class_name =>'DataType',      :foreign_key =>'data_type_id'
 belongs_to :parameter, :class_name =>'Parameter',     :foreign_key =>'parameter_id'
 serialize :options

  def input?
    ((io_mode && 1) == 1)
  end

  def output?
    ((io_mode && 2) == 2)
  end

  def mode
   self.io_mode  
  end
  
  def mode=(value)
    self.io_mode = value
  end
  
  def io_style
   case io_mode
   when 1 : '[in]'
   when 2 : '[out]'
   when 3 : '[in/out]'
   else 
     '[script]'
   end
  end

  def script?
    !self.script_body.nil?
  end

  def style
    case level_no
    when 0
      'Value ' + io_style
    when 1
      'Array '+ io_style
    else
      'Manual'+ io_style
    end
  end
  
  def update(params={})
    params.stringify_keys!
    for item in params.keys
       logger.info " #{item}=  #{params[item]} "       
       send(item.to_s + '=', params[item] ) 
    end
    self.column_no = self.parameter.column_no if self.parameter
   logger.info "column =  #{column_no} "           
  end
end
