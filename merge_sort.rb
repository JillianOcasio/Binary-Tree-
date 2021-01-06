def merge_sort(list)
    len = list.length()
    half_len=len/2
    if list.length()<2 
        return list 
    else 
        left_list=list.slice!(0...half_len)
        right_list=list
    left = merge_sort(left_list)
    right = merge_sort(right_list)
    final_array = merge(left,right)

    return final_array
    end   
end 

def merge(left_list,right_list)
    final_list=[]
    while !left_list.empty? && !right_list.empty?
        if left_list[0]<right_list[0] 
                final_list.append(left_list.shift())
        else 
            final_list.append(right_list.shift())  
        end 
    end 

    while !left_list.empty?
        final_list.append(left_list.shift())
    end 
    while !right_list.empty?
        final_list.append(right_list.shift())  
    end  
    return final_list
end 

random_array = []; 20.times { random_array << rand(100)}

p random_array
puts "#{merge_sort(random_array)} sorted"