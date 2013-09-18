def divide(an_array)
  # base
  if an_array.length <= 1
    return an_array
  end

  left = an_array.select { |element| an_array.index(element) < an_array.length / 2 } 
  # p left
  right = an_array.select { |element| an_array.index(element) >= an_array.length / 2 }
  # p right

  left = divide(left)
  right = divide(right)

  merge(left, right)
end


def merge(left_array, right_array)
  sorted = [] 

  m = lambda do |left_array, right_array|
    if left_array.length == 0 && right_array.length == 0
      return sorted
    elsif left_array.length == 0
      sorted << right_array.shift
      m.call(left_array, right_array)
    elsif right_array.length == 0
      sorted << left_array.shift
      m.call(left_array, right_array)
    else
      left_array.first < right_array.first ? sorted << left_array.shift : sorted << right_array.shift
      m.call(left_array, right_array)
    end
  end
  
  m.call(left_array, right_array)
end




test_odd = [1,5,7,8,1,9,4,0,12]
test_even = [1,2,5,6,8,3,12,10]

p divide(test_even)
p divide(test_odd)
