# 7-segment Driver for Digilent Basys2 development board
An easy to use seven segment driver module for the Digilent Basys2 Board, as well as an example demo application to demonstrate usage and functionality. 

Typically when working with 7-segment displays, one must worry about proper multiplexing of the digits. This module handles all of the proper timing internally. Four 5-bit inputs are made available to the user corresponding to each of the four digits on the display. Simply pass in a value to one of the inputs, and the module will display the value.
