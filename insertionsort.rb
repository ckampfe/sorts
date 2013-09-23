def insertion(a)
  t1 = Time.now
  a.each_with_index do |current_num, i|
    while i > 0
      if current_num < a[i-1]
        a.insert(i-1, a.delete_at(i))
      end

      i-=1
    end
  end
  t2 = Time.now

  p a
  p t2 - t1
end


1.times do
  rando = []
  20000.times { rando << rand(10000) }
  p insertion(rando)
end
