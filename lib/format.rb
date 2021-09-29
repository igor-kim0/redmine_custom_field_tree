module TreeField
    class Format < Redmine::FieldFormat::Base
        NAME = 'tree'

        add NAME
        self.searchable_supported = true
        self.customized_class_names = %w(Issue)
        self.form_partial = 'custom_fields/formats/tree'

        def edit_tag(view, tag_id, tag_name, custom_value, options={})
            tag = "<select name=issue[custom_field_values][#{custom_value.custom_field.id}] id=\"issue_custom_field_values_#{custom_value.custom_field.id}\" class=\"list_cf\">"
            i = 0
            lines = custom_value.custom_field.possible_values.split("\r\n")
            lines.each do | line |
                curr_level = line.index( line.strip)
                nb = "&nbsp" * curr_level

                disabled = has_child( lines, i) ? "disabled" : ""
                
                path = "#{parent(lines, i)}#{line.strip}"
                selected = path == custom_value.value ? "selected" : ""

                tag << "<option value=\"#{path}\" #{selected} #{disabled}>#{nb}#{line.strip}</option>"
                i += 1
            end
            tag << "</select>"
            tag = tag.html_safe
        end        

        private

        def has_child( arr, num)

            if arr[num].index( arr[num].strip) == 0
                return false if arr.count == num
                return false if arr[num+1].index( arr[num+1].strip) == 0
                return true
            end

            return false
        end

        def parent( arr, num)
            name = ""
            while (arr[num].index( arr[num].strip) != 0) and (num > -1) do
                num -= 1
                name += ( arr[num] + " > " ) if arr[num+1].index( arr[num+1].strip) != arr[num].index( arr[num].strip)
            end
            name
        end
    end
end
