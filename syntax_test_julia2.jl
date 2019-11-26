# SYNTAX TEST "Packages/Julia/Julia.sublime-syntax"

# For information on how this file is used, see
# https://www.sublimetext.com/docs/3/syntax.html#testing
# Run tests by pressing `ctrl(or cmd)+shift+b`, i.e. run the `build` command


#=
  command block
# ^^^^^^^^^^^^^ comment.block.number-equal-sign
=#
# <- comment.block.number-equal-sign punctuation.definition.comment.number-equal-sign


##
## NUMBERS ====
##

  0b101
# ^^^^^ constant.numeric
  0o7
# ^^^ constant.numeric
  0xa3
# ^^^^ constant.numeric
  1e+123
# ^^^^^^ constant.numeric
  12e123
# ^^^^^^ constant.numeric
  1.32e+123
# ^^^^^^^^^ constant.numeric
  .32e+123
# ^^^^^^^^ constant.numeric
  1.e-123
# ^^^^^^^ constant.numeric
  11
# ^^ constant.numeric
  .11
# ^^^ constant.numeric
  11.
# ^^^ constant.numeric
  11.11
# ^^^^^ constant.numeric
  2.a
# ^^ constant.numeric
#   ^ meta.generic-name
# (issue 37)
  123_4_56_7
# ^^^^^^^^^^ constant.numeric
  0xa_3_f
# ^^^^^^^ constant.numeric
  0b1_0_1
# ^^^^^^^ constant.numeric
  1.3_2e+1_2_3
# ^^^^^^^^^^^^ constant.numeric.julia
# (issue 51)
  e2
# ^^ meta.generic-name
  2e
# ^ constant.numeric
#  ^ meta.generic-name
  2e2
# ^^^ constant.numeric
  e+2
# ^ meta.generic-name
#  ^ keyword.operator
#   ^ constant.numeric
  2+e
# ^ constant.numeric
#  ^ keyword.operator
#   ^ meta.generic-name


##
## CONSTANTS ====
##

  true
# ^^^^ constant.language
  false
# ^^^^^ constant.language
  nothing
# ^^^^^^^ constant.language
  missing
# ^^^^^^^ constant.language
  undef
# ^^^^^ constant.language
  NaN
# ^^^ constant.language
  NaN16
# ^^^^^ constant.language
  NaN32
# ^^^^^ constant.language
  NaN64
# ^^^^^ constant.language
  Inf
# ^^^ constant.language
  Inf16
# ^^^^^ constant.language
  Inf32
# ^^^^^ constant.language
  Inf64
# ^^^^^ constant.language
  ℯ
# ^ constant.language
  pi
# ^^ constant.language
  π
# ^ constant.language
  im
# ^^ constant.language
  ARGS
# ^^^^ constant.language
  C_NULL
# ^^^^^^ constant.language
  ENDIAN_BOM
# ^^^^^^^^^^ constant.language
  ENV
# ^^^ constant.language
  LOAD_PATH
# ^^^^^^^^^ constant.language
  PROGRAM_FILE
# ^^^^^^^^^^^^ constant.language
  STDERR
# ^^^^^^ constant.language
  STDIN
# ^^^^^ constant.language
  STDOUT
# ^^^^^^ constant.language
  VERSION
# ^^^^^^^ constant.language

##
## Variables and Functions ====
##


  bar
# ^^^ meta.generic-name.julia

  foo.bar
# ^^^ meta.generic-name
#    ^ punctuation.accessor.dot
#     ^^^ meta.generic-name

  foo.bar = 1
# ^^^ meta.generic-name.julia
#    ^ punctuation.accessor.dot.julia
#     ^^^ meta.generic-name.julia
#         ^ keyword.operator.assignment.julia

  foo.bar(x)
# ^^^ meta.function-call.julia variable.function.julia meta.generic-name.julia
#    ^ meta.function-call.julia punctuation.accessor.dot.julia
#     ^^^ meta.function-call.julia variable.function.julia meta.generic-name.julia
#         ^ meta.function-call.julia meta.function-call.arguments.julia meta.generic-name.julia
  (foo).bar(x)
#  ^^^ meta.group.julia meta.generic-name.julia
#      ^ punctuation.accessor.dot.julia
#       ^^^ meta.function-call.julia variable.function.julia meta.generic-name.julia

  bar(x = 1, y = 2, kwargs...)
