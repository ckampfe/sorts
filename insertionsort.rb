def insertion(a)
  a.each_with_index do |current_num, i|
    while i > 0
      if current_num < a[i-1]
        a.insert(i-1, a.delete_at(i))
      end

      i-=1
    end
  end
end
