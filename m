Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F6181A50D
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 17:29:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFzP3-0000Ok-Fm; Wed, 20 Dec 2023 11:26:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1rFzOx-0000Mt-EW
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 11:26:31 -0500
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1rFzOr-0004lG-LJ
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 11:26:30 -0500
Received: (qmail 15354 invoked by uid 484); 20 Dec 2023 16:26:20 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.073577 secs); 20 Dec 2023 16:26:20 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP
 for <qemu-devel@nongnu.org>; 20 Dec 2023 16:26:19 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Christian Boenig" <christian.boenig@lauterbach.com>,
 "Nicolas Eder" <nicolas.eder@lauterbach.com>
Subject: [PATCH v5 11/18] mcdstub: system and core queries added
Date: Wed, 20 Dec 2023 17:25:48 +0100
Message-Id: <20231220162555.19545-12-nicolas.eder@lauterbach.com>
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
 debug/mcdstub/arm_mcdstub.c      | 243 ++++++++++++++++++++
 debug/mcdstub/mcdstub.c          | 370 ++++++++++++++++++++++++++++++-
 debug/mcdstub/meson.build        |   2 +-
 include/mcdstub/arm_mcdstub.h    |  85 +++++++
 include/mcdstub/mcdstub.h        |   5 -
 include/mcdstub/mcdstub_common.h |  19 ++
 6 files changed, 717 insertions(+), 7 deletions(-)

diff --git a/debug/mcdstub/arm_mcdstub.c b/debug/mcdstub/arm_mcdstub.c
index c24aaf1202..ce5264a617 100644
--- a/debug/mcdstub/arm_mcdstub.c
+++ b/debug/mcdstub/arm_mcdstub.c
@@ -16,3 +16,246 @@
  *
  * SPDX-License-Identifier: LGPL-2.0+
  */
+
+#include "qemu/osdep.h"
+#include "mcdstub/arm_mcdstub.h"
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
+    uint8_t reg_type = 0;
+    CPUClass *cc = CPU_GET_CLASS(cpu);
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
+        if (cc->gdb_get_dynamic_xml) {
+            xml_content = cc->gdb_get_dynamic_xml(cpu, xml_filename);
+        }
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
+uint16_t arm_mcd_get_opcode(CPUState *cs, uint32_t n)
+{
+    /* TODO: not working with current build structure */
+    return 0;
+}
diff --git a/debug/mcdstub/mcdstub.c b/debug/mcdstub/mcdstub.c
index 45daa38689..4095b3f8ce 100644
--- a/debug/mcdstub/mcdstub.c
+++ b/debug/mcdstub/mcdstub.c
@@ -34,6 +34,7 @@
 
 #include "mcdstub/mcd_shared_defines.h"
 #include "mcdstub/mcdstub.h"
+#include "mcdstub/arm_mcdstub.h"
 
 typedef struct {
     CharBackend chr;
@@ -150,6 +151,25 @@ static CPUState *mcd_first_attached_cpu(void)
     return cpu;
 }
 
