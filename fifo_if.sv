interface fifo_if(input clk,rstn);
bit i_rden;
bit i_wren;
bit [127:0] i_wrdata;
bit o_full;
bit o_alm_full;
bit o_empty;
bit o_alm_empty;
bit [127:0] o_rddata;

clocking d_cb @(posedge clk);
  default input #0 output #0;
  output i_rden;
  output i_wren;
  output i_wrdata;
  input o_full;
  input o_alm_full;
  input o_alm_empty;
  input o_empty;
  input o_rddata;
endclocking

clocking m_cb @(posedge clk);
  default input #0 output #0;
  input i_rden;
  input i_wren;
  input i_wrdata;
  input o_full;
  input o_alm_full;
  input o_empty;
  input o_alm_empty;
  input o_rddata;
endclocking

endinterface