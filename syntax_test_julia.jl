# SYNTAX TEST "Packages/Julia-sublime/Julia.sublime-syntax"

# For information on how this file is used, see
# https://www.sublimetext.com/docs/3/syntax.html#testing
# Run tests by pressing `ctrl+shift+b`, i.e. run the `build` command


##
## NUMBERS
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
#   ^ variable.other
# (issue 37)
  123_4_56_7
# ^^^^^^^^^^ constant.numeric
  0xa_3_f
# ^^^^^^^ constant.numeric
  0b1_0_1
# ^^^^^^^ constant.numeric
  1.3_2e+1_2_3
# ^^^^^^^^^^^^ constant.numeric
# (issue 51)
  e2
# ^^ variable.other
  2e
# ^ constant.numeric
#  ^ variable.other
  2e2
# ^^^ constant.numeric
  e+2
# ^ variable.other
#  ^ keyword.operator
#   ^ constant.numeric
  2+e
# ^ constant.numeric
#  ^ keyword.operator
#   ^ variable.other


##
## CONSTANTS
##

  true
# ^^^^ constant.language
  false
# ^^^^^ constant.language
  nothing
# ^^^^^^^ constant.language
  missing
# ^^^^^^^ constant.language
  uninitialized
# ^^^^^^^^^^^^^ constant.language
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
## FUNCTION CALLS
##

# (issue 9, 16)
  !β!(x)
# ^ keyword.operator
#  ^^ variable.function
#     ^ variable.other
  (x,f(x))
#  ^ variable.other
#    ^ variable.function
#      ^ variable.other
  √(2.3)
# ^ variable.function
#   ^^^ constant.numeric
  TypeConstructor{Foo()}(a)
# ^^^^^^^^^^^^^^^ variable.function
#                ^^^^^^^ support.type
#                        ^ variable.other

# (issue 30)
  f(a, ")=") a
# ^ variable.function
#   ^ variable.other
#      ^^^^ string.quoted.double
#            ^ variable.other
  f(a, a=")=") = a
# ^ entity.name.function
#   ^ variable.parameter
#      ^ variable.parameter
#       ^ keyword.operator
#        ^^^^ string.quoted.double
#              ^ keyword.operator
#                ^ variable.other
  f(a, a=(")=")) = a
# ^ entity.name.function
#   ^ variable.parameter
#      ^ variable.parameter
#       ^ keyword.operator
#         ^^^^ string.quoted.double
#                ^ keyword.operator
#                  ^ variable.other
  f(a, a=")=\"a") = a
# ^ entity.name.function
#   ^ variable.parameter
#      ^ variable.parameter
#       ^ keyword.operator
#        ^^^ string.quoted.double
#           ^^ constant.character.escape
#             ^^ string.quoted.double
#                 ^ keyword.operator
#                   ^ variable.other

# (issue 46)
  f(x)
# ^^^^ meta.function-call
# ^ variable.function
#   ^  meta.function-call.arguments
  abs(x)
# ^^^ support.function
# ^^^ variable.function
  f(x=1)
# ^ variable.function
#   ^ variable.parameter
#    ^ keyword.operator.assignment

# (issue 47)
  Base
# ^^^^ support.module
  Pkg.foo()
# ^^^ support.module
#     ^^^ variable.function
  Core.foo(x) = 2
# ^^^^ support.module
  filter!()
# ^^^^^^^ support.function
  length
# ^^^^^^ support.function
  Base.filter!()
# ^^^^ support.module
#      ^^^^^^^ support.function
  Base.filter()
# ^^^^ support.module
#      ^^^^^^ support.function
  Base.filter!
# ^^^^ support.module
#      ^^^^^^^ support.function
  Base.length
# ^^^^ support.module
#      ^^^^^^ support.function


##
## UNICODE WORD BOUDARIES
##

# Unicode and numbers in names (issue 18)
  β1 = 5
# ^^ variable.other
  β3(x)
# ^^ variable.function
  β2(x) = x
# ^^ entity.name.function
  ∇1 = 5
# ^^ variable.other
  ∇3(x)
# ^^ variable.function
  ∇2(∇2) = x
# ^^ entity.name.function
#    ^^ variable.parameter

# (issue 11)
  a::B{C}=c()
#  ^^ keyword.operator
#    ^^^^ support.type
#        ^ keyword.operator
#         ^ variable.function


##
## SYMBOLS
##

  :a.b
