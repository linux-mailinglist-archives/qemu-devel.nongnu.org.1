Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C25E17BB3E6
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 11:08:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qogno-0008Mh-8N; Fri, 06 Oct 2023 05:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qognN-0008AQ-4d
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:06:54 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qognI-0000yv-Js
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:06:52 -0400
Received: (qmail 19721 invoked by uid 484); 6 Oct 2023 09:06:35 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.152078 secs); 06 Oct 2023 09:06:35 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP for <qemu-devel@nongnu.org>; 6 Oct 2023 09:06:33 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Christian.Boenig@lauterbach.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicolas Eder <nicolas.eder@lauterbach.com>
Subject: [PATCH v2 15/29] adapting to the qemu coding style
Date: Fri,  6 Oct 2023 11:05:56 +0200
Message-Id: <20231006090610.26171-16-nicolas.eder@lauterbach.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006090610.26171-1-nicolas.eder@lauterbach.com>
References: <20231006090610.26171-1-nicolas.eder@lauterbach.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Qmail-Scanner-2.11: added fake Content-Type header
Content-Type: text/plain
Received-SPF: pass client-ip=62.154.241.196;
 envelope-from=nicolas.eder@lauterbach.com; helo=smtp1.lauterbach.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: neder <nicolas.eder@lauterbach.com>

---
 gdbstub/gdbstub.c                  |    2 +-
 include/exec/mcdstub.h             |    3 +-
 include/mcdstub/syscalls.h         |    2 +-
 mcdstub/mcd_shared_defines.h       |   17 +-
 mcdstub/mcd_softmmu.c              |  171 -----
 mcdstub/mcd_syscalls.c             |    7 +-
 mcdstub/mcd_tcp_server.c           |   95 ---
 mcdstub/mcdstub.c                  | 1037 ++++++++++++++++------------
 mcdstub/{internals.h => mcdstub.h} |  102 +--
 mcdstub/meson.build                |   16 +-
 softmmu/cpus.c                     |    2 +-
 softmmu/vl.c                       |    4 +-
 target/arm/mcdstub.c               |   24 +-
 13 files changed, 684 insertions(+), 798 deletions(-)
 delete mode 100644 mcdstub/mcd_softmmu.c
 delete mode 100644 mcdstub/mcd_tcp_server.c
 rename mcdstub/{internals.h => mcdstub.h} (69%)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 2ff50757bb..349d348c7b 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -857,7 +857,7 @@ static int process_string_cmd(const char *data,
 
         if (cmd->schema) {
             if (cmd_parse_params(&data[strlen(cmd->cmd)],
-                                 cmd->schema, params)) { 
+                                 cmd->schema, params)) {
                 return -1;
             }
         }
diff --git a/include/exec/mcdstub.h b/include/exec/mcdstub.h
index 132f32417c..84f7c811cb 100644
--- a/include/exec/mcdstub.h
+++ b/include/exec/mcdstub.h
@@ -2,9 +2,8 @@
 #define MCDSTUB_H
 
 #define DEFAULT_MCDSTUB_PORT "1235"
-#define TYPE_CHARDEV_MCD "chardev-mcd"
 
-// breakpoint defines
+/* breakpoint defines */
 #define MCD_BREAKPOINT_SW        0
 #define MCD_BREAKPOINT_HW        1
 #define MCD_WATCHPOINT_WRITE     2
diff --git a/include/mcdstub/syscalls.h b/include/mcdstub/syscalls.h
index 92ae7f4e77..5547d6d29e 100644
--- a/include/mcdstub/syscalls.h
+++ b/include/mcdstub/syscalls.h
@@ -3,4 +3,4 @@
 
 typedef void (*gdb_syscall_complete_cb)(CPUState *cpu, uint64_t ret, int err);
 
-#endif /* _SYSCALLS_H_ */
\ No newline at end of file
+#endif /* _SYSCALLS_H_ */
diff --git a/mcdstub/mcd_shared_defines.h b/mcdstub/mcd_shared_defines.h
index 311d24e12f..891f6477e7 100644
--- a/mcdstub/mcd_shared_defines.h
+++ b/mcdstub/mcd_shared_defines.h
@@ -1,9 +1,12 @@
-// this file is shared between the mcd dll and the mcd stub. it has to be kept exectly the same!
+/*
+ *this file is shared between the mcd dll and the mcd stub.
+ *it has to be kept exectly the same!
+ */
 
 #ifndef MCD_SHARED_DEFINES
 #define MCD_SHARED_DEFINES
 
-// tcp data characters
+/* tcp data characters */
 #define TCP_CHAR_OPEN_SERVER 'I'
 #define TCP_CHAR_OPEN_CORE 'i'
 #define TCP_CHAR_GO 'C'
@@ -19,7 +22,7 @@
 #define TCP_CHAR_READ_MEMORY 'm'
 #define TCP_CHAR_WRITE_MEMORY 'M'
 
-// tcp protocol chars
+/* tcp protocol chars */
 #define TCP_ACKNOWLEDGED '+'
 #define TCP_NOT_ACKNOWLEDGED '-'
 #define TCP_COMMAND_START '$'
@@ -30,7 +33,7 @@
 #define TCP_EXECUTION_SUCCESS "success"
 #define TCP_EXECUTION_ERROR "error"
 
-// tcp query arguments
+/* tcp query arguments */
 #define QUERY_FIRST "f"
 #define QUERY_CONSEQUTIVE "c"
 
@@ -43,7 +46,7 @@
 #define QUERY_ARG_REG "reg"
 #define QUERY_ARG_STATE "state"
 
-// tcp query packet argument list
+/* tcp query packet argument list */
 #define TCP_ARGUMENT_NAME "name"
 #define TCP_ARGUMENT_DATA "data"
 #define TCP_ARGUMENT_ID "id"
@@ -70,10 +73,10 @@
 #define TCP_ARGUMENT_OPTION "option"
 #define TCP_ARGUMENT_ACTION "action"
 
-// for packets sent to qemu
+/* for packets sent to qemu */
 #define ARGUMENT_SEPARATOR ';'
 
-// core states
+/* core states */
 #define CORE_STATE_RUNNING "running"
 #define CORE_STATE_HALTED "halted"
 #define CORE_STATE_DEBUG "debug"
diff --git a/mcdstub/mcd_softmmu.c b/mcdstub/mcd_softmmu.c
deleted file mode 100644
index 52dcb182b2..0000000000
--- a/mcdstub/mcd_softmmu.c
+++ /dev/null
@@ -1,171 +0,0 @@
-/*
-#if defined(WIN32)
-#ifndef _WIN32_WINNT
-#define _WIN32_WINNT 0x0600
-#endif
-#include <winsock2.h>
-#include <ws2tcpip.h>
-//#pragma comment(lib, "Ws2_32.lib")
-#define ISVALIDSOCKET(s) ((s) != INVALID_SOCKET)
-#define CLOSESOCKET(s) closesocket(s)
-#define GETSOCKETERRNO() (WSAGetLastError())
-#else
-#include <sys/types.h>
-#include <sys/socket.h>
-#include <netinet/in.h>
-#include <arpa/inet.h>
-#include <netdb.h>
-#include <unistd.h>
-//#include <errno.h>
-#define SOCKET int
-#define ISVALIDSOCKET(s) ((s) >= 0)
-#define CLOSESOCKET(s) close(s)
-#define GETSOCKETERRNO() (errno)
-#endif
-
-#define SA struct sockaddr
-
-
-
-#include "exec/mcdstub.h"
-#include "qemu/osdep.h"
-#include "qapi/error.h"
-#include "qemu/error-report.h"
-#include "qemu/cutils.h"
-#include "gdbstub/syscalls.h"
-#include "exec/hwaddr.h"
-#include "exec/tb-flush.h"
-#include "sysemu/cpus.h"
-#include "sysemu/runstate.h"
-#include "sysemu/replay.h"
-#include "hw/core/cpu.h"
-#include "hw/cpu/cluster.h"
-#include "hw/boards.h"
-#include "chardev/char.h"
-#include "chardev/char-fe.h"
-#include "monitor/monitor.h"
-#include "internals.h"
-
-//here only deprecated code:
-
-int old_mcdserver_start(const char *device)
-{
-    //the device is a char array. if its "default" we use tcp with the default DEFAULT_MCDSTUB_PORT. Otherwise it has to look like "tcp::<tcpport>"
-    char tcp_port[MX_INPUT_LENGTH];
-    int error;
-    error = mcd_extract_tcp_port_num(device, tcp_port);
-    if (error != 0) {
-        return -1;
-    }
-    int tcp_port_num = atoi(tcp_port);
-        
-    if (!mcdserver_state.init) {
-        mcd_init_mcdserver_state();
-    }
-    return mcd_open_tcp_socket(tcp_port_num);
-}
-
-int mcd_open_tcp_socket(int tcp_port)
-//soon to be deprecated (hopefully)
-{
-    SOCKET socked_fd, connect_fd;
-	struct sockaddr_in server_address, client_address;
-
-#if defined(WIN32)
-	WSADATA d;
-	if (WSAStartup(MAKEWORD(2, 2), &d)) {
-    	return -1;
-	}
-	int len;
-#else
-	unsigned int len;
-#endif
-
-	// socket create and verification
-	socked_fd = socket(AF_INET, SOCK_STREAM, 0);
-	if (!ISVALIDSOCKET(socked_fd)) {
-		return -1;
-	}
-	memset(&server_address, 0, sizeof(server_address));
-
-	// assign IP, PORT
-	server_address.sin_family = AF_INET;
-	server_address.sin_port = htons(tcp_port);
-	server_address.sin_addr.s_addr = htonl(INADDR_ANY);
-
-	// Binding newly created socket to given IP and verification
-	if ((bind(socked_fd, (SA*)&server_address, sizeof(server_address))) != 0) {
-		CLOSESOCKET(socked_fd);
-		return -1;
-	}
-
-	// Now server is ready to listen and verification
-	if ((listen(socked_fd, 5)) != 0) {
-		CLOSESOCKET(socked_fd);
-		return -1;
-	}
-	else {
-		printf("TCP server listening on port %d\n", tcp_port);
-	}
-
-	//accepting connection
-	len = sizeof(client_address);
-	connect_fd = accept(socked_fd, (SA*)&client_address, &len);
-    if (!ISVALIDSOCKET(connect_fd)) {
-		CLOSESOCKET(socked_fd);
-        return -1;
-    }
-
-	//lets do the handshake
-
-	char buff[MCD_TCP_DATALEN];
-	char expected_buff[MCD_TCP_DATALEN];
-
-	memset(buff, 0, sizeof(buff));
-	memset(expected_buff, 0, sizeof(buff));
-	strcpy((char*)expected_buff, "initializing handshake");
-
-    // read the message from client
-    recv(connect_fd, buff, MCD_TCP_DATALEN, 0);
-	
-	if (strcmp(buff, expected_buff)==0) {
-		strcpy((char*)buff, "shaking your hand");
-		send(connect_fd, buff, MCD_TCP_DATALEN, 0);
-		printf("handshake complete\n");
-		return 0;
-	}
-	else {
-		CLOSESOCKET(socked_fd);
-		CLOSESOCKET(connect_fd);
-		return -1;
-	}
-}
-
-int mcd_extract_tcp_port_num(const char *in_string, char *out_string)
-{
-    int string_length = strlen(in_string);
-    if (string_length>MX_INPUT_LENGTH+1) {
-        return -1;
-    }
-
-    const char default_str[] = "default";
-
-    if ((string_length==strlen(default_str)) && (strcmp(default_str, in_string)==0)) {
-        strcpy((char*)out_string, DEFAULT_MCDSTUB_PORT);
-        return 0;
-    }
-    else if (strcmp("tcp::", in_string)==0) {
-            for (int index = 5; index < string_length; index++) {
-                if (!isdigit(in_string[index])) {
-                    return -1;
-                }
-            }
-    }
-    else {
-        return -1;
-    }
-    strcpy((char*)out_string, in_string+5);
-    return 0;
-}
-
-*/
\ No newline at end of file
diff --git a/mcdstub/mcd_syscalls.c b/mcdstub/mcd_syscalls.c
index dec0af51b7..eaa6853335 100644
--- a/mcdstub/mcd_syscalls.c
+++ b/mcdstub/mcd_syscalls.c
@@ -3,12 +3,11 @@
 #include "semihosting/semihost.h"
 #include "sysemu/runstate.h"
 #include "mcdstub/syscalls.h"
-//#include "trace.h"
-#include "internals.h"
+#include "mcdstub.h"
 
 typedef struct {
     char syscall_buf[256];
-    //TODO: this needs to be get fixed mcd_syscall_complete_cb
+    /* TODO: this needs to be get fixed mcd_syscall_complete_cb */
     int current_syscall_cb;
 } MCDSyscallState;
 
