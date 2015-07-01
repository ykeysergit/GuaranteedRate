require_relative 'record'

class GenderComparator
  def compare(one, two)
    return -1 if one.gender == Record::FEMALE && two.gender == Record::MALE
    return 1 if one.gender == Record::MALE && two.gender == Record::FEMALE
    0
  end
end