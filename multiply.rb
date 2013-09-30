# an implementation of Array#inject(:*)

def multiply(a)
  return a.shift if a.length == 1
  a.shift * multiply(a)
end

p multiply([6,2,8])
p multiply([5,4,3,2,1])
