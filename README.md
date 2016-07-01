# 7-segment Driver for Digilent Basys2 development board
An easy to use seven segment driver module for the Digilent Basys2 Board, as well as an example demo application to demonstrate usage and functionality. 

Typically when working with 7-segment displays, one must worry about proper multiplexing of the digits. This module handles all of the proper timing internally. Four 5-bit inputs are made available to the user corresponding to each of the four digits on the display. Simply pass in a value to one of the inputs, and the module will display the value.

As of now, this module will display all hexadecimal values only (0x0000 to 0xFFFF).

A bit file is also made available for immediate testing. Button "btn3" is used for reset. Upon programming the FPGA, the 7-segment display will begin counting from 0x0000 to 0xFFFF and will loop back to 0x0000.
