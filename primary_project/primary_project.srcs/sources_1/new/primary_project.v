`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: PRS Semicon (PRS Group Company)
// Engineer: Aditya Sarma Nuthalapati
// Create Date: 11/09/2025
// Design Name: Frequency divider
// Module Name: primary_project
// Target Devices: Basys 3 Artix-7
//////////////////////////////////////////////////////////////////////////////////


module freq_divider #(parameter integer DIV = 2) (
    input  wire clk,
    input  wire rst,
    output reg  clk_out
);

    localparam integer WIDTH = (DIV <= 1) ? 1 : $clog2(DIV-1) + 1;
    reg [WIDTH-1:0] cnt;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            cnt <= {WIDTH{1'b0}};
            clk_out <= 1'b0;
        end
        else begin
            if (cnt == (DIV - 1))
                cnt <= {WIDTH{1'b0}};
            else
                cnt <= cnt + 1'b1;


            if (cnt < (DIV >> 1))
                clk_out <= 1'b1;
            else
                clk_out <= 1'b0;
        end
    end
endmodule



module segment_7display(
    input  wire clk,   
    input  wire rst,
    input  wire [3:0] value,       
    output reg  [6:0] seg,
    output reg  [3:0] an
);
    reg [19:0] count;
    wire [1:0] digit_select;
    assign digit_select = count[19:18];

    always @(posedge clk or posedge rst) begin
        if (rst) count <= 20'd0;
        else     count <= count + 1'b1;
    end

    reg [3:0] digit_data;

    always @(*) begin
        case (digit_select)
            2'b00 : an = 4'b1110;
            2'b01 : an = 4'b1101;
            2'b10 : an = 4'b1011;
            2'b11 : an = 4'b0111;
            default: an = 4'b1111;
        endcase
    end

 
    always @(*) begin
        digit_data = 4'd15;
        case (value)
            4'd2 : begin
                case(digit_select)
                    2'b00 : digit_data = 4'd2;
                    default: digit_data = 4'd15;
                endcase
            end
            4'd4 : begin
                case(digit_select)
                    2'b00 : digit_data = 4'd4;
                    default: digit_data = 4'd15;
                endcase
            end
            4'd10 : begin 
                case(digit_select)
                    2'b00 : digit_data = 4'd0;
                    2'b01 : digit_data = 4'd1;
                    default: digit_data = 4'd15;
                endcase
            end
            4'd11 : begin
                case(digit_select)
                    2'b00 : digit_data = 4'd0;
                    2'b01 : digit_data = 4'd0;
                    2'b10 : digit_data = 4'd1;
                    default: digit_data = 4'd15;
                endcase
            end
            4'd12 : begin 
                case(digit_select)
                    2'b00 : digit_data = 4'd0;
                    2'b01 : digit_data = 4'd0;
                    2'b10 : digit_data = 4'd0;
                    2'b11 : digit_data = 4'd1;
                    default: digit_data = 4'd15;
                endcase
            end
            default: digit_data = 4'd15;
        endcase
    end

    always @(*) begin
        case (digit_data)
            4'd0 : seg = 7'b1000000;
            4'd1 : seg = 7'b1111001;
            4'd2 : seg = 7'b0100100;
            4'd3 : seg = 7'b0110000;
            4'd4 : seg = 7'b0011001;
            4'd5 : seg = 7'b0010010;
            4'd6 : seg = 7'b0000010;
            4'd7 : seg = 7'b1111000;
            4'd8 : seg = 7'b0000000;
            4'd9 : seg = 7'b0010000;
            default: seg = 7'b1111111; 
        endcase
    end
endmodule


module primary_project (
    input  wire clk,        
    input  wire rst,        
    input  wire [2:0] sw,   
    output reg  [3:0] led,
    output wire [6:0] seg,
    output wire [3:0] an,
    output wire clk_out     
);

    localparam DIV2   = 2;
    localparam DIV4   = 4;
    localparam DIV10  = 10;
    localparam DIV100 = 100;
    localparam DIV1K  = 1000;


    wire clk_div2, clk_div4, clk_div10, clk_div100, clk_div1k;


    freq_divider #(.DIV(DIV2))   u_div2  (.clk(clk), .rst(rst), .clk_out(clk_div2));
    freq_divider #(.DIV(DIV4))   u_div4  (.clk(clk), .rst(rst), .clk_out(clk_div4));
    freq_divider #(.DIV(DIV10))  u_div10 (.clk(clk), .rst(rst), .clk_out(clk_div10));
    freq_divider #(.DIV(DIV100)) u_div100(.clk(clk), .rst(rst), .clk_out(clk_div100));
    freq_divider #(.DIV(DIV1K))  u_div1k (.clk(clk), .rst(rst), .clk_out(clk_div1k));

  
    reg [3:0] display_value;
    reg selected_clk; 

    always @(*) begin
     
        display_value = 4'd2;
        selected_clk = clk_div2;
        case (sw)
            3'b000 : begin selected_clk = clk_div2;   display_value = 4'd2;  end
            3'b001 : begin selected_clk = clk_div4;   display_value = 4'd4;  end
            3'b010 : begin selected_clk = clk_div10;  display_value = 4'd10; end
            3'b011 : begin selected_clk = clk_div100; display_value = 4'd11; end
            3'b100 : begin selected_clk = clk_div1k;  display_value = 4'd12; end
            default: begin selected_clk = clk_div2;   display_value = 4'd2;  end
        endcase
    end

    
    
    reg clk_out_reg;
    always @(posedge clk or posedge rst) begin
        if (rst) clk_out_reg <= 1'b0;
        else clk_out_reg <= selected_clk;
    end
    assign clk_out = clk_out_reg;

    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            led = 4'b0000;
        end else begin
            case (sw)
                3'b000 : led = {3'b000, clk_div2};
                3'b001 : led = {2'b00, clk_div4, clk_div4};
                3'b010 : led = {1'b0, clk_div10, clk_div10, clk_div10};
                3'b011 : led = {clk_div100, clk_div100, clk_div100, clk_div100};
                3'b100 : led = {clk_div1k, clk_div1k, clk_div1k, clk_div1k};
                default: led = 4'b0000;
            endcase
        end
    end

   
    segment_7display segu(.clk(clk), .rst(rst), .value(display_value), .seg(seg), .an(an));

endmodule