# ^ keyword.operator
#  ^ constant.other.symbol
#    ^ variable.other
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
#   ^ variable.other
#      ^ source.julia
  :++a
# ^ keyword.operator
#  ^^ constant.other.symbol
#    ^ variable.other
  :+a
# ^ keyword.operator
#  ^ constant.other.symbol
#   ^ variable.other
  :∘+a # Yes, this is correct, equivalent to +(:∘, a)
# ^ keyword.operator
#  ^ constant.other.symbol
#   ^ keyword.operator
#    ^ variable.other
  :.///a
# ^ keyword.operator
#  ^^^ constant.other.symbol
#     ^ keyword.operator
#      ^ variable.other
# (issue 43)
  :function
# ^ keyword.operator
#  ^^^^^^^^ constant.other.symbol

:.a
:.+a
:.∘a
:++a
:+++a
:/a
://a
:///a
:.///a


##
## TERNARY OPERATORS
##

  a?b:c
# ^ variable.other
#  ^ keyword.operator
#   ^ variable.other
#    ^ keyword.operator
#     ^ variable.other
  a ? b :c
# ^ variable.other
#   ^ keyword.operator
#     ^ variable.other
#       ^ keyword.operator
#        ^ variable.other


##
## RANGES
##

# (issue 14)
  a:b
# ^ variable.other
#  ^ keyword.operator
#   ^ variable.other
  1.:a
# ^^ constant.numeric
#   ^ keyword.operator
#    ^ variable.other
  a:2.
# ^ variable.other
#  ^ keyword.operator
#   ^^ constant.numeric
  23.:31.
# ^^^ constant.numeric
#    ^ keyword.operator
#     ^^^ constant.numeric
  β:f()
# ^ variable.other
#  ^ keyword.operator
#   ^ variable.function
  f():1
# ^ variable.function
#    ^ keyword.operator
#     ^ constant.numeric


##
## TYPES
##

  f(x::Foo, ::Bar{1, 2})
# ^ variable.function
#   ^ variable.other
#    ^^ keyword.operator
#      ^^^ support.type
#           ^^ keyword.operator
#             ^^^^^^^^^ support.type
# Nested types
  x::A{B,C{D,E},F{G,H{I,J{K,L{M}},N}}} closed
#  ^^ keyword.operator
#    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ support.type
# (issue 19)
  myvar::MyModule.MyType
# ^^^^^ variable.other
#      ^^ keyword.operator
#        ^^^^^^^^^^^^^^^ support.type

# Modules (issue 19)
  MyModule.myfunc(x)
# ^^^^^^^^ variable.other
#          ^^^^^^ variable.function
#                 ^ variable.other

# (issue 11)
  aa::AA{BB} = fun{CC{DD}}()
# ^^ variable.other
#   ^^ keyword.operator
#     ^^^^^^ support.type
#            ^ keyword.operator
#              ^^^ variable.function
#                 ^^^^^^^^ support.type
  aa::AA{BB}=fun{CC{DD}}() closed
# ^^ variable.other
#   ^^ keyword.operator
#     ^^^^^^ support.type
#           ^ keyword.operator
#            ^^^ variable.function
#               ^^^^^^^^ support.type
#                          ^^^^^^ variable.other
  mytype = Array
# ^^^^^^ variable.other
#        ^ keyword.operator
#          ^^^^^ support.type
  mytype = Array{Int}
# ^^^^^^ variable.other
#        ^ keyword.operator
#          ^^^^^^^^^^ support.type
  mytype = CallMsg{:call}
#          ^^^^^^^^^^^^^^ support.type

# Julia 0.6 (issue 45)
  A = Array{T} where T<:Integer{Foo}
#     ^^^^^^^^ support.type
#              ^^^^^ keyword.other
#                    ^ support.type
#                     ^^ keyword.operator
#                       ^^^^^^^^^^^^ support.type
  S >: T
# ^ support.type
#   ^^ keyword.operator
#      ^ support.type
  Foo <: $A{$A}
# ^^^ support.type
#     ^^ keyword.operator
#        ^^^^^^ support.type
  $A{$A} >: $A{$A}
# ^^^^^^ support.type
#        ^^ keyword.operator
#           ^^^^^^ support.type

# (issue 17)
# All things being defined are green, types as well
  mutable struct Foo{T<:Real} end
