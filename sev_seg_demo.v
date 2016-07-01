/******************************************************************************************
*   sev_seg_demo.v - A demo implementation to demonstrate usage of the sev_segdriver module	
*******************************************************************************************
* Author: David Hong
*
* 7-seg display starts at 0000 and counts to FFFF, and wraps back around to 0000.
* Reset button resets the display back to 0000.
*
* Future Plans:
*	Implement more demo features, like scrolling text, utilizing DCM's for more accurate
*   clocks (to implement applications like a clock or stopwatch)
*
* Do whatever you want with this!
******************************************************************************************/

`timescale 1ns/1ps

module sev_seg_demo(
	input clk_50MHz,
	input rst,

	output [6:0] seg,
	output       dp,
	output [3:0] anode
	);

	/*
		TEMPORARY
		- Using a counter to generate a slower clock, which
		  is not good FPGA design practice but will work in this
		  case since it's a low-speed design.
		- Use DCM's for clock manipulation needs (good practice)

		using 'counter[16]' divides the 50_MHz clock by 131,072 (2^17)
		resulting in... 
			frequency = 381.469_Hz
			period    = 2.621_ms
		each refresh period takes 4 clock cycles, so the refresh period is
			refresh_period = 10.485_ms
		which falls in-between a required refresh period of 1_ms ~ 16_ms
	*/
	reg [21:0] counter = 22'd0;
	always @(posedge clk_50MHz or posedge rst) begin
		if(rst) begin
			counter <= 0;
		end
		else begin
			counter <= counter + 1'b1;
		end
	end

	wire [4:0] data_digit0;	
	wire [4:0] data_digit1;
	wire [4:0] data_digit2;
	wire [4:0] data_digit3;	

	sev_segdriver dut(
		.clk         (counter[16]),
		.rst         (rst),

		.seg         (seg),
		.dp          (dp),
		.anode       (anode),

		.data_digit0 (data_digit0),
		.data_digit1 (data_digit1),
		.data_digit2 (data_digit2),
		.data_digit3 (data_digit3)
		);

	/*
		Stimulant
		Logic to drive digits
	*/

	//turn off decimal always
	assign data_digit0[4] = 1'b1; 
	assign data_digit1[4] = 1'b1; 
	assign data_digit2[4] = 1'b1; 
	assign data_digit3[4] = 1'b1;

	reg [15:0] counter_for_display = 16'd0;
	always @(posedge counter[20] or posedge rst) begin
		if(rst) begin
			counter_for_display = 16'd0;
		end
		else begin
			counter_for_display = counter_for_display + 1'b1;
		end
	end

	assign data_digit0[3:0] = counter_for_display[3:0];
	assign data_digit1[3:0] = counter_for_display[7:4];
	assign data_digit2[3:0] = counter_for_display[11:8];
	assign data_digit3[3:0] = counter_for_display[15:12];



endmodule