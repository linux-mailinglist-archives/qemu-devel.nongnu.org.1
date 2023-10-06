Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A4C7BB3DC
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 11:08:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qogmx-00081I-SM; Fri, 06 Oct 2023 05:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qogmp-0007zK-R8
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:06:19 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qogmm-0000sa-4w
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:06:19 -0400
Received: (qmail 19382 invoked by uid 484); 6 Oct 2023 09:06:14 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.074411 secs); 06 Oct 2023 09:06:14 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP for <qemu-devel@nongnu.org>; 6 Oct 2023 09:06:13 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Christian.Boenig@lauterbach.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicolas Eder <nicolas.eder@lauterbach.com>
Subject: [PATCH v2 02/29] TCP chardev added, handshake with TRACE32 working
Date: Fri,  6 Oct 2023 11:05:43 +0200
Message-Id: <20231006090610.26171-3-nicolas.eder@lauterbach.com>
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
 gdbstub/gdbstub.c          |   2 +-
 include/exec/mcdstub.h     |  21 +-
 include/mcdstub/syscalls.h |   6 +
 mcdstub/internals.h        | 135 ++++++++++
 mcdstub/mcd_softmmu.c      | 218 +++++++++++-----
 mcdstub/mcd_syscalls.c     |  20 ++
 mcdstub/mcd_tcp_server.c   |   2 +-
 mcdstub/mcdstub.c          | 519 +++++++++++++++++++++++++++++++++++++
 mcdstub/meson.build        |  25 ++
 meson.build                |   1 +
 qemu-options.hx            |  25 ++
 softmmu/vl.c               |   9 +
 12 files changed, 901 insertions(+), 82 deletions(-)
 create mode 100644 include/mcdstub/syscalls.h
 create mode 100644 mcdstub/internals.h
 create mode 100644 mcdstub/meson.build

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 349d348c7b..2ff50757bb 100644
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
index 8afbc09367..abf7beb634 100644
--- a/include/exec/mcdstub.h
+++ b/include/exec/mcdstub.h
@@ -1,7 +1,10 @@
 #ifndef MCDSTUB_H
 #define MCDSTUB_H
 
-#define DEFAULT_MCDSTUB_PORT "1234"
+#define DEFAULT_MCDSTUB_PORT "1235"
+#define TYPE_CHARDEV_MCD "chardev-mcd"
+#define MX_INPUT_LENGTH 9
+#define MCD_TCP_DATALEN 80
 
 /* MCD breakpoint/watchpoint types */
 #define MCD_BREAKPOINT_SW        0
@@ -10,22 +13,12 @@
 #define MCD_WATCHPOINT_READ      3
 #define MCD_WATCHPOINT_ACCESS    4
 
-
-/* Get or set a register.  Returns the size of the register.  */
-typedef int (*gdb_get_reg_cb)(CPUArchState *env, GByteArray *buf, int reg);
-typedef int (*gdb_set_reg_cb)(CPUArchState *env, uint8_t *buf, int reg);
-void gdb_register_coprocessor(CPUState *cpu,
-                              gdb_get_reg_cb get_reg, gdb_set_reg_cb set_reg,
-                              int num_regs, const char *xml, int g_pos);
-
 /**
- * mcdserver_start: start the mcd server
- * @port_or_device: connection spec for mcd
+ * mcd_tcp_server_start: start the tcp server to connect via mcd
+ * @device: connection spec for mcd
  *
  * This is a TCP port
  */
-int mcdserver_start(const char *port_or_device);
-
-void gdb_set_stop_cpu(CPUState *cpu);
+int mcdserver_start(const char *device);
 
 #endif
