class Node

  attr_accessor :value, :next_pointer
  
  # the data of a node
  def initialize(value, next_pointer)
    @value = value
    @next_pointer = next_pointer
  end
end


class Linked_List
  
  attr_reader :actual

  def initialize(*nodes)
    if nodes.length > 0
      @raws = nodes
      @actual = []
      builder(@raws, Node.new(@raws.pop, nil)) # linked list construction
      @first = @actual[0].object_id
    else
      @first = nil
    end
  end

  # recursively extract items and define lists in terms of their next relationship
  def builder(nodes, a_node)
   
    # perhaps revise so that nodes do not live in an array, rather,
    # just use '@first' as the the main vector, and have a temp
    # variable hold the next prev
    @actual.unshift(a_node)

    if nodes.length == 0
      return @actual
    end
    
    builder(nodes, Node.new(nodes.pop, @actual[0].object_id))
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

    @first != nil ? array_builder.call(@first) : []
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

    @first ? last_getter.call(ObjectSpace._id2ref(@first)) : nil 
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
        # I'm still trying to work out why this is 'push_vals[value - 1]' instead of 
        # push_vals[value], given that the intitial call is with index 0
        node.instance_variable_set(:@next_pointer, Node.new(push_vals[index - 1], nil).object_id)
        # call again with the next value of push_vals
        last_setter.call(ObjectSpace._id2ref(@first), index + 1)
      end
    end

    # determines if list is empty, and if so, defines a first value before proceeding. 
    if @first
      last_setter.call(@first, 0)
    else
      @first = Node.new(push_vals[0], nil).object_id
      last_setter.call(@first, 1)
    end
  end


end

# integers
my_list = Linked_List.new(1,2,3,4,5,6)
p my_list #=> #<>
p my_list.last #=> 6
p my_list.to_a #=> [1,2,3,4,5,6]

# strings
string_list = Linked_List.new("hello", "there", "sonny", "boy")
p string_list #=> #<>
p string_list.last #=> "boy"
p string_list.to_a #=> ["hello", "there", "sonny", "boy"] 

# mixed
mixed_list = Linked_List.new("hello", "caprica", 6)
p mixed_list #=> #<>
p mixed_list.last #=> 6
p mixed_list.to_a #=> ["hello", "caprica", 6] 

# empty
empty = Linked_List.new()
p empty #=> #<>
p empty.last #=> nil
p empty.to_a #=> []

# push
another_list = Linked_List.new(2,4,6)
p another_list.to_a #=> [2,4,6]
p another_list.push("tunisie") #=> [2,4,6,"tunisie"]
p another_list.push(5,10,15) #=> [2,4,6,"tunisie",5,10,15]
p another_list.push("silly wabbits", "I'm hunting them") #=> [2,4,6,"tunisie",5,10,15,"silly wabbits", "I'm hunting them"]
p another_list.push()

# empty push
ep = Linked_List.new
p ep.to_a #=> []
p ep.push(11,73,93) #=> [11,73,93]
p ep.push("a string") #=> [11,73,93,"a string"]
