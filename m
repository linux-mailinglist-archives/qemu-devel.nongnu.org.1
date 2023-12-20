Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 182EA81A511
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 17:29:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFzPI-0000Wg-Db; Wed, 20 Dec 2023 11:26:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1rFzP9-0000TW-GQ
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 11:26:43 -0500
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1rFzP7-0004mS-8o
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 11:26:43 -0500
Received: (qmail 15502 invoked by uid 484); 20 Dec 2023 16:26:26 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 1.8e-05 secs); 20 Dec 2023 16:26:26 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP
 for <qemu-devel@nongnu.org>; 20 Dec 2023 16:26:23 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Christian Boenig" <christian.boenig@lauterbach.com>,
 "Nicolas Eder" <nicolas.eder@lauterbach.com>
Subject: [PATCH v5 13/18] mcdstub: go, step and break added
Date: Wed, 20 Dec 2023 17:25:50 +0100
Message-Id: <20231220162555.19545-14-nicolas.eder@lauterbach.com>
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
 debug/mcdstub/mcdstub.c | 218 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 218 insertions(+)

diff --git a/debug/mcdstub/mcdstub.c b/debug/mcdstub/mcdstub.c
index e90fc81814..ee52830a2c 100644
--- a/debug/mcdstub/mcdstub.c
+++ b/debug/mcdstub/mcdstub.c
@@ -28,6 +28,7 @@
 #include "chardev/char-fe.h"
 #include "hw/cpu/cluster.h"
 #include "hw/boards.h"
+#include "exec/tb-flush.h"
 #include "sysemu/cpus.h"
 #include "sysemu/hw_accel.h"
 #include "sysemu/runstate.h"
