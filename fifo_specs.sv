module my_fifo #(
                   parameter DATA_W           = 128     ,        // Data width
                   parameter DEPTH            = 1024      ,        // Depth of FIFO                   
                   parameter UPP_TH           = 4      ,        // Upper threshold to generate Almost-full
                   parameter LOW_TH           = 2               // Lower threshold to generate Almost-empty
                )

 

                (
                   input                   clk         ,        // Clock
                   input                   rstn        ,        // Active-low Synchronous Reset
                   
                   input                   i_wren      ,        // Write Enable
                   input  [DATA_W - 1 : 0] i_wrdata    ,        // Write-data
                   output                  o_alm_full  ,        // Almost-full signal
                   output                  o_full      ,        // Full signal

 

                   input                   i_rden      ,        // Read Enable
                   output [DATA_W - 1 : 0] o_rddata    ,        // Read-data
                   output                  o_alm_empty ,        // Almost-empty signal
                   output                  o_empty              // Empty signal
                );
