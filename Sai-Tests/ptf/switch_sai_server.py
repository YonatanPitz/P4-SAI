import sys
sys.path.append('example/mytests/switch_sai/switch_sai')
sys.path.append('../../')
sys.path.append('../../../../tools/')
from cli_driver import SwitchThriftClient
import switch_sai_rpc
from ttypes import *

from thrift.transport import TSocket
from thrift.transport import TTransport
from thrift.protocol import TBinaryProtocol
from thrift.server import TServer

import socket

class SaiHandler:
  def __init__(self):
    self.log = {}
    print "connecting to cli thrift"
    self.cli_client = SwitchThriftClient(json='../../sai.json')

  def sai_thrift_create_vlan(self, vid):
    print "vlan id %d" % vid
    self.cli_client.AddTable('table_ingress_lag', 'action_set_lag_l2if', '0', '0 0 0')
    return 0

  def sai_thrift_create_fdb_entry(self, thrift_fdb_entry, thrift_attr_list):
  	return 0

  def sai_thrift_delete_fdb_entry(self, thrift_fdb_entry):
  	return 0

  def sai_thrift_delete_vlan(self, vlan_id):
  	return 0


handler = SaiHandler()
processor = switch_sai_rpc.Processor(handler)
transport = TSocket.TServerSocket(port=9092)
tfactory = TTransport.TBufferedTransportFactory()
pfactory = TBinaryProtocol.TBinaryProtocolFactory()

server = TServer.TSimpleServer(processor, transport, tfactory, pfactory)

print "Starting python server..."
server.serve()
print "done!"