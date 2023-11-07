Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 448A87E3F82
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 14:04:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0LkW-00088Z-Gi; Tue, 07 Nov 2023 08:04:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1r0LkJ-00088H-Sh
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:03:55 -0500
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1r0LkG-0005j6-Ku
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:03:55 -0500
Received: (qmail 30802 invoked by uid 484); 7 Nov 2023 13:03:32 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.09664 secs); 07 Nov 2023 13:03:32 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP for <qemu-devel@nongnu.org>; 7 Nov 2023 13:03:31 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: "Nicolas Eder" <nicolas.eder@lauterbach.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Christian Boenig" <christian.boenig@lauterbach.com>
Subject: [PATCH v3 01/20] mcdstub: initial file structure for new mcdstub
 created. -mcd QEMU startup option added. Functions for initializing the
 mcdstub added. Basic helper functions for processes/cpus in the mcdstub added
Date: Tue,  7 Nov 2023 14:03:04 +0100
Message-Id: <20231107130323.4126-2-nicolas.eder@lauterbach.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107130323.4126-1-nicolas.eder@lauterbach.com>
References: <20231107130323.4126-1-nicolas.eder@lauterbach.com>
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
 include/mcdstub/arm_mcdstub.h    |  10 +
 include/mcdstub/mcdstub.h        | 239 +++++++++++++++++++
 include/mcdstub/mcdstub_common.h |   7 +
 mcdstub/mcdstub.c                | 383 +++++++++++++++++++++++++++++++
 qemu-options.hx                  |  18 ++
 system/vl.c                      |  13 ++
 6 files changed, 670 insertions(+)
 create mode 100644 include/mcdstub/arm_mcdstub.h
 create mode 100644 include/mcdstub/mcdstub.h
 create mode 100644 include/mcdstub/mcdstub_common.h
 create mode 100644 mcdstub/mcdstub.c

