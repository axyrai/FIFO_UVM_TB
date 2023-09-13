class fifo_monitor extends uvm_monitor;
  virtual fifo_if vif;
  fifo_seq_item packet;
  uvm_analysis_port#(fifo_seq_item) packet_port;
  `uvm_component_utils(fifo_monitor)

  function new(string name = "fifo_monitor",uvm_component parent);
    super.new(name,parent);
    packet_port = new("packet_port",this);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    packet=fifo_seq_item::type_id::create("packet");
    if(!uvm_config_db#(virtual fifo_if)::get(this,"","vif",vif))
      `uvm_fatal("Monitor: ","No vif found")
  endfunction

  virtual task run_phase(uvm_phase phase);
    forever begin
      @(posedge vif.m_mp.clk)
      if(vif.m_mp.m_cb.i_wren==1)
        begin
		packet.i_wrdata = vif.m_mp.m_cb.i_wrdata;
        packet.i_wren = 'b1;
        packet.i_rden = 'b0;
        packet.o_full = vif.m_mp.m_cb.o_full;
        packet.o_empty=vif.m_mp.m_cb.o_empty;
        packet.o_alm_full=vif.m_mp.m_cb.o_alm_empty;
        packet.o_alm_empty=vif.m_mp.m_cb.o_alm_empty; 
        packet_port.write(packet);
        end
      else if(vif.m_mp.m_cb.i_rden == 1)
        begin
        packet.o_rddata = vif.m_mp.m_cb.o_rddata;
        packet.i_wren = 'b0;
        packet.i_rden = 'b1;
        packet.o_full = vif.m_mp.m_cb.o_full;
        packet.o_empty=vif.m_mp.m_cb.o_empty;
        packet.o_alm_full=vif.m_mp.m_cb.o_alm_empty;
        packet.o_alm_empty=vif.m_mp.m_cb.o_alm_empty; 
        packet_port.write(packet);
        end
      endtask
    endclass


