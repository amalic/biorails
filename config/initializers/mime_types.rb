# Be sure to restart your server when you modify this file.

# Add new mime types for use in respond_to blocks:
# Mime::Type.register "text/richtext", :rtf
# Mime::Type.register_alias "text/html", :iphone


#Mime::Type.register "application/msword", :doc, %w( text/html )
Mime::Type.register "application/msexcel", :xls
Mime::Type.register "application/pdf", :pdf
Mime::Type.register "text/richtext", :rtf
Mime::Type.register "image/svg+xml", :svg
Mime::Type.register "application/extjs", :ext
Mime::Type.register 'text/csv', :csv, %w('text/comma-separated-values')