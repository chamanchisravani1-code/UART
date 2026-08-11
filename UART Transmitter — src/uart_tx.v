module uart_tx #(
    parameter CLKS_PER_BIT = 4
)(
    input        clk,
    input        rst,
    input        tx_start,
    input  [7:0] tx_data,
    output reg   tx,
    output reg   tx_busy
);

    reg [7:0] data_reg;
    reg [3:0] bit_index;
    reg [15:0] clk_count;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            tx        <= 1'b1;
            tx_busy   <= 1'b0;
            data_reg  <= 8'b0;
            bit_index <= 4'b0;
            clk_count <= 16'b0;
        end

        else begin

            if (tx_start && !tx_busy) begin
                tx        <= 1'b0;
                tx_busy   <= 1'b1;
                data_reg  <= tx_data;
                bit_index <= 4'd0;
                clk_count <= 16'd0;
            end

            else if (tx_busy) begin

                if (clk_count < CLKS_PER_BIT - 1) begin
                    clk_count <= clk_count + 1'b1;
                end

                else begin
                    clk_count <= 16'd0;

                    if (bit_index < 8) begin
                        tx <= data_reg[bit_index];
                        bit_index <= bit_index + 1'b1;
                    end

                    else begin
                        tx      <= 1'b1;
                        tx_busy <= 1'b0;
                    end
                end
            end
        end
    end

endmodule