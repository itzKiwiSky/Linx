# Linx

Linx is a simple programming language that allow you create drawings on a canvas.
The language is pretty minimal, without flow controls or statements, the only thing you can use is variables.

You can declare a variable using the `defvar` command

Usage : `defvar <type> <name> <value> ...`

```linx
;; this program defines a var and set the foreground color to the values of the var
defvar color testColor 255 255 255 255
setfg $testColor
```