@@ -28,4 +27,4 @@ void mcd_syscall_reset(void)
 void mcd_disable_syscalls(void)
 {
     mcd_syscall_mode = MCD_SYS_DISABLED;
-}
\ No newline at end of file
+}
diff --git a/mcdstub/mcd_tcp_server.c b/mcdstub/mcd_tcp_server.c
deleted file mode 100644
index 558ddcb969..0000000000
--- a/mcdstub/mcd_tcp_server.c
+++ /dev/null
@@ -1,95 +0,0 @@
-#include <stdio.h>
-#include <netdb.h>
-#include <netinet/in.h>
-#include <stdlib.h>
-#include <string.h>
-#include <sys/socket.h>
-#include <sys/types.h>
-#include <unistd.h> // read(), write(), close()
-#include "exec/mcdstub.h"
-#define MAX 80
-#define SA struct sockaddr
-
-// Function designed for chat between client and server.
-void func(int connfd)
-{
-	char buff[MAX];
-	int n;
-	// infinite loop for chat
-	for (;;) {
-		bzero(buff, MAX);
-
-		// read the message from client and copy it in buffer
-		read(connfd, buff, sizeof(buff));
-		// print buffer which contains the client contents
-		printf("From client: %s\t To client : ", buff);
-		bzero(buff, MAX);
-		n = 0;
-		// copy server message in the buffer
-		while ((buff[n++] = getchar()) != '\n')
-			;
-
-		// and send that buffer to client
-		write(connfd, buff, sizeof(buff));
-
-		// if msg contains "Exit" then server exit and chat ended.
-		if (strncmp("exit", buff, 4) == 0) {
-			printf("Server Exit...\n");
-			break;
-		}
-	}
-}
-
-// Driver function
-int main()
-{
-	int sockfd, connfd, len;
-	struct sockaddr_in servaddr, cli;
-
-	// socket create and verification
-	sockfd = socket(AF_INET, SOCK_STREAM, 0);
-	if (sockfd == -1) {
-		printf("socket creation failed...\n");
-		exit(0);
-	}
-	else
-		printf("Socket successfully created..\n");
-	bzero(&servaddr, sizeof(servaddr));
-
-	// assign IP, PORT
-	servaddr.sin_family = AF_INET;
-	servaddr.sin_addr.s_addr = htonl(INADDR_ANY);
-	servaddr.sin_port = htons(DEFAULT_MCDSTUB_PORT);
-
-	// Binding newly created socket to given IP and verification
-	if ((bind(sockfd, (SA*)&servaddr, sizeof(servaddr))) != 0) {
-		printf("socket bind failed...\n");
-		exit(0);
-	}
-	else
-		printf("Socket successfully binded..\n");
-
-	// Now server is ready to listen and verification
-	if ((listen(sockfd, 5)) != 0) {
-		printf("Listen failed...\n");
-		exit(0);
-	}
-	else
-		printf("Server listening..\n");
-	len = sizeof(cli);
-
-	// Accept the data packet from client and verification
-	connfd = accept(sockfd, (SA*)&cli, &len);
-	if (connfd < 0) {
-		printf("server accept failed...\n");
-		exit(0);
-	}
-	else
-		printf("server accept the client...\n");
-
-	// Function for chatting between client and server
-	func(connfd);
-
-	// After chatting close the socket
-	close(sockfd);
-}
diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index d65b0a54d2..9f79864af6 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -2,8 +2,6 @@
  * This is the main mcdstub.
  */
 
-#include "mcd_shared_defines.h"
-
 #include "qemu/osdep.h"
 #include "qemu/ctype.h"
 #include "qemu/cutils.h"
@@ -17,7 +15,6 @@
 #include "sysemu/runstate.h"
 #include "exec/replay-core.h"
 #include "exec/hwaddr.h"
-#include "internals.h"
 
 #include "qapi/error.h"
 #include "exec/tb-flush.h"
@@ -27,11 +24,12 @@
 #include "chardev/char-fe.h"
 #include "monitor/monitor.h"
 
-// architecture specific stubs
-#include "target/arm/mcdstub.h"
+/* mcdstub header files */
+#include "mcd_shared_defines.h"
+#include "mcdstub.h"
 
-// FIXME: delete the following line and check if it worked
-#include "hw/core/sysemu-cpu-ops.h"
+/* architecture specific stubs */
+#include "target/arm/mcdstub.h"
 
 typedef struct {
     CharBackend chr;
@@ -43,7 +41,7 @@ MCDState mcdserver_state;
 
 void mcd_init_mcdserver_state(void)
 {
-	g_assert(!mcdserver_state.init);
+    g_assert(!mcdserver_state.init);
     memset(&mcdserver_state, 0, sizeof(MCDState));
     mcdserver_state.init = true;
     mcdserver_state.str_buf = g_string_new(NULL);
@@ -55,14 +53,15 @@ void mcd_init_mcdserver_state(void)
      * By default try to use no IRQs and no timers while single
      * stepping so as to make single stepping like a typical ICE HW step.
      */
-    mcdserver_state.supported_sstep_flags = accel_supported_gdbstub_sstep_flags();
+    mcdserver_state.supported_sstep_flags =
+        accel_supported_gdbstub_sstep_flags();
     mcdserver_state.sstep_flags = SSTEP_ENABLE | SSTEP_NOIRQ | SSTEP_NOTIMER;
     mcdserver_state.sstep_flags &= mcdserver_state.supported_sstep_flags;
 
-    // init query table
+    /* init query table */
     init_query_cmds_table(mcdserver_state.mcd_query_cmds_table);
 
-    // at this time the cpu hans't been started! -> set cpu_state
+    /* at this time the cpu hans't been started! -> set cpu_state */
     mcd_cpu_state_st cpu_state =  {
             .state = CORE_STATE_HALTED,
             .info_str = STATE_STR_INIT_HALTED,
@@ -70,8 +69,9 @@ void mcd_init_mcdserver_state(void)
     mcdserver_state.cpu_state = cpu_state;
 }
 
-void init_query_cmds_table(MCDCmdParseEntry* mcd_query_cmds_table) {
-    // initalizes a list of all query commands
+void init_query_cmds_table(MCDCmdParseEntry *mcd_query_cmds_table)
+{
+    /* initalizes a list of all query commands */
     int cmd_number = 0;
 
     MCDCmdParseEntry query_system = {
@@ -270,7 +270,7 @@ int mcdserver_start(const char *device)
         return -1;
     }
 
-    // if device == default -> set device = tcp::1235
+    /* if device == default -> set device = tcp::1235 */
     if (strcmp(device, "default") == 0) {
         device = "tcp::1235";
     }
@@ -329,10 +329,12 @@ int mcd_chr_can_receive(void *opaque)
 void mcd_chr_receive(void *opaque, const uint8_t *buf, int size)
 {
     int i;
-	
+
     for (i = 0; i < size; i++) {
         mcd_read_byte(buf[i]);
-        if (buf[i]==0) break;
+        if (buf[i] == 0) {
+            break;
+        }
     }
 }
 
@@ -342,27 +344,30 @@ void mcd_read_byte(uint8_t ch)
 
     if (mcdserver_state.last_packet->len) {
         if (ch == TCP_NOT_ACKNOWLEDGED) {
-            // the previous packet was not akcnowledged
-            mcd_put_buffer(mcdserver_state.last_packet->data, mcdserver_state.last_packet->len);
-        }
-        else if (ch == TCP_ACKNOWLEDGED) {
-            // the previous packet was acknowledged
+            /* the previous packet was not akcnowledged */
+            mcd_put_buffer(mcdserver_state.last_packet->data,
+                mcdserver_state.last_packet->len);
+        } else if (ch == TCP_ACKNOWLEDGED) {
+            /* the previous packet was acknowledged */
         }
 
         if (ch == TCP_ACKNOWLEDGED || ch == TCP_COMMAND_START) {
-            // either acknowledged or a new communication starts -> discard previous packet
+            /*
+             * either acknowledged or a new communication starts
+             * -> discard previous packet
+             */
             g_byte_array_set_size(mcdserver_state.last_packet, 0);
         }
         if (ch != TCP_COMMAND_START) {
-            // skip to the next char
+            /* skip to the next char */
             return;
         }
     }
 
-    switch(mcdserver_state.state) {
+    switch (mcdserver_state.state) {
     case RS_IDLE:
         if (ch == TCP_COMMAND_START) {
-            // start of command packet
+            /* start of command packet */
             mcdserver_state.line_buf_index = 0;
             mcdserver_state.line_sum = 0;
             mcdserver_state.state = RS_GETLINE;
@@ -370,16 +375,15 @@ void mcd_read_byte(uint8_t ch)
         break;
     case RS_GETLINE:
         if (ch == TCP_COMMAND_END) {
-            // end of command
+            /* end of command */
             mcdserver_state.line_buf[mcdserver_state.line_buf_index++] = 0;
             mcdserver_state.state = RS_DATAEND;
-        }
-        else if (mcdserver_state.line_buf_index >= sizeof(mcdserver_state.line_buf) - 1) {
-            // the input string is too long for the linebuffer!
+        } else if (mcdserver_state.line_buf_index >=
+            sizeof(mcdserver_state.line_buf) - 1) {
+            /* the input string is too long for the linebuffer! */
             mcdserver_state.state = RS_IDLE;
-        }
-        else {
-            // copy the content to the line_buf
+        } else {
+            /* copy the content to the line_buf */
             mcdserver_state.line_buf[mcdserver_state.line_buf_index++] = ch;
             mcdserver_state.line_sum += ch;
         }
@@ -389,17 +393,15 @@ void mcd_read_byte(uint8_t ch)
             reply = TCP_ACKNOWLEDGED;
             mcd_put_buffer(&reply, 1);
             mcdserver_state.state = mcd_handle_packet(mcdserver_state.line_buf);
-        }
-        else if (ch == TCP_WAS_LAST) {
+        } else if (ch == TCP_WAS_LAST) {
             reply = TCP_ACKNOWLEDGED;
             mcd_put_buffer(&reply, 1);
             mcdserver_state.state = mcd_handle_packet(mcdserver_state.line_buf);
-        }
-        else {
-            // not acknowledged!
+        } else {
+            /* not acknowledged! */
             reply = TCP_NOT_ACKNOWLEDGED;
             mcd_put_buffer(&reply, 1);
-            // waiting for package to get resent
+            /* waiting for package to get resent */
             mcdserver_state.state = RS_IDLE;
         }
         break;
@@ -410,7 +412,10 @@ void mcd_read_byte(uint8_t ch)
 
 int mcd_handle_packet(const char *line_buf)
 {
-    // decides what function (handler) to call depending on the first character in the line_buf
+    /*
+     * decides what function (handler) to call depending on
+     * the first character in the line_buf
+     */
     const MCDCmdParseEntry *cmd_parser = NULL;
 
     switch (line_buf[0]) {
@@ -438,7 +443,8 @@ int mcd_handle_packet(const char *line_buf)
                 .handler = handle_vm_step,
             };
             step_cmd_desc.cmd = (char[2]) { TCP_CHAR_STEP, '\0' };
-            strcpy(step_cmd_desc.schema, (char[2]) { ARG_SCHEMA_CORENUM, '\0' });
+            strcpy(step_cmd_desc.schema,
+                (char[2]) { ARG_SCHEMA_CORENUM, '\0' });
             cmd_parser = &step_cmd_desc;
         }
         break;
@@ -452,7 +458,7 @@ int mcd_handle_packet(const char *line_buf)
         }
         break;
     case TCP_CHAR_KILLQEMU:
-        // kill qemu completely
+        /* kill qemu completely */
         error_report("QEMU: Terminated via MCDstub");
         mcd_exit(0);
         exit(0);
@@ -462,7 +468,8 @@ int mcd_handle_packet(const char *line_buf)
                 .handler = handle_gen_query,
             };
             query_cmd_desc.cmd = (char[2]) { TCP_CHAR_QUERY, '\0' };
-            strcpy(query_cmd_desc.schema, (char[2]) { ARG_SCHEMA_STRING, '\0' });
+            strcpy(query_cmd_desc.schema,
+                (char[2]) { ARG_SCHEMA_STRING, '\0' });
             cmd_parser = &query_cmd_desc;
         }
         break;
@@ -472,7 +479,8 @@ int mcd_handle_packet(const char *line_buf)
                 .handler = handle_open_core,
             };
             open_core_cmd_desc.cmd = (char[2]) { TCP_CHAR_OPEN_CORE, '\0' };
-            strcpy(open_core_cmd_desc.schema, (char[2]) { ARG_SCHEMA_CORENUM, '\0' });
+            strcpy(open_core_cmd_desc.schema,
+                (char[2]) { ARG_SCHEMA_CORENUM, '\0' });
             cmd_parser = &open_core_cmd_desc;
         }
         break;
@@ -481,7 +489,8 @@ int mcd_handle_packet(const char *line_buf)
             static MCDCmdParseEntry close_server_cmd_desc = {
                 .handler = handle_close_server,
             };
-            close_server_cmd_desc.cmd = (char[2]) { TCP_CHAR_CLOSE_SERVER, '\0' };
+            close_server_cmd_desc.cmd =
+                (char[2]) { TCP_CHAR_CLOSE_SERVER, '\0' };
             cmd_parser = &close_server_cmd_desc;
         }
         break;
@@ -491,7 +500,8 @@ int mcd_handle_packet(const char *line_buf)
                 .handler = handle_close_core,
             };
             close_core_cmd_desc.cmd = (char[2]) { TCP_CHAR_CLOSE_CORE, '\0' };
-            strcpy(close_core_cmd_desc.schema, (char[2]) { ARG_SCHEMA_CORENUM, '\0' });
+            strcpy(close_core_cmd_desc.schema,
+                (char[2]) { ARG_SCHEMA_CORENUM, '\0' });
             cmd_parser = &close_core_cmd_desc;
         }
         break;
@@ -511,7 +521,8 @@ int mcd_handle_packet(const char *line_buf)
                 .handler = handle_read_register,
             };
             read_reg_cmd_desc.cmd = (char[2]) { TCP_CHAR_READ_REGISTER, '\0' };
-            strcpy(read_reg_cmd_desc.schema, (char[3]) { ARG_SCHEMA_CORENUM, ARG_SCHEMA_UINT64_T, '\0' });
+            strcpy(read_reg_cmd_desc.schema,
+                (char[3]) { ARG_SCHEMA_CORENUM, ARG_SCHEMA_UINT64_T, '\0' });
             cmd_parser = &read_reg_cmd_desc;
         }
         break;
@@ -520,8 +531,11 @@ int mcd_handle_packet(const char *line_buf)
             static MCDCmdParseEntry write_reg_cmd_desc = {
                 .handler = handle_write_register,
             };
-            write_reg_cmd_desc.cmd = (char[2]) { TCP_CHAR_WRITE_REGISTER, '\0' };
-            strcpy(write_reg_cmd_desc.schema, (char[5]) { ARG_SCHEMA_CORENUM, ARG_SCHEMA_UINT64_T, ARG_SCHEMA_INT, ARG_SCHEMA_HEXDATA, '\0' });
+            write_reg_cmd_desc.cmd =
+                (char[2]) { TCP_CHAR_WRITE_REGISTER, '\0' };
+            strcpy(write_reg_cmd_desc.schema,
+                (char[5]) { ARG_SCHEMA_CORENUM, ARG_SCHEMA_UINT64_T,
+                ARG_SCHEMA_INT, ARG_SCHEMA_HEXDATA, '\0' });
             cmd_parser = &write_reg_cmd_desc;
         }
         break;
@@ -531,7 +545,9 @@ int mcd_handle_packet(const char *line_buf)
                 .handler = handle_read_memory,
             };
             read_mem_cmd_desc.cmd = (char[2]) { TCP_CHAR_READ_MEMORY, '\0' };
-            strcpy(read_mem_cmd_desc.schema, (char[4]) { ARG_SCHEMA_CORENUM, ARG_SCHEMA_UINT64_T, ARG_SCHEMA_INT, '\0' });
+            strcpy(read_mem_cmd_desc.schema,
+                (char[4]) { ARG_SCHEMA_CORENUM, ARG_SCHEMA_UINT64_T,
+                ARG_SCHEMA_INT, '\0' });
             cmd_parser = &read_mem_cmd_desc;
         }
         break;
