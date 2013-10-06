class Node

  attr_accessor :value, :next_pointer
  
  # the data of a node
  def initialize(value, next_pointer)
    @value = value
    @next_pointer = next_pointer
  end
end


class Linked_List
  
  def initialize(*raw_items)
    if raw_items.length > 0
      # @head is defined inside of #builder for all lengths > 0 
      builder(raw_items, Node.new(raw_items[-1], nil), raw_items.length - 1) # linked list construction
    else
      @head = nil
    end
  end

  # recursively extract items and define lists in terms of their next relationship
  def builder(nodes_list, current_node, index)
    if index < 1
      @head = current_node.object_id
      return self.to_a 
    end
    
    builder(nodes_list, Node.new(nodes_list[index - 1], current_node.object_id), index - 1)
  end

  def to_a
    a = []
    array_builder = lambda do |an_obj_id|
      this_node = ObjectSpace._id2ref(an_obj_id)
      next_node = this_node.instance_variable_get(:@next_pointer)
      
      a << this_node.instance_variable_get(:@value)

      if this_node.instance_variable_get(:@next_pointer) == nil
        return a
      end

       array_builder.call(next_node)
    end

    @head != nil ? array_builder.call(@head) : []
  end
 
  def first
    ObjectSpace._id2ref(@head).instance_variable_get(:@value)
  end
  
  # runs a lambda that follows the @next_pointer trail until it reaches a node with 
  # @next_pointer == nil, at which point it returns the @value. 
  def last
    last_getter = lambda do |node|
      unless node.instance_variable_get(:@next_pointer) == nil
        last_getter.call(ObjectSpace._id2ref(node.instance_variable_get(:@next_pointer)))
      else
        return node.instance_variable_get(:@value)
      end
    end

    @head ? last_getter.call(ObjectSpace._id2ref(@head)) : nil 
  end

  # similar to the last_getter lambda in #last.
  # recursively calls a last_setter lambda to find the last value, and change its next
  # pointer to a Node.new(push_vals[index], nil), making it the "new last", 
  # so to speak. It calls itself as long as it has not reached the end of push_vals
  def push(*push_vals) 
    last_setter = lambda do |node, index|
      if index > push_vals.length 
        return self.to_a
      end

      # call self again unless the current @next_pointer indicates last value status.
      unless node.instance_variable_get(:@next_pointer) == nil
        last_setter.call(ObjectSpace._id2ref(node.instance_variable_get(:@next_pointer)), index)
      else
        # creates a new last node
        node.instance_variable_set(:@next_pointer, Node.new(push_vals[index - 1], nil).object_id)
        # call again with the next value of push_vals
        last_setter.call(ObjectSpace._id2ref(@head), index + 1)
      end
    end

    # determines if list is empty, and if so, defines a first value before proceeding. 
    if @head
      last_setter.call(ObjectSpace._id2ref(@head), 1)
    else
      @head = Node.new(push_vals[0], nil).object_id
      last_setter.call(@head, 1)
    end
  end
  
  # this method is not efficient, running I think O(n^2).
  def pop(n=1)
    popper = lambda do |node|
      # the value of the next node's @next_pointer, necessary to check "one ahead" for the nil value,
      # indicating end of the list. 
      next_node_pointer = ObjectSpace._id2ref(node.instance_variable_get(:@next_pointer)).instance_variable_get(:@next_pointer)

      if next_node_pointer == nil
        a_pop_val = ObjectSpace._id2ref(node.instance_variable_get(:@next_pointer)).instance_variable_get(:@value)
        node.instance_variable_set(:@next_pointer, nil) 
        return a_pop_val
      else
        popper.call(ObjectSpace._id2ref(node.instance_variable_get(:@next_pointer)))
      end
    end
  
    # calls the lambda enough times for the given #pop(n) value 
    i = 1
    pop_array = []
    while i <= n
      pop_array.unshift(popper.call(ObjectSpace._id2ref(@head)))
      i += 1
    end

    pop_array.length > 1 ? pop_array : pop_array[0]
  end
  
  def unshift(*unshift_vals)
    unshifter = lambda do |index|
      @head = Node.new(unshift_vals[index], @head).object_id 
      return self.to_a if index == 0 
      unshifter.call(index - 1)
    end
    
    unshift_vals.length > 0 ? unshifter.call(unshift_vals.length - 1) : self.to_a
  end


  # note: maybe crawl until position n-1, and set n-1[@next_pointer] to nil?
  def shift(n=1)
    shift_array = []
    shifter = lambda do |position|
      shift_array << ObjectSpace._id2ref(@head).instance_variable_get(:@value)   
      @head = ObjectSpace._id2ref(@head).instance_variable_get(:@next_pointer)

      position > 1 ? shifter.call(position - 1) : shift_array
    end

    # the usual trick: return the first element unless n > 1
    n > 1 ? shifter.call(n) : shifter.call(n)[0]
  end

end

# tests
my_list = Linked_List.new(1,2,3,4,5,6)
p my_list #=> #<>
p my_list.last #=> 6
p my_list.to_a #=> [1,2,3,4,5,6]
p my_list.pop #=> 6
p my_list.to_a #=> [1,2,3,4,5]
p my_list.pop(3) #=> [3,4,5]
p my_list.to_a #=> [1,2]
p my_list.push("dinkytown", true) #=> [1,2,"dinkytown", true]
p my_list.last #=> true
p my_list.first #=> 1
p my_list.unshift #=> [1,2,"dinkytown",true]
p my_list.unshift("holland", 1945) #=> ["holland",1945,1,2,"dinkytown",true]
p my_list.shift #=> "holland"
p my_list.shift(3) #=> [1945,1,2]
p my_list.to_a #=> ["dinkytown",true]

p "-----------------"

newy = Linked_List.new(3)
p newy #=> #<>
p newy.push(5) #=> [3,5]

empty = Linked_List.new
p empty.push("mcownedyou", "whamford") #=> ["mcownedyou", "whamford"]

empty_second = Linked_List.new
p empty_second.unshift(8) #=> [8]
