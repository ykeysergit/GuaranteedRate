require 'minitest/autorun'
require_relative 'gender_comparator'
require_relative 'rest_api/connection_adapters/memory_connection_adapter'
require_relative 'rest_api/rest_client'

class TestRESTAPI < MiniTest::Unit::TestCase
  def setup
    @datastore=RecordDataStore.new
    @connection_adapter = MemoryConnectionAdapter.new('/',MemoryConnectionAdapter::DEFAULT_CONTENT_TYPE,
    @datastore)
    @client=RESTClient.new(@connection_adapter)
  end
  
  def test_save_record
    rec=Record.new
    rec.set_first_name('John')
    rec.set_last_name('Smith')
    rec.set_fav_color('green')
    rec.set_gender(Record::MALE)
    rec.set_dob('06/12/1974')
    
    @client.save_record(rec)
    
    records = @datastore.query
    assert_equal 1, records.length
    assert records[0].kind_of?(Record)
    assert_equal rec, records[0]
    
    @datastore.delete_all
  end
  
  def test_retrieve_records_sort_by_name
    rec1=Record.new
    rec1.set_gender(Record::FEMALE)
    rec1.set_last_name('B')
    
    rec2=Record.new
    rec2.set_gender(Record::FEMALE)
    rec2.set_last_name('A')
    
    @client.save_record(rec1)
    @client.save_record(rec2)
    records = @datastore.query
    assert_equal 2, records.length
    assert records[0].kind_of?(Record)
    assert records[1].kind_of?(Record)
    assert_equal 'B', records[0].last_name
    assert_equal 'A', records[1].last_name
    
    json_resp = @client.retrieve_records_sorted_by_name
    assert json_resp.length>0
    
    json_parsed = JSON.parse(json_resp)
    assert_equal 2,json_parsed.length
    
    assert_equal 'B', json_parsed[0]['last_name']
    assert_equal 'A', json_parsed[1]['last_name']
    
    @datastore.delete_all
  end
end