@@ -541,48 +557,57 @@ int mcd_handle_packet(const char *line_buf)
                 .handler = handle_write_memory,
             };
             write_mem_cmd_desc.cmd = (char[2]) { TCP_CHAR_WRITE_MEMORY, '\0' };
-            strcpy(write_mem_cmd_desc.schema, (char[5]) { ARG_SCHEMA_CORENUM, ARG_SCHEMA_UINT64_T, ARG_SCHEMA_INT, ARG_SCHEMA_HEXDATA, '\0' });
+            strcpy(write_mem_cmd_desc.schema,
+                (char[5]) { ARG_SCHEMA_CORENUM, ARG_SCHEMA_UINT64_T,
+                ARG_SCHEMA_INT, ARG_SCHEMA_HEXDATA, '\0' });
             cmd_parser = &write_mem_cmd_desc;
         }
         break;
     default:
-        // command not supported
+        /* command not supported */
         mcd_put_packet("");
         break;
     }
 
     if (cmd_parser) {
-        // parse commands and run the selected handler function
+        /* parse commands and run the selected handler function */
         run_cmd_parser(line_buf, cmd_parser);
     }
 
     return RS_IDLE;
 }
 
-void handle_vm_start(GArray *params, void *user_ctx) {
-    // TODO: add partial restart with arguments and so on
+void handle_vm_start(GArray *params, void *user_ctx)
+{
+    /* TODO: add partial restart with arguments and so on */
     mcd_vm_start();
 }
 
-void handle_vm_step(GArray *params, void *user_ctx) {
-    // TODO: add partial restart with arguments and so on
+void handle_vm_step(GArray *params, void *user_ctx)
+{
+    /* TODO: add partial restart with arguments and so on */
     uint32_t cpu_id = get_param(params, 0)->cpu_id;
 
     CPUState *cpu = mcd_get_cpu(cpu_id);
-    mcd_vm_sstep(cpu);
+    int return_value = mcd_vm_sstep(cpu);
+    if (return_value != 0) {
+        g_assert_not_reached();
+    }
 }
 
 
-void handle_vm_stop(GArray *params, void *user_ctx) {
-    // TODO: add partial stop with arguments and so on
+void handle_vm_stop(GArray *params, void *user_ctx)
+{
+    /* TODO: add partial stop with arguments and so on */
     mcd_vm_stop();
 }
 
-void handle_gen_query(GArray *params, void *user_ctx) {
+void handle_gen_query(GArray *params, void *user_ctx)
+{
     if (!params->len) {
         return;
     }
-    // iterate over all possible query functions and execute the right one
+    /* iterate over all possible query functions and execute the right one */
     if (process_string_cmd(NULL, get_param(params, 0)->data,
                            mcdserver_state.mcd_query_cmds_table,
                            ARRAY_SIZE(mcdserver_state.mcd_query_cmds_table))) {
@@ -590,7 +615,8 @@ void handle_gen_query(GArray *params, void *user_ctx) {
     }
 }
 
-void run_cmd_parser(const char *data, const MCDCmdParseEntry *cmd) {
+void run_cmd_parser(const char *data, const MCDCmdParseEntry *cmd)
+{
     if (!data) {
         return;
     }
@@ -603,10 +629,10 @@ void run_cmd_parser(const char *data, const MCDCmdParseEntry *cmd) {
     }
 }
 
-uint64_t atouint64_t(const char* in) {
+uint64_t atouint64_t(const char *in)
+{
     uint64_t res = 0;
-    for (int i = 0; i < strlen(in); ++i)
-    {
+    for (int i = 0; i < strlen(in); ++i) {
         const char c = in[i];
         res *= 10;
         res += c - '0';
@@ -615,33 +641,33 @@ uint64_t atouint64_t(const char* in) {
     return res;
 }
 
-int cmd_parse_params(const char *data, const char *schema, GArray *params) {
-    
+int cmd_parse_params(const char *data, const char *schema, GArray *params)
+{
+
     char data_buffer[64] = {0};
     const char *remaining_data = data;
-    
-    for (int i = 0; i<strlen(schema); i++) {
-        // get correct part of data
+
+    for (int i = 0; i < strlen(schema); i++) {
+        /* get correct part of data */
         char *separator = strchr(remaining_data, ARGUMENT_SEPARATOR);
 
         if (separator) {
-            // multiple arguments
+            /* multiple arguments */
             int seperator_index = (int)(separator - remaining_data);
             strncpy(data_buffer, remaining_data, seperator_index);
             data_buffer[seperator_index] = 0;
-            // update remaining data for the next run
-            remaining_data = &(remaining_data[seperator_index+1]);
-        }
-        else {
+            /* update remaining data for the next run */
+            remaining_data = &(remaining_data[seperator_index + 1]);
+        } else {
             strncpy(data_buffer, remaining_data, strlen(remaining_data));
             data_buffer[strlen(remaining_data)] = 0;
         }
-        
-        // store right data
-        MCDCmdVariant this_param; 
+
+        /* store right data */
+        MCDCmdVariant this_param;
         switch (schema[i]) {
         case ARG_SCHEMA_STRING:
-            // this has to be the last argument
+            /* this has to be the last argument */
             this_param.data = remaining_data;
             g_array_append_val(params, this_param);
             break;
@@ -671,7 +697,9 @@ int cmd_parse_params(const char *data, const char *schema, GArray *params) {
     return 0;
 }
 
-int process_string_cmd(void *user_ctx, const char *data, const MCDCmdParseEntry *cmds, int num_cmds) {
+int process_string_cmd(void *user_ctx, const char *data,
+    const MCDCmdParseEntry *cmds, int num_cmds)
+{
     int i;
     g_autoptr(GArray) params = g_array_new(false, true, sizeof(MCDCmdVariant));
 
@@ -683,19 +711,20 @@ int process_string_cmd(void *user_ctx, const char *data, const MCDCmdParseEntry
         const MCDCmdParseEntry *cmd = &cmds[i];
         g_assert(cmd->handler && cmd->cmd);
 
-        // continue if data and command are different
+        /* continue if data and command are different */
         if (strncmp(data, cmd->cmd, strlen(cmd->cmd))) {
             continue;
         }
 
         if (strlen(cmd->schema)) {
-            // extract data for parameters
-            if (cmd_parse_params(&data[strlen(cmd->cmd)], cmd->schema, params)) {
+            /* extract data for parameters */
+            if (cmd_parse_params(&data[strlen(cmd->cmd)], cmd->schema, params))
+            {
                 return -1;
             }
         }
 
-        // call handler
+        /* call handler */
         cmd->handler(params, user_ctx);
         return 0;
     }
@@ -703,8 +732,9 @@ int process_string_cmd(void *user_ctx, const char *data, const MCDCmdParseEntry
     return -1;
 }
 
-void mcd_exit(int code) {
-    // terminate qemu
+void mcd_exit(int code)
+{
+    /* terminate qemu */
     if (!mcdserver_state.init) {
         return;
     }
@@ -712,13 +742,14 @@ void mcd_exit(int code) {
     qemu_chr_fe_deinit(&mcdserver_system_state.chr, true);
 }
 
-void mcd_chr_event(void *opaque, QEMUChrEvent event) {
+void mcd_chr_event(void *opaque, QEMUChrEvent event)
+{
     int i;
     MCDState *s = (MCDState *) opaque;
 
     switch (event) {
     case CHR_EVENT_OPENED:
-        // Start with first process attached, others detached
+        /* Start with first process attached, others detached */
         for (i = 0; i < s->process_num; i++) {
             s->processes[i].attached = !i;
         }
@@ -730,7 +761,8 @@ void mcd_chr_event(void *opaque, QEMUChrEvent event) {
     }
 }
 
-bool mcd_supports_guest_debug(void) {
+bool mcd_supports_guest_debug(void)
+{
     const AccelOpsClass *ops = cpus_get_accel();
     if (ops->supports_guest_debug) {
         return ops->supports_guest_debug();
@@ -739,15 +771,17 @@ bool mcd_supports_guest_debug(void) {
 }
 
 #ifndef _WIN32
-void mcd_sigterm_handler(int signal) {
+void mcd_sigterm_handler(int signal)
+{
     if (runstate_is_running()) {
         vm_stop(RUN_STATE_PAUSED);
     }
 }
 #endif
 
-void mcd_vm_state_change(void *opaque, bool running, RunState state) {
-	CPUState *cpu = mcdserver_state.c_cpu;
+void mcd_vm_state_change(void *opaque, bool running, RunState state)
+{
+    CPUState *cpu = mcdserver_state.c_cpu;
 
     if (mcdserver_state.state == RS_INACTIVE) {
         return;
@@ -755,7 +789,10 @@ void mcd_vm_state_change(void *opaque, bool running, RunState state) {
 
     if (cpu == NULL) {
         if (running) {
-            // this is the case if qemu starts the vm before a mcd client is connected
+            /*
+             * this is the case if qemu starts the vm
+             * before a mcd client is connected
+             */
             const char *mcd_state;
             mcd_state = CORE_STATE_RUNNING;
             const char *info_str;
@@ -798,13 +835,11 @@ void mcd_vm_state_change(void *opaque, bool running, RunState state) {
                 stop_str = STATE_STR_BREAK_UNKNOWN;
             }
             cpu->watchpoint_hit = NULL;
-        }
-        else if (cpu->singlestep_enabled){
-            // we land here when a single step is performed
+        } else if (cpu->singlestep_enabled) {
+            /* we land here when a single step is performed */
             cpu_single_step(cpu, 0);
             stop_str = STATE_STEP_PERFORMED;
-        }
-        else {
+        } else {
             trig_id = MCD_TRIG_TYPE_IP;
             stop_str = STATE_STR_BREAK_HW;
             tb_flush(cpu);
@@ -816,7 +851,6 @@ void mcd_vm_state_change(void *opaque, bool running, RunState state) {
         stop_str = "";
         break;
     case RUN_STATE_WATCHDOG:
-        printf("runstate watchdog hit\n");
         info_str = STATE_STR_UNKNOWN(cpu->cpu_index);
         mcd_state = CORE_STATE_UNKNOWN;
         stop_str = "";
@@ -828,30 +862,38 @@ void mcd_vm_state_change(void *opaque, bool running, RunState state) {
         break;
     }
 
-    // set state for c_cpu
+    /* set state for c_cpu */
     mcdserver_state.cpu_state.state = mcd_state;
     mcdserver_state.cpu_state.trig_id = trig_id;
     mcdserver_state.cpu_state.stop_str = stop_str;
     mcdserver_state.cpu_state.info_str = info_str;
 }
 
-int mcd_put_packet(const char *buf) {
+int mcd_put_packet(const char *buf)
+{
     return mcd_put_packet_binary(buf, strlen(buf), false);
 }
 
-void mcd_put_strbuf(void) {
+void mcd_put_strbuf(void)
+{
     mcd_put_packet(mcdserver_state.str_buf->str);
 }
 
-int mcd_put_packet_binary(const char *buf, int len, bool dump) {
-    for(;;) {
+int mcd_put_packet_binary(const char *buf, int len, bool dump)
+{
+    for (;;) {
         g_byte_array_set_size(mcdserver_state.last_packet, 0);
-        g_byte_array_append(mcdserver_state.last_packet, (const uint8_t *) (char[2]) { TCP_COMMAND_START, '\0' }, 1);
-        g_byte_array_append(mcdserver_state.last_packet, (const uint8_t *) buf, len);
-        g_byte_array_append(mcdserver_state.last_packet, (const uint8_t *) (char[2]) { TCP_COMMAND_END, '\0' }, 1);
-        g_byte_array_append(mcdserver_state.last_packet, (const uint8_t *) (char[2]) { TCP_WAS_LAST, '\0' }, 1);
-
-        mcd_put_buffer(mcdserver_state.last_packet->data, mcdserver_state.last_packet->len);
+        g_byte_array_append(mcdserver_state.last_packet,
+            (const uint8_t *) (char[2]) { TCP_COMMAND_START, '\0' }, 1);
+        g_byte_array_append(mcdserver_state.last_packet,
+            (const uint8_t *) buf, len);
+        g_byte_array_append(mcdserver_state.last_packet,
+            (const uint8_t *) (char[2]) { TCP_COMMAND_END, '\0' }, 1);
+        g_byte_array_append(mcdserver_state.last_packet,
+            (const uint8_t *) (char[2]) { TCP_WAS_LAST, '\0' }, 1);
+
+        mcd_put_buffer(mcdserver_state.last_packet->data,
+            mcdserver_state.last_packet->len);
 
         if (mcd_got_immediate_ack()) {
             break;
@@ -860,28 +902,33 @@ int mcd_put_packet_binary(const char *buf, int len, bool dump) {
     return 0;
 }
 
-bool mcd_got_immediate_ack(void) {
+bool mcd_got_immediate_ack(void)
+{
     return true;
 }
 
-void mcd_put_buffer(const uint8_t *buf, int len) {
+void mcd_put_buffer(const uint8_t *buf, int len)
+{
     qemu_chr_fe_write_all(&mcdserver_system_state.chr, buf, len);
 }
 
-MCDProcess *mcd_get_cpu_process(CPUState *cpu) {
+MCDProcess *mcd_get_cpu_process(CPUState *cpu)
+{
     return mcd_get_process(mcd_get_cpu_pid(cpu));
 }
 
-uint32_t mcd_get_cpu_pid(CPUState *cpu) {
+uint32_t mcd_get_cpu_pid(CPUState *cpu)
+{
     if (cpu->cluster_index == UNASSIGNED_CLUSTER_INDEX) {
-        // Return the default process' PID
+        /* Return the default process' PID */
         int index = mcdserver_state.process_num - 1;
         return mcdserver_state.processes[index].pid;
     }
     return cpu->cluster_index + 1;
 }
 
-MCDProcess *mcd_get_process(uint32_t pid) {
+MCDProcess *mcd_get_process(uint32_t pid)
+{
     int i;
 
     if (!pid) {
@@ -898,7 +945,8 @@ MCDProcess *mcd_get_process(uint32_t pid) {
     return NULL;
 }
 
-CPUState* mcd_get_cpu(uint32_t i_cpu_index) {
+CPUState *mcd_get_cpu(uint32_t i_cpu_index)
+{
     CPUState *cpu = first_cpu;
 
     while (cpu) {
@@ -911,7 +959,8 @@ CPUState* mcd_get_cpu(uint32_t i_cpu_index) {
     return cpu;
 }
 
-CPUState *mcd_first_attached_cpu(void) {
+CPUState *mcd_first_attached_cpu(void)
+{
     CPUState *cpu = first_cpu;
     MCDProcess *process = mcd_get_cpu_process(cpu);
 
@@ -922,7 +971,8 @@ CPUState *mcd_first_attached_cpu(void) {
     return cpu;
 }
 
-CPUState *mcd_next_attached_cpu(CPUState *cpu) {
+CPUState *mcd_next_attached_cpu(CPUState *cpu)
+{
     cpu = CPU_NEXT(cpu);
 
     while (cpu) {
@@ -936,11 +986,13 @@ CPUState *mcd_next_attached_cpu(CPUState *cpu) {
     return cpu;
 }
 
-int mcd_get_cpu_index(CPUState *cpu) {
+int mcd_get_cpu_index(CPUState *cpu)
+{
     return cpu->cpu_index + 1;
 }
 
-CPUState *get_first_cpu_in_process(MCDProcess *process) {
+CPUState *get_first_cpu_in_process(MCDProcess *process)
+{
     CPUState *cpu;
 
     CPU_FOREACH(cpu) {
@@ -952,7 +1004,8 @@ CPUState *get_first_cpu_in_process(MCDProcess *process) {
     return NULL;
 }
 
-CPUState *find_cpu(uint32_t thread_id) {
+CPUState *find_cpu(uint32_t thread_id)
+{
     CPUState *cpu;
 
     CPU_FOREACH(cpu) {
@@ -965,8 +1018,9 @@ CPUState *find_cpu(uint32_t thread_id) {
 }
 
 
-void parse_reg_xml(const char *xml, int size, GArray* registers) {
-    // iterates over the complete xml file
+void parse_reg_xml(const char *xml, int size, GArray *registers)
+{
+    /* iterates over the complete xml file */
     int i, j;
     int still_to_skip = 0;
     char argument[64] = {0};
@@ -987,108 +1041,103 @@ void parse_reg_xml(const char *xml, int size, GArray* registers) {
         c = xml[i];
         c_ptr = &c;
 
-        if (still_to_skip>0) {
-            // skip unwanted chars
-            still_to_skip --;
+        if (still_to_skip > 0) {
+            /* skip unwanted chars */
+            still_to_skip--;
             continue;
         }
 
-        if (strncmp(&xml[i], "<reg", 4)==0) {
-            // start of a register
+        if (strncmp(&xml[i], "<reg", 4) == 0) {
+            /* start of a register */
             still_to_skip = 3;
             is_reg = true;
             reg_data = g_array_new(false, true, sizeof(xml_attrib));
-        }
-        else if (is_reg) {
-            if (strncmp(&xml[i], "/>", 2)==0) {
-                // end of register info
+        } else if (is_reg) {
+            if (strncmp(&xml[i], "/>", 2) == 0) {
+                /* end of register info */
                 still_to_skip = 1;
                 is_reg = false;
 
-                // create empty register
+                /* create empty register */
                 mcd_reg_st my_register = (const struct mcd_reg_st){ 0 };
 
-                // add found attribtues
-                for (j = 0; j<reg_data->len; j++) {
+                /* add found attribtues */
+                for (j = 0; j < reg_data->len; j++) {
                     attribute_j = g_array_index(reg_data, xml_attrib, j);
 
                     argument_j = attribute_j.argument;
                     value_j = attribute_j.value;
 
-                    if (strcmp(argument_j, "name")==0) {
+                    if (strcmp(argument_j, "name") == 0) {
                         strcpy(my_register.name, value_j);
-                    }
-                    else if (strcmp(argument_j, "regnum")==0) {
+                    } else if (strcmp(argument_j, "regnum") == 0) {
                         my_register.id = atoi(value_j);
-                    }
-                    else if (strcmp(argument_j, "bitsize")==0) {
+                    } else if (strcmp(argument_j, "bitsize") == 0) {
                         my_register.bitsize = atoi(value_j);
-                    }
-                    else if (strcmp(argument_j, "type")==0) {
+                    } else if (strcmp(argument_j, "type") == 0) {
                         strcpy(my_register.type, value_j);
-                    }
-                    else if (strcmp(argument_j, "group")==0) {
+                    } else if (strcmp(argument_j, "group") == 0) {
                         strcpy(my_register.group, value_j);
                     }
                 }
-                // store register
+                /* store register */
                 g_array_append_vals(registers, (gconstpointer)&my_register, 1);
-                // free memory
+                /* free memory */
                 g_array_free(reg_data, false);
-            }
-            else {
-                // store info for register
+            } else {
+                /* store info for register */
                 switch (c) {
-                    case ' ':
-                        break;
-                    case '=':
-                        is_argument = false;
-                        break;
-                    case '"':
-                        if (is_value) {
-                            // end of value reached
-                            is_value = false;
-                            // store arg-val combo
-                            xml_attrib current_attribute;
-                            strcpy(current_attribute.argument, argument);
-                            strcpy(current_attribute.value, value);
-                            g_array_append_vals(reg_data, (gconstpointer)&current_attribute, 1);
-                            memset(argument, 0, sizeof(argument));
-                            memset(value, 0, sizeof(value));
-                        }
-                        else {
-                            //start of value
-                            is_value = true;
-                        }
-                        break;
-                    default:
-                        if (is_argument) {
-                            strncat(argument, c_ptr, 1);
-                        }
-                        else if (is_value) {
-                            strncat(value, c_ptr, 1);
-                        }
-                        else {
-                            is_argument = true;
-                            strncat(argument, c_ptr, 1);
-                        }
-                        break;
+                case ' ':
+                    break;
+                case '=':
+                    is_argument = false;
+                    break;
+                case '"':
+                    if (is_value) {
+                        /* end of value reached */
+                        is_value = false;
+                        /* store arg-val combo */
+                        xml_attrib current_attribute;
+                        strcpy(current_attribute.argument, argument);
+                        strcpy(current_attribute.value, value);
+                        g_array_append_vals(reg_data,
+                        (gconstpointer)&current_attribute, 1);
+                        memset(argument, 0, sizeof(argument));
+                        memset(value, 0, sizeof(value));
+                    } else {
+                        /*start of value */
+                        is_value = true;
+                    }
+                    break;
+                default:
+                    if (is_argument) {
+                        strncat(argument, c_ptr, 1);
+                    } else if (is_value) {
+                        strncat(value, c_ptr, 1);
+                    } else {
+                        is_argument = true;
+                        strncat(argument, c_ptr, 1);
+                    }
+                    break;
                 }
             }
         }
     }
 }
 
-int int_cmp(gconstpointer a, gconstpointer b) {
-    if (*(int*)a == *(int*)b) {
+int int_cmp(gconstpointer a, gconstpointer b)
+{
+    int int_a = *(int *)a;
+    int int_b = *(int *)b;
+    if (int_a == int_b) {
         return 0;
-    }
-    else {
+    } else {
         return 1;
     }
 }
 
-int mcd_arm_store_mem_spaces(CPUState *cpu, GArray* memspaces) {
+int mcd_arm_store_mem_spaces(CPUState *cpu, GArray *memspaces)
+{
     int nr_address_spaces = cpu->num_ases;
 
     mcd_mem_space_st space1 = {
@@ -1117,7 +1166,7 @@ int mcd_arm_store_mem_spaces(CPUState *cpu, GArray* memspaces) {
     };
     g_array_append_vals(memspaces, (gconstpointer)&space2, 1);
 
-    if (nr_address_spaces==2) {
+    if (nr_address_spaces == 2) {
         mcd_mem_space_st space3 = {
         .name = "Secure",
         .id = 3,
@@ -1143,7 +1192,7 @@ int mcd_arm_store_mem_spaces(CPUState *cpu, GArray* memspaces) {
     };
     g_array_append_vals(memspaces, (gconstpointer)&space4, 1);
     }
-    // TODO: get dynamically how the per (CP15) space is called
+    /* TODO: get dynamically how the per (CP15) space is called */
     mcd_mem_space_st space5 = {
         .name = "GPR Registers",
         .id = 5,
@@ -1172,7 +1221,8 @@ int mcd_arm_store_mem_spaces(CPUState *cpu, GArray* memspaces) {
     return 0;
 }
 
-int init_resets(GArray* resets) {
+int init_resets(GArray *resets)
+{
     mcd_reset_st system_reset = { .id = 0, .name = RESET_SYSTEM};
     mcd_reset_st gpr_reset = { .id = 1, .name = RESET_GPR};
     mcd_reset_st memory_reset = { .id = 2, .name = RESET_MEMORY};
@@ -1182,32 +1232,41 @@ int init_resets(GArray* resets) {
     return 0;
 }
 
-int init_trigger(mcd_trigger_st* trigger) {
-    trigger->type = (MCD_TRIG_TYPE_IP | MCD_TRIG_TYPE_READ | MCD_TRIG_TYPE_WRITE | MCD_TRIG_TYPE_RW);
+int init_trigger(mcd_trigger_st *trigger)
+{
+    trigger->type = (MCD_TRIG_TYPE_IP | MCD_TRIG_TYPE_READ |
+        MCD_TRIG_TYPE_WRITE | MCD_TRIG_TYPE_RW);
     trigger->option = (MCD_TRIG_OPT_DATA_IS_CONDITION);
     trigger->action = (MCD_TRIG_ACTION_DBG_DEBUG);
     trigger->nr_trigger = 4;
     return 0;
 }
 
-void handle_open_server(GArray *params, void *user_ctx) {
-    // initialize core-independent data
+void handle_open_server(GArray *params, void *user_ctx)
+{
+    /* initialize core-independent data */
     int return_value = 0;
     mcdserver_state.resets = g_array_new(false, true, sizeof(mcd_reset_st));
     return_value = init_resets(mcdserver_state.resets);
-    if (return_value!=0) assert(0);
+    if (return_value != 0) {
+        g_assert_not_reached();
+    }
     return_value = init_trigger(&mcdserver_state.trigger);
-    if (return_value!=0) assert(0);
+    if (return_value != 0) {
+        g_assert_not_reached();
+    }
 
-    mcd_put_packet(TCP_HANDSHAKE_SUCCESS); 
+    mcd_put_packet(TCP_HANDSHAKE_SUCCESS);
 }
 
-void handle_query_system(GArray *params, void *user_ctx) {
+void handle_query_system(GArray *params, void *user_ctx)
+{
     mcd_put_packet(MCD_SYSTEM_NAME);
 }
 
-void handle_query_cores(GArray *params, void *user_ctx) {
-    // get first cpu
+void handle_query_cores(GArray *params, void *user_ctx)
+{
+    /* get first cpu */
     CPUState *cpu = mcd_first_attached_cpu();
     if (!cpu) {
         return;
@@ -1218,123 +1277,136 @@ void handle_query_cores(GArray *params, void *user_ctx) {
 
     CPUClass *cc = CPU_GET_CLASS(cpu);
     gchar *arch = cc->gdb_arch_name(cpu);
-    
+
     int nr_cores = cpu->nr_cores;
     char device_name[] = DEVICE_NAME_TEMPLATE(arch);
     g_string_printf(mcdserver_state.str_buf, "%s=%s.%s=%s.%s=%d.",
-        TCP_ARGUMENT_DEVICE, device_name, TCP_ARGUMENT_CORE, cpu_model, TCP_ARGUMENT_AMOUNT_CORE, nr_cores);
+        TCP_ARGUMENT_DEVICE, device_name, TCP_ARGUMENT_CORE, cpu_model,
+        TCP_ARGUMENT_AMOUNT_CORE, nr_cores);
     mcd_put_strbuf();
     g_free(arch);
 }
 
-int mcd_arm_parse_core_xml_file(CPUClass *cc, GArray* reggroups, GArray* registers, int* current_group_id) {
+int mcd_arm_parse_core_xml_file(CPUClass *cc, GArray *reggroups,
+    GArray *registers, int *current_group_id)
+{
     const char *xml_filename = NULL;
     const char *current_xml_filename = NULL;
     const char *xml_content = NULL;
     int i = 0;
 
-    // 1. get correct file
+    /* 1. get correct file */
     xml_filename = cc->gdb_core_xml_file;
     for (i = 0; ; i++) {
         current_xml_filename = xml_builtin[i][0];
-        if (!current_xml_filename || (strncmp(current_xml_filename, xml_filename, strlen(xml_filename)) == 0
+        if (!current_xml_filename || (strncmp(current_xml_filename,
+            xml_filename, strlen(xml_filename)) == 0
             && strlen(current_xml_filename) == strlen(xml_filename)))
-        break;
+            break;
     }
-    // without gpr registers we can do nothing
+    /* without gpr registers we can do nothing */
     if (!current_xml_filename) {
         return -1;
     }
 
-    // 2. add group for gpr registers
-    mcd_reg_group_st gprregs = { .name = "GPR Registers", .id = *current_group_id };
+    /* 2. add group for gpr registers */
+    mcd_reg_group_st gprregs = {
+        .name = "GPR Registers",
+        .id = *current_group_id
+    };
     g_array_append_vals(reggroups, (gconstpointer)&gprregs, 1);
     *current_group_id = *current_group_id + 1;
 
-    // 3. parse xml
+    /* 3. parse xml */
     xml_content = xml_builtin[i][1];
     parse_reg_xml(xml_content, strlen(xml_content), registers);
     return 0;
 }
 
-int mcd_arm_parse_general_xml_files(CPUState *cpu, GArray* reggroups, GArray* registers, int* current_group_id) {
+int mcd_arm_parse_general_xml_files(CPUState *cpu, GArray *reggroups,
+    GArray *registers, int *current_group_id) {
     const char *xml_filename = NULL;
     const char *current_xml_filename = NULL;
     const char *xml_content = NULL;
     int i = 0;
 
-    // iterate over all gdb xml files 
+    /* iterate over all gdb xml files*/
     GDBRegisterState *r;
     for (r = cpu->gdb_regs; r; r = r->next) {
         xml_filename = r->xml;
         xml_content = NULL;
 
-        // 1. get xml content
+        /* 1. get xml content */
         xml_content = arm_mcd_get_dynamic_xml(cpu, xml_filename);
         if (xml_content) {
-            if (strcmp(xml_filename, "system-registers.xml")==0) {
-                // these are the coprocessor register
-                mcd_reg_group_st corprocessorregs = { .name = "CP15 Registers", .id = *current_group_id };
-                g_array_append_vals(reggroups, (gconstpointer)&corprocessorregs, 1);
+            if (strcmp(xml_filename, "system-registers.xml") == 0) {
+                /* these are the coprocessor register */
+                mcd_reg_group_st corprocessorregs = {
+                    .name = "CP15 Registers",
+                    .id = *current_group_id
+                };
+                g_array_append_vals(reggroups,
+                    (gconstpointer)&corprocessorregs, 1);
                 *current_group_id = *current_group_id + 1;
-            }  
-        }
-        else {
-            // its not a coprocessor xml -> it is a static xml file
+            }
+        } else {
+            /* its not a coprocessor xml -> it is a static xml file */
             for (i = 0; ; i++) {
                 current_xml_filename = xml_builtin[i][0];
-                if (!current_xml_filename || (strncmp(current_xml_filename, xml_filename, strlen(xml_filename)) == 0
+                if (!current_xml_filename || (strncmp(current_xml_filename,
+                    xml_filename, strlen(xml_filename)) == 0
                     && strlen(current_xml_filename) == strlen(xml_filename)))
-                break;
+                    break;
             }
             if (current_xml_filename) {
                 xml_content = xml_builtin[i][1];
-            }
-            else {
-                printf("no data found for %s\n", xml_filename);
+            } else {
                 continue;
             }
         }
-        // 2. parse xml
+        /* 2. parse xml */
         parse_reg_xml(xml_content, strlen(xml_content), registers);
     }
     return 0;
 }
 
-int mcd_arm_get_additional_register_info(GArray* reggroups, GArray* registers) {
+int mcd_arm_get_additional_register_info(GArray *reggroups, GArray *registers)
+{
     GList *register_numbers = NULL;
     mcd_reg_st *current_register;
     int i = 0;
     int id_neg_offset = 0;
     int effective_id = 0;
 
-    // iterate over all registers
+    /* iterate over all registers */
     for (i = 0; i < registers->len; i++) {
         current_register = &(g_array_index(registers, mcd_reg_st, i));
-        // 1. ad the id
+        /* 1. ad the id */
         if (current_register->id) {
-            // id is already in place
-            // NOTE: qemu doesn't emulate the FPA regs (so we are missing the indices 16 to 24)
+            /*
+             *id is already in place
+             *NOTE: qemu doesn't emulate the FPA regs
+             *(so we are missing the indices 16 to 24)
+             */
             int used_id = current_register->id;
             register_numbers = g_list_append(register_numbers, &used_id);
-            id_neg_offset ++;
-        }
-        else {
+            id_neg_offset++;
+        } else {
             effective_id = i - id_neg_offset;
-            if (g_list_find_custom(register_numbers, &effective_id, (GCompareFunc)int_cmp)!=NULL) {
-                id_neg_offset --;
+            if (g_list_find_custom(register_numbers, &effective_id,
+                (GCompareFunc)int_cmp) != NULL) {
+                id_neg_offset--;
             }
             current_register->id = i - id_neg_offset;
         }
-        // 2. add mcd_reg_group_id and mcd_mem_space_id
-        if (strcmp(current_register->group, "cp_regs")==0) {
-            // coprocessor registers
+        /* 2. add mcd_reg_group_id and mcd_mem_space_id */
+        if (strcmp(current_register->group, "cp_regs") == 0) {
+            /* coprocessor registers */
             current_register->mcd_reg_group_id = 2;
             current_register->mcd_mem_space_id = 6;
-            // TODO: get info for opcode
-        }
-        else {
-            // gpr register
+            /* TODO: get info for opcode */
+        } else {
+            /* gpr register */
             current_register->mcd_reg_group_id = 1;
             current_register->mcd_mem_space_id = 5;
         }
@@ -1343,7 +1415,8 @@ int mcd_arm_get_additional_register_info(GArray* reggroups, GArray* registers) {
     return 0;
 }
 
-void handle_open_core(GArray *params, void *user_ctx) {
+void handle_open_core(GArray *params, void *user_ctx)
+{
     uint32_t cpu_id = get_param(params, 0)->cpu_id;
     CPUState *cpu = mcd_get_cpu(cpu_id);
     mcdserver_state.c_cpu = cpu;
@@ -1351,315 +1424,373 @@ void handle_open_core(GArray *params, void *user_ctx) {
     gchar *arch = cc->gdb_arch_name(cpu);
     int return_value = 0;
 
-    // prepare data strucutures
-    GArray* memspaces = g_array_new(false, true, sizeof(mcd_mem_space_st));
-    GArray* reggroups = g_array_new(false, true, sizeof(mcd_reg_group_st));
-    GArray* registers = g_array_new(false, true, sizeof(mcd_reg_st));
-    
-    if (strcmp(arch, "arm")==0) {
-        // TODO: make group and memspace ids dynamic
+    /* prepare data strucutures */
+    GArray *memspaces = g_array_new(false, true, sizeof(mcd_mem_space_st));
+    GArray *reggroups = g_array_new(false, true, sizeof(mcd_reg_group_st));
+    GArray *registers = g_array_new(false, true, sizeof(mcd_reg_st));
+
+    if (strcmp(arch, "arm") == 0) {
+        /* TODO: make group and memspace ids dynamic */
         int current_group_id = 1;
-        // 1. store mem spaces
+        /* 1. store mem spaces */
         return_value = mcd_arm_store_mem_spaces(cpu, memspaces);
-        if (return_value!=0) assert(0);
-        // 2. parse core xml
-        return_value = mcd_arm_parse_core_xml_file(cc, reggroups, registers, &current_group_id);
-        if (return_value!=0) assert(0);
-        // 3. parse other xmls
-        return_value = mcd_arm_parse_general_xml_files(cpu, reggroups, registers, &current_group_id);
-        if (return_value!=0) assert(0);
-        // 4. add additional data the the regs from the xmls
-        return_value = mcd_arm_get_additional_register_info(reggroups, registers);
-        if (return_value!=0) assert(0);
-        // 5. store all found data
+        if (return_value != 0) {
+            g_assert_not_reached();
+        }
+        /* 2. parse core xml */
+        return_value = mcd_arm_parse_core_xml_file(cc, reggroups,
+            registers, &current_group_id);
+        if (return_value != 0) {
+            g_assert_not_reached();
+        }
+        /* 3. parse other xmls */
+        return_value = mcd_arm_parse_general_xml_files(cpu, reggroups,
+            registers, &current_group_id);
+        if (return_value != 0) {
+            g_assert_not_reached();
+        }
+        /* 4. add additional data the the regs from the xmls */
+        return_value = mcd_arm_get_additional_register_info(reggroups,
+            registers);
+        if (return_value != 0) {
+            g_assert_not_reached();
+        }
+        /* 5. store all found data */
         if (g_list_nth(mcdserver_state.all_memspaces, cpu_id)) {
-            GList* memspaces_ptr = g_list_nth(mcdserver_state.all_memspaces, cpu_id);
+            GList *memspaces_ptr =
+                g_list_nth(mcdserver_state.all_memspaces, cpu_id);
             memspaces_ptr->data = memspaces;
-        }
-        else {
-            mcdserver_state.all_memspaces = g_list_insert(mcdserver_state.all_memspaces, memspaces, cpu_id);
+        } else {
+            mcdserver_state.all_memspaces =
+                g_list_insert(mcdserver_state.all_memspaces, memspaces, cpu_id);
         }
         if (g_list_nth(mcdserver_state.all_reggroups, cpu_id)) {
-            GList* reggroups_ptr = g_list_nth(mcdserver_state.all_reggroups, cpu_id);
+            GList *reggroups_ptr =
+                g_list_nth(mcdserver_state.all_reggroups, cpu_id);
             reggroups_ptr->data = reggroups;
-        }
-        else {
-            mcdserver_state.all_reggroups = g_list_insert(mcdserver_state.all_reggroups, reggroups, cpu_id);
+        } else {
+            mcdserver_state.all_reggroups =
+                g_list_insert(mcdserver_state.all_reggroups, reggroups, cpu_id);
         }
         if (g_list_nth(mcdserver_state.all_registers, cpu_id)) {
-            GList* registers_ptr = g_list_nth(mcdserver_state.all_registers, cpu_id);
+            GList *registers_ptr =
+                g_list_nth(mcdserver_state.all_registers, cpu_id);
             registers_ptr->data = registers;
+        } else {
+            mcdserver_state.all_registers =
+                g_list_insert(mcdserver_state.all_registers, registers, cpu_id);
         }
-        else {
-            mcdserver_state.all_registers = g_list_insert(mcdserver_state.all_registers, registers, cpu_id);
-        }
-    }
-    else {
-        // we don't support other architectures
-        assert(0);
+    } else {
+        /* we don't support other architectures */
+        g_assert_not_reached();
     }
 
     g_free(arch);
 }
 
-void handle_query_reset_f(GArray *params, void *user_ctx) {
-    // TODO: vull reset over the qemu monitor
-    
-    // 1. check length
+void handle_query_reset_f(GArray *params, void *user_ctx)
+{
+    /* TODO: vull reset over the qemu monitor */
+
+    /* 1. check length */
     int nb_resets = mcdserver_state.resets->len;
     if (nb_resets == 1) {
-        // indicates this is the last packet
+        /* indicates this is the last packet */
         g_string_printf(mcdserver_state.str_buf, "0!");
-    }
-    else {
+    } else {
         g_string_printf(mcdserver_state.str_buf, "1!");
     }
-    // 2. send data
+    /* 2. send data */
     mcd_reset_st reset = g_array_index(mcdserver_state.resets, mcd_reset_st, 0);
-    g_string_append_printf(mcdserver_state.str_buf, "%s=%s.%s=%d.", TCP_ARGUMENT_NAME, reset.name, TCP_ARGUMENT_ID, reset.id);
+    g_string_append_printf(mcdserver_state.str_buf, "%s=%s.%s=%d.",
+        TCP_ARGUMENT_NAME, reset.name, TCP_ARGUMENT_ID, reset.id);
     mcd_put_strbuf();
 }
 
-void handle_query_reset_c(GArray *params, void *user_ctx) {
-    // reset options are the same for every cpu!
+void handle_query_reset_c(GArray *params, void *user_ctx)
+{
+    /* reset options are the same for every cpu! */
     int query_index = get_param(params, 0)->query_handle;
-    
-    // 1. check weather this was the last mem space
+
+    /* 1. check weather this was the last mem space */
     int nb_groups = mcdserver_state.resets->len;
-    if (query_index+1 == nb_groups) {
-        // indicates this is the last packet
+    if (query_index + 1 == nb_groups) {
+        /* indicates this is the last packet */
         g_string_printf(mcdserver_state.str_buf, "0!");
-    }
-    else {
-        g_string_printf(mcdserver_state.str_buf, "%d!", query_index+1);
+    } else {
+        g_string_printf(mcdserver_state.str_buf, "%d!", query_index + 1);
     }
 
-    // 2. send data
-    mcd_reset_st reset = g_array_index(mcdserver_state.resets, mcd_reset_st, query_index);
-    g_string_append_printf(mcdserver_state.str_buf, "%s=%s.%s=%d.", TCP_ARGUMENT_NAME, reset.name, TCP_ARGUMENT_ID, reset.id);
+    /* 2. send data */
+    mcd_reset_st reset = g_array_index(mcdserver_state.resets,
+        mcd_reset_st, query_index);
+    g_string_append_printf(mcdserver_state.str_buf, "%s=%s.%s=%d.",
+        TCP_ARGUMENT_NAME, reset.name, TCP_ARGUMENT_ID, reset.id);
     mcd_put_strbuf();
 }
 
-void handle_close_core(GArray *params, void *user_ctx) {
-    // free memory for correct core
+void handle_close_core(GArray *params, void *user_ctx)
+{
+    /* free memory for correct core */
     uint32_t cpu_id = get_param(params, 0)->cpu_id;
-    GArray* memspaces = g_list_nth_data(mcdserver_state.all_memspaces, cpu_id);
-    mcdserver_state.all_memspaces = g_list_remove(mcdserver_state.all_memspaces, memspaces);
+    GArray *memspaces = g_list_nth_data(mcdserver_state.all_memspaces, cpu_id);
+    mcdserver_state.all_memspaces =
+        g_list_remove(mcdserver_state.all_memspaces, memspaces);
     g_array_free(memspaces, TRUE);
-    GArray* reggroups = g_list_nth_data(mcdserver_state.all_reggroups, cpu_id);
-    mcdserver_state.all_reggroups = g_list_remove(mcdserver_state.all_reggroups, reggroups);
+    GArray *reggroups = g_list_nth_data(mcdserver_state.all_reggroups, cpu_id);
+    mcdserver_state.all_reggroups =
+        g_list_remove(mcdserver_state.all_reggroups, reggroups);
     g_array_free(reggroups, TRUE);
-    GArray* registers = g_list_nth_data(mcdserver_state.all_registers, cpu_id);
-    mcdserver_state.all_registers = g_list_remove(mcdserver_state.all_registers, registers);
+    GArray *registers = g_list_nth_data(mcdserver_state.all_registers, cpu_id);
+    mcdserver_state.all_registers =
+        g_list_remove(mcdserver_state.all_registers, registers);
     g_array_free(registers, TRUE);
 }
 
-void handle_close_server(GArray *params, void *user_ctx) {
+void handle_close_server(GArray *params, void *user_ctx)
+{
     uint32_t pid = 1;
     MCDProcess *process = mcd_get_process(pid);
 
-    // 1. free memory
-    // TODO: do this only if there are no processes attached anymore!
+    /*
+     * 1. free memory
+     * TODO: do this only if there are no processes attached anymore!
+     */
     g_list_free(mcdserver_state.all_memspaces);
     g_list_free(mcdserver_state.all_reggroups);
     g_list_free(mcdserver_state.all_registers);
     g_array_free(mcdserver_state.resets, TRUE);
 
-    // 2. detach
+    /* 2. detach */
     process->attached = false;
 
-    // 3. reset process
+    /* 3. reset process */
     if (pid == mcd_get_cpu_pid(mcdserver_state.c_cpu)) {
         mcdserver_state.c_cpu = mcd_first_attached_cpu();
     }
     if (!mcdserver_state.c_cpu) {
-        // no more processes attached
+        /* no more processes attached */
         mcd_disable_syscalls();
         mcd_vm_start();
     }
 }
 
-void handle_query_trigger(GArray *params, void *user_ctx) {
+void handle_query_trigger(GArray *params, void *user_ctx)
+{
     mcd_trigger_st trigger = mcdserver_state.trigger;
     g_string_printf(mcdserver_state.str_buf, "%s=%d.%s=%d.%s=%d.%s=%d.",
-        TCP_ARGUMENT_AMOUNT_TRIGGER,  trigger.nr_trigger, TCP_ARGUMENT_TYPE, trigger.type,
-        TCP_ARGUMENT_OPTION, trigger.option, TCP_ARGUMENT_ACTION, trigger.action);
+        TCP_ARGUMENT_AMOUNT_TRIGGER, trigger.nr_trigger,
+        TCP_ARGUMENT_TYPE, trigger.type, TCP_ARGUMENT_OPTION, trigger.option,
+        TCP_ARGUMENT_ACTION, trigger.action);
     mcd_put_strbuf();
 }
 
-void mcd_vm_start(void) {
+void mcd_vm_start(void)
+{
     if (!runstate_needs_reset() && !runstate_is_running()) {
         vm_start();
     }
 }
 
-int mcd_vm_sstep(CPUState *cpu) {
+int mcd_vm_sstep(CPUState *cpu)
+{
     cpu_single_step(mcdserver_state.c_cpu, mcdserver_state.sstep_flags);
     mcd_vm_start();
     return 0;
 }
 
-void mcd_vm_stop(void) {
+void mcd_vm_stop(void)
+{
     if (runstate_is_running()) {
         vm_stop(RUN_STATE_DEBUG);
     }
 }
 
-void handle_query_mem_spaces_f(GArray *params, void *user_ctx) {
-    // 1. get correct memspaces and set the query_cpu
+void handle_query_mem_spaces_f(GArray *params, void *user_ctx)
+{
+    /* 1. get correct memspaces and set the query_cpu */
     uint32_t cpu_id = get_param(params, 0)->cpu_id;
     mcdserver_state.query_cpu_id = cpu_id;
-    GArray* memspaces = g_list_nth_data(mcdserver_state.all_memspaces, cpu_id);
+    GArray *memspaces = g_list_nth_data(mcdserver_state.all_memspaces, cpu_id);
 
-    // 2. check length
+    /* 2. check length */
     int nb_groups = memspaces->len;
     if (nb_groups == 1) {
-        // indicates this is the last packet
+        /* indicates this is the last packet */
         g_string_printf(mcdserver_state.str_buf, "0!");
-    }
-    else {
+    } else {
         g_string_printf(mcdserver_state.str_buf, "1!");
     }
 
-    // 3. send data
+    /* 3. send data */
     mcd_mem_space_st space = g_array_index(memspaces, mcd_mem_space_st, 0);
-    g_string_append_printf(mcdserver_state.str_buf, "%s=%s.%s=%d.%s=%d.%s=%d.%s=%d.%s=%d.%s=%ld.%s=%ld.%s=%d.",
-        TCP_ARGUMENT_NAME, space.name, TCP_ARGUMENT_ID, space.id, TCP_ARGUMENT_TYPE, space.type,
-        TCP_ARGUMENT_BITS_PER_MAU, space.bits_per_mau, TCP_ARGUMENT_INVARIANCE, space.invariance, TCP_ARGUMENT_ENDIAN, space.endian,
-        TCP_ARGUMENT_MIN, space.min_addr, TCP_ARGUMENT_MAX, space.max_addr,
-        TCP_ARGUMENT_SUPPORTED_ACCESS_OPTIONS, space.supported_access_options);
+    g_string_append_printf(mcdserver_state.str_buf,
+        "%s=%s.%s=%d.%s=%d.%s=%d.%s=%d.%s=%d.%s=%ld.%s=%ld.%s=%d.",
+        TCP_ARGUMENT_NAME, space.name, TCP_ARGUMENT_ID, space.id,
+        TCP_ARGUMENT_TYPE, space.type, TCP_ARGUMENT_BITS_PER_MAU,
+        space.bits_per_mau, TCP_ARGUMENT_INVARIANCE, space.invariance,
+        TCP_ARGUMENT_ENDIAN, space.endian, TCP_ARGUMENT_MIN, space.min_addr,
+        TCP_ARGUMENT_MAX, space.max_addr, TCP_ARGUMENT_SUPPORTED_ACCESS_OPTIONS,
+        space.supported_access_options);
     mcd_put_strbuf();
 }
 
-void handle_query_mem_spaces_c(GArray *params, void *user_ctx) {
-    // this funcitons send all mem spaces except for the first
-    // 1. get parameter and memspace
+void handle_query_mem_spaces_c(GArray *params, void *user_ctx)
+{
+    /*
+     * this funcitons send all mem spaces except for the first
+     * 1. get parameter and memspace
+     */
     int query_index = get_param(params, 0)->query_handle;
     uint32_t cpu_id = mcdserver_state.query_cpu_id;
-    GArray* memspaces = g_list_nth_data(mcdserver_state.all_memspaces, cpu_id);
+    GArray *memspaces = g_list_nth_data(mcdserver_state.all_memspaces, cpu_id);
 
-    // 2. check weather this was the last mem space
+    /* 2. check weather this was the last mem space */
     int nb_groups = memspaces->len;
-    if (query_index+1 == nb_groups) {
-        // indicates this is the last packet
+    if (query_index + 1 == nb_groups) {
+        /* indicates this is the last packet */
         g_string_printf(mcdserver_state.str_buf, "0!");
-    }
-    else {
-        g_string_printf(mcdserver_state.str_buf, "%d!", query_index+1);
-    }
-
-    // 3. send the correct memspace
-    mcd_mem_space_st space = g_array_index(memspaces, mcd_mem_space_st, query_index);
-    g_string_append_printf(mcdserver_state.str_buf, "%s=%s.%s=%d.%s=%d.%s=%d.%s=%d.%s=%d.%s=%ld.%s=%ld.%s=%d.",
-        TCP_ARGUMENT_NAME, space.name, TCP_ARGUMENT_ID, space.id, TCP_ARGUMENT_TYPE, space.type,
-        TCP_ARGUMENT_BITS_PER_MAU, space.bits_per_mau, TCP_ARGUMENT_INVARIANCE, space.invariance, TCP_ARGUMENT_ENDIAN, space.endian,
-        TCP_ARGUMENT_MIN, space.min_addr, TCP_ARGUMENT_MAX, space.max_addr,
-        TCP_ARGUMENT_SUPPORTED_ACCESS_OPTIONS, space.supported_access_options);
+    } else {
+        g_string_printf(mcdserver_state.str_buf, "%d!", query_index + 1);
+    }
+
+    /* 3. send the correct memspace */
+    mcd_mem_space_st space = g_array_index(memspaces,
+        mcd_mem_space_st, query_index);
+    g_string_append_printf(mcdserver_state.str_buf,
+        "%s=%s.%s=%d.%s=%d.%s=%d.%s=%d.%s=%d.%s=%ld.%s=%ld.%s=%d.",
+        TCP_ARGUMENT_NAME, space.name, TCP_ARGUMENT_ID,
+        space.id, TCP_ARGUMENT_TYPE, space.type, TCP_ARGUMENT_BITS_PER_MAU,
+        space.bits_per_mau, TCP_ARGUMENT_INVARIANCE, space.invariance,
+        TCP_ARGUMENT_ENDIAN, space.endian, TCP_ARGUMENT_MIN, space.min_addr,
+        TCP_ARGUMENT_MAX, space.max_addr, TCP_ARGUMENT_SUPPORTED_ACCESS_OPTIONS,
+        space.supported_access_options);
     mcd_put_strbuf();
 }
 
-void handle_query_reg_groups_f(GArray *params, void *user_ctx) {
-    // 1. get correct reggroups and set the query_cpu
+void handle_query_reg_groups_f(GArray *params, void *user_ctx)
+{
+    /* 1. get correct reggroups and set the query_cpu */
     uint32_t cpu_id = get_param(params, 0)->cpu_id;
     mcdserver_state.query_cpu_id = cpu_id;
-    GArray* reggroups = g_list_nth_data(mcdserver_state.all_reggroups, cpu_id);
+    GArray *reggroups = g_list_nth_data(mcdserver_state.all_reggroups, cpu_id);
 
-    // 2. check length
+    /* 2. check length */
     int nb_groups = reggroups->len;
     if (nb_groups == 1) {
-        // indicates this is the last packet
+        /* indicates this is the last packet */
         g_string_printf(mcdserver_state.str_buf, "0!");
-    }
-    else {
+    } else {
         g_string_printf(mcdserver_state.str_buf, "1!");
     }
-    // 3. send data
+    /* 3. send data */
     mcd_reg_group_st group = g_array_index(reggroups, mcd_reg_group_st, 0);
-    g_string_append_printf(mcdserver_state.str_buf, "%s=%d.%s=%s.", TCP_ARGUMENT_ID, group.id, TCP_ARGUMENT_NAME, group.name);
+    g_string_append_printf(mcdserver_state.str_buf, "%s=%d.%s=%s.",
+        TCP_ARGUMENT_ID, group.id, TCP_ARGUMENT_NAME, group.name);
     mcd_put_strbuf();
 }
 
-void handle_query_reg_groups_c(GArray *params, void *user_ctx) {
-    // this funcitons send all reg groups except for the first
-    // 1. get parameter and memspace
+void handle_query_reg_groups_c(GArray *params, void *user_ctx)
+{
+    /*
+     * this funcitons send all reg groups except for the first
+     * 1. get parameter and memspace
+     */
     int query_index = get_param(params, 0)->query_handle;
     uint32_t cpu_id = mcdserver_state.query_cpu_id;
-    GArray* reggroups = g_list_nth_data(mcdserver_state.all_reggroups, cpu_id);
+    GArray *reggroups = g_list_nth_data(mcdserver_state.all_reggroups, cpu_id);
 
-    // 2. check weather this was the last reg group
+    /* 2. check weather this was the last reg group */
     int nb_groups = reggroups->len;
-    if (query_index+1 == nb_groups) {
-        // indicates this is the last packet
+    if (query_index + 1 == nb_groups) {
+        /* indicates this is the last packet */
         g_string_printf(mcdserver_state.str_buf, "0!");
-    }
-    else {
-        g_string_printf(mcdserver_state.str_buf, "%d!", query_index+1);
+    } else {
+        g_string_printf(mcdserver_state.str_buf, "%d!", query_index + 1);
     }
 
-    // 3. send the correct reggroup
-    mcd_reg_group_st group = g_array_index(reggroups, mcd_reg_group_st, query_index);
-    g_string_append_printf(mcdserver_state.str_buf, "%s=%d.%s=%s.", TCP_ARGUMENT_ID, group.id, TCP_ARGUMENT_NAME, group.name);
+    /* 3. send the correct reggroup */
+    mcd_reg_group_st group = g_array_index(reggroups, mcd_reg_group_st,
+        query_index);
+    g_string_append_printf(mcdserver_state.str_buf, "%s=%d.%s=%s.",
+        TCP_ARGUMENT_ID, group.id, TCP_ARGUMENT_NAME, group.name);
     mcd_put_strbuf();
 }
 
-void handle_query_regs_f(GArray *params, void *user_ctx) {
-    // 1. get correct registers and set the query_cpu
+void handle_query_regs_f(GArray *params, void *user_ctx)
+{
+    /* 1. get correct registers and set the query_cpu */
     uint32_t cpu_id = get_param(params, 0)->cpu_id;
     mcdserver_state.query_cpu_id = cpu_id;
-    GArray* registers = g_list_nth_data(mcdserver_state.all_registers, cpu_id);
+    GArray *registers = g_list_nth_data(mcdserver_state.all_registers, cpu_id);
 
-    // 2. check length
+    /* 2. check length */
     int nb_regs = registers->len;
     if (nb_regs == 1) {
-        // indicates this is the last packet
+        /* indicates this is the last packet */
         g_string_printf(mcdserver_state.str_buf, "0!");
-    }
-    else {
+    } else {
         g_string_printf(mcdserver_state.str_buf, "1!");
     }
-    // 3. send data
+    /* 3. send data */
     mcd_reg_st my_register = g_array_index(registers, mcd_reg_st, 0);
-    g_string_append_printf(mcdserver_state.str_buf, "%s=%d.%s=%s.%s=%d.%s=%d.%s=%d.%s=%d.%s=%d.",
-        TCP_ARGUMENT_ID, my_register.id, TCP_ARGUMENT_NAME,  my_register.name, TCP_ARGUMENT_SIZE, my_register.bitsize,
-        TCP_ARGUMENT_REGGROUPID, my_register.mcd_reg_group_id, TCP_ARGUMENT_MEMSPACEID, my_register.mcd_mem_space_id,
-        TCP_ARGUMENT_TYPE, my_register.mcd_reg_type, TCP_ARGUMENT_THREAD, my_register.mcd_hw_thread_id);
+    g_string_append_printf(mcdserver_state.str_buf,
+        "%s=%d.%s=%s.%s=%d.%s=%d.%s=%d.%s=%d.%s=%d.",
+        TCP_ARGUMENT_ID, my_register.id, TCP_ARGUMENT_NAME,
+        my_register.name, TCP_ARGUMENT_SIZE, my_register.bitsize,
+        TCP_ARGUMENT_REGGROUPID, my_register.mcd_reg_group_id,
+        TCP_ARGUMENT_MEMSPACEID, my_register.mcd_mem_space_id,
+        TCP_ARGUMENT_TYPE, my_register.mcd_reg_type,
+        TCP_ARGUMENT_THREAD, my_register.mcd_hw_thread_id);
     mcd_put_strbuf();
 }
 
-void handle_query_regs_c(GArray *params, void *user_ctx) {
-    // this funcitons send all regs except for the first
-    // 1. get parameter and registers
+void handle_query_regs_c(GArray *params, void *user_ctx)
+{
+    /*
+     * this funcitons send all regs except for the first
+     * 1. get parameter and registers
+     */
     int query_index = get_param(params, 0)->query_handle;
     uint32_t cpu_id = mcdserver_state.query_cpu_id;
-    GArray* registers = g_list_nth_data(mcdserver_state.all_registers, cpu_id);
+    GArray *registers = g_list_nth_data(mcdserver_state.all_registers, cpu_id);
 
-    // 2. check weather this was the last register
+    /* 2. check weather this was the last register */
     int nb_regs = registers->len;
-    if (query_index+1 == nb_regs) {
-        // indicates this is the last packet
+    if (query_index + 1 == nb_regs) {
+        /* indicates this is the last packet */
         g_string_printf(mcdserver_state.str_buf, "0!");
-    }
-    else {
-        g_string_printf(mcdserver_state.str_buf, "%d!", query_index+1);
+    } else {
+        g_string_printf(mcdserver_state.str_buf, "%d!", query_index + 1);
     }
 
-    // 3. send the correct register
+    /* 3. send the correct register */
     mcd_reg_st my_register = g_array_index(registers, mcd_reg_st, query_index);
-    g_string_append_printf(mcdserver_state.str_buf, "%s=%d.%s=%s.%s=%d.%s=%d.%s=%d.%s=%d.%s=%d.",
-        TCP_ARGUMENT_ID, my_register.id, TCP_ARGUMENT_NAME,  my_register.name, TCP_ARGUMENT_SIZE, my_register.bitsize,
-        TCP_ARGUMENT_REGGROUPID, my_register.mcd_reg_group_id, TCP_ARGUMENT_MEMSPACEID, my_register.mcd_mem_space_id,
-        TCP_ARGUMENT_TYPE, my_register.mcd_reg_type, TCP_ARGUMENT_THREAD, my_register.mcd_hw_thread_id);
+    g_string_append_printf(mcdserver_state.str_buf,
+        "%s=%d.%s=%s.%s=%d.%s=%d.%s=%d.%s=%d.%s=%d.",
+        TCP_ARGUMENT_ID, my_register.id, TCP_ARGUMENT_NAME,
+        my_register.name, TCP_ARGUMENT_SIZE, my_register.bitsize,
+        TCP_ARGUMENT_REGGROUPID, my_register.mcd_reg_group_id,
+        TCP_ARGUMENT_MEMSPACEID, my_register.mcd_mem_space_id,
+        TCP_ARGUMENT_TYPE, my_register.mcd_reg_type,
+        TCP_ARGUMENT_THREAD, my_register.mcd_hw_thread_id);
     mcd_put_strbuf();
 }
 
-void handle_reset(GArray *params, void *user_ctx) {
-    //int reset_id = get_param(params, 0)->data_int;
-    // TODO: implement resets
+void handle_reset(GArray *params, void *user_ctx)
+{
+    /*
+     * int reset_id = get_param(params, 0)->data_int;
+     * TODO: implement resets
+     */
 }
 
-void handle_query_state(GArray *params, void *user_ctx) {
-    // TODO: multicore support
-    // get state info
+void handle_query_state(GArray *params, void *user_ctx)
+{
+    /*
+     * TODO: multicore support
+     * get state info
+     */
     mcd_cpu_state_st state_info = mcdserver_state.cpu_state;
     mcd_core_event_et event = MCD_CORE_EVENT_NONE;
     if (state_info.memory_changed) {
@@ -1674,42 +1805,47 @@ void handle_query_state(GArray *params, void *user_ctx) {
         event = event | MCD_CORE_EVENT_STOPPED;
         state_info.target_was_stopped = false;
     }
-    // send data
-    g_string_printf(mcdserver_state.str_buf, "%s=%s.%s=%d.%s=%d.%s=%d.%s=%s.%s=%s.", TCP_ARGUMENT_STATE, state_info.state,
-        TCP_ARGUMENT_EVENT, event, TCP_ARGUMENT_THREAD, 0, TCP_ARGUMENT_TRIGGER_ID, state_info.trig_id,
-        TCP_ARGUMENT_STOP_STRING, state_info.stop_str, TCP_ARGUMENT_INFO_STRING, state_info.info_str);
+    /* send data */
+    g_string_printf(mcdserver_state.str_buf,
+        "%s=%s.%s=%d.%s=%d.%s=%d.%s=%s.%s=%s.",
+        TCP_ARGUMENT_STATE, state_info.state,
+        TCP_ARGUMENT_EVENT, event, TCP_ARGUMENT_THREAD, 0,
+        TCP_ARGUMENT_TRIGGER_ID, state_info.trig_id,
+        TCP_ARGUMENT_STOP_STRING, state_info.stop_str,
+        TCP_ARGUMENT_INFO_STRING, state_info.info_str);
     mcd_put_strbuf();
 }
 
-int mcd_read_register(CPUState *cpu, GByteArray *buf, int reg) {
+int mcd_read_register(CPUState *cpu, GByteArray *buf, int reg)
+{
     CPUClass *cc = CPU_GET_CLASS(cpu);
     gchar *arch = cc->gdb_arch_name(cpu);
-    if (strcmp(arch, "arm")==0) {
+    if (strcmp(arch, "arm") == 0) {
         g_free(arch);
         return arm_mcd_read_register(cpu, buf, reg);
-    }
-    else {
+    } else {
         g_free(arch);
         return 0;
     }
 }
 
-int mcd_write_register(CPUState *cpu, GByteArray *buf, int reg) {
+int mcd_write_register(CPUState *cpu, GByteArray *buf, int reg)
+{
     CPUClass *cc = CPU_GET_CLASS(cpu);
     gchar *arch = cc->gdb_arch_name(cpu);
-    if (strcmp(arch, "arm")==0) {
+    if (strcmp(arch, "arm") == 0) {
         g_free(arch);
         return arm_mcd_write_register(cpu, buf, reg);
-    }
-    else {
+    } else {
         g_free(arch);
         return 0;
     }
 }
 
-void mcd_memtohex(GString *buf, const uint8_t *mem, int len) {
+void mcd_memtohex(GString *buf, const uint8_t *mem, int len)
+{
     int i, c;
-    for(i = 0; i < len; i++) {
+    for (i = 0; i < len; i++) {
         c = mem[i];
         g_string_append_c(buf, tohex(c >> 4));
         g_string_append_c(buf, tohex(c & 0xf));
@@ -1717,45 +1853,50 @@ void mcd_memtohex(GString *buf, const uint8_t *mem, int len) {
     g_string_append_c(buf, '\0');
 }
 
-void mcd_hextomem(GByteArray *mem, const char *buf, int len) {
+void mcd_hextomem(GByteArray *mem, const char *buf, int len)
+{
     int i;
 
-    for(i = 0; i < len; i++) {
+    for (i = 0; i < len; i++) {
         guint8 byte = fromhex(buf[0]) << 4 | fromhex(buf[1]);
         g_byte_array_append(mem, &byte, 1);
         buf += 2;
     }
 }
 
-void handle_read_register(GArray *params, void *user_ctx) {
+void handle_read_register(GArray *params, void *user_ctx)
+{
     uint32_t cpu_id = get_param(params, 0)->cpu_id;
     uint64_t reg_num = get_param(params, 1)->data_int;
     int reg_size;
 
     CPUState *cpu = mcd_get_cpu(cpu_id);
     reg_size = mcd_read_register(cpu, mcdserver_state.mem_buf, reg_num);
-    mcd_memtohex(mcdserver_state.str_buf, mcdserver_state.mem_buf->data, reg_size);
+    mcd_memtohex(mcdserver_state.str_buf,
+        mcdserver_state.mem_buf->data, reg_size);
     mcd_put_strbuf();
 }
 
-void handle_write_register(GArray *params, void *user_ctx) {
+void handle_write_register(GArray *params, void *user_ctx)
+{
     uint32_t cpu_id = get_param(params, 0)->cpu_id;
     uint64_t reg_num = get_param(params, 1)->data_int;
     uint32_t reg_size = get_param(params, 2)->data_int;
 
     CPUState *cpu = mcd_get_cpu(cpu_id);
-    mcd_hextomem(mcdserver_state.mem_buf, mcdserver_state.str_buf->str, reg_size);
-    if (mcd_write_register(cpu, mcdserver_state.mem_buf, reg_num)==0) {
+    mcd_hextomem(mcdserver_state.mem_buf,
+        mcdserver_state.str_buf->str, reg_size);
+    if (mcd_write_register(cpu, mcdserver_state.mem_buf, reg_num) == 0) {
         mcd_put_packet(TCP_EXECUTION_ERROR);
-    }
-    else {
+    } else {
         mcd_put_packet(TCP_EXECUTION_SUCCESS);
     }
 }
 
-int mcd_read_memory(CPUState *cpu, hwaddr addr, uint8_t *buf, int len) {
+int mcd_read_memory(CPUState *cpu, hwaddr addr, uint8_t *buf, int len)
+{
     CPUClass *cc;
-    //TODO: add physical mem cpu_physical_memory_read(addr, buf, len);
+    /*TODO: add physical mem cpu_physical_memory_read(addr, buf, len); */
     cc = CPU_GET_CLASS(cpu);
     if (cc->memory_rw_debug) {
         return cc->memory_rw_debug(cpu, addr, buf, len, false);
@@ -1764,9 +1905,10 @@ int mcd_read_memory(CPUState *cpu, hwaddr addr, uint8_t *buf, int len) {
     return cpu_memory_rw_debug(cpu, addr, buf, len, false);
 }
 
-int mcd_write_memory(CPUState *cpu, hwaddr addr, uint8_t *buf, int len) {
+int mcd_write_memory(CPUState *cpu, hwaddr addr, uint8_t *buf, int len)
+{
     CPUClass *cc;
-    //TODO: add physical mem cpu_physical_memory_read(addr, buf, len);
+    /*TODO: add physical mem cpu_physical_memory_read(addr, buf, len); */
     cc = CPU_GET_CLASS(cpu);
     if (cc->memory_rw_debug) {
         return cc->memory_rw_debug(cpu, addr, buf, len, true);
@@ -1775,33 +1917,36 @@ int mcd_write_memory(CPUState *cpu, hwaddr addr, uint8_t *buf, int len) {
     return cpu_memory_rw_debug(cpu, addr, buf, len, true);
 }
 
-void handle_read_memory(GArray *params, void *user_ctx) {
+void handle_read_memory(GArray *params, void *user_ctx)
+{
     uint32_t cpu_id = get_param(params, 0)->cpu_id;
     uint64_t mem_address = get_param(params, 1)->data_uint64_t;
     int len = get_param(params, 2)->data_int;
 
     CPUState *cpu = mcd_get_cpu(cpu_id);
     g_byte_array_set_size(mcdserver_state.mem_buf, len);
-    if (mcd_read_memory(cpu, mem_address, mcdserver_state.mem_buf->data, mcdserver_state.mem_buf->len)!=0) {
+    if (mcd_read_memory(cpu, mem_address, mcdserver_state.mem_buf->data,
+        mcdserver_state.mem_buf->len) != 0) {
         mcd_put_packet(TCP_EXECUTION_ERROR);
-    }
-    else {
-        mcd_memtohex(mcdserver_state.str_buf, mcdserver_state.mem_buf->data, mcdserver_state.mem_buf->len);
+    } else {
+        mcd_memtohex(mcdserver_state.str_buf, mcdserver_state.mem_buf->data,
+            mcdserver_state.mem_buf->len);
         mcd_put_strbuf();
     }
 }
 
-void handle_write_memory(GArray *params, void *user_ctx) {
+void handle_write_memory(GArray *params, void *user_ctx)
+{
     uint32_t cpu_id = get_param(params, 0)->cpu_id;
     uint64_t mem_address = get_param(params, 1)->data_uint64_t;
     int len = get_param(params, 2)->data_int;
 
     CPUState *cpu = mcd_get_cpu(cpu_id);
     mcd_hextomem(mcdserver_state.mem_buf, mcdserver_state.str_buf->str, len);
-    if (mcd_write_memory(cpu, mem_address, mcdserver_state.mem_buf->data, len)!=0) {
+    if (mcd_write_memory(cpu, mem_address,
+        mcdserver_state.mem_buf->data, len) != 0) {
         mcd_put_packet(TCP_EXECUTION_ERROR);
-    }
-    else {
+    } else {
         mcd_put_packet(TCP_EXECUTION_SUCCESS);
     }
 }
diff --git a/mcdstub/internals.h b/mcdstub/mcdstub.h
similarity index 69%
rename from mcdstub/internals.h
rename to mcdstub/mcdstub.h
index 0afab434ce..83156dceb8 100644
--- a/mcdstub/internals.h
+++ b/mcdstub/mcdstub.h
@@ -4,49 +4,46 @@
 #include "exec/cpu-common.h"
 #include "chardev/char.h"
 #include "hw/core/cpu.h"
-// just used for the register xml files
+/* just used for the register xml files */
 #include "exec/gdbstub.h"
 
 #define MAX_PACKET_LENGTH 1024
 
-// trigger defines
+/* trigger defines */
 #define MCD_TRIG_OPT_DATA_IS_CONDITION 0x00000008
 #define MCD_TRIG_ACTION_DBG_DEBUG 0x00000001
 
 typedef uint32_t mcd_trig_type_et;
-// TODO: replace mcd defines with custom layer
+/* TODO: replace mcd defines with custom layer */
 enum {
-	MCD_TRIG_TYPE_UNDEFINED = 0x00000000, /**< Undefined trigger type.                                                   */
-	MCD_TRIG_TYPE_IP        = 0x00000001, /**< Trigger on a changing instruction pointer.                                */
-	MCD_TRIG_TYPE_READ      = 0x00000002, /**< Trigger on a read data access to a specific address or address range.     */
-	MCD_TRIG_TYPE_WRITE     = 0x00000004, /**< Trigger on a write data access to a specific address or address range.    */
-	MCD_TRIG_TYPE_RW        = 0x00000008, /**< Trigger on a read or a write data access to a specific address or
-		   address range.                                                            */
-	MCD_TRIG_TYPE_NOCYCLE   = 0x00000010, /**< Trigger on core information other than an IP or data compare trigger.     */
-	MCD_TRIG_TYPE_TRIG_BUS  = 0x00000020, /**< Trigger on a trigger bus combination.                                     */
-	MCD_TRIG_TYPE_COUNTER   = 0x00000040, /**< Trigger on an elapsed trigger counter.                                    */
-	MCD_TRIG_TYPE_CUSTOM    = 0x00000080, /**< Custom trigger using standard format as defined by \ref mcd_trig_custom_st. */
-	MCD_TRIG_TYPE_CUSTOM_LO = 0x00010000, /**< Begin Range: User defined trigger types.                                  */
-	MCD_TRIG_TYPE_CUSTOM_HI = 0x40000000, /**< End   Range: User defined trigger types.                                  */
+    MCD_TRIG_TYPE_UNDEFINED = 0x00000000,
+    MCD_TRIG_TYPE_IP        = 0x00000001,
+    MCD_TRIG_TYPE_READ      = 0x00000002,
+    MCD_TRIG_TYPE_WRITE     = 0x00000004,
+    MCD_TRIG_TYPE_RW        = 0x00000008,
+    MCD_TRIG_TYPE_NOCYCLE   = 0x00000010,
+    MCD_TRIG_TYPE_TRIG_BUS  = 0x00000020,
+    MCD_TRIG_TYPE_COUNTER   = 0x00000040,
+    MCD_TRIG_TYPE_CUSTOM    = 0x00000080,
+    MCD_TRIG_TYPE_CUSTOM_LO = 0x00010000,
+    MCD_TRIG_TYPE_CUSTOM_HI = 0x40000000,
 };
 
 typedef uint32_t mcd_core_event_et;
-// TODO: replace mcd defines with custom layer
+/* TODO: replace mcd defines with custom layer */
 enum {
-	MCD_CORE_EVENT_NONE            = 0x00000000,   /**< No since the last poll.                                 */
-	MCD_CORE_EVENT_MEMORY_CHANGE   = 0x00000001,   /**< Memory content has changed.                             */
-	MCD_CORE_EVENT_REGISTER_CHANGE = 0x00000002,   /**< Register contents have changed.                         */
-	MCD_CORE_EVENT_TRACE_CHANGE    = 0x00000004,   /**< Trace contents or states have changed.                  */
-	MCD_CORE_EVENT_TRIGGER_CHANGE  = 0x00000008,   /**< Triggers or trigger states have changed.                */
-	MCD_CORE_EVENT_STOPPED         = 0x00000010,   /**< Target was stopped at least once since the last poll,
-		it may already be running again.                        */
-	MCD_CORE_EVENT_CHL_PENDING     = 0x00000020,   /**< A target communication channel request from the target
-		is pending.                                             */
-	MCD_CORE_EVENT_CUSTOM_LO       = 0x00010000,   /**< Begin Range: User defined core events.                  */
-	MCD_CORE_EVENT_CUSTOM_HI       = 0x40000000,   /**< End   Range: User defined core events.                  */
+    MCD_CORE_EVENT_NONE            = 0x00000000,
+    MCD_CORE_EVENT_MEMORY_CHANGE   = 0x00000001,
+    MCD_CORE_EVENT_REGISTER_CHANGE = 0x00000002,
+    MCD_CORE_EVENT_TRACE_CHANGE    = 0x00000004,
+    MCD_CORE_EVENT_TRIGGER_CHANGE  = 0x00000008,
+    MCD_CORE_EVENT_STOPPED         = 0x00000010,
+    MCD_CORE_EVENT_CHL_PENDING     = 0x00000020,
+    MCD_CORE_EVENT_CUSTOM_LO       = 0x00010000,
+    MCD_CORE_EVENT_CUSTOM_HI       = 0x40000000,
 };
 
-// schema defines
+/* schema defines */
 #define ARG_SCHEMA_QRYHANDLE 'q'
 #define ARG_SCHEMA_STRING 's'
 #define ARG_SCHEMA_INT 'd'
@@ -54,20 +51,20 @@ enum {
 #define ARG_SCHEMA_CORENUM 'c'
 #define ARG_SCHEMA_HEXDATA 'h'
 
-// resets
+/* resets */
 #define RESET_SYSTEM "full_system_reset"
 #define RESET_GPR "gpr_reset"
 #define RESET_MEMORY "memory_reset"
 
-// misc
-#define QUERY_TOTAL_NUMBER 12 
+/* misc */
+#define QUERY_TOTAL_NUMBER 12
 #define CMD_SCHEMA_LENGTH 5
 #define MCD_SYSTEM_NAME "qemu-system"
 
-// tcp query packet values templates
+/* tcp query packet values templates */
 #define DEVICE_NAME_TEMPLATE(s) "qemu-" #s "-device"
 
-// state strings
+/* state strings */
 #define STATE_STR_UNKNOWN(d) "cpu " #d " in unknown state"
 #define STATE_STR_DEBUG(d) "cpu " #d " in debug state"
 #define STATE_STR_RUNNING(d) "cpu " #d " running"
@@ -82,7 +79,7 @@ enum {
 #define STATE_STR_BREAK_UNKNOWN "stopped for unknown reason"
 
 typedef struct GDBRegisterState {
-    // needed for the used gdb functions
+    /* needed for the used gdb functions */
     int base_reg;
     int num_regs;
     gdb_get_reg_cb get_reg;
@@ -193,22 +190,22 @@ typedef struct xml_attrib {
 } xml_attrib;
 
 typedef struct mcd_reg_st {
-    // xml info
+    /* xml info */
     char name[64];
     char group[64];
     char type[64];
     uint32_t bitsize;
     uint32_t id;
-    // mcd metadata
+    /* mcd metadata */
     uint32_t mcd_reg_group_id;
     uint32_t mcd_mem_space_id;
     uint32_t mcd_reg_type;
     uint32_t mcd_hw_thread_id;
-    // data for op-code
+    /* data for op-code */
     uint8_t cp;
     uint8_t crn;
     uint8_t crm;
-    uint8_t opc0; // <- might not be needed!
+    uint8_t opc0; /* <- might not be needed! */
     uint8_t opc1;
     uint8_t opc2;
 } mcd_reg_st;
@@ -245,9 +242,9 @@ void mcd_sigterm_handler(int signal);
 #endif
 
 void mcd_init_mcdserver_state(void);
-void init_query_cmds_table(MCDCmdParseEntry* mcd_query_cmds_table);
-int init_resets(GArray* resets);
-int init_trigger(mcd_trigger_st* trigger);
+void init_query_cmds_table(MCDCmdParseEntry *mcd_query_cmds_table);
+int init_resets(GArray *resets);
+int init_trigger(mcd_trigger_st *trigger);
 void reset_mcdserver_state(void);
 void create_processes(MCDState *s);
 void mcd_create_default_process(MCDState *s);
@@ -272,14 +269,15 @@ int mcd_handle_packet(const char *line_buf);
 void mcd_put_strbuf(void);
 void mcd_exit(int code);
 void run_cmd_parser(const char *data, const MCDCmdParseEntry *cmd);
-int process_string_cmd(void *user_ctx, const char *data, const MCDCmdParseEntry *cmds, int num_cmds);
+int process_string_cmd(void *user_ctx, const char *data,
+    const MCDCmdParseEntry *cmds, int num_cmds);
 int cmd_parse_params(const char *data, const char *schema, GArray *params);
 void handle_vm_start(GArray *params, void *user_ctx);
 void handle_vm_step(GArray *params, void *user_ctx);
 void handle_vm_stop(GArray *params, void *user_ctx);
 void handle_gen_query(GArray *params, void *user_ctx);
 int mcd_get_cpu_index(CPUState *cpu);
-CPUState* mcd_get_cpu(uint32_t i_cpu_index);
+CPUState *mcd_get_cpu(uint32_t i_cpu_index);
 void handle_query_cores(GArray *params, void *user_ctx);
 void handle_query_system(GArray *params, void *user_ctx);
 CPUState *get_first_cpu_in_process(MCDProcess *process);
@@ -312,20 +310,22 @@ int mcd_write_register(CPUState *cpu, GByteArray *buf, int reg);
 int mcd_read_memory(CPUState *cpu, hwaddr addr, uint8_t *buf, int len);
 int mcd_write_memory(CPUState *cpu, hwaddr addr, uint8_t *buf, int len);
 
-// arm specific functions
-int mcd_arm_store_mem_spaces(CPUState *cpu, GArray* memspaces);
-int mcd_arm_parse_core_xml_file(CPUClass *cc, GArray* reggroups, GArray* registers, int* current_group_id);
-int mcd_arm_parse_general_xml_files(CPUState *cpu, GArray* reggroups, GArray* registers, int* current_group_id);
-int mcd_arm_get_additional_register_info(GArray* reggroups, GArray* registers);
+/* arm specific functions */
+int mcd_arm_store_mem_spaces(CPUState *cpu, GArray *memspaces);
+int mcd_arm_parse_core_xml_file(CPUClass *cc, GArray *reggroups,
+    GArray *registers, int *current_group_id);
+int mcd_arm_parse_general_xml_files(CPUState *cpu, GArray* reggroups,
+    GArray *registers, int *current_group_id);
+int mcd_arm_get_additional_register_info(GArray *reggroups, GArray *registers);
 
-// sycall handling
+/* sycall handling */
 void mcd_syscall_reset(void);
 void mcd_disable_syscalls(void);
 
-// helpers
+/* helpers */
 int int_cmp(gconstpointer a, gconstpointer b);
 void mcd_memtohex(GString *buf, const uint8_t *mem, int len);
 void mcd_hextomem(GByteArray *mem, const char *buf, int len);
-uint64_t atouint64_t(const char* in);
+uint64_t atouint64_t(const char *in);
 
 #endif /* MCDSTUB_INTERNALS_H */
diff --git a/mcdstub/meson.build b/mcdstub/meson.build
index f17e2f3e89..ebd47b0725 100644
--- a/mcdstub/meson.build
+++ b/mcdstub/meson.build
@@ -7,19 +7,21 @@
 # We need to build the core mcd code via a library to be able to tweak
 # cflags so:
 
-mcd_softmmu_ss = ss.source_set()
+mcd_system_ss = ss.source_set()
 
-# We build one version of the mcdstub, because it only needs to work for system emulation
-mcd_softmmu_ss.add(files('mcdstub.c'))
+# We build one version of the mcdstub,
+#because it only needs to work for system emulation
+mcd_system_ss.add(files('mcdstub.c'))
 
-mcd_softmmu_ss = mcd_softmmu_ss.apply(config_host, strict: false)
+mcd_system_ss = mcd_system_ss.apply(config_host, strict: false)
 
 libmcd_softmmu = static_library('mcd_softmmu',
-                                mcd_softmmu_ss.sources() + genh,
-                                name_suffix: 'fa')
+                                mcd_system_ss.sources() + genh,
+                                name_suffix: 'fa',
+                                build_by_default: have_system)
 
 mcd_softmmu = declare_dependency(link_whole: libmcd_softmmu)
-softmmu_ss.add(mcd_softmmu)
+system_ss.add(mcd_softmmu)
 
 # this might cause problems because we don't support user mode
 common_ss.add(files('mcd_syscalls.c'))
diff --git a/softmmu/cpus.c b/softmmu/cpus.c
index 6a1c969f3b..0848e0dbdb 100644
--- a/softmmu/cpus.c
+++ b/softmmu/cpus.c
@@ -306,7 +306,7 @@ void cpu_handle_guest_debug(CPUState *cpu)
             cpu_single_step(cpu, 0);
         }
     } else {
-        //gdb_set_stop_cpu(cpu);
+        gdb_set_stop_cpu(cpu);
         qemu_system_debug_request();
         cpu->stopped = true;
     }
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 2d66f612a7..085a312f9d 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -2663,9 +2663,9 @@ static void qemu_machine_creation_done(void)
     if (foreach_device_config(DEV_GDB, gdbserver_start) < 0) {
         exit(1);
     }
-    
+
     if (foreach_device_config(DEV_MCD, mcdserver_start) < 0) {
-        /* 
+        /*
          * starts the mcdserver if the mcd option was set
          */
         exit(1);
diff --git a/target/arm/mcdstub.c b/target/arm/mcdstub.c
index 27e1a13b69..e4e632d3f3 100644
--- a/target/arm/mcdstub.c
+++ b/target/arm/mcdstub.c
@@ -8,8 +8,10 @@
 
 static inline int mcd_get_reg32(GByteArray *buf, uint32_t val)
 {
-    //TODO: move this to a separate file
-    // convert endianess if necessary
+    /*
+     *TODO: move this to a separate file
+     *convert endianess if necessary
+     */
     uint32_t to_long = tswap32(val);
     g_byte_array_append(buf, (uint8_t *) &to_long, 4);
     return 4;
@@ -17,7 +19,7 @@ static inline int mcd_get_reg32(GByteArray *buf, uint32_t val)
 
 static inline int mcd_get_zeroes(GByteArray *array, size_t len)
 {
-    //TODO: move this to a separate file
+    /*TODO: move this to a separate file */
     guint oldlen = array->len;
     g_byte_array_set_size(array, oldlen + len);
     memset(array->data + oldlen, 0, len);
@@ -43,7 +45,8 @@ const char *arm_mcd_get_dynamic_xml(CPUState *cs, const char *xmlname)
     return NULL;
 }
 
-int arm_mcd_read_register(CPUState *cs, GByteArray *mem_buf, int n) {
+int arm_mcd_read_register(CPUState *cs, GByteArray *mem_buf, int n)
+{
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
 
@@ -52,12 +55,12 @@ int arm_mcd_read_register(CPUState *cs, GByteArray *mem_buf, int n) {
         return mcd_get_reg32(mem_buf, env->regs[n]);
     }
     if (n < 24) {
-        // TODO: these numbers don't match mine
+        /* TODO: these numbers don't match mine */
         return mcd_get_zeroes(mem_buf, 12);
     }
     switch (n) {
     case 24:
-        // TODO: these numbers don't match mine
+        /* TODO: these numbers don't match mine */
         return mcd_get_reg32(mem_buf, 0);
     case 25:
         /* CPSR, or XPSR for M-profile */
@@ -67,17 +70,18 @@ int arm_mcd_read_register(CPUState *cs, GByteArray *mem_buf, int n) {
             return mcd_get_reg32(mem_buf, cpsr_read(env));
         }
     }
-    //TODO: add funcitons for the remaining regs (including cp_regs)
+    /* TODO: add funcitons for the remaining regs (including cp_regs) */
     return 0;
 }
 
-int arm_mcd_write_register(CPUState *cs, GByteArray *mem_buf, int n) {
+int arm_mcd_write_register(CPUState *cs, GByteArray *mem_buf, int n)
+{
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
     uint32_t tmp;
 
     tmp = ldl_p(mem_buf);
-    tmp = *((uint32_t*)mem_buf->data);
+    tmp = *((uint32_t *)mem_buf->data);
 
     /*
      * Mask out low bits of PC to workaround gdb bugs.
@@ -122,6 +126,6 @@ int arm_mcd_write_register(CPUState *cs, GByteArray *mem_buf, int n) {
         }
         return 4;
     }
-    //TODO: add funcitons for the remaining regs (including cp_regs)
+    /* TODO: add funcitons for the remaining regs (including cp_regs) */
     return 0;
 }
-- 
2.34.1


