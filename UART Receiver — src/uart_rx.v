module uart_rx #(
    parameter CLKS_PER_BIT = 4
)(
    input        clk,
    input        rst,
    input        rx,
    output reg [7:0] rx_data,
    output reg   rx_done
);

    reg [7:0] data_reg;
    reg [3:0] bit_index;
    reg [15:0] clk_count;
    reg receiving;

    always @(posedge clk or posedge rst) begin

        if (rst) begin
            rx_data   <= 8'b0;
            rx_done   <= 1'b0;
            data_reg  <= 8'b0;
            bit_index <= 4'b0;
            clk_count <= 16'b0;
            receiving <= 1'b0;
        end

        else begin

            rx_done <= 1'b0;

            if (!receiving) begin

                if (rx == 1'b0) begin
                    receiving <= 1'b1;
                    clk_count <= 16'd0;
                    bit_index <= 4'd0;
                end

            end

            else begin

                if (clk_count < CLKS_PER_BIT - 1) begin
                    clk_count <= clk_count + 1'b1;
                end

                else begin
                    clk_count <= 16'd0;

                    if (bit_index < 8) begin
                        data_reg[bit_index] <= rx;
                        bit_index <= bit_index + 1'b1;
                    end

                    else begin
                        rx_data   <= data_reg;
                        rx_done   <= 1'b1;
                        receiving <= 1'b0;
                    end
                end
            end
        end
    end

endmodule