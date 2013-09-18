# just a little functional adder I had the idea to make.

def sum(an_array)
  if an_array.length == 1
    return an_array.last
  end

  an_array.last + sum(an_array.slice(0, an_array.length - 1))
end
