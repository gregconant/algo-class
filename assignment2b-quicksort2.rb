#Programming Question - 2
#Question 1
#GENERAL DIRECTIONS:
#Download the text file here. 

#The file contains all of the integers between 1 and 10,000 (inclusive) in unsorted order (with no integer repeated). The integer in the ith row of the file gives you the ith entry of an input array.

#Your task is to compute the total number of comparisons used to sort the given input file by QuickSort.
#As you know, the number of comparisons depends on which elements are chosen as pivots, so we'll ask you to explore three different pivoting rules.
#You should not count comparisons one-by-one. Rather, when there is a recursive call on a subarray of length m,
#you should simply add m−1 to your running total of comparisons. (This is because the pivot element will be
#compared to each of the other m−1 elements in the subarray in this recursive call.)

#WARNING: The Partition subroutine can be implemented in several different ways, and different implementations can give you
#differing numbers of comparisons. For this problem, you should implement the Partition subroutine as it is described in the
#video lectures (otherwise you might get the wrong answer).

#DIRECTIONS FOR THIS PROBLEM:

#Compute the number of comparisons (as in Problem 1), always using the final element of the given array as the pivot element.
#Again, be sure to implement the Partition subroutine as it is described in the video lectures. Recall from the lectures that,
#just before the main Partition subroutine, you should exchange the pivot element (i.e., the last element) with the first element.

#HOW TO GIVE US YOUR ANSWER:

# Type the numeric answer in the space provided.
# So if your answer is 1198233847, then just type 1198233847 in the space provided without any space / commas / other punctuation marks.
# You can make up to 5 attempts, and we'll count the best one for grading.
# (We do not require you to submit your code, so feel free to use the programming language of your choice, just type the numeric
# answer in the following space.)

def getInts
  integers = Array.new(0)
  #fileName = "./02-QuickSortSmall.txt"
  fileName = "02-QuickSort.txt"
  File.open(fileName).each_line{ |s|
    s.gsub!(/\n?/, "")
    integers.push(s.to_i)
  }
  integers
end


#ints = getInts
#ints = [5,3,10,9,2,1,8,7,6,4]
#ints = [5,2,3,4,6,1,7,8,9,10]
#ints = [3,1,5,2,4,6]
#ints = [1,2,3,4,5,6]
#ints = [6,5,4,3,2,1]
ints = [5,6,4,3,2,1]
#ints = [3,2,1]

#print ints.to_s

print ints.to_s + "\n"

# Pseudocode:


# remember: i is the index of the first element bigger than the pivot
#           j is the index of the first element that is unpartitioned (indices less than j are partitioned)
#           partitioned means it's divided into two parts: one part where all elements are less than the pivot,
#           and one part where all elements are greater than the pivot.
#           choose 1st element of array as pivot

# Partition(A,l,r) # l is the leftmost index we should look at, r is the rightmost index
#   pivot = A[l] 
#   i = l + 1
#   for j = l+1 to r # r => rightmost index
#     if A[j] < pivot   # if A[j] > p, do nothing
#       swap A[j] with leftmost element that's bigger than the pivot (A[i])
#       i = i + 1
#   swap A[l] and A[i-1]


def Partition(array, left, right, comparisons)

  puts "partitioning #{array.to_s}... #{comparisons} comparisons done already."
  
  pivot = array[right]
  #puts "choosing pivot of #{pivot} for array starting with #{array[0..1]}"
  i = left + 1
  
  #print "array[#{left}]: #{array[left]}\n"
  #print "array[#{right}]: #{array[right]}\n"
  temp = array[left]
  array[left] = array[right]

  array[right] = temp
  #print "array[#{left}]: #{array[left]}\n"
  #print "array[#{right}]: #{array[right]}\n"
  #input = gets.chomp
  
  for j in (left + 1)..right
    #print "  #{j} "
    comparisons = comparisons + 1
    if array[j] < pivot
      #puts "#{array[j]} is less than pivot"
      #swap A[i] and A[j]
      temp = array[i]
      array[i] = array[j]
      array[j] = temp
      i = i + 1
      
    end
  end
  # swap A[l] and A[i - 1]
  temp = array[left]
  array[left] = array[i - 1]
  array[i-1] = temp
  
  puts "done partitioning #{array.to_s}... #{comparisons} comparisons done now."
  return [array, i, j, comparisons]
end

def Quicksort(array, length, comparisons, level)
  spacing = "  "
  leftSorted = []
  rightSorted = []
  level.times do spacing += "  " end
    
  level = level + 1
  if comparisons == nil
    puts "#{spacing} NO COMPARISONS PASSED IN FOR #{array.to_s} on level #{level}"
  end
  
  
  if array == nil || array.length == 1
    puts "#{spacing} level #{level}: nothing to do; returning #{array.to_s} with #{comparisons} comparisons..."
    return [array, comparisons]
  end
  partitioned = Partition(array, 0, length, comparisons)
  arr = partitioned[0]
  comparisons = partitioned[3]
  puts "#{spacing} level #{level}: #{comparisons} comparisons done so far."
  input = gets.chomp
  puts "#{spacing} level #{level}: partitioned: #{arr.to_s}"
  left = arr.slice(0, partitioned[1])
  right = arr.slice(partitioned[1], arr.length)
  
  #input = gets.chomp()
  
#  if left.length != 0
    puts "#{spacing} level #{level}: left is NOT empty"
    puts "#{spacing} level #{level}: sorting left: #{left.to_s} of length #{left.length} with #{comparisons} comparisons"
    leftSorted = Quicksort(left, left.length - 1, comparisons, level)
    leftSortedArr = leftSorted[0]
    comparisons = leftSorted[1]
    puts "#{spacing} level #{level}: sorted left with #{comparisons} comparisons"

    puts "#{spacing} level #{level}: left sorted: #{leftSortedArr.to_s}"
    #comparisons = leftSorted[1].to_i + (left.length - 1)
#  end
#  if right.length != 0
    puts "#{spacing} level #{level}: right is NOT empty"
    puts "#{spacing} level #{level}: sorting right: #{right.to_s} of length #{right.length} with #{comparisons} comparisons"  
    rightSorted = Quicksort(right, right.length - 1, comparisons, level)
    rightSortedArr = rightSorted[0]
    comparisons = rightSorted[1]    
    puts "#{spacing} level #{level}: sorted right with #{comparisons} comparisons"
    
    puts "#{spacing} level #{level}: right sorted: #{rightSortedArr.to_s}"
    #comparisons = rightSorted[1].to_i + (right.length - 1)
    
    puts "#{spacing} level #{level}: left: #{left.to_s}"
    puts "#{spacing} level #{level}: right: #{right.to_s}"
    puts "#{spacing} level #{level}: leftSortedArr: #{leftSortedArr}"
    puts "#{spacing} level #{level}: rightSortedArr: #{rightSortedArr}"
    newArray = leftSortedArr.concat(rightSortedArr)
    puts "#{spacing} level #{level}: newArray: #{newArray}"
    
#  end
  return [array, comparisons]
end

result = Quicksort(ints, ints.length - 1, 0, 0)
print "done partitioning!\n"
print result[0].flatten.to_s + "\n"
print "#{result[1]} comparisons performed."

