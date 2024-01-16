Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAF182E574
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 01:42:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPXWm-0001NS-Pv; Mon, 15 Jan 2024 19:42:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rPXWk-0001My-E1
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 19:42:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rPXWi-0000xh-4H
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 19:42:02 -0500
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40FNu7AI005701; Tue, 16 Jan 2024 00:41:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=mOvhNRxds+07jsvF75LFOV7ZgXxemoQnx1Xf3kZVIxM=;
 b=X7zovgIokOhXiOoCANysPohneXo+77DSTue8hNn7pKsVVAz3+Vc59JuHikFE5apXPI3m
 1OZHrVt+UEgAr2LlXrsddV31rzVPNsehF3ql+loZM3DZsyih204sVztGw7J8e0f5rG8M
 pNUZi7ZIu2z592ZLd9ddkZGAEqaN+MO8lC7WFaYuCf//lPDcjMzsmwU5BAui+kmBXEFo
 7VSKeZigtmEPUVEdKS/p8cTVMBUhPZUUrwCbI02dorLakef4m6j0hsAmRz9mijo2lwWA
 q7sOyDTxoKajAMYP9holA8JYZjZT76NykouOFPViUxNo3SxzOYVJSZcv5iKjush0rN9c 2Q== 
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vncmrbp5m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jan 2024 00:41:50 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40FM18Kl026489; Tue, 16 Jan 2024 00:41:49 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vm72ju55h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jan 2024 00:41:49 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40G0fmY053871038
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jan 2024 00:41:48 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 162E72004B;
 Tue, 16 Jan 2024 00:41:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A8FB220040;
 Tue, 16 Jan 2024 00:41:47 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.179.4.64])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 Jan 2024 00:41:47 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 1/2] gdbstub: Implement catching syscalls
Date: Tue, 16 Jan 2024 01:40:11 +0100
Message-ID: <20240116004141.78626-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116004141.78626-1-iii@linux.ibm.com>
References: <20240116004141.78626-1-iii@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ixAXWqlgVlWoo8avV6T-GbSrcUWHmLTo
X-Proofpoint-ORIG-GUID: ixAXWqlgVlWoo8avV6T-GbSrcUWHmLTo
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-15_17,2024-01-15_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401160002
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

GDB supports stopping on syscall entry and exit using the "catch
syscall" command. It relies on 3 packets, which are currently not
supported by QEMU:

* qSupported:QCatchSyscalls+ [1]
* QCatchSyscalls: [2]
* T05syscall_entry: and T05syscall_return: [3]

Implement generation and handling of these packets.

[1] https://sourceware.org/gdb/current/onlinedocs/gdb.html/General-Query-Packets.html#qSupported
[2] https://sourceware.org/gdb/current/onlinedocs/gdb.html/General-Query-Packets.html#QCatchSyscalls
[3] https://sourceware.org/gdb/current/onlinedocs/gdb.html/Stop-Reply-Packets.html

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 gdbstub/gdbstub.c            | 11 +++++++-
 gdbstub/internals.h          | 16 +++++++++++
 gdbstub/system.c             |  1 +
 gdbstub/user-target.c        | 39 +++++++++++++++++++++++++++
 gdbstub/user.c               | 51 +++++++++++++++++++++++++++++++++++-
 include/gdbstub/user.h       | 29 ++++++++++++++++++--
 include/user/syscall-trace.h |  7 +++--
 7 files changed, 148 insertions(+), 6 deletions(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 46d752bbc2c..7faf19508d1 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1618,7 +1618,8 @@ static void handle_query_supported(GArray *params, void *user_ctx)
         g_string_append(gdbserver_state.str_buf, ";qXfer:auxv:read+");
     }
 #endif
-    g_string_append(gdbserver_state.str_buf, ";qXfer:exec-file:read+");
+    g_string_append(gdbserver_state.str_buf, ";qXfer:exec-file:read+"
+                                             ";QCatchSyscalls+");
 #endif
 
     if (params->len &&
@@ -1810,6 +1811,14 @@ static const GdbCmdParseEntry gdb_gen_set_table[] = {
         .schema = "l0"
     },
 #endif
+#if defined(CONFIG_USER_ONLY)
+    {
+        .handler = gdb_handle_set_catch_syscalls,
+        .cmd = "CatchSyscalls:",
+        .cmd_startswith = 1,
+        .schema = "s0",
+    },
+#endif
 };
 
 static void handle_gen_query(GArray *params, void *user_ctx)
diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index 5c0c725e54c..6e0905ca328 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -10,6 +10,7 @@
 #define GDBSTUB_INTERNALS_H
 
 #include "exec/cpu-common.h"
+#include "qemu/bitops.h"
 
 #define MAX_PACKET_LENGTH 4096
 
@@ -46,6 +47,14 @@ enum RSState {
     RS_CHKSUM2,
 };
 
