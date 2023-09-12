`include "uvm_macros.svh"
import uvm_pkg::*;

class fifo_sequence extends uvm_sequence #(fifo_seq_item);
  `uvm_object_utils(fifo_sequence);

  function new(string name="fifo_sequence");
    super.new(name);
  endfunction

  fifo_seq_item packet;


  task body();
   repeat(total_trans)
   begin
     packet=fifo_sequence_item::type_id::create("packet");
     start_item(packet);
     if(!packet.randomize())
       `uvm_error("Sequence","Randomization failure")
     finish_item(packet);
  endtask


endclass
