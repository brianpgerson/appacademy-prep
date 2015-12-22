def doubler(array)
  doubled_arr = []
  0.upto(array.length - 1) do |i|
    doubled_arr << array[i]*2
  end
  doubled_arr
end

print doubler([1,2,3])