@@ -182,6 +183,96 @@ static CPUState *mcd_get_cpu(uint32_t cpu_index)
  */
 static void mcd_vm_state_change(void *opaque, bool running, RunState state)
 {
+    CPUState *cpu = mcdserver_state.c_cpu;
+
+    if (mcdserver_state.state == RS_INACTIVE) {
+        return;
+    }
+
+    if (cpu == NULL) {
+        if (running) {
+            /*
+             * this is the case if qemu starts the vm
+             * before a mcd client is connected
+             */
+            const char *mcd_state;
+            mcd_state = CORE_STATE_RUNNING;
+            const char *info_str;
+            info_str = STATE_STR_INIT_RUNNING;
+            mcdserver_state.cpu_state.state = mcd_state;
+            mcdserver_state.cpu_state.info_str = info_str;
+        }
+        return;
+    }
+
+    const char *mcd_state;
+    const char *stop_str;
+    const char *info_str;
+    uint32_t bp_type = 0;
+    uint64_t bp_address = 0;
+    switch (state) {
+    case RUN_STATE_RUNNING:
+        mcd_state = CORE_STATE_RUNNING;
+        info_str = STATE_STR_RUNNING(cpu->cpu_index);
+        stop_str = "";
+        break;
+    case RUN_STATE_DEBUG:
+        mcd_state = CORE_STATE_DEBUG;
+        info_str = STATE_STR_DEBUG(cpu->cpu_index);
+        if (cpu->watchpoint_hit) {
+            switch (cpu->watchpoint_hit->flags & BP_MEM_ACCESS) {
+            case BP_MEM_READ:
+                bp_type = MCD_BREAKPOINT_READ;
+                stop_str = STATE_STR_BREAK_READ(cpu->watchpoint_hit->hitaddr);
+                break;
+            case BP_MEM_WRITE:
+                bp_type = MCD_BREAKPOINT_WRITE;
+                stop_str = STATE_STR_BREAK_WRITE(cpu->watchpoint_hit->hitaddr);
+                break;
+            case BP_MEM_ACCESS:
+                bp_type = MCD_BREAKPOINT_RW;
+                stop_str = STATE_STR_BREAK_RW(cpu->watchpoint_hit->hitaddr);
+                break;
+            default:
+                stop_str = STATE_STR_BREAK_UNKNOWN;
+                break;
+            }
+            bp_address = cpu->watchpoint_hit->hitaddr;
+            cpu->watchpoint_hit = NULL;
+        } else if (cpu->singlestep_enabled) {
+            /* we land here when a single step is performed */
+            stop_str = STATE_STEP_PERFORMED;
+        } else {
+            bp_type = MCD_BREAKPOINT_HW;
+            stop_str = STATE_STR_BREAK_HW;
+            tb_flush(cpu);
+        }
+        /* deactivate single step */
+        cpu_single_step(cpu, 0);
+        break;
+    case RUN_STATE_PAUSED:
+        info_str = STATE_STR_HALTED(cpu->cpu_index);
+        mcd_state = CORE_STATE_HALTED;
+        stop_str = "";
+        break;
+    case RUN_STATE_WATCHDOG:
+        info_str = STATE_STR_UNKNOWN(cpu->cpu_index);
+        mcd_state = CORE_STATE_UNKNOWN;
+        stop_str = "";
+        break;
+    default:
+        info_str = STATE_STR_UNKNOWN(cpu->cpu_index);
+        mcd_state = CORE_STATE_UNKNOWN;
+        stop_str = "";
+        break;
+    }
+
+    /* set state for c_cpu */
+    mcdserver_state.cpu_state.state = mcd_state;
+    mcdserver_state.cpu_state.bp_type = bp_type;
+    mcdserver_state.cpu_state.bp_address = bp_address;
+    mcdserver_state.cpu_state.stop_str = stop_str;
+    mcdserver_state.cpu_state.info_str = info_str;
 }
 
 /**
@@ -637,6 +728,104 @@ static void handle_close_core(GArray *params, void *user_ctx)
     g_array_free(registers, TRUE);
 }
 
+/**
+ * mcd_cpu_start() - Starts the selected CPU with the cpu_resume function.
+ *
+ * @cpu: The CPU about to be started.
+ */
+static void mcd_cpu_start(CPUState *cpu)
+{
+    if (!runstate_needs_reset() && !runstate_is_running() &&
+        !vm_prepare_start(false)) {
+        mcdserver_state.c_cpu = cpu;
+        qemu_clock_enable(QEMU_CLOCK_VIRTUAL, true);
+        cpu_resume(cpu);
+    }
+}
+
+/**
+ * mcd_cpu_sstep() - Performes a step on the selected CPU.
+ *
+ * This function first sets the correct single step flags for the CPU with
+ * cpu_single_step and then starts the CPU with cpu_resume.
+ * @cpu: The CPU about to be stepped.
+ */
+static int mcd_cpu_sstep(CPUState *cpu)
+{
+    mcdserver_state.c_cpu = cpu;
+    cpu_single_step(cpu, mcdserver_state.sstep_flags);
+    if (!runstate_needs_reset() && !runstate_is_running() &&
+        !vm_prepare_start(true)) {
+        qemu_clock_enable(QEMU_CLOCK_VIRTUAL, true);
+        cpu_resume(cpu);
+    }
+    return 0;
+}
+
+/**
+ * mcd_vm_stop() - Brings all CPUs in debug state with the vm_stop function.
+ */
+static void mcd_vm_stop(void)
+{
+    if (runstate_is_running()) {
+        vm_stop(RUN_STATE_DEBUG);
+    }
+}
+
+/**
+ * handle_vm_start() - Handler for the VM start TCP packet.
+ *
+ * Evaluates whether all cores or just a perticular core should get started and
+ * calls :c:func:`mcd_vm_start` or :c:func:`mcd_cpu_start` respectively.
+ * @params: GArray with all TCP packet parameters.
+ */
+static void handle_vm_start(GArray *params, void *user_ctx)
+{
+    uint32_t global = get_param(params, 0)->data_uint32_t;
+    if (global == 1) {
+        mcd_vm_start();
+    } else{
+        uint32_t cpu_id = get_param(params, 1)->cpu_id;
+        CPUState *cpu = mcd_get_cpu(cpu_id);
+        mcd_cpu_start(cpu);
+    }
+}
+
+/**
+ * handle_vm_step() - Handler for the VM step TCP packet.
+ *
+ * Calls :c:func:`mcd_cpu_sstep` for the CPU which sould be stepped.
+ * Stepping all CPUs is currently not supported.
+ * @params: GArray with all TCP packet parameters.
+ */
+static void handle_vm_step(GArray *params, void *user_ctx)
+{
+    uint32_t global = get_param(params, 0)->data_uint32_t;
+    if (global == 1) {
+        /* TODO: add multicore support */
+    } else{
+        uint32_t cpu_id = get_param(params, 1)->cpu_id;
+        CPUState *cpu = mcd_get_cpu(cpu_id);
+        int return_value = mcd_cpu_sstep(cpu);
+        if (return_value != 0) {
+            g_assert_not_reached();
+        }
+    }
+}
+
+/**
+ * handle_vm_stop() - Handler for the VM stop TCP packet.
+ *
+ * Always calls :c:func:`mcd_vm_stop` and stops all cores. Stopping individual
+ * cores is currently not supported.
+ * @params: GArray with all TCP packet parameters.
+ */
+static void handle_vm_stop(GArray *params, void *user_ctx)
+{
+    /* TODO: add core dependant break option */
+    mcd_vm_stop();
+}
+
 /**
  * mcd_handle_packet() - Evaluates the type of received packet and chooses the
  * correct handler.
@@ -703,6 +892,35 @@ static int mcd_handle_packet(const char *line_buf)
             cmd_parser = &close_core_cmd_desc;
         }
         break;
+    case TCP_CHAR_GO:
+        {
+            static MCDCmdParseEntry go_cmd_desc = {
+                .handler = handle_vm_start,
+                .cmd = {TCP_CHAR_GO, '\0'},
+                .schema = {ARG_SCHEMA_INT, ARG_SCHEMA_CORENUM, '\0'},
+            };
+            cmd_parser = &go_cmd_desc;
+        }
+        break;
+    case TCP_CHAR_STEP:
+        {
+            static MCDCmdParseEntry step_cmd_desc = {
+                .handler = handle_vm_step,
+                .cmd = {TCP_CHAR_STEP, '\0'},
+                .schema = {ARG_SCHEMA_INT, ARG_SCHEMA_CORENUM, '\0'},
+            };
+            cmd_parser = &step_cmd_desc;
+        }
+        break;
+    case TCP_CHAR_BREAK:
+        {
+            static MCDCmdParseEntry break_cmd_desc = {
+                .handler = handle_vm_stop,
+                .cmd = {TCP_CHAR_BREAK, '\0'},
+            };
+            cmd_parser = &break_cmd_desc;
+        }
+        break;
     default:
         /* command not supported */
         mcd_put_packet("");
-- 
2.34.1


