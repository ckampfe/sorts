# just a little functional summer I had the idea to make.

def sum(an_array)
  if an_array.length == 1
    return an_array[0]
  end

  an_array.slice(-1, 1)[0] + sum(an_array.slice(0, an_array.length - 1))
end

my_array = [1,2,3,4]
p sum(my_array)
p my_array 
