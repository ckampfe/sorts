# mergesort, invented by John von Neumann

def divide(an_array)
  # base case
  if an_array.length <= 1
    return an_array
  end

  left, right = [], []
  # elements with indices < length / 2 go to left, all others go to right
  an_array.each_with_index { |element, index| index < an_array.length / 2 ? left << element : right << element }
  
  # recurse to reduce all to bases 
  left = divide(left)
  right = divide(right)
  
  # merge them back together in order
  merge(left, right)
end


def merge(left_array, right_array)
  sorted = [] 
  
  m = lambda do |left_array, right_array|
    if left_array.length == 0 && right_array.length == 0
      return sorted
    elsif left_array.length < 1
      sorted << right_array.shift
      m.call(left_array, right_array)
    elsif right_array.length < 1 
      sorted << left_array.shift
      m.call(left_array, right_array)
    else
      left_array.first <= right_array.first ? sorted << left_array.shift : sorted << right_array.shift
      m.call(left_array, right_array)
    end
  end
  
  m.call(left_array, right_array)
end
