module ActiveRecord
  class SchemaDumper
    
    # A list of views which should not be dumped to the schema. 
    # Acceptable values are strings as well as regexp.
    # This setting is only used if ActiveRecord::Base.schema_format == :ruby
    cattr_accessor :ignore_views 
    @@ignore_views = []
    
    def trailer_with_views(stream)
      # do nothing...we'll call this later
    end
    alias_method_chain :trailer, :views
    
    # Add views to the end of the dump stream
    def dump_with_views(stream)
      dump_without_views(stream)
      begin
        if @connection.supports_views?
          views(stream)
        end
      rescue => e
        if ActiveRecord::Base.logger
          ActiveRecord::Base.logger.error "Unable to dump views: #{e}"
        else
          raise e
        end
      end
      trailer_without_views(stream)
      stream
    end
    alias_method_chain :dump, :views
    
    # Add views to the stream
    def views(stream)
      @connection.views.sort.each do |v|
        if ActiveRecord::Migrator.respond_to?(:schema_migrations_table_name)
          next if [ActiveRecord::Migrator.schema_migrations_table_name, ignore_views].flatten.any? do |ignored|
            case ignored
            when String then v == ignored
            when Symbol then v == ignored.to_s
            when Regexp then v =~ ignored
            else
              raise StandardError, 'ActiveRecord::SchemaDumper.ignore_views accepts an array of String and / or Regexp values.'
            end
          end
        end
        view(v, stream)
      end
    end
    
    # Add the specified view to the stream
    def view(view, stream)
      columns = @connection.columns(view).collect { |c| c.name }
      begin
        v = StringIO.new

        v.print "  create_view #{view.inspect}"
        v.print ", #{@connection.view_select_statement(view).dump}"
        v.print ", :force => true"
        v.puts " do |v|"

        columns.each do |column|
          v.print "    v.column :#{column}"
          v.puts
        end

        v.puts "  end"
        v.puts
        
        v.rewind
        stream.print v.read
      rescue => e
        stream.puts "# Could not dump view #{view.inspect} because of following #{e.class}"
        stream.puts "#   #{e.message}"
        stream.puts
      end
      
      stream
    end

    def tables(stream)
      @connection.nonview_tables.sort.each do |tbl|
        if ActiveRecord::Migrator.respond_to?(:schema_migrations_table_name)
          next if [ActiveRecord::Migrator.schema_migrations_table_name, ignore_tables].flatten.any? do |ignored|
            case ignored
            when String then tbl == ignored
            when Regexp then tbl =~ ignored
            else
              raise StandardError, 'ActiveRecord::SchemaDumper.ignore_tables accepts an array of String and / or Regexp values.'
            end
          end
        end
        table(tbl, stream)
      end
    end

  end
end
