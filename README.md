# Enumerable methods 
[![Contributors][contributors-shield]][contributors-url]

<div style="text-align: center;" >
  <a href="https://www.microverse.org">
    <img src="img/m.png" height="70" width="70" style="background: #6f23ff;" alt="Microverse">
  </a>
  
  <p>
    <b>Enumerable methods</b></br>
    <a href="https://ruby-doc.org/core-2.6.5/Enumerable.html"><b>Enumerable</b></a>
  </p>
</div>



## Problem:

This is the second ruby project on the [Microverse](https://www.microverse.org) curriculum
Here I create my own implementation of the ruby Enumerable methods

```
#my_each_with_index
#my_select
#my_all?
#my_any?
#my_none?
#my_count
#my_map
#my_inject
```

#For testing purpose , create a multiply_els

```
multiply_els
multiply_els([2,4,5]) #=> 40
```

Extra bonus:
Modify your `#my_map` method to take a `proc` instead.
Modify your `#my_map` method to `take either a **proc or a block**. 

```
It won’t be necessary to apply both a proc and a block in the same #my_map 
call since you could get the same effect by chaining together one #my_map call
with the block and one with the proc. This approach is also clearer, 
since the user doesn’t have to remember whether the proc or block will be run first.
So if both a proc and a block are given, only execute the proc.

Quick Tips:

Remember yield and the #call method.
```

## Contact
Sebastian Lujan: [@Sebastian Lujan](https://github.com/sebastianlujan) | glujan.recalde@gmail.com 

[contributors-shield]: https://img.shields.io/github/contributors/sebastianlujan/ruby-enumerables?style=flat-square
[contributors-url]: https://github.com/sebastianlujan/ruby-enumerables/