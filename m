Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A520981A503
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 17:28:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFzPE-0000Ty-0f; Wed, 20 Dec 2023 11:26:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1rFzP5-0000Qy-3j
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 11:26:39 -0500
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1rFzOz-0004i9-BB
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 11:26:38 -0500
Received: (qmail 15190 invoked by uid 484); 20 Dec 2023 16:26:10 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.153183 secs); 20 Dec 2023 16:26:10 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP
 for <qemu-devel@nongnu.org>; 20 Dec 2023 16:26:09 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Christian Boenig" <christian.boenig@lauterbach.com>,
 "Nicolas Eder" <nicolas.eder@lauterbach.com>
Subject: [PATCH v5 06/18] mcdstub: -mcd start option added,
 mcd specific defines added
Date: Wed, 20 Dec 2023 17:25:43 +0100
Message-Id: <20231220162555.19545-7-nicolas.eder@lauterbach.com>
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
 debug/mcdstub/mcdstub.c          | 203 +++++++++++++++++++++++++++++++
 debug/mcdstub/meson.build        |  12 ++
 debug/meson.build                |   1 +
 include/mcdstub/mcdstub.h        | 152 +++++++++++++++++++++++
 include/mcdstub/mcdstub_common.h |  46 +++++++
 qemu-options.hx                  |  18 +++
 system/vl.c                      |  13 ++
 7 files changed, 445 insertions(+)

diff --git a/debug/mcdstub/mcdstub.c b/debug/mcdstub/mcdstub.c
index c24aaf1202..4d8d5d956a 100644
--- a/debug/mcdstub/mcdstub.c
+++ b/debug/mcdstub/mcdstub.c
@@ -16,3 +16,206 @@
  *
  * SPDX-License-Identifier: LGPL-2.0+
  */
