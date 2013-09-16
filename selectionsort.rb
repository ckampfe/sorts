def selection(an_array)
  current_pos = 0
  # position tracker
  while current_pos < an_array.length
    n = current_pos
    current_min = an_array[current_pos]
    
    # min finder
    while n < an_array.length 
      if an_array[n] <= current_min
        current_min = an_array[n]
      end
      
      n += 1
    end
    
    current_min = an_array.delete_at(an_array.index(current_min))
    an_array.insert(current_pos, current_min)
    current_pos += 1
  end 
  
  an_array
end


# p selection([6,3,7,2,8,1,0])

5.times do
  temp_rando = []
  5.times { temp_rando << rand(40) }
  p "rando array: #{temp_rando}"
  p "selection-sorted array: #{selection(temp_rando)}"
end
