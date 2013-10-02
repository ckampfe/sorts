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
     
    # @actual.each { |node| a << node.instance_variable_get(:@value) }
  end


end

# instance test
my_list = Linked_List.new(1,2,3,4,5,6)
p my_list.to_a
p my_list
p my_list.instance_variable_get(:@actual).length
p my_list.instance_variable_get(:@actual)[0]
p ObjectSpace._id2ref(my_list.instance_variable_get(:@actual)[0].instance_variable_get(:@next_pointer))


