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

  foo.bar
# ^^^ meta.generic-name
#    ^ punctuation.accessor.dot
#     ^^^ meta.generic-name

  foo.bar = 1
# ^^^ meta.qualified-name.julia meta.generic-name.julia
#    ^ punctuation.accessor.dot.julia
#     ^^^ meta.qualified-name.julia meta.generic-name.julia
#         ^ keyword.operator.assignment.julia

  foo.bar()
# ^^^ meta.generic-name
#    ^ punctuation.accessor.dot
#     ^^^ meta.function-call

  bar()
# ^^^ meta.function-call.julia variable.function.julia
#    ^^ meta.function-call.arguments.julia punctuation.section.arguments

  (bar())
# ^^^^^^^ meta.group.julia
#  ^^^ meta.function-call.julia variable.function.julia
#     ^^ meta.function-call.arguments.julia punctuation.section.arguments

  (bar)()
#  ^^^ meta.qualified-name.julia meta.generic-name.julia
#      ^^ meta.function-call.arguments.julia punctuation.section.arguments

  bar() = 1

  foo.bar() = 1
