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

    @raw_nodes = nodes
    @actual = []
    builder(@raw_nodes.shift) # begin linked list construction
  end

  # recursively extract items and define lists in terms of their next relationship
  def builder(a_node)
    if @raw_nodes.length == 0
      @actual << Node.new(a_node, nil) # last node holds nil for next_pointer, not sure
                                       # if it should be something else.
      return @actual
    end

    @actual << Node.new(a_node, builder(@raw_nodes.shift).object_id)
  end

  def to_a
    a = []
    @actual.each { |node| a << node.instance_variable_get(:@value) }
    a
  end


end

# instance test
my_list = Linked_List.new(1,2,3,4,5,6)
p my_list.to_a
p my_list

# _id2ref test
# z = "a string"
# puts z.object_id
# a = z.object_id
# puts ObjectSpace._id2ref(a)
