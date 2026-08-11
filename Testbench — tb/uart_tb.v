`timescale 1ns/1ps

module uart_tb;

    reg clk;
    reg rst;
    reg tx_start;
    reg [7:0] tx_data;

    wire tx;
    wire tx_busy;
    wire [7:0] rx_data;
    wire rx_done;

    uart_top #(
        .CLKS_PER_BIT(4)
    ) DUT (
        .clk(clk),
        .rst(rst),
        .tx_start(tx_start),
        .tx_data(tx_data),
        .tx(tx),
        .tx_busy(tx_busy),
        .rx_data(rx_data),
        .rx_done(rx_done)
    );

    // Clock generation: 10 ns period
    always #5 clk = ~clk;

    task send_data(input [7:0] data);
        begin

            @(posedge clk);
            tx_data  <= data;
            tx_start <= 1'b1;

            @(posedge clk);
            tx_start <= 1'b0;

            wait(rx_done);

            #1;

            if (rx_data == data)
                $display("TX Data = %h | RX Data = %h | PASS",
                         data, rx_data);
            else
                $display("TX Data = %h | RX Data = %h | FAIL",
                         data, rx_data);

            #20;
        end
    endtask

    initial begin

        // Generate waveform
        $dumpfile("uart.vcd");
        $dumpvars(0, uart_tb);

        clk      = 1'b0;
        rst      = 1'b1;
        tx_start = 1'b0;
        tx_data  = 8'h00;

        $display("========================================");
        $display("       UART SIMULATION STARTED");
        $display("========================================");

        #20;
        rst = 1'b0;

        send_data(8'h55);
        send_data(8'hA5);
        send_data(8'h3C);

        $display("========================================");
        $display("      UART SIMULATION COMPLETED");
        $display("========================================");

        #50;
        $finish;

    end

endmodule