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
    @nodes = nodes
    builder(@nodes.shift)
  end

  def builder(a_node)
    if @nodes.length <=  0
      return Node.new(@nodes.shift, nil).object_id
    end
     @nodes << Node.new(a_node, builder(@nodes.shift).object_id)
  end


 def inspect
   @nodes.each { |n| p n } 

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
