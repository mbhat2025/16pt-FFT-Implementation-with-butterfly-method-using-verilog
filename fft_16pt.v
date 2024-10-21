module fft_16pt (
    input clk,
    input rst,
    input start,
    input [15:0] x_real [0:15],
    input [15:0] x_imag [0:15], 
    output reg [15:0] y_real [0:15], 
    output reg [15:0] y_imag [0:15], 
    output reg done 
);
    
    reg [15:0] stage_real [0:15];
    reg [15:0] stage_imag [0:15];
    
    reg [3:0] stage_count;
    reg [3:0] i, j, k, n;
    reg [15:0] w_real, w_imag; 
    reg [15:0] temp_real, temp_imag;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            done <= 0;
            stage_count <= 0;
        end else if (start) begin
            
            for (i = 0; i < 16; i = i + 1) begin
                stage_real[i] <= x_real[i];
                stage_imag[i] <= x_imag[i];
            end
            stage_count <= 0;
        end else if (stage_count < 4) begin
            
            for (k = 0; k < (16 >> (stage_count + 1)); k = k + 1) begin
                for (j = 0; j < (1 << stage_count); j = j + 1) begin
                  
                    w_real = $cos(2 * 3.14159 * k / (1 << (stage_count + 1)));
                    w_imag = $sin(2 * 3.14159 * k / (1 << (stage_count + 1)));
                    

                    temp_real = (stage_real[j + (k << (stage_count + 1))] * w_real) - (stage_imag[j + (k << (stage_count + 1))] * w_imag);
                    temp_imag = (stage_real[j + (k << (stage_count + 1))] * w_imag) + (stage_imag[j + (k << (stage_count + 1))] * w_real);

                    stage_real[j + (k << (stage_count + 1))] <= stage_real[j] + temp_real;
                    stage_imag[j + (k << (stage_count + 1))] <= stage_imag[j] + temp_imag;

                    stage_real[j] <= stage_real[j] - temp_real;
                    stage_imag[j] <= stage_imag[j] - temp_imag;
                end
            end
            
            stage_count <= stage_count + 1;
        end else begin
            
            for (i = 0; i < 16; i = i + 1) begin
                y_real[i] <= stage_real[i];
                y_imag[i] <= stage_imag[i];
            end
            done <= 1; 
        end
    end
endmodule
