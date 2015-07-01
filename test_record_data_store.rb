require 'minitest/autorun'
require_relative 'record_data_store'
require_relative 'record'

class TestLastNameComparator < MiniTest::Unit::TestCase
  def setup
    @datastore=RecordDataStore.new
  end
  
  def test_save_record
    record=Record.new
    record.set_first_name('John')
    record.set_last_name('Smith')
    record.set_gender(Record::MALE)
    
    @datastore.store(record)
    
    records = @datastore.query
    assert_equal 1,records.length
    assert record,records[0]
    @datastore.delete_all
  end
  
  def test_retrieve_by_name
    record=Record.new
    record.set_first_name('John')
    record.set_last_name('Smith')
    record.set_gender(Record::MALE)
    
    @datastore.store(record)
    
    records = @datastore.query(RecordDataStore::SORT_BY_NAME)
    assert_equal 1,records.length
    assert record,records[0]
    
    @datastore.delete_all
  end
  
end