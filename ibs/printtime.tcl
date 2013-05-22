#!/usr/bin/tclsh
set sec [lindex $argv 0]
set d [clock format $sec -format "%b %Y\t %d/%m/%Y"]
puts $d



