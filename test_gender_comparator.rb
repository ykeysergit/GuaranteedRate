require 'minitest/autorun'
require_relative 'gender_comparator'

class TestGenderComparator < MiniTest::Unit::TestCase
  def setup
    @comparator=GenderComparator.new
  end
  
  def test_male_male
    rec1=Record.new
    rec1.set_gender(Record::MALE)
    
    rec2=Record.new
    rec2.set_gender(Record::MALE)
    
    assert_equal 0, @comparator.compare(rec1,rec2)
  end
  
  def test_male_female
    rec1=Record.new
    rec1.set_gender(Record::MALE)
    
    rec2=Record.new
    rec2.set_gender(Record::FEMALE)
    
    assert_equal 1, @comparator.compare(rec1,rec2)
  end
  
  def test_female_female
    rec1=Record.new
    rec1.set_gender(Record::FEMALE)
    
    rec2=Record.new
    rec2.set_gender(Record::FEMALE)
    
    assert_equal 0, @comparator.compare(rec1,rec2)
  end
  
  def test_female_male
    rec1=Record.new
    rec1.set_gender(Record::FEMALE)
    
    rec2=Record.new
    rec2.set_gender(Record::MALE)
    
    assert_equal -1, @comparator.compare(rec1,rec2)
  end
end