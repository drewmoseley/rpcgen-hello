all:
	rpcgen msg.x
	CPATH=/usr/include/tirpc gcc rprintmsg.c -o rprintmsg -ltirpc
	CPATH=/usr/include/tirpc/ gcc msg_proc.c msg_svc.c -o msg_server -ltirpc