# ^^^ meta.function-call variable.function
#    ^^^^^^^^^^^^^^^^^^^^^^^^^ meta.function-call.julia
#     ^ meta.function-call.arguments.julia variable.parameter.julia
#       ^ meta.function-call.arguments.julia keyword.operator.assignment.julia
#            ^ meta.function-call.arguments.julia variable.parameter.julia
#              ^ meta.function-call.arguments.julia keyword.operator.assignment.julia
#                ^ meta.function-call.arguments.julia constant.numeric.julia
#                   ^^^^^^ meta.function-call.arguments.julia meta.generic-name.julia
#                         ^^^ meta.function-call.arguments.julia keyword.operator.splat.julia

  bar(x == 1)
# ^^^ meta.function-call.julia variable.function.julia meta.generic-name.julia
#     ^ meta.function-call.arguments.julia meta.generic-name.julia
#       ^^ meta.function-call.arguments.julia keyword.operator.julia
#          ^ meta.function-call.arguments.julia constant.numeric.julia

  (bar())
# ^^^^^^^ meta.group.julia
#  ^^^ meta.function-call.julia variable.function.julia
#     ^^ meta.function-call.julia punctuation.section.arguments

  bar.()

  (bar).()
#  ^^^ meta.generic-name.julia
#      ^ keyword.operator.broadcast.julia
#       ^^ meta.function-call.julia punctuation.section.arguments

  (bar)(x, y) = 1
#  ^^^ meta.group.julia meta.generic-name.julia
#       ^^^^ meta.function.julia meta.function.parameters.julia

  bar(x, y) = 2
# ^^^ meta.function.julia entity.name.function.julia meta.generic-name.julia
#     ^ meta.function.julia meta.function.parameters.julia variable.parameter.julia
#        ^ meta.function.julia meta.function.parameters.julia variable.parameter.julia

  bar(a = 1, z = abc) = 1
#     ^ meta.function.julia meta.function.parameters.julia variable.parameter.julia
#                ^^^ meta.function.julia meta.function.parameters.julia meta.generic-name.julia
# ^^^ meta.function.julia entity.name.function.julia
  bar(a = 1) == 1
# ^^^ meta.function-call.julia variable.function.julia meta.generic-name.julia
#            ^^ keyword.operator.julia

  foo.bar(x) = 1
# ^^^^^^^ entity.name.function.julia
#    ^ punctuation.accessor.dot.julia
#         ^ meta.function.julia meta.function.parameters.julia variable.parameter.julia


  function foo(x, y)
#          ^^^ meta.function.julia entity.name.function.julia meta.generic-name.julia
#              ^ meta.function.julia meta.function.parameters.julia variable.parameter.julia
#               ^ meta.function.julia meta.function.parameters.julia punctuation.separator.arguments.julia
#                 ^ meta.function.julia meta.function.parameters.julia variable.parameter.julia
  end

  function bar.foo(x, y)
#          ^^^ meta.function.julia entity.name.function.julia meta.generic-name.julia
#             ^ meta.function.julia entity.name.function.julia punctuation.accessor.dot.julia
#              ^^^ meta.function.julia entity.name.function.julia meta.generic-name.julia
  end


  function (foo)(x, y)
#           ^^^ meta.group.julia meta.function.julia entity.name.function.julia meta.generic-name.julia
#                ^^^^ meta.function.julia meta.function.parameters.julia
  end

  function foo
#          ^^^ meta.function.julia entity.name.function.julia meta.generic-name.julia
  end

  function (x, y)
#           ^^^^ meta.function.julia meta.function.parameters.julia
  end

  function (f::Mytype)(x, y)
  end

  filter!()
# ^^^^^^^ meta.function-call.julia variable.function.julia support.function.julia
  length([1, 2])
# ^^^^^^ meta.function-call.julia variable.function.julia support.function.julia
  length(x::Mytype) = 1
# ^^^^^^ meta.function-call.julia entity.name.function.julia support.function.julia
  Base.filter!()
# ^^^^ meta.function-call.julia variable.function.julia support.module.julia
#     ^ meta.function-call.julia punctuation.accessor.dot.julia
#      ^^^^^^^ meta.function-call.julia variable.function.julia support.function.julia
  Base.length([1, 2])