+enum GDBCatchSyscallsState {
+    GDB_CATCH_SYSCALLS_NONE,
+    GDB_CATCH_SYSCALLS_ALL,
+    GDB_CATCH_SYSCALLS_SELECTED,
+};
+#define GDB_NR_SYSCALLS 1024
+typedef unsigned long GDBSyscallsMask[BITS_TO_LONGS(GDB_NR_SYSCALLS)];
+
 typedef struct GDBState {
     bool init;       /* have we been initialised? */
     CPUState *c_cpu; /* current CPU for step/continue ops */
@@ -70,6 +79,12 @@ typedef struct GDBState {
      * Must be set off after sending the stop reply itself.
      */
     bool allow_stop_reply;
+    /*
+     * Store syscalls mask without memory allocation in order to avoid
+     * implementing synchronization.
+     */
+    enum GDBCatchSyscallsState catch_syscalls_state;
+    GDBSyscallsMask catch_syscalls_mask;
 } GDBState;
 
 /* lives in main gdbstub.c */
@@ -194,6 +209,7 @@ void gdb_handle_v_file_close(GArray *params, void *user_ctx); /* user */
 void gdb_handle_v_file_pread(GArray *params, void *user_ctx); /* user */
 void gdb_handle_v_file_readlink(GArray *params, void *user_ctx); /* user */
 void gdb_handle_query_xfer_exec_file(GArray *params, void *user_ctx); /* user */
+void gdb_handle_set_catch_syscalls(GArray *params, void *user_ctx); /* user */
 
 void gdb_handle_query_attached(GArray *params, void *user_ctx); /* both */
 
diff --git a/gdbstub/system.c b/gdbstub/system.c
index 83fd452800b..4c4bafd3bcc 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -44,6 +44,7 @@ static void reset_gdbserver_state(void)
     gdbserver_state.processes = NULL;
     gdbserver_state.process_num = 0;
     gdbserver_state.allow_stop_reply = false;
+    gdbserver_state.catch_syscalls_state = GDB_CATCH_SYSCALLS_NONE;
 }
 
 /*
diff --git a/gdbstub/user-target.c b/gdbstub/user-target.c
index c4bba4c72c7..442d15e9473 100644
--- a/gdbstub/user-target.c
+++ b/gdbstub/user-target.c
@@ -9,6 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "exec/gdbstub.h"
+#include "gdbstub/user.h"
 #include "qemu.h"
 #include "internals.h"
 #ifdef CONFIG_LINUX
@@ -418,3 +419,41 @@ void gdb_handle_query_xfer_exec_file(GArray *params, void *user_ctx)
                     ts->bprm->filename + offset);
     gdb_put_strbuf();
 }
+
+static bool should_catch_syscall(int num)
+{
+    switch (gdbserver_state.catch_syscalls_state) {
+    case GDB_CATCH_SYSCALLS_NONE:
+        return false;
+    case GDB_CATCH_SYSCALLS_ALL:
+        return true;
+    case GDB_CATCH_SYSCALLS_SELECTED:
+        if (num < 0 || num >= GDB_NR_SYSCALLS) {
+            return false;
+        } else {
+            return test_bit(num, gdbserver_state.catch_syscalls_mask);
+        }
+    default:
+        g_assert_not_reached();
+    }
+}
+
+void gdb_syscall_entry(CPUState *cs, int num)
+{
+    char reason[32];
+
+    if (should_catch_syscall(num)) {
+        snprintf(reason, sizeof(reason), "syscall_entry:%x;", num);
+        gdb_handlesig_reason(cs, TARGET_SIGTRAP, reason);
+    }
+}
+
+void gdb_syscall_return(CPUState *cs, int num)
+{
+    char reason[32];
+
+    if (should_catch_syscall(num)) {
+        snprintf(reason, sizeof(reason), "syscall_return:%x;", num);
+        gdb_handlesig_reason(cs, TARGET_SIGTRAP, reason);
+    }
+}
diff --git a/gdbstub/user.c b/gdbstub/user.c
index dbe1d9b8875..e02be56abf6 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -121,7 +121,7 @@ void gdb_qemu_exit(int code)
     exit(code);
 }
 
-int gdb_handlesig(CPUState *cpu, int sig)
+int gdb_handlesig_reason(CPUState *cpu, int sig, const char *reason)
 {
     char buf[256];
     int n;
@@ -141,6 +141,9 @@ int gdb_handlesig(CPUState *cpu, int sig)
                             "T%02xthread:", gdb_target_signal_to_gdb(sig));
             gdb_append_thread_id(cpu, gdbserver_state.str_buf);
             g_string_append_c(gdbserver_state.str_buf, ';');
+            if (reason) {
+                g_string_append(gdbserver_state.str_buf, reason);
+            }
             gdb_put_strbuf();
             gdbserver_state.allow_stop_reply = false;
         }
@@ -499,3 +502,49 @@ void gdb_syscall_handling(const char *syscall_packet)
     gdb_put_packet(syscall_packet);
     gdb_handlesig(gdbserver_state.c_cpu, 0);
 }
+
+void gdb_handle_set_catch_syscalls(GArray *params, void *user_ctx)
+{
+    enum GDBCatchSyscallsState catch_syscalls_state;
+    const char *param = get_param(params, 0)->data;
+    GDBSyscallsMask catch_syscalls_mask;
+    bool catch_syscalls_none;
+    unsigned int num;
+    const char *p;
+
+    catch_syscalls_none = strcmp(param, "0") == 0;
+    if (catch_syscalls_none || strcmp(param, "1") == 0) {
+        gdbserver_state.catch_syscalls_state = catch_syscalls_none ?
+                                                   GDB_CATCH_SYSCALLS_NONE :
+                                                   GDB_CATCH_SYSCALLS_ALL;
+        gdb_put_packet("OK");
+        return;
+    }
+
+    if (param[0] == '1' && param[1] == ';') {
+        catch_syscalls_state = GDB_CATCH_SYSCALLS_SELECTED;
+        memset(catch_syscalls_mask, 0, sizeof(catch_syscalls_mask));
+        for (p = &param[2];; p++) {
+            if (qemu_strtoui(p, &p, 16, &num) || (*p && *p != ';')) {
+                goto err;
+            }
+            if (num >= GDB_NR_SYSCALLS) {
+                /* Fall back to reporting all syscalls. */
+                catch_syscalls_state = GDB_CATCH_SYSCALLS_ALL;
+            } else {
+                set_bit(num, catch_syscalls_mask);
+            }
+            if (!*p) {
+                break;
+            }
+        }
+        gdbserver_state.catch_syscalls_state = catch_syscalls_state;
+        memcpy(gdbserver_state.catch_syscalls_mask, catch_syscalls_mask,
+               sizeof(catch_syscalls_mask));
+        gdb_put_packet("OK");
+        return;
+    }
+
+err:
+    gdb_put_packet("E00");
+}
diff --git a/include/gdbstub/user.h b/include/gdbstub/user.h
index d392e510c59..68b6534130c 100644
--- a/include/gdbstub/user.h
+++ b/include/gdbstub/user.h
@@ -10,9 +10,10 @@
 #define GDBSTUB_USER_H
 
 /**
- * gdb_handlesig() - yield control to gdb
+ * gdb_handlesig_reason() - yield control to gdb
  * @cpu: CPU
  * @sig: if non-zero, the signal number which caused us to stop
+ * @reason: stop reason for stop reply packet or NULL
  *
  * This function yields control to gdb, when a user-mode-only target
  * needs to stop execution. If @sig is non-zero, then we will send a
@@ -24,7 +25,18 @@
  * or 0 if no signal should be delivered, ie the signal that caused
  * us to stop should be ignored.
  */
