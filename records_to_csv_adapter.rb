require_relative 'record'

class RecordsToCSVAdapter
  def initialize(records=[])
    @records=records
  end
  
  def adapt    
    output_csv = ['LastName', 'FirstName', 'Gender', 'FavoriteColor', 'DateOfBirth'].join(',')
    
    @records.each do |record|
      first_name=nil if record.first_name.length==0
      
      # Ruby-CSV puts quotes for empty strings
      
      output_csv << "\n"
      output_csv << [record.last_name,record.first_name,
        record.gender, record.fav_color, record.dob].join(',')
    end

    output_csv
  end
end