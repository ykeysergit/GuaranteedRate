require_relative 'record_adapter'

class Parser 
  def parse_text(text)
    records=[]
    string_handle = StringIO.open(text, 'r')
    
    string_handle.each_with_index do |line,index|
      next if index == 0 # first line is header
      records << RecordAdapter.new(line).adapt
    end
    
    string_handle.close
    records
  end
  
  def parse_file(file_path)
    records=[]
    file = File.open(file_path, 'r')
    
    file.each_with_index do |line, index|
      next if index == 0 # first line is header
      records << RecordAdapter.new(line).adapt
    end
    
    file.close
    records
  end
end
