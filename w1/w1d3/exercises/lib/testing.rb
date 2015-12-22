class Fixnum
  def stringify(base)
    digit_hash = {
      0 => "0",
      1 => "1", 
      2 => "2", 
      3 => "3", 
      4 => "4", 
      5 => "5", 
      6 => "6", 
      7 => "7", 
      8 => "8", 
      9 => "9", 
      10 => "a", 
      11 => "b", 
      12 => "c", 
      13 => "d", 
      14 => "e", 
      15 => "f", 
      16 => "g"
    }
    basepower = 1
    digits = []
    if self <= base || base == 10
      digit_hash[self]
    end
    while basepower < self
      digits << ((self/basepower)%base)
      basepower *= base
    end
    print digits
    digits.reverse!
    coded = (digits.map { |dig| digit_hash[dig] }).join("")
  end
end

puts 10.stringify(16)