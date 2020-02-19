# reimplementing methods
private
# Black arcane magic over voodoo
def validate?(arg, element, equality)
  if arg.instance_of? Regexp
    arg.match?(element.to_s)
  elsif element.instance_of? arg.class
    arg == element
  elsif arg.instance_of? Class
    element.is_a? arg
  else
    equality
  end
end

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

  def my_all?(arg = nil)
    my_each do |i|
      condition = block_given? && !yield(i)
      condition ||= !block_given? && arg.nil? && !i
      condition ||= !arg.nil? && !validate?(arg, i, false)
      return false if condition
    end
    true
  end

  def my_any?(arg = nil)
    my_each do |i|
      condition = block_given? && yield(i)
      condition ||= !block_given? && arg.nil? && i
      condition ||= !arg.nil? && validate?(arg, i, false)
      return true if condition
    end
    false
  end

  def my_none?(arg = nil)
    my_each do |i|
      condition = block_given? && yield(i)
      condition ||= !block_given? && arg.nil? && i
      condition ||= !arg.nil? && validate?(arg, i, false)
      return false if condition
    end
    true
  end

  def my_count(arg = nil)
    sum = 0
    my_each do |i|
      condition = arg.nil? && !block_given?
      condition ||= block_given? && yield(i)
      condition ||= !arg.nil? && i == arg
      sum += 1 if condition
    end
    sum
  end

  def my_map
    return to_enum(:my_map) unless block_given?

    arr = []
    my_each { |i| arr << yield(i) }
    arr
  end

  def inject_arg_valid?(*arg)
    acc = arg[0]&.is_a?(Numeric) ? arg[0] : to_a[0]
    if arg[0]&.is_a? Symbol
      operation = arg[0]
    elsif arg[1]&.is_a? Symbol
      operation = arg[1]
    end
    [acc, operation]
  end

  def eval_operation?(operation)
    ':/ :% :-'.include?(operation.to_s)
  end

  def inject_valid_symbol?
    ->(arg, i) { arg.size.between?(1, 2) && !i.zero? }
  end

  def my_inject(*arg)
    acc, operation = inject_arg_valid?(*arg)
    each_with_index do |e, i|
      if block_given? && arg.size < 2
        acc = yield(acc, e) if acc
      elsif inject_valid_symbol?.call(arg, i)
        e, acc = acc, e if eval_operation?(operation)
        acc = e.send(operation, acc)
      end
      next
    end
    acc
  end
end

def multiply_els(arg)
  arg.my_inject(1) { |acc, product| acc * product }
end

require './test_basic.rb'
