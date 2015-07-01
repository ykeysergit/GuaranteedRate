require_relative 'resource_uri_builder'
require_relative '../record'
require_relative '../records_to_csv_adapter'
require 'json'

class RESTClient
  DEFAULT_CONTENT_TYPE=:json
  
  def initialize(connection_adapter)
    @connection_adapter=connection_adapter
  end
  
  def save_record(record=Record.new)
    relative_path=ResourceURIBuilder.new.set_context(Record).build
    body=RecordsToCSVAdapter.new([record]).adapt
    @connection_adapter.post(relative_path,body)
  end
  
  def retrieve_records_sorted_by_gender
    retrieve_records_by_action(RecordDataStore::SORT_BY_GENDER)
  end
  
  def retrieve_records_sorted_by_birthdate
    retrieve_records_by_action(RecordDataStore::SORT_BY_BIRTHDATE)
  end
  
  def retrieve_records_sorted_by_name
    retrieve_records_by_action(RecordDataStore::SORT_BY_NAME)
  end
  
  #
  # protected
  protected
  
  def retrieve_records_by_action(action='')
    relative_path=ResourceURIBuilder.new.set_context(Record).set_action(action.to_sym).build
    @connection_adapter.get(relative_path)
  end
end