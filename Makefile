CPATH=/usr/include/tirpc
LFLAGS=-ltirpc

all: rprintmsg msg_server

rprintmsg: rprintmsg.c msg.h msg_clnt.c
	CPATH=${CPATH} gcc rprintmsg.c msg_clnt.c -o rprintmsg -ltirpc

msg_server: msg_proc.c msg_svc.c msg.h
	CPATH=${CPATH} gcc msg_proc.c msg_svc.c -o msg_server -ltirpc

msg.h msg_clnt.c msg_svc.c: msg.x
	rpcgen msg.x

clean:
	rm -f msg.h msg_clnt.c msg_svc.c
	rm -f rprintmsg msg_server