# ^^^^^^^ keyword.other
#         ^^^^^^ keyword.other
#                ^^^ entity.name.type
#                   ^^^^^^^^^ support.type
  mutable struct A <: B end
# ^^^^^^^ keyword.other
#         ^^^^^^ keyword.other
#                ^ entity.name.type
#                  ^^ keyword.operator
#                     ^ support.type
#                       ^^^ keyword.other
  mutable struct Foo{T}<:Bar{T} end
# ^^^^^^^ keyword.other
#         ^^^^^^ keyword.other
#                ^^^ entity.name.type
#                   ^^^ support.type
#                      ^^ keyword.operator
#                        ^^^^^^ support.type
  struct Foo{T<:Real} end
# ^^^^^^ keyword.other
#        ^^^ entity.name.type
#           ^^^^^^^^^ support.type
  const Foo{T} Bar{T}
# ^^^^^ keyword.other
#       ^^^^^^ support.type
#              ^^^^^^ support.type
  primitive type Foo{T}<:Bar{T} 32 end
# ^^^^^^^^^ keyword.other
#           ^^^^ keyword.other
#                ^^^ entity.name.type
#                   ^^^ support.type
#                      ^^ keyword.operator
#                        ^^^^^^ support.type
#                               ^^ constant.numeric

# Julia 0.6 (issue 45)
  struct Foo{T} end
# ^^^^^^ keyword.other
#        ^^^ entity.name.type
#           ^^^ support.type
#               ^^^ keyword.other
  mutable struct Foo{T} end
# ^^^^^^^ keyword.other
#         ^^^^^^ keyword.other
#                ^^^ entity.name.type
#                   ^^^ support.type
#                       ^^^ keyword.other
  abstract type Foo{T} end
# ^^^^^^^^ keyword.other
#          ^^^^ keyword.other
#               ^^^ entity.name.type
#                  ^^^ support.type
#                      ^^^ keyword.other
  primitive type Char 32 end
# ^^^^^^^^^ keyword.other
#           ^^^^ keyword.other
#                ^^^^ entity.name.type
#                     ^^ constant.numeric
#                        ^^^ keyword.other

# (issue 52)
  mutable struct $Foo{T} end
# ^^^^^^^ keyword.other
#         ^^^^^^ keyword.other
#                ^^^^ entity.name.type
#                    ^^^ support.type
#                        ^^^ keyword.other


##
## FUNCTION DEFINITIONS
##

  function f(a::b) end
# ^^^^^^^^ keyword.other
#          ^ entity.name.function
#            ^ variable.parameter
#             ^^ keyword.operator
#               ^ support.type
#                  ^^^ keyword.other

  function Module.foo!{T<:Real}(xx::Aa{Bb}, β::Aa{Bb}=1.::Aa{Bb}, c) end
# ^^^^^^^^ keyword.other
#          ^^^^^^ variable.other
#                ^ keyword.operator
#                 ^^^^ entity.name.function
#                     ^^^^^^^^^ support.type
#                               ^^ variable.parameter
#                                 ^^ keyword.operator
#                                   ^^^^^^ support.type
#                                           ^ variable.parameter
#                                            ^^ keyword.operator
#                                              ^^^^^^ support.type
#                                                    ^ keyword.operator
#                                                     ^^ constant.numeric
#                                                       ^^ keyword.operator
#                                                         ^^^^^^ support.type
#                                                                 ^ variable.parameter
#                                                                    ^^^ keyword.other

# Infix operator declaration
  function ∘{T<:Real}(xx::Aa{Bb}, β::Aa{Bb}=1.::Aa{Bb}, c) end
# ^^^^^^^^ keyword.other
#          ^ entity.name.function
#           ^^^^^^^^^ support.type
#                     ^^ variable.parameter
#                       ^^ keyword.operator
#                         ^^^^^^ support.type
#                                 ^ variable.parameter
#                                  ^^ keyword.operator
#                                    ^^^^^^ support.type
#                                          ^ keyword.operator
#                                           ^^ constant.numeric
#                                             ^^ keyword.operator
#                                               ^^^^^^ support.type
#                                                       ^ variable.parameter
#                                                          ^^^ keyword.other

# Infix operator declaration in module
  function Module.∘{T<:Real}(xx::Aa{Bb}, β::Aa{Bb}=1.::Aa{Bb}, c) end
