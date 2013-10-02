class Node

  attr_accessor :value, :next_pointer
  
  # the data of a node
  def initialize(value, next_pointer)
    @value = value
    @next_pointer = next_pointer
  end
end


class Linked_List


  def initialize(nodes)
    
    if nodes.length == 0
      nodes 
    end

    @raw_nodes = nodes
    @actual = []
    builder(@raw_nodes.shift)
  end

  # recursively extract items and define lists in terms of their next relationship
  # still having trouble
  def builder(a_node)
    # p @raw_nodes
    if @raw_nodes.length == 1
      return @actual << Node.new(@raw_nodes.shift, nil)
    else
      @actual << Node.new(a_node, builder(@raw_nodes.shift).object_id)
    end

    @actual
  end


 def inspect
   @actual.each { |n| puts n.inspect } 
 end

 #  def list(a_node)
 #    @list ||= []
 #    unless a_node[@next_pointer] == nil
 #      @list << list(a_node[@next_pointer]) 
 #    else
 #      return a_node[@value]    
 #    end 
 #    
 #  end
end

my_list = Linked_List.new([1,2,3,4,5,6])
p my_list.inspect

# another_list = Linked_List.new([])
# p another_list
