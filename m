Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7216D7BB3D5
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 11:07:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qogmq-0007z4-7N; Fri, 06 Oct 2023 05:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qogmn-0007yo-Ie
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:06:17 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qogml-0000sO-6w
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:06:17 -0400
Received: (qmail 19360 invoked by uid 484); 6 Oct 2023 09:06:13 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.07498 secs); 06 Oct 2023 09:06:13 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP for <qemu-devel@nongnu.org>; 6 Oct 2023 09:06:12 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Christian.Boenig@lauterbach.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicolas Eder <nicolas.eder@lauterbach.com>
Subject: [PATCH v2 01/29] mcdstub initial commit, mcdstub file structure added
Date: Fri,  6 Oct 2023 11:05:42 +0200
Message-Id: <20231006090610.26171-2-nicolas.eder@lauterbach.com>
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
+                              gdb_get_reg_cb get_reg, gdb_set_reg_cb set_reg,
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
+    Chardev *chr = NULL;
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
+    if (strcmp(device, "none") != 0) {
+        if (strstart(device, "tcp:", NULL)) {
+            /* enforce required TCP attributes */
+            snprintf(gdbstub_device_name, sizeof(gdbstub_device_name),
+                     "%s,wait=off,nodelay=on,server=on", device);
+            device = gdbstub_device_name;
+        }
+#ifndef _WIN32
+        else if (strcmp(device, "stdio") == 0) {
+            struct sigaction act;
+
+            memset(&act, 0, sizeof(act));
+            act.sa_handler = gdb_sigterm_handler;
+            sigaction(SIGINT, &act, NULL);
+        }
+#endif
+        /*
+         * FIXME: it's a bit weird to allow using a mux chardev here
+         * and implicitly setup a monitor. We may want to break this.
+         */
+        chr = qemu_chr_new_noreplay("gdb", device, true, NULL);
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
+        mon_chr = qemu_chardev_new(NULL, TYPE_CHARDEV_GDB,
+                                   NULL, NULL, &error_abort);
+        monitor_init_hmp(mon_chr, false, &error_abort);
+    } else {
+        qemu_chr_fe_deinit(&gdbserver_system_state.chr, true);
+        mon_chr = gdbserver_system_state.mon_chr;
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
+    gdbserver_state.state = chr ? RS_IDLE : RS_INACTIVE;
+    gdbserver_system_state.mon_chr = mon_chr;
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
+		n = 0;
+		// copy server message in the buffer
+		while ((buff[n++] = getchar()) != '\n')
+			;
+
+		// and send that buffer to client
+		write(connfd, buff, sizeof(buff));
+
+		// if msg contains "Exit" then server exit and chat ended.
+		if (strncmp("exit", buff, 4) == 0) {
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
+	sockfd = socket(AF_INET, SOCK_STREAM, 0);
+	if (sockfd == -1) {
+		printf("socket creation failed...\n");
+		exit(0);
+	}
+	else
+		printf("Socket successfully created..\n");
+	bzero(&servaddr, sizeof(servaddr));
+
+	// assign IP, PORT
+	servaddr.sin_family = AF_INET;
+	servaddr.sin_addr.s_addr = htonl(INADDR_ANY);
+	servaddr.sin_port = htons(DEFAULT_MCDSTUB_PORT);
+
+	// Binding newly created socket to given IP and verification
+	if ((bind(sockfd, (SA*)&servaddr, sizeof(servaddr))) != 0) {
+		printf("socket bind failed...\n");
+		exit(0);
+	}
+	else
+		printf("Socket successfully binded..\n");
+
+	// Now server is ready to listen and verification
+	if ((listen(sockfd, 5)) != 0) {
+		printf("Listen failed...\n");
+		exit(0);
+	}
+	else
+		printf("Server listening..\n");
+	len = sizeof(cli);
+
+	// Accept the data packet from client and verification
+	connfd = accept(sockfd, (SA*)&cli, &len);
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
                     list_data_dirs = true;
-- 
2.34.1


