require 'minitest/autorun'
require_relative 'record_adapter'
require_relative 'record'

class TestRecordAdapter < MiniTest::Unit::TestCase
  def test_which_delimiter
    adapter=RecordAdapter.new('')
    assert_equal RecordAdapter::COMMA, adapter.class.which_delimiter?(",")
    assert_equal RecordAdapter::SPACE, adapter.class.which_delimiter?(" ")
    assert_equal RecordAdapter::PIPE, adapter.class.which_delimiter?("|")
    assert_nil adapter.class.which_delimiter?("hello")
  end
  
  
  
  def test_extract_fields
    line = 'B,,F,,'
    adapter = RecordAdapter.new(line)
    fields = adapter.class.extract_fields(line, RecordAdapter::COMMA)
    assert_equal 5, fields.length
    assert_equal 'B', fields[0]
    assert_equal '', fields[1]
    assert_equal 'M', fields[2]
    assert_equal '', fields[3]
    assert_equal '', fields[4]
  end
  
  def test_extract_fields
    line = ',,M,,'
    adapter = RecordAdapter.new(line)
    fields = adapter.class.extract_fields(line, RecordAdapter::COMMA)
    assert_equal 5, fields.length
    assert_equal '', fields[0]
    assert_equal '', fields[1]
    assert_equal 'M', fields[2]
    assert_equal '', fields[3]
    assert_equal '', fields[4]
  end
  
  def test_extract_fields
    line = ',,,,'
    adapter = RecordAdapter.new(line)
    fields = adapter.class.extract_fields(line, RecordAdapter::COMMA)
    assert_equal 5, fields.length
    assert_equal '', fields[0]
    assert_equal '', fields[1]
    assert_equal '', fields[2]
    assert_equal '', fields[3]
    assert_equal '', fields[4]
  end
  
  def test_extract_fields
    line = 'Last,,,,'
    adapter = RecordAdapter.new(line)
    fields = adapter.class.extract_fields(line, RecordAdapter::COMMA)
    assert_equal 5, fields.length
    assert_equal 'Last', fields[0]
    assert_equal '', fields[1]
    assert_equal '', fields[2]
    assert_equal '', fields[3]
    assert_equal '', fields[4]
  end
  
  def test_extract_fields
    line = 'Last,First,M,green,05/12/2015'
    adapter = RecordAdapter.new(line)
    fields = adapter.class.extract_fields(line, RecordAdapter::COMMA)
    assert_equal 5, fields.length
    assert_equal 'Last', fields[0]
    assert_equal 'First', fields[1]
    assert_equal 'M', fields[2]
    assert_equal 'green', fields[3]
    assert_equal '05/12/2015', fields[4]
  end
  
  def test_extract_fields
    line = ',,,,05/12/2015'
    adapter = RecordAdapter.new(line)
    fields = adapter.class.extract_fields(line, RecordAdapter::COMMA)
    assert_equal 5, fields.length
    assert_equal '', fields[0]
    assert_equal '', fields[1]
    assert_equal '', fields[2]
    assert_equal '', fields[3]
    assert_equal '05/12/2015', fields[4]
  end
  
  def test_adapt
    line = 'Last,First,M,green,05/12/2015'
    adapter = RecordAdapter.new(line)
    assert_equal line, adapter.raw
    
    record = adapter.adapt
    assert record, 'Record is missing!'
    assert_equal 'Last', record.last_name
    assert_equal 'First', record.first_name
    assert_equal 'M', record.gender
    assert_equal 'green', record.fav_color
    assert_equal '05/12/2015', record.dob.to_s
  end
end