// This is P4 sample source for sai
// Fill in these files with your P4 code


// includes
#include "headers.p4"
#include "parser.p4"
#include "tables.p4"
#include "actions.p4"
#include "defines.p4"
#include "field_lists.p4"

// headers
header 		ethernet_t 			ethernet;
header 		vlan_t 				vlan;
header 		ipv4_t 				ipv4;
header 		tcp_t 				tcp;
header 		udp_t				udp;

// metadata
metadata 	ingress_metadata_t 	 ingress_metadata;
metadata 	egress_metadata_t 	 egress_metadata;

control ingress {
	// phy
	control_port();
	
	// bridging
	if(ingress_metadata.l2_if_type == L2_1D_BRIDGE)	control_1d_bridge_flow();
	if(ingress_metadata.l2_if_type == L2_1Q_BRIDGE) control_1q_bridge_flow();
	// bridge fdb
	if((ingress_metadata.l2_if_type == L2_1Q_BRIDGE) or (ingress_metadata.l2_if_type == L2_1D_BRIDGE) ) control_fdb();
	
	// router
	if(ingress_metadata.l2_if_type == L2_ROUTER_TYPE) control_router_flow();
}

control control_port{
	apply(table_ingress_lag);
	apply(table_accepted_frame_type);
	//apply(table_ingress_acl); // TODO
	apply(table_ingress_l2_interface_type);
}

control control_1d_bridge_flow{
	apply(table_vbridge);
	apply(table_vbridge_STP);

}

control control_1q_bridge_flow{
 	apply(table_ingress_vlan_filtering);
 	apply(table_xSTP_instance);
 	apply(table_xSTP);
}

control control_router_flow{
	// TODO
}

control control_fdb{
	apply(table_learn_fdb);
		apply(table_l3_interface){
			action_go_to_in_l3_if_table{
				apply(table_l3_if);
			}
			action_go_to_fdb_table{
				if((ethernet.srcAddr>>48) != UNICAST){ //TODO unicast - mac msb is off lsb of 1st byte should be 0.
					apply(table_fdb){
						miss { // if packet not in fdb
							apply(table_unknown_unicast);
						}
					}	
				}
			}
		}
		apply(table_egrass_vbridge_STP);
		apply(table_egrass_vbridge);
		//if((egress_metadata.stp_state == STP_FORWORDING) and (egress_metadata.tag_mode == TAG) ){
			// TODO: go to egress
		//}
}

control egress{
	if(egress_metadata.out_if == OUT_IF_IS_LAG){ // TODO when out_if is set?
		apply(table_egress_lag);
	}
//    apply(egress_acl); // TODO
}

