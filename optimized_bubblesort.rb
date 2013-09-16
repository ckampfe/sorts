# this is an optimized bubble sort, reducing the number of pairs that need to by
# checked by 1 for each complete pass

def bubblesort(my_array)
  # comparison, return the swapped elements and true if a swap occured,
  # otherwise just return the elements in order 
  compare = lambda do |ele0, ele1|
    if ele0 > ele1
      return ele1, ele0, true
    else
      return ele0, ele1 
    end
  end 
 
  # iterate over the input my_array, calling the lambda on each pair, and set `swap' ONLY to true,
  # ignore the nil settings given when no swap is necessary 
  # n is so as to ignore the last n elements after n runs
  iterate = lambda do |my_array, n|
    i = 0
    while i < (my_array.length - n)
      my_array[i], my_array[i + 1], swap_temp = compare.call(my_array[i], my_array[i + 1])
      swap ||= swap_temp
      i += 1
    end
   
    # recursion if it had to swap in the past
    # n is +1 because max is moved farthest to the right with each pass, so
    # no need to recheck array[length-n] after n runs   
    iterate.call(my_array, n + 1) if swap
    return my_array
  end
   
  # calls the whole thing with a base of 1, so the loop defaults to
  # a termination condition of i < my_array.length - 1 on the first loop,
  # and n + 1 (so, 2, 3, etc.) on each additional call
  iterate.call(my_array, 1)
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
