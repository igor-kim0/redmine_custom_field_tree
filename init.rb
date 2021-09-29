Redmine::Plugin.register :redmine_custom_field_tree do
  name 'Redmine Tree Field'
  author 'Igor Kishinskiy'
  description ''
  version '0.0.0'
  requires_redmine version_or_higher: '4.1'
  url ''
  author_url ''
end

require_relative 'lib/format'
require 'tree_custom_field'