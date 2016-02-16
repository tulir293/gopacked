// goPacked - A simple text-based Minecraft modpack manager.
// Copyright (C) 2016 Tulir Asokan
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
package main

import (
	"bufio"
	"fmt"
	"os"
)

var infoPrefix = []byte("[Info] ")
var warnPrefix = []byte("\x1b[33m[Warning] ")
var errorPrefix = []byte("\x1b[31m[Error] ")
var fatalPrefix = []byte("\x1b[35m[Fatal] ")
var newline = []byte("\x1b[0m\n")

// Inputf prints the given message and then waits for input
func Inputf(message string, args ...interface{}) string {
	os.Stdout.Write([]byte(fmt.Sprintf(message, args...)))
	os.Stdout.Write([]byte(" "))
	bio := bufio.NewReader(os.Stdin)
	line, _ := bio.ReadString('\n')
	return line
}

// Infof formats and prints the given message into stdout
func Infof(message string, args ...interface{}) {
	os.Stdout.Write(infoPrefix)
	os.Stdout.Write([]byte(fmt.Sprintf(message, args...)))
	os.Stdout.Write(newline)
}

// Warnf formats and prints the given message into stdout with a yellow color
func Warnf(message string, args ...interface{}) {
	os.Stdout.Write(warnPrefix)
	os.Stdout.Write([]byte(fmt.Sprintf(message, args...)))
	os.Stdout.Write(newline)
}

// Errorf formats and prints the given message into stderr with a red color
func Errorf(message string, args ...interface{}) {
	os.Stdout.Write(errorPrefix)
	os.Stdout.Write([]byte(fmt.Sprintf(message, args...)))
	os.Stdout.Write(newline)
}

// Fatalf formats and prints the given message into stderr with a purple color
func Fatalf(message string, args ...interface{}) {
	os.Stdout.Write(fatalPrefix)
	os.Stdout.Write([]byte(fmt.Sprintf(message, args...)))
	os.Stdout.Write(newline)
}
