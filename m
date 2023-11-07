Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CED7E3F92
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 14:05:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0LlM-0000Ox-C9; Tue, 07 Nov 2023 08:05:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1r0LkQ-00089u-BJ
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:04:05 -0500
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1r0LkM-0005x9-1B
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:04:01 -0500
Received: (qmail 31207 invoked by uid 484); 7 Nov 2023 13:03:54 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.072978 secs); 07 Nov 2023 13:03:54 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP for <qemu-devel@nongnu.org>; 7 Nov 2023 13:03:54 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: "Nicolas Eder" <nicolas.eder@lauterbach.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Christian Boenig" <christian.boenig@lauterbach.com>
Subject: [PATCH v3 09/20] mcdstub: open/close core added. This includes core
 specific data preparation: memory spaces,
 register groups and registers. This data preparation is done in the arm
 mcdstub
Date: Tue,  7 Nov 2023 14:03:12 +0100
Message-Id: <20231107130323.4126-10-nicolas.eder@lauterbach.com>
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
 include/mcdstub/arm_mcdstub.h    |  81 +++++++++
 include/mcdstub/mcdstub.h        |  26 +++
 include/mcdstub/mcdstub_common.h |  52 ++++++
 mcdstub/mcdstub.c                | 111 ++++++++++++
 target/arm/mcdstub.c             | 278 +++++++++++++++++++++++++++++++
 5 files changed, 548 insertions(+)
 create mode 100644 target/arm/mcdstub.c

diff --git a/include/mcdstub/arm_mcdstub.h b/include/mcdstub/arm_mcdstub.h
index a57aa8e9f2..c71f6c3356 100644
--- a/include/mcdstub/arm_mcdstub.h
+++ b/include/mcdstub/arm_mcdstub.h
@@ -6,5 +6,86 @@
 /* just used for the register xml files */
 #include "exec/gdbstub.h"
 
