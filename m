Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C45BA7BB3F2
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 11:09:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qognv-0000eT-Ak; Fri, 06 Oct 2023 05:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qogng-0008Qs-3L
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:07:17 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qognb-00014G-Qs
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:07:11 -0400
Received: (qmail 19990 invoked by uid 484); 6 Oct 2023 09:06:55 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.07256 secs); 06 Oct 2023 09:06:55 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP for <qemu-devel@nongnu.org>; 6 Oct 2023 09:06:54 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Christian.Boenig@lauterbach.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicolas Eder <nicolas.eder@lauterbach.com>
Subject: [PATCH v2 25/29] Doxygen documentation added
Date: Fri,  6 Oct 2023 11:06:06 +0200
Message-Id: <20231006090610.26171-26-nicolas.eder@lauterbach.com>
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
 
 #define DEFAULT_MCDSTUB_PORT "1235"
 
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
 
 typedef void (*gdb_syscall_complete_cb)(CPUState *cpu, uint64_t ret, int err);
 
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
 
 #define QUERY_ARG_SYSTEM "system"
 #define QUERY_ARG_CORES "cores"
diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index 7613ed2c4a..a468a7d7b8 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -218,12 +218,6 @@ int find_cpu_clusters(Object *child, void *opaque)
         s->processes = g_renew(MCDProcess, s->processes, ++s->process_num);
 
         process = &s->processes[s->process_num - 1];
-
-        /*
-         * GDB process IDs -1 and 0 are reserved. To avoid subtle errors at
-         * runtime, we enforce here that the machine does not use a cluster ID
-         * that would lead to PID 0.
-         */
         assert(cluster->cluster_id != UINT32_MAX);
         process->pid = cluster->cluster_id + 1;
         process->attached = false;
@@ -925,7 +919,7 @@ void mcd_vm_state_change(void *opaque, bool running, RunState state)
 
 int mcd_put_packet(const char *buf)
 {
-    return mcd_put_packet_binary(buf, strlen(buf), false);
+    return mcd_put_packet_binary(buf, strlen(buf));
 }
 
 void mcd_put_strbuf(void)
@@ -933,7 +927,7 @@ void mcd_put_strbuf(void)
     mcd_put_packet(mcdserver_state.str_buf->str);
 }
 
