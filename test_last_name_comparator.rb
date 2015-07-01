require 'minitest/autorun'
require_relative 'last_name_comparator'
require_relative 'record'

class TestLastNameComparator < MiniTest::Unit::TestCase 
  def test_asc
    comparator=LastNameComparator.new(LastNameComparator::ASC)
    rec1=Record.new
    rec1.set_last_name('A')
    
    rec2=Record.new
    rec2.set_last_name('B')
    
    assert_equal -1, comparator.compare(rec1,rec2)
    
    rec2.set_last_name('A')
    assert_equal 0, comparator.compare(rec1,rec2)
  end
  
  def test_desc
    comparator=LastNameComparator.new(LastNameComparator::DESC)
    rec1=Record.new
    rec1.set_last_name('A')
    
    rec2=Record.new
    rec2.set_last_name('B')
    
    assert_equal 1, comparator.compare(rec1,rec2)
    
    rec2.set_last_name('A')
    assert_equal 0, comparator.compare(rec1,rec2)
  end
end