+/**
+ * mcd_get_cpu() - Returns the CPU the index i_cpu_index.
+ *
+ * @cpu_index: Index of the desired CPU.
+ */
+static CPUState *mcd_get_cpu(uint32_t cpu_index)
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
 /**
  * mcd_vm_state_change() - Handles a state change of the QEMU VM.
  *
@@ -221,6 +241,15 @@ static int mcd_put_packet(const char *buf)
     return mcd_put_packet_binary(buf, strlen(buf));
 }
 
+/**
+ * mcd_put_strbuf() - Calls :c:func:`mcd_put_packet` with the str_buf of the
+ * mcdserver_state.
+ */
+static void mcd_put_strbuf(void)
+{
+    mcd_put_packet(mcdserver_state.str_buf->str);
+}
+
 /**
  * cmd_parse_params() - Extracts all parameters from a TCP packet.
  *
@@ -480,6 +509,134 @@ static void handle_close_server(GArray *params, void *user_ctx)
     }
 }
 
+/**
+ * handle_gen_query() - Handler for all TCP query packets.
+ *
+ * Calls :c:func:`process_string_cmd` with all query functions in the
+ * mcd_query_cmds_table. :c:func:`process_string_cmd` then selects the correct
+ * one. This function just passes on the TCP packet data string from the
+ * parameters.
+ * @params: GArray with all TCP packet parameters.
+ */
+static void handle_gen_query(GArray *params, void *user_ctx)
+{
+    if (!params->len) {
+        return;
+    }
+    /* iterate over all possible query functions and execute the right one */
+    if (process_string_cmd(NULL, get_param(params, 0)->data,
+                           mcdserver_state.mcd_query_cmds_table,
+                           ARRAY_SIZE(mcdserver_state.mcd_query_cmds_table))) {
+        mcd_put_packet("");
+    }
+}
+
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
+static void handle_open_core(GArray *params, void *user_ctx)
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
+/**
+ * handle_close_core() - Handler for closing a core.
+ *
+ * Frees all memory allocated for core specific information. This includes
+ * memory spaces, register groups and registers.
+ * @params: GArray with all TCP packet parameters.
+ */
+static void handle_close_core(GArray *params, void *user_ctx)
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
+
 /**
  * mcd_handle_packet() - Evaluates the type of received packet and chooses the
  * correct handler.
@@ -516,6 +673,36 @@ static int mcd_handle_packet(const char *line_buf)
             cmd_parser = &close_server_cmd_desc;
         }
         break;
+    case TCP_CHAR_QUERY:
+        {
+            static MCDCmdParseEntry query_cmd_desc = {
+                .handler = handle_gen_query,
+                .cmd = {TCP_CHAR_QUERY, '\0'},
+                .schema = {ARG_SCHEMA_STRING, '\0'},
+            };
+            cmd_parser = &query_cmd_desc;
+        }
+        break;
+    case TCP_CHAR_OPEN_CORE:
+        {
+            static MCDCmdParseEntry open_core_cmd_desc = {
+                .handler = handle_open_core,
+                .cmd = {TCP_CHAR_OPEN_CORE, '\0'},
+                .schema = {ARG_SCHEMA_CORENUM, '\0'},
+            };
+            cmd_parser = &open_core_cmd_desc;
+        }
+        break;
+    case TCP_CHAR_CLOSE_CORE:
+        {
+            static MCDCmdParseEntry close_core_cmd_desc = {
+                .handler = handle_close_core,
+                .cmd = {TCP_CHAR_CLOSE_CORE, '\0'},
+                .schema = {ARG_SCHEMA_CORENUM, '\0'},
+            };
+            cmd_parser = &close_core_cmd_desc;
+        }
+        break;
     default:
         /* command not supported */
         mcd_put_packet("");
@@ -663,6 +850,49 @@ static void mcd_chr_event(void *opaque, QEMUChrEvent event)
     }
 }
 
+/**
+ * handle_query_system() - Handler for the system query.
+ *
+ * Sends the system name, which is "qemu-system".
+ * @params: GArray with all TCP packet parameters.
+ */
+static void handle_query_system(GArray *params, void *user_ctx)
+{
+    mcd_put_packet(MCD_SYSTEM_NAME);
+}
+
+/**
+ * handle_query_cores() - Handler for the core query.
+ *
+ * This function sends the type of core and number of cores currently
+ * simulated by QEMU. It also sends a device name for the MCD data structure.
+ * @params: GArray with all TCP packet parameters.
+ */
+static void handle_query_cores(GArray *params, void *user_ctx)
+{
+    /* get first cpu */
+    CPUState *cpu = mcd_first_attached_cpu();
+    if (!cpu) {
+        return;
+    }
+
+    ObjectClass *oc = object_get_class(OBJECT(cpu));
+    const char *cpu_model = object_class_get_name(oc);
+
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+    const gchar *arch = cc->gdb_arch_name(cpu);
+
+    uint32_t nr_cores = cpu->nr_cores;
+    char device_name[ARGUMENT_STRING_LENGTH] = {0};
+    if (arch) {
+        snprintf(device_name, sizeof(device_name), "qemu-%s-device", arch);
+    }
+    g_string_printf(mcdserver_state.str_buf, "%s=%s.%s=%s.%s=%u.",
+        TCP_ARGUMENT_DEVICE, device_name, TCP_ARGUMENT_CORE, cpu_model,
+        TCP_ARGUMENT_AMOUNT_CORE, nr_cores);
+    mcd_put_strbuf();
+}
+
 /**
  * init_query_cmds_table() - Initializes all query functions.
  *
@@ -671,7 +901,24 @@ static void mcd_chr_event(void *opaque, QEMUChrEvent event)
  * @mcd_query_cmds_table: Lookup table with all query commands.
  */
 static void init_query_cmds_table(MCDCmdParseEntry *mcd_query_cmds_table)