# ^^^^^^^^ keyword.other
#          ^^^^^^ variable.other
#                ^ keyword.operator
#                 ^ entity.name.function
#                  ^^^^^^^^^ support.type
#                            ^^ variable.parameter
#                              ^^ keyword.operator
#                                ^^^^^^ support.type
#                                        ^ variable.parameter
#                                         ^^ keyword.operator
#                                           ^^^^^^ support.type
#                                                 ^ keyword.operator
#                                                  ^^ constant.numeric
#                                                    ^^ keyword.operator
#                                                      ^^^^^^ support..type
#                                                              ^ variable.parameter
#                                                                 ^^^ keyword.other

# Assignemetn-form function declaration (issue 19)
  MyModule.foo!{T<:Real}(xx::Aa{Bb}, β::Aa{Bb}=1.::Aa{Bb}, c) = kron(a, b)
# ^^^^^^^^ variable.other
#          ^^^^ entity.name.function
#              ^^^^^^^^^ support.type
#                        ^^ variable.parameter
#                          ^^ keyword.operator
#                            ^^^^^^ support.type
#                                    ^ variable.parameter
#                                     ^^ keyword.operator
#                                       ^^^^^^ support.type
#                                             ^ keyword.operator
#                                              ^^ constant.numeric
#                                                ^^ keyword.operator
#                                                  ^^^^^^ support.type
#                                                          ^ variable.parameter
#                                                             ^ keyword.operator

# Assignemetn-form infix operator declaration
  ∘{T<:Real}(xx::Aa{Bb}, β::Aa{Bb}=1.::Aa{Bb}, c) = ...
# ^ entity.name.function
#  ^^^^^^^^^ support.type
#            ^^ variable.parameter
#              ^^ keyword.operator
#                ^^^^^^ support.type
#                        ^ variable.parameter
#                         ^^ keyword.operator
#                           ^^^^^^ support.type
#                                 ^ keyword.operator
#                                  ^^ constant.numeric
#                                    ^^ keyword.operator
#                                      ^^^^^^ support.type
#                                              ^ variable.parameter
#                                                 ^ keyword.operator

# Assignemetn-form infix operator declaration in module
  MyModule.∘{T<:Real}(xx::Aa{Bb}, β::Aa{Bb}=1.::Aa{Bb}, c) = ...
# ^^^^^^^^ variable.other
#          ^ entity.name.function
#           ^^^^^^^^^  support.type
#                     ^^ variable.parameter
#                       ^^ keyword.operator
#                         ^^^^^^  support.type
#                                 ^ variable.parameter
#                                  ^^ keyword.operator
#                                    ^^^^^^  support.type
#                                          ^ keyword.operator
#                                           ^^ constant.numeric
#                                             ^^ keyword.operator
#                                               ^^^^^^ support.type
#                                                       ^ variable.parameter
#                                                          ^ keyword.operator

# (issue 23)
  f(a::B{()}) = ...
# ^ entity.name.function
#   ^ variable.parameter
#    ^^ keyword.operator
#      ^^^^^ support.type
#             ^ keyword.operator

# Splats and interpolated types
  f(x..., x::$Foo..., a=a) = ...
# ^ entity.name.function
#   ^ variable.parameter
#    ^^^ keyword.operator
#         ^ variable.parameter
#          ^^ keyword.operator
#            ^^^^ support.type
#                ^^^ keyword.operator
#                     ^ variable.parameter
#                      ^ keyword.operator
#                       ^ variable.other
  function f(x..., x::$Foo{$T}..., a=a) end
# ^^^^^^^^ keyword.other
#          ^ entity.name.function
#            ^ variable.parameter
#             ^^^ keyword.operator
#                  ^ variable.parameter
#                   ^^ keyword.operator
#                     ^^^^^^^^ support.type
#                             ^^^ keyword.operator
#                                  ^ variable.parameter
#                                   ^ keyword.operator
#                                    ^ variable.other
#                                       ^^^ keyword.other

# Parenthesized function name
  function (a)(b) end
# ^^^^^^^^ keyword.other
#           ^ entity.name.function
#              ^ variable.parameter
#                 ^^^ keyword.other
  function (+)(a) end
# ^^^^^^^^ keyword.other
#           ^ entity.name.function
#              ^ variable.parameter
#                 ^^^ keyword.other
  (+)(a, b) = ...
#  ^ entity.name.function
#     ^ variable.parameter
#        ^ variable.parameter
#           ^ keyword.operator

# Anonymous function
  function (a) foo end
