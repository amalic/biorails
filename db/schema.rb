# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 288) do

  create_table "analysis_methods", :force => true do |t|
    t.string   "name",                :limit => 128,                                 :default => "", :null => false
    t.string   "description",         :limit => 2048
    t.string   "class_name",                                                         :default => "", :null => false
    t.integer  "protocol_version_id",                 :precision => 11, :scale => 0
    t.integer  "lock_version",                        :precision => 11, :scale => 0, :default => 0,  :null => false
    t.datetime "created_at",                                                                         :null => false
    t.datetime "updated_at",                                                                         :null => false
    t.integer  "updated_by_user_id",                  :precision => 11, :scale => 0, :default => 1,  :null => false
    t.integer  "created_by_user_id",                  :precision => 11, :scale => 0, :default => 1,  :null => false
  end

  create_table "audits", :force => true do |t|
    t.integer  "auditable_id",                  :precision => 11, :scale => 0
    t.string   "auditable_type"
    t.integer  "user_id",                       :precision => 11, :scale => 0
    t.string   "user_type"
    t.string   "session_id"
    t.string   "action"
    t.text     "changes",        :limit => nil
    t.datetime "created_at"
  end

  add_index "audits", ["auditable_id", "auditable_type"], :name => "auditable_index"
  add_index "audits", ["created_at"], :name => "audits_created_at_index"
  add_index "audits", ["auditable_id"], :name => "audits_idx2"
  add_index "audits", ["user_id"], :name => "audits_idx4"
  add_index "audits", ["session_id"], :name => "audits_idx6"
  add_index "audits", ["user_id", "user_type"], :name => "user_index"

  create_table "batches", :force => true do |t|
    t.integer  "compound_id",                        :precision => 11, :scale => 0, :default => 0,  :null => false
    t.string   "name"
    t.string   "description",        :limit => 1024,                                :default => "", :null => false
    t.string   "external_ref"
    t.string   "quantity_unit"
    t.float    "quantity_value"
    t.string   "url"
    t.integer  "lock_version",                       :precision => 11, :scale => 0, :default => 0,  :null => false
    t.datetime "created_at",                                                                        :null => false
    t.datetime "updated_at",                                                                        :null => false
    t.integer  "updated_by_user_id",                 :precision => 11, :scale => 0, :default => 1,  :null => false
    t.integer  "created_by_user_id",                 :precision => 11, :scale => 0, :default => 1,  :null => false
  end

  add_index "batches", ["compound_id"], :name => "batches_compound_fk"
  add_index "batches", ["created_at"], :name => "batches_idx10"
  add_index "batches", ["updated_at"], :name => "batches_idx11"
  add_index "batches", ["updated_by_user_id"], :name => "batches_idx12"
  add_index "batches", ["created_by_user_id"], :name => "batches_idx13"
  add_index "batches", ["name"], :name => "batches_idx3"

  create_table "catalog_logs", :force => true do |t|
    t.integer  "user_id",        :precision => 11, :scale => 0
    t.integer  "auditable_id",   :precision => 11, :scale => 0
    t.string   "auditable_type"
    t.string   "action"
    t.string   "name"
    t.string   "comments"
    t.string   "created_by"
    t.datetime "created_at"
  end

  add_index "catalog_logs", ["user_id"], :name => "catalog_logs_idx1"
  add_index "catalog_logs", ["auditable_type", "auditable_id"], :name => "catalog_logs_idx2"
  add_index "catalog_logs", ["created_at"], :name => "catalog_logs_idx3"
  add_index "catalog_logs", ["name"], :name => "catalog_logs_idx6"

  create_table "compounds", :force => true do |t|
    t.string   "name",               :limit => 50,                                  :default => "", :null => false
    t.string   "description",        :limit => 1024,                                :default => "", :null => false
    t.string   "formula",            :limit => 50
    t.float    "mass"
    t.string   "smiles"
    t.integer  "lock_version",                       :precision => 11, :scale => 0, :default => 0,  :null => false
    t.datetime "created_at",                                                                        :null => false
    t.datetime "updated_at",                                                                        :null => false
    t.datetime "registration_date"
    t.string   "iupacname",                                                         :default => ""
    t.integer  "updated_by_user_id",                 :precision => 11, :scale => 0, :default => 1,  :null => false
    t.integer  "created_by_user_id",                 :precision => 11, :scale => 0, :default => 1,  :null => false
  end

  add_index "compounds", ["updated_by_user_id"], :name => "compounds_idx12"
  add_index "compounds", ["created_by_user_id"], :name => "compounds_idx13"
  add_index "compounds", ["name"], :name => "compounds_idx2"
  add_index "compounds", ["created_at"], :name => "compounds_idx8"
  add_index "compounds", ["updated_at"], :name => "compounds_idx9"

  create_table "container_items", :force => true do |t|
    t.integer "container_group_id", :precision => 11, :scale => 0,                 :null => false
    t.string  "subject_type",                                      :default => "", :null => false
    t.integer "subject_id",         :precision => 11, :scale => 0,                 :null => false
    t.integer "slot_no",            :precision => 11, :scale => 0,                 :null => false
  end

  add_index "container_items", ["container_group_id"], :name => "container_items_idx2"
  add_index "container_items", ["subject_id"], :name => "container_items_idx4"

  create_table "containers", :force => true do |t|
    t.string   "name",               :limit => 128,                                 :default => "", :null => false
    t.string   "description",        :limit => 1024,                                :default => "", :null => false
    t.integer  "plate_format_id",                    :precision => 11, :scale => 0
    t.integer  "lock_version",                       :precision => 11, :scale => 0, :default => 0,  :null => false
    t.datetime "created_at",                                                                        :null => false
    t.datetime "updated_at",                                                                        :null => false
    t.integer  "updated_by_user_id",                 :precision => 11, :scale => 0, :default => 1,  :null => false
    t.integer  "created_by_user_id",                 :precision => 11, :scale => 0, :default => 1,  :null => false
  end

  add_index "containers", ["name"], :name => "containers_idx2"
  add_index "containers", ["plate_format_id"], :name => "containers_idx4"
  add_index "containers", ["created_at"], :name => "containers_idx6"
  add_index "containers", ["updated_at"], :name => "containers_idx7"
  add_index "containers", ["updated_by_user_id"], :name => "containers_idx8"
  add_index "containers", ["created_by_user_id"], :name => "containers_idx9"

  create_table "data_concepts", :force => true do |t|
    t.integer  "parent_id",                          :precision => 11, :scale => 0
    t.string   "name",               :limit => 50,                                  :default => "",            :null => false
    t.integer  "data_context_id",                    :precision => 11, :scale => 0, :default => 0,             :null => false
    t.string   "description",        :limit => 1024,                                :default => "",            :null => false
    t.integer  "access_control_id",                  :precision => 11, :scale => 0
    t.integer  "lock_version",                       :precision => 11, :scale => 0, :default => 0,             :null => false
    t.datetime "created_at",                                                                                   :null => false
    t.datetime "updated_at",                                                                                   :null => false
    t.string   "type",                                                              :default => "DataConcept", :null => false
    t.integer  "updated_by_user_id",                 :precision => 11, :scale => 0, :default => 1,             :null => false
    t.integer  "created_by_user_id",                 :precision => 11, :scale => 0, :default => 1,             :null => false
  end

  add_index "data_concepts", ["access_control_id"], :name => "data_concepts_acl_idx"
  add_index "data_concepts", ["data_context_id"], :name => "data_concepts_fk1"
  add_index "data_concepts", ["updated_by_user_id"], :name => "data_concepts_idx11"
  add_index "data_concepts", ["created_by_user_id"], :name => "data_concepts_idx12"
  add_index "data_concepts", ["updated_at"], :name => "data_concepts_idx2"
  add_index "data_concepts", ["created_at"], :name => "data_concepts_idx4"
  add_index "data_concepts", ["name"], :name => "data_concepts_name_idx"

  create_table "data_elements", :force => true do |t|
    t.string   "name",               :limit => 50,                                  :default => "", :null => false
    t.string   "description",        :limit => 1024,                                :default => "", :null => false
    t.integer  "data_system_id",                     :precision => 11, :scale => 0,                 :null => false
    t.integer  "data_concept_id",                    :precision => 11, :scale => 0,                 :null => false
    t.integer  "access_control_id",                  :precision => 11, :scale => 0
    t.integer  "lock_version",                       :precision => 11, :scale => 0, :default => 0,  :null => false
    t.datetime "created_at",                                                                        :null => false
    t.datetime "updated_at",                                                                        :null => false
    t.integer  "parent_id",                          :precision => 11, :scale => 0
    t.string   "style",              :limit => 10,                                  :default => "", :null => false
    t.string   "content",            :limit => 4000,                                :default => ""
    t.integer  "estimated_count",                    :precision => 11, :scale => 0
    t.string   "type"
    t.integer  "updated_by_user_id",                 :precision => 11, :scale => 0, :default => 1,  :null => false
    t.integer  "created_by_user_id",                 :precision => 11, :scale => 0, :default => 1,  :null => false
  end

  add_index "data_elements", ["access_control_id"], :name => "data_elements_acl_idx"
  add_index "data_elements", ["parent_id"], :name => "data_elements_idx10"
  add_index "data_elements", ["updated_by_user_id"], :name => "data_elements_idx15"
  add_index "data_elements", ["created_by_user_id"], :name => "data_elements_idx16"
  add_index "data_elements", ["updated_at"], :name => "data_elements_idx2"
  add_index "data_elements", ["created_at"], :name => "data_elements_idx4"
  add_index "data_elements", ["name"], :name => "data_elements_name_idx"
  add_index "data_elements", ["data_system_id"], :name => "data_element_fk1"
  add_index "data_elements", ["data_concept_id"], :name => "data_element_fk2"

  create_table "data_formats", :force => true do |t|
    t.string   "name",               :limit => 128,                                 :default => "", :null => false
    t.string   "description",        :limit => 1024,                                :default => "", :null => false
    t.string   "default_value"
    t.string   "format_regex"
    t.integer  "lock_version",                       :precision => 11, :scale => 0, :default => 0,  :null => false
    t.datetime "created_at",                                                                        :null => false
    t.datetime "updated_at",                                                                        :null => false
    t.integer  "data_type_id",                       :precision => 11, :scale => 0
    t.integer  "updated_by_user_id",                 :precision => 11, :scale => 0, :default => 1,  :null => false
    t.integer  "created_by_user_id",                 :precision => 11, :scale => 0, :default => 1,  :null => false
    t.string   "format_sprintf"
  end

  add_index "data_formats", ["updated_by_user_id"], :name => "data_formats_idx10"
  add_index "data_formats", ["created_by_user_id"], :name => "data_formats_idx11"
  add_index "data_formats", ["name"], :name => "data_formats_idx2"
  add_index "data_formats", ["created_at"], :name => "data_formats_idx7"
  add_index "data_formats", ["updated_at"], :name => "data_formats_idx8"
  add_index "data_formats", ["data_type_id"], :name => "data_formats_idx9"

  create_table "data_relations", :force => true do |t|
    t.integer "from_concept_id", :limit => 32, :precision => 32, :scale => 0, :null => false
    t.integer "to_concept_id",   :limit => 32, :precision => 32, :scale => 0, :null => false
    t.integer "role_concept_id", :limit => 32, :precision => 32, :scale => 0, :null => false
  end

  add_index "data_relations", ["from_concept_id"], :name => "data_relations_from_idx"
  add_index "data_relations", ["role_concept_id"], :name => "data_relations_role_idx"
  add_index "data_relations", ["to_concept_id"], :name => "data_relations_to_idx"

  create_table "data_systems", :force => true do |t|
    t.string   "name",               :limit => 50,                                  :default => "",          :null => false
    t.string   "description",        :limit => 1024,                                :default => "",          :null => false
    t.integer  "data_context_id",                    :precision => 11, :scale => 0, :default => 1,           :null => false
    t.integer  "access_control_id",                  :precision => 11, :scale => 0
    t.integer  "lock_version",                       :precision => 11, :scale => 0, :default => 0,           :null => false
    t.datetime "created_at",                                                                                 :null => false
    t.datetime "updated_at",                                                                                 :null => false
    t.string   "adapter",            :limit => 50,                                  :default => "mysql",     :null => false
    t.string   "host",               :limit => 50,                                  :default => "localhost"
    t.string   "username",           :limit => 50,                                  :default => "root"
    t.string   "password",           :limit => 50,                                  :default => ""
    t.string   "database",           :limit => 50,                                  :default => ""
    t.string   "test_object",        :limit => 45,                                  :default => "",          :null => false
    t.integer  "updated_by_user_id",                 :precision => 11, :scale => 0, :default => 1,           :null => false
    t.integer  "created_by_user_id",                 :precision => 11, :scale => 0, :default => 1,           :null => false
  end

  add_index "data_systems", ["access_control_id"], :name => "data_environments_acl_idx"
  add_index "data_systems", ["data_context_id"], :name => "data_environments_fk1"
  add_index "data_systems", ["updated_at"], :name => "data_environments_idx2"
  add_index "data_systems", ["created_at"], :name => "data_environments_idx4"
  add_index "data_systems", ["name"], :name => "data_environments_name_idx"
  add_index "data_systems", ["updated_by_user_id"], :name => "data_systems_idx15"
  add_index "data_systems", ["created_by_user_id"], :name => "data_systems_idx16"

  create_table "data_types", :force => true do |t|
    t.string   "name",                                                              :default => "", :null => false
    t.string   "description",        :limit => 1024,                                :default => "", :null => false
    t.string   "value_class"
    t.integer  "lock_version",                       :precision => 11, :scale => 0, :default => 0,  :null => false
    t.datetime "created_at",                                                                        :null => false
    t.datetime "updated_at",                                                                        :null => false
    t.integer  "updated_by_user_id",                 :precision => 11, :scale => 0, :default => 1,  :null => false
    t.integer  "created_by_user_id",                 :precision => 11, :scale => 0, :default => 1,  :null => false
  end

  add_index "data_types", ["name"], :name => "data_types_idx2", :unique => true
  add_index "data_types", ["created_at"], :name => "data_types_idx6"
  add_index "data_types", ["updated_at"], :name => "data_types_idx7"
  add_index "data_types", ["updated_by_user_id"], :name => "data_types_idx8"
  add_index "data_types", ["created_by_user_id"], :name => "data_types_idx9"

  create_table "db_files", :force => true do |t|
    t.binary "data"
  end

  create_table "experiment_logs", :force => true do |t|
    t.integer  "experiment_id",  :precision => 11, :scale => 0
    t.integer  "task_id",        :precision => 11, :scale => 0
    t.integer  "user_id",        :precision => 11, :scale => 0
    t.integer  "auditable_id",   :precision => 11, :scale => 0
    t.string   "auditable_type"
    t.string   "action"
    t.string   "name"
    t.string   "comments"
    t.string   "created_by"
    t.datetime "created_at"
  end

  add_index "experiment_logs", ["experiment_id"], :name => "experiment_logs_idx1"
  add_index "experiment_logs", ["auditable_type", "auditable_id"], :name => "experiment_logs_idx3"
  add_index "experiment_logs", ["created_at"], :name => "experiment_logs_idx4"
  add_index "experiment_logs", ["auditable_id"], :name => "experiment_logs_idx5"
  add_index "experiment_logs", ["name"], :name => "experiment_logs_idx8"
  add_index "experiment_logs", ["user_id"], :name => "experiment_logs_user_idx2"

  create_table "experiments", :force => true do |t|
    t.string   "name",                :limit => 128,                                 :default => "", :null => false
    t.string   "description",         :limit => 1024,                                :default => "", :null => false
    t.integer  "category_id",                         :precision => 11, :scale => 0
    t.integer  "status_id",                           :precision => 11, :scale => 0, :default => 0,  :null => false
    t.integer  "study_id",                            :precision => 11, :scale => 0,                 :null => false
    t.integer  "protocol_version_id",                 :precision => 11, :scale => 0
    t.integer  "lock_version",                        :precision => 11, :scale => 0, :default => 0,  :null => false
    t.datetime "created_at",                                                                         :null => false
    t.datetime "updated_at",                                                                         :null => false
    t.integer  "study_protocol_id",                   :precision => 11, :scale => 0,                 :null => false
    t.integer  "project_id",                          :precision => 11, :scale => 0,                 :null => false
    t.integer  "updated_by_user_id",                  :precision => 11, :scale => 0, :default => 1,  :null => false
    t.integer  "created_by_user_id",                  :precision => 11, :scale => 0, :default => 1,  :null => false
    t.datetime "started_at"
    t.datetime "ended_at"
    t.datetime "expected_at"
  end

  add_index "experiments", ["updated_at"], :name => "experiments_idx10"
  add_index "experiments", ["study_protocol_id"], :name => "experiments_idx11"
  add_index "experiments", ["project_id"], :name => "experiments_idx12"
  add_index "experiments", ["updated_by_user_id"], :name => "experiments_idx13"
  add_index "experiments", ["created_by_user_id"], :name => "experiments_idx14"
  add_index "experiments", ["name"], :name => "experiments_idx2"
  add_index "experiments", ["category_id"], :name => "experiments_idx4"
  add_index "experiments", ["status_id"], :name => "experiments_idx5"
  add_index "experiments", ["study_id"], :name => "experiments_idx6"
  add_index "experiments", ["protocol_version_id"], :name => "experiments_idx7"
  add_index "experiments", ["created_at"], :name => "experiments_idx9"

  create_table "identifiers", :force => true do |t|
    t.string   "name"
    t.string   "prefix"
    t.string   "postfix"
    t.string   "mask"
    t.integer  "current_counter",    :precision => 11, :scale => 0, :default => 0
    t.integer  "current_step",       :precision => 11, :scale => 0, :default => 1
    t.integer  "lock_version",       :precision => 11, :scale => 0, :default => 0, :null => false
    t.datetime "created_at",                                                       :null => false
    t.datetime "updated_at",                                                       :null => false
    t.integer  "updated_by_user_id", :precision => 11, :scale => 0, :default => 1, :null => false
    t.integer  "created_by_user_id", :precision => 11, :scale => 0, :default => 1, :null => false
  end

  add_index "identifiers", ["updated_at"], :name => "identifiers_idx10"
  add_index "identifiers", ["updated_by_user_id"], :name => "identifiers_idx11"
  add_index "identifiers", ["created_by_user_id"], :name => "identifiers_idx12"
  add_index "identifiers", ["name"], :name => "identifiers_idx2"
  add_index "identifiers", ["created_at"], :name => "identifiers_idx9"

  create_table "list_items", :force => true do |t|
    t.integer "list_id",   :precision => 11, :scale => 0, :null => false
    t.string  "data_type"
    t.integer "data_id",   :precision => 11, :scale => 0
    t.string  "data_name"
  end

  add_index "list_items", ["list_id"], :name => "list_items_idx2"
  add_index "list_items", ["data_id"], :name => "list_items_idx4"

  create_table "lists", :force => true do |t|
    t.string   "name",                                                                              :null => false
    t.string   "description",        :limit => 1024,                                :default => ""
    t.string   "type"
    t.datetime "expires_at"
    t.integer  "lock_version",                       :precision => 11, :scale => 0, :default => 0,  :null => false
    t.datetime "created_at",                                                                        :null => false
    t.datetime "updated_at",                                                                        :null => false
    t.integer  "data_element_id",                    :precision => 11, :scale => 0
    t.integer  "updated_by_user_id",                 :precision => 11, :scale => 0, :default => 1,  :null => false
    t.integer  "created_by_user_id",                 :precision => 11, :scale => 0, :default => 1,  :null => false
  end

  add_index "lists", ["updated_by_user_id"], :name => "lists_idx10"
  add_index "lists", ["created_by_user_id"], :name => "lists_idx11"
  add_index "lists", ["name"], :name => "lists_idx2"
  add_index "lists", ["created_at"], :name => "lists_idx7"
  add_index "lists", ["updated_at"], :name => "lists_idx8"
  add_index "lists", ["data_element_id"], :name => "lists_idx9"

  create_table "log_messages", :force => true do |t|
    t.datetime "log_time",                                                                              :null => false
    t.string   "username",        :limit => 32,                                  :default => "user",    :null => false
    t.integer  "log_code",                        :precision => 11, :scale => 0, :default => 0,         :null => false
    t.string   "log_source",                                                     :default => "UNKNOWN", :null => false
    t.string   "log_level",       :limit => 8,                                   :default => "INFO",    :null => false
    t.string   "description",                                                                           :null => false
    t.integer  "session_id",                      :precision => 11, :scale => 0
    t.string   "client_user",     :limit => 32
    t.string   "client_exe",      :limit => 64
    t.string   "client_terminal", :limit => 64
    t.string   "client_info",     :limit => 64
    t.string   "client_host",     :limit => 64
    t.string   "client_ip",       :limit => 64
    t.string   "code_module",     :limit => 64
    t.string   "code_action",     :limit => 64
    t.string   "details",         :limit => 2000
  end

  create_table "memberships", :force => true do |t|
    t.integer  "user_id",                         :precision => 11, :scale => 0, :default => 0,     :null => false
    t.integer  "project_id",                      :precision => 11, :scale => 0, :default => 0,     :null => false
    t.integer  "role_id",                         :precision => 11, :scale => 0, :default => 0,     :null => false
    t.boolean  "is_owner",           :limit => 1,                                :default => false
    t.datetime "created_at",                                                                        :null => false
    t.datetime "updated_at",                                                                        :null => false
    t.integer  "updated_by_user_id",              :precision => 11, :scale => 0, :default => 1,     :null => false
    t.integer  "created_by_user_id",              :precision => 11, :scale => 0, :default => 1,     :null => false
  end

  add_index "memberships", ["user_id"], :name => "memberships_idx2"
  add_index "memberships", ["project_id"], :name => "memberships_idx3"
  add_index "memberships", ["role_id"], :name => "memberships_idx4"
  add_index "memberships", ["created_at"], :name => "memberships_idx6"
  add_index "memberships", ["updated_at"], :name => "memberships_idx7"
  add_index "memberships", ["updated_by_user_id"], :name => "memberships_idx8"
  add_index "memberships", ["created_by_user_id"], :name => "memberships_idx9"

  create_table "parameter_contexts", :force => true do |t|
    t.integer "protocol_version_id", :precision => 11, :scale => 0,                :null => false
    t.integer "parent_id",           :precision => 11, :scale => 0
    t.integer "level_no",            :precision => 11, :scale => 0, :default => 0
    t.string  "label"
    t.integer "default_count",       :precision => 11, :scale => 0, :default => 1
    t.integer "left_limit",          :precision => 11, :scale => 0, :default => 0, :null => false
    t.integer "right_limit",         :precision => 11, :scale => 0, :default => 0, :null => false
  end

  add_index "parameter_contexts", ["protocol_version_id"], :name => "parameter_contexts_ide1"
  add_index "parameter_contexts", ["parent_id"], :name => "parameter_contexts_idx2"
  add_index "parameter_contexts", ["label"], :name => "parameter_contexts_idx3"

  create_table "parameter_roles", :force => true do |t|
    t.string   "name",               :limit => 50,                                  :default => "", :null => false
    t.string   "description",        :limit => 1024,                                :default => "", :null => false
    t.integer  "weighing",                           :precision => 11, :scale => 0, :default => 0,  :null => false
    t.integer  "lock_version",                       :precision => 11, :scale => 0, :default => 0,  :null => false
    t.datetime "created_at",                                                                        :null => false
    t.datetime "updated_at",                                                                        :null => false
    t.integer  "updated_by_user_id",                 :precision => 11, :scale => 0, :default => 1,  :null => false
    t.integer  "created_by_user_id",                 :precision => 11, :scale => 0, :default => 1,  :null => false
  end

  add_index "parameter_roles", ["name"], :name => "parameter_roles_idx2"
  add_index "parameter_roles", ["created_at"], :name => "parameter_roles_idx6"
  add_index "parameter_roles", ["updated_at"], :name => "parameter_roles_idx7"
  add_index "parameter_roles", ["updated_by_user_id"], :name => "parameter_roles_idx8"
  add_index "parameter_roles", ["created_by_user_id"], :name => "parameter_roles_idx9"

  create_table "parameter_types", :force => true do |t|
    t.string   "name",               :limit => 50,                                  :default => "", :null => false
    t.string   "description",        :limit => 1024,                                :default => "", :null => false
    t.integer  "weighing",                           :precision => 11, :scale => 0, :default => 0,  :null => false
    t.integer  "lock_version",                       :precision => 11, :scale => 0, :default => 0,  :null => false
    t.datetime "created_at",                                                                        :null => false
    t.datetime "updated_at",                                                                        :null => false
    t.integer  "data_concept_id",                    :precision => 11, :scale => 0
    t.integer  "data_type_id",                       :precision => 11, :scale => 0
    t.string   "storage_unit"
    t.integer  "updated_by_user_id",                 :precision => 11, :scale => 0, :default => 1,  :null => false
    t.integer  "created_by_user_id",                 :precision => 11, :scale => 0, :default => 1,  :null => false
  end

  add_index "parameter_types", ["updated_by_user_id"], :name => "parameter_types_idx11"
  add_index "parameter_types", ["created_by_user_id"], :name => "parameter_types_idx12"
  add_index "parameter_types", ["name"], :name => "parameter_types_idx2"
  add_index "parameter_types", ["created_at"], :name => "parameter_types_idx6"
  add_index "parameter_types", ["updated_at"], :name => "parameter_types_idx7"
  add_index "parameter_types", ["data_concept_id"], :name => "parameter_types_idx8"
  add_index "parameter_types", ["data_type_id"], :name => "parameter_types_idx9"

  create_table "parameters", :force => true do |t|
    t.integer  "protocol_version_id",                  :precision => 11, :scale => 0,                  :null => false
    t.integer  "parameter_type_id",                    :precision => 11, :scale => 0,                  :null => false
    t.integer  "parameter_role_id",                    :precision => 11, :scale => 0,                  :null => false
    t.integer  "parameter_context_id",                 :precision => 11, :scale => 0,                  :null => false
    t.integer  "column_no",                            :precision => 11, :scale => 0
    t.integer  "sequence_num",                         :precision => 11, :scale => 0
    t.string   "name",                 :limit => 62,                                  :default => "",  :null => false
    t.string   "description",          :limit => 1024
    t.string   "display_unit",         :limit => 20
    t.integer  "data_element_id",                      :precision => 11, :scale => 0
    t.string   "qualifier_style",      :limit => 1
    t.integer  "access_control_id",                    :precision => 11, :scale => 0, :default => 0,   :null => false
    t.integer  "lock_version",                         :precision => 11, :scale => 0, :default => 0,   :null => false
    t.datetime "created_at",                                                                           :null => false
    t.datetime "updated_at",                                                                           :null => false
    t.string   "mandatory",                                                           :default => "N"
    t.string   "default_value"
    t.integer  "data_type_id",                         :precision => 11, :scale => 0,                  :null => false
    t.integer  "data_format_id",                       :precision => 11, :scale => 0
    t.integer  "study_parameter_id",                   :precision => 11, :scale => 0,                  :null => false
    t.integer  "study_queue_id",                       :precision => 11, :scale => 0
    t.integer  "updated_by_user_id",                   :precision => 11, :scale => 0, :default => 1,   :null => false
    t.integer  "created_by_user_id",                   :precision => 11, :scale => 0, :default => 1,   :null => false
    t.integer  "left_limit",                           :precision => 11, :scale => 0, :default => 0,   :null => false
    t.integer  "right_limit",                          :precision => 11, :scale => 0, :default => 0,   :null => false
  end

  add_index "parameters", ["name"], :name => "parameters_idx1"
  add_index "parameters", ["data_element_id"], :name => "parameters_idx11"
  add_index "parameters", ["access_control_id"], :name => "parameters_idx13"
  add_index "parameters", ["created_at"], :name => "parameters_idx15"
  add_index "parameters", ["data_type_id"], :name => "parameters_idx19"
  add_index "parameters", ["protocol_version_id"], :name => "parameters_idx2"
  add_index "parameters", ["data_format_id"], :name => "parameters_idx20"
  add_index "parameters", ["study_parameter_id"], :name => "parameters_idx21"
  add_index "parameters", ["study_queue_id"], :name => "parameters_idx22"
  add_index "parameters", ["updated_by_user_id"], :name => "parameters_idx23"
  add_index "parameters", ["created_by_user_id"], :name => "parameters_idx24"
  add_index "parameters", ["parameter_context_id"], :name => "parameters_idx3"
  add_index "parameters", ["parameter_type_id"], :name => "parameters_idx4"
  add_index "parameters", ["parameter_role_id"], :name => "parameters_idx5"
  add_index "parameters", ["updated_at"], :name => "parameters_idx6"

  create_table "permissions", :force => true do |t|
    t.boolean "checked", :limit => 1, :default => false
    t.string  "subject",              :default => "",    :null => false
    t.string  "action",               :default => "",    :null => false
  end

  create_table "plate_formats", :force => true do |t|
    t.string   "name",               :limit => 128,                                 :default => "", :null => false
    t.string   "description",        :limit => 1024,                                :default => "", :null => false
    t.integer  "num_rows",                           :precision => 11, :scale => 0
    t.integer  "num_columns",                        :precision => 11, :scale => 0
    t.integer  "lock_version",                       :precision => 11, :scale => 0, :default => 0,  :null => false
    t.datetime "created_at",                                                                        :null => false
    t.datetime "updated_at",                                                                        :null => false
    t.integer  "updated_by_user_id",                 :precision => 11, :scale => 0, :default => 1,  :null => false
    t.integer  "created_by_user_id",                 :precision => 11, :scale => 0, :default => 1,  :null => false
  end

  add_index "plate_formats", ["created_by_user_id"], :name => "plate_formats_idx10"
  add_index "plate_formats", ["name"], :name => "plate_formats_idx2"
  add_index "plate_formats", ["created_at"], :name => "plate_formats_idx7"
  add_index "plate_formats", ["updated_at"], :name => "plate_formats_idx8"
  add_index "plate_formats", ["updated_by_user_id"], :name => "plate_formats_idx9"

  create_table "plate_wells", :force => true do |t|
    t.string   "name",               :limit => 128,                                :default => "", :null => false
    t.string   "label"
    t.integer  "row_no",                            :precision => 11, :scale => 0, :default => 0,  :null => false
    t.integer  "column_no",                         :precision => 11, :scale => 0, :default => 0,  :null => false
    t.integer  "slot_no",                           :precision => 11, :scale => 0, :default => 0,  :null => false
    t.integer  "lock_version",                      :precision => 11, :scale => 0, :default => 0,  :null => false
    t.datetime "created_at",                                                                       :null => false
    t.datetime "updated_at",                                                                       :null => false
    t.integer  "updated_by_user_id",                :precision => 11, :scale => 0, :default => 1,  :null => false
    t.integer  "created_by_user_id",                :precision => 11, :scale => 0, :default => 1,  :null => false
  end

  add_index "plate_wells", ["updated_by_user_id"], :name => "plate_wells_idx10"
  add_index "plate_wells", ["created_by_user_id"], :name => "plate_wells_idx11"
  add_index "plate_wells", ["name"], :name => "plate_wells_idx2"
  add_index "plate_wells", ["created_at"], :name => "plate_wells_idx8"
  add_index "plate_wells", ["updated_at"], :name => "plate_wells_idx9"

  create_table "plates", :force => true do |t|
    t.string   "name",                                                                              :null => false
    t.string   "description",        :limit => 1024,                                :default => "", :null => false
    t.string   "external_ref"
    t.string   "quantity_unit"
    t.float    "quantity_value"
    t.string   "url"
    t.integer  "lock_version",                       :precision => 11, :scale => 0, :default => 0,  :null => false
    t.datetime "created_at",                                                                        :null => false
    t.datetime "updated_at",                                                                        :null => false
    t.integer  "updated_by_user_id",                 :precision => 11, :scale => 0, :default => 1,  :null => false
    t.integer  "created_by_user_id",                 :precision => 11, :scale => 0, :default => 1,  :null => false
  end

  add_index "plates", ["updated_at"], :name => "plates_idx10"
  add_index "plates", ["updated_by_user_id"], :name => "plates_idx11"
  add_index "plates", ["created_by_user_id"], :name => "plates_idx12"
  add_index "plates", ["name"], :name => "plates_idx2"
  add_index "plates", ["created_at"], :name => "plates_idx9"

  create_table "plugin_schema_info", :id => false, :force => true do |t|
    t.string  "plugin_name"
    t.integer "version",     :precision => 11, :scale => 0
  end

  create_table "project_assets", :force => true do |t|
    t.integer  "project_id",                        :precision => 11, :scale => 0
    t.string   "title"
    t.integer  "parent_id",                         :precision => 11, :scale => 0
    t.string   "content_type"
    t.string   "filename"
    t.string   "thumbnail"
    t.integer  "size_bytes",                        :precision => 11, :scale => 0
    t.integer  "width",                             :precision => 11, :scale => 0
    t.integer  "height",                            :precision => 11, :scale => 0
    t.integer  "thumbnails_count",                  :precision => 11, :scale => 0, :default => 0
    t.boolean  "published",          :limit => 1,                                  :default => false
    t.string   "content_hash"
    t.integer  "lock_version",                      :precision => 11, :scale => 0, :default => 0,     :null => false
    t.datetime "created_at",                                                                          :null => false
    t.datetime "updated_at",                                                                          :null => false
    t.integer  "updated_by_user_id",                :precision => 11, :scale => 0, :default => 1,     :null => false
    t.integer  "created_by_user_id",                :precision => 11, :scale => 0, :default => 1,     :null => false
    t.text     "caption",            :limit => nil
    t.integer  "db_file_id",                        :precision => 11, :scale => 0
  end

  add_index "project_assets", ["created_at"], :name => "project_assets_idx15"
  add_index "project_assets", ["updated_at"], :name => "project_assets_idx16"
  add_index "project_assets", ["updated_by_user_id"], :name => "project_assets_idx17"
  add_index "project_assets", ["created_by_user_id"], :name => "project_assets_idx18"
  add_index "project_assets", ["project_id"], :name => "project_assets_idx2"
  add_index "project_assets", ["db_file_id"], :name => "project_assets_idx20"
  add_index "project_assets", ["parent_id"], :name => "project_assets_idx4"

  create_table "project_contents", :force => true do |t|
    t.integer  "project_id",                        :precision => 11, :scale => 0,                    :null => false
    t.string   "type",               :limit => 20
    t.string   "name"
    t.string   "title"
    t.text     "body",               :limit => nil
    t.text     "body_html",          :limit => nil
    t.string   "author_ip",          :limit => 100
    t.integer  "comments_count",                    :precision => 11, :scale => 0, :default => 0
    t.integer  "comment_age",                       :precision => 11, :scale => 0, :default => 0
    t.boolean  "published",          :limit => 1,                                  :default => false
    t.string   "content_hash"
    t.datetime "lock_timeout"
    t.integer  "lock_user_id",                      :precision => 11, :scale => 0
    t.integer  "lock_version",                      :precision => 11, :scale => 0, :default => 0,     :null => false
    t.datetime "created_at",                                                                          :null => false
    t.datetime "updated_at",                                                                          :null => false
    t.integer  "updated_by_user_id",                :precision => 11, :scale => 0, :default => 1,     :null => false
    t.integer  "created_by_user_id",                :precision => 11, :scale => 0, :default => 1,     :null => false
    t.integer  "left_limit",                        :precision => 11, :scale => 0
    t.integer  "right_limit",                       :precision => 11, :scale => 0
    t.integer  "parent_id",                         :precision => 11, :scale => 0
  end

  add_index "project_contents", ["lock_user_id"], :name => "project_contents_idx14"
  add_index "project_contents", ["created_at"], :name => "project_contents_idx16"
  add_index "project_contents", ["updated_at"], :name => "project_contents_idx17"
  add_index "project_contents", ["updated_by_user_id"], :name => "project_contents_idx18"
  add_index "project_contents", ["created_by_user_id"], :name => "project_contents_idx19"
  add_index "project_contents", ["project_id"], :name => "project_contents_idx2"
  add_index "project_contents", ["parent_id"], :name => "project_contents_idx22"
  add_index "project_contents", ["name"], :name => "project_contents_idx4"

  create_table "project_elements", :force => true do |t|
    t.integer  "parent_id",                            :precision => 11, :scale => 0
    t.integer  "project_id",                           :precision => 11, :scale => 0,                               :null => false
    t.string   "type",                   :limit => 32,                                :default => "ProjectElement"
    t.integer  "position",                             :precision => 11, :scale => 0, :default => 1
    t.string   "name",                   :limit => 64,                                :default => "",               :null => false
    t.integer  "reference_id",                         :precision => 11, :scale => 0
    t.string   "reference_type",         :limit => 20
    t.integer  "lock_version",                         :precision => 11, :scale => 0, :default => 0,                :null => false
    t.datetime "created_at",                                                                                        :null => false
    t.datetime "updated_at",                                                                                        :null => false
    t.integer  "updated_by_user_id",                   :precision => 11, :scale => 0, :default => 1,                :null => false
    t.integer  "created_by_user_id",                   :precision => 11, :scale => 0, :default => 1,                :null => false
    t.integer  "asset_id",                             :precision => 11, :scale => 0
    t.integer  "content_id",                           :precision => 11, :scale => 0
    t.string   "published_hash"
    t.integer  "project_elements_count",               :precision => 11, :scale => 0, :default => 0,                :null => false
    t.integer  "left_limit",                           :precision => 11, :scale => 0, :default => 1,                :null => false
    t.integer  "right_limit",                          :precision => 11, :scale => 0, :default => 2,                :null => false
  end

  add_index "project_elements", ["left_limit", "project_id"], :name => "left_limit"
  add_index "project_elements", ["name", "parent_id"], :name => "parent_id", :unique => true
  add_index "project_elements", ["created_at"], :name => "project_elements_idx10"
  add_index "project_elements", ["updated_at"], :name => "project_elements_idx11"
  add_index "project_elements", ["updated_by_user_id"], :name => "project_elements_idx12"
  add_index "project_elements", ["created_by_user_id"], :name => "project_elements_idx13"
  add_index "project_elements", ["asset_id"], :name => "project_elements_idx14"
  add_index "project_elements", ["content_id"], :name => "project_elements_idx15"
  add_index "project_elements", ["parent_id"], :name => "project_elements_idx2"
  add_index "project_elements", ["name"], :name => "project_elements_idx6"
  add_index "project_elements", ["reference_id"], :name => "project_elements_idx7"
  add_index "project_elements", ["project_id"], :name => "project_id"
  add_index "project_elements", ["right_limit", "project_id"], :name => "right_limit"

  create_table "projects", :force => true do |t|
    t.string   "name",               :limit => 30,                                  :default => "", :null => false
    t.string   "summary",            :limit => 1024,                                :default => "", :null => false
    t.integer  "status_id",                          :precision => 11, :scale => 0, :default => 0,  :null => false
    t.string   "title"
    t.string   "email"
    t.string   "host"
    t.integer  "comment_age",                        :precision => 11, :scale => 0
    t.string   "timezone"
    t.datetime "created_at",                                                                        :null => false
    t.datetime "updated_at",                                                                        :null => false
    t.datetime "started_at"
    t.datetime "ended_at"
    t.datetime "expected_at"
    t.float    "done_hours"
    t.float    "expected_hours"
    t.integer  "updated_by_user_id",                 :precision => 11, :scale => 0, :default => 1,  :null => false
    t.integer  "created_by_user_id",                 :precision => 11, :scale => 0, :default => 1,  :null => false
  end

  add_index "projects", ["created_at"], :name => "projects_idx10"
  add_index "projects", ["updated_at"], :name => "projects_idx11"
  add_index "projects", ["updated_by_user_id"], :name => "projects_idx17"
  add_index "projects", ["created_by_user_id"], :name => "projects_idx18"
  add_index "projects", ["name"], :name => "projects_idx2"
  add_index "projects", ["status_id"], :name => "projects_idx4"

  create_table "protocol_versions", :force => true do |t|
    t.integer  "study_protocol_id",                 :precision => 11, :scale => 0
    t.string   "name",               :limit => 77
    t.integer  "version",            :limit => 6,   :precision => 6,  :scale => 0,                :null => false
    t.integer  "lock_version",                      :precision => 11, :scale => 0, :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "how_to",             :limit => nil
    t.integer  "report_id",                         :precision => 11, :scale => 0
    t.integer  "analysis_id",                       :precision => 11, :scale => 0
    t.integer  "updated_by_user_id",                :precision => 11, :scale => 0, :default => 1, :null => false
    t.integer  "created_by_user_id",                :precision => 11, :scale => 0, :default => 1, :null => false
  end

  add_index "protocol_versions", ["name"], :name => "process_versions_idx1"
  add_index "protocol_versions", ["study_protocol_id"], :name => "process_versions_idx2"
  add_index "protocol_versions", ["updated_at"], :name => "process_versions_idx3"
  add_index "protocol_versions", ["analysis_id"], :name => "protocol_versions_idx10"
  add_index "protocol_versions", ["updated_by_user_id"], :name => "protocol_versions_idx11"
  add_index "protocol_versions", ["created_by_user_id"], :name => "protocol_versions_idx12"
  add_index "protocol_versions", ["created_at"], :name => "protocol_versions_idx6"
  add_index "protocol_versions", ["report_id"], :name => "protocol_versions_idx9"

  create_table "queue_items", :force => true do |t|
    t.string   "name"
    t.string   "comments",             :limit => 1024,                                :default => "", :null => false
    t.integer  "study_queue_id",                       :precision => 11, :scale => 0
    t.integer  "experiment_id",                        :precision => 11, :scale => 0
    t.integer  "task_id",                              :precision => 11, :scale => 0
    t.integer  "study_parameter_id",                   :precision => 11, :scale => 0
    t.string   "data_type"
    t.integer  "data_id",                              :precision => 11, :scale => 0
    t.string   "data_name"
    t.datetime "expected_at"
    t.datetime "started_at"
    t.datetime "ended_at"
    t.datetime "created_at",                                                                          :null => false
    t.datetime "updated_at",                                                                          :null => false
    t.integer  "request_service_id",                   :precision => 11, :scale => 0
    t.integer  "status_id",                            :precision => 11, :scale => 0, :default => 0,  :null => false
    t.integer  "priority_id",                          :precision => 11, :scale => 0
    t.integer  "updated_by_user_id",                   :precision => 11, :scale => 0, :default => 1,  :null => false
    t.integer  "created_by_user_id",                   :precision => 11, :scale => 0, :default => 1,  :null => false
    t.integer  "requested_by_user_id",                 :precision => 11, :scale => 0, :default => 1
    t.integer  "assigned_to_user_id",                  :precision => 11, :scale => 0, :default => 1
  end

  add_index "queue_items", ["created_at"], :name => "queue_items_idx15"
  add_index "queue_items", ["updated_at"], :name => "queue_items_idx16"
  add_index "queue_items", ["request_service_id"], :name => "queue_items_idx17"
  add_index "queue_items", ["status_id"], :name => "queue_items_idx18"
  add_index "queue_items", ["priority_id"], :name => "queue_items_idx19"
  add_index "queue_items", ["name"], :name => "queue_items_idx2"
  add_index "queue_items", ["updated_by_user_id"], :name => "queue_items_idx20"
  add_index "queue_items", ["created_by_user_id"], :name => "queue_items_idx21"
  add_index "queue_items", ["requested_by_user_id"], :name => "queue_items_idx22"
  add_index "queue_items", ["assigned_to_user_id"], :name => "queue_items_idx23"
  add_index "queue_items", ["study_queue_id"], :name => "queue_items_idx4"
  add_index "queue_items", ["experiment_id"], :name => "queue_items_idx5"
  add_index "queue_items", ["task_id"], :name => "queue_items_idx6"
  add_index "queue_items", ["study_parameter_id"], :name => "queue_items_idx7"
  add_index "queue_items", ["data_id"], :name => "queue_items_idx9"

  create_table "report_columns", :force => true do |t|
    t.integer  "report_id",                          :precision => 11, :scale => 0,                   :null => false
    t.string   "name",               :limit => 128,                                 :default => "",   :null => false
    t.string   "description",        :limit => 1024,                                :default => ""
    t.string   "join_model"
    t.string   "label"
    t.string   "action"
    t.string   "filter_operation"
    t.string   "filter_text"
    t.string   "subject_type"
    t.integer  "subject_id",                         :precision => 11, :scale => 0
    t.integer  "data_element",                       :precision => 11, :scale => 0
    t.boolean  "is_visible",         :limit => 1,                                   :default => true
    t.boolean  "is_filterible",      :limit => 1,                                   :default => true
    t.boolean  "is_sortable",        :limit => 1,                                   :default => true
    t.integer  "order_num",                          :precision => 11, :scale => 0
    t.integer  "sort_num",                           :precision => 11, :scale => 0
    t.string   "sort_direction",     :limit => 11
    t.integer  "lock_version",                       :precision => 11, :scale => 0, :default => 0,    :null => false
    t.datetime "created_at",                                                                          :null => false
    t.datetime "updated_at",                                                                          :null => false
    t.string   "join_name"
    t.integer  "updated_by_user_id",                 :precision => 11, :scale => 0, :default => 1,    :null => false
    t.integer  "created_by_user_id",                 :precision => 11, :scale => 0, :default => 1,    :null => false
  end

  add_index "report_columns", ["subject_id"], :name => "report_columns_idx11"
  add_index "report_columns", ["report_id"], :name => "report_columns_idx2"
  add_index "report_columns", ["created_at"], :name => "report_columns_idx20"
  add_index "report_columns", ["updated_at"], :name => "report_columns_idx21"
  add_index "report_columns", ["updated_by_user_id"], :name => "report_columns_idx23"
  add_index "report_columns", ["created_by_user_id"], :name => "report_columns_idx24"
  add_index "report_columns", ["name"], :name => "report_columns_idx3"

  create_table "reports", :force => true do |t|
    t.string   "name",               :limit => 128,                                 :default => "", :null => false
    t.string   "description",        :limit => 1024,                                :default => "", :null => false
    t.string   "base_model"
    t.string   "custom_sql"
    t.integer  "lock_version",                       :precision => 11, :scale => 0, :default => 0,  :null => false
    t.datetime "created_at",                                                                        :null => false
    t.datetime "updated_at",                                                                        :null => false
    t.string   "style"
    t.integer  "updated_by_user_id",                 :precision => 11, :scale => 0, :default => 1,  :null => false
    t.integer  "created_by_user_id",                 :precision => 11, :scale => 0, :default => 1,  :null => false
    t.boolean  "internal",           :limit => 1
    t.integer  "project_id",                         :precision => 11, :scale => 0
    t.string   "action"
  end

  add_index "reports", ["updated_by_user_id"], :name => "reports_idx10"
  add_index "reports", ["created_by_user_id"], :name => "reports_idx11"
  add_index "reports", ["project_id"], :name => "reports_idx13"
  add_index "reports", ["name"], :name => "reports_idx2"
  add_index "reports", ["created_at"], :name => "reports_idx7"
  add_index "reports", ["updated_at"], :name => "reports_idx8"

  create_table "request_services", :force => true do |t|
    t.integer  "request_id",                           :precision => 11, :scale => 0,                 :null => false
    t.integer  "service_id",                           :precision => 11, :scale => 0,                 :null => false
    t.string   "name",                 :limit => 128,                                 :default => "", :null => false
    t.string   "description",          :limit => 1024,                                :default => ""
    t.datetime "expected_at"
    t.datetime "started_at"
    t.datetime "ended_at"
    t.datetime "created_at",                                                                          :null => false
    t.datetime "updated_at",                                                                          :null => false
    t.integer  "status_id",                            :precision => 11, :scale => 0, :default => 0,  :null => false
    t.integer  "priority_id",                          :precision => 11, :scale => 0
    t.integer  "updated_by_user_id",                   :precision => 11, :scale => 0, :default => 1,  :null => false
    t.integer  "created_by_user_id",                   :precision => 11, :scale => 0, :default => 1,  :null => false
    t.integer  "requested_by_user_id",                 :precision => 11, :scale => 0, :default => 1
    t.integer  "assigned_to_user_id",                  :precision => 11, :scale => 0, :default => 1
  end

  add_index "request_services", ["created_at"], :name => "request_services_idx10"
  add_index "request_services", ["updated_at"], :name => "request_services_idx11"
  add_index "request_services", ["status_id"], :name => "request_services_idx12"
  add_index "request_services", ["priority_id"], :name => "request_services_idx13"
  add_index "request_services", ["updated_by_user_id"], :name => "request_services_idx14"
  add_index "request_services", ["created_by_user_id"], :name => "request_services_idx15"
  add_index "request_services", ["requested_by_user_id"], :name => "request_services_idx16"
  add_index "request_services", ["assigned_to_user_id"], :name => "request_services_idx17"
  add_index "request_services", ["request_id"], :name => "request_services_idx2"
  add_index "request_services", ["service_id"], :name => "request_services_idx3"
  add_index "request_services", ["name"], :name => "request_services_idx4"

  create_table "requests", :force => true do |t|
    t.string   "name",                 :limit => 128,                                 :default => "", :null => false
    t.string   "description",          :limit => 1024,                                :default => "", :null => false
    t.datetime "expected_at"
    t.integer  "lock_version",                         :precision => 11, :scale => 0, :default => 0,  :null => false
    t.datetime "created_at",                                                                          :null => false
    t.datetime "updated_at",                                                                          :null => false
    t.integer  "list_id",                              :precision => 11, :scale => 0
    t.integer  "data_element_id",                      :precision => 11, :scale => 0
    t.integer  "status_id",                            :precision => 11, :scale => 0, :default => 0,  :null => false
    t.integer  "priority_id",                          :precision => 11, :scale => 0
    t.integer  "project_id",                           :precision => 11, :scale => 0
    t.integer  "updated_by_user_id",                   :precision => 11, :scale => 0, :default => 1,  :null => false
    t.integer  "created_by_user_id",                   :precision => 11, :scale => 0, :default => 1,  :null => false
    t.integer  "requested_by_user_id",                 :precision => 11, :scale => 0, :default => 1
    t.datetime "started_at"
    t.datetime "ended_at"
  end

  add_index "requests", ["status_id"], :name => "requests_idx10"
  add_index "requests", ["priority_id"], :name => "requests_idx11"
  add_index "requests", ["project_id"], :name => "requests_idx12"
  add_index "requests", ["updated_by_user_id"], :name => "requests_idx13"
  add_index "requests", ["created_by_user_id"], :name => "requests_idx14"
  add_index "requests", ["requested_by_user_id"], :name => "requests_idx15"
  add_index "requests", ["name"], :name => "requests_idx2"
  add_index "requests", ["created_at"], :name => "requests_idx6"
  add_index "requests", ["updated_at"], :name => "requests_idx7"
  add_index "requests", ["list_id"], :name => "requests_idx8"
  add_index "requests", ["data_element_id"], :name => "requests_idx9"

  create_table "role_permissions", :force => true do |t|
    t.integer "role_id",                     :precision => 11, :scale => 0, :null => false
    t.integer "permission_id",               :precision => 11, :scale => 0
    t.string  "subject",       :limit => 40
    t.string  "action",        :limit => 40
  end

  add_index "role_permissions", ["role_id"], :name => "roles_permission_idx1"
  add_index "role_permissions", ["permission_id"], :name => "roles_permission_idx2"

  create_table "roles", :force => true do |t|
    t.string   "name",                                                              :default => "", :null => false
    t.integer  "parent_id",                          :precision => 11, :scale => 0
    t.string   "description",        :limit => 1024,                                :default => "", :null => false
    t.string   "cache",              :limit => 4000,                                :default => ""
    t.datetime "created_at",                                                                        :null => false
    t.datetime "updated_at",                                                                        :null => false
    t.integer  "created_by_user_id",                 :precision => 11, :scale => 0, :default => 1,  :null => false
    t.integer  "updated_by_user_id",                 :precision => 11, :scale => 0, :default => 1,  :null => false
    t.string   "type"
  end

  add_index "roles", ["updated_by_user_id"], :name => "roles_idx10"
  add_index "roles", ["name"], :name => "roles_idx2"
  add_index "roles", ["created_at"], :name => "roles_idx7"
  add_index "roles", ["updated_at"], :name => "roles_idx8"
  add_index "roles", ["created_by_user_id"], :name => "roles_idx9"
  add_index "roles", ["parent_id"], :name => "role_parent_idx"

  create_table "samples", :force => true do |t|
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id",                                                     :default => ""
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "status",          :limit => 8,                                   :default => "OPEN"
    t.integer  "user_id",                         :precision => 11, :scale => 0
    t.string   "username",        :limit => 40,                                  :default => "user"
    t.string   "client_user",     :limit => 32
    t.string   "client_exe",      :limit => 64
    t.string   "client_terminal", :limit => 64
    t.string   "client_info",     :limit => 64
    t.string   "client_host",     :limit => 64
    t.string   "client_ip",       :limit => 64
    t.string   "code_module",     :limit => 64
    t.string   "code_action",     :limit => 64
    t.string   "comments",        :limit => 2000
    t.text     "data",            :limit => nil
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "sessions_idx2"
  add_index "sessions", ["created_at"], :name => "sessions_idx4"
  add_index "sessions", ["updated_at"], :name => "sessions_idx5"

  create_table "signatures", :force => true do |t|
    t.string   "content_hash"
    t.integer  "signer",           :precision => 11, :scale => 0
    t.string   "public_key"
    t.string   "signature_format"
    t.string   "signature_role"
    t.string   "signature_state"
    t.string   "reason"
    t.datetime "requested_date"
    t.datetime "signed_date"
    t.integer  "project_element",  :precision => 11, :scale => 0
  end

  create_table "specimens", :force => true do |t|
    t.string   "name",               :limit => 128,                                 :default => "", :null => false
    t.string   "description",        :limit => 1024,                                :default => "", :null => false
    t.float    "weight"
    t.string   "sex"
    t.datetime "birth"
    t.datetime "age"
    t.string   "taxon_domain"
    t.string   "taxon_kingdom"
    t.string   "taxon_phylum"
    t.string   "taxon_class"
    t.string   "taxon_family"
    t.string   "taxon_order"
    t.string   "taxon_genus"
    t.string   "taxon_species"
    t.string   "taxon_subspecies"
    t.integer  "lock_version",                       :precision => 11, :scale => 0, :default => 0,  :null => false
    t.datetime "created_at",                                                                        :null => false
    t.datetime "updated_at",                                                                        :null => false
    t.integer  "updated_by_user_id",                 :precision => 11, :scale => 0, :default => 1,  :null => false
    t.integer  "created_by_user_id",                 :precision => 11, :scale => 0, :default => 1,  :null => false
  end

  add_index "specimens", ["created_at"], :name => "specimens_idx18"
  add_index "specimens", ["updated_at"], :name => "specimens_idx19"
  add_index "specimens", ["name"], :name => "specimens_idx2"
  add_index "specimens", ["updated_by_user_id"], :name => "specimens_idx20"
  add_index "specimens", ["created_by_user_id"], :name => "specimens_idx21"

  create_table "studies", :force => true do |t|
    t.string   "name",               :limit => 128,                                 :default => "", :null => false
    t.string   "description",        :limit => 1024,                                :default => "", :null => false
    t.integer  "category_id",                        :precision => 11, :scale => 0
    t.string   "research_area"
    t.string   "purpose"
    t.integer  "lock_version",                       :precision => 11, :scale => 0, :default => 0,  :null => false
    t.datetime "created_at",                                                                        :null => false
    t.datetime "updated_at",                                                                        :null => false
    t.integer  "project_id",                         :precision => 11, :scale => 0,                 :null => false
    t.integer  "updated_by_user_id",                 :precision => 11, :scale => 0, :default => 1,  :null => false
    t.integer  "created_by_user_id",                 :precision => 11, :scale => 0, :default => 1,  :null => false
    t.datetime "started_at"
    t.datetime "ended_at"
    t.datetime "expected_at"
    t.integer  "status_id",                          :precision => 11, :scale => 0, :default => 0,  :null => false
  end

  add_index "studies", ["name"], :name => "studies_idx1"
  add_index "studies", ["project_id"], :name => "studies_idx10"
  add_index "studies", ["updated_by_user_id"], :name => "studies_idx11"
  add_index "studies", ["created_by_user_id"], :name => "studies_idx12"
  add_index "studies", ["status_id"], :name => "studies_idx16"
  add_index "studies", ["updated_at"], :name => "studies_idx2"
  add_index "studies", ["category_id"], :name => "studies_idx4"
  add_index "studies", ["created_at"], :name => "studies_idx8"

  create_table "study_logs", :force => true do |t|
    t.integer  "study_id",                      :precision => 11, :scale => 0
    t.integer  "user_id",                       :precision => 11, :scale => 0
    t.integer  "auditable_id",                  :precision => 11, :scale => 0
    t.string   "auditable_type"
    t.string   "action"
    t.string   "name"
    t.string   "comments"
    t.text     "changes",        :limit => nil
    t.string   "created_by"
    t.datetime "created_at"
  end

  add_index "study_logs", ["study_id"], :name => "study_logs_idx1"
  add_index "study_logs", ["user_id"], :name => "study_logs_idx2"
  add_index "study_logs", ["auditable_type", "auditable_id"], :name => "study_logs_idx3"
  add_index "study_logs", ["created_at"], :name => "study_logs_idx4"
  add_index "study_logs", ["name"], :name => "study_logs_idx7"

  create_table "study_parameters", :force => true do |t|
    t.integer "parameter_type_id",                  :precision => 11, :scale => 0,                 :null => false
    t.integer "parameter_role_id",                  :precision => 11, :scale => 0,                 :null => false
    t.integer "study_id",                           :precision => 11, :scale => 0, :default => 1
    t.string  "name",                                                              :default => "", :null => false
    t.string  "default_value"
    t.integer "data_element_id",                    :precision => 11, :scale => 0
    t.integer "data_type_id",                       :precision => 11, :scale => 0,                 :null => false
    t.integer "data_format_id",                     :precision => 11, :scale => 0
    t.string  "description",        :limit => 1024,                                :default => "", :null => false
    t.string  "display_unit"
    t.integer "created_by_user_id",                 :precision => 11, :scale => 0, :default => 1,  :null => false
    t.integer "updated_by_user_id",                 :precision => 11, :scale => 0, :default => 1,  :null => false
  end

  add_index "study_parameters", ["study_id"], :name => "study_parameters_idx1"
  add_index "study_parameters", ["created_by_user_id"], :name => "study_parameters_idx12"
  add_index "study_parameters", ["updated_by_user_id"], :name => "study_parameters_idx13"
  add_index "study_parameters", ["name"], :name => "study_parameters_idx2"
  add_index "study_parameters", ["parameter_type_id"], :name => "study_parameters_idx3"
  add_index "study_parameters", ["parameter_role_id"], :name => "study_parameters_idx4"
  add_index "study_parameters", ["data_element_id"], :name => "study_parameters_idx7"
  add_index "study_parameters", ["data_type_id"], :name => "study_parameters_idx8"
  add_index "study_parameters", ["data_format_id"], :name => "study_parameters_idx9"

  create_table "study_protocols", :force => true do |t|
    t.integer  "study_id",                              :precision => 11, :scale => 0,                      :null => false
    t.integer  "study_stage_id",                        :precision => 11, :scale => 0, :default => 1,       :null => false
    t.integer  "current_process_id",                    :precision => 11, :scale => 0
    t.integer  "process_definition_id",                 :precision => 11, :scale => 0
    t.string   "process_style",         :limit => 128,                                 :default => "Entry", :null => false
    t.string   "name",                  :limit => 128,                                 :default => "",      :null => false
    t.string   "description",           :limit => 1024,                                :default => ""
    t.string   "literature_ref",        :limit => 1024,                                :default => ""
    t.string   "protocol_catagory",     :limit => 20
    t.string   "protocol_status",       :limit => 20
    t.integer  "lock_version",                          :precision => 11, :scale => 0, :default => 0,       :null => false
    t.datetime "created_at",                                                                                :null => false
    t.datetime "updated_at",                                                                                :null => false
    t.integer  "updated_by_user_id",                    :precision => 11, :scale => 0, :default => 1,       :null => false
    t.integer  "created_by_user_id",                    :precision => 11, :scale => 0, :default => 1,       :null => false
  end

  add_index "study_protocols", ["study_id"], :name => "study_protocols_idx1"
  add_index "study_protocols", ["created_at"], :name => "study_protocols_idx13"
  add_index "study_protocols", ["updated_at"], :name => "study_protocols_idx14"
  add_index "study_protocols", ["updated_by_user_id"], :name => "study_protocols_idx15"
  add_index "study_protocols", ["created_by_user_id"], :name => "study_protocols_idx16"
  add_index "study_protocols", ["current_process_id"], :name => "study_protocols_idx2"
  add_index "study_protocols", ["process_definition_id"], :name => "study_protocols_idx3"
  add_index "study_protocols", ["name"], :name => "study_protocols_idx7"

  create_table "study_queues", :force => true do |t|
    t.string   "name",                :limit => 128,                                 :default => "",       :null => false
    t.string   "description",         :limit => 1024,                                :default => "",       :null => false
    t.integer  "study_id",                            :precision => 11, :scale => 0,                       :null => false
    t.integer  "study_stage_id",                      :precision => 11, :scale => 0
    t.integer  "study_parameter_id",                  :precision => 11, :scale => 0,                       :null => false
    t.integer  "study_protocol_id",                   :precision => 11, :scale => 0
    t.string   "status",                                                             :default => "new",    :null => false
    t.string   "priority",                                                           :default => "normal", :null => false
    t.integer  "lock_version",                        :precision => 11, :scale => 0, :default => 0,        :null => false
    t.datetime "created_at",                                                                               :null => false
    t.datetime "updated_at",                                                                               :null => false
    t.integer  "updated_by_user_id",                  :precision => 11, :scale => 0, :default => 1,        :null => false
    t.integer  "created_by_user_id",                  :precision => 11, :scale => 0, :default => 1,        :null => false
    t.integer  "assigned_to_user_id",                 :precision => 11, :scale => 0, :default => 1
  end

  add_index "study_queues", ["created_at"], :name => "study_queues_idx11"
  add_index "study_queues", ["updated_at"], :name => "study_queues_idx12"
  add_index "study_queues", ["updated_by_user_id"], :name => "study_queues_idx13"
  add_index "study_queues", ["created_by_user_id"], :name => "study_queues_idx14"
  add_index "study_queues", ["assigned_to_user_id"], :name => "study_queues_idx15"
  add_index "study_queues", ["name"], :name => "study_queues_idx2"
  add_index "study_queues", ["study_id"], :name => "study_queues_idx4"
  add_index "study_queues", ["study_stage_id"], :name => "study_queues_idx5"
  add_index "study_queues", ["study_parameter_id"], :name => "study_queues_idx6"
  add_index "study_queues", ["study_protocol_id"], :name => "study_queues_idx7"

  create_table "study_stages", :force => true do |t|
    t.string   "name",               :limit => 128,                                 :default => "", :null => false
    t.string   "description",        :limit => 1024,                                :default => "", :null => false
    t.integer  "lock_version",                       :precision => 11, :scale => 0, :default => 0,  :null => false
    t.datetime "created_at",                                                                        :null => false
    t.datetime "updated_at",                                                                        :null => false
    t.integer  "updated_by_user_id",                 :precision => 11, :scale => 0, :default => 1,  :null => false
    t.integer  "created_by_user_id",                 :precision => 11, :scale => 0, :default => 1,  :null => false
  end

  add_index "study_stages", ["name"], :name => "study_stages_idx2"
  add_index "study_stages", ["created_at"], :name => "study_stages_idx5"
  add_index "study_stages", ["updated_at"], :name => "study_stages_idx6"
  add_index "study_stages", ["updated_by_user_id"], :name => "study_stages_idx7"
  add_index "study_stages", ["created_by_user_id"], :name => "study_stages_idx8"

  create_table "system_settings", :force => true do |t|
    t.string   "name",               :limit => 30,                                :default => "",  :null => false
    t.string   "description",                                                     :default => "",  :null => false
    t.string   "text",                                                            :default => "0", :null => false
    t.datetime "created_at",                                                                       :null => false
    t.datetime "updated_at",                                                                       :null => false
    t.integer  "updated_by_user_id",               :precision => 11, :scale => 0, :default => 1,   :null => false
    t.integer  "created_by_user_id",               :precision => 11, :scale => 0, :default => 1,   :null => false
  end

  add_index "system_settings", ["name"], :name => "system_settings_idx2"
  add_index "system_settings", ["created_at"], :name => "system_settings_idx5"
  add_index "system_settings", ["updated_at"], :name => "system_settings_idx6"
  add_index "system_settings", ["updated_by_user_id"], :name => "system_settings_idx7"
  add_index "system_settings", ["created_by_user_id"], :name => "system_settings_idx8"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id",        :precision => 11, :scale => 0
    t.integer  "taggable_id",   :precision => 11, :scale => 0
    t.string   "taggable_type"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "taggings_idx2"
  add_index "taggings", ["taggable_id"], :name => "taggings_idx3"
  add_index "taggings", ["created_at"], :name => "taggings_idx5"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  add_index "tags", ["name"], :name => "tags_idx2"

  create_table "task_contexts", :force => true do |t|
    t.integer "task_id",                           :precision => 11, :scale => 0,                :null => false
    t.integer "parameter_context_id",              :precision => 11, :scale => 0,                :null => false
    t.string  "label"
    t.boolean "is_valid",             :limit => 1
    t.integer "row_no",                            :precision => 11, :scale => 0,                :null => false
    t.integer "parent_id",                         :precision => 11, :scale => 0
    t.integer "sequence_no",                       :precision => 11, :scale => 0,                :null => false
    t.integer "left_limit",                        :precision => 11, :scale => 0, :default => 1
    t.integer "right_limit",                       :precision => 11, :scale => 0, :default => 2
  end

  add_index "task_contexts", ["task_id"], :name => "task_contexts_idx1"
  add_index "task_contexts", ["parameter_context_id"], :name => "task_contexts_idx2"
  add_index "task_contexts", ["row_no"], :name => "task_contexts_idx3"
  add_index "task_contexts", ["label"], :name => "task_contexts_idx4"
  add_index "task_contexts", ["is_valid"], :name => "task_contexts_idx5"
  add_index "task_contexts", ["parent_id"], :name => "task_contexts_idx7"

  create_table "task_references", :force => true do |t|
    t.integer  "task_context_id",    :precision => 11, :scale => 0,                :null => false
    t.integer  "parameter_id",       :precision => 11, :scale => 0,                :null => false
    t.integer  "data_element_id",    :precision => 11, :scale => 0
    t.string   "data_type",                                                        :null => false
    t.integer  "data_id",            :precision => 11, :scale => 0,                :null => false
    t.string   "data_name"
    t.integer  "lock_version",       :precision => 11, :scale => 0, :default => 0, :null => false
    t.datetime "created_at",                                                       :null => false
    t.datetime "updated_at",                                                       :null => false
    t.integer  "task_id",            :precision => 11, :scale => 0,                :null => false
    t.integer  "updated_by_user_id", :precision => 11, :scale => 0, :default => 1, :null => false
    t.integer  "created_by_user_id", :precision => 11, :scale => 0, :default => 1, :null => false
  end

  add_index "task_references", ["task_id"], :name => "task_references_idx1"
  add_index "task_references", ["updated_by_user_id"], :name => "task_references_idx12"
  add_index "task_references", ["created_by_user_id"], :name => "task_references_idx13"
  add_index "task_references", ["task_context_id"], :name => "task_references_idx2"
  add_index "task_references", ["parameter_id"], :name => "task_references_idx3"
  add_index "task_references", ["updated_at"], :name => "task_references_idx4"
  add_index "task_references", ["data_id"], :name => "task_references_idx6"
  add_index "task_references", ["created_at"], :name => "task_references_idx9"

  create_table "task_relations", :force => true do |t|
    t.integer "to_task_id",   :precision => 11, :scale => 0
    t.integer "from_task_id", :precision => 11, :scale => 0
    t.integer "relation_id",  :precision => 11, :scale => 0
  end

  add_index "task_relations", ["to_task_id"], :name => "task_relations_idx2"
  add_index "task_relations", ["from_task_id"], :name => "task_relations_idx3"
  add_index "task_relations", ["relation_id"], :name => "task_relations_idx4"

  create_table "task_texts", :force => true do |t|
    t.integer  "task_context_id",                    :precision => 11, :scale => 0,                :null => false
    t.integer  "parameter_id",                       :precision => 11, :scale => 0,                :null => false
    t.string   "data_content",       :limit => 1000
    t.integer  "lock_version",                       :precision => 11, :scale => 0, :default => 0, :null => false
    t.datetime "created_at",                                                                       :null => false
    t.datetime "updated_at",                                                                       :null => false
    t.integer  "task_id",                            :precision => 11, :scale => 0,                :null => false
    t.integer  "updated_by_user_id",                 :precision => 11, :scale => 0, :default => 1, :null => false
    t.integer  "created_by_user_id",                 :precision => 11, :scale => 0, :default => 1, :null => false
  end

  add_index "task_texts", ["task_id"], :name => "task_texts_idx1"
  add_index "task_texts", ["updated_by_user_id"], :name => "task_texts_idx10"
  add_index "task_texts", ["created_by_user_id"], :name => "task_texts_idx11"
  add_index "task_texts", ["task_context_id"], :name => "task_texts_idx2"
  add_index "task_texts", ["parameter_id"], :name => "task_texts_idx3"
  add_index "task_texts", ["updated_at"], :name => "task_texts_idx4"
  add_index "task_texts", ["created_at"], :name => "task_texts_idx7"

  create_table "task_values", :force => true do |t|
    t.integer  "task_context_id",    :precision => 11, :scale => 0,                :null => false
    t.integer  "parameter_id",       :precision => 11, :scale => 0,                :null => false
    t.float    "data_value",                                                       :null => false
    t.string   "display_unit"
    t.integer  "lock_version",       :precision => 11, :scale => 0, :default => 0, :null => false
    t.datetime "created_at",                                                       :null => false
    t.datetime "updated_at",                                                       :null => false
    t.integer  "task_id",            :precision => 11, :scale => 0,                :null => false
    t.string   "storage_unit"
    t.integer  "updated_by_user_id", :precision => 11, :scale => 0, :default => 1, :null => false
    t.integer  "created_by_user_id", :precision => 11, :scale => 0, :default => 1, :null => false
  end

  add_index "task_values", ["task_id"], :name => "task_values_idx1"
  add_index "task_values", ["updated_by_user_id"], :name => "task_values_idx11"
  add_index "task_values", ["created_by_user_id"], :name => "task_values_idx12"
  add_index "task_values", ["task_context_id"], :name => "task_values_idx2"
  add_index "task_values", ["parameter_id"], :name => "task_values_idx3"
  add_index "task_values", ["updated_at"], :name => "task_values_idx4"
  add_index "task_values", ["data_value"], :name => "task_values_idx5"
  add_index "task_values", ["created_at"], :name => "task_values_idx7"

  create_table "tasks", :force => true do |t|
    t.string   "name",                :limit => 128,                                 :default => "", :null => false
    t.string   "description",         :limit => 1024,                                :default => "", :null => false
    t.integer  "experiment_id",                       :precision => 11, :scale => 0,                 :null => false
    t.integer  "protocol_version_id",                 :precision => 11, :scale => 0,                 :null => false
    t.integer  "status_id",                           :precision => 11, :scale => 0, :default => 0,  :null => false
    t.boolean  "is_milestone",        :limit => 1
    t.integer  "priority_id",                         :precision => 11, :scale => 0
    t.datetime "started_at"
    t.datetime "ended_at"
    t.float    "expected_hours"
    t.float    "done_hours"
    t.integer  "lock_version",                        :precision => 11, :scale => 0, :default => 0,  :null => false
    t.datetime "created_at",                                                                         :null => false
    t.datetime "updated_at",                                                                         :null => false
    t.integer  "study_protocol_id",                   :precision => 11, :scale => 0
    t.integer  "project_id",                          :precision => 11, :scale => 0,                 :null => false
    t.integer  "updated_by_user_id",                  :precision => 11, :scale => 0, :default => 1,  :null => false
    t.integer  "created_by_user_id",                  :precision => 11, :scale => 0, :default => 1,  :null => false
    t.integer  "assigned_to_user_id",                 :precision => 11, :scale => 0, :default => 1
    t.datetime "expected_at"
  end

  add_index "tasks", ["name"], :name => "tasks_idx1"
  add_index "tasks", ["created_at"], :name => "tasks_idx14"
  add_index "tasks", ["updated_at"], :name => "tasks_idx15"
  add_index "tasks", ["project_id"], :name => "tasks_idx17"
  add_index "tasks", ["updated_by_user_id"], :name => "tasks_idx18"
  add_index "tasks", ["created_by_user_id"], :name => "tasks_idx19"
  add_index "tasks", ["experiment_id"], :name => "tasks_idx2"
  add_index "tasks", ["assigned_to_user_id"], :name => "tasks_idx20"
  add_index "tasks", ["protocol_version_id"], :name => "tasks_idx3"
  add_index "tasks", ["study_protocol_id"], :name => "tasks_idx4"
  add_index "tasks", ["started_at"], :name => "tasks_idx5"
  add_index "tasks", ["ended_at"], :name => "tasks_idx6"
  add_index "tasks", ["priority_id"], :name => "tasks_idx8"

  create_table "teams", :force => true do |t|
    t.string   "name",               :limit => 30,                                  :default => "", :null => false
    t.string   "description",        :limit => 2048,                                :default => "", :null => false
    t.integer  "status_id",                          :precision => 11, :scale => 0, :default => 0,  :null => false
    t.integer  "public_role_id",                     :precision => 11, :scale => 0,                 :null => false
    t.integer  "external_role_id",                   :precision => 11, :scale => 0
    t.string   "email"
    t.integer  "lock_version",                       :precision => 11, :scale => 0, :default => 0,  :null => false
    t.datetime "created_at",                                                                        :null => false
    t.integer  "created_by_user_id",                 :precision => 11, :scale => 0, :default => 1,  :null => false
    t.datetime "updated_at",                                                                        :null => false
    t.integer  "updated_by_user_id",                 :precision => 11, :scale => 0, :default => 1,  :null => false
  end

  create_table "tmp_data", :force => true do |t|
  end

  create_table "transactions", :force => true do |t|
    t.datetime "start_time",                                                                         :null => false
    t.datetime "end_time",                                                                           :null => false
    t.string   "status",          :limit => 8,                                   :default => "OPEN", :null => false
    t.integer  "user_id",                         :precision => 11, :scale => 0,                     :null => false
    t.string   "username",        :limit => 40,                                  :default => "user", :null => false
    t.integer  "session_id",                      :precision => 11, :scale => 0
    t.string   "client_user",     :limit => 32
    t.string   "client_exe",      :limit => 64
    t.string   "client_terminal", :limit => 64
    t.string   "client_info",     :limit => 64
    t.string   "client_host",     :limit => 64
    t.string   "client_ip",       :limit => 64
    t.string   "code_module",     :limit => 64
    t.string   "code_action",     :limit => 64
    t.string   "comments",        :limit => 2000
  end

  create_table "treatment_groups", :force => true do |t|
    t.string   "name",               :limit => 128,                                 :default => "", :null => false
    t.string   "description",        :limit => 1024,                                :default => "", :null => false
    t.integer  "study_id",                           :precision => 11, :scale => 0
    t.integer  "experiment_id",                      :precision => 11, :scale => 0
    t.integer  "lock_version",                       :precision => 11, :scale => 0, :default => 0,  :null => false
    t.datetime "created_at",                                                                        :null => false
    t.datetime "updated_at",                                                                        :null => false
    t.integer  "updated_by_user_id",                 :precision => 11, :scale => 0, :default => 1,  :null => false
    t.integer  "created_by_user_id",                 :precision => 11, :scale => 0, :default => 1,  :null => false
  end

  add_index "treatment_groups", ["created_by_user_id"], :name => "treatment_groups_idx10"
  add_index "treatment_groups", ["name"], :name => "treatment_groups_idx2"
  add_index "treatment_groups", ["study_id"], :name => "treatment_groups_idx4"
  add_index "treatment_groups", ["experiment_id"], :name => "treatment_groups_idx5"
  add_index "treatment_groups", ["created_at"], :name => "treatment_groups_idx7"
  add_index "treatment_groups", ["updated_at"], :name => "treatment_groups_idx8"
  add_index "treatment_groups", ["updated_by_user_id"], :name => "treatment_groups_idx9"

  create_table "treatment_items", :force => true do |t|
    t.integer "treatment_group_id", :precision => 11, :scale => 0,                 :null => false
    t.string  "subject_type",                                      :default => "", :null => false
    t.integer "subject_id",         :precision => 11, :scale => 0,                 :null => false
    t.integer "sequence_order",     :precision => 11, :scale => 0,                 :null => false
  end

  add_index "treatment_items", ["treatment_group_id"], :name => "treatment_items_idx2"
  add_index "treatment_items", ["subject_id"], :name => "treatment_items_idx4"

  create_table "user_settings", :force => true do |t|
    t.string   "name",               :limit => 30,                                  :default => "",  :null => false
    t.string   "description",        :limit => 1024,                                :default => "",  :null => false
    t.string   "value",                                                             :default => "0", :null => false
    t.datetime "created_at",                                                                         :null => false
    t.datetime "updated_at",                                                                         :null => false
    t.integer  "updated_by_user_id",                 :precision => 11, :scale => 0, :default => 1,   :null => false
    t.integer  "created_by_user_id",                 :precision => 11, :scale => 0, :default => 1,   :null => false
  end

  add_index "user_settings", ["name"], :name => "user_settings_idx2"
  add_index "user_settings", ["created_at"], :name => "user_settings_idx5"
  add_index "user_settings", ["updated_at"], :name => "user_settings_idx6"
  add_index "user_settings", ["updated_by_user_id"], :name => "user_settings_idx7"
  add_index "user_settings", ["created_by_user_id"], :name => "user_settings_idx8"

  create_table "users", :force => true do |t|
    t.string   "name",                                                            :default => "",    :null => false
    t.string   "password_hash",      :limit => 40
    t.integer  "role_id",                          :precision => 11, :scale => 0,                    :null => false
    t.string   "password_salt"
    t.string   "fullname"
    t.string   "email"
    t.string   "login",              :limit => 40
    t.string   "activation_code",    :limit => 40
    t.integer  "state_id",                         :precision => 11, :scale => 0
    t.datetime "activated_at"
    t.string   "token"
    t.datetime "token_expires_at"
    t.string   "filter"
    t.boolean  "admin",              :limit => 1,                                 :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.integer  "created_by_user_id",               :precision => 11, :scale => 0, :default => 1,     :null => false
    t.integer  "updated_by_user_id",               :precision => 11, :scale => 0, :default => 1,     :null => false
    t.boolean  "is_disabled",        :limit => 1,                                 :default => false
  end

  add_index "users", ["role_id"], :name => "fk_user_role_id"
  add_index "users", ["state_id"], :name => "users_idx10"
  add_index "users", ["created_at"], :name => "users_idx16"
  add_index "users", ["updated_at"], :name => "users_idx17"
  add_index "users", ["created_by_user_id"], :name => "users_idx19"
  add_index "users", ["name"], :name => "users_idx2"
  add_index "users", ["updated_by_user_id"], :name => "users_idx20"

end
