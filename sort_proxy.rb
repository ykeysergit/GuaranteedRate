class SortProxy
  def initialize(records=[], comparators)
    @records=records
    @comparators=comparators
  end
  
  def records
    @records
  end
  
  def comparators
    @comparators
  end
  
  def sort!
    return if records.length==0
    
    records.sort! do |first,second|
      compare(first,second)
    end
  end
  
  # 
  # protected
  #
  protected
  
  def compare(first,second)
    result=0
    
    comparators.each_with_index do |comparator, index|
        compare_result = comparator.compare(first,second)
         
        # Keep iterating until a tie is resolved
        result=compare_result if compare_result != 0
      end
      
    result
  end
end