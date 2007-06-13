# Files and folders can be stored temporary on the clipboard.
# 
# Objects are not persisted to the database as the nature of a clipboard object
# is that it's temporary.
# 
# This is a basic collection of ProjectElements for addition to other folders.
# 
# 
class Clipboard
  include Enumerable
  attr_reader :elements
  attr_reader :cache
##
# Initialize clipboard object, with the @elements as empty
#
  def initialize
    @elements =[]
    @cache = []
  end

  def each
    initialize_cache
    @cache.each do |item|
      yield item
    end
  end
  
  def cache
    initialize_cache
    @cache
  end
#
# Dump elements to store
#
  def marshal_dump
    if @cache
      @elements = @cache.collect{|i|i.id}
    end
    @elements
  end
#
# Load elements from store
#
  def marshal_load(variables)
    initialize_cache
    @elements = variables
  end
  
##
# Add given element on clipboard unless it's already there
# 
  def add(element)
    initialize_cache
    if element and !@elements.find{|i|i.id == element.id}
      @elements << element.id 
      @cache << element 
    end
  end

##
# Remove given element from clipboard
# 
  def remove(element)
    initialize_cache
    @cache.delete(element)
  end

##
# filtered list of items
# 
  def filter(model)
    initialize_cache
    @cache.collect{ |f| f if f['reference_type'] == model.class }.uniq
  end
  
  def initialize_cache
    if @elements
      @cache = @elements.collect{|i| ProjectElement.find(i) }
    end
  end

end