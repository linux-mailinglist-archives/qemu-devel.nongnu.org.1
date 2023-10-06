Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA19F7BB285
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 09:45:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qofUX-0001sl-Et; Fri, 06 Oct 2023 03:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qofUU-0001sb-Tq
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 03:43:18 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qofUM-0005VA-UB
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 03:43:18 -0400
Received: (qmail 31639 invoked by uid 484); 6 Oct 2023 07:42:49 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.497954 secs); 06 Oct 2023 07:42:49 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP for <qemu-devel@nongnu.org>; 6 Oct 2023 07:42:47 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, Christian.Boenig@lauterbach.com,
 Nicolas Eder <nicolas.eder@lauterbach.com>
Subject: [PATCH mcdstub] first version of mcdstub
Date: Fri,  6 Oct 2023 09:41:47 +0200
Message-Id: <20231006074148.17719-1-nicolas.eder@lauterbach.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

SUMMARY=0D
=3D=3D=3D=3D=3D=3D=3D=0D
=0D
This patch-set introduces the first version of the mcdstub.=0D
The mcdstub is a debug interface, which enables debugging QEMU=0D
using the MCD (Multi-Core Debug) API.=0D
The mcdstub uses TCP to communicate with the host debug software. However,=
=0D
because MCD is merely an API, the TCP communication is not part of=0D
the MCD spec but specific to this project.=0D
=0D
To translate between the MCD API and the TCP data stream coming from the mc=
dstub,=0D
the host has to use a shared library (.dll/.so).=0D
Such a shared library will be available soon Lauterbach's open source site=
=0D
and will be linked to from inside this project in a future patch.=0D
The MCD API itself can be downloaded here: https://repo.lauterbach.com/spri=
nt_mcd_api_v1_0.zip=0D
=0D
QUICK START=0D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
=0D
Attention: MCD is currently only supported for qemu-system-arm !=0D
=0D
Three components are required to Debug QEMU via MCD:=0D
=0D
1. qemu-system-arm (built with this patch series applied).=0D
2. MCD shared library (translates between the MCD API and TCP data).=0D
3. Host debugging software with support for the MCD API (e.g. Lauterbach TR=
ACE32).=0D
=0D
To activate the mcdstub, just use the "mcd" launch option in combination wi=
th=0D
a TCP port.=0D
=0D
With the default TCP port 1235:=0D
=0D
$ qemu-system-arm -M virt -cpu cortex-a15 -mcd default=0D
=0D
With a custom TCP port:=0D
=0D
$ qemu-system-arm -M virt -cpu cortex-a15 -mcd tcp::1235=0D
=0D
QEMU will listen for an MCD host to connect to the specified port.=0D
=0D
IMPORTANT CHANGES=0D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
=0D
1. DebugClass:=0D
=0D
This patch-set introduces the DebugClass to the QOM, which is used to abstr=
act=0D
GDB/MCD specific debugger details.=0D
It is declared in include/qemu/debug.h, defined in debug/debug-common.c=0D
and configured in debug/debug-gdb.c and debug/debug-mcd.c respectively.=0D
It currently only offers one function: set_stop_cpu, which gets called=0D
in cpu_handle_guest_debug in softmmu/cpus.c.=0D
In the future, other functions could be moved from the mcd/gdbstub=0D
to the DebugClass.=0D
=0D
2. mcd launch option:=0D
=0D
This patch-set introduces the mcd launch option to QEMU. The quick start=0D
section describes how to use it.=0D
=0D
3. MCD debugging features:=0D
=0D
* Go, break, step=0D
* Read/write memory (user space only)=0D
* Read/write registers (GPR and CP)=0D
* Set breakpoints and watchpoints.=0D
=0D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
=0D
Signed-off-by: Nicolas Eder <nicolas.eder@lauterbach.com>=0D
=0D
From 107b25f36232d039c7ba8292eb73c907ed1ac24f Mon Sep 17 00:00:00 2001
From: Nicolas Eder <nicolas.eder@lauterbach.com>
Date: Wed, 26 Apr 2023 09:42:53 +0200
Subject: [PATCH 01/29] mcdstub initial commit, mcdstub file structure added

Signed-off-by: Nicolas Eder <nicolas.eder@lauterbach.com>
---
 include/exec/mcdstub.h   | 31 +++++++++++++
 mcdstub/mcd_softmmu.c    | 85 +++++++++++++++++++++++++++++++++++
 mcdstub/mcd_syscalls.c   |  0
 mcdstub/mcd_tcp_server.c | 95 ++++++++++++++++++++++++++++++++++++++++
 mcdstub/mcdstub.c        |  0
 softmmu/vl.c             |  4 ++
 6 files changed, 215 insertions(+)
 create mode 100644 include/exec/mcdstub.h
 create mode 100644 mcdstub/mcd_softmmu.c
 create mode 100644 mcdstub/mcd_syscalls.c
 create mode 100644 mcdstub/mcd_tcp_server.c
 create mode 100644 mcdstub/mcdstub.c

diff --git a/include/exec/mcdstub.h b/include/exec/mcdstub.h
new file mode 100644
index 0000000000..8afbc09367
--- /dev/null
+++ b/include/exec/mcdstub.h
@@ -0,0 +1,31 @@
+#ifndef MCDSTUB_H
+#define MCDSTUB_H
+
+#define DEFAULT_MCDSTUB_PORT "1234"
+
+/* MCD breakpoint/watchpoint types */
+#define MCD_BREAKPOINT_SW        0
+#define MCD_BREAKPOINT_HW        1
+#define MCD_WATCHPOINT_WRITE     2
+#define MCD_WATCHPOINT_READ      3
+#define MCD_WATCHPOINT_ACCESS    4
+
+
+/* Get or set a register.  Returns the size of the register.  */
+typedef int (*gdb_get_reg_cb)(CPUArchState *env, GByteArray *buf, int reg);
+typedef int (*gdb_set_reg_cb)(CPUArchState *env, uint8_t *buf, int reg);
+void gdb_register_coprocessor(CPUState *cpu,
+                              gdb_get_reg_cb get_reg, gdb_set_reg_cb set_r=
eg,
+                              int num_regs, const char *xml, int g_pos);
+
+/**
+ * mcdserver_start: start the mcd server
+ * @port_or_device: connection spec for mcd
+ *
+ * This is a TCP port
+ */
+int mcdserver_start(const char *port_or_device);
+
+void gdb_set_stop_cpu(CPUState *cpu);
+
+#endif
diff --git a/mcdstub/mcd_softmmu.c b/mcdstub/mcd_softmmu.c
new file mode 100644
index 0000000000..17e1d3ca1b
--- /dev/null
+++ b/mcdstub/mcd_softmmu.c
@@ -0,0 +1,85 @@
+/*
+ * this handeles all system emulation functions for the mcdstub
+ */
+
+#include "exec/mcdstub.h"
+
+int mcdserver_start(const char *device)
+{
+    trace_gdbstub_op_start(device);
+
+    char gdbstub_device_name[128];
+    Chardev *chr =3D NULL;
+    Chardev *mon_chr;
+
+    if (!first_cpu) {
+        error_report("gdbstub: meaningless to attach gdb to a "
+                     "machine without any CPU.");
+        return -1;
+    }
+
+    if (!gdb_supports_guest_debug()) {
+        error_report("gdbstub: current accelerator doesn't "
+                     "support guest debugging");
+        return -1;
+    }
+
+    if (!device) {
+        return -1;
+    }
+    if (strcmp(device, "none") !=3D 0) {
+        if (strstart(device, "tcp:", NULL)) {
+            /* enforce required TCP attributes */
+            snprintf(gdbstub_device_name, sizeof(gdbstub_device_name),
+                     "%s,wait=3Doff,nodelay=3Don,server=3Don", device);
+            device =3D gdbstub_device_name;
+        }
+#ifndef _WIN32
+        else if (strcmp(device, "stdio") =3D=3D 0) {
+            struct sigaction act;
+
+            memset(&act, 0, sizeof(act));
+            act.sa_handler =3D gdb_sigterm_handler;
+            sigaction(SIGINT, &act, NULL);
+        }
+#endif
+        /*
+         * FIXME: it's a bit weird to allow using a mux chardev here
+         * and implicitly setup a monitor. We may want to break this.
+         */
+        chr =3D qemu_chr_new_noreplay("gdb", device, true, NULL);
+        if (!chr) {
+            return -1;
+        }
+    }
+
+    if (!gdbserver_state.init) {
+        gdb_init_gdbserver_state();
+
+        qemu_add_vm_change_state_handler(gdb_vm_state_change, NULL);
+
+        /* Initialize a monitor terminal for gdb */
+        mon_chr =3D qemu_chardev_new(NULL, TYPE_CHARDEV_GDB,
+                                   NULL, NULL, &error_abort);
+        monitor_init_hmp(mon_chr, false, &error_abort);
+    } else {
+        qemu_chr_fe_deinit(&gdbserver_system_state.chr, true);
+        mon_chr =3D gdbserver_system_state.mon_chr;
+        reset_gdbserver_state();
+    }
+
+    create_processes(&gdbserver_state);
+
+    if (chr) {
+        qemu_chr_fe_init(&gdbserver_system_state.chr, chr, &error_abort);
+        qemu_chr_fe_set_handlers(&gdbserver_system_state.chr,
+                                 gdb_chr_can_receive,
+                                 gdb_chr_receive, gdb_chr_event,
+                                 NULL, &gdbserver_state, NULL, true);
+    }
+    gdbserver_state.state =3D chr ? RS_IDLE : RS_INACTIVE;
+    gdbserver_system_state.mon_chr =3D mon_chr;
+    gdb_syscall_reset();
+
+    return 0;
+}
\ No newline at end of file
diff --git a/mcdstub/mcd_syscalls.c b/mcdstub/mcd_syscalls.c
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/mcdstub/mcd_tcp_server.c b/mcdstub/mcd_tcp_server.c
new file mode 100644
index 0000000000..9a1baea2e4
--- /dev/null
+++ b/mcdstub/mcd_tcp_server.c
@@ -0,0 +1,95 @@
+#include <stdio.h>
+#include <netdb.h>
+#include <netinet/in.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/socket.h>
+#include <sys/types.h>
+#include <unistd.h> // read(), write(), close()
+#define MAX 80
+#define DEFAULT_MCDSTUB_PORT "1234"
+#define SA struct sockaddr
+
+// Function designed for chat between client and server.
+void func(int connfd)
+{
+	char buff[MAX];
+	int n;
+	// infinite loop for chat
+	for (;;) {
+		bzero(buff, MAX);
+
+		// read the message from client and copy it in buffer
+		read(connfd, buff, sizeof(buff));
+		// print buffer which contains the client contents
+		printf("From client: %s\t To client : ", buff);
+		bzero(buff, MAX);
+		n =3D 0;
+		// copy server message in the buffer
+		while ((buff[n++] =3D getchar()) !=3D '\n')
+			;
+
+		// and send that buffer to client
+		write(connfd, buff, sizeof(buff));
+
+		// if msg contains "Exit" then server exit and chat ended.
+		if (strncmp("exit", buff, 4) =3D=3D 0) {
+			printf("Server Exit...\n");
+			break;
+		}
+	}
+}
+
+// Driver function
+int main()
+{
+	int sockfd, connfd, len;
+	struct sockaddr_in servaddr, cli;
+
+	// socket create and verification
+	sockfd =3D socket(AF_INET, SOCK_STREAM, 0);
+	if (sockfd =3D=3D -1) {
+		printf("socket creation failed...\n");
+		exit(0);
+	}
+	else
+		printf("Socket successfully created..\n");
+	bzero(&servaddr, sizeof(servaddr));
+
+	// assign IP, PORT
+	servaddr.sin_family =3D AF_INET;
+	servaddr.sin_addr.s_addr =3D htonl(INADDR_ANY);
+	servaddr.sin_port =3D htons(DEFAULT_MCDSTUB_PORT);
+
+	// Binding newly created socket to given IP and verification
+	if ((bind(sockfd, (SA*)&servaddr, sizeof(servaddr))) !=3D 0) {
+		printf("socket bind failed...\n");
+		exit(0);
+	}
+	else
+		printf("Socket successfully binded..\n");
+
+	// Now server is ready to listen and verification
+	if ((listen(sockfd, 5)) !=3D 0) {
+		printf("Listen failed...\n");
+		exit(0);
+	}
+	else
+		printf("Server listening..\n");
+	len =3D sizeof(cli);
+
+	// Accept the data packet from client and verification
+	connfd =3D accept(sockfd, (SA*)&cli, &len);
+	if (connfd < 0) {
+		printf("server accept failed...\n");
+		exit(0);
+	}
+	else
+		printf("server accept the client...\n");
+
+	// Function for chatting between client and server
+	func(connfd);
+
+	// After chatting close the socket
+	close(sockfd);
+}
diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 98e071e63b..3278f204ea 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -1258,6 +1258,7 @@ struct device_config {
         DEV_PARALLEL,  /* -parallel      */
         DEV_DEBUGCON,  /* -debugcon */
         DEV_GDB,       /* -gdb, -s */
+        DEV_MCD,       /* -mcd */
         DEV_SCLP,      /* s390 sclp */
     } type;
     const char *cmdline;
@@ -3011,6 +3012,9 @@ void qemu_init(int argc, char **argv)
             case QEMU_OPTION_gdb:
                 add_device_config(DEV_GDB, optarg);
                 break;
+            case QEMU_OPTION_mcd:
+                add_device_config(DEV_MCD, optarg);
+                break;
             case QEMU_OPTION_L:
                 if (is_help_option(optarg)) {
                     list_data_dirs =3D true;
--=20
2.34.1


From f35f32173f89612158c5618f2e52f3371a004f3b Mon Sep 17 00:00:00 2001
From: Nicolas Eder <nicolas.eder@lauterbach.com>
Date: Fri, 28 Apr 2023 10:19:33 +0200
Subject: [PATCH 02/29] TCP chardev added, handshake with TRACE32 working

Signed-off-by: Nicolas Eder <nicolas.eder@lauterbach.com>
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
=20
         if (cmd->schema) {
             if (cmd_parse_params(&data[strlen(cmd->cmd)],
-                                 cmd->schema, params)) {
+                                 cmd->schema, params)) {=20
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
=20
-#define DEFAULT_MCDSTUB_PORT "1234"
+#define DEFAULT_MCDSTUB_PORT "1235"
+#define TYPE_CHARDEV_MCD "chardev-mcd"
+#define MX_INPUT_LENGTH 9
+#define MCD_TCP_DATALEN 80
=20
 /* MCD breakpoint/watchpoint types */
 #define MCD_BREAKPOINT_SW        0
@@ -10,22 +13,12 @@
 #define MCD_WATCHPOINT_READ      3
 #define MCD_WATCHPOINT_ACCESS    4
=20
-
-/* Get or set a register.  Returns the size of the register.  */
-typedef int (*gdb_get_reg_cb)(CPUArchState *env, GByteArray *buf, int reg);
-typedef int (*gdb_set_reg_cb)(CPUArchState *env, uint8_t *buf, int reg);
-void gdb_register_coprocessor(CPUState *cpu,
-                              gdb_get_reg_cb get_reg, gdb_set_reg_cb set_r=
eg,
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
=20
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
+typedef void (*gdb_syscall_complete_cb)(CPUState *cpu, uint64_t ret, int e=
rr);
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
+ * this header includes a lookup table for the transmitted messages over t=
he tcp connection to trace32,
+ * as well as function declarations for all functios used inside the mcdst=
ub
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
+    MCD_SIGNAL_HANDSHAKE =3D 0
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
+    if (v >=3D '0' && v <=3D '9') {
+        return v - '0';
+    } else if (v >=3D 'A' && v <=3D 'F') {
+        return v - 'A' + 10;
+    } else if (v >=3D 'a' && v <=3D 'f') {
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
+#define ISVALIDSOCKET(s) ((s) !=3D INVALID_SOCKET)
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
+#define ISVALIDSOCKET(s) ((s) >=3D 0)
+#define CLOSESOCKET(s) close(s)
+#define GETSOCKETERRNO() (errno)
+#endif
=20
-#include "exec/mcdstub.h"
+#define SA struct sockaddr
=20
-int mcdserver_start(const char *device)
-{
-    trace_gdbstub_op_start(device);
=20
-    char gdbstub_device_name[128];
-    Chardev *chr =3D NULL;
-    Chardev *mon_chr;
=20
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
=20
-    if (!gdb_supports_guest_debug()) {
-        error_report("gdbstub: current accelerator doesn't "
-                     "support guest debugging");
-        return -1;
-    }
+//here only deprecated code:
=20
-    if (!device) {
+int old_mcdserver_start(const char *device)
+{
+    //the device is a char array. if its "default" we use tcp with the def=
ault DEFAULT_MCDSTUB_PORT. Otherwise it has to look like "tcp::<tcpport>"
+    char tcp_port[MX_INPUT_LENGTH];
+    int error;
+    error =3D mcd_extract_tcp_port_num(device, tcp_port);
+    if (error !=3D 0) {
         return -1;
     }
-    if (strcmp(device, "none") !=3D 0) {
-        if (strstart(device, "tcp:", NULL)) {
-            /* enforce required TCP attributes */
-            snprintf(gdbstub_device_name, sizeof(gdbstub_device_name),
-                     "%s,wait=3Doff,nodelay=3Don,server=3Don", device);
-            device =3D gdbstub_device_name;
-        }
-#ifndef _WIN32
-        else if (strcmp(device, "stdio") =3D=3D 0) {
-            struct sigaction act;
-
-            memset(&act, 0, sizeof(act));
-            act.sa_handler =3D gdb_sigterm_handler;
-            sigaction(SIGINT, &act, NULL);
-        }
-#endif
-        /*
-         * FIXME: it's a bit weird to allow using a mux chardev here
-         * and implicitly setup a monitor. We may want to break this.
-         */
-        chr =3D qemu_chr_new_noreplay("gdb", device, true, NULL);
-        if (!chr) {
-            return -1;
-        }
+    int tcp_port_num =3D atoi(tcp_port);
+=20=20=20=20=20=20=20=20
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
=20
-    if (!gdbserver_state.init) {
-        gdb_init_gdbserver_state();
+	// socket create and verification
+	socked_fd =3D socket(AF_INET, SOCK_STREAM, 0);
+	if (!ISVALIDSOCKET(socked_fd)) {
+		return -1;
+	}
+	memset(&server_address, 0, sizeof(server_address));
=20
-        qemu_add_vm_change_state_handler(gdb_vm_state_change, NULL);
+	// assign IP, PORT
+	server_address.sin_family =3D AF_INET;
+	server_address.sin_port =3D htons(tcp_port);
+	server_address.sin_addr.s_addr =3D htonl(INADDR_ANY);
=20
-        /* Initialize a monitor terminal for gdb */
-        mon_chr =3D qemu_chardev_new(NULL, TYPE_CHARDEV_GDB,
-                                   NULL, NULL, &error_abort);
-        monitor_init_hmp(mon_chr, false, &error_abort);
-    } else {
-        qemu_chr_fe_deinit(&gdbserver_system_state.chr, true);
-        mon_chr =3D gdbserver_system_state.mon_chr;
-        reset_gdbserver_state();
+	// Binding newly created socket to given IP and verification
+	if ((bind(socked_fd, (SA*)&server_address, sizeof(server_address))) !=3D =
0) {
+		CLOSESOCKET(socked_fd);
+		return -1;
+	}
+
+	// Now server is ready to listen and verification
+	if ((listen(socked_fd, 5)) !=3D 0) {
+		CLOSESOCKET(socked_fd);
+		return -1;
+	}
+	else {
+		printf("TCP server listening on port %d\n", tcp_port);
+	}
+
+	//accepting connection
+	len =3D sizeof(client_address);
+	connect_fd =3D accept(socked_fd, (SA*)&client_address, &len);
+    if (!ISVALIDSOCKET(connect_fd)) {
+		CLOSESOCKET(socked_fd);
+        return -1;
     }
=20
-    create_processes(&gdbserver_state);
+	//lets do the handshake
+
+	char buff[MCD_TCP_DATALEN];
+	char expected_buff[MCD_TCP_DATALEN];
=20
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
+=09
+	if (strcmp(buff, expected_buff)=3D=3D0) {
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
+    int string_length =3D strlen(in_string);
+    if (string_length>MX_INPUT_LENGTH+1) {
+        return -1;
     }
-    gdbserver_state.state =3D chr ? RS_IDLE : RS_INACTIVE;
-    gdbserver_system_state.mon_chr =3D mon_chr;
-    gdb_syscall_reset();
=20
+    const char default_str[] =3D "default";
+
+    if ((string_length=3D=3Dstrlen(default_str)) && (strcmp(default_str, i=
n_string)=3D=3D0)) {
+        strcpy((char*)out_string, DEFAULT_MCDSTUB_PORT);
+        return 0;
+    }
+    else if (strcmp("tcp::", in_string)=3D=3D0) {
+            for (int index =3D 5; index < string_length; index++) {
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
+    mcdserver_syscall_state.current_syscall_cb =3D 0;
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
=20
 // Function designed for chat between client and server.
diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index e69de29bb2..c68cab9391 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -0,0 +1,519 @@
+/*
+ * This is the main mcdstub. It needs to be complemented by other mcd stub=
s for each target.
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
+    mcdserver_state.init =3D true;
+    mcdserver_state.str_buf =3D g_string_new(NULL);
+    mcdserver_state.mem_buf =3D g_byte_array_sized_new(MAX_PACKET_LENGTH);
+    mcdserver_state.last_packet =3D g_byte_array_sized_new(MAX_PACKET_LENG=
TH + 4);
+
+    /*
+     * What single-step modes are supported is accelerator dependent.
+     * By default try to use no IRQs and no timers while single
+     * stepping so as to make single stepping like a typical ICE HW step.
+     */
+	// TODO:
+	// this is weird and might be able to sit just like it is here with the s=
ame value as for gdb
+    mcdserver_state.supported_sstep_flags =3D accel_supported_gdbstub_sste=
p_flags();
+    mcdserver_state.sstep_flags =3D SSTEP_ENABLE | SSTEP_NOIRQ | SSTEP_NOT=
IMER;
+    mcdserver_state.sstep_flags &=3D mcdserver_state.supported_sstep_flags;
+}
+
+void reset_mcdserver_state(void)
+{
+    g_free(mcdserver_state.processes);
+    mcdserver_state.processes =3D NULL;
+    mcdserver_state.process_num =3D 0;
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
+    int max_pid =3D 0;
+
+    if (mcdserver_state.process_num) {
+        max_pid =3D s->processes[s->process_num - 1].pid;
+    }
+
+    s->processes =3D g_renew(MCDProcess, s->processes, ++s->process_num);
+    process =3D &s->processes[s->process_num - 1];
+
+    /* We need an available PID slot for this process */
+    assert(max_pid < UINT32_MAX);
+
+    process->pid =3D max_pid + 1;
+    process->attached =3D false;
+    process->target_xml[0] =3D '\0';
+}
+
+int find_cpu_clusters(Object *child, void *opaque)
+{
+    if (object_dynamic_cast(child, TYPE_CPU_CLUSTER)) {
+        MCDState *s =3D (MCDState *) opaque;
+        CPUClusterState *cluster =3D CPU_CLUSTER(child);
+        MCDProcess *process;
+
+        s->processes =3D g_renew(MCDProcess, s->processes, ++s->process_nu=
m);
+
+        process =3D &s->processes[s->process_num - 1];
+
+        /*
+         * GDB process IDs -1 and 0 are reserved. To avoid subtle errors at
+         * runtime, we enforce here that the machine does not use a cluste=
r ID
+         * that would lead to PID 0.
+         */
+        assert(cluster->cluster_id !=3D UINT32_MAX);
+        process->pid =3D cluster->cluster_id + 1;
+        process->attached =3D false;
+        process->target_xml[0] =3D '\0';
+
+        return 0;
+    }
+
+    return object_child_foreach(child, find_cpu_clusters, opaque);
+}
+
+int pid_order(const void *a, const void *b)
+{
+    MCDProcess *pa =3D (MCDProcess *) a;
+    MCDProcess *pb =3D (MCDProcess *) b;
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
+    Chardev *chr =3D NULL;
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
+    //if device =3D=3D default -> set device =3D tcp::1235
+    if (strcmp(device, "default") =3D=3D 0) {
+        device =3D "tcp::1235";
+    }
+
+    if (strcmp(device, "none") !=3D 0) {
+        if (strstart(device, "tcp:", NULL)) {
+            /* enforce required TCP attributes */
+            snprintf(mcdstub_device_name, sizeof(mcdstub_device_name),
+                     "%s,wait=3Doff,nodelay=3Don,server=3Don", device);
+            device =3D mcdstub_device_name;
+        }
+#ifndef _WIN32
+        else if (strcmp(device, "stdio") =3D=3D 0) {
+            struct sigaction act;
+
+            memset(&act, 0, sizeof(act));
+            act.sa_handler =3D mcd_sigterm_handler;
+            sigaction(SIGINT, &act, NULL);
+        }
+#endif
+=20=20=20=20=20=20=20=20
+        chr =3D qemu_chr_new_noreplay("mcd", device, true, NULL);
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
+        //mon_chr =3D qemu_chardev_new(NULL, TYPE_CHARDEV_MCD, NULL, NULL,=
 &error_abort);
+        //monitor_init_hmp(mon_chr, false, &error_abort);
+    } else {
+        qemu_chr_fe_deinit(&mcdserver_system_state.chr, true);
+        //mon_chr =3D mcdserver_system_state.mon_chr;
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
+    mcdserver_state.state =3D chr ? RS_IDLE : RS_INACTIVE;
+    //mcdserver_system_state.mon_chr =3D mon_chr;
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
+    char send_buffer[] =3D "shaking your hand";
+    mcd_put_packet(send_buffer);
+    //int i;
+	/*
+    for (i =3D 0; i < size; i++) {
+        //TODO: some byte reading or idk gdb_read_byte(buf[i]);
+    }*/
+}
+
+void mcd_chr_event(void *opaque, QEMUChrEvent event)
+{
+    int i;
+    MCDState *s =3D (MCDState *) opaque;
+
+    switch (event) {
+    case CHR_EVENT_OPENED:
+        // Start with first process attached, others detached
+        for (i =3D 0; i < s->process_num; i++) {
+            s->processes[i].attached =3D !i;
+        }
+
+        s->c_cpu =3D mcd_first_attached_cpu();
+        s->g_cpu =3D s->c_cpu;
+
+        vm_stop(RUN_STATE_PAUSED);
+		//TODO: this might not be necessary
+        //replay_gdb_attached();
+        //gdb_has_xml =3D false;
+        break;
+    default:
+        break;
+    }
+}
+
+bool mcd_supports_guest_debug(void)
+{
+    const AccelOpsClass *ops =3D cpus_get_accel();
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
+    CPUState *cpu =3D mcdserver_state.c_cpu;
+    g_autoptr(GString) buf =3D g_string_new(NULL);
+    g_autoptr(GString) tid =3D g_string_new(NULL);
+    const char *type;
+    int ret;
+
+    if (running || mcdserver_state.state =3D=3D RS_INACTIVE) {
+        return;
+    }
+
+    //Is there a GDB syscall waiting to be sent?
+    if (gdb_handled_syscall()) {
+        return;
+    }
+
+    if (cpu =3D=3D NULL) {
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
+                type =3D "r";
+                break;
+            case BP_MEM_ACCESS:
+                type =3D "a";
+                break;
+            default:
+                type =3D "";
+                break;
+            }
+            trace_gdbstub_hit_watchpoint(type,
+                                         gdb_get_cpu_index(cpu),
+                                         cpu->watchpoint_hit->vaddr);
+            g_string_printf(buf, "T%02xthread:%s;%swatch:%" VADDR_PRIx ";",
+                            GDB_SIGNAL_TRAP, tid->str, type,
+                            cpu->watchpoint_hit->vaddr);
+            cpu->watchpoint_hit =3D NULL;
+            goto send_packet;
+        } else {
+            trace_gdbstub_hit_break();
+        }
+        tb_flush(cpu);
+        ret =3D GDB_SIGNAL_TRAP;
+        break;
+    case RUN_STATE_PAUSED:
+        trace_gdbstub_hit_paused();
+        ret =3D GDB_SIGNAL_INT;
+        break;
+    case RUN_STATE_SHUTDOWN:
+        trace_gdbstub_hit_shutdown();
+        ret =3D GDB_SIGNAL_QUIT;
+        break;
+    case RUN_STATE_IO_ERROR:
+        trace_gdbstub_hit_io_error();
+        ret =3D GDB_SIGNAL_IO;
+        break;
+    case RUN_STATE_WATCHDOG:
+        trace_gdbstub_hit_watchdog();
+        ret =3D GDB_SIGNAL_ALRM;
+        break;
+    case RUN_STATE_INTERNAL_ERROR:
+        trace_gdbstub_hit_internal_error();
+        ret =3D GDB_SIGNAL_ABRT;
+        break;
+    case RUN_STATE_SAVE_VM:
+    case RUN_STATE_RESTORE_VM:
+        return;
+    case RUN_STATE_FINISH_MIGRATE:
+        ret =3D GDB_SIGNAL_XCPU;
+        break;
+    default:
+        trace_gdbstub_hit_unknown(state);
+        ret =3D GDB_SIGNAL_UNKNOWN;
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
+    //if (dump && trace_event_get_state_backends(TRACE_GDBSTUB_IO_BINARYRE=
PLY)) {
+    //    hexdump(buf, len, trace_gdbstub_io_binaryreply);
+    //}
+
+    for(;;) {
+        //super interesting if we want a chekcsum or something like that h=
ere!!
+        g_byte_array_set_size(mcdserver_state.last_packet, 0);
+        //g_byte_array_append(mcdserver_state.last_packet, (const uint8_t =
*) "$", 1);
+        g_byte_array_append(mcdserver_state.last_packet,
+                            (const uint8_t *) buf, len);
+        /*
+        csum =3D 0;
+        for(i =3D 0; i < len; i++) {
+            csum +=3D buf[i];
+        }
+        footer[0] =3D '#';
+        footer[1] =3D tohex((csum >> 4) & 0xf);
+        footer[2] =3D tohex((csum) & 0xf);
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
+    MCDProcess *p =3D mcd_get_cpu_process(cpu);
+
+    if (!p->attached) {
+        /*
+         * Having a stop CPU corresponding to a process that is not attach=
ed
+         * confuses GDB. So we ignore the request.
+         */
+        return;
+    }
+
+    mcdserver_state.c_cpu =3D cpu;
+    mcdserver_state.g_cpu =3D cpu;
+}
+
+MCDProcess *mcd_get_cpu_process(CPUState *cpu)
+{
+    return mcd_get_process(mcd_get_cpu_pid(cpu));
+}
+
+uint32_t mcd_get_cpu_pid(CPUState *cpu)
+{
+    if (cpu->cluster_index =3D=3D UNASSIGNED_CLUSTER_INDEX) {
+        /* Return the default process' PID */
+        int index =3D mcdserver_state.process_num - 1;
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
+    for (i =3D 0; i < mcdserver_state.process_num; i++) {
+        if (mcdserver_state.processes[i].pid =3D=3D pid) {
+            return &mcdserver_state.processes[i];
+        }
+    }
+
+    return NULL;
+}
+
+CPUState *mcd_first_attached_cpu(void)
+{
+    CPUState *cpu =3D first_cpu;
+    MCDProcess *process =3D mcd_get_cpu_process(cpu);
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
+    cpu =3D CPU_NEXT(cpu);
+
+    while (cpu) {
+        if (mcd_get_cpu_process(cpu)->attached) {
+            break;
+        }
+
+        cpu =3D CPU_NEXT(cpu);
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
+mcd_softmmu_ss =3D ss.source_set()
+
+# We build one version of the mcdstub, because it only needs to work for s=
ystem emulation
+mcd_softmmu_ss.add(files('mcdstub.c'))
+
+mcd_softmmu_ss =3D mcd_softmmu_ss.apply(config_host, strict: false)
+
+libmcd_softmmu =3D static_library('mcd_softmmu',
+                                mcd_softmmu_ss.sources() + genh,
+                                name_suffix: 'fa')
+
+mcd_softmmu =3D declare_dependency(link_whole: libmcd_softmmu)
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
=20
 if enable_modules
   libmodulecommon =3D static_library('module-common', files('module-common=
.c') + genh, pic: true, c_args: '-DBUILD_DSO')
diff --git a/qemu-options.hx b/qemu-options.hx
index 9ce8a5b957..0c15125b92 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4414,6 +4414,31 @@ SRST
     (see the :ref:`GDB usage` chapter in the System Emulation Users Guide).
 ERST
=20
+DEF("mcd", HAS_ARG, QEMU_OPTION_mcd, \
+    "-mcd dev        accept mcd connection on 'dev'. (QEMU defaults to sta=
rting\n"
+    "                the guest without waiting for a mcd client to connect=
; use -S too\n"
+    "                if you want it to not start execution.)\n",
+    QEMU_ARCH_ALL)
+SRST
+``-mcd dev``
+    Accept a mcd connection on device dev. Note that this option does not =
pause QEMU
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
+    "-mcdd              shorthand for -mcd tcp::" DEFAULT_MCDSTUB_PORT "\n=
",
+    QEMU_ARCH_ALL)
+SRST
+``-mcdd``
+    Shorthand for -mcd tcp::1234, i.e. open a mcdserver on TCP port 1234
+ERST
+
 DEF("d", HAS_ARG, QEMU_OPTION_d, \
     "-d item1,...    enable logging of specified items (use '-d help' for =
a list of log items)\n",
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
+=20=20=20=20
+    if (foreach_device_config(DEV_MCD, mcdserver_start) < 0) {
+        /*=20
+         * starts the mcdserver if the mcd option was set
+         */
+        exit(1);
+    }
+
     if (!vga_interface_created && !default_vga &&
         vga_interface_type !=3D VGA_NONE) {
         warn_report("A -vga option was passed but this machine "
--=20
2.34.1


From 73eea6655ba8a7c79c7d3212e261e9744bbb8a87 Mon Sep 17 00:00:00 2001
From: Nicolas Eder <nicolas.eder@lauterbach.com>
Date: Fri, 2 Jun 2023 16:54:56 +0200
Subject: [PATCH 03/29] TCP packet handling added

Signed-off-by: Nicolas Eder <nicolas.eder@lauterbach.com>
---
 mcdstub/internals.h    |  64 ++++-
 mcdstub/mcd_syscalls.c |  11 +
 mcdstub/mcdstub.c      | 541 +++++++++++++++++++++++++++++++++++++++--
 3 files changed, 596 insertions(+), 20 deletions(-)

diff --git a/mcdstub/internals.h b/mcdstub/internals.h
index 7b0f4b0b36..5af705a12a 100644
--- a/mcdstub/internals.h
+++ b/mcdstub/internals.h
@@ -25,12 +25,42 @@ enum {
  */
=20
 typedef struct MCDProcess {
+    //this is probably what we would call a system (in qemu its a cluster)
     uint32_t pid;
     bool attached;
=20
     char target_xml[1024];
 } MCDProcess;
=20
+typedef void (*MCDCmdHandler)(GArray *params, void *user_ctx);
+typedef struct MCDCmdParseEntry {
+    MCDCmdHandler handler;
+    const char *cmd;
+    bool cmd_startswith;
+    const char *schema;
+} MCDCmdParseEntry;
+
+typedef enum MCDThreadIdKind {
+    GDB_ONE_THREAD =3D 0,
+    GDB_ALL_THREADS,     /* One process, all threads */
+    GDB_ALL_PROCESSES,
+    GDB_READ_THREAD_ERR
+} MCDThreadIdKind;
+
+typedef union MCDCmdVariant {
+    const char *data;
+    uint8_t opcode;
+    unsigned long val_ul;
+    unsigned long long val_ull;
+    struct {
+        MCDThreadIdKind kind;
+        uint32_t pid;
+        uint32_t tid;
+    } thread_id;
+} MCDCmdVariant;
+
+#define get_param(p, i)    (&g_array_index(p, MCDCmdVariant, i))
+
=20
 /*
  * not sure for what this is used exactly
@@ -41,10 +71,11 @@ enum RSState {
     RS_INACTIVE,
     RS_IDLE,
     RS_GETLINE,
-    RS_GETLINE_ESC,
-    RS_GETLINE_RLE,
-    RS_CHKSUM1,
-    RS_CHKSUM2,
+    RS_DATAEND,
+    //RS_GETLINE_ESC,
+    //RS_GETLINE_RLE,
+    //RS_CHKSUM1,
+    //RS_CHKSUM2,
 };
=20
 typedef struct MCDState {
@@ -59,11 +90,13 @@ typedef struct MCDState {
     int line_csum; /* checksum at the end of the packet */
     GByteArray *last_packet;
     int signal;
-    bool multiprocess;
+    //the next one is about stub compatibility and we should be able to as=
sume this is true anyway
+    //bool multiprocess;
     MCDProcess *processes;
     int process_num;
     GString *str_buf;
     GByteArray *mem_buf;
+    // maybe we don't need those flags
     int sstep_flags;
     int supported_sstep_flags;
 } MCDState;
@@ -128,8 +161,29 @@ uint32_t mcd_get_cpu_pid(CPUState *cpu);
 MCDProcess *mcd_get_process(uint32_t pid);
 CPUState *mcd_first_attached_cpu(void);
 CPUState *mcd_next_attached_cpu(CPUState *cpu);
+void mcd_read_byte(uint8_t ch);
+int mcd_handle_packet(const char *line_buf);
+void mcd_put_strbuf(void);
+void mcd_exit(int code);
+void run_cmd_parser(const char *data, const MCDCmdParseEntry *cmd);
+int process_string_cmd(void *user_ctx, const char *data, const MCDCmdParse=
Entry *cmds, int num_cmds);
+int cmd_parse_params(const char *data, const char *schema, GArray *params);
+void handle_continue(GArray *params, void *user_ctx);
+void handle_gen_query(GArray *params, void *user_ctx);
+void mcd_append_thread_id(CPUState *cpu, GString *buf);
+int mcd_get_cpu_index(CPUState *cpu);
+CPUState* mcd_get_cpu(uint32_t i_cpu_index);
+void handle_query_cores(GArray *params, void *user_ctx);
+void handle_query_system(GArray *params, void *user_ctx);
+CPUState *get_first_cpu_in_process(MCDProcess *process);
+CPUState *find_cpu(uint32_t thread_id);
+void handle_core_open(GArray *params, void *user_ctx);
+void handle_query_reset(GArray *params, void *user_ctx);
+void handle_detach(GArray *params, void *user_ctx);
+void mcd_continue(void);
=20
 /* sycall handling */
 void mcd_syscall_reset(void);
+void mcd_disable_syscalls(void);
=20
 #endif /* MCDSTUB_INTERNALS_H */
diff --git a/mcdstub/mcd_syscalls.c b/mcdstub/mcd_syscalls.c
index 663ffde1b6..dec0af51b7 100644
--- a/mcdstub/mcd_syscalls.c
+++ b/mcdstub/mcd_syscalls.c
@@ -12,9 +12,20 @@ typedef struct {
     int current_syscall_cb;
 } MCDSyscallState;
=20
+static enum {
+    MCD_SYS_UNKNOWN,
+    MCD_SYS_ENABLED,
+    MCD_SYS_DISABLED,
+} mcd_syscall_mode;
+
 static MCDSyscallState mcdserver_syscall_state;
=20
 void mcd_syscall_reset(void)
 {
     mcdserver_syscall_state.current_syscall_cb =3D 0;
+}
+
+void mcd_disable_syscalls(void)
+{
+    mcd_syscall_mode =3D MCD_SYS_DISABLED;
 }
\ No newline at end of file
diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index c68cab9391..75b38d910a 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -31,6 +31,9 @@
 #include "chardev/char-fe.h"
 #include "monitor/monitor.h"
=20
+// just used for the xml_builtin stuff
+//#include "exec/gdbstub.h"       /* xml_builtin */
+
 typedef struct {
     CharBackend chr;
     //Chardev *mon_chr;
@@ -40,6 +43,22 @@ MCDSystemState mcdserver_system_state;
=20
 MCDState mcdserver_state;
=20
+static const MCDCmdParseEntry mcd_gen_query_table[] =3D {
+    // this is a list of all query commands. it gets iterated over only th=
e handler of the matching command will get executed
+    {
+        .handler =3D handle_query_system,
+        .cmd =3D "system",
+    },
+    {
+        .handler =3D handle_query_cores,
+        .cmd =3D "cores",
+    },
+    {
+        .handler =3D handle_query_reset,
+        .cmd =3D "reset",
+    },
+};
+
 void mcd_init_mcdserver_state(void)
 {
 	g_assert(!mcdserver_state.init);
@@ -55,7 +74,7 @@ void mcd_init_mcdserver_state(void)
      * stepping so as to make single stepping like a typical ICE HW step.
      */
 	// TODO:
-	// this is weird and might be able to sit just like it is here with the s=
ame value as for gdb
+	// this is weird and we might not actually need it after all
     mcdserver_state.supported_sstep_flags =3D accel_supported_gdbstub_sste=
p_flags();
     mcdserver_state.sstep_flags =3D SSTEP_ENABLE | SSTEP_NOIRQ | SSTEP_NOT=
IMER;
     mcdserver_state.sstep_flags &=3D mcdserver_state.supported_sstep_flags;
@@ -235,14 +254,343 @@ int mcd_chr_can_receive(void *opaque)
=20
 void mcd_chr_receive(void *opaque, const uint8_t *buf, int size)
 {
-    printf("incoming buffer: %s\n", buf);
-    char send_buffer[] =3D "shaking your hand";
-    mcd_put_packet(send_buffer);
-    //int i;
-	/*
+    int i;
+=09
     for (i =3D 0; i < size; i++) {
-        //TODO: some byte reading or idk gdb_read_byte(buf[i]);
-    }*/
+        mcd_read_byte(buf[i]);
+    }
+}
+
+void mcd_read_byte(uint8_t ch)
+{
+    uint8_t reply;
+
+    if (mcdserver_state.last_packet->len) {
+        /* Waiting for a response to the last packet.  If we see the start
+           of a new command then abandon the previous response.  */
+        if (ch =3D=3D '-') {
+            //the previous packet was not akcnowledged
+            //trace_gdbstub_err_got_nack();
+            //we are resending the last packet
+            mcd_put_buffer(mcdserver_state.last_packet->data, mcdserver_st=
ate.last_packet->len);
+        }
+        else if (ch =3D=3D '+') {
+            //the previous packet was acknowledged
+            //trace_gdbstub_io_got_ack();
+        }
+
+        if (ch =3D=3D '+' || ch =3D=3D '$') {
+            //either acknowledged or a new communication starts -> we disc=
ard previous communication
+            g_byte_array_set_size(mcdserver_state.last_packet, 0);
+        }
+        if (ch !=3D '$') {
+            // we only continue if we are processing a new commant. otherw=
ise we skip to ne next character in the packet which sould be a $
+            return;
+        }
+    }
+    if (runstate_is_running()) {
+        /* when the CPU is running, we cannot do anything except stop
+           it when receiving a char */
+        vm_stop(RUN_STATE_PAUSED);
+    }
+    else {
+        switch(mcdserver_state.state) {
+        case RS_IDLE:
+            if (ch =3D=3D '$') {
+                /* start of command packet */
+                mcdserver_state.line_buf_index =3D 0;
+                mcdserver_state.line_sum =3D 0;
+                mcdserver_state.state =3D RS_GETLINE;
+            }
+            else {
+                //new communication has to start with a $
+                //trace_gdbstub_err_garbage(ch);
+            }
+            break;
+        case RS_GETLINE:
+            if (ch =3D=3D '#') {
+                /* end of command, start of checksum*/
+                mcdserver_state.state =3D RS_DATAEND;
+            }
+            else if (mcdserver_state.line_buf_index >=3D sizeof(mcdserver_=
state.line_buf) - 1) {
+                //the input string is too long for the linebuffer!
+                //trace_gdbstub_err_overrun();
+                mcdserver_state.state =3D RS_IDLE;
+            }
+            else {
+                /* unescaped command character */
+                //this means the character is part of the real content fo =
the packet and we copy it to the line_buf
+                mcdserver_state.line_buf[mcdserver_state.line_buf_index++]=
 =3D ch;
+                mcdserver_state.line_sum +=3D ch;
+            }
+            break;
+        case RS_DATAEND:
+            // we are now done with copying the data and in the suffix of =
the packet
+            // TODO: maybe wanna implement a checksum or sth like the gdb =
protocol has
+
+            if (ch =3D=3D '~') {
+                // ~ indicates that there is an additional package coming
+                //acknowledged -> send +
+                reply =3D '+';
+                mcd_put_buffer(&reply, 1);
+                mcdserver_state.state =3D mcd_handle_packet(mcdserver_stat=
e.line_buf);
+            }
+            else if (ch =3D=3D '|') {
+                //acknowledged -> send +
+                // | indicates that there is no additional package coming
+                reply =3D '+';
+                mcd_put_buffer(&reply, 1);
+                mcdserver_state.state =3D mcd_handle_packet(mcdserver_stat=
e.line_buf);
+            }
+            else {
+                //trace_gdbstub_err_checksum_incorrect(mcdserver_state.lin=
e_sum, mcdserver_state.line_csum);
+                //not acknowledged -> send -
+                reply =3D '-';
+                mcd_put_buffer(&reply, 1);
+                //waiting for package to get resent
+                mcdserver_state.state =3D RS_IDLE;
+            }
+            break;
+        default:
+            abort();
+        }
+    }
+}
+
+int mcd_handle_packet(const char *line_buf)
+{
+    //decides what function (handler) to call depending on what the first =
character in the line_buf is!
+    const MCDCmdParseEntry *cmd_parser =3D NULL;
+
+    //trace_gdbstub_io_command(line_buf);
+
+    switch (line_buf[0]) {
+    case 'i':
+        //handshake
+        mcd_put_packet("shaking your hand");
+        //gdb_put_packet("OK");
+        break;
+    case 'c':
+        //go command
+        {
+            static const MCDCmdParseEntry continue_cmd_desc =3D {
+                .handler =3D handle_continue,
+                .cmd =3D "c",
+                //.cmd_startswith =3D 1,
+                //.schema =3D "L0"
+            };
+            cmd_parser =3D &continue_cmd_desc;
+        }
+        break;
+    case 'k':
+        // kill qemu completely
+        error_report("QEMU: Terminated via MCDstub");
+        mcd_exit(0);
+        exit(0);
+    case 'q':
+        //query inquiry
+        {
+            static const MCDCmdParseEntry gen_query_cmd_desc =3D {
+                .handler =3D handle_gen_query,
+                .cmd =3D "q",
+                //.cmd_startswith =3D 1,
+                .schema =3D "ss"
+            };
+            cmd_parser =3D &gen_query_cmd_desc;
+        }
+        break;
+    case 'H':
+        //current alias for open core, later this will probably be a part =
of the 'i' requests
+        {
+            static const MCDCmdParseEntry gen_core_open =3D {
+                .handler =3D handle_core_open,
+                .cmd =3D "H",
+                //.cmd_startswith =3D 1,
+                .schema =3D "ss"
+            };
+            cmd_parser =3D &gen_core_open;
+        }
+        break;
+    case 'D':
+        {
+            static const MCDCmdParseEntry detach_cmd_desc =3D {
+                .handler =3D handle_detach,
+                .cmd =3D "D",
+                //.cmd_startswith =3D 1,
+                //.schema =3D "?.l0"
+            };
+            cmd_parser =3D &detach_cmd_desc;
+        }
+        break;
+    default:
+        //could not perform the command (because its unknown)
+        mcd_put_packet("");
+        break;
+    }
+
+    if (cmd_parser) {
+        //now parse commands and run the selected function (handler)
+        run_cmd_parser(line_buf, cmd_parser);
+    }
+
+    return RS_IDLE;
+}
+
+void handle_continue(GArray *params, void *user_ctx)
+{
+    /*
+    if (params->len) {
+        gdb_set_cpu_pc(get_param(params, 0)->val_ull);
+    }
+
+    mcdserver_state.signal =3D 0;
+    gdb_continue();
+    */
+}
+
+void handle_gen_query(GArray *params, void *user_ctx)
+{
+    if (!params->len) {
+        return;
+    }
+    //now iterate over all possible query functions and execute the right =
one
+    if (process_string_cmd(NULL, get_param(params, 0)->data,
+                           mcd_gen_query_table,
+                           ARRAY_SIZE(mcd_gen_query_table))) {
+        mcd_put_packet("");
+    }
+}
+
+void run_cmd_parser(const char *data, const MCDCmdParseEntry *cmd)
+{
+    if (!data) {
+        return;
+    }
+
+    g_string_set_size(mcdserver_state.str_buf, 0);
+    g_byte_array_set_size(mcdserver_state.mem_buf, 0);
+
+    /* In case there was an error during the command parsing we must
+    * send a NULL packet to indicate the command is not supported */
+    if (process_string_cmd(NULL, data, cmd, 1)) {
+        mcd_put_packet("");
+    }
+}
+
+int cmd_parse_params(const char *data, const char *schema, GArray *params)
+{
+    MCDCmdVariant this_param;
+    this_param.data =3D data;
+    g_array_append_val(params, this_param);
+    /*
+    const char *curr_schema, *curr_data;
+
+    g_assert(schema);
+    g_assert(params->len =3D=3D 0);
+
+    curr_schema =3D schema;
+    curr_data =3D data;
+    while (curr_schema[0] && curr_schema[1] && *curr_data) {
+        GdbCmdVariant this_param;
+
+        switch (curr_schema[0]) {
+        case 'l':
+            if (qemu_strtoul(curr_data, &curr_data, 16,
+                             &this_param.val_ul)) {
+                return -EINVAL;
+            }
+            curr_data =3D cmd_next_param(curr_data, curr_schema[1]);
+            g_array_append_val(params, this_param);
+            break;
+        case 'L':
+            if (qemu_strtou64(curr_data, &curr_data, 16,
+                              (uint64_t *)&this_param.val_ull)) {
+                return -EINVAL;
+            }
+            curr_data =3D cmd_next_param(curr_data, curr_schema[1]);
+            g_array_append_val(params, this_param);
+            break;
+        case 's':
+            this_param.data =3D curr_data;
+            curr_data =3D cmd_next_param(curr_data, curr_schema[1]);
+            g_array_append_val(params, this_param);
+            break;
+        case 'o':
+            this_param.opcode =3D *(uint8_t *)curr_data;
+            curr_data =3D cmd_next_param(curr_data, curr_schema[1]);
+            g_array_append_val(params, this_param);
+            break;
+        case 't':
+            this_param.thread_id.kind =3D
+                read_thread_id(curr_data, &curr_data,
+                               &this_param.thread_id.pid,
+                               &this_param.thread_id.tid);
+            curr_data =3D cmd_next_param(curr_data, curr_schema[1]);
+            g_array_append_val(params, this_param);
+            break;
+        case '?':
+            curr_data =3D cmd_next_param(curr_data, curr_schema[1]);
+            break;
+        default:
+            return -EINVAL;
+        }
+        curr_schema +=3D 2;
+    }
+    */
+    return 0;
+=20=20=20=20
+}
+
+int process_string_cmd(void *user_ctx, const char *data, const MCDCmdParse=
Entry *cmds, int num_cmds)
+{
+    int i;
+    g_autoptr(GArray) params =3D g_array_new(false, true, sizeof(MCDCmdVar=
iant));
+
+    if (!cmds) {
+        return -1;
+    }
+
+    for (i =3D 0; i < num_cmds; i++) {
+        const MCDCmdParseEntry *cmd =3D &cmds[i];
+        //terminate if we don't have handler and cmd
+        g_assert(cmd->handler && cmd->cmd);
+
+        // if data and command are different continue
+        if (strncmp(data, cmd->cmd, strlen(cmd->cmd))) {
+            continue;
+        }
+
+        // if a schema is provided we need to extract parameters from the =
data string
+        if (cmd->schema) {
+            //currently doing nothing
+            if (cmd_parse_params(&data[strlen(cmd->cmd)], cmd->schema, par=
ams)) {
+                return -1;
+            }
+        }
+
+        // the correct handler function is called
+        cmd->handler(params, user_ctx);
+        return 0;
+    }
+
+    return -1;
+}
+
+void mcd_exit(int code)
+{
+    char buf[4];
+
+    if (!mcdserver_state.init) {
+        return;
+    }
+
+    //trace_gdbstub_op_exiting((uint8_t)code);
+
+    //need to check what is sent here and dapt it to my needs
+    snprintf(buf, sizeof(buf), "W%02x", (uint8_t)code);
+    mcd_put_packet(buf);
+
+    qemu_chr_fe_deinit(&mcdserver_system_state.chr, true);
 }
=20
 void mcd_chr_event(void *opaque, QEMUChrEvent event)
@@ -392,6 +740,11 @@ int mcd_put_packet(const char *buf)
     return mcd_put_packet_binary(buf, strlen(buf), false);
 }
=20
+void mcd_put_strbuf(void)
+{
+    mcd_put_packet(mcdserver_state.str_buf->str);
+}
+
 int mcd_put_packet_binary(const char *buf, int len, bool dump)
 {
     //int csum, i;
@@ -405,9 +758,10 @@ int mcd_put_packet_binary(const char *buf, int len, bo=
ol dump)
     for(;;) {
         //super interesting if we want a chekcsum or something like that h=
ere!!
         g_byte_array_set_size(mcdserver_state.last_packet, 0);
-        //g_byte_array_append(mcdserver_state.last_packet, (const uint8_t =
*) "$", 1);
-        g_byte_array_append(mcdserver_state.last_packet,
-                            (const uint8_t *) buf, len);
+        g_byte_array_append(mcdserver_state.last_packet, (const uint8_t *)=
 "$", 1);
+        g_byte_array_append(mcdserver_state.last_packet, (const uint8_t *)=
 buf, len);
+        g_byte_array_append(mcdserver_state.last_packet, (const uint8_t *)=
 "#", 1);
+        g_byte_array_append(mcdserver_state.last_packet, (const uint8_t *)=
 "|", 1);
         /*
         csum =3D 0;
         for(i =3D 0; i < len; i++) {
@@ -418,8 +772,7 @@ int mcd_put_packet_binary(const char *buf, int len, boo=
l dump)
         footer[2] =3D tohex((csum) & 0xf);
         g_byte_array_append(mcdserver_state.last_packet, footer, 3);
         */
-        mcd_put_buffer(mcdserver_state.last_packet->data,
-                   mcdserver_state.last_packet->len);
+        mcd_put_buffer(mcdserver_state.last_packet->data, mcdserver_state.=
last_packet->len);
=20
         if (mcd_got_immediate_ack()) {
             break;
@@ -453,7 +806,7 @@ void mcd_set_stop_cpu(CPUState *cpu)
          */
         return;
     }
-
+    //FIXME: we probably can delete this because in the opern_core functio=
n we set these two anyway
     mcdserver_state.c_cpu =3D cpu;
     mcdserver_state.g_cpu =3D cpu;
 }
@@ -470,6 +823,7 @@ uint32_t mcd_get_cpu_pid(CPUState *cpu)
         int index =3D mcdserver_state.process_num - 1;
         return mcdserver_state.processes[index].pid;
     }
+    // TODO: maybe +1 because we start numbering at 1
     return cpu->cluster_index + 1;
 }
=20
@@ -491,6 +845,19 @@ MCDProcess *mcd_get_process(uint32_t pid)
     return NULL;
 }
=20
+CPUState* mcd_get_cpu(uint32_t i_cpu_index) {
+    CPUState *cpu =3D first_cpu;
+
+    while (cpu) {
+        if (cpu->cpu_index =3D=3D i_cpu_index) {
+            return cpu;
+        }
+        cpu =3D mcd_next_attached_cpu(cpu);
+    }
+
+    return cpu;
+}
+
 CPUState *mcd_first_attached_cpu(void)
 {
     CPUState *cpu =3D first_cpu;
@@ -516,4 +883,148 @@ CPUState *mcd_next_attached_cpu(CPUState *cpu)
     }
=20
     return cpu;
-}
\ No newline at end of file
+}
+/*
+void handle_query_first_threads(GArray *params, void *user_ctx)
+{
+    // chache the first cpu
+    mcdserver_state.query_cpu =3D mcd_first_attached_cpu();
+    // new answer over tcp
+    handle_query_threads(params, user_ctx);
+}
+
+void handle_query_threads(GArray *params, void *user_ctx)
+{
+    if (!mcdserver_state.query_cpu) {
+        // send packet back that that there is no more threads
+        //gdb_put_packet("l");
+        return;
+    }
+
+    g_string_assign(mcdserver_state.str_buf, "m");
+    mcd_append_thread_id(mcdserver_state.query_cpu, mcdserver_state.str_bu=
f);
+    mcd_put_strbuf();
+    mcdserver_state.query_cpu =3D mcd_next_attached_cpu(mcdserver_state.qu=
ery_cpu);
+}
+
+
+void mcd_append_thread_id(CPUState *cpu, GString *buf)
+{
+    g_string_append_printf(buf, "p%02x.%02x", mcd_get_cpu_pid(cpu), mcd_ge=
t_cpu_index(cpu));
+}
+*/
+
+int mcd_get_cpu_index(CPUState *cpu)
+{
+    // TODO: maybe plus 1 because we start numbering at 1
+    return cpu->cpu_index + 1;
+}
+
+CPUState *get_first_cpu_in_process(MCDProcess *process)
+{
+    CPUState *cpu;
+
+    CPU_FOREACH(cpu) {
+        if (mcd_get_cpu_pid(cpu) =3D=3D process->pid) {
+            return cpu;
+        }
+    }
+
+    return NULL;
+}
+
+CPUState *find_cpu(uint32_t thread_id)
+{
+    CPUState *cpu;
+
+    CPU_FOREACH(cpu) {
+        if (mcd_get_cpu_index(cpu) =3D=3D thread_id) {
+            return cpu;
+        }
+    }
+
+    return NULL;
+}
+
+void handle_query_system(GArray *params, void *user_ctx) {
+    mcd_put_packet("qemu-system");
+}
+
+void handle_query_cores(GArray *params, void *user_ctx) {
+    //TODO: add cluster support: in gdb each inferior (process) handles on=
e cluster we might want to have sth similar here
+
+    // get first cpu
+    CPUState *cpu =3D mcd_first_attached_cpu();
+    if (!cpu) {
+        return;
+    }
+
+    ObjectClass *oc =3D object_get_class(OBJECT(cpu));
+    const char *cpu_model =3D object_class_get_name(oc);
+
+    CPUClass *cc =3D CPU_GET_CLASS(cpu);
+    gchar *arch =3D cc->gdb_arch_name(cpu);
+=20=20=20=20
+    //const char *cpu_name =3D object_get_canonical_path_component(OBJECT(=
cpu));
+    //int process_id =3D mcd_get_cpu_pid(cpu);
+    //int cpu_index =3D cpu->cpu_index;
+    //int cpu_cluster =3D cpu->cluster_index;
+    int nr_cores =3D cpu->nr_cores;
+
+    g_string_append_printf(mcdserver_state.str_buf, "device=3D\"qemu-%s-de=
vice\",core=3D\"%s\",nr_cores=3D\"%d\"", arch, cpu_model, nr_cores);
+    mcd_put_strbuf();
+    g_free(arch);
+}
+
+void handle_core_open(GArray *params, void *user_ctx) {
+    // get the cpu whith the given id
+    uint32_t cpu_id =3D atoi(get_param(params, 0)->data);
+
+    CPUState *cpu =3D mcd_get_cpu(cpu_id);
+
+    // select the the cpu as the current cpu for all request from the mcd =
interface
+    mcdserver_state.c_cpu =3D cpu;
+    mcdserver_state.g_cpu =3D cpu;
+
+}
+
+void handle_query_reset(GArray *params, void *user_ctx) {
+    // resetting has to be done over a monitor (look ar Rcmd) so we tell M=
CD that we can reset but this still need to be implemented
+    // we only support one reset over this monitor and that would be a ful=
ly "system_restart"
+    mcd_put_packet("info_rst=3D\"results in a full system restart\"");
+}
+
+void handle_detach(GArray *params, void *user_ctx) {
+    uint32_t pid =3D 1;
+    MCDProcess *process =3D mcd_get_process(pid);
+
+    // 1. cleanup
+    // gdb_process_breakpoint_remove_all(process);
+
+    // 2. detach
+    process->attached =3D false;
+
+    // reset current cpus
+    // TODO: if we don't use c_cpu we can delete this
+    // this also checks to only reset THIS process we also probably don't =
need this since we only got one process!
+    if (pid =3D=3D mcd_get_cpu_pid(mcdserver_state.c_cpu)) {
+        mcdserver_state.c_cpu =3D mcd_first_attached_cpu();
+    }
+
+    if (pid =3D=3D mcd_get_cpu_pid(mcdserver_state.g_cpu)) {
+        mcdserver_state.g_cpu =3D mcd_first_attached_cpu();
+    }
+
+    if (!mcdserver_state.c_cpu) {
+        /* No more process attached */
+        mcd_disable_syscalls();
+        mcd_continue();
+    }
+}
+
+void mcd_continue(void)
+{
+    if (!runstate_needs_reset()) {
+        vm_start();
+    }
+}
--=20
2.34.1


From a05b2211045bc49a3788bfa952e9e2e26abb8dcb Mon Sep 17 00:00:00 2001
From: Nicolas Eder <nicolas.eder@lauterbach.com>
Date: Fri, 16 Jun 2023 17:27:57 +0200
Subject: [PATCH 04/29] queries for resets and triggers added

Signed-off-by: Nicolas Eder <nicolas.eder@lauterbach.com>
---
 mcdstub/internals.h |  9 +++++++++
 mcdstub/mcdstub.c   | 19 ++++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/mcdstub/internals.h b/mcdstub/internals.h
index 5af705a12a..ce3bffe7e6 100644
--- a/mcdstub/internals.h
+++ b/mcdstub/internals.h
@@ -11,6 +11,14 @@
=20
 #define MAX_PACKET_LENGTH 1024
=20
+// trigger defines
+#define MCD_TRIG_TYPE_IP 0x00000001
+#define MCD_TRIG_TYPE_READ 0x00000002
+#define MCD_TRIG_TYPE_WRITE 0x00000004
+#define MCD_TRIG_TYPE_RW 0x00000008
+#define MCD_TRIG_OPT_DATA_IS_CONDITION 0x00000008
+#define MCD_TRIG_ACTION_DBG_DEBUG 0x00000001
+
 /*
  * lookuptable for transmitted signals
  */
@@ -180,6 +188,7 @@ CPUState *find_cpu(uint32_t thread_id);
 void handle_core_open(GArray *params, void *user_ctx);
 void handle_query_reset(GArray *params, void *user_ctx);
 void handle_detach(GArray *params, void *user_ctx);
+void handle_query_trigger(GArray *params, void *user_ctx);
 void mcd_continue(void);
=20
 /* sycall handling */
diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index 75b38d910a..1d066c8169 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -57,6 +57,10 @@ static const MCDCmdParseEntry mcd_gen_query_table[] =3D {
         .handler =3D handle_query_reset,
         .cmd =3D "reset",
     },
+    {
+        .handler =3D handle_query_trigger,
+        .cmd =3D "trigger",
+    },
 };
=20
 void mcd_init_mcdserver_state(void)
@@ -991,7 +995,8 @@ void handle_core_open(GArray *params, void *user_ctx) {
 void handle_query_reset(GArray *params, void *user_ctx) {
     // resetting has to be done over a monitor (look ar Rcmd) so we tell M=
CD that we can reset but this still need to be implemented
     // we only support one reset over this monitor and that would be a ful=
ly "system_restart"
-    mcd_put_packet("info_rst=3D\"results in a full system restart\"");
+    mcd_put_packet("nr=3D\"3\",info=3D\"0,full_system_reset;1,gpr_reset;2,=
memory_reset;\"");
+    // TODO: we still need to implement the gpr and memory reset here!
 }
=20
 void handle_detach(GArray *params, void *user_ctx) {
@@ -1022,6 +1027,18 @@ void handle_detach(GArray *params, void *user_ctx) {
     }
 }
=20
+void handle_query_trigger(GArray *params, void *user_ctx) {
+    // set the type, option and action bitmask and send it
+
+    uint32_t type =3D (MCD_TRIG_TYPE_IP | MCD_TRIG_TYPE_READ | MCD_TRIG_TY=
PE_WRITE | MCD_TRIG_TYPE_RW);
+    uint32_t option =3D (MCD_TRIG_OPT_DATA_IS_CONDITION);
+    uint32_t action =3D (MCD_TRIG_ACTION_DBG_DEBUG);
+    uint32_t nr_trigger =3D 4;
+
+    g_string_append_printf(mcdserver_state.str_buf, "nr=3D\"%d\",info=3D\"=
%d;%d;%d;\"", nr_trigger, type, option, action);
+    mcd_put_strbuf();
+}
+
 void mcd_continue(void)
 {
     if (!runstate_needs_reset()) {
--=20
2.34.1


From 7bad0ae1e10fc8641c24acee08706f9cf9de0131 Mon Sep 17 00:00:00 2001
From: Nicolas Eder <nicolas.eder@lauterbach.com>
Date: Tue, 20 Jun 2023 17:34:00 +0200
Subject: [PATCH 05/29] queries for memory spaces and register groups added

Signed-off-by: Nicolas Eder <nicolas.eder@lauterbach.com>
---
 mcdstub/internals.h |  29 +++---
 mcdstub/mcdstub.c   | 240 ++++++++++++++++++++++++--------------------
 2 files changed, 147 insertions(+), 122 deletions(-)

diff --git a/mcdstub/internals.h b/mcdstub/internals.h
index ce3bffe7e6..8df535e92a 100644
--- a/mcdstub/internals.h
+++ b/mcdstub/internals.h
@@ -19,21 +19,13 @@
 #define MCD_TRIG_OPT_DATA_IS_CONDITION 0x00000008
 #define MCD_TRIG_ACTION_DBG_DEBUG 0x00000001
=20
-/*
- * lookuptable for transmitted signals
- */
-
-enum {
-    MCD_SIGNAL_HANDSHAKE =3D 0
-};
-
=20
 /*
  * struct for an MCD Process, each process can establish one connection
  */
=20
 typedef struct MCDProcess {
-    //this is probably what we would call a system (in qemu its a cluster)
+    //this is a relict from the gdb process, we might be able to delete th=
is
     uint32_t pid;
     bool attached;
=20
@@ -65,6 +57,9 @@ typedef union MCDCmdVariant {
         uint32_t pid;
         uint32_t tid;
     } thread_id;
+
+    // used to synchronize stub and dll for functions with multiple packets
+    int index_handle;
 } MCDCmdVariant;
=20
 #define get_param(p, i)    (&g_array_index(p, MCDCmdVariant, i))
@@ -88,9 +83,7 @@ enum RSState {
=20
 typedef struct MCDState {
     bool init;       /* have we been initialised? */
-    CPUState *c_cpu; /* current CPU for step/continue ops */
-    CPUState *g_cpu; /* current CPU for other ops */
-    CPUState *query_cpu; /* for q{f|s}ThreadInfo */
+    CPUState *c_cpu; /* current CPU for everything */
     enum RSState state; /* parsing state */
     char line_buf[MAX_PACKET_LENGTH];
     int line_buf_index;
@@ -107,11 +100,19 @@ typedef struct MCDState {
     // maybe we don't need those flags
     int sstep_flags;
     int supported_sstep_flags;
+
+    // my stuff
+    GArray *reggroups;
 } MCDState;
=20
 /* lives in main mcdstub.c */
 extern MCDState mcdserver_state;
=20
+typedef struct mcd_reg_group_st {
+    const char *name;
+    const char *id;
+} mcd_reg_group_st;
+
=20
 // Inline utility function, convert from int to hex and back
=20
@@ -190,6 +191,10 @@ void handle_query_reset(GArray *params, void *user_ctx=
);
 void handle_detach(GArray *params, void *user_ctx);
 void handle_query_trigger(GArray *params, void *user_ctx);
 void mcd_continue(void);
+void handle_query_mem_spaces(GArray *params, void *user_ctx);
+void handle_query_reg_groups_f(GArray *params, void *user_ctx);
+void handle_query_reg_groups_c(GArray *params, void *user_ctx);
+void handle_init(GArray *params, void *user_ctx);
=20
 /* sycall handling */
 void mcd_syscall_reset(void);
diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index 1d066c8169..9817f0893c 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -33,6 +33,7 @@
=20
 // just used for the xml_builtin stuff
 //#include "exec/gdbstub.h"       /* xml_builtin */
+#include "hw/core/sysemu-cpu-ops.h"
=20
 typedef struct {
     CharBackend chr;
@@ -61,6 +62,19 @@ static const MCDCmdParseEntry mcd_gen_query_table[] =3D {
         .handler =3D handle_query_trigger,
         .cmd =3D "trigger",
     },
+    {
+        .handler =3D handle_query_mem_spaces,
+        .cmd =3D "memory",
+    },
+    {
+        .handler =3D handle_query_reg_groups_f,
+        .cmd =3D "reggroupf",
+    },
+    {
+        .handler =3D handle_query_reg_groups_c,
+        .cmd =3D "reggroupc",
+        .schema =3D "i",
+    },
 };
=20
 void mcd_init_mcdserver_state(void)
@@ -314,6 +328,8 @@ void mcd_read_byte(uint8_t ch)
         case RS_GETLINE:
             if (ch =3D=3D '#') {
                 /* end of command, start of checksum*/
+                mcdserver_state.line_buf[mcdserver_state.line_buf_index++]=
 =3D 0;
+                //mcdserver_state.line_sum +=3D ch;
                 mcdserver_state.state =3D RS_DATAEND;
             }
             else if (mcdserver_state.line_buf_index >=3D sizeof(mcdserver_=
state.line_buf) - 1) {
@@ -363,25 +379,26 @@ void mcd_read_byte(uint8_t ch)
=20
 int mcd_handle_packet(const char *line_buf)
 {
-    //decides what function (handler) to call depending on what the first =
character in the line_buf is!
+    // decides what function (handler) to call depending on what the first=
 character in the line_buf is!
     const MCDCmdParseEntry *cmd_parser =3D NULL;
=20
-    //trace_gdbstub_io_command(line_buf);
-
     switch (line_buf[0]) {
     case 'i':
-        //handshake
-        mcd_put_packet("shaking your hand");
-        //gdb_put_packet("OK");
+        // handshake and lookup initialization
+        {
+            static const MCDCmdParseEntry continue_cmd_desc =3D {
+                .handler =3D handle_init,
+                .cmd =3D "i",
+            };
+            cmd_parser =3D &continue_cmd_desc;
+        }
         break;
     case 'c':
-        //go command
+        // go command
         {
             static const MCDCmdParseEntry continue_cmd_desc =3D {
                 .handler =3D handle_continue,
                 .cmd =3D "c",
-                //.cmd_startswith =3D 1,
-                //.schema =3D "L0"
             };
             cmd_parser =3D &continue_cmd_desc;
         }
@@ -397,8 +414,7 @@ int mcd_handle_packet(const char *line_buf)
             static const MCDCmdParseEntry gen_query_cmd_desc =3D {
                 .handler =3D handle_gen_query,
                 .cmd =3D "q",
-                //.cmd_startswith =3D 1,
-                .schema =3D "ss"
+                .schema =3D "s"
             };
             cmd_parser =3D &gen_query_cmd_desc;
         }
@@ -409,8 +425,7 @@ int mcd_handle_packet(const char *line_buf)
             static const MCDCmdParseEntry gen_core_open =3D {
                 .handler =3D handle_core_open,
                 .cmd =3D "H",
-                //.cmd_startswith =3D 1,
-                .schema =3D "ss"
+                .schema =3D "s"
             };
             cmd_parser =3D &gen_core_open;
         }
@@ -420,20 +435,18 @@ int mcd_handle_packet(const char *line_buf)
             static const MCDCmdParseEntry detach_cmd_desc =3D {
                 .handler =3D handle_detach,
                 .cmd =3D "D",
-                //.cmd_startswith =3D 1,
-                //.schema =3D "?.l0"
             };
             cmd_parser =3D &detach_cmd_desc;
         }
         break;
     default:
-        //could not perform the command (because its unknown)
+        // could not perform the command (because its unknown)
         mcd_put_packet("");
         break;
     }
=20
     if (cmd_parser) {
-        //now parse commands and run the selected function (handler)
+        // now parse commands and run the selected function (handler)
         run_cmd_parser(line_buf, cmd_parser);
     }
=20
@@ -484,63 +497,16 @@ void run_cmd_parser(const char *data, const MCDCmdPar=
seEntry *cmd)
 int cmd_parse_params(const char *data, const char *schema, GArray *params)
 {
     MCDCmdVariant this_param;
-    this_param.data =3D data;
-    g_array_append_val(params, this_param);
-    /*
-    const char *curr_schema, *curr_data;
=20
-    g_assert(schema);
-    g_assert(params->len =3D=3D 0);
-
-    curr_schema =3D schema;
-    curr_data =3D data;
-    while (curr_schema[0] && curr_schema[1] && *curr_data) {
-        GdbCmdVariant this_param;
-
-        switch (curr_schema[0]) {
-        case 'l':
-            if (qemu_strtoul(curr_data, &curr_data, 16,
-                             &this_param.val_ul)) {
-                return -EINVAL;
-            }
-            curr_data =3D cmd_next_param(curr_data, curr_schema[1]);
-            g_array_append_val(params, this_param);
-            break;
-        case 'L':
-            if (qemu_strtou64(curr_data, &curr_data, 16,
-                              (uint64_t *)&this_param.val_ull)) {
-                return -EINVAL;
-            }
-            curr_data =3D cmd_next_param(curr_data, curr_schema[1]);
-            g_array_append_val(params, this_param);
-            break;
-        case 's':
-            this_param.data =3D curr_data;
-            curr_data =3D cmd_next_param(curr_data, curr_schema[1]);
-            g_array_append_val(params, this_param);
-            break;
-        case 'o':
-            this_param.opcode =3D *(uint8_t *)curr_data;
-            curr_data =3D cmd_next_param(curr_data, curr_schema[1]);
-            g_array_append_val(params, this_param);
-            break;
-        case 't':
-            this_param.thread_id.kind =3D
-                read_thread_id(curr_data, &curr_data,
-                               &this_param.thread_id.pid,
-                               &this_param.thread_id.tid);
-            curr_data =3D cmd_next_param(curr_data, curr_schema[1]);
-            g_array_append_val(params, this_param);
-            break;
-        case '?':
-            curr_data =3D cmd_next_param(curr_data, curr_schema[1]);
-            break;
-        default:
-            return -EINVAL;
-        }
-        curr_schema +=3D 2;
+    if (schema[0] =3D=3D 's') {
+        this_param.data =3D data;
+        g_array_append_val(params, this_param);
     }
-    */
+    else if (schema[0] =3D=3D 'i') {
+        this_param.index_handle =3D atoi(data);
+    g_array_append_val(params, this_param);
+    }
+
     return 0;
=20=20=20=20=20
 }
@@ -566,7 +532,7 @@ int process_string_cmd(void *user_ctx, const char *data=
, const MCDCmdParseEntry
=20
         // if a schema is provided we need to extract parameters from the =
data string
         if (cmd->schema) {
-            //currently doing nothing
+            // this only gets the data from data beginning after the comma=
nd name
             if (cmd_parse_params(&data[strlen(cmd->cmd)], cmd->schema, par=
ams)) {
                 return -1;
             }
@@ -610,7 +576,6 @@ void mcd_chr_event(void *opaque, QEMUChrEvent event)
         }
=20
         s->c_cpu =3D mcd_first_attached_cpu();
-        s->g_cpu =3D s->c_cpu;
=20
         vm_stop(RUN_STATE_PAUSED);
 		//TODO: this might not be necessary
@@ -812,7 +777,6 @@ void mcd_set_stop_cpu(CPUState *cpu)
     }
     //FIXME: we probably can delete this because in the opern_core functio=
n we set these two anyway
     mcdserver_state.c_cpu =3D cpu;
-    mcdserver_state.g_cpu =3D cpu;
 }
=20
 MCDProcess *mcd_get_cpu_process(CPUState *cpu)
@@ -888,35 +852,6 @@ CPUState *mcd_next_attached_cpu(CPUState *cpu)
=20
     return cpu;
 }
-/*
-void handle_query_first_threads(GArray *params, void *user_ctx)
-{
-    // chache the first cpu
-    mcdserver_state.query_cpu =3D mcd_first_attached_cpu();
-    // new answer over tcp
-    handle_query_threads(params, user_ctx);
-}
-
-void handle_query_threads(GArray *params, void *user_ctx)
-{
-    if (!mcdserver_state.query_cpu) {
-        // send packet back that that there is no more threads
-        //gdb_put_packet("l");
-        return;
-    }
-
-    g_string_assign(mcdserver_state.str_buf, "m");
-    mcd_append_thread_id(mcdserver_state.query_cpu, mcdserver_state.str_bu=
f);
-    mcd_put_strbuf();
-    mcdserver_state.query_cpu =3D mcd_next_attached_cpu(mcdserver_state.qu=
ery_cpu);
-}
-
-
-void mcd_append_thread_id(CPUState *cpu, GString *buf)
-{
-    g_string_append_printf(buf, "p%02x.%02x", mcd_get_cpu_pid(cpu), mcd_ge=
t_cpu_index(cpu));
-}
-*/
=20
 int mcd_get_cpu_index(CPUState *cpu)
 {
@@ -950,6 +885,34 @@ CPUState *find_cpu(uint32_t thread_id)
     return NULL;
 }
=20
+void handle_init(GArray *params, void *user_ctx) {
+    CPUState *cpu =3D mcdserver_state.c_cpu;
+    CPUClass *cc =3D CPU_GET_CLASS(cpu);
+
+    gchar *arch =3D cc->gdb_arch_name(cpu);
+
+    // store reg groups
+    if (strcmp(arch, "arm")=3D=3D0) {
+        // at the moment we just assume there are 3 spaces (gpr, per and d=
ebug)
+        // TODO: this might cause a memory leak when called a second time =
-> maybe free the Garray first
+        mcdserver_state.reggroups =3D g_array_new(false, true, sizeof(mcd_=
reg_group_st));
+
+        mcd_reg_group_st group1 =3D { .name =3D "GPR Registers", .id =3D "=
1" };
+        g_array_append_vals(mcdserver_state.reggroups, (gconstpointer)&gro=
up1, 1);
+
+        mcd_reg_group_st group2 =3D { .name =3D "CP15 Registers", .id =3D =
"2" };
+        g_array_append_vals(mcdserver_state.reggroups, (gconstpointer)&gro=
up2, 1);
+    }
+    else {
+        // we don't support other architectures
+        assert(1);
+    }
+    g_free(arch);
+
+    // the mcdserver is set up and we return the handshake
+    mcd_put_packet("shaking your hand");
+}
+
 void handle_query_system(GArray *params, void *user_ctx) {
     mcd_put_packet("qemu-system");
 }
@@ -988,7 +951,6 @@ void handle_core_open(GArray *params, void *user_ctx) {
=20
     // select the the cpu as the current cpu for all request from the mcd =
interface
     mcdserver_state.c_cpu =3D cpu;
-    mcdserver_state.g_cpu =3D cpu;
=20
 }
=20
@@ -1016,10 +978,6 @@ void handle_detach(GArray *params, void *user_ctx) {
         mcdserver_state.c_cpu =3D mcd_first_attached_cpu();
     }
=20
-    if (pid =3D=3D mcd_get_cpu_pid(mcdserver_state.g_cpu)) {
-        mcdserver_state.g_cpu =3D mcd_first_attached_cpu();
-    }
-
     if (!mcdserver_state.c_cpu) {
         /* No more process attached */
         mcd_disable_syscalls();
@@ -1035,7 +993,7 @@ void handle_query_trigger(GArray *params, void *user_c=
tx) {
     uint32_t action =3D (MCD_TRIG_ACTION_DBG_DEBUG);
     uint32_t nr_trigger =3D 4;
=20
-    g_string_append_printf(mcdserver_state.str_buf, "nr=3D\"%d\",info=3D\"=
%d;%d;%d;\"", nr_trigger, type, option, action);
+    g_string_printf(mcdserver_state.str_buf, "nr=3D\"%d\",info=3D\"%d;%d;%=
d;\"", nr_trigger, type, option, action);
     mcd_put_strbuf();
 }
=20
@@ -1045,3 +1003,65 @@ void mcd_continue(void)
         vm_start();
     }
 }
+
+void handle_query_mem_spaces(GArray *params, void *user_ctx) {
+    // this returns the address spaces
+    // first we check if this is an arm architecture
+    // if it is arm we assume that if there are 2 address spaces, these ar=
e secure and non-secure (EL3 and EL0 for 64 bit)
+    CPUState *cpu =3D mcdserver_state.c_cpu;
+    CPUClass *cc =3D CPU_GET_CLASS(cpu);
+
+    int nr_address_spaces =3D cpu->num_ases;
+    gchar *arch =3D cc->gdb_arch_name(cpu);
+
+    if (strcmp(arch, "arm")=3D=3D0) {
+        // we got secure and non-secure
+        g_string_printf(mcdserver_state.str_buf, "Non Secure=3Did:1;type:3=
4;bpm:8;i:1;e:1;min:0;max:-1;sao:0;.");
+        g_string_append_printf(mcdserver_state.str_buf, "Physical (Non Sec=
ure)=3Did:2;type:18;bpm:8;i:1;e:1;min:0;max:-1;sao:0;.");
+        if (nr_address_spaces=3D=3D2) {
+            g_string_append_printf(mcdserver_state.str_buf, "Secure=3Did:3=
;type:34;bpm:8;i:1;e:1;min:0;max:-1;sao:0;.");
+            g_string_append_printf(mcdserver_state.str_buf, "Physical (Sec=
ure)=3Did:4;type:18;bpm:8;i:1;e:1;min:0;max:-1;sao:0;.");
+        }
+
+        // provide register spaces
+        // TODO: get dynamically how the per (CP15) space is called
+        g_string_append_printf(mcdserver_state.str_buf, "GPR Registers=3Di=
d:5;type:1;bpm:64;i:1;e:1;min:0;max:-1;sao:0;.");
+        g_string_append_printf(mcdserver_state.str_buf, "CP15 Registers=3D=
id:6;type:1;bpm:32;i:1;e:1;min:0;max:-1;sao:0;."); //<-- per registers
+        //g_string_append_printf(mcdserver_state.str_buf, "CP14 Registers=
=3Dtype:1;bpm:32;i:1;e:1;min:0;max:-1;sao:0;."); // <-- debug registers
+    }
+    else {
+        // we don't support other architectures
+        assert(1);
+    }
+    g_free(arch);
+    mcd_put_strbuf();
+}
+
+void handle_query_reg_groups_f(GArray *params, void *user_ctx) {
+    // send the first reg group
+    mcd_reg_group_st group =3D g_array_index(mcdserver_state.reggroups, mc=
d_reg_group_st, 0);
+    g_string_printf(mcdserver_state.str_buf, "1!id=3D%s.name=3D%s.", group=
.id, group.name);
+    mcd_put_strbuf();
+}
+
+void handle_query_reg_groups_c(GArray *params, void *user_ctx) {
+    // this funcitons send all reg groups exept for the first
+    // 1. get parameter
+    int query_index =3D get_param(params, 0)->index_handle;
+
+    // 2. check weather this was the last reg group
+    int nb_groups =3D mcdserver_state.reggroups->len;
+    if (query_index+1 =3D=3D nb_groups) {
+        // indicates this is the last packet
+        g_string_printf(mcdserver_state.str_buf, "0!");
+    }
+    else {
+        // provides
+        g_string_printf(mcdserver_state.str_buf, "%d!", query_index+1);
+    }
+
+    // 3. send the correct reggroup
+    mcd_reg_group_st group =3D g_array_index(mcdserver_state.reggroups, mc=
d_reg_group_st, query_index);
+    g_string_append_printf(mcdserver_state.str_buf, "id=3D%s.name=3D%s.", =
group.id, group.name);
+    mcd_put_strbuf();
+}
--=20
2.34.1


From 4e5b0cb290eddd633407bc37322e437422ee5897 Mon Sep 17 00:00:00 2001
From: Nicolas Eder <nicolas.eder@lauterbach.com>
Date: Fri, 23 Jun 2023 18:12:42 +0200
Subject: [PATCH 06/29] query for registers added

Signed-off-by: Nicolas Eder <nicolas.eder@lauterbach.com>
---
 mcdstub/internals.h    |  55 +++++--
 mcdstub/mcdstub.c      | 320 ++++++++++++++++++++++++++++++++++++++---
 target/arm/meson.build |   1 +
 3 files changed, 344 insertions(+), 32 deletions(-)

diff --git a/mcdstub/internals.h b/mcdstub/internals.h
index 8df535e92a..45ba1ca8cb 100644
--- a/mcdstub/internals.h
+++ b/mcdstub/internals.h
@@ -8,6 +8,8 @@
=20
 #include "exec/cpu-common.h"
 #include "chardev/char.h"
+// just used for the register xml files
+#include "exec/gdbstub.h"       /* xml_builtin */
=20
 #define MAX_PACKET_LENGTH 1024
=20
@@ -19,6 +21,15 @@
 #define MCD_TRIG_OPT_DATA_IS_CONDITION 0x00000008
 #define MCD_TRIG_ACTION_DBG_DEBUG 0x00000001
=20
+// GDB stuff thats needed for GDB function, which we use
+typedef struct GDBRegisterState {
+    int base_reg;
+    int num_regs;
+    gdb_get_reg_cb get_reg;
+    gdb_set_reg_cb set_reg;
+    const char *xml;
+    struct GDBRegisterState *next;
+} GDBRegisterState;
=20
 /*
  * struct for an MCD Process, each process can establish one connection
@@ -75,10 +86,6 @@ enum RSState {
     RS_IDLE,
     RS_GETLINE,
     RS_DATAEND,
-    //RS_GETLINE_ESC,
-    //RS_GETLINE_RLE,
-    //RS_CHKSUM1,
-    //RS_CHKSUM2,
 };
=20
 typedef struct MCDState {
@@ -103,6 +110,7 @@ typedef struct MCDState {
=20
     // my stuff
     GArray *reggroups;
+    GArray *registers;
 } MCDState;
=20
 /* lives in main mcdstub.c */
@@ -110,9 +118,34 @@ extern MCDState mcdserver_state;
=20
 typedef struct mcd_reg_group_st {
     const char *name;
-    const char *id;
+    uint32_t id;
 } mcd_reg_group_st;
=20
+typedef struct xml_attrib {
+    char argument[64];
+    char value[64];
+} xml_attrib;
+
+typedef struct mcd_reg_st {
+    // xml info
+    char name[64];
+    char group[64];
+    char type[64];
+    uint32_t bitsize;
+    uint32_t id;
+    // mcd metadata
+    uint32_t mcd_reg_group_id;
+    uint32_t mcd_mem_space_id;
+    uint32_t mcd_reg_type;
+    uint32_t mcd_hw_thread_id;
+    // data for op-code
+    uint8_t cp;
+    uint8_t crn;
+    uint8_t crm;
+    uint8_t opc0; // <- might not be needed!
+    uint8_t opc1;
+    uint8_t opc2;
+} mcd_reg_st;
=20
 // Inline utility function, convert from int to hex and back
=20
@@ -139,12 +172,6 @@ static inline int tohex(int v)
     }
 }
=20
-
-/*old functions
-void mcd_init_mcdserver_state(void);
-int mcd_open_tcp_socket(int tcp_port);
-int mcd_extract_tcp_port_num(const char *in_string, char *out_string);
-*/
 #ifndef _WIN32
 void mcd_sigterm_handler(int signal);
 #endif
@@ -194,10 +221,16 @@ void mcd_continue(void);
 void handle_query_mem_spaces(GArray *params, void *user_ctx);
 void handle_query_reg_groups_f(GArray *params, void *user_ctx);
 void handle_query_reg_groups_c(GArray *params, void *user_ctx);
+void handle_query_regs_f(GArray *params, void *user_ctx);
+void handle_query_regs_c(GArray *params, void *user_ctx);
 void handle_init(GArray *params, void *user_ctx);
+void parse_reg_xml(const char *xml, int size);
=20
 /* sycall handling */
 void mcd_syscall_reset(void);
 void mcd_disable_syscalls(void);
=20
+// helpers
+int int_cmp(gconstpointer a, gconstpointer b);
+
 #endif /* MCDSTUB_INTERNALS_H */
diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index 9817f0893c..81026a42a1 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -8,7 +8,6 @@
 #include "qemu/cutils.h"
 #include "qemu/module.h"
 #include "qemu/error-report.h"
-//#include "trace.h"
 #include "exec/mcdstub.h"
 #include "mcdstub/syscalls.h"
 #include "hw/cpu/cluster.h"
@@ -31,8 +30,10 @@
 #include "chardev/char-fe.h"
 #include "monitor/monitor.h"
=20
-// just used for the xml_builtin stuff
-//#include "exec/gdbstub.h"       /* xml_builtin */
+//architecture specific stuff
+#include "target/arm/mcdstub.h"
+
+// FIXME: delete the following line and check if it worked
 #include "hw/core/sysemu-cpu-ops.h"
=20
 typedef struct {
@@ -75,6 +76,15 @@ static const MCDCmdParseEntry mcd_gen_query_table[] =3D {
         .cmd =3D "reggroupc",
         .schema =3D "i",
     },
+    {
+        .handler =3D handle_query_regs_f,
+        .cmd =3D "regf",
+    },
+    {
+        .handler =3D handle_query_regs_c,
+        .cmd =3D "regc",
+        .schema =3D "i",
+    },
 };
=20
 void mcd_init_mcdserver_state(void)
@@ -494,21 +504,21 @@ void run_cmd_parser(const char *data, const MCDCmdPar=
seEntry *cmd)
     }
 }
=20
-int cmd_parse_params(const char *data, const char *schema, GArray *params)
-{
+int cmd_parse_params(const char *data, const char *schema, GArray *params)=
 {
     MCDCmdVariant this_param;
=20
+    char data_buffer[64] =3D {0};
     if (schema[0] =3D=3D 's') {
         this_param.data =3D data;
         g_array_append_val(params, this_param);
     }
     else if (schema[0] =3D=3D 'i') {
-        this_param.index_handle =3D atoi(data);
-    g_array_append_val(params, this_param);
+        strncat(data_buffer, data, strlen(data));
+        this_param.index_handle =3D atoi(data_buffer);
+        g_array_append_val(params, this_param);
     }
=20
     return 0;
-=20=20=20=20
 }
=20
 int process_string_cmd(void *user_ctx, const char *data, const MCDCmdParse=
Entry *cmds, int num_cmds)
@@ -885,23 +895,248 @@ CPUState *find_cpu(uint32_t thread_id)
     return NULL;
 }
=20
+
+void parse_reg_xml(const char *xml, int size) {
+    // iterates over the complete xml file
+    int i, j;
+    int still_to_skip =3D 0;
+    char argument[64] =3D {0};
+    char value[64] =3D {0};
+    bool is_reg =3D false;
+    bool is_argument =3D false;
+    bool is_value =3D false;
+    GArray *reg_data;
+
+    char c;
+    char *c_ptr;
+
+    xml_attrib attribute_j;
+    const char *argument_j;
+    const char *value_j;
+
+    for (i =3D 0; i < size; i++) {
+        c =3D xml[i];
+        c_ptr =3D &c;
+
+        if (still_to_skip>0) {
+            // skip chars unwanted chars
+            still_to_skip --;
+            continue;
+        }
+
+        if (strncmp(&xml[i], "<reg", 4)=3D=3D0) {
+            // start of a register
+            still_to_skip =3D 3;
+            is_reg =3D true;
+            reg_data =3D g_array_new(false, true, sizeof(xml_attrib));
+        }
+        else if (is_reg) {
+            if (strncmp(&xml[i], "/>", 2)=3D=3D0) {
+                // end of register info
+                still_to_skip =3D 1;
+                is_reg =3D false;
+
+                // create empty register
+                mcd_reg_st my_register =3D (const struct mcd_reg_st){ 0 };
+
+                // add found attribtues
+                for (j =3D 0; j<reg_data->len; j++) {
+                    attribute_j =3D g_array_index(reg_data, xml_attrib, j);
+
+                    argument_j =3D attribute_j.argument;
+                    value_j =3D attribute_j.value;
+
+                    if (strcmp(argument_j, "name")=3D=3D0) {
+                        strcpy(my_register.name, value_j);
+                    }
+                    else if (strcmp(argument_j, "regnum")=3D=3D0) {
+                        my_register.id =3D atoi(value_j);
+                    }
+                    else if (strcmp(argument_j, "bitsize")=3D=3D0) {
+                        my_register.bitsize =3D atoi(value_j);
+                    }
+                    else if (strcmp(argument_j, "type")=3D=3D0) {
+                        strcpy(my_register.type, value_j);
+                    }
+                    else if (strcmp(argument_j, "group")=3D=3D0) {
+                        strcpy(my_register.group, value_j);
+                    }
+                }
+                // store register
+                g_array_append_vals(mcdserver_state.registers, (gconstpoin=
ter)&my_register, 1);
+                // free memory
+                g_array_free(reg_data, false);
+            }
+            else {
+                // store info for register
+                switch (c) {
+                    case ' ':
+                        break;
+                    case '=3D':
+                        is_argument =3D false;
+                        break;
+                    case '"':
+                        if (is_value) {
+                            // end of value reached
+                            is_value =3D false;
+                            // store arg-val combo
+                            xml_attrib current_attribute;
+                            strcpy(current_attribute.argument, argument);
+                            strcpy(current_attribute.value, value);
+                            g_array_append_vals(reg_data, (gconstpointer)&=
current_attribute, 1);
+                            memset(argument, 0, sizeof(argument));
+                            memset(value, 0, sizeof(value));
+                        }
+                        else {
+                            //start of value
+                            is_value =3D true;
+                        }
+                        break;
+                    default:
+                        if (is_argument) {
+                            strncat(argument, c_ptr, 1);
+                        }
+                        else if (is_value) {
+                            strncat(value, c_ptr, 1);
+                        }
+                        else {
+                            is_argument =3D true;
+                            strncat(argument, c_ptr, 1);
+                        }
+                        break;
+                }
+            }
+        }
+    }
+}
+
+int int_cmp(gconstpointer a, gconstpointer b) {
+    int a_int =3D *(int*)a;
+    int b_int =3D *(int*)b;
+    if (a_int =3D=3D b_int) {
+        return 0;
+    }
+    else {
+        return 1;
+    }
+}
+
 void handle_init(GArray *params, void *user_ctx) {
     CPUState *cpu =3D mcdserver_state.c_cpu;
     CPUClass *cc =3D CPU_GET_CLASS(cpu);
=20
     gchar *arch =3D cc->gdb_arch_name(cpu);
=20
-    // store reg groups
+=20=20=20=20
     if (strcmp(arch, "arm")=3D=3D0) {
+        // store reg groups
+        uint32_t current_group_id =3D 0;
+
         // at the moment we just assume there are 3 spaces (gpr, per and d=
ebug)
         // TODO: this might cause a memory leak when called a second time =
-> maybe free the Garray first
         mcdserver_state.reggroups =3D g_array_new(false, true, sizeof(mcd_=
reg_group_st));
=20
-        mcd_reg_group_st group1 =3D { .name =3D "GPR Registers", .id =3D "=
1" };
+        // store the registers themselves
+        mcdserver_state.registers =3D g_array_new(false, true, sizeof(mcd_=
reg_st));
+        GList *register_numbers =3D NULL;
+
+        const char *xml_filename =3D NULL;
+        const char *xml_content =3D NULL;
+        const char *name =3D NULL;
+        int i;
+
+        // 1. check out the core xml file
+        xml_filename =3D cc->gdb_core_xml_file;
+
+        for (i =3D 0; ; i++) {
+                name =3D xml_builtin[i][0];
+                if (!name || (strncmp(name, xml_filename, strlen(xml_filen=
ame)) =3D=3D 0 && strlen(name) =3D=3D strlen(xml_filename)))
+                break;
+            }
+        // without gpr registers we can do nothing
+        assert(name);
+        // add group for gpr registers
+        current_group_id =3D 1;
+        mcd_reg_group_st group1 =3D { .name =3D "GPR Registers", .id =3D c=
urrent_group_id };
         g_array_append_vals(mcdserver_state.reggroups, (gconstpointer)&gro=
up1, 1);
=20
-        mcd_reg_group_st group2 =3D { .name =3D "CP15 Registers", .id =3D =
"2" };
-        g_array_append_vals(mcdserver_state.reggroups, (gconstpointer)&gro=
up2, 1);
+        // parse xml
+        xml_content =3D xml_builtin[i][1];
+        parse_reg_xml(xml_content, strlen(xml_content));
+
+        // 2. iterate over all other xml files
+        GDBRegisterState *r;
+        for (r =3D cpu->gdb_regs; r; r =3D r->next) {
+            xml_filename =3D r->xml;
+            xml_content =3D NULL;
+
+            // first, check if this is a coprocessor xml
+
+            // funciton call
+            xml_content =3D arm_mcd_get_dynamic_xml(cpu, xml_filename);
+            if (xml_content) {
+                if (strcmp(xml_filename, "system-registers.xml")=3D=3D0) {
+                    //these are the coprocessor register
+                    current_group_id =3D 2;
+                    mcd_reg_group_st group2 =3D { .name =3D "CP15 Register=
s", .id =3D current_group_id };
+                    g_array_append_vals(mcdserver_state.reggroups, (gconst=
pointer)&group2, 1);
+                }
+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
+            }
+            else {
+                // its not a coprocessor xml -> it is a static xml file
+                for (i =3D 0; ; i++) {
+                    name =3D xml_builtin[i][0];
+                    if (!name || (strncmp(name, xml_filename, strlen(xml_f=
ilename)) =3D=3D 0 && strlen(name) =3D=3D strlen(xml_filename)))
+                    break;
+                }
+                if (name) {
+                    xml_content =3D xml_builtin[i][1];
+                }
+                else {
+                    printf("no data found for %s\n", xml_filename);
+                    continue;
+                }
+            }
+
+            // parse xml
+            parse_reg_xml(xml_content, strlen(xml_content));
+        }
+        // go over the register array and collect all additional data
+        mcd_reg_st *current_register;
+        int id_neg_offset =3D 0;
+        int effective_id;
+        for (i =3D 0; i < mcdserver_state.registers->len; i++) {
+            current_register =3D &(g_array_index(mcdserver_state.registers=
, mcd_reg_st, i));
+            // ad an id handle
+            if (current_register->id) {
+                // id is already in place
+                //FIXME: we are missing 10 registers (likely the FPA regs =
or sth)
+                int used_id =3D current_register->id;
+                register_numbers =3D g_list_append(register_numbers, &used=
_id);
+                id_neg_offset ++;
+            }
+            else {
+                effective_id =3D i - id_neg_offset;
+                if (g_list_find_custom(register_numbers, &effective_id, (G=
CompareFunc)int_cmp)!=3DNULL) {
+                    id_neg_offset --;
+                }
+                current_register->id =3D i - id_neg_offset;
+            }
+            // sort into correct reg_group and according mem_space
+            if (strcmp(current_register->group, "cp_regs")=3D=3D0) {
+                current_register->mcd_reg_group_id =3D 2;
+                current_register->mcd_mem_space_id =3D 6;
+                // get info for opcode
+            }
+            else {
+                // gpr register
+                current_register->mcd_reg_group_id =3D 1;
+                current_register->mcd_mem_space_id =3D 5;
+            }
+        }
+        // free memory
+        g_list_free(register_numbers);
     }
     else {
         // we don't support other architectures
@@ -910,7 +1145,7 @@ void handle_init(GArray *params, void *user_ctx) {
     g_free(arch);
=20
     // the mcdserver is set up and we return the handshake
-    mcd_put_packet("shaking your hand");
+    mcd_put_packet("shaking your hand");=20
 }
=20
 void handle_query_system(GArray *params, void *user_ctx) {
@@ -932,10 +1167,6 @@ void handle_query_cores(GArray *params, void *user_ct=
x) {
     CPUClass *cc =3D CPU_GET_CLASS(cpu);
     gchar *arch =3D cc->gdb_arch_name(cpu);
=20=20=20=20=20
-    //const char *cpu_name =3D object_get_canonical_path_component(OBJECT(=
cpu));
-    //int process_id =3D mcd_get_cpu_pid(cpu);
-    //int cpu_index =3D cpu->cpu_index;
-    //int cpu_cluster =3D cpu->cluster_index;
     int nr_cores =3D cpu->nr_cores;
=20
     g_string_append_printf(mcdserver_state.str_buf, "device=3D\"qemu-%s-de=
vice\",core=3D\"%s\",nr_cores=3D\"%d\"", arch, cpu_model, nr_cores);
@@ -1039,13 +1270,21 @@ void handle_query_mem_spaces(GArray *params, void *=
user_ctx) {
=20
 void handle_query_reg_groups_f(GArray *params, void *user_ctx) {
     // send the first reg group
+    int nb_groups =3D mcdserver_state.reggroups->len;
+    if (nb_groups =3D=3D 1) {
+        // indicates this is the last packet
+        g_string_printf(mcdserver_state.str_buf, "0!");
+    }
+    else {
+        g_string_printf(mcdserver_state.str_buf, "1!");
+    }
     mcd_reg_group_st group =3D g_array_index(mcdserver_state.reggroups, mc=
d_reg_group_st, 0);
-    g_string_printf(mcdserver_state.str_buf, "1!id=3D%s.name=3D%s.", group=
.id, group.name);
+    g_string_append_printf(mcdserver_state.str_buf, "id=3D%d.name=3D%s.", =
group.id, group.name);
     mcd_put_strbuf();
 }
=20
 void handle_query_reg_groups_c(GArray *params, void *user_ctx) {
-    // this funcitons send all reg groups exept for the first
+    // this funcitons send all reg groups except for the first
     // 1. get parameter
     int query_index =3D get_param(params, 0)->index_handle;
=20
@@ -1056,12 +1295,51 @@ void handle_query_reg_groups_c(GArray *params, void=
 *user_ctx) {
         g_string_printf(mcdserver_state.str_buf, "0!");
     }
     else {
-        // provides
         g_string_printf(mcdserver_state.str_buf, "%d!", query_index+1);
     }
=20
     // 3. send the correct reggroup
     mcd_reg_group_st group =3D g_array_index(mcdserver_state.reggroups, mc=
d_reg_group_st, query_index);
-    g_string_append_printf(mcdserver_state.str_buf, "id=3D%s.name=3D%s.", =
group.id, group.name);
+    g_string_append_printf(mcdserver_state.str_buf, "id=3D%d.name=3D%s.", =
group.id, group.name);
+    mcd_put_strbuf();
+}
+
+void handle_query_regs_f(GArray *params, void *user_ctx) {
+    // send the first register
+    int nb_regs =3D mcdserver_state.registers->len;
+    if (nb_regs =3D=3D 1) {
+        // indicates this is the last packet
+        g_string_printf(mcdserver_state.str_buf, "0!");
+    }
+    else {
+        g_string_printf(mcdserver_state.str_buf, "1!");
+    }
+    mcd_reg_st my_register =3D g_array_index(mcdserver_state.registers, mc=
d_reg_st, 0);
+    g_string_append_printf(mcdserver_state.str_buf, "id=3D%d.name=3D%s.siz=
e=3D%d.reggroupid=3D%d.memspaceid=3D%d.type=3D%d.thread=3D%d.",
+        my_register.id, my_register.name, my_register.bitsize, my_register=
.mcd_reg_group_id,
+        my_register.mcd_mem_space_id, my_register.mcd_reg_type, my_registe=
r.mcd_hw_thread_id);
+    mcd_put_strbuf();
+}
+
+void handle_query_regs_c(GArray *params, void *user_ctx) {
+    // this funcitons send all registers except for the first
+    // 1. get parameter
+    int query_index =3D get_param(params, 0)->index_handle;
+
+    // 2. check weather this was the last register
+    int nb_regs =3D mcdserver_state.registers->len;
+    if (query_index+1 =3D=3D nb_regs) {
+        // indicates this is the last packet
+        g_string_printf(mcdserver_state.str_buf, "0!");
+    }
+    else {
+        g_string_printf(mcdserver_state.str_buf, "%d!", query_index+1);
+    }
+
+    // 3. send the correct register
+    mcd_reg_st my_register =3D g_array_index(mcdserver_state.registers, mc=
d_reg_st, query_index);
+    g_string_append_printf(mcdserver_state.str_buf, "id=3D%d.name=3D%s.siz=
e=3D%d.reggroupid=3D%d.memspaceid=3D%d.type=3D%d.thread=3D%d.",
+        my_register.id, my_register.name, my_register.bitsize, my_register=
.mcd_reg_group_id,
+        my_register.mcd_mem_space_id, my_register.mcd_reg_type, my_registe=
r.mcd_hw_thread_id);
     mcd_put_strbuf();
 }
diff --git a/target/arm/meson.build b/target/arm/meson.build
index e645e456da..71ff10316f 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -3,6 +3,7 @@ arm_ss.add(files(
   'cpu.c',
   'debug_helper.c',
   'gdbstub.c',
+  'mcdstub.c',
   'helper.c',
   'vfp_helper.c',
 ))
--=20
2.34.1


From 304f3b11febb1a0f3350cbcdd362929746dc807a Mon Sep 17 00:00:00 2001
From: Nicolas Eder <nicolas.eder@lauterbach.com>
Date: Mon, 26 Jun 2023 17:19:41 +0200
Subject: [PATCH 07/29] query data preparation improved

Signed-off-by: Nicolas Eder <nicolas.eder@lauterbach.com>
---
 mcdstub/internals.h |  35 +++-
 mcdstub/mcdstub.c   | 382 ++++++++++++++++++++++----------------------
 2 files changed, 215 insertions(+), 202 deletions(-)

diff --git a/mcdstub/internals.h b/mcdstub/internals.h
index 45ba1ca8cb..2f9a768038 100644
--- a/mcdstub/internals.h
+++ b/mcdstub/internals.h
@@ -21,6 +21,11 @@
 #define MCD_TRIG_OPT_DATA_IS_CONDITION 0x00000008
 #define MCD_TRIG_ACTION_DBG_DEBUG 0x00000001
=20
+// schema defines
+#define ARG_SCHEMA_QRY_HANDLE "q"
+#define ARG_SCHEMA_STRING "s"
+#define ARG_SCHEMA_CORE_NUM "c"=20
+
 // GDB stuff thats needed for GDB function, which we use
 typedef struct GDBRegisterState {
     int base_reg;
@@ -60,17 +65,16 @@ typedef enum MCDThreadIdKind {
=20
 typedef union MCDCmdVariant {
     const char *data;
-    uint8_t opcode;
-    unsigned long val_ul;
-    unsigned long long val_ull;
+=20=20=20=20
     struct {
         MCDThreadIdKind kind;
         uint32_t pid;
         uint32_t tid;
     } thread_id;
=20
-    // used to synchronize stub and dll for functions with multiple packets
-    int index_handle;
+    int query_handle;
+    int cpu_id;
+
 } MCDCmdVariant;
=20
 #define get_param(p, i)    (&g_array_index(p, MCDCmdVariant, i))
@@ -109,6 +113,7 @@ typedef struct MCDState {
     int supported_sstep_flags;
=20
     // my stuff
+    GArray *memspaces;
     GArray *reggroups;
     GArray *registers;
 } MCDState;
@@ -116,6 +121,18 @@ typedef struct MCDState {
 /* lives in main mcdstub.c */
 extern MCDState mcdserver_state;
=20
+typedef struct mcd_mem_space_st {
+    const char *name;
+    uint32_t id;
+    uint32_t type;
+    uint32_t bits_per_mau;
+    uint8_t invariance;
+    uint32_t endian;
+    uint64_t min_addr;
+    uint64_t max_addr;
+    uint32_t supported_access_options;
+} mcd_mem_space_st;
+
 typedef struct mcd_reg_group_st {
     const char *name;
     uint32_t id;
@@ -213,19 +230,23 @@ void handle_query_cores(GArray *params, void *user_ct=
x);
 void handle_query_system(GArray *params, void *user_ctx);
 CPUState *get_first_cpu_in_process(MCDProcess *process);
 CPUState *find_cpu(uint32_t thread_id);
-void handle_core_open(GArray *params, void *user_ctx);
+void handle_open_core(GArray *params, void *user_ctx);
 void handle_query_reset(GArray *params, void *user_ctx);
 void handle_detach(GArray *params, void *user_ctx);
 void handle_query_trigger(GArray *params, void *user_ctx);
 void mcd_continue(void);
-void handle_query_mem_spaces(GArray *params, void *user_ctx);
 void handle_query_reg_groups_f(GArray *params, void *user_ctx);
 void handle_query_reg_groups_c(GArray *params, void *user_ctx);
+void handle_query_mem_spaces_f(GArray *params, void *user_ctx);
+void handle_query_mem_spaces_c(GArray *params, void *user_ctx);
 void handle_query_regs_f(GArray *params, void *user_ctx);
 void handle_query_regs_c(GArray *params, void *user_ctx);
 void handle_init(GArray *params, void *user_ctx);
 void parse_reg_xml(const char *xml, int size);
=20
+// arm specific functions
+void mcd_arm_store_mem_spaces(int nr_address_spaces);
+
 /* sycall handling */
 void mcd_syscall_reset(void);
 void mcd_disable_syscalls(void);
diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index 81026a42a1..b3ec3af543 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -2,6 +2,8 @@
  * This is the main mcdstub. It needs to be complemented by other mcd stub=
s for each target.
  */
=20
+#include "mcd_shared_defines.h"
+
 //from original gdbstub.c
 #include "qemu/osdep.h"
 #include "qemu/ctype.h"
@@ -64,8 +66,13 @@ static const MCDCmdParseEntry mcd_gen_query_table[] =3D {
         .cmd =3D "trigger",
     },
     {
-        .handler =3D handle_query_mem_spaces,
-        .cmd =3D "memory",
+        .handler =3D handle_query_mem_spaces_f,
+        .cmd =3D "memoryf",
+    },
+    {
+        .handler =3D handle_query_mem_spaces_c,
+        .cmd =3D "memoryc",
+        .schema =3D ARG_SCHEMA_QRY_HANDLE,
     },
     {
         .handler =3D handle_query_reg_groups_f,
@@ -74,7 +81,7 @@ static const MCDCmdParseEntry mcd_gen_query_table[] =3D {
     {
         .handler =3D handle_query_reg_groups_c,
         .cmd =3D "reggroupc",
-        .schema =3D "i",
+        .schema =3D ARG_SCHEMA_QRY_HANDLE,
     },
     {
         .handler =3D handle_query_regs_f,
@@ -83,7 +90,7 @@ static const MCDCmdParseEntry mcd_gen_query_table[] =3D {
     {
         .handler =3D handle_query_regs_c,
         .cmd =3D "regc",
-        .schema =3D "i",
+        .schema =3D ARG_SCHEMA_QRY_HANDLE,
     },
 };
=20
@@ -424,20 +431,19 @@ int mcd_handle_packet(const char *line_buf)
             static const MCDCmdParseEntry gen_query_cmd_desc =3D {
                 .handler =3D handle_gen_query,
                 .cmd =3D "q",
-                .schema =3D "s"
+                .schema =3D ARG_SCHEMA_STRING
             };
             cmd_parser =3D &gen_query_cmd_desc;
         }
         break;
     case 'H':
-        //current alias for open core, later this will probably be a part =
of the 'i' requests
         {
-            static const MCDCmdParseEntry gen_core_open =3D {
-                .handler =3D handle_core_open,
+            static const MCDCmdParseEntry gen_open_core =3D {
+                .handler =3D handle_open_core,
                 .cmd =3D "H",
-                .schema =3D "s"
+                .schema =3D ARG_SCHEMA_CORE_NUM
             };
-            cmd_parser =3D &gen_core_open;
+            cmd_parser =3D &gen_open_core;
         }
         break;
     case 'D':
@@ -508,13 +514,18 @@ int cmd_parse_params(const char *data, const char *sc=
hema, GArray *params) {
     MCDCmdVariant this_param;
=20
     char data_buffer[64] =3D {0};
-    if (schema[0] =3D=3D 's') {
+    if (schema[0] =3D=3D atoi(ARG_SCHEMA_STRING)) {
         this_param.data =3D data;
         g_array_append_val(params, this_param);
     }
-    else if (schema[0] =3D=3D 'i') {
+    else if (schema[0] =3D=3D atoi(ARG_SCHEMA_QRY_HANDLE)) {
         strncat(data_buffer, data, strlen(data));
-        this_param.index_handle =3D atoi(data_buffer);
+        this_param.query_handle =3D atoi(data_buffer);
+        g_array_append_val(params, this_param);
+    }
+    else if (schema[0] =3D=3D atoi(ARG_SCHEMA_CORE_NUM)) {
+        strncat(data_buffer, data, strlen(data));
+        this_param.cpu_id =3D atoi(data_buffer);
         g_array_append_val(params, this_param);
     }
=20
@@ -618,97 +629,6 @@ void mcd_sigterm_handler(int signal)
 void mcd_vm_state_change(void *opaque, bool running, RunState state)
 {
 	printf("this calls state_change\n");
-	/*
-    CPUState *cpu =3D mcdserver_state.c_cpu;
-    g_autoptr(GString) buf =3D g_string_new(NULL);
-    g_autoptr(GString) tid =3D g_string_new(NULL);
-    const char *type;
-    int ret;
-
-    if (running || mcdserver_state.state =3D=3D RS_INACTIVE) {
-        return;
-    }
-
-    //Is there a GDB syscall waiting to be sent?
-    if (gdb_handled_syscall()) {
-        return;
-    }
-
-    if (cpu =3D=3D NULL) {
-        //No process attached
-        return;
-    }
-
-    gdb_append_thread_id(cpu, tid);
-
-    switch (state) {
-    case RUN_STATE_DEBUG:
-        if (cpu->watchpoint_hit) {
-            switch (cpu->watchpoint_hit->flags & BP_MEM_ACCESS) {
-            case BP_MEM_READ:
-                type =3D "r";
-                break;
-            case BP_MEM_ACCESS:
-                type =3D "a";
-                break;
-            default:
-                type =3D "";
-                break;
-            }
-            trace_gdbstub_hit_watchpoint(type,
-                                         gdb_get_cpu_index(cpu),
-                                         cpu->watchpoint_hit->vaddr);
-            g_string_printf(buf, "T%02xthread:%s;%swatch:%" VADDR_PRIx ";",
-                            GDB_SIGNAL_TRAP, tid->str, type,
-                            cpu->watchpoint_hit->vaddr);
-            cpu->watchpoint_hit =3D NULL;
-            goto send_packet;
-        } else {
-            trace_gdbstub_hit_break();
-        }
-        tb_flush(cpu);
-        ret =3D GDB_SIGNAL_TRAP;
-        break;
-    case RUN_STATE_PAUSED:
-        trace_gdbstub_hit_paused();
-        ret =3D GDB_SIGNAL_INT;
-        break;
-    case RUN_STATE_SHUTDOWN:
-        trace_gdbstub_hit_shutdown();
-        ret =3D GDB_SIGNAL_QUIT;
-        break;
-    case RUN_STATE_IO_ERROR:
-        trace_gdbstub_hit_io_error();
-        ret =3D GDB_SIGNAL_IO;
-        break;
-    case RUN_STATE_WATCHDOG:
-        trace_gdbstub_hit_watchdog();
-        ret =3D GDB_SIGNAL_ALRM;
-        break;
-    case RUN_STATE_INTERNAL_ERROR:
-        trace_gdbstub_hit_internal_error();
-        ret =3D GDB_SIGNAL_ABRT;
-        break;
-    case RUN_STATE_SAVE_VM:
-    case RUN_STATE_RESTORE_VM:
-        return;
-    case RUN_STATE_FINISH_MIGRATE:
-        ret =3D GDB_SIGNAL_XCPU;
-        break;
-    default:
-        trace_gdbstub_hit_unknown(state);
-        ret =3D GDB_SIGNAL_UNKNOWN;
-        break;
-    }
-    mcd_set_stop_cpu(cpu);
-    g_string_printf(buf, "T%02xthread:%s;", ret, tid->str);
-
-send_packet:
-    mcd_put_packet(buf->str);
-
-    // disable single step if it was enabled
-    cpu_single_step(cpu, 0);
-*/
 }
=20
 int mcd_put_packet(const char *buf)
@@ -726,14 +646,6 @@ void mcd_put_strbuf(void)
=20
 int mcd_put_packet_binary(const char *buf, int len, bool dump)
 {
-    //int csum, i;
-    //uint8_t footer[3];
-
-	//trace stuff
-    //if (dump && trace_event_get_state_backends(TRACE_GDBSTUB_IO_BINARYRE=
PLY)) {
-    //    hexdump(buf, len, trace_gdbstub_io_binaryreply);
-    //}
-
     for(;;) {
         //super interesting if we want a chekcsum or something like that h=
ere!!
         g_byte_array_set_size(mcdserver_state.last_packet, 0);
@@ -741,16 +653,7 @@ int mcd_put_packet_binary(const char *buf, int len, bo=
ol dump)
         g_byte_array_append(mcdserver_state.last_packet, (const uint8_t *)=
 buf, len);
         g_byte_array_append(mcdserver_state.last_packet, (const uint8_t *)=
 "#", 1);
         g_byte_array_append(mcdserver_state.last_packet, (const uint8_t *)=
 "|", 1);
-        /*
-        csum =3D 0;
-        for(i =3D 0; i < len; i++) {
-            csum +=3D buf[i];
-        }
-        footer[0] =3D '#';
-        footer[1] =3D tohex((csum >> 4) & 0xf);
-        footer[2] =3D tohex((csum) & 0xf);
-        g_byte_array_append(mcdserver_state.last_packet, footer, 3);
-        */
+
         mcd_put_buffer(mcdserver_state.last_packet->data, mcdserver_state.=
last_packet->len);
=20
         if (mcd_got_immediate_ack()) {
@@ -1021,23 +924,145 @@ int int_cmp(gconstpointer a, gconstpointer b) {
     }
 }
=20
+void mcd_arm_store_mem_spaces(int nr_address_spaces) {
+    mcd_mem_space_st space1 =3D {
+        .name =3D "Non Secure",
+        .id =3D 1,
+        .type =3D 34,
+        .bits_per_mau =3D 8,
+        .invariance =3D 1,
+        .endian =3D 1,
+        .min_addr =3D 0,
+        .max_addr =3D -1,
+        .supported_access_options =3D 0,
+    };
+    g_array_append_vals(mcdserver_state.memspaces, (gconstpointer)&space1,=
 1);
+
+    mcd_mem_space_st space2 =3D {
+        .name =3D "Physical (Non Secure)",
+        .id =3D 2,
+        .type =3D 18,
+        .bits_per_mau =3D 8,
+        .invariance =3D 1,
+        .endian =3D 1,
+        .min_addr =3D 0,
+        .max_addr =3D -1,
+        .supported_access_options =3D 0,
+    };
+    g_array_append_vals(mcdserver_state.memspaces, (gconstpointer)&space2,=
 1);
+
+    if (nr_address_spaces=3D=3D2) {
+        mcd_mem_space_st space3 =3D {
+        .name =3D "Secure",
+        .id =3D 3,
+        .type =3D 34,
+        .bits_per_mau =3D 8,
+        .invariance =3D 1,
+        .endian =3D 1,
+        .min_addr =3D 0,
+        .max_addr =3D -1,
+        .supported_access_options =3D 0,
+    };
+    g_array_append_vals(mcdserver_state.memspaces, (gconstpointer)&space3,=
 1);
+    mcd_mem_space_st space4 =3D {
+        .name =3D "Physical (Secure)",
+        .id =3D 4,
+        .type =3D 18,
+        .bits_per_mau =3D 8,
+        .invariance =3D 1,
+        .endian =3D 1,
+        .min_addr =3D 0,
+        .max_addr =3D -1,
+        .supported_access_options =3D 0,
+    };
+    g_array_append_vals(mcdserver_state.memspaces, (gconstpointer)&space4,=
 1);
+    }
+    // TODO: get dynamically how the per (CP15) space is called
+    mcd_mem_space_st space5 =3D {
+        .name =3D "GPR Registers",
+        .id =3D 5,
+        .type =3D 1,
+        .bits_per_mau =3D 8,
+        .invariance =3D 1,
+        .endian =3D 1,
+        .min_addr =3D 0,
+        .max_addr =3D -1,
+        .supported_access_options =3D 0,
+    };
+    g_array_append_vals(mcdserver_state.memspaces, (gconstpointer)&space5,=
 1);
+    mcd_mem_space_st space6 =3D {
+        .name =3D "CP15 Registers",
+        .id =3D 6,
+        .type =3D 1,
+        .bits_per_mau =3D 8,
+        .invariance =3D 1,
+        .endian =3D 1,
+        .min_addr =3D 0,
+        .max_addr =3D -1,
+        .supported_access_options =3D 0,
+    };
+    g_array_append_vals(mcdserver_state.memspaces, (gconstpointer)&space6,=
 1);
+}
+
 void handle_init(GArray *params, void *user_ctx) {
-    CPUState *cpu =3D mcdserver_state.c_cpu;
+    // the mcdserver is set up and we return the handshake
+    mcd_put_packet("shaking your hand");=20
+}
+
+void handle_query_system(GArray *params, void *user_ctx) {
+    mcd_put_packet("qemu-system");
+}
+
+void handle_query_cores(GArray *params, void *user_ctx) {
+    //TODO: add cluster support: in gdb each inferior (process) handles on=
e cluster we might want to have sth similar here
+
+    // get first cpu
+    CPUState *cpu =3D mcd_first_attached_cpu();
+    if (!cpu) {
+        return;
+    }
+
+    ObjectClass *oc =3D object_get_class(OBJECT(cpu));
+    const char *cpu_model =3D object_class_get_name(oc);
+
+    CPUClass *cc =3D CPU_GET_CLASS(cpu);
+    gchar *arch =3D cc->gdb_arch_name(cpu);
+=20=20=20=20
+    int nr_cores =3D cpu->nr_cores;
+
+    g_string_append_printf(mcdserver_state.str_buf, "device=3D\"qemu-%s-de=
vice\",core=3D\"%s\",nr_cores=3D\"%d\"", arch, cpu_model, nr_cores);
+    mcd_put_strbuf();
+    g_free(arch);
+}
+
+void handle_open_core(GArray *params, void *user_ctx) {
+    // get the cpu whith the given id
+    uint32_t cpu_id =3D get_param(params, 0)->cpu_id;
+
+    CPUState *cpu =3D mcd_get_cpu(cpu_id);
+
     CPUClass *cc =3D CPU_GET_CLASS(cpu);
=20
     gchar *arch =3D cc->gdb_arch_name(cpu);
=20
+    // TODO: this might cause a memory leak when called a second time -> m=
aybe free the Garray first
+    mcdserver_state.memspaces =3D g_array_new(false, true, sizeof(mcd_mem_=
space_st));
+    mcdserver_state.reggroups =3D g_array_new(false, true, sizeof(mcd_reg_=
group_st));
+    mcdserver_state.registers =3D g_array_new(false, true, sizeof(mcd_reg_=
st));
+
=20=20=20=20=20
     if (strcmp(arch, "arm")=3D=3D0) {
         // store reg groups
         uint32_t current_group_id =3D 0;
=20
         // at the moment we just assume there are 3 spaces (gpr, per and d=
ebug)
-        // TODO: this might cause a memory leak when called a second time =
-> maybe free the Garray first
-        mcdserver_state.reggroups =3D g_array_new(false, true, sizeof(mcd_=
reg_group_st));
+=20=20=20=20=20=20=20=20
+        // store mem spaces
+        int nr_address_spaces =3D cpu->num_ases;
+        mcd_arm_store_mem_spaces(nr_address_spaces);
+        // mem spaces done
+
=20
-        // store the registers themselves
-        mcdserver_state.registers =3D g_array_new(false, true, sizeof(mcd_=
reg_st));
         GList *register_numbers =3D NULL;
=20
         const char *xml_filename =3D NULL;
@@ -1140,49 +1165,9 @@ void handle_init(GArray *params, void *user_ctx) {
     }
     else {
         // we don't support other architectures
-        assert(1);
+        assert(0);
     }
     g_free(arch);
-
-    // the mcdserver is set up and we return the handshake
-    mcd_put_packet("shaking your hand");=20
-}
-
-void handle_query_system(GArray *params, void *user_ctx) {
-    mcd_put_packet("qemu-system");
-}
-
-void handle_query_cores(GArray *params, void *user_ctx) {
-    //TODO: add cluster support: in gdb each inferior (process) handles on=
e cluster we might want to have sth similar here
-
-    // get first cpu
-    CPUState *cpu =3D mcd_first_attached_cpu();
-    if (!cpu) {
-        return;
-    }
-
-    ObjectClass *oc =3D object_get_class(OBJECT(cpu));
-    const char *cpu_model =3D object_class_get_name(oc);
-
-    CPUClass *cc =3D CPU_GET_CLASS(cpu);
-    gchar *arch =3D cc->gdb_arch_name(cpu);
-=20=20=20=20
-    int nr_cores =3D cpu->nr_cores;
-
-    g_string_append_printf(mcdserver_state.str_buf, "device=3D\"qemu-%s-de=
vice\",core=3D\"%s\",nr_cores=3D\"%d\"", arch, cpu_model, nr_cores);
-    mcd_put_strbuf();
-    g_free(arch);
-}
-
-void handle_core_open(GArray *params, void *user_ctx) {
-    // get the cpu whith the given id
-    uint32_t cpu_id =3D atoi(get_param(params, 0)->data);
-
-    CPUState *cpu =3D mcd_get_cpu(cpu_id);
-
-    // select the the cpu as the current cpu for all request from the mcd =
interface
-    mcdserver_state.c_cpu =3D cpu;
-
 }
=20
 void handle_query_reset(GArray *params, void *user_ctx) {
@@ -1235,36 +1220,43 @@ void mcd_continue(void)
     }
 }
=20
-void handle_query_mem_spaces(GArray *params, void *user_ctx) {
-    // this returns the address spaces
-    // first we check if this is an arm architecture
-    // if it is arm we assume that if there are 2 address spaces, these ar=
e secure and non-secure (EL3 and EL0 for 64 bit)
-    CPUState *cpu =3D mcdserver_state.c_cpu;
-    CPUClass *cc =3D CPU_GET_CLASS(cpu);
-
-    int nr_address_spaces =3D cpu->num_ases;
-    gchar *arch =3D cc->gdb_arch_name(cpu);
+void handle_query_mem_spaces_f(GArray *params, void *user_ctx) {
+    // send the first mem space
+    int nb_groups =3D mcdserver_state.memspaces->len;
+    if (nb_groups =3D=3D 1) {
+        // indicates this is the last packet
+        g_string_printf(mcdserver_state.str_buf, "0!");
+    }
+    else {
+        g_string_printf(mcdserver_state.str_buf, "1!");
+    }
+    mcd_mem_space_st space =3D g_array_index(mcdserver_state.memspaces, mc=
d_mem_space_st, 0);
+    g_string_append_printf(mcdserver_state.str_buf, "name=3D%s.id=3D%d.typ=
e=3D%d.bpm=3D%d.i=3D%d.e=3D%d.min=3D%ld.max=3D%ld.sao=3D%d.",
+        space.name, space.id, space.type, space.bits_per_mau, space.invari=
ance, space.endian,
+        space.min_addr, space.max_addr, space.supported_access_options);
+    mcd_put_strbuf();
+}
=20
-    if (strcmp(arch, "arm")=3D=3D0) {
-        // we got secure and non-secure
-        g_string_printf(mcdserver_state.str_buf, "Non Secure=3Did:1;type:3=
4;bpm:8;i:1;e:1;min:0;max:-1;sao:0;.");
-        g_string_append_printf(mcdserver_state.str_buf, "Physical (Non Sec=
ure)=3Did:2;type:18;bpm:8;i:1;e:1;min:0;max:-1;sao:0;.");
-        if (nr_address_spaces=3D=3D2) {
-            g_string_append_printf(mcdserver_state.str_buf, "Secure=3Did:3=
;type:34;bpm:8;i:1;e:1;min:0;max:-1;sao:0;.");
-            g_string_append_printf(mcdserver_state.str_buf, "Physical (Sec=
ure)=3Did:4;type:18;bpm:8;i:1;e:1;min:0;max:-1;sao:0;.");
-        }
+void handle_query_mem_spaces_c(GArray *params, void *user_ctx) {
+    // this funcitons send all mem spaces except for the first
+    // 1. get parameter
+    int query_index =3D get_param(params, 0)->query_handle;
=20
-        // provide register spaces
-        // TODO: get dynamically how the per (CP15) space is called
-        g_string_append_printf(mcdserver_state.str_buf, "GPR Registers=3Di=
d:5;type:1;bpm:64;i:1;e:1;min:0;max:-1;sao:0;.");
-        g_string_append_printf(mcdserver_state.str_buf, "CP15 Registers=3D=
id:6;type:1;bpm:32;i:1;e:1;min:0;max:-1;sao:0;."); //<-- per registers
-        //g_string_append_printf(mcdserver_state.str_buf, "CP14 Registers=
=3Dtype:1;bpm:32;i:1;e:1;min:0;max:-1;sao:0;."); // <-- debug registers
+    // 2. check weather this was the last mem space
+    int nb_groups =3D mcdserver_state.memspaces->len;
+    if (query_index+1 =3D=3D nb_groups) {
+        // indicates this is the last packet
+        g_string_printf(mcdserver_state.str_buf, "0!");
     }
     else {
-        // we don't support other architectures
-        assert(1);
+        g_string_printf(mcdserver_state.str_buf, "%d!", query_index+1);
     }
-    g_free(arch);
+
+    // 3. send the correct memspace
+    mcd_mem_space_st space =3D g_array_index(mcdserver_state.memspaces, mc=
d_mem_space_st, query_index);
+    g_string_append_printf(mcdserver_state.str_buf, "name=3D%s.id=3D%d.typ=
e=3D%d.bpm=3D%d.i=3D%d.e=3D%d.min=3D%ld.max=3D%ld.sao=3D%d.",
+        space.name, space.id, space.type, space.bits_per_mau, space.invari=
ance, space.endian,
+        space.min_addr, space.max_addr, space.supported_access_options);
     mcd_put_strbuf();
 }
=20
@@ -1286,7 +1278,7 @@ void handle_query_reg_groups_f(GArray *params, void *=
user_ctx) {
 void handle_query_reg_groups_c(GArray *params, void *user_ctx) {
     // this funcitons send all reg groups except for the first
     // 1. get parameter
-    int query_index =3D get_param(params, 0)->index_handle;
+    int query_index =3D get_param(params, 0)->query_handle;
=20
     // 2. check weather this was the last reg group
     int nb_groups =3D mcdserver_state.reggroups->len;
@@ -1324,7 +1316,7 @@ void handle_query_regs_f(GArray *params, void *user_c=
tx) {
 void handle_query_regs_c(GArray *params, void *user_ctx) {
     // this funcitons send all registers except for the first
     // 1. get parameter
-    int query_index =3D get_param(params, 0)->index_handle;
+    int query_index =3D get_param(params, 0)->query_handle;
=20
     // 2. check weather this was the last register
     int nb_regs =3D mcdserver_state.registers->len;
--=20
2.34.1


From 499ed6ab8d47ef63c584a489265bf2b24a3fd680 Mon Sep 17 00:00:00 2001
From: Nicolas Eder <nicolas.eder@lauterbach.com>
Date: Tue, 27 Jun 2023 12:47:57 +0200
Subject: [PATCH 08/29] shared header file added, used for TCP packet data

Signed-off-by: Nicolas Eder <nicolas.eder@lauterbach.com>
---
 mcdstub/internals.h          |  4 +-
 mcdstub/mcd_shared_defines.h | 24 ++++++++++++
 mcdstub/mcdstub.c            | 72 ++++++++++++++++++------------------
 3 files changed, 62 insertions(+), 38 deletions(-)
 create mode 100644 mcdstub/mcd_shared_defines.h

diff --git a/mcdstub/internals.h b/mcdstub/internals.h
index 2f9a768038..4c79ff7674 100644
--- a/mcdstub/internals.h
+++ b/mcdstub/internals.h
@@ -22,9 +22,9 @@
 #define MCD_TRIG_ACTION_DBG_DEBUG 0x00000001
=20
 // schema defines
-#define ARG_SCHEMA_QRY_HANDLE "q"
+#define ARG_SCHEMA_QRYHANDLE "q"
 #define ARG_SCHEMA_STRING "s"
-#define ARG_SCHEMA_CORE_NUM "c"=20
+#define ARG_SCHEMA_CORENUM "c"=20
=20
 // GDB stuff thats needed for GDB function, which we use
 typedef struct GDBRegisterState {
diff --git a/mcdstub/mcd_shared_defines.h b/mcdstub/mcd_shared_defines.h
new file mode 100644
index 0000000000..6a2abfb1bc
--- /dev/null
+++ b/mcdstub/mcd_shared_defines.h
@@ -0,0 +1,24 @@
+// this file is shared between the mcd dll and the mcd stub. it has to be =
kept exectly the same!
+
+#ifndef MCD_SHARED_DEFINES
+#define MCD_SHARED_DEFINES
+
+// tcp characters
+#define TCP_CHAR_INIT 'i'
+#define TCP_CHAR_GO 'c'
+#define TCP_CHAR_QUERY 'q'
+#define TCP_CHAR_OPEN_CORE 'H'
+#define TCP_CHAR_DETACH 'D'
+#define TCP_CHAR_KILLQEMU 'k'
+
+// tcp protocol chars
+#define TCP_ACKNOWLEDGED '+'
+#define TCP_NOT_ACKNOWLEDGED '-'
+#define TCP_COMMAND_START '$'
+#define TCP_COMMAND_END '#'
+#define TCP_WAS_LAST '|'
+#define TCP_WAS_NOT_LAST '~'
+
+
+
+#endif
\ No newline at end of file
diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index b3ec3af543..a4841cf7d3 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -72,7 +72,7 @@ static const MCDCmdParseEntry mcd_gen_query_table[] =3D {
     {
         .handler =3D handle_query_mem_spaces_c,
         .cmd =3D "memoryc",
-        .schema =3D ARG_SCHEMA_QRY_HANDLE,
+        .schema =3D ARG_SCHEMA_QRYHANDLE,
     },
     {
         .handler =3D handle_query_reg_groups_f,
@@ -81,7 +81,7 @@ static const MCDCmdParseEntry mcd_gen_query_table[] =3D {
     {
         .handler =3D handle_query_reg_groups_c,
         .cmd =3D "reggroupc",
-        .schema =3D ARG_SCHEMA_QRY_HANDLE,
+        .schema =3D ARG_SCHEMA_QRYHANDLE,
     },
     {
         .handler =3D handle_query_regs_f,
@@ -90,7 +90,7 @@ static const MCDCmdParseEntry mcd_gen_query_table[] =3D {
     {
         .handler =3D handle_query_regs_c,
         .cmd =3D "regc",
-        .schema =3D ARG_SCHEMA_QRY_HANDLE,
+        .schema =3D ARG_SCHEMA_QRYHANDLE,
     },
 };
=20
@@ -303,22 +303,22 @@ void mcd_read_byte(uint8_t ch)
     if (mcdserver_state.last_packet->len) {
         /* Waiting for a response to the last packet.  If we see the start
            of a new command then abandon the previous response.  */
-        if (ch =3D=3D '-') {
+        if (ch =3D=3D TCP_NOT_ACKNOWLEDGED) {
             //the previous packet was not akcnowledged
             //trace_gdbstub_err_got_nack();
             //we are resending the last packet
             mcd_put_buffer(mcdserver_state.last_packet->data, mcdserver_st=
ate.last_packet->len);
         }
-        else if (ch =3D=3D '+') {
+        else if (ch =3D=3D TCP_ACKNOWLEDGED) {
             //the previous packet was acknowledged
             //trace_gdbstub_io_got_ack();
         }
=20
-        if (ch =3D=3D '+' || ch =3D=3D '$') {
+        if (ch =3D=3D TCP_ACKNOWLEDGED || ch =3D=3D TCP_COMMAND_START) {
             //either acknowledged or a new communication starts -> we disc=
ard previous communication
             g_byte_array_set_size(mcdserver_state.last_packet, 0);
         }
-        if (ch !=3D '$') {
+        if (ch !=3D TCP_COMMAND_START) {
             // we only continue if we are processing a new commant. otherw=
ise we skip to ne next character in the packet which sould be a $
             return;
         }
@@ -331,7 +331,7 @@ void mcd_read_byte(uint8_t ch)
     else {
         switch(mcdserver_state.state) {
         case RS_IDLE:
-            if (ch =3D=3D '$') {
+            if (ch =3D=3D TCP_COMMAND_START) {
                 /* start of command packet */
                 mcdserver_state.line_buf_index =3D 0;
                 mcdserver_state.line_sum =3D 0;
@@ -343,7 +343,7 @@ void mcd_read_byte(uint8_t ch)
             }
             break;
         case RS_GETLINE:
-            if (ch =3D=3D '#') {
+            if (ch =3D=3D TCP_COMMAND_END) {
                 /* end of command, start of checksum*/
                 mcdserver_state.line_buf[mcdserver_state.line_buf_index++]=
 =3D 0;
                 //mcdserver_state.line_sum +=3D ch;
@@ -365,24 +365,24 @@ void mcd_read_byte(uint8_t ch)
             // we are now done with copying the data and in the suffix of =
the packet
             // TODO: maybe wanna implement a checksum or sth like the gdb =
protocol has
=20
-            if (ch =3D=3D '~') {
+            if (ch =3D=3D TCP_WAS_NOT_LAST) {
                 // ~ indicates that there is an additional package coming
                 //acknowledged -> send +
-                reply =3D '+';
+                reply =3D TCP_ACKNOWLEDGED;
                 mcd_put_buffer(&reply, 1);
                 mcdserver_state.state =3D mcd_handle_packet(mcdserver_stat=
e.line_buf);
             }
-            else if (ch =3D=3D '|') {
+            else if (ch =3D=3D TCP_WAS_LAST) {
                 //acknowledged -> send +
                 // | indicates that there is no additional package coming
-                reply =3D '+';
+                reply =3D TCP_ACKNOWLEDGED;
                 mcd_put_buffer(&reply, 1);
                 mcdserver_state.state =3D mcd_handle_packet(mcdserver_stat=
e.line_buf);
             }
             else {
                 //trace_gdbstub_err_checksum_incorrect(mcdserver_state.lin=
e_sum, mcdserver_state.line_csum);
                 //not acknowledged -> send -
-                reply =3D '-';
+                reply =3D TCP_NOT_ACKNOWLEDGED;
                 mcd_put_buffer(&reply, 1);
                 //waiting for package to get resent
                 mcdserver_state.state =3D RS_IDLE;
@@ -400,58 +400,58 @@ int mcd_handle_packet(const char *line_buf)
     const MCDCmdParseEntry *cmd_parser =3D NULL;
=20
     switch (line_buf[0]) {
-    case 'i':
+    case TCP_CHAR_INIT:
         // handshake and lookup initialization
         {
-            static const MCDCmdParseEntry continue_cmd_desc =3D {
+            static MCDCmdParseEntry init_cmd_desc =3D {
                 .handler =3D handle_init,
-                .cmd =3D "i",
             };
-            cmd_parser =3D &continue_cmd_desc;
+            init_cmd_desc.cmd =3D (char[2]) { (char) TCP_CHAR_INIT, '\0' };
+            cmd_parser =3D &init_cmd_desc;
         }
         break;
-    case 'c':
+    case TCP_CHAR_GO:
         // go command
         {
-            static const MCDCmdParseEntry continue_cmd_desc =3D {
+            static MCDCmdParseEntry go_cmd_desc =3D {
                 .handler =3D handle_continue,
-                .cmd =3D "c",
             };
-            cmd_parser =3D &continue_cmd_desc;
+            go_cmd_desc.cmd =3D (char[2]) { (char) TCP_CHAR_GO, '\0' };
+            cmd_parser =3D &go_cmd_desc;
         }
         break;
-    case 'k':
+    case TCP_CHAR_KILLQEMU:
         // kill qemu completely
         error_report("QEMU: Terminated via MCDstub");
         mcd_exit(0);
         exit(0);
-    case 'q':
+    case TCP_CHAR_QUERY:
         //query inquiry
         {
-            static const MCDCmdParseEntry gen_query_cmd_desc =3D {
+            static MCDCmdParseEntry query_cmd_desc =3D {
                 .handler =3D handle_gen_query,
-                .cmd =3D "q",
                 .schema =3D ARG_SCHEMA_STRING
             };
-            cmd_parser =3D &gen_query_cmd_desc;
+            query_cmd_desc.cmd =3D (char[2]) { (char) TCP_CHAR_QUERY, '\0'=
 };
+            cmd_parser =3D &query_cmd_desc;
         }
         break;
-    case 'H':
+    case TCP_CHAR_OPEN_CORE:
         {
-            static const MCDCmdParseEntry gen_open_core =3D {
+            static MCDCmdParseEntry gen_open_core =3D {
                 .handler =3D handle_open_core,
-                .cmd =3D "H",
-                .schema =3D ARG_SCHEMA_CORE_NUM
+                .schema =3D ARG_SCHEMA_CORENUM
             };
+            gen_open_core.cmd =3D (char[2]) { (char) TCP_CHAR_OPEN_CORE, '=
\0' };
             cmd_parser =3D &gen_open_core;
         }
         break;
-    case 'D':
+    case TCP_CHAR_DETACH:
         {
-            static const MCDCmdParseEntry detach_cmd_desc =3D {
+            static MCDCmdParseEntry detach_cmd_desc =3D {
                 .handler =3D handle_detach,
-                .cmd =3D "D",
             };
+            detach_cmd_desc.cmd =3D (char[2]) { (char) TCP_CHAR_DETACH, '\=
0' };
             cmd_parser =3D &detach_cmd_desc;
         }
         break;
@@ -518,12 +518,12 @@ int cmd_parse_params(const char *data, const char *sc=
hema, GArray *params) {
         this_param.data =3D data;
         g_array_append_val(params, this_param);
     }
-    else if (schema[0] =3D=3D atoi(ARG_SCHEMA_QRY_HANDLE)) {
+    else if (schema[0] =3D=3D atoi(ARG_SCHEMA_QRYHANDLE)) {
         strncat(data_buffer, data, strlen(data));
         this_param.query_handle =3D atoi(data_buffer);
         g_array_append_val(params, this_param);
     }
-    else if (schema[0] =3D=3D atoi(ARG_SCHEMA_CORE_NUM)) {
+    else if (schema[0] =3D=3D atoi(ARG_SCHEMA_CORENUM)) {
         strncat(data_buffer, data, strlen(data));
         this_param.cpu_id =3D atoi(data_buffer);
         g_array_append_val(params, this_param);
--=20
2.34.1


From e448b636347739b964d2f24a343c8c009205a82e Mon Sep 17 00:00:00 2001
From: Nicolas Eder <nicolas.eder@lauterbach.com>
Date: Tue, 27 Jun 2023 17:23:05 +0200
Subject: [PATCH 09/29] memory and register query data now stored per core

Signed-off-by: Nicolas Eder <nicolas.eder@lauterbach.com>
---
 mcdstub/internals.h          |  63 +++-
 mcdstub/mcd_shared_defines.h |  43 ++-
 mcdstub/mcdstub.c            | 693 ++++++++++++++++++++++-------------
 3 files changed, 533 insertions(+), 266 deletions(-)

diff --git a/mcdstub/internals.h b/mcdstub/internals.h
index 4c79ff7674..a4d49a4a84 100644
--- a/mcdstub/internals.h
+++ b/mcdstub/internals.h
@@ -8,6 +8,7 @@
=20
 #include "exec/cpu-common.h"
 #include "chardev/char.h"
+#include "hw/core/cpu.h"
 // just used for the register xml files
 #include "exec/gdbstub.h"       /* xml_builtin */
=20
@@ -22,9 +23,22 @@
 #define MCD_TRIG_ACTION_DBG_DEBUG 0x00000001
=20
 // schema defines
-#define ARG_SCHEMA_QRYHANDLE "q"
-#define ARG_SCHEMA_STRING "s"
-#define ARG_SCHEMA_CORENUM "c"=20
+#define ARG_SCHEMA_QRYHANDLE 'q'
+#define ARG_SCHEMA_STRING 's'
+#define ARG_SCHEMA_CORENUM 'c'
+
+// resets
+#define RESET_SYSTEM "full_system_reset"
+#define RESET_GPR "gpr_reset"
+#define RESET_MEMORY "memory_reset"
+
+// more
+#define QUERY_TOTAL_NUMBER 11 //FIXME: set this to a usefull value in the =
end
+#define CMD_SCHEMA_LENGTH 2
+#define MCD_MAX_CORES 128
+#define MCD_SYSTEM_NAME "qemu-system"
+// tcp query packet values templates
+#define DEVICE_NAME_TEMPLATE(s) "qemu-" #s "-device"
=20
 // GDB stuff thats needed for GDB function, which we use
 typedef struct GDBRegisterState {
@@ -52,8 +66,7 @@ typedef void (*MCDCmdHandler)(GArray *params, void *user_=
ctx);
 typedef struct MCDCmdParseEntry {
     MCDCmdHandler handler;
     const char *cmd;
-    bool cmd_startswith;
-    const char *schema;
+    char schema[CMD_SCHEMA_LENGTH];
 } MCDCmdParseEntry;
=20
 typedef enum MCDThreadIdKind {
@@ -92,6 +105,13 @@ enum RSState {
     RS_DATAEND,
 };
=20
+typedef struct mcd_trigger_st {
+    uint32_t type;
+    uint32_t option;
+    uint32_t action;
+    uint32_t nr_trigger;
+} mcd_trigger_st;
+
 typedef struct MCDState {
     bool init;       /* have we been initialised? */
     CPUState *c_cpu; /* current CPU for everything */
@@ -113,9 +133,13 @@ typedef struct MCDState {
     int supported_sstep_flags;
=20
     // my stuff
-    GArray *memspaces;
-    GArray *reggroups;
-    GArray *registers;
+    uint32_t query_cpu_id;
+    GList *all_memspaces;
+    GList *all_reggroups;
+    GList *all_registers;
+    GArray *resets;
+    mcd_trigger_st trigger;
+    MCDCmdParseEntry mcd_query_cmds_table[QUERY_TOTAL_NUMBER];
 } MCDState;
=20
 /* lives in main mcdstub.c */
@@ -164,6 +188,11 @@ typedef struct mcd_reg_st {
     uint8_t opc2;
 } mcd_reg_st;
=20
+typedef struct mcd_reset_st {
+    const char *name;
+    uint8_t id;
+} mcd_reset_st;
+
 // Inline utility function, convert from int to hex and back
=20
=20
@@ -194,6 +223,9 @@ void mcd_sigterm_handler(int signal);
 #endif
=20
 void mcd_init_mcdserver_state(void);
+void init_query_cmds_table(MCDCmdParseEntry* mcd_query_cmds_table);
+int init_resets(GArray* resets);
+int init_trigger(mcd_trigger_st* trigger);
 void reset_mcdserver_state(void);
 void create_processes(MCDState *s);
 void mcd_create_default_process(MCDState *s);
@@ -231,8 +263,10 @@ void handle_query_system(GArray *params, void *user_ct=
x);
 CPUState *get_first_cpu_in_process(MCDProcess *process);
 CPUState *find_cpu(uint32_t thread_id);
 void handle_open_core(GArray *params, void *user_ctx);
-void handle_query_reset(GArray *params, void *user_ctx);
-void handle_detach(GArray *params, void *user_ctx);
+void handle_query_reset_f(GArray *params, void *user_ctx);
+void handle_query_reset_c(GArray *params, void *user_ctx);
+void handle_close_server(GArray *params, void *user_ctx);
+void handle_close_core(GArray *params, void *user_ctx);
 void handle_query_trigger(GArray *params, void *user_ctx);
 void mcd_continue(void);
 void handle_query_reg_groups_f(GArray *params, void *user_ctx);
@@ -241,11 +275,14 @@ void handle_query_mem_spaces_f(GArray *params, void *=
user_ctx);
 void handle_query_mem_spaces_c(GArray *params, void *user_ctx);
 void handle_query_regs_f(GArray *params, void *user_ctx);
 void handle_query_regs_c(GArray *params, void *user_ctx);
-void handle_init(GArray *params, void *user_ctx);
-void parse_reg_xml(const char *xml, int size);
+void handle_open_server(GArray *params, void *user_ctx);
+void parse_reg_xml(const char *xml, int size, GArray* registers);
=20
 // arm specific functions
-void mcd_arm_store_mem_spaces(int nr_address_spaces);
+int mcd_arm_store_mem_spaces(CPUState *cpu, GArray* memspaces);
+int mcd_arm_parse_core_xml_file(CPUClass *cc, GArray* reggroups, GArray* r=
egisters, int* current_group_id);
+int mcd_arm_parse_general_xml_files(CPUState *cpu, GArray* reggroups, GArr=
ay* registers, int* current_group_id);
+int mcd_arm_get_additional_register_info(GArray* reggroups, GArray* regist=
ers);
=20
 /* sycall handling */
 void mcd_syscall_reset(void);
diff --git a/mcdstub/mcd_shared_defines.h b/mcdstub/mcd_shared_defines.h
index 6a2abfb1bc..e0b27ce5e6 100644
--- a/mcdstub/mcd_shared_defines.h
+++ b/mcdstub/mcd_shared_defines.h
@@ -3,12 +3,13 @@
 #ifndef MCD_SHARED_DEFINES
 #define MCD_SHARED_DEFINES
=20
-// tcp characters
-#define TCP_CHAR_INIT 'i'
+// tcp data characters
+#define TCP_CHAR_OPEN_SERVER 'I'
+#define TCP_CHAR_OPEN_CORE 'i'
 #define TCP_CHAR_GO 'c'
 #define TCP_CHAR_QUERY 'q'
-#define TCP_CHAR_OPEN_CORE 'H'
-#define TCP_CHAR_DETACH 'D'
+#define TCP_CHAR_CLOSE_SERVER 'D'
+#define TCP_CHAR_CLOSE_CORE 'd'
 #define TCP_CHAR_KILLQEMU 'k'
=20
 // tcp protocol chars
@@ -18,7 +19,39 @@
 #define TCP_COMMAND_END '#'
 #define TCP_WAS_LAST '|'
 #define TCP_WAS_NOT_LAST '~'
+#define TCP_HANDSHAKE_SUCCESS "shaking your hand"
=20
+// tcp query arguments
+#define QUERY_FIRST "f"
+#define QUERY_CONSEQUTIVE "c"
=20
+#define QUERY_ARG_SYSTEM "system"
+#define QUERY_ARG_CORES "cores"
+#define QUERY_ARG_RESET "reset"
+#define QUERY_ARG_TRIGGER "trigger"
+#define QUERY_ARG_MEMORY "memory"
+#define QUERY_ARG_REGGROUP "reggroup"
+#define QUERY_ARG_REG "reg"
=20
-#endif
\ No newline at end of file
+// tcp query packet argument list
+#define TCP_ARGUMENT_NAME "name"
+#define TCP_ARGUMENT_ID "id"
+#define TCP_ARGUMENT_TYPE "type"
+#define TCP_ARGUMENT_BITS_PER_MAU "bpm"
+#define TCP_ARGUMENT_INVARIANCE "i"
+#define TCP_ARGUMENT_ENDIAN "e"
+#define TCP_ARGUMENT_MIN "min"
+#define TCP_ARGUMENT_MAX "max"
+#define TCP_ARGUMENT_SUPPORTED_ACCESS_OPTIONS "sao"
+#define TCP_ARGUMENT_REGGROUPID "reggroupid"
+#define TCP_ARGUMENT_MEMSPACEID "memspaceid"
+#define TCP_ARGUMENT_SIZE "size"
+#define TCP_ARGUMENT_THREAD "thread"
+#define TCP_ARGUMENT_DEVICE "device"
+#define TCP_ARGUMENT_CORE "core"
+#define TCP_ARGUMENT_AMOUNT_CORE "nr_cores"
+#define TCP_ARGUMENT_AMOUNT_TRIGGER "nr_trigger"
+#define TCP_ARGUMENT_OPTION "option"
+#define TCP_ARGUMENT_ACTION "action"
+
+#endif
diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index a4841cf7d3..a0c4c2794f 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -27,7 +27,6 @@
 #include "exec/tb-flush.h"
 #include "sysemu/cpus.h"
 #include "sysemu/replay.h"
-#include "hw/core/cpu.h"
 #include "chardev/char.h"
 #include "chardev/char-fe.h"
 #include "monitor/monitor.h"
@@ -47,53 +46,6 @@ MCDSystemState mcdserver_system_state;
=20
 MCDState mcdserver_state;
=20
-static const MCDCmdParseEntry mcd_gen_query_table[] =3D {
-    // this is a list of all query commands. it gets iterated over only th=
e handler of the matching command will get executed
-    {
-        .handler =3D handle_query_system,
-        .cmd =3D "system",
-    },
-    {
-        .handler =3D handle_query_cores,
-        .cmd =3D "cores",
-    },
-    {
-        .handler =3D handle_query_reset,
-        .cmd =3D "reset",
-    },
-    {
-        .handler =3D handle_query_trigger,
-        .cmd =3D "trigger",
-    },
-    {
-        .handler =3D handle_query_mem_spaces_f,
-        .cmd =3D "memoryf",
-    },
-    {
-        .handler =3D handle_query_mem_spaces_c,
-        .cmd =3D "memoryc",
-        .schema =3D ARG_SCHEMA_QRYHANDLE,
-    },
-    {
-        .handler =3D handle_query_reg_groups_f,
-        .cmd =3D "reggroupf",
-    },
-    {
-        .handler =3D handle_query_reg_groups_c,
-        .cmd =3D "reggroupc",
-        .schema =3D ARG_SCHEMA_QRYHANDLE,
-    },
-    {
-        .handler =3D handle_query_regs_f,
-        .cmd =3D "regf",
-    },
-    {
-        .handler =3D handle_query_regs_c,
-        .cmd =3D "regc",
-        .schema =3D ARG_SCHEMA_QRYHANDLE,
-    },
-};
-
 void mcd_init_mcdserver_state(void)
 {
 	g_assert(!mcdserver_state.init);
@@ -113,6 +65,97 @@ void mcd_init_mcdserver_state(void)
     mcdserver_state.supported_sstep_flags =3D accel_supported_gdbstub_sste=
p_flags();
     mcdserver_state.sstep_flags =3D SSTEP_ENABLE | SSTEP_NOIRQ | SSTEP_NOT=
IMER;
     mcdserver_state.sstep_flags &=3D mcdserver_state.supported_sstep_flags;
+
+    // init query table
+    init_query_cmds_table(mcdserver_state.mcd_query_cmds_table);
+}
+
+void init_query_cmds_table(MCDCmdParseEntry* mcd_query_cmds_table) {
+    // initalizes a list of all query commands
+    int cmd_number =3D 0;
+
+    MCDCmdParseEntry query_system =3D {
+        .handler =3D handle_query_system,
+        .cmd =3D QUERY_ARG_SYSTEM,
+    };
+    mcd_query_cmds_table[cmd_number] =3D query_system;
+    cmd_number++;
+
+    MCDCmdParseEntry query_cores =3D {
+        .handler =3D handle_query_cores,
+        .cmd =3D QUERY_ARG_CORES,
+    };
+    mcd_query_cmds_table[cmd_number] =3D query_cores;
+    cmd_number++;
+
+    MCDCmdParseEntry query_reset_f =3D {
+        .handler =3D handle_query_reset_f,
+        .cmd =3D QUERY_ARG_RESET QUERY_FIRST,
+    };
+    mcd_query_cmds_table[cmd_number] =3D query_reset_f;
+    cmd_number++;
+
+    MCDCmdParseEntry query_reset_c =3D {
+        .handler =3D handle_query_reset_c,
+        .cmd =3D QUERY_ARG_RESET QUERY_CONSEQUTIVE,
+    };
+    strcpy(query_reset_c.schema, (char[2]) { (char) ARG_SCHEMA_QRYHANDLE, =
'\0' });
+    mcd_query_cmds_table[cmd_number] =3D query_reset_c;
+    cmd_number++;
+
+    MCDCmdParseEntry query_trigger =3D {
+        .handler =3D handle_query_trigger,
+        .cmd =3D QUERY_ARG_TRIGGER,
+    };
+    mcd_query_cmds_table[cmd_number] =3D query_trigger;
+    cmd_number++;
+
+    MCDCmdParseEntry query_mem_spaces_f =3D {
+        .handler =3D handle_query_mem_spaces_f,
+        .cmd =3D QUERY_ARG_MEMORY QUERY_FIRST,
+    };
+    strcpy(query_mem_spaces_f.schema, (char[2]) { (char) ARG_SCHEMA_CORENU=
M, '\0' });
+    mcd_query_cmds_table[cmd_number] =3D query_mem_spaces_f;
+    cmd_number++;
+
+    MCDCmdParseEntry query_mem_spaces_c =3D {
+        .handler =3D handle_query_mem_spaces_c,
+        .cmd =3D QUERY_ARG_MEMORY QUERY_CONSEQUTIVE,
+    };
+    strcpy(query_mem_spaces_c.schema, (char[2]) { (char) ARG_SCHEMA_QRYHAN=
DLE, '\0' });
+    mcd_query_cmds_table[cmd_number] =3D query_mem_spaces_c;
+    cmd_number++;
+
+    MCDCmdParseEntry query_reg_groups_f =3D {
+        .handler =3D handle_query_reg_groups_f,
+        .cmd =3D QUERY_ARG_REGGROUP QUERY_FIRST,
+    };
+    strcpy(query_reg_groups_f.schema, (char[2]) { (char) ARG_SCHEMA_CORENU=
M, '\0' });
+    mcd_query_cmds_table[cmd_number] =3D query_reg_groups_f;
+    cmd_number++;
+
+    MCDCmdParseEntry query_reg_groups_c =3D {
+        .handler =3D handle_query_reg_groups_c,
+        .cmd =3D QUERY_ARG_REGGROUP QUERY_CONSEQUTIVE,
+    };
+    strcpy(query_reg_groups_c.schema, (char[2]) { (char) ARG_SCHEMA_QRYHAN=
DLE, '\0' });
+    mcd_query_cmds_table[cmd_number] =3D query_reg_groups_c;
+    cmd_number++;
+
+    MCDCmdParseEntry query_regs_f =3D {
+        .handler =3D handle_query_regs_f,
+        .cmd =3D QUERY_ARG_REG QUERY_FIRST,
+    };
+    strcpy(query_regs_f.schema, (char[2]) { (char) ARG_SCHEMA_CORENUM, '\0=
' });
+    mcd_query_cmds_table[cmd_number] =3D query_regs_f;
+    cmd_number++;
+
+    MCDCmdParseEntry query_regs_c =3D {
+        .handler =3D handle_query_regs_c,
+        .cmd =3D QUERY_ARG_REG QUERY_CONSEQUTIVE,
+    };
+    strcpy(query_regs_c.schema, (char[2]) { (char) ARG_SCHEMA_QRYHANDLE, '=
\0' });
+    mcd_query_cmds_table[cmd_number] =3D query_regs_c;
 }
=20
 void reset_mcdserver_state(void)
@@ -400,14 +443,14 @@ int mcd_handle_packet(const char *line_buf)
     const MCDCmdParseEntry *cmd_parser =3D NULL;
=20
     switch (line_buf[0]) {
-    case TCP_CHAR_INIT:
+    case TCP_CHAR_OPEN_SERVER:
         // handshake and lookup initialization
         {
-            static MCDCmdParseEntry init_cmd_desc =3D {
-                .handler =3D handle_init,
+            static MCDCmdParseEntry open_server_cmd_desc =3D {
+                .handler =3D handle_open_server,
             };
-            init_cmd_desc.cmd =3D (char[2]) { (char) TCP_CHAR_INIT, '\0' };
-            cmd_parser =3D &init_cmd_desc;
+            open_server_cmd_desc.cmd =3D (char[2]) { (char) TCP_CHAR_OPEN_=
SERVER, '\0' };
+            cmd_parser =3D &open_server_cmd_desc;
         }
         break;
     case TCP_CHAR_GO:
@@ -430,29 +473,39 @@ int mcd_handle_packet(const char *line_buf)
         {
             static MCDCmdParseEntry query_cmd_desc =3D {
                 .handler =3D handle_gen_query,
-                .schema =3D ARG_SCHEMA_STRING
             };
             query_cmd_desc.cmd =3D (char[2]) { (char) TCP_CHAR_QUERY, '\0'=
 };
+            strcpy(query_cmd_desc.schema, (char[2]) { (char) ARG_SCHEMA_ST=
RING, '\0' });
             cmd_parser =3D &query_cmd_desc;
         }
         break;
     case TCP_CHAR_OPEN_CORE:
         {
-            static MCDCmdParseEntry gen_open_core =3D {
+            static MCDCmdParseEntry open_core_cmd_desc =3D {
                 .handler =3D handle_open_core,
-                .schema =3D ARG_SCHEMA_CORENUM
             };
-            gen_open_core.cmd =3D (char[2]) { (char) TCP_CHAR_OPEN_CORE, '=
\0' };
-            cmd_parser =3D &gen_open_core;
+            open_core_cmd_desc.cmd =3D (char[2]) { (char) TCP_CHAR_OPEN_CO=
RE, '\0' };
+            strcpy(open_core_cmd_desc.schema, (char[2]) { (char) ARG_SCHEM=
A_CORENUM, '\0' });
+            cmd_parser =3D &open_core_cmd_desc;
         }
         break;
-    case TCP_CHAR_DETACH:
+    case TCP_CHAR_CLOSE_SERVER:
         {
-            static MCDCmdParseEntry detach_cmd_desc =3D {
-                .handler =3D handle_detach,
+            static MCDCmdParseEntry close_server_cmd_desc =3D {
+                .handler =3D handle_close_server,
             };
-            detach_cmd_desc.cmd =3D (char[2]) { (char) TCP_CHAR_DETACH, '\=
0' };
-            cmd_parser =3D &detach_cmd_desc;
+            close_server_cmd_desc.cmd =3D (char[2]) { (char) TCP_CHAR_CLOS=
E_SERVER, '\0' };
+            cmd_parser =3D &close_server_cmd_desc;
+        }
+        break;
+    case TCP_CHAR_CLOSE_CORE:
+        {
+            static MCDCmdParseEntry close_core_cmd_desc =3D {
+                .handler =3D handle_close_core,
+            };
+            close_core_cmd_desc.cmd =3D (char[2]) { (char) TCP_CHAR_CLOSE_=
CORE, '\0' };
+            strcpy(close_core_cmd_desc.schema, (char[2]) { (char) ARG_SCHE=
MA_CORENUM, '\0' });
+            cmd_parser =3D &close_core_cmd_desc;
         }
         break;
     default:
@@ -488,8 +541,8 @@ void handle_gen_query(GArray *params, void *user_ctx)
     }
     //now iterate over all possible query functions and execute the right =
one
     if (process_string_cmd(NULL, get_param(params, 0)->data,
-                           mcd_gen_query_table,
-                           ARRAY_SIZE(mcd_gen_query_table))) {
+                           mcdserver_state.mcd_query_cmds_table,
+                           ARRAY_SIZE(mcdserver_state.mcd_query_cmds_table=
))) {
         mcd_put_packet("");
     }
 }
@@ -514,16 +567,16 @@ int cmd_parse_params(const char *data, const char *sc=
hema, GArray *params) {
     MCDCmdVariant this_param;
=20
     char data_buffer[64] =3D {0};
-    if (schema[0] =3D=3D atoi(ARG_SCHEMA_STRING)) {
+    if (schema[0] =3D=3D ARG_SCHEMA_STRING) {
         this_param.data =3D data;
         g_array_append_val(params, this_param);
     }
-    else if (schema[0] =3D=3D atoi(ARG_SCHEMA_QRYHANDLE)) {
+    else if (schema[0] =3D=3D ARG_SCHEMA_QRYHANDLE) {
         strncat(data_buffer, data, strlen(data));
         this_param.query_handle =3D atoi(data_buffer);
         g_array_append_val(params, this_param);
     }
-    else if (schema[0] =3D=3D atoi(ARG_SCHEMA_CORENUM)) {
+    else if (schema[0] =3D=3D ARG_SCHEMA_CORENUM) {
         strncat(data_buffer, data, strlen(data));
         this_param.cpu_id =3D atoi(data_buffer);
         g_array_append_val(params, this_param);
@@ -799,7 +852,7 @@ CPUState *find_cpu(uint32_t thread_id)
 }
=20
=20
-void parse_reg_xml(const char *xml, int size) {
+void parse_reg_xml(const char *xml, int size, GArray* registers) {
     // iterates over the complete xml file
     int i, j;
     int still_to_skip =3D 0;
@@ -866,7 +919,7 @@ void parse_reg_xml(const char *xml, int size) {
                     }
                 }
                 // store register
-                g_array_append_vals(mcdserver_state.registers, (gconstpoin=
ter)&my_register, 1);
+                g_array_append_vals(registers, (gconstpointer)&my_register=
, 1);
                 // free memory
                 g_array_free(reg_data, false);
             }
@@ -924,7 +977,9 @@ int int_cmp(gconstpointer a, gconstpointer b) {
     }
 }
=20
-void mcd_arm_store_mem_spaces(int nr_address_spaces) {
+int mcd_arm_store_mem_spaces(CPUState *cpu, GArray* memspaces) {
+    int nr_address_spaces =3D cpu->num_ases;
+
     mcd_mem_space_st space1 =3D {
         .name =3D "Non Secure",
         .id =3D 1,
@@ -936,7 +991,7 @@ void mcd_arm_store_mem_spaces(int nr_address_spaces) {
         .max_addr =3D -1,
         .supported_access_options =3D 0,
     };
-    g_array_append_vals(mcdserver_state.memspaces, (gconstpointer)&space1,=
 1);
+    g_array_append_vals(memspaces, (gconstpointer)&space1, 1);
=20
     mcd_mem_space_st space2 =3D {
         .name =3D "Physical (Non Secure)",
@@ -949,7 +1004,7 @@ void mcd_arm_store_mem_spaces(int nr_address_spaces) {
         .max_addr =3D -1,
         .supported_access_options =3D 0,
     };
-    g_array_append_vals(mcdserver_state.memspaces, (gconstpointer)&space2,=
 1);
+    g_array_append_vals(memspaces, (gconstpointer)&space2, 1);
=20
     if (nr_address_spaces=3D=3D2) {
         mcd_mem_space_st space3 =3D {
@@ -963,7 +1018,7 @@ void mcd_arm_store_mem_spaces(int nr_address_spaces) {
         .max_addr =3D -1,
         .supported_access_options =3D 0,
     };
-    g_array_append_vals(mcdserver_state.memspaces, (gconstpointer)&space3,=
 1);
+    g_array_append_vals(memspaces, (gconstpointer)&space3, 1);
     mcd_mem_space_st space4 =3D {
         .name =3D "Physical (Secure)",
         .id =3D 4,
@@ -975,7 +1030,7 @@ void mcd_arm_store_mem_spaces(int nr_address_spaces) {
         .max_addr =3D -1,
         .supported_access_options =3D 0,
     };
-    g_array_append_vals(mcdserver_state.memspaces, (gconstpointer)&space4,=
 1);
+    g_array_append_vals(memspaces, (gconstpointer)&space4, 1);
     }
     // TODO: get dynamically how the per (CP15) space is called
     mcd_mem_space_st space5 =3D {
@@ -989,7 +1044,7 @@ void mcd_arm_store_mem_spaces(int nr_address_spaces) {
         .max_addr =3D -1,
         .supported_access_options =3D 0,
     };
-    g_array_append_vals(mcdserver_state.memspaces, (gconstpointer)&space5,=
 1);
+    g_array_append_vals(memspaces, (gconstpointer)&space5, 1);
     mcd_mem_space_st space6 =3D {
         .name =3D "CP15 Registers",
         .id =3D 6,
@@ -1001,16 +1056,43 @@ void mcd_arm_store_mem_spaces(int nr_address_spaces=
) {
         .max_addr =3D -1,
         .supported_access_options =3D 0,
     };
-    g_array_append_vals(mcdserver_state.memspaces, (gconstpointer)&space6,=
 1);
+    g_array_append_vals(memspaces, (gconstpointer)&space6, 1);
+
+    return 0;
+}
+
+int init_resets(GArray* resets) {
+    mcd_reset_st system_reset =3D { .id =3D 0, .name =3D RESET_SYSTEM};
+    mcd_reset_st gpr_reset =3D { .id =3D 1, .name =3D RESET_GPR};
+    mcd_reset_st memory_reset =3D { .id =3D 2, .name =3D RESET_MEMORY};
+    g_array_append_vals(resets, (gconstpointer)&system_reset, 1);
+    g_array_append_vals(resets, (gconstpointer)&gpr_reset, 1);
+    g_array_append_vals(resets, (gconstpointer)&memory_reset, 1);
+    return 0;
 }
=20
-void handle_init(GArray *params, void *user_ctx) {
-    // the mcdserver is set up and we return the handshake
-    mcd_put_packet("shaking your hand");=20
+int init_trigger(mcd_trigger_st* trigger) {
+    trigger->type =3D (MCD_TRIG_TYPE_IP | MCD_TRIG_TYPE_READ | MCD_TRIG_TY=
PE_WRITE | MCD_TRIG_TYPE_RW);
+    trigger->option =3D (MCD_TRIG_OPT_DATA_IS_CONDITION);
+    trigger->action =3D (MCD_TRIG_ACTION_DBG_DEBUG);
+    trigger->nr_trigger =3D 4;
+    return 0;
+}
+
+void handle_open_server(GArray *params, void *user_ctx) {
+    // initialize some core-independent data
+    int return_value =3D 0;
+    mcdserver_state.resets =3D g_array_new(false, true, sizeof(mcd_reset_s=
t));
+    return_value =3D init_resets(mcdserver_state.resets);
+    if (return_value!=3D0) assert(0);
+    return_value =3D init_trigger(&mcdserver_state.trigger);
+    if (return_value!=3D0) assert(0);
+
+    mcd_put_packet(TCP_HANDSHAKE_SUCCESS);=20
 }
=20
 void handle_query_system(GArray *params, void *user_ctx) {
-    mcd_put_packet("qemu-system");
+    mcd_put_packet(MCD_SYSTEM_NAME);
 }
=20
 void handle_query_cores(GArray *params, void *user_ctx) {
@@ -1030,138 +1112,179 @@ void handle_query_cores(GArray *params, void *use=
r_ctx) {
=20=20=20=20=20
     int nr_cores =3D cpu->nr_cores;
=20
-    g_string_append_printf(mcdserver_state.str_buf, "device=3D\"qemu-%s-de=
vice\",core=3D\"%s\",nr_cores=3D\"%d\"", arch, cpu_model, nr_cores);
+    char device_name[] =3D DEVICE_NAME_TEMPLATE(arch);
+    g_string_printf(mcdserver_state.str_buf, "%s=3D%s.%s=3D%s.%s=3D%d.",
+    TCP_ARGUMENT_DEVICE, device_name, TCP_ARGUMENT_CORE, cpu_model, TCP_AR=
GUMENT_AMOUNT_CORE, nr_cores);
     mcd_put_strbuf();
     g_free(arch);
 }
=20
-void handle_open_core(GArray *params, void *user_ctx) {
-    // get the cpu whith the given id
-    uint32_t cpu_id =3D get_param(params, 0)->cpu_id;
-
-    CPUState *cpu =3D mcd_get_cpu(cpu_id);
-
-    CPUClass *cc =3D CPU_GET_CLASS(cpu);
-
-    gchar *arch =3D cc->gdb_arch_name(cpu);
-
-    // TODO: this might cause a memory leak when called a second time -> m=
aybe free the Garray first
-    mcdserver_state.memspaces =3D g_array_new(false, true, sizeof(mcd_mem_=
space_st));
-    mcdserver_state.reggroups =3D g_array_new(false, true, sizeof(mcd_reg_=
group_st));
-    mcdserver_state.registers =3D g_array_new(false, true, sizeof(mcd_reg_=
st));
-
-=20=20=20=20
-    if (strcmp(arch, "arm")=3D=3D0) {
-        // store reg groups
-        uint32_t current_group_id =3D 0;
-
-        // at the moment we just assume there are 3 spaces (gpr, per and d=
ebug)
-=20=20=20=20=20=20=20=20
-        // store mem spaces
-        int nr_address_spaces =3D cpu->num_ases;
-        mcd_arm_store_mem_spaces(nr_address_spaces);
-        // mem spaces done
-
-
-        GList *register_numbers =3D NULL;
+int mcd_arm_parse_core_xml_file(CPUClass *cc, GArray* reggroups, GArray* r=
egisters, int* current_group_id) {
+    const char *xml_filename =3D NULL;
+    const char *current_xml_filename =3D NULL;
+    const char *xml_content =3D NULL;
+    int i =3D 0;
+
+    // 1. get correct file
+    xml_filename =3D cc->gdb_core_xml_file;
+    for (i =3D 0; ; i++) {
+        current_xml_filename =3D xml_builtin[i][0];
+        if (!current_xml_filename || (strncmp(current_xml_filename, xml_fi=
lename, strlen(xml_filename)) =3D=3D 0
+            && strlen(current_xml_filename) =3D=3D strlen(xml_filename)))
+        break;
+    }
+    // without gpr registers we can do nothing
+    if (!current_xml_filename) {
+        return -1;
+    }
=20
-        const char *xml_filename =3D NULL;
-        const char *xml_content =3D NULL;
-        const char *name =3D NULL;
-        int i;
+    // 2. add group for gpr registers
+    mcd_reg_group_st gprregs =3D { .name =3D "GPR Registers", .id =3D *cur=
rent_group_id };
+    g_array_append_vals(reggroups, (gconstpointer)&gprregs, 1);
+    *current_group_id =3D *current_group_id + 1;
=20
-        // 1. check out the core xml file
-        xml_filename =3D cc->gdb_core_xml_file;
+    // 3. parse xml
+    xml_content =3D xml_builtin[i][1];
+    parse_reg_xml(xml_content, strlen(xml_content), registers);
+    return 0;
+}
=20
-        for (i =3D 0; ; i++) {
-                name =3D xml_builtin[i][0];
-                if (!name || (strncmp(name, xml_filename, strlen(xml_filen=
ame)) =3D=3D 0 && strlen(name) =3D=3D strlen(xml_filename)))
+int mcd_arm_parse_general_xml_files(CPUState *cpu, GArray* reggroups, GArr=
ay* registers, int* current_group_id) {
+    const char *xml_filename =3D NULL;
+    const char *current_xml_filename =3D NULL;
+    const char *xml_content =3D NULL;
+    int i =3D 0;
+
+    // iterate over all gdb xml files=20
+    GDBRegisterState *r;
+    for (r =3D cpu->gdb_regs; r; r =3D r->next) {
+        xml_filename =3D r->xml;
+        xml_content =3D NULL;
+
+        // 1. get xml content
+        xml_content =3D arm_mcd_get_dynamic_xml(cpu, xml_filename);
+        if (xml_content) {
+            if (strcmp(xml_filename, "system-registers.xml")=3D=3D0) {
+                // these are the coprocessor register
+                mcd_reg_group_st corprocessorregs =3D { .name =3D "CP15 Re=
gisters", .id =3D *current_group_id };
+                g_array_append_vals(reggroups, (gconstpointer)&corprocesso=
rregs, 1);
+                *current_group_id =3D *current_group_id + 1;
+            }=20=20
+        }
+        else {
+            // its not a coprocessor xml -> it is a static xml file
+            for (i =3D 0; ; i++) {
+                current_xml_filename =3D xml_builtin[i][0];
+                if (!current_xml_filename || (strncmp(current_xml_filename=
, xml_filename, strlen(xml_filename)) =3D=3D 0
+                    && strlen(current_xml_filename) =3D=3D strlen(xml_file=
name)))
                 break;
             }
-        // without gpr registers we can do nothing
-        assert(name);
-        // add group for gpr registers
-        current_group_id =3D 1;
-        mcd_reg_group_st group1 =3D { .name =3D "GPR Registers", .id =3D c=
urrent_group_id };
-        g_array_append_vals(mcdserver_state.reggroups, (gconstpointer)&gro=
up1, 1);
-
-        // parse xml
-        xml_content =3D xml_builtin[i][1];
-        parse_reg_xml(xml_content, strlen(xml_content));
-
-        // 2. iterate over all other xml files
-        GDBRegisterState *r;
-        for (r =3D cpu->gdb_regs; r; r =3D r->next) {
-            xml_filename =3D r->xml;
-            xml_content =3D NULL;
-
-            // first, check if this is a coprocessor xml
-
-            // funciton call
-            xml_content =3D arm_mcd_get_dynamic_xml(cpu, xml_filename);
-            if (xml_content) {
-                if (strcmp(xml_filename, "system-registers.xml")=3D=3D0) {
-                    //these are the coprocessor register
-                    current_group_id =3D 2;
-                    mcd_reg_group_st group2 =3D { .name =3D "CP15 Register=
s", .id =3D current_group_id };
-                    g_array_append_vals(mcdserver_state.reggroups, (gconst=
pointer)&group2, 1);
-                }
-=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
+            if (current_xml_filename) {
+                xml_content =3D xml_builtin[i][1];
             }
             else {
-                // its not a coprocessor xml -> it is a static xml file
-                for (i =3D 0; ; i++) {
-                    name =3D xml_builtin[i][0];
-                    if (!name || (strncmp(name, xml_filename, strlen(xml_f=
ilename)) =3D=3D 0 && strlen(name) =3D=3D strlen(xml_filename)))
-                    break;
-                }
-                if (name) {
-                    xml_content =3D xml_builtin[i][1];
-                }
-                else {
-                    printf("no data found for %s\n", xml_filename);
-                    continue;
-                }
+                printf("no data found for %s\n", xml_filename);
+                continue;
             }
+        }
+        // 2. parse xml
+        parse_reg_xml(xml_content, strlen(xml_content), registers);
+    }
+    return 0;
+}
=20
-            // parse xml
-            parse_reg_xml(xml_content, strlen(xml_content));
+int mcd_arm_get_additional_register_info(GArray* reggroups, GArray* regist=
ers) {
+    GList *register_numbers =3D NULL;
+    mcd_reg_st *current_register;
+    int i =3D 0;
+    int id_neg_offset =3D 0;
+    int effective_id =3D 0;
+
+    // iterate over all registers
+    for (i =3D 0; i < registers->len; i++) {
+        current_register =3D &(g_array_index(registers, mcd_reg_st, i));
+        // 1. ad the id
+        if (current_register->id) {
+            // id is already in place
+            // NOTE: qemu doesn't emulate the FPA regs (so we are missing =
the indices 16 to 24)
+            int used_id =3D current_register->id;
+            register_numbers =3D g_list_append(register_numbers, &used_id);
+            id_neg_offset ++;
         }
-        // go over the register array and collect all additional data
-        mcd_reg_st *current_register;
-        int id_neg_offset =3D 0;
-        int effective_id;
-        for (i =3D 0; i < mcdserver_state.registers->len; i++) {
-            current_register =3D &(g_array_index(mcdserver_state.registers=
, mcd_reg_st, i));
-            // ad an id handle
-            if (current_register->id) {
-                // id is already in place
-                //FIXME: we are missing 10 registers (likely the FPA regs =
or sth)
-                int used_id =3D current_register->id;
-                register_numbers =3D g_list_append(register_numbers, &used=
_id);
-                id_neg_offset ++;
-            }
-            else {
-                effective_id =3D i - id_neg_offset;
-                if (g_list_find_custom(register_numbers, &effective_id, (G=
CompareFunc)int_cmp)!=3DNULL) {
-                    id_neg_offset --;
-                }
-                current_register->id =3D i - id_neg_offset;
-            }
-            // sort into correct reg_group and according mem_space
-            if (strcmp(current_register->group, "cp_regs")=3D=3D0) {
-                current_register->mcd_reg_group_id =3D 2;
-                current_register->mcd_mem_space_id =3D 6;
-                // get info for opcode
-            }
-            else {
-                // gpr register
-                current_register->mcd_reg_group_id =3D 1;
-                current_register->mcd_mem_space_id =3D 5;
+        else {
+            effective_id =3D i - id_neg_offset;
+            if (g_list_find_custom(register_numbers, &effective_id, (GComp=
areFunc)int_cmp)!=3DNULL) {
+                id_neg_offset --;
             }
+            current_register->id =3D i - id_neg_offset;
+        }
+        // 2. add mcd_reg_group_id and mcd_mem_space_id
+        if (strcmp(current_register->group, "cp_regs")=3D=3D0) {
+            // coprocessor registers
+            current_register->mcd_reg_group_id =3D 2;
+            current_register->mcd_mem_space_id =3D 6;
+            // TODO: get info for opcode
+        }
+        else {
+            // gpr register
+            current_register->mcd_reg_group_id =3D 1;
+            current_register->mcd_mem_space_id =3D 5;
+        }
+    }
+    g_list_free(register_numbers);
+    return 0;
+}
+
+void handle_open_core(GArray *params, void *user_ctx) {
+    // get the cpu whith the given id
+    uint32_t cpu_id =3D get_param(params, 0)->cpu_id;
+    CPUState *cpu =3D mcd_get_cpu(cpu_id);
+    CPUClass *cc =3D CPU_GET_CLASS(cpu);
+    gchar *arch =3D cc->gdb_arch_name(cpu);
+    int return_value =3D 0;
+
+    // prepare data strucutures
+    GArray* memspaces =3D g_array_new(false, true, sizeof(mcd_mem_space_st=
));
+    GArray* reggroups =3D g_array_new(false, true, sizeof(mcd_reg_group_st=
));
+    GArray* registers =3D g_array_new(false, true, sizeof(mcd_reg_st));
+=20=20=20=20
+    if (strcmp(arch, "arm")=3D=3D0) {
+        // TODO: make group and memspace ids dynamic
+        int current_group_id =3D 1;
+        // 1. store mem spaces
+        return_value =3D mcd_arm_store_mem_spaces(cpu, memspaces);
+        if (return_value!=3D0) assert(0);
+        // 2. parse core xml
+        return_value =3D mcd_arm_parse_core_xml_file(cc, reggroups, regist=
ers, &current_group_id);
+        if (return_value!=3D0) assert(0);
+        // 3. parse other xmls
+        return_value =3D mcd_arm_parse_general_xml_files(cpu, reggroups, r=
egisters, &current_group_id);
+        if (return_value!=3D0) assert(0);
+        // 4. add additional data the the regs from the xmls
+        return_value =3D mcd_arm_get_additional_register_info(reggroups, r=
egisters);
+        if (return_value!=3D0) assert(0);
+        // 5. store all found data
+        if (g_list_nth(mcdserver_state.all_memspaces, cpu_id)) {
+            GList* memspaces_ptr =3D g_list_nth(mcdserver_state.all_memspa=
ces, cpu_id);
+            memspaces_ptr->data =3D memspaces;
+        }
+        else {
+            mcdserver_state.all_memspaces =3D g_list_insert(mcdserver_stat=
e.all_memspaces, memspaces, cpu_id);
+        }
+        if (g_list_nth(mcdserver_state.all_reggroups, cpu_id)) {
+            GList* reggroups_ptr =3D g_list_nth(mcdserver_state.all_reggro=
ups, cpu_id);
+            reggroups_ptr->data =3D reggroups;
+        }
+        else {
+            mcdserver_state.all_reggroups =3D g_list_insert(mcdserver_stat=
e.all_reggroups, reggroups, cpu_id);
+        }
+        if (g_list_nth(mcdserver_state.all_registers, cpu_id)) {
+            GList* registers_ptr =3D g_list_nth(mcdserver_state.all_regist=
ers, cpu_id);
+            registers_ptr->data =3D registers;
+        }
+        else {
+            mcdserver_state.all_registers =3D g_list_insert(mcdserver_stat=
e.all_registers, registers, cpu_id);
         }
-        // free memory
-        g_list_free(register_numbers);
     }
     else {
         // we don't support other architectures
@@ -1170,30 +1293,77 @@ void handle_open_core(GArray *params, void *user_ct=
x) {
     g_free(arch);
 }
=20
-void handle_query_reset(GArray *params, void *user_ctx) {
+void handle_query_reset_f(GArray *params, void *user_ctx) {
     // resetting has to be done over a monitor (look ar Rcmd) so we tell M=
CD that we can reset but this still need to be implemented
-    // we only support one reset over this monitor and that would be a ful=
ly "system_restart"
-    mcd_put_packet("nr=3D\"3\",info=3D\"0,full_system_reset;1,gpr_reset;2,=
memory_reset;\"");
+    // we only support one reset over this monitor and that would be a ful=
l "system_restart"
+    // reset options are the same for every cpu!
+=20=20=20=20
+    // 1. check length
+    int nb_resets =3D mcdserver_state.resets->len;
+    if (nb_resets =3D=3D 1) {
+        // indicates this is the last packet
+        g_string_printf(mcdserver_state.str_buf, "0!");
+    }
+    else {
+        g_string_printf(mcdserver_state.str_buf, "1!");
+    }
+    // 2. send data
+    mcd_reset_st reset =3D g_array_index(mcdserver_state.resets, mcd_reset=
_st, 0);
+    g_string_append_printf(mcdserver_state.str_buf, "%s=3D%s.%s=3D%d.", TC=
P_ARGUMENT_NAME, reset.name, TCP_ARGUMENT_ID, reset.id);
+    mcd_put_strbuf();
+    // TODO: we still need to implement the gpr and memory reset here!
+}
+
+void handle_query_reset_c(GArray *params, void *user_ctx) {
+    // reset options are the same for every cpu!
+    int query_index =3D get_param(params, 0)->query_handle;
+=20=20=20=20
+    // 1. check weather this was the last mem space
+    int nb_groups =3D mcdserver_state.resets->len;
+    if (query_index+1 =3D=3D nb_groups) {
+        // indicates this is the last packet
+        g_string_printf(mcdserver_state.str_buf, "0!");
+    }
+    else {
+        g_string_printf(mcdserver_state.str_buf, "%d!", query_index+1);
+    }
+
+    // 2. send data
+    mcd_reset_st reset =3D g_array_index(mcdserver_state.resets, mcd_reset=
_st, query_index);
+    g_string_append_printf(mcdserver_state.str_buf, "%s=3D%s.%s=3D%d.", TC=
P_ARGUMENT_NAME, reset.name, TCP_ARGUMENT_ID, reset.id);
+    mcd_put_strbuf();
     // TODO: we still need to implement the gpr and memory reset here!
 }
=20
-void handle_detach(GArray *params, void *user_ctx) {
+void handle_close_core(GArray *params, void *user_ctx) {
+    // free memory for correct core
+    uint32_t cpu_id =3D get_param(params, 0)->cpu_id;
+    GArray* memspaces =3D g_list_nth_data(mcdserver_state.all_memspaces, c=
pu_id);
+    g_array_free(memspaces, TRUE);
+    GArray* reggroups =3D g_list_nth_data(mcdserver_state.all_reggroups, c=
pu_id);
+    g_array_free(reggroups, TRUE);
+    GArray* registers =3D g_list_nth_data(mcdserver_state.all_registers, c=
pu_id);
+    g_array_free(registers, TRUE);
+}
+
+void handle_close_server(GArray *params, void *user_ctx) {
     uint32_t pid =3D 1;
     MCDProcess *process =3D mcd_get_process(pid);
=20
-    // 1. cleanup
-    // gdb_process_breakpoint_remove_all(process);
+    // 1. free memory
+    // TODO: do this only if there are no processes attached anymore!
+    g_list_free(mcdserver_state.all_memspaces);
+    g_list_free(mcdserver_state.all_reggroups);
+    g_list_free(mcdserver_state.all_registers);
+    g_array_free(mcdserver_state.resets, TRUE);
=20
     // 2. detach
     process->attached =3D false;
=20
-    // reset current cpus
-    // TODO: if we don't use c_cpu we can delete this
-    // this also checks to only reset THIS process we also probably don't =
need this since we only got one process!
+    // 3. reset process
     if (pid =3D=3D mcd_get_cpu_pid(mcdserver_state.c_cpu)) {
         mcdserver_state.c_cpu =3D mcd_first_attached_cpu();
     }
-
     if (!mcdserver_state.c_cpu) {
         /* No more process attached */
         mcd_disable_syscalls();
@@ -1202,14 +1372,10 @@ void handle_detach(GArray *params, void *user_ctx) {
 }
=20
 void handle_query_trigger(GArray *params, void *user_ctx) {
-    // set the type, option and action bitmask and send it
-
-    uint32_t type =3D (MCD_TRIG_TYPE_IP | MCD_TRIG_TYPE_READ | MCD_TRIG_TY=
PE_WRITE | MCD_TRIG_TYPE_RW);
-    uint32_t option =3D (MCD_TRIG_OPT_DATA_IS_CONDITION);
-    uint32_t action =3D (MCD_TRIG_ACTION_DBG_DEBUG);
-    uint32_t nr_trigger =3D 4;
-
-    g_string_printf(mcdserver_state.str_buf, "nr=3D\"%d\",info=3D\"%d;%d;%=
d;\"", nr_trigger, type, option, action);
+    mcd_trigger_st trigger =3D mcdserver_state.trigger;
+    g_string_printf(mcdserver_state.str_buf, "%s=3D%d.%s=3D%d.%s=3D%d.%s=
=3D%d.",
+        TCP_ARGUMENT_AMOUNT_TRIGGER,  trigger.nr_trigger, TCP_ARGUMENT_TYP=
E, trigger.type,
+        TCP_ARGUMENT_OPTION, trigger.option, TCP_ARGUMENT_ACTION, trigger.=
action);
     mcd_put_strbuf();
 }
=20
@@ -1221,8 +1387,13 @@ void mcd_continue(void)
 }
=20
 void handle_query_mem_spaces_f(GArray *params, void *user_ctx) {
-    // send the first mem space
-    int nb_groups =3D mcdserver_state.memspaces->len;
+    // 1. get correct memspaces and set the query_cpu
+    uint32_t cpu_id =3D get_param(params, 0)->cpu_id;
+    mcdserver_state.query_cpu_id =3D cpu_id;
+    GArray* memspaces =3D g_list_nth_data(mcdserver_state.all_memspaces, c=
pu_id);
+
+    // 2. check length
+    int nb_groups =3D memspaces->len;
     if (nb_groups =3D=3D 1) {
         // indicates this is the last packet
         g_string_printf(mcdserver_state.str_buf, "0!");
@@ -1230,20 +1401,26 @@ void handle_query_mem_spaces_f(GArray *params, void=
 *user_ctx) {
     else {
         g_string_printf(mcdserver_state.str_buf, "1!");
     }
-    mcd_mem_space_st space =3D g_array_index(mcdserver_state.memspaces, mc=
d_mem_space_st, 0);
-    g_string_append_printf(mcdserver_state.str_buf, "name=3D%s.id=3D%d.typ=
e=3D%d.bpm=3D%d.i=3D%d.e=3D%d.min=3D%ld.max=3D%ld.sao=3D%d.",
-        space.name, space.id, space.type, space.bits_per_mau, space.invari=
ance, space.endian,
-        space.min_addr, space.max_addr, space.supported_access_options);
+
+    // 3. send data
+    mcd_mem_space_st space =3D g_array_index(memspaces, mcd_mem_space_st, =
0);
+    g_string_append_printf(mcdserver_state.str_buf, "%s=3D%s.%s=3D%d.%s=3D=
%d.%s=3D%d.%s=3D%d.%s=3D%d.%s=3D%ld.%s=3D%ld.%s=3D%d.",
+        TCP_ARGUMENT_NAME, space.name, TCP_ARGUMENT_ID, space.id, TCP_ARGU=
MENT_TYPE, space.type,
+        TCP_ARGUMENT_BITS_PER_MAU, space.bits_per_mau, TCP_ARGUMENT_INVARI=
ANCE, space.invariance, TCP_ARGUMENT_ENDIAN, space.endian,
+        TCP_ARGUMENT_MIN, space.min_addr, TCP_ARGUMENT_MAX, space.max_addr,
+        TCP_ARGUMENT_SUPPORTED_ACCESS_OPTIONS, space.supported_access_opti=
ons);
     mcd_put_strbuf();
 }
=20
 void handle_query_mem_spaces_c(GArray *params, void *user_ctx) {
     // this funcitons send all mem spaces except for the first
-    // 1. get parameter
+    // 1. get parameter and memspace
     int query_index =3D get_param(params, 0)->query_handle;
+    uint32_t cpu_id =3D mcdserver_state.query_cpu_id;
+    GArray* memspaces =3D g_list_nth_data(mcdserver_state.all_memspaces, c=
pu_id);
=20
     // 2. check weather this was the last mem space
-    int nb_groups =3D mcdserver_state.memspaces->len;
+    int nb_groups =3D memspaces->len;
     if (query_index+1 =3D=3D nb_groups) {
         // indicates this is the last packet
         g_string_printf(mcdserver_state.str_buf, "0!");
@@ -1253,16 +1430,23 @@ void handle_query_mem_spaces_c(GArray *params, void=
 *user_ctx) {
     }
=20
     // 3. send the correct memspace
-    mcd_mem_space_st space =3D g_array_index(mcdserver_state.memspaces, mc=
d_mem_space_st, query_index);
-    g_string_append_printf(mcdserver_state.str_buf, "name=3D%s.id=3D%d.typ=
e=3D%d.bpm=3D%d.i=3D%d.e=3D%d.min=3D%ld.max=3D%ld.sao=3D%d.",
-        space.name, space.id, space.type, space.bits_per_mau, space.invari=
ance, space.endian,
-        space.min_addr, space.max_addr, space.supported_access_options);
+    mcd_mem_space_st space =3D g_array_index(memspaces, mcd_mem_space_st, =
query_index);
+    g_string_append_printf(mcdserver_state.str_buf, "%s=3D%s.%s=3D%d.%s=3D=
%d.%s=3D%d.%s=3D%d.%s=3D%d.%s=3D%ld.%s=3D%ld.%s=3D%d.",
+        TCP_ARGUMENT_NAME, space.name, TCP_ARGUMENT_ID, space.id, TCP_ARGU=
MENT_TYPE, space.type,
+        TCP_ARGUMENT_BITS_PER_MAU, space.bits_per_mau, TCP_ARGUMENT_INVARI=
ANCE, space.invariance, TCP_ARGUMENT_ENDIAN, space.endian,
+        TCP_ARGUMENT_MIN, space.min_addr, TCP_ARGUMENT_MAX, space.max_addr,
+        TCP_ARGUMENT_SUPPORTED_ACCESS_OPTIONS, space.supported_access_opti=
ons);
     mcd_put_strbuf();
 }
=20
 void handle_query_reg_groups_f(GArray *params, void *user_ctx) {
-    // send the first reg group
-    int nb_groups =3D mcdserver_state.reggroups->len;
+    // 1. get correct reggroups and set the query_cpu
+    uint32_t cpu_id =3D get_param(params, 0)->cpu_id;
+    mcdserver_state.query_cpu_id =3D cpu_id;
+    GArray* reggroups =3D g_list_nth_data(mcdserver_state.all_reggroups, c=
pu_id);
+
+    // 2. check length
+    int nb_groups =3D reggroups->len;
     if (nb_groups =3D=3D 1) {
         // indicates this is the last packet
         g_string_printf(mcdserver_state.str_buf, "0!");
@@ -1270,18 +1454,21 @@ void handle_query_reg_groups_f(GArray *params, void=
 *user_ctx) {
     else {
         g_string_printf(mcdserver_state.str_buf, "1!");
     }
-    mcd_reg_group_st group =3D g_array_index(mcdserver_state.reggroups, mc=
d_reg_group_st, 0);
-    g_string_append_printf(mcdserver_state.str_buf, "id=3D%d.name=3D%s.", =
group.id, group.name);
+    // 3. send data
+    mcd_reg_group_st group =3D g_array_index(reggroups, mcd_reg_group_st, =
0);
+    g_string_append_printf(mcdserver_state.str_buf, "%s=3D%d.%s=3D%s.", TC=
P_ARGUMENT_ID, group.id, TCP_ARGUMENT_NAME, group.name);
     mcd_put_strbuf();
 }
=20
 void handle_query_reg_groups_c(GArray *params, void *user_ctx) {
     // this funcitons send all reg groups except for the first
-    // 1. get parameter
+    // 1. get parameter and memspace
     int query_index =3D get_param(params, 0)->query_handle;
+    uint32_t cpu_id =3D mcdserver_state.query_cpu_id;
+    GArray* reggroups =3D g_list_nth_data(mcdserver_state.all_reggroups, c=
pu_id);
=20
     // 2. check weather this was the last reg group
-    int nb_groups =3D mcdserver_state.reggroups->len;
+    int nb_groups =3D reggroups->len;
     if (query_index+1 =3D=3D nb_groups) {
         // indicates this is the last packet
         g_string_printf(mcdserver_state.str_buf, "0!");
@@ -1291,14 +1478,19 @@ void handle_query_reg_groups_c(GArray *params, void=
 *user_ctx) {
     }
=20
     // 3. send the correct reggroup
-    mcd_reg_group_st group =3D g_array_index(mcdserver_state.reggroups, mc=
d_reg_group_st, query_index);
-    g_string_append_printf(mcdserver_state.str_buf, "id=3D%d.name=3D%s.", =
group.id, group.name);
+    mcd_reg_group_st group =3D g_array_index(reggroups, mcd_reg_group_st, =
query_index);
+    g_string_append_printf(mcdserver_state.str_buf, "%s=3D%d.%s=3D%s.", TC=
P_ARGUMENT_ID, group.id, TCP_ARGUMENT_NAME, group.name);
     mcd_put_strbuf();
 }
=20
 void handle_query_regs_f(GArray *params, void *user_ctx) {
-    // send the first register
-    int nb_regs =3D mcdserver_state.registers->len;
+    // 1. get correct registers and set the query_cpu
+    uint32_t cpu_id =3D get_param(params, 0)->cpu_id;
+    mcdserver_state.query_cpu_id =3D cpu_id;
+    GArray* registers =3D g_list_nth_data(mcdserver_state.all_registers, c=
pu_id);
+
+    // 2. check length
+    int nb_regs =3D registers->len;
     if (nb_regs =3D=3D 1) {
         // indicates this is the last packet
         g_string_printf(mcdserver_state.str_buf, "0!");
@@ -1306,20 +1498,24 @@ void handle_query_regs_f(GArray *params, void *user=
_ctx) {
     else {
         g_string_printf(mcdserver_state.str_buf, "1!");
     }
-    mcd_reg_st my_register =3D g_array_index(mcdserver_state.registers, mc=
d_reg_st, 0);
-    g_string_append_printf(mcdserver_state.str_buf, "id=3D%d.name=3D%s.siz=
e=3D%d.reggroupid=3D%d.memspaceid=3D%d.type=3D%d.thread=3D%d.",
-        my_register.id, my_register.name, my_register.bitsize, my_register=
.mcd_reg_group_id,
-        my_register.mcd_mem_space_id, my_register.mcd_reg_type, my_registe=
r.mcd_hw_thread_id);
+    // 3. send data
+    mcd_reg_st my_register =3D g_array_index(registers, mcd_reg_st, 0);
+    g_string_append_printf(mcdserver_state.str_buf, "%s=3D%d.%s=3D%s.%s=3D=
%d.%s=3D%d.%s=3D%d.%s=3D%d.%s=3D%d.",
+        TCP_ARGUMENT_ID, my_register.id, TCP_ARGUMENT_NAME,  my_register.n=
ame, TCP_ARGUMENT_SIZE, my_register.bitsize,
+        TCP_ARGUMENT_REGGROUPID, my_register.mcd_reg_group_id, TCP_ARGUMEN=
T_MEMSPACEID, my_register.mcd_mem_space_id,
+        TCP_ARGUMENT_TYPE, my_register.mcd_reg_type, TCP_ARGUMENT_THREAD, =
my_register.mcd_hw_thread_id);
     mcd_put_strbuf();
 }
=20
 void handle_query_regs_c(GArray *params, void *user_ctx) {
-    // this funcitons send all registers except for the first
-    // 1. get parameter
+    // this funcitons send all reg groups except for the first
+    // 1. get parameter and registers
     int query_index =3D get_param(params, 0)->query_handle;
+    uint32_t cpu_id =3D mcdserver_state.query_cpu_id;
+    GArray* registers =3D g_list_nth_data(mcdserver_state.all_registers, c=
pu_id);
=20
     // 2. check weather this was the last register
-    int nb_regs =3D mcdserver_state.registers->len;
+    int nb_regs =3D registers->len;
     if (query_index+1 =3D=3D nb_regs) {
         // indicates this is the last packet
         g_string_printf(mcdserver_state.str_buf, "0!");
@@ -1329,9 +1525,10 @@ void handle_query_regs_c(GArray *params, void *user_=
ctx) {
     }
=20
     // 3. send the correct register
-    mcd_reg_st my_register =3D g_array_index(mcdserver_state.registers, mc=
d_reg_st, query_index);
-    g_string_append_printf(mcdserver_state.str_buf, "id=3D%d.name=3D%s.siz=
e=3D%d.reggroupid=3D%d.memspaceid=3D%d.type=3D%d.thread=3D%d.",
-        my_register.id, my_register.name, my_register.bitsize, my_register=
.mcd_reg_group_id,
-        my_register.mcd_mem_space_id, my_register.mcd_reg_type, my_registe=
r.mcd_hw_thread_id);
+    mcd_reg_st my_register =3D g_array_index(registers, mcd_reg_st, query_=
index);
+    g_string_append_printf(mcdserver_state.str_buf, "%s=3D%d.%s=3D%s.%s=3D=
%d.%s=3D%d.%s=3D%d.%s=3D%d.%s=3D%d.",
+        TCP_ARGUMENT_ID, my_register.id, TCP_ARGUMENT_NAME,  my_register.n=
ame, TCP_ARGUMENT_SIZE, my_register.bitsize,
+        TCP_ARGUMENT_REGGROUPID, my_register.mcd_reg_group_id, TCP_ARGUMEN=
T_MEMSPACEID, my_register.mcd_mem_space_id,
+        TCP_ARGUMENT_TYPE, my_register.mcd_reg_type, TCP_ARGUMENT_THREAD, =
my_register.mcd_hw_thread_id);
     mcd_put_strbuf();
 }
--=20
2.34.1


From e6c686ad758340f1545b928ee54fb4929402ced7 Mon Sep 17 00:00:00 2001
From: Nicolas Eder <nicolas.eder@lauterbach.com>
Date: Wed, 28 Jun 2023 18:01:44 +0200
Subject: [PATCH 10/29] handler for resets added

Signed-off-by: Nicolas Eder <nicolas.eder@lauterbach.com>
---
 mcdstub/internals.h          | 14 ++++----
 mcdstub/mcd_shared_defines.h |  4 +++
 mcdstub/mcdstub.c            | 65 ++++++++++++++++++++++++++++--------
 3 files changed, 63 insertions(+), 20 deletions(-)

diff --git a/mcdstub/internals.h b/mcdstub/internals.h
index a4d49a4a84..0de8d8fd07 100644
--- a/mcdstub/internals.h
+++ b/mcdstub/internals.h
@@ -25,6 +25,7 @@
 // schema defines
 #define ARG_SCHEMA_QRYHANDLE 'q'
 #define ARG_SCHEMA_STRING 's'
+#define ARG_SCHEMA_INT 'd'
 #define ARG_SCHEMA_CORENUM 'c'
=20
 // resets
@@ -34,8 +35,8 @@
=20
 // more
 #define QUERY_TOTAL_NUMBER 11 //FIXME: set this to a usefull value in the =
end
-#define CMD_SCHEMA_LENGTH 2
-#define MCD_MAX_CORES 128
+#define CMD_SCHEMA_LENGTH 3
+#define MAX_SCHEMA_ARGS CMD_SCHEMA_LENGTH-1
 #define MCD_SYSTEM_NAME "qemu-system"
 // tcp query packet values templates
 #define DEVICE_NAME_TEMPLATE(s) "qemu-" #s "-device"
@@ -77,17 +78,17 @@ typedef enum MCDThreadIdKind {
 } MCDThreadIdKind;
=20
 typedef union MCDCmdVariant {
-    const char *data;
=20=20=20=20=20
+    const char *data;
+    int data_int;
+    int query_handle;
+    int cpu_id;
     struct {
         MCDThreadIdKind kind;
         uint32_t pid;
         uint32_t tid;
     } thread_id;
=20
-    int query_handle;
-    int cpu_id;
-
 } MCDCmdVariant;
=20
 #define get_param(p, i)    (&g_array_index(p, MCDCmdVariant, i))
@@ -277,6 +278,7 @@ void handle_query_regs_f(GArray *params, void *user_ctx=
);
 void handle_query_regs_c(GArray *params, void *user_ctx);
 void handle_open_server(GArray *params, void *user_ctx);
 void parse_reg_xml(const char *xml, int size, GArray* registers);
+void handle_reset(GArray *params, void *user_ctx);
=20
 // arm specific functions
 int mcd_arm_store_mem_spaces(CPUState *cpu, GArray* memspaces);
diff --git a/mcdstub/mcd_shared_defines.h b/mcdstub/mcd_shared_defines.h
index e0b27ce5e6..7e96129cdf 100644
--- a/mcdstub/mcd_shared_defines.h
+++ b/mcdstub/mcd_shared_defines.h
@@ -11,6 +11,7 @@
 #define TCP_CHAR_CLOSE_SERVER 'D'
 #define TCP_CHAR_CLOSE_CORE 'd'
 #define TCP_CHAR_KILLQEMU 'k'
+#define TCP_CHAR_RESET 'r'
=20
 // tcp protocol chars
 #define TCP_ACKNOWLEDGED '+'
@@ -54,4 +55,7 @@
 #define TCP_ARGUMENT_OPTION "option"
 #define TCP_ARGUMENT_ACTION "action"
=20
+// for packets sent to qemu
+#define ARGUMENT_SEPARATOR ';'
+
 #endif
diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index a0c4c2794f..85e0c3a219 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -508,6 +508,16 @@ int mcd_handle_packet(const char *line_buf)
             cmd_parser =3D &close_core_cmd_desc;
         }
         break;
+    case TCP_CHAR_RESET:
+        {
+            static MCDCmdParseEntry reset_cmd_desc =3D {
+                .handler =3D handle_reset,
+            };
+            reset_cmd_desc.cmd =3D (char[2]) { (char) TCP_CHAR_RESET, '\0'=
 };
+            strcpy(reset_cmd_desc.schema, (char[3]) { (char) ARG_SCHEMA_IN=
T, ARG_SCHEMA_INT, '\0' });
+            cmd_parser =3D &reset_cmd_desc;
+        }
+        break;
     default:
         // could not perform the command (because its unknown)
         mcd_put_packet("");
@@ -564,24 +574,42 @@ void run_cmd_parser(const char *data, const MCDCmdPar=
seEntry *cmd)
 }
=20
 int cmd_parse_params(const char *data, const char *schema, GArray *params)=
 {
-    MCDCmdVariant this_param;
-
+=20=20=20=20
     char data_buffer[64] =3D {0};
-    if (schema[0] =3D=3D ARG_SCHEMA_STRING) {
-        this_param.data =3D data;
-        g_array_append_val(params, this_param);
-    }
-    else if (schema[0] =3D=3D ARG_SCHEMA_QRYHANDLE) {
-        strncat(data_buffer, data, strlen(data));
-        this_param.query_handle =3D atoi(data_buffer);
-        g_array_append_val(params, this_param);
+    char *separator =3D strchr(data_buffer, ARGUMENT_SEPARATOR);
+    int seperator_index =3D (int)(separator - data);
+
+    if (separator) {
+        // we got two arguments
+        strncpy(data_buffer, data, seperator_index);
     }
-    else if (schema[0] =3D=3D ARG_SCHEMA_CORENUM) {
-        strncat(data_buffer, data, strlen(data));
-        this_param.cpu_id =3D atoi(data_buffer);
-        g_array_append_val(params, this_param);
+    else {
+        strncpy(data_buffer, data, strlen(data));
     }
+    for (int i =3D 0; i<MAX_SCHEMA_ARGS; i++) {
+        MCDCmdVariant this_param;
+        if (schema[i] =3D=3D ARG_SCHEMA_STRING) {
+            this_param.data =3D data_buffer;
+            g_array_append_val(params, this_param);
+        }
+        else if (schema[i] =3D=3D ARG_SCHEMA_INT) {
+            this_param.data_int =3D atoi(data_buffer);
+            g_array_append_val(params, this_param);
+        }
+        else if (schema[i] =3D=3D ARG_SCHEMA_QRYHANDLE) {
+            this_param.query_handle =3D atoi(data_buffer);
+            g_array_append_val(params, this_param);
+        }
+        else if (schema[i] =3D=3D ARG_SCHEMA_CORENUM) {
+            this_param.cpu_id =3D atoi(data_buffer);
+            g_array_append_val(params, this_param);
+        }
=20
+        if (separator) {
+            // we got two arguments
+            strncpy(data_buffer, &data[seperator_index+1], strlen(&data[se=
perator_index+1]));
+        }
+    }
     return 0;
 }
=20
@@ -1532,3 +1560,12 @@ void handle_query_regs_c(GArray *params, void *user_=
ctx) {
         TCP_ARGUMENT_TYPE, my_register.mcd_reg_type, TCP_ARGUMENT_THREAD, =
my_register.mcd_hw_thread_id);
     mcd_put_strbuf();
 }
+
+void handle_reset(GArray *params, void *user_ctx) {
+    int reset_id =3D get_param(params, 0)->data_int;
+    int bool_halt_after_reset =3D get_param(params, 1)->data_int;
+    if (reset_id>=3D0 && bool_halt_after_reset) {
+        //fun for the compiler
+    }
+=20=20=20=20
+}
--=20
2.34.1


From cade07c1cd8929a4116711a2e798b5983a2aaec2 Mon Sep 17 00:00:00 2001
From: Nicolas Eder <nicolas.eder@lauterbach.com>
Date: Thu, 29 Jun 2023 16:06:28 +0200
Subject: [PATCH 11/29] query for the VM state added

Signed-off-by: Nicolas Eder <nicolas.eder@lauterbach.com>
---
 mcdstub/internals.h          |  54 ++++++++-
 mcdstub/mcd_shared_defines.h |  13 ++
 mcdstub/mcdstub.c            | 229 ++++++++++++++++++++++++++++-------
 3 files changed, 249 insertions(+), 47 deletions(-)

diff --git a/mcdstub/internals.h b/mcdstub/internals.h
index 0de8d8fd07..2c64cfc0f9 100644
--- a/mcdstub/internals.h
+++ b/mcdstub/internals.h
@@ -22,6 +22,21 @@
 #define MCD_TRIG_OPT_DATA_IS_CONDITION 0x00000008
 #define MCD_TRIG_ACTION_DBG_DEBUG 0x00000001
=20
+typedef uint32_t mcd_core_event_et;
+enum {
+	MCD_CORE_EVENT_NONE            =3D 0x00000000,   /**< No since the last p=
oll.                                 */
+	MCD_CORE_EVENT_MEMORY_CHANGE   =3D 0x00000001,   /**< Memory content has =
changed.                             */
+	MCD_CORE_EVENT_REGISTER_CHANGE =3D 0x00000002,   /**< Register contents h=
ave changed.                         */
+	MCD_CORE_EVENT_TRACE_CHANGE    =3D 0x00000004,   /**< Trace contents or s=
tates have changed.                  */
+	MCD_CORE_EVENT_TRIGGER_CHANGE  =3D 0x00000008,   /**< Triggers or trigger=
 states have changed.                */
+	MCD_CORE_EVENT_STOPPED         =3D 0x00000010,   /**< Target was stopped =
at least once since the last poll,
+		it may already be running again.                        */
+	MCD_CORE_EVENT_CHL_PENDING     =3D 0x00000020,   /**< A target communicat=
ion channel request from the target
+		is pending.                                             */
+	MCD_CORE_EVENT_CUSTOM_LO       =3D 0x00010000,   /**< Begin Range: User d=
efined core events.                  */
+	MCD_CORE_EVENT_CUSTOM_HI       =3D 0x40000000,   /**< End   Range: User d=
efined core events.                  */
+};
+
 // schema defines
 #define ARG_SCHEMA_QRYHANDLE 'q'
 #define ARG_SCHEMA_STRING 's'
@@ -34,13 +49,25 @@
 #define RESET_MEMORY "memory_reset"
=20
 // more
-#define QUERY_TOTAL_NUMBER 11 //FIXME: set this to a usefull value in the =
end
-#define CMD_SCHEMA_LENGTH 3
-#define MAX_SCHEMA_ARGS CMD_SCHEMA_LENGTH-1
+#define QUERY_TOTAL_NUMBER 12 //FIXME: set this to a usefull value in the =
end
+#define CMD_SCHEMA_LENGTH 2
 #define MCD_SYSTEM_NAME "qemu-system"
 // tcp query packet values templates
 #define DEVICE_NAME_TEMPLATE(s) "qemu-" #s "-device"
=20
+// state strings
+#define STATE_STR_UNKNOWN(d) "cpu " #d " in unknown state"
+#define STATE_STR_DEBUG(d) "cpu " #d " in debug state"
+#define STATE_STR_RUNNING(d) "cpu " #d " running"
+#define STATE_STR_HALTED(d) "cpu " #d " currently halted"
+#define STATE_STR_INIT_HALTED "vm halted since boot"
+#define STATE_STR_INIT_RUNNING "vm running since boot"
+#define STATE_STR_BREAK_HW "stopped beacuse of HW breakpoint"
+#define STATE_STR_BREAK_READ(d) "stopped beacuse of read access at " #d
+#define STATE_STR_BREAK_WRITE(d) "stopped beacuse of write access at " #d
+#define STATE_STR_BREAK_RW(d) "stopped beacuse of read or write access at =
" #d
+#define STATE_STR_BREAK_UNKNOWN "stopped for unknown reason"
+
 // GDB stuff thats needed for GDB function, which we use
 typedef struct GDBRegisterState {
     int base_reg;
@@ -113,6 +140,16 @@ typedef struct mcd_trigger_st {
     uint32_t nr_trigger;
 } mcd_trigger_st;
=20
+typedef struct mcd_cpu_state_st {
+    const char *state;
+    bool memory_changed;
+    bool registers_changed;
+    bool target_was_stopped;
+    uint32_t trig_id;
+    const char *stop_str;
+    const char *info_str;
+} mcd_cpu_state_st;
+
 typedef struct MCDState {
     bool init;       /* have we been initialised? */
     CPUState *c_cpu; /* current CPU for everything */
@@ -134,12 +171,15 @@ typedef struct MCDState {
     int supported_sstep_flags;
=20
     // my stuff
+    RunState vm_current_state;
+    RunState vm_previous_state;
     uint32_t query_cpu_id;
     GList *all_memspaces;
     GList *all_reggroups;
     GList *all_registers;
     GArray *resets;
     mcd_trigger_st trigger;
+    mcd_cpu_state_st cpu_state;
     MCDCmdParseEntry mcd_query_cmds_table[QUERY_TOTAL_NUMBER];
 } MCDState;
=20
@@ -254,9 +294,9 @@ void mcd_exit(int code);
 void run_cmd_parser(const char *data, const MCDCmdParseEntry *cmd);
 int process_string_cmd(void *user_ctx, const char *data, const MCDCmdParse=
Entry *cmds, int num_cmds);
 int cmd_parse_params(const char *data, const char *schema, GArray *params);
-void handle_continue(GArray *params, void *user_ctx);
+void handle_vm_start(GArray *params, void *user_ctx);
+void handle_vm_stop(GArray *params, void *user_ctx);
 void handle_gen_query(GArray *params, void *user_ctx);
-void mcd_append_thread_id(CPUState *cpu, GString *buf);
 int mcd_get_cpu_index(CPUState *cpu);
 CPUState* mcd_get_cpu(uint32_t i_cpu_index);
 void handle_query_cores(GArray *params, void *user_ctx);
@@ -269,7 +309,8 @@ void handle_query_reset_c(GArray *params, void *user_ct=
x);
 void handle_close_server(GArray *params, void *user_ctx);
 void handle_close_core(GArray *params, void *user_ctx);
 void handle_query_trigger(GArray *params, void *user_ctx);
-void mcd_continue(void);
+void mcd_vm_start(void);
+void mcd_vm_stop(void);
 void handle_query_reg_groups_f(GArray *params, void *user_ctx);
 void handle_query_reg_groups_c(GArray *params, void *user_ctx);
 void handle_query_mem_spaces_f(GArray *params, void *user_ctx);
@@ -279,6 +320,7 @@ void handle_query_regs_c(GArray *params, void *user_ctx=
);
 void handle_open_server(GArray *params, void *user_ctx);
 void parse_reg_xml(const char *xml, int size, GArray* registers);
 void handle_reset(GArray *params, void *user_ctx);
+void handle_query_state(GArray *params, void *user_ctx);
=20
 // arm specific functions
 int mcd_arm_store_mem_spaces(CPUState *cpu, GArray* memspaces);
diff --git a/mcdstub/mcd_shared_defines.h b/mcdstub/mcd_shared_defines.h
index 7e96129cdf..8cec2e9f23 100644
--- a/mcdstub/mcd_shared_defines.h
+++ b/mcdstub/mcd_shared_defines.h
@@ -7,6 +7,7 @@
 #define TCP_CHAR_OPEN_SERVER 'I'
 #define TCP_CHAR_OPEN_CORE 'i'
 #define TCP_CHAR_GO 'c'
+#define TCP_CHAR_BREAK 'b'
 #define TCP_CHAR_QUERY 'q'
 #define TCP_CHAR_CLOSE_SERVER 'D'
 #define TCP_CHAR_CLOSE_CORE 'd'
@@ -33,6 +34,7 @@
 #define QUERY_ARG_MEMORY "memory"
 #define QUERY_ARG_REGGROUP "reggroup"
 #define QUERY_ARG_REG "reg"
+#define QUERY_ARG_STATE "state"
=20
 // tcp query packet argument list
 #define TCP_ARGUMENT_NAME "name"
@@ -48,6 +50,11 @@
 #define TCP_ARGUMENT_MEMSPACEID "memspaceid"
 #define TCP_ARGUMENT_SIZE "size"
 #define TCP_ARGUMENT_THREAD "thread"
+#define TCP_ARGUMENT_TRIGGER_ID "trig_id"
+#define TCP_ARGUMENT_STOP_STRING "stop_str"
+#define TCP_ARGUMENT_INFO_STRING "info_str"
+#define TCP_ARGUMENT_STATE "state"
+#define TCP_ARGUMENT_EVENT "event"
 #define TCP_ARGUMENT_DEVICE "device"
 #define TCP_ARGUMENT_CORE "core"
 #define TCP_ARGUMENT_AMOUNT_CORE "nr_cores"
@@ -58,4 +65,10 @@
 // for packets sent to qemu
 #define ARGUMENT_SEPARATOR ';'
=20
+// core states
+#define CORE_STATE_RUNNING "running"
+#define CORE_STATE_HALTED "halted"
+#define CORE_STATE_DEBUG "debug"
+#define CORE_STATE_UNKNOWN "unknown"
+
 #endif
diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index 85e0c3a219..dc40a68338 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -68,6 +68,13 @@ void mcd_init_mcdserver_state(void)
=20
     // init query table
     init_query_cmds_table(mcdserver_state.mcd_query_cmds_table);
+
+    // at this time the cpu hans't been started! -> set cpu_state
+    mcd_cpu_state_st cpu_state =3D  {
+            .state =3D CORE_STATE_HALTED,
+            .info_str =3D STATE_STR_INIT_HALTED,
+    };
+    mcdserver_state.cpu_state =3D cpu_state;
 }
=20
 void init_query_cmds_table(MCDCmdParseEntry* mcd_query_cmds_table) {
@@ -156,6 +163,14 @@ void init_query_cmds_table(MCDCmdParseEntry* mcd_query=
_cmds_table) {
     };
     strcpy(query_regs_c.schema, (char[2]) { (char) ARG_SCHEMA_QRYHANDLE, '=
\0' });
     mcd_query_cmds_table[cmd_number] =3D query_regs_c;
+    cmd_number++;
+
+    MCDCmdParseEntry query_state =3D {
+        .handler =3D handle_query_state,
+        .cmd =3D QUERY_ARG_STATE,
+    };
+    strcpy(query_state.schema, (char[2]) { (char) ARG_SCHEMA_CORENUM, '\0'=
 });
+    mcd_query_cmds_table[cmd_number] =3D query_state;
 }
=20
 void reset_mcdserver_state(void)
@@ -336,6 +351,7 @@ void mcd_chr_receive(void *opaque, const uint8_t *buf, =
int size)
=20=09
     for (i =3D 0; i < size; i++) {
         mcd_read_byte(buf[i]);
+        if (buf[i]=3D=3D0) break;
     }
 }
=20
@@ -366,12 +382,12 @@ void mcd_read_byte(uint8_t ch)
             return;
         }
     }
-    if (runstate_is_running()) {
+    //if (runstate_is_running()) {
         /* when the CPU is running, we cannot do anything except stop
            it when receiving a char */
-        vm_stop(RUN_STATE_PAUSED);
-    }
-    else {
+        //vm_stop(RUN_STATE_PAUSED);
+    //}
+    //else {
         switch(mcdserver_state.state) {
         case RS_IDLE:
             if (ch =3D=3D TCP_COMMAND_START) {
@@ -434,7 +450,7 @@ void mcd_read_byte(uint8_t ch)
         default:
             abort();
         }
-    }
+    //}
 }
=20
 int mcd_handle_packet(const char *line_buf)
@@ -457,12 +473,22 @@ int mcd_handle_packet(const char *line_buf)
         // go command
         {
             static MCDCmdParseEntry go_cmd_desc =3D {
-                .handler =3D handle_continue,
+                .handler =3D handle_vm_start,
             };
             go_cmd_desc.cmd =3D (char[2]) { (char) TCP_CHAR_GO, '\0' };
             cmd_parser =3D &go_cmd_desc;
         }
         break;
+    case TCP_CHAR_BREAK:
+        // go command
+        {
+            static MCDCmdParseEntry break_cmd_desc =3D {
+                .handler =3D handle_vm_stop,
+            };
+            break_cmd_desc.cmd =3D (char[2]) { (char) TCP_CHAR_BREAK, '\0'=
 };
+            cmd_parser =3D &break_cmd_desc;
+        }
+        break;
     case TCP_CHAR_KILLQEMU:
         // kill qemu completely
         error_report("QEMU: Terminated via MCDstub");
@@ -514,7 +540,7 @@ int mcd_handle_packet(const char *line_buf)
                 .handler =3D handle_reset,
             };
             reset_cmd_desc.cmd =3D (char[2]) { (char) TCP_CHAR_RESET, '\0'=
 };
-            strcpy(reset_cmd_desc.schema, (char[3]) { (char) ARG_SCHEMA_IN=
T, ARG_SCHEMA_INT, '\0' });
+            strcpy(reset_cmd_desc.schema, (char[2]) { (char) ARG_SCHEMA_IN=
T, '\0' });
             cmd_parser =3D &reset_cmd_desc;
         }
         break;
@@ -532,16 +558,14 @@ int mcd_handle_packet(const char *line_buf)
     return RS_IDLE;
 }
=20
-void handle_continue(GArray *params, void *user_ctx)
-{
-    /*
-    if (params->len) {
-        gdb_set_cpu_pc(get_param(params, 0)->val_ull);
-    }
+void handle_vm_start(GArray *params, void *user_ctx) {
+    // todo add partial restart with arguments and so on
+    mcd_vm_start();
+}
=20
-    mcdserver_state.signal =3D 0;
-    gdb_continue();
-    */
+void handle_vm_stop(GArray *params, void *user_ctx) {
+    // todo add partial stop with arguments and so on
+    mcd_vm_stop();
 }
=20
 void handle_gen_query(GArray *params, void *user_ctx)
@@ -576,7 +600,7 @@ void run_cmd_parser(const char *data, const MCDCmdParse=
Entry *cmd)
 int cmd_parse_params(const char *data, const char *schema, GArray *params)=
 {
=20=20=20=20=20
     char data_buffer[64] =3D {0};
-    char *separator =3D strchr(data_buffer, ARGUMENT_SEPARATOR);
+    char *separator =3D strchr(data, ARGUMENT_SEPARATOR);
     int seperator_index =3D (int)(separator - data);
=20
     if (separator) {
@@ -586,25 +610,29 @@ int cmd_parse_params(const char *data, const char *sc=
hema, GArray *params) {
     else {
         strncpy(data_buffer, data, strlen(data));
     }
-    for (int i =3D 0; i<MAX_SCHEMA_ARGS; i++) {
-        MCDCmdVariant this_param;
-        if (schema[i] =3D=3D ARG_SCHEMA_STRING) {
-            this_param.data =3D data_buffer;
+    for (int i =3D 0; i<strlen(schema); i++) {
+        MCDCmdVariant this_param;=20
+        switch (schema[i]) {
+        case ARG_SCHEMA_STRING:
+            this_param.data =3D data;
             g_array_append_val(params, this_param);
-        }
-        else if (schema[i] =3D=3D ARG_SCHEMA_INT) {
+            break;
+        case ARG_SCHEMA_INT:
             this_param.data_int =3D atoi(data_buffer);
             g_array_append_val(params, this_param);
-        }
-        else if (schema[i] =3D=3D ARG_SCHEMA_QRYHANDLE) {
+            break;
+        case ARG_SCHEMA_QRYHANDLE:
             this_param.query_handle =3D atoi(data_buffer);
             g_array_append_val(params, this_param);
-        }
-        else if (schema[i] =3D=3D ARG_SCHEMA_CORENUM) {
+            break;
+        case ARG_SCHEMA_CORENUM:
             this_param.cpu_id =3D atoi(data_buffer);
             g_array_append_val(params, this_param);
+            break;
+        default:
+            return -1;
         }
-
+=20=20=20=20=20=20=20=20
         if (separator) {
             // we got two arguments
             strncpy(data_buffer, &data[seperator_index+1], strlen(&data[se=
perator_index+1]));
@@ -633,7 +661,7 @@ int process_string_cmd(void *user_ctx, const char *data=
, const MCDCmdParseEntry
         }
=20
         // if a schema is provided we need to extract parameters from the =
data string
-        if (cmd->schema) {
+        if (strlen(cmd->schema)) {
             // this only gets the data from data beginning after the comma=
nd name
             if (cmd_parse_params(&data[strlen(cmd->cmd)], cmd->schema, par=
ams)) {
                 return -1;
@@ -679,7 +707,7 @@ void mcd_chr_event(void *opaque, QEMUChrEvent event)
=20
         s->c_cpu =3D mcd_first_attached_cpu();
=20
-        vm_stop(RUN_STATE_PAUSED);
+        //vm_stop(RUN_STATE_PAUSED);
 		//TODO: this might not be necessary
         //replay_gdb_attached();
         //gdb_has_xml =3D false;
@@ -709,14 +737,98 @@ void mcd_sigterm_handler(int signal)
=20
 void mcd_vm_state_change(void *opaque, bool running, RunState state)
 {
-	printf("this calls state_change\n");
+	CPUState *cpu =3D mcdserver_state.c_cpu;
+
+    // update cpu state
+    mcdserver_state.vm_previous_state =3D mcdserver_state.vm_current_state;
+    mcdserver_state.vm_current_state =3D state;
+
+    if (mcdserver_state.state =3D=3D RS_INACTIVE) {
+        return;
+    }
+
+    if (cpu =3D=3D NULL) {
+        if (running) {
+            // this is the case if qemu starts the vm before any mcd is co=
nnected
+            const char *mcd_state;
+            mcd_state =3D CORE_STATE_RUNNING;
+            const char *info_str;
+            info_str =3D STATE_STR_INIT_RUNNING;
+            mcdserver_state.cpu_state.state =3D mcd_state;
+            mcdserver_state.cpu_state.state =3D info_str;
+        }
+        return;
+    }
+
+    const char *mcd_state;
+    const char *stop_str;
+    const char *info_str;
+    uint32_t trig_id =3D 0;
+    switch (state) {
+    case RUN_STATE_RUNNING:
+        mcd_state =3D CORE_STATE_RUNNING;
+        info_str =3D STATE_STR_RUNNING(cpu->cpu_index);
+        stop_str =3D "";
+        break;
+    case RUN_STATE_DEBUG:
+        mcd_state =3D CORE_STATE_DEBUG;
+        info_str =3D STATE_STR_DEBUG(cpu->cpu_index);
+        if (cpu->watchpoint_hit) {
+            switch (cpu->watchpoint_hit->flags & BP_MEM_ACCESS) {
+            case BP_MEM_READ:
+                trig_id =3D MCD_TRIG_TYPE_READ;
+                stop_str =3D STATE_STR_BREAK_READ(cpu->watchpoint_hit->hit=
addr);
+                break;
+            case BP_MEM_WRITE:
+                trig_id =3D MCD_TRIG_TYPE_WRITE;
+                stop_str =3D STATE_STR_BREAK_WRITE(cpu->watchpoint_hit->hi=
taddr);
+                break;
+            case BP_MEM_ACCESS:
+                trig_id =3D MCD_TRIG_TYPE_RW;
+                stop_str =3D STATE_STR_BREAK_RW(cpu->watchpoint_hit->hitad=
dr);
+                break;
+            default:
+                break;
+                stop_str =3D STATE_STR_BREAK_UNKNOWN;
+            }
+            cpu->watchpoint_hit =3D NULL;
+        } else {
+            // "hardware" breakpoint hit!
+            trig_id =3D MCD_TRIG_TYPE_IP;
+            stop_str =3D STATE_STR_BREAK_HW;
+            tb_flush(cpu);
+        }
+        break;
+    case RUN_STATE_PAUSED:
+        info_str =3D STATE_STR_HALTED(cpu->cpu_index);
+        mcd_state =3D CORE_STATE_HALTED;
+        stop_str =3D "";
+        break;
+    case RUN_STATE_WATCHDOG:
+        info_str =3D STATE_STR_UNKNOWN(cpu->cpu_index);
+        mcd_state =3D CORE_STATE_UNKNOWN;
+        stop_str =3D "";
+        printf("runstate watchdog hit\n");
+        break;
+    default:
+        info_str =3D STATE_STR_UNKNOWN(cpu->cpu_index);
+        mcd_state =3D CORE_STATE_UNKNOWN;
+        stop_str =3D "";
+        // we don't care;
+        break;
+    }
+
+    mcdserver_state.cpu_state.state =3D mcd_state;
+    mcdserver_state.cpu_state.trig_id =3D trig_id;
+    mcdserver_state.cpu_state.stop_str =3D stop_str;
+    mcdserver_state.cpu_state.info_str =3D info_str;
+
+    /* disable single step if it was enabled */
+    cpu_single_step(cpu, 0);
 }
=20
 int mcd_put_packet(const char *buf)
 {
-	//tracing
-    //trace_gdbstub_io_reply(buf);
-
     return mcd_put_packet_binary(buf, strlen(buf), false);
 }
=20
@@ -1267,6 +1379,7 @@ void handle_open_core(GArray *params, void *user_ctx)=
 {
     // get the cpu whith the given id
     uint32_t cpu_id =3D get_param(params, 0)->cpu_id;
     CPUState *cpu =3D mcd_get_cpu(cpu_id);
+    mcdserver_state.c_cpu =3D cpu;
     CPUClass *cc =3D CPU_GET_CLASS(cpu);
     gchar *arch =3D cc->gdb_arch_name(cpu);
     int return_value =3D 0;
@@ -1318,6 +1431,7 @@ void handle_open_core(GArray *params, void *user_ctx)=
 {
         // we don't support other architectures
         assert(0);
     }
+
     g_free(arch);
 }
=20
@@ -1367,10 +1481,13 @@ void handle_close_core(GArray *params, void *user_c=
tx) {
     // free memory for correct core
     uint32_t cpu_id =3D get_param(params, 0)->cpu_id;
     GArray* memspaces =3D g_list_nth_data(mcdserver_state.all_memspaces, c=
pu_id);
+    mcdserver_state.all_memspaces =3D g_list_remove(mcdserver_state.all_me=
mspaces, memspaces);
     g_array_free(memspaces, TRUE);
     GArray* reggroups =3D g_list_nth_data(mcdserver_state.all_reggroups, c=
pu_id);
+    mcdserver_state.all_reggroups =3D g_list_remove(mcdserver_state.all_re=
ggroups, reggroups);
     g_array_free(reggroups, TRUE);
     GArray* registers =3D g_list_nth_data(mcdserver_state.all_registers, c=
pu_id);
+    mcdserver_state.all_registers =3D g_list_remove(mcdserver_state.all_re=
gisters, registers);
     g_array_free(registers, TRUE);
 }
=20
@@ -1395,7 +1512,7 @@ void handle_close_server(GArray *params, void *user_c=
tx) {
     if (!mcdserver_state.c_cpu) {
         /* No more process attached */
         mcd_disable_syscalls();
-        mcd_continue();
+        mcd_vm_start();
     }
 }
=20
@@ -1407,13 +1524,19 @@ void handle_query_trigger(GArray *params, void *use=
r_ctx) {
     mcd_put_strbuf();
 }
=20
-void mcd_continue(void)
-{
-    if (!runstate_needs_reset()) {
+void mcd_vm_start(void) {
+    if (!runstate_needs_reset() && !runstate_is_running()) {
         vm_start();
     }
 }
=20
+void mcd_vm_stop(void) {
+    if (runstate_is_running()) {
+        //might want to have DEBUG state here but idk
+        vm_stop(RUN_STATE_PAUSED);
+    }
+}
+
 void handle_query_mem_spaces_f(GArray *params, void *user_ctx) {
     // 1. get correct memspaces and set the query_cpu
     uint32_t cpu_id =3D get_param(params, 0)->cpu_id;
@@ -1563,9 +1686,33 @@ void handle_query_regs_c(GArray *params, void *user_=
ctx) {
=20
 void handle_reset(GArray *params, void *user_ctx) {
     int reset_id =3D get_param(params, 0)->data_int;
-    int bool_halt_after_reset =3D get_param(params, 1)->data_int;
-    if (reset_id>=3D0 && bool_halt_after_reset) {
+    //int bool_halt_after_reset =3D get_param(params, 1)->data_int;
+    if (reset_id>=3D0) {
         //fun for the compiler
     }
-=20=20=20=20
+}
+
+void handle_query_state(GArray *params, void *user_ctx) {
+    // send state from correct core
+    //uint32_t cpu_id =3D get_param(params, 0)->cpu_id;
+    // get state info
+    mcd_cpu_state_st state_info =3D mcdserver_state.cpu_state;
+    mcd_core_event_et event =3D MCD_CORE_EVENT_NONE;
+    if (state_info.memory_changed) {
+        event =3D event | MCD_CORE_EVENT_MEMORY_CHANGE;
+        state_info.memory_changed =3D false;
+    }
+    if (state_info.registers_changed) {
+        event =3D event | MCD_CORE_EVENT_REGISTER_CHANGE;
+        state_info.registers_changed =3D false;
+    }
+    if (state_info.target_was_stopped) {
+        event =3D event | MCD_CORE_EVENT_STOPPED;
+        state_info.target_was_stopped =3D false;
+    }
+    // send data
+    g_string_printf(mcdserver_state.str_buf, "%s=3D%s.%s=3D%d.%s=3D%d.%s=
=3D%d.%s=3D%s.%s=3D%s.", TCP_ARGUMENT_STATE, state_info.state,
+        TCP_ARGUMENT_EVENT, event, TCP_ARGUMENT_THREAD, 0, TCP_ARGUMENT_TR=
IGGER_ID, state_info.trig_id,
+        TCP_ARGUMENT_STOP_STRING, state_info.stop_str, TCP_ARGUMENT_INFO_S=
TRING, state_info.info_str);
+    mcd_put_strbuf();
 }
--=20
2.34.1


From f7175242512470cccc930f10759327553e1e4b03 Mon Sep 17 00:00:00 2001
From: Nicolas Eder <nicolas.eder@lauterbach.com>
Date: Sun, 2 Jul 2023 14:44:05 +0200
Subject: [PATCH 12/29] handler for reading registers added

Signed-off-by: Nicolas Eder <nicolas.eder@lauterbach.com>
---
 mcdstub/internals.h          |  11 ++-
 mcdstub/mcd_shared_defines.h |   7 ++
 mcdstub/mcdstub.c            | 129 +++++++++++++++++++++++++++++++++++
 target/arm/mcdstub.c         |  75 ++++++++++++++++++++
 target/arm/mcdstub.h         |   7 ++
 5 files changed, 228 insertions(+), 1 deletion(-)
 create mode 100644 target/arm/mcdstub.c
 create mode 100644 target/arm/mcdstub.h

diff --git a/mcdstub/internals.h b/mcdstub/internals.h
index 2c64cfc0f9..a85173d0d1 100644
--- a/mcdstub/internals.h
+++ b/mcdstub/internals.h
@@ -41,6 +41,7 @@ enum {
 #define ARG_SCHEMA_QRYHANDLE 'q'
 #define ARG_SCHEMA_STRING 's'
 #define ARG_SCHEMA_INT 'd'
+#define ARG_SCHEMA_UINT32_T 'l'
 #define ARG_SCHEMA_CORENUM 'c'
=20
 // resets
@@ -50,7 +51,7 @@ enum {
=20
 // more
 #define QUERY_TOTAL_NUMBER 12 //FIXME: set this to a usefull value in the =
end
-#define CMD_SCHEMA_LENGTH 2
+#define CMD_SCHEMA_LENGTH 3
 #define MCD_SYSTEM_NAME "qemu-system"
 // tcp query packet values templates
 #define DEVICE_NAME_TEMPLATE(s) "qemu-" #s "-device"
@@ -108,6 +109,7 @@ typedef union MCDCmdVariant {
=20=20=20=20=20
     const char *data;
     int data_int;
+    uint64_t data_uint64_t;
     int query_handle;
     int cpu_id;
     struct {
@@ -321,6 +323,12 @@ void handle_open_server(GArray *params, void *user_ctx=
);
 void parse_reg_xml(const char *xml, int size, GArray* registers);
 void handle_reset(GArray *params, void *user_ctx);
 void handle_query_state(GArray *params, void *user_ctx);
+void handle_read_register(GArray *params, void *user_ctx);
+void handle_write_register(GArray *params, void *user_ctx);
+void handle_read_memory(GArray *params, void *user_ctx);
+void handle_write_memory(GArray *params, void *user_ctx);
+int mcd_read_register(CPUState *cpu, GByteArray *buf, int reg);
+int mcd_read_memory(CPUState *cpu, hwaddr addr, uint8_t *buf, int len);
=20
 // arm specific functions
 int mcd_arm_store_mem_spaces(CPUState *cpu, GArray* memspaces);
@@ -334,5 +342,6 @@ void mcd_disable_syscalls(void);
=20
 // helpers
 int int_cmp(gconstpointer a, gconstpointer b);
+void mcd_memtohex(GString *buf, const uint8_t *mem, int len);
=20
 #endif /* MCDSTUB_INTERNALS_H */
diff --git a/mcdstub/mcd_shared_defines.h b/mcdstub/mcd_shared_defines.h
index 8cec2e9f23..47d5d46af3 100644
--- a/mcdstub/mcd_shared_defines.h
+++ b/mcdstub/mcd_shared_defines.h
@@ -13,6 +13,10 @@
 #define TCP_CHAR_CLOSE_CORE 'd'
 #define TCP_CHAR_KILLQEMU 'k'
 #define TCP_CHAR_RESET 'r'
+#define TCP_CHAR_READ_REGISTER 'p'
+#define TCP_CHAR_WRITE_REGISTER 'P'
+#define TCP_CHAR_READ_MEMORY 'm'
+#define TCP_CHAR_WRITE_MEMORY 'M'
=20
 // tcp protocol chars
 #define TCP_ACKNOWLEDGED '+'
@@ -22,6 +26,8 @@
 #define TCP_WAS_LAST '|'
 #define TCP_WAS_NOT_LAST '~'
 #define TCP_HANDSHAKE_SUCCESS "shaking your hand"
+#define TCP_EXECUTION_SUCCESS "success"
+#define TCP_EXECUTION_ERROR ""
=20
 // tcp query arguments
 #define QUERY_FIRST "f"
@@ -38,6 +44,7 @@
=20
 // tcp query packet argument list
 #define TCP_ARGUMENT_NAME "name"
+#define TCP_ARGUMENT_DATA "data"
 #define TCP_ARGUMENT_ID "id"
 #define TCP_ARGUMENT_TYPE "type"
 #define TCP_ARGUMENT_BITS_PER_MAU "bpm"
diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index dc40a68338..21e9159876 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -544,6 +544,46 @@ int mcd_handle_packet(const char *line_buf)
             cmd_parser =3D &reset_cmd_desc;
         }
         break;
+    case TCP_CHAR_READ_REGISTER:
+        {
+            static MCDCmdParseEntry read_reg_cmd_desc =3D {
+                .handler =3D handle_read_register,
+            };
+            read_reg_cmd_desc.cmd =3D (char[2]) { (char) TCP_CHAR_READ_REG=
ISTER, '\0' };
+            strcpy(read_reg_cmd_desc.schema, (char[3]) { ARG_SCHEMA_CORENU=
M, ARG_SCHEMA_INT, '\0' });
+            cmd_parser =3D &read_reg_cmd_desc;
+        }
+        break;
+    case TCP_CHAR_WRITE_REGISTER:
+        {
+            static MCDCmdParseEntry write_reg_cmd_desc =3D {
+                .handler =3D handle_write_register,
+            };
+            write_reg_cmd_desc.cmd =3D (char[2]) { (char) TCP_CHAR_WRITE_R=
EGISTER, '\0' };
+            strcpy(write_reg_cmd_desc.schema, (char[3]) { ARG_SCHEMA_COREN=
UM, ARG_SCHEMA_INT, '\0' });
+            cmd_parser =3D &write_reg_cmd_desc;
+        }
+        break;
+    case TCP_CHAR_READ_MEMORY:
+        {
+            static MCDCmdParseEntry read_mem_cmd_desc =3D {
+                .handler =3D handle_read_memory,
+            };
+            read_mem_cmd_desc.cmd =3D (char[2]) { (char) TCP_CHAR_READ_MEM=
ORY, '\0' };
+            strcpy(read_mem_cmd_desc.schema, (char[3]) { ARG_SCHEMA_CORENU=
M, ARG_SCHEMA_INT, '\0' });
+            cmd_parser =3D &read_mem_cmd_desc;
+        }
+        break;
+    case TCP_CHAR_WRITE_MEMORY:
+        {
+            static MCDCmdParseEntry write_mem_cmd_desc =3D {
+                .handler =3D handle_write_memory,
+            };
+            write_mem_cmd_desc.cmd =3D (char[2]) { (char) TCP_CHAR_WRITE_M=
EMORY, '\0' };
+            strcpy(write_mem_cmd_desc.schema, (char[3]) { ARG_SCHEMA_COREN=
UM, ARG_SCHEMA_INT, '\0' });
+            cmd_parser =3D &write_mem_cmd_desc;
+        }
+        break;
     default:
         // could not perform the command (because its unknown)
         mcd_put_packet("");
@@ -597,6 +637,18 @@ void run_cmd_parser(const char *data, const MCDCmdPars=
eEntry *cmd)
     }
 }
=20
+uint64_t atouint64_t(const char* in) {
+    uint64_t res =3D 0;
+    for (int i =3D 0; i < strlen(in); ++i)
+    {
+        const char c =3D in[i];
+        res *=3D 10;
+        res +=3D c - '0';
+    }
+
+    return res;
+}
+
 int cmd_parse_params(const char *data, const char *schema, GArray *params)=
 {
=20=20=20=20=20
     char data_buffer[64] =3D {0};
@@ -621,6 +673,10 @@ int cmd_parse_params(const char *data, const char *sch=
ema, GArray *params) {
             this_param.data_int =3D atoi(data_buffer);
             g_array_append_val(params, this_param);
             break;
+        case ARG_SCHEMA_UINT32_T:
+            this_param.data_int =3D atoi(data_buffer);
+            g_array_append_val(params, this_param);
+            break;
         case ARG_SCHEMA_QRYHANDLE:
             this_param.query_handle =3D atoi(data_buffer);
             g_array_append_val(params, this_param);
@@ -1716,3 +1772,76 @@ void handle_query_state(GArray *params, void *user_c=
tx) {
         TCP_ARGUMENT_STOP_STRING, state_info.stop_str, TCP_ARGUMENT_INFO_S=
TRING, state_info.info_str);
     mcd_put_strbuf();
 }
+
+int mcd_read_register(CPUState *cpu, GByteArray *buf, int reg) {
+    CPUClass *cc =3D CPU_GET_CLASS(cpu);
+    gchar *arch =3D cc->gdb_arch_name(cpu);
+    if (strcmp(arch, "arm")=3D=3D0) {
+        g_free(arch);
+        return arm_mcd_read_register(cpu, buf, reg);
+    }
+    else {
+        g_free(arch);
+        return 0;
+    }
+}
+
+void mcd_memtohex(GString *buf, const uint8_t *mem, int len) {
+    int i, c;
+    for(i =3D 0; i < len; i++) {
+        c =3D mem[i];
+        g_string_append_c(buf, tohex(c >> 4));
+        g_string_append_c(buf, tohex(c & 0xf));
+    }
+    g_string_append_c(buf, '\0');
+}
+
+void handle_read_register(GArray *params, void *user_ctx) {
+    uint32_t cpu_id =3D get_param(params, 0)->cpu_id;
+    int reg_num =3D get_param(params, 1)->data_int;
+    int reg_size;
+
+    CPUState *cpu =3D mcd_get_cpu(cpu_id);
+
+    reg_size =3D mcd_read_register(cpu, mcdserver_state.mem_buf, reg_num);
+    mcd_memtohex(mcdserver_state.str_buf,  mcdserver_state.mem_buf->data, =
reg_size);
+    //g_string_printf(mcdserver_state.str_buf, "%s=3D%d;%d.%s=3D%d.",
+    //    TCP_ARGUMENT_DATA, *mcdserver_state.mem_buf->data, mcdserver_sta=
te.mem_buf->data[1], TCP_ARGUMENT_SIZE, reg_size);
+    mcd_put_strbuf();
+}
+
+void handle_write_register(GArray *params, void *user_ctx) {
+
+}
+
+int mcd_read_memory(CPUState *cpu, hwaddr addr, uint8_t *buf, int len)
+{
+    CPUClass *cc;
+    //TODO: add physical mem cpu_physical_memory_read(addr, buf, len);
+    cc =3D CPU_GET_CLASS(cpu);
+    if (cc->memory_rw_debug) {
+        // TODO: check out the difference between those two calls
+        return cc->memory_rw_debug(cpu, addr, buf, len, false);
+    }
+
+    return cpu_memory_rw_debug(cpu, addr, buf, len, false);
+}
+
+void handle_read_memory(GArray *params, void *user_ctx) {
+    uint32_t cpu_id =3D get_param(params, 0)->cpu_id;
+    uint64_t mem_address =3D get_param(params, 1)->data_uint64_t;
+    int len =3D get_param(params, 2)->data_int;
+
+    CPUState *cpu =3D mcd_get_cpu(cpu_id);
+    if (mcd_read_memory(cpu, mem_address, mcdserver_state.mem_buf, len)!=
=3D0) {
+        mcd_put_packet(TCP_EXECUTION_ERROR);
+    }
+    else {
+        mcd_memtohex(mcdserver_state.str_buf,  mcdserver_state.mem_buf->da=
ta, len);
+        mcd_put_strbuf();
+    }
+}
+
+void handle_write_memory(GArray *params, void *user_ctx) {
+
+}
diff --git a/target/arm/mcdstub.c b/target/arm/mcdstub.c
new file mode 100644
index 0000000000..dc36a79a70
--- /dev/null
+++ b/target/arm/mcdstub.c
@@ -0,0 +1,75 @@
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "exec/mcdstub.h"
+#include "sysemu/tcg.h"
+#include "internals.h"
+#include "cpregs.h"
+#include "mcdstub.h"
+
+static inline int mcd_get_reg32(GByteArray *buf, uint32_t val)
+{
+    //FIXME: move this to a separate file
+    // convert endianess if necessary
+    uint32_t to_long =3D tswap32(val);
+    g_byte_array_append(buf, (uint8_t *) &to_long, 4);
+    return 4;
+}
+
+static inline int mcd_get_zeroes(GByteArray *array, size_t len)
+{
+    //FIXME: move this to a separate file
+    guint oldlen =3D array->len;
+    g_byte_array_set_size(array, oldlen + len);
+    memset(array->data + oldlen, 0, len);
+
+    return len;
+}
+
+const char *arm_mcd_get_dynamic_xml(CPUState *cs, const char *xmlname)
+{
+    ARMCPU *cpu =3D ARM_CPU(cs);
+
+    if (strcmp(xmlname, "system-registers.xml") =3D=3D 0) {
+        return cpu->dyn_sysreg_xml.desc;
+    } else if (strcmp(xmlname, "sve-registers.xml") =3D=3D 0) {
+        return cpu->dyn_svereg_xml.desc;
+    } else if (strcmp(xmlname, "arm-m-system.xml") =3D=3D 0) {
+        return cpu->dyn_m_systemreg_xml.desc;
+#ifndef CONFIG_USER_ONLY
+    } else if (strcmp(xmlname, "arm-m-secext.xml") =3D=3D 0) {
+        return cpu->dyn_m_secextreg_xml.desc;
+#endif
+    }
+    return NULL;
+}
+
+int arm_mcd_read_register(CPUState *cs, GByteArray *mem_buf, int n) {
+    //CPUClass *cc =3D CPU_GET_CLASS(cpu);
+    //CPUArchState *env =3D cpu->env_ptr;
+
+    ARMCPU *cpu =3D ARM_CPU(cs);
+    CPUARMState *env =3D &cpu->env;
+
+    if (n < 16) {
+        /* Core integer register.  */
+        return mcd_get_reg32(mem_buf, env->regs[n]);
+    }
+    if (n < 24) {
+        // TODO: these numbers don't match mine
+        return mcd_get_zeroes(mem_buf, 12);
+    }
+    switch (n) {
+    case 24:
+        // TODO: these numbers don't match mine
+        return mcd_get_reg32(mem_buf, 0);
+    case 25:
+        /* CPSR, or XPSR for M-profile */
+        if (arm_feature(env, ARM_FEATURE_M)) {
+            return mcd_get_reg32(mem_buf, xpsr_read(env));
+        } else {
+            return mcd_get_reg32(mem_buf, cpsr_read(env));
+        }
+    }
+    //TODO: add funcitons for regs with higher numbers (including cp_regs)
+    return 0;
+}
\ No newline at end of file
diff --git a/target/arm/mcdstub.h b/target/arm/mcdstub.h
new file mode 100644
index 0000000000..d61028c7f4
--- /dev/null
+++ b/target/arm/mcdstub.h
@@ -0,0 +1,7 @@
+#ifndef ARM_MCDSTUB_H
+#define ARM_MCDSTUB_H
+
+const char *arm_mcd_get_dynamic_xml(CPUState *cs, const char *xmlname);
+int arm_mcd_read_register(CPUState *cs, GByteArray *mem_buf, int n);
+
+#endif /* ARM_MCDSTUB_H */
--=20
2.34.1


From 6fc5138b201233e306f60e06c51bdc63d08492b3 Mon Sep 17 00:00:00 2001
From: Nicolas Eder <nicolas.eder@lauterbach.com>
Date: Mon, 3 Jul 2023 17:08:44 +0200
Subject: [PATCH 13/29] handler for reading memory added

Signed-off-by: Nicolas Eder <nicolas.eder@lauterbach.com>
---
 mcdstub/internals.h          |   9 ++-
 mcdstub/mcd_shared_defines.h |   2 +-
 mcdstub/mcdstub.c            | 124 +++++++++++++++++++++++------------
 3 files changed, 89 insertions(+), 46 deletions(-)

diff --git a/mcdstub/internals.h b/mcdstub/internals.h
index a85173d0d1..871a58f8ea 100644
--- a/mcdstub/internals.h
+++ b/mcdstub/internals.h
@@ -41,8 +41,9 @@ enum {
 #define ARG_SCHEMA_QRYHANDLE 'q'
 #define ARG_SCHEMA_STRING 's'
 #define ARG_SCHEMA_INT 'd'
-#define ARG_SCHEMA_UINT32_T 'l'
+#define ARG_SCHEMA_UINT64_T 'l'
 #define ARG_SCHEMA_CORENUM 'c'
+#define ARG_SCHEMA_HEXDATA 'h'
=20
 // resets
 #define RESET_SYSTEM "full_system_reset"
@@ -51,7 +52,7 @@ enum {
=20
 // more
 #define QUERY_TOTAL_NUMBER 12 //FIXME: set this to a usefull value in the =
end
-#define CMD_SCHEMA_LENGTH 3
+#define CMD_SCHEMA_LENGTH 5
 #define MCD_SYSTEM_NAME "qemu-system"
 // tcp query packet values templates
 #define DEVICE_NAME_TEMPLATE(s) "qemu-" #s "-device"
@@ -106,7 +107,6 @@ typedef enum MCDThreadIdKind {
 } MCDThreadIdKind;
=20
 typedef union MCDCmdVariant {
-=20=20=20=20
     const char *data;
     int data_int;
     uint64_t data_uint64_t;
@@ -329,6 +329,7 @@ void handle_read_memory(GArray *params, void *user_ctx);
 void handle_write_memory(GArray *params, void *user_ctx);
 int mcd_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int mcd_read_memory(CPUState *cpu, hwaddr addr, uint8_t *buf, int len);
+int mcd_write_memory(CPUState *cpu, hwaddr addr, uint8_t *buf, int len);
=20
 // arm specific functions
 int mcd_arm_store_mem_spaces(CPUState *cpu, GArray* memspaces);
@@ -343,5 +344,7 @@ void mcd_disable_syscalls(void);
 // helpers
 int int_cmp(gconstpointer a, gconstpointer b);
 void mcd_memtohex(GString *buf, const uint8_t *mem, int len);
+void mcd_hextomem(GByteArray *mem, const char *buf, int len);
+uint64_t atouint64_t(const char* in);
=20
 #endif /* MCDSTUB_INTERNALS_H */
diff --git a/mcdstub/mcd_shared_defines.h b/mcdstub/mcd_shared_defines.h
index 47d5d46af3..f2f4d31335 100644
--- a/mcdstub/mcd_shared_defines.h
+++ b/mcdstub/mcd_shared_defines.h
@@ -27,7 +27,7 @@
 #define TCP_WAS_NOT_LAST '~'
 #define TCP_HANDSHAKE_SUCCESS "shaking your hand"
 #define TCP_EXECUTION_SUCCESS "success"
-#define TCP_EXECUTION_ERROR ""
+#define TCP_EXECUTION_ERROR "error"
=20
 // tcp query arguments
 #define QUERY_FIRST "f"
diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index 21e9159876..88f321a068 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -465,7 +465,7 @@ int mcd_handle_packet(const char *line_buf)
             static MCDCmdParseEntry open_server_cmd_desc =3D {
                 .handler =3D handle_open_server,
             };
-            open_server_cmd_desc.cmd =3D (char[2]) { (char) TCP_CHAR_OPEN_=
SERVER, '\0' };
+            open_server_cmd_desc.cmd =3D (char[2]) { TCP_CHAR_OPEN_SERVER,=
 '\0' };
             cmd_parser =3D &open_server_cmd_desc;
         }
         break;
@@ -475,7 +475,7 @@ int mcd_handle_packet(const char *line_buf)
             static MCDCmdParseEntry go_cmd_desc =3D {
                 .handler =3D handle_vm_start,
             };
-            go_cmd_desc.cmd =3D (char[2]) { (char) TCP_CHAR_GO, '\0' };
+            go_cmd_desc.cmd =3D (char[2]) { TCP_CHAR_GO, '\0' };
             cmd_parser =3D &go_cmd_desc;
         }
         break;
@@ -485,7 +485,7 @@ int mcd_handle_packet(const char *line_buf)
             static MCDCmdParseEntry break_cmd_desc =3D {
                 .handler =3D handle_vm_stop,
             };
-            break_cmd_desc.cmd =3D (char[2]) { (char) TCP_CHAR_BREAK, '\0'=
 };
+            break_cmd_desc.cmd =3D (char[2]) { TCP_CHAR_BREAK, '\0' };
             cmd_parser =3D &break_cmd_desc;
         }
         break;
@@ -500,8 +500,8 @@ int mcd_handle_packet(const char *line_buf)
             static MCDCmdParseEntry query_cmd_desc =3D {
                 .handler =3D handle_gen_query,
             };
-            query_cmd_desc.cmd =3D (char[2]) { (char) TCP_CHAR_QUERY, '\0'=
 };
-            strcpy(query_cmd_desc.schema, (char[2]) { (char) ARG_SCHEMA_ST=
RING, '\0' });
+            query_cmd_desc.cmd =3D (char[2]) { TCP_CHAR_QUERY, '\0' };
+            strcpy(query_cmd_desc.schema, (char[2]) { ARG_SCHEMA_STRING, '=
\0' });
             cmd_parser =3D &query_cmd_desc;
         }
         break;
@@ -510,8 +510,8 @@ int mcd_handle_packet(const char *line_buf)
             static MCDCmdParseEntry open_core_cmd_desc =3D {
                 .handler =3D handle_open_core,
             };
-            open_core_cmd_desc.cmd =3D (char[2]) { (char) TCP_CHAR_OPEN_CO=
RE, '\0' };
-            strcpy(open_core_cmd_desc.schema, (char[2]) { (char) ARG_SCHEM=
A_CORENUM, '\0' });
+            open_core_cmd_desc.cmd =3D (char[2]) { TCP_CHAR_OPEN_CORE, '\0=
' };
+            strcpy(open_core_cmd_desc.schema, (char[2]) { ARG_SCHEMA_COREN=
UM, '\0' });
             cmd_parser =3D &open_core_cmd_desc;
         }
         break;
@@ -520,7 +520,7 @@ int mcd_handle_packet(const char *line_buf)
             static MCDCmdParseEntry close_server_cmd_desc =3D {
                 .handler =3D handle_close_server,
             };
-            close_server_cmd_desc.cmd =3D (char[2]) { (char) TCP_CHAR_CLOS=
E_SERVER, '\0' };
+            close_server_cmd_desc.cmd =3D (char[2]) { TCP_CHAR_CLOSE_SERVE=
R, '\0' };
             cmd_parser =3D &close_server_cmd_desc;
         }
         break;
@@ -529,8 +529,8 @@ int mcd_handle_packet(const char *line_buf)
             static MCDCmdParseEntry close_core_cmd_desc =3D {
                 .handler =3D handle_close_core,
             };
-            close_core_cmd_desc.cmd =3D (char[2]) { (char) TCP_CHAR_CLOSE_=
CORE, '\0' };
-            strcpy(close_core_cmd_desc.schema, (char[2]) { (char) ARG_SCHE=
MA_CORENUM, '\0' });
+            close_core_cmd_desc.cmd =3D (char[2]) { TCP_CHAR_CLOSE_CORE, '=
\0' };
+            strcpy(close_core_cmd_desc.schema, (char[2]) { ARG_SCHEMA_CORE=
NUM, '\0' });
             cmd_parser =3D &close_core_cmd_desc;
         }
         break;
@@ -539,8 +539,8 @@ int mcd_handle_packet(const char *line_buf)
             static MCDCmdParseEntry reset_cmd_desc =3D {
                 .handler =3D handle_reset,
             };
-            reset_cmd_desc.cmd =3D (char[2]) { (char) TCP_CHAR_RESET, '\0'=
 };
-            strcpy(reset_cmd_desc.schema, (char[2]) { (char) ARG_SCHEMA_IN=
T, '\0' });
+            reset_cmd_desc.cmd =3D (char[2]) { TCP_CHAR_RESET, '\0' };
+            strcpy(reset_cmd_desc.schema, (char[2]) { ARG_SCHEMA_INT, '\0'=
 });
             cmd_parser =3D &reset_cmd_desc;
         }
         break;
@@ -549,7 +549,7 @@ int mcd_handle_packet(const char *line_buf)
             static MCDCmdParseEntry read_reg_cmd_desc =3D {
                 .handler =3D handle_read_register,
             };
-            read_reg_cmd_desc.cmd =3D (char[2]) { (char) TCP_CHAR_READ_REG=
ISTER, '\0' };
+            read_reg_cmd_desc.cmd =3D (char[2]) { TCP_CHAR_READ_REGISTER, =
'\0' };
             strcpy(read_reg_cmd_desc.schema, (char[3]) { ARG_SCHEMA_CORENU=
M, ARG_SCHEMA_INT, '\0' });
             cmd_parser =3D &read_reg_cmd_desc;
         }
@@ -559,7 +559,7 @@ int mcd_handle_packet(const char *line_buf)
             static MCDCmdParseEntry write_reg_cmd_desc =3D {
                 .handler =3D handle_write_register,
             };
-            write_reg_cmd_desc.cmd =3D (char[2]) { (char) TCP_CHAR_WRITE_R=
EGISTER, '\0' };
+            write_reg_cmd_desc.cmd =3D (char[2]) { TCP_CHAR_WRITE_REGISTER=
, '\0' };
             strcpy(write_reg_cmd_desc.schema, (char[3]) { ARG_SCHEMA_COREN=
UM, ARG_SCHEMA_INT, '\0' });
             cmd_parser =3D &write_reg_cmd_desc;
         }
@@ -569,8 +569,8 @@ int mcd_handle_packet(const char *line_buf)
             static MCDCmdParseEntry read_mem_cmd_desc =3D {
                 .handler =3D handle_read_memory,
             };
-            read_mem_cmd_desc.cmd =3D (char[2]) { (char) TCP_CHAR_READ_MEM=
ORY, '\0' };
-            strcpy(read_mem_cmd_desc.schema, (char[3]) { ARG_SCHEMA_CORENU=
M, ARG_SCHEMA_INT, '\0' });
+            read_mem_cmd_desc.cmd =3D (char[2]) { TCP_CHAR_READ_MEMORY, '\=
0' };
+            strcpy(read_mem_cmd_desc.schema, (char[4]) { ARG_SCHEMA_CORENU=
M, ARG_SCHEMA_UINT64_T, ARG_SCHEMA_INT, '\0' });
             cmd_parser =3D &read_mem_cmd_desc;
         }
         break;
@@ -579,8 +579,8 @@ int mcd_handle_packet(const char *line_buf)
             static MCDCmdParseEntry write_mem_cmd_desc =3D {
                 .handler =3D handle_write_memory,
             };
-            write_mem_cmd_desc.cmd =3D (char[2]) { (char) TCP_CHAR_WRITE_M=
EMORY, '\0' };
-            strcpy(write_mem_cmd_desc.schema, (char[3]) { ARG_SCHEMA_COREN=
UM, ARG_SCHEMA_INT, '\0' });
+            write_mem_cmd_desc.cmd =3D (char[2]) { TCP_CHAR_WRITE_MEMORY, =
'\0' };
+            strcpy(write_mem_cmd_desc.schema, (char[5]) { ARG_SCHEMA_COREN=
UM, ARG_SCHEMA_UINT64_T, ARG_SCHEMA_INT, ARG_SCHEMA_HEXDATA, '\0' });
             cmd_parser =3D &write_mem_cmd_desc;
         }
         break;
@@ -652,29 +652,43 @@ uint64_t atouint64_t(const char* in) {
 int cmd_parse_params(const char *data, const char *schema, GArray *params)=
 {
=20=20=20=20=20
     char data_buffer[64] =3D {0};
-    char *separator =3D strchr(data, ARGUMENT_SEPARATOR);
-    int seperator_index =3D (int)(separator - data);
-
-    if (separator) {
-        // we got two arguments
-        strncpy(data_buffer, data, seperator_index);
-    }
-    else {
-        strncpy(data_buffer, data, strlen(data));
-    }
+    const char *remaining_data =3D data;
+=20=20=20=20
     for (int i =3D 0; i<strlen(schema); i++) {
+        // get correct part of string
+        char *separator =3D strchr(remaining_data, ARGUMENT_SEPARATOR);
+
+        if (separator) {
+            // we multiple arguments left
+            int seperator_index =3D (int)(separator - remaining_data);
+            strncpy(data_buffer, remaining_data, seperator_index);
+            data_buffer[seperator_index] =3D 0;
+            // update remaining data for the next run
+            remaining_data =3D &(remaining_data[seperator_index+1]);
+        }
+        else {
+            strncpy(data_buffer, remaining_data, strlen(remaining_data));
+            data_buffer[strlen(remaining_data)] =3D 0;
+        }
+=20=20=20=20=20=20=20=20
+        // store right data
         MCDCmdVariant this_param;=20
         switch (schema[i]) {
         case ARG_SCHEMA_STRING:
-            this_param.data =3D data;
+            // a string has to be the last argument
+            this_param.data =3D remaining_data;
             g_array_append_val(params, this_param);
             break;
+        case ARG_SCHEMA_HEXDATA:
+            // a string has to be the last argument
+            g_string_printf(mcdserver_state.str_buf, "%s", data_buffer);
+            break;
         case ARG_SCHEMA_INT:
             this_param.data_int =3D atoi(data_buffer);
             g_array_append_val(params, this_param);
             break;
-        case ARG_SCHEMA_UINT32_T:
-            this_param.data_int =3D atoi(data_buffer);
+        case ARG_SCHEMA_UINT64_T:
+            this_param.data_uint64_t =3D atouint64_t(data_buffer);
             g_array_append_val(params, this_param);
             break;
         case ARG_SCHEMA_QRYHANDLE:
@@ -688,11 +702,6 @@ int cmd_parse_params(const char *data, const char *sch=
ema, GArray *params) {
         default:
             return -1;
         }
-=20=20=20=20=20=20=20=20
-        if (separator) {
-            // we got two arguments
-            strncpy(data_buffer, &data[seperator_index+1], strlen(&data[se=
perator_index+1]));
-        }
     }
     return 0;
 }
@@ -1796,6 +1805,16 @@ void mcd_memtohex(GString *buf, const uint8_t *mem, =
int len) {
     g_string_append_c(buf, '\0');
 }
=20
+void mcd_hextomem(GByteArray *mem, const char *buf, int len) {
+    int i;
+
+    for(i =3D 0; i < len; i++) {
+        guint8 byte =3D fromhex(buf[0]) << 4 | fromhex(buf[1]);
+        g_byte_array_append(mem, &byte, 1);
+        buf +=3D 2;
+    }
+}
+
 void handle_read_register(GArray *params, void *user_ctx) {
     uint32_t cpu_id =3D get_param(params, 0)->cpu_id;
     int reg_num =3D get_param(params, 1)->data_int;
@@ -1805,8 +1824,6 @@ void handle_read_register(GArray *params, void *user_=
ctx) {
=20
     reg_size =3D mcd_read_register(cpu, mcdserver_state.mem_buf, reg_num);
     mcd_memtohex(mcdserver_state.str_buf,  mcdserver_state.mem_buf->data, =
reg_size);
-    //g_string_printf(mcdserver_state.str_buf, "%s=3D%d;%d.%s=3D%d.",
-    //    TCP_ARGUMENT_DATA, *mcdserver_state.mem_buf->data, mcdserver_sta=
te.mem_buf->data[1], TCP_ARGUMENT_SIZE, reg_size);
     mcd_put_strbuf();
 }
=20
@@ -1814,8 +1831,7 @@ void handle_write_register(GArray *params, void *user=
_ctx) {
=20
 }
=20
-int mcd_read_memory(CPUState *cpu, hwaddr addr, uint8_t *buf, int len)
-{
+int mcd_read_memory(CPUState *cpu, hwaddr addr, uint8_t *buf, int len) {
     CPUClass *cc;
     //TODO: add physical mem cpu_physical_memory_read(addr, buf, len);
     cc =3D CPU_GET_CLASS(cpu);
@@ -1827,21 +1843,45 @@ int mcd_read_memory(CPUState *cpu, hwaddr addr, uin=
t8_t *buf, int len)
     return cpu_memory_rw_debug(cpu, addr, buf, len, false);
 }
=20
+int mcd_write_memory(CPUState *cpu, hwaddr addr, uint8_t *buf, int len) {
+    CPUClass *cc;
+    //TODO: add physical mem cpu_physical_memory_read(addr, buf, len);
+    cc =3D CPU_GET_CLASS(cpu);
+    if (cc->memory_rw_debug) {
+        // TODO: check out the difference between those two calls
+        return cc->memory_rw_debug(cpu, addr, buf, len, true);
+    }
+
+    return cpu_memory_rw_debug(cpu, addr, buf, len, true);
+}
+
 void handle_read_memory(GArray *params, void *user_ctx) {
     uint32_t cpu_id =3D get_param(params, 0)->cpu_id;
     uint64_t mem_address =3D get_param(params, 1)->data_uint64_t;
     int len =3D get_param(params, 2)->data_int;
=20
     CPUState *cpu =3D mcd_get_cpu(cpu_id);
-    if (mcd_read_memory(cpu, mem_address, mcdserver_state.mem_buf, len)!=
=3D0) {
+    g_byte_array_set_size(mcdserver_state.mem_buf, len);
+    if (mcd_read_memory(cpu, mem_address, mcdserver_state.mem_buf->data, m=
cdserver_state.mem_buf->len)!=3D0) {
         mcd_put_packet(TCP_EXECUTION_ERROR);
     }
     else {
-        mcd_memtohex(mcdserver_state.str_buf,  mcdserver_state.mem_buf->da=
ta, len);
+        mcd_memtohex(mcdserver_state.str_buf, mcdserver_state.mem_buf->dat=
a, mcdserver_state.mem_buf->len);
         mcd_put_strbuf();
     }
 }
=20
 void handle_write_memory(GArray *params, void *user_ctx) {
+    uint32_t cpu_id =3D get_param(params, 0)->cpu_id;
+    uint64_t mem_address =3D get_param(params, 1)->data_uint64_t;
+    int len =3D get_param(params, 2)->data_int;
=20
+    CPUState *cpu =3D mcd_get_cpu(cpu_id);
+    mcd_hextomem(mcdserver_state.mem_buf, mcdserver_state.str_buf->str, le=
n);
+    if (mcd_write_memory(cpu, mem_address, mcdserver_state.mem_buf->data, =
len)!=3D0) {
+        mcd_put_packet(TCP_EXECUTION_ERROR);
+    }
+    else {
+        mcd_put_packet(TCP_EXECUTION_SUCCESS);
+    }
 }
--=20
2.34.1


From 0212c248b318acd70df2b68ae89204622a33996b Mon Sep 17 00:00:00 2001
From: Nicolas Eder <nicolas.eder@lauterbach.com>
Date: Wed, 5 Jul 2023 18:25:56 +0200
Subject: [PATCH 14/29] handler for single step added

Signed-off-by: Nicolas Eder <nicolas.eder@lauterbach.com>
---
 include/exec/mcdstub.h       |   6 +-
 include/mcdstub/syscalls.h   |   4 +-
 mcdstub/internals.h          |  77 +++----
 mcdstub/mcd_shared_defines.h |   3 +-
 mcdstub/mcdstub.c            | 428 ++++++++++++++---------------------
 softmmu/cpus.c               |   2 +-
 target/arm/mcdstub.c         |  66 +++++-
 target/arm/mcdstub.h         |   1 +
 8 files changed, 269 insertions(+), 318 deletions(-)

diff --git a/include/exec/mcdstub.h b/include/exec/mcdstub.h
index abf7beb634..132f32417c 100644
--- a/include/exec/mcdstub.h
+++ b/include/exec/mcdstub.h
@@ -3,10 +3,8 @@
=20
 #define DEFAULT_MCDSTUB_PORT "1235"
 #define TYPE_CHARDEV_MCD "chardev-mcd"
-#define MX_INPUT_LENGTH 9
-#define MCD_TCP_DATALEN 80
=20
-/* MCD breakpoint/watchpoint types */
+// breakpoint defines
 #define MCD_BREAKPOINT_SW        0
 #define MCD_BREAKPOINT_HW        1
 #define MCD_WATCHPOINT_WRITE     2
@@ -16,8 +14,6 @@
 /**
  * mcd_tcp_server_start: start the tcp server to connect via mcd
  * @device: connection spec for mcd
- *
- * This is a TCP port
  */
 int mcdserver_start(const char *device);
=20
diff --git a/include/mcdstub/syscalls.h b/include/mcdstub/syscalls.h
index 1f86634140..92ae7f4e77 100644
--- a/include/mcdstub/syscalls.h
+++ b/include/mcdstub/syscalls.h
@@ -1,5 +1,5 @@
-#ifndef _SYSCALLS_H_
-#define _SYSCALLS_H_
+#ifndef _MCD_SYSCALLS_H_
+#define _MCD_SYSCALLS_H_
=20
 typedef void (*gdb_syscall_complete_cb)(CPUState *cpu, uint64_t ret, int e=
rr);
=20
diff --git a/mcdstub/internals.h b/mcdstub/internals.h
index 871a58f8ea..0afab434ce 100644
--- a/mcdstub/internals.h
+++ b/mcdstub/internals.h
@@ -1,8 +1,3 @@
-/*
- * this header includes a lookup table for the transmitted messages over t=
he tcp connection to trace32,
- * as well as function declarations for all functios used inside the mcdst=
ub
- */
-
 #ifndef MCDSTUB_INTERNALS_H
 #define MCDSTUB_INTERNALS_H
=20
@@ -10,19 +5,33 @@
 #include "chardev/char.h"
 #include "hw/core/cpu.h"
 // just used for the register xml files
-#include "exec/gdbstub.h"       /* xml_builtin */
+#include "exec/gdbstub.h"
=20
 #define MAX_PACKET_LENGTH 1024
=20
 // trigger defines
-#define MCD_TRIG_TYPE_IP 0x00000001
-#define MCD_TRIG_TYPE_READ 0x00000002
-#define MCD_TRIG_TYPE_WRITE 0x00000004
-#define MCD_TRIG_TYPE_RW 0x00000008
 #define MCD_TRIG_OPT_DATA_IS_CONDITION 0x00000008
 #define MCD_TRIG_ACTION_DBG_DEBUG 0x00000001
=20
+typedef uint32_t mcd_trig_type_et;
+// TODO: replace mcd defines with custom layer
+enum {
+	MCD_TRIG_TYPE_UNDEFINED =3D 0x00000000, /**< Undefined trigger type.     =
                                              */
+	MCD_TRIG_TYPE_IP        =3D 0x00000001, /**< Trigger on a changing instru=
ction pointer.                                */
+	MCD_TRIG_TYPE_READ      =3D 0x00000002, /**< Trigger on a read data acces=
s to a specific address or address range.     */
+	MCD_TRIG_TYPE_WRITE     =3D 0x00000004, /**< Trigger on a write data acce=
ss to a specific address or address range.    */
+	MCD_TRIG_TYPE_RW        =3D 0x00000008, /**< Trigger on a read or a write=
 data access to a specific address or
+		   address range.                                                       =
     */
+	MCD_TRIG_TYPE_NOCYCLE   =3D 0x00000010, /**< Trigger on core information =
other than an IP or data compare trigger.     */
+	MCD_TRIG_TYPE_TRIG_BUS  =3D 0x00000020, /**< Trigger on a trigger bus com=
bination.                                     */
+	MCD_TRIG_TYPE_COUNTER   =3D 0x00000040, /**< Trigger on an elapsed trigge=
r counter.                                    */
+	MCD_TRIG_TYPE_CUSTOM    =3D 0x00000080, /**< Custom trigger using standar=
d format as defined by \ref mcd_trig_custom_st. */
+	MCD_TRIG_TYPE_CUSTOM_LO =3D 0x00010000, /**< Begin Range: User defined tr=
igger types.                                  */
+	MCD_TRIG_TYPE_CUSTOM_HI =3D 0x40000000, /**< End   Range: User defined tr=
igger types.                                  */
+};
+
 typedef uint32_t mcd_core_event_et;
+// TODO: replace mcd defines with custom layer
 enum {
 	MCD_CORE_EVENT_NONE            =3D 0x00000000,   /**< No since the last p=
oll.                                 */
 	MCD_CORE_EVENT_MEMORY_CHANGE   =3D 0x00000001,   /**< Memory content has =
changed.                             */
@@ -50,10 +59,11 @@ enum {
 #define RESET_GPR "gpr_reset"
 #define RESET_MEMORY "memory_reset"
=20
-// more
-#define QUERY_TOTAL_NUMBER 12 //FIXME: set this to a usefull value in the =
end
+// misc
+#define QUERY_TOTAL_NUMBER 12=20
 #define CMD_SCHEMA_LENGTH 5
 #define MCD_SYSTEM_NAME "qemu-system"
+
 // tcp query packet values templates
 #define DEVICE_NAME_TEMPLATE(s) "qemu-" #s "-device"
=20
@@ -65,13 +75,14 @@ enum {
 #define STATE_STR_INIT_HALTED "vm halted since boot"
 #define STATE_STR_INIT_RUNNING "vm running since boot"
 #define STATE_STR_BREAK_HW "stopped beacuse of HW breakpoint"
+#define STATE_STEP_PERFORMED "stopped beacuse of single step"
 #define STATE_STR_BREAK_READ(d) "stopped beacuse of read access at " #d
 #define STATE_STR_BREAK_WRITE(d) "stopped beacuse of write access at " #d
 #define STATE_STR_BREAK_RW(d) "stopped beacuse of read or write access at =
" #d
 #define STATE_STR_BREAK_UNKNOWN "stopped for unknown reason"
=20
-// GDB stuff thats needed for GDB function, which we use
 typedef struct GDBRegisterState {
+    // needed for the used gdb functions
     int base_reg;
     int num_regs;
     gdb_get_reg_cb get_reg;
@@ -80,12 +91,7 @@ typedef struct GDBRegisterState {
     struct GDBRegisterState *next;
 } GDBRegisterState;
=20
-/*
- * struct for an MCD Process, each process can establish one connection
- */
-
 typedef struct MCDProcess {
-    //this is a relict from the gdb process, we might be able to delete th=
is
     uint32_t pid;
     bool attached;
=20
@@ -99,35 +105,16 @@ typedef struct MCDCmdParseEntry {
     char schema[CMD_SCHEMA_LENGTH];
 } MCDCmdParseEntry;
=20
-typedef enum MCDThreadIdKind {
-    GDB_ONE_THREAD =3D 0,
-    GDB_ALL_THREADS,     /* One process, all threads */
-    GDB_ALL_PROCESSES,
-    GDB_READ_THREAD_ERR
-} MCDThreadIdKind;
-
 typedef union MCDCmdVariant {
     const char *data;
     int data_int;
     uint64_t data_uint64_t;
     int query_handle;
     int cpu_id;
-    struct {
-        MCDThreadIdKind kind;
-        uint32_t pid;
-        uint32_t tid;
-    } thread_id;
-
 } MCDCmdVariant;
=20
 #define get_param(p, i)    (&g_array_index(p, MCDCmdVariant, i))
=20
-
-/*
- * not sure for what this is used exactly
- */
-
-
 enum RSState {
     RS_INACTIVE,
     RS_IDLE,
@@ -162,19 +149,14 @@ typedef struct MCDState {
     int line_csum; /* checksum at the end of the packet */
     GByteArray *last_packet;
     int signal;
-    //the next one is about stub compatibility and we should be able to as=
sume this is true anyway
-    //bool multiprocess;
+
     MCDProcess *processes;
     int process_num;
     GString *str_buf;
     GByteArray *mem_buf;
-    // maybe we don't need those flags
     int sstep_flags;
     int supported_sstep_flags;
=20
-    // my stuff
-    RunState vm_current_state;
-    RunState vm_previous_state;
     uint32_t query_cpu_id;
     GList *all_memspaces;
     GList *all_reggroups;
@@ -236,9 +218,6 @@ typedef struct mcd_reset_st {
     uint8_t id;
 } mcd_reset_st;
=20
-// Inline utility function, convert from int to hex and back
-
-
 static inline int fromhex(int v)
 {
     if (v >=3D '0' && v <=3D '9') {
@@ -283,7 +262,6 @@ int mcd_put_packet(const char *buf);
 int mcd_put_packet_binary(const char *buf, int len, bool dump);
 bool mcd_got_immediate_ack(void);
 void mcd_put_buffer(const uint8_t *buf, int len);
-void mcd_set_stop_cpu(CPUState *cpu);
 MCDProcess *mcd_get_cpu_process(CPUState *cpu);
 uint32_t mcd_get_cpu_pid(CPUState *cpu);
 MCDProcess *mcd_get_process(uint32_t pid);
@@ -297,6 +275,7 @@ void run_cmd_parser(const char *data, const MCDCmdParse=
Entry *cmd);
 int process_string_cmd(void *user_ctx, const char *data, const MCDCmdParse=
Entry *cmds, int num_cmds);
 int cmd_parse_params(const char *data, const char *schema, GArray *params);
 void handle_vm_start(GArray *params, void *user_ctx);
+void handle_vm_step(GArray *params, void *user_ctx);
 void handle_vm_stop(GArray *params, void *user_ctx);
 void handle_gen_query(GArray *params, void *user_ctx);
 int mcd_get_cpu_index(CPUState *cpu);
@@ -312,6 +291,7 @@ void handle_close_server(GArray *params, void *user_ctx=
);
 void handle_close_core(GArray *params, void *user_ctx);
 void handle_query_trigger(GArray *params, void *user_ctx);
 void mcd_vm_start(void);
+int mcd_vm_sstep(CPUState *cpu);
 void mcd_vm_stop(void);
 void handle_query_reg_groups_f(GArray *params, void *user_ctx);
 void handle_query_reg_groups_c(GArray *params, void *user_ctx);
@@ -328,6 +308,7 @@ void handle_write_register(GArray *params, void *user_c=
tx);
 void handle_read_memory(GArray *params, void *user_ctx);
 void handle_write_memory(GArray *params, void *user_ctx);
 int mcd_read_register(CPUState *cpu, GByteArray *buf, int reg);
+int mcd_write_register(CPUState *cpu, GByteArray *buf, int reg);
 int mcd_read_memory(CPUState *cpu, hwaddr addr, uint8_t *buf, int len);
 int mcd_write_memory(CPUState *cpu, hwaddr addr, uint8_t *buf, int len);
=20
@@ -337,7 +318,7 @@ int mcd_arm_parse_core_xml_file(CPUClass *cc, GArray* r=
eggroups, GArray* registe
 int mcd_arm_parse_general_xml_files(CPUState *cpu, GArray* reggroups, GArr=
ay* registers, int* current_group_id);
 int mcd_arm_get_additional_register_info(GArray* reggroups, GArray* regist=
ers);
=20
-/* sycall handling */
+// sycall handling
 void mcd_syscall_reset(void);
 void mcd_disable_syscalls(void);
=20
diff --git a/mcdstub/mcd_shared_defines.h b/mcdstub/mcd_shared_defines.h
index f2f4d31335..311d24e12f 100644
--- a/mcdstub/mcd_shared_defines.h
+++ b/mcdstub/mcd_shared_defines.h
@@ -6,7 +6,8 @@
 // tcp data characters
 #define TCP_CHAR_OPEN_SERVER 'I'
 #define TCP_CHAR_OPEN_CORE 'i'
-#define TCP_CHAR_GO 'c'
+#define TCP_CHAR_GO 'C'
+#define TCP_CHAR_STEP 'c'
 #define TCP_CHAR_BREAK 'b'
 #define TCP_CHAR_QUERY 'q'
 #define TCP_CHAR_CLOSE_SERVER 'D'
diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index 88f321a068..d65b0a54d2 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -1,10 +1,9 @@
 /*
- * This is the main mcdstub. It needs to be complemented by other mcd stub=
s for each target.
+ * This is the main mcdstub.
  */
=20
 #include "mcd_shared_defines.h"
=20
-//from original gdbstub.c
 #include "qemu/osdep.h"
 #include "qemu/ctype.h"
 #include "qemu/cutils.h"
@@ -14,15 +13,12 @@
 #include "mcdstub/syscalls.h"
 #include "hw/cpu/cluster.h"
 #include "hw/boards.h"
-
 #include "sysemu/hw_accel.h"
 #include "sysemu/runstate.h"
 #include "exec/replay-core.h"
 #include "exec/hwaddr.h"
-
 #include "internals.h"
=20
-//from original softmmu.c (minus what was already here)
 #include "qapi/error.h"
 #include "exec/tb-flush.h"
 #include "sysemu/cpus.h"
@@ -31,7 +27,7 @@
 #include "chardev/char-fe.h"
 #include "monitor/monitor.h"
=20
-//architecture specific stuff
+// architecture specific stubs
 #include "target/arm/mcdstub.h"
=20
 // FIXME: delete the following line and check if it worked
@@ -39,7 +35,6 @@
=20
 typedef struct {
     CharBackend chr;
-    //Chardev *mon_chr;
 } MCDSystemState;
=20
 MCDSystemState mcdserver_system_state;
@@ -60,8 +55,6 @@ void mcd_init_mcdserver_state(void)
      * By default try to use no IRQs and no timers while single
      * stepping so as to make single stepping like a typical ICE HW step.
      */
-	// TODO:
-	// this is weird and we might not actually need it after all
     mcdserver_state.supported_sstep_flags =3D accel_supported_gdbstub_sste=
p_flags();
     mcdserver_state.sstep_flags =3D SSTEP_ENABLE | SSTEP_NOIRQ | SSTEP_NOT=
IMER;
     mcdserver_state.sstep_flags &=3D mcdserver_state.supported_sstep_flags;
@@ -106,7 +99,7 @@ void init_query_cmds_table(MCDCmdParseEntry* mcd_query_c=
mds_table) {
         .handler =3D handle_query_reset_c,
         .cmd =3D QUERY_ARG_RESET QUERY_CONSEQUTIVE,
     };
-    strcpy(query_reset_c.schema, (char[2]) { (char) ARG_SCHEMA_QRYHANDLE, =
'\0' });
+    strcpy(query_reset_c.schema, (char[2]) { ARG_SCHEMA_QRYHANDLE, '\0' });
     mcd_query_cmds_table[cmd_number] =3D query_reset_c;
     cmd_number++;
=20
@@ -121,7 +114,7 @@ void init_query_cmds_table(MCDCmdParseEntry* mcd_query_=
cmds_table) {
         .handler =3D handle_query_mem_spaces_f,
         .cmd =3D QUERY_ARG_MEMORY QUERY_FIRST,
     };
-    strcpy(query_mem_spaces_f.schema, (char[2]) { (char) ARG_SCHEMA_CORENU=
M, '\0' });
+    strcpy(query_mem_spaces_f.schema, (char[2]) { ARG_SCHEMA_CORENUM, '\0'=
 });
     mcd_query_cmds_table[cmd_number] =3D query_mem_spaces_f;
     cmd_number++;
=20
@@ -129,7 +122,7 @@ void init_query_cmds_table(MCDCmdParseEntry* mcd_query_=
cmds_table) {
         .handler =3D handle_query_mem_spaces_c,
         .cmd =3D QUERY_ARG_MEMORY QUERY_CONSEQUTIVE,
     };
-    strcpy(query_mem_spaces_c.schema, (char[2]) { (char) ARG_SCHEMA_QRYHAN=
DLE, '\0' });
+    strcpy(query_mem_spaces_c.schema, (char[2]) { ARG_SCHEMA_QRYHANDLE, '\=
0' });
     mcd_query_cmds_table[cmd_number] =3D query_mem_spaces_c;
     cmd_number++;
=20
@@ -137,7 +130,7 @@ void init_query_cmds_table(MCDCmdParseEntry* mcd_query_=
cmds_table) {
         .handler =3D handle_query_reg_groups_f,
         .cmd =3D QUERY_ARG_REGGROUP QUERY_FIRST,
     };
-    strcpy(query_reg_groups_f.schema, (char[2]) { (char) ARG_SCHEMA_CORENU=
M, '\0' });
+    strcpy(query_reg_groups_f.schema, (char[2]) { ARG_SCHEMA_CORENUM, '\0'=
 });
     mcd_query_cmds_table[cmd_number] =3D query_reg_groups_f;
     cmd_number++;
=20
@@ -145,7 +138,7 @@ void init_query_cmds_table(MCDCmdParseEntry* mcd_query_=
cmds_table) {
         .handler =3D handle_query_reg_groups_c,
         .cmd =3D QUERY_ARG_REGGROUP QUERY_CONSEQUTIVE,
     };
-    strcpy(query_reg_groups_c.schema, (char[2]) { (char) ARG_SCHEMA_QRYHAN=
DLE, '\0' });
+    strcpy(query_reg_groups_c.schema, (char[2]) { ARG_SCHEMA_QRYHANDLE, '\=
0' });
     mcd_query_cmds_table[cmd_number] =3D query_reg_groups_c;
     cmd_number++;
=20
@@ -153,7 +146,7 @@ void init_query_cmds_table(MCDCmdParseEntry* mcd_query_=
cmds_table) {
         .handler =3D handle_query_regs_f,
         .cmd =3D QUERY_ARG_REG QUERY_FIRST,
     };
-    strcpy(query_regs_f.schema, (char[2]) { (char) ARG_SCHEMA_CORENUM, '\0=
' });
+    strcpy(query_regs_f.schema, (char[2]) { ARG_SCHEMA_CORENUM, '\0' });
     mcd_query_cmds_table[cmd_number] =3D query_regs_f;
     cmd_number++;
=20
@@ -161,7 +154,7 @@ void init_query_cmds_table(MCDCmdParseEntry* mcd_query_=
cmds_table) {
         .handler =3D handle_query_regs_c,
         .cmd =3D QUERY_ARG_REG QUERY_CONSEQUTIVE,
     };
-    strcpy(query_regs_c.schema, (char[2]) { (char) ARG_SCHEMA_QRYHANDLE, '=
\0' });
+    strcpy(query_regs_c.schema, (char[2]) { ARG_SCHEMA_QRYHANDLE, '\0' });
     mcd_query_cmds_table[cmd_number] =3D query_regs_c;
     cmd_number++;
=20
@@ -169,7 +162,7 @@ void init_query_cmds_table(MCDCmdParseEntry* mcd_query_=
cmds_table) {
         .handler =3D handle_query_state,
         .cmd =3D QUERY_ARG_STATE,
     };
-    strcpy(query_state.schema, (char[2]) { (char) ARG_SCHEMA_CORENUM, '\0'=
 });
+    strcpy(query_state.schema, (char[2]) { ARG_SCHEMA_CORENUM, '\0' });
     mcd_query_cmds_table[cmd_number] =3D query_state;
 }
=20
@@ -258,12 +251,8 @@ int pid_order(const void *a, const void *b)
=20
 int mcdserver_start(const char *device)
 {
-    //might wann add tracing later (no idea for what this is used)
-    //trace_gdbstub_op_start(device);
-
     char mcdstub_device_name[128];
     Chardev *chr =3D NULL;
-    //Chardev *mon_chr;
=20
     if (!first_cpu) {
         error_report("mcdstub: meaningless to attach to a "
@@ -271,7 +260,6 @@ int mcdserver_start(const char *device)
         return -1;
     }
=20
-    //
     if (!mcd_supports_guest_debug()) {
         error_report("mcdstub: current accelerator doesn't "
                      "support guest debugging");
@@ -282,7 +270,7 @@ int mcdserver_start(const char *device)
         return -1;
     }
=20
-    //if device =3D=3D default -> set device =3D tcp::1235
+    // if device =3D=3D default -> set device =3D tcp::1235
     if (strcmp(device, "default") =3D=3D 0) {
         device =3D "tcp::1235";
     }
@@ -303,7 +291,6 @@ int mcdserver_start(const char *device)
             sigaction(SIGINT, &act, NULL);
         }
 #endif
-=20=20=20=20=20=20=20=20
         chr =3D qemu_chr_new_noreplay("mcd", device, true, NULL);
         if (!chr) {
             return -1;
@@ -314,13 +301,8 @@ int mcdserver_start(const char *device)
         mcd_init_mcdserver_state();
=20
         qemu_add_vm_change_state_handler(mcd_vm_state_change, NULL);
-
-        /* Initialize a monitor terminal for mcd */
-        //mon_chr =3D qemu_chardev_new(NULL, TYPE_CHARDEV_MCD, NULL, NULL,=
 &error_abort);
-        //monitor_init_hmp(mon_chr, false, &error_abort);
     } else {
         qemu_chr_fe_deinit(&mcdserver_system_state.chr, true);
-        //mon_chr =3D mcdserver_system_state.mon_chr;
         reset_mcdserver_state();
     }
=20
@@ -334,7 +316,6 @@ int mcdserver_start(const char *device)
                                  NULL, &mcdserver_state, NULL, true);
     }
     mcdserver_state.state =3D chr ? RS_IDLE : RS_INACTIVE;
-    //mcdserver_system_state.mon_chr =3D mon_chr;
     mcd_syscall_reset();
=20
     return 0;
@@ -360,107 +341,80 @@ void mcd_read_byte(uint8_t ch)
     uint8_t reply;
=20
     if (mcdserver_state.last_packet->len) {
-        /* Waiting for a response to the last packet.  If we see the start
-           of a new command then abandon the previous response.  */
         if (ch =3D=3D TCP_NOT_ACKNOWLEDGED) {
-            //the previous packet was not akcnowledged
-            //trace_gdbstub_err_got_nack();
-            //we are resending the last packet
+            // the previous packet was not akcnowledged
             mcd_put_buffer(mcdserver_state.last_packet->data, mcdserver_st=
ate.last_packet->len);
         }
         else if (ch =3D=3D TCP_ACKNOWLEDGED) {
-            //the previous packet was acknowledged
-            //trace_gdbstub_io_got_ack();
+            // the previous packet was acknowledged
         }
=20
         if (ch =3D=3D TCP_ACKNOWLEDGED || ch =3D=3D TCP_COMMAND_START) {
-            //either acknowledged or a new communication starts -> we disc=
ard previous communication
+            // either acknowledged or a new communication starts -> discar=
d previous packet
             g_byte_array_set_size(mcdserver_state.last_packet, 0);
         }
         if (ch !=3D TCP_COMMAND_START) {
-            // we only continue if we are processing a new commant. otherw=
ise we skip to ne next character in the packet which sould be a $
+            // skip to the next char
             return;
         }
     }
-    //if (runstate_is_running()) {
-        /* when the CPU is running, we cannot do anything except stop
-           it when receiving a char */
-        //vm_stop(RUN_STATE_PAUSED);
-    //}
-    //else {
-        switch(mcdserver_state.state) {
-        case RS_IDLE:
-            if (ch =3D=3D TCP_COMMAND_START) {
-                /* start of command packet */
-                mcdserver_state.line_buf_index =3D 0;
-                mcdserver_state.line_sum =3D 0;
-                mcdserver_state.state =3D RS_GETLINE;
-            }
-            else {
-                //new communication has to start with a $
-                //trace_gdbstub_err_garbage(ch);
-            }
-            break;
-        case RS_GETLINE:
-            if (ch =3D=3D TCP_COMMAND_END) {
-                /* end of command, start of checksum*/
-                mcdserver_state.line_buf[mcdserver_state.line_buf_index++]=
 =3D 0;
-                //mcdserver_state.line_sum +=3D ch;
-                mcdserver_state.state =3D RS_DATAEND;
-            }
-            else if (mcdserver_state.line_buf_index >=3D sizeof(mcdserver_=
state.line_buf) - 1) {
-                //the input string is too long for the linebuffer!
-                //trace_gdbstub_err_overrun();
-                mcdserver_state.state =3D RS_IDLE;
-            }
-            else {
-                /* unescaped command character */
-                //this means the character is part of the real content fo =
the packet and we copy it to the line_buf
-                mcdserver_state.line_buf[mcdserver_state.line_buf_index++]=
 =3D ch;
-                mcdserver_state.line_sum +=3D ch;
-            }
-            break;
-        case RS_DATAEND:
-            // we are now done with copying the data and in the suffix of =
the packet
-            // TODO: maybe wanna implement a checksum or sth like the gdb =
protocol has
-
-            if (ch =3D=3D TCP_WAS_NOT_LAST) {
-                // ~ indicates that there is an additional package coming
-                //acknowledged -> send +
-                reply =3D TCP_ACKNOWLEDGED;
-                mcd_put_buffer(&reply, 1);
-                mcdserver_state.state =3D mcd_handle_packet(mcdserver_stat=
e.line_buf);
-            }
-            else if (ch =3D=3D TCP_WAS_LAST) {
-                //acknowledged -> send +
-                // | indicates that there is no additional package coming
-                reply =3D TCP_ACKNOWLEDGED;
-                mcd_put_buffer(&reply, 1);
-                mcdserver_state.state =3D mcd_handle_packet(mcdserver_stat=
e.line_buf);
-            }
-            else {
-                //trace_gdbstub_err_checksum_incorrect(mcdserver_state.lin=
e_sum, mcdserver_state.line_csum);
-                //not acknowledged -> send -
-                reply =3D TCP_NOT_ACKNOWLEDGED;
-                mcd_put_buffer(&reply, 1);
-                //waiting for package to get resent
-                mcdserver_state.state =3D RS_IDLE;
-            }
-            break;
-        default:
-            abort();
+
+    switch(mcdserver_state.state) {
+    case RS_IDLE:
+        if (ch =3D=3D TCP_COMMAND_START) {
+            // start of command packet
+            mcdserver_state.line_buf_index =3D 0;
+            mcdserver_state.line_sum =3D 0;
+            mcdserver_state.state =3D RS_GETLINE;
+        }
+        break;
+    case RS_GETLINE:
+        if (ch =3D=3D TCP_COMMAND_END) {
+            // end of command
+            mcdserver_state.line_buf[mcdserver_state.line_buf_index++] =3D=
 0;
+            mcdserver_state.state =3D RS_DATAEND;
+        }
+        else if (mcdserver_state.line_buf_index >=3D sizeof(mcdserver_stat=
e.line_buf) - 1) {
+            // the input string is too long for the linebuffer!
+            mcdserver_state.state =3D RS_IDLE;
+        }
+        else {
+            // copy the content to the line_buf
+            mcdserver_state.line_buf[mcdserver_state.line_buf_index++] =3D=
 ch;
+            mcdserver_state.line_sum +=3D ch;
+        }
+        break;
+    case RS_DATAEND:
+        if (ch =3D=3D TCP_WAS_NOT_LAST) {
+            reply =3D TCP_ACKNOWLEDGED;
+            mcd_put_buffer(&reply, 1);
+            mcdserver_state.state =3D mcd_handle_packet(mcdserver_state.li=
ne_buf);
+        }
+        else if (ch =3D=3D TCP_WAS_LAST) {
+            reply =3D TCP_ACKNOWLEDGED;
+            mcd_put_buffer(&reply, 1);
+            mcdserver_state.state =3D mcd_handle_packet(mcdserver_state.li=
ne_buf);
         }
-    //}
+        else {
+            // not acknowledged!
+            reply =3D TCP_NOT_ACKNOWLEDGED;
+            mcd_put_buffer(&reply, 1);
+            // waiting for package to get resent
+            mcdserver_state.state =3D RS_IDLE;
+        }
+        break;
+    default:
+        abort();
+    }
 }
=20
 int mcd_handle_packet(const char *line_buf)
 {
-    // decides what function (handler) to call depending on what the first=
 character in the line_buf is!
+    // decides what function (handler) to call depending on the first char=
acter in the line_buf
     const MCDCmdParseEntry *cmd_parser =3D NULL;
=20
     switch (line_buf[0]) {
     case TCP_CHAR_OPEN_SERVER:
-        // handshake and lookup initialization
         {
             static MCDCmdParseEntry open_server_cmd_desc =3D {
                 .handler =3D handle_open_server,
@@ -470,7 +424,6 @@ int mcd_handle_packet(const char *line_buf)
         }
         break;
     case TCP_CHAR_GO:
-        // go command
         {
             static MCDCmdParseEntry go_cmd_desc =3D {
                 .handler =3D handle_vm_start,
@@ -479,8 +432,17 @@ int mcd_handle_packet(const char *line_buf)
             cmd_parser =3D &go_cmd_desc;
         }
         break;
+    case TCP_CHAR_STEP:
+        {
+            static MCDCmdParseEntry step_cmd_desc =3D {
+                .handler =3D handle_vm_step,
+            };
+            step_cmd_desc.cmd =3D (char[2]) { TCP_CHAR_STEP, '\0' };
+            strcpy(step_cmd_desc.schema, (char[2]) { ARG_SCHEMA_CORENUM, '=
\0' });
+            cmd_parser =3D &step_cmd_desc;
+        }
+        break;
     case TCP_CHAR_BREAK:
-        // go command
         {
             static MCDCmdParseEntry break_cmd_desc =3D {
                 .handler =3D handle_vm_stop,
@@ -495,7 +457,6 @@ int mcd_handle_packet(const char *line_buf)
         mcd_exit(0);
         exit(0);
     case TCP_CHAR_QUERY:
-        //query inquiry
         {
             static MCDCmdParseEntry query_cmd_desc =3D {
                 .handler =3D handle_gen_query,
@@ -550,7 +511,7 @@ int mcd_handle_packet(const char *line_buf)
                 .handler =3D handle_read_register,
             };
             read_reg_cmd_desc.cmd =3D (char[2]) { TCP_CHAR_READ_REGISTER, =
'\0' };
-            strcpy(read_reg_cmd_desc.schema, (char[3]) { ARG_SCHEMA_CORENU=
M, ARG_SCHEMA_INT, '\0' });
+            strcpy(read_reg_cmd_desc.schema, (char[3]) { ARG_SCHEMA_CORENU=
M, ARG_SCHEMA_UINT64_T, '\0' });
             cmd_parser =3D &read_reg_cmd_desc;
         }
         break;
@@ -560,7 +521,7 @@ int mcd_handle_packet(const char *line_buf)
                 .handler =3D handle_write_register,
             };
             write_reg_cmd_desc.cmd =3D (char[2]) { TCP_CHAR_WRITE_REGISTER=
, '\0' };
-            strcpy(write_reg_cmd_desc.schema, (char[3]) { ARG_SCHEMA_COREN=
UM, ARG_SCHEMA_INT, '\0' });
+            strcpy(write_reg_cmd_desc.schema, (char[5]) { ARG_SCHEMA_COREN=
UM, ARG_SCHEMA_UINT64_T, ARG_SCHEMA_INT, ARG_SCHEMA_HEXDATA, '\0' });
             cmd_parser =3D &write_reg_cmd_desc;
         }
         break;
@@ -585,13 +546,13 @@ int mcd_handle_packet(const char *line_buf)
         }
         break;
     default:
-        // could not perform the command (because its unknown)
+        // command not supported
         mcd_put_packet("");
         break;
     }
=20
     if (cmd_parser) {
-        // now parse commands and run the selected function (handler)
+        // parse commands and run the selected handler function
         run_cmd_parser(line_buf, cmd_parser);
     }
=20
@@ -599,21 +560,29 @@ int mcd_handle_packet(const char *line_buf)
 }
=20
 void handle_vm_start(GArray *params, void *user_ctx) {
-    // todo add partial restart with arguments and so on
+    // TODO: add partial restart with arguments and so on
     mcd_vm_start();
 }
=20
+void handle_vm_step(GArray *params, void *user_ctx) {
+    // TODO: add partial restart with arguments and so on
+    uint32_t cpu_id =3D get_param(params, 0)->cpu_id;
+
+    CPUState *cpu =3D mcd_get_cpu(cpu_id);
+    mcd_vm_sstep(cpu);
+}
+
+
 void handle_vm_stop(GArray *params, void *user_ctx) {
-    // todo add partial stop with arguments and so on
+    // TODO: add partial stop with arguments and so on
     mcd_vm_stop();
 }
=20
-void handle_gen_query(GArray *params, void *user_ctx)
-{
+void handle_gen_query(GArray *params, void *user_ctx) {
     if (!params->len) {
         return;
     }
-    //now iterate over all possible query functions and execute the right =
one
+    // iterate over all possible query functions and execute the right one
     if (process_string_cmd(NULL, get_param(params, 0)->data,
                            mcdserver_state.mcd_query_cmds_table,
                            ARRAY_SIZE(mcdserver_state.mcd_query_cmds_table=
))) {
@@ -621,8 +590,7 @@ void handle_gen_query(GArray *params, void *user_ctx)
     }
 }
=20
-void run_cmd_parser(const char *data, const MCDCmdParseEntry *cmd)
-{
+void run_cmd_parser(const char *data, const MCDCmdParseEntry *cmd) {
     if (!data) {
         return;
     }
@@ -630,8 +598,6 @@ void run_cmd_parser(const char *data, const MCDCmdParse=
Entry *cmd)
     g_string_set_size(mcdserver_state.str_buf, 0);
     g_byte_array_set_size(mcdserver_state.mem_buf, 0);
=20
-    /* In case there was an error during the command parsing we must
-    * send a NULL packet to indicate the command is not supported */
     if (process_string_cmd(NULL, data, cmd, 1)) {
         mcd_put_packet("");
     }
@@ -655,11 +621,11 @@ int cmd_parse_params(const char *data, const char *sc=
hema, GArray *params) {
     const char *remaining_data =3D data;
=20=20=20=20=20
     for (int i =3D 0; i<strlen(schema); i++) {
-        // get correct part of string
+        // get correct part of data
         char *separator =3D strchr(remaining_data, ARGUMENT_SEPARATOR);
=20
         if (separator) {
-            // we multiple arguments left
+            // multiple arguments
             int seperator_index =3D (int)(separator - remaining_data);
             strncpy(data_buffer, remaining_data, seperator_index);
             data_buffer[seperator_index] =3D 0;
@@ -675,12 +641,11 @@ int cmd_parse_params(const char *data, const char *sc=
hema, GArray *params) {
         MCDCmdVariant this_param;=20
         switch (schema[i]) {
         case ARG_SCHEMA_STRING:
-            // a string has to be the last argument
+            // this has to be the last argument
             this_param.data =3D remaining_data;
             g_array_append_val(params, this_param);
             break;
         case ARG_SCHEMA_HEXDATA:
-            // a string has to be the last argument
             g_string_printf(mcdserver_state.str_buf, "%s", data_buffer);
             break;
         case ARG_SCHEMA_INT:
@@ -706,8 +671,7 @@ int cmd_parse_params(const char *data, const char *sche=
ma, GArray *params) {
     return 0;
 }
=20
-int process_string_cmd(void *user_ctx, const char *data, const MCDCmdParse=
Entry *cmds, int num_cmds)
-{
+int process_string_cmd(void *user_ctx, const char *data, const MCDCmdParse=
Entry *cmds, int num_cmds) {
     int i;
     g_autoptr(GArray) params =3D g_array_new(false, true, sizeof(MCDCmdVar=
iant));
=20
@@ -717,23 +681,21 @@ int process_string_cmd(void *user_ctx, const char *da=
ta, const MCDCmdParseEntry
=20
     for (i =3D 0; i < num_cmds; i++) {
         const MCDCmdParseEntry *cmd =3D &cmds[i];
-        //terminate if we don't have handler and cmd
         g_assert(cmd->handler && cmd->cmd);
=20
-        // if data and command are different continue
+        // continue if data and command are different
         if (strncmp(data, cmd->cmd, strlen(cmd->cmd))) {
             continue;
         }
=20
-        // if a schema is provided we need to extract parameters from the =
data string
         if (strlen(cmd->schema)) {
-            // this only gets the data from data beginning after the comma=
nd name
+            // extract data for parameters
             if (cmd_parse_params(&data[strlen(cmd->cmd)], cmd->schema, par=
ams)) {
                 return -1;
             }
         }
=20
-        // the correct handler function is called
+        // call handler
         cmd->handler(params, user_ctx);
         return 0;
     }
@@ -741,25 +703,16 @@ int process_string_cmd(void *user_ctx, const char *da=
ta, const MCDCmdParseEntry
     return -1;
 }
=20
-void mcd_exit(int code)
-{
-    char buf[4];
-
+void mcd_exit(int code) {
+    // terminate qemu
     if (!mcdserver_state.init) {
         return;
     }
=20
-    //trace_gdbstub_op_exiting((uint8_t)code);
-
-    //need to check what is sent here and dapt it to my needs
-    snprintf(buf, sizeof(buf), "W%02x", (uint8_t)code);
-    mcd_put_packet(buf);
-
     qemu_chr_fe_deinit(&mcdserver_system_state.chr, true);
 }
=20
-void mcd_chr_event(void *opaque, QEMUChrEvent event)
-{
+void mcd_chr_event(void *opaque, QEMUChrEvent event) {
     int i;
     MCDState *s =3D (MCDState *) opaque;
=20
@@ -771,19 +724,13 @@ void mcd_chr_event(void *opaque, QEMUChrEvent event)
         }
=20
         s->c_cpu =3D mcd_first_attached_cpu();
-
-        //vm_stop(RUN_STATE_PAUSED);
-		//TODO: this might not be necessary
-        //replay_gdb_attached();
-        //gdb_has_xml =3D false;
         break;
     default:
         break;
     }
 }
=20
-bool mcd_supports_guest_debug(void)
-{
+bool mcd_supports_guest_debug(void) {
     const AccelOpsClass *ops =3D cpus_get_accel();
     if (ops->supports_guest_debug) {
         return ops->supports_guest_debug();
@@ -792,29 +739,23 @@ bool mcd_supports_guest_debug(void)
 }
=20
 #ifndef _WIN32
-void mcd_sigterm_handler(int signal)
-{
+void mcd_sigterm_handler(int signal) {
     if (runstate_is_running()) {
         vm_stop(RUN_STATE_PAUSED);
     }
 }
 #endif
=20
-void mcd_vm_state_change(void *opaque, bool running, RunState state)
-{
+void mcd_vm_state_change(void *opaque, bool running, RunState state) {
 	CPUState *cpu =3D mcdserver_state.c_cpu;
=20
-    // update cpu state
-    mcdserver_state.vm_previous_state =3D mcdserver_state.vm_current_state;
-    mcdserver_state.vm_current_state =3D state;
-
     if (mcdserver_state.state =3D=3D RS_INACTIVE) {
         return;
     }
=20
     if (cpu =3D=3D NULL) {
         if (running) {
-            // this is the case if qemu starts the vm before any mcd is co=
nnected
+            // this is the case if qemu starts the vm before a mcd client =
is connected
             const char *mcd_state;
             mcd_state =3D CORE_STATE_RUNNING;
             const char *info_str;
@@ -857,8 +798,13 @@ void mcd_vm_state_change(void *opaque, bool running, R=
unState state)
                 stop_str =3D STATE_STR_BREAK_UNKNOWN;
             }
             cpu->watchpoint_hit =3D NULL;
-        } else {
-            // "hardware" breakpoint hit!
+        }
+        else if (cpu->singlestep_enabled){
+            // we land here when a single step is performed
+            cpu_single_step(cpu, 0);
+            stop_str =3D STATE_STEP_PERFORMED;
+        }
+        else {
             trig_id =3D MCD_TRIG_TYPE_IP;
             stop_str =3D STATE_STR_BREAK_HW;
             tb_flush(cpu);
@@ -870,47 +816,40 @@ void mcd_vm_state_change(void *opaque, bool running, =
RunState state)
         stop_str =3D "";
         break;
     case RUN_STATE_WATCHDOG:
+        printf("runstate watchdog hit\n");
         info_str =3D STATE_STR_UNKNOWN(cpu->cpu_index);
         mcd_state =3D CORE_STATE_UNKNOWN;
         stop_str =3D "";
-        printf("runstate watchdog hit\n");
         break;
     default:
         info_str =3D STATE_STR_UNKNOWN(cpu->cpu_index);
         mcd_state =3D CORE_STATE_UNKNOWN;
         stop_str =3D "";
-        // we don't care;
         break;
     }
=20
+    // set state for c_cpu
     mcdserver_state.cpu_state.state =3D mcd_state;
     mcdserver_state.cpu_state.trig_id =3D trig_id;
     mcdserver_state.cpu_state.stop_str =3D stop_str;
     mcdserver_state.cpu_state.info_str =3D info_str;
-
-    /* disable single step if it was enabled */
-    cpu_single_step(cpu, 0);
 }
=20
-int mcd_put_packet(const char *buf)
-{
+int mcd_put_packet(const char *buf) {
     return mcd_put_packet_binary(buf, strlen(buf), false);
 }
=20
-void mcd_put_strbuf(void)
-{
+void mcd_put_strbuf(void) {
     mcd_put_packet(mcdserver_state.str_buf->str);
 }
=20
-int mcd_put_packet_binary(const char *buf, int len, bool dump)
-{
+int mcd_put_packet_binary(const char *buf, int len, bool dump) {
     for(;;) {
-        //super interesting if we want a chekcsum or something like that h=
ere!!
         g_byte_array_set_size(mcdserver_state.last_packet, 0);
-        g_byte_array_append(mcdserver_state.last_packet, (const uint8_t *)=
 "$", 1);
+        g_byte_array_append(mcdserver_state.last_packet, (const uint8_t *)=
 (char[2]) { TCP_COMMAND_START, '\0' }, 1);
         g_byte_array_append(mcdserver_state.last_packet, (const uint8_t *)=
 buf, len);
-        g_byte_array_append(mcdserver_state.last_packet, (const uint8_t *)=
 "#", 1);
-        g_byte_array_append(mcdserver_state.last_packet, (const uint8_t *)=
 "|", 1);
+        g_byte_array_append(mcdserver_state.last_packet, (const uint8_t *)=
 (char[2]) { TCP_COMMAND_END, '\0' }, 1);
+        g_byte_array_append(mcdserver_state.last_packet, (const uint8_t *)=
 (char[2]) { TCP_WAS_LAST, '\0' }, 1);
=20
         mcd_put_buffer(mcdserver_state.last_packet->data, mcdserver_state.=
last_packet->len);
=20
@@ -921,53 +860,28 @@ int mcd_put_packet_binary(const char *buf, int len, b=
ool dump)
     return 0;
 }
=20
-bool mcd_got_immediate_ack(void)
-{
+bool mcd_got_immediate_ack(void) {
     return true;
 }
=20
-void mcd_put_buffer(const uint8_t *buf, int len)
-{
-    /*
-     * XXX this blocks entire thread. Rewrite to use
-     * qemu_chr_fe_write and background I/O callbacks
-     */
+void mcd_put_buffer(const uint8_t *buf, int len) {
     qemu_chr_fe_write_all(&mcdserver_system_state.chr, buf, len);
 }
=20
-void mcd_set_stop_cpu(CPUState *cpu)
-{
-    MCDProcess *p =3D mcd_get_cpu_process(cpu);
-
-    if (!p->attached) {
-        /*
-         * Having a stop CPU corresponding to a process that is not attach=
ed
-         * confuses GDB. So we ignore the request.
-         */
-        return;
-    }
-    //FIXME: we probably can delete this because in the opern_core functio=
n we set these two anyway
-    mcdserver_state.c_cpu =3D cpu;
-}
-
-MCDProcess *mcd_get_cpu_process(CPUState *cpu)
-{
+MCDProcess *mcd_get_cpu_process(CPUState *cpu) {
     return mcd_get_process(mcd_get_cpu_pid(cpu));
 }
=20
-uint32_t mcd_get_cpu_pid(CPUState *cpu)
-{
+uint32_t mcd_get_cpu_pid(CPUState *cpu) {
     if (cpu->cluster_index =3D=3D UNASSIGNED_CLUSTER_INDEX) {
-        /* Return the default process' PID */
+        // Return the default process' PID
         int index =3D mcdserver_state.process_num - 1;
         return mcdserver_state.processes[index].pid;
     }
-    // TODO: maybe +1 because we start numbering at 1
     return cpu->cluster_index + 1;
 }
=20
-MCDProcess *mcd_get_process(uint32_t pid)
-{
+MCDProcess *mcd_get_process(uint32_t pid) {
     int i;
=20
     if (!pid) {
@@ -997,8 +911,7 @@ CPUState* mcd_get_cpu(uint32_t i_cpu_index) {
     return cpu;
 }
=20
-CPUState *mcd_first_attached_cpu(void)
-{
+CPUState *mcd_first_attached_cpu(void) {
     CPUState *cpu =3D first_cpu;
     MCDProcess *process =3D mcd_get_cpu_process(cpu);
=20
@@ -1009,8 +922,7 @@ CPUState *mcd_first_attached_cpu(void)
     return cpu;
 }
=20
-CPUState *mcd_next_attached_cpu(CPUState *cpu)
-{
+CPUState *mcd_next_attached_cpu(CPUState *cpu) {
     cpu =3D CPU_NEXT(cpu);
=20
     while (cpu) {
@@ -1024,14 +936,11 @@ CPUState *mcd_next_attached_cpu(CPUState *cpu)
     return cpu;
 }
=20
-int mcd_get_cpu_index(CPUState *cpu)
-{
-    // TODO: maybe plus 1 because we start numbering at 1
+int mcd_get_cpu_index(CPUState *cpu) {
     return cpu->cpu_index + 1;
 }
=20
-CPUState *get_first_cpu_in_process(MCDProcess *process)
-{
+CPUState *get_first_cpu_in_process(MCDProcess *process) {
     CPUState *cpu;
=20
     CPU_FOREACH(cpu) {
@@ -1043,8 +952,7 @@ CPUState *get_first_cpu_in_process(MCDProcess *process)
     return NULL;
 }
=20
-CPUState *find_cpu(uint32_t thread_id)
-{
+CPUState *find_cpu(uint32_t thread_id) {
     CPUState *cpu;
=20
     CPU_FOREACH(cpu) {
@@ -1080,7 +988,7 @@ void parse_reg_xml(const char *xml, int size, GArray* =
registers) {
         c_ptr =3D &c;
=20
         if (still_to_skip>0) {
-            // skip chars unwanted chars
+            // skip unwanted chars
             still_to_skip --;
             continue;
         }
@@ -1172,9 +1080,7 @@ void parse_reg_xml(const char *xml, int size, GArray*=
 registers) {
 }
=20
 int int_cmp(gconstpointer a, gconstpointer b) {
-    int a_int =3D *(int*)a;
-    int b_int =3D *(int*)b;
-    if (a_int =3D=3D b_int) {
+    if (*(int*)a =3D=3D *(int*)b) {
         return 0;
     }
     else {
@@ -1285,7 +1191,7 @@ int init_trigger(mcd_trigger_st* trigger) {
 }
=20
 void handle_open_server(GArray *params, void *user_ctx) {
-    // initialize some core-independent data
+    // initialize core-independent data
     int return_value =3D 0;
     mcdserver_state.resets =3D g_array_new(false, true, sizeof(mcd_reset_s=
t));
     return_value =3D init_resets(mcdserver_state.resets);
@@ -1301,8 +1207,6 @@ void handle_query_system(GArray *params, void *user_c=
tx) {
 }
=20
 void handle_query_cores(GArray *params, void *user_ctx) {
-    //TODO: add cluster support: in gdb each inferior (process) handles on=
e cluster we might want to have sth similar here
-
     // get first cpu
     CPUState *cpu =3D mcd_first_attached_cpu();
     if (!cpu) {
@@ -1316,10 +1220,9 @@ void handle_query_cores(GArray *params, void *user_c=
tx) {
     gchar *arch =3D cc->gdb_arch_name(cpu);
=20=20=20=20=20
     int nr_cores =3D cpu->nr_cores;
-
     char device_name[] =3D DEVICE_NAME_TEMPLATE(arch);
     g_string_printf(mcdserver_state.str_buf, "%s=3D%s.%s=3D%s.%s=3D%d.",
-    TCP_ARGUMENT_DEVICE, device_name, TCP_ARGUMENT_CORE, cpu_model, TCP_AR=
GUMENT_AMOUNT_CORE, nr_cores);
+        TCP_ARGUMENT_DEVICE, device_name, TCP_ARGUMENT_CORE, cpu_model, TC=
P_ARGUMENT_AMOUNT_CORE, nr_cores);
     mcd_put_strbuf();
     g_free(arch);
 }
@@ -1441,7 +1344,6 @@ int mcd_arm_get_additional_register_info(GArray* regg=
roups, GArray* registers) {
 }
=20
 void handle_open_core(GArray *params, void *user_ctx) {
-    // get the cpu whith the given id
     uint32_t cpu_id =3D get_param(params, 0)->cpu_id;
     CPUState *cpu =3D mcd_get_cpu(cpu_id);
     mcdserver_state.c_cpu =3D cpu;
@@ -1501,9 +1403,7 @@ void handle_open_core(GArray *params, void *user_ctx)=
 {
 }
=20
 void handle_query_reset_f(GArray *params, void *user_ctx) {
-    // resetting has to be done over a monitor (look ar Rcmd) so we tell M=
CD that we can reset but this still need to be implemented
-    // we only support one reset over this monitor and that would be a ful=
l "system_restart"
-    // reset options are the same for every cpu!
+    // TODO: vull reset over the qemu monitor
=20=20=20=20=20
     // 1. check length
     int nb_resets =3D mcdserver_state.resets->len;
@@ -1518,7 +1418,6 @@ void handle_query_reset_f(GArray *params, void *user_=
ctx) {
     mcd_reset_st reset =3D g_array_index(mcdserver_state.resets, mcd_reset=
_st, 0);
     g_string_append_printf(mcdserver_state.str_buf, "%s=3D%s.%s=3D%d.", TC=
P_ARGUMENT_NAME, reset.name, TCP_ARGUMENT_ID, reset.id);
     mcd_put_strbuf();
-    // TODO: we still need to implement the gpr and memory reset here!
 }
=20
 void handle_query_reset_c(GArray *params, void *user_ctx) {
@@ -1539,7 +1438,6 @@ void handle_query_reset_c(GArray *params, void *user_=
ctx) {
     mcd_reset_st reset =3D g_array_index(mcdserver_state.resets, mcd_reset=
_st, query_index);
     g_string_append_printf(mcdserver_state.str_buf, "%s=3D%s.%s=3D%d.", TC=
P_ARGUMENT_NAME, reset.name, TCP_ARGUMENT_ID, reset.id);
     mcd_put_strbuf();
-    // TODO: we still need to implement the gpr and memory reset here!
 }
=20
 void handle_close_core(GArray *params, void *user_ctx) {
@@ -1575,7 +1473,7 @@ void handle_close_server(GArray *params, void *user_c=
tx) {
         mcdserver_state.c_cpu =3D mcd_first_attached_cpu();
     }
     if (!mcdserver_state.c_cpu) {
-        /* No more process attached */
+        // no more processes attached
         mcd_disable_syscalls();
         mcd_vm_start();
     }
@@ -1595,10 +1493,15 @@ void mcd_vm_start(void) {
     }
 }
=20
+int mcd_vm_sstep(CPUState *cpu) {
+    cpu_single_step(mcdserver_state.c_cpu, mcdserver_state.sstep_flags);
+    mcd_vm_start();
+    return 0;
+}
+
 void mcd_vm_stop(void) {
     if (runstate_is_running()) {
-        //might want to have DEBUG state here but idk
-        vm_stop(RUN_STATE_PAUSED);
+        vm_stop(RUN_STATE_DEBUG);
     }
 }
=20
@@ -1724,7 +1627,7 @@ void handle_query_regs_f(GArray *params, void *user_c=
tx) {
 }
=20
 void handle_query_regs_c(GArray *params, void *user_ctx) {
-    // this funcitons send all reg groups except for the first
+    // this funcitons send all regs except for the first
     // 1. get parameter and registers
     int query_index =3D get_param(params, 0)->query_handle;
     uint32_t cpu_id =3D mcdserver_state.query_cpu_id;
@@ -1750,16 +1653,12 @@ void handle_query_regs_c(GArray *params, void *user=
_ctx) {
 }
=20
 void handle_reset(GArray *params, void *user_ctx) {
-    int reset_id =3D get_param(params, 0)->data_int;
-    //int bool_halt_after_reset =3D get_param(params, 1)->data_int;
-    if (reset_id>=3D0) {
-        //fun for the compiler
-    }
+    //int reset_id =3D get_param(params, 0)->data_int;
+    // TODO: implement resets
 }
=20
 void handle_query_state(GArray *params, void *user_ctx) {
-    // send state from correct core
-    //uint32_t cpu_id =3D get_param(params, 0)->cpu_id;
+    // TODO: multicore support
     // get state info
     mcd_cpu_state_st state_info =3D mcdserver_state.cpu_state;
     mcd_core_event_et event =3D MCD_CORE_EVENT_NONE;
@@ -1795,6 +1694,19 @@ int mcd_read_register(CPUState *cpu, GByteArray *buf=
, int reg) {
     }
 }
=20
+int mcd_write_register(CPUState *cpu, GByteArray *buf, int reg) {
+    CPUClass *cc =3D CPU_GET_CLASS(cpu);
+    gchar *arch =3D cc->gdb_arch_name(cpu);
+    if (strcmp(arch, "arm")=3D=3D0) {
+        g_free(arch);
+        return arm_mcd_write_register(cpu, buf, reg);
+    }
+    else {
+        g_free(arch);
+        return 0;
+    }
+}
+
 void mcd_memtohex(GString *buf, const uint8_t *mem, int len) {
     int i, c;
     for(i =3D 0; i < len; i++) {
@@ -1817,18 +1729,28 @@ void mcd_hextomem(GByteArray *mem, const char *buf,=
 int len) {
=20
 void handle_read_register(GArray *params, void *user_ctx) {
     uint32_t cpu_id =3D get_param(params, 0)->cpu_id;
-    int reg_num =3D get_param(params, 1)->data_int;
+    uint64_t reg_num =3D get_param(params, 1)->data_int;
     int reg_size;
=20
     CPUState *cpu =3D mcd_get_cpu(cpu_id);
-
     reg_size =3D mcd_read_register(cpu, mcdserver_state.mem_buf, reg_num);
-    mcd_memtohex(mcdserver_state.str_buf,  mcdserver_state.mem_buf->data, =
reg_size);
+    mcd_memtohex(mcdserver_state.str_buf, mcdserver_state.mem_buf->data, r=
eg_size);
     mcd_put_strbuf();
 }
=20
 void handle_write_register(GArray *params, void *user_ctx) {
+    uint32_t cpu_id =3D get_param(params, 0)->cpu_id;
+    uint64_t reg_num =3D get_param(params, 1)->data_int;
+    uint32_t reg_size =3D get_param(params, 2)->data_int;
=20
+    CPUState *cpu =3D mcd_get_cpu(cpu_id);
+    mcd_hextomem(mcdserver_state.mem_buf, mcdserver_state.str_buf->str, re=
g_size);
+    if (mcd_write_register(cpu, mcdserver_state.mem_buf, reg_num)=3D=3D0) {
+        mcd_put_packet(TCP_EXECUTION_ERROR);
+    }
+    else {
+        mcd_put_packet(TCP_EXECUTION_SUCCESS);
+    }
 }
=20
 int mcd_read_memory(CPUState *cpu, hwaddr addr, uint8_t *buf, int len) {
@@ -1836,7 +1758,6 @@ int mcd_read_memory(CPUState *cpu, hwaddr addr, uint8=
_t *buf, int len) {
     //TODO: add physical mem cpu_physical_memory_read(addr, buf, len);
     cc =3D CPU_GET_CLASS(cpu);
     if (cc->memory_rw_debug) {
-        // TODO: check out the difference between those two calls
         return cc->memory_rw_debug(cpu, addr, buf, len, false);
     }
=20
@@ -1848,7 +1769,6 @@ int mcd_write_memory(CPUState *cpu, hwaddr addr, uint=
8_t *buf, int len) {
     //TODO: add physical mem cpu_physical_memory_read(addr, buf, len);
     cc =3D CPU_GET_CLASS(cpu);
     if (cc->memory_rw_debug) {
-        // TODO: check out the difference between those two calls
         return cc->memory_rw_debug(cpu, addr, buf, len, true);
     }
=20
diff --git a/softmmu/cpus.c b/softmmu/cpus.c
index 0848e0dbdb..6a1c969f3b 100644
--- a/softmmu/cpus.c
+++ b/softmmu/cpus.c
@@ -306,7 +306,7 @@ void cpu_handle_guest_debug(CPUState *cpu)
             cpu_single_step(cpu, 0);
         }
     } else {
-        gdb_set_stop_cpu(cpu);
+        //gdb_set_stop_cpu(cpu);
         qemu_system_debug_request();
         cpu->stopped =3D true;
     }
diff --git a/target/arm/mcdstub.c b/target/arm/mcdstub.c
index dc36a79a70..27e1a13b69 100644
--- a/target/arm/mcdstub.c
+++ b/target/arm/mcdstub.c
@@ -8,7 +8,7 @@
=20
 static inline int mcd_get_reg32(GByteArray *buf, uint32_t val)
 {
-    //FIXME: move this to a separate file
+    //TODO: move this to a separate file
     // convert endianess if necessary
     uint32_t to_long =3D tswap32(val);
     g_byte_array_append(buf, (uint8_t *) &to_long, 4);
@@ -17,7 +17,7 @@ static inline int mcd_get_reg32(GByteArray *buf, uint32_t=
 val)
=20
 static inline int mcd_get_zeroes(GByteArray *array, size_t len)
 {
-    //FIXME: move this to a separate file
+    //TODO: move this to a separate file
     guint oldlen =3D array->len;
     g_byte_array_set_size(array, oldlen + len);
     memset(array->data + oldlen, 0, len);
@@ -44,9 +44,6 @@ const char *arm_mcd_get_dynamic_xml(CPUState *cs, const c=
har *xmlname)
 }
=20
 int arm_mcd_read_register(CPUState *cs, GByteArray *mem_buf, int n) {
-    //CPUClass *cc =3D CPU_GET_CLASS(cpu);
-    //CPUArchState *env =3D cpu->env_ptr;
-
     ARMCPU *cpu =3D ARM_CPU(cs);
     CPUARMState *env =3D &cpu->env;
=20
@@ -70,6 +67,61 @@ int arm_mcd_read_register(CPUState *cs, GByteArray *mem_=
buf, int n) {
             return mcd_get_reg32(mem_buf, cpsr_read(env));
         }
     }
-    //TODO: add funcitons for regs with higher numbers (including cp_regs)
+    //TODO: add funcitons for the remaining regs (including cp_regs)
+    return 0;
+}
+
+int arm_mcd_write_register(CPUState *cs, GByteArray *mem_buf, int n) {
+    ARMCPU *cpu =3D ARM_CPU(cs);
+    CPUARMState *env =3D &cpu->env;
+    uint32_t tmp;
+
+    tmp =3D ldl_p(mem_buf);
+    tmp =3D *((uint32_t*)mem_buf->data);
+
+    /*
+     * Mask out low bits of PC to workaround gdb bugs.
+     * This avoids an assert in thumb_tr_translate_insn, because it is
+     * architecturally impossible to misalign the pc.
+     * This will probably cause problems if we ever implement the
+     * Jazelle DBX extensions.
+     */
+    if (n =3D=3D 15) {
+        tmp &=3D ~1;
+    }
+
+    if (n < 16) {
+        /* Core integer register.  */
+        if (n =3D=3D 13 && arm_feature(env, ARM_FEATURE_M)) {
+            /* M profile SP low bits are always 0 */
+            tmp &=3D ~3;
+        }
+        env->regs[n] =3D tmp;
+        return 4;
+    }
+    if (n < 24) { /* 16-23 */
+        /* FPA registers (ignored).  */
+        return 4;
+    }
+    switch (n) {
+    case 24:
+        /* FPA status register (ignored).  */
+        return 4;
+    case 25:
+        /* CPSR, or XPSR for M-profile */
+        if (arm_feature(env, ARM_FEATURE_M)) {
+            /*
+             * Don't allow writing to XPSR.Exception as it can cause
+             * a transition into or out of handler mode (it's not
+             * writable via the MSR insn so this is a reasonable
+             * restriction). Other fields are safe to update.
+             */
+            xpsr_write(env, tmp, ~XPSR_EXCP);
+        } else {
+            cpsr_write(env, tmp, 0xffffffff, CPSRWriteByGDBStub);
+        }
+        return 4;
+    }
+    //TODO: add funcitons for the remaining regs (including cp_regs)
     return 0;
-}
\ No newline at end of file
+}
diff --git a/target/arm/mcdstub.h b/target/arm/mcdstub.h
index d61028c7f4..28c7f2baec 100644
--- a/target/arm/mcdstub.h
+++ b/target/arm/mcdstub.h
@@ -3,5 +3,6 @@
=20
 const char *arm_mcd_get_dynamic_xml(CPUState *cs, const char *xmlname);
 int arm_mcd_read_register(CPUState *cs, GByteArray *mem_buf, int n);
+int arm_mcd_write_register(CPUState *cs, GByteArray *mem_buf, int n);
=20
 #endif /* ARM_MCDSTUB_H */
--=20
2.34.1


From a0a4aacb667ec3161642bd1831b7ba359a87357a Mon Sep 17 00:00:00 2001
From: Nicolas Eder <nicolas.eder@lauterbach.com>
Date: Fri, 7 Jul 2023 15:25:15 +0200
Subject: [PATCH 15/29] adapting to the qemu coding style

Signed-off-by: Nicolas Eder <nicolas.eder@lauterbach.com>
---
 gdbstub/gdbstub.c                  |    2 +-
 include/exec/mcdstub.h             |    3 +-
 include/mcdstub/syscalls.h         |    2 +-
 mcdstub/mcd_shared_defines.h       |   17 +-
 mcdstub/mcd_softmmu.c              |  171 -----
 mcdstub/mcd_syscalls.c             |    7 +-
 mcdstub/mcd_tcp_server.c           |   95 ---
 mcdstub/mcdstub.c                  | 1037 ++++++++++++++++------------
 mcdstub/{internals.h =3D> mcdstub.h} |  102 +--
 mcdstub/meson.build                |   16 +-
 softmmu/cpus.c                     |    2 +-
 softmmu/vl.c                       |    4 +-
 target/arm/mcdstub.c               |   24 +-
 13 files changed, 684 insertions(+), 798 deletions(-)
 delete mode 100644 mcdstub/mcd_softmmu.c
 delete mode 100644 mcdstub/mcd_tcp_server.c
 rename mcdstub/{internals.h =3D> mcdstub.h} (69%)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 2ff50757bb..349d348c7b 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -857,7 +857,7 @@ static int process_string_cmd(const char *data,
=20
         if (cmd->schema) {
             if (cmd_parse_params(&data[strlen(cmd->cmd)],
-                                 cmd->schema, params)) {=20
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
=20
 #define DEFAULT_MCDSTUB_PORT "1235"
-#define TYPE_CHARDEV_MCD "chardev-mcd"
=20
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
=20
 typedef void (*gdb_syscall_complete_cb)(CPUState *cpu, uint64_t ret, int e=
rr);
=20
-#endif /* _SYSCALLS_H_ */
\ No newline at end of file
+#endif /* _SYSCALLS_H_ */
diff --git a/mcdstub/mcd_shared_defines.h b/mcdstub/mcd_shared_defines.h
index 311d24e12f..891f6477e7 100644
--- a/mcdstub/mcd_shared_defines.h
+++ b/mcdstub/mcd_shared_defines.h
@@ -1,9 +1,12 @@
-// this file is shared between the mcd dll and the mcd stub. it has to be =
kept exectly the same!
+/*
+ *this file is shared between the mcd dll and the mcd stub.
+ *it has to be kept exectly the same!
+ */
=20
 #ifndef MCD_SHARED_DEFINES
 #define MCD_SHARED_DEFINES
=20
-// tcp data characters
+/* tcp data characters */
 #define TCP_CHAR_OPEN_SERVER 'I'
 #define TCP_CHAR_OPEN_CORE 'i'
 #define TCP_CHAR_GO 'C'
@@ -19,7 +22,7 @@
 #define TCP_CHAR_READ_MEMORY 'm'
 #define TCP_CHAR_WRITE_MEMORY 'M'
=20
-// tcp protocol chars
+/* tcp protocol chars */
 #define TCP_ACKNOWLEDGED '+'
 #define TCP_NOT_ACKNOWLEDGED '-'
 #define TCP_COMMAND_START '$'
@@ -30,7 +33,7 @@
 #define TCP_EXECUTION_SUCCESS "success"
 #define TCP_EXECUTION_ERROR "error"
=20
-// tcp query arguments
+/* tcp query arguments */
 #define QUERY_FIRST "f"
 #define QUERY_CONSEQUTIVE "c"
=20
@@ -43,7 +46,7 @@
 #define QUERY_ARG_REG "reg"
 #define QUERY_ARG_STATE "state"
=20
-// tcp query packet argument list
+/* tcp query packet argument list */
 #define TCP_ARGUMENT_NAME "name"
 #define TCP_ARGUMENT_DATA "data"
 #define TCP_ARGUMENT_ID "id"
@@ -70,10 +73,10 @@
 #define TCP_ARGUMENT_OPTION "option"
 #define TCP_ARGUMENT_ACTION "action"
=20
-// for packets sent to qemu
+/* for packets sent to qemu */
 #define ARGUMENT_SEPARATOR ';'
=20
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
-#define ISVALIDSOCKET(s) ((s) !=3D INVALID_SOCKET)
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
-#define ISVALIDSOCKET(s) ((s) >=3D 0)
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
-    //the device is a char array. if its "default" we use tcp with the def=
ault DEFAULT_MCDSTUB_PORT. Otherwise it has to look like "tcp::<tcpport>"
-    char tcp_port[MX_INPUT_LENGTH];
-    int error;
-    error =3D mcd_extract_tcp_port_num(device, tcp_port);
-    if (error !=3D 0) {
-        return -1;
-    }
-    int tcp_port_num =3D atoi(tcp_port);
-=20=20=20=20=20=20=20=20
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
-	socked_fd =3D socket(AF_INET, SOCK_STREAM, 0);
-	if (!ISVALIDSOCKET(socked_fd)) {
-		return -1;
-	}
-	memset(&server_address, 0, sizeof(server_address));
-
-	// assign IP, PORT
-	server_address.sin_family =3D AF_INET;
-	server_address.sin_port =3D htons(tcp_port);
-	server_address.sin_addr.s_addr =3D htonl(INADDR_ANY);
-
-	// Binding newly created socket to given IP and verification
-	if ((bind(socked_fd, (SA*)&server_address, sizeof(server_address))) !=3D =
0) {
-		CLOSESOCKET(socked_fd);
-		return -1;
-	}
-
-	// Now server is ready to listen and verification
-	if ((listen(socked_fd, 5)) !=3D 0) {
-		CLOSESOCKET(socked_fd);
-		return -1;
-	}
-	else {
-		printf("TCP server listening on port %d\n", tcp_port);
-	}
-
-	//accepting connection
-	len =3D sizeof(client_address);
-	connect_fd =3D accept(socked_fd, (SA*)&client_address, &len);
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
-=09
-	if (strcmp(buff, expected_buff)=3D=3D0) {
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
-    int string_length =3D strlen(in_string);
-    if (string_length>MX_INPUT_LENGTH+1) {
-        return -1;
-    }
-
-    const char default_str[] =3D "default";
-
-    if ((string_length=3D=3Dstrlen(default_str)) && (strcmp(default_str, i=
n_string)=3D=3D0)) {
-        strcpy((char*)out_string, DEFAULT_MCDSTUB_PORT);
-        return 0;
-    }
-    else if (strcmp("tcp::", in_string)=3D=3D0) {
-            for (int index =3D 5; index < string_length; index++) {
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
=20
 typedef struct {
     char syscall_buf[256];
-    //TODO: this needs to be get fixed mcd_syscall_complete_cb
+    /* TODO: this needs to be get fixed mcd_syscall_complete_cb */
     int current_syscall_cb;
 } MCDSyscallState;
=20
@@ -28,4 +27,4 @@ void mcd_syscall_reset(void)
 void mcd_disable_syscalls(void)
 {
     mcd_syscall_mode =3D MCD_SYS_DISABLED;
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
-		n =3D 0;
-		// copy server message in the buffer
-		while ((buff[n++] =3D getchar()) !=3D '\n')
-			;
-
-		// and send that buffer to client
-		write(connfd, buff, sizeof(buff));
-
-		// if msg contains "Exit" then server exit and chat ended.
-		if (strncmp("exit", buff, 4) =3D=3D 0) {
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
-	sockfd =3D socket(AF_INET, SOCK_STREAM, 0);
-	if (sockfd =3D=3D -1) {
-		printf("socket creation failed...\n");
-		exit(0);
-	}
-	else
-		printf("Socket successfully created..\n");
-	bzero(&servaddr, sizeof(servaddr));
-
-	// assign IP, PORT
-	servaddr.sin_family =3D AF_INET;
-	servaddr.sin_addr.s_addr =3D htonl(INADDR_ANY);
-	servaddr.sin_port =3D htons(DEFAULT_MCDSTUB_PORT);
-
-	// Binding newly created socket to given IP and verification
-	if ((bind(sockfd, (SA*)&servaddr, sizeof(servaddr))) !=3D 0) {
-		printf("socket bind failed...\n");
-		exit(0);
-	}
-	else
-		printf("Socket successfully binded..\n");
-
-	// Now server is ready to listen and verification
-	if ((listen(sockfd, 5)) !=3D 0) {
-		printf("Listen failed...\n");
-		exit(0);
-	}
-	else
-		printf("Server listening..\n");
-	len =3D sizeof(cli);
-
-	// Accept the data packet from client and verification
-	connfd =3D accept(sockfd, (SA*)&cli, &len);
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
=20
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
=20
 #include "qapi/error.h"
 #include "exec/tb-flush.h"
@@ -27,11 +24,12 @@
 #include "chardev/char-fe.h"
 #include "monitor/monitor.h"
=20
-// architecture specific stubs
-#include "target/arm/mcdstub.h"
+/* mcdstub header files */
+#include "mcd_shared_defines.h"
+#include "mcdstub.h"
=20
-// FIXME: delete the following line and check if it worked
-#include "hw/core/sysemu-cpu-ops.h"
+/* architecture specific stubs */
+#include "target/arm/mcdstub.h"
=20
 typedef struct {
     CharBackend chr;
@@ -43,7 +41,7 @@ MCDState mcdserver_state;
=20
 void mcd_init_mcdserver_state(void)
 {
-	g_assert(!mcdserver_state.init);
+    g_assert(!mcdserver_state.init);
     memset(&mcdserver_state, 0, sizeof(MCDState));
     mcdserver_state.init =3D true;
     mcdserver_state.str_buf =3D g_string_new(NULL);
@@ -55,14 +53,15 @@ void mcd_init_mcdserver_state(void)
      * By default try to use no IRQs and no timers while single
      * stepping so as to make single stepping like a typical ICE HW step.
      */
-    mcdserver_state.supported_sstep_flags =3D accel_supported_gdbstub_sste=
p_flags();
+    mcdserver_state.supported_sstep_flags =3D
+        accel_supported_gdbstub_sstep_flags();
     mcdserver_state.sstep_flags =3D SSTEP_ENABLE | SSTEP_NOIRQ | SSTEP_NOT=
IMER;
     mcdserver_state.sstep_flags &=3D mcdserver_state.supported_sstep_flags;
=20
-    // init query table
+    /* init query table */
     init_query_cmds_table(mcdserver_state.mcd_query_cmds_table);
=20
-    // at this time the cpu hans't been started! -> set cpu_state
+    /* at this time the cpu hans't been started! -> set cpu_state */
     mcd_cpu_state_st cpu_state =3D  {
             .state =3D CORE_STATE_HALTED,
             .info_str =3D STATE_STR_INIT_HALTED,
@@ -70,8 +69,9 @@ void mcd_init_mcdserver_state(void)
     mcdserver_state.cpu_state =3D cpu_state;
 }
=20
-void init_query_cmds_table(MCDCmdParseEntry* mcd_query_cmds_table) {
-    // initalizes a list of all query commands
+void init_query_cmds_table(MCDCmdParseEntry *mcd_query_cmds_table)
+{
+    /* initalizes a list of all query commands */
     int cmd_number =3D 0;
=20
     MCDCmdParseEntry query_system =3D {
@@ -270,7 +270,7 @@ int mcdserver_start(const char *device)
         return -1;
     }
=20
-    // if device =3D=3D default -> set device =3D tcp::1235
+    /* if device =3D=3D default -> set device =3D tcp::1235 */
     if (strcmp(device, "default") =3D=3D 0) {
         device =3D "tcp::1235";
     }
@@ -329,10 +329,12 @@ int mcd_chr_can_receive(void *opaque)
 void mcd_chr_receive(void *opaque, const uint8_t *buf, int size)
 {
     int i;
-=09
+
     for (i =3D 0; i < size; i++) {
         mcd_read_byte(buf[i]);
-        if (buf[i]=3D=3D0) break;
+        if (buf[i] =3D=3D 0) {
+            break;
+        }
     }
 }
=20
@@ -342,27 +344,30 @@ void mcd_read_byte(uint8_t ch)
=20
     if (mcdserver_state.last_packet->len) {
         if (ch =3D=3D TCP_NOT_ACKNOWLEDGED) {
-            // the previous packet was not akcnowledged
-            mcd_put_buffer(mcdserver_state.last_packet->data, mcdserver_st=
ate.last_packet->len);
-        }
-        else if (ch =3D=3D TCP_ACKNOWLEDGED) {
-            // the previous packet was acknowledged
+            /* the previous packet was not akcnowledged */
+            mcd_put_buffer(mcdserver_state.last_packet->data,
+                mcdserver_state.last_packet->len);
+        } else if (ch =3D=3D TCP_ACKNOWLEDGED) {
+            /* the previous packet was acknowledged */
         }
=20
         if (ch =3D=3D TCP_ACKNOWLEDGED || ch =3D=3D TCP_COMMAND_START) {
-            // either acknowledged or a new communication starts -> discar=
d previous packet
+            /*
+             * either acknowledged or a new communication starts
+             * -> discard previous packet
+             */
             g_byte_array_set_size(mcdserver_state.last_packet, 0);
         }
         if (ch !=3D TCP_COMMAND_START) {
-            // skip to the next char
+            /* skip to the next char */
             return;
         }
     }
=20
-    switch(mcdserver_state.state) {
+    switch (mcdserver_state.state) {
     case RS_IDLE:
         if (ch =3D=3D TCP_COMMAND_START) {
-            // start of command packet
+            /* start of command packet */
             mcdserver_state.line_buf_index =3D 0;
             mcdserver_state.line_sum =3D 0;
             mcdserver_state.state =3D RS_GETLINE;
@@ -370,16 +375,15 @@ void mcd_read_byte(uint8_t ch)
         break;
     case RS_GETLINE:
         if (ch =3D=3D TCP_COMMAND_END) {
-            // end of command
+            /* end of command */
             mcdserver_state.line_buf[mcdserver_state.line_buf_index++] =3D=
 0;
             mcdserver_state.state =3D RS_DATAEND;
-        }
-        else if (mcdserver_state.line_buf_index >=3D sizeof(mcdserver_stat=
e.line_buf) - 1) {
-            // the input string is too long for the linebuffer!
+        } else if (mcdserver_state.line_buf_index >=3D
+            sizeof(mcdserver_state.line_buf) - 1) {
+            /* the input string is too long for the linebuffer! */
             mcdserver_state.state =3D RS_IDLE;
-        }
-        else {
-            // copy the content to the line_buf
+        } else {
+            /* copy the content to the line_buf */
             mcdserver_state.line_buf[mcdserver_state.line_buf_index++] =3D=
 ch;
             mcdserver_state.line_sum +=3D ch;
         }
@@ -389,17 +393,15 @@ void mcd_read_byte(uint8_t ch)
             reply =3D TCP_ACKNOWLEDGED;
             mcd_put_buffer(&reply, 1);
             mcdserver_state.state =3D mcd_handle_packet(mcdserver_state.li=
ne_buf);
-        }
-        else if (ch =3D=3D TCP_WAS_LAST) {
+        } else if (ch =3D=3D TCP_WAS_LAST) {
             reply =3D TCP_ACKNOWLEDGED;
             mcd_put_buffer(&reply, 1);
             mcdserver_state.state =3D mcd_handle_packet(mcdserver_state.li=
ne_buf);
-        }
-        else {
-            // not acknowledged!
+        } else {
+            /* not acknowledged! */
             reply =3D TCP_NOT_ACKNOWLEDGED;
             mcd_put_buffer(&reply, 1);
-            // waiting for package to get resent
+            /* waiting for package to get resent */
             mcdserver_state.state =3D RS_IDLE;
         }
         break;
@@ -410,7 +412,10 @@ void mcd_read_byte(uint8_t ch)
=20
 int mcd_handle_packet(const char *line_buf)
 {
-    // decides what function (handler) to call depending on the first char=
acter in the line_buf
+    /*
+     * decides what function (handler) to call depending on
+     * the first character in the line_buf
+     */
     const MCDCmdParseEntry *cmd_parser =3D NULL;
=20
     switch (line_buf[0]) {
@@ -438,7 +443,8 @@ int mcd_handle_packet(const char *line_buf)
                 .handler =3D handle_vm_step,
             };
             step_cmd_desc.cmd =3D (char[2]) { TCP_CHAR_STEP, '\0' };
-            strcpy(step_cmd_desc.schema, (char[2]) { ARG_SCHEMA_CORENUM, '=
\0' });
+            strcpy(step_cmd_desc.schema,
+                (char[2]) { ARG_SCHEMA_CORENUM, '\0' });
             cmd_parser =3D &step_cmd_desc;
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
                 .handler =3D handle_gen_query,
             };
             query_cmd_desc.cmd =3D (char[2]) { TCP_CHAR_QUERY, '\0' };
-            strcpy(query_cmd_desc.schema, (char[2]) { ARG_SCHEMA_STRING, '=
\0' });
+            strcpy(query_cmd_desc.schema,
+                (char[2]) { ARG_SCHEMA_STRING, '\0' });
             cmd_parser =3D &query_cmd_desc;
         }
         break;
@@ -472,7 +479,8 @@ int mcd_handle_packet(const char *line_buf)
                 .handler =3D handle_open_core,
             };
             open_core_cmd_desc.cmd =3D (char[2]) { TCP_CHAR_OPEN_CORE, '\0=
' };
-            strcpy(open_core_cmd_desc.schema, (char[2]) { ARG_SCHEMA_COREN=
UM, '\0' });
+            strcpy(open_core_cmd_desc.schema,
+                (char[2]) { ARG_SCHEMA_CORENUM, '\0' });
             cmd_parser =3D &open_core_cmd_desc;
         }
         break;
@@ -481,7 +489,8 @@ int mcd_handle_packet(const char *line_buf)
             static MCDCmdParseEntry close_server_cmd_desc =3D {
                 .handler =3D handle_close_server,
             };
-            close_server_cmd_desc.cmd =3D (char[2]) { TCP_CHAR_CLOSE_SERVE=
R, '\0' };
+            close_server_cmd_desc.cmd =3D
+                (char[2]) { TCP_CHAR_CLOSE_SERVER, '\0' };
             cmd_parser =3D &close_server_cmd_desc;
         }
         break;
@@ -491,7 +500,8 @@ int mcd_handle_packet(const char *line_buf)
                 .handler =3D handle_close_core,
             };
             close_core_cmd_desc.cmd =3D (char[2]) { TCP_CHAR_CLOSE_CORE, '=
\0' };
-            strcpy(close_core_cmd_desc.schema, (char[2]) { ARG_SCHEMA_CORE=
NUM, '\0' });
+            strcpy(close_core_cmd_desc.schema,
+                (char[2]) { ARG_SCHEMA_CORENUM, '\0' });
             cmd_parser =3D &close_core_cmd_desc;
         }
         break;
@@ -511,7 +521,8 @@ int mcd_handle_packet(const char *line_buf)
                 .handler =3D handle_read_register,
             };
             read_reg_cmd_desc.cmd =3D (char[2]) { TCP_CHAR_READ_REGISTER, =
'\0' };
-            strcpy(read_reg_cmd_desc.schema, (char[3]) { ARG_SCHEMA_CORENU=
M, ARG_SCHEMA_UINT64_T, '\0' });
+            strcpy(read_reg_cmd_desc.schema,
+                (char[3]) { ARG_SCHEMA_CORENUM, ARG_SCHEMA_UINT64_T, '\0' =
});
             cmd_parser =3D &read_reg_cmd_desc;
         }
         break;
@@ -520,8 +531,11 @@ int mcd_handle_packet(const char *line_buf)
             static MCDCmdParseEntry write_reg_cmd_desc =3D {
                 .handler =3D handle_write_register,
             };
-            write_reg_cmd_desc.cmd =3D (char[2]) { TCP_CHAR_WRITE_REGISTER=
, '\0' };
-            strcpy(write_reg_cmd_desc.schema, (char[5]) { ARG_SCHEMA_COREN=
UM, ARG_SCHEMA_UINT64_T, ARG_SCHEMA_INT, ARG_SCHEMA_HEXDATA, '\0' });
+            write_reg_cmd_desc.cmd =3D
+                (char[2]) { TCP_CHAR_WRITE_REGISTER, '\0' };
+            strcpy(write_reg_cmd_desc.schema,
+                (char[5]) { ARG_SCHEMA_CORENUM, ARG_SCHEMA_UINT64_T,
+                ARG_SCHEMA_INT, ARG_SCHEMA_HEXDATA, '\0' });
             cmd_parser =3D &write_reg_cmd_desc;
         }
         break;
@@ -531,7 +545,9 @@ int mcd_handle_packet(const char *line_buf)
                 .handler =3D handle_read_memory,
             };
             read_mem_cmd_desc.cmd =3D (char[2]) { TCP_CHAR_READ_MEMORY, '\=
0' };
-            strcpy(read_mem_cmd_desc.schema, (char[4]) { ARG_SCHEMA_CORENU=
M, ARG_SCHEMA_UINT64_T, ARG_SCHEMA_INT, '\0' });
+            strcpy(read_mem_cmd_desc.schema,
+                (char[4]) { ARG_SCHEMA_CORENUM, ARG_SCHEMA_UINT64_T,
+                ARG_SCHEMA_INT, '\0' });
             cmd_parser =3D &read_mem_cmd_desc;
         }
         break;
@@ -541,48 +557,57 @@ int mcd_handle_packet(const char *line_buf)
                 .handler =3D handle_write_memory,
             };
             write_mem_cmd_desc.cmd =3D (char[2]) { TCP_CHAR_WRITE_MEMORY, =
'\0' };
-            strcpy(write_mem_cmd_desc.schema, (char[5]) { ARG_SCHEMA_COREN=
UM, ARG_SCHEMA_UINT64_T, ARG_SCHEMA_INT, ARG_SCHEMA_HEXDATA, '\0' });
+            strcpy(write_mem_cmd_desc.schema,
+                (char[5]) { ARG_SCHEMA_CORENUM, ARG_SCHEMA_UINT64_T,
+                ARG_SCHEMA_INT, ARG_SCHEMA_HEXDATA, '\0' });
             cmd_parser =3D &write_mem_cmd_desc;
         }
         break;
     default:
-        // command not supported
+        /* command not supported */
         mcd_put_packet("");
         break;
     }
=20
     if (cmd_parser) {
-        // parse commands and run the selected handler function
+        /* parse commands and run the selected handler function */
         run_cmd_parser(line_buf, cmd_parser);
     }
=20
     return RS_IDLE;
 }
=20
-void handle_vm_start(GArray *params, void *user_ctx) {
-    // TODO: add partial restart with arguments and so on
+void handle_vm_start(GArray *params, void *user_ctx)
+{
+    /* TODO: add partial restart with arguments and so on */
     mcd_vm_start();
 }
=20
-void handle_vm_step(GArray *params, void *user_ctx) {
-    // TODO: add partial restart with arguments and so on
+void handle_vm_step(GArray *params, void *user_ctx)
+{
+    /* TODO: add partial restart with arguments and so on */
     uint32_t cpu_id =3D get_param(params, 0)->cpu_id;
=20
     CPUState *cpu =3D mcd_get_cpu(cpu_id);
-    mcd_vm_sstep(cpu);
+    int return_value =3D mcd_vm_sstep(cpu);
+    if (return_value !=3D 0) {
+        g_assert_not_reached();
+    }
 }
=20
=20
-void handle_vm_stop(GArray *params, void *user_ctx) {
-    // TODO: add partial stop with arguments and so on
+void handle_vm_stop(GArray *params, void *user_ctx)
+{
+    /* TODO: add partial stop with arguments and so on */
     mcd_vm_stop();
 }
=20
-void handle_gen_query(GArray *params, void *user_ctx) {
+void handle_gen_query(GArray *params, void *user_ctx)
+{
     if (!params->len) {
         return;
     }
-    // iterate over all possible query functions and execute the right one
+    /* iterate over all possible query functions and execute the right one=
 */
     if (process_string_cmd(NULL, get_param(params, 0)->data,
                            mcdserver_state.mcd_query_cmds_table,
                            ARRAY_SIZE(mcdserver_state.mcd_query_cmds_table=
))) {
@@ -590,7 +615,8 @@ void handle_gen_query(GArray *params, void *user_ctx) {
     }
 }
=20
-void run_cmd_parser(const char *data, const MCDCmdParseEntry *cmd) {
+void run_cmd_parser(const char *data, const MCDCmdParseEntry *cmd)
+{
     if (!data) {
         return;
     }
@@ -603,10 +629,10 @@ void run_cmd_parser(const char *data, const MCDCmdPar=
seEntry *cmd) {
     }
 }
=20
-uint64_t atouint64_t(const char* in) {
+uint64_t atouint64_t(const char *in)
+{
     uint64_t res =3D 0;
-    for (int i =3D 0; i < strlen(in); ++i)
-    {
+    for (int i =3D 0; i < strlen(in); ++i) {
         const char c =3D in[i];
         res *=3D 10;
         res +=3D c - '0';
@@ -615,33 +641,33 @@ uint64_t atouint64_t(const char* in) {
     return res;
 }
=20
-int cmd_parse_params(const char *data, const char *schema, GArray *params)=
 {
-=20=20=20=20
+int cmd_parse_params(const char *data, const char *schema, GArray *params)
+{
+
     char data_buffer[64] =3D {0};
     const char *remaining_data =3D data;
-=20=20=20=20
-    for (int i =3D 0; i<strlen(schema); i++) {
-        // get correct part of data
+
+    for (int i =3D 0; i < strlen(schema); i++) {
+        /* get correct part of data */
         char *separator =3D strchr(remaining_data, ARGUMENT_SEPARATOR);
=20
         if (separator) {
-            // multiple arguments
+            /* multiple arguments */
             int seperator_index =3D (int)(separator - remaining_data);
             strncpy(data_buffer, remaining_data, seperator_index);
             data_buffer[seperator_index] =3D 0;
-            // update remaining data for the next run
-            remaining_data =3D &(remaining_data[seperator_index+1]);
-        }
-        else {
+            /* update remaining data for the next run */
+            remaining_data =3D &(remaining_data[seperator_index + 1]);
+        } else {
             strncpy(data_buffer, remaining_data, strlen(remaining_data));
             data_buffer[strlen(remaining_data)] =3D 0;
         }
-=20=20=20=20=20=20=20=20
-        // store right data
-        MCDCmdVariant this_param;=20
+
+        /* store right data */
+        MCDCmdVariant this_param;
         switch (schema[i]) {
         case ARG_SCHEMA_STRING:
-            // this has to be the last argument
+            /* this has to be the last argument */
             this_param.data =3D remaining_data;
             g_array_append_val(params, this_param);
             break;
@@ -671,7 +697,9 @@ int cmd_parse_params(const char *data, const char *sche=
ma, GArray *params) {
     return 0;
 }
=20
-int process_string_cmd(void *user_ctx, const char *data, const MCDCmdParse=
Entry *cmds, int num_cmds) {
+int process_string_cmd(void *user_ctx, const char *data,
+    const MCDCmdParseEntry *cmds, int num_cmds)
+{
     int i;
     g_autoptr(GArray) params =3D g_array_new(false, true, sizeof(MCDCmdVar=
iant));
=20
@@ -683,19 +711,20 @@ int process_string_cmd(void *user_ctx, const char *da=
ta, const MCDCmdParseEntry
         const MCDCmdParseEntry *cmd =3D &cmds[i];
         g_assert(cmd->handler && cmd->cmd);
=20
-        // continue if data and command are different
+        /* continue if data and command are different */
         if (strncmp(data, cmd->cmd, strlen(cmd->cmd))) {
             continue;
         }
=20
         if (strlen(cmd->schema)) {
-            // extract data for parameters
-            if (cmd_parse_params(&data[strlen(cmd->cmd)], cmd->schema, par=
ams)) {
+            /* extract data for parameters */
+            if (cmd_parse_params(&data[strlen(cmd->cmd)], cmd->schema, par=
ams))
+            {
                 return -1;
             }
         }
=20
-        // call handler
+        /* call handler */
         cmd->handler(params, user_ctx);
         return 0;
     }
@@ -703,8 +732,9 @@ int process_string_cmd(void *user_ctx, const char *data=
, const MCDCmdParseEntry
     return -1;
 }
=20
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
=20
-void mcd_chr_event(void *opaque, QEMUChrEvent event) {
+void mcd_chr_event(void *opaque, QEMUChrEvent event)
+{
     int i;
     MCDState *s =3D (MCDState *) opaque;
=20
     switch (event) {
     case CHR_EVENT_OPENED:
-        // Start with first process attached, others detached
+        /* Start with first process attached, others detached */
         for (i =3D 0; i < s->process_num; i++) {
             s->processes[i].attached =3D !i;
         }
@@ -730,7 +761,8 @@ void mcd_chr_event(void *opaque, QEMUChrEvent event) {
     }
 }
=20
-bool mcd_supports_guest_debug(void) {
+bool mcd_supports_guest_debug(void)
+{
     const AccelOpsClass *ops =3D cpus_get_accel();
     if (ops->supports_guest_debug) {
         return ops->supports_guest_debug();
@@ -739,15 +771,17 @@ bool mcd_supports_guest_debug(void) {
 }
=20
 #ifndef _WIN32
-void mcd_sigterm_handler(int signal) {
+void mcd_sigterm_handler(int signal)
+{
     if (runstate_is_running()) {
         vm_stop(RUN_STATE_PAUSED);
     }
 }
 #endif
=20
-void mcd_vm_state_change(void *opaque, bool running, RunState state) {
-	CPUState *cpu =3D mcdserver_state.c_cpu;
+void mcd_vm_state_change(void *opaque, bool running, RunState state)
+{
+    CPUState *cpu =3D mcdserver_state.c_cpu;
=20
     if (mcdserver_state.state =3D=3D RS_INACTIVE) {
         return;
@@ -755,7 +789,10 @@ void mcd_vm_state_change(void *opaque, bool running, R=
unState state) {
=20
     if (cpu =3D=3D NULL) {
         if (running) {
-            // this is the case if qemu starts the vm before a mcd client =
is connected
+            /*
+             * this is the case if qemu starts the vm
+             * before a mcd client is connected
+             */
             const char *mcd_state;
             mcd_state =3D CORE_STATE_RUNNING;
             const char *info_str;
@@ -798,13 +835,11 @@ void mcd_vm_state_change(void *opaque, bool running, =
RunState state) {
                 stop_str =3D STATE_STR_BREAK_UNKNOWN;
             }
             cpu->watchpoint_hit =3D NULL;
-        }
-        else if (cpu->singlestep_enabled){
-            // we land here when a single step is performed
+        } else if (cpu->singlestep_enabled) {
+            /* we land here when a single step is performed */
             cpu_single_step(cpu, 0);
             stop_str =3D STATE_STEP_PERFORMED;
-        }
-        else {
+        } else {
             trig_id =3D MCD_TRIG_TYPE_IP;
             stop_str =3D STATE_STR_BREAK_HW;
             tb_flush(cpu);
@@ -816,7 +851,6 @@ void mcd_vm_state_change(void *opaque, bool running, Ru=
nState state) {
         stop_str =3D "";
         break;
     case RUN_STATE_WATCHDOG:
-        printf("runstate watchdog hit\n");
         info_str =3D STATE_STR_UNKNOWN(cpu->cpu_index);
         mcd_state =3D CORE_STATE_UNKNOWN;
         stop_str =3D "";
@@ -828,30 +862,38 @@ void mcd_vm_state_change(void *opaque, bool running, =
RunState state) {
         break;
     }
=20
-    // set state for c_cpu
+    /* set state for c_cpu */
     mcdserver_state.cpu_state.state =3D mcd_state;
     mcdserver_state.cpu_state.trig_id =3D trig_id;
     mcdserver_state.cpu_state.stop_str =3D stop_str;
     mcdserver_state.cpu_state.info_str =3D info_str;
 }
=20
-int mcd_put_packet(const char *buf) {
+int mcd_put_packet(const char *buf)
+{
     return mcd_put_packet_binary(buf, strlen(buf), false);
 }
=20
-void mcd_put_strbuf(void) {
+void mcd_put_strbuf(void)
+{
     mcd_put_packet(mcdserver_state.str_buf->str);
 }
=20
-int mcd_put_packet_binary(const char *buf, int len, bool dump) {
-    for(;;) {
+int mcd_put_packet_binary(const char *buf, int len, bool dump)
+{
+    for (;;) {
         g_byte_array_set_size(mcdserver_state.last_packet, 0);
-        g_byte_array_append(mcdserver_state.last_packet, (const uint8_t *)=
 (char[2]) { TCP_COMMAND_START, '\0' }, 1);
-        g_byte_array_append(mcdserver_state.last_packet, (const uint8_t *)=
 buf, len);
-        g_byte_array_append(mcdserver_state.last_packet, (const uint8_t *)=
 (char[2]) { TCP_COMMAND_END, '\0' }, 1);
-        g_byte_array_append(mcdserver_state.last_packet, (const uint8_t *)=
 (char[2]) { TCP_WAS_LAST, '\0' }, 1);
-
-        mcd_put_buffer(mcdserver_state.last_packet->data, mcdserver_state.=
last_packet->len);
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
=20
         if (mcd_got_immediate_ack()) {
             break;
@@ -860,28 +902,33 @@ int mcd_put_packet_binary(const char *buf, int len, b=
ool dump) {
     return 0;
 }
=20
-bool mcd_got_immediate_ack(void) {
+bool mcd_got_immediate_ack(void)
+{
     return true;
 }
=20
-void mcd_put_buffer(const uint8_t *buf, int len) {
+void mcd_put_buffer(const uint8_t *buf, int len)
+{
     qemu_chr_fe_write_all(&mcdserver_system_state.chr, buf, len);
 }
=20
-MCDProcess *mcd_get_cpu_process(CPUState *cpu) {
+MCDProcess *mcd_get_cpu_process(CPUState *cpu)
+{
     return mcd_get_process(mcd_get_cpu_pid(cpu));
 }
=20
-uint32_t mcd_get_cpu_pid(CPUState *cpu) {
+uint32_t mcd_get_cpu_pid(CPUState *cpu)
+{
     if (cpu->cluster_index =3D=3D UNASSIGNED_CLUSTER_INDEX) {
-        // Return the default process' PID
+        /* Return the default process' PID */
         int index =3D mcdserver_state.process_num - 1;
         return mcdserver_state.processes[index].pid;
     }
     return cpu->cluster_index + 1;
 }
=20
-MCDProcess *mcd_get_process(uint32_t pid) {
+MCDProcess *mcd_get_process(uint32_t pid)
+{
     int i;
=20
     if (!pid) {
@@ -898,7 +945,8 @@ MCDProcess *mcd_get_process(uint32_t pid) {
     return NULL;
 }
=20
-CPUState* mcd_get_cpu(uint32_t i_cpu_index) {
+CPUState *mcd_get_cpu(uint32_t i_cpu_index)
+{
     CPUState *cpu =3D first_cpu;
=20
     while (cpu) {
@@ -911,7 +959,8 @@ CPUState* mcd_get_cpu(uint32_t i_cpu_index) {
     return cpu;
 }
=20
-CPUState *mcd_first_attached_cpu(void) {
+CPUState *mcd_first_attached_cpu(void)
+{
     CPUState *cpu =3D first_cpu;
     MCDProcess *process =3D mcd_get_cpu_process(cpu);
=20
@@ -922,7 +971,8 @@ CPUState *mcd_first_attached_cpu(void) {
     return cpu;
 }
=20
-CPUState *mcd_next_attached_cpu(CPUState *cpu) {
+CPUState *mcd_next_attached_cpu(CPUState *cpu)
+{
     cpu =3D CPU_NEXT(cpu);
=20
     while (cpu) {
@@ -936,11 +986,13 @@ CPUState *mcd_next_attached_cpu(CPUState *cpu) {
     return cpu;
 }
=20
-int mcd_get_cpu_index(CPUState *cpu) {
+int mcd_get_cpu_index(CPUState *cpu)
+{
     return cpu->cpu_index + 1;
 }
=20
-CPUState *get_first_cpu_in_process(MCDProcess *process) {
+CPUState *get_first_cpu_in_process(MCDProcess *process)
+{
     CPUState *cpu;
=20
     CPU_FOREACH(cpu) {
@@ -952,7 +1004,8 @@ CPUState *get_first_cpu_in_process(MCDProcess *process=
) {
     return NULL;
 }
=20
-CPUState *find_cpu(uint32_t thread_id) {
+CPUState *find_cpu(uint32_t thread_id)
+{
     CPUState *cpu;
=20
     CPU_FOREACH(cpu) {
@@ -965,8 +1018,9 @@ CPUState *find_cpu(uint32_t thread_id) {
 }
=20
=20
-void parse_reg_xml(const char *xml, int size, GArray* registers) {
-    // iterates over the complete xml file
+void parse_reg_xml(const char *xml, int size, GArray *registers)
+{
+    /* iterates over the complete xml file */
     int i, j;
     int still_to_skip =3D 0;
     char argument[64] =3D {0};
@@ -987,108 +1041,103 @@ void parse_reg_xml(const char *xml, int size, GArr=
ay* registers) {
         c =3D xml[i];
         c_ptr =3D &c;
=20
-        if (still_to_skip>0) {
-            // skip unwanted chars
-            still_to_skip --;
+        if (still_to_skip > 0) {
+            /* skip unwanted chars */
+            still_to_skip--;
             continue;
         }
=20
-        if (strncmp(&xml[i], "<reg", 4)=3D=3D0) {
-            // start of a register
+        if (strncmp(&xml[i], "<reg", 4) =3D=3D 0) {
+            /* start of a register */
             still_to_skip =3D 3;
             is_reg =3D true;
             reg_data =3D g_array_new(false, true, sizeof(xml_attrib));
-        }
-        else if (is_reg) {
-            if (strncmp(&xml[i], "/>", 2)=3D=3D0) {
-                // end of register info
+        } else if (is_reg) {
+            if (strncmp(&xml[i], "/>", 2) =3D=3D 0) {
+                /* end of register info */
                 still_to_skip =3D 1;
                 is_reg =3D false;
=20
-                // create empty register
+                /* create empty register */
                 mcd_reg_st my_register =3D (const struct mcd_reg_st){ 0 };
=20
-                // add found attribtues
-                for (j =3D 0; j<reg_data->len; j++) {
+                /* add found attribtues */
+                for (j =3D 0; j < reg_data->len; j++) {
                     attribute_j =3D g_array_index(reg_data, xml_attrib, j);
=20
                     argument_j =3D attribute_j.argument;
                     value_j =3D attribute_j.value;
=20
-                    if (strcmp(argument_j, "name")=3D=3D0) {
+                    if (strcmp(argument_j, "name") =3D=3D 0) {
                         strcpy(my_register.name, value_j);
-                    }
-                    else if (strcmp(argument_j, "regnum")=3D=3D0) {
+                    } else if (strcmp(argument_j, "regnum") =3D=3D 0) {
                         my_register.id =3D atoi(value_j);
-                    }
-                    else if (strcmp(argument_j, "bitsize")=3D=3D0) {
+                    } else if (strcmp(argument_j, "bitsize") =3D=3D 0) {
                         my_register.bitsize =3D atoi(value_j);
-                    }
-                    else if (strcmp(argument_j, "type")=3D=3D0) {
+                    } else if (strcmp(argument_j, "type") =3D=3D 0) {
                         strcpy(my_register.type, value_j);
-                    }
-                    else if (strcmp(argument_j, "group")=3D=3D0) {
+                    } else if (strcmp(argument_j, "group") =3D=3D 0) {
                         strcpy(my_register.group, value_j);
                     }
                 }
-                // store register
+                /* store register */
                 g_array_append_vals(registers, (gconstpointer)&my_register=
, 1);
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
-                    case '=3D':
-                        is_argument =3D false;
-                        break;
-                    case '"':
-                        if (is_value) {
-                            // end of value reached
-                            is_value =3D false;
-                            // store arg-val combo
-                            xml_attrib current_attribute;
-                            strcpy(current_attribute.argument, argument);
-                            strcpy(current_attribute.value, value);
-                            g_array_append_vals(reg_data, (gconstpointer)&=
current_attribute, 1);
-                            memset(argument, 0, sizeof(argument));
-                            memset(value, 0, sizeof(value));
-                        }
-                        else {
-                            //start of value
-                            is_value =3D true;
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
-                            is_argument =3D true;
-                            strncat(argument, c_ptr, 1);
-                        }
-                        break;
+                case ' ':
+                    break;
+                case '=3D':
+                    is_argument =3D false;
+                    break;
+                case '"':
+                    if (is_value) {
+                        /* end of value reached */
+                        is_value =3D false;
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
+                        is_value =3D true;
+                    }
+                    break;
+                default:
+                    if (is_argument) {
+                        strncat(argument, c_ptr, 1);
+                    } else if (is_value) {
+                        strncat(value, c_ptr, 1);
+                    } else {
+                        is_argument =3D true;
+                        strncat(argument, c_ptr, 1);
+                    }
+                    break;
                 }
             }
         }
     }
 }
=20
-int int_cmp(gconstpointer a, gconstpointer b) {
-    if (*(int*)a =3D=3D *(int*)b) {
+int int_cmp(gconstpointer a, gconstpointer b)
+{
+    int int_a =3D *(int *)a;
+    int int_b =3D *(int *)b;
+    if (int_a =3D=3D int_b) {
         return 0;
-    }
-    else {
+    } else {
         return 1;
     }
 }
=20
-int mcd_arm_store_mem_spaces(CPUState *cpu, GArray* memspaces) {
+int mcd_arm_store_mem_spaces(CPUState *cpu, GArray *memspaces)
+{
     int nr_address_spaces =3D cpu->num_ases;
=20
     mcd_mem_space_st space1 =3D {
@@ -1117,7 +1166,7 @@ int mcd_arm_store_mem_spaces(CPUState *cpu, GArray* m=
emspaces) {
     };
     g_array_append_vals(memspaces, (gconstpointer)&space2, 1);
=20
-    if (nr_address_spaces=3D=3D2) {
+    if (nr_address_spaces =3D=3D 2) {
         mcd_mem_space_st space3 =3D {
         .name =3D "Secure",
         .id =3D 3,
@@ -1143,7 +1192,7 @@ int mcd_arm_store_mem_spaces(CPUState *cpu, GArray* m=
emspaces) {
     };
     g_array_append_vals(memspaces, (gconstpointer)&space4, 1);
     }
-    // TODO: get dynamically how the per (CP15) space is called
+    /* TODO: get dynamically how the per (CP15) space is called */
     mcd_mem_space_st space5 =3D {
         .name =3D "GPR Registers",
         .id =3D 5,
@@ -1172,7 +1221,8 @@ int mcd_arm_store_mem_spaces(CPUState *cpu, GArray* m=
emspaces) {
     return 0;
 }
=20
-int init_resets(GArray* resets) {
+int init_resets(GArray *resets)
+{
     mcd_reset_st system_reset =3D { .id =3D 0, .name =3D RESET_SYSTEM};
     mcd_reset_st gpr_reset =3D { .id =3D 1, .name =3D RESET_GPR};
     mcd_reset_st memory_reset =3D { .id =3D 2, .name =3D RESET_MEMORY};
@@ -1182,32 +1232,41 @@ int init_resets(GArray* resets) {
     return 0;
 }
=20
-int init_trigger(mcd_trigger_st* trigger) {
-    trigger->type =3D (MCD_TRIG_TYPE_IP | MCD_TRIG_TYPE_READ | MCD_TRIG_TY=
PE_WRITE | MCD_TRIG_TYPE_RW);
+int init_trigger(mcd_trigger_st *trigger)
+{
+    trigger->type =3D (MCD_TRIG_TYPE_IP | MCD_TRIG_TYPE_READ |
+        MCD_TRIG_TYPE_WRITE | MCD_TRIG_TYPE_RW);
     trigger->option =3D (MCD_TRIG_OPT_DATA_IS_CONDITION);
     trigger->action =3D (MCD_TRIG_ACTION_DBG_DEBUG);
     trigger->nr_trigger =3D 4;
     return 0;
 }
=20
-void handle_open_server(GArray *params, void *user_ctx) {
-    // initialize core-independent data
+void handle_open_server(GArray *params, void *user_ctx)
+{
+    /* initialize core-independent data */
     int return_value =3D 0;
     mcdserver_state.resets =3D g_array_new(false, true, sizeof(mcd_reset_s=
t));
     return_value =3D init_resets(mcdserver_state.resets);
-    if (return_value!=3D0) assert(0);
+    if (return_value !=3D 0) {
+        g_assert_not_reached();
+    }
     return_value =3D init_trigger(&mcdserver_state.trigger);
-    if (return_value!=3D0) assert(0);
+    if (return_value !=3D 0) {
+        g_assert_not_reached();
+    }
=20
-    mcd_put_packet(TCP_HANDSHAKE_SUCCESS);=20
+    mcd_put_packet(TCP_HANDSHAKE_SUCCESS);
 }
=20
-void handle_query_system(GArray *params, void *user_ctx) {
+void handle_query_system(GArray *params, void *user_ctx)
+{
     mcd_put_packet(MCD_SYSTEM_NAME);
 }
=20
-void handle_query_cores(GArray *params, void *user_ctx) {
-    // get first cpu
+void handle_query_cores(GArray *params, void *user_ctx)
+{
+    /* get first cpu */
     CPUState *cpu =3D mcd_first_attached_cpu();
     if (!cpu) {
         return;
@@ -1218,123 +1277,136 @@ void handle_query_cores(GArray *params, void *use=
r_ctx) {
=20
     CPUClass *cc =3D CPU_GET_CLASS(cpu);
     gchar *arch =3D cc->gdb_arch_name(cpu);
-=20=20=20=20
+
     int nr_cores =3D cpu->nr_cores;
     char device_name[] =3D DEVICE_NAME_TEMPLATE(arch);
     g_string_printf(mcdserver_state.str_buf, "%s=3D%s.%s=3D%s.%s=3D%d.",
-        TCP_ARGUMENT_DEVICE, device_name, TCP_ARGUMENT_CORE, cpu_model, TC=
P_ARGUMENT_AMOUNT_CORE, nr_cores);
+        TCP_ARGUMENT_DEVICE, device_name, TCP_ARGUMENT_CORE, cpu_model,
+        TCP_ARGUMENT_AMOUNT_CORE, nr_cores);
     mcd_put_strbuf();
     g_free(arch);
 }
=20
-int mcd_arm_parse_core_xml_file(CPUClass *cc, GArray* reggroups, GArray* r=
egisters, int* current_group_id) {
+int mcd_arm_parse_core_xml_file(CPUClass *cc, GArray *reggroups,
+    GArray *registers, int *current_group_id)
+{
     const char *xml_filename =3D NULL;
     const char *current_xml_filename =3D NULL;
     const char *xml_content =3D NULL;
     int i =3D 0;
=20
-    // 1. get correct file
+    /* 1. get correct file */
     xml_filename =3D cc->gdb_core_xml_file;
     for (i =3D 0; ; i++) {
         current_xml_filename =3D xml_builtin[i][0];
-        if (!current_xml_filename || (strncmp(current_xml_filename, xml_fi=
lename, strlen(xml_filename)) =3D=3D 0
+        if (!current_xml_filename || (strncmp(current_xml_filename,
+            xml_filename, strlen(xml_filename)) =3D=3D 0
             && strlen(current_xml_filename) =3D=3D strlen(xml_filename)))
-        break;
+            break;
     }
-    // without gpr registers we can do nothing
+    /* without gpr registers we can do nothing */
     if (!current_xml_filename) {
         return -1;
     }
=20
-    // 2. add group for gpr registers
-    mcd_reg_group_st gprregs =3D { .name =3D "GPR Registers", .id =3D *cur=
rent_group_id };
+    /* 2. add group for gpr registers */
+    mcd_reg_group_st gprregs =3D {
+        .name =3D "GPR Registers",
+        .id =3D *current_group_id
+    };
     g_array_append_vals(reggroups, (gconstpointer)&gprregs, 1);
     *current_group_id =3D *current_group_id + 1;
=20
-    // 3. parse xml
+    /* 3. parse xml */
     xml_content =3D xml_builtin[i][1];
     parse_reg_xml(xml_content, strlen(xml_content), registers);
     return 0;
 }
=20
-int mcd_arm_parse_general_xml_files(CPUState *cpu, GArray* reggroups, GArr=
ay* registers, int* current_group_id) {
+int mcd_arm_parse_general_xml_files(CPUState *cpu, GArray *reggroups,
+    GArray *registers, int *current_group_id) {
     const char *xml_filename =3D NULL;
     const char *current_xml_filename =3D NULL;
     const char *xml_content =3D NULL;
     int i =3D 0;
=20
-    // iterate over all gdb xml files=20
+    /* iterate over all gdb xml files*/
     GDBRegisterState *r;
     for (r =3D cpu->gdb_regs; r; r =3D r->next) {
         xml_filename =3D r->xml;
         xml_content =3D NULL;
=20
-        // 1. get xml content
+        /* 1. get xml content */
         xml_content =3D arm_mcd_get_dynamic_xml(cpu, xml_filename);
         if (xml_content) {
-            if (strcmp(xml_filename, "system-registers.xml")=3D=3D0) {
-                // these are the coprocessor register
-                mcd_reg_group_st corprocessorregs =3D { .name =3D "CP15 Re=
gisters", .id =3D *current_group_id };
-                g_array_append_vals(reggroups, (gconstpointer)&corprocesso=
rregs, 1);
+            if (strcmp(xml_filename, "system-registers.xml") =3D=3D 0) {
+                /* these are the coprocessor register */
+                mcd_reg_group_st corprocessorregs =3D {
+                    .name =3D "CP15 Registers",
+                    .id =3D *current_group_id
+                };
+                g_array_append_vals(reggroups,
+                    (gconstpointer)&corprocessorregs, 1);
                 *current_group_id =3D *current_group_id + 1;
-            }=20=20
-        }
-        else {
-            // its not a coprocessor xml -> it is a static xml file
+            }
+        } else {
+            /* its not a coprocessor xml -> it is a static xml file */
             for (i =3D 0; ; i++) {
                 current_xml_filename =3D xml_builtin[i][0];
-                if (!current_xml_filename || (strncmp(current_xml_filename=
, xml_filename, strlen(xml_filename)) =3D=3D 0
+                if (!current_xml_filename || (strncmp(current_xml_filename,
+                    xml_filename, strlen(xml_filename)) =3D=3D 0
                     && strlen(current_xml_filename) =3D=3D strlen(xml_file=
name)))
-                break;
+                    break;
             }
             if (current_xml_filename) {
                 xml_content =3D xml_builtin[i][1];
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
=20
-int mcd_arm_get_additional_register_info(GArray* reggroups, GArray* regist=
ers) {
+int mcd_arm_get_additional_register_info(GArray *reggroups, GArray *regist=
ers)
+{
     GList *register_numbers =3D NULL;
     mcd_reg_st *current_register;
     int i =3D 0;
     int id_neg_offset =3D 0;
     int effective_id =3D 0;
=20
-    // iterate over all registers
+    /* iterate over all registers */
     for (i =3D 0; i < registers->len; i++) {
         current_register =3D &(g_array_index(registers, mcd_reg_st, i));
-        // 1. ad the id
+        /* 1. ad the id */
         if (current_register->id) {
-            // id is already in place
-            // NOTE: qemu doesn't emulate the FPA regs (so we are missing =
the indices 16 to 24)
+            /*
+             *id is already in place
+             *NOTE: qemu doesn't emulate the FPA regs
+             *(so we are missing the indices 16 to 24)
+             */
             int used_id =3D current_register->id;
             register_numbers =3D g_list_append(register_numbers, &used_id);
-            id_neg_offset ++;
-        }
-        else {
+            id_neg_offset++;
+        } else {
             effective_id =3D i - id_neg_offset;
-            if (g_list_find_custom(register_numbers, &effective_id, (GComp=
areFunc)int_cmp)!=3DNULL) {
-                id_neg_offset --;
+            if (g_list_find_custom(register_numbers, &effective_id,
+                (GCompareFunc)int_cmp) !=3D NULL) {
+                id_neg_offset--;
             }
             current_register->id =3D i - id_neg_offset;
         }
-        // 2. add mcd_reg_group_id and mcd_mem_space_id
-        if (strcmp(current_register->group, "cp_regs")=3D=3D0) {
-            // coprocessor registers
+        /* 2. add mcd_reg_group_id and mcd_mem_space_id */
+        if (strcmp(current_register->group, "cp_regs") =3D=3D 0) {
+            /* coprocessor registers */
             current_register->mcd_reg_group_id =3D 2;
             current_register->mcd_mem_space_id =3D 6;
-            // TODO: get info for opcode
-        }
-        else {
-            // gpr register
+            /* TODO: get info for opcode */
+        } else {
+            /* gpr register */
             current_register->mcd_reg_group_id =3D 1;
             current_register->mcd_mem_space_id =3D 5;
         }
@@ -1343,7 +1415,8 @@ int mcd_arm_get_additional_register_info(GArray* regg=
roups, GArray* registers) {
     return 0;
 }
=20
-void handle_open_core(GArray *params, void *user_ctx) {
+void handle_open_core(GArray *params, void *user_ctx)
+{
     uint32_t cpu_id =3D get_param(params, 0)->cpu_id;
     CPUState *cpu =3D mcd_get_cpu(cpu_id);
     mcdserver_state.c_cpu =3D cpu;
@@ -1351,315 +1424,373 @@ void handle_open_core(GArray *params, void *user_=
ctx) {
     gchar *arch =3D cc->gdb_arch_name(cpu);
     int return_value =3D 0;
=20
-    // prepare data strucutures
-    GArray* memspaces =3D g_array_new(false, true, sizeof(mcd_mem_space_st=
));
-    GArray* reggroups =3D g_array_new(false, true, sizeof(mcd_reg_group_st=
));
-    GArray* registers =3D g_array_new(false, true, sizeof(mcd_reg_st));
-=20=20=20=20
-    if (strcmp(arch, "arm")=3D=3D0) {
-        // TODO: make group and memspace ids dynamic
+    /* prepare data strucutures */
+    GArray *memspaces =3D g_array_new(false, true, sizeof(mcd_mem_space_st=
));
+    GArray *reggroups =3D g_array_new(false, true, sizeof(mcd_reg_group_st=
));
+    GArray *registers =3D g_array_new(false, true, sizeof(mcd_reg_st));
+
+    if (strcmp(arch, "arm") =3D=3D 0) {
+        /* TODO: make group and memspace ids dynamic */
         int current_group_id =3D 1;
-        // 1. store mem spaces
+        /* 1. store mem spaces */
         return_value =3D mcd_arm_store_mem_spaces(cpu, memspaces);
-        if (return_value!=3D0) assert(0);
-        // 2. parse core xml
-        return_value =3D mcd_arm_parse_core_xml_file(cc, reggroups, regist=
ers, &current_group_id);
-        if (return_value!=3D0) assert(0);
-        // 3. parse other xmls
-        return_value =3D mcd_arm_parse_general_xml_files(cpu, reggroups, r=
egisters, &current_group_id);
-        if (return_value!=3D0) assert(0);
-        // 4. add additional data the the regs from the xmls
-        return_value =3D mcd_arm_get_additional_register_info(reggroups, r=
egisters);
-        if (return_value!=3D0) assert(0);
-        // 5. store all found data
+        if (return_value !=3D 0) {
+            g_assert_not_reached();
+        }
+        /* 2. parse core xml */
+        return_value =3D mcd_arm_parse_core_xml_file(cc, reggroups,
+            registers, &current_group_id);
+        if (return_value !=3D 0) {
+            g_assert_not_reached();
+        }
+        /* 3. parse other xmls */
+        return_value =3D mcd_arm_parse_general_xml_files(cpu, reggroups,
+            registers, &current_group_id);
+        if (return_value !=3D 0) {
+            g_assert_not_reached();
+        }
+        /* 4. add additional data the the regs from the xmls */
+        return_value =3D mcd_arm_get_additional_register_info(reggroups,
+            registers);
+        if (return_value !=3D 0) {
+            g_assert_not_reached();
+        }
+        /* 5. store all found data */
         if (g_list_nth(mcdserver_state.all_memspaces, cpu_id)) {
-            GList* memspaces_ptr =3D g_list_nth(mcdserver_state.all_memspa=
ces, cpu_id);
+            GList *memspaces_ptr =3D
+                g_list_nth(mcdserver_state.all_memspaces, cpu_id);
             memspaces_ptr->data =3D memspaces;
-        }
-        else {
-            mcdserver_state.all_memspaces =3D g_list_insert(mcdserver_stat=
e.all_memspaces, memspaces, cpu_id);
+        } else {
+            mcdserver_state.all_memspaces =3D
+                g_list_insert(mcdserver_state.all_memspaces, memspaces, cp=
u_id);
         }
         if (g_list_nth(mcdserver_state.all_reggroups, cpu_id)) {
-            GList* reggroups_ptr =3D g_list_nth(mcdserver_state.all_reggro=
ups, cpu_id);
+            GList *reggroups_ptr =3D
+                g_list_nth(mcdserver_state.all_reggroups, cpu_id);
             reggroups_ptr->data =3D reggroups;
-        }
-        else {
-            mcdserver_state.all_reggroups =3D g_list_insert(mcdserver_stat=
e.all_reggroups, reggroups, cpu_id);
+        } else {
+            mcdserver_state.all_reggroups =3D
+                g_list_insert(mcdserver_state.all_reggroups, reggroups, cp=
u_id);
         }
         if (g_list_nth(mcdserver_state.all_registers, cpu_id)) {
-            GList* registers_ptr =3D g_list_nth(mcdserver_state.all_regist=
ers, cpu_id);
+            GList *registers_ptr =3D
+                g_list_nth(mcdserver_state.all_registers, cpu_id);
             registers_ptr->data =3D registers;
+        } else {
+            mcdserver_state.all_registers =3D
+                g_list_insert(mcdserver_state.all_registers, registers, cp=
u_id);
         }
-        else {
-            mcdserver_state.all_registers =3D g_list_insert(mcdserver_stat=
e.all_registers, registers, cpu_id);
-        }
-    }
-    else {
-        // we don't support other architectures
-        assert(0);
+    } else {
+        /* we don't support other architectures */
+        g_assert_not_reached();
     }
=20
     g_free(arch);
 }
=20
-void handle_query_reset_f(GArray *params, void *user_ctx) {
-    // TODO: vull reset over the qemu monitor
-=20=20=20=20
-    // 1. check length
+void handle_query_reset_f(GArray *params, void *user_ctx)
+{
+    /* TODO: vull reset over the qemu monitor */
+
+    /* 1. check length */
     int nb_resets =3D mcdserver_state.resets->len;
     if (nb_resets =3D=3D 1) {
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
     mcd_reset_st reset =3D g_array_index(mcdserver_state.resets, mcd_reset=
_st, 0);
-    g_string_append_printf(mcdserver_state.str_buf, "%s=3D%s.%s=3D%d.", TC=
P_ARGUMENT_NAME, reset.name, TCP_ARGUMENT_ID, reset.id);
+    g_string_append_printf(mcdserver_state.str_buf, "%s=3D%s.%s=3D%d.",
+        TCP_ARGUMENT_NAME, reset.name, TCP_ARGUMENT_ID, reset.id);
     mcd_put_strbuf();
 }
=20
-void handle_query_reset_c(GArray *params, void *user_ctx) {
-    // reset options are the same for every cpu!
+void handle_query_reset_c(GArray *params, void *user_ctx)
+{
+    /* reset options are the same for every cpu! */
     int query_index =3D get_param(params, 0)->query_handle;
-=20=20=20=20
-    // 1. check weather this was the last mem space
+
+    /* 1. check weather this was the last mem space */
     int nb_groups =3D mcdserver_state.resets->len;
-    if (query_index+1 =3D=3D nb_groups) {
-        // indicates this is the last packet
+    if (query_index + 1 =3D=3D nb_groups) {
+        /* indicates this is the last packet */
         g_string_printf(mcdserver_state.str_buf, "0!");
-    }
-    else {
-        g_string_printf(mcdserver_state.str_buf, "%d!", query_index+1);
+    } else {
+        g_string_printf(mcdserver_state.str_buf, "%d!", query_index + 1);
     }
=20
-    // 2. send data
-    mcd_reset_st reset =3D g_array_index(mcdserver_state.resets, mcd_reset=
_st, query_index);
-    g_string_append_printf(mcdserver_state.str_buf, "%s=3D%s.%s=3D%d.", TC=
P_ARGUMENT_NAME, reset.name, TCP_ARGUMENT_ID, reset.id);
+    /* 2. send data */
+    mcd_reset_st reset =3D g_array_index(mcdserver_state.resets,
+        mcd_reset_st, query_index);
+    g_string_append_printf(mcdserver_state.str_buf, "%s=3D%s.%s=3D%d.",
+        TCP_ARGUMENT_NAME, reset.name, TCP_ARGUMENT_ID, reset.id);
     mcd_put_strbuf();
 }
=20
-void handle_close_core(GArray *params, void *user_ctx) {
-    // free memory for correct core
+void handle_close_core(GArray *params, void *user_ctx)
+{
+    /* free memory for correct core */
     uint32_t cpu_id =3D get_param(params, 0)->cpu_id;
-    GArray* memspaces =3D g_list_nth_data(mcdserver_state.all_memspaces, c=
pu_id);
-    mcdserver_state.all_memspaces =3D g_list_remove(mcdserver_state.all_me=
mspaces, memspaces);
+    GArray *memspaces =3D g_list_nth_data(mcdserver_state.all_memspaces, c=
pu_id);
+    mcdserver_state.all_memspaces =3D
+        g_list_remove(mcdserver_state.all_memspaces, memspaces);
     g_array_free(memspaces, TRUE);
-    GArray* reggroups =3D g_list_nth_data(mcdserver_state.all_reggroups, c=
pu_id);
-    mcdserver_state.all_reggroups =3D g_list_remove(mcdserver_state.all_re=
ggroups, reggroups);
+    GArray *reggroups =3D g_list_nth_data(mcdserver_state.all_reggroups, c=
pu_id);
+    mcdserver_state.all_reggroups =3D
+        g_list_remove(mcdserver_state.all_reggroups, reggroups);
     g_array_free(reggroups, TRUE);
-    GArray* registers =3D g_list_nth_data(mcdserver_state.all_registers, c=
pu_id);
-    mcdserver_state.all_registers =3D g_list_remove(mcdserver_state.all_re=
gisters, registers);
+    GArray *registers =3D g_list_nth_data(mcdserver_state.all_registers, c=
pu_id);
+    mcdserver_state.all_registers =3D
+        g_list_remove(mcdserver_state.all_registers, registers);
     g_array_free(registers, TRUE);
 }
=20
-void handle_close_server(GArray *params, void *user_ctx) {
+void handle_close_server(GArray *params, void *user_ctx)
+{
     uint32_t pid =3D 1;
     MCDProcess *process =3D mcd_get_process(pid);
=20
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
=20
-    // 2. detach
+    /* 2. detach */
     process->attached =3D false;
=20
-    // 3. reset process
+    /* 3. reset process */
     if (pid =3D=3D mcd_get_cpu_pid(mcdserver_state.c_cpu)) {
         mcdserver_state.c_cpu =3D mcd_first_attached_cpu();
     }
     if (!mcdserver_state.c_cpu) {
-        // no more processes attached
+        /* no more processes attached */
         mcd_disable_syscalls();
         mcd_vm_start();
     }
 }
=20
-void handle_query_trigger(GArray *params, void *user_ctx) {
+void handle_query_trigger(GArray *params, void *user_ctx)
+{
     mcd_trigger_st trigger =3D mcdserver_state.trigger;
     g_string_printf(mcdserver_state.str_buf, "%s=3D%d.%s=3D%d.%s=3D%d.%s=
=3D%d.",
-        TCP_ARGUMENT_AMOUNT_TRIGGER,  trigger.nr_trigger, TCP_ARGUMENT_TYP=
E, trigger.type,
-        TCP_ARGUMENT_OPTION, trigger.option, TCP_ARGUMENT_ACTION, trigger.=
action);
+        TCP_ARGUMENT_AMOUNT_TRIGGER, trigger.nr_trigger,
+        TCP_ARGUMENT_TYPE, trigger.type, TCP_ARGUMENT_OPTION, trigger.opti=
on,
+        TCP_ARGUMENT_ACTION, trigger.action);
     mcd_put_strbuf();
 }
=20
-void mcd_vm_start(void) {
+void mcd_vm_start(void)
+{
     if (!runstate_needs_reset() && !runstate_is_running()) {
         vm_start();
     }
 }
=20
-int mcd_vm_sstep(CPUState *cpu) {
+int mcd_vm_sstep(CPUState *cpu)
+{
     cpu_single_step(mcdserver_state.c_cpu, mcdserver_state.sstep_flags);
     mcd_vm_start();
     return 0;
 }
=20
-void mcd_vm_stop(void) {
+void mcd_vm_stop(void)
+{
     if (runstate_is_running()) {
         vm_stop(RUN_STATE_DEBUG);
     }
 }
=20
-void handle_query_mem_spaces_f(GArray *params, void *user_ctx) {
-    // 1. get correct memspaces and set the query_cpu
+void handle_query_mem_spaces_f(GArray *params, void *user_ctx)
+{
+    /* 1. get correct memspaces and set the query_cpu */
     uint32_t cpu_id =3D get_param(params, 0)->cpu_id;
     mcdserver_state.query_cpu_id =3D cpu_id;
-    GArray* memspaces =3D g_list_nth_data(mcdserver_state.all_memspaces, c=
pu_id);
+    GArray *memspaces =3D g_list_nth_data(mcdserver_state.all_memspaces, c=
pu_id);
=20
-    // 2. check length
+    /* 2. check length */
     int nb_groups =3D memspaces->len;
     if (nb_groups =3D=3D 1) {
-        // indicates this is the last packet
+        /* indicates this is the last packet */
         g_string_printf(mcdserver_state.str_buf, "0!");
-    }
-    else {
+    } else {
         g_string_printf(mcdserver_state.str_buf, "1!");
     }
=20
-    // 3. send data
+    /* 3. send data */
     mcd_mem_space_st space =3D g_array_index(memspaces, mcd_mem_space_st, =
0);
-    g_string_append_printf(mcdserver_state.str_buf, "%s=3D%s.%s=3D%d.%s=3D=
%d.%s=3D%d.%s=3D%d.%s=3D%d.%s=3D%ld.%s=3D%ld.%s=3D%d.",
-        TCP_ARGUMENT_NAME, space.name, TCP_ARGUMENT_ID, space.id, TCP_ARGU=
MENT_TYPE, space.type,
-        TCP_ARGUMENT_BITS_PER_MAU, space.bits_per_mau, TCP_ARGUMENT_INVARI=
ANCE, space.invariance, TCP_ARGUMENT_ENDIAN, space.endian,
-        TCP_ARGUMENT_MIN, space.min_addr, TCP_ARGUMENT_MAX, space.max_addr,
-        TCP_ARGUMENT_SUPPORTED_ACCESS_OPTIONS, space.supported_access_opti=
ons);
+    g_string_append_printf(mcdserver_state.str_buf,
+        "%s=3D%s.%s=3D%d.%s=3D%d.%s=3D%d.%s=3D%d.%s=3D%d.%s=3D%ld.%s=3D%ld=
.%s=3D%d.",
+        TCP_ARGUMENT_NAME, space.name, TCP_ARGUMENT_ID, space.id,
+        TCP_ARGUMENT_TYPE, space.type, TCP_ARGUMENT_BITS_PER_MAU,
+        space.bits_per_mau, TCP_ARGUMENT_INVARIANCE, space.invariance,
+        TCP_ARGUMENT_ENDIAN, space.endian, TCP_ARGUMENT_MIN, space.min_add=
r,
+        TCP_ARGUMENT_MAX, space.max_addr, TCP_ARGUMENT_SUPPORTED_ACCESS_OP=
TIONS,
+        space.supported_access_options);
     mcd_put_strbuf();
 }
=20
-void handle_query_mem_spaces_c(GArray *params, void *user_ctx) {
-    // this funcitons send all mem spaces except for the first
-    // 1. get parameter and memspace
+void handle_query_mem_spaces_c(GArray *params, void *user_ctx)
+{
+    /*
+     * this funcitons send all mem spaces except for the first
+     * 1. get parameter and memspace
+     */
     int query_index =3D get_param(params, 0)->query_handle;
     uint32_t cpu_id =3D mcdserver_state.query_cpu_id;
-    GArray* memspaces =3D g_list_nth_data(mcdserver_state.all_memspaces, c=
pu_id);
+    GArray *memspaces =3D g_list_nth_data(mcdserver_state.all_memspaces, c=
pu_id);
=20
-    // 2. check weather this was the last mem space
+    /* 2. check weather this was the last mem space */
     int nb_groups =3D memspaces->len;
-    if (query_index+1 =3D=3D nb_groups) {
-        // indicates this is the last packet
+    if (query_index + 1 =3D=3D nb_groups) {
+        /* indicates this is the last packet */
         g_string_printf(mcdserver_state.str_buf, "0!");
-    }
-    else {
-        g_string_printf(mcdserver_state.str_buf, "%d!", query_index+1);
-    }
-
-    // 3. send the correct memspace
-    mcd_mem_space_st space =3D g_array_index(memspaces, mcd_mem_space_st, =
query_index);
-    g_string_append_printf(mcdserver_state.str_buf, "%s=3D%s.%s=3D%d.%s=3D=
%d.%s=3D%d.%s=3D%d.%s=3D%d.%s=3D%ld.%s=3D%ld.%s=3D%d.",
-        TCP_ARGUMENT_NAME, space.name, TCP_ARGUMENT_ID, space.id, TCP_ARGU=
MENT_TYPE, space.type,
-        TCP_ARGUMENT_BITS_PER_MAU, space.bits_per_mau, TCP_ARGUMENT_INVARI=
ANCE, space.invariance, TCP_ARGUMENT_ENDIAN, space.endian,
-        TCP_ARGUMENT_MIN, space.min_addr, TCP_ARGUMENT_MAX, space.max_addr,
-        TCP_ARGUMENT_SUPPORTED_ACCESS_OPTIONS, space.supported_access_opti=
ons);
+    } else {
+        g_string_printf(mcdserver_state.str_buf, "%d!", query_index + 1);
+    }
+
+    /* 3. send the correct memspace */
+    mcd_mem_space_st space =3D g_array_index(memspaces,
+        mcd_mem_space_st, query_index);
+    g_string_append_printf(mcdserver_state.str_buf,
+        "%s=3D%s.%s=3D%d.%s=3D%d.%s=3D%d.%s=3D%d.%s=3D%d.%s=3D%ld.%s=3D%ld=
.%s=3D%d.",
+        TCP_ARGUMENT_NAME, space.name, TCP_ARGUMENT_ID,
+        space.id, TCP_ARGUMENT_TYPE, space.type, TCP_ARGUMENT_BITS_PER_MAU,
+        space.bits_per_mau, TCP_ARGUMENT_INVARIANCE, space.invariance,
+        TCP_ARGUMENT_ENDIAN, space.endian, TCP_ARGUMENT_MIN, space.min_add=
r,
+        TCP_ARGUMENT_MAX, space.max_addr, TCP_ARGUMENT_SUPPORTED_ACCESS_OP=
TIONS,
+        space.supported_access_options);
     mcd_put_strbuf();
 }
=20
-void handle_query_reg_groups_f(GArray *params, void *user_ctx) {
-    // 1. get correct reggroups and set the query_cpu
+void handle_query_reg_groups_f(GArray *params, void *user_ctx)
+{
+    /* 1. get correct reggroups and set the query_cpu */
     uint32_t cpu_id =3D get_param(params, 0)->cpu_id;
     mcdserver_state.query_cpu_id =3D cpu_id;
-    GArray* reggroups =3D g_list_nth_data(mcdserver_state.all_reggroups, c=
pu_id);
+    GArray *reggroups =3D g_list_nth_data(mcdserver_state.all_reggroups, c=
pu_id);
=20
-    // 2. check length
+    /* 2. check length */
     int nb_groups =3D reggroups->len;
     if (nb_groups =3D=3D 1) {
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
     mcd_reg_group_st group =3D g_array_index(reggroups, mcd_reg_group_st, =
0);
-    g_string_append_printf(mcdserver_state.str_buf, "%s=3D%d.%s=3D%s.", TC=
P_ARGUMENT_ID, group.id, TCP_ARGUMENT_NAME, group.name);
+    g_string_append_printf(mcdserver_state.str_buf, "%s=3D%d.%s=3D%s.",
+        TCP_ARGUMENT_ID, group.id, TCP_ARGUMENT_NAME, group.name);
     mcd_put_strbuf();
 }
=20
-void handle_query_reg_groups_c(GArray *params, void *user_ctx) {
-    // this funcitons send all reg groups except for the first
-    // 1. get parameter and memspace
+void handle_query_reg_groups_c(GArray *params, void *user_ctx)
+{
+    /*
+     * this funcitons send all reg groups except for the first
+     * 1. get parameter and memspace
+     */
     int query_index =3D get_param(params, 0)->query_handle;
     uint32_t cpu_id =3D mcdserver_state.query_cpu_id;
-    GArray* reggroups =3D g_list_nth_data(mcdserver_state.all_reggroups, c=
pu_id);
+    GArray *reggroups =3D g_list_nth_data(mcdserver_state.all_reggroups, c=
pu_id);
=20
-    // 2. check weather this was the last reg group
+    /* 2. check weather this was the last reg group */
     int nb_groups =3D reggroups->len;
-    if (query_index+1 =3D=3D nb_groups) {
-        // indicates this is the last packet
+    if (query_index + 1 =3D=3D nb_groups) {
+        /* indicates this is the last packet */
         g_string_printf(mcdserver_state.str_buf, "0!");
-    }
-    else {
-        g_string_printf(mcdserver_state.str_buf, "%d!", query_index+1);
+    } else {
+        g_string_printf(mcdserver_state.str_buf, "%d!", query_index + 1);
     }
=20
-    // 3. send the correct reggroup
-    mcd_reg_group_st group =3D g_array_index(reggroups, mcd_reg_group_st, =
query_index);
-    g_string_append_printf(mcdserver_state.str_buf, "%s=3D%d.%s=3D%s.", TC=
P_ARGUMENT_ID, group.id, TCP_ARGUMENT_NAME, group.name);
+    /* 3. send the correct reggroup */
+    mcd_reg_group_st group =3D g_array_index(reggroups, mcd_reg_group_st,
+        query_index);
+    g_string_append_printf(mcdserver_state.str_buf, "%s=3D%d.%s=3D%s.",
+        TCP_ARGUMENT_ID, group.id, TCP_ARGUMENT_NAME, group.name);
     mcd_put_strbuf();
 }
=20
-void handle_query_regs_f(GArray *params, void *user_ctx) {
-    // 1. get correct registers and set the query_cpu
+void handle_query_regs_f(GArray *params, void *user_ctx)
+{
+    /* 1. get correct registers and set the query_cpu */
     uint32_t cpu_id =3D get_param(params, 0)->cpu_id;
     mcdserver_state.query_cpu_id =3D cpu_id;
-    GArray* registers =3D g_list_nth_data(mcdserver_state.all_registers, c=
pu_id);
+    GArray *registers =3D g_list_nth_data(mcdserver_state.all_registers, c=
pu_id);
=20
-    // 2. check length
+    /* 2. check length */
     int nb_regs =3D registers->len;
     if (nb_regs =3D=3D 1) {
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
     mcd_reg_st my_register =3D g_array_index(registers, mcd_reg_st, 0);
-    g_string_append_printf(mcdserver_state.str_buf, "%s=3D%d.%s=3D%s.%s=3D=
%d.%s=3D%d.%s=3D%d.%s=3D%d.%s=3D%d.",
-        TCP_ARGUMENT_ID, my_register.id, TCP_ARGUMENT_NAME,  my_register.n=
ame, TCP_ARGUMENT_SIZE, my_register.bitsize,
-        TCP_ARGUMENT_REGGROUPID, my_register.mcd_reg_group_id, TCP_ARGUMEN=
T_MEMSPACEID, my_register.mcd_mem_space_id,
-        TCP_ARGUMENT_TYPE, my_register.mcd_reg_type, TCP_ARGUMENT_THREAD, =
my_register.mcd_hw_thread_id);
+    g_string_append_printf(mcdserver_state.str_buf,
+        "%s=3D%d.%s=3D%s.%s=3D%d.%s=3D%d.%s=3D%d.%s=3D%d.%s=3D%d.",
+        TCP_ARGUMENT_ID, my_register.id, TCP_ARGUMENT_NAME,
+        my_register.name, TCP_ARGUMENT_SIZE, my_register.bitsize,
+        TCP_ARGUMENT_REGGROUPID, my_register.mcd_reg_group_id,
+        TCP_ARGUMENT_MEMSPACEID, my_register.mcd_mem_space_id,
+        TCP_ARGUMENT_TYPE, my_register.mcd_reg_type,
+        TCP_ARGUMENT_THREAD, my_register.mcd_hw_thread_id);
     mcd_put_strbuf();
 }
=20
-void handle_query_regs_c(GArray *params, void *user_ctx) {
-    // this funcitons send all regs except for the first
-    // 1. get parameter and registers
+void handle_query_regs_c(GArray *params, void *user_ctx)
+{
+    /*
+     * this funcitons send all regs except for the first
+     * 1. get parameter and registers
+     */
     int query_index =3D get_param(params, 0)->query_handle;
     uint32_t cpu_id =3D mcdserver_state.query_cpu_id;
-    GArray* registers =3D g_list_nth_data(mcdserver_state.all_registers, c=
pu_id);
+    GArray *registers =3D g_list_nth_data(mcdserver_state.all_registers, c=
pu_id);
=20
-    // 2. check weather this was the last register
+    /* 2. check weather this was the last register */
     int nb_regs =3D registers->len;
-    if (query_index+1 =3D=3D nb_regs) {
-        // indicates this is the last packet
+    if (query_index + 1 =3D=3D nb_regs) {
+        /* indicates this is the last packet */
         g_string_printf(mcdserver_state.str_buf, "0!");
-    }
-    else {
-        g_string_printf(mcdserver_state.str_buf, "%d!", query_index+1);
+    } else {
+        g_string_printf(mcdserver_state.str_buf, "%d!", query_index + 1);
     }
=20
-    // 3. send the correct register
+    /* 3. send the correct register */
     mcd_reg_st my_register =3D g_array_index(registers, mcd_reg_st, query_=
index);
-    g_string_append_printf(mcdserver_state.str_buf, "%s=3D%d.%s=3D%s.%s=3D=
%d.%s=3D%d.%s=3D%d.%s=3D%d.%s=3D%d.",
-        TCP_ARGUMENT_ID, my_register.id, TCP_ARGUMENT_NAME,  my_register.n=
ame, TCP_ARGUMENT_SIZE, my_register.bitsize,
-        TCP_ARGUMENT_REGGROUPID, my_register.mcd_reg_group_id, TCP_ARGUMEN=
T_MEMSPACEID, my_register.mcd_mem_space_id,
-        TCP_ARGUMENT_TYPE, my_register.mcd_reg_type, TCP_ARGUMENT_THREAD, =
my_register.mcd_hw_thread_id);
+    g_string_append_printf(mcdserver_state.str_buf,
+        "%s=3D%d.%s=3D%s.%s=3D%d.%s=3D%d.%s=3D%d.%s=3D%d.%s=3D%d.",
+        TCP_ARGUMENT_ID, my_register.id, TCP_ARGUMENT_NAME,
+        my_register.name, TCP_ARGUMENT_SIZE, my_register.bitsize,
+        TCP_ARGUMENT_REGGROUPID, my_register.mcd_reg_group_id,
+        TCP_ARGUMENT_MEMSPACEID, my_register.mcd_mem_space_id,
+        TCP_ARGUMENT_TYPE, my_register.mcd_reg_type,
+        TCP_ARGUMENT_THREAD, my_register.mcd_hw_thread_id);
     mcd_put_strbuf();
 }
=20
-void handle_reset(GArray *params, void *user_ctx) {
-    //int reset_id =3D get_param(params, 0)->data_int;
-    // TODO: implement resets
+void handle_reset(GArray *params, void *user_ctx)
+{
+    /*
+     * int reset_id =3D get_param(params, 0)->data_int;
+     * TODO: implement resets
+     */
 }
=20
-void handle_query_state(GArray *params, void *user_ctx) {
-    // TODO: multicore support
-    // get state info
+void handle_query_state(GArray *params, void *user_ctx)
+{
+    /*
+     * TODO: multicore support
+     * get state info
+     */
     mcd_cpu_state_st state_info =3D mcdserver_state.cpu_state;
     mcd_core_event_et event =3D MCD_CORE_EVENT_NONE;
     if (state_info.memory_changed) {
@@ -1674,42 +1805,47 @@ void handle_query_state(GArray *params, void *user_=
ctx) {
         event =3D event | MCD_CORE_EVENT_STOPPED;
         state_info.target_was_stopped =3D false;
     }
-    // send data
-    g_string_printf(mcdserver_state.str_buf, "%s=3D%s.%s=3D%d.%s=3D%d.%s=
=3D%d.%s=3D%s.%s=3D%s.", TCP_ARGUMENT_STATE, state_info.state,
-        TCP_ARGUMENT_EVENT, event, TCP_ARGUMENT_THREAD, 0, TCP_ARGUMENT_TR=
IGGER_ID, state_info.trig_id,
-        TCP_ARGUMENT_STOP_STRING, state_info.stop_str, TCP_ARGUMENT_INFO_S=
TRING, state_info.info_str);
+    /* send data */
+    g_string_printf(mcdserver_state.str_buf,
+        "%s=3D%s.%s=3D%d.%s=3D%d.%s=3D%d.%s=3D%s.%s=3D%s.",
+        TCP_ARGUMENT_STATE, state_info.state,
+        TCP_ARGUMENT_EVENT, event, TCP_ARGUMENT_THREAD, 0,
+        TCP_ARGUMENT_TRIGGER_ID, state_info.trig_id,
+        TCP_ARGUMENT_STOP_STRING, state_info.stop_str,
+        TCP_ARGUMENT_INFO_STRING, state_info.info_str);
     mcd_put_strbuf();
 }
=20
-int mcd_read_register(CPUState *cpu, GByteArray *buf, int reg) {
+int mcd_read_register(CPUState *cpu, GByteArray *buf, int reg)
+{
     CPUClass *cc =3D CPU_GET_CLASS(cpu);
     gchar *arch =3D cc->gdb_arch_name(cpu);
-    if (strcmp(arch, "arm")=3D=3D0) {
+    if (strcmp(arch, "arm") =3D=3D 0) {
         g_free(arch);
         return arm_mcd_read_register(cpu, buf, reg);
-    }
-    else {
+    } else {
         g_free(arch);
         return 0;
     }
 }
=20
-int mcd_write_register(CPUState *cpu, GByteArray *buf, int reg) {
+int mcd_write_register(CPUState *cpu, GByteArray *buf, int reg)
+{
     CPUClass *cc =3D CPU_GET_CLASS(cpu);
     gchar *arch =3D cc->gdb_arch_name(cpu);
-    if (strcmp(arch, "arm")=3D=3D0) {
+    if (strcmp(arch, "arm") =3D=3D 0) {
         g_free(arch);
         return arm_mcd_write_register(cpu, buf, reg);
-    }
-    else {
+    } else {
         g_free(arch);
         return 0;
     }
 }
=20
-void mcd_memtohex(GString *buf, const uint8_t *mem, int len) {
+void mcd_memtohex(GString *buf, const uint8_t *mem, int len)
+{
     int i, c;
-    for(i =3D 0; i < len; i++) {
+    for (i =3D 0; i < len; i++) {
         c =3D mem[i];
         g_string_append_c(buf, tohex(c >> 4));
         g_string_append_c(buf, tohex(c & 0xf));
@@ -1717,45 +1853,50 @@ void mcd_memtohex(GString *buf, const uint8_t *mem,=
 int len) {
     g_string_append_c(buf, '\0');
 }
=20
-void mcd_hextomem(GByteArray *mem, const char *buf, int len) {
+void mcd_hextomem(GByteArray *mem, const char *buf, int len)
+{
     int i;
=20
-    for(i =3D 0; i < len; i++) {
+    for (i =3D 0; i < len; i++) {
         guint8 byte =3D fromhex(buf[0]) << 4 | fromhex(buf[1]);
         g_byte_array_append(mem, &byte, 1);
         buf +=3D 2;
     }
 }
=20
-void handle_read_register(GArray *params, void *user_ctx) {
+void handle_read_register(GArray *params, void *user_ctx)
+{
     uint32_t cpu_id =3D get_param(params, 0)->cpu_id;
     uint64_t reg_num =3D get_param(params, 1)->data_int;
     int reg_size;
=20
     CPUState *cpu =3D mcd_get_cpu(cpu_id);
     reg_size =3D mcd_read_register(cpu, mcdserver_state.mem_buf, reg_num);
-    mcd_memtohex(mcdserver_state.str_buf, mcdserver_state.mem_buf->data, r=
eg_size);
+    mcd_memtohex(mcdserver_state.str_buf,
+        mcdserver_state.mem_buf->data, reg_size);
     mcd_put_strbuf();
 }
=20
-void handle_write_register(GArray *params, void *user_ctx) {
+void handle_write_register(GArray *params, void *user_ctx)
+{
     uint32_t cpu_id =3D get_param(params, 0)->cpu_id;
     uint64_t reg_num =3D get_param(params, 1)->data_int;
     uint32_t reg_size =3D get_param(params, 2)->data_int;
=20
     CPUState *cpu =3D mcd_get_cpu(cpu_id);
-    mcd_hextomem(mcdserver_state.mem_buf, mcdserver_state.str_buf->str, re=
g_size);
-    if (mcd_write_register(cpu, mcdserver_state.mem_buf, reg_num)=3D=3D0) {
+    mcd_hextomem(mcdserver_state.mem_buf,
+        mcdserver_state.str_buf->str, reg_size);
+    if (mcd_write_register(cpu, mcdserver_state.mem_buf, reg_num) =3D=3D 0=
) {
         mcd_put_packet(TCP_EXECUTION_ERROR);
-    }
-    else {
+    } else {
         mcd_put_packet(TCP_EXECUTION_SUCCESS);
     }
 }
=20
-int mcd_read_memory(CPUState *cpu, hwaddr addr, uint8_t *buf, int len) {
+int mcd_read_memory(CPUState *cpu, hwaddr addr, uint8_t *buf, int len)
+{
     CPUClass *cc;
-    //TODO: add physical mem cpu_physical_memory_read(addr, buf, len);
+    /*TODO: add physical mem cpu_physical_memory_read(addr, buf, len); */
     cc =3D CPU_GET_CLASS(cpu);
     if (cc->memory_rw_debug) {
         return cc->memory_rw_debug(cpu, addr, buf, len, false);
@@ -1764,9 +1905,10 @@ int mcd_read_memory(CPUState *cpu, hwaddr addr, uint=
8_t *buf, int len) {
     return cpu_memory_rw_debug(cpu, addr, buf, len, false);
 }
=20
-int mcd_write_memory(CPUState *cpu, hwaddr addr, uint8_t *buf, int len) {
+int mcd_write_memory(CPUState *cpu, hwaddr addr, uint8_t *buf, int len)
+{
     CPUClass *cc;
-    //TODO: add physical mem cpu_physical_memory_read(addr, buf, len);
+    /*TODO: add physical mem cpu_physical_memory_read(addr, buf, len); */
     cc =3D CPU_GET_CLASS(cpu);
     if (cc->memory_rw_debug) {
         return cc->memory_rw_debug(cpu, addr, buf, len, true);
@@ -1775,33 +1917,36 @@ int mcd_write_memory(CPUState *cpu, hwaddr addr, ui=
nt8_t *buf, int len) {
     return cpu_memory_rw_debug(cpu, addr, buf, len, true);
 }
=20
-void handle_read_memory(GArray *params, void *user_ctx) {
+void handle_read_memory(GArray *params, void *user_ctx)
+{
     uint32_t cpu_id =3D get_param(params, 0)->cpu_id;
     uint64_t mem_address =3D get_param(params, 1)->data_uint64_t;
     int len =3D get_param(params, 2)->data_int;
=20
     CPUState *cpu =3D mcd_get_cpu(cpu_id);
     g_byte_array_set_size(mcdserver_state.mem_buf, len);
-    if (mcd_read_memory(cpu, mem_address, mcdserver_state.mem_buf->data, m=
cdserver_state.mem_buf->len)!=3D0) {
+    if (mcd_read_memory(cpu, mem_address, mcdserver_state.mem_buf->data,
+        mcdserver_state.mem_buf->len) !=3D 0) {
         mcd_put_packet(TCP_EXECUTION_ERROR);
-    }
-    else {
-        mcd_memtohex(mcdserver_state.str_buf, mcdserver_state.mem_buf->dat=
a, mcdserver_state.mem_buf->len);
+    } else {
+        mcd_memtohex(mcdserver_state.str_buf, mcdserver_state.mem_buf->dat=
a,
+            mcdserver_state.mem_buf->len);
         mcd_put_strbuf();
     }
 }
=20
-void handle_write_memory(GArray *params, void *user_ctx) {
+void handle_write_memory(GArray *params, void *user_ctx)
+{
     uint32_t cpu_id =3D get_param(params, 0)->cpu_id;
     uint64_t mem_address =3D get_param(params, 1)->data_uint64_t;
     int len =3D get_param(params, 2)->data_int;
=20
     CPUState *cpu =3D mcd_get_cpu(cpu_id);
     mcd_hextomem(mcdserver_state.mem_buf, mcdserver_state.str_buf->str, le=
n);
-    if (mcd_write_memory(cpu, mem_address, mcdserver_state.mem_buf->data, =
len)!=3D0) {
+    if (mcd_write_memory(cpu, mem_address,
+        mcdserver_state.mem_buf->data, len) !=3D 0) {
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
=20
 #define MAX_PACKET_LENGTH 1024
=20
-// trigger defines
+/* trigger defines */
 #define MCD_TRIG_OPT_DATA_IS_CONDITION 0x00000008
 #define MCD_TRIG_ACTION_DBG_DEBUG 0x00000001
=20
 typedef uint32_t mcd_trig_type_et;
-// TODO: replace mcd defines with custom layer
+/* TODO: replace mcd defines with custom layer */
 enum {
-	MCD_TRIG_TYPE_UNDEFINED =3D 0x00000000, /**< Undefined trigger type.     =
                                              */
-	MCD_TRIG_TYPE_IP        =3D 0x00000001, /**< Trigger on a changing instru=
ction pointer.                                */
-	MCD_TRIG_TYPE_READ      =3D 0x00000002, /**< Trigger on a read data acces=
s to a specific address or address range.     */
-	MCD_TRIG_TYPE_WRITE     =3D 0x00000004, /**< Trigger on a write data acce=
ss to a specific address or address range.    */
-	MCD_TRIG_TYPE_RW        =3D 0x00000008, /**< Trigger on a read or a write=
 data access to a specific address or
-		   address range.                                                       =
     */
-	MCD_TRIG_TYPE_NOCYCLE   =3D 0x00000010, /**< Trigger on core information =
other than an IP or data compare trigger.     */
-	MCD_TRIG_TYPE_TRIG_BUS  =3D 0x00000020, /**< Trigger on a trigger bus com=
bination.                                     */
-	MCD_TRIG_TYPE_COUNTER   =3D 0x00000040, /**< Trigger on an elapsed trigge=
r counter.                                    */
-	MCD_TRIG_TYPE_CUSTOM    =3D 0x00000080, /**< Custom trigger using standar=
d format as defined by \ref mcd_trig_custom_st. */
-	MCD_TRIG_TYPE_CUSTOM_LO =3D 0x00010000, /**< Begin Range: User defined tr=
igger types.                                  */
-	MCD_TRIG_TYPE_CUSTOM_HI =3D 0x40000000, /**< End   Range: User defined tr=
igger types.                                  */
+    MCD_TRIG_TYPE_UNDEFINED =3D 0x00000000,
+    MCD_TRIG_TYPE_IP        =3D 0x00000001,
+    MCD_TRIG_TYPE_READ      =3D 0x00000002,
+    MCD_TRIG_TYPE_WRITE     =3D 0x00000004,
+    MCD_TRIG_TYPE_RW        =3D 0x00000008,
+    MCD_TRIG_TYPE_NOCYCLE   =3D 0x00000010,
+    MCD_TRIG_TYPE_TRIG_BUS  =3D 0x00000020,
+    MCD_TRIG_TYPE_COUNTER   =3D 0x00000040,
+    MCD_TRIG_TYPE_CUSTOM    =3D 0x00000080,
+    MCD_TRIG_TYPE_CUSTOM_LO =3D 0x00010000,
+    MCD_TRIG_TYPE_CUSTOM_HI =3D 0x40000000,
 };
=20
 typedef uint32_t mcd_core_event_et;
-// TODO: replace mcd defines with custom layer
+/* TODO: replace mcd defines with custom layer */
 enum {
-	MCD_CORE_EVENT_NONE            =3D 0x00000000,   /**< No since the last p=
oll.                                 */
-	MCD_CORE_EVENT_MEMORY_CHANGE   =3D 0x00000001,   /**< Memory content has =
changed.                             */
-	MCD_CORE_EVENT_REGISTER_CHANGE =3D 0x00000002,   /**< Register contents h=
ave changed.                         */
-	MCD_CORE_EVENT_TRACE_CHANGE    =3D 0x00000004,   /**< Trace contents or s=
tates have changed.                  */
-	MCD_CORE_EVENT_TRIGGER_CHANGE  =3D 0x00000008,   /**< Triggers or trigger=
 states have changed.                */
-	MCD_CORE_EVENT_STOPPED         =3D 0x00000010,   /**< Target was stopped =
at least once since the last poll,
-		it may already be running again.                        */
-	MCD_CORE_EVENT_CHL_PENDING     =3D 0x00000020,   /**< A target communicat=
ion channel request from the target
-		is pending.                                             */
-	MCD_CORE_EVENT_CUSTOM_LO       =3D 0x00010000,   /**< Begin Range: User d=
efined core events.                  */
-	MCD_CORE_EVENT_CUSTOM_HI       =3D 0x40000000,   /**< End   Range: User d=
efined core events.                  */
+    MCD_CORE_EVENT_NONE            =3D 0x00000000,
+    MCD_CORE_EVENT_MEMORY_CHANGE   =3D 0x00000001,
+    MCD_CORE_EVENT_REGISTER_CHANGE =3D 0x00000002,
+    MCD_CORE_EVENT_TRACE_CHANGE    =3D 0x00000004,
+    MCD_CORE_EVENT_TRIGGER_CHANGE  =3D 0x00000008,
+    MCD_CORE_EVENT_STOPPED         =3D 0x00000010,
+    MCD_CORE_EVENT_CHL_PENDING     =3D 0x00000020,
+    MCD_CORE_EVENT_CUSTOM_LO       =3D 0x00010000,
+    MCD_CORE_EVENT_CUSTOM_HI       =3D 0x40000000,
 };
=20
-// schema defines
+/* schema defines */
 #define ARG_SCHEMA_QRYHANDLE 'q'
 #define ARG_SCHEMA_STRING 's'
 #define ARG_SCHEMA_INT 'd'
@@ -54,20 +51,20 @@ enum {
 #define ARG_SCHEMA_CORENUM 'c'
 #define ARG_SCHEMA_HEXDATA 'h'
=20
-// resets
+/* resets */
 #define RESET_SYSTEM "full_system_reset"
 #define RESET_GPR "gpr_reset"
 #define RESET_MEMORY "memory_reset"
=20
-// misc
-#define QUERY_TOTAL_NUMBER 12=20
+/* misc */
+#define QUERY_TOTAL_NUMBER 12
 #define CMD_SCHEMA_LENGTH 5
 #define MCD_SYSTEM_NAME "qemu-system"
=20
-// tcp query packet values templates
+/* tcp query packet values templates */
 #define DEVICE_NAME_TEMPLATE(s) "qemu-" #s "-device"
=20
-// state strings
+/* state strings */
 #define STATE_STR_UNKNOWN(d) "cpu " #d " in unknown state"
 #define STATE_STR_DEBUG(d) "cpu " #d " in debug state"
 #define STATE_STR_RUNNING(d) "cpu " #d " running"
@@ -82,7 +79,7 @@ enum {
 #define STATE_STR_BREAK_UNKNOWN "stopped for unknown reason"
=20
 typedef struct GDBRegisterState {
-    // needed for the used gdb functions
+    /* needed for the used gdb functions */
     int base_reg;
     int num_regs;
     gdb_get_reg_cb get_reg;
@@ -193,22 +190,22 @@ typedef struct xml_attrib {
 } xml_attrib;
=20
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
=20
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
-int process_string_cmd(void *user_ctx, const char *data, const MCDCmdParse=
Entry *cmds, int num_cmds);
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
@@ -312,20 +310,22 @@ int mcd_write_register(CPUState *cpu, GByteArray *buf=
, int reg);
 int mcd_read_memory(CPUState *cpu, hwaddr addr, uint8_t *buf, int len);
 int mcd_write_memory(CPUState *cpu, hwaddr addr, uint8_t *buf, int len);
=20
-// arm specific functions
-int mcd_arm_store_mem_spaces(CPUState *cpu, GArray* memspaces);
-int mcd_arm_parse_core_xml_file(CPUClass *cc, GArray* reggroups, GArray* r=
egisters, int* current_group_id);
-int mcd_arm_parse_general_xml_files(CPUState *cpu, GArray* reggroups, GArr=
ay* registers, int* current_group_id);
-int mcd_arm_get_additional_register_info(GArray* reggroups, GArray* regist=
ers);
+/* arm specific functions */
+int mcd_arm_store_mem_spaces(CPUState *cpu, GArray *memspaces);
+int mcd_arm_parse_core_xml_file(CPUClass *cc, GArray *reggroups,
+    GArray *registers, int *current_group_id);
+int mcd_arm_parse_general_xml_files(CPUState *cpu, GArray* reggroups,
+    GArray *registers, int *current_group_id);
+int mcd_arm_get_additional_register_info(GArray *reggroups, GArray *regist=
ers);
=20
-// sycall handling
+/* sycall handling */
 void mcd_syscall_reset(void);
 void mcd_disable_syscalls(void);
=20
-// helpers
+/* helpers */
 int int_cmp(gconstpointer a, gconstpointer b);
 void mcd_memtohex(GString *buf, const uint8_t *mem, int len);
 void mcd_hextomem(GByteArray *mem, const char *buf, int len);
-uint64_t atouint64_t(const char* in);
+uint64_t atouint64_t(const char *in);
=20
 #endif /* MCDSTUB_INTERNALS_H */
diff --git a/mcdstub/meson.build b/mcdstub/meson.build
index f17e2f3e89..ebd47b0725 100644
--- a/mcdstub/meson.build
+++ b/mcdstub/meson.build
@@ -7,19 +7,21 @@
 # We need to build the core mcd code via a library to be able to tweak
 # cflags so:
=20
-mcd_softmmu_ss =3D ss.source_set()
+mcd_system_ss =3D ss.source_set()
=20
-# We build one version of the mcdstub, because it only needs to work for s=
ystem emulation
-mcd_softmmu_ss.add(files('mcdstub.c'))
+# We build one version of the mcdstub,
+#because it only needs to work for system emulation
+mcd_system_ss.add(files('mcdstub.c'))
=20
-mcd_softmmu_ss =3D mcd_softmmu_ss.apply(config_host, strict: false)
+mcd_system_ss =3D mcd_system_ss.apply(config_host, strict: false)
=20
 libmcd_softmmu =3D static_library('mcd_softmmu',
-                                mcd_softmmu_ss.sources() + genh,
-                                name_suffix: 'fa')
+                                mcd_system_ss.sources() + genh,
+                                name_suffix: 'fa',
+                                build_by_default: have_system)
=20
 mcd_softmmu =3D declare_dependency(link_whole: libmcd_softmmu)
-softmmu_ss.add(mcd_softmmu)
+system_ss.add(mcd_softmmu)
=20
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
         cpu->stopped =3D true;
     }
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 2d66f612a7..085a312f9d 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -2663,9 +2663,9 @@ static void qemu_machine_creation_done(void)
     if (foreach_device_config(DEV_GDB, gdbserver_start) < 0) {
         exit(1);
     }
-=20=20=20=20
+
     if (foreach_device_config(DEV_MCD, mcdserver_start) < 0) {
-        /*=20
+        /*
          * starts the mcdserver if the mcd option was set
          */
         exit(1);
diff --git a/target/arm/mcdstub.c b/target/arm/mcdstub.c
index 27e1a13b69..e4e632d3f3 100644
--- a/target/arm/mcdstub.c
+++ b/target/arm/mcdstub.c
@@ -8,8 +8,10 @@
=20
 static inline int mcd_get_reg32(GByteArray *buf, uint32_t val)
 {
-    //TODO: move this to a separate file
-    // convert endianess if necessary
+    /*
+     *TODO: move this to a separate file
+     *convert endianess if necessary
+     */
     uint32_t to_long =3D tswap32(val);
     g_byte_array_append(buf, (uint8_t *) &to_long, 4);
     return 4;
@@ -17,7 +19,7 @@ static inline int mcd_get_reg32(GByteArray *buf, uint32_t=
 val)
=20
 static inline int mcd_get_zeroes(GByteArray *array, size_t len)
 {
-    //TODO: move this to a separate file
+    /*TODO: move this to a separate file */
     guint oldlen =3D array->len;
     g_byte_array_set_size(array, oldlen + len);
     memset(array->data + oldlen, 0, len);
@@ -43,7 +45,8 @@ const char *arm_mcd_get_dynamic_xml(CPUState *cs, const c=
har *xmlname)
     return NULL;
 }
=20
-int arm_mcd_read_register(CPUState *cs, GByteArray *mem_buf, int n) {
+int arm_mcd_read_register(CPUState *cs, GByteArray *mem_buf, int n)
+{
     ARMCPU *cpu =3D ARM_CPU(cs);
     CPUARMState *env =3D &cpu->env;
=20
@@ -52,12 +55,12 @@ int arm_mcd_read_register(CPUState *cs, GByteArray *mem=
_buf, int n) {
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
@@ -67,17 +70,18 @@ int arm_mcd_read_register(CPUState *cs, GByteArray *mem=
_buf, int n) {
             return mcd_get_reg32(mem_buf, cpsr_read(env));
         }
     }
-    //TODO: add funcitons for the remaining regs (including cp_regs)
+    /* TODO: add funcitons for the remaining regs (including cp_regs) */
     return 0;
 }
=20
-int arm_mcd_write_register(CPUState *cs, GByteArray *mem_buf, int n) {
+int arm_mcd_write_register(CPUState *cs, GByteArray *mem_buf, int n)
+{
     ARMCPU *cpu =3D ARM_CPU(cs);
     CPUARMState *env =3D &cpu->env;
     uint32_t tmp;
=20
     tmp =3D ldl_p(mem_buf);
-    tmp =3D *((uint32_t*)mem_buf->data);
+    tmp =3D *((uint32_t *)mem_buf->data);
=20
     /*
      * Mask out low bits of PC to workaround gdb bugs.
@@ -122,6 +126,6 @@ int arm_mcd_write_register(CPUState *cs, GByteArray *me=
m_buf, int n) {
         }
         return 4;
     }
-    //TODO: add funcitons for the remaining regs (including cp_regs)
+    /* TODO: add funcitons for the remaining regs (including cp_regs) */
     return 0;
 }
--=20
2.34.1


From 30dc5d9df62fdb38fb8fe7b06f0f84c8a614e18e Mon Sep 17 00:00:00 2001
From: Nicolas Eder <nicolas.eder@lauterbach.com>
Date: Mon, 10 Jul 2023 12:53:32 +0200
Subject: [PATCH 16/29] deleting the mcdd startup option

Signed-off-by: Nicolas Eder <nicolas.eder@lauterbach.com>
---
 mcdstub/meson.build | 10 +---------
 qemu-options.hx     | 13 +++----------
 2 files changed, 4 insertions(+), 19 deletions(-)

diff --git a/mcdstub/meson.build b/mcdstub/meson.build
index ebd47b0725..6b2f970eae 100644
--- a/mcdstub/meson.build
+++ b/mcdstub/meson.build
@@ -1,16 +1,9 @@
-#
-# The main gdbstub still relies on per-build definitions of various
-# types. The bits pushed to softmmu/user.c try to use guest agnostic
-# types such as hwaddr.
-#
-
 # We need to build the core mcd code via a library to be able to tweak
 # cflags so:
=20
 mcd_system_ss =3D ss.source_set()
=20
-# We build one version of the mcdstub,
-#because it only needs to work for system emulation
+# only system emulation is supported over mcd
 mcd_system_ss.add(files('mcdstub.c'))
=20
 mcd_system_ss =3D mcd_system_ss.apply(config_host, strict: false)
@@ -23,5 +16,4 @@ libmcd_softmmu =3D static_library('mcd_softmmu',
 mcd_softmmu =3D declare_dependency(link_whole: libmcd_softmmu)
 system_ss.add(mcd_softmmu)
=20
-# this might cause problems because we don't support user mode
 common_ss.add(files('mcd_syscalls.c'))
diff --git a/qemu-options.hx b/qemu-options.hx
index 0c15125b92..0b72c2de07 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4417,7 +4417,8 @@ ERST
 DEF("mcd", HAS_ARG, QEMU_OPTION_mcd, \
     "-mcd dev        accept mcd connection on 'dev'. (QEMU defaults to sta=
rting\n"
     "                the guest without waiting for a mcd client to connect=
; use -S too\n"
-    "                if you want it to not start execution.)\n",
+    "                if you want it to not start execution.)\n"
+    "                To use the default Port write '-mcd default'\n",
     QEMU_ARCH_ALL)
 SRST
 ``-mcd dev``
@@ -4428,15 +4429,7 @@ SRST
=20
     The most usual configuration is to listen on a local TCP socket::
=20
-        -mcd tcp::1234
-ERST
-
-DEF("mcdd", 0, QEMU_OPTION_mcdd, \
-    "-mcdd              shorthand for -mcd tcp::" DEFAULT_MCDSTUB_PORT "\n=
",
-    QEMU_ARCH_ALL)
-SRST
-``-mcdd``
-    Shorthand for -mcd tcp::1234, i.e. open a mcdserver on TCP port 1234
+        -mcd tcp::1235
 ERST
=20
 DEF("d", HAS_ARG, QEMU_OPTION_d, \
--=20
2.34.1


From 0c3a643cbe9923c26bb21e420f3a7ffa10a3cd6a Mon Sep 17 00:00:00 2001
From: Nicolas Eder <nicolas.eder@lauterbach.com>
Date: Mon, 10 Jul 2023 18:34:04 +0200
Subject: [PATCH 17/29] handler for breakpoints and watchpoints added

Signed-off-by: Nicolas Eder <nicolas.eder@lauterbach.com>
---
 mcdstub/mcd_shared_defines.h |   8 +++
 mcdstub/mcdstub.c            | 124 ++++++++++++++++++++++++++++++++++-
 mcdstub/mcdstub.h            |   4 ++
 softmmu/cpus.c               |   2 +-
 4 files changed, 135 insertions(+), 3 deletions(-)

diff --git a/mcdstub/mcd_shared_defines.h b/mcdstub/mcd_shared_defines.h
index 891f6477e7..2e0831594a 100644
--- a/mcdstub/mcd_shared_defines.h
+++ b/mcdstub/mcd_shared_defines.h
@@ -21,6 +21,8 @@
 #define TCP_CHAR_WRITE_REGISTER 'P'
 #define TCP_CHAR_READ_MEMORY 'm'
 #define TCP_CHAR_WRITE_MEMORY 'M'
+#define TCP_CHAR_BREAKPOINT_INSERT 't'
+#define TCP_CHAR_BREAKPOINT_REMOVE 'T'
=20
 /* tcp protocol chars */
 #define TCP_ACKNOWLEDGED '+'
@@ -82,4 +84,10 @@
 #define CORE_STATE_DEBUG "debug"
 #define CORE_STATE_UNKNOWN "unknown"
=20
+/* breakpoint types */
+#define MCD_BREAKPOINT_HW 1
+#define MCD_BREAKPOINT_READ 2
+#define MCD_BREAKPOINT_WRITE 3
+#define MCD_BREAKPOINT_RW 4
+
 #endif
diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index 9f79864af6..4327703bca 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -563,6 +563,32 @@ int mcd_handle_packet(const char *line_buf)
             cmd_parser =3D &write_mem_cmd_desc;
         }
         break;
+    case TCP_CHAR_BREAKPOINT_INSERT:
+        {
+            static MCDCmdParseEntry handle_breakpoint_insert_cmd_desc =3D {
+                .handler =3D handle_breakpoint_insert,
+            };
+            handle_breakpoint_insert_cmd_desc.cmd =3D
+                (char[2]) { TCP_CHAR_BREAKPOINT_INSERT, '\0' };
+            strcpy(handle_breakpoint_insert_cmd_desc.schema,
+                (char[5]) { ARG_SCHEMA_CORENUM, ARG_SCHEMA_INT,
+                ARG_SCHEMA_UINT64_T, ARG_SCHEMA_UINT64_T, '\0' });
+            cmd_parser =3D &handle_breakpoint_insert_cmd_desc;
+        }
+        break;
+    case TCP_CHAR_BREAKPOINT_REMOVE:
+        {
+            static MCDCmdParseEntry handle_breakpoint_remove_cmd_desc =3D {
+                .handler =3D handle_breakpoint_remove,
+            };
+            handle_breakpoint_remove_cmd_desc.cmd =3D
+                (char[2]) { TCP_CHAR_BREAKPOINT_REMOVE, '\0' };
+            strcpy(handle_breakpoint_remove_cmd_desc.schema,
+                (char[5]) { ARG_SCHEMA_CORENUM, ARG_SCHEMA_INT,
+                ARG_SCHEMA_UINT64_T, ARG_SCHEMA_UINT64_T, '\0' });
+            cmd_parser =3D &handle_breakpoint_remove_cmd_desc;
+        }
+        break;
     default:
         /* command not supported */
         mcd_put_packet("");
@@ -837,13 +863,14 @@ void mcd_vm_state_change(void *opaque, bool running, =
RunState state)
             cpu->watchpoint_hit =3D NULL;
         } else if (cpu->singlestep_enabled) {
             /* we land here when a single step is performed */
-            cpu_single_step(cpu, 0);
             stop_str =3D STATE_STEP_PERFORMED;
         } else {
             trig_id =3D MCD_TRIG_TYPE_IP;
             stop_str =3D STATE_STR_BREAK_HW;
             tb_flush(cpu);
         }
+        /* deactivate single step */
+        cpu_single_step(cpu, 0);
         break;
     case RUN_STATE_PAUSED:
         info_str =3D STATE_STR_HALTED(cpu->cpu_index);
@@ -1594,7 +1621,8 @@ void mcd_vm_start(void)
=20
 int mcd_vm_sstep(CPUState *cpu)
 {
-    cpu_single_step(mcdserver_state.c_cpu, mcdserver_state.sstep_flags);
+    mcdserver_state.c_cpu =3D cpu;
+    cpu_single_step(cpu, mcdserver_state.sstep_flags);
     mcd_vm_start();
     return 0;
 }
@@ -1950,3 +1978,95 @@ void handle_write_memory(GArray *params, void *user_=
ctx)
         mcd_put_packet(TCP_EXECUTION_SUCCESS);
     }
 }
+
+int mcd_breakpoint_insert(CPUState *cpu, int type, vaddr addr, vaddr len)
+{
+    /* translate the type to known gdb types and function call*/
+    int bp_type =3D 0;
+    CPUClass *cc =3D CPU_GET_CLASS(cpu);
+    if (cc->gdb_stop_before_watchpoint) {
+        //bp_type |=3D BP_STOP_BEFORE_ACCESS;
+    }
+    int return_value =3D 0;
+    switch (type) {
+    case MCD_BREAKPOINT_HW:
+        return_value =3D cpu_breakpoint_insert(cpu, addr, BP_GDB, NULL);
+        return return_value;
+    case MCD_BREAKPOINT_READ:
+        bp_type |=3D BP_GDB | BP_MEM_READ;
+        return_value =3D cpu_watchpoint_insert(cpu, addr, 4, bp_type, NULL=
);
+        return return_value;
+    case MCD_BREAKPOINT_WRITE:
+        bp_type |=3D BP_GDB | BP_MEM_WRITE;
+        return_value =3D cpu_watchpoint_insert(cpu, addr, 4, bp_type, NULL=
);
+        return return_value;
+    case MCD_BREAKPOINT_RW:
+        bp_type |=3D BP_GDB | BP_MEM_ACCESS;
+        return_value =3D cpu_watchpoint_insert(cpu, addr, 4, bp_type, NULL=
);
+        return return_value;
+    default:
+        return -ENOSYS;
+    }
+}
+
+int mcd_breakpoint_remove(CPUState *cpu, int type, vaddr addr, vaddr len)
+{
+    /* translate the type to known gdb types and function call*/
+    int bp_type =3D 0;
+    CPUClass *cc =3D CPU_GET_CLASS(cpu);
+    if (cc->gdb_stop_before_watchpoint) {
+        //bp_type |=3D BP_STOP_BEFORE_ACCESS;
+    }
+    int return_value =3D 0;
+    switch (type) {
+    case MCD_BREAKPOINT_HW:
+        return_value =3D cpu_breakpoint_remove(cpu, addr, BP_GDB);
+        return return_value;
+    case MCD_BREAKPOINT_READ:
+        bp_type |=3D BP_GDB | BP_MEM_READ;
+        return_value =3D cpu_watchpoint_remove(cpu, addr, 4, bp_type);
+        return return_value;
+    case MCD_BREAKPOINT_WRITE:
+        bp_type |=3D BP_GDB | BP_MEM_WRITE;
+        return_value =3D cpu_watchpoint_remove(cpu, addr, 4, bp_type);
+        return return_value;
+    case MCD_BREAKPOINT_RW:
+        bp_type |=3D BP_GDB | BP_MEM_ACCESS;
+        return_value =3D cpu_watchpoint_remove(cpu, addr, 4, bp_type);
+        return return_value;
+    default:
+        return -ENOSYS;
+    }
+}
+
+void handle_breakpoint_insert(GArray *params, void *user_ctx)
+{
+    /* 1. get parameter data */
+    uint32_t cpu_id =3D get_param(params, 0)->cpu_id;
+    uint32_t type =3D get_param(params, 1)->data_int;
+    uint64_t address =3D get_param(params, 2)->data_uint64_t;
+    uint64_t len =3D get_param(params, 3)->data_uint64_t;
+    /* 2. insert breakpoint and send reply*/
+    CPUState *cpu =3D mcd_get_cpu(cpu_id);
+    if (mcd_breakpoint_insert(cpu, type, address, len) !=3D 0) {
+        mcd_put_packet(TCP_EXECUTION_ERROR);
+    } else {
+        mcd_put_packet(TCP_EXECUTION_SUCCESS);
+    }
+}
+
+void handle_breakpoint_remove(GArray *params, void *user_ctx)
+{
+    /* 1. get parameter data */
+    uint32_t cpu_id =3D get_param(params, 0)->cpu_id;
+    uint32_t type =3D get_param(params, 1)->data_int;
+    uint64_t address =3D get_param(params, 2)->data_uint64_t;
+    uint64_t len =3D get_param(params, 3)->data_uint64_t;
+    /* 2. remove breakpoint and send reply*/
+    CPUState *cpu =3D mcd_get_cpu(cpu_id);
+    if (mcd_breakpoint_remove(cpu, type, address, len) !=3D 0) {
+        mcd_put_packet(TCP_EXECUTION_ERROR);
+    } else {
+        mcd_put_packet(TCP_EXECUTION_SUCCESS);
+    }
+}
diff --git a/mcdstub/mcdstub.h b/mcdstub/mcdstub.h
index 83156dceb8..c2bdaee410 100644
--- a/mcdstub/mcdstub.h
+++ b/mcdstub/mcdstub.h
@@ -309,6 +309,10 @@ int mcd_read_register(CPUState *cpu, GByteArray *buf, =
int reg);
 int mcd_write_register(CPUState *cpu, GByteArray *buf, int reg);
 int mcd_read_memory(CPUState *cpu, hwaddr addr, uint8_t *buf, int len);
 int mcd_write_memory(CPUState *cpu, hwaddr addr, uint8_t *buf, int len);
+void handle_breakpoint_insert(GArray *params, void *user_ctx);
+void handle_breakpoint_remove(GArray *params, void *user_ctx);
+int mcd_breakpoint_insert(CPUState *cpu, int type, vaddr addr, vaddr len);
+int mcd_breakpoint_remove(CPUState *cpu, int type, vaddr addr, vaddr len);
=20
 /* arm specific functions */
 int mcd_arm_store_mem_spaces(CPUState *cpu, GArray *memspaces);
diff --git a/softmmu/cpus.c b/softmmu/cpus.c
index 0848e0dbdb..b1807e6d7b 100644
--- a/softmmu/cpus.c
+++ b/softmmu/cpus.c
@@ -306,7 +306,7 @@ void cpu_handle_guest_debug(CPUState *cpu)
             cpu_single_step(cpu, 0);
         }
     } else {
-        gdb_set_stop_cpu(cpu);
+        /*gdb_set_stop_cpu(cpu);*/
         qemu_system_debug_request();
         cpu->stopped =3D true;
     }
--=20
2.34.1


From 8d3d3659010bd71f94c506e0d859fba35f69b7ef Mon Sep 17 00:00:00 2001
From: Nicolas Eder <nicolas.eder@lauterbach.com>
Date: Wed, 12 Jul 2023 11:53:29 +0200
Subject: [PATCH 18/29] making step and go handlers core-specific

Signed-off-by: Nicolas Eder <nicolas.eder@lauterbach.com>
---
 mcdstub/mcdstub.c | 26 ++++++++++++++++++++++----
 mcdstub/mcdstub.h |  3 ++-
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index 4327703bca..8fc95d96a4 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -434,6 +434,8 @@ int mcd_handle_packet(const char *line_buf)
                 .handler =3D handle_vm_start,
             };
             go_cmd_desc.cmd =3D (char[2]) { TCP_CHAR_GO, '\0' };
+            strcpy(go_cmd_desc.schema,
+                (char[2]) { ARG_SCHEMA_CORENUM, '\0' });
             cmd_parser =3D &go_cmd_desc;
         }
         break;
@@ -606,7 +608,9 @@ int mcd_handle_packet(const char *line_buf)
 void handle_vm_start(GArray *params, void *user_ctx)
 {
     /* TODO: add partial restart with arguments and so on */
-    mcd_vm_start();
+    uint32_t cpu_id =3D get_param(params, 0)->cpu_id;
+    CPUState *cpu =3D mcd_get_cpu(cpu_id);
+    mcd_cpu_start(cpu);
 }
=20
 void handle_vm_step(GArray *params, void *user_ctx)
@@ -615,7 +619,7 @@ void handle_vm_step(GArray *params, void *user_ctx)
     uint32_t cpu_id =3D get_param(params, 0)->cpu_id;
=20
     CPUState *cpu =3D mcd_get_cpu(cpu_id);
-    int return_value =3D mcd_vm_sstep(cpu);
+    int return_value =3D mcd_cpu_sstep(cpu);
     if (return_value !=3D 0) {
         g_assert_not_reached();
     }
@@ -1619,11 +1623,25 @@ void mcd_vm_start(void)
     }
 }
=20
-int mcd_vm_sstep(CPUState *cpu)
+void mcd_cpu_start(CPUState *cpu)
+{
+    if (!runstate_needs_reset() && !runstate_is_running() &&
+        !vm_prepare_start(false)) {
+        mcdserver_state.c_cpu =3D cpu;
+        qemu_clock_enable(QEMU_CLOCK_VIRTUAL, true);
+        cpu_resume(cpu);
+    }
+}
+
+int mcd_cpu_sstep(CPUState *cpu)
 {
     mcdserver_state.c_cpu =3D cpu;
     cpu_single_step(cpu, mcdserver_state.sstep_flags);
-    mcd_vm_start();
+    if (!runstate_needs_reset() && !runstate_is_running() &&
+        !vm_prepare_start(true)) {
+        qemu_clock_enable(QEMU_CLOCK_VIRTUAL, true);
+        cpu_resume(cpu);
+    }
     return 0;
 }
=20
diff --git a/mcdstub/mcdstub.h b/mcdstub/mcdstub.h
index c2bdaee410..ab44252ba0 100644
--- a/mcdstub/mcdstub.h
+++ b/mcdstub/mcdstub.h
@@ -289,7 +289,8 @@ void handle_close_server(GArray *params, void *user_ctx=
);
 void handle_close_core(GArray *params, void *user_ctx);
 void handle_query_trigger(GArray *params, void *user_ctx);
 void mcd_vm_start(void);
-int mcd_vm_sstep(CPUState *cpu);
+void mcd_cpu_start(CPUState *cpu);
+int mcd_cpu_sstep(CPUState *cpu);
 void mcd_vm_stop(void);
 void handle_query_reg_groups_f(GArray *params, void *user_ctx);
 void handle_query_reg_groups_c(GArray *params, void *user_ctx);
--=20
2.34.1


From d8d56695e2c9fcab1bb2ecaa5d5fac994088adce Mon Sep 17 00:00:00 2001
From: Nicolas Eder <nicolas.eder@lauterbach.com>
Date: Thu, 13 Jul 2023 15:36:29 +0200
Subject: [PATCH 19/29] adding trigger ID handling for TRACE32

Signed-off-by: Nicolas Eder <nicolas.eder@lauterbach.com>
---
 mcdstub/mcd_shared_defines.h |   2 +-
 mcdstub/mcdstub.c            | 101 +++++++++++++++++++++--------------
 mcdstub/mcdstub.h            |  29 ++++++----
 3 files changed, 82 insertions(+), 50 deletions(-)

diff --git a/mcdstub/mcd_shared_defines.h b/mcdstub/mcd_shared_defines.h
index 2e0831594a..88d556cab1 100644
--- a/mcdstub/mcd_shared_defines.h
+++ b/mcdstub/mcd_shared_defines.h
@@ -63,7 +63,7 @@
 #define TCP_ARGUMENT_MEMSPACEID "memspaceid"
 #define TCP_ARGUMENT_SIZE "size"
 #define TCP_ARGUMENT_THREAD "thread"
-#define TCP_ARGUMENT_TRIGGER_ID "trig_id"
+#define TCP_ARGUMENT_ADDRESS "address"
 #define TCP_ARGUMENT_STOP_STRING "stop_str"
 #define TCP_ARGUMENT_INFO_STRING "info_str"
 #define TCP_ARGUMENT_STATE "state"
diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index 8fc95d96a4..bd532b0f4c 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -573,8 +573,8 @@ int mcd_handle_packet(const char *line_buf)
             handle_breakpoint_insert_cmd_desc.cmd =3D
                 (char[2]) { TCP_CHAR_BREAKPOINT_INSERT, '\0' };
             strcpy(handle_breakpoint_insert_cmd_desc.schema,
-                (char[5]) { ARG_SCHEMA_CORENUM, ARG_SCHEMA_INT,
-                ARG_SCHEMA_UINT64_T, ARG_SCHEMA_UINT64_T, '\0' });
+                (char[4]) { ARG_SCHEMA_CORENUM, ARG_SCHEMA_INT,
+                ARG_SCHEMA_UINT64_T, '\0' });
             cmd_parser =3D &handle_breakpoint_insert_cmd_desc;
         }
         break;
@@ -586,8 +586,8 @@ int mcd_handle_packet(const char *line_buf)
             handle_breakpoint_remove_cmd_desc.cmd =3D
                 (char[2]) { TCP_CHAR_BREAKPOINT_REMOVE, '\0' };
             strcpy(handle_breakpoint_remove_cmd_desc.schema,
-                (char[5]) { ARG_SCHEMA_CORENUM, ARG_SCHEMA_INT,
-                ARG_SCHEMA_UINT64_T, ARG_SCHEMA_UINT64_T, '\0' });
+                (char[4]) { ARG_SCHEMA_CORENUM, ARG_SCHEMA_INT,
+                ARG_SCHEMA_UINT64_T, '\0' });
             cmd_parser =3D &handle_breakpoint_remove_cmd_desc;
         }
         break;
@@ -671,6 +671,18 @@ uint64_t atouint64_t(const char *in)
     return res;
 }
=20
+uint32_t atouint32_t(const char *in)
+{
+    uint32_t res =3D 0;
+    for (int i =3D 0; i < strlen(in); ++i) {
+        const char c =3D in[i];
+        res *=3D 10;
+        res +=3D c - '0';
+    }
+
+    return res;
+}
+
 int cmd_parse_params(const char *data, const char *schema, GArray *params)
 {
=20
@@ -705,7 +717,7 @@ int cmd_parse_params(const char *data, const char *sche=
ma, GArray *params)
             g_string_printf(mcdserver_state.str_buf, "%s", data_buffer);
             break;
         case ARG_SCHEMA_INT:
-            this_param.data_int =3D atoi(data_buffer);
+            this_param.data_uint32_t =3D atouint32_t(data_buffer);
             g_array_append_val(params, this_param);
             break;
         case ARG_SCHEMA_UINT64_T:
@@ -713,11 +725,11 @@ int cmd_parse_params(const char *data, const char *sc=
hema, GArray *params)
             g_array_append_val(params, this_param);
             break;
         case ARG_SCHEMA_QRYHANDLE:
-            this_param.query_handle =3D atoi(data_buffer);
+            this_param.query_handle =3D atouint32_t(data_buffer);
             g_array_append_val(params, this_param);
             break;
         case ARG_SCHEMA_CORENUM:
-            this_param.cpu_id =3D atoi(data_buffer);
+            this_param.cpu_id =3D atouint32_t(data_buffer);
             g_array_append_val(params, this_param);
             break;
         default:
@@ -828,7 +840,7 @@ void mcd_vm_state_change(void *opaque, bool running, Ru=
nState state)
             const char *info_str;
             info_str =3D STATE_STR_INIT_RUNNING;
             mcdserver_state.cpu_state.state =3D mcd_state;
-            mcdserver_state.cpu_state.state =3D info_str;
+            mcdserver_state.cpu_state.info_str =3D info_str;
         }
         return;
     }
@@ -836,7 +848,8 @@ void mcd_vm_state_change(void *opaque, bool running, Ru=
nState state)
     const char *mcd_state;
     const char *stop_str;
     const char *info_str;
-    uint32_t trig_id =3D 0;
+    uint32_t bp_type =3D 0;
+    uint64_t bp_address =3D 0;
     switch (state) {
     case RUN_STATE_RUNNING:
         mcd_state =3D CORE_STATE_RUNNING;
@@ -849,27 +862,28 @@ void mcd_vm_state_change(void *opaque, bool running, =
RunState state)
         if (cpu->watchpoint_hit) {
             switch (cpu->watchpoint_hit->flags & BP_MEM_ACCESS) {
             case BP_MEM_READ:
-                trig_id =3D MCD_TRIG_TYPE_READ;
+                bp_type =3D MCD_BREAKPOINT_READ;
                 stop_str =3D STATE_STR_BREAK_READ(cpu->watchpoint_hit->hit=
addr);
                 break;
             case BP_MEM_WRITE:
-                trig_id =3D MCD_TRIG_TYPE_WRITE;
+                bp_type =3D MCD_BREAKPOINT_WRITE;
                 stop_str =3D STATE_STR_BREAK_WRITE(cpu->watchpoint_hit->hi=
taddr);
                 break;
             case BP_MEM_ACCESS:
-                trig_id =3D MCD_TRIG_TYPE_RW;
+                bp_type =3D MCD_BREAKPOINT_RW;
                 stop_str =3D STATE_STR_BREAK_RW(cpu->watchpoint_hit->hitad=
dr);
                 break;
             default:
-                break;
                 stop_str =3D STATE_STR_BREAK_UNKNOWN;
+                break;
             }
+            bp_address =3D cpu->watchpoint_hit->hitaddr;
             cpu->watchpoint_hit =3D NULL;
         } else if (cpu->singlestep_enabled) {
             /* we land here when a single step is performed */
             stop_str =3D STATE_STEP_PERFORMED;
         } else {
-            trig_id =3D MCD_TRIG_TYPE_IP;
+            bp_type =3D MCD_BREAKPOINT_HW;
             stop_str =3D STATE_STR_BREAK_HW;
             tb_flush(cpu);
         }
@@ -895,7 +909,8 @@ void mcd_vm_state_change(void *opaque, bool running, Ru=
nState state)
=20
     /* set state for c_cpu */
     mcdserver_state.cpu_state.state =3D mcd_state;
-    mcdserver_state.cpu_state.trig_id =3D trig_id;
+    mcdserver_state.cpu_state.bp_type =3D bp_type;
+    mcdserver_state.cpu_state.bp_address =3D bp_address;
     mcdserver_state.cpu_state.stop_str =3D stop_str;
     mcdserver_state.cpu_state.info_str =3D info_str;
 }
@@ -1263,13 +1278,14 @@ int init_resets(GArray *resets)
     return 0;
 }
=20
-int init_trigger(mcd_trigger_st *trigger)
+int init_trigger(mcd_trigger_into_st *trigger)
 {
     trigger->type =3D (MCD_TRIG_TYPE_IP | MCD_TRIG_TYPE_READ |
         MCD_TRIG_TYPE_WRITE | MCD_TRIG_TYPE_RW);
     trigger->option =3D (MCD_TRIG_OPT_DATA_IS_CONDITION);
     trigger->action =3D (MCD_TRIG_ACTION_DBG_DEBUG);
-    trigger->nr_trigger =3D 4;
+    /* there is no specific upper limit for trigger */
+    trigger->nr_trigger =3D 0;
     return 0;
 }
=20
@@ -1541,7 +1557,7 @@ void handle_query_reset_f(GArray *params, void *user_=
ctx)
 void handle_query_reset_c(GArray *params, void *user_ctx)
 {
     /* reset options are the same for every cpu! */
-    int query_index =3D get_param(params, 0)->query_handle;
+    uint32_t query_index =3D get_param(params, 0)->query_handle;
=20
     /* 1. check weather this was the last mem space */
     int nb_groups =3D mcdserver_state.resets->len;
@@ -1608,7 +1624,7 @@ void handle_close_server(GArray *params, void *user_c=
tx)
=20
 void handle_query_trigger(GArray *params, void *user_ctx)
 {
-    mcd_trigger_st trigger =3D mcdserver_state.trigger;
+    mcd_trigger_into_st trigger =3D mcdserver_state.trigger;
     g_string_printf(mcdserver_state.str_buf, "%s=3D%d.%s=3D%d.%s=3D%d.%s=
=3D%d.",
         TCP_ARGUMENT_AMOUNT_TRIGGER, trigger.nr_trigger,
         TCP_ARGUMENT_TYPE, trigger.type, TCP_ARGUMENT_OPTION, trigger.opti=
on,
@@ -1687,7 +1703,7 @@ void handle_query_mem_spaces_c(GArray *params, void *=
user_ctx)
      * this funcitons send all mem spaces except for the first
      * 1. get parameter and memspace
      */
-    int query_index =3D get_param(params, 0)->query_handle;
+    uint32_t query_index =3D get_param(params, 0)->query_handle;
     uint32_t cpu_id =3D mcdserver_state.query_cpu_id;
     GArray *memspaces =3D g_list_nth_data(mcdserver_state.all_memspaces, c=
pu_id);
=20
@@ -1742,7 +1758,7 @@ void handle_query_reg_groups_c(GArray *params, void *=
user_ctx)
      * this funcitons send all reg groups except for the first
      * 1. get parameter and memspace
      */
-    int query_index =3D get_param(params, 0)->query_handle;
+    uint32_t query_index =3D get_param(params, 0)->query_handle;
     uint32_t cpu_id =3D mcdserver_state.query_cpu_id;
     GArray *reggroups =3D g_list_nth_data(mcdserver_state.all_reggroups, c=
pu_id);
=20
@@ -1797,7 +1813,7 @@ void handle_query_regs_c(GArray *params, void *user_c=
tx)
      * this funcitons send all regs except for the first
      * 1. get parameter and registers
      */
-    int query_index =3D get_param(params, 0)->query_handle;
+    uint32_t query_index =3D get_param(params, 0)->query_handle;
     uint32_t cpu_id =3D mcdserver_state.query_cpu_id;
     GArray *registers =3D g_list_nth_data(mcdserver_state.all_registers, c=
pu_id);
=20
@@ -1853,13 +1869,22 @@ void handle_query_state(GArray *params, void *user_=
ctx)
     }
     /* send data */
     g_string_printf(mcdserver_state.str_buf,
-        "%s=3D%s.%s=3D%d.%s=3D%d.%s=3D%d.%s=3D%s.%s=3D%s.",
+        "%s=3D%s.%s=3D%u.%s=3D%u.%s=3D%u.%s=3D%lu.%s=3D%s.%s=3D%s.",
         TCP_ARGUMENT_STATE, state_info.state,
         TCP_ARGUMENT_EVENT, event, TCP_ARGUMENT_THREAD, 0,
-        TCP_ARGUMENT_TRIGGER_ID, state_info.trig_id,
+        TCP_ARGUMENT_TYPE, state_info.bp_type,
+        TCP_ARGUMENT_ADDRESS, state_info.bp_address,
         TCP_ARGUMENT_STOP_STRING, state_info.stop_str,
         TCP_ARGUMENT_INFO_STRING, state_info.info_str);
     mcd_put_strbuf();
+
+    /* reset debug info after first query */
+    if (strcmp(state_info.state, CORE_STATE_DEBUG) =3D=3D 0) {
+        mcdserver_state.cpu_state.stop_str =3D "";
+        mcdserver_state.cpu_state.info_str =3D "";
+        mcdserver_state.cpu_state.bp_type =3D 0;
+        mcdserver_state.cpu_state.bp_address =3D 0;
+    }
 }
=20
 int mcd_read_register(CPUState *cpu, GByteArray *buf, int reg)
@@ -1913,7 +1938,7 @@ void mcd_hextomem(GByteArray *mem, const char *buf, i=
nt len)
 void handle_read_register(GArray *params, void *user_ctx)
 {
     uint32_t cpu_id =3D get_param(params, 0)->cpu_id;
-    uint64_t reg_num =3D get_param(params, 1)->data_int;
+    uint64_t reg_num =3D get_param(params, 1)->data_uint64_t;
     int reg_size;
=20
     CPUState *cpu =3D mcd_get_cpu(cpu_id);
@@ -1926,8 +1951,8 @@ void handle_read_register(GArray *params, void *user_=
ctx)
 void handle_write_register(GArray *params, void *user_ctx)
 {
     uint32_t cpu_id =3D get_param(params, 0)->cpu_id;
-    uint64_t reg_num =3D get_param(params, 1)->data_int;
-    uint32_t reg_size =3D get_param(params, 2)->data_int;
+    uint64_t reg_num =3D get_param(params, 1)->data_uint64_t;
+    uint32_t reg_size =3D get_param(params, 2)->data_uint32_t;
=20
     CPUState *cpu =3D mcd_get_cpu(cpu_id);
     mcd_hextomem(mcdserver_state.mem_buf,
@@ -1967,7 +1992,7 @@ void handle_read_memory(GArray *params, void *user_ct=
x)
 {
     uint32_t cpu_id =3D get_param(params, 0)->cpu_id;
     uint64_t mem_address =3D get_param(params, 1)->data_uint64_t;
-    int len =3D get_param(params, 2)->data_int;
+    uint32_t len =3D get_param(params, 2)->data_uint32_t;
=20
     CPUState *cpu =3D mcd_get_cpu(cpu_id);
     g_byte_array_set_size(mcdserver_state.mem_buf, len);
@@ -1985,7 +2010,7 @@ void handle_write_memory(GArray *params, void *user_c=
tx)
 {
     uint32_t cpu_id =3D get_param(params, 0)->cpu_id;
     uint64_t mem_address =3D get_param(params, 1)->data_uint64_t;
-    int len =3D get_param(params, 2)->data_int;
+    uint32_t len =3D get_param(params, 2)->data_uint32_t;
=20
     CPUState *cpu =3D mcd_get_cpu(cpu_id);
     mcd_hextomem(mcdserver_state.mem_buf, mcdserver_state.str_buf->str, le=
n);
@@ -1997,7 +2022,7 @@ void handle_write_memory(GArray *params, void *user_c=
tx)
     }
 }
=20
-int mcd_breakpoint_insert(CPUState *cpu, int type, vaddr addr, vaddr len)
+int mcd_breakpoint_insert(CPUState *cpu, int type, vaddr addr)
 {
     /* translate the type to known gdb types and function call*/
     int bp_type =3D 0;
@@ -2027,7 +2052,7 @@ int mcd_breakpoint_insert(CPUState *cpu, int type, va=
ddr addr, vaddr len)
     }
 }
=20
-int mcd_breakpoint_remove(CPUState *cpu, int type, vaddr addr, vaddr len)
+int mcd_breakpoint_remove(CPUState *cpu, int type, vaddr addr)
 {
     /* translate the type to known gdb types and function call*/
     int bp_type =3D 0;
@@ -2061,12 +2086,11 @@ void handle_breakpoint_insert(GArray *params, void =
*user_ctx)
 {
     /* 1. get parameter data */
     uint32_t cpu_id =3D get_param(params, 0)->cpu_id;
-    uint32_t type =3D get_param(params, 1)->data_int;
+    uint32_t type =3D get_param(params, 1)->data_uint32_t;
     uint64_t address =3D get_param(params, 2)->data_uint64_t;
-    uint64_t len =3D get_param(params, 3)->data_uint64_t;
-    /* 2. insert breakpoint and send reply*/
+    /* 2. insert breakpoint and send reply */
     CPUState *cpu =3D mcd_get_cpu(cpu_id);
-    if (mcd_breakpoint_insert(cpu, type, address, len) !=3D 0) {
+    if (mcd_breakpoint_insert(cpu, type, address) !=3D 0) {
         mcd_put_packet(TCP_EXECUTION_ERROR);
     } else {
         mcd_put_packet(TCP_EXECUTION_SUCCESS);
@@ -2077,12 +2101,11 @@ void handle_breakpoint_remove(GArray *params, void =
*user_ctx)
 {
     /* 1. get parameter data */
     uint32_t cpu_id =3D get_param(params, 0)->cpu_id;
-    uint32_t type =3D get_param(params, 1)->data_int;
+    uint32_t type =3D get_param(params, 1)->data_uint32_t;
     uint64_t address =3D get_param(params, 2)->data_uint64_t;
-    uint64_t len =3D get_param(params, 3)->data_uint64_t;
-    /* 2. remove breakpoint and send reply*/
+    /* 2. remove breakpoint and send reply */
     CPUState *cpu =3D mcd_get_cpu(cpu_id);
-    if (mcd_breakpoint_remove(cpu, type, address, len) !=3D 0) {
+    if (mcd_breakpoint_remove(cpu, type, address) !=3D 0) {
         mcd_put_packet(TCP_EXECUTION_ERROR);
     } else {
         mcd_put_packet(TCP_EXECUTION_SUCCESS);
diff --git a/mcdstub/mcdstub.h b/mcdstub/mcdstub.h
index ab44252ba0..7a63a01a39 100644
--- a/mcdstub/mcdstub.h
+++ b/mcdstub/mcdstub.h
@@ -104,10 +104,10 @@ typedef struct MCDCmdParseEntry {
=20
 typedef union MCDCmdVariant {
     const char *data;
-    int data_int;
+    uint32_t data_uint32_t;
     uint64_t data_uint64_t;
-    int query_handle;
-    int cpu_id;
+    uint32_t query_handle;
+    uint32_t cpu_id;
 } MCDCmdVariant;
=20
 #define get_param(p, i)    (&g_array_index(p, MCDCmdVariant, i))
@@ -119,19 +119,26 @@ enum RSState {
     RS_DATAEND,
 };
=20
-typedef struct mcd_trigger_st {
+typedef struct breakpoint_st {
+    uint32_t type;
+    uint64_t address;
+    uint32_t id;
+} breakpoint_st;
+
+typedef struct mcd_trigger_into_st {
     uint32_t type;
     uint32_t option;
     uint32_t action;
     uint32_t nr_trigger;
-} mcd_trigger_st;
+} mcd_trigger_into_st;
=20
 typedef struct mcd_cpu_state_st {
     const char *state;
     bool memory_changed;
     bool registers_changed;
     bool target_was_stopped;
-    uint32_t trig_id;
+    uint32_t bp_type;
+    uint64_t bp_address;
     const char *stop_str;
     const char *info_str;
 } mcd_cpu_state_st;
@@ -158,8 +165,9 @@ typedef struct MCDState {
     GList *all_memspaces;
     GList *all_reggroups;
     GList *all_registers;
+    GList *all_breakpoints;
     GArray *resets;
-    mcd_trigger_st trigger;
+    mcd_trigger_into_st trigger;
     mcd_cpu_state_st cpu_state;
     MCDCmdParseEntry mcd_query_cmds_table[QUERY_TOTAL_NUMBER];
 } MCDState;
@@ -244,7 +252,7 @@ void mcd_sigterm_handler(int signal);
 void mcd_init_mcdserver_state(void);
 void init_query_cmds_table(MCDCmdParseEntry *mcd_query_cmds_table);
 int init_resets(GArray *resets);
-int init_trigger(mcd_trigger_st *trigger);
+int init_trigger(mcd_trigger_into_st *trigger);
 void reset_mcdserver_state(void);
 void create_processes(MCDState *s);
 void mcd_create_default_process(MCDState *s);
@@ -312,8 +320,8 @@ int mcd_read_memory(CPUState *cpu, hwaddr addr, uint8_t=
 *buf, int len);
 int mcd_write_memory(CPUState *cpu, hwaddr addr, uint8_t *buf, int len);
 void handle_breakpoint_insert(GArray *params, void *user_ctx);
 void handle_breakpoint_remove(GArray *params, void *user_ctx);
-int mcd_breakpoint_insert(CPUState *cpu, int type, vaddr addr, vaddr len);
-int mcd_breakpoint_remove(CPUState *cpu, int type, vaddr addr, vaddr len);
+int mcd_breakpoint_insert(CPUState *cpu, int type, vaddr addr);
+int mcd_breakpoint_remove(CPUState *cpu, int type, vaddr addr);
=20
 /* arm specific functions */
 int mcd_arm_store_mem_spaces(CPUState *cpu, GArray *memspaces);
@@ -332,5 +340,6 @@ int int_cmp(gconstpointer a, gconstpointer b);
 void mcd_memtohex(GString *buf, const uint8_t *mem, int len);
 void mcd_hextomem(GByteArray *mem, const char *buf, int len);
 uint64_t atouint64_t(const char *in);
+uint32_t atouint32_t(const char *in);
=20
 #endif /* MCDSTUB_INTERNALS_H */
--=20
2.34.1


From ad46b0fb59ad4c191a5be656cb7adeaa4b68ea5b Mon Sep 17 00:00:00 2001
From: Nicolas Eder <nicolas.eder@lauterbach.com>
Date: Fri, 14 Jul 2023 13:06:46 +0200
Subject: [PATCH 20/29] cp register read/write added

Signed-off-by: Nicolas Eder <nicolas.eder@lauterbach.com>
---
 mcdstub/mcd_shared_defines.h |   1 +
 mcdstub/mcdstub.c            | 117 ++++++++++------
 mcdstub/mcdstub.h            |  18 ++-
 target/arm/mcdstub.c         | 265 ++++++++++++++++++++++++++++++-----
 target/arm/mcdstub.h         |  16 ++-
 5 files changed, 330 insertions(+), 87 deletions(-)

diff --git a/mcdstub/mcd_shared_defines.h b/mcdstub/mcd_shared_defines.h
index 88d556cab1..91d476a555 100644
--- a/mcdstub/mcd_shared_defines.h
+++ b/mcdstub/mcd_shared_defines.h
@@ -74,6 +74,7 @@
 #define TCP_ARGUMENT_AMOUNT_TRIGGER "nr_trigger"
 #define TCP_ARGUMENT_OPTION "option"
 #define TCP_ARGUMENT_ACTION "action"
+#define TCP_ARGUMENT_OPCODE "opcode"
=20
 /* for packets sent to qemu */
 #define ARGUMENT_SEPARATOR ';'
diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index bd532b0f4c..3772bda0a1 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -1064,10 +1064,12 @@ CPUState *find_cpu(uint32_t thread_id)
 }
=20
=20
-void parse_reg_xml(const char *xml, int size, GArray *registers)
+void parse_reg_xml(const char *xml, int size, GArray *registers,
+    uint8_t reg_type)
 {
     /* iterates over the complete xml file */
     int i, j;
+    uint32_t internal_id =3D 0;
     int still_to_skip =3D 0;
     char argument[64] =3D {0};
     char value[64] =3D {0};
@@ -1116,8 +1118,11 @@ void parse_reg_xml(const char *xml, int size, GArray=
 *registers)
=20
                     if (strcmp(argument_j, "name") =3D=3D 0) {
                         strcpy(my_register.name, value_j);
-                    } else if (strcmp(argument_j, "regnum") =3D=3D 0) {
-                        my_register.id =3D atoi(value_j);
+                    /*
+                     * we might want to read out the regnum
+                     * } else if (strcmp(argument_j, "regnum") =3D=3D 0) {
+                     * my_register.internal_id =3D atoi(value_j);
+                     */
                     } else if (strcmp(argument_j, "bitsize") =3D=3D 0) {
                         my_register.bitsize =3D atoi(value_j);
                     } else if (strcmp(argument_j, "type") =3D=3D 0) {
@@ -1126,6 +1131,10 @@ void parse_reg_xml(const char *xml, int size, GArray=
 *registers)
                         strcpy(my_register.group, value_j);
                     }
                 }
+                /* add reg_type and internal id */
+                my_register.reg_type =3D reg_type;
+                my_register.internal_id =3D internal_id;
+                internal_id++;
                 /* store register */
                 g_array_append_vals(registers, (gconstpointer)&my_register=
, 1);
                 /* free memory */
@@ -1238,6 +1247,7 @@ int mcd_arm_store_mem_spaces(CPUState *cpu, GArray *m=
emspaces)
     };
     g_array_append_vals(memspaces, (gconstpointer)&space4, 1);
     }
+
     /* TODO: get dynamically how the per (CP15) space is called */
     mcd_mem_space_st space5 =3D {
         .name =3D "GPR Registers",
@@ -1263,7 +1273,6 @@ int mcd_arm_store_mem_spaces(CPUState *cpu, GArray *m=
emspaces)
         .supported_access_options =3D 0,
     };
     g_array_append_vals(memspaces, (gconstpointer)&space6, 1);
-
     return 0;
 }
=20
@@ -1366,7 +1375,8 @@ int mcd_arm_parse_core_xml_file(CPUClass *cc, GArray =
*reggroups,
=20
     /* 3. parse xml */
     xml_content =3D xml_builtin[i][1];
-    parse_reg_xml(xml_content, strlen(xml_content), registers);
+    parse_reg_xml(xml_content, strlen(xml_content), registers,
+        MCD_ARM_REG_TYPE_GPR);
     return 0;
 }
=20
@@ -1376,6 +1386,7 @@ int mcd_arm_parse_general_xml_files(CPUState *cpu, GA=
rray *reggroups,
     const char *current_xml_filename =3D NULL;
     const char *xml_content =3D NULL;
     int i =3D 0;
+    uint8_t reg_type;
=20
     /* iterate over all gdb xml files*/
     GDBRegisterState *r;
@@ -1395,6 +1406,7 @@ int mcd_arm_parse_general_xml_files(CPUState *cpu, GA=
rray *reggroups,
                 g_array_append_vals(reggroups,
                     (gconstpointer)&corprocessorregs, 1);
                 *current_group_id =3D *current_group_id + 1;
+                reg_type =3D MCD_ARM_REG_TYPE_CPR;
             }
         } else {
             /* its not a coprocessor xml -> it is a static xml file */
@@ -1407,58 +1419,59 @@ int mcd_arm_parse_general_xml_files(CPUState *cpu, =
GArray *reggroups,
             }
             if (current_xml_filename) {
                 xml_content =3D xml_builtin[i][1];
+                /* select correct reg_type */
+                if (strcmp(current_xml_filename, "arm-vfp.xml") =3D=3D 0) {
+                    reg_type =3D MCD_ARM_REG_TYPE_VFP;
+                } else if (strcmp(current_xml_filename, "arm-vfp3.xml") =
=3D=3D 0) {
+                    reg_type =3D MCD_ARM_REG_TYPE_VFP;
+                } else if (strcmp(current_xml_filename,
+                    "arm-vfp-sysregs.xml") =3D=3D 0) {
+                    reg_type =3D MCD_ARM_REG_TYPE_VFP_SYS;
+                } else if (strcmp(current_xml_filename,
+                    "arm-neon.xml") =3D=3D 0) {
+                    reg_type =3D MCD_ARM_REG_TYPE_VFP;
+                } else if (strcmp(current_xml_filename,
+                    "arm-m-profile-mve.xml") =3D=3D 0) {
+                    reg_type =3D MCD_ARM_REG_TYPE_MVE;
+                }
             } else {
                 continue;
             }
         }
         /* 2. parse xml */
-        parse_reg_xml(xml_content, strlen(xml_content), registers);
+        parse_reg_xml(xml_content, strlen(xml_content), registers, reg_typ=
e);
     }
     return 0;
 }
=20
-int mcd_arm_get_additional_register_info(GArray *reggroups, GArray *regist=
ers)
+int mcd_arm_get_additional_register_info(GArray *reggroups, GArray *regist=
ers,
+    CPUState *cpu)
 {
-    GList *register_numbers =3D NULL;
     mcd_reg_st *current_register;
-    int i =3D 0;
-    int id_neg_offset =3D 0;
-    int effective_id =3D 0;
+    uint32_t i =3D 0;
=20
     /* iterate over all registers */
     for (i =3D 0; i < registers->len; i++) {
         current_register =3D &(g_array_index(registers, mcd_reg_st, i));
-        /* 1. ad the id */
-        if (current_register->id) {
-            /*
-             *id is already in place
-             *NOTE: qemu doesn't emulate the FPA regs
-             *(so we are missing the indices 16 to 24)
-             */
-            int used_id =3D current_register->id;
-            register_numbers =3D g_list_append(register_numbers, &used_id);
-            id_neg_offset++;
-        } else {
-            effective_id =3D i - id_neg_offset;
-            if (g_list_find_custom(register_numbers, &effective_id,
-                (GCompareFunc)int_cmp) !=3D NULL) {
-                id_neg_offset--;
-            }
-            current_register->id =3D i - id_neg_offset;
-        }
-        /* 2. add mcd_reg_group_id and mcd_mem_space_id */
+        current_register->id =3D i;
+        /* add mcd_reg_group_id and mcd_mem_space_id */
         if (strcmp(current_register->group, "cp_regs") =3D=3D 0) {
             /* coprocessor registers */
             current_register->mcd_reg_group_id =3D 2;
             current_register->mcd_mem_space_id =3D 6;
-            /* TODO: get info for opcode */
+            /*
+             * get info for opcode
+             * for 32bit the opcode is only 16 bit long
+             * for 64bit it is 32 bit long
+             */
+            current_register->opcode |=3D
+                arm_mcd_get_opcode(cpu, current_register->internal_id);
         } else {
             /* gpr register */
             current_register->mcd_reg_group_id =3D 1;
             current_register->mcd_mem_space_id =3D 5;
         }
     }
-    g_list_free(register_numbers);
     return 0;
 }
=20
@@ -1498,7 +1511,7 @@ void handle_open_core(GArray *params, void *user_ctx)
         }
         /* 4. add additional data the the regs from the xmls */
         return_value =3D mcd_arm_get_additional_register_info(reggroups,
-            registers);
+            registers, cpu);
         if (return_value !=3D 0) {
             g_assert_not_reached();
         }
@@ -1797,13 +1810,15 @@ void handle_query_regs_f(GArray *params, void *user=
_ctx)
     /* 3. send data */
     mcd_reg_st my_register =3D g_array_index(registers, mcd_reg_st, 0);
     g_string_append_printf(mcdserver_state.str_buf,
-        "%s=3D%d.%s=3D%s.%s=3D%d.%s=3D%d.%s=3D%d.%s=3D%d.%s=3D%d.",
-        TCP_ARGUMENT_ID, my_register.id, TCP_ARGUMENT_NAME,
-        my_register.name, TCP_ARGUMENT_SIZE, my_register.bitsize,
+        "%s=3D%u.%s=3D%s.%s=3D%u.%s=3D%u.%s=3D%u.%s=3D%u.%s=3D%u.%s=3D%u.",
+        TCP_ARGUMENT_ID, my_register.id,
+        TCP_ARGUMENT_NAME, my_register.name,
+        TCP_ARGUMENT_SIZE, my_register.bitsize,
         TCP_ARGUMENT_REGGROUPID, my_register.mcd_reg_group_id,
         TCP_ARGUMENT_MEMSPACEID, my_register.mcd_mem_space_id,
         TCP_ARGUMENT_TYPE, my_register.mcd_reg_type,
-        TCP_ARGUMENT_THREAD, my_register.mcd_hw_thread_id);
+        TCP_ARGUMENT_THREAD, my_register.mcd_hw_thread_id,
+        TCP_ARGUMENT_OPCODE, my_register.opcode);
     mcd_put_strbuf();
 }
=20
@@ -1829,13 +1844,15 @@ void handle_query_regs_c(GArray *params, void *user=
_ctx)
     /* 3. send the correct register */
     mcd_reg_st my_register =3D g_array_index(registers, mcd_reg_st, query_=
index);
     g_string_append_printf(mcdserver_state.str_buf,
-        "%s=3D%d.%s=3D%s.%s=3D%d.%s=3D%d.%s=3D%d.%s=3D%d.%s=3D%d.",
-        TCP_ARGUMENT_ID, my_register.id, TCP_ARGUMENT_NAME,
-        my_register.name, TCP_ARGUMENT_SIZE, my_register.bitsize,
+        "%s=3D%u.%s=3D%s.%s=3D%u.%s=3D%u.%s=3D%u.%s=3D%u.%s=3D%u.%s=3D%u.",
+        TCP_ARGUMENT_ID, my_register.id,
+        TCP_ARGUMENT_NAME, my_register.name,
+        TCP_ARGUMENT_SIZE, my_register.bitsize,
         TCP_ARGUMENT_REGGROUPID, my_register.mcd_reg_group_id,
         TCP_ARGUMENT_MEMSPACEID, my_register.mcd_mem_space_id,
         TCP_ARGUMENT_TYPE, my_register.mcd_reg_type,
-        TCP_ARGUMENT_THREAD, my_register.mcd_hw_thread_id);
+        TCP_ARGUMENT_THREAD, my_register.mcd_hw_thread_id,
+        TCP_ARGUMENT_OPCODE, my_register.opcode);
     mcd_put_strbuf();
 }
=20
@@ -1889,11 +1906,18 @@ void handle_query_state(GArray *params, void *user_=
ctx)
=20
 int mcd_read_register(CPUState *cpu, GByteArray *buf, int reg)
 {
+    /* 1. get reg type and internal id */
+    GArray *registers =3D
+        g_list_nth_data(mcdserver_state.all_registers, cpu->cpu_index);
+    mcd_reg_st desired_register =3D g_array_index(registers, mcd_reg_st, r=
eg);
+    uint8_t reg_type =3D desired_register.reg_type;
+    uint32_t internal_id =3D desired_register.internal_id;
+    /* 2. read register */
     CPUClass *cc =3D CPU_GET_CLASS(cpu);
     gchar *arch =3D cc->gdb_arch_name(cpu);
     if (strcmp(arch, "arm") =3D=3D 0) {
         g_free(arch);
-        return arm_mcd_read_register(cpu, buf, reg);
+        return arm_mcd_read_register(cpu, buf, reg_type, internal_id);
     } else {
         g_free(arch);
         return 0;
@@ -1902,11 +1926,18 @@ int mcd_read_register(CPUState *cpu, GByteArray *bu=
f, int reg)
=20
 int mcd_write_register(CPUState *cpu, GByteArray *buf, int reg)
 {
+    /* 1. get reg type and internal id */
+    GArray *registers =3D
+        g_list_nth_data(mcdserver_state.all_registers, cpu->cpu_index);
+    mcd_reg_st desired_register =3D g_array_index(registers, mcd_reg_st, r=
eg);
+    uint8_t reg_type =3D desired_register.reg_type;
+    uint32_t internal_id =3D desired_register.internal_id;
+    /* 2. write register */
     CPUClass *cc =3D CPU_GET_CLASS(cpu);
     gchar *arch =3D cc->gdb_arch_name(cpu);
     if (strcmp(arch, "arm") =3D=3D 0) {
         g_free(arch);
-        return arm_mcd_write_register(cpu, buf, reg);
+        return arm_mcd_write_register(cpu, buf, reg_type, internal_id);
     } else {
         g_free(arch);
         return 0;
diff --git a/mcdstub/mcdstub.h b/mcdstub/mcdstub.h
index 7a63a01a39..25475acaf7 100644
--- a/mcdstub/mcdstub.h
+++ b/mcdstub/mcdstub.h
@@ -203,19 +203,16 @@ typedef struct mcd_reg_st {
     char group[64];
     char type[64];
     uint32_t bitsize;
-    uint32_t id;
+    uint32_t id; /* id used by the mcd interface */
+    uint32_t internal_id; /* id inside reg type */
+    uint8_t reg_type;
     /* mcd metadata */
     uint32_t mcd_reg_group_id;
     uint32_t mcd_mem_space_id;
     uint32_t mcd_reg_type;
     uint32_t mcd_hw_thread_id;
     /* data for op-code */
-    uint8_t cp;
-    uint8_t crn;
-    uint8_t crm;
-    uint8_t opc0; /* <- might not be needed! */
-    uint8_t opc1;
-    uint8_t opc2;
+    uint32_t opcode;
 } mcd_reg_st;
=20
 typedef struct mcd_reset_st {
@@ -307,7 +304,8 @@ void handle_query_mem_spaces_c(GArray *params, void *us=
er_ctx);
 void handle_query_regs_f(GArray *params, void *user_ctx);
 void handle_query_regs_c(GArray *params, void *user_ctx);
 void handle_open_server(GArray *params, void *user_ctx);
-void parse_reg_xml(const char *xml, int size, GArray* registers);
+void parse_reg_xml(const char *xml, int size, GArray* registers,
+    uint8_t reg_type);
 void handle_reset(GArray *params, void *user_ctx);
 void handle_query_state(GArray *params, void *user_ctx);
 void handle_read_register(GArray *params, void *user_ctx);
@@ -329,8 +327,8 @@ int mcd_arm_parse_core_xml_file(CPUClass *cc, GArray *r=
eggroups,
     GArray *registers, int *current_group_id);
 int mcd_arm_parse_general_xml_files(CPUState *cpu, GArray* reggroups,
     GArray *registers, int *current_group_id);
-int mcd_arm_get_additional_register_info(GArray *reggroups, GArray *regist=
ers);
-
+int mcd_arm_get_additional_register_info(GArray *reggroups, GArray *regist=
ers,
+    CPUState *cpu);
 /* sycall handling */
 void mcd_syscall_reset(void);
 void mcd_disable_syscalls(void);
diff --git a/target/arm/mcdstub.c b/target/arm/mcdstub.c
index e4e632d3f3..c0bd5bb545 100644
--- a/target/arm/mcdstub.c
+++ b/target/arm/mcdstub.c
@@ -17,6 +17,31 @@ static inline int mcd_get_reg32(GByteArray *buf, uint32_=
t val)
     return 4;
 }
=20
+static inline int mcd_get_reg64(GByteArray *buf, uint64_t val)
+{
+    uint64_t to_quad =3D tswap64(val);
+    g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
+    return 8;
+}
+
+static inline int mcd_get_reg128(GByteArray *buf, uint64_t val_hi,
+                                 uint64_t val_lo)
+{
+    uint64_t to_quad;
+#if TARGET_BIG_ENDIAN
+    to_quad =3D tswap64(val_hi);
+    g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
+    to_quad =3D tswap64(val_lo);
+    g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
+#else
+    to_quad =3D tswap64(val_lo);
+    g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
+    to_quad =3D tswap64(val_hi);
+    g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
+#endif
+    return 16;
+}
+
 static inline int mcd_get_zeroes(GByteArray *array, size_t len)
 {
     /*TODO: move this to a separate file */
@@ -45,24 +70,13 @@ const char *arm_mcd_get_dynamic_xml(CPUState *cs, const=
 char *xmlname)
     return NULL;
 }
=20
-int arm_mcd_read_register(CPUState *cs, GByteArray *mem_buf, int n)
+static int arm_mcd_read_gpr_register(CPUARMState *env, GByteArray *mem_buf,
+    uint32_t n)
 {
-    ARMCPU *cpu =3D ARM_CPU(cs);
-    CPUARMState *env =3D &cpu->env;
-
     if (n < 16) {
         /* Core integer register.  */
         return mcd_get_reg32(mem_buf, env->regs[n]);
-    }
-    if (n < 24) {
-        /* TODO: these numbers don't match mine */
-        return mcd_get_zeroes(mem_buf, 12);
-    }
-    switch (n) {
-    case 24:
-        /* TODO: these numbers don't match mine */
-        return mcd_get_reg32(mem_buf, 0);
-    case 25:
+    } else if (n =3D=3D 16) {
         /* CPSR, or XPSR for M-profile */
         if (arm_feature(env, ARM_FEATURE_M)) {
             return mcd_get_reg32(mem_buf, xpsr_read(env));
@@ -70,21 +84,17 @@ int arm_mcd_read_register(CPUState *cs, GByteArray *mem=
_buf, int n)
             return mcd_get_reg32(mem_buf, cpsr_read(env));
         }
     }
-    /* TODO: add funcitons for the remaining regs (including cp_regs) */
     return 0;
 }
=20
-int arm_mcd_write_register(CPUState *cs, GByteArray *mem_buf, int n)
+static int arm_mcd_write_gpr_register(CPUARMState *env, uint8_t *mem_buf,
+    uint32_t n)
 {
-    ARMCPU *cpu =3D ARM_CPU(cs);
-    CPUARMState *env =3D &cpu->env;
     uint32_t tmp;
=20
     tmp =3D ldl_p(mem_buf);
-    tmp =3D *((uint32_t *)mem_buf->data);
-
     /*
-     * Mask out low bits of PC to workaround gdb bugs.
+     * Mask out low bits of PC
      * This avoids an assert in thumb_tr_translate_insn, because it is
      * architecturally impossible to misalign the pc.
      * This will probably cause problems if we ever implement the
@@ -102,16 +112,7 @@ int arm_mcd_write_register(CPUState *cs, GByteArray *m=
em_buf, int n)
         }
         env->regs[n] =3D tmp;
         return 4;
-    }
-    if (n < 24) { /* 16-23 */
-        /* FPA registers (ignored).  */
-        return 4;
-    }
-    switch (n) {
-    case 24:
-        /* FPA status register (ignored).  */
-        return 4;
-    case 25:
+    } else if (n =3D=3D 16) {
         /* CPSR, or XPSR for M-profile */
         if (arm_feature(env, ARM_FEATURE_M)) {
             /*
@@ -126,6 +127,206 @@ int arm_mcd_write_register(CPUState *cs, GByteArray *=
mem_buf, int n)
         }
         return 4;
     }
-    /* TODO: add funcitons for the remaining regs (including cp_regs) */
+    return 0;
+}
+
+static int arm_mcd_read_vfp_register(CPUARMState *env, GByteArray *buf,
+    uint32_t reg)
+{
+    ARMCPU *cpu =3D env_archcpu(env);
+    int nregs =3D cpu_isar_feature(aa32_simd_r32, cpu) ? 32 : 16;
+
+    /* VFP data registers are always little-endian.  */
+    if (reg < nregs) {
+        return mcd_get_reg64(buf, *aa32_vfp_dreg(env, reg));
+    }
+    if (arm_feature(env, ARM_FEATURE_NEON)) {
+        /* Aliases for Q regs.  */
+        nregs +=3D 16;
+        if (reg < nregs) {
+            uint64_t *q =3D aa32_vfp_qreg(env, reg - 32);
+            return mcd_get_reg128(buf, q[0], q[1]);
+        }
+    }
+    switch (reg - nregs) {
+    case 0:
+        return mcd_get_reg32(buf, vfp_get_fpscr(env));
+    }
+    return 0;
+}
+
+static int arm_mcd_write_vfp_register(CPUARMState *env, uint8_t *buf,
+    uint32_t reg)
+{
+    ARMCPU *cpu =3D env_archcpu(env);
+    int nregs =3D cpu_isar_feature(aa32_simd_r32, cpu) ? 32 : 16;
+
+    if (reg < nregs) {
+        *aa32_vfp_dreg(env, reg) =3D ldq_le_p(buf);
+        return 8;
+    }
+    if (arm_feature(env, ARM_FEATURE_NEON)) {
+        nregs +=3D 16;
+        if (reg < nregs) {
+            uint64_t *q =3D aa32_vfp_qreg(env, reg - 32);
+            q[0] =3D ldq_le_p(buf);
+            q[1] =3D ldq_le_p(buf + 8);
+            return 16;
+        }
+    }
+    switch (reg - nregs) {
+    case 0:
+        vfp_set_fpscr(env, ldl_p(buf));
+        return 4;
+    }
+    return 0;
+}
+
+static int arm_mcd_read_vfp_sys_register(CPUARMState *env, GByteArray *buf,
+    uint32_t reg)
+{
+    switch (reg) {
+    case 0:
+        return mcd_get_reg32(buf, env->vfp.xregs[ARM_VFP_FPSID]);
+    case 1:
+        return mcd_get_reg32(buf, env->vfp.xregs[ARM_VFP_FPEXC]);
+    }
+    return 0;
+}
+
+static int arm_mcd_write_vfp_sys_register(CPUARMState *env, uint8_t *buf,
+    uint32_t reg)
+{
+    switch (reg) {
+    case 0:
+        env->vfp.xregs[ARM_VFP_FPSID] =3D ldl_p(buf);
+        return 4;
+    case 1:
+        env->vfp.xregs[ARM_VFP_FPEXC] =3D ldl_p(buf) & (1 << 30);
+        return 4;
+    }
+    return 0;
+}
+
+static int arm_mcd_read_mve_register(CPUARMState *env, GByteArray *buf,
+    uint32_t reg)
+{
+    switch (reg) {
+    case 0:
+        return mcd_get_reg32(buf, env->v7m.vpr);
+    default:
+        return 0;
+    }
+}
+
+static int arm_mcd_write_mve_register(CPUARMState *env, uint8_t *buf,
+    uint32_t reg)
+{
+    switch (reg) {
+    case 0:
+        env->v7m.vpr =3D ldl_p(buf);
+        return 4;
+    default:
+        return 0;
+    }
+}
+
+static int arm_mcd_read_cpr_register(CPUARMState *env, GByteArray *buf,
+    uint32_t reg)
+{
+    ARMCPU *cpu =3D env_archcpu(env);
+    const ARMCPRegInfo *ri;
+    uint32_t key;
+
+    key =3D cpu->dyn_sysreg_xml.data.cpregs.keys[reg];
+    ri =3D get_arm_cp_reginfo(cpu->cp_regs, key);
+    if (ri) {
+        if (cpreg_field_is_64bit(ri)) {
+            return mcd_get_reg64(buf, (uint64_t)read_raw_cp_reg(env, ri));
+        } else {
+            return mcd_get_reg32(buf, (uint32_t)read_raw_cp_reg(env, ri));
+        }
+    }
+    return 0;
+}
+
+static int arm_mcd_write_cpr_register(CPUARMState *env, uint8_t *buf,
+    uint32_t reg)
+{
+    /* try write_raw_cp_reg here*/
+    return 0;
+}
+
+int arm_mcd_read_register(CPUState *cs, GByteArray *mem_buf, uint8_t reg_t=
ype,
+    uint32_t n)
+{
+    ARMCPU *cpu =3D ARM_CPU(cs);
+    CPUARMState *env =3D &cpu->env;
+    switch (reg_type) {
+    case MCD_ARM_REG_TYPE_GPR:
+        return arm_mcd_read_gpr_register(env, mem_buf, n);
+        break;
+    case MCD_ARM_REG_TYPE_VFP:
+        return arm_mcd_read_vfp_register(env, mem_buf, n);
+        break;
+    case MCD_ARM_REG_TYPE_VFP_SYS:
+        return arm_mcd_read_vfp_sys_register(env, mem_buf, n);
+        break;
+    case MCD_ARM_REG_TYPE_MVE:
+        return arm_mcd_read_mve_register(env, mem_buf, n);
+        break;
+    case MCD_ARM_REG_TYPE_CPR:
+        return arm_mcd_read_cpr_register(env, mem_buf, n);
+        break;
+    default:
+        /* unknown register type*/
+        return 0;
+    }
+}
+
+int arm_mcd_write_register(CPUState *cs, GByteArray *mem_buf, uint8_t reg_=
type,
+    uint32_t n)
+{
+    ARMCPU *cpu =3D ARM_CPU(cs);
+    CPUARMState *env =3D &cpu->env;
+    switch (reg_type) {
+    case MCD_ARM_REG_TYPE_GPR:
+        return arm_mcd_write_gpr_register(env, mem_buf->data, n);
+        break;
+    case MCD_ARM_REG_TYPE_VFP:
+        return arm_mcd_write_vfp_register(env, mem_buf->data, n);
+        break;
+    case MCD_ARM_REG_TYPE_VFP_SYS:
+        return arm_mcd_write_vfp_sys_register(env, mem_buf->data, n);
+        break;
+    case MCD_ARM_REG_TYPE_MVE:
+        return arm_mcd_write_mve_register(env, mem_buf->data, n);
+        break;
+    case MCD_ARM_REG_TYPE_CPR:
+        return arm_mcd_write_cpr_register(env, mem_buf->data, n);
+        break;
+    default:
+        /* unknown register type*/
+        return 0;
+    }
+}
+
+uint16_t arm_mcd_get_opcode(CPUState *cs, uint32_t n)
+{
+    /*gets the opcode for a cp register*/
+    ARMCPU *cpu =3D ARM_CPU(cs);
+    const ARMCPRegInfo *ri;
+    uint32_t key;
+
+    key =3D cpu->dyn_sysreg_xml.data.cpregs.keys[n];
+    ri =3D get_arm_cp_reginfo(cpu->cp_regs, key);
+    if (ri) {
+        uint16_t opcode =3D 0;
+        opcode |=3D ri->opc1 << 14;
+        opcode |=3D ri->opc2 << 10;
+        opcode |=3D ri->crm << 7;
+        opcode |=3D ri->crn << 3;
+        return opcode;
+    }
     return 0;
 }
diff --git a/target/arm/mcdstub.h b/target/arm/mcdstub.h
index 28c7f2baec..81d67246d8 100644
--- a/target/arm/mcdstub.h
+++ b/target/arm/mcdstub.h
@@ -1,8 +1,20 @@
 #ifndef ARM_MCDSTUB_H
 #define ARM_MCDSTUB_H
=20
+/* ids for each different type of register */
+enum {
+    MCD_ARM_REG_TYPE_GPR,
+    MCD_ARM_REG_TYPE_VFP,
+    MCD_ARM_REG_TYPE_VFP_SYS,
+    MCD_ARM_REG_TYPE_MVE,
+    MCD_ARM_REG_TYPE_CPR,
+};
+
 const char *arm_mcd_get_dynamic_xml(CPUState *cs, const char *xmlname);
-int arm_mcd_read_register(CPUState *cs, GByteArray *mem_buf, int n);
-int arm_mcd_write_register(CPUState *cs, GByteArray *mem_buf, int n);
+int arm_mcd_read_register(CPUState *cs, GByteArray *mem_buf, uint8_t reg_t=
ype,
+    uint32_t n);
+int arm_mcd_write_register(CPUState *cs, GByteArray *mem_buf, uint8_t reg_=
type,
+    uint32_t n);
+uint16_t arm_mcd_get_opcode(CPUState *cs, uint32_t n);
=20
 #endif /* ARM_MCDSTUB_H */
--=20
2.34.1


From c59ef5b700e25c8f4b739354377117903b94ab08 Mon Sep 17 00:00:00 2001
From: Nicolas Eder <nicolas.eder@lauterbach.com>
Date: Wed, 19 Jul 2023 17:07:45 +0200
Subject: [PATCH 21/29] switching between secure and non-secure memory added

Signed-off-by: Nicolas Eder <nicolas.eder@lauterbach.com>
---
 mcdstub/mcdstub.c    | 131 +++++++++++++++++++++++++++----------------
 mcdstub/mcdstub.h    |   4 +-
 target/arm/mcdstub.c |  14 +++++
 target/arm/mcdstub.h |   1 +
 4 files changed, 100 insertions(+), 50 deletions(-)

diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index 3772bda0a1..7d8ce634c8 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -548,8 +548,8 @@ int mcd_handle_packet(const char *line_buf)
             };
             read_mem_cmd_desc.cmd =3D (char[2]) { TCP_CHAR_READ_MEMORY, '\=
0' };
             strcpy(read_mem_cmd_desc.schema,
-                (char[4]) { ARG_SCHEMA_CORENUM, ARG_SCHEMA_UINT64_T,
-                ARG_SCHEMA_INT, '\0' });
+                (char[5]) { ARG_SCHEMA_CORENUM, ARG_SCHEMA_INT,
+                ARG_SCHEMA_UINT64_T, ARG_SCHEMA_INT, '\0' });
             cmd_parser =3D &read_mem_cmd_desc;
         }
         break;
@@ -560,8 +560,9 @@ int mcd_handle_packet(const char *line_buf)
             };
             write_mem_cmd_desc.cmd =3D (char[2]) { TCP_CHAR_WRITE_MEMORY, =
'\0' };
             strcpy(write_mem_cmd_desc.schema,
-                (char[5]) { ARG_SCHEMA_CORENUM, ARG_SCHEMA_UINT64_T,
-                ARG_SCHEMA_INT, ARG_SCHEMA_HEXDATA, '\0' });
+                (char[6]) { ARG_SCHEMA_CORENUM, ARG_SCHEMA_INT,
+                ARG_SCHEMA_UINT64_T, ARG_SCHEMA_INT,
+                ARG_SCHEMA_HEXDATA, '\0' });
             cmd_parser =3D &write_mem_cmd_desc;
         }
         break;
@@ -1194,10 +1195,17 @@ int int_cmp(gconstpointer a, gconstpointer b)
 int mcd_arm_store_mem_spaces(CPUState *cpu, GArray *memspaces)
 {
     int nr_address_spaces =3D cpu->num_ases;
+    uint32_t mem_space_id =3D 0;
+
+    /*
+     * TODO: atm we can only access physical memory addresses,
+     * but trace32 needs fake locical spaces to work with
+    */
=20
-    mcd_mem_space_st space1 =3D {
+    mem_space_id++;
+    mcd_mem_space_st non_secure =3D {
         .name =3D "Non Secure",
-        .id =3D 1,
+        .id =3D mem_space_id,
         .type =3D 34,
         .bits_per_mau =3D 8,
         .invariance =3D 1,
@@ -1205,38 +1213,13 @@ int mcd_arm_store_mem_spaces(CPUState *cpu, GArray =
*memspaces)
         .min_addr =3D 0,
         .max_addr =3D -1,
         .supported_access_options =3D 0,
+        .is_secure =3D false,
     };
-    g_array_append_vals(memspaces, (gconstpointer)&space1, 1);
-
-    mcd_mem_space_st space2 =3D {
+    g_array_append_vals(memspaces, (gconstpointer)&non_secure, 1);
+    mem_space_id++;
+    mcd_mem_space_st phys_non_secure =3D {
         .name =3D "Physical (Non Secure)",
-        .id =3D 2,
-        .type =3D 18,
-        .bits_per_mau =3D 8,
-        .invariance =3D 1,
-        .endian =3D 1,
-        .min_addr =3D 0,
-        .max_addr =3D -1,
-        .supported_access_options =3D 0,
-    };
-    g_array_append_vals(memspaces, (gconstpointer)&space2, 1);
-
-    if (nr_address_spaces =3D=3D 2) {
-        mcd_mem_space_st space3 =3D {
-        .name =3D "Secure",
-        .id =3D 3,
-        .type =3D 34,
-        .bits_per_mau =3D 8,
-        .invariance =3D 1,
-        .endian =3D 1,
-        .min_addr =3D 0,
-        .max_addr =3D -1,
-        .supported_access_options =3D 0,
-    };
-    g_array_append_vals(memspaces, (gconstpointer)&space3, 1);
-    mcd_mem_space_st space4 =3D {
-        .name =3D "Physical (Secure)",
-        .id =3D 4,
+        .id =3D mem_space_id,
         .type =3D 18,
         .bits_per_mau =3D 8,
         .invariance =3D 1,
@@ -1244,14 +1227,44 @@ int mcd_arm_store_mem_spaces(CPUState *cpu, GArray =
*memspaces)
         .min_addr =3D 0,
         .max_addr =3D -1,
         .supported_access_options =3D 0,
+        .is_secure =3D false,
     };
-    g_array_append_vals(memspaces, (gconstpointer)&space4, 1);
+    g_array_append_vals(memspaces, (gconstpointer)&phys_non_secure, 1);
+    if(nr_address_spaces > 1) {
+        mem_space_id++;
+        mcd_mem_space_st secure =3D {
+            .name =3D "Secure",
+            .id =3D mem_space_id,
+            .type =3D 34,
+            .bits_per_mau =3D 8,
+            .invariance =3D 1,
+            .endian =3D 1,
+            .min_addr =3D 0,
+            .max_addr =3D -1,
+            .supported_access_options =3D 0,
+            .is_secure =3D true,
+        };
+        g_array_append_vals(memspaces, (gconstpointer)&secure, 1);
+        mem_space_id++;
+        mcd_mem_space_st phys_secure =3D {
+            .name =3D "Physical (Secure)",
+            .id =3D mem_space_id,
+            .type =3D 18,
+            .bits_per_mau =3D 8,
+            .invariance =3D 1,
+            .endian =3D 1,
+            .min_addr =3D 0,
+            .max_addr =3D -1,
+            .supported_access_options =3D 0,
+            .is_secure =3D true,
+        };
+        g_array_append_vals(memspaces, (gconstpointer)&phys_secure, 1);
     }
-
     /* TODO: get dynamically how the per (CP15) space is called */
-    mcd_mem_space_st space5 =3D {
+    mem_space_id++;
+    mcd_mem_space_st gpr =3D {
         .name =3D "GPR Registers",
-        .id =3D 5,
+        .id =3D mem_space_id,
         .type =3D 1,
         .bits_per_mau =3D 8,
         .invariance =3D 1,
@@ -1260,10 +1273,11 @@ int mcd_arm_store_mem_spaces(CPUState *cpu, GArray =
*memspaces)
         .max_addr =3D -1,
         .supported_access_options =3D 0,
     };
-    g_array_append_vals(memspaces, (gconstpointer)&space5, 1);
-    mcd_mem_space_st space6 =3D {
+    g_array_append_vals(memspaces, (gconstpointer)&gpr, 1);
+    mem_space_id++;
+    mcd_mem_space_st cpr =3D {
         .name =3D "CP15 Registers",
-        .id =3D 6,
+        .id =3D mem_space_id,
         .type =3D 1,
         .bits_per_mau =3D 8,
         .invariance =3D 1,
@@ -1272,7 +1286,7 @@ int mcd_arm_store_mem_spaces(CPUState *cpu, GArray *m=
emspaces)
         .max_addr =3D -1,
         .supported_access_options =3D 0,
     };
-    g_array_append_vals(memspaces, (gconstpointer)&space6, 1);
+    g_array_append_vals(memspaces, (gconstpointer)&cpr, 1);
     return 0;
 }
=20
@@ -2022,10 +2036,20 @@ int mcd_write_memory(CPUState *cpu, hwaddr addr, ui=
nt8_t *buf, int len)
 void handle_read_memory(GArray *params, void *user_ctx)
 {
     uint32_t cpu_id =3D get_param(params, 0)->cpu_id;
-    uint64_t mem_address =3D get_param(params, 1)->data_uint64_t;
-    uint32_t len =3D get_param(params, 2)->data_uint32_t;
+    uint32_t mem_space_id =3D get_param(params, 1)->data_uint32_t;
+    uint64_t mem_address =3D get_param(params, 2)->data_uint64_t;
+    uint32_t len =3D get_param(params, 3)->data_uint32_t;
=20
     CPUState *cpu =3D mcd_get_cpu(cpu_id);
+    /* check if the mem space is secure */
+    GArray *memspaces =3D g_list_nth_data(mcdserver_state.all_memspaces, c=
pu_id);
+    mcd_mem_space_st space =3D g_array_index(memspaces, mcd_mem_space_st,
+        mem_space_id - 1);
+    if (arm_mcd_set_scr(cpu, space.is_secure)) {
+        mcd_put_packet(TCP_EXECUTION_ERROR);
+        return;
+    }
+    /* read memory */
     g_byte_array_set_size(mcdserver_state.mem_buf, len);
     if (mcd_read_memory(cpu, mem_address, mcdserver_state.mem_buf->data,
         mcdserver_state.mem_buf->len) !=3D 0) {
@@ -2040,10 +2064,19 @@ void handle_read_memory(GArray *params, void *user_=
ctx)
 void handle_write_memory(GArray *params, void *user_ctx)
 {
     uint32_t cpu_id =3D get_param(params, 0)->cpu_id;
-    uint64_t mem_address =3D get_param(params, 1)->data_uint64_t;
-    uint32_t len =3D get_param(params, 2)->data_uint32_t;
-
+    uint32_t mem_space_id =3D get_param(params, 1)->data_uint32_t;
+    uint64_t mem_address =3D get_param(params, 2)->data_uint64_t;
+    uint32_t len =3D get_param(params, 3)->data_uint32_t;
     CPUState *cpu =3D mcd_get_cpu(cpu_id);
+    /* check if the mem space is secure */
+    GArray *memspaces =3D g_list_nth_data(mcdserver_state.all_memspaces, c=
pu_id);
+    mcd_mem_space_st space =3D g_array_index(memspaces, mcd_mem_space_st,
+        mem_space_id - 1);
+    if (arm_mcd_set_scr(cpu, space.is_secure)) {
+        mcd_put_packet(TCP_EXECUTION_ERROR);
+        return;
+    }
+    /* read memory */
     mcd_hextomem(mcdserver_state.mem_buf, mcdserver_state.str_buf->str, le=
n);
     if (mcd_write_memory(cpu, mem_address,
         mcdserver_state.mem_buf->data, len) !=3D 0) {
diff --git a/mcdstub/mcdstub.h b/mcdstub/mcdstub.h
index 25475acaf7..f8171cba71 100644
--- a/mcdstub/mcdstub.h
+++ b/mcdstub/mcdstub.h
@@ -58,7 +58,7 @@ enum {
=20
 /* misc */
 #define QUERY_TOTAL_NUMBER 12
-#define CMD_SCHEMA_LENGTH 5
+#define CMD_SCHEMA_LENGTH 6
 #define MCD_SYSTEM_NAME "qemu-system"
=20
 /* tcp query packet values templates */
@@ -185,6 +185,8 @@ typedef struct mcd_mem_space_st {
     uint64_t min_addr;
     uint64_t max_addr;
     uint32_t supported_access_options;
+    /* internal */
+    bool is_secure;
 } mcd_mem_space_st;
=20
 typedef struct mcd_reg_group_st {
diff --git a/target/arm/mcdstub.c b/target/arm/mcdstub.c
index c0bd5bb545..8456352370 100644
--- a/target/arm/mcdstub.c
+++ b/target/arm/mcdstub.c
@@ -330,3 +330,17 @@ uint16_t arm_mcd_get_opcode(CPUState *cs, uint32_t n)
     }
     return 0;
 }
+
+int arm_mcd_set_scr(CPUState *cs, bool secure)
+{
+    /* swtiches between secure and non secure mode */
+    ARMCPU *cpu =3D ARM_CPU(cs);
+    CPUARMState *env =3D &cpu->env;
+    /* set bit 0 to 1 if non secure, to 0 if secure*/
+    if (secure) {
+        env->cp15.scr_el3 &=3D 0xFFFFFFFE;
+    } else {
+        env->cp15.scr_el3 |=3D 1;
+    }
+    return 0;
+}
diff --git a/target/arm/mcdstub.h b/target/arm/mcdstub.h
index 81d67246d8..c3b5c1ae8d 100644
--- a/target/arm/mcdstub.h
+++ b/target/arm/mcdstub.h
@@ -16,5 +16,6 @@ int arm_mcd_read_register(CPUState *cs, GByteArray *mem_b=
uf, uint8_t reg_type,
 int arm_mcd_write_register(CPUState *cs, GByteArray *mem_buf, uint8_t reg_=
type,
     uint32_t n);
 uint16_t arm_mcd_get_opcode(CPUState *cs, uint32_t n);
+int arm_mcd_set_scr(CPUState *cs, bool secure);
=20
 #endif /* ARM_MCDSTUB_H */
--=20
2.34.1


From 64b4aacccd13fe0e642b5c233adc457bbc4c0c9e Mon Sep 17 00:00:00 2001
From: Nicolas Eder <nicolas.eder@lauterbach.com>
Date: Sat, 22 Jul 2023 16:55:45 +0200
Subject: [PATCH 22/29] transitioning to unsinged integers in TCP packets and
 removing MCD-API-specific terms

Signed-off-by: Nicolas Eder <nicolas.eder@lauterbach.com>
---
 mcdstub/mcd_shared_defines.h |  8 ++++
 mcdstub/mcdstub.c            | 74 ++++++++++++++++++++----------------
 mcdstub/mcdstub.h            | 33 +++++-----------
 target/arm/mcdstub.c         |  2 +-
 4 files changed, 60 insertions(+), 57 deletions(-)

diff --git a/mcdstub/mcd_shared_defines.h b/mcdstub/mcd_shared_defines.h
index 91d476a555..5cfda4121d 100644
--- a/mcdstub/mcd_shared_defines.h
+++ b/mcdstub/mcd_shared_defines.h
@@ -91,4 +91,12 @@
 #define MCD_BREAKPOINT_WRITE 3
 #define MCD_BREAKPOINT_RW 4
=20
+/* trigger data */
+#define MCD_TRIG_ACT_BREAK "check_data_value"
+#define MCD_TRIG_OPT_VALUE "break_on_trigger"
+
+/* register mem space key words */
+#define MCD_GRP_KEYWORD "GPR"
+#define MCD_CP_KEYWORD "CP"
+
 #endif
diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index 7d8ce634c8..8e711a0a40 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -1303,12 +1303,15 @@ int init_resets(GArray *resets)
=20
 int init_trigger(mcd_trigger_into_st *trigger)
 {
-    trigger->type =3D (MCD_TRIG_TYPE_IP | MCD_TRIG_TYPE_READ |
-        MCD_TRIG_TYPE_WRITE | MCD_TRIG_TYPE_RW);
-    trigger->option =3D (MCD_TRIG_OPT_DATA_IS_CONDITION);
-    trigger->action =3D (MCD_TRIG_ACTION_DBG_DEBUG);
-    /* there is no specific upper limit for trigger */
-    trigger->nr_trigger =3D 0;
+    snprintf(trigger->type, sizeof(trigger->type),
+        "%d,%d,%d,%d", MCD_BREAKPOINT_HW, MCD_BREAKPOINT_READ,
+        MCD_BREAKPOINT_WRITE, MCD_BREAKPOINT_RW);
+    snprintf(trigger->option, sizeof(trigger->option),
+        "%s", MCD_TRIG_OPT_VALUE);
+    snprintf(trigger->action, sizeof(trigger->action),
+        "%s", MCD_TRIG_ACT_BREAK);
+    /* there can be 16 breakpoints and 16 watchpoints each */
+    trigger->nr_trigger =3D 16;
     return 0;
 }
=20
@@ -1348,9 +1351,9 @@ void handle_query_cores(GArray *params, void *user_ct=
x)
     CPUClass *cc =3D CPU_GET_CLASS(cpu);
     gchar *arch =3D cc->gdb_arch_name(cpu);
=20
-    int nr_cores =3D cpu->nr_cores;
+    uint32_t nr_cores =3D cpu->nr_cores;
     char device_name[] =3D DEVICE_NAME_TEMPLATE(arch);
-    g_string_printf(mcdserver_state.str_buf, "%s=3D%s.%s=3D%s.%s=3D%d.",
+    g_string_printf(mcdserver_state.str_buf, "%s=3D%s.%s=3D%s.%s=3D%u.",
         TCP_ARGUMENT_DEVICE, device_name, TCP_ARGUMENT_CORE, cpu_model,
         TCP_ARGUMENT_AMOUNT_CORE, nr_cores);
     mcd_put_strbuf();
@@ -1576,7 +1579,7 @@ void handle_query_reset_f(GArray *params, void *user_=
ctx)
     }
     /* 2. send data */
     mcd_reset_st reset =3D g_array_index(mcdserver_state.resets, mcd_reset=
_st, 0);
-    g_string_append_printf(mcdserver_state.str_buf, "%s=3D%s.%s=3D%d.",
+    g_string_append_printf(mcdserver_state.str_buf, "%s=3D%s.%s=3D%u.",
         TCP_ARGUMENT_NAME, reset.name, TCP_ARGUMENT_ID, reset.id);
     mcd_put_strbuf();
 }
@@ -1592,13 +1595,13 @@ void handle_query_reset_c(GArray *params, void *use=
r_ctx)
         /* indicates this is the last packet */
         g_string_printf(mcdserver_state.str_buf, "0!");
     } else {
-        g_string_printf(mcdserver_state.str_buf, "%d!", query_index + 1);
+        g_string_printf(mcdserver_state.str_buf, "%u!", query_index + 1);
     }
=20
     /* 2. send data */
     mcd_reset_st reset =3D g_array_index(mcdserver_state.resets,
         mcd_reset_st, query_index);
-    g_string_append_printf(mcdserver_state.str_buf, "%s=3D%s.%s=3D%d.",
+    g_string_append_printf(mcdserver_state.str_buf, "%s=3D%s.%s=3D%u.",
         TCP_ARGUMENT_NAME, reset.name, TCP_ARGUMENT_ID, reset.id);
     mcd_put_strbuf();
 }
@@ -1652,9 +1655,10 @@ void handle_close_server(GArray *params, void *user_=
ctx)
 void handle_query_trigger(GArray *params, void *user_ctx)
 {
     mcd_trigger_into_st trigger =3D mcdserver_state.trigger;
-    g_string_printf(mcdserver_state.str_buf, "%s=3D%d.%s=3D%d.%s=3D%d.%s=
=3D%d.",
+    g_string_printf(mcdserver_state.str_buf, "%s=3D%u.%s=3D%s.%s=3D%s.%s=
=3D%s.",
         TCP_ARGUMENT_AMOUNT_TRIGGER, trigger.nr_trigger,
-        TCP_ARGUMENT_TYPE, trigger.type, TCP_ARGUMENT_OPTION, trigger.opti=
on,
+        TCP_ARGUMENT_TYPE, trigger.type,
+        TCP_ARGUMENT_OPTION, trigger.option,
         TCP_ARGUMENT_ACTION, trigger.action);
     mcd_put_strbuf();
 }
@@ -1714,13 +1718,16 @@ void handle_query_mem_spaces_f(GArray *params, void=
 *user_ctx)
     /* 3. send data */
     mcd_mem_space_st space =3D g_array_index(memspaces, mcd_mem_space_st, =
0);
     g_string_append_printf(mcdserver_state.str_buf,
-        "%s=3D%s.%s=3D%d.%s=3D%d.%s=3D%d.%s=3D%d.%s=3D%d.%s=3D%ld.%s=3D%ld=
.%s=3D%d.",
-        TCP_ARGUMENT_NAME, space.name, TCP_ARGUMENT_ID, space.id,
-        TCP_ARGUMENT_TYPE, space.type, TCP_ARGUMENT_BITS_PER_MAU,
-        space.bits_per_mau, TCP_ARGUMENT_INVARIANCE, space.invariance,
-        TCP_ARGUMENT_ENDIAN, space.endian, TCP_ARGUMENT_MIN, space.min_add=
r,
-        TCP_ARGUMENT_MAX, space.max_addr, TCP_ARGUMENT_SUPPORTED_ACCESS_OP=
TIONS,
-        space.supported_access_options);
+        "%s=3D%s.%s=3D%u.%s=3D%u.%s=3D%u.%s=3D%u.%s=3D%u.%s=3D%ld.%s=3D%ld=
.%s=3D%u.",
+        TCP_ARGUMENT_NAME, space.name,
+        TCP_ARGUMENT_ID, space.id,
+        TCP_ARGUMENT_TYPE, space.type,
+        TCP_ARGUMENT_BITS_PER_MAU, space.bits_per_mau,
+        TCP_ARGUMENT_INVARIANCE, space.invariance,
+        TCP_ARGUMENT_ENDIAN, space.endian,
+        TCP_ARGUMENT_MIN, space.min_addr,
+        TCP_ARGUMENT_MAX, space.max_addr,
+        TCP_ARGUMENT_SUPPORTED_ACCESS_OPTIONS, space.supported_access_opti=
ons);
     mcd_put_strbuf();
 }
=20
@@ -1740,20 +1747,23 @@ void handle_query_mem_spaces_c(GArray *params, void=
 *user_ctx)
         /* indicates this is the last packet */
         g_string_printf(mcdserver_state.str_buf, "0!");
     } else {
-        g_string_printf(mcdserver_state.str_buf, "%d!", query_index + 1);
+        g_string_printf(mcdserver_state.str_buf, "%u!", query_index + 1);
     }
=20
     /* 3. send the correct memspace */
     mcd_mem_space_st space =3D g_array_index(memspaces,
         mcd_mem_space_st, query_index);
     g_string_append_printf(mcdserver_state.str_buf,
-        "%s=3D%s.%s=3D%d.%s=3D%d.%s=3D%d.%s=3D%d.%s=3D%d.%s=3D%ld.%s=3D%ld=
.%s=3D%d.",
-        TCP_ARGUMENT_NAME, space.name, TCP_ARGUMENT_ID,
-        space.id, TCP_ARGUMENT_TYPE, space.type, TCP_ARGUMENT_BITS_PER_MAU,
-        space.bits_per_mau, TCP_ARGUMENT_INVARIANCE, space.invariance,
-        TCP_ARGUMENT_ENDIAN, space.endian, TCP_ARGUMENT_MIN, space.min_add=
r,
-        TCP_ARGUMENT_MAX, space.max_addr, TCP_ARGUMENT_SUPPORTED_ACCESS_OP=
TIONS,
-        space.supported_access_options);
+        "%s=3D%s.%s=3D%u.%s=3D%u.%s=3D%u.%s=3D%u.%s=3D%u.%s=3D%ld.%s=3D%ld=
.%s=3D%u.",
+        TCP_ARGUMENT_NAME, space.name,
+        TCP_ARGUMENT_ID, space.id,
+        TCP_ARGUMENT_TYPE, space.type,
+        TCP_ARGUMENT_BITS_PER_MAU, space.bits_per_mau,
+        TCP_ARGUMENT_INVARIANCE, space.invariance,
+        TCP_ARGUMENT_ENDIAN, space.endian,
+        TCP_ARGUMENT_MIN, space.min_addr,
+        TCP_ARGUMENT_MAX, space.max_addr,
+        TCP_ARGUMENT_SUPPORTED_ACCESS_OPTIONS, space.supported_access_opti=
ons);
     mcd_put_strbuf();
 }
=20
@@ -1774,7 +1784,7 @@ void handle_query_reg_groups_f(GArray *params, void *=
user_ctx)
     }
     /* 3. send data */
     mcd_reg_group_st group =3D g_array_index(reggroups, mcd_reg_group_st, =
0);
-    g_string_append_printf(mcdserver_state.str_buf, "%s=3D%d.%s=3D%s.",
+    g_string_append_printf(mcdserver_state.str_buf, "%s=3D%u.%s=3D%s.",
         TCP_ARGUMENT_ID, group.id, TCP_ARGUMENT_NAME, group.name);
     mcd_put_strbuf();
 }
@@ -1795,13 +1805,13 @@ void handle_query_reg_groups_c(GArray *params, void=
 *user_ctx)
         /* indicates this is the last packet */
         g_string_printf(mcdserver_state.str_buf, "0!");
     } else {
-        g_string_printf(mcdserver_state.str_buf, "%d!", query_index + 1);
+        g_string_printf(mcdserver_state.str_buf, "%u!", query_index + 1);
     }
=20
     /* 3. send the correct reggroup */
     mcd_reg_group_st group =3D g_array_index(reggroups, mcd_reg_group_st,
         query_index);
-    g_string_append_printf(mcdserver_state.str_buf, "%s=3D%d.%s=3D%s.",
+    g_string_append_printf(mcdserver_state.str_buf, "%s=3D%u.%s=3D%s.",
         TCP_ARGUMENT_ID, group.id, TCP_ARGUMENT_NAME, group.name);
     mcd_put_strbuf();
 }
@@ -1852,7 +1862,7 @@ void handle_query_regs_c(GArray *params, void *user_c=
tx)
         /* indicates this is the last packet */
         g_string_printf(mcdserver_state.str_buf, "0!");
     } else {
-        g_string_printf(mcdserver_state.str_buf, "%d!", query_index + 1);
+        g_string_printf(mcdserver_state.str_buf, "%u!", query_index + 1);
     }
=20
     /* 3. send the correct register */
diff --git a/mcdstub/mcdstub.h b/mcdstub/mcdstub.h
index f8171cba71..a436551bb1 100644
--- a/mcdstub/mcdstub.h
+++ b/mcdstub/mcdstub.h
@@ -13,22 +13,6 @@
 #define MCD_TRIG_OPT_DATA_IS_CONDITION 0x00000008
 #define MCD_TRIG_ACTION_DBG_DEBUG 0x00000001
=20
-typedef uint32_t mcd_trig_type_et;
-/* TODO: replace mcd defines with custom layer */
-enum {
-    MCD_TRIG_TYPE_UNDEFINED =3D 0x00000000,
-    MCD_TRIG_TYPE_IP        =3D 0x00000001,
-    MCD_TRIG_TYPE_READ      =3D 0x00000002,
-    MCD_TRIG_TYPE_WRITE     =3D 0x00000004,
-    MCD_TRIG_TYPE_RW        =3D 0x00000008,
-    MCD_TRIG_TYPE_NOCYCLE   =3D 0x00000010,
-    MCD_TRIG_TYPE_TRIG_BUS  =3D 0x00000020,
-    MCD_TRIG_TYPE_COUNTER   =3D 0x00000040,
-    MCD_TRIG_TYPE_CUSTOM    =3D 0x00000080,
-    MCD_TRIG_TYPE_CUSTOM_LO =3D 0x00010000,
-    MCD_TRIG_TYPE_CUSTOM_HI =3D 0x40000000,
-};
-
 typedef uint32_t mcd_core_event_et;
 /* TODO: replace mcd defines with custom layer */
 enum {
@@ -60,6 +44,7 @@ enum {
 #define QUERY_TOTAL_NUMBER 12
 #define CMD_SCHEMA_LENGTH 6
 #define MCD_SYSTEM_NAME "qemu-system"
+#define ARGUMENT_STRING_LENGTH 64
=20
 /* tcp query packet values templates */
 #define DEVICE_NAME_TEMPLATE(s) "qemu-" #s "-device"
@@ -126,9 +111,9 @@ typedef struct breakpoint_st {
 } breakpoint_st;
=20
 typedef struct mcd_trigger_into_st {
-    uint32_t type;
-    uint32_t option;
-    uint32_t action;
+    char type[ARGUMENT_STRING_LENGTH];
+    char option[ARGUMENT_STRING_LENGTH];
+    char action[ARGUMENT_STRING_LENGTH];
     uint32_t nr_trigger;
 } mcd_trigger_into_st;
=20
@@ -195,15 +180,15 @@ typedef struct mcd_reg_group_st {
 } mcd_reg_group_st;
=20
 typedef struct xml_attrib {
-    char argument[64];
-    char value[64];
+    char argument[ARGUMENT_STRING_LENGTH];
+    char value[ARGUMENT_STRING_LENGTH];
 } xml_attrib;
=20
 typedef struct mcd_reg_st {
     /* xml info */
-    char name[64];
-    char group[64];
-    char type[64];
+    char name[ARGUMENT_STRING_LENGTH];
+    char group[ARGUMENT_STRING_LENGTH];
+    char type[ARGUMENT_STRING_LENGTH];
     uint32_t bitsize;
     uint32_t id; /* id used by the mcd interface */
     uint32_t internal_id; /* id inside reg type */
diff --git a/target/arm/mcdstub.c b/target/arm/mcdstub.c
index 8456352370..3a35d1062d 100644
--- a/target/arm/mcdstub.c
+++ b/target/arm/mcdstub.c
@@ -333,7 +333,7 @@ uint16_t arm_mcd_get_opcode(CPUState *cs, uint32_t n)
=20
 int arm_mcd_set_scr(CPUState *cs, bool secure)
 {
-    /* swtiches between secure and non secure mode */
+    /* switches between secure and non secure mode */
     ARMCPU *cpu =3D ARM_CPU(cs);
     CPUARMState *env =3D &cpu->env;
     /* set bit 0 to 1 if non secure, to 0 if secure*/
--=20
2.34.1


From 863b297e6e58d285098ca9d21f4a353b4b9658e7 Mon Sep 17 00:00:00 2001
From: Nicolas Eder <nicolas.eder@lauterbach.com>
Date: Wed, 9 Aug 2023 11:26:16 +0200
Subject: [PATCH 23/29] moved all ARM code to the ARM mcdstub and added now
 commom header file

Signed-off-by: Nicolas Eder <nicolas.eder@lauterbach.com>
---
 mcdstub/mcdstub.c        | 244 ++-------------------------------------
 mcdstub/mcdstub.h        |  64 +---------
 mcdstub/mcdstub_common.h |  46 ++++++++
 target/arm/mcdstub.c     | 231 ++++++++++++++++++++++++++++++++++++
 target/arm/mcdstub.h     |  22 ++++
 5 files changed, 310 insertions(+), 297 deletions(-)
 create mode 100644 mcdstub/mcdstub_common.h

diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index 8e711a0a40..b19ca471ea 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -1192,104 +1192,6 @@ int int_cmp(gconstpointer a, gconstpointer b)
     }
 }
=20
-int mcd_arm_store_mem_spaces(CPUState *cpu, GArray *memspaces)
-{
-    int nr_address_spaces =3D cpu->num_ases;
-    uint32_t mem_space_id =3D 0;
-
-    /*
-     * TODO: atm we can only access physical memory addresses,
-     * but trace32 needs fake locical spaces to work with
-    */
-
-    mem_space_id++;
-    mcd_mem_space_st non_secure =3D {
-        .name =3D "Non Secure",
-        .id =3D mem_space_id,
-        .type =3D 34,
-        .bits_per_mau =3D 8,
-        .invariance =3D 1,
-        .endian =3D 1,
-        .min_addr =3D 0,
-        .max_addr =3D -1,
-        .supported_access_options =3D 0,
-        .is_secure =3D false,
-    };
-    g_array_append_vals(memspaces, (gconstpointer)&non_secure, 1);
-    mem_space_id++;
-    mcd_mem_space_st phys_non_secure =3D {
-        .name =3D "Physical (Non Secure)",
-        .id =3D mem_space_id,
-        .type =3D 18,
-        .bits_per_mau =3D 8,
-        .invariance =3D 1,
-        .endian =3D 1,
-        .min_addr =3D 0,
-        .max_addr =3D -1,
-        .supported_access_options =3D 0,
-        .is_secure =3D false,
-    };
-    g_array_append_vals(memspaces, (gconstpointer)&phys_non_secure, 1);
-    if(nr_address_spaces > 1) {
-        mem_space_id++;
-        mcd_mem_space_st secure =3D {
-            .name =3D "Secure",
-            .id =3D mem_space_id,
-            .type =3D 34,
-            .bits_per_mau =3D 8,
-            .invariance =3D 1,
-            .endian =3D 1,
-            .min_addr =3D 0,
-            .max_addr =3D -1,
-            .supported_access_options =3D 0,
-            .is_secure =3D true,
-        };
-        g_array_append_vals(memspaces, (gconstpointer)&secure, 1);
-        mem_space_id++;
-        mcd_mem_space_st phys_secure =3D {
-            .name =3D "Physical (Secure)",
-            .id =3D mem_space_id,
-            .type =3D 18,
-            .bits_per_mau =3D 8,
-            .invariance =3D 1,
-            .endian =3D 1,
-            .min_addr =3D 0,
-            .max_addr =3D -1,
-            .supported_access_options =3D 0,
-            .is_secure =3D true,
-        };
-        g_array_append_vals(memspaces, (gconstpointer)&phys_secure, 1);
-    }
-    /* TODO: get dynamically how the per (CP15) space is called */
-    mem_space_id++;
-    mcd_mem_space_st gpr =3D {
-        .name =3D "GPR Registers",
-        .id =3D mem_space_id,
-        .type =3D 1,
-        .bits_per_mau =3D 8,
-        .invariance =3D 1,
-        .endian =3D 1,
-        .min_addr =3D 0,
-        .max_addr =3D -1,
-        .supported_access_options =3D 0,
-    };
-    g_array_append_vals(memspaces, (gconstpointer)&gpr, 1);
-    mem_space_id++;
-    mcd_mem_space_st cpr =3D {
-        .name =3D "CP15 Registers",
-        .id =3D mem_space_id,
-        .type =3D 1,
-        .bits_per_mau =3D 8,
-        .invariance =3D 1,
-        .endian =3D 1,
-        .min_addr =3D 0,
-        .max_addr =3D -1,
-        .supported_access_options =3D 0,
-    };
-    g_array_append_vals(memspaces, (gconstpointer)&cpr, 1);
-    return 0;
-}
-
 int init_resets(GArray *resets)
 {
     mcd_reset_st system_reset =3D { .id =3D 0, .name =3D RESET_SYSTEM};
@@ -1360,138 +1262,6 @@ void handle_query_cores(GArray *params, void *user_=
ctx)
     g_free(arch);
 }
=20
-int mcd_arm_parse_core_xml_file(CPUClass *cc, GArray *reggroups,
-    GArray *registers, int *current_group_id)
-{
-    const char *xml_filename =3D NULL;
-    const char *current_xml_filename =3D NULL;
-    const char *xml_content =3D NULL;
-    int i =3D 0;
-
-    /* 1. get correct file */
-    xml_filename =3D cc->gdb_core_xml_file;
-    for (i =3D 0; ; i++) {
-        current_xml_filename =3D xml_builtin[i][0];
-        if (!current_xml_filename || (strncmp(current_xml_filename,
-            xml_filename, strlen(xml_filename)) =3D=3D 0
-            && strlen(current_xml_filename) =3D=3D strlen(xml_filename)))
-            break;
-    }
-    /* without gpr registers we can do nothing */
-    if (!current_xml_filename) {
-        return -1;
-    }
-
-    /* 2. add group for gpr registers */
-    mcd_reg_group_st gprregs =3D {
-        .name =3D "GPR Registers",
-        .id =3D *current_group_id
-    };
-    g_array_append_vals(reggroups, (gconstpointer)&gprregs, 1);
-    *current_group_id =3D *current_group_id + 1;
-
-    /* 3. parse xml */
-    xml_content =3D xml_builtin[i][1];
-    parse_reg_xml(xml_content, strlen(xml_content), registers,
-        MCD_ARM_REG_TYPE_GPR);
-    return 0;
-}
-
-int mcd_arm_parse_general_xml_files(CPUState *cpu, GArray *reggroups,
-    GArray *registers, int *current_group_id) {
-    const char *xml_filename =3D NULL;
-    const char *current_xml_filename =3D NULL;
-    const char *xml_content =3D NULL;
-    int i =3D 0;
-    uint8_t reg_type;
-
-    /* iterate over all gdb xml files*/
-    GDBRegisterState *r;
-    for (r =3D cpu->gdb_regs; r; r =3D r->next) {
-        xml_filename =3D r->xml;
-        xml_content =3D NULL;
-
-        /* 1. get xml content */
-        xml_content =3D arm_mcd_get_dynamic_xml(cpu, xml_filename);
-        if (xml_content) {
-            if (strcmp(xml_filename, "system-registers.xml") =3D=3D 0) {
-                /* these are the coprocessor register */
-                mcd_reg_group_st corprocessorregs =3D {
-                    .name =3D "CP15 Registers",
-                    .id =3D *current_group_id
-                };
-                g_array_append_vals(reggroups,
-                    (gconstpointer)&corprocessorregs, 1);
-                *current_group_id =3D *current_group_id + 1;
-                reg_type =3D MCD_ARM_REG_TYPE_CPR;
-            }
-        } else {
-            /* its not a coprocessor xml -> it is a static xml file */
-            for (i =3D 0; ; i++) {
-                current_xml_filename =3D xml_builtin[i][0];
-                if (!current_xml_filename || (strncmp(current_xml_filename,
-                    xml_filename, strlen(xml_filename)) =3D=3D 0
-                    && strlen(current_xml_filename) =3D=3D strlen(xml_file=
name)))
-                    break;
-            }
-            if (current_xml_filename) {
-                xml_content =3D xml_builtin[i][1];
-                /* select correct reg_type */
-                if (strcmp(current_xml_filename, "arm-vfp.xml") =3D=3D 0) {
-                    reg_type =3D MCD_ARM_REG_TYPE_VFP;
-                } else if (strcmp(current_xml_filename, "arm-vfp3.xml") =
=3D=3D 0) {
-                    reg_type =3D MCD_ARM_REG_TYPE_VFP;
-                } else if (strcmp(current_xml_filename,
-                    "arm-vfp-sysregs.xml") =3D=3D 0) {
-                    reg_type =3D MCD_ARM_REG_TYPE_VFP_SYS;
-                } else if (strcmp(current_xml_filename,
-                    "arm-neon.xml") =3D=3D 0) {
-                    reg_type =3D MCD_ARM_REG_TYPE_VFP;
-                } else if (strcmp(current_xml_filename,
-                    "arm-m-profile-mve.xml") =3D=3D 0) {
-                    reg_type =3D MCD_ARM_REG_TYPE_MVE;
-                }
-            } else {
-                continue;
-            }
-        }
-        /* 2. parse xml */
-        parse_reg_xml(xml_content, strlen(xml_content), registers, reg_typ=
e);
-    }
-    return 0;
-}
-
-int mcd_arm_get_additional_register_info(GArray *reggroups, GArray *regist=
ers,
-    CPUState *cpu)
-{
-    mcd_reg_st *current_register;
-    uint32_t i =3D 0;
-
-    /* iterate over all registers */
-    for (i =3D 0; i < registers->len; i++) {
-        current_register =3D &(g_array_index(registers, mcd_reg_st, i));
-        current_register->id =3D i;
-        /* add mcd_reg_group_id and mcd_mem_space_id */
-        if (strcmp(current_register->group, "cp_regs") =3D=3D 0) {
-            /* coprocessor registers */
-            current_register->mcd_reg_group_id =3D 2;
-            current_register->mcd_mem_space_id =3D 6;
-            /*
-             * get info for opcode
-             * for 32bit the opcode is only 16 bit long
-             * for 64bit it is 32 bit long
-             */
-            current_register->opcode |=3D
-                arm_mcd_get_opcode(cpu, current_register->internal_id);
-        } else {
-            /* gpr register */
-            current_register->mcd_reg_group_id =3D 1;
-            current_register->mcd_mem_space_id =3D 5;
-        }
-    }
-    return 0;
-}
-
 void handle_open_core(GArray *params, void *user_ctx)
 {
     uint32_t cpu_id =3D get_param(params, 0)->cpu_id;
@@ -1506,28 +1276,28 @@ void handle_open_core(GArray *params, void *user_ct=
x)
     GArray *reggroups =3D g_array_new(false, true, sizeof(mcd_reg_group_st=
));
     GArray *registers =3D g_array_new(false, true, sizeof(mcd_reg_st));
=20
-    if (strcmp(arch, "arm") =3D=3D 0) {
+    if (strcmp(arch, MCDSTUB_ARCH_ARM) =3D=3D 0) {
         /* TODO: make group and memspace ids dynamic */
         int current_group_id =3D 1;
         /* 1. store mem spaces */
-        return_value =3D mcd_arm_store_mem_spaces(cpu, memspaces);
+        return_value =3D arm_mcd_store_mem_spaces(cpu, memspaces);
         if (return_value !=3D 0) {
             g_assert_not_reached();
         }
         /* 2. parse core xml */
-        return_value =3D mcd_arm_parse_core_xml_file(cc, reggroups,
+        return_value =3D arm_mcd_parse_core_xml_file(cc, reggroups,
             registers, &current_group_id);
         if (return_value !=3D 0) {
             g_assert_not_reached();
         }
         /* 3. parse other xmls */
-        return_value =3D mcd_arm_parse_general_xml_files(cpu, reggroups,
+        return_value =3D arm_mcd_parse_general_xml_files(cpu, reggroups,
             registers, &current_group_id);
         if (return_value !=3D 0) {
             g_assert_not_reached();
         }
         /* 4. add additional data the the regs from the xmls */
-        return_value =3D mcd_arm_get_additional_register_info(reggroups,
+        return_value =3D arm_mcd_get_additional_register_info(reggroups,
             registers, cpu);
         if (return_value !=3D 0) {
             g_assert_not_reached();
@@ -1939,7 +1709,7 @@ int mcd_read_register(CPUState *cpu, GByteArray *buf,=
 int reg)
     /* 2. read register */
     CPUClass *cc =3D CPU_GET_CLASS(cpu);
     gchar *arch =3D cc->gdb_arch_name(cpu);
-    if (strcmp(arch, "arm") =3D=3D 0) {
+    if (strcmp(arch, MCDSTUB_ARCH_ARM) =3D=3D 0) {
         g_free(arch);
         return arm_mcd_read_register(cpu, buf, reg_type, internal_id);
     } else {
@@ -1959,7 +1729,7 @@ int mcd_write_register(CPUState *cpu, GByteArray *buf=
, int reg)
     /* 2. write register */
     CPUClass *cc =3D CPU_GET_CLASS(cpu);
     gchar *arch =3D cc->gdb_arch_name(cpu);
-    if (strcmp(arch, "arm") =3D=3D 0) {
+    if (strcmp(arch, MCDSTUB_ARCH_ARM) =3D=3D 0) {
         g_free(arch);
         return arm_mcd_write_register(cpu, buf, reg_type, internal_id);
     } else {
diff --git a/mcdstub/mcdstub.h b/mcdstub/mcdstub.h
index a436551bb1..d3f15da180 100644
--- a/mcdstub/mcdstub.h
+++ b/mcdstub/mcdstub.h
@@ -4,8 +4,7 @@
 #include "exec/cpu-common.h"
 #include "chardev/char.h"
 #include "hw/core/cpu.h"
-/* just used for the register xml files */
-#include "exec/gdbstub.h"
+#include "mcdstub_common.h"
=20
 #define MAX_PACKET_LENGTH 1024
=20
@@ -44,7 +43,9 @@ enum {
 #define QUERY_TOTAL_NUMBER 12
 #define CMD_SCHEMA_LENGTH 6
 #define MCD_SYSTEM_NAME "qemu-system"
-#define ARGUMENT_STRING_LENGTH 64
+
+/* supported architectures */
+#define MCDSTUB_ARCH_ARM "arm"
=20
 /* tcp query packet values templates */
 #define DEVICE_NAME_TEMPLATE(s) "qemu-" #s "-device"
@@ -63,16 +64,6 @@ enum {
 #define STATE_STR_BREAK_RW(d) "stopped beacuse of read or write access at =
" #d
 #define STATE_STR_BREAK_UNKNOWN "stopped for unknown reason"
=20
-typedef struct GDBRegisterState {
-    /* needed for the used gdb functions */
-    int base_reg;
-    int num_regs;
-    gdb_get_reg_cb get_reg;
-    gdb_set_reg_cb set_reg;
-    const char *xml;
-    struct GDBRegisterState *next;
-} GDBRegisterState;
-
 typedef struct MCDProcess {
     uint32_t pid;
     bool attached;
@@ -160,48 +151,11 @@ typedef struct MCDState {
 /* lives in main mcdstub.c */
 extern MCDState mcdserver_state;
=20
-typedef struct mcd_mem_space_st {
-    const char *name;
-    uint32_t id;
-    uint32_t type;
-    uint32_t bits_per_mau;
-    uint8_t invariance;
-    uint32_t endian;
-    uint64_t min_addr;
-    uint64_t max_addr;
-    uint32_t supported_access_options;
-    /* internal */
-    bool is_secure;
-} mcd_mem_space_st;
-
-typedef struct mcd_reg_group_st {
-    const char *name;
-    uint32_t id;
-} mcd_reg_group_st;
-
 typedef struct xml_attrib {
     char argument[ARGUMENT_STRING_LENGTH];
     char value[ARGUMENT_STRING_LENGTH];
 } xml_attrib;
=20
-typedef struct mcd_reg_st {
-    /* xml info */
-    char name[ARGUMENT_STRING_LENGTH];
-    char group[ARGUMENT_STRING_LENGTH];
-    char type[ARGUMENT_STRING_LENGTH];
-    uint32_t bitsize;
-    uint32_t id; /* id used by the mcd interface */
-    uint32_t internal_id; /* id inside reg type */
-    uint8_t reg_type;
-    /* mcd metadata */
-    uint32_t mcd_reg_group_id;
-    uint32_t mcd_mem_space_id;
-    uint32_t mcd_reg_type;
-    uint32_t mcd_hw_thread_id;
-    /* data for op-code */
-    uint32_t opcode;
-} mcd_reg_st;
-
 typedef struct mcd_reset_st {
     const char *name;
     uint8_t id;
@@ -291,8 +245,6 @@ void handle_query_mem_spaces_c(GArray *params, void *us=
er_ctx);
 void handle_query_regs_f(GArray *params, void *user_ctx);
 void handle_query_regs_c(GArray *params, void *user_ctx);
 void handle_open_server(GArray *params, void *user_ctx);
-void parse_reg_xml(const char *xml, int size, GArray* registers,
-    uint8_t reg_type);
 void handle_reset(GArray *params, void *user_ctx);
 void handle_query_state(GArray *params, void *user_ctx);
 void handle_read_register(GArray *params, void *user_ctx);
@@ -308,14 +260,6 @@ void handle_breakpoint_remove(GArray *params, void *us=
er_ctx);
 int mcd_breakpoint_insert(CPUState *cpu, int type, vaddr addr);
 int mcd_breakpoint_remove(CPUState *cpu, int type, vaddr addr);
=20
-/* arm specific functions */
-int mcd_arm_store_mem_spaces(CPUState *cpu, GArray *memspaces);
-int mcd_arm_parse_core_xml_file(CPUClass *cc, GArray *reggroups,
-    GArray *registers, int *current_group_id);
-int mcd_arm_parse_general_xml_files(CPUState *cpu, GArray* reggroups,
-    GArray *registers, int *current_group_id);
-int mcd_arm_get_additional_register_info(GArray *reggroups, GArray *regist=
ers,
-    CPUState *cpu);
 /* sycall handling */
 void mcd_syscall_reset(void);
 void mcd_disable_syscalls(void);
diff --git a/mcdstub/mcdstub_common.h b/mcdstub/mcdstub_common.h
new file mode 100644
index 0000000000..f5175e3979
--- /dev/null
+++ b/mcdstub/mcdstub_common.h
@@ -0,0 +1,46 @@
+#ifndef MCDSTUB_COMMON_H
+#define MCDSTUB_COMMON_H
+
+#define ARGUMENT_STRING_LENGTH 64
+
+typedef struct mcd_mem_space_st {
+    const char *name;
+    uint32_t id;
+    uint32_t type;
+    uint32_t bits_per_mau;
+    uint8_t invariance;
+    uint32_t endian;
+    uint64_t min_addr;
+    uint64_t max_addr;
+    uint32_t supported_access_options;
+    /* internal */
+    bool is_secure;
+} mcd_mem_space_st;
+
+typedef struct mcd_reg_st {
+    /* xml info */
+    char name[ARGUMENT_STRING_LENGTH];
+    char group[ARGUMENT_STRING_LENGTH];
+    char type[ARGUMENT_STRING_LENGTH];
+    uint32_t bitsize;
+    uint32_t id; /* id used by the mcd interface */
+    uint32_t internal_id; /* id inside reg type */
+    uint8_t reg_type;
+    /* mcd metadata */
+    uint32_t mcd_reg_group_id;
+    uint32_t mcd_mem_space_id;
+    uint32_t mcd_reg_type;
+    uint32_t mcd_hw_thread_id;
+    /* data for op-code */
+    uint32_t opcode;
+} mcd_reg_st;
+
+typedef struct mcd_reg_group_st {
+    const char *name;
+    uint32_t id;
+} mcd_reg_group_st;
+
+void parse_reg_xml(const char *xml, int size, GArray* registers,
+    uint8_t reg_type);
+
+#endif /* MCDSTUB_COMMON_H */
diff --git a/target/arm/mcdstub.c b/target/arm/mcdstub.c
index 3a35d1062d..d2a83a3cd9 100644
--- a/target/arm/mcdstub.c
+++ b/target/arm/mcdstub.c
@@ -344,3 +344,234 @@ int arm_mcd_set_scr(CPUState *cs, bool secure)
     }
     return 0;
 }
+
+int arm_mcd_store_mem_spaces(CPUState *cpu, GArray *memspaces)
+{
+    int nr_address_spaces =3D cpu->num_ases;
+    uint32_t mem_space_id =3D 0;
+
+    /*
+     * TODO: atm we can only access physical memory addresses,
+     * but trace32 needs fake locical spaces to work with
+    */
+
+    mem_space_id++;
+    mcd_mem_space_st non_secure =3D {
+        .name =3D "Non Secure",
+        .id =3D mem_space_id,
+        .type =3D 34,
+        .bits_per_mau =3D 8,
+        .invariance =3D 1,
+        .endian =3D 1,
+        .min_addr =3D 0,
+        .max_addr =3D -1,
+        .supported_access_options =3D 0,
+        .is_secure =3D false,
+    };
+    g_array_append_vals(memspaces, (gconstpointer)&non_secure, 1);
+    mem_space_id++;
+    mcd_mem_space_st phys_non_secure =3D {
+        .name =3D "Physical (Non Secure)",
+        .id =3D mem_space_id,
+        .type =3D 18,
+        .bits_per_mau =3D 8,
+        .invariance =3D 1,
+        .endian =3D 1,
+        .min_addr =3D 0,
+        .max_addr =3D -1,
+        .supported_access_options =3D 0,
+        .is_secure =3D false,
+    };
+    g_array_append_vals(memspaces, (gconstpointer)&phys_non_secure, 1);
+    if(nr_address_spaces > 1) {
+        mem_space_id++;
+        mcd_mem_space_st secure =3D {
+            .name =3D "Secure",
+            .id =3D mem_space_id,
+            .type =3D 34,
+            .bits_per_mau =3D 8,
+            .invariance =3D 1,
+            .endian =3D 1,
+            .min_addr =3D 0,
+            .max_addr =3D -1,
+            .supported_access_options =3D 0,
+            .is_secure =3D true,
+        };
+        g_array_append_vals(memspaces, (gconstpointer)&secure, 1);
+        mem_space_id++;
+        mcd_mem_space_st phys_secure =3D {
+            .name =3D "Physical (Secure)",
+            .id =3D mem_space_id,
+            .type =3D 18,
+            .bits_per_mau =3D 8,
+            .invariance =3D 1,
+            .endian =3D 1,
+            .min_addr =3D 0,
+            .max_addr =3D -1,
+            .supported_access_options =3D 0,
+            .is_secure =3D true,
+        };
+        g_array_append_vals(memspaces, (gconstpointer)&phys_secure, 1);
+    }
+    /* TODO: get dynamically how the per (CP15) space is called */
+    mem_space_id++;
+    mcd_mem_space_st gpr =3D {
+        .name =3D "GPR Registers",
+        .id =3D mem_space_id,
+        .type =3D 1,
+        .bits_per_mau =3D 8,
+        .invariance =3D 1,
+        .endian =3D 1,
+        .min_addr =3D 0,
+        .max_addr =3D -1,
+        .supported_access_options =3D 0,
+    };
+    g_array_append_vals(memspaces, (gconstpointer)&gpr, 1);
+    mem_space_id++;
+    mcd_mem_space_st cpr =3D {
+        .name =3D "CP15 Registers",
+        .id =3D mem_space_id,
+        .type =3D 1,
+        .bits_per_mau =3D 8,
+        .invariance =3D 1,
+        .endian =3D 1,
+        .min_addr =3D 0,
+        .max_addr =3D -1,
+        .supported_access_options =3D 0,
+    };
+    g_array_append_vals(memspaces, (gconstpointer)&cpr, 1);
+    return 0;
+}
+
+int arm_mcd_parse_core_xml_file(CPUClass *cc, GArray *reggroups,
+    GArray *registers, int *current_group_id)
+{
+    const char *xml_filename =3D NULL;
+    const char *current_xml_filename =3D NULL;
+    const char *xml_content =3D NULL;
+    int i =3D 0;
+
+    /* 1. get correct file */
+    xml_filename =3D cc->gdb_core_xml_file;
+    for (i =3D 0; ; i++) {
+        current_xml_filename =3D xml_builtin[i][0];
+        if (!current_xml_filename || (strncmp(current_xml_filename,
+            xml_filename, strlen(xml_filename)) =3D=3D 0
+            && strlen(current_xml_filename) =3D=3D strlen(xml_filename)))
+            break;
+    }
+    /* without gpr registers we can do nothing */
+    if (!current_xml_filename) {
+        return -1;
+    }
+
+    /* 2. add group for gpr registers */
+    mcd_reg_group_st gprregs =3D {
+        .name =3D "GPR Registers",
+        .id =3D *current_group_id
+    };
+    g_array_append_vals(reggroups, (gconstpointer)&gprregs, 1);
+    *current_group_id =3D *current_group_id + 1;
+
+    /* 3. parse xml */
+    xml_content =3D xml_builtin[i][1];
+    parse_reg_xml(xml_content, strlen(xml_content), registers,
+        MCD_ARM_REG_TYPE_GPR);
+    return 0;
+}
+
+int arm_mcd_parse_general_xml_files(CPUState *cpu, GArray *reggroups,
+    GArray *registers, int *current_group_id) {
+    const char *xml_filename =3D NULL;
+    const char *current_xml_filename =3D NULL;
+    const char *xml_content =3D NULL;
+    int i =3D 0;
+    uint8_t reg_type;
+
+    /* iterate over all gdb xml files*/
+    GDBRegisterState *r;
+    for (r =3D cpu->gdb_regs; r; r =3D r->next) {
+        xml_filename =3D r->xml;
+        xml_content =3D NULL;
+
+        /* 1. get xml content */
+        xml_content =3D arm_mcd_get_dynamic_xml(cpu, xml_filename);
+        if (xml_content) {
+            if (strcmp(xml_filename, "system-registers.xml") =3D=3D 0) {
+                /* these are the coprocessor register */
+                mcd_reg_group_st corprocessorregs =3D {
+                    .name =3D "CP15 Registers",
+                    .id =3D *current_group_id
+                };
+                g_array_append_vals(reggroups,
+                    (gconstpointer)&corprocessorregs, 1);
+                *current_group_id =3D *current_group_id + 1;
+                reg_type =3D MCD_ARM_REG_TYPE_CPR;
+            }
+        } else {
+            /* its not a coprocessor xml -> it is a static xml file */
+            for (i =3D 0; ; i++) {
+                current_xml_filename =3D xml_builtin[i][0];
+                if (!current_xml_filename || (strncmp(current_xml_filename,
+                    xml_filename, strlen(xml_filename)) =3D=3D 0
+                    && strlen(current_xml_filename) =3D=3D strlen(xml_file=
name)))
+                    break;
+            }
+            if (current_xml_filename) {
+                xml_content =3D xml_builtin[i][1];
+                /* select correct reg_type */
+                if (strcmp(current_xml_filename, "arm-vfp.xml") =3D=3D 0) {
+                    reg_type =3D MCD_ARM_REG_TYPE_VFP;
+                } else if (strcmp(current_xml_filename, "arm-vfp3.xml") =
=3D=3D 0) {
+                    reg_type =3D MCD_ARM_REG_TYPE_VFP;
+                } else if (strcmp(current_xml_filename,
+                    "arm-vfp-sysregs.xml") =3D=3D 0) {
+                    reg_type =3D MCD_ARM_REG_TYPE_VFP_SYS;
+                } else if (strcmp(current_xml_filename,
+                    "arm-neon.xml") =3D=3D 0) {
+                    reg_type =3D MCD_ARM_REG_TYPE_VFP;
+                } else if (strcmp(current_xml_filename,
+                    "arm-m-profile-mve.xml") =3D=3D 0) {
+                    reg_type =3D MCD_ARM_REG_TYPE_MVE;
+                }
+            } else {
+                continue;
+            }
+        }
+        /* 2. parse xml */
+        parse_reg_xml(xml_content, strlen(xml_content), registers, reg_typ=
e);
+    }
+    return 0;
+}
+
+int arm_mcd_get_additional_register_info(GArray *reggroups, GArray *regist=
ers,
+    CPUState *cpu)
+{
+    mcd_reg_st *current_register;
+    uint32_t i =3D 0;
+
+    /* iterate over all registers */
+    for (i =3D 0; i < registers->len; i++) {
+        current_register =3D &(g_array_index(registers, mcd_reg_st, i));
+        current_register->id =3D i;
+        /* add mcd_reg_group_id and mcd_mem_space_id */
+        if (strcmp(current_register->group, "cp_regs") =3D=3D 0) {
+            /* coprocessor registers */
+            current_register->mcd_reg_group_id =3D 2;
+            current_register->mcd_mem_space_id =3D 6;
+            /*
+             * get info for opcode
+             * for 32bit the opcode is only 16 bit long
+             * for 64bit it is 32 bit long
+             */
+            current_register->opcode |=3D
+                arm_mcd_get_opcode(cpu, current_register->internal_id);
+        } else {
+            /* gpr register */
+            current_register->mcd_reg_group_id =3D 1;
+            current_register->mcd_mem_space_id =3D 5;
+        }
+    }
+    return 0;
+}
+
diff --git a/target/arm/mcdstub.h b/target/arm/mcdstub.h
index c3b5c1ae8d..1321d5dc07 100644
--- a/target/arm/mcdstub.h
+++ b/target/arm/mcdstub.h
@@ -1,6 +1,21 @@
 #ifndef ARM_MCDSTUB_H
 #define ARM_MCDSTUB_H
=20
+#include "hw/core/cpu.h"
+#include "mcdstub/mcdstub_common.h"
+/* just used for the register xml files */
+#include "exec/gdbstub.h"
+
+typedef struct GDBRegisterState {
+    /* needed for the used gdb functions */
+    int base_reg;
+    int num_regs;
+    gdb_get_reg_cb get_reg;
+    gdb_set_reg_cb set_reg;
+    const char *xml;
+    struct GDBRegisterState *next;
+} GDBRegisterState;
+
 /* ids for each different type of register */
 enum {
     MCD_ARM_REG_TYPE_GPR,
@@ -17,5 +32,12 @@ int arm_mcd_write_register(CPUState *cs, GByteArray *mem=
_buf, uint8_t reg_type,
     uint32_t n);
 uint16_t arm_mcd_get_opcode(CPUState *cs, uint32_t n);
 int arm_mcd_set_scr(CPUState *cs, bool secure);
+int arm_mcd_store_mem_spaces(CPUState *cpu, GArray *memspaces);
+int arm_mcd_parse_core_xml_file(CPUClass *cc, GArray *reggroups,
+    GArray *registers, int *current_group_id);
+int arm_mcd_parse_general_xml_files(CPUState *cpu, GArray* reggroups,
+    GArray *registers, int *current_group_id);
+int arm_mcd_get_additional_register_info(GArray *reggroups, GArray *regist=
ers,
+    CPUState *cpu);
=20
 #endif /* ARM_MCDSTUB_H */
--=20
2.34.1


From 011ef906c4fbe79c188caad6591ddcd30b90026f Mon Sep 17 00:00:00 2001
From: Nicolas Eder <nicolas.eder@lauterbach.com>
Date: Fri, 18 Aug 2023 15:56:21 +0200
Subject: [PATCH 24/29] step and go handlers now propperly perform global
 operations

Signed-off-by: Nicolas Eder <nicolas.eder@lauterbach.com>
---
 mcdstub/mcd_shared_defines.h |  2 ++
 mcdstub/mcdstub.c            | 35 +++++++++++++++++++++--------------
 2 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/mcdstub/mcd_shared_defines.h b/mcdstub/mcd_shared_defines.h
index 5cfda4121d..5fbd732252 100644
--- a/mcdstub/mcd_shared_defines.h
+++ b/mcdstub/mcd_shared_defines.h
@@ -78,6 +78,8 @@
=20
 /* for packets sent to qemu */
 #define ARGUMENT_SEPARATOR ';'
+#define NEGATIVE_FLAG 0
+#define POSITIVE_FLAG 1
=20
 /* core states */
 #define CORE_STATE_RUNNING "running"
diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index b19ca471ea..7613ed2c4a 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -435,7 +435,7 @@ int mcd_handle_packet(const char *line_buf)
             };
             go_cmd_desc.cmd =3D (char[2]) { TCP_CHAR_GO, '\0' };
             strcpy(go_cmd_desc.schema,
-                (char[2]) { ARG_SCHEMA_CORENUM, '\0' });
+                (char[3]) { ARG_SCHEMA_INT, ARG_SCHEMA_CORENUM, '\0' });
             cmd_parser =3D &go_cmd_desc;
         }
         break;
@@ -446,7 +446,7 @@ int mcd_handle_packet(const char *line_buf)
             };
             step_cmd_desc.cmd =3D (char[2]) { TCP_CHAR_STEP, '\0' };
             strcpy(step_cmd_desc.schema,
-                (char[2]) { ARG_SCHEMA_CORENUM, '\0' });
+                (char[3]) { ARG_SCHEMA_INT, ARG_SCHEMA_CORENUM, '\0' });
             cmd_parser =3D &step_cmd_desc;
         }
         break;
@@ -608,28 +608,35 @@ int mcd_handle_packet(const char *line_buf)
=20
 void handle_vm_start(GArray *params, void *user_ctx)
 {
-    /* TODO: add partial restart with arguments and so on */
-    uint32_t cpu_id =3D get_param(params, 0)->cpu_id;
-    CPUState *cpu =3D mcd_get_cpu(cpu_id);
-    mcd_cpu_start(cpu);
+    uint32_t global =3D get_param(params, 0)->data_uint32_t;
+    if (global =3D=3D 1) {
+        mcd_vm_start();
+    } else{
+        uint32_t cpu_id =3D get_param(params, 1)->cpu_id;
+        CPUState *cpu =3D mcd_get_cpu(cpu_id);
+        mcd_cpu_start(cpu);
+    }
 }
=20
 void handle_vm_step(GArray *params, void *user_ctx)
 {
-    /* TODO: add partial restart with arguments and so on */
-    uint32_t cpu_id =3D get_param(params, 0)->cpu_id;
-
-    CPUState *cpu =3D mcd_get_cpu(cpu_id);
-    int return_value =3D mcd_cpu_sstep(cpu);
-    if (return_value !=3D 0) {
-        g_assert_not_reached();
+    uint32_t global =3D get_param(params, 0)->data_uint32_t;
+    if (global =3D=3D 1) {
+        /* TODO: add multicore support */
+    } else{
+        uint32_t cpu_id =3D get_param(params, 1)->cpu_id;
+        CPUState *cpu =3D mcd_get_cpu(cpu_id);
+        int return_value =3D mcd_cpu_sstep(cpu);
+        if (return_value !=3D 0) {
+            g_assert_not_reached();
+        }
     }
 }
=20
=20
 void handle_vm_stop(GArray *params, void *user_ctx)
 {
-    /* TODO: add partial stop with arguments and so on */
+    /* TODO: add core dependant break option */
     mcd_vm_stop();
 }
=20
--=20
2.34.1


From 7ea2961119797d28034d5d1114a9e78e35e2bc68 Mon Sep 17 00:00:00 2001
From: Nicolas Eder <nicolas.eder@lauterbach.com>
Date: Tue, 22 Aug 2023 11:59:42 +0200
Subject: [PATCH 25/29] Doxygen documentation added

Signed-off-by: Nicolas Eder <nicolas.eder@lauterbach.com>
---
 include/exec/mcdstub.h       |   7 -
 include/mcdstub/syscalls.h   |   2 +-
 mcdstub/mcd_shared_defines.h |   1 +
 mcdstub/mcdstub.c            |  61 ++--
 mcdstub/mcdstub.h            | 579 ++++++++++++++++++++++++++++++++++-
 mcdstub/mcdstub_common.h     |  18 ++
 target/arm/mcdstub.c         |   6 -
 target/arm/mcdstub.h         | 105 +++++++
 8 files changed, 709 insertions(+), 70 deletions(-)

diff --git a/include/exec/mcdstub.h b/include/exec/mcdstub.h
index 84f7c811cb..9b7c31a951 100644
--- a/include/exec/mcdstub.h
+++ b/include/exec/mcdstub.h
@@ -3,13 +3,6 @@
=20
 #define DEFAULT_MCDSTUB_PORT "1235"
=20
-/* breakpoint defines */
-#define MCD_BREAKPOINT_SW        0
-#define MCD_BREAKPOINT_HW        1
-#define MCD_WATCHPOINT_WRITE     2
-#define MCD_WATCHPOINT_READ      3
-#define MCD_WATCHPOINT_ACCESS    4
-
 /**
  * mcd_tcp_server_start: start the tcp server to connect via mcd
  * @device: connection spec for mcd
diff --git a/include/mcdstub/syscalls.h b/include/mcdstub/syscalls.h
index 5547d6d29e..52a26be3a9 100644
--- a/include/mcdstub/syscalls.h
+++ b/include/mcdstub/syscalls.h
@@ -3,4 +3,4 @@
=20
 typedef void (*gdb_syscall_complete_cb)(CPUState *cpu, uint64_t ret, int e=
rr);
=20
-#endif /* _SYSCALLS_H_ */
+#endif /* _MCD_SYSCALLS_H_ */
diff --git a/mcdstub/mcd_shared_defines.h b/mcdstub/mcd_shared_defines.h
index 5fbd732252..110d36d975 100644
--- a/mcdstub/mcd_shared_defines.h
+++ b/mcdstub/mcd_shared_defines.h
@@ -38,6 +38,7 @@
 /* tcp query arguments */
 #define QUERY_FIRST "f"
 #define QUERY_CONSEQUTIVE "c"
+#define QUERY_END_INDEX "!"
=20
 #define QUERY_ARG_SYSTEM "system"
 #define QUERY_ARG_CORES "cores"
diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index 7613ed2c4a..a468a7d7b8 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -218,12 +218,6 @@ int find_cpu_clusters(Object *child, void *opaque)
         s->processes =3D g_renew(MCDProcess, s->processes, ++s->process_nu=
m);
=20
         process =3D &s->processes[s->process_num - 1];
-
-        /*
-         * GDB process IDs -1 and 0 are reserved. To avoid subtle errors at
-         * runtime, we enforce here that the machine does not use a cluste=
r ID
-         * that would lead to PID 0.
-         */
         assert(cluster->cluster_id !=3D UINT32_MAX);
         process->pid =3D cluster->cluster_id + 1;
         process->attached =3D false;
@@ -925,7 +919,7 @@ void mcd_vm_state_change(void *opaque, bool running, Ru=
nState state)
=20
 int mcd_put_packet(const char *buf)
 {
-    return mcd_put_packet_binary(buf, strlen(buf), false);
+    return mcd_put_packet_binary(buf, strlen(buf));
 }
=20
 void mcd_put_strbuf(void)
@@ -933,7 +927,7 @@ void mcd_put_strbuf(void)
     mcd_put_packet(mcdserver_state.str_buf->str);
 }
=20
-int mcd_put_packet_binary(const char *buf, int len, bool dump)
+int mcd_put_packet_binary(const char *buf, int len)
 {
     for (;;) {
         g_byte_array_set_size(mcdserver_state.last_packet, 0);
@@ -999,12 +993,12 @@ MCDProcess *mcd_get_process(uint32_t pid)
     return NULL;
 }
=20
-CPUState *mcd_get_cpu(uint32_t i_cpu_index)
+CPUState *mcd_get_cpu(uint32_t cpu_index)
 {
     CPUState *cpu =3D first_cpu;
=20
     while (cpu) {
-        if (cpu->cpu_index =3D=3D i_cpu_index) {
+        if (cpu->cpu_index =3D=3D cpu_index) {
             return cpu;
         }
         cpu =3D mcd_next_attached_cpu(cpu);
@@ -1344,15 +1338,13 @@ void handle_open_core(GArray *params, void *user_ct=
x)
=20
 void handle_query_reset_f(GArray *params, void *user_ctx)
 {
-    /* TODO: vull reset over the qemu monitor */
-
     /* 1. check length */
     int nb_resets =3D mcdserver_state.resets->len;
     if (nb_resets =3D=3D 1) {
         /* indicates this is the last packet */
-        g_string_printf(mcdserver_state.str_buf, "0!");
+        g_string_printf(mcdserver_state.str_buf, "0%s", QUERY_END_INDEX);
     } else {
-        g_string_printf(mcdserver_state.str_buf, "1!");
+        g_string_printf(mcdserver_state.str_buf, "1%s", QUERY_END_INDEX);
     }
     /* 2. send data */
     mcd_reset_st reset =3D g_array_index(mcdserver_state.resets, mcd_reset=
_st, 0);
@@ -1370,7 +1362,7 @@ void handle_query_reset_c(GArray *params, void *user_=
ctx)
     int nb_groups =3D mcdserver_state.resets->len;
     if (query_index + 1 =3D=3D nb_groups) {
         /* indicates this is the last packet */
-        g_string_printf(mcdserver_state.str_buf, "0!");
+        g_string_printf(mcdserver_state.str_buf, "0%s", QUERY_END_INDEX);
     } else {
         g_string_printf(mcdserver_state.str_buf, "%u!", query_index + 1);
     }
@@ -1487,9 +1479,9 @@ void handle_query_mem_spaces_f(GArray *params, void *=
user_ctx)
     int nb_groups =3D memspaces->len;
     if (nb_groups =3D=3D 1) {
         /* indicates this is the last packet */
-        g_string_printf(mcdserver_state.str_buf, "0!");
+        g_string_printf(mcdserver_state.str_buf, "0%s", QUERY_END_INDEX);
     } else {
-        g_string_printf(mcdserver_state.str_buf, "1!");
+        g_string_printf(mcdserver_state.str_buf, "1%s", QUERY_END_INDEX);
     }
=20
     /* 3. send data */
@@ -1522,7 +1514,7 @@ void handle_query_mem_spaces_c(GArray *params, void *=
user_ctx)
     int nb_groups =3D memspaces->len;
     if (query_index + 1 =3D=3D nb_groups) {
         /* indicates this is the last packet */
-        g_string_printf(mcdserver_state.str_buf, "0!");
+        g_string_printf(mcdserver_state.str_buf, "0%s", QUERY_END_INDEX);
     } else {
         g_string_printf(mcdserver_state.str_buf, "%u!", query_index + 1);
     }
@@ -1555,9 +1547,9 @@ void handle_query_reg_groups_f(GArray *params, void *=
user_ctx)
     int nb_groups =3D reggroups->len;
     if (nb_groups =3D=3D 1) {
         /* indicates this is the last packet */
-        g_string_printf(mcdserver_state.str_buf, "0!");
+        g_string_printf(mcdserver_state.str_buf, "0%s", QUERY_END_INDEX);
     } else {
-        g_string_printf(mcdserver_state.str_buf, "1!");
+        g_string_printf(mcdserver_state.str_buf, "1%s", QUERY_END_INDEX);
     }
     /* 3. send data */
     mcd_reg_group_st group =3D g_array_index(reggroups, mcd_reg_group_st, =
0);
@@ -1580,7 +1572,7 @@ void handle_query_reg_groups_c(GArray *params, void *=
user_ctx)
     int nb_groups =3D reggroups->len;
     if (query_index + 1 =3D=3D nb_groups) {
         /* indicates this is the last packet */
-        g_string_printf(mcdserver_state.str_buf, "0!");
+        g_string_printf(mcdserver_state.str_buf, "0%s", QUERY_END_INDEX);
     } else {
         g_string_printf(mcdserver_state.str_buf, "%u!", query_index + 1);
     }
@@ -1604,9 +1596,9 @@ void handle_query_regs_f(GArray *params, void *user_c=
tx)
     int nb_regs =3D registers->len;
     if (nb_regs =3D=3D 1) {
         /* indicates this is the last packet */
-        g_string_printf(mcdserver_state.str_buf, "0!");
+        g_string_printf(mcdserver_state.str_buf, "0%s", QUERY_END_INDEX);
     } else {
-        g_string_printf(mcdserver_state.str_buf, "1!");
+        g_string_printf(mcdserver_state.str_buf, "1%s", QUERY_END_INDEX);
     }
     /* 3. send data */
     mcd_reg_st my_register =3D g_array_index(registers, mcd_reg_st, 0);
@@ -1637,7 +1629,7 @@ void handle_query_regs_c(GArray *params, void *user_c=
tx)
     int nb_regs =3D registers->len;
     if (query_index + 1 =3D=3D nb_regs) {
         /* indicates this is the last packet */
-        g_string_printf(mcdserver_state.str_buf, "0!");
+        g_string_printf(mcdserver_state.str_buf, "0%s", QUERY_END_INDEX);
     } else {
         g_string_printf(mcdserver_state.str_buf, "%u!", query_index + 1);
     }
@@ -1672,19 +1664,8 @@ void handle_query_state(GArray *params, void *user_c=
tx)
      * get state info
      */
     mcd_cpu_state_st state_info =3D mcdserver_state.cpu_state;
-    mcd_core_event_et event =3D MCD_CORE_EVENT_NONE;
-    if (state_info.memory_changed) {
-        event =3D event | MCD_CORE_EVENT_MEMORY_CHANGE;
-        state_info.memory_changed =3D false;
-    }
-    if (state_info.registers_changed) {
-        event =3D event | MCD_CORE_EVENT_REGISTER_CHANGE;
-        state_info.registers_changed =3D false;
-    }
-    if (state_info.target_was_stopped) {
-        event =3D event | MCD_CORE_EVENT_STOPPED;
-        state_info.target_was_stopped =3D false;
-    }
+    /* TODO: add event information */
+    uint32_t event =3D 0;
     /* send data */
     g_string_printf(mcdserver_state.str_buf,
         "%s=3D%s.%s=3D%u.%s=3D%u.%s=3D%u.%s=3D%lu.%s=3D%s.%s=3D%s.",
@@ -1863,7 +1844,7 @@ void handle_write_memory(GArray *params, void *user_c=
tx)
         mcd_put_packet(TCP_EXECUTION_ERROR);
         return;
     }
-    /* read memory */
+    /* write memory */
     mcd_hextomem(mcdserver_state.mem_buf, mcdserver_state.str_buf->str, le=
n);
     if (mcd_write_memory(cpu, mem_address,
         mcdserver_state.mem_buf->data, len) !=3D 0) {
@@ -1879,7 +1860,7 @@ int mcd_breakpoint_insert(CPUState *cpu, int type, va=
ddr addr)
     int bp_type =3D 0;
     CPUClass *cc =3D CPU_GET_CLASS(cpu);
     if (cc->gdb_stop_before_watchpoint) {
-        //bp_type |=3D BP_STOP_BEFORE_ACCESS;
+        /* bp_type |=3D BP_STOP_BEFORE_ACCESS; */
     }
     int return_value =3D 0;
     switch (type) {
@@ -1909,7 +1890,7 @@ int mcd_breakpoint_remove(CPUState *cpu, int type, va=
ddr addr)
     int bp_type =3D 0;
     CPUClass *cc =3D CPU_GET_CLASS(cpu);
     if (cc->gdb_stop_before_watchpoint) {
-        //bp_type |=3D BP_STOP_BEFORE_ACCESS;
+        /* bp_type |=3D BP_STOP_BEFORE_ACCESS; */
     }
     int return_value =3D 0;
     switch (type) {
diff --git a/mcdstub/mcdstub.h b/mcdstub/mcdstub.h
index d3f15da180..5412b59423 100644
--- a/mcdstub/mcdstub.h
+++ b/mcdstub/mcdstub.h
@@ -12,20 +12,6 @@
 #define MCD_TRIG_OPT_DATA_IS_CONDITION 0x00000008
 #define MCD_TRIG_ACTION_DBG_DEBUG 0x00000001
=20
-typedef uint32_t mcd_core_event_et;
-/* TODO: replace mcd defines with custom layer */
-enum {
-    MCD_CORE_EVENT_NONE            =3D 0x00000000,
-    MCD_CORE_EVENT_MEMORY_CHANGE   =3D 0x00000001,
-    MCD_CORE_EVENT_REGISTER_CHANGE =3D 0x00000002,
-    MCD_CORE_EVENT_TRACE_CHANGE    =3D 0x00000004,
-    MCD_CORE_EVENT_TRIGGER_CHANGE  =3D 0x00000008,
-    MCD_CORE_EVENT_STOPPED         =3D 0x00000010,
-    MCD_CORE_EVENT_CHL_PENDING     =3D 0x00000020,
-    MCD_CORE_EVENT_CUSTOM_LO       =3D 0x00010000,
-    MCD_CORE_EVENT_CUSTOM_HI       =3D 0x40000000,
-};
-
 /* schema defines */
 #define ARG_SCHEMA_QRYHANDLE 'q'
 #define ARG_SCHEMA_STRING 's'
@@ -187,88 +173,649 @@ static inline int tohex(int v)
 void mcd_sigterm_handler(int signal);
 #endif
=20
+/**
+ * \defgroup mcdstub Main mcdstub functions
+ * All architecture independent mcdstub functions.
+ */
+
+/**
+ * \addtogroup mcdstub
+ * @{
+ */
+
+/**
+ * \brief Initializes the mcdserver_state struct.
+ *
+ * This function allocates memory for the mcdserver_state struct and sets
+ * all of its members to their inital values. This includes setting the
+ * cpu_state to halted and initializing the query functions with \ref
+ * init_query_cmds_table.
+ */
 void mcd_init_mcdserver_state(void);
+/**
+ * \brief Initializes all query functions.
+ *
+ * This function adds all query functions to the mcd_query_cmds_table. This
+ * includes their command string, handler function and parameter schema.
+ * @param[out] mcd_query_cmds_table Lookup table with all query commands.
+ */
 void init_query_cmds_table(MCDCmdParseEntry *mcd_query_cmds_table);
+/**
+ * \brief Initializes the resets info.
+ *
+ * This function currently only adds all theoretical possible resets to the
+ * resets GArray. None of the resets work at the moment. The resets are:
+ * "full_system_reset", "gpr_reset" and "memory_reset".
+ * @param[out] resets GArray with possible resets.
+ */
 int init_resets(GArray *resets);
+/**
+ * \brief Initializes the trigger info.
+ *
+ * This function adds the types of trigger, their possible options and act=
ions
+ * to the trigger struct.
+ * @param[out] trigger Struct with all trigger info.
+ */
 int init_trigger(mcd_trigger_into_st *trigger);
+/**
+ * \brief Resets the mcdserver_state struct.
+ *
+ * This function deletes all processes connected to the mcdserver_state.
+ */
 void reset_mcdserver_state(void);
+/**
+ * \brief Sorts all processes and calls \ref mcd_create_default_process.
+ *
+ * This function sorts all connected processes with the qsort function.
+ * Afterwards, it creates a new process with \ref mcd_create_default_proce=
ss.
+ * @param[in] s A MCDState object.
+ */
 void create_processes(MCDState *s);
+/**
+ * \brief Creates a default process for debugging.
+ *
+ * This function creates a new, not yet attached, process with an ID one a=
bove
+ * the previous maximum ID.
+ * @param[in] s A MCDState object.
+ */
 void mcd_create_default_process(MCDState *s);
+/**
+ * \brief Returns the CPU cluster of the child object.
+ *
+ * @param[in] child Object with unknown CPU cluster.
+ * @param[in] opaque Pointer to an MCDState object.
+ */
 int find_cpu_clusters(Object *child, void *opaque);
+/**
+ * \brief Compares process IDs.
+ *
+ * This function returns -1 if process "a" has a ower process ID than "b".
+ * If "b" has a lower ID than "a" 1 is returned and if they are qual 0 is
+ * returned.=20
+ * @param[in] a Process a.
+ * @param[in] b Process b.
+ */
 int pid_order(const void *a, const void *b);
+/**
+ * \brief Returns the maximum packet length of a TCP packet.
+ */
 int mcd_chr_can_receive(void *opaque);
+/**
+ * \brief Handles receiving a TCP packet.
+ *=20
+ * This function gets called by QEMU when a TCP packet is received.
+ * It iterates over that packet an calls \ref mcd_read_byte for each char
+ * of the packet.
+ * @param[in] buf Content of the packet.
+ * @param[in] size Length of the packet.
+ */
 void mcd_chr_receive(void *opaque, const uint8_t *buf, int size);
+/**
+ * \brief Handles a TCP client connect.
+ *=20
+ * This function gets called by QEMU when a TCP cliet connects to the open=
ed
+ * TCP port. It attaches the first process. From here on TCP packets can be
+ * exchanged.
+ * @param[in] event Type of event.
+ */
 void mcd_chr_event(void *opaque, QEMUChrEvent event);
+/**
+ * \brief Returns true if debugging the selected accelerator is supported.
+ */
 bool mcd_supports_guest_debug(void);
+/**
+ * \brief Handles a state change of the QEMU VM.
+ *=20
+ * This function is called when the QEMU VM goes through a state transitio=
n.
+ * It stores the runstate the CPU is in to the cpu_state and when in
+ * \c RUN_STATE_DEBUG it collects additional data on what watchpoint was h=
it.
+ * This function also resets the singlestep behavior.
+ * @param[in] running True if he VM is running.
+ * @param[in] state The new (and active) VM run state.
+ */
 void mcd_vm_state_change(void *opaque, bool running, RunState state);
+/**
+ * \brief Calls \ref mcd_put_packet_binary with buf and length of buf.
+ *=20
+ * @param[in] buf TCP packet data.
+ */
 int mcd_put_packet(const char *buf);
-int mcd_put_packet_binary(const char *buf, int len, bool dump);
+/**
+ * \brief Adds footer and header to the TCP packet data in buf.
+ *=20
+ * Besides adding header and footer, this function also stores the complet=
e TCP
+ * packet in the last_packet member of the mcdserver_state. Then the packet
+ * gets send with the \ref mcd_put_buffer function.
+ * @param[in] buf TCP packet data.
+ * @param[in] len TCP packet length.
+ */
+int mcd_put_packet_binary(const char *buf, int len);
+/**
+ * \brief Always returns true, currently needed for copatibility.
+ */
 bool mcd_got_immediate_ack(void);
+/**
+ * \brief Sends the buf as TCP packet with qemu_chr_fe_write_all.
+ *=20
+ * @param[in] buf TCP packet data.
+ * @param[in] len TCP packet length.
+ */
 void mcd_put_buffer(const uint8_t *buf, int len);
+/**
+ * \brief Returns the process of the provided CPU.
+ *=20
+ * @param[in] cpu The CPU state.
+ */
 MCDProcess *mcd_get_cpu_process(CPUState *cpu);
+/**
+ * \brief Returns the process ID of the provided CPU.
+ *=20
+ * @param[in] cpu The CPU state.
+ */
 uint32_t mcd_get_cpu_pid(CPUState *cpu);
+/**
+ * \brief Returns the process of the provided pid.
+ *=20
+ * @param[in] pid The process ID.
+ */
 MCDProcess *mcd_get_process(uint32_t pid);
+/**
+ * \brief Returns the first CPU with an attached process.
+ */
 CPUState *mcd_first_attached_cpu(void);
+/**
+ * \brief Returns the first CPU with an attached process starting after th=
e=20
+ * provided cpu.
+ *=20
+ * @param[in] cpu The CPU to start from.
+ */
 CPUState *mcd_next_attached_cpu(CPUState *cpu);
+/**
+ * \brief Resends the last packet if not acknowledged and extracts the data
+ * from a received TCP packet.
+ *=20
+ * In case the last sent packet was not acknowledged from the mcdstub,
+ * this function resends it.
+ * If it was acknowledged this function parses the incoming packet
+ * byte by byte.
+ * It extracts the data in the packet and sends an
+ * acknowledging response when finished. Then \ref mcd_handle_packet gets
+ * called.
+ * @param[in] ch Character of the received TCP packet, which should be par=
sed.
+ */
 void mcd_read_byte(uint8_t ch);
+/**
+ * \brief Evaluates the type of received packet and chooses the correct ha=
ndler.
+ *=20
+ * This function takes the first character of the line_buf to determine the
+ * type of packet. Then it selects the correct handler function and parame=
ter
+ * schema. With this info it calls \ref run_cmd_parser.
+ * @param[in] line_buf TCP packet data.
+ */
 int mcd_handle_packet(const char *line_buf);
+/**
+ * \brief Calls \ref mcd_put_packet with the str_buf of the mcdserver_stat=
e.
+ */
 void mcd_put_strbuf(void);
+/**
+ * \brief Terminates QEMU.
+ *=20
+ * If the mcdserver_state has not been initialized the function exits befo=
re
+ * terminating QEMU. Terminting is done with the qemu_chr_fe_deinit functi=
on.
+ * @param[in] code An exitcode, which can be used in the future.
+ */
 void mcd_exit(int code);
+/**
+ * \brief Prepares the mcdserver_state before executing TCP packet functio=
ns.
+ *=20
+ * This function empties the str_buf and mem_buf of the mcdserver_state and
+ * then calls \ref process_string_cmd. In case this function fails, an emp=
ty
+ * TCP packet is sent back the MCD Shared Library.
+ * @param[in] data TCP packet data.
+ * @param[in] cmd Handler function (can be an array of functions).
+ */
 void run_cmd_parser(const char *data, const MCDCmdParseEntry *cmd);
+/**
+ * \brief Collects all parameters from the data and calls the correct hand=
ler.
+ *=20
+ * The parameters are extracted with the \ref cmd_parse_params function.
+ * This function selects the command in the cmds array, which fits the sta=
rt of
+ * the data string. This way the correct commands is selected.
+ * @param[in] data TCP packet data.
+ * @param[in] cmds Array of possible commands.
+ * @param[in] num_cmds Number of commands in the cmds array.
+ */
 int process_string_cmd(void *user_ctx, const char *data,
     const MCDCmdParseEntry *cmds, int num_cmds);
+/**
+ * \brief Extracts all parameters from a TCP packet.
+ *=20
+ * This function uses the schema parameter to determine which type of para=
meter
+ * to expect. It then extracts that parameter from the data and stores it =
in
+ * the params GArray.
+ * @param[in] data TCP packet data.
+ * @param[in] schema List of expected parameters for the packet.
+ * @param[out] params GArray with all extracted parameters.
+ */
 int cmd_parse_params(const char *data, const char *schema, GArray *params);
+/**
+ * \brief Handler for the VM start TCP packet.
+ *=20
+ * Evaluates whether all cores or just a perticular core should get starte=
d and
+ * calls \ref mcd_vm_start or \ref mcd_cpu_start respectively.
+ * @param[in] params GArray with all TCP packet parameters.
+ */
 void handle_vm_start(GArray *params, void *user_ctx);
+/**
+ * \brief Handler for the VM step TCP packet.
+ *=20
+ * Calls \ref mcd_cpu_sstep for the CPU which sould be stepped. Stepping a=
ll
+ * CPUs is currently not supported.
+ * @param[in] params GArray with all TCP packet parameters.
+ */
 void handle_vm_step(GArray *params, void *user_ctx);
+/**
+ * \brief Handler for the VM stop TCP packet.
+ *=20
+ * Always calls \ref mcd_vm_stop and stops all cores. Stopping individual =
cores
+ * is currently not supported
+ * @param[in] params GArray with all TCP packet parameters.
+ */
 void handle_vm_stop(GArray *params, void *user_ctx);
+/**
+ * \brief Handler for all TCP query packets.
+ *=20
+ * Calls \ref process_string_cmd with all query functions in the
+ * mcd_query_cmds_table. \ref process_string_cmd then selects the correct =
one.
+ * This function just passes on the TCP packet data string from the parame=
ters.
+ * @param[in] params GArray with all TCP packet parameters.
+ */
 void handle_gen_query(GArray *params, void *user_ctx);
+/**
+ * \brief Returns the internal CPU index plus one.
+ *=20
+ * @param[in] cpu CPU of interest.
+ */
 int mcd_get_cpu_index(CPUState *cpu);
-CPUState *mcd_get_cpu(uint32_t i_cpu_index);
+/**
+ * \brief Returns the CPU the index i_cpu_index.
+ *=20
+ * @param[in] cpu_index Index of the desired CPU.
+ */
+CPUState *mcd_get_cpu(uint32_t cpu_index);
+/**
+ * \brief Handler for the core query.
+ *=20
+ * This function sends the type of core and number of cores currently
+ * simulated by QEMU. It also sends a device name for the MCD data structu=
re.
+ * @param[in] params GArray with all TCP packet parameters.
+ */
 void handle_query_cores(GArray *params, void *user_ctx);
+/**
+ * \brief Handler for the system query.
+ *=20
+ * Sends the system name, which is "qemu-system".
+ * @param[in] params GArray with all TCP packet parameters.
+ */
 void handle_query_system(GArray *params, void *user_ctx);
+/**
+ * \brief Returns the first CPU in the provided process.
+ *=20
+ * @param[in] process The process to look in.
+ */
 CPUState *get_first_cpu_in_process(MCDProcess *process);
+/**
+ * \brief Returns the CPU with an index equal to the thread_id.
+ *=20
+ * @param[in] thread_id ID of the desired CPU.
+ */
 CPUState *find_cpu(uint32_t thread_id);
+/**
+ * \brief Handler for opening a core.
+ *=20
+ * This function initializes all data for the core with the ID provided in
+ * the first parameter. In has a swtich case for different architectures.
+ * Currently only 32-Bit ARM is supported. The data includes memory spaces,
+ * register groups and registers themselves. They get stored into GLists w=
here
+ * every entry in the list corresponds to one opened core.
+ * @param[in] params GArray with all TCP packet parameters.
+ */
 void handle_open_core(GArray *params, void *user_ctx);
+/**
+ * \brief Handler for the first reset query.
+ *=20
+ * This function sends the first reset name and ID.
+ * @param[in] params GArray with all TCP packet parameters.
+ */
 void handle_query_reset_f(GArray *params, void *user_ctx);
+/**
+ * \brief Handler for all consecutive reset queries.
+ *=20
+ * This functions sends all consecutive reset names and IDs. It uses the
+ * query_index parameter to determine which reset is queried next.
+ * @param[in] params GArray with all TCP packet parameters.
+ */
 void handle_query_reset_c(GArray *params, void *user_ctx);
+/**
+ * \brief Handler for closing the MCD server.
+ *=20
+ * This function detaches the debugger (process) and frees up memory.
+ * Then it start the QEMU VM with \ref mcd_vm_start.
+ * @param[in] params GArray with all TCP packet parameters.
+ */
 void handle_close_server(GArray *params, void *user_ctx);
+/**
+ * \brief Handler for closing a core.
+ *=20
+ * Frees all memory allocated for core specific information. This includes
+ * memory spaces, register groups and registers.
+ * @param[in] params GArray with all TCP packet parameters.
+ */
 void handle_close_core(GArray *params, void *user_ctx);
+/**
+ * \brief Handler for trigger query.
+ *=20
+ * Sends data on the different types of trigger and their options and acti=
ons.
+ * @param[in] params GArray with all TCP packet parameters.
+ */
 void handle_query_trigger(GArray *params, void *user_ctx);
+/**
+ * \brief Starts all CPUs with the vm_start function.
+ */
 void mcd_vm_start(void);
+/**
+ * \brief Starts the selected CPU with the cpu_resume function.
+ *=20
+ * @param[in] cpu The CPU about to be started.
+ */
 void mcd_cpu_start(CPUState *cpu);
+/**
+ * \brief Performes a step on the selected CPU.
+ *=20
+ * This function first sets the correct single step flags for the CPU with
+ * cpu_single_step and then starts the CPU with cpu_resume.
+ * @param[in] cpu The CPU about to be stepped.
+ */
 int mcd_cpu_sstep(CPUState *cpu);
+/**
+ * \brief Brings all CPUs in debug state with the vm_stop function.
+ */
 void mcd_vm_stop(void);
+/**
+ * \brief Handler for the first register group query.
+ *=20
+ * This function sends the first register group name and ID.
+ * @param[in] params GArray with all TCP packet parameters.
+ */
 void handle_query_reg_groups_f(GArray *params, void *user_ctx);
+/**
+ * \brief Handler for all consecutive register group queries.
+ *=20
+ * This function sends all consecutive register group names and IDs. It us=
es
+ * the query_index parameter to determine which register group is queried =
next.
+ * @param[in] params GArray with all TCP packet parameters.
+ */
 void handle_query_reg_groups_c(GArray *params, void *user_ctx);
+/**
+ * \brief Handler for the first memory space query.
+ *=20
+ * This function sends the first memory space name, ID, type and accessing
+ * options.
+ * @param[in] params GArray with all TCP packet parameters.
+ */
 void handle_query_mem_spaces_f(GArray *params, void *user_ctx);
+/**
+ * \brief Handler for all consecutive memory space queries.
+ *=20
+ * This function sends all consecutive memory space names, IDs, types and
+ * accessing options.
+ * It uses the query_index parameter to determine
+ * which memory space is queried next.
+ * @param[in] params GArray with all TCP packet parameters.
+ */
 void handle_query_mem_spaces_c(GArray *params, void *user_ctx);
+/**
+ * \brief Handler for the first register query.
+ *=20
+ * This function sends the first register with all its information.
+ * @param[in] params GArray with all TCP packet parameters.
+ */
 void handle_query_regs_f(GArray *params, void *user_ctx);
+/**
+ * \brief Handler for all consecutive register queries.
+ *=20
+ * This function sends all consecutive registers with all their informatio=
n.
+ * It uses the query_index parameter to determine
+ * which register is queried next.
+ * @param[in] params GArray with all TCP packet parameters.
+ */
 void handle_query_regs_c(GArray *params, void *user_ctx);
+/**
+ * \brief Handler for opening the MCD server.
+ *=20
+ * This is the first function that gets called from the MCD Shared Library.
+ * It initializes core indepent data with the \ref init_resets and
+ * \reg init_trigger functions. It also send the \c TCP_HANDSHAKE_SUCCESS
+ * packet back to the library to confirm the mcdstub is ready for further
+ * communication.
+ * @param[in] params GArray with all TCP packet parameters.
+ */
 void handle_open_server(GArray *params, void *user_ctx);
+/**
+ * \brief Handler for performing resets.
+ *=20
+ * This function is currently not in use.
+ * @param[in] params GArray with all TCP packet parameters.
+ */
 void handle_reset(GArray *params, void *user_ctx);
+/**
+ * \brief Handler for the state query.
+ *=20
+ * This function collects all data stored in the
+ * cpu_state member of the mcdserver_state and formats and sends it to the
+ * library.
+ * @param[in] params GArray with all TCP packet parameters.
+ */
 void handle_query_state(GArray *params, void *user_ctx);
+/**
+ * \brief Handler for reading a register.
+ *=20
+ * This function calls \ref mcd_read_register to read a register. The regi=
ster
+ * data gets stored in the mem_buf byte array. The data then gets converted
+ * into a hex string with \ref mcd_memtohex and then send.
+ * @param[in] params GArray with all TCP packet parameters.
+ */
 void handle_read_register(GArray *params, void *user_ctx);
+/**
+ * \brief Handler for writing a register.
+ *=20
+ * This function converts the incoming hex string data into a byte array w=
ith
+ * \ref mcd_hextomem. Then it calls \ref mcd_write_register to write to the
+ * register.
+ * @param[in] params GArray with all TCP packet parameters.
+ */
 void handle_write_register(GArray *params, void *user_ctx);
+/**
+ * \brief Handler for reading memory.
+ *=20
+ * First, this function checks whether reading a secure memory space is
+ * requested and changes the access mode with \ref arm_mcd_set_scr.
+ * Then it calls \ref mcd_read_memory to read memory. The collected
+ * data gets stored in the mem_buf byte array. The data then gets converted
+ * into a hex string with \ref mcd_memtohex and then send.
+ * @param[in] params GArray with all TCP packet parameters.
+ */
 void handle_read_memory(GArray *params, void *user_ctx);
+/**
+ * \brief Handler for writing memory.
+ *=20
+ * First, this function checks whether reading a secure memory space is
+ * requested and changes the access mode with \ref arm_mcd_set_scr.
+ * Then it converts the incoming hex string data into a byte array with
+ * \ref mcd_hextomem. Then it calls \ref mcd_write_memory to write to the
+ * register.
+ * @param[in] params GArray with all TCP packet parameters.
+ */
 void handle_write_memory(GArray *params, void *user_ctx);
+/**
+ * \brief Reads a registers data and stores it into the buf.
+ *=20
+ * This function collects the register type and internal ID
+ * (depending on the XML file). Then it calls the architecture specific
+ * read function. For ARM this is \ref arm_mcd_read_register.
+ * @param[in] cpu CPU to which the register belongs.
+ * @param[out] buf Byte array with register data.
+ * @param[in] reg General ID of the register.
+ */
 int mcd_read_register(CPUState *cpu, GByteArray *buf, int reg);
+/**
+ * \brief Writes data from the buf to a register.
+ *=20
+ * This function collects the register type and internal ID
+ * (depending on the XML file). Then it calls the architecture specific
+ * write function. For ARM this is \ref arm_mcd_write_register.
+ * @param[in] cpu CPU to which the register belongs.
+ * @param[in] buf Byte array with register data.
+ * @param[in] reg General ID of the register.
+ */
 int mcd_write_register(CPUState *cpu, GByteArray *buf, int reg);
+/**
+ * \brief Reads memory data and stores it into the buf.
+ *=20
+ * This function calls cpu_memory_rw_debug or if available
+ * memory_rw_debug in read mode and passes on all parameters.
+ * @param[in] cpu CPU to which the memory belongs.
+ * @param[in] addr Address to start reading.
+ * @param[out] buf Byte array with memory data.
+ * @param[in] len Number of bytes to be read.
+ */
 int mcd_read_memory(CPUState *cpu, hwaddr addr, uint8_t *buf, int len);
+/**
+ * \brief Writes data from the buf into the memory.
+ *=20
+ * This function calls cpu_memory_rw_debug or if available
+ * memory_rw_debug in write mode and passes on all parameters.
+ * @param[in] cpu CPU to which the memory belongs.
+ * @param[in] addr Address to start writing.
+ * @param[in] buf Byte array with memory data.
+ * @param[in] len Number of bytes to be written.
+ */
 int mcd_write_memory(CPUState *cpu, hwaddr addr, uint8_t *buf, int len);
+/**
+ * \brief Handler for inserting a break- or watchpoint.
+ *=20
+ * This function extracts the CPU, breakpoint type and address from the
+ * parameters and calls \ref mcd_breakpoint_insert to insert the breakpoin=
t.
+ * @param[in] params GArray with all TCP packet parameters.
+ */
 void handle_breakpoint_insert(GArray *params, void *user_ctx);
+/**
+ * \brief Handler for inserting a break- or watchpoint.
+ *=20
+ * This function extracts the CPU, breakpoint type and address from the
+ * parameters and calls \ref mcd_breakpoint_remove to insert the breakpoin=
t.
+ * @param[in] params GArray with all TCP packet parameters.
+ */
 void handle_breakpoint_remove(GArray *params, void *user_ctx);
+/**
+ * \brief Inserts a break- or watchpoint.
+ *=20
+ * This function evaluates the received breakpoint type and translates it
+ * to a known GDB breakpoint type.
+ * Then it calls cpu_breakpoint_insert or cpu_watchpoint_insert depending =
on
+ * the type.
+ * @param[in] cpu CPU to which the breakpoint should be added.
+ * @param[in] addr Address of the breakpoint.
+ * @param[in] type Breakpoint type.
+ */
 int mcd_breakpoint_insert(CPUState *cpu, int type, vaddr addr);
+/**
+ * \brief Removes a break- or watchpoint.
+ *=20
+ * This function evaluates the received breakpoint type and translates it
+ * to a known GDB breakpoint type.
+ * Then it calls cpu_breakpoint_remove or cpu_watchpoint_remove depending =
on
+ * the type.
+ * @param[in] cpu CPU from which the breakpoint should be removed.
+ * @param[in] addr Address of the breakpoint.
+ * @param[in] type Breakpoint type.
+ */
 int mcd_breakpoint_remove(CPUState *cpu, int type, vaddr addr);
=20
+/** @} */
+
 /* sycall handling */
 void mcd_syscall_reset(void);
 void mcd_disable_syscalls(void);
=20
 /* helpers */
+
+/**
+ * \defgroup helperfunctions Helper mcdstub functions
+ * Supporting functions used throughout the mcdstub.
+ */
+
+/**
+ * \addtogroup helperfunctions
+ * @{
+ */
+
+/**
+ * \brief Compares a and b and returns zero if they are equal.
+ *
+ * @param[in] a Pointer to integer a.
+ * @param[in] b Pointer to integer b.
+ */
 int int_cmp(gconstpointer a, gconstpointer b);
+/**
+ * \brief Converts a byte array into a hex string.
+ *
+ * @param[in] mem Pointer to byte array.
+ * @param[out] buf Pointer to hex string.
+ * @param[in] len Number of bytes.
+ */
 void mcd_memtohex(GString *buf, const uint8_t *mem, int len);
+/**
+ * \brief Converts a hex string into a byte array.
+ *
+ * @param[out] mem Pointer to byte array.
+ * @param[in] buf Pointer to hex string.
+ * @param[in] len Number of bytes.
+ */
 void mcd_hextomem(GByteArray *mem, const char *buf, int len);
+/**
+ * \brief Converts a string into a unsigned 64 bit integer.
+ *
+ * @param[in] in Pointer to input string.
+ */
 uint64_t atouint64_t(const char *in);
+/**
+ * \brief Converts a string into a unsigned 32 bit integer.
+ *
+ * @param[in] in Pointer to input string.
+ */
 uint32_t atouint32_t(const char *in);
=20
+/** @} */
+
 #endif /* MCDSTUB_INTERNALS_H */
diff --git a/mcdstub/mcdstub_common.h b/mcdstub/mcdstub_common.h
index f5175e3979..f6247fce70 100644
--- a/mcdstub/mcdstub_common.h
+++ b/mcdstub/mcdstub_common.h
@@ -40,7 +40,25 @@ typedef struct mcd_reg_group_st {
     uint32_t id;
 } mcd_reg_group_st;
=20
+/**
+ * \addtogroup mcdstub
+ * @{
+ */
+
+/**
+ * \brief Parses a GDB register XML file.
+ *
+ * This fuction extracts all registers from the provided xml file and stor=
es
+ * them into the registers GArray. It extracts the register name, bitsize,=
 type
+ * and group if they are set.
+ * @param[in] xml String with contents of the XML file.
+ * @param[out] registers GArray with stored registers.
+ * @param[in] reg_type Register type (depending on file).
+ * @param[in] size Number of characters in the xml string.
+ */
 void parse_reg_xml(const char *xml, int size, GArray* registers,
     uint8_t reg_type);
=20
+/** @} */
+
 #endif /* MCDSTUB_COMMON_H */
diff --git a/target/arm/mcdstub.c b/target/arm/mcdstub.c
index d2a83a3cd9..6c98c34673 100644
--- a/target/arm/mcdstub.c
+++ b/target/arm/mcdstub.c
@@ -350,11 +350,6 @@ int arm_mcd_store_mem_spaces(CPUState *cpu, GArray *me=
mspaces)
     int nr_address_spaces =3D cpu->num_ases;
     uint32_t mem_space_id =3D 0;
=20
-    /*
-     * TODO: atm we can only access physical memory addresses,
-     * but trace32 needs fake locical spaces to work with
-    */
-
     mem_space_id++;
     mcd_mem_space_st non_secure =3D {
         .name =3D "Non Secure",
@@ -413,7 +408,6 @@ int arm_mcd_store_mem_spaces(CPUState *cpu, GArray *mem=
spaces)
         };
         g_array_append_vals(memspaces, (gconstpointer)&phys_secure, 1);
     }
-    /* TODO: get dynamically how the per (CP15) space is called */
     mem_space_id++;
     mcd_mem_space_st gpr =3D {
         .name =3D "GPR Registers",
diff --git a/target/arm/mcdstub.h b/target/arm/mcdstub.h
index 1321d5dc07..daba7a04d7 100644
--- a/target/arm/mcdstub.h
+++ b/target/arm/mcdstub.h
@@ -25,19 +25,124 @@ enum {
     MCD_ARM_REG_TYPE_CPR,
 };
=20
+/**
+ * \defgroup armmcdstub ARM mcdstub functions
+ * All ARM specific functions of the mcdstub.
+ */
+
+/**
+ * \addtogroup armmcdstub
+ * @{
+ */
+
+/**
+ * \brief Returns the contents of the desired XML file.
+ *=20
+ * @param[in] xmlname Name of the desired XML file.
+ * @param[in] cs CPU state.
+ */
 const char *arm_mcd_get_dynamic_xml(CPUState *cs, const char *xmlname);
+/**
+ * \brief Calls the correct read function which writes data into the mem_b=
uf.
+ *=20
+ * Depending on the reg_type of the register one of the following functions
+ * will get called: arm_mcd_read_gpr_register, arm_mcd_read_vfp_register,
+ * arm_mcd_read_vfp_sys_register, arm_mcd_read_mve_register and
+ * arm_mcd_read_cpr_register. In those the data of the requested register =
will
+ * be stored as byte array into mem_buf. The function returns zero if no b=
ytes
+ * were written
+ * @param[out] mem_buf Byte array for register data.
+ * @param[in] reg_type Type of register.
+ * @param[in] n The register ID within its type.
+ * @param[in] cs CPU state.
+ */
 int arm_mcd_read_register(CPUState *cs, GByteArray *mem_buf, uint8_t reg_t=
ype,
     uint32_t n);
+/**
+ * \brief Calls the correct write function which writes data from the mem_=
buf.
+ *=20
+ * Depending on the reg_type of the register one of the following functions
+ * will get called: arm_mcd_write_gpr_register, arm_mcd_write_vfp_register,
+ * arm_mcd_write_vfp_sys_register, arm_mcd_write_mve_register and
+ * arm_mcd_write_cpr_register. In those the register data from mem_buf will
+ * be written. The function returns zero if no bytes were written.
+ * @param[in] mem_buf Byte array for register data.
+ * @param[in] reg_type Type of register.
+ * @param[in] n The register ID within its type.
+ * @param[in] cs CPU state.
+ */
 int arm_mcd_write_register(CPUState *cs, GByteArray *mem_buf, uint8_t reg_=
type,
     uint32_t n);
+/**
+ * \brief Returns the opcode for a coprocessor register.
+ *=20
+ * This function uses the opc1, opc2, crm and crn members of the register =
to
+ * create the opcode. The formular for creating the opcode is determined b=
y ARM.
+ * @param[in] n The register ID of the CP register.
+ * @param[in] cs CPU state.
+ */
 uint16_t arm_mcd_get_opcode(CPUState *cs, uint32_t n);
+/**
+ * \brief Sets the scr_el3 register according to the secure parameter.
+ *=20
+ * If secure is true, the first bit of the scr_el3 register gets set to 0,
+ * if not it gets set to 1.
+ * @param[in] secure True when secure is requested.
+ * @param[in] cs CPU state.
+ */
 int arm_mcd_set_scr(CPUState *cs, bool secure);
+/**
+ * \brief Stores all 32-Bit ARM specific memory spaces.
+ *=20
+ * This function stores the memory spaces into the memspaces GArray.
+ * It only stores secure memory spaces if the CPU has more than one address
+ * space. It also stores a GPR and a CP15 register memory space.
+ * @param[out] memspaces GArray of memory spaces.
+ * @param[in] cpu CPU state.
+ */
 int arm_mcd_store_mem_spaces(CPUState *cpu, GArray *memspaces);
+/**
+ * \brief Parses the GPR registers.
+ *=20
+ * This function parses the core XML file, which includes the GPR register=
s.
+ * The regsters get stored in a GArray and a GPR register group is stored =
in a
+ * second GArray.
+ * @param[out] reggroups GArray of register groups.
+ * @param[out] registers GArray of registers.
+ * @param[in] cc The CPU class.
+ * @param[in,out] current_group_id The current group ID. It increases after
+ * each group.
+ */
 int arm_mcd_parse_core_xml_file(CPUClass *cc, GArray *reggroups,
     GArray *registers, int *current_group_id);
+/**
+ * \brief Parses all but the GPR registers.
+ *=20
+ * This function parses all XML files except for the core XML file.
+ * The regsters get stored in a GArray and if the system-registers.xml fil=
e is
+ * parsed, it also adds a CP15 register group.
+ * @param[out] reggroups GArray of register groups.
+ * @param[out] registers GArray of registers.
+ * @param[in] cpu The CPU state.
+ * @param[in,out] current_group_id The current group ID. It increases after
+ * each added group.
+ */
 int arm_mcd_parse_general_xml_files(CPUState *cpu, GArray* reggroups,
     GArray *registers, int *current_group_id);
+/**
+ * \brief Adds additional data to parsed registers.
+ *=20
+ * This function is called, after \ref arm_mcd_parse_core_xml_file and
+ * \ref arm_mcd_parse_core_xml_file. It adds additional data for all alrea=
dy
+ * parsed registers. The registers get a correct ID, group, memory space a=
nd
+ * opcode, if they are CP15 registers.
+ * @param[in] reggroups GArray of register groups.
+ * @param[in,out] registers GArray of registers.
+ * @param[in] cpu The CPU state.
+ */
 int arm_mcd_get_additional_register_info(GArray *reggroups, GArray *regist=
ers,
     CPUState *cpu);
=20
+/** @} */
+
 #endif /* ARM_MCDSTUB_H */
--=20
2.34.1


From 40cd4a9d23f24b6350ce14fd6377e05a15e9c66b Mon Sep 17 00:00:00 2001
From: Nicolas Eder <nicolas.eder@lauterbach.com>
Date: Mon, 11 Sep 2023 11:36:24 +0200
Subject: [PATCH 26/29] moved all mcd related header files into include/mcds=
tub

Signed-off-by: Nicolas Eder <nicolas.eder@lauterbach.com>
---
 target/arm/mcdstub.h =3D> include/mcdstub/arm_mcdstub.h | 2 +-
 {mcdstub =3D> include/mcdstub}/mcd_shared_defines.h     | 0
 {mcdstub =3D> include/mcdstub}/mcdstub.h                | 0
 {mcdstub =3D> include/mcdstub}/mcdstub_common.h         | 0
 mcdstub/mcd_syscalls.c                                | 2 +-
 mcdstub/mcdstub.c                                     | 6 +++---
 target/arm/mcdstub.c                                  | 3 ++-
 7 files changed, 7 insertions(+), 6 deletions(-)
 rename target/arm/mcdstub.h =3D> include/mcdstub/arm_mcdstub.h (99%)
 rename {mcdstub =3D> include/mcdstub}/mcd_shared_defines.h (100%)
 rename {mcdstub =3D> include/mcdstub}/mcdstub.h (100%)
 rename {mcdstub =3D> include/mcdstub}/mcdstub_common.h (100%)

diff --git a/target/arm/mcdstub.h b/include/mcdstub/arm_mcdstub.h
similarity index 99%
rename from target/arm/mcdstub.h
rename to include/mcdstub/arm_mcdstub.h
index daba7a04d7..3db271150a 100644
--- a/target/arm/mcdstub.h
+++ b/include/mcdstub/arm_mcdstub.h
@@ -2,7 +2,7 @@
 #define ARM_MCDSTUB_H
=20
 #include "hw/core/cpu.h"
-#include "mcdstub/mcdstub_common.h"
+#include "mcdstub_common.h"
 /* just used for the register xml files */
 #include "exec/gdbstub.h"
=20
diff --git a/mcdstub/mcd_shared_defines.h b/include/mcdstub/mcd_shared_defi=
nes.h
similarity index 100%
rename from mcdstub/mcd_shared_defines.h
rename to include/mcdstub/mcd_shared_defines.h
diff --git a/mcdstub/mcdstub.h b/include/mcdstub/mcdstub.h
similarity index 100%
rename from mcdstub/mcdstub.h
rename to include/mcdstub/mcdstub.h
diff --git a/mcdstub/mcdstub_common.h b/include/mcdstub/mcdstub_common.h
similarity index 100%
rename from mcdstub/mcdstub_common.h
rename to include/mcdstub/mcdstub_common.h
diff --git a/mcdstub/mcd_syscalls.c b/mcdstub/mcd_syscalls.c
index eaa6853335..e363a249ca 100644
--- a/mcdstub/mcd_syscalls.c
+++ b/mcdstub/mcd_syscalls.c
@@ -3,7 +3,7 @@
 #include "semihosting/semihost.h"
 #include "sysemu/runstate.h"
 #include "mcdstub/syscalls.h"
-#include "mcdstub.h"
+#include "mcdstub/mcdstub.h"
=20
 typedef struct {
     char syscall_buf[256];
diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index a468a7d7b8..4f9fafe749 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -25,11 +25,11 @@
 #include "monitor/monitor.h"
=20
 /* mcdstub header files */
-#include "mcd_shared_defines.h"
-#include "mcdstub.h"
+#include "mcdstub/mcd_shared_defines.h"
+#include "mcdstub/mcdstub.h"
=20
 /* architecture specific stubs */
-#include "target/arm/mcdstub.h"
+#include "mcdstub/arm_mcdstub.h"
=20
 typedef struct {
     CharBackend chr;
diff --git a/target/arm/mcdstub.c b/target/arm/mcdstub.c
index 6c98c34673..1b82b9d439 100644
--- a/target/arm/mcdstub.c
+++ b/target/arm/mcdstub.c
@@ -4,7 +4,8 @@
 #include "sysemu/tcg.h"
 #include "internals.h"
 #include "cpregs.h"
-#include "mcdstub.h"
+
+#include "mcdstub/arm_mcdstub.h"
=20
 static inline int mcd_get_reg32(GByteArray *buf, uint32_t val)
 {
--=20
2.34.1


From 5f5795d6aa758484e61ee4bdc2ae210c47e788f2 Mon Sep 17 00:00:00 2001
From: Nicolas Eder <nicolas.eder@lauterbach.com>
Date: Mon, 11 Sep 2023 11:42:29 +0200
Subject: [PATCH 27/29] MCD stub entry added to maintainers file

Signed-off-by: Nicolas Eder <nicolas.eder@lauterbach.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 81625f036b..b6bc8201bb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2832,6 +2832,15 @@ F: tests/tcg/multiarch/gdbstub/
 F: scripts/feature_to_c.sh
 F: scripts/probe-gdb-support.py
=20
+MCD stub
+M: Nicolas Eder <nicolas.eder@lauterbach.com>
+R: Alex Benn=C3=A9e <alex.bennee@linaro.org>
+S: Maintained
+F: mcdstub/*
+F: include/exec/mcdstub.h
+F: include/mcdstub/*
+F: target/arm/mcdstub.c
+
 Memory API
 M: Paolo Bonzini <pbonzini@redhat.com>
 M: Peter Xu <peterx@redhat.com>
--=20
2.34.1


From 834f013b92d7b6b2039b7bd5802fc1072d621963 Mon Sep 17 00:00:00 2001
From: Nicolas Eder <nicolas.eder@lauterbach.com>
Date: Mon, 11 Sep 2023 11:45:51 +0200
Subject: [PATCH 28/29] added description to out-commented gdb function

Signed-off-by: Nicolas Eder <nicolas.eder@lauterbach.com>
---
 softmmu/cpus.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/softmmu/cpus.c b/softmmu/cpus.c
index b1807e6d7b..5d0657bbe5 100644
--- a/softmmu/cpus.c
+++ b/softmmu/cpus.c
@@ -306,7 +306,10 @@ void cpu_handle_guest_debug(CPUState *cpu)
             cpu_single_step(cpu, 0);
         }
     } else {
-        /*gdb_set_stop_cpu(cpu);*/
+        /*
+         * TODO: was gdb_set_stop_cpu(cpu), need to abstract options to
+         * a QOM class.
+         */
         qemu_system_debug_request();
         cpu->stopped =3D true;
     }
--=20
2.34.1


From c32c1312e521a7155810e0a00298bdc8be37dd0a Mon Sep 17 00:00:00 2001
From: Nicolas Eder <nicolas.eder@lauterbach.com>
Date: Thu, 21 Sep 2023 15:44:34 +0200
Subject: [PATCH 29/29] introducing the DebugClass. It is used to abstract t=
he
 gdb/mcd set_stop_cpu function.

Signed-off-by: Nicolas Eder <nicolas.eder@lauterbach.com>
---
 MAINTAINERS                   |   3 +
 debug/debug-common.c          |  42 ++++++++++++
 debug/debug-gdb.c             |  24 +++++++
 debug/debug-mcd.c             |  25 +++++++
 gdbstub/meson.build           |   4 +-
 gdbstub/softmmu.c             |   4 ++
 gdbstub/user.c                |   2 +
 include/exec/gdbstub.h        |   5 ++
 include/hw/boards.h           |   1 +
 include/mcdstub/arm_mcdstub.h |  25 +++----
 include/mcdstub/mcdstub.h     | 122 ++++++++++++++++++----------------
 include/qemu/debug.h          |  19 ++++++
 include/qemu/typedefs.h       |   2 +
 mcdstub/mcdstub.c             |  51 +++++++++-----
 mcdstub/meson.build           |   4 +-
 softmmu/cpus.c                |  12 ++--
 target/arm/mcdstub.c          |  17 +----
 17 files changed, 247 insertions(+), 115 deletions(-)
 create mode 100644 debug/debug-common.c
 create mode 100644 debug/debug-gdb.c
 create mode 100644 debug/debug-mcd.c
 create mode 100644 include/qemu/debug.h

diff --git a/MAINTAINERS b/MAINTAINERS
index b6bc8201bb..b2a1d2bfc6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2839,6 +2839,9 @@ S: Maintained
 F: mcdstub/*
 F: include/exec/mcdstub.h
 F: include/mcdstub/*
+F: include/qemu/debug.h
+F: debug/debug-common.c
+F: debug/debug-mcd.c
 F: target/arm/mcdstub.c
=20
 Memory API
diff --git a/debug/debug-common.c b/debug/debug-common.c
new file mode 100644
index 0000000000..8f41b4e6cb
--- /dev/null
+++ b/debug/debug-common.c
@@ -0,0 +1,42 @@
+#include "qemu/osdep.h"
+#include "qemu/ctype.h"
+#include "qemu/cutils.h"
+#include "qemu/module.h"
+#include "qemu/error-report.h"
+#include "hw/cpu/cluster.h"
+#include "hw/boards.h"
+#include "sysemu/hw_accel.h"
+#include "sysemu/runstate.h"
+#include "exec/replay-core.h"
+#include "exec/hwaddr.h"
+#include "qemu/debug.h"
+#include "qom/object_interfaces.h"
+
+static void debug_instance_init(Object *obj)
+{
+}
+
+static void debug_finalize(Object *obj)
+{
+}
+
+static void debug_class_init(ObjectClass *oc, void *data)
+{
+}
+
+static const TypeInfo debug_info =3D {
+    .name =3D TYPE_DEBUG,
+    .parent =3D TYPE_OBJECT,
+    .instance_size =3D sizeof(DebugState),
+    .instance_init =3D debug_instance_init,
+    .instance_finalize =3D debug_finalize,
+    .class_size =3D sizeof(DebugClass),
+    .class_init =3D debug_class_init
+};
+
+static void debug_register_types(void)
+{
+    type_register_static(&debug_info);
+}
+
+type_init(debug_register_types);
diff --git a/debug/debug-gdb.c b/debug/debug-gdb.c
new file mode 100644
index 0000000000..9c7bcda95f
--- /dev/null
+++ b/debug/debug-gdb.c
@@ -0,0 +1,24 @@
+#include "qemu/osdep.h"
+#include "qemu/ctype.h"
+#include "qemu/cutils.h"
+#include "qemu/module.h"
+#include "qemu/error-report.h"
+#include "hw/cpu/cluster.h"
+#include "hw/boards.h"
+#include "sysemu/hw_accel.h"
+#include "sysemu/runstate.h"
+#include "exec/replay-core.h"
+#include "exec/hwaddr.h"
+#include "exec/gdbstub.h"
+#include "qemu/debug.h"
+
+void gdb_init_debug_class(void)
+{
+    Object *obj;
+    obj =3D object_new(TYPE_DEBUG);
+    DebugState *ds =3D DEBUG(obj);
+    DebugClass *dc =3D DEBUG_GET_CLASS(ds);
+    dc->set_stop_cpu =3D gdb_set_stop_cpu;
+    MachineState *ms =3D MACHINE(qdev_get_machine());
+    ms->debug_state =3D ds;
+}
diff --git a/debug/debug-mcd.c b/debug/debug-mcd.c
new file mode 100644
index 0000000000..2d3a31be15
--- /dev/null
+++ b/debug/debug-mcd.c
@@ -0,0 +1,25 @@
+#include "qemu/osdep.h"
+#include "qemu/ctype.h"
+#include "qemu/cutils.h"
+#include "qemu/module.h"
+#include "qemu/error-report.h"
+#include "hw/cpu/cluster.h"
+#include "hw/boards.h"
+#include "sysemu/hw_accel.h"
+#include "sysemu/runstate.h"
+#include "exec/replay-core.h"
+#include "exec/hwaddr.h"
+#include "mcdstub/mcdstub.h"
+#include "qemu/debug.h"
+#include "qom/object_interfaces.h"
+
+void mcd_init_debug_class(void)
+{
+    Object *obj;
+    obj =3D object_new(TYPE_DEBUG);
+    DebugState *ds =3D DEBUG(obj);
+    DebugClass *dc =3D DEBUG_GET_CLASS(ds);
+    dc->set_stop_cpu =3D mcd_set_stop_cpu;
+    MachineState *ms =3D MACHINE(qdev_get_machine());
+    ms->debug_state =3D ds;
+}
diff --git a/gdbstub/meson.build b/gdbstub/meson.build
index a5a1f4e433..e4ee9e5035 100644
--- a/gdbstub/meson.build
+++ b/gdbstub/meson.build
@@ -11,8 +11,8 @@ gdb_user_ss =3D ss.source_set()
 gdb_system_ss =3D ss.source_set()
=20
 # We build two versions of gdbstub, one for each mode
-gdb_user_ss.add(files('gdbstub.c', 'user.c'))
-gdb_system_ss.add(files('gdbstub.c', 'softmmu.c'))
+gdb_user_ss.add(files('gdbstub.c', 'user.c', '../debug/debug-gdb.c'))
+gdb_system_ss.add(files('gdbstub.c', 'softmmu.c', '../debug/debug-gdb.c'))
=20
 gdb_user_ss =3D gdb_user_ss.apply(config_targetos, strict: false)
 gdb_system_ss =3D gdb_system_ss.apply(config_targetos, strict: false)
diff --git a/gdbstub/softmmu.c b/gdbstub/softmmu.c
index 9f0b8b5497..27af26d308 100644
--- a/gdbstub/softmmu.c
+++ b/gdbstub/softmmu.c
@@ -14,6 +14,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/cutils.h"
+#include "qemu/debug.h"
 #include "exec/gdbstub.h"
 #include "gdbstub/syscalls.h"
 #include "exec/hwaddr.h"
@@ -405,6 +406,9 @@ int gdbserver_start(const char *device)
     gdbserver_system_state.mon_chr =3D mon_chr;
     gdb_syscall_reset();
=20
+    /* create new debug object */
+    gdb_init_debug_class();
+
     return 0;
 }
=20
diff --git a/gdbstub/user.c b/gdbstub/user.c
index 7ab6e5d975..ecffc354b1 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -326,8 +326,10 @@ int gdbserver_start(const char *port_or_path)
     }
=20
     if (port > 0 && gdb_accept_tcp(gdb_fd)) {
+        gdb_init_debug_class();
         return 0;
     } else if (gdb_accept_socket(gdb_fd)) {
+        gdb_init_debug_class();
         gdbserver_user_state.socket_path =3D g_strdup(port_or_path);
         return 0;
     }
diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 16a139043f..d0d4feebef 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -51,4 +51,9 @@ bool gdb_has_xml(void);
 /* in gdbstub-xml.c, generated by scripts/feature_to_c.sh */
 extern const char *const xml_builtin[][2];
=20
+/**
+ * gdb_init_debug_class() - initialize gdb-specific DebugClass
+ */
+void gdb_init_debug_class(void);
+
 #endif
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 55a64a13fd..e37cddab26 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -380,6 +380,7 @@ struct MachineState {
     CpuTopology smp;
     struct NVDIMMState *nvdimms_state;
     struct NumaState *numa_state;
+    DebugState *debug_state;
 };
=20
 #define DEFINE_MACHINE(namestr, machine_initfn) \
diff --git a/include/mcdstub/arm_mcdstub.h b/include/mcdstub/arm_mcdstub.h
index 3db271150a..93bf71e133 100644
--- a/include/mcdstub/arm_mcdstub.h
+++ b/include/mcdstub/arm_mcdstub.h
@@ -37,14 +37,14 @@ enum {
=20
 /**
  * \brief Returns the contents of the desired XML file.
- *=20
+ *
  * @param[in] xmlname Name of the desired XML file.
  * @param[in] cs CPU state.
  */
 const char *arm_mcd_get_dynamic_xml(CPUState *cs, const char *xmlname);
 /**
  * \brief Calls the correct read function which writes data into the mem_b=
uf.
- *=20
+ *
  * Depending on the reg_type of the register one of the following functions
  * will get called: arm_mcd_read_gpr_register, arm_mcd_read_vfp_register,
  * arm_mcd_read_vfp_sys_register, arm_mcd_read_mve_register and
@@ -60,7 +60,7 @@ int arm_mcd_read_register(CPUState *cs, GByteArray *mem_b=
uf, uint8_t reg_type,
     uint32_t n);
 /**
  * \brief Calls the correct write function which writes data from the mem_=
buf.
- *=20
+ *
  * Depending on the reg_type of the register one of the following functions
  * will get called: arm_mcd_write_gpr_register, arm_mcd_write_vfp_register,
  * arm_mcd_write_vfp_sys_register, arm_mcd_write_mve_register and
@@ -75,25 +75,16 @@ int arm_mcd_write_register(CPUState *cs, GByteArray *me=
m_buf, uint8_t reg_type,
     uint32_t n);
 /**
  * \brief Returns the opcode for a coprocessor register.
- *=20
+ *
  * This function uses the opc1, opc2, crm and crn members of the register =
to
  * create the opcode. The formular for creating the opcode is determined b=
y ARM.
  * @param[in] n The register ID of the CP register.
  * @param[in] cs CPU state.
  */
 uint16_t arm_mcd_get_opcode(CPUState *cs, uint32_t n);
-/**
- * \brief Sets the scr_el3 register according to the secure parameter.
- *=20
- * If secure is true, the first bit of the scr_el3 register gets set to 0,
- * if not it gets set to 1.
- * @param[in] secure True when secure is requested.
- * @param[in] cs CPU state.
- */
-int arm_mcd_set_scr(CPUState *cs, bool secure);
 /**
  * \brief Stores all 32-Bit ARM specific memory spaces.
- *=20
+ *
  * This function stores the memory spaces into the memspaces GArray.
  * It only stores secure memory spaces if the CPU has more than one address
  * space. It also stores a GPR and a CP15 register memory space.
@@ -103,7 +94,7 @@ int arm_mcd_set_scr(CPUState *cs, bool secure);
 int arm_mcd_store_mem_spaces(CPUState *cpu, GArray *memspaces);
 /**
  * \brief Parses the GPR registers.
- *=20
+ *
  * This function parses the core XML file, which includes the GPR register=
s.
  * The regsters get stored in a GArray and a GPR register group is stored =
in a
  * second GArray.
@@ -117,7 +108,7 @@ int arm_mcd_parse_core_xml_file(CPUClass *cc, GArray *r=
eggroups,
     GArray *registers, int *current_group_id);
 /**
  * \brief Parses all but the GPR registers.
- *=20
+ *
  * This function parses all XML files except for the core XML file.
  * The regsters get stored in a GArray and if the system-registers.xml fil=
e is
  * parsed, it also adds a CP15 register group.
@@ -131,7 +122,7 @@ int arm_mcd_parse_general_xml_files(CPUState *cpu, GArr=
ay* reggroups,
     GArray *registers, int *current_group_id);
 /**
  * \brief Adds additional data to parsed registers.
- *=20
+ *
  * This function is called, after \ref arm_mcd_parse_core_xml_file and
  * \ref arm_mcd_parse_core_xml_file. It adds additional data for all alrea=
dy
  * parsed registers. The registers get a correct ID, group, memory space a=
nd
diff --git a/include/mcdstub/mcdstub.h b/include/mcdstub/mcdstub.h
index 5412b59423..88f1ee58a7 100644
--- a/include/mcdstub/mcdstub.h
+++ b/include/mcdstub/mcdstub.h
@@ -217,6 +217,10 @@ int init_resets(GArray *resets);
  * @param[out] trigger Struct with all trigger info.
  */
 int init_trigger(mcd_trigger_into_st *trigger);
+/**
+ * mcd_init_debug_class() - initialize mcd-specific DebugClass
+ */
+void mcd_init_debug_class(void);
 /**
  * \brief Resets the mcdserver_state struct.
  *
@@ -251,7 +255,7 @@ int find_cpu_clusters(Object *child, void *opaque);
  *
  * This function returns -1 if process "a" has a ower process ID than "b".
  * If "b" has a lower ID than "a" 1 is returned and if they are qual 0 is
- * returned.=20
+ * returned.
  * @param[in] a Process a.
  * @param[in] b Process b.
  */
@@ -262,7 +266,7 @@ int pid_order(const void *a, const void *b);
 int mcd_chr_can_receive(void *opaque);
 /**
  * \brief Handles receiving a TCP packet.
- *=20
+ *
  * This function gets called by QEMU when a TCP packet is received.
  * It iterates over that packet an calls \ref mcd_read_byte for each char
  * of the packet.
@@ -272,7 +276,7 @@ int mcd_chr_can_receive(void *opaque);
 void mcd_chr_receive(void *opaque, const uint8_t *buf, int size);
 /**
  * \brief Handles a TCP client connect.
- *=20
+ *
  * This function gets called by QEMU when a TCP cliet connects to the open=
ed
  * TCP port. It attaches the first process. From here on TCP packets can be
  * exchanged.
@@ -285,7 +289,7 @@ void mcd_chr_event(void *opaque, QEMUChrEvent event);
 bool mcd_supports_guest_debug(void);
 /**
  * \brief Handles a state change of the QEMU VM.
- *=20
+ *
  * This function is called when the QEMU VM goes through a state transitio=
n.
  * It stores the runstate the CPU is in to the cpu_state and when in
  * \c RUN_STATE_DEBUG it collects additional data on what watchpoint was h=
it.
@@ -296,13 +300,13 @@ bool mcd_supports_guest_debug(void);
 void mcd_vm_state_change(void *opaque, bool running, RunState state);
 /**
  * \brief Calls \ref mcd_put_packet_binary with buf and length of buf.
- *=20
+ *
  * @param[in] buf TCP packet data.
  */
 int mcd_put_packet(const char *buf);
 /**
  * \brief Adds footer and header to the TCP packet data in buf.
- *=20
+ *
  * Besides adding header and footer, this function also stores the complet=
e TCP
  * packet in the last_packet member of the mcdserver_state. Then the packet
  * gets send with the \ref mcd_put_buffer function.
@@ -316,26 +320,30 @@ int mcd_put_packet_binary(const char *buf, int len);
 bool mcd_got_immediate_ack(void);
 /**
  * \brief Sends the buf as TCP packet with qemu_chr_fe_write_all.
- *=20
+ *
  * @param[in] buf TCP packet data.
  * @param[in] len TCP packet length.
  */
 void mcd_put_buffer(const uint8_t *buf, int len);
 /**
  * \brief Returns the process of the provided CPU.
- *=20
+ *
  * @param[in] cpu The CPU state.
  */
 MCDProcess *mcd_get_cpu_process(CPUState *cpu);
+/**
+ * \brief Sets c_cpu to the just stopped CPU.
+ */
+void mcd_set_stop_cpu(CPUState *cpu);
 /**
  * \brief Returns the process ID of the provided CPU.
- *=20
+ *
  * @param[in] cpu The CPU state.
  */
 uint32_t mcd_get_cpu_pid(CPUState *cpu);
 /**
  * \brief Returns the process of the provided pid.
- *=20
+ *
  * @param[in] pid The process ID.
  */
 MCDProcess *mcd_get_process(uint32_t pid);
@@ -344,16 +352,16 @@ MCDProcess *mcd_get_process(uint32_t pid);
  */
 CPUState *mcd_first_attached_cpu(void);
 /**
- * \brief Returns the first CPU with an attached process starting after th=
e=20
+ * \brief Returns the first CPU with an attached process starting after the
  * provided cpu.
- *=20
+ *
  * @param[in] cpu The CPU to start from.
  */
 CPUState *mcd_next_attached_cpu(CPUState *cpu);
 /**
  * \brief Resends the last packet if not acknowledged and extracts the data
  * from a received TCP packet.
- *=20
+ *
  * In case the last sent packet was not acknowledged from the mcdstub,
  * this function resends it.
  * If it was acknowledged this function parses the incoming packet
@@ -366,7 +374,7 @@ CPUState *mcd_next_attached_cpu(CPUState *cpu);
 void mcd_read_byte(uint8_t ch);
 /**
  * \brief Evaluates the type of received packet and chooses the correct ha=
ndler.
- *=20
+ *
  * This function takes the first character of the line_buf to determine the
  * type of packet. Then it selects the correct handler function and parame=
ter
  * schema. With this info it calls \ref run_cmd_parser.
@@ -379,7 +387,7 @@ int mcd_handle_packet(const char *line_buf);
 void mcd_put_strbuf(void);
 /**
  * \brief Terminates QEMU.
- *=20
+ *
  * If the mcdserver_state has not been initialized the function exits befo=
re
  * terminating QEMU. Terminting is done with the qemu_chr_fe_deinit functi=
on.
  * @param[in] code An exitcode, which can be used in the future.
@@ -387,7 +395,7 @@ void mcd_put_strbuf(void);
 void mcd_exit(int code);
 /**
  * \brief Prepares the mcdserver_state before executing TCP packet functio=
ns.
- *=20
+ *
  * This function empties the str_buf and mem_buf of the mcdserver_state and
  * then calls \ref process_string_cmd. In case this function fails, an emp=
ty
  * TCP packet is sent back the MCD Shared Library.
@@ -397,7 +405,7 @@ void mcd_exit(int code);
 void run_cmd_parser(const char *data, const MCDCmdParseEntry *cmd);
 /**
  * \brief Collects all parameters from the data and calls the correct hand=
ler.
- *=20
+ *
  * The parameters are extracted with the \ref cmd_parse_params function.
  * This function selects the command in the cmds array, which fits the sta=
rt of
  * the data string. This way the correct commands is selected.
@@ -409,7 +417,7 @@ int process_string_cmd(void *user_ctx, const char *data,
     const MCDCmdParseEntry *cmds, int num_cmds);
 /**
  * \brief Extracts all parameters from a TCP packet.
- *=20
+ *
  * This function uses the schema parameter to determine which type of para=
meter
  * to expect. It then extracts that parameter from the data and stores it =
in
  * the params GArray.
@@ -420,7 +428,7 @@ int process_string_cmd(void *user_ctx, const char *data,
 int cmd_parse_params(const char *data, const char *schema, GArray *params);
 /**
  * \brief Handler for the VM start TCP packet.
- *=20
+ *
  * Evaluates whether all cores or just a perticular core should get starte=
d and
  * calls \ref mcd_vm_start or \ref mcd_cpu_start respectively.
  * @param[in] params GArray with all TCP packet parameters.
@@ -428,7 +436,7 @@ int cmd_parse_params(const char *data, const char *sche=
ma, GArray *params);
 void handle_vm_start(GArray *params, void *user_ctx);
 /**
  * \brief Handler for the VM step TCP packet.
- *=20
+ *
  * Calls \ref mcd_cpu_sstep for the CPU which sould be stepped. Stepping a=
ll
  * CPUs is currently not supported.
  * @param[in] params GArray with all TCP packet parameters.
@@ -436,7 +444,7 @@ void handle_vm_start(GArray *params, void *user_ctx);
 void handle_vm_step(GArray *params, void *user_ctx);
 /**
  * \brief Handler for the VM stop TCP packet.
- *=20
+ *
  * Always calls \ref mcd_vm_stop and stops all cores. Stopping individual =
cores
  * is currently not supported
  * @param[in] params GArray with all TCP packet parameters.
@@ -444,7 +452,7 @@ void handle_vm_step(GArray *params, void *user_ctx);
 void handle_vm_stop(GArray *params, void *user_ctx);
 /**
  * \brief Handler for all TCP query packets.
- *=20
+ *
  * Calls \ref process_string_cmd with all query functions in the
  * mcd_query_cmds_table. \ref process_string_cmd then selects the correct =
one.
  * This function just passes on the TCP packet data string from the parame=
ters.
@@ -453,19 +461,19 @@ void handle_vm_stop(GArray *params, void *user_ctx);
 void handle_gen_query(GArray *params, void *user_ctx);
 /**
  * \brief Returns the internal CPU index plus one.
- *=20
+ *
  * @param[in] cpu CPU of interest.
  */
 int mcd_get_cpu_index(CPUState *cpu);
 /**
  * \brief Returns the CPU the index i_cpu_index.
- *=20
+ *
  * @param[in] cpu_index Index of the desired CPU.
  */
 CPUState *mcd_get_cpu(uint32_t cpu_index);
 /**
  * \brief Handler for the core query.
- *=20
+ *
  * This function sends the type of core and number of cores currently
  * simulated by QEMU. It also sends a device name for the MCD data structu=
re.
  * @param[in] params GArray with all TCP packet parameters.
@@ -473,26 +481,26 @@ CPUState *mcd_get_cpu(uint32_t cpu_index);
 void handle_query_cores(GArray *params, void *user_ctx);
 /**
  * \brief Handler for the system query.
- *=20
+ *
  * Sends the system name, which is "qemu-system".
  * @param[in] params GArray with all TCP packet parameters.
  */
 void handle_query_system(GArray *params, void *user_ctx);
 /**
  * \brief Returns the first CPU in the provided process.
- *=20
+ *
  * @param[in] process The process to look in.
  */
 CPUState *get_first_cpu_in_process(MCDProcess *process);
 /**
  * \brief Returns the CPU with an index equal to the thread_id.
- *=20
+ *
  * @param[in] thread_id ID of the desired CPU.
  */
 CPUState *find_cpu(uint32_t thread_id);
 /**
  * \brief Handler for opening a core.
- *=20
+ *
  * This function initializes all data for the core with the ID provided in
  * the first parameter. In has a swtich case for different architectures.
  * Currently only 32-Bit ARM is supported. The data includes memory spaces,
@@ -503,14 +511,14 @@ CPUState *find_cpu(uint32_t thread_id);
 void handle_open_core(GArray *params, void *user_ctx);
 /**
  * \brief Handler for the first reset query.
- *=20
+ *
  * This function sends the first reset name and ID.
  * @param[in] params GArray with all TCP packet parameters.
  */
 void handle_query_reset_f(GArray *params, void *user_ctx);
 /**
  * \brief Handler for all consecutive reset queries.
- *=20
+ *
  * This functions sends all consecutive reset names and IDs. It uses the
  * query_index parameter to determine which reset is queried next.
  * @param[in] params GArray with all TCP packet parameters.
@@ -518,7 +526,7 @@ void handle_query_reset_f(GArray *params, void *user_ct=
x);
 void handle_query_reset_c(GArray *params, void *user_ctx);
 /**
  * \brief Handler for closing the MCD server.
- *=20
+ *
  * This function detaches the debugger (process) and frees up memory.
  * Then it start the QEMU VM with \ref mcd_vm_start.
  * @param[in] params GArray with all TCP packet parameters.
@@ -526,7 +534,7 @@ void handle_query_reset_c(GArray *params, void *user_ct=
x);
 void handle_close_server(GArray *params, void *user_ctx);
 /**
  * \brief Handler for closing a core.
- *=20
+ *
  * Frees all memory allocated for core specific information. This includes
  * memory spaces, register groups and registers.
  * @param[in] params GArray with all TCP packet parameters.
@@ -534,7 +542,7 @@ void handle_close_server(GArray *params, void *user_ctx=
);
 void handle_close_core(GArray *params, void *user_ctx);
 /**
  * \brief Handler for trigger query.
- *=20
+ *
  * Sends data on the different types of trigger and their options and acti=
ons.
  * @param[in] params GArray with all TCP packet parameters.
  */
@@ -545,13 +553,13 @@ void handle_query_trigger(GArray *params, void *user_=
ctx);
 void mcd_vm_start(void);
 /**
  * \brief Starts the selected CPU with the cpu_resume function.
- *=20
+ *
  * @param[in] cpu The CPU about to be started.
  */
 void mcd_cpu_start(CPUState *cpu);
 /**
  * \brief Performes a step on the selected CPU.
- *=20
+ *
  * This function first sets the correct single step flags for the CPU with
  * cpu_single_step and then starts the CPU with cpu_resume.
  * @param[in] cpu The CPU about to be stepped.
@@ -563,14 +571,14 @@ int mcd_cpu_sstep(CPUState *cpu);
 void mcd_vm_stop(void);
 /**
  * \brief Handler for the first register group query.
- *=20
+ *
  * This function sends the first register group name and ID.
  * @param[in] params GArray with all TCP packet parameters.
  */
 void handle_query_reg_groups_f(GArray *params, void *user_ctx);
 /**
  * \brief Handler for all consecutive register group queries.
- *=20
+ *
  * This function sends all consecutive register group names and IDs. It us=
es
  * the query_index parameter to determine which register group is queried =
next.
  * @param[in] params GArray with all TCP packet parameters.
@@ -578,7 +586,7 @@ void handle_query_reg_groups_f(GArray *params, void *us=
er_ctx);
 void handle_query_reg_groups_c(GArray *params, void *user_ctx);
 /**
  * \brief Handler for the first memory space query.
- *=20
+ *
  * This function sends the first memory space name, ID, type and accessing
  * options.
  * @param[in] params GArray with all TCP packet parameters.
@@ -586,7 +594,7 @@ void handle_query_reg_groups_c(GArray *params, void *us=
er_ctx);
 void handle_query_mem_spaces_f(GArray *params, void *user_ctx);
 /**
  * \brief Handler for all consecutive memory space queries.
- *=20
+ *
  * This function sends all consecutive memory space names, IDs, types and
  * accessing options.
  * It uses the query_index parameter to determine
@@ -596,14 +604,14 @@ void handle_query_mem_spaces_f(GArray *params, void *=
user_ctx);
 void handle_query_mem_spaces_c(GArray *params, void *user_ctx);
 /**
  * \brief Handler for the first register query.
- *=20
+ *
  * This function sends the first register with all its information.
  * @param[in] params GArray with all TCP packet parameters.
  */
 void handle_query_regs_f(GArray *params, void *user_ctx);
 /**
  * \brief Handler for all consecutive register queries.
- *=20
+ *
  * This function sends all consecutive registers with all their informatio=
n.
  * It uses the query_index parameter to determine
  * which register is queried next.
@@ -612,7 +620,7 @@ void handle_query_regs_f(GArray *params, void *user_ctx=
);
 void handle_query_regs_c(GArray *params, void *user_ctx);
 /**
  * \brief Handler for opening the MCD server.
- *=20
+ *
  * This is the first function that gets called from the MCD Shared Library.
  * It initializes core indepent data with the \ref init_resets and
  * \reg init_trigger functions. It also send the \c TCP_HANDSHAKE_SUCCESS
@@ -623,14 +631,14 @@ void handle_query_regs_c(GArray *params, void *user_c=
tx);
 void handle_open_server(GArray *params, void *user_ctx);
 /**
  * \brief Handler for performing resets.
- *=20
+ *
  * This function is currently not in use.
  * @param[in] params GArray with all TCP packet parameters.
  */
 void handle_reset(GArray *params, void *user_ctx);
 /**
  * \brief Handler for the state query.
- *=20
+ *
  * This function collects all data stored in the
  * cpu_state member of the mcdserver_state and formats and sends it to the
  * library.
@@ -639,7 +647,7 @@ void handle_reset(GArray *params, void *user_ctx);
 void handle_query_state(GArray *params, void *user_ctx);
 /**
  * \brief Handler for reading a register.
- *=20
+ *
  * This function calls \ref mcd_read_register to read a register. The regi=
ster
  * data gets stored in the mem_buf byte array. The data then gets converted
  * into a hex string with \ref mcd_memtohex and then send.
@@ -648,7 +656,7 @@ void handle_query_state(GArray *params, void *user_ctx);
 void handle_read_register(GArray *params, void *user_ctx);
 /**
  * \brief Handler for writing a register.
- *=20
+ *
  * This function converts the incoming hex string data into a byte array w=
ith
  * \ref mcd_hextomem. Then it calls \ref mcd_write_register to write to the
  * register.
@@ -657,7 +665,7 @@ void handle_read_register(GArray *params, void *user_ct=
x);
 void handle_write_register(GArray *params, void *user_ctx);
 /**
  * \brief Handler for reading memory.
- *=20
+ *
  * First, this function checks whether reading a secure memory space is
  * requested and changes the access mode with \ref arm_mcd_set_scr.
  * Then it calls \ref mcd_read_memory to read memory. The collected
@@ -668,7 +676,7 @@ void handle_write_register(GArray *params, void *user_c=
tx);
 void handle_read_memory(GArray *params, void *user_ctx);
 /**
  * \brief Handler for writing memory.
- *=20
+ *
  * First, this function checks whether reading a secure memory space is
  * requested and changes the access mode with \ref arm_mcd_set_scr.
  * Then it converts the incoming hex string data into a byte array with
@@ -679,7 +687,7 @@ void handle_read_memory(GArray *params, void *user_ctx);
 void handle_write_memory(GArray *params, void *user_ctx);
 /**
  * \brief Reads a registers data and stores it into the buf.
- *=20
+ *
  * This function collects the register type and internal ID
  * (depending on the XML file). Then it calls the architecture specific
  * read function. For ARM this is \ref arm_mcd_read_register.
@@ -690,7 +698,7 @@ void handle_write_memory(GArray *params, void *user_ctx=
);
 int mcd_read_register(CPUState *cpu, GByteArray *buf, int reg);
 /**
  * \brief Writes data from the buf to a register.
- *=20
+ *
  * This function collects the register type and internal ID
  * (depending on the XML file). Then it calls the architecture specific
  * write function. For ARM this is \ref arm_mcd_write_register.
@@ -701,7 +709,7 @@ int mcd_read_register(CPUState *cpu, GByteArray *buf, i=
nt reg);
 int mcd_write_register(CPUState *cpu, GByteArray *buf, int reg);
 /**
  * \brief Reads memory data and stores it into the buf.
- *=20
+ *
  * This function calls cpu_memory_rw_debug or if available
  * memory_rw_debug in read mode and passes on all parameters.
  * @param[in] cpu CPU to which the memory belongs.
@@ -712,7 +720,7 @@ int mcd_write_register(CPUState *cpu, GByteArray *buf, =
int reg);
 int mcd_read_memory(CPUState *cpu, hwaddr addr, uint8_t *buf, int len);
 /**
  * \brief Writes data from the buf into the memory.
- *=20
+ *
  * This function calls cpu_memory_rw_debug or if available
  * memory_rw_debug in write mode and passes on all parameters.
  * @param[in] cpu CPU to which the memory belongs.
@@ -723,7 +731,7 @@ int mcd_read_memory(CPUState *cpu, hwaddr addr, uint8_t=
 *buf, int len);
 int mcd_write_memory(CPUState *cpu, hwaddr addr, uint8_t *buf, int len);
 /**
  * \brief Handler for inserting a break- or watchpoint.
- *=20
+ *
  * This function extracts the CPU, breakpoint type and address from the
  * parameters and calls \ref mcd_breakpoint_insert to insert the breakpoin=
t.
  * @param[in] params GArray with all TCP packet parameters.
@@ -731,7 +739,7 @@ int mcd_write_memory(CPUState *cpu, hwaddr addr, uint8_=
t *buf, int len);
 void handle_breakpoint_insert(GArray *params, void *user_ctx);
 /**
  * \brief Handler for inserting a break- or watchpoint.
- *=20
+ *
  * This function extracts the CPU, breakpoint type and address from the
  * parameters and calls \ref mcd_breakpoint_remove to insert the breakpoin=
t.
  * @param[in] params GArray with all TCP packet parameters.
@@ -739,7 +747,7 @@ void handle_breakpoint_insert(GArray *params, void *use=
r_ctx);
 void handle_breakpoint_remove(GArray *params, void *user_ctx);
 /**
  * \brief Inserts a break- or watchpoint.
- *=20
+ *
  * This function evaluates the received breakpoint type and translates it
  * to a known GDB breakpoint type.
  * Then it calls cpu_breakpoint_insert or cpu_watchpoint_insert depending =
on
@@ -751,7 +759,7 @@ void handle_breakpoint_remove(GArray *params, void *use=
r_ctx);
 int mcd_breakpoint_insert(CPUState *cpu, int type, vaddr addr);
 /**
  * \brief Removes a break- or watchpoint.
- *=20
+ *
  * This function evaluates the received breakpoint type and translates it
  * to a known GDB breakpoint type.
  * Then it calls cpu_breakpoint_remove or cpu_watchpoint_remove depending =
on
diff --git a/include/qemu/debug.h b/include/qemu/debug.h
new file mode 100644
index 0000000000..870f3ea152
--- /dev/null
+++ b/include/qemu/debug.h
@@ -0,0 +1,19 @@
+#ifndef QEMU_DEBUG_H
+#define QEMU_DEBUG_H
+
+#include "qom/object.h"
+#include "qemu/typedefs.h"
+
+struct DebugClass {
+    ObjectClass parent_class;
+    void (*set_stop_cpu)(CPUState *cpu);
+};
+
+struct DebugState {
+    Object parent_obj;
+};
+
+#define TYPE_DEBUG "debug"
+OBJECT_DECLARE_TYPE(DebugState, DebugClass, DEBUG)
+
+#endif /* QEMU_DEBUG_H */
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 5abdbc3874..e48b544173 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -46,6 +46,8 @@ typedef struct CpuInfoFast CpuInfoFast;
 typedef struct CPUJumpCache CPUJumpCache;
 typedef struct CPUState CPUState;
 typedef struct CPUTLBEntryFull CPUTLBEntryFull;
+typedef struct DebugClass DebugClass;
+typedef struct DebugState DebugState;
 typedef struct DeviceListener DeviceListener;
 typedef struct DeviceState DeviceState;
 typedef struct DirtyBitmapSnapshot DirtyBitmapSnapshot;
diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index 4f9fafe749..7f6c869023 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -7,6 +7,7 @@
 #include "qemu/cutils.h"
 #include "qemu/module.h"
 #include "qemu/error-report.h"
+#include "qemu/debug.h"
 #include "exec/mcdstub.h"
 #include "mcdstub/syscalls.h"
 #include "hw/cpu/cluster.h"
@@ -67,6 +68,14 @@ void mcd_init_mcdserver_state(void)
             .info_str =3D STATE_STR_INIT_HALTED,
     };
     mcdserver_state.cpu_state =3D cpu_state;
+
+    /* create new debug object */
+    mcd_init_debug_class();
+ }
+
+void mcd_set_stop_cpu(CPUState *cpu)
+{
+    mcdserver_state.c_cpu =3D cpu;
 }
=20
 void init_query_cmds_table(MCDCmdParseEntry *mcd_query_cmds_table)
@@ -1804,19 +1813,22 @@ int mcd_write_memory(CPUState *cpu, hwaddr addr, ui=
nt8_t *buf, int len)
 void handle_read_memory(GArray *params, void *user_ctx)
 {
     uint32_t cpu_id =3D get_param(params, 0)->cpu_id;
-    uint32_t mem_space_id =3D get_param(params, 1)->data_uint32_t;
     uint64_t mem_address =3D get_param(params, 2)->data_uint64_t;
     uint32_t len =3D get_param(params, 3)->data_uint32_t;
=20
     CPUState *cpu =3D mcd_get_cpu(cpu_id);
-    /* check if the mem space is secure */
-    GArray *memspaces =3D g_list_nth_data(mcdserver_state.all_memspaces, c=
pu_id);
-    mcd_mem_space_st space =3D g_array_index(memspaces, mcd_mem_space_st,
-        mem_space_id - 1);
-    if (arm_mcd_set_scr(cpu, space.is_secure)) {
-        mcd_put_packet(TCP_EXECUTION_ERROR);
-        return;
-    }
+    /*
+     * TODO: select to correct address space
+     * uint32_t mem_space_id =3D get_param(params, 1)->data_uint32_t;
+     * GArray *memspaces =3D
+     *     g_list_nth_data(mcdserver_state.all_memspaces, cpu_id);
+     * mcd_mem_space_st space =3D g_array_index(memspaces, mcd_mem_space_s=
t,
+     *     mem_space_id - 1);
+     * if (arm_mcd_set_scr(cpu, space.is_secure)) {
+     *     mcd_put_packet(TCP_EXECUTION_ERROR);
+     *     return;
+     * }
+     */
     /* read memory */
     g_byte_array_set_size(mcdserver_state.mem_buf, len);
     if (mcd_read_memory(cpu, mem_address, mcdserver_state.mem_buf->data,
@@ -1832,18 +1844,21 @@ void handle_read_memory(GArray *params, void *user_=
ctx)
 void handle_write_memory(GArray *params, void *user_ctx)
 {
     uint32_t cpu_id =3D get_param(params, 0)->cpu_id;
-    uint32_t mem_space_id =3D get_param(params, 1)->data_uint32_t;
     uint64_t mem_address =3D get_param(params, 2)->data_uint64_t;
     uint32_t len =3D get_param(params, 3)->data_uint32_t;
     CPUState *cpu =3D mcd_get_cpu(cpu_id);
-    /* check if the mem space is secure */
-    GArray *memspaces =3D g_list_nth_data(mcdserver_state.all_memspaces, c=
pu_id);
-    mcd_mem_space_st space =3D g_array_index(memspaces, mcd_mem_space_st,
-        mem_space_id - 1);
-    if (arm_mcd_set_scr(cpu, space.is_secure)) {
-        mcd_put_packet(TCP_EXECUTION_ERROR);
-        return;
-    }
+    /*
+     * TODO: select to correct address space
+     * uint32_t mem_space_id =3D get_param(params, 1)->data_uint32_t;
+     * GArray *memspaces =3D
+     *     g_list_nth_data(mcdserver_state.all_memspaces, cpu_id);
+     * mcd_mem_space_st space =3D g_array_index(memspaces, mcd_mem_space_s=
t,
+     *     mem_space_id - 1);
+     * if (arm_mcd_set_scr(cpu, space.is_secure)) {
+     *     mcd_put_packet(TCP_EXECUTION_ERROR);
+     *     return;
+     * }
+     */
     /* write memory */
     mcd_hextomem(mcdserver_state.mem_buf, mcdserver_state.str_buf->str, le=
n);
     if (mcd_write_memory(cpu, mem_address,
diff --git a/mcdstub/meson.build b/mcdstub/meson.build
index 6b2f970eae..aad35234a9 100644
--- a/mcdstub/meson.build
+++ b/mcdstub/meson.build
@@ -4,7 +4,7 @@
 mcd_system_ss =3D ss.source_set()
=20
 # only system emulation is supported over mcd
-mcd_system_ss.add(files('mcdstub.c'))
+mcd_system_ss.add(files('mcdstub.c', '../debug/debug-mcd.c'))
=20
 mcd_system_ss =3D mcd_system_ss.apply(config_host, strict: false)
=20
@@ -16,4 +16,4 @@ libmcd_softmmu =3D static_library('mcd_softmmu',
 mcd_softmmu =3D declare_dependency(link_whole: libmcd_softmmu)
 system_ss.add(mcd_softmmu)
=20
-common_ss.add(files('mcd_syscalls.c'))
+common_ss.add(files('../debug/debug-common.c', 'mcd_syscalls.c'))
diff --git a/softmmu/cpus.c b/softmmu/cpus.c
index 5d0657bbe5..734173096a 100644
--- a/softmmu/cpus.c
+++ b/softmmu/cpus.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "monitor/monitor.h"
 #include "qemu/coroutine-tls.h"
+#include "qemu/debug.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-machine.h"
 #include "qapi/qapi-commands-misc.h"
@@ -306,10 +307,13 @@ void cpu_handle_guest_debug(CPUState *cpu)
             cpu_single_step(cpu, 0);
         }
     } else {
-        /*
-         * TODO: was gdb_set_stop_cpu(cpu), need to abstract options to
-         * a QOM class.
-         */
+        MachineState *ms =3D MACHINE(qdev_get_machine());
+        DebugState *ds =3D ms->debug_state;
+        DebugClass *dc =3D DEBUG_GET_CLASS(ds);
+
+        if (dc->set_stop_cpu) {
+            dc->set_stop_cpu(cpu);
+        }
         qemu_system_debug_request();
         cpu->stopped =3D true;
     }
diff --git a/target/arm/mcdstub.c b/target/arm/mcdstub.c
index 1b82b9d439..6faf2d7649 100644
--- a/target/arm/mcdstub.c
+++ b/target/arm/mcdstub.c
@@ -4,6 +4,7 @@
 #include "sysemu/tcg.h"
 #include "internals.h"
 #include "cpregs.h"
+#include "qemu/debug.h"
=20
 #include "mcdstub/arm_mcdstub.h"
=20
@@ -332,20 +333,6 @@ uint16_t arm_mcd_get_opcode(CPUState *cs, uint32_t n)
     return 0;
 }
=20
-int arm_mcd_set_scr(CPUState *cs, bool secure)
-{
-    /* switches between secure and non secure mode */
-    ARMCPU *cpu =3D ARM_CPU(cs);
-    CPUARMState *env =3D &cpu->env;
-    /* set bit 0 to 1 if non secure, to 0 if secure*/
-    if (secure) {
-        env->cp15.scr_el3 &=3D 0xFFFFFFFE;
-    } else {
-        env->cp15.scr_el3 |=3D 1;
-    }
-    return 0;
-}
-
 int arm_mcd_store_mem_spaces(CPUState *cpu, GArray *memspaces)
 {
     int nr_address_spaces =3D cpu->num_ases;
@@ -379,7 +366,7 @@ int arm_mcd_store_mem_spaces(CPUState *cpu, GArray *mem=
spaces)
         .is_secure =3D false,
     };
     g_array_append_vals(memspaces, (gconstpointer)&phys_non_secure, 1);
-    if(nr_address_spaces > 1) {
+    if (nr_address_spaces > 1) {
         mem_space_id++;
         mcd_mem_space_st secure =3D {
             .name =3D "Secure",
--=20
2.34.1


