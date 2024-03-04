/* msg.x: Remote msg printing protocol */
 program MESSAGEPROG {
     version MESSAGEVERS {
        int PRINTMESSAGE(string) = 1;
 	 } = 1;
} = 99;
