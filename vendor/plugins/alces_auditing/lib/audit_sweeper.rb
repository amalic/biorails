##
# Copyright © 2006 Alces Ltd All Rights Reserved
# Author: Robert Shell
# See license agreement for additional rights
##
#
module Alces #:nodoc:
    module AuditedModel #:nodoc:

      def self.included(base) # :nodoc:
        base.extend ClassMethods
      end

      module ClassMethods
        # Declare models that should be audited in your controller
        #
        #   class ApplicationController < ActionController::Base
        #     audit User, Widget
        #   end
        #
        def audit(*models)
          models.each do |clazz|
            clazz.send :acts_as_audited unless clazz.respond_to?(:disable_auditing)
            # disable ActiveRecord callbacks, which are replaced by the AuditSweeper
            clazz.send :disable_auditing
          end
          AuditSweeper.class_eval do
            observe *models
          end
          class_eval do
            cache_sweeper :audit_sweeper
          end
        end
      end
      
    end
  end

class AuditSweeper < ActionController::Caching::Sweeper #:nodoc:

  def after_create(record)
    record.send(:write_audit, :create, current_user)
  end

  def after_destroy(record)
    record.send(:write_audit, :destroy, current_user)
  end

  def after_update(record)
    record.send(:write_audit, :update, current_user)
  end
  
  def current_user
    controller.send :current_user if controller.respond_to?(:current_user)
  end

end