# ^^^^^^^^ keyword.other
#           ^ variable.parameter
#              ^^^ variable.other
#                  ^^^ keyword.other

# Type constructor
 (::Type{Foo{A}}){B}(a::Bar{B}) = ...
# ^^ keyword.operator
#   ^^^^^^^^^^^^ entity.name.function
#                ^^^ support.type
#                    ^ variable.parameter
#                     ^^ keyword.operator
#                       ^^^^^^ support.type
  function (::Type{Foo{A}}){B}(a::Bar{b})
# ^^^^^^^^ keyword.other
#           ^^ keyword.operator
#             ^^^^^^^^^^^^ entity.name.function
#                          ^^^ support.type
#                              ^ variable.parameter
#                               ^^ keyword.operator
#                                 ^^^^^^ support.type
  f(a="()") = a
# ^ entity.name.function
#   ^ variable.parameter
#     ^^^^ string.quoted
#           ^ keyword.operator
#             ^ variable.other

  (::f{A()}){A{B()}}(a) = ...
#  ^^ keyword.operator
#    ^^^^^^ entity.name.function
#           ^^^^^^^^ support.type
#                    ^ variable.parameter

  f(a=[b,c]) = d
# ^ entity.name.function
#   ^ variable.parameter
#    ^ keyword.operator
#      ^ variable.other
#        ^ variable.other
#            ^ keyword.operator
#              ^ variable.other

# (issue 31)
  f(x::A=5; z) = ...
# ^ entity.name.function
#   ^ variable.parameter
#    ^^ keyword.operator
#      ^ support.type
#       ^ keyword.operator
#        ^ constant.numeric
#           ^ variable.parameter

# (issue 33)
  f(::Int, x::Float64) = x
# ^ entity.name.function
#   ^^ keyword.operator
#     ^^^ support.type
#          ^variable.parameter
#           ^^ keyword.operator
#             ^^^^^^^ support.type

  f(; x::Float64) = x
# ^ entity.name.function
#     ^ variable.parameter
#      ^^ keyword.operator
#        ^^^^^^^ support.type

# The following fails, function parameters should be highlighted.
# There seems to be no way of solving this, see issue #33.
  f(x,
    y) = ...
# Tests are removed, to avoid superfluous test fails (comments are ignored).

# (issue 40)
  function foo end
# ^^^^^^^^ keyword.other
#          ^^^ entity.name.function
#              ^^^ keyword.other
  function foo (x) end
# ^^^^^^^^ keyword.other
#          ^^^ entity.name.function
#               ^ variable.parameter
#                  ^^^ keyword.other

# Jula 0.6 (issue 45)
  function inv(M::Matrix{T}) where T<:AbstractFloat end
# ^^^^^^^^ keyword.other
#          ^^^ entity.name.function
#              ^ variable.parameter
#               ^^ keyword.operator
#                 ^^^^^^^^^ support.type
#                            ^^^^^ keyword.other
#                                  ^  support.type
#                                   ^^ keyword.operator
#                                     ^^^^^^^^^^^^^ support.type
#                                                   ^^^ keyword.other
  function inv(M::Matrix{T} where T<:AbstractFloat) end
# ^^^^^^^^ keyword.other
#          ^^^ entity.name.function
#              ^ variable.parameter
#               ^^ keyword.operator
#                 ^^^^^^^^^ support.type
#                           ^^^^^ keyword.other
#                                 ^  support.type
#                                  ^^ keyword.operator
#                                    ^^^^^^^^^^^^^ support.type
#                                                   ^^^ keyword.other
  inv(M::Matrix{T}) where T<:AbstractFloat = M
# ^^^ entity.name.function
#     ^ variable.parameter
#      ^^ keyword.operator
#        ^^^^^^^^^ support.type
#                   ^^^^^ keyword.other
#                         ^  support.type
#                          ^^ keyword.operator
#                            ^^^^^^^^^^^^^ support.type
#                                          ^ keyword.operator
  inv(M::Matrix{T}) where {T<:AbstractFloat} = M
# ^^^ entity.name.function
#     ^ variable.parameter
#      ^^ keyword.operator
#        ^^^^^^^^^ support.type
#                   ^^^^^ keyword.other
#                         ^^  support.type
#                           ^^ keyword.operator
#                             ^^^^^^^^^^^^^^ support.type
#                                            ^ keyword.operator
  inv(M::Matrix{T} where T<:AbstractFloat) = M
