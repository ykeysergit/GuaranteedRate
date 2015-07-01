require_relative '../../record_data_store'
require_relative '../resource_uri_builder'
require_relative '../../parser'

class MemoryConnectionAdapter
  DEFAULT_CONTENT_TYPE=:json
  EMPTY_JSON_RESPONSE='{}'
  
  def initialize(base_uri, content_type=DEFAULT_CONTENT_TYPE, datastore=RecordDataStore.new)
    @base_uri=base_uri.to_s.downcase
    @content_type=content_type.to_s.downcase.to_sym
    @datastore=datastore
  end
  
  def datastore
    @datastore
  end
  
  def post(relative_path=ResourceURIBuilder::PATH_SEPARATOR, body='')
    records=Parser.new.parse_text(body)
    datastore.store(records[0]) if records.length >= 1  
    JSON.generate({})
  end
  
  def get(relative_path=ResourceURIBuilder::PATH_SEPARATOR)
    JSON.generate(datastore.query(self.class.extract_action(relative_path)).map(&:to_h))
  end
  
  def self.extract_action(relative_path)
    if relative_path.split(ResourceURIBuilder::PATH_SEPARATOR).length >= 3
      (relative_path.split(ResourceURIBuilder::PATH_SEPARATOR)-[''])[1].to_sym
    end
  end
end