+
+#include "qemu/osdep.h"
+#include "qemu/ctype.h"
+#include "qemu/cutils.h"
+#include "qemu/module.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "chardev/char.h"
+#include "chardev/char-fe.h"
+#include "sysemu/cpus.h"
+#include "sysemu/hw_accel.h"
+#include "sysemu/runstate.h"
+
+#include "mcdstub/mcd_shared_defines.h"
+#include "mcdstub/mcdstub.h"
+
+typedef struct {
+    CharBackend chr;
+} MCDSystemState;
+
+MCDSystemState mcdserver_system_state;
+
+MCDState mcdserver_state;
+
+/**
+ * mcd_supports_guest_debug() - Returns true if debugging the selected
+ * accelerator is supported.
+ */
+static bool mcd_supports_guest_debug(void)
+{
+    const AccelOpsClass *ops = cpus_get_accel();
+    if (ops->supports_guest_debug) {
+        return ops->supports_guest_debug();
+    }
+    return false;
+}
+
+#ifndef _WIN32
+static void mcd_sigterm_handler(int signal)
+{
+    if (runstate_is_running()) {
+        vm_stop(RUN_STATE_PAUSED);
+    }
+}
+#endif
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
+static void mcd_vm_state_change(void *opaque, bool running, RunState state)
+{
+}
+
+/**
+ * mcd_chr_can_receive() - Returns the maximum packet length of a TCP packet.
+ */
+static int mcd_chr_can_receive(void *opaque)
+{
+    return MAX_PACKET_LENGTH;
+}
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
+static void mcd_chr_receive(void *opaque, const uint8_t *buf, int size)
+{
+}
+
+/**
+ * mcd_chr_event() - Handles a TCP client connect.
+ *
+ * This function gets called by QEMU when a TCP cliet connects to the opened
+ * TCP port. It attaches the first process. From here on TCP packets can be
+ * exchanged.
+ * @event: Type of event.
+ */
+static void mcd_chr_event(void *opaque, QEMUChrEvent event)
+{
+}
+
+/**
+ * mcd_init_mcdserver_state() - Initializes the mcdserver_state struct.
+ *
+ * This function allocates memory for the mcdserver_state struct and sets
+ * all of its members to their inital values. This includes setting the
+ * cpu_state to halted and initializing the query functions with
+ * :c:func:`init_query_cmds_table`.
+ */
+static void mcd_init_mcdserver_state(void)
+{
+}
+
+/**
+ * reset_mcdserver_state() - Resets the mcdserver_state struct.
+ *
+ * This function deletes all processes connected to the mcdserver_state.
+ */
+static void reset_mcdserver_state(void)
+{
+}
+
+/**
+ * create_processes() - Sorts all processes and calls
+ * :c:func:`mcd_create_default_process`.
+ *
+ * This function sorts all connected processes with the qsort function.
+ * Afterwards, it creates a new process with
+ * :c:func:`mcd_create_default_process`.
+ * @s: A MCDState object.
+ */
+static void create_processes(MCDState *s)
+{
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
+            if (snprintf(mcd_device_config, sizeof(mcd_device_config),
+                     "%s,wait=off,nodelay=on,server=on", device) < 0) {
+                g_assert_not_reached();
+            }
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
diff --git a/debug/mcdstub/meson.build b/debug/mcdstub/meson.build
index e69de29bb2..7e5ae878b0 100644
--- a/debug/mcdstub/meson.build
+++ b/debug/mcdstub/meson.build
@@ -0,0 +1,12 @@
+# only system emulation is supported over mcd
+mcd_system_ss = ss.source_set()
+mcd_system_ss.add(files('mcdstub.c'))
+mcd_system_ss = mcd_system_ss.apply(config_host, strict: false)
+
+libmcd_system = static_library('mcd_system',
+                                mcd_system_ss.sources() + genh,
+                                name_suffix: 'fa',
+                                build_by_default: have_system)
+
+mcd_system = declare_dependency(link_whole: libmcd_system)
+system_ss.add(mcd_system)
diff --git a/debug/meson.build b/debug/meson.build
index f46ab14af9..97c80d7406 100644
--- a/debug/meson.build
+++ b/debug/meson.build
@@ -1,2 +1,3 @@
 subdir('common')
 subdir('gdbstub')
+subdir('mcdstub')
diff --git a/include/mcdstub/mcdstub.h b/include/mcdstub/mcdstub.h
index c24aaf1202..26aa33c0e3 100644
--- a/include/mcdstub/mcdstub.h
+++ b/include/mcdstub/mcdstub.h
@@ -16,3 +16,155 @@
  *
  * SPDX-License-Identifier: LGPL-2.0+
  */
+
+#ifndef MCDSTUB_H
+#define MCDSTUB_H
+
+#include "mcdstub_common.h"
+
+#define MAX_PACKET_LENGTH 1024
+
+/* trigger defines */
+#define MCD_TRIG_OPT_DATA_IS_CONDITION 0x00000008
+#define MCD_TRIG_ACTION_DBG_DEBUG 0x00000001
+
+/* schema defines */
+#define ARG_SCHEMA_QRYHANDLE 'q'
+#define ARG_SCHEMA_STRING 's'
+#define ARG_SCHEMA_INT 'd'
+#define ARG_SCHEMA_UINT64_T 'l'
+#define ARG_SCHEMA_CORENUM 'c'
+#define ARG_SCHEMA_HEXDATA 'h'
+
+/* resets */
+#define RESET_SYSTEM "full_system_reset"
+#define RESET_GPR "gpr_reset"
+#define RESET_MEMORY "memory_reset"
+
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
+/* state strings */
+#define STATE_STR_UNKNOWN(d) "cpu " #d " in unknown state"
+#define STATE_STR_DEBUG(d) "cpu " #d " in debug state"
+#define STATE_STR_RUNNING(d) "cpu " #d " running"
+#define STATE_STR_HALTED(d) "cpu " #d " currently halted"
+#define STATE_STR_INIT_HALTED "vm halted since boot"
+#define STATE_STR_INIT_RUNNING "vm running since boot"
+#define STATE_STR_BREAK_HW "stopped beacuse of HW breakpoint"
+#define STATE_STEP_PERFORMED "stopped beacuse of single step"
+#define STATE_STR_BREAK_READ(d) "stopped beacuse of read access at " #d
+#define STATE_STR_BREAK_WRITE(d) "stopped beacuse of write access at " #d
+#define STATE_STR_BREAK_RW(d) "stopped beacuse of read or write access at " #d
+#define STATE_STR_BREAK_UNKNOWN "stopped for unknown reason"
+
+typedef struct MCDProcess {
+    uint32_t pid;
+    bool attached;
+} MCDProcess;
+
+typedef void (*MCDCmdHandler)(GArray *params, void *user_ctx);
+typedef struct MCDCmdParseEntry {
+    MCDCmdHandler handler;
+    char cmd[ARGUMENT_STRING_LENGTH];
+    char schema[CMD_SCHEMA_LENGTH];
+} MCDCmdParseEntry;
+
+typedef union MCDCmdVariant {
+    const char *data;
+    uint32_t data_uint32_t;
+    uint64_t data_uint64_t;
+    uint32_t query_handle;
+    uint32_t cpu_id;
+} MCDCmdVariant;
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
+typedef struct breakpoint_st {
+    uint32_t type;
+    uint64_t address;
+    uint32_t id;
+} breakpoint_st;
+
+typedef struct mcd_trigger_into_st {
+    char type[ARGUMENT_STRING_LENGTH];
+    char option[ARGUMENT_STRING_LENGTH];
+    char action[ARGUMENT_STRING_LENGTH];
+    uint32_t nr_trigger;
+} mcd_trigger_into_st;
+
+typedef struct mcd_cpu_state_st {
+    const char *state;
+    bool memory_changed;
+    bool registers_changed;
+    bool target_was_stopped;
+    uint32_t bp_type;
+    uint64_t bp_address;
+    const char *stop_str;
+    const char *info_str;
+} mcd_cpu_state_st;
+
+typedef struct MCDState {
+    bool init;
+    CPUState *c_cpu;
+    enum RSState state;
+    char line_buf[MAX_PACKET_LENGTH];
+    int line_buf_index;
+    int line_sum;
+    int line_csum;
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
+/* lives in mcdstub.c */
+extern MCDState mcdserver_state;
+
+typedef struct xml_attrib {
+    char argument[ARGUMENT_STRING_LENGTH];
+    char value[ARGUMENT_STRING_LENGTH];
+} xml_attrib;
+
+typedef struct mcd_reset_st {
+    const char *name;
+    uint8_t id;
+} mcd_reset_st;
+
+/**
+ * mcdserver_start() - initializes the mcdstub and opens a TCP port
+ * @device: TCP port (e.g. tcp::1235)
+ */
+int mcdserver_start(const char *device);
+
+#endif /* MCDSTUB_H */
diff --git a/include/mcdstub/mcdstub_common.h b/include/mcdstub/mcdstub_common.h
index c24aaf1202..b64748c080 100644
--- a/include/mcdstub/mcdstub_common.h
+++ b/include/mcdstub/mcdstub_common.h
@@ -16,3 +16,49 @@
  *
  * SPDX-License-Identifier: LGPL-2.0+
  */
+
+#ifndef MCDSTUB_COMMON_H
+#define MCDSTUB_COMMON_H
+
+#define ARGUMENT_STRING_LENGTH 64
+#define TCP_CONFIG_STRING_LENGTH 128
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
+    bool is_physical;
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
+#endif /* MCDSTUB_COMMON_H */
diff --git a/qemu-options.hx b/qemu-options.hx
index 42fd09e4de..b60df3463c 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4444,6 +4444,24 @@ SRST
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
index 2bcd9efb9a..2c4610c19f 100644
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
@@ -1271,6 +1272,7 @@ struct device_config {
         DEV_PARALLEL,  /* -parallel      */
         DEV_DEBUGCON,  /* -debugcon */
         DEV_GDB,       /* -gdb, -s */
+        DEV_MCD,       /* -mcd */
         DEV_SCLP,      /* s390 sclp */
     } type;
     const char *cmdline;
@@ -2686,6 +2688,12 @@ static void qemu_machine_creation_done(void)
     if (foreach_device_config(DEV_GDB, gdbserver_start) < 0) {
         exit(1);
     }
+    if (foreach_device_config(DEV_MCD, mcdserver_start) < 0) {
+        /*
+         * starts the mcdserver if the mcd option was set
+         */
+        exit(1);
+    }
     if (!vga_interface_created && !default_vga &&
         vga_interface_type != VGA_NONE) {
         warn_report("A -vga option was passed but this machine "
@@ -3041,6 +3049,11 @@ void qemu_init(int argc, char **argv)
             case QEMU_OPTION_gdb:
                 add_device_config(DEV_GDB, optarg);
                 break;
+#if !defined(CONFIG_USER_ONLY)
+            case QEMU_OPTION_mcd:
+                add_device_config(DEV_MCD, optarg);
+                break;
+#endif
             case QEMU_OPTION_L:
                 if (is_help_option(optarg)) {
                     list_data_dirs = true;
-- 
2.34.1


