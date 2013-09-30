# takes a sorted array

def binary_search(n, list, place)
  p list

  if list[place] == n
    list.rindex(list[place])
  elsif list[place] < n
    p "place < n"
    binary_search(n, list.slice(place, list.rindex(list[-1])), list.slice(place, list[-1]).length / 2)
  else
    p "place > n"
    binary_search(n, list.slice(list.first, list.rindex(list[place])), list.slice(list.first, list[place]).length / 2)
  end


end

my_list = [1,2,45,88,105,200,301,302,310,980]

p binary_search(105, my_list, my_list.length/2)

