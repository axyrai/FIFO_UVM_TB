class fifo_driver extends uvm_driver#(fifo_seq_item);
  virtual fifo_if vif;
  fifo_seq_item packet;

  `uvm_component_utils(fifo_driver)

  function new(string name = "fifo_driver",uvm_component parent);
    super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual fifo_if)::get(this,"","vif",vif)
      `uvm_error("Driver","No vif found")
  endfunction

  virtual task run_phase(uvm_phase phase);
    vif.d_mp.d_cb.i_wren<='b0;
    vif.d_mp.d_cb.i_rden<='b0;
    vif.d_mp.d_cb.i_wrdata<='b0;
    forever begin
      seq_item_port.get_next_item(packet);
      if(packet.i_rden == 1)
        main_read();
      else if( packet.i_wren == 1)
        main_write(packet.i_wrdata);
      seq_item_port.item_done();
    end
  endtask
  virtual task main_read();
    @(posedge vif.d_mp.clk)
      vif.d_mp.d_cb.i_rden <=1'b1;
    @(posedge vif.d_mp.clk)
      vif.d_mp.d_cb.i_rden <=1'b0;

  endtask

  virtual task main_write(input [127:0] i_wrdata);
    @(posedge vif.d_mp.clk)
    vif.d_mp.d_cb.i_wren <= 1'b1;
    vif.d_mp.d_cb.i_wrdata <= i_wrdata;
    @(posedge vif.d_mp.clk)
    vif.d_mp.d_cb.i_wren <= 1'b0;
  endtask

endclass
