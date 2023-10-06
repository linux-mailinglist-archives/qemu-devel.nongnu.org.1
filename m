Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD65A7BB3E9
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 11:08:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qognz-0001Jz-MB; Fri, 06 Oct 2023 05:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qognq-0000Vi-Bz
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:07:23 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qognk-00015P-OJ
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:07:22 -0400
Received: (qmail 20108 invoked by uid 484); 6 Oct 2023 09:07:03 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.215779 secs); 06 Oct 2023 09:07:03 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP for <qemu-devel@nongnu.org>; 6 Oct 2023 09:07:02 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Christian.Boenig@lauterbach.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicolas Eder <nicolas.eder@lauterbach.com>
Subject: [PATCH v2 29/29] introducing the DebugClass. It is used to abstract
 the gdb/mcd set_stop_cpu function.
Date: Fri,  6 Oct 2023 11:06:10 +0200
Message-Id: <20231006090610.26171-30-nicolas.eder@lauterbach.com>
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
+static const TypeInfo debug_info = {
+    .name = TYPE_DEBUG,
+    .parent = TYPE_OBJECT,
+    .instance_size = sizeof(DebugState),
+    .instance_init = debug_instance_init,
+    .instance_finalize = debug_finalize,
+    .class_size = sizeof(DebugClass),
+    .class_init = debug_class_init
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
+    obj = object_new(TYPE_DEBUG);
+    DebugState *ds = DEBUG(obj);
+    DebugClass *dc = DEBUG_GET_CLASS(ds);
+    dc->set_stop_cpu = gdb_set_stop_cpu;
+    MachineState *ms = MACHINE(qdev_get_machine());
+    ms->debug_state = ds;
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
+    obj = object_new(TYPE_DEBUG);
+    DebugState *ds = DEBUG(obj);
+    DebugClass *dc = DEBUG_GET_CLASS(ds);
+    dc->set_stop_cpu = mcd_set_stop_cpu;
+    MachineState *ms = MACHINE(qdev_get_machine());
+    ms->debug_state = ds;
+}
diff --git a/gdbstub/meson.build b/gdbstub/meson.build
index a5a1f4e433..e4ee9e5035 100644
--- a/gdbstub/meson.build
+++ b/gdbstub/meson.build
@@ -11,8 +11,8 @@ gdb_user_ss = ss.source_set()
 gdb_system_ss = ss.source_set()
 
 # We build two versions of gdbstub, one for each mode
-gdb_user_ss.add(files('gdbstub.c', 'user.c'))
-gdb_system_ss.add(files('gdbstub.c', 'softmmu.c'))
+gdb_user_ss.add(files('gdbstub.c', 'user.c', '../debug/debug-gdb.c'))
+gdb_system_ss.add(files('gdbstub.c', 'softmmu.c', '../debug/debug-gdb.c'))
 
 gdb_user_ss = gdb_user_ss.apply(config_targetos, strict: false)
 gdb_system_ss = gdb_system_ss.apply(config_targetos, strict: false)
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
     gdbserver_system_state.mon_chr = mon_chr;
     gdb_syscall_reset();
 
+    /* create new debug object */
+    gdb_init_debug_class();
+
     return 0;
 }
 
diff --git a/gdbstub/user.c b/gdbstub/user.c
index 7ab6e5d975..ecffc354b1 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -326,8 +326,10 @@ int gdbserver_start(const char *port_or_path)
     }
 
     if (port > 0 && gdb_accept_tcp(gdb_fd)) {
+        gdb_init_debug_class();
         return 0;
     } else if (gdb_accept_socket(gdb_fd)) {
+        gdb_init_debug_class();
         gdbserver_user_state.socket_path = g_strdup(port_or_path);
         return 0;
     }
diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 16a139043f..d0d4feebef 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -51,4 +51,9 @@ bool gdb_has_xml(void);
 /* in gdbstub-xml.c, generated by scripts/feature_to_c.sh */
 extern const char *const xml_builtin[][2];
 
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
 
 #define DEFINE_MACHINE(namestr, machine_initfn) \