-{}
+{
+    /* initalizes a list of all query commands */
+    int cmd_number = 0;
+
+    MCDCmdParseEntry query_system = {
+        .handler = handle_query_system,
+        .cmd = QUERY_ARG_SYSTEM,
+    };
+    mcd_query_cmds_table[cmd_number] = query_system;
+    cmd_number++;
+
+    MCDCmdParseEntry query_cores = {
+        .handler = handle_query_cores,
+        .cmd = QUERY_ARG_CORES,
+    };
+    mcd_query_cmds_table[cmd_number] = query_cores;
+    cmd_number++;
+}
 
 /**
  * mcd_set_stop_cpu() - Sets c_cpu to the just stopped CPU.
@@ -924,3 +1171,124 @@ int mcdserver_start(const char *device)
 
     return 0;
 }
+
+void parse_reg_xml(const char *xml, int size, GArray* registers,
+    uint8_t reg_type, uint32_t reg_id_offset)
+{
+    /* iterates over the complete xml file */
+    int i, j;
+    uint32_t current_reg_id = reg_id_offset;
+    uint32_t internal_id = 0;
+    int still_to_skip = 0;
+    char argument[64] = {0};
+    char value[64] = {0};
+    bool is_reg = false;
+    bool is_argument = false;
+    bool is_value = false;
+    GArray *reg_data = NULL;
+
+    char c;
+    char *c_ptr;
+
+    xml_attrib attribute_j;
+    const char *argument_j;
+    const char *value_j;
+
+    for (i = 0; i < size; i++) {
+        c = xml[i];
+        c_ptr = &c;
+
+        if (still_to_skip > 0) {
+            /* skip unwanted chars */
+            still_to_skip--;
+            continue;
+        }
+
+        if (strncmp(&xml[i], "<reg", 4) == 0) {
+            /* start of a register */
+            still_to_skip = 3;
+            is_reg = true;
+            reg_data = g_array_new(false, true, sizeof(xml_attrib));
+        } else if (is_reg) {
+            if (strncmp(&xml[i], "/>", 2) == 0) {
+                /* end of register info */
+                still_to_skip = 1;
+                is_reg = false;
+
+                /* create empty register */
+                mcd_reg_st my_register = (const struct mcd_reg_st){ 0 };
+
+                /* add found attribtues */
+                for (j = 0; j < reg_data->len; j++) {
+                    attribute_j = g_array_index(reg_data, xml_attrib, j);
+
+                    argument_j = attribute_j.argument;
+                    value_j = attribute_j.value;
+
+                    if (strcmp(argument_j, "name") == 0) {
+                        strcpy(my_register.name, value_j);
+                    } else if (strcmp(argument_j, "regnum") == 0) {
+                        my_register.id = atoi(value_j);
+                    } else if (strcmp(argument_j, "bitsize") == 0) {
+                        my_register.bitsize = atoi(value_j);
+                    } else if (strcmp(argument_j, "type") == 0) {
+                        strcpy(my_register.type, value_j);
+                    } else if (strcmp(argument_j, "group") == 0) {
+                        strcpy(my_register.group, value_j);
+                    }
+                }
+                /* add reg_type, internal_id and id*/
+                my_register.reg_type = reg_type;
+                my_register.internal_id = internal_id;
+                internal_id++;
+                if (!my_register.id) {
+                    my_register.id = current_reg_id;
+                    current_reg_id++;
+                } else {
+                    /* set correct ID for the next register */
+                    current_reg_id = my_register.id + 1;
+                }
+                /* store register */
+                g_array_append_vals(registers, (gconstpointer)&my_register, 1);
+                /* free memory */
+                g_array_free(reg_data, false);
+            } else {
+                /* store info for register */
+                switch (c) {
+                case ' ':
+                    break;
+                case '=':
+                    is_argument = false;
+                    break;
+                case '"':
+                    if (is_value) {
+                        /* end of value reached */
+                        is_value = false;
+                        /* store arg-val combo */
+                        xml_attrib current_attribute;
+                        strcpy(current_attribute.argument, argument);
+                        strcpy(current_attribute.value, value);
+                        g_array_append_vals(reg_data,
+                        (gconstpointer)&current_attribute, 1);
+                        memset(argument, 0, sizeof(argument));
+                        memset(value, 0, sizeof(value));
+                    } else {
+                        /*start of value */
+                        is_value = true;
+                    }
+                    break;
+                default:
+                    if (is_argument) {
+                        strncat(argument, c_ptr, 1);
+                    } else if (is_value) {
+                        strncat(value, c_ptr, 1);
+                    } else {
+                        is_argument = true;
+                        strncat(argument, c_ptr, 1);
+                    }
+                    break;
+                }
+            }
+        }
+    }
+}
diff --git a/debug/mcdstub/meson.build b/debug/mcdstub/meson.build
index 7e5ae878b0..3051a4e731 100644
--- a/debug/mcdstub/meson.build
+++ b/debug/mcdstub/meson.build
@@ -1,6 +1,6 @@
 # only system emulation is supported over mcd
 mcd_system_ss = ss.source_set()
