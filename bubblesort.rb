def bubblesort(my_array)
  # comparison, return the swapped elements and true if a swap occured,
  # otherwise just return the elements in order 
  compare = lambda do |ele1, ele2|
    if ele1 > ele2
      return ele2, ele1, true
    else
      return ele1, ele2 
    end
  end 
 
  # iterate over the input my_array, calling the comparison lambda on each pair, and set `swap' ONLY to true,
  # ignoring the nil given when no swap is necessary 
  i = 0
  while i < (my_array.length - 1)
    my_array[i], my_array[i + 1], swap_temp = compare.call(my_array[i], my_array[i + 1])
    swap ||= swap_temp
    i += 1
  end
  
  # recursion if it had to swap in the past
  if swap
    bubblesort(my_array)
  else
    my_array
  end
end


# test cases, baby!
5.times do
  rand_my_array = []
  5.times { rand_my_array << rand(500) }
  p "rand my_array:"
  p rand_my_array
  print "\n + bubblesorted:"
  p bubblesort(rand_my_array)
  print "\n + #sort method"
  p rand_my_array.sort
end
