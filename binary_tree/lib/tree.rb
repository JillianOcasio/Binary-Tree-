require_relative('node')

class Tree
    attr_accessor :root
    def initialize(array)
        @root = build_tree(array) 
    end 

    def build_tree(array)
        return nil if array.empty?
 
        clean_array=clean(array)
        len = clean_array.length()
        start = 0 
        finish= len
        mid = ((len-1)/2)
        root=Node.new(clean_array[mid])
        left_array = clean_array[...(mid)]
        root.left = build_tree(left_array)
        right_array = clean_array[(mid+1)...]
        root.right=build_tree(right_array)
        return root  
    end 

    def clean(array)
        array=array.uniq
        array.sort!
        return array 
    end 

    def insert(key, node=@root)
        if node.nil?
            return Node.new(key)
        else 
            if node.value==key 
                return nil 
            elsif node.value<key
                node.right=insert(key, node.right)
            else 
                node.left = insert(key,node.left)
        return node  
            end 
        end 
    end 

    def minValueNode(node)
        current = node
        # loop down to find the leftmost leaf
        while current.left != nil
            current = current.left
        return current
        end
    end 
    
    def delete(key, node=@root)
        return node if node.nil? 

        if key<node.value 
            node.left=delete(key, node.left)
        elsif key>node.value
            node.right = delete(key, node.right)
        else 
            #node only has one child or no children 
            if node.left.nil?
                return node.right 
            elsif node.right.nil?
                return node.left 
            temp =  minValueNode(node.right)
            node.value=temp.value 
            node.right = delete(temp.value,node.right)
            end 
        return node 
        end  
    end 

    def find(key, node=@root)
        if node.value == key 
            return node 
        elsif key<node.value 
            node.left=find(key, node.left)
        elsif key>node.value 
            node.right=find(key,node.right)
        else
            return nil 
        end 
    end 
    def level_order(node=@root, list_values=[])
        return list_values if node.nil? 
        current = node.value 
        if current != nil 
            list_values.push(current)
            if node.right != nil && node.left != nil 
                list_values=level_order(node.left, list_values)
                list_values=level_order(node.right, list_values)
            elsif node.left !=nil 
                list_values=level_order(node.left, list_values)
            elsif node.right!=nil  
                list_values=level_order(node.right, list_values)       
            end 
        return list_values
        end 
    end 
    def inorder (node=@root, list_values=[])
        return list_values if node.nil? 
        inorder(node.left, list_values)
        list_values.push(node.value)
        inorder(node.right, list_values)
    end 
    def preorder (node=@root, list_values=[])
        return list_values if node.nil? 
        list_values.push(node.value)
        preorder(node.left, list_values)
        preorder(node.right, list_values)
    end
    def postorder (node=@root, list_values=[])
        return list_values if node.nil? 
        postorder(node.left, list_values)
        postorder(node.right, list_values)
        list_values.push(node.value)
    end  

    def numNodes(node)
        return 0 if node.nil? 
        left_tree= 1 + numNodes(node.left) 
        right_tree= 1 + numNodes(node.right)
        if left_tree>right_tree
            return left_tree
        else 
            return right_tree
        end 
    end 
            
    def height(key,counter=0)
        node = find(key, node=@root)
        return numNodes(node) 
    end 
        
    def depth(key,node=@root,counter=0)
        return counter if node.nil? 
        if node.value==key 
            return counter 
        elsif node.value>key
            counter+=1  
            depth(key,node.left,counter)
        elsif node.value<key
            counter+=1 
            depth(key,node.right,counter)  
        end 
    end 

    def balanced?(node=@root) 
        depth_left = height(node.left.value)
        depth_right = height(node.right.value)
        difference_in_Depth=depth_left-depth_right
        if difference_in_Depth>1 
            return false
        else 
            return true 
        end 
    end
    def rebalance(node=@root)
        unless balanced?
            tree_array=level_order()
            return build_tree(tree_array)
        end 

    end 

    ##from the discord 
def pretty_print(node = @root, prefix = '', is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
        pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
    end
end 
    


test_tree = Array.new(20) { rand(1..100) }
puts test_tree
test_b=Tree.new(test_tree)
p test_b.balanced?
puts test_b.level_order
puts test_b.preorder
puts test_b.postorder
puts test_b.inorder
test_b.rebalance()
p test_b.balanced?
puts test_b.level_order
puts test_b.preorder
puts test_b.postorder
puts test_b.inorder