-mcd_system_ss.add(files('mcdstub.c'))
+mcd_system_ss.add(files('mcdstub.c', 'arm_mcdstub.c'))
 mcd_system_ss = mcd_system_ss.apply(config_host, strict: false)
 
 libmcd_system = static_library('mcd_system',
diff --git a/include/mcdstub/arm_mcdstub.h b/include/mcdstub/arm_mcdstub.h
index c24aaf1202..9961145f07 100644
--- a/include/mcdstub/arm_mcdstub.h
+++ b/include/mcdstub/arm_mcdstub.h
@@ -16,3 +16,88 @@
  *
  * SPDX-License-Identifier: LGPL-2.0+
  */
+
+#ifndef ARM_MCDSTUB_H
+#define ARM_MCDSTUB_H
+
+#include "hw/core/cpu.h"
+#include "mcdstub_common.h"
+/* just used for the register xml files */
+#include "exec/gdbstub.h"
+
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
+    CPUState *cpu);
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
+#endif /* ARM_MCDSTUB_H */
diff --git a/include/mcdstub/mcdstub.h b/include/mcdstub/mcdstub.h
index 26aa33c0e3..ac14b2cda8 100644
--- a/include/mcdstub/mcdstub.h
+++ b/include/mcdstub/mcdstub.h
@@ -151,11 +151,6 @@ typedef struct MCDState {
 /* lives in mcdstub.c */
 extern MCDState mcdserver_state;
 
-typedef struct xml_attrib {
-    char argument[ARGUMENT_STRING_LENGTH];
-    char value[ARGUMENT_STRING_LENGTH];
-} xml_attrib;
-
 typedef struct mcd_reset_st {
     const char *name;
     uint8_t id;
diff --git a/include/mcdstub/mcdstub_common.h b/include/mcdstub/mcdstub_common.h
index b64748c080..d6ff55005e 100644
--- a/include/mcdstub/mcdstub_common.h
+++ b/include/mcdstub/mcdstub_common.h
@@ -61,4 +61,23 @@ typedef struct mcd_reg_group_st {
     uint32_t id;
 } mcd_reg_group_st;
 
+typedef struct xml_attrib {
+    char argument[ARGUMENT_STRING_LENGTH];
+    char value[ARGUMENT_STRING_LENGTH];
+} xml_attrib;
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
-- 
2.34.1


