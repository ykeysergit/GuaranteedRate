class LastNameComparator
  ASC=1
  DESC=-1
  
  def initialize(order=ASC)
    @order=order
  end
  
  def compare(one,two)
    (one.last_name <=> two.last_name) * @order
  end
end