Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6237BB3DF
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 11:08:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qognc-0008H0-AA; Fri, 06 Oct 2023 05:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qognO-0008DN-SK
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:06:54 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qognL-0000za-T6
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:06:54 -0400
Received: (qmail 19776 invoked by uid 484); 6 Oct 2023 09:06:40 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.184611 secs); 06 Oct 2023 09:06:40 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP for <qemu-devel@nongnu.org>; 6 Oct 2023 09:06:38 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Christian.Boenig@lauterbach.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicolas Eder <nicolas.eder@lauterbach.com>
Subject: [PATCH v2 17/29] handler for breakpoints and watchpoints added
Date: Fri,  6 Oct 2023 11:05:58 +0200
Message-Id: <20231006090610.26171-18-nicolas.eder@lauterbach.com>
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
 
 /* tcp protocol chars */
 #define TCP_ACKNOWLEDGED '+'
@@ -82,4 +84,10 @@
 #define CORE_STATE_DEBUG "debug"
 #define CORE_STATE_UNKNOWN "unknown"
 
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
             cmd_parser = &write_mem_cmd_desc;
         }
         break;
+    case TCP_CHAR_BREAKPOINT_INSERT:
+        {
+            static MCDCmdParseEntry handle_breakpoint_insert_cmd_desc = {
+                .handler = handle_breakpoint_insert,
+            };
+            handle_breakpoint_insert_cmd_desc.cmd =
+                (char[2]) { TCP_CHAR_BREAKPOINT_INSERT, '\0' };
+            strcpy(handle_breakpoint_insert_cmd_desc.schema,
+                (char[5]) { ARG_SCHEMA_CORENUM, ARG_SCHEMA_INT,
+                ARG_SCHEMA_UINT64_T, ARG_SCHEMA_UINT64_T, '\0' });
+            cmd_parser = &handle_breakpoint_insert_cmd_desc;
+        }
+        break;
+    case TCP_CHAR_BREAKPOINT_REMOVE:
+        {
+            static MCDCmdParseEntry handle_breakpoint_remove_cmd_desc = {
+                .handler = handle_breakpoint_remove,
+            };
+            handle_breakpoint_remove_cmd_desc.cmd =
+                (char[2]) { TCP_CHAR_BREAKPOINT_REMOVE, '\0' };
+            strcpy(handle_breakpoint_remove_cmd_desc.schema,
+                (char[5]) { ARG_SCHEMA_CORENUM, ARG_SCHEMA_INT,
+                ARG_SCHEMA_UINT64_T, ARG_SCHEMA_UINT64_T, '\0' });
+            cmd_parser = &handle_breakpoint_remove_cmd_desc;
+        }
+        break;
     default:
         /* command not supported */
         mcd_put_packet("");
@@ -837,13 +863,14 @@ void mcd_vm_state_change(void *opaque, bool running, RunState state)
             cpu->watchpoint_hit = NULL;
         } else if (cpu->singlestep_enabled) {
             /* we land here when a single step is performed */
-            cpu_single_step(cpu, 0);
             stop_str = STATE_STEP_PERFORMED;
         } else {
             trig_id = MCD_TRIG_TYPE_IP;
             stop_str = STATE_STR_BREAK_HW;
             tb_flush(cpu);
         }
+        /* deactivate single step */
+        cpu_single_step(cpu, 0);
         break;
     case RUN_STATE_PAUSED:
         info_str = STATE_STR_HALTED(cpu->cpu_index);
@@ -1594,7 +1621,8 @@ void mcd_vm_start(void)
 
 int mcd_vm_sstep(CPUState *cpu)
 {
-    cpu_single_step(mcdserver_state.c_cpu, mcdserver_state.sstep_flags);
+    mcdserver_state.c_cpu = cpu;
+    cpu_single_step(cpu, mcdserver_state.sstep_flags);
     mcd_vm_start();
     return 0;
 }
@@ -1950,3 +1978,95 @@ void handle_write_memory(GArray *params, void *user_ctx)
         mcd_put_packet(TCP_EXECUTION_SUCCESS);
     }
 }
