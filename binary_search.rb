# initially takes a search term, a sorted array, a starting place, and index adjustment modifier
# other implementations I saw used explicit `left-right` boundaries, so I used slices
# to be a little different. I'm not sure if using slices defeats the point, but it seems to work
# and I wanted to mix things up.

def binary_search(n, list, place, adj)

  # base 
  if list[place] == n
    return place + adj
  end
  
  # not found
  
  if list.length <= 2 && list[0] != n
    return -1
  end
  
  # normal cases 
  if list[0] == n  
    0
  elsif list[place] < n
    binary_search(n, list[place..-1], (list[place..-1].length / 2), (adj + place)) 
  elsif list[place] > n
    binary_search(n, list[0..place], (list[0..place].length / 2), adj)
  end
end

my_list = [1,2,45,88,105,200,301,302,310,980]


# test
my_list.each do |x|
  p "element = #{x}"
  p binary_search(x, my_list, my_list.length / 2, 0) 
end

# unfound tests
p binary_search(3, my_list, my_list.length / 2, 0)
p binary_search(1000, my_list, my_list.length / 2, 0)
p binary_search(92, my_list, my_list.length / 2, 0)
p binary_search(305, my_list, my_list.length / 2, 0)
