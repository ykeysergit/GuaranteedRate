class RecordAdapter
  SPACE=' '
  COMMA=','
  PIPE='|'
  
  FIELD_POSITIONS={
    LAST_NAME: 0,
    FIRST_NAME: 1,
    GENDER: 2,
    FAV_COLOR: 3,
    DOB: 4
  }
  
  def initialize(record_str)
    @record_str=record_str
  end
  
  def raw
    @record_str
  end
  
  def self.extract_fields(line='', delimiter=COMMA)
    return [] if delimiter.to_s.strip.length==0
    line=line.strip
    
    fields=[]
    field=''
    
    line.chars.each do|character|
      field+=character if character != delimiter
      
      if character == delimiter
        fields << field
        field=''
      end
    end
    
    fields<<field
    
    fields
  end
  
  def adapt
    delimiter = self.class.which_delimiter?(@record_str)
    fields = self.class.extract_fields(@record_str, delimiter)
    
    if fields.length == FIELD_POSITIONS.keys.length
      Record.new.set_first_name(fields[FIELD_POSITIONS[:FIRST_NAME]])
      .set_last_name(fields[FIELD_POSITIONS[:LAST_NAME]])
      .set_gender(fields[FIELD_POSITIONS[:GENDER]])
      .set_fav_color(fields[FIELD_POSITIONS[:FAV_COLOR]])
      .set_dob(fields[FIELD_POSITIONS[:DOB]])
    else
      Record.new
    end
  end
  
  def self.which_delimiter?(line)
    return SPACE if line.to_s.include?(SPACE)
    return COMMA if line.to_s.include?(COMMA)
    return PIPE if line.to_s.include?(PIPE)
  end
end