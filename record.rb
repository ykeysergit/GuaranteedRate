require 'date'
#
# Ruby Bean
#
class Record
  MALE='M'
  FEMALE='F'
  DOB_FORMAT='%m/%d/%Y'
  
  def hash
    to_h.to_s.hash
  end
  
  alias_method :eql?, :==
  
  def ==(record)
    self.to_h.to_s.hash == record.to_h.to_s.hash
  end
  
  def to_h
    display={}
    display[:first_name]=first_name
    display[:last_name]=last_name
    display[:dob]=dob
    display[:fav_color]=fav_color
    display[:gender]=gender
    display
  end
  
  def to_s
    self.to_h.to_s
  end  

  def set_first_name(name='')
    @first_name=name
    self
  end
  
  def set_gender(gender='')
    @gender=gender
    self
  end
  
  def set_last_name(name='')
    @last_name=name
    self
  end
  
  def set_dob(dob='')
    if dob.to_s.length > 0
      @dob=Date.strptime(dob.to_s, DOB_FORMAT)
    else
      @dob=''
    end
    
    self
  end
  
  def set_fav_color(color='')
    @fav_color=color
    self
  end
  
  # Getters
  def dob
    return @dob.strftime(DOB_FORMAT) if @dob.kind_of?(Date)
    ''
  end
  
  
  
  def fav_color
    @fav_color || ''
  end
  
  def gender
    @gender || ''
  end
  
  def last_name
    @last_name || ''
  end
  
  def first_name
    @first_name || ''
  end
end