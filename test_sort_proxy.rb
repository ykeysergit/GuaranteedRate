require 'minitest/autorun'
require_relative 'record'
require_relative 'sort_proxy'
require_relative 'gender_comparator'
require_relative 'last_name_comparator'

class TestSortProxy < MiniTest::Unit::TestCase
  def test_female_female_rec2_before_rec1
    rec1=Record.new
    rec1.set_gender(Record::FEMALE)
    rec1.set_last_name('B')
    
    rec2=Record.new
    rec2.set_gender(Record::FEMALE)
    rec2.set_last_name('A')
    
    comparators=[GenderComparator.new, LastNameComparator.new(LastNameComparator::ASC)]
    
    @sort_proxy=SortProxy.new([rec1,rec2],comparators)
    sorted_records = @sort_proxy.sort!
    assert_equal rec2, sorted_records[0]
    assert_equal rec1, sorted_records[1]
  end
  
  def test_female_female_last_name_already_sorted
    rec1=Record.new
    rec1.set_gender(Record::FEMALE)
    rec1.set_last_name('A')
    
    rec2=Record.new
    rec2.set_gender(Record::FEMALE)
    rec2.set_last_name('B')
    
    comparators=[GenderComparator.new, LastNameComparator.new(LastNameComparator::ASC)]
    
    @sort_proxy=SortProxy.new([rec1,rec2],comparators)
    sorted_records = @sort_proxy.sort!
    assert_equal rec1, sorted_records[0]
    assert_equal rec2, sorted_records[1]
  end
  
  def test_male_female_same_last_name
    rec1=Record.new
    rec1.set_gender(Record::MALE)
    rec1.set_last_name('A')
    
    rec2=Record.new
    rec2.set_gender(Record::FEMALE)
    rec2.set_last_name('A')
    
    comparators=[GenderComparator.new, LastNameComparator.new(LastNameComparator::ASC)]
    
    @sort_proxy=SortProxy.new([rec1,rec2],comparators)
    sorted_records = @sort_proxy.sort!
    assert_equal rec2, sorted_records[0]
    assert_equal rec1, sorted_records[1]
  end
  
  def test_female_male_same_last_name
    rec1=Record.new
    rec1.set_gender(Record::MALE)
    rec1.set_last_name('A')
    
    rec2=Record.new
    rec2.set_gender(Record::FEMALE)
    rec2.set_last_name('A')
    
    comparators=[GenderComparator.new, LastNameComparator.new(LastNameComparator::ASC)]
    
    @sort_proxy=SortProxy.new([rec1,rec2],comparators)
    sorted_records = @sort_proxy.sort!
    assert_equal rec2, sorted_records[0]
    assert_equal rec1, sorted_records[1]
  end
  
end