`timescale 1ns / 1ps

module tb_fft_16pt;
    reg clk;
    reg rst;
    reg start;
    reg [15:0] x_real [0:15]; 
    reg [15:0] x_imag [0:15]; 
    wire [15:0] y_real [0:15]; 
    wire [15:0] y_imag [0:15];
    wire done;

    fft_16pt uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .x_real(x_real),
        .x_imag(x_imag),
        .y_real(y_real),
        .y_imag(y_imag),
        .done(done)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    initial begin
       
        $dumpfile("fft_output.vcd");
        $dumpvars(0, tb_fft_16pt);

        rst = 1;
        start = 0;
        #10 rst = 0;

        x_real[0] = 16'd1;  x_imag[0] = 16'd0;
        x_real[1] = 16'd0;  x_imag[1] = 16'd0;
        x_real[2] = 16'd0;  x_imag[2] = 16'd0;
        x_real[3] = 16'd0;  x_imag[3] = 16'd0;
        x_real[4] = 16'd0;  x_imag[4] = 16'd0;
        x_real[5] = 16'd0;  x_imag[5] = 16'd0;
        x_real[6] = 16'd0;  x_imag[6] = 16'd0;
        x_real[7] = 16'd0;  x_imag[7] = 16'd0;
        x_real[8] = 16'd0;  x_imag[8] = 16'd0;
        x_real[9] = 16'd0;  x_imag[9] = 16'd0;
        x_real[10] = 16'd0; x_imag[10] = 16'd0;
        x_real[11] = 16'd0; x_imag[11] = 16'd0;
        x_real[12] = 16'd0; x_imag[12] = 16'd0;
        x_real[13] = 16'd0; x_imag[13] = 16'd0;
        x_real[14] = 16'd0; x_imag[14] = 16'd0;
        x_real[15] = 16'd0; x_imag[15] = 16'd0;


        start = 1;
        #10 start = 0;

        wait(done);
        #10;

        $display("FFT Output:");
        for (integer i = 0; i < 16; i = i + 1) begin
            $display("Y[%0d] = %d + %di", i, y_real[i], y_imag[i]);
        end

        $finish;
    end
endmodule
