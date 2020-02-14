# frozen_string_literal: true
module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    size.times { |i| yield(to_a[i]) }
    self
  end

  def my_each_with_index 
    return to_enum(:my_each_with_index) unless block_given?

    size.times { |i| yield(to_a[i], i) }
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    arr = []
    my_each { |i| arr << i if yield(i) }
    arr
  end

  def validate?(arg, element, equality)
    if arg.instance_of? Regexp
      arg.match? element
    elsif element.instance_of? arg.class
      arg == element
    elsif arg.is_a? Class
      element.is_a? arg
    else
      equality
    end
  end

  def my_all?(arg = nil)
    meet_condition = true
    my_each do |i|
      return !meet_condition if block_given? && !yield(i)
      return !(i.nil? || i == !meet_condition) if arg.nil?

      meet_condition &= validate?(arg, i, !meet_condition)
    end
    meet_condition
  end

  def my_none?(obj = nil)
    meet_condition = true
    my_each do |i|
      return false if block_given? && yield(i)
      #return (i.nil? || i == meet_condition) if obj.nil?

      #meet_condition = meet_condition validate?(obj, i, false)
    end
    meet_condition
  end

  def my_any?(arg = nil)
    meet_condition = false
    my_each do |i|
      return true if block_given? && yield(i)
      return true if !block_given? && arg.nil? && i

      meet_condition = !meet_condition && validate?(arg, i, meet_condition)
    end
    meet_condition
  end

  def my_count(arg = nil)
    sum = 0
    my_each do |i|
      condition = arg.nil? && !block_given?
      condition ||= block_given? && yield(i)
      condition ||= (!arg.nil? && i == arg)
      sum += 1 if condition
    end
    sum
  end

  def my_map
    arr = []
    my_each { |i| arr << yield(i) }
    arr
  end
end

# p arr.my_select(&:even?)
# p arr.my_inject(:+) { |i| i }
# p arr.my_select(&:even?)
# identity = ->(i) { i }
# f = ->(x) { x * 3 }
# p ary.my_each(&identity)
# p ary.my_select(&:even?)
=begin
p ary.my_map(&f)

p "my_each_with_index"
hash = Hash.new
%w(cat dog wombat).my_each_with_index { |item, index|
  hash[item] = index
}
p hash   #=> {"cat"=>0, "dog"=>1, "wombat"=>2}
=end

  p "my_all"

  #p%w[ant bear cat].my_all? { |word| word.length >= 3 } #=> true
  #p %w[ant bear cat].my_all? { |word| word.length >= 4 } #=> false
  #p %w[ant bear cat].my_all?(/t/)                        #=> false
  #p %w[ant beart cat].my_all?(/t/)                        #=>true
  #p [1,1,1].my_all?(1)                                   #=>true
  #p [1,1,1].my_all?(3)                                   #=>false
  #p [nil, true, 99].my_all?                              #=>false
  #p [true, 'a'].my_all?                                  #=>true
  #p [].my_all?                                              #=>true
  #p [1, 1, 1].my_all?('S')                               #=>false
  #p [1, 2i, 3.14].my_all?(Numeric)                       #=> true
  #p [1, 2i, 3.14, 'a'].my_all?(Numeric)                  #=> falso

  p "my_none"

  p %w{ant bear cat}.my_none? { |word| word.length == 5 } #=> true
  p %w{ant bear cat}.my_none? { |word| word.length >= 4 } #=> false
  #p %w{ant bear cat}.my_none?(/d/)                        #=> true
  #p [1, 3.14, 42].my_none?(Float)                         #=> false
  #p [].my_none?                                           #=> true
  #p [nil].my_none?                                        #=> true
  #p [nil, false].my_none?                                 #=> true
  #p [nil, false, true].my_none?                           #=> false

  p "my_any"

  #p %w[ant bear cat].my_any? { |word| word.length >= 3 } #=> true
  #p %w[ant bear cat].my_any? { |word| word.length >= 4 } #=> true
  #p %w[ant bear cat].my_any? { |word| word.length >= 50 } #=> false
  #p %w[ant bear cat].my_any?(/d/)                        #=> false
  #p [nil, true, 99].my_any?(Integer)                     #=> true
  #p [nil, true, 99].my_any?                              #=> true
  #p [].my_any?                                           #=> false

  ary = [1, 2, 4, 2]

  p "my_count"
=begin
  p ary.my_count               #=> 4
  p ary.my_count(2)            #=> 2
  p ary.my_count{ |x| x%2==0 } #=> 3
  p ary.my_count('A')
=end