-int mcd_put_packet_binary(const char *buf, int len, bool dump)
+int mcd_put_packet_binary(const char *buf, int len)
 {
     for (;;) {
         g_byte_array_set_size(mcdserver_state.last_packet, 0);
@@ -999,12 +993,12 @@ MCDProcess *mcd_get_process(uint32_t pid)
     return NULL;
 }
 
-CPUState *mcd_get_cpu(uint32_t i_cpu_index)
+CPUState *mcd_get_cpu(uint32_t cpu_index)
 {
     CPUState *cpu = first_cpu;
 
     while (cpu) {
-        if (cpu->cpu_index == i_cpu_index) {
+        if (cpu->cpu_index == cpu_index) {
             return cpu;
         }
         cpu = mcd_next_attached_cpu(cpu);
@@ -1344,15 +1338,13 @@ void handle_open_core(GArray *params, void *user_ctx)
 
 void handle_query_reset_f(GArray *params, void *user_ctx)
 {
-    /* TODO: vull reset over the qemu monitor */
-
     /* 1. check length */
     int nb_resets = mcdserver_state.resets->len;
     if (nb_resets == 1) {
         /* indicates this is the last packet */
-        g_string_printf(mcdserver_state.str_buf, "0!");
+        g_string_printf(mcdserver_state.str_buf, "0%s", QUERY_END_INDEX);
     } else {
-        g_string_printf(mcdserver_state.str_buf, "1!");
+        g_string_printf(mcdserver_state.str_buf, "1%s", QUERY_END_INDEX);
     }
     /* 2. send data */
     mcd_reset_st reset = g_array_index(mcdserver_state.resets, mcd_reset_st, 0);
@@ -1370,7 +1362,7 @@ void handle_query_reset_c(GArray *params, void *user_ctx)
     int nb_groups = mcdserver_state.resets->len;
     if (query_index + 1 == nb_groups) {
         /* indicates this is the last packet */
-        g_string_printf(mcdserver_state.str_buf, "0!");
+        g_string_printf(mcdserver_state.str_buf, "0%s", QUERY_END_INDEX);
     } else {
         g_string_printf(mcdserver_state.str_buf, "%u!", query_index + 1);
     }
@@ -1487,9 +1479,9 @@ void handle_query_mem_spaces_f(GArray *params, void *user_ctx)
     int nb_groups = memspaces->len;
     if (nb_groups == 1) {
         /* indicates this is the last packet */
-        g_string_printf(mcdserver_state.str_buf, "0!");
+        g_string_printf(mcdserver_state.str_buf, "0%s", QUERY_END_INDEX);
     } else {
-        g_string_printf(mcdserver_state.str_buf, "1!");
+        g_string_printf(mcdserver_state.str_buf, "1%s", QUERY_END_INDEX);
     }
 
     /* 3. send data */
@@ -1522,7 +1514,7 @@ void handle_query_mem_spaces_c(GArray *params, void *user_ctx)
     int nb_groups = memspaces->len;
     if (query_index + 1 == nb_groups) {
         /* indicates this is the last packet */
-        g_string_printf(mcdserver_state.str_buf, "0!");
+        g_string_printf(mcdserver_state.str_buf, "0%s", QUERY_END_INDEX);
     } else {
         g_string_printf(mcdserver_state.str_buf, "%u!", query_index + 1);
     }
@@ -1555,9 +1547,9 @@ void handle_query_reg_groups_f(GArray *params, void *user_ctx)
     int nb_groups = reggroups->len;
     if (nb_groups == 1) {
         /* indicates this is the last packet */
-        g_string_printf(mcdserver_state.str_buf, "0!");
+        g_string_printf(mcdserver_state.str_buf, "0%s", QUERY_END_INDEX);
     } else {
-        g_string_printf(mcdserver_state.str_buf, "1!");
+        g_string_printf(mcdserver_state.str_buf, "1%s", QUERY_END_INDEX);
     }
     /* 3. send data */
     mcd_reg_group_st group = g_array_index(reggroups, mcd_reg_group_st, 0);
@@ -1580,7 +1572,7 @@ void handle_query_reg_groups_c(GArray *params, void *user_ctx)
     int nb_groups = reggroups->len;
     if (query_index + 1 == nb_groups) {
         /* indicates this is the last packet */
-        g_string_printf(mcdserver_state.str_buf, "0!");
+        g_string_printf(mcdserver_state.str_buf, "0%s", QUERY_END_INDEX);
     } else {
         g_string_printf(mcdserver_state.str_buf, "%u!", query_index + 1);
     }
@@ -1604,9 +1596,9 @@ void handle_query_regs_f(GArray *params, void *user_ctx)
     int nb_regs = registers->len;
     if (nb_regs == 1) {
         /* indicates this is the last packet */
-        g_string_printf(mcdserver_state.str_buf, "0!");
+        g_string_printf(mcdserver_state.str_buf, "0%s", QUERY_END_INDEX);
     } else {
-        g_string_printf(mcdserver_state.str_buf, "1!");
+        g_string_printf(mcdserver_state.str_buf, "1%s", QUERY_END_INDEX);
     }
     /* 3. send data */
     mcd_reg_st my_register = g_array_index(registers, mcd_reg_st, 0);
@@ -1637,7 +1629,7 @@ void handle_query_regs_c(GArray *params, void *user_ctx)
     int nb_regs = registers->len;
     if (query_index + 1 == nb_regs) {
         /* indicates this is the last packet */
-        g_string_printf(mcdserver_state.str_buf, "0!");
+        g_string_printf(mcdserver_state.str_buf, "0%s", QUERY_END_INDEX);
     } else {
         g_string_printf(mcdserver_state.str_buf, "%u!", query_index + 1);
     }
@@ -1672,19 +1664,8 @@ void handle_query_state(GArray *params, void *user_ctx)
      * get state info
      */
     mcd_cpu_state_st state_info = mcdserver_state.cpu_state;
-    mcd_core_event_et event = MCD_CORE_EVENT_NONE;
-    if (state_info.memory_changed) {
-        event = event | MCD_CORE_EVENT_MEMORY_CHANGE;
-        state_info.memory_changed = false;
-    }
-    if (state_info.registers_changed) {
-        event = event | MCD_CORE_EVENT_REGISTER_CHANGE;
-        state_info.registers_changed = false;
-    }
-    if (state_info.target_was_stopped) {
-        event = event | MCD_CORE_EVENT_STOPPED;
-        state_info.target_was_stopped = false;
-    }
+    /* TODO: add event information */
+    uint32_t event = 0;
     /* send data */
     g_string_printf(mcdserver_state.str_buf,
         "%s=%s.%s=%u.%s=%u.%s=%u.%s=%lu.%s=%s.%s=%s.",
@@ -1863,7 +1844,7 @@ void handle_write_memory(GArray *params, void *user_ctx)
         mcd_put_packet(TCP_EXECUTION_ERROR);
         return;
     }
-    /* read memory */
+    /* write memory */
     mcd_hextomem(mcdserver_state.mem_buf, mcdserver_state.str_buf->str, len);
     if (mcd_write_memory(cpu, mem_address,
         mcdserver_state.mem_buf->data, len) != 0) {
@@ -1879,7 +1860,7 @@ int mcd_breakpoint_insert(CPUState *cpu, int type, vaddr addr)
     int bp_type = 0;
     CPUClass *cc = CPU_GET_CLASS(cpu);
     if (cc->gdb_stop_before_watchpoint) {
-        //bp_type |= BP_STOP_BEFORE_ACCESS;
+        /* bp_type |= BP_STOP_BEFORE_ACCESS; */
     }
     int return_value = 0;
     switch (type) {
@@ -1909,7 +1890,7 @@ int mcd_breakpoint_remove(CPUState *cpu, int type, vaddr addr)
     int bp_type = 0;
     CPUClass *cc = CPU_GET_CLASS(cpu);
     if (cc->gdb_stop_before_watchpoint) {
-        //bp_type |= BP_STOP_BEFORE_ACCESS;
+        /* bp_type |= BP_STOP_BEFORE_ACCESS; */
     }
     int return_value = 0;
     switch (type) {
diff --git a/mcdstub/mcdstub.h b/mcdstub/mcdstub.h
index d3f15da180..5412b59423 100644
--- a/mcdstub/mcdstub.h
+++ b/mcdstub/mcdstub.h
@@ -12,20 +12,6 @@
 #define MCD_TRIG_OPT_DATA_IS_CONDITION 0x00000008
 #define MCD_TRIG_ACTION_DBG_DEBUG 0x00000001
 
-typedef uint32_t mcd_core_event_et;
-/* TODO: replace mcd defines with custom layer */
-enum {
-    MCD_CORE_EVENT_NONE            = 0x00000000,
-    MCD_CORE_EVENT_MEMORY_CHANGE   = 0x00000001,
-    MCD_CORE_EVENT_REGISTER_CHANGE = 0x00000002,
-    MCD_CORE_EVENT_TRACE_CHANGE    = 0x00000004,
-    MCD_CORE_EVENT_TRIGGER_CHANGE  = 0x00000008,
-    MCD_CORE_EVENT_STOPPED         = 0x00000010,
-    MCD_CORE_EVENT_CHL_PENDING     = 0x00000020,
-    MCD_CORE_EVENT_CUSTOM_LO       = 0x00010000,
-    MCD_CORE_EVENT_CUSTOM_HI       = 0x40000000,
-};
-
 /* schema defines */
 #define ARG_SCHEMA_QRYHANDLE 'q'
 #define ARG_SCHEMA_STRING 's'
@@ -187,88 +173,649 @@ static inline int tohex(int v)
 void mcd_sigterm_handler(int signal);
 #endif
 
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
+ * This function adds the types of trigger, their possible options and actions
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
+ * Afterwards, it creates a new process with \ref mcd_create_default_process.
+ * @param[in] s A MCDState object.
+ */
 void create_processes(MCDState *s);
+/**
+ * \brief Creates a default process for debugging.
+ *
+ * This function creates a new, not yet attached, process with an ID one above
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
+ * returned. 
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
+ * 
+ * This function gets called by QEMU when a TCP packet is received.
+ * It iterates over that packet an calls \ref mcd_read_byte for each char
+ * of the packet.
+ * @param[in] buf Content of the packet.
+ * @param[in] size Length of the packet.
+ */
 void mcd_chr_receive(void *opaque, const uint8_t *buf, int size);
+/**
+ * \brief Handles a TCP client connect.
+ * 
+ * This function gets called by QEMU when a TCP cliet connects to the opened
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
+ * 
+ * This function is called when the QEMU VM goes through a state transition.
+ * It stores the runstate the CPU is in to the cpu_state and when in
+ * \c RUN_STATE_DEBUG it collects additional data on what watchpoint was hit.
+ * This function also resets the singlestep behavior.
+ * @param[in] running True if he VM is running.
+ * @param[in] state The new (and active) VM run state.
+ */
 void mcd_vm_state_change(void *opaque, bool running, RunState state);
+/**
+ * \brief Calls \ref mcd_put_packet_binary with buf and length of buf.
+ * 
+ * @param[in] buf TCP packet data.
+ */
 int mcd_put_packet(const char *buf);
-int mcd_put_packet_binary(const char *buf, int len, bool dump);
+/**
+ * \brief Adds footer and header to the TCP packet data in buf.
+ * 
+ * Besides adding header and footer, this function also stores the complete TCP
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
+ * 
+ * @param[in] buf TCP packet data.
+ * @param[in] len TCP packet length.
+ */
 void mcd_put_buffer(const uint8_t *buf, int len);
+/**
+ * \brief Returns the process of the provided CPU.
+ * 
+ * @param[in] cpu The CPU state.
+ */
 MCDProcess *mcd_get_cpu_process(CPUState *cpu);
+/**
+ * \brief Returns the process ID of the provided CPU.
+ * 
+ * @param[in] cpu The CPU state.
+ */
 uint32_t mcd_get_cpu_pid(CPUState *cpu);
+/**
+ * \brief Returns the process of the provided pid.
+ * 
+ * @param[in] pid The process ID.
+ */
 MCDProcess *mcd_get_process(uint32_t pid);
+/**
+ * \brief Returns the first CPU with an attached process.
+ */
 CPUState *mcd_first_attached_cpu(void);
+/**
+ * \brief Returns the first CPU with an attached process starting after the 
+ * provided cpu.
+ * 
+ * @param[in] cpu The CPU to start from.
+ */
 CPUState *mcd_next_attached_cpu(CPUState *cpu);
+/**
+ * \brief Resends the last packet if not acknowledged and extracts the data
+ * from a received TCP packet.
+ * 
+ * In case the last sent packet was not acknowledged from the mcdstub,
+ * this function resends it.
+ * If it was acknowledged this function parses the incoming packet
+ * byte by byte.
+ * It extracts the data in the packet and sends an
+ * acknowledging response when finished. Then \ref mcd_handle_packet gets
+ * called.
+ * @param[in] ch Character of the received TCP packet, which should be parsed.
+ */
 void mcd_read_byte(uint8_t ch);
+/**
+ * \brief Evaluates the type of received packet and chooses the correct handler.
+ * 
+ * This function takes the first character of the line_buf to determine the
+ * type of packet. Then it selects the correct handler function and parameter
+ * schema. With this info it calls \ref run_cmd_parser.
+ * @param[in] line_buf TCP packet data.
+ */
 int mcd_handle_packet(const char *line_buf);
+/**
+ * \brief Calls \ref mcd_put_packet with the str_buf of the mcdserver_state.
+ */
 void mcd_put_strbuf(void);
+/**
+ * \brief Terminates QEMU.
+ * 
+ * If the mcdserver_state has not been initialized the function exits before
+ * terminating QEMU. Terminting is done with the qemu_chr_fe_deinit function.
+ * @param[in] code An exitcode, which can be used in the future.
+ */
 void mcd_exit(int code);
+/**
+ * \brief Prepares the mcdserver_state before executing TCP packet functions.
+ * 
+ * This function empties the str_buf and mem_buf of the mcdserver_state and
+ * then calls \ref process_string_cmd. In case this function fails, an empty
+ * TCP packet is sent back the MCD Shared Library.
+ * @param[in] data TCP packet data.
+ * @param[in] cmd Handler function (can be an array of functions).
+ */
 void run_cmd_parser(const char *data, const MCDCmdParseEntry *cmd);
+/**
+ * \brief Collects all parameters from the data and calls the correct handler.
+ * 
+ * The parameters are extracted with the \ref cmd_parse_params function.
+ * This function selects the command in the cmds array, which fits the start of
+ * the data string. This way the correct commands is selected.
+ * @param[in] data TCP packet data.
+ * @param[in] cmds Array of possible commands.
+ * @param[in] num_cmds Number of commands in the cmds array.
+ */
 int process_string_cmd(void *user_ctx, const char *data,
     const MCDCmdParseEntry *cmds, int num_cmds);
+/**
+ * \brief Extracts all parameters from a TCP packet.
+ * 
+ * This function uses the schema parameter to determine which type of parameter
+ * to expect. It then extracts that parameter from the data and stores it in
+ * the params GArray.
+ * @param[in] data TCP packet data.
+ * @param[in] schema List of expected parameters for the packet.
+ * @param[out] params GArray with all extracted parameters.
+ */
 int cmd_parse_params(const char *data, const char *schema, GArray *params);
+/**
+ * \brief Handler for the VM start TCP packet.
+ * 
+ * Evaluates whether all cores or just a perticular core should get started and
+ * calls \ref mcd_vm_start or \ref mcd_cpu_start respectively.
+ * @param[in] params GArray with all TCP packet parameters.
+ */
 void handle_vm_start(GArray *params, void *user_ctx);
+/**
+ * \brief Handler for the VM step TCP packet.
+ * 
+ * Calls \ref mcd_cpu_sstep for the CPU which sould be stepped. Stepping all
+ * CPUs is currently not supported.
+ * @param[in] params GArray with all TCP packet parameters.
+ */
 void handle_vm_step(GArray *params, void *user_ctx);
+/**
+ * \brief Handler for the VM stop TCP packet.
+ * 
+ * Always calls \ref mcd_vm_stop and stops all cores. Stopping individual cores
+ * is currently not supported
+ * @param[in] params GArray with all TCP packet parameters.
+ */
 void handle_vm_stop(GArray *params, void *user_ctx);
+/**
+ * \brief Handler for all TCP query packets.
+ * 
+ * Calls \ref process_string_cmd with all query functions in the
+ * mcd_query_cmds_table. \ref process_string_cmd then selects the correct one.
+ * This function just passes on the TCP packet data string from the parameters.
+ * @param[in] params GArray with all TCP packet parameters.
+ */
 void handle_gen_query(GArray *params, void *user_ctx);
+/**
+ * \brief Returns the internal CPU index plus one.
+ * 
+ * @param[in] cpu CPU of interest.
+ */
 int mcd_get_cpu_index(CPUState *cpu);
-CPUState *mcd_get_cpu(uint32_t i_cpu_index);
+/**
+ * \brief Returns the CPU the index i_cpu_index.
+ * 
+ * @param[in] cpu_index Index of the desired CPU.
+ */
+CPUState *mcd_get_cpu(uint32_t cpu_index);
+/**
+ * \brief Handler for the core query.
+ * 
+ * This function sends the type of core and number of cores currently
+ * simulated by QEMU. It also sends a device name for the MCD data structure.
+ * @param[in] params GArray with all TCP packet parameters.
+ */
 void handle_query_cores(GArray *params, void *user_ctx);
+/**
+ * \brief Handler for the system query.
+ * 
+ * Sends the system name, which is "qemu-system".
+ * @param[in] params GArray with all TCP packet parameters.
+ */
 void handle_query_system(GArray *params, void *user_ctx);
+/**
+ * \brief Returns the first CPU in the provided process.
+ * 
+ * @param[in] process The process to look in.
+ */
 CPUState *get_first_cpu_in_process(MCDProcess *process);
+/**
+ * \brief Returns the CPU with an index equal to the thread_id.
+ * 
+ * @param[in] thread_id ID of the desired CPU.
+ */
 CPUState *find_cpu(uint32_t thread_id);
+/**
+ * \brief Handler for opening a core.
+ * 
+ * This function initializes all data for the core with the ID provided in
+ * the first parameter. In has a swtich case for different architectures.
+ * Currently only 32-Bit ARM is supported. The data includes memory spaces,
+ * register groups and registers themselves. They get stored into GLists where
+ * every entry in the list corresponds to one opened core.
+ * @param[in] params GArray with all TCP packet parameters.
+ */
 void handle_open_core(GArray *params, void *user_ctx);
+/**
+ * \brief Handler for the first reset query.
+ * 
+ * This function sends the first reset name and ID.
+ * @param[in] params GArray with all TCP packet parameters.
+ */
 void handle_query_reset_f(GArray *params, void *user_ctx);
+/**
+ * \brief Handler for all consecutive reset queries.
+ * 
+ * This functions sends all consecutive reset names and IDs. It uses the
+ * query_index parameter to determine which reset is queried next.
+ * @param[in] params GArray with all TCP packet parameters.
+ */
 void handle_query_reset_c(GArray *params, void *user_ctx);
+/**
+ * \brief Handler for closing the MCD server.
+ * 
+ * This function detaches the debugger (process) and frees up memory.
+ * Then it start the QEMU VM with \ref mcd_vm_start.
+ * @param[in] params GArray with all TCP packet parameters.
+ */
 void handle_close_server(GArray *params, void *user_ctx);
+/**
+ * \brief Handler for closing a core.
+ * 
+ * Frees all memory allocated for core specific information. This includes
+ * memory spaces, register groups and registers.
+ * @param[in] params GArray with all TCP packet parameters.
+ */
 void handle_close_core(GArray *params, void *user_ctx);
+/**
+ * \brief Handler for trigger query.
+ * 
+ * Sends data on the different types of trigger and their options and actions.
+ * @param[in] params GArray with all TCP packet parameters.
+ */
 void handle_query_trigger(GArray *params, void *user_ctx);
+/**
+ * \brief Starts all CPUs with the vm_start function.
+ */
 void mcd_vm_start(void);
+/**
+ * \brief Starts the selected CPU with the cpu_resume function.
+ * 
+ * @param[in] cpu The CPU about to be started.
+ */
 void mcd_cpu_start(CPUState *cpu);
+/**
+ * \brief Performes a step on the selected CPU.
+ * 
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
+ * 
+ * This function sends the first register group name and ID.
+ * @param[in] params GArray with all TCP packet parameters.
+ */
 void handle_query_reg_groups_f(GArray *params, void *user_ctx);
+/**
+ * \brief Handler for all consecutive register group queries.
+ * 
+ * This function sends all consecutive register group names and IDs. It uses
+ * the query_index parameter to determine which register group is queried next.
+ * @param[in] params GArray with all TCP packet parameters.
+ */
 void handle_query_reg_groups_c(GArray *params, void *user_ctx);
+/**
+ * \brief Handler for the first memory space query.
+ * 
+ * This function sends the first memory space name, ID, type and accessing
+ * options.
+ * @param[in] params GArray with all TCP packet parameters.
+ */
 void handle_query_mem_spaces_f(GArray *params, void *user_ctx);
+/**
+ * \brief Handler for all consecutive memory space queries.
+ * 
+ * This function sends all consecutive memory space names, IDs, types and
+ * accessing options.
+ * It uses the query_index parameter to determine
+ * which memory space is queried next.
+ * @param[in] params GArray with all TCP packet parameters.
+ */
 void handle_query_mem_spaces_c(GArray *params, void *user_ctx);
+/**
+ * \brief Handler for the first register query.
+ * 
+ * This function sends the first register with all its information.
+ * @param[in] params GArray with all TCP packet parameters.
+ */
 void handle_query_regs_f(GArray *params, void *user_ctx);
+/**
+ * \brief Handler for all consecutive register queries.
+ * 
+ * This function sends all consecutive registers with all their information.
+ * It uses the query_index parameter to determine
+ * which register is queried next.
+ * @param[in] params GArray with all TCP packet parameters.
+ */
 void handle_query_regs_c(GArray *params, void *user_ctx);
+/**
+ * \brief Handler for opening the MCD server.
+ * 
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
+ * 
+ * This function is currently not in use.
+ * @param[in] params GArray with all TCP packet parameters.
+ */
 void handle_reset(GArray *params, void *user_ctx);
+/**
+ * \brief Handler for the state query.
+ * 
+ * This function collects all data stored in the
+ * cpu_state member of the mcdserver_state and formats and sends it to the
+ * library.
+ * @param[in] params GArray with all TCP packet parameters.
+ */
 void handle_query_state(GArray *params, void *user_ctx);
+/**
+ * \brief Handler for reading a register.
+ * 
+ * This function calls \ref mcd_read_register to read a register. The register
+ * data gets stored in the mem_buf byte array. The data then gets converted
+ * into a hex string with \ref mcd_memtohex and then send.
+ * @param[in] params GArray with all TCP packet parameters.
+ */
 void handle_read_register(GArray *params, void *user_ctx);
+/**
+ * \brief Handler for writing a register.
+ * 
+ * This function converts the incoming hex string data into a byte array with
+ * \ref mcd_hextomem. Then it calls \ref mcd_write_register to write to the
+ * register.
+ * @param[in] params GArray with all TCP packet parameters.
+ */
 void handle_write_register(GArray *params, void *user_ctx);
+/**
+ * \brief Handler for reading memory.
+ * 
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
+ * 
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
+ * 
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
+ * 
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
+ * 
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
+ * 
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
+ * 
+ * This function extracts the CPU, breakpoint type and address from the
+ * parameters and calls \ref mcd_breakpoint_insert to insert the breakpoint.
+ * @param[in] params GArray with all TCP packet parameters.
+ */
 void handle_breakpoint_insert(GArray *params, void *user_ctx);
+/**
+ * \brief Handler for inserting a break- or watchpoint.
+ * 
+ * This function extracts the CPU, breakpoint type and address from the
+ * parameters and calls \ref mcd_breakpoint_remove to insert the breakpoint.
+ * @param[in] params GArray with all TCP packet parameters.
+ */
 void handle_breakpoint_remove(GArray *params, void *user_ctx);
+/**
+ * \brief Inserts a break- or watchpoint.
+ * 
+ * This function evaluates the received breakpoint type and translates it
+ * to a known GDB breakpoint type.
+ * Then it calls cpu_breakpoint_insert or cpu_watchpoint_insert depending on
+ * the type.
+ * @param[in] cpu CPU to which the breakpoint should be added.
+ * @param[in] addr Address of the breakpoint.
+ * @param[in] type Breakpoint type.
+ */
 int mcd_breakpoint_insert(CPUState *cpu, int type, vaddr addr);
+/**
+ * \brief Removes a break- or watchpoint.
+ * 
+ * This function evaluates the received breakpoint type and translates it
+ * to a known GDB breakpoint type.
+ * Then it calls cpu_breakpoint_remove or cpu_watchpoint_remove depending on
+ * the type.
+ * @param[in] cpu CPU from which the breakpoint should be removed.
+ * @param[in] addr Address of the breakpoint.
+ * @param[in] type Breakpoint type.
+ */
 int mcd_breakpoint_remove(CPUState *cpu, int type, vaddr addr);
 
+/** @} */
+
 /* sycall handling */
 void mcd_syscall_reset(void);
 void mcd_disable_syscalls(void);
 
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
 
+/**
+ * \addtogroup mcdstub
+ * @{
+ */
+
+/**
+ * \brief Parses a GDB register XML file.
+ *
+ * This fuction extracts all registers from the provided xml file and stores
+ * them into the registers GArray. It extracts the register name, bitsize, type
+ * and group if they are set.
+ * @param[in] xml String with contents of the XML file.
+ * @param[out] registers GArray with stored registers.
+ * @param[in] reg_type Register type (depending on file).
+ * @param[in] size Number of characters in the xml string.
+ */
 void parse_reg_xml(const char *xml, int size, GArray* registers,
     uint8_t reg_type);
 
+/** @} */
+
 #endif /* MCDSTUB_COMMON_H */
diff --git a/target/arm/mcdstub.c b/target/arm/mcdstub.c
index d2a83a3cd9..6c98c34673 100644
--- a/target/arm/mcdstub.c
+++ b/target/arm/mcdstub.c
@@ -350,11 +350,6 @@ int arm_mcd_store_mem_spaces(CPUState *cpu, GArray *memspaces)
     int nr_address_spaces = cpu->num_ases;
     uint32_t mem_space_id = 0;
 
-    /*
-     * TODO: atm we can only access physical memory addresses,
-     * but trace32 needs fake locical spaces to work with
-    */
-
     mem_space_id++;
     mcd_mem_space_st non_secure = {
         .name = "Non Secure",
@@ -413,7 +408,6 @@ int arm_mcd_store_mem_spaces(CPUState *cpu, GArray *memspaces)
         };
         g_array_append_vals(memspaces, (gconstpointer)&phys_secure, 1);
     }
-    /* TODO: get dynamically how the per (CP15) space is called */
     mem_space_id++;
     mcd_mem_space_st gpr = {
         .name = "GPR Registers",
diff --git a/target/arm/mcdstub.h b/target/arm/mcdstub.h
index 1321d5dc07..daba7a04d7 100644
--- a/target/arm/mcdstub.h
+++ b/target/arm/mcdstub.h
@@ -25,19 +25,124 @@ enum {
     MCD_ARM_REG_TYPE_CPR,
 };
 
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
+ * 
+ * @param[in] xmlname Name of the desired XML file.
+ * @param[in] cs CPU state.
+ */
 const char *arm_mcd_get_dynamic_xml(CPUState *cs, const char *xmlname);
+/**
+ * \brief Calls the correct read function which writes data into the mem_buf.
+ * 
+ * Depending on the reg_type of the register one of the following functions
+ * will get called: arm_mcd_read_gpr_register, arm_mcd_read_vfp_register,
+ * arm_mcd_read_vfp_sys_register, arm_mcd_read_mve_register and
+ * arm_mcd_read_cpr_register. In those the data of the requested register will
+ * be stored as byte array into mem_buf. The function returns zero if no bytes
+ * were written
+ * @param[out] mem_buf Byte array for register data.
+ * @param[in] reg_type Type of register.
+ * @param[in] n The register ID within its type.
+ * @param[in] cs CPU state.
+ */
 int arm_mcd_read_register(CPUState *cs, GByteArray *mem_buf, uint8_t reg_type,
     uint32_t n);
+/**
+ * \brief Calls the correct write function which writes data from the mem_buf.
+ * 
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
 int arm_mcd_write_register(CPUState *cs, GByteArray *mem_buf, uint8_t reg_type,
     uint32_t n);
+/**
+ * \brief Returns the opcode for a coprocessor register.
+ * 
+ * This function uses the opc1, opc2, crm and crn members of the register to
+ * create the opcode. The formular for creating the opcode is determined by ARM.
+ * @param[in] n The register ID of the CP register.
+ * @param[in] cs CPU state.
+ */
 uint16_t arm_mcd_get_opcode(CPUState *cs, uint32_t n);
+/**
+ * \brief Sets the scr_el3 register according to the secure parameter.
+ * 
+ * If secure is true, the first bit of the scr_el3 register gets set to 0,
+ * if not it gets set to 1.
+ * @param[in] secure True when secure is requested.
+ * @param[in] cs CPU state.
+ */
 int arm_mcd_set_scr(CPUState *cs, bool secure);
+/**
+ * \brief Stores all 32-Bit ARM specific memory spaces.
+ * 
+ * This function stores the memory spaces into the memspaces GArray.
+ * It only stores secure memory spaces if the CPU has more than one address
+ * space. It also stores a GPR and a CP15 register memory space.
+ * @param[out] memspaces GArray of memory spaces.
+ * @param[in] cpu CPU state.
+ */
 int arm_mcd_store_mem_spaces(CPUState *cpu, GArray *memspaces);
+/**
+ * \brief Parses the GPR registers.
+ * 
+ * This function parses the core XML file, which includes the GPR registers.
+ * The regsters get stored in a GArray and a GPR register group is stored in a
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
+ * 
+ * This function parses all XML files except for the core XML file.
+ * The regsters get stored in a GArray and if the system-registers.xml file is
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
+ * 
+ * This function is called, after \ref arm_mcd_parse_core_xml_file and
+ * \ref arm_mcd_parse_core_xml_file. It adds additional data for all already
+ * parsed registers. The registers get a correct ID, group, memory space and
+ * opcode, if they are CP15 registers.
+ * @param[in] reggroups GArray of register groups.
+ * @param[in,out] registers GArray of registers.
+ * @param[in] cpu The CPU state.
+ */
 int arm_mcd_get_additional_register_info(GArray *reggroups, GArray *registers,
     CPUState *cpu);
 
+/** @} */
+
 #endif /* ARM_MCDSTUB_H */
-- 
2.34.1