diff --git a/include/mcdstub/arm_mcdstub.h b/include/mcdstub/arm_mcdstub.h
index 3db271150a..93bf71e133 100644
--- a/include/mcdstub/arm_mcdstub.h
+++ b/include/mcdstub/arm_mcdstub.h
@@ -37,14 +37,14 @@ enum {
 
 /**
  * \brief Returns the contents of the desired XML file.
- * 
+ *
  * @param[in] xmlname Name of the desired XML file.
  * @param[in] cs CPU state.
  */
 const char *arm_mcd_get_dynamic_xml(CPUState *cs, const char *xmlname);
 /**
  * \brief Calls the correct read function which writes data into the mem_buf.
- * 
+ *
  * Depending on the reg_type of the register one of the following functions
  * will get called: arm_mcd_read_gpr_register, arm_mcd_read_vfp_register,
  * arm_mcd_read_vfp_sys_register, arm_mcd_read_mve_register and
@@ -60,7 +60,7 @@ int arm_mcd_read_register(CPUState *cs, GByteArray *mem_buf, uint8_t reg_type,
     uint32_t n);
 /**
  * \brief Calls the correct write function which writes data from the mem_buf.
- * 
+ *
  * Depending on the reg_type of the register one of the following functions
  * will get called: arm_mcd_write_gpr_register, arm_mcd_write_vfp_register,
  * arm_mcd_write_vfp_sys_register, arm_mcd_write_mve_register and
@@ -75,25 +75,16 @@ int arm_mcd_write_register(CPUState *cs, GByteArray *mem_buf, uint8_t reg_type,
     uint32_t n);
 /**
  * \brief Returns the opcode for a coprocessor register.
- * 
+ *
  * This function uses the opc1, opc2, crm and crn members of the register to
  * create the opcode. The formular for creating the opcode is determined by ARM.
  * @param[in] n The register ID of the CP register.
  * @param[in] cs CPU state.
  */
 uint16_t arm_mcd_get_opcode(CPUState *cs, uint32_t n);
-/**
- * \brief Sets the scr_el3 register according to the secure parameter.
- * 
- * If secure is true, the first bit of the scr_el3 register gets set to 0,
- * if not it gets set to 1.
- * @param[in] secure True when secure is requested.
- * @param[in] cs CPU state.
- */
-int arm_mcd_set_scr(CPUState *cs, bool secure);
 /**
  * \brief Stores all 32-Bit ARM specific memory spaces.
- * 
+ *
  * This function stores the memory spaces into the memspaces GArray.
  * It only stores secure memory spaces if the CPU has more than one address
  * space. It also stores a GPR and a CP15 register memory space.
@@ -103,7 +94,7 @@ int arm_mcd_set_scr(CPUState *cs, bool secure);
 int arm_mcd_store_mem_spaces(CPUState *cpu, GArray *memspaces);
 /**
  * \brief Parses the GPR registers.
- * 
+ *
  * This function parses the core XML file, which includes the GPR registers.
  * The regsters get stored in a GArray and a GPR register group is stored in a
  * second GArray.
@@ -117,7 +108,7 @@ int arm_mcd_parse_core_xml_file(CPUClass *cc, GArray *reggroups,
     GArray *registers, int *current_group_id);
 /**
  * \brief Parses all but the GPR registers.
- * 
+ *
  * This function parses all XML files except for the core XML file.
  * The regsters get stored in a GArray and if the system-registers.xml file is
  * parsed, it also adds a CP15 register group.
@@ -131,7 +122,7 @@ int arm_mcd_parse_general_xml_files(CPUState *cpu, GArray* reggroups,
     GArray *registers, int *current_group_id);
 /**
  * \brief Adds additional data to parsed registers.
- * 
+ *
  * This function is called, after \ref arm_mcd_parse_core_xml_file and
  * \ref arm_mcd_parse_core_xml_file. It adds additional data for all already
  * parsed registers. The registers get a correct ID, group, memory space and
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
- * returned. 
+ * returned.
  * @param[in] a Process a.
  * @param[in] b Process b.
  */
@@ -262,7 +266,7 @@ int pid_order(const void *a, const void *b);
 int mcd_chr_can_receive(void *opaque);
 /**
  * \brief Handles receiving a TCP packet.
- * 
+ *
  * This function gets called by QEMU when a TCP packet is received.
  * It iterates over that packet an calls \ref mcd_read_byte for each char
  * of the packet.
@@ -272,7 +276,7 @@ int mcd_chr_can_receive(void *opaque);
 void mcd_chr_receive(void *opaque, const uint8_t *buf, int size);
 /**
  * \brief Handles a TCP client connect.
- * 
+ *
  * This function gets called by QEMU when a TCP cliet connects to the opened
  * TCP port. It attaches the first process. From here on TCP packets can be
  * exchanged.
@@ -285,7 +289,7 @@ void mcd_chr_event(void *opaque, QEMUChrEvent event);
 bool mcd_supports_guest_debug(void);
 /**
  * \brief Handles a state change of the QEMU VM.
- * 
+ *
  * This function is called when the QEMU VM goes through a state transition.
  * It stores the runstate the CPU is in to the cpu_state and when in
  * \c RUN_STATE_DEBUG it collects additional data on what watchpoint was hit.
@@ -296,13 +300,13 @@ bool mcd_supports_guest_debug(void);
 void mcd_vm_state_change(void *opaque, bool running, RunState state);
 /**
  * \brief Calls \ref mcd_put_packet_binary with buf and length of buf.
- * 
+ *
  * @param[in] buf TCP packet data.
  */
 int mcd_put_packet(const char *buf);
 /**
  * \brief Adds footer and header to the TCP packet data in buf.
- * 
+ *
  * Besides adding header and footer, this function also stores the complete TCP
  * packet in the last_packet member of the mcdserver_state. Then the packet
  * gets send with the \ref mcd_put_buffer function.
@@ -316,26 +320,30 @@ int mcd_put_packet_binary(const char *buf, int len);
 bool mcd_got_immediate_ack(void);
 /**
  * \brief Sends the buf as TCP packet with qemu_chr_fe_write_all.
- * 
+ *
  * @param[in] buf TCP packet data.
  * @param[in] len TCP packet length.
  */
 void mcd_put_buffer(const uint8_t *buf, int len);
 /**
  * \brief Returns the process of the provided CPU.
- * 
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
- * 
+ *
  * @param[in] cpu The CPU state.
  */
 uint32_t mcd_get_cpu_pid(CPUState *cpu);
 /**
  * \brief Returns the process of the provided pid.
- * 
+ *
  * @param[in] pid The process ID.
  */
 MCDProcess *mcd_get_process(uint32_t pid);
@@ -344,16 +352,16 @@ MCDProcess *mcd_get_process(uint32_t pid);
  */
 CPUState *mcd_first_attached_cpu(void);
 /**
- * \brief Returns the first CPU with an attached process starting after the 
+ * \brief Returns the first CPU with an attached process starting after the
  * provided cpu.
- * 
+ *
  * @param[in] cpu The CPU to start from.
  */
 CPUState *mcd_next_attached_cpu(CPUState *cpu);
 /**
  * \brief Resends the last packet if not acknowledged and extracts the data
  * from a received TCP packet.
- * 
+ *
  * In case the last sent packet was not acknowledged from the mcdstub,
  * this function resends it.
  * If it was acknowledged this function parses the incoming packet
@@ -366,7 +374,7 @@ CPUState *mcd_next_attached_cpu(CPUState *cpu);
 void mcd_read_byte(uint8_t ch);
 /**
  * \brief Evaluates the type of received packet and chooses the correct handler.
- * 
+ *
  * This function takes the first character of the line_buf to determine the
  * type of packet. Then it selects the correct handler function and parameter
  * schema. With this info it calls \ref run_cmd_parser.
@@ -379,7 +387,7 @@ int mcd_handle_packet(const char *line_buf);
 void mcd_put_strbuf(void);
 /**
  * \brief Terminates QEMU.
- * 
+ *
  * If the mcdserver_state has not been initialized the function exits before
  * terminating QEMU. Terminting is done with the qemu_chr_fe_deinit function.
  * @param[in] code An exitcode, which can be used in the future.
@@ -387,7 +395,7 @@ void mcd_put_strbuf(void);
 void mcd_exit(int code);
 /**
  * \brief Prepares the mcdserver_state before executing TCP packet functions.
- * 
+ *
  * This function empties the str_buf and mem_buf of the mcdserver_state and
  * then calls \ref process_string_cmd. In case this function fails, an empty
  * TCP packet is sent back the MCD Shared Library.
@@ -397,7 +405,7 @@ void mcd_exit(int code);
 void run_cmd_parser(const char *data, const MCDCmdParseEntry *cmd);
 /**
  * \brief Collects all parameters from the data and calls the correct handler.
- * 
+ *
  * The parameters are extracted with the \ref cmd_parse_params function.
  * This function selects the command in the cmds array, which fits the start of
  * the data string. This way the correct commands is selected.
@@ -409,7 +417,7 @@ int process_string_cmd(void *user_ctx, const char *data,
     const MCDCmdParseEntry *cmds, int num_cmds);
 /**
  * \brief Extracts all parameters from a TCP packet.
- * 
+ *
  * This function uses the schema parameter to determine which type of parameter
  * to expect. It then extracts that parameter from the data and stores it in
  * the params GArray.
@@ -420,7 +428,7 @@ int process_string_cmd(void *user_ctx, const char *data,
 int cmd_parse_params(const char *data, const char *schema, GArray *params);
 /**
  * \brief Handler for the VM start TCP packet.
- * 
+ *
  * Evaluates whether all cores or just a perticular core should get started and
  * calls \ref mcd_vm_start or \ref mcd_cpu_start respectively.
  * @param[in] params GArray with all TCP packet parameters.
@@ -428,7 +436,7 @@ int cmd_parse_params(const char *data, const char *schema, GArray *params);
 void handle_vm_start(GArray *params, void *user_ctx);
 /**
  * \brief Handler for the VM step TCP packet.
- * 
+ *
  * Calls \ref mcd_cpu_sstep for the CPU which sould be stepped. Stepping all
  * CPUs is currently not supported.
  * @param[in] params GArray with all TCP packet parameters.
@@ -436,7 +444,7 @@ void handle_vm_start(GArray *params, void *user_ctx);
 void handle_vm_step(GArray *params, void *user_ctx);
 /**
  * \brief Handler for the VM stop TCP packet.
- * 
+ *
  * Always calls \ref mcd_vm_stop and stops all cores. Stopping individual cores
  * is currently not supported
  * @param[in] params GArray with all TCP packet parameters.
@@ -444,7 +452,7 @@ void handle_vm_step(GArray *params, void *user_ctx);
 void handle_vm_stop(GArray *params, void *user_ctx);
 /**
  * \brief Handler for all TCP query packets.
- * 
+ *
  * Calls \ref process_string_cmd with all query functions in the
  * mcd_query_cmds_table. \ref process_string_cmd then selects the correct one.
  * This function just passes on the TCP packet data string from the parameters.
@@ -453,19 +461,19 @@ void handle_vm_stop(GArray *params, void *user_ctx);
 void handle_gen_query(GArray *params, void *user_ctx);
 /**
  * \brief Returns the internal CPU index plus one.
- * 
+ *
  * @param[in] cpu CPU of interest.
  */
 int mcd_get_cpu_index(CPUState *cpu);
 /**
  * \brief Returns the CPU the index i_cpu_index.
- * 
+ *
  * @param[in] cpu_index Index of the desired CPU.
  */
 CPUState *mcd_get_cpu(uint32_t cpu_index);
 /**
  * \brief Handler for the core query.
- * 
+ *
  * This function sends the type of core and number of cores currently
  * simulated by QEMU. It also sends a device name for the MCD data structure.
  * @param[in] params GArray with all TCP packet parameters.
@@ -473,26 +481,26 @@ CPUState *mcd_get_cpu(uint32_t cpu_index);
 void handle_query_cores(GArray *params, void *user_ctx);
 /**
  * \brief Handler for the system query.
- * 
+ *
  * Sends the system name, which is "qemu-system".
  * @param[in] params GArray with all TCP packet parameters.
  */
 void handle_query_system(GArray *params, void *user_ctx);
 /**
  * \brief Returns the first CPU in the provided process.
- * 
+ *
  * @param[in] process The process to look in.
  */
 CPUState *get_first_cpu_in_process(MCDProcess *process);
 /**
  * \brief Returns the CPU with an index equal to the thread_id.
- * 
+ *
  * @param[in] thread_id ID of the desired CPU.
  */
 CPUState *find_cpu(uint32_t thread_id);
 /**
  * \brief Handler for opening a core.
- * 
+ *
  * This function initializes all data for the core with the ID provided in
  * the first parameter. In has a swtich case for different architectures.
  * Currently only 32-Bit ARM is supported. The data includes memory spaces,
@@ -503,14 +511,14 @@ CPUState *find_cpu(uint32_t thread_id);
 void handle_open_core(GArray *params, void *user_ctx);
 /**
  * \brief Handler for the first reset query.
- * 
+ *
  * This function sends the first reset name and ID.
  * @param[in] params GArray with all TCP packet parameters.
  */
 void handle_query_reset_f(GArray *params, void *user_ctx);
 /**
  * \brief Handler for all consecutive reset queries.
- * 
+ *
  * This functions sends all consecutive reset names and IDs. It uses the
  * query_index parameter to determine which reset is queried next.
  * @param[in] params GArray with all TCP packet parameters.
@@ -518,7 +526,7 @@ void handle_query_reset_f(GArray *params, void *user_ctx);
 void handle_query_reset_c(GArray *params, void *user_ctx);
 /**
  * \brief Handler for closing the MCD server.
- * 
+ *
  * This function detaches the debugger (process) and frees up memory.
  * Then it start the QEMU VM with \ref mcd_vm_start.
  * @param[in] params GArray with all TCP packet parameters.
@@ -526,7 +534,7 @@ void handle_query_reset_c(GArray *params, void *user_ctx);
 void handle_close_server(GArray *params, void *user_ctx);
 /**
  * \brief Handler for closing a core.
- * 
+ *
  * Frees all memory allocated for core specific information. This includes
  * memory spaces, register groups and registers.
  * @param[in] params GArray with all TCP packet parameters.
@@ -534,7 +542,7 @@ void handle_close_server(GArray *params, void *user_ctx);
 void handle_close_core(GArray *params, void *user_ctx);
 /**
  * \brief Handler for trigger query.
- * 
+ *
  * Sends data on the different types of trigger and their options and actions.
  * @param[in] params GArray with all TCP packet parameters.
  */
@@ -545,13 +553,13 @@ void handle_query_trigger(GArray *params, void *user_ctx);
 void mcd_vm_start(void);
 /**
  * \brief Starts the selected CPU with the cpu_resume function.
- * 
+ *
  * @param[in] cpu The CPU about to be started.
  */
 void mcd_cpu_start(CPUState *cpu);
 /**
  * \brief Performes a step on the selected CPU.
- * 
+ *
  * This function first sets the correct single step flags for the CPU with
  * cpu_single_step and then starts the CPU with cpu_resume.
  * @param[in] cpu The CPU about to be stepped.
@@ -563,14 +571,14 @@ int mcd_cpu_sstep(CPUState *cpu);
 void mcd_vm_stop(void);
 /**
  * \brief Handler for the first register group query.
- * 
+ *
  * This function sends the first register group name and ID.
  * @param[in] params GArray with all TCP packet parameters.
  */
 void handle_query_reg_groups_f(GArray *params, void *user_ctx);
 /**
  * \brief Handler for all consecutive register group queries.
- * 
+ *
  * This function sends all consecutive register group names and IDs. It uses
  * the query_index parameter to determine which register group is queried next.
  * @param[in] params GArray with all TCP packet parameters.
@@ -578,7 +586,7 @@ void handle_query_reg_groups_f(GArray *params, void *user_ctx);
 void handle_query_reg_groups_c(GArray *params, void *user_ctx);
 /**
  * \brief Handler for the first memory space query.
- * 
+ *
  * This function sends the first memory space name, ID, type and accessing
  * options.
  * @param[in] params GArray with all TCP packet parameters.
@@ -586,7 +594,7 @@ void handle_query_reg_groups_c(GArray *params, void *user_ctx);
 void handle_query_mem_spaces_f(GArray *params, void *user_ctx);
 /**
  * \brief Handler for all consecutive memory space queries.
- * 
+ *
  * This function sends all consecutive memory space names, IDs, types and
  * accessing options.
  * It uses the query_index parameter to determine
@@ -596,14 +604,14 @@ void handle_query_mem_spaces_f(GArray *params, void *user_ctx);
 void handle_query_mem_spaces_c(GArray *params, void *user_ctx);
 /**
  * \brief Handler for the first register query.
- * 
+ *
  * This function sends the first register with all its information.
  * @param[in] params GArray with all TCP packet parameters.
  */
 void handle_query_regs_f(GArray *params, void *user_ctx);
 /**
  * \brief Handler for all consecutive register queries.
- * 
+ *
  * This function sends all consecutive registers with all their information.
  * It uses the query_index parameter to determine
  * which register is queried next.
@@ -612,7 +620,7 @@ void handle_query_regs_f(GArray *params, void *user_ctx);
 void handle_query_regs_c(GArray *params, void *user_ctx);
 /**
  * \brief Handler for opening the MCD server.
- * 
+ *
  * This is the first function that gets called from the MCD Shared Library.
  * It initializes core indepent data with the \ref init_resets and
  * \reg init_trigger functions. It also send the \c TCP_HANDSHAKE_SUCCESS
@@ -623,14 +631,14 @@ void handle_query_regs_c(GArray *params, void *user_ctx);
 void handle_open_server(GArray *params, void *user_ctx);
 /**
  * \brief Handler for performing resets.
- * 
+ *
  * This function is currently not in use.
  * @param[in] params GArray with all TCP packet parameters.
  */
 void handle_reset(GArray *params, void *user_ctx);
 /**
  * \brief Handler for the state query.
- * 
+ *
  * This function collects all data stored in the
  * cpu_state member of the mcdserver_state and formats and sends it to the
  * library.
@@ -639,7 +647,7 @@ void handle_reset(GArray *params, void *user_ctx);
 void handle_query_state(GArray *params, void *user_ctx);
 /**
  * \brief Handler for reading a register.
- * 
+ *
  * This function calls \ref mcd_read_register to read a register. The register
  * data gets stored in the mem_buf byte array. The data then gets converted
  * into a hex string with \ref mcd_memtohex and then send.
@@ -648,7 +656,7 @@ void handle_query_state(GArray *params, void *user_ctx);
 void handle_read_register(GArray *params, void *user_ctx);
 /**
  * \brief Handler for writing a register.
- * 
+ *
  * This function converts the incoming hex string data into a byte array with
  * \ref mcd_hextomem. Then it calls \ref mcd_write_register to write to the
  * register.
@@ -657,7 +665,7 @@ void handle_read_register(GArray *params, void *user_ctx);
 void handle_write_register(GArray *params, void *user_ctx);
 /**
  * \brief Handler for reading memory.
- * 
+ *
  * First, this function checks whether reading a secure memory space is
  * requested and changes the access mode with \ref arm_mcd_set_scr.
  * Then it calls \ref mcd_read_memory to read memory. The collected
@@ -668,7 +676,7 @@ void handle_write_register(GArray *params, void *user_ctx);
 void handle_read_memory(GArray *params, void *user_ctx);
 /**
  * \brief Handler for writing memory.
- * 
+ *
  * First, this function checks whether reading a secure memory space is
  * requested and changes the access mode with \ref arm_mcd_set_scr.
  * Then it converts the incoming hex string data into a byte array with
@@ -679,7 +687,7 @@ void handle_read_memory(GArray *params, void *user_ctx);
 void handle_write_memory(GArray *params, void *user_ctx);
 /**
  * \brief Reads a registers data and stores it into the buf.
- * 
+ *
  * This function collects the register type and internal ID
  * (depending on the XML file). Then it calls the architecture specific
  * read function. For ARM this is \ref arm_mcd_read_register.
@@ -690,7 +698,7 @@ void handle_write_memory(GArray *params, void *user_ctx);
 int mcd_read_register(CPUState *cpu, GByteArray *buf, int reg);
 /**
  * \brief Writes data from the buf to a register.
- * 
+ *
  * This function collects the register type and internal ID
  * (depending on the XML file). Then it calls the architecture specific
  * write function. For ARM this is \ref arm_mcd_write_register.
@@ -701,7 +709,7 @@ int mcd_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int mcd_write_register(CPUState *cpu, GByteArray *buf, int reg);
 /**
  * \brief Reads memory data and stores it into the buf.
- * 
+ *
  * This function calls cpu_memory_rw_debug or if available
  * memory_rw_debug in read mode and passes on all parameters.
  * @param[in] cpu CPU to which the memory belongs.
@@ -712,7 +720,7 @@ int mcd_write_register(CPUState *cpu, GByteArray *buf, int reg);
 int mcd_read_memory(CPUState *cpu, hwaddr addr, uint8_t *buf, int len);
 /**
  * \brief Writes data from the buf into the memory.
- * 
+ *
  * This function calls cpu_memory_rw_debug or if available
  * memory_rw_debug in write mode and passes on all parameters.
  * @param[in] cpu CPU to which the memory belongs.
@@ -723,7 +731,7 @@ int mcd_read_memory(CPUState *cpu, hwaddr addr, uint8_t *buf, int len);
 int mcd_write_memory(CPUState *cpu, hwaddr addr, uint8_t *buf, int len);
 /**
  * \brief Handler for inserting a break- or watchpoint.
- * 
+ *
  * This function extracts the CPU, breakpoint type and address from the
  * parameters and calls \ref mcd_breakpoint_insert to insert the breakpoint.
  * @param[in] params GArray with all TCP packet parameters.
@@ -731,7 +739,7 @@ int mcd_write_memory(CPUState *cpu, hwaddr addr, uint8_t *buf, int len);
 void handle_breakpoint_insert(GArray *params, void *user_ctx);
 /**
  * \brief Handler for inserting a break- or watchpoint.
- * 
+ *
  * This function extracts the CPU, breakpoint type and address from the
  * parameters and calls \ref mcd_breakpoint_remove to insert the breakpoint.
  * @param[in] params GArray with all TCP packet parameters.
@@ -739,7 +747,7 @@ void handle_breakpoint_insert(GArray *params, void *user_ctx);
 void handle_breakpoint_remove(GArray *params, void *user_ctx);
 /**
  * \brief Inserts a break- or watchpoint.
- * 
+ *
  * This function evaluates the received breakpoint type and translates it
  * to a known GDB breakpoint type.
  * Then it calls cpu_breakpoint_insert or cpu_watchpoint_insert depending on
@@ -751,7 +759,7 @@ void handle_breakpoint_remove(GArray *params, void *user_ctx);
 int mcd_breakpoint_insert(CPUState *cpu, int type, vaddr addr);
 /**
  * \brief Removes a break- or watchpoint.
- * 
+ *
  * This function evaluates the received breakpoint type and translates it
  * to a known GDB breakpoint type.
  * Then it calls cpu_breakpoint_remove or cpu_watchpoint_remove depending on
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
             .info_str = STATE_STR_INIT_HALTED,
     };
     mcdserver_state.cpu_state = cpu_state;
+
+    /* create new debug object */
+    mcd_init_debug_class();
+ }
+
+void mcd_set_stop_cpu(CPUState *cpu)
+{
+    mcdserver_state.c_cpu = cpu;
 }
 
 void init_query_cmds_table(MCDCmdParseEntry *mcd_query_cmds_table)