# ^^^^ meta.function-call.julia variable.function.julia support.module.julia
#     ^ meta.function-call.julia punctuation.accessor.dot.julia
#      ^^^^^^ meta.function-call.julia variable.function.julia support.function.julia
  Base.length(x::Mytype) = 1
# ^^^^ meta.function-call.julia entity.name.function.julia support.module.julia
#     ^ meta.function-call.julia entity.name.function.julia punctuation.accessor.dot.julia
#      ^^^^^^ meta.function-call.julia entity.name.function.julia support.function.julia



##
## UNICODE WORD BOUDARIES ====
##

# Unicode and numbers in names (issue 18)
  β1 = 5
# ^^ meta.generic-name
  β3(x)
# ^^ variable.function
  β2(x) = x
# ^^ entity.name.function
  ∇1 = 5
# ^^ meta.generic-name
  ∇3(x)
# ^^ variable.function
  ∇2(∇2) = x
# ^^ entity.name.function
#    ^^^ meta.function meta.function.parameters


##
## RANGES ====
##

# (issue 14)
  a:b
# ^ meta.generic-name
#  ^ keyword.operator
#   ^ meta.generic-name
  1.:a
# ^^ constant.numeric
#   ^ keyword.operator
#    ^ meta.generic-name
  a:2.
# ^ meta.generic-name
#  ^ keyword.operator
#   ^^ constant.numeric
  23.:31.
# ^^^ constant.numeric
#    ^ keyword.operator
#     ^^^ constant.numeric
  β:f()
# ^ meta.generic-name
#  ^ keyword.operator
#   ^ variable.function
  f():1
# ^ variable.function
#    ^ keyword.operator
#     ^ constant.numeric

##
## TERNARY OPERATORS ====
##

  a ? b :c
# ^ meta.generic-name
#   ^ keyword.operator
#     ^ meta.generic-name
#       ^ keyword.operator
#        ^ meta.generic-name

  a? b : c
#  ^ invalid.operator.julia

  a ?b : c
#   ^ invalid.operator.julia


##
## Types ====
##

  Array{Int, 2}
# ^^^^^ meta.parametric-type.julia support.type.julia
#      ^ meta.parametric-type.julia punctuation.section.parameter.begin.julia
#       ^^^ meta.parametric-type.julia meta.parametric-type.parameters.julia support.type.julia
  Foo{Bar, 2}
# ^^^ meta.parametric-type.julia meta.generic-name.julia
#    ^ meta.parametric-type.julia punctuation.section.parameter.begin.julia
#     ^^^ meta.parametric-type.julia meta.parametric-type.parameters.julia meta.generic-name.julia
  y::MyArray{T, 2} where T foo
# ^ meta.generic-name.julia
#  ^^ keyword.operator.colons.julia
#    ^^^^^^^ meta.parametric-type.julia meta.generic-name.julia
#                  ^^^^^ meta.where-clause.julia keyword.control.julia
#                        ^ meta.where-clause.julia meta.generic-name.julia
#                          ^ - meta.where-clause.julia
  MyArray{T, 2} where T >: Int
# ^^^^^^^ meta.parametric-type.julia meta.generic-name.julia
#               ^^^^^ meta.where-clause.julia keyword.control.julia
#                     ^ meta.where-clause.julia meta.generic-name.julia
#                       ^^ meta.where-clause.julia keyword.operator.superset.julia
#                          ^^^ meta.where-clause.julia support.type.julia
  MyArray{T, 1} where T <: Array{S} where S
#                     ^ meta.where-clause.julia meta.generic-name.julia
#                       ^^ meta.where-clause.julia keyword.operator.subset.julia
#                          ^^^^^ meta.where-clause.julia meta.parametric-type.julia support.type.julia
#                               ^ meta.where-clause.julia meta.parametric-type.julia punctuation.section.parameter.begin.julia
#                                ^ meta.where-clause.julia meta.parametric-type.julia meta.parametric-type.parameters.julia meta.generic-name.julia
#                                 ^ meta.where-clause.julia meta.parametric-type.julia meta.parametric-type.parameters.julia punctuation.section.parameter.end.julia
#                                   ^^^^^ meta.where-clause.julia meta.where-clause.julia keyword.control.julia
#                                         ^ meta.where-clause.julia meta.where-clause.julia meta.generic-name.julia
  MyArray{T, S} where {T, S}