+
+int mcd_breakpoint_insert(CPUState *cpu, int type, vaddr addr, vaddr len)
+{
+    /* translate the type to known gdb types and function call*/
+    int bp_type = 0;
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+    if (cc->gdb_stop_before_watchpoint) {
+        //bp_type |= BP_STOP_BEFORE_ACCESS;
+    }
+    int return_value = 0;
+    switch (type) {
+    case MCD_BREAKPOINT_HW:
+        return_value = cpu_breakpoint_insert(cpu, addr, BP_GDB, NULL);
+        return return_value;
+    case MCD_BREAKPOINT_READ:
+        bp_type |= BP_GDB | BP_MEM_READ;
+        return_value = cpu_watchpoint_insert(cpu, addr, 4, bp_type, NULL);
+        return return_value;
+    case MCD_BREAKPOINT_WRITE:
+        bp_type |= BP_GDB | BP_MEM_WRITE;
+        return_value = cpu_watchpoint_insert(cpu, addr, 4, bp_type, NULL);
+        return return_value;
+    case MCD_BREAKPOINT_RW:
+        bp_type |= BP_GDB | BP_MEM_ACCESS;
+        return_value = cpu_watchpoint_insert(cpu, addr, 4, bp_type, NULL);
+        return return_value;
+    default:
+        return -ENOSYS;
+    }
+}
+
+int mcd_breakpoint_remove(CPUState *cpu, int type, vaddr addr, vaddr len)
+{
+    /* translate the type to known gdb types and function call*/
+    int bp_type = 0;
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+    if (cc->gdb_stop_before_watchpoint) {
+        //bp_type |= BP_STOP_BEFORE_ACCESS;
+    }
+    int return_value = 0;
+    switch (type) {
+    case MCD_BREAKPOINT_HW:
+        return_value = cpu_breakpoint_remove(cpu, addr, BP_GDB);
+        return return_value;
+    case MCD_BREAKPOINT_READ:
+        bp_type |= BP_GDB | BP_MEM_READ;
+        return_value = cpu_watchpoint_remove(cpu, addr, 4, bp_type);
+        return return_value;
+    case MCD_BREAKPOINT_WRITE:
+        bp_type |= BP_GDB | BP_MEM_WRITE;
+        return_value = cpu_watchpoint_remove(cpu, addr, 4, bp_type);
+        return return_value;
+    case MCD_BREAKPOINT_RW:
+        bp_type |= BP_GDB | BP_MEM_ACCESS;
+        return_value = cpu_watchpoint_remove(cpu, addr, 4, bp_type);
+        return return_value;
+    default:
+        return -ENOSYS;
+    }
+}
+
+void handle_breakpoint_insert(GArray *params, void *user_ctx)
+{
+    /* 1. get parameter data */
+    uint32_t cpu_id = get_param(params, 0)->cpu_id;
+    uint32_t type = get_param(params, 1)->data_int;
+    uint64_t address = get_param(params, 2)->data_uint64_t;
+    uint64_t len = get_param(params, 3)->data_uint64_t;
+    /* 2. insert breakpoint and send reply*/
+    CPUState *cpu = mcd_get_cpu(cpu_id);
+    if (mcd_breakpoint_insert(cpu, type, address, len) != 0) {
+        mcd_put_packet(TCP_EXECUTION_ERROR);
+    } else {
+        mcd_put_packet(TCP_EXECUTION_SUCCESS);
+    }
+}
+
+void handle_breakpoint_remove(GArray *params, void *user_ctx)
+{
+    /* 1. get parameter data */
+    uint32_t cpu_id = get_param(params, 0)->cpu_id;
+    uint32_t type = get_param(params, 1)->data_int;
+    uint64_t address = get_param(params, 2)->data_uint64_t;
+    uint64_t len = get_param(params, 3)->data_uint64_t;
+    /* 2. remove breakpoint and send reply*/
+    CPUState *cpu = mcd_get_cpu(cpu_id);
+    if (mcd_breakpoint_remove(cpu, type, address, len) != 0) {
+        mcd_put_packet(TCP_EXECUTION_ERROR);
+    } else {
+        mcd_put_packet(TCP_EXECUTION_SUCCESS);
+    }
+}
diff --git a/mcdstub/mcdstub.h b/mcdstub/mcdstub.h
index 83156dceb8..c2bdaee410 100644
--- a/mcdstub/mcdstub.h
+++ b/mcdstub/mcdstub.h
@@ -309,6 +309,10 @@ int mcd_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int mcd_write_register(CPUState *cpu, GByteArray *buf, int reg);
 int mcd_read_memory(CPUState *cpu, hwaddr addr, uint8_t *buf, int len);
 int mcd_write_memory(CPUState *cpu, hwaddr addr, uint8_t *buf, int len);
+void handle_breakpoint_insert(GArray *params, void *user_ctx);
+void handle_breakpoint_remove(GArray *params, void *user_ctx);
+int mcd_breakpoint_insert(CPUState *cpu, int type, vaddr addr, vaddr len);
+int mcd_breakpoint_remove(CPUState *cpu, int type, vaddr addr, vaddr len);
 
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
         cpu->stopped = true;
     }
-- 
2.34.1


