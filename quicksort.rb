def quicksort(array)
  # base cases
  if array.length <= 1
    return array
  end
  
  # set pivot with last element of array, create greater and lesser arrays
  pivot = array.pop 
  less, greater = [], []

  # break array according to current pivot, lesser and greater
  array.each do |element|
    if element <= pivot
      less << element
    else
      greater << element
    end
  end
  
  # recursively combine the results, with pivot between the lesser and greater arrays
  return quicksort(less) + quicksort(greater).unshift(pivot)
end

# test case
1.times do
  rando_array = []
  200.times { rando_array << rand(1001) }
  p quicksort(rando_array)
end