#                     ^ meta.where-clause.julia meta.parametric-type.julia punctuation.section.parameter.begin.julia
#                      ^ meta.where-clause.julia meta.parametric-type.julia meta.parametric-type.parameters.julia meta.generic-name.julia
#                         ^ meta.where-clause.julia meta.parametric-type.julia meta.parametric-type.parameters.julia meta.generic-name.julia
  MyArray{T, 1} where Int <: T <: Number
#                     ^^^ meta.where-clause.julia support.type.julia
#                         ^^ meta.where-clause.julia keyword.operator.subset.julia
#                            ^ meta.where-clause.julia meta.generic-name.julia
#                              ^^ meta.where-clause.julia keyword.operator.subset.julia
#                                 ^^^^^^ meta.where-clause.julia support.type.julia

  x::Int = 1
# ^ meta.generic-name.julia
#  ^^ keyword.operator.colons.julia
#    ^^^ support.type.julia
  x::Array{S, 2} where S = [2 2; 1 1]
#    ^^^^^ meta.parametric-type.julia support.type.julia
#                ^^^^^ meta.where-clause.julia keyword.control.julia
#                      ^ meta.where-clause.julia meta.generic-name.julia
#                        ^ keyword.operator.assignment.julia

  foo(1::Int, abc::Mytype)
  foo(x = 1::Int, y = abc::Mytype)
  (foo).(1::Int, abc::Mytype)

  foo(x::Int, y::Mytype) = x
  foo(::Int, ::Mytype) = x
  foo(::Int = 1, ::Mytype = 1.0) = x
  (foo::Int)(x::Int = 1, y::Mytype = 1.0) = x


##
## MACROS ====
##

macro foo(x, y)

end

@foo x y
@foo(x, y)


##
## Symbols ====
##

  foo(a = 1, :abc => foo())
# ^^^ meta.function-call.julia variable.function.julia meta.generic-name.julia
#            ^^^^ meta.function-call.julia meta.function-call.arguments.julia constant.other.symbol.julia
#                 ^^ meta.function-call.julia meta.function-call.arguments.julia keyword.operator.pair.julia

  :a.b
# ^ keyword.operator
#  ^ constant.other.symbol
#    ^ meta.generic-name
# (issue 3)
  ,:βa
#  ^ keyword.operator
#   ^^ constant.other.symbol
  [:+]
#  ^ keyword.operator
#   ^ constant.other.symbol
  (:∘)
#  ^ keyword.operator
#   ^ constant.other.symbol
  :a!
# ^ keyword.operator
#  ^^ constant.other.symbol
  :(:)
# ^ keyword.operator
#  ^ source.julia
#    ^ source.julia
  :(a)
# ^ keyword.operator
#  ^ source.julia
#   ^ meta.generic-name
#      ^ source.julia
  :++a
# ^ keyword.operator
#  ^^ constant.other.symbol
#    ^ meta.generic-name
  :+a
# ^ keyword.operator
#  ^ constant.other.symbol
#   ^ meta.generic-name
  :∘+a # Yes, this is correct, equivalent to +(:∘, a)
# ^ keyword.operator
#  ^ constant.other.symbol
#   ^ keyword.operator
#    ^ meta.generic-name
  :.///a
# ^ keyword.operator
#  ^^^ constant.other.symbol
#     ^ keyword.operator
#      ^ meta.generic-name
# (issue 43)
  :function
# ^ keyword.operator
#  ^^^^^^^^ constant.other.symbol


##
## Chars ====
##

  s = '\''
  s = 'ab'

##
## Strings ====
##

  s = "\U03b1\U03b2"
  s =  "foo + $apple"
  s = """
  apple
  orange
  banana
  """
  s = "$('\U03b1')\U03b2"
  s = "$(apple + 1)\U03b2"
  r = r"[a-z0-9]{2, 3}"

  r"""
  [a-z0-9]{2, 3}"""

  r"\""
  r"""a"b"""

  b"DATA\xff\u2200"
  b"""DATA\xff\u2200"""

  v"3.0-"

  raw"abc\"few"