diff --git a/include/mcdstub/syscalls.h b/include/mcdstub/syscalls.h
new file mode 100644
index 0000000000..1f86634140
--- /dev/null
+++ b/include/mcdstub/syscalls.h
@@ -0,0 +1,6 @@
+#ifndef _SYSCALLS_H_
+#define _SYSCALLS_H_
+
+typedef void (*gdb_syscall_complete_cb)(CPUState *cpu, uint64_t ret, int err);
+
+#endif /* _SYSCALLS_H_ */
\ No newline at end of file
diff --git a/mcdstub/internals.h b/mcdstub/internals.h
new file mode 100644
index 0000000000..7b0f4b0b36
--- /dev/null
+++ b/mcdstub/internals.h
@@ -0,0 +1,135 @@
+/*
+ * this header includes a lookup table for the transmitted messages over the tcp connection to trace32,
+ * as well as function declarations for all functios used inside the mcdstub
+ */
+
+#ifndef MCDSTUB_INTERNALS_H
+#define MCDSTUB_INTERNALS_H
+
+#include "exec/cpu-common.h"
+#include "chardev/char.h"
+
+#define MAX_PACKET_LENGTH 1024
+
+/*
+ * lookuptable for transmitted signals
+ */
+
+enum {
+    MCD_SIGNAL_HANDSHAKE = 0
+};
+
+
+/*
+ * struct for an MCD Process, each process can establish one connection
+ */
+
+typedef struct MCDProcess {
+    uint32_t pid;
+    bool attached;
+
+    char target_xml[1024];
+} MCDProcess;
+
+
+/*
+ * not sure for what this is used exactly
+ */
+
+
+enum RSState {
+    RS_INACTIVE,
+    RS_IDLE,
+    RS_GETLINE,
+    RS_GETLINE_ESC,
+    RS_GETLINE_RLE,
+    RS_CHKSUM1,
+    RS_CHKSUM2,
+};
+
+typedef struct MCDState {
+    bool init;       /* have we been initialised? */
+    CPUState *c_cpu; /* current CPU for step/continue ops */
+    CPUState *g_cpu; /* current CPU for other ops */
+    CPUState *query_cpu; /* for q{f|s}ThreadInfo */
+    enum RSState state; /* parsing state */
+    char line_buf[MAX_PACKET_LENGTH];
+    int line_buf_index;
+    int line_sum; /* running checksum */
+    int line_csum; /* checksum at the end of the packet */
+    GByteArray *last_packet;
+    int signal;
+    bool multiprocess;
+    MCDProcess *processes;
+    int process_num;
+    GString *str_buf;
+    GByteArray *mem_buf;
+    int sstep_flags;
+    int supported_sstep_flags;
+} MCDState;
+
+/* lives in main mcdstub.c */
+extern MCDState mcdserver_state;
+
+
+// Inline utility function, convert from int to hex and back
+
+
+static inline int fromhex(int v)
+{
+    if (v >= '0' && v <= '9') {
+        return v - '0';
+    } else if (v >= 'A' && v <= 'F') {
+        return v - 'A' + 10;
+    } else if (v >= 'a' && v <= 'f') {
+        return v - 'a' + 10;
+    } else {
+        return 0;
+    }
+}
+
+static inline int tohex(int v)
+{
+    if (v < 10) {
+        return v + '0';
+    } else {
+        return v - 10 + 'a';
+    }
+}
+
+
+/*old functions
+void mcd_init_mcdserver_state(void);
+int mcd_open_tcp_socket(int tcp_port);
+int mcd_extract_tcp_port_num(const char *in_string, char *out_string);
+*/
+#ifndef _WIN32
+void mcd_sigterm_handler(int signal);
+#endif
+
+void mcd_init_mcdserver_state(void);
+void reset_mcdserver_state(void);
+void create_processes(MCDState *s);
+void mcd_create_default_process(MCDState *s);
+int find_cpu_clusters(Object *child, void *opaque);
+int pid_order(const void *a, const void *b);
+int mcd_chr_can_receive(void *opaque);
+void mcd_chr_receive(void *opaque, const uint8_t *buf, int size);
+void mcd_chr_event(void *opaque, QEMUChrEvent event);
+bool mcd_supports_guest_debug(void);
+void mcd_vm_state_change(void *opaque, bool running, RunState state);
+int mcd_put_packet(const char *buf);
+int mcd_put_packet_binary(const char *buf, int len, bool dump);
+bool mcd_got_immediate_ack(void);
+void mcd_put_buffer(const uint8_t *buf, int len);
+void mcd_set_stop_cpu(CPUState *cpu);
+MCDProcess *mcd_get_cpu_process(CPUState *cpu);
+uint32_t mcd_get_cpu_pid(CPUState *cpu);
+MCDProcess *mcd_get_process(uint32_t pid);
+CPUState *mcd_first_attached_cpu(void);
+CPUState *mcd_next_attached_cpu(CPUState *cpu);
+
+/* sycall handling */
+void mcd_syscall_reset(void);
+
+#endif /* MCDSTUB_INTERNALS_H */
diff --git a/mcdstub/mcd_softmmu.c b/mcdstub/mcd_softmmu.c
index 17e1d3ca1b..52dcb182b2 100644
--- a/mcdstub/mcd_softmmu.c
+++ b/mcdstub/mcd_softmmu.c
@@ -1,85 +1,171 @@
 /*
- * this handeles all system emulation functions for the mcdstub
- */
+#if defined(WIN32)
+#ifndef _WIN32_WINNT
+#define _WIN32_WINNT 0x0600
+#endif
+#include <winsock2.h>
+#include <ws2tcpip.h>
+//#pragma comment(lib, "Ws2_32.lib")
+#define ISVALIDSOCKET(s) ((s) != INVALID_SOCKET)
+#define CLOSESOCKET(s) closesocket(s)
+#define GETSOCKETERRNO() (WSAGetLastError())
+#else
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+#include <arpa/inet.h>
+#include <netdb.h>
+#include <unistd.h>
+//#include <errno.h>
+#define SOCKET int
+#define ISVALIDSOCKET(s) ((s) >= 0)
+#define CLOSESOCKET(s) close(s)
+#define GETSOCKETERRNO() (errno)
+#endif
 
-#include "exec/mcdstub.h"
+#define SA struct sockaddr
 
