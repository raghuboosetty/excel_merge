require "excel_merge/version"

require "excel_merge/ext/string"
require "excel_merge/sheet"
require "excel_merge/merger"

# module ExcelMerge
#   class String
#     def sanitize
#       html_tags_regex = /<("[^"]*"|'[^']*'|[^'">])*>/
#       self.to_s.gsub(html_tags_regex, '') rescue nil
#     end
#   end
# end
