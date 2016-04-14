module ExcelMerge
  class Sheet
    def initialize(file_path)
      @xls = Roo::Spreadsheet.open(file_path, :extension => :xls)
    end

    def each_sheet
      @xls.sheets.each do |sheet|
        @xls.default_sheet = sheet
        yield sheet
      end
    end

    def each_row
      0.upto(@xls.last_row) do |index|
        yield @xls.row(index)
      end
    end

    def each_column
      0.upto(@xls.last_column) do |index|
        yield @xls.column(index)
      end
    end

    def parse(columns=[])
      rows = [] # final rows - an array of hashes

      count = 0
      row_heads = {} # row heads from sheet
      downcased_columns = columns.map(&:downcase) # for matching
      self.each_row do |es_row|
        hash_mapped_row = {}
        if count.eql? 1 # skip first row(its nil)
          # select rows only with merge columns
          es_row.each_with_index do |es_row_head, index|
            row_heads[es_row_head] = index  if downcased_columns.include? es_row_head.downcase.strip
          end
          puts 'Empty row_head' if row_heads.empty?
        elsif count > 1
          row_heads.each do |head, index|
            hash_mapped_row[head] = es_row[index]
          end
          rows.push hash_mapped_row
        end
        count += 1
      end

      rows
    end
  end
end