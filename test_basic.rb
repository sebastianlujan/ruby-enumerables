=begin
  ary = [1, 2, 4, 2]

  p ary.my_select(&:even?)
  #p ary.my_inject(:+) { |i| i }
  p ary.my_select(&:even?)

  identity = ->(i) { i }
  f = ->(x) { x * 3 }

  p ary.my_each(&identity)
  p ary.my_select(&:even?)
  p ary.my_map(&f)

  p "my_each_with_index"
  hash = Hash.new
  %w(cat dog wombat).my_each_with_index { |item, index|
    hash[item] = index
  }

  p hash   #=> {"cat"=>0, "dog"=>1, "wombat"=>2}
=end

  #p "my_all"

  #p %w[ant bear cat].my_all? { |word| word.length >= 3 } #=> true
  #p %w[ant bear cat].my_all? { |word| word.length >= 4 } #=> false
  #p %w[ant bear cat].my_all? { |word| word.length >= 69 } #=> false

  #p %w[ant bear cat].my_all?(/t/)                        #=> false
  #p %w[ant beart cat].my_all?(/t/)                       #=> true

  #p [1,1,1].my_all?(1)                                   #=> true
  #p [1,1,1].my_all?(3)                                   #=> false#

  #p [nil, true, 99].my_all?                              #=> false
  #p [true, 'a'].my_all?                                  #=> true
  #p [].my_all?                                           #=> true
  #p [1, 1, 1].my_all?('S')                               #=> false
  #p [1, 2i, 3.14].my_all?(Numeric)                       #=> true
  #p [1, 2i, 3.14, 'a'].my_all?(Numeric)                  #=> falso

  #p "my_none"
#
  #p %w{ant bear cat}.my_none? { |word| word.length == 5 } #=> true
  #p %w{ant bear cat}.my_none? { |word| word.length >= 4 } #=> false
  #p %w{ant bear cat}.my_none?(/d/)                        #=> true
  #p [1, 3.14, 42].my_none?(Float)                         #=> false
  #p [].my_none?                                           #=> true
  #p [nil].my_none?                                        #=> true
  #p [nil, false].my_none?                                 #=> true
  #p [nil, false, true].my_none?                           #=> false

=begin
  p "my_any"
  p %w[ant bear cat].my_any? { |word| word.length >= 3 } #=> true
  p %w[ant bear cat].my_any? { |word| word.length >= 4 } #=> true
  p %w[ant bear cat].my_any? { |word| word.length >= 50 }#=> false
  p %w[ant bear cat].my_any?(/d/)                         #=> false
  p %w[ant bear cat].my_any?(/t/)                         #=> true
  p ['ant', 'beart', 1].my_any?(/t/)                      #=> true
  p [nil, true, 99].my_any?(Integer)                      #=> true
  p [1, 3.14, 42].my_any?(String)                         #=> false
  p [nil, true, 99].my_any?                               #=> true
  p [nil, true, 99].my_any?                               #=> true
  p [true, 'a'].my_any?                                   #=> true
  p [].my_any?                                            #=> false
  p [1,1,1].my_any?(1)                                    #=> true
  p [1,1,1].my_any?(3)                                    #=> false
  p [1, 1,1].my_any?('S')                                 #=> false
  p [1, 2i, 3.14].my_any?(Numeric)                        #=> true
  p [1, 2i, 3.14, 'a'].my_any?(Numeric)                   #=> true
=end 
=begin
  p "my_count"
  p ary.my_count               #=> 4
  p ary.my_count(2)            #=> 2
  p ary.my_count{ |x| x%2==0 } #=> 3
  p ary.my_count('A')
=end

p (5..10).reduce(:+)                             #=> 45
p (5..10).reduce(1, :*)                          #=> 151200
p (5..10).inject(1) { |product, n| product * n } #=> 151200
p (5..10).inject { |sum, n| sum + n }            #=> 45
