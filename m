Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5734981A51F
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 17:30:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFzP6-0000R9-5P; Wed, 20 Dec 2023 11:26:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1rFzP4-0000Qc-Bf
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 11:26:38 -0500
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1rFzOz-0004iX-B9
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 11:26:38 -0500
Received: (qmail 15224 invoked by uid 484); 20 Dec 2023 16:26:12 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.071925 secs); 20 Dec 2023 16:26:12 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP
 for <qemu-devel@nongnu.org>; 20 Dec 2023 16:26:10 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Christian Boenig" <christian.boenig@lauterbach.com>,
 "Nicolas Eder" <nicolas.eder@lauterbach.com>
Subject: [PATCH v5 07/18] mcdstub: mcdserver initialization functions added
Date: Wed, 20 Dec 2023 17:25:44 +0100
Message-Id: <20231220162555.19545-8-nicolas.eder@lauterbach.com>
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
 debug/mcdstub/mcdstub.c | 154 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 154 insertions(+)

diff --git a/debug/mcdstub/mcdstub.c b/debug/mcdstub/mcdstub.c
index 4d8d5d956a..0df436719e 100644
--- a/debug/mcdstub/mcdstub.c
+++ b/debug/mcdstub/mcdstub.c
@@ -22,9 +22,12 @@
 #include "qemu/cutils.h"
 #include "qemu/module.h"
 #include "qemu/error-report.h"
+#include "qemu/debug.h"
 #include "qapi/error.h"
 #include "chardev/char.h"
 #include "chardev/char-fe.h"
+#include "hw/cpu/cluster.h"
+#include "hw/boards.h"
 #include "sysemu/cpus.h"
 #include "sysemu/hw_accel.h"
 #include "sysemu/runstate.h"
@@ -109,6 +112,39 @@ static void mcd_chr_event(void *opaque, QEMUChrEvent event)
 {
 }
 
+/**
+ * init_query_cmds_table() - Initializes all query functions.
+ *
+ * This function adds all query functions to the mcd_query_cmds_table. This
+ * includes their command string, handler function and parameter schema.
+ * @mcd_query_cmds_table: Lookup table with all query commands.
+ */
+static void init_query_cmds_table(MCDCmdParseEntry *mcd_query_cmds_table)
+{}
+
+/**
+ * mcd_set_stop_cpu() - Sets c_cpu to the just stopped CPU.
+ *
+ * @cpu: The CPU state.
+ */
+static void mcd_set_stop_cpu(CPUState *cpu)
+{
+    mcdserver_state.c_cpu = cpu;
+}
+
+/**
+ * mcd_init_debug_class() - initialize mcd-specific DebugClass
+ */
+static void mcd_init_debug_class(void){
+    Object *obj;
+    obj = object_new(TYPE_DEBUG);
+    DebugState *ds = DEBUG(obj);
+    DebugClass *dc = DEBUG_GET_CLASS(ds);
+    dc->set_stop_cpu = mcd_set_stop_cpu;
+    MachineState *ms = MACHINE(qdev_get_machine());
+    ms->debug_state = ds;
+}
+
 /**
  * mcd_init_mcdserver_state() - Initializes the mcdserver_state struct.
  *
@@ -119,6 +155,35 @@ static void mcd_chr_event(void *opaque, QEMUChrEvent event)
  */
 static void mcd_init_mcdserver_state(void)
 {
+    g_assert(!mcdserver_state.init);
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
+    mcdserver_state.supported_sstep_flags =
+        accel_supported_gdbstub_sstep_flags();
+    mcdserver_state.sstep_flags = SSTEP_ENABLE | SSTEP_NOIRQ | SSTEP_NOTIMER;
+    mcdserver_state.sstep_flags &= mcdserver_state.supported_sstep_flags;
+
+    /* init query table */
+    init_query_cmds_table(mcdserver_state.mcd_query_cmds_table);
+
+    /* at this time the cpu hans't been started! -> set cpu_state */
+    mcd_cpu_state_st cpu_state =  {
+            .state = CORE_STATE_HALTED,
+            .info_str = STATE_STR_INIT_HALTED,
+    };
+    mcdserver_state.cpu_state = cpu_state;
+
+    /* create new debug object */
+    mcd_init_debug_class();
 }
 
 /**
@@ -128,6 +193,84 @@ static void mcd_init_mcdserver_state(void)
  */
 static void reset_mcdserver_state(void)
 {
+    g_free(mcdserver_state.processes);
+    mcdserver_state.processes = NULL;
+    mcdserver_state.process_num = 0;
+}
+
+/**
+ * mcd_create_default_process() - Creates a default process for debugging.
+ *
+ * This function creates a new, not yet attached, process with an ID one above
+ * the previous maximum ID.
+ * @s: A MCDState object.
+ */
+static void mcd_create_default_process(MCDState *s)
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
+}
+
+/**
+ * find_cpu_clusters() - Returns the CPU cluster of the child object.
+ *
+ * @param[in] child Object with unknown CPU cluster.
+ * @param[in] opaque Pointer to an MCDState object.
+ */
+static int find_cpu_clusters(Object *child, void *opaque)
+{
+    if (object_dynamic_cast(child, TYPE_CPU_CLUSTER)) {
+        MCDState *s = (MCDState *) opaque;
+        CPUClusterState *cluster = CPU_CLUSTER(child);
+        MCDProcess *process;
+
+        s->processes = g_renew(MCDProcess, s->processes, ++s->process_num);
+
+        process = &s->processes[s->process_num - 1];
+        assert(cluster->cluster_id != UINT32_MAX);
+        process->pid = cluster->cluster_id + 1;
+        process->attached = false;
+
+        return 0;
+    }
+
+    return object_child_foreach(child, find_cpu_clusters, opaque);
+}
+
+/**
+ * pid_order() - Compares process IDs.
+ *
+ * This function returns -1 if process "a" has a ower process ID than "b".
+ * If "b" has a lower ID than "a" 1 is returned and if they are qual 0 is
+ * returned.
+ * @a: Process a.
+ * @b: Process b.
+ */
+static int pid_order(const void *a, const void *b)
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
 }
 
 /**
@@ -141,6 +284,17 @@ static void reset_mcdserver_state(void)
  */
 static void create_processes(MCDState *s)
 {
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
 }
 
 int mcdserver_start(const char *device)
-- 
2.34.1