-int mcdserver_start(const char *device)
-{
-    trace_gdbstub_op_start(device);
 
-    char gdbstub_device_name[128];
-    Chardev *chr = NULL;
-    Chardev *mon_chr;
 
-    if (!first_cpu) {
-        error_report("gdbstub: meaningless to attach gdb to a "
-                     "machine without any CPU.");
-        return -1;
-    }
+#include "exec/mcdstub.h"
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qemu/cutils.h"
+#include "gdbstub/syscalls.h"
+#include "exec/hwaddr.h"
+#include "exec/tb-flush.h"
+#include "sysemu/cpus.h"
+#include "sysemu/runstate.h"
+#include "sysemu/replay.h"
+#include "hw/core/cpu.h"
+#include "hw/cpu/cluster.h"
+#include "hw/boards.h"
+#include "chardev/char.h"
+#include "chardev/char-fe.h"
+#include "monitor/monitor.h"
+#include "internals.h"
 
-    if (!gdb_supports_guest_debug()) {
-        error_report("gdbstub: current accelerator doesn't "
-                     "support guest debugging");
-        return -1;
-    }
+//here only deprecated code:
 
-    if (!device) {
+int old_mcdserver_start(const char *device)
+{
+    //the device is a char array. if its "default" we use tcp with the default DEFAULT_MCDSTUB_PORT. Otherwise it has to look like "tcp::<tcpport>"
+    char tcp_port[MX_INPUT_LENGTH];
+    int error;
+    error = mcd_extract_tcp_port_num(device, tcp_port);
+    if (error != 0) {
         return -1;
     }
-    if (strcmp(device, "none") != 0) {
-        if (strstart(device, "tcp:", NULL)) {
-            /* enforce required TCP attributes */
-            snprintf(gdbstub_device_name, sizeof(gdbstub_device_name),
-                     "%s,wait=off,nodelay=on,server=on", device);
-            device = gdbstub_device_name;
-        }
-#ifndef _WIN32
-        else if (strcmp(device, "stdio") == 0) {
-            struct sigaction act;
-
-            memset(&act, 0, sizeof(act));
-            act.sa_handler = gdb_sigterm_handler;
-            sigaction(SIGINT, &act, NULL);
-        }
-#endif
-        /*
-         * FIXME: it's a bit weird to allow using a mux chardev here
-         * and implicitly setup a monitor. We may want to break this.
-         */
-        chr = qemu_chr_new_noreplay("gdb", device, true, NULL);
-        if (!chr) {
-            return -1;
-        }
+    int tcp_port_num = atoi(tcp_port);
+        
+    if (!mcdserver_state.init) {
+        mcd_init_mcdserver_state();
     }
+    return mcd_open_tcp_socket(tcp_port_num);
+}
+
+int mcd_open_tcp_socket(int tcp_port)
+//soon to be deprecated (hopefully)
+{
+    SOCKET socked_fd, connect_fd;
+	struct sockaddr_in server_address, client_address;
+
+#if defined(WIN32)
+	WSADATA d;
+	if (WSAStartup(MAKEWORD(2, 2), &d)) {
+    	return -1;
+	}
+	int len;
+#else
+	unsigned int len;
+#endif
 
-    if (!gdbserver_state.init) {
-        gdb_init_gdbserver_state();
+	// socket create and verification
+	socked_fd = socket(AF_INET, SOCK_STREAM, 0);
+	if (!ISVALIDSOCKET(socked_fd)) {
+		return -1;
+	}
+	memset(&server_address, 0, sizeof(server_address));
 
-        qemu_add_vm_change_state_handler(gdb_vm_state_change, NULL);
+	// assign IP, PORT
+	server_address.sin_family = AF_INET;
+	server_address.sin_port = htons(tcp_port);
+	server_address.sin_addr.s_addr = htonl(INADDR_ANY);
 
-        /* Initialize a monitor terminal for gdb */
-        mon_chr = qemu_chardev_new(NULL, TYPE_CHARDEV_GDB,
-                                   NULL, NULL, &error_abort);
-        monitor_init_hmp(mon_chr, false, &error_abort);
-    } else {
-        qemu_chr_fe_deinit(&gdbserver_system_state.chr, true);
-        mon_chr = gdbserver_system_state.mon_chr;
-        reset_gdbserver_state();
+	// Binding newly created socket to given IP and verification
+	if ((bind(socked_fd, (SA*)&server_address, sizeof(server_address))) != 0) {
+		CLOSESOCKET(socked_fd);
+		return -1;
+	}
+
+	// Now server is ready to listen and verification
+	if ((listen(socked_fd, 5)) != 0) {
+		CLOSESOCKET(socked_fd);
+		return -1;
+	}
+	else {
+		printf("TCP server listening on port %d\n", tcp_port);
+	}
+
+	//accepting connection
+	len = sizeof(client_address);
+	connect_fd = accept(socked_fd, (SA*)&client_address, &len);
+    if (!ISVALIDSOCKET(connect_fd)) {
+		CLOSESOCKET(socked_fd);
+        return -1;
     }
 
-    create_processes(&gdbserver_state);
+	//lets do the handshake
+
+	char buff[MCD_TCP_DATALEN];
+	char expected_buff[MCD_TCP_DATALEN];
 
-    if (chr) {
-        qemu_chr_fe_init(&gdbserver_system_state.chr, chr, &error_abort);
-        qemu_chr_fe_set_handlers(&gdbserver_system_state.chr,
-                                 gdb_chr_can_receive,
-                                 gdb_chr_receive, gdb_chr_event,
-                                 NULL, &gdbserver_state, NULL, true);
+	memset(buff, 0, sizeof(buff));
+	memset(expected_buff, 0, sizeof(buff));
+	strcpy((char*)expected_buff, "initializing handshake");
+
+    // read the message from client
+    recv(connect_fd, buff, MCD_TCP_DATALEN, 0);
+	
+	if (strcmp(buff, expected_buff)==0) {
+		strcpy((char*)buff, "shaking your hand");
+		send(connect_fd, buff, MCD_TCP_DATALEN, 0);
+		printf("handshake complete\n");
+		return 0;
+	}
+	else {
+		CLOSESOCKET(socked_fd);
+		CLOSESOCKET(connect_fd);
+		return -1;
+	}
+}
+
+int mcd_extract_tcp_port_num(const char *in_string, char *out_string)
+{
+    int string_length = strlen(in_string);
+    if (string_length>MX_INPUT_LENGTH+1) {
+        return -1;
     }
-    gdbserver_state.state = chr ? RS_IDLE : RS_INACTIVE;
-    gdbserver_system_state.mon_chr = mon_chr;
-    gdb_syscall_reset();
 
+    const char default_str[] = "default";
+
+    if ((string_length==strlen(default_str)) && (strcmp(default_str, in_string)==0)) {
+        strcpy((char*)out_string, DEFAULT_MCDSTUB_PORT);
+        return 0;
+    }
+    else if (strcmp("tcp::", in_string)==0) {
+            for (int index = 5; index < string_length; index++) {
+                if (!isdigit(in_string[index])) {
+                    return -1;
+                }
+            }
+    }
+    else {
+        return -1;
+    }
+    strcpy((char*)out_string, in_string+5);
     return 0;
-}
\ No newline at end of file
+}
+
+*/
\ No newline at end of file
diff --git a/mcdstub/mcd_syscalls.c b/mcdstub/mcd_syscalls.c
index e69de29bb2..663ffde1b6 100644
--- a/mcdstub/mcd_syscalls.c
+++ b/mcdstub/mcd_syscalls.c
@@ -0,0 +1,20 @@
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "semihosting/semihost.h"
+#include "sysemu/runstate.h"
+#include "mcdstub/syscalls.h"
+//#include "trace.h"
+#include "internals.h"
+
+typedef struct {
+    char syscall_buf[256];
+    //TODO: this needs to be get fixed mcd_syscall_complete_cb
+    int current_syscall_cb;
+} MCDSyscallState;
+
+static MCDSyscallState mcdserver_syscall_state;
+
+void mcd_syscall_reset(void)
+{
+    mcdserver_syscall_state.current_syscall_cb = 0;
+}
\ No newline at end of file
diff --git a/mcdstub/mcd_tcp_server.c b/mcdstub/mcd_tcp_server.c
index 9a1baea2e4..558ddcb969 100644
--- a/mcdstub/mcd_tcp_server.c
+++ b/mcdstub/mcd_tcp_server.c
@@ -6,8 +6,8 @@
 #include <sys/socket.h>
 #include <sys/types.h>
 #include <unistd.h> // read(), write(), close()
+#include "exec/mcdstub.h"
 #define MAX 80
-#define DEFAULT_MCDSTUB_PORT "1234"
 #define SA struct sockaddr
 
 // Function designed for chat between client and server.
diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index e69de29bb2..c68cab9391 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -0,0 +1,519 @@
+/*
+ * This is the main mcdstub. It needs to be complemented by other mcd stubs for each target.
+ */
+
+//from original gdbstub.c
+#include "qemu/osdep.h"
+#include "qemu/ctype.h"
+#include "qemu/cutils.h"
+#include "qemu/module.h"
+#include "qemu/error-report.h"
+//#include "trace.h"
+#include "exec/mcdstub.h"
+#include "mcdstub/syscalls.h"
+#include "hw/cpu/cluster.h"
+#include "hw/boards.h"
+
+#include "sysemu/hw_accel.h"
+#include "sysemu/runstate.h"
+#include "exec/replay-core.h"
+#include "exec/hwaddr.h"
+
+#include "internals.h"
+
+//from original softmmu.c (minus what was already here)
+#include "qapi/error.h"
+#include "exec/tb-flush.h"
+#include "sysemu/cpus.h"
+#include "sysemu/replay.h"
+#include "hw/core/cpu.h"
+#include "chardev/char.h"
+#include "chardev/char-fe.h"
+#include "monitor/monitor.h"
+
+typedef struct {
+    CharBackend chr;
+    //Chardev *mon_chr;
+} MCDSystemState;
+
+MCDSystemState mcdserver_system_state;
+
+MCDState mcdserver_state;
+
+void mcd_init_mcdserver_state(void)
+{
+	g_assert(!mcdserver_state.init);
+    memset(&mcdserver_state, 0, sizeof(MCDState));
+    mcdserver_state.init = true;
+    mcdserver_state.str_buf = g_string_new(NULL);
+    mcdserver_state.mem_buf = g_byte_array_sized_new(MAX_PACKET_LENGTH);
+    mcdserver_state.last_packet = g_byte_array_sized_new(MAX_PACKET_LENGTH + 4);
+
+    /*
+     * What single-step modes are supported is accelerator dependent.
+     * By default try to use no IRQs and no timers while single
+     * stepping so as to make single stepping like a typical ICE HW step.
+     */
+	// TODO:
+	// this is weird and might be able to sit just like it is here with the same value as for gdb
+    mcdserver_state.supported_sstep_flags = accel_supported_gdbstub_sstep_flags();
+    mcdserver_state.sstep_flags = SSTEP_ENABLE | SSTEP_NOIRQ | SSTEP_NOTIMER;
+    mcdserver_state.sstep_flags &= mcdserver_state.supported_sstep_flags;
+}
+
+void reset_mcdserver_state(void)
+{
+    g_free(mcdserver_state.processes);
+    mcdserver_state.processes = NULL;
+    mcdserver_state.process_num = 0;
+}
+
+void create_processes(MCDState *s)
+{
+    object_child_foreach(object_get_root(), find_cpu_clusters, s);
+
+    if (mcdserver_state.processes) {
+        /* Sort by PID */
+        qsort(mcdserver_state.processes,
+              mcdserver_state.process_num,
+              sizeof(mcdserver_state.processes[0]),
+              pid_order);
+    }
+
+    mcd_create_default_process(s);
+}
+
+void mcd_create_default_process(MCDState *s)
+{
+    MCDProcess *process;
+    int max_pid = 0;
+
+    if (mcdserver_state.process_num) {
+        max_pid = s->processes[s->process_num - 1].pid;
+    }
+
+    s->processes = g_renew(MCDProcess, s->processes, ++s->process_num);
+    process = &s->processes[s->process_num - 1];
+
+    /* We need an available PID slot for this process */
+    assert(max_pid < UINT32_MAX);
+
+    process->pid = max_pid + 1;
+    process->attached = false;
+    process->target_xml[0] = '\0';
+}
+
+int find_cpu_clusters(Object *child, void *opaque)
+{
+    if (object_dynamic_cast(child, TYPE_CPU_CLUSTER)) {
+        MCDState *s = (MCDState *) opaque;
+        CPUClusterState *cluster = CPU_CLUSTER(child);
+        MCDProcess *process;
+
+        s->processes = g_renew(MCDProcess, s->processes, ++s->process_num);
+
+        process = &s->processes[s->process_num - 1];
+
+        /*
+         * GDB process IDs -1 and 0 are reserved. To avoid subtle errors at
+         * runtime, we enforce here that the machine does not use a cluster ID
+         * that would lead to PID 0.
+         */
+        assert(cluster->cluster_id != UINT32_MAX);
+        process->pid = cluster->cluster_id + 1;
+        process->attached = false;
+        process->target_xml[0] = '\0';
+
+        return 0;
+    }
+
+    return object_child_foreach(child, find_cpu_clusters, opaque);
+}
+
+int pid_order(const void *a, const void *b)
+{
+    MCDProcess *pa = (MCDProcess *) a;
+    MCDProcess *pb = (MCDProcess *) b;
+
+    if (pa->pid < pb->pid) {
+        return -1;
+    } else if (pa->pid > pb->pid) {
+        return 1;
+    } else {
+        return 0;
+    }
+}
+
+int mcdserver_start(const char *device)
+{
+    //might wann add tracing later (no idea for what this is used)
+    //trace_gdbstub_op_start(device);
+
+    char mcdstub_device_name[128];
+    Chardev *chr = NULL;
+    //Chardev *mon_chr;
+
+    if (!first_cpu) {
+        error_report("mcdstub: meaningless to attach to a "
+                     "machine without any CPU.");
+        return -1;
+    }
+
+    //
+    if (!mcd_supports_guest_debug()) {
+        error_report("mcdstub: current accelerator doesn't "
+                     "support guest debugging");
+        return -1;
+    }
+
+    if (!device) {
+        return -1;
+    }
+
+    //if device == default -> set device = tcp::1235
+    if (strcmp(device, "default") == 0) {
+        device = "tcp::1235";
+    }
+
+    if (strcmp(device, "none") != 0) {
+        if (strstart(device, "tcp:", NULL)) {
+            /* enforce required TCP attributes */
+            snprintf(mcdstub_device_name, sizeof(mcdstub_device_name),
+                     "%s,wait=off,nodelay=on,server=on", device);
+            device = mcdstub_device_name;
+        }
+#ifndef _WIN32
+        else if (strcmp(device, "stdio") == 0) {
+            struct sigaction act;
+
+            memset(&act, 0, sizeof(act));
+            act.sa_handler = mcd_sigterm_handler;
+            sigaction(SIGINT, &act, NULL);
+        }
+#endif
+        
+        chr = qemu_chr_new_noreplay("mcd", device, true, NULL);
+        if (!chr) {
+            return -1;
+        }
+    }
+
+    if (!mcdserver_state.init) {
+        mcd_init_mcdserver_state();
+
+        qemu_add_vm_change_state_handler(mcd_vm_state_change, NULL);
+
+        /* Initialize a monitor terminal for mcd */
+        //mon_chr = qemu_chardev_new(NULL, TYPE_CHARDEV_MCD, NULL, NULL, &error_abort);
+        //monitor_init_hmp(mon_chr, false, &error_abort);
+    } else {
+        qemu_chr_fe_deinit(&mcdserver_system_state.chr, true);
+        //mon_chr = mcdserver_system_state.mon_chr;
+        reset_mcdserver_state();
+    }
+
+    create_processes(&mcdserver_state);
+
+    if (chr) {
+        qemu_chr_fe_init(&mcdserver_system_state.chr, chr, &error_abort);
+        qemu_chr_fe_set_handlers(&mcdserver_system_state.chr,
+                                 mcd_chr_can_receive,
+                                 mcd_chr_receive, mcd_chr_event,
+                                 NULL, &mcdserver_state, NULL, true);
+    }
+    mcdserver_state.state = chr ? RS_IDLE : RS_INACTIVE;
+    //mcdserver_system_state.mon_chr = mon_chr;
+    mcd_syscall_reset();
+
+    return 0;
+}
+
+int mcd_chr_can_receive(void *opaque)
+{
+  return MAX_PACKET_LENGTH;
+}
+
+void mcd_chr_receive(void *opaque, const uint8_t *buf, int size)
+{
+    printf("incoming buffer: %s\n", buf);
+    char send_buffer[] = "shaking your hand";
+    mcd_put_packet(send_buffer);
+    //int i;
+	/*
+    for (i = 0; i < size; i++) {
+        //TODO: some byte reading or idk gdb_read_byte(buf[i]);
+    }*/
+}
+
+void mcd_chr_event(void *opaque, QEMUChrEvent event)
+{
+    int i;
+    MCDState *s = (MCDState *) opaque;
+
+    switch (event) {
+    case CHR_EVENT_OPENED:
+        // Start with first process attached, others detached
+        for (i = 0; i < s->process_num; i++) {
+            s->processes[i].attached = !i;
+        }
+
+        s->c_cpu = mcd_first_attached_cpu();
+        s->g_cpu = s->c_cpu;
+
+        vm_stop(RUN_STATE_PAUSED);
+		//TODO: this might not be necessary
+        //replay_gdb_attached();
+        //gdb_has_xml = false;
+        break;
+    default:
+        break;
+    }
+}
+
+bool mcd_supports_guest_debug(void)
+{
+    const AccelOpsClass *ops = cpus_get_accel();
+    if (ops->supports_guest_debug) {
+        return ops->supports_guest_debug();
+    }
+    return false;
+}
+
+#ifndef _WIN32
+void mcd_sigterm_handler(int signal)
+{
+    if (runstate_is_running()) {
+        vm_stop(RUN_STATE_PAUSED);
+    }
+}
+#endif
+
+void mcd_vm_state_change(void *opaque, bool running, RunState state)
+{
+	printf("this calls state_change\n");
+	/*
+    CPUState *cpu = mcdserver_state.c_cpu;
+    g_autoptr(GString) buf = g_string_new(NULL);
+    g_autoptr(GString) tid = g_string_new(NULL);
+    const char *type;
+    int ret;
+
+    if (running || mcdserver_state.state == RS_INACTIVE) {
+        return;
+    }
+
+    //Is there a GDB syscall waiting to be sent?
+    if (gdb_handled_syscall()) {
+        return;
+    }
+
+    if (cpu == NULL) {
+        //No process attached
+        return;
+    }
+
+    gdb_append_thread_id(cpu, tid);
+
+    switch (state) {
+    case RUN_STATE_DEBUG:
+        if (cpu->watchpoint_hit) {
+            switch (cpu->watchpoint_hit->flags & BP_MEM_ACCESS) {
+            case BP_MEM_READ:
+                type = "r";
+                break;
+            case BP_MEM_ACCESS:
+                type = "a";
+                break;
+            default:
+                type = "";
+                break;
+            }
+            trace_gdbstub_hit_watchpoint(type,
+                                         gdb_get_cpu_index(cpu),
+                                         cpu->watchpoint_hit->vaddr);
+            g_string_printf(buf, "T%02xthread:%s;%swatch:%" VADDR_PRIx ";",
+                            GDB_SIGNAL_TRAP, tid->str, type,
+                            cpu->watchpoint_hit->vaddr);
+            cpu->watchpoint_hit = NULL;
+            goto send_packet;
+        } else {
+            trace_gdbstub_hit_break();
+        }
+        tb_flush(cpu);
+        ret = GDB_SIGNAL_TRAP;
+        break;
+    case RUN_STATE_PAUSED:
+        trace_gdbstub_hit_paused();
+        ret = GDB_SIGNAL_INT;
+        break;
+    case RUN_STATE_SHUTDOWN:
+        trace_gdbstub_hit_shutdown();
+        ret = GDB_SIGNAL_QUIT;
+        break;
+    case RUN_STATE_IO_ERROR:
+        trace_gdbstub_hit_io_error();
+        ret = GDB_SIGNAL_IO;
+        break;
+    case RUN_STATE_WATCHDOG:
+        trace_gdbstub_hit_watchdog();
+        ret = GDB_SIGNAL_ALRM;
+        break;
+    case RUN_STATE_INTERNAL_ERROR:
+        trace_gdbstub_hit_internal_error();
+        ret = GDB_SIGNAL_ABRT;
+        break;
+    case RUN_STATE_SAVE_VM:
+    case RUN_STATE_RESTORE_VM:
+        return;
+    case RUN_STATE_FINISH_MIGRATE:
+        ret = GDB_SIGNAL_XCPU;
+        break;
+    default:
+        trace_gdbstub_hit_unknown(state);
+        ret = GDB_SIGNAL_UNKNOWN;
+        break;
+    }
+    mcd_set_stop_cpu(cpu);
+    g_string_printf(buf, "T%02xthread:%s;", ret, tid->str);
+
+send_packet:
+    mcd_put_packet(buf->str);
+
+    // disable single step if it was enabled
+    cpu_single_step(cpu, 0);
+*/
+}
+
+int mcd_put_packet(const char *buf)
+{
+	//tracing
+    //trace_gdbstub_io_reply(buf);
+
+    return mcd_put_packet_binary(buf, strlen(buf), false);
+}
+
+int mcd_put_packet_binary(const char *buf, int len, bool dump)
+{
+    //int csum, i;
+    //uint8_t footer[3];
+
+	//trace stuff
+    //if (dump && trace_event_get_state_backends(TRACE_GDBSTUB_IO_BINARYREPLY)) {
+    //    hexdump(buf, len, trace_gdbstub_io_binaryreply);
+    //}
+
+    for(;;) {
+        //super interesting if we want a chekcsum or something like that here!!
+        g_byte_array_set_size(mcdserver_state.last_packet, 0);
+        //g_byte_array_append(mcdserver_state.last_packet, (const uint8_t *) "$", 1);
+        g_byte_array_append(mcdserver_state.last_packet,
+                            (const uint8_t *) buf, len);
+        /*
+        csum = 0;
+        for(i = 0; i < len; i++) {
+            csum += buf[i];
+        }
+        footer[0] = '#';
+        footer[1] = tohex((csum >> 4) & 0xf);
+        footer[2] = tohex((csum) & 0xf);
+        g_byte_array_append(mcdserver_state.last_packet, footer, 3);
+        */
+        mcd_put_buffer(mcdserver_state.last_packet->data,
+                   mcdserver_state.last_packet->len);
+
+        if (mcd_got_immediate_ack()) {
+            break;
+        }
+    }
+    return 0;
+}
+
+bool mcd_got_immediate_ack(void)
+{
+    return true;
+}
+
+void mcd_put_buffer(const uint8_t *buf, int len)
+{
+    /*
+     * XXX this blocks entire thread. Rewrite to use
+     * qemu_chr_fe_write and background I/O callbacks
+     */
+    qemu_chr_fe_write_all(&mcdserver_system_state.chr, buf, len);
+}
+
+void mcd_set_stop_cpu(CPUState *cpu)
+{
+    MCDProcess *p = mcd_get_cpu_process(cpu);
+
+    if (!p->attached) {
+        /*
+         * Having a stop CPU corresponding to a process that is not attached
+         * confuses GDB. So we ignore the request.
+         */
+        return;
+    }
+
+    mcdserver_state.c_cpu = cpu;
+    mcdserver_state.g_cpu = cpu;
+}
+
+MCDProcess *mcd_get_cpu_process(CPUState *cpu)
+{
+    return mcd_get_process(mcd_get_cpu_pid(cpu));
+}
+
+uint32_t mcd_get_cpu_pid(CPUState *cpu)
+{
+    if (cpu->cluster_index == UNASSIGNED_CLUSTER_INDEX) {
+        /* Return the default process' PID */
+        int index = mcdserver_state.process_num - 1;
+        return mcdserver_state.processes[index].pid;
+    }
+    return cpu->cluster_index + 1;
+}
+
+MCDProcess *mcd_get_process(uint32_t pid)
+{
+    int i;
+
+    if (!pid) {
+        /* 0 means any process, we take the first one */
+        return &mcdserver_state.processes[0];
+    }
+
+    for (i = 0; i < mcdserver_state.process_num; i++) {
+        if (mcdserver_state.processes[i].pid == pid) {
+            return &mcdserver_state.processes[i];
+        }
+    }
+
+    return NULL;
+}
+
+CPUState *mcd_first_attached_cpu(void)
+{
+    CPUState *cpu = first_cpu;
+    MCDProcess *process = mcd_get_cpu_process(cpu);
+
+    if (!process->attached) {
+        return mcd_next_attached_cpu(cpu);
+    }
+
+    return cpu;
+}
+
+CPUState *mcd_next_attached_cpu(CPUState *cpu)
+{
+    cpu = CPU_NEXT(cpu);
+
+    while (cpu) {
+        if (mcd_get_cpu_process(cpu)->attached) {
+            break;
+        }
+
+        cpu = CPU_NEXT(cpu);
+    }
+
+    return cpu;
+}
\ No newline at end of file
diff --git a/mcdstub/meson.build b/mcdstub/meson.build
new file mode 100644
index 0000000000..f17e2f3e89
--- /dev/null
+++ b/mcdstub/meson.build
@@ -0,0 +1,25 @@
+#
+# The main gdbstub still relies on per-build definitions of various
+# types. The bits pushed to softmmu/user.c try to use guest agnostic
+# types such as hwaddr.
+#
+
+# We need to build the core mcd code via a library to be able to tweak
+# cflags so:
+
+mcd_softmmu_ss = ss.source_set()
+
+# We build one version of the mcdstub, because it only needs to work for system emulation
+mcd_softmmu_ss.add(files('mcdstub.c'))
+
+mcd_softmmu_ss = mcd_softmmu_ss.apply(config_host, strict: false)
+
+libmcd_softmmu = static_library('mcd_softmmu',
+                                mcd_softmmu_ss.sources() + genh,
+                                name_suffix: 'fa')
+
+mcd_softmmu = declare_dependency(link_whole: libmcd_softmmu)
+softmmu_ss.add(mcd_softmmu)
+
+# this might cause problems because we don't support user mode
+common_ss.add(files('mcd_syscalls.c'))
diff --git a/meson.build b/meson.build
index 21a1bc03f8..bd1d982522 100644
--- a/meson.build
+++ b/meson.build
@@ -3356,6 +3356,7 @@ subdir('crypto')
 subdir('ui')
 subdir('hw')
 subdir('gdbstub')
+subdir('mcdstub')
 
 if enable_modules
   libmodulecommon = static_library('module-common', files('module-common.c') + genh, pic: true, c_args: '-DBUILD_DSO')
diff --git a/qemu-options.hx b/qemu-options.hx
index 9ce8a5b957..0c15125b92 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4414,6 +4414,31 @@ SRST
     (see the :ref:`GDB usage` chapter in the System Emulation Users Guide).
 ERST
 
+DEF("mcd", HAS_ARG, QEMU_OPTION_mcd, \
+    "-mcd dev        accept mcd connection on 'dev'. (QEMU defaults to starting\n"
+    "                the guest without waiting for a mcd client to connect; use -S too\n"
+    "                if you want it to not start execution.)\n",
+    QEMU_ARCH_ALL)
+SRST
+``-mcd dev``
+    Accept a mcd connection on device dev. Note that this option does not pause QEMU
+    execution -- if you want QEMU to not start the guest until you
+    connect with mcd and issue a ``run`` command, you will need to
+    also pass the ``-S`` option to QEMU.
+
+    The most usual configuration is to listen on a local TCP socket::
+
+        -mcd tcp::1234
+ERST
+
+DEF("mcdd", 0, QEMU_OPTION_mcdd, \
+    "-mcdd              shorthand for -mcd tcp::" DEFAULT_MCDSTUB_PORT "\n",
+    QEMU_ARCH_ALL)
+SRST
+``-mcdd``
+    Shorthand for -mcd tcp::1234, i.e. open a mcdserver on TCP port 1234
+ERST
+
 DEF("d", HAS_ARG, QEMU_OPTION_d, \
     "-d item1,...    enable logging of specified items (use '-d help' for a list of log items)\n",
     QEMU_ARCH_ALL)
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 3278f204ea..2d66f612a7 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -68,6 +68,7 @@
 #include "sysemu/numa.h"
 #include "sysemu/hostmem.h"
 #include "exec/gdbstub.h"
+#include "exec/mcdstub.h"
 #include "qemu/timer.h"
 #include "chardev/char.h"
 #include "qemu/bitmap.h"
@@ -2662,6 +2663,14 @@ static void qemu_machine_creation_done(void)
     if (foreach_device_config(DEV_GDB, gdbserver_start) < 0) {
         exit(1);
     }
+    
+    if (foreach_device_config(DEV_MCD, mcdserver_start) < 0) {
+        /* 
+         * starts the mcdserver if the mcd option was set
+         */
+        exit(1);
+    }
+
     if (!vga_interface_created && !default_vga &&
         vga_interface_type != VGA_NONE) {
         warn_report("A -vga option was passed but this machine "
-- 
2.34.1


