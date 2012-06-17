#Download the text file here. (Right click and save link as)
#The file contains all the 100,000 integers between 1 and 100,000 (including both) in some random order( no integer is repeated).

#Your task is to find the number of inversions in the file given 
#(every row has a single integer between 1 and 100,000). Assume your array is from 1 to 100,000 and ith row of the file gives you the ith entry of the array.
#Write a program and run over the file given. 
#The numeric answer should be written in the space.
#So if your answer is 1198233847, then just type 1198233847 in the space provided without any space / commas / any other punctuation marks. 
#You can make upto 5 attempts, and we'll count the best one for grading.
#(We do not require you to submit your code, so feel free to choose the programming language 
#of your choice, just type the numeric answer in the following space)


def getInts
  integers = Array.new(0)
  File.open('IntegerArray.txt').each_line{ |s|
    s.gsub!(/\n?/, "")
    integers.push(s)
  }
  integers
end


ints = getInts
#ints = [5,3,10,9,2,1,8,7,6,4]
#ints = [5,2,3,4,6,1,7,8,9,10]
#ints = [1,3,5,2,4,6]
#ints = [1,2,3,4,5,6]
#ints = [6,5,4,3,2,1]
#print ints.to_s

@inversions = 0

def merge(left, right, length)
  merged = Array.new(length)
  i = 0
  j = 0
  #puts "  merging " + length.to_s + " items..."
  #puts "  left: " + left.to_s
  #puts "  right: " + right.to_s
  puts "        left: " + left.length.to_s + " elements; right: " + right.length.to_s + " elements."
  return merged if right == nil || left == nil
  
  (0..length).each do |index|
    currentLeft = left[i] || nil
    currentRight = right[j] || nil
    #puts "  index: " + index.to_s
    puts "    currentLeft: " + currentLeft.to_s
    puts "    currentRight: " + currentRight.to_s

    if(currentRight == nil && currentLeft == nil)
      return merged
    end
    
    if(currentLeft == nil)
      merged[index] = currentRight
      j += 1
    elsif(currentRight == nil)
      merged[index] = currentLeft
      i += 1
    elsif(currentLeft < currentRight)
      merged[index] = currentLeft
      i += 1
    else
      #puts "    inversion merging " + currentLeft.to_s + " and " + currentRight.to_s
      #puts "     index: " + index.to_s
      @inversions += (left.length - i)
      merged[index] = currentRight
      #puts "    " + @inversions.to_s + " inversions"
      j += 1
    end
    #puts "  merged: " + merged.to_s
    
  end
  return merged
  
end

def merge_sort(nums)
  return nums if nums.length == 1
  half = nums.length/2
  #puts "merge sort: " + nums.to_s
  #puts "left (pre-sort): " + nums[0..half-1].to_s
  #puts "right (pre-sort): " + nums[half..nums.length].to_s
  #left = merge_sort(nums[0..half-1])
  #right = merge_sort(nums[half..nums.length])
  
  left = nums[0..half-1].sort
  right = nums[half..nums.length].sort

  #puts "sorted left: " + left.to_s
  #puts "sorted right: " + right.to_s

  merge(left, right, nums.length)
  puts "  " + @inversions.to_s + " inversions"
  
end

puts merge_sort(ints)
