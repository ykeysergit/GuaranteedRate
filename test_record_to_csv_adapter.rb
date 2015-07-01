require 'minitest/autorun'
require_relative 'record'
require_relative 'records_to_csv_adapter'

class TestRecordToCSVAdapter < MiniTest::Unit::TestCase
  def test_adapt
    record=Record.new
    record.set_last_name('Smith')
    
    adapter=RecordsToCSVAdapter.new([record])
    csv=adapter.adapt
    assert csv.include?('Smith,,,,')
    assert csv.include?('LastName,FirstName,Gender,FavoriteColor,DateOfBirth')
  end
end