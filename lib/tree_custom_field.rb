    module Patches
        module TreeCustomFieldPatch
            def self.included(base)
                base.send(:include, InstanceMethods)
                base.class_eval do
                    unloadable

                    alias_method :possible_values_without_tree=, :possible_values=
                    alias_method :possible_values=, :possible_values_with_tree=

                    alias_method :possible_values_without_tree, :possible_values
                    alias_method :possible_values, :possible_values_with_tree
                end
            end

            module InstanceMethods
       
                # 174332
                def possible_values_with_tree=(arg)
                    self.field_format == "tree" ? write_attribute(:possible_values, arg) : self.possible_values_without_tree=(arg)
                end

                def possible_values_with_tree
                    self.field_format == "tree" ? read_attribute(:possible_values) : possible_values_without_tree
                end
            end
        end
    end
  
unless CustomField.included_modules.include?(Patches::TreeCustomFieldPatch)
    CustomField.send(:include, Patches::TreeCustomFieldPatch)
end
  