# SYNTAX TEST "Packages/Julia-sublime/Julia.sublime-syntax"


##
## NUMBERS
##

  0b101
# ^^^^^ constant.numeric
  0o7
# ^^^ constant.numeric
  0xa3
# ^^^^ constant.numeric
  e+123
# ^^^^^ constant.numeric
  12e123
# ^^^^^^ constant.numeric
  1.32e+123
# ^^^^^^^^^ constant.numeric
  e-123
# ^^^^^ constant.numeric
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

##
## CONSTANTS
##

  true
# ^^^^ constant.language
  false
# ^^^^^ constant.language
  nothing
# ^^^^^^^ constant.language
  NaN
# ^^^ constant.language
  Inf
# ^^^ constant.language


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
#   ^ keyword.operator
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
  :.//aa
# ^ keyword.operator
#  ^ constant.other.symbol
#   ^^ keyword.operator
#     ^^ variable.other


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
#         ^ keyword.operator
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
#          ^^^^^ variable.other
  mytype = Array{Int}
# ^^^^^^ variable.other
#        ^ keyword.operator
#          ^^^^^^^^^^ variable.other

# (issue 17)
# All things being defined are green, types as well
  type Foo{T<:Real} end
# ^^^^ keyword.other
#      ^^^ entity.name.type
#         ^^^^^^^^^ support.type
  type A <: B end
# ^^^^ keyword.other
#      ^ entity.name.type
#        ^^ keyword.operator
#           ^ support.type
#             ^^^ keyword.other
  type Foo{T}<:Bar{T} end
# ^^^^ keyword.other
#      ^^^ entity.name.type
#         ^^^ support.type
#            ^^ keyword.operator
#              ^^^^^^ support.type
  immutable Foo{T<:Real} end
# ^^^^^^^^^ keyword.other
#           ^^^ entity.name.type
#              ^^^^^^^^^ support.type
  typealias Foo{T} Bar{T}
# ^^^^^^^^^ keyword.other
#           ^^^^^^ entity.name.type
#                  ^^^^^^ support.type
  bitstype 32 Foo{T}<:Bar{T}
# ^^^^^^^^ keyword.other
#          ^^ constant.numeric
#             ^^^^^^ entity.name.type
#                   ^^ keyword.operator
#                     ^^^^^^ support.type


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

# "Mathematical" function declaration (issue 19)
  Module.foo!{T<:Real}(xx::Aa{Bb}, β::Aa{Bb}=1.::Aa{Bb}, c) = kron(a, b)
# ^^^^^^ variable.other
#       ^ keyword.operator
#        ^^^^ entity.name.function
#            ^^^^^^^^^ support.type
#                      ^^ variable.parameter
#                        ^^ keyword.operator
#                          ^^^^^^ support.type
#                                  ^ variable.parameter
#                                   ^^ keyword.operator
#                                     ^^^^^^ support.type
#                                           ^ keyword.operator
#                                            ^^ constant.numeric
#                                              ^^ keyword.operator
#                                                ^^^^^^ support.type
#                                                        ^ variable.parameter
#                                                           ^ keyword.operator

# "Mathematical" infix operator declaration
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

# "Mathematical" infix operator declaration in module
  Module.∘{T<:Real}(xx::Aa{Bb}, β::Aa{Bb}=1.::Aa{Bb}, c) = ...
# ^^^^^^ variable.other
#       ^ keyword.operator
#        ^ entity.name.function
#         ^^^^^^^^^  support.type
#                   ^^ variable.parameter
#                     ^^ keyword.operator
#                       ^^^^^^  support.type
#                               ^ variable.parameter
#                                ^^ keyword.operator
#                                  ^^^^^^  support.type
#                                        ^ keyword.operator
#                                         ^^ constant.numeric
#                                           ^^ keyword.operator
#                                             ^^^^^^ support.type
#                                                     ^ variable.parameter
#                                                        ^ keyword.operator

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


==(r::RRID, s::RRID) = (r.whence==s.whence && r.id==s.id)


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


##
## TRANSPOSES
##

# (issue 1, 15)
  a'
# ^ variable.other
#  ^ keyword.operator
  β.''
# ^ variable.other
#  ^^^ keyword.operator
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
## COMMENTS
##

# (issue 13)
  #fun()
# ^^^^^^ comment.line
# Nested block comments
  #=#==#hej=#
# ^^^^^^^^^^^ comment.block


##
## STIRNGS
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