# ^^^ entity.name.function
#     ^ variable.parameter
#      ^^ keyword.operator
#        ^^^^^^^^^ support.type
#                  ^^^^^ keyword.other
#                        ^  support.type
#                         ^^ keyword.operator
#                           ^^^^^^^^^^^^^ support.type
#                                          ^ keyword.operator
  inv(M::Matrix{T} where {T<:AbstractFloat}) = M
# ^^^ entity.name.function
#     ^ variable.parameter
#      ^^ keyword.operator
#        ^^^^^^^^^ support.type
#                  ^^^^^ keyword.other
#                        ^^  support.type
#                          ^^ keyword.operator
#                            ^^^^^^^^^^^^^^ support.type
#                                            ^ keyword.operator
  f(x::Array{T,S} where T) = x
# ^ entity.name.function
#   ^ variable.parameter
#    ^^ keyword.operator
#      ^^^^^^^^^^ support.type
#                 ^^^^^ keyword.other
#                       ^ support.type
#                          ^ keyword.operator
  f(x::Array{T,S} where T where S) = x
# ^ entity.name.function
#   ^ variable.parameter
#    ^^ keyword.operator
#      ^^^^^^^^^^ support.type
#                 ^^^^^ keyword.other
#                       ^ support.type
#                         ^^^^^ keyword.other
#                               ^ support.type
#                                  ^ keyword.operator
  f(x::Array{T,S}) where T = x
# ^ entity.name.function
#   ^ variable.parameter
#    ^^ keyword.operator
#      ^^^^^^^^^^ support.type
#                  ^^^^^ keyword.other
#                        ^ support.type
#                          ^ keyword.operator
  f(x::Array{T,S}) where T where S = x
# ^ entity.name.function
#   ^ variable.parameter
#    ^^ keyword.operator
#      ^^^^^^^^^^ support.type
#                  ^^^^^ keyword.other
#                        ^ support.type
#                          ^^^^^ keyword.other
#                                ^ support.type
#                                  ^ keyword.operator
  function f(x::Array{T,S}) where T end
# ^^^^^^^^ keyword.other
#          ^ entity.name.function
#            ^ variable.parameter
#             ^^ keyword.operator
#               ^^^^^^^^^^ support.type
#                           ^^^^^ keyword.other
#                                 ^ support.type
#                                   ^^^ keyword.other
  function f(x::Array{T,S}) where T where S end
# ^^^^^^^^ keyword.other
#          ^ entity.name.function
#            ^ variable.parameter
#             ^^ keyword.operator
#               ^^^^^^^^^^ support.type
#                           ^^^^^ keyword.other
#                                 ^ support.type
#                                   ^^^^^ keyword.other
#                                         ^ support.type
#                                           ^^^ keyword.other
  function f(x::Array{T,S} where T) end
# ^^^^^^^^ keyword.other
#          ^ entity.name.function
#            ^ variable.parameter
#             ^^ keyword.operator
#               ^^^^^^^^^^ support.type
#                          ^^^^^ keyword.other
#                                ^ support.type
#                                   ^^^ keyword.other
  function f(x::Array{T,S} where T where S) end
# ^^^^^^^^ keyword.other
#          ^ entity.name.function
#            ^ variable.parameter
#             ^^ keyword.operator
#               ^^^^^^^^^^ support.type
#                          ^^^^^ keyword.other
#                                ^ support.type
#                                  ^^^^^ keyword.other
#                                        ^ support.type
#                                           ^^^ keyword.other
  function f(x::typeof(yy) where T where S) end
# ^^^^^^^^ keyword.other
#          ^ entity.name.function
#            ^ variable.parameter
#             ^^ keyword.operator
#               ^^^^^^^^^^ support.type
#                          ^^^^^ keyword.other
#                                ^ support.type
#                                  ^^^^^ keyword.other
#                                        ^ support.type
#                                           ^^^ keyword.other
  function *(x::Bool, y::T)::promote_type(Bool,T) where T<:Unsigned end
# ^^^^^^^^ keyword.other
#          ^ entity.name.function
#            ^ variable.parameter
#             ^^ keyword.operator
#               ^^^^ support.type
#                     ^ variable.parameter
#                      ^^ keyword.operator
#                        ^ support.type
#                          ^^ keyword.operator
#                            ^^^^^^^^^^^^^^^^^^^^ support.type
#                                                 ^^^^^ keyword.other
#                                                       ^ support.type
#                                                        ^^ keyword.operator
#                                                          ^^^^^^^^ support.type
#                                                                   ^^^ keyword.other

