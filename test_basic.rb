ary = [1, 2, 4, 2]

p ary.my_select(&:even?)
p ary.my_inject(:+) { |i| i }
p ary.my_select(&:even?)

identity = ->(i) { i }
f = ->(x) { x * 3 }

p ary.my_each(&identity)
p ary.my_select(&:even?)
p ary.my_map(&f)

p 'my_each_with_index'
hash = {}
%w[cat dog wombat].my_each_with_index do |item, index|
  hash[item] = index
end

to_three = Enumerator.new do |y|
  3.times do |x|
    y << x
  end
end

to_three_with_string = to_three.with_object('foo')
to_three_with_string.each do |x, string|
  puts "#{string}: #{x}"
end

gt_eq_four = ->(word) { word.length >= 4 }
gt_three = ->(word) { word.length >= 3 }
gt_eq_fifty = ->(word) { word.length >= 50 }
eq_five = ->(word) { word.length == 5 }

p hash #=> {'cat'=>0, 'dog'=>1, 'wombat'=>2}
p 'my_all'
p %w[ant bear cat].my_all?(&gt_three) # => true
p %w[ant bear cat].my_all?(&gt_eq_four) # => false
p %w[ant bear cat].my_all?(&gt_eq_fifty) # => false
p %w[ant bear cat].my_all?(/t/) # => false
p %w[ant beart cat].my_all?(/t/) # => true
p [1, 1, 1].my_all?(1) # => true
p [1, 1, 1].my_all?(3) # => false
p [nil, true, 99].my_all? # => false
p [true, 'a'].my_all? # => true
p [].my_all? # => true
p [1, 1, 1].my_all?('S') # => false
p [1, 2i, 3.14].my_all?(Numeric) # => true
p [1, 2i, 3.14, 'a'].my_all?(Numeric) # => false

p 'my_none'
p %w[ant bear cat].my_none?(&eq_five) #=> true
p %w[ant bear cat].my_none?(&gt_eq_four) #=> false
p %w[ant bear cat].my_none?(/d/) #=> true
p [1, 3.14, 42].my_none?(Float) #=> false
p [].my_none? #=> true
p [nil].my_none? #=> true
p [nil, false].my_none? #=> true
p [nil, false, true].my_none? #=> false

p 'my_any'
p %w[ant bear cat].my_any?(&gt_three) #=> true
p %w[ant bear cat].my_any?(&gt_eq_four) #=> true
p %w[ant bear cat].my_any?(&gt_eq_fifty) #=> false
p %w[ant bear cat].my_any?(/d/) #=> false
p %w[ant bear cat].my_any?(/t/) #=> true
p ['ant', 'beart', 1].my_any?(/t/) #=> true
p [nil, true, 99].my_any?(Integer) #=> true
p [1, 3.14, 42].my_any?(String) #=> false
p [nil, true, 99].my_any? #=> true
p [nil, true, 99].my_any? #=> true
p [true, 'a'].my_any? #=> true
p [].my_any? #=> false
p [1, 1, 1].my_any?(1) #=> true
p [1, 1, 1].my_any?(3) #=> false
p [1, 1, 1].my_any?('S') #=> false
p [1, 2i, 3.14].my_any?(Numeric) #=> true
p [1, 2i, 3.14, 'a'].my_any?(Numeric) #=> true

p 'my_count'
p ary.my_count #=> 4
p ary.my_count(2) #=> 2
p ary.my_count(&:even?) #=> 3
p ary.my_count('A') #=> 0

p 'my_inject'
sigma = (5..10).my_inject(:+) #=> 45
p sigma

product = (5..10).my_inject(1, :*) #=> 151200
p product

product = ->(acc, n) { acc * n }
product = (5..10).my_inject(1, &product) #=> 151200
p product

sigma = ->(sum, n) { sum + n }
sigma = (5..10).my_inject(&sigma) #=> 45
p sigma


p [1, 2, 3, 4].my_inject(:*) # 24
p [120, 30, 2].my_inject(:/) # 2
p [120, 30, 2].my_inject(:-) # 8

p multiply_els([2, 4, 5])# 40
