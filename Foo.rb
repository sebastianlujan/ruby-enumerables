# frozen_string_literal: true
# reimplementing methods
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

  # Black arcane magic over voodoo
  def validate?(arg, element, equality)
    if arg.instance_of? Regexp
      arg.match?(element.to_s)
    elsif element.instance_of? arg.class #same type
      arg == element
    elsif arg.is_a? Class #TO_FIX
      element.is_a? arg
    else
      equality
    end
  end

  def my_all?(arg = nil)
    meet_condition = true
    my_each do |i|
      condition = block_given? && !yield(i)
      condition ||= !block_given? && arg.nil? && !i
      condition ||= !validate?(arg, i, true)
      return false if condition
    end
    meet_condition
  end

  def my_none?(arg = nil)
    meet_condition = true
    my_each do |i|
      return false if block_given? && yield(i)
      return false if !block_given? && arg.nil? && i == true
      return false if validate?(arg, i, false)
    end
    return meet_condition
  end

  def my_any?(arg = nil)
    meet_condition = false
    my_each do |i|
      condition = block_given? && yield(i)
      condition ||= !block_given? && arg.nil? && i
      condition ||= validate?(arg, i, meet_condition)
      return true if condition
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

  def inject(*args ) 
    acc = 0
    if block_given?
      my_each { |i| acc = yield(acc, i) }
      unless args.size.zero?
        if args.size == 1 && args[0].class == Integer
          acc = args[0]
          my_each { |i| acc = yield(acc, i) }
        end
      end
    else
      if args.size == 1 && args[0].class == Symbol
        my_each { |i| acc.call( args[1], i ) }
      end 
      if args.size == 2 && (args[0].class == Integer) && (args[1].class == Symbol)
        my_each {|i| args[0].call( args[1], i) }
      end
    end
    acc
  end

  def multiply_els(arg)
    arg.inject(:*)
  end
end

p %w{ant bear cat}.my_none? { |word| word.length == 5 } #=> true
p %w{ant bear cat}.my_none? { |word| word.length >= 4 } #=> false
p %w{ant bear cat}.my_none?(/d/)                        #=> true
p [1, 3.14, 42].my_none?(Float)                         #=> false
p [].my_none?                                           #=> true
p [nil].my_none?                                        #=> true
p [nil, false].my_none?                                 #=> true
p [nil, false, true].my_none?                           #=> false

require './test_basic.rb'

#[].multiply_els([2,4,5])