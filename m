Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF0B81A509
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 17:28:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFzPO-0000XZ-Oj; Wed, 20 Dec 2023 11:26:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1rFzPM-0000XQ-P5
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 11:26:56 -0500
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1rFzPK-0004pw-RB
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 11:26:56 -0500
Received: (qmail 15722 invoked by uid 484); 20 Dec 2023 16:26:42 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 6e-06 secs); 20 Dec 2023 16:26:42 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP
 for <qemu-devel@nongnu.org>; 20 Dec 2023 16:26:35 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Christian Boenig" <christian.boenig@lauterbach.com>,
 "Nicolas Eder" <nicolas.eder@lauterbach.com>
Subject: [PATCH v5 18/18] mcdstub: break/watchpoints added
Date: Wed, 20 Dec 2023 17:25:55 +0100
Message-Id: <20231220162555.19545-19-nicolas.eder@lauterbach.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220162555.19545-1-nicolas.eder@lauterbach.com>
References: <20231220162555.19545-1-nicolas.eder@lauterbach.com>
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
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

---
 debug/mcdstub/mcdstub.c | 150 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 150 insertions(+)

diff --git a/debug/mcdstub/mcdstub.c b/debug/mcdstub/mcdstub.c
index 954d06c0b7..d2c505c0d6 100644
--- a/debug/mcdstub/mcdstub.c
+++ b/debug/mcdstub/mcdstub.c
@@ -1177,6 +1177,134 @@ static void handle_write_memory(GArray *params, void *user_ctx)
     mcd_put_packet(TCP_EXECUTION_SUCCESS);
 }
 
+/**
+ * mcd_breakpoint_insert() - Inserts a break- or watchpoint.
+ *
+ * This function evaluates the received breakpoint type and translates it
+ * to a known GDB breakpoint type.
+ * Then it calls cpu_breakpoint_insert or cpu_watchpoint_insert depending on
+ * the type.
+ * @cpu: CPU to which the breakpoint should be added.
+ * @addr: Address of the breakpoint.
+ * @type: Breakpoint type.
+ */
+static int mcd_breakpoint_insert(CPUState *cpu, int type, vaddr addr)
+{
+    /* translate the type to known gdb types and function call*/
+    int bp_type = 0;
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+    if (cc->gdb_stop_before_watchpoint) {
+        /* bp_type |= BP_STOP_BEFORE_ACCESS; */
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
+/**
+ * mcd_breakpoint_remove() - Removes a break- or watchpoint.
+ *
+ * This function evaluates the received breakpoint type and translates it
+ * to a known GDB breakpoint type.
+ * Then it calls cpu_breakpoint_remove or cpu_watchpoint_remove depending on
+ * the type.
+ * @cpu: CPU from which the breakpoint should be removed.
+ * @addr: Address of the breakpoint.
+ * @type: Breakpoint type.
+ */
+static int mcd_breakpoint_remove(CPUState *cpu, int type, vaddr addr)
+{
+    /* translate the type to known gdb types and function call*/
+    int bp_type = 0;
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+    if (cc->gdb_stop_before_watchpoint) {
+        /* bp_type |= BP_STOP_BEFORE_ACCESS; */
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
+/**
+ * handle_breakpoint_insert() - Handler for inserting a break- or watchpoint.
+ *
+ * This function extracts the CPU, breakpoint type and address from the
+ * parameters and calls :c:func:`mcd_breakpoint_insert` to insert the
+ * breakpoint.
+ * @params: GArray with all TCP packet parameters.
+ */
+static void handle_breakpoint_insert(GArray *params, void *user_ctx)
+{
+    /* 1. get parameter data */
+    uint32_t cpu_id = get_param(params, 0)->cpu_id;
+    uint32_t type = get_param(params, 1)->data_uint32_t;
+    uint64_t address = get_param(params, 2)->data_uint64_t;
+    /* 2. insert breakpoint and send reply */
+    CPUState *cpu = mcd_get_cpu(cpu_id);
+    if (mcd_breakpoint_insert(cpu, type, address) != 0) {
+        mcd_put_packet(TCP_EXECUTION_ERROR);
+    } else {
+        mcd_put_packet(TCP_EXECUTION_SUCCESS);
+    }
+}
+
+/**
+ * handle_breakpoint_remove() - Handler for inserting a break- or watchpoint.
+ *
+ * This function extracts the CPU, breakpoint type and address from the
+ * parameters and calls :c:func:`mcd_breakpoint_remove` to insert the
+ * breakpoint.
+ * @params: GArray with all TCP packet parameters.
+ */
+static void handle_breakpoint_remove(GArray *params, void *user_ctx)
+{
+    /* 1. get parameter data */
+    uint32_t cpu_id = get_param(params, 0)->cpu_id;
+    uint32_t type = get_param(params, 1)->data_uint32_t;
+    uint64_t address = get_param(params, 2)->data_uint64_t;
+    /* 2. remove breakpoint and send reply */
+    CPUState *cpu = mcd_get_cpu(cpu_id);
+    if (mcd_breakpoint_remove(cpu, type, address) != 0) {
+        mcd_put_packet(TCP_EXECUTION_ERROR);
+    } else {
+        mcd_put_packet(TCP_EXECUTION_SUCCESS);
+    }
+}
+
 /**
  * mcd_handle_packet() - Evaluates the type of received packet and chooses the
  * correct handler.
@@ -1331,6 +1459,28 @@ static int mcd_handle_packet(const char *line_buf)
             cmd_parser = &write_mem_cmd_desc;
         }
         break;
+    case TCP_CHAR_BREAKPOINT_INSERT:
+        {
+            static MCDCmdParseEntry handle_breakpoint_insert_cmd_desc = {
+                .handler = handle_breakpoint_insert,
+                .cmd = {TCP_CHAR_BREAKPOINT_INSERT, '\0'},
+                .schema = {ARG_SCHEMA_CORENUM, ARG_SCHEMA_INT,
+                           ARG_SCHEMA_UINT64_T, '\0'},
+            };
+            cmd_parser = &handle_breakpoint_insert_cmd_desc;
+        }
+        break;
+    case TCP_CHAR_BREAKPOINT_REMOVE:
+        {
+            static MCDCmdParseEntry handle_breakpoint_remove_cmd_desc = {
+                .handler = handle_breakpoint_remove,
+                .cmd = {TCP_CHAR_BREAKPOINT_REMOVE, '\0'},
+                .schema = {ARG_SCHEMA_CORENUM, ARG_SCHEMA_INT,
+                           ARG_SCHEMA_UINT64_T, '\0'},
+            };
+            cmd_parser = &handle_breakpoint_remove_cmd_desc;
+        }
+        break;
     default:
         /* command not supported */
         mcd_put_packet("");
-- 
2.34.1