+/* ids for each different type of register */
+enum {
+    MCD_ARM_REG_TYPE_GPR,
+    MCD_ARM_REG_TYPE_VFP,
+    MCD_ARM_REG_TYPE_VFP_SYS,
+    MCD_ARM_REG_TYPE_MVE,
+    MCD_ARM_REG_TYPE_CPR,
+};
+
+/**
+ * arm_mcd_get_dynamic_xml() - Returns the contents of the desired XML file.
+ *
+ * @xmlname: Name of the desired XML file.
+ * @cs: CPU state.
+ */
+const char *arm_mcd_get_dynamic_xml(CPUState *cs, const char *xmlname);
+
+/**
+ * arm_mcd_get_opcode() - Returns the opcode for a coprocessor register.
+ *
+ * This function uses the opc1, opc2, crm and crn members of the register to
+ * create the opcode. The formular for creating the opcode is determined by ARM.
+ * @n: The register ID of the CP register.
+ * @cs: CPU state.
+ */
+uint16_t arm_mcd_get_opcode(CPUState *cs, uint32_t n);
+
+/**
+ * arm_mcd_store_mem_spaces() - Stores all 32-Bit ARM specific memory spaces.
+ *
+ * This function stores the memory spaces into the memspaces GArray.
+ * It only stores secure memory spaces if the CPU has more than one address
+ * space. It also stores a GPR and a CP15 register memory space.
+ * @memspaces: GArray of memory spaces.
+ * @cpu: CPU state.
+ */
+int arm_mcd_store_mem_spaces(CPUState *cpu, GArray *memspaces);
+
+/**
+ * arm_mcd_parse_core_xml_file() - Parses the GPR registers.
+ *
+ * This function parses the core XML file, which includes the GPR registers.
+ * The regsters get stored in a GArray and a GPR register group is stored in a
+ * second GArray.
+ * @reggroups: GArray of register groups.
+ * @registers: GArray of registers.
+ * @cc: The CPU class.
+ * @current_group_id: The current group ID. It increases after
+ * each group.
+ */
+int arm_mcd_parse_core_xml_file(CPUClass *cc, GArray *reggroups,
+    GArray *registers, int *current_group_id);
+
+/**
+ * arm_mcd_parse_general_xml_files() - Parses all but the GPR registers.
+ *
+ * This function parses all XML files except for the core XML file.
+ * The regsters get stored in a GArray and if the system-registers.xml file is
+ * parsed, it also adds a CP15 register group.
+ * @reggroups: GArray of register groups.
+ * @registers: GArray of registers.
+ * @cpu: The CPU state.
+ * @current_group_id: The current group ID. It increases after
+ * each added group.
+ */
+int arm_mcd_parse_general_xml_files(CPUState *cpu, GArray* reggroups,
+    GArray *registers, int *current_group_id);
+
+/**
+ * arm_mcd_get_additional_register_info() - Adds additional data to parsed
+ * registers.
+ *
+ * This function is called, after :c:func:`arm_mcd_parse_core_xml_file` and
+ * :c:func:`arm_mcd_parse_general_xml_files`. It adds additional data for all
+ * already parsed registers. The registers get a correct ID, group, memory
+ * space and opcode, if they are CP15 registers.
+ * @reggroups: GArray of register groups.
+ * @registers: GArray of registers.
+ * @cpu: The CPU state.
+ */
+int arm_mcd_get_additional_register_info(GArray *reggroups, GArray *registers,
 
 #endif /* ARM_MCDSTUB_H */
diff --git a/include/mcdstub/mcdstub.h b/include/mcdstub/mcdstub.h
index c4370bb177..d38106e973 100644
--- a/include/mcdstub/mcdstub.h
+++ b/include/mcdstub/mcdstub.h
@@ -106,6 +106,11 @@ typedef struct MCDState {
 /* lives in main mcdstub.c */
 extern MCDState mcdserver_state;
 
+typedef struct xml_attrib {
+    char argument[ARGUMENT_STRING_LENGTH];
+    char value[ARGUMENT_STRING_LENGTH];
+} xml_attrib;
+
 typedef struct mcd_reset_st {
     const char *name;
     uint8_t id;
@@ -459,6 +464,18 @@ CPUState *get_first_cpu_in_process(MCDProcess *process);
  */
 CPUState *find_cpu(uint32_t thread_id);
 
+/**
+ * handle_open_core() - Handler for opening a core.
+ *
+ * This function initializes all data for the core with the ID provided in
+ * the first parameter. In has a swtich case for different architectures.
+ * Currently only 32-Bit ARM is supported. The data includes memory spaces,
+ * register groups and registers themselves. They get stored into GLists where
+ * every entry in the list corresponds to one opened core.
+ * @params: GArray with all TCP packet parameters.
+ */
+void handle_open_core(GArray *params, void *user_ctx);
+
 /**
  * handle_close_server() - Handler for closing the MCD server.
  *
@@ -468,6 +485,15 @@ CPUState *find_cpu(uint32_t thread_id);
  */
 void handle_close_server(GArray *params, void *user_ctx);
 
+/**
+ * handle_close_core() - Handler for closing a core.
+ *
+ * Frees all memory allocated for core specific information. This includes
+ * memory spaces, register groups and registers.
+ * @params: GArray with all TCP packet parameters.
+ */
+void handle_close_core(GArray *params, void *user_ctx);
+
 /**
  * handle_open_server() - Handler for opening the MCD server.
  *
diff --git a/include/mcdstub/mcdstub_common.h b/include/mcdstub/mcdstub_common.h
index 3bae2c3b6f..633d9b0f70 100644
--- a/include/mcdstub/mcdstub_common.h
+++ b/include/mcdstub/mcdstub_common.h
@@ -4,4 +4,56 @@
 #define ARGUMENT_STRING_LENGTH 64
 #define TCP_CONFIG_STRING_LENGTH 128
 
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
+/**
+ * parse_reg_xml() -  Parses a GDB register XML file
+ *
+ * This fuction extracts all registers from the provided xml file and stores
+ * them into the registers GArray. It extracts the register name, bitsize, type
+ * and group if they are set.
+ * @xml: String with contents of the XML file.
+ * @registers: GArray with stored registers.
+ * @reg_type: Register type (depending on file).
+ * @size: Number of characters in the xml string.
+ */
+void parse_reg_xml(const char *xml, int size, GArray* registers,
+    uint8_t reg_type, uint32_t reg_id_offset);
+
 #endif /* MCDSTUB_COMMON_H */
diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index a090268e70..ca98d01ee7 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -370,6 +370,17 @@ int mcd_handle_packet(const char *line_buf)
             cmd_parser = &query_cmd_desc;
         }
         break;
+    case TCP_CHAR_OPEN_CORE:
+        {
+            static MCDCmdParseEntry open_core_cmd_desc = {
+                .handler = handle_open_core,
+            };
+            open_core_cmd_desc.cmd = (char[2]) { TCP_CHAR_OPEN_CORE, '\0' };
+            strcpy(open_core_cmd_desc.schema,
+                (char[2]) { ARG_SCHEMA_CORENUM, '\0' });
+            cmd_parser = &open_core_cmd_desc;
+        }
+        break;
     case TCP_CHAR_CLOSE_SERVER:
         {
             static MCDCmdParseEntry close_server_cmd_desc = {
@@ -380,6 +391,17 @@ int mcd_handle_packet(const char *line_buf)
             cmd_parser = &close_server_cmd_desc;
         }
         break;
+    case TCP_CHAR_CLOSE_CORE:
+        {
+            static MCDCmdParseEntry close_core_cmd_desc = {
+                .handler = handle_close_core,
+            };
+            close_core_cmd_desc.cmd = (char[2]) { TCP_CHAR_CLOSE_CORE, '\0' };
+            strcpy(close_core_cmd_desc.schema,
+                (char[2]) { ARG_SCHEMA_CORENUM, '\0' });
+            cmd_parser = &close_core_cmd_desc;
+        }
+        break;
     default:
         /* command not supported */
         mcd_put_packet("");
@@ -805,6 +827,95 @@ void handle_query_cores(GArray *params, void *user_ctx)
     mcd_put_strbuf();
 }
 
+void handle_open_core(GArray *params, void *user_ctx)
+{
+    uint32_t cpu_id = get_param(params, 0)->cpu_id;
+    CPUState *cpu = mcd_get_cpu(cpu_id);
+    mcdserver_state.c_cpu = cpu;
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+    const gchar *arch = cc->gdb_arch_name(cpu);
+    int return_value = 0;
+
+    /* prepare data strucutures */
+    GArray *memspaces = g_array_new(false, true, sizeof(mcd_mem_space_st));
+    GArray *reggroups = g_array_new(false, true, sizeof(mcd_reg_group_st));
+    GArray *registers = g_array_new(false, true, sizeof(mcd_reg_st));
+
+    if (strcmp(arch, MCDSTUB_ARCH_ARM) == 0) {
+        /* TODO: make group and memspace ids dynamic */
+        int current_group_id = 1;
+        /* 1. store mem spaces */
+        return_value = arm_mcd_store_mem_spaces(cpu, memspaces);
+        if (return_value != 0) {
+            g_assert_not_reached();
+        }
+        /* 2. parse core xml */
+        return_value = arm_mcd_parse_core_xml_file(cc, reggroups,
+            registers, &current_group_id);
+        if (return_value != 0) {
+            g_assert_not_reached();
+        }
+        /* 3. parse other xmls */
+        return_value = arm_mcd_parse_general_xml_files(cpu, reggroups,
+            registers, &current_group_id);
+        if (return_value != 0) {
+            g_assert_not_reached();
+        }
+        /* 4. add additional data the the regs from the xmls */
+        return_value = arm_mcd_get_additional_register_info(reggroups,
+            registers, cpu);
+        if (return_value != 0) {
+            g_assert_not_reached();
+        }
+        /* 5. store all found data */
+        if (g_list_nth(mcdserver_state.all_memspaces, cpu_id)) {
+            GList *memspaces_ptr =
+                g_list_nth(mcdserver_state.all_memspaces, cpu_id);
+            memspaces_ptr->data = memspaces;
+        } else {
+            mcdserver_state.all_memspaces =
+                g_list_insert(mcdserver_state.all_memspaces, memspaces, cpu_id);
+        }
+        if (g_list_nth(mcdserver_state.all_reggroups, cpu_id)) {
+            GList *reggroups_ptr =
+                g_list_nth(mcdserver_state.all_reggroups, cpu_id);
+            reggroups_ptr->data = reggroups;
+        } else {
+            mcdserver_state.all_reggroups =
+                g_list_insert(mcdserver_state.all_reggroups, reggroups, cpu_id);
+        }
+        if (g_list_nth(mcdserver_state.all_registers, cpu_id)) {
+            GList *registers_ptr =
+                g_list_nth(mcdserver_state.all_registers, cpu_id);
+            registers_ptr->data = registers;
+        } else {
+            mcdserver_state.all_registers =
+                g_list_insert(mcdserver_state.all_registers, registers, cpu_id);
+        }
+    } else {
+        /* we don't support other architectures */
+        g_assert_not_reached();
+    }
+}
+
+
+void handle_close_core(GArray *params, void *user_ctx)
+{
+    /* free memory for correct core */
+    uint32_t cpu_id = get_param(params, 0)->cpu_id;
+    GArray *memspaces = g_list_nth_data(mcdserver_state.all_memspaces, cpu_id);
+    mcdserver_state.all_memspaces =
+        g_list_remove(mcdserver_state.all_memspaces, memspaces);
+    g_array_free(memspaces, TRUE);
+    GArray *reggroups = g_list_nth_data(mcdserver_state.all_reggroups, cpu_id);
+    mcdserver_state.all_reggroups =
+        g_list_remove(mcdserver_state.all_reggroups, reggroups);
+    g_array_free(reggroups, TRUE);
+    GArray *registers = g_list_nth_data(mcdserver_state.all_registers, cpu_id);
+    mcdserver_state.all_registers =
+        g_list_remove(mcdserver_state.all_registers, registers);
+    g_array_free(registers, TRUE);
+}
 
 void handle_close_server(GArray *params, void *user_ctx)
 {
diff --git a/target/arm/mcdstub.c b/target/arm/mcdstub.c
new file mode 100644
index 0000000000..ff1350831b
--- /dev/null
+++ b/target/arm/mcdstub.c
@@ -0,0 +1,278 @@
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "exec/memory.h"
+#include "sysemu/tcg.h"
+#include "internals.h"
+#include "cpregs.h"
+#include "qemu/debug.h"
+#include "mcdstub/arm_mcdstub.h"
+
+const char *arm_mcd_get_dynamic_xml(CPUState *cs, const char *xmlname)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+
+    if (strcmp(xmlname, "system-registers.xml") == 0) {
+        return cpu->dyn_sysreg_xml.desc;
+    } else if (strcmp(xmlname, "sve-registers.xml") == 0) {
+        return cpu->dyn_svereg_xml.desc;
+    } else if (strcmp(xmlname, "arm-m-system.xml") == 0) {
+        return cpu->dyn_m_systemreg_xml.desc;
+#ifndef CONFIG_USER_ONLY
+    } else if (strcmp(xmlname, "arm-m-secext.xml") == 0) {
+        return cpu->dyn_m_secextreg_xml.desc;
+#endif
+    }
+    return NULL;
+}
+
+uint16_t arm_mcd_get_opcode(CPUState *cs, uint32_t n)
+{
+    /*gets the opcode for a cp register*/
+    ARMCPU *cpu = ARM_CPU(cs);
+    const ARMCPRegInfo *ri;
+    uint32_t key;
+
+    key = cpu->dyn_sysreg_xml.data.cpregs.keys[n];
+    ri = get_arm_cp_reginfo(cpu->cp_regs, key);
+    if (ri) {
+        uint16_t opcode = 0;
+        opcode |= ri->opc1 << 14;
+        opcode |= ri->opc2 << 10;
+        opcode |= ri->crm << 7;
+        opcode |= ri->crn << 3;
+        return opcode;
+    }
+    return 0;
+}
+
+int arm_mcd_store_mem_spaces(CPUState *cpu, GArray *memspaces)
+{
+    int nr_address_spaces = cpu->num_ases;
+    uint32_t mem_space_id = 0;
+
+    mem_space_id++;
+    mcd_mem_space_st non_secure = {
+        .name = "Non Secure",
+        .id = mem_space_id,
+        .type = 34,
+        .bits_per_mau = 8,
+        .invariance = 1,
+        .endian = 1,
+        .min_addr = 0,
+        .max_addr = -1,
+        .supported_access_options = 0,
+        .is_secure = false,
+        .is_physical = false,
+    };
+    g_array_append_vals(memspaces, (gconstpointer)&non_secure, 1);
+    mem_space_id++;
+    mcd_mem_space_st phys_non_secure = {
+        .name = "Physical (Non Secure)",
+        .id = mem_space_id,
+        .type = 18,
+        .bits_per_mau = 8,
+        .invariance = 1,
+        .endian = 1,
+        .min_addr = 0,
+        .max_addr = -1,
+        .supported_access_options = 0,
+        .is_secure = false,
+        .is_physical = true,
+    };
+    g_array_append_vals(memspaces, (gconstpointer)&phys_non_secure, 1);
+    if (nr_address_spaces > 1) {
+        mem_space_id++;
+        mcd_mem_space_st secure = {
+            .name = "Secure",
+            .id = mem_space_id,
+            .type = 34,
+            .bits_per_mau = 8,
+            .invariance = 1,
+            .endian = 1,
+            .min_addr = 0,
+            .max_addr = -1,
+            .supported_access_options = 0,
+            .is_secure = true,
+            .is_physical = false,
+        };
+        g_array_append_vals(memspaces, (gconstpointer)&secure, 1);
+        mem_space_id++;
+        mcd_mem_space_st phys_secure = {
+            .name = "Physical (Secure)",
+            .id = mem_space_id,
+            .type = 18,
+            .bits_per_mau = 8,
+            .invariance = 1,
+            .endian = 1,
+            .min_addr = 0,
+            .max_addr = -1,
+            .supported_access_options = 0,
+            .is_secure = true,
+            .is_physical = true,
+        };
+        g_array_append_vals(memspaces, (gconstpointer)&phys_secure, 1);
+    }
+    mem_space_id++;
+    mcd_mem_space_st gpr = {
+        .name = "GPR Registers",
+        .id = mem_space_id,
+        .type = 1,
+        .bits_per_mau = 8,
+        .invariance = 1,
+        .endian = 1,
+        .min_addr = 0,
+        .max_addr = -1,
+        .supported_access_options = 0,
+    };
+    g_array_append_vals(memspaces, (gconstpointer)&gpr, 1);
+    mem_space_id++;
+    mcd_mem_space_st cpr = {
+        .name = "CP15 Registers",
+        .id = mem_space_id,
+        .type = 1,
+        .bits_per_mau = 8,
+        .invariance = 1,
+        .endian = 1,
+        .min_addr = 0,
+        .max_addr = -1,
+        .supported_access_options = 0,
+    };
+    g_array_append_vals(memspaces, (gconstpointer)&cpr, 1);
+    return 0;
+}
+
+int arm_mcd_parse_core_xml_file(CPUClass *cc, GArray *reggroups,
+    GArray *registers, int *current_group_id)
+{
+    const char *xml_filename = NULL;
+    const char *current_xml_filename = NULL;
+    const char *xml_content = NULL;
+    int i = 0;
+
+    /* 1. get correct file */
+    xml_filename = cc->gdb_core_xml_file;
+    for (i = 0; ; i++) {
+        current_xml_filename = gdb_static_features[i].xmlname;
+        if (!current_xml_filename || (strncmp(current_xml_filename,
+            xml_filename, strlen(xml_filename)) == 0
+            && strlen(current_xml_filename) == strlen(xml_filename)))
+            break;
+    }
+    /* without gpr registers we can do nothing */
+    if (!current_xml_filename) {
+        return -1;
+    }
+
+    /* 2. add group for gpr registers */
+    mcd_reg_group_st gprregs = {
+        .name = "GPR Registers",
+        .id = *current_group_id
+    };
+    g_array_append_vals(reggroups, (gconstpointer)&gprregs, 1);
+    *current_group_id = *current_group_id + 1;
+
+    /* 3. parse xml */
+    /* the offset for gpr is always zero */
+    xml_content = gdb_static_features[i].xml;
+    parse_reg_xml(xml_content, strlen(xml_content), registers,
+        MCD_ARM_REG_TYPE_GPR, 0);
+    return 0;
+}
+
+int arm_mcd_parse_general_xml_files(CPUState *cpu, GArray *reggroups,
+    GArray *registers, int *current_group_id) {
+    const char *xml_filename = NULL;
+    const char *current_xml_filename = NULL;
+    const char *xml_content = NULL;
+    uint8_t reg_type;
+
+    /* iterate over all gdb xml files*/
+    GDBRegisterState *r;
+    for (guint i = 0; i < cpu->gdb_regs->len; i++) {
+        r = &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
+
+        xml_filename = r->xml;
+        xml_content = NULL;
+
+        /* 1. get xml content */
+        xml_content = arm_mcd_get_dynamic_xml(cpu, xml_filename);
+        if (xml_content) {
+            if (strcmp(xml_filename, "system-registers.xml") == 0) {
+                /* these are the coprocessor register */
+                mcd_reg_group_st corprocessorregs = {
+                    .name = "CP15 Registers",
+                    .id = *current_group_id
+                };
+                g_array_append_vals(reggroups,
+                    (gconstpointer)&corprocessorregs, 1);
+                *current_group_id = *current_group_id + 1;
+                reg_type = MCD_ARM_REG_TYPE_CPR;
+            }
+        } else {
+            /* its not a coprocessor xml -> it is a static xml file */
+            int j = 0;
+            for (j = 0; ; j++) {
+                current_xml_filename = gdb_static_features[j].xmlname;
+                if (!current_xml_filename || (strncmp(current_xml_filename,
+                    xml_filename, strlen(xml_filename)) == 0
+                    && strlen(current_xml_filename) == strlen(xml_filename)))
+                    break;
+            }
+            if (current_xml_filename) {
+                xml_content = gdb_static_features[j].xml;
+                /* select correct reg_type */
+                if (strcmp(current_xml_filename, "arm-vfp.xml") == 0) {
+                    reg_type = MCD_ARM_REG_TYPE_VFP;
+                } else if (strcmp(current_xml_filename, "arm-vfp3.xml") == 0) {
+                    reg_type = MCD_ARM_REG_TYPE_VFP;
+                } else if (strcmp(current_xml_filename,
+                    "arm-vfp-sysregs.xml") == 0) {
+                    reg_type = MCD_ARM_REG_TYPE_VFP_SYS;
+                } else if (strcmp(current_xml_filename,
+                    "arm-neon.xml") == 0) {
+                    reg_type = MCD_ARM_REG_TYPE_VFP;
+                } else if (strcmp(current_xml_filename,
+                    "arm-m-profile-mve.xml") == 0) {
+                    reg_type = MCD_ARM_REG_TYPE_MVE;
+                }
+            } else {
+                continue;
+            }
+        }
+        /* 2. parse xml */
+        parse_reg_xml(xml_content, strlen(xml_content), registers, reg_type,
+            r->base_reg);
+    }
+    return 0;
+}
+
+int arm_mcd_get_additional_register_info(GArray *reggroups, GArray *registers,
+    CPUState *cpu)
+{
+    mcd_reg_st *current_register;
+    uint32_t i = 0;
+
+    /* iterate over all registers */
+    for (i = 0; i < registers->len; i++) {
+        current_register = &(g_array_index(registers, mcd_reg_st, i));
+        /* add mcd_reg_group_id and mcd_mem_space_id */
+        if (strcmp(current_register->group, "cp_regs") == 0) {
+            /* coprocessor registers */
+            current_register->mcd_reg_group_id = 2;
+            current_register->mcd_mem_space_id = 6;
+            /*
+             * get info for opcode
+             * for 32bit the opcode is only 16 bit long
+             * for 64bit it is 32 bit long
+             */
+            current_register->opcode |=
+                arm_mcd_get_opcode(cpu, current_register->internal_id);
+        } else {
+            /* gpr register */
+            current_register->mcd_reg_group_id = 1;
+            current_register->mcd_mem_space_id = 5;
+        }
+    }
+    return 0;
+}
+
-- 
2.34.1