@@ -1804,19 +1813,22 @@ int mcd_write_memory(CPUState *cpu, hwaddr addr, uint8_t *buf, int len)
 void handle_read_memory(GArray *params, void *user_ctx)
 {
     uint32_t cpu_id = get_param(params, 0)->cpu_id;
-    uint32_t mem_space_id = get_param(params, 1)->data_uint32_t;
     uint64_t mem_address = get_param(params, 2)->data_uint64_t;
     uint32_t len = get_param(params, 3)->data_uint32_t;
 
     CPUState *cpu = mcd_get_cpu(cpu_id);
-    /* check if the mem space is secure */
-    GArray *memspaces = g_list_nth_data(mcdserver_state.all_memspaces, cpu_id);
-    mcd_mem_space_st space = g_array_index(memspaces, mcd_mem_space_st,
-        mem_space_id - 1);
-    if (arm_mcd_set_scr(cpu, space.is_secure)) {
-        mcd_put_packet(TCP_EXECUTION_ERROR);
-        return;
-    }
+    /*
+     * TODO: select to correct address space
+     * uint32_t mem_space_id = get_param(params, 1)->data_uint32_t;
+     * GArray *memspaces =
+     *     g_list_nth_data(mcdserver_state.all_memspaces, cpu_id);
+     * mcd_mem_space_st space = g_array_index(memspaces, mcd_mem_space_st,
+     *     mem_space_id - 1);
+     * if (arm_mcd_set_scr(cpu, space.is_secure)) {
+     *     mcd_put_packet(TCP_EXECUTION_ERROR);
+     *     return;
+     * }
+     */
     /* read memory */
     g_byte_array_set_size(mcdserver_state.mem_buf, len);
     if (mcd_read_memory(cpu, mem_address, mcdserver_state.mem_buf->data,
@@ -1832,18 +1844,21 @@ void handle_read_memory(GArray *params, void *user_ctx)
 void handle_write_memory(GArray *params, void *user_ctx)
 {
     uint32_t cpu_id = get_param(params, 0)->cpu_id;
-    uint32_t mem_space_id = get_param(params, 1)->data_uint32_t;
     uint64_t mem_address = get_param(params, 2)->data_uint64_t;
     uint32_t len = get_param(params, 3)->data_uint32_t;
     CPUState *cpu = mcd_get_cpu(cpu_id);
-    /* check if the mem space is secure */
-    GArray *memspaces = g_list_nth_data(mcdserver_state.all_memspaces, cpu_id);
-    mcd_mem_space_st space = g_array_index(memspaces, mcd_mem_space_st,
-        mem_space_id - 1);
-    if (arm_mcd_set_scr(cpu, space.is_secure)) {
-        mcd_put_packet(TCP_EXECUTION_ERROR);
-        return;
-    }
+    /*
+     * TODO: select to correct address space
+     * uint32_t mem_space_id = get_param(params, 1)->data_uint32_t;
+     * GArray *memspaces =
+     *     g_list_nth_data(mcdserver_state.all_memspaces, cpu_id);
+     * mcd_mem_space_st space = g_array_index(memspaces, mcd_mem_space_st,
+     *     mem_space_id - 1);
+     * if (arm_mcd_set_scr(cpu, space.is_secure)) {
+     *     mcd_put_packet(TCP_EXECUTION_ERROR);
+     *     return;
+     * }
+     */
     /* write memory */
     mcd_hextomem(mcdserver_state.mem_buf, mcdserver_state.str_buf->str, len);
     if (mcd_write_memory(cpu, mem_address,
diff --git a/mcdstub/meson.build b/mcdstub/meson.build
index 6b2f970eae..aad35234a9 100644
--- a/mcdstub/meson.build
+++ b/mcdstub/meson.build
@@ -4,7 +4,7 @@
 mcd_system_ss = ss.source_set()
 
 # only system emulation is supported over mcd
-mcd_system_ss.add(files('mcdstub.c'))
+mcd_system_ss.add(files('mcdstub.c', '../debug/debug-mcd.c'))
 
 mcd_system_ss = mcd_system_ss.apply(config_host, strict: false)
 
@@ -16,4 +16,4 @@ libmcd_softmmu = static_library('mcd_softmmu',
 mcd_softmmu = declare_dependency(link_whole: libmcd_softmmu)
 system_ss.add(mcd_softmmu)
 
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
+        MachineState *ms = MACHINE(qdev_get_machine());
+        DebugState *ds = ms->debug_state;
+        DebugClass *dc = DEBUG_GET_CLASS(ds);
+
+        if (dc->set_stop_cpu) {
+            dc->set_stop_cpu(cpu);
+        }
         qemu_system_debug_request();
         cpu->stopped = true;
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
 
 #include "mcdstub/arm_mcdstub.h"
 
@@ -332,20 +333,6 @@ uint16_t arm_mcd_get_opcode(CPUState *cs, uint32_t n)
     return 0;
 }
 
-int arm_mcd_set_scr(CPUState *cs, bool secure)
-{
-    /* switches between secure and non secure mode */
-    ARMCPU *cpu = ARM_CPU(cs);
-    CPUARMState *env = &cpu->env;
-    /* set bit 0 to 1 if non secure, to 0 if secure*/
-    if (secure) {
-        env->cp15.scr_el3 &= 0xFFFFFFFE;
-    } else {
-        env->cp15.scr_el3 |= 1;
-    }
-    return 0;
-}
-
 int arm_mcd_store_mem_spaces(CPUState *cpu, GArray *memspaces)
 {
     int nr_address_spaces = cpu->num_ases;
@@ -379,7 +366,7 @@ int arm_mcd_store_mem_spaces(CPUState *cpu, GArray *memspaces)
         .is_secure = false,
     };
     g_array_append_vals(memspaces, (gconstpointer)&phys_non_secure, 1);
-    if(nr_address_spaces > 1) {
+    if (nr_address_spaces > 1) {
         mem_space_id++;
         mcd_mem_space_st secure = {
             .name = "Secure",
-- 
2.34.1


