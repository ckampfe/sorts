# takes a sorted array

def binary_search(n, list, place, adj)

  # need to implement `return -1 if not found`
  
  if list[place] == n
    return place + adj
  end

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

# unfound test
p binary_search(90, my_list, my_list.length / 2, 0)
