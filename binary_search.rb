# takes a sorted array

def binary_search(n, list, place, adj)

  if list[place] == n 
    return list.rindex(list[place]) + adj
  end

  if list[place] < n
    binary_search(n,   
                  list[place..-1], # list slice
                  (list[place..-1].length / 2), # place
                  (adj + place)) # adjust
  else
    binary_search(n,
                  list[0..place], # list slice
                  (list[0..place].length / 2), # place
                  adj)
                  #list.length - place) # adjust
  end

  # need to implement `return -1 if not found`

end

my_list = [1,2,45,88,105,200,301,302,310,980]

# works for everything but first element
my_list.each do |x|
  p binary_search(x, my_list, my_list.length / 2, 0) 
end