# Anonymous functions
  (x::T{S}, yy::T{S}) ->
#  ^ variable.parameter
#   ^^ keyword.operator
#     ^^^^ support.type
#           ^^ variable.parameter
#             ^^ keyword.operator
#               ^^^^ support.type
#                     ^^ keyword.operator
  (x, y) ->
#  ^ variable.parameter
#     ^ variable.parameter
#        ^^ keyword.operator
  (x::T{S}) ->
#  ^ variable.parameter
#   ^^ keyword.operator
#     ^^^^ support.type
#           ^^ keyword.operator
  (x) ->
#  ^ variable.parameter
#     ^^ keyword.operator
  x::T{S} ->
# ^ variable.parameter
#  ^^ keyword.operator
#    ^^^^ support.type
#         ^^ keyword.operator
  x ->
# ^ variable.parameter
#   ^^ keyword.operator
  ((x::Array{T}) where T<:Real{Foo}) -> 2x
#   ^ variable.parameter
#    ^^ keyword.operator
#      ^^^^^^^^ support.type
#                ^^^^^ keyword.other
#                      ^ support.type
#                       ^^ keyword.operator
#                         ^^^^^^^^^ support.type
#                                    ^^ keyword.operator
  ((x::T{S}) -> 2x)
#   ^ variable.parameter



##
## MACROS
##

  macro foo(a) end
# ^^^^^ keyword.other
#       ^^^ entity.name.macro
#           ^ variable.parameter
  @foo a
# ^^^^ variable.macro
#      ^ variable.other

  @macro arg1 arg2
# ^^^^^^ variable.macro
#        ^^^^ variable.other
#             ^^^^ variable.other
  @macro(arg1,arg2)
# ^^^^^^ variable.macro
#        ^^^^ variable.other
#             ^^^^ variable.other
  @macro(arg1,arg2) = ...
# ^^^^^^ variable.macro
#        ^^^^ variable.other
#             ^^^^ variable.other
  function @macro(arg1,arg2) end
# ^^^^^^^^ keyword.other
#          ^^^^^^ variable.macro
#                 ^^^^ variable.other
#                      ^^^^ variable.other


##
## TRANSPOSES
##

# (issue 1, 15)
  a'
# ^ variable.other
#  ^ keyword.operator
  β.''
# ^ variable.other
#  ^ keyword.operator.broadcast
#   ^^ keyword.operator
  f()'
# ^ variable.function
#    ^ keyword.operator
 (1.)'
# ^^ constant.numeric
#    ^ keyword.operator
 [1,2]'
# ^ constant.numeric
#   ^ constant.numeric
#     ^ keyword.operator


##
## INFIX OPERATORS
##

  a=b
#  ^ keyword.operator.assignment
  a >= b
#   ^ keyword.operator.julia
  a <= b
#   ^ keyword.operator.julia
  x -> 2 + x
#   ^ keyword.operator
  a => b
#   ^ keyword.operator.julia
  x .-= 3
#   ^ keyword.operator.broadcast.julia
#    ^ keyword.operator.julia
  a == b
#   ^ keyword.operator.julia
  a != b
#   ^ keyword.operator.julia
  a === b
#   ^ keyword.operator.julia
#    ^ keyword.operator.julia
#     ^ keyword.operator.julia
  a !== b
#   ^ keyword.operator.julia
#    ^ keyword.operator.julia
#     ^ keyword.operator.julia

# (issue 6, 8, 10)
  2.⊗a
# ^^ constant.numeric
#   ^ keyword.operator
#    ^ variable.other
  a⊕β()
# ^ variable.other
#  ^ keyword.operator
#   ^ variable.function
  1.23≤23.
# ^^^^ constant.numeric
#     ^ keyword.operator
#      ^^^ constant.numeric


##
## BROADCAST
##

  f.(x)
# ^ variable.function
#  ^ keyword.operator.broadcast
  Mod.f.(x)
#     ^ variable.function
#      ^ keyword.operator.broadcast
  a.=b
#  ^ keyword.operator.broadcast
#   ^ keyword.operator.assignment
  a.⊕b
#  ^ keyword.operator.broadcast
#   ^ keyword.operator


