require_relative 'sort_proxy'
require_relative 'last_name_comparator'
require_relative 'dob_comparator'
require_relative 'gender_comparator'

class RecordDataStore
  SORT_BY_BIRTHDATE=:birthdate
  SORT_BY_NAME=:name
  SORT_BY_GENDER=:gender
  CONTEXT=:records
  
  def initialize
    @datastore={
      records:[]
    }
  end
  
  def store(record)
    @datastore[:records] << record
  end
  
  def delete_all
    @datastore[:records].clear
  end
  
  def query(sort_by=nil)
    if sort_by == SORT_BY_GENDER
      SortProxy.new(@datastore[:records],[GenderComparator.new, LastNameComparator.new(LastNameComparator::ASC)]).sort!
    elsif sort_by == SORT_BY_BIRTHDATE
      SortProxy.new(@datastore[:records],[DOBComparator.new]).sort!
    elsif sort_by == SORT_BY_NAME
      SortProxy.new(@datastore[:records],[LastNameComparator.new(LastNameComparator::DESC)]).sort!
    else
      @datastore[:records]     
    end
  end
end