-int gdb_handlesig(CPUState *, int);
+int gdb_handlesig_reason(CPUState *, int, const char *);
+
+/**
+ * gdb_handlesig() - yield control to gdb
+ * @cpu CPU
+ * @sig: if non-zero, the signal number which caused us to stop
+ * @see gdb_handlesig_reason()
+ */
+static inline int gdb_handlesig(CPUState *cpu, int sig)
+{
+    return gdb_handlesig_reason(cpu, sig, NULL);
+}
 
 /**
  * gdb_signalled() - inform remote gdb of sig exit
@@ -39,5 +51,18 @@ void gdb_signalled(CPUArchState *as, int sig);
  */
 void gdbserver_fork(CPUState *cs);
 
+/**
+ * gdb_syscall_entry() - inform gdb of syscall entry and yield control to it
+ * @cs: CPU
+ * @num: syscall number
+ */
+void gdb_syscall_entry(CPUState *cs, int num);
+
+/**
+ * gdb_syscall_entry() - inform gdb of syscall return and yield control to it
+ * @cs: CPU
+ * @num: syscall number
+ */
+void gdb_syscall_return(CPUState *cs, int num);
 
 #endif /* GDBSTUB_USER_H */
diff --git a/include/user/syscall-trace.h b/include/user/syscall-trace.h
index 557f881a79b..b48b2b2d0ae 100644
--- a/include/user/syscall-trace.h
+++ b/include/user/syscall-trace.h
@@ -11,6 +11,7 @@
 #define SYSCALL_TRACE_H
 
 #include "exec/user/abitypes.h"
+#include "gdbstub/user.h"
 #include "qemu/plugin.h"
 #include "trace/trace-root.h"
 
@@ -20,7 +21,7 @@
  * could potentially unify the -strace code here as well.
  */
 
-static inline void record_syscall_start(void *cpu, int num,
+static inline void record_syscall_start(CPUState *cpu, int num,
                                         abi_long arg1, abi_long arg2,
                                         abi_long arg3, abi_long arg4,
                                         abi_long arg5, abi_long arg6,
@@ -29,11 +30,13 @@ static inline void record_syscall_start(void *cpu, int num,
     qemu_plugin_vcpu_syscall(cpu, num,
                              arg1, arg2, arg3, arg4,
                              arg5, arg6, arg7, arg8);
+    gdb_syscall_entry(cpu, num);
 }
 
-static inline void record_syscall_return(void *cpu, int num, abi_long ret)
+static inline void record_syscall_return(CPUState *cpu, int num, abi_long ret)
 {
     qemu_plugin_vcpu_syscall_ret(cpu, num, ret);
+    gdb_syscall_return(cpu, num);
 }
 
 
-- 
2.43.0