##
## COMMENTS
##

# (issue 13)
  #fun()
# ^^^^^^ comment.line
# Nested block comments
  #=#==#hej=#
# ^^^^^^^^^^^ comment.block

# (issue 27)
  a#a
# ^ variable.other
#  ^^ comment.line
  a#=a=# a
# ^ variable.other
#  ^^^^^ comment.block
#        ^ variable.other


##
## STRINGS
##

"hello" closed
# <- string.quoted.double
# ^^^^^ string.quoted.double
#         ^ variable.other
'hello' closed
# <- string.quoted.single
# ^^^^^ string.quoted.single
#       ^ variable.other
  "hel\lo\"there"
# ^^^^ string.quoted.double
#     ^^ constant.character.escape
#       ^ string.quoted.double
#        ^^ constant.character.escape
#          ^^^^^^ string.quoted.double
# (issue 5)
  r"\\\\" closed
# ^^^^^^^ string.quoted.other
#         ^ variable.other
  r"raw\str\"ooh\\ok" closed
# ^^^^^^^^^ string.quoted.other
#          ^^ constant.character.escape
#            ^^^ string.quoted.other
#               ^^ constant.character.escape
#                 ^^^ string.quoted.other
#                     ^ variable.other
  whatever"yaah" closed
# ^^^^^^^^^^^^^^ string.quoted.other
#                ^ variable.other
  b"DATA\xffoho\u2200aha" closed
# ^^^^^^ string.quoted.other
#       ^^^^ constant.character.escape
#           ^^^ string.quoted.other
#              ^^^^^^ constant.character.escape
#                    ^^^^ string.quoted.other
#                         ^ variable.other
# (issue 28)
  r"""\n a \" b $""" a
# ^^^^^^^^^ string.quoted.other
#          ^^ constant.character.escape
#            ^^^^^^^ string.quoted.other
#                    ^ variable.other
# (issue 29)
  """a"$b"c"""
# ^^^^^ string.quoted.double
#      ^ keyword.operator
#       ^ variable.other
#        ^^^^^ string.quoted.double


##
## STRING INTERPOLATION
##

a = "f \$no $∇2() bar" closed
#   ^^ string.quoted.double
#      ^^ constant.character.escape
#        ^^^ string.quoted.double
#           ^ keyword.operator
#            ^^ variable.other
#              ^^^^^^^ string.quoted.double
#                      ^ variable.other
a = "foo$(a+f(a, g())+b)foobar" closed
#   ^^^^ string.quoted.double
#       ^ keyword.operator
#         ^ variable.other
#          ^ keyword.operator
#           ^ variable.function
#             ^ variable.other
#                ^ variable.function
#                     ^ variable.other
#                       ^^^^^^^ string.quoted.double
#                               ^ variable.other
a = "foo$(a+f(a, g())+b)(a)bar" closed
#   ^^^^ string.quoted.double
#       ^ keyword.operator
#         ^ variable.other
#          ^ keyword.operator
#           ^ variable.function
#             ^ variable.other
#                ^ variable.function
#                     ^ variable.other
#                       ^^^^^^^ string.quoted.double
#                               ^ variable.other
  a "f(x)=($(f(x)))" a
# ^ variable.other
#   ^^^^^^^ string.quoted.double
#          ^ keyword.operator
#            ^ variable.function
#              ^ variable.other
#                 ^^ string.quoted.double
#                    ^ variable.other
  "a $(f(a))$aa a" a
# ^^^ string.quoted.double
#    ^ keyword.operator
#      ^ variable.function
#           ^ keyword.operator
#            ^^ variable.other
#               ^^ string.quoted.double
#                  ^ variable.other
  f("$(g(a.b))") a
#   ^ string
#    ^ keyword
#      ^ variable.function
#             ^ string
#                ^ variable.other
  a = ? c-'0':b
#       ^ variable.other
#        ^ keyword.operator
#         ^^^ string.quoted.single
#            ^ keyword.operator
#             ^ variable.other

# (issue 25)
  println("sqrt(4) = 2") closed
# ^^^^^^^ variable.function
#         ^^^^^^^^^^^^^ string.quoted
#                        ^^^^^^ variable.other

# (issue 32)
  a `a$a` a
# ^ variable.other
#   ^^ string.quoted.cmd
#     ^ keyword.operator
#      ^ variable.other
#       ^ string.quoted.cmd
#         ^ variable.other
