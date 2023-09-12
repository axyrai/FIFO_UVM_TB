import uvm_pkg::*;
class fifo_seq_item extends uvm_sequence_item;

  rand bit i_rden;
  rand bit i_wren;
  rand bit [127:0] i_wrdata;
  bit o_alm_full;
  bit o_alm_empty;
  bit o_full;
  bit o_empty;
  bit [127:0] o_rddata;

  //field macris
  `uvm_object_utils_begin(fifo_seq_item)
  `uvm_field_int(i_rden,UVM_ALL_ON)
  `uvm_field_int(i_wren,UVM_ALL_ON)
  `uvm_field_int(i_wrdata,UVM_ALL_ON)
  `uvm_field_int(o_alm_full,UVM_ALL_ON)
  `uvm_field_int(o_alm_empty,UVM_ALL_ON)
  `uvm_field_int(o_full,UVM_ALL_ON)
  `uvm_field_int(o_empty,UVM_ALL_ON)
  `uvm_field_int(o_rddata,UVM_ALL_ON)
  `uvm_object_utils_end

  //constructor
  function new(string name="fifo_seq_item");
    super.new(name);
  endfunction

  //constraint
   constraint c1 { {i_rden,i_wren} inside {[0:3]};}
  
endclass
