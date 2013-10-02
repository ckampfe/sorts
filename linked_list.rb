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
    if nodes.length == 0
      nodes 
    end

    @raws = nodes
    @actual = []
    builder(@raws, Node.new(@raws.pop, nil)) # linked list construction
    @first = @actual[0].object_id
  end

  # recursively extract items and define lists in terms of their next relationship
  def builder(nodes, a_node)
    
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

    array_builder.call(@first)
  end

end

# integers
my_list = Linked_List.new(1,2,3,4,5,6)
p my_list
p my_list.to_a

# strings
string_list = Linked_List.new("hello", "there", "sonny", "boy")
p string_list
p string_list.to_a


mixed_list = Linked_List.new("hello", "caprica", 6)
p mixed_list
p mixed_list.to_a
