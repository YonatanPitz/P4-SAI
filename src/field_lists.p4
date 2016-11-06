field_list mac_learn_digest {
    ethernet.srcAddr;
    ingress_metadata.bridge_id; // TODO 
    standard_metadata.ingress_port; // TODO
}

field_list_calculation ipv4_checksum {
    input {
        ipv4_checksum_list;
    }
    algorithm : csum16;
    output_width : 16;
}

field_list ipv4_checksum_list {
        ipv4.version;
        ipv4.ihl;
        ipv4.diffserv;
        ipv4.ipv4_length;
        ipv4.id;
        ipv4.flags;
        ipv4.offset;
        ipv4.ttl;
        ipv4.protocol;
        ipv4.srcAddr;
        ipv4.dstAddr;
}