diff --git a/include/mcdstub/arm_mcdstub.h b/include/mcdstub/arm_mcdstub.h
new file mode 100644
index 0000000000..a57aa8e9f2
--- /dev/null
+++ b/include/mcdstub/arm_mcdstub.h
@@ -0,0 +1,10 @@
+#ifndef ARM_MCDSTUB_H
+#define ARM_MCDSTUB_H
+
+#include "hw/core/cpu.h"
+#include "mcdstub_common.h"
+/* just used for the register xml files */
+#include "exec/gdbstub.h"
+
+
+#endif /* ARM_MCDSTUB_H */
diff --git a/include/mcdstub/mcdstub.h b/include/mcdstub/mcdstub.h
new file mode 100644
index 0000000000..36058157ae
--- /dev/null
+++ b/include/mcdstub/mcdstub.h
@@ -0,0 +1,239 @@
+#ifndef MCDSTUB_INTERNALS_H
+#define MCDSTUB_INTERNALS_H
+
+#include "exec/cpu-common.h"
+#include "chardev/char.h"
+#include "hw/core/cpu.h"
+#include "mcdstub_common.h"
+
+#define MAX_PACKET_LENGTH 1024
+/* misc */
+#define QUERY_TOTAL_NUMBER 12
+#define CMD_SCHEMA_LENGTH 6
+#define MCD_SYSTEM_NAME "qemu-system"
+
+/* supported architectures */
+#define MCDSTUB_ARCH_ARM "arm"
+
+/* tcp query packet values templates */
+#define DEVICE_NAME_TEMPLATE(s) "qemu-" #s "-device"
+
+typedef struct MCDProcess {
+    uint32_t pid;
+    bool attached;
+
+    char target_xml[1024];
+} MCDProcess;
+
+#define get_param(p, i)    (&g_array_index(p, MCDCmdVariant, i))
+
+enum RSState {
+    RS_INACTIVE,
+    RS_IDLE,
+    RS_GETLINE,
+    RS_DATAEND,
+};
+
+typedef struct MCDState {
+    bool init;       /* have we been initialised? */
+    CPUState *c_cpu; /* current CPU for everything */
+    enum RSState state; /* parsing state */
+    char line_buf[MAX_PACKET_LENGTH];
+    int line_buf_index;
+    int line_sum; /* running checksum */
+    int line_csum; /* checksum at the end of the packet */
+    GByteArray *last_packet;
+    int signal;
+
+    MCDProcess *processes;
+    int process_num;
+    GString *str_buf;
+    GByteArray *mem_buf;
+    int sstep_flags;
+    int supported_sstep_flags;
+
+    uint32_t query_cpu_id;
+    GList *all_memspaces;
+    GList *all_reggroups;
+    GList *all_registers;
+    GList *all_breakpoints;
+    GArray *resets;
+    mcd_trigger_into_st trigger;
+    mcd_cpu_state_st cpu_state;
+    MCDCmdParseEntry mcd_query_cmds_table[QUERY_TOTAL_NUMBER];
+} MCDState;
+
+/* lives in main mcdstub.c */
+extern MCDState mcdserver_state;
+
+#ifndef _WIN32
+void mcd_sigterm_handler(int signal);
+#endif
+
+/**
+ * mcdserver_start() - initializes the mcdstub and opens a TCP port
+ * @device: TCP port (e.g. tcp::1235)
+ */
+int mcdserver_start(const char *device);
+
+/**
+ * mcd_init_mcdserver_state() - Initializes the mcdserver_state struct.
+ *
+ * This function allocates memory for the mcdserver_state struct and sets
+ * all of its members to their inital values. This includes setting the
+ * cpu_state to halted and initializing the query functions with
+ * :c:func:`init_query_cmds_table`.
+ */
+void mcd_init_mcdserver_state(void);
+
+/**
+ * init_query_cmds_table() - Initializes all query functions.
+ *
+ * This function adds all query functions to the mcd_query_cmds_table. This
+ * includes their command string, handler function and parameter schema.
+ * @mcd_query_cmds_table: Lookup table with all query commands.
+ */
+void init_query_cmds_table(MCDCmdParseEntry *mcd_query_cmds_table);
+/**
+ * create_processes() - Sorts all processes and calls
+ * :c:func:`mcd_create_default_process`.
+ *
+ * This function sorts all connected processes with the qsort function.
+ * Afterwards, it creates a new process with
+ * :c:func:`mcd_create_default_process`.
+ * @s: A MCDState object.
+ */
+void create_processes(MCDState *s);
+
+/**
+ * mcd_create_default_process() - Creates a default process for debugging.
+ *
+ * This function creates a new, not yet attached, process with an ID one above
+ * the previous maximum ID.
+ * @s: A MCDState object.
+ */
+void mcd_create_default_process(MCDState *s);
+
+/**
+ * find_cpu_clusters() - Returns the CPU cluster of the child object.
+ *
+ * @param[in] child Object with unknown CPU cluster.
+ * @param[in] opaque Pointer to an MCDState object.
+ */
+int find_cpu_clusters(Object *child, void *opaque);
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
+int pid_order(const void *a, const void *b);
+
+/**
+ * mcd_chr_can_receive() - Returns the maximum packet length of a TCP packet.
+ */
+int mcd_chr_can_receive(void *opaque);
+
+/**
+ * mcd_chr_receive() - Handles receiving a TCP packet.
+ *
+ * This function gets called by QEMU when a TCP packet is received.
+ * It iterates over that packet an calls :c:func:`mcd_read_byte` for each char
+ * of the packet.
+ * @buf: Content of the packet.
+ * @size: Length of the packet.
+ */
+void mcd_chr_receive(void *opaque, const uint8_t *buf, int size);
+
+/**
+ * mcd_chr_event() - Handles a TCP client connect.
+ *
+ * This function gets called by QEMU when a TCP cliet connects to the opened
+ * TCP port. It attaches the first process. From here on TCP packets can be
+ * exchanged.
+ * @event: Type of event.
+ */
+void mcd_chr_event(void *opaque, QEMUChrEvent event);
+
+/**
+ * mcd_supports_guest_debug() - Returns true if debugging the selected
+ * accelerator is supported.
+ */
+bool mcd_supports_guest_debug(void);
+
+/**
+ * mcd_vm_state_change() - Handles a state change of the QEMU VM.
+ *
+ * This function is called when the QEMU VM goes through a state transition.
+ * It stores the runstate the CPU is in to the cpu_state and when in
+ * RUN_STATE_DEBUG it collects additional data on what watchpoint was hit.
+ * This function also resets the singlestep behavior.
+ * @running: True if he VM is running.
+ * @state: The new (and active) VM run state.
+ */
+void mcd_vm_state_change(void *opaque, bool running, RunState state);
+/**
+ * mcd_get_cpu_process() - Returns the process of the provided CPU.
+ *
+ * @cpu: The CPU state.
+ */
+MCDProcess *mcd_get_cpu_process(CPUState *cpu);
+
+/**
+ * mcd_set_stop_cpu() - Sets c_cpu to the just stopped CPU.
+ *
+ * @cpu: The CPU state.
+ */
+void mcd_set_stop_cpu(CPUState *cpu);
+
+/**
+ * mcd_get_cpu_pid() - Returns the process ID of the provided CPU.
+ *
+ * @cpu: The CPU state.
+ */
+uint32_t mcd_get_cpu_pid(CPUState *cpu);
+
+/**
+ * mcd_get_process() - Returns the process of the provided pid.
+ *
+ * @pid: The process ID.
+ */
+MCDProcess *mcd_get_process(uint32_t pid);
+
+/**
+ * mcd_first_attached_cpu() - Returns the first CPU with an attached process.
+ */
+CPUState *mcd_first_attached_cpu(void);
+
+/**
+ * mcd_next_attached_cpu() - Returns the first CPU with an attached process
+ * starting after the
+ * provided cpu.
+ *
+ * @cpu: The CPU to start from.
+ */
+CPUState *mcd_next_attached_cpu(CPUState *cpu);
+
+/**
+ * mcd_get_cpu() - Returns the CPU the index i_cpu_index.
+ *
+ * @cpu_index: Index of the desired CPU.
+ */
+CPUState *mcd_get_cpu(uint32_t cpu_index);
+/**
+ * get_first_cpu_in_process() - Returns the first CPU in the provided process.
+ *
+ * @process: The process to look in.
+ */
+CPUState *get_first_cpu_in_process(MCDProcess *process);
+
+/**
+ * find_cpu() - Returns the CPU with an index equal to the thread_id.
+ *
+ * @thread_id: ID of the desired CPU.
+ */
+CPUState *find_cpu(uint32_t thread_id);
diff --git a/include/mcdstub/mcdstub_common.h b/include/mcdstub/mcdstub_common.h
new file mode 100644
index 0000000000..3bae2c3b6f
--- /dev/null
+++ b/include/mcdstub/mcdstub_common.h
@@ -0,0 +1,7 @@
+#ifndef MCDSTUB_COMMON_H
+#define MCDSTUB_COMMON_H
+
+#define ARGUMENT_STRING_LENGTH 64
+#define TCP_CONFIG_STRING_LENGTH 128
+
+#endif /* MCDSTUB_COMMON_H */
diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
new file mode 100644
index 0000000000..4cdf2e42ed
--- /dev/null
+++ b/mcdstub/mcdstub.c
@@ -0,0 +1,383 @@
+/*
+ * This is the main mcdstub.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/ctype.h"
+#include "qemu/cutils.h"
+#include "qemu/module.h"
+#include "qemu/error-report.h"
+#include "qemu/debug.h"
+#include "hw/cpu/cluster.h"
+#include "hw/boards.h"
+#include "sysemu/hw_accel.h"
+#include "sysemu/runstate.h"
+#include "exec/replay-core.h"
+#include "exec/hwaddr.h"
+#include "qapi/error.h"
+#include "exec/tb-flush.h"
+#include "sysemu/cpus.h"
+#include "sysemu/replay.h"
+#include "chardev/char.h"
+#include "chardev/char-fe.h"
+#include "monitor/monitor.h"
+#include "cutils.h"
+
+/* mcdstub header files */
+#include "mcdstub/mcd_shared_defines.h"
+#include "mcdstub/mcdstub.h"
+
+/* architecture specific stubs */
+#include "mcdstub/arm_mcdstub.h"
+
+typedef struct {
+    CharBackend chr;
+} MCDSystemState;
+
+MCDSystemState mcdserver_system_state;
+
+MCDState mcdserver_state;
+
+void mcd_init_mcdserver_state(void)
+{
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
+ }
+
+void mcd_set_stop_cpu(CPUState *cpu)
+{
+    mcdserver_state.c_cpu = cpu;
+}
+
+void init_query_cmds_table(MCDCmdParseEntry *mcd_query_cmds_table)
+{
+    /* initalizes a list of all query commands */
+    int cmd_number = 0;
+}
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
+    char mcd_device_config[TCP_CONFIG_STRING_LENGTH];
+    char mcd_tcp_port[TCP_CONFIG_STRING_LENGTH];
+    Chardev *chr = NULL;
+
+    if (!first_cpu) {
+        error_report("mcdstub: meaningless to attach to a "
+                     "machine without any CPU.");
+        return -1;
+    }
+
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
+    /* if device == default -> set tcp_port = tcp::<MCD_DEFAULT_TCP_PORT> */
+    if (strcmp(device, "default") == 0) {
+        snprintf(mcd_tcp_port, sizeof(mcd_tcp_port), "tcp::%s",
+            MCD_DEFAULT_TCP_PORT);
+        device = mcd_tcp_port;
+    }
+
+    if (strcmp(device, "none") != 0) {
+        if (strstart(device, "tcp:", NULL)) {
+            /* enforce required TCP attributes */
+            snprintf(mcd_device_config, sizeof(mcd_device_config),
+                     "%s,wait=off,nodelay=on,server=on", device);
+            device = mcd_device_config;
+        }
+#ifndef _WIN32
+        else if (strcmp(device, "stdio") == 0) {
+            struct sigaction act;
+
+            memset(&act, 0, sizeof(act));
+            act.sa_handler = mcd_sigterm_handler;
+            sigaction(SIGINT, &act, NULL);
+            strcpy(mcd_device_config, device);
+        }
+#endif
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
+    } else {
+        qemu_chr_fe_deinit(&mcdserver_system_state.chr, true);
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
+    int i;
+
+    for (i = 0; i < size; i++) {
+        mcd_read_byte(buf[i]);
+        if (buf[i] == 0) {
+            break;
+        }
+    }
+}
+
+
+void mcd_chr_event(void *opaque, QEMUChrEvent event)
+{
+    int i;
+    MCDState *s = (MCDState *) opaque;
+
+    switch (event) {
+    case CHR_EVENT_OPENED:
+        /* Start with first process attached, others detached */
+        for (i = 0; i < s->process_num; i++) {
+            s->processes[i].attached = !i;
+        }
+
+        s->c_cpu = mcd_first_attached_cpu();
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
+CPUState *mcd_get_cpu(uint32_t cpu_index)
+{
+    CPUState *cpu = first_cpu;
+
+    while (cpu) {
+        if (cpu->cpu_index == cpu_index) {
+            return cpu;
+        }
+        cpu = mcd_next_attached_cpu(cpu);
+    }
+
+    return cpu;
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
+
+int mcd_get_cpu_index(CPUState *cpu)
+{
+    return cpu->cpu_index + 1;
+}
+
+CPUState *get_first_cpu_in_process(MCDProcess *process)
+{
+    CPUState *cpu;
+
+    CPU_FOREACH(cpu) {
+        if (mcd_get_cpu_pid(cpu) == process->pid) {
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
+        if (mcd_get_cpu_index(cpu) == thread_id) {
+            return cpu;
+        }
+    }
+
+    return NULL;
+}
+
diff --git a/qemu-options.hx b/qemu-options.hx
index e26230bac5..accf92642c 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4430,6 +4430,24 @@ SRST
     (see the :ref:`GDB usage` chapter in the System Emulation Users Guide).
 ERST
 
+DEF("mcd", HAS_ARG, QEMU_OPTION_mcd, \
+    "-mcd dev        accept mcd connection on 'dev'. (QEMU defaults to starting\n"
+    "                the guest without waiting for a mcd client to connect; use -S too\n"
+    "                if you want it to not start execution.)\n"
+    "                To use the default Port write '-mcd default'\n",
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
+        -mcd tcp::1235
+ERST
+
 DEF("d", HAS_ARG, QEMU_OPTION_d, \
     "-d item1,...    enable logging of specified items (use '-d help' for a list of log items)\n",
     QEMU_ARCH_ALL)
diff --git a/system/vl.c b/system/vl.c
index 92d29bf521..b657c77ea4 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -68,6 +68,7 @@
 #include "sysemu/numa.h"
 #include "sysemu/hostmem.h"
 #include "exec/gdbstub.h"
+#include "mcdstub/mcdstub.h"
 #include "qemu/timer.h"
 #include "chardev/char.h"
 #include "qemu/bitmap.h"
@@ -1266,6 +1267,7 @@ struct device_config {
         DEV_PARALLEL,  /* -parallel      */
         DEV_DEBUGCON,  /* -debugcon */
         DEV_GDB,       /* -gdb, -s */
+        DEV_MCD,       /* -mcd */
         DEV_SCLP,      /* s390 sclp */
     } type;
     const char *cmdline;
@@ -2673,6 +2675,14 @@ static void qemu_machine_creation_done(void)
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
@@ -3028,6 +3038,9 @@ void qemu_init(int argc, char **argv)
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


