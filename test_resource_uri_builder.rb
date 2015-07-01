require 'minitest/autorun'
require_relative 'rest_api/resource_uri_builder'
require_relative 'record'

class TestResourceURIBuilder < MiniTest::Unit::TestCase
  def test_without_context_and_without_action
    assert_equal '',ResourceURIBuilder.new.build
  end
  
  def test_context_without_action
    assert_equal '/records', ResourceURIBuilder.new.set_context('records').build
    assert_equal '/records', ResourceURIBuilder.new.set_context(Record).build
  end
  
  def test_context_with_action
    assert_equal '/records/name', ResourceURIBuilder.new.set_context('records').set_action('name').build
    assert_equal '/records/name', ResourceURIBuilder.new.set_context(Record).set_action('name').build
  end
end