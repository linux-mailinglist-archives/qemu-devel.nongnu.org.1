Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6C87BB3D7
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 11:07:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qognw-0000ph-34; Fri, 06 Oct 2023 05:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qognc-0008Ma-EZ
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:07:09 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qognZ-00013g-6n
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:07:08 -0400
Received: (qmail 19947 invoked by uid 484); 6 Oct 2023 09:06:53 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.03596 secs); 06 Oct 2023 09:06:53 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP for <qemu-devel@nongnu.org>; 6 Oct 2023 09:06:52 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Christian.Boenig@lauterbach.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicolas Eder <nicolas.eder@lauterbach.com>
Subject: [PATCH v2 23/29] moved all ARM code to the ARM mcdstub and added now
 commom header file
Date: Fri,  6 Oct 2023 11:06:04 +0200
Message-Id: <20231006090610.26171-24-nicolas.eder@lauterbach.com>
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
 mcdstub/mcdstub.c        | 244 ++-------------------------------------
 mcdstub/mcdstub.h        |  64 +---------
 mcdstub/mcdstub_common.h |  46 ++++++++
 target/arm/mcdstub.c     | 231 ++++++++++++++++++++++++++++++++++++
 target/arm/mcdstub.h     |  22 ++++
 5 files changed, 310 insertions(+), 297 deletions(-)
 create mode 100644 mcdstub/mcdstub_common.h

diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index 8e711a0a40..b19ca471ea 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -1192,104 +1192,6 @@ int int_cmp(gconstpointer a, gconstpointer b)
     }
 }
 
-int mcd_arm_store_mem_spaces(CPUState *cpu, GArray *memspaces)
-{
-    int nr_address_spaces = cpu->num_ases;
-    uint32_t mem_space_id = 0;
-
-    /*
-     * TODO: atm we can only access physical memory addresses,
-     * but trace32 needs fake locical spaces to work with
-    */
-
-    mem_space_id++;
-    mcd_mem_space_st non_secure = {
-        .name = "Non Secure",
-        .id = mem_space_id,
-        .type = 34,
-        .bits_per_mau = 8,
-        .invariance = 1,
-        .endian = 1,
-        .min_addr = 0,
-        .max_addr = -1,
-        .supported_access_options = 0,
-        .is_secure = false,
-    };
-    g_array_append_vals(memspaces, (gconstpointer)&non_secure, 1);
-    mem_space_id++;
-    mcd_mem_space_st phys_non_secure = {
-        .name = "Physical (Non Secure)",
-        .id = mem_space_id,
-        .type = 18,
-        .bits_per_mau = 8,
-        .invariance = 1,
-        .endian = 1,
-        .min_addr = 0,
-        .max_addr = -1,
-        .supported_access_options = 0,
-        .is_secure = false,
-    };
-    g_array_append_vals(memspaces, (gconstpointer)&phys_non_secure, 1);
-    if(nr_address_spaces > 1) {
-        mem_space_id++;
-        mcd_mem_space_st secure = {
-            .name = "Secure",
-            .id = mem_space_id,
-            .type = 34,
-            .bits_per_mau = 8,
-            .invariance = 1,
-            .endian = 1,
-            .min_addr = 0,
-            .max_addr = -1,
-            .supported_access_options = 0,
-            .is_secure = true,
-        };
-        g_array_append_vals(memspaces, (gconstpointer)&secure, 1);
-        mem_space_id++;
-        mcd_mem_space_st phys_secure = {
-            .name = "Physical (Secure)",
-            .id = mem_space_id,
-            .type = 18,
-            .bits_per_mau = 8,
-            .invariance = 1,
-            .endian = 1,
-            .min_addr = 0,
-            .max_addr = -1,
-            .supported_access_options = 0,
-            .is_secure = true,
-        };
-        g_array_append_vals(memspaces, (gconstpointer)&phys_secure, 1);
-    }
-    /* TODO: get dynamically how the per (CP15) space is called */
-    mem_space_id++;
-    mcd_mem_space_st gpr = {
-        .name = "GPR Registers",
-        .id = mem_space_id,
-        .type = 1,
-        .bits_per_mau = 8,
-        .invariance = 1,
-        .endian = 1,
-        .min_addr = 0,
-        .max_addr = -1,
-        .supported_access_options = 0,
-    };
-    g_array_append_vals(memspaces, (gconstpointer)&gpr, 1);
-    mem_space_id++;
-    mcd_mem_space_st cpr = {
-        .name = "CP15 Registers",
-        .id = mem_space_id,
-        .type = 1,
-        .bits_per_mau = 8,
-        .invariance = 1,
-        .endian = 1,
-        .min_addr = 0,
-        .max_addr = -1,
-        .supported_access_options = 0,
-    };
-    g_array_append_vals(memspaces, (gconstpointer)&cpr, 1);
-    return 0;
-}
-
 int init_resets(GArray *resets)
 {
     mcd_reset_st system_reset = { .id = 0, .name = RESET_SYSTEM};
@@ -1360,138 +1262,6 @@ void handle_query_cores(GArray *params, void *user_ctx)
     g_free(arch);
 }
 
-int mcd_arm_parse_core_xml_file(CPUClass *cc, GArray *reggroups,
-    GArray *registers, int *current_group_id)
-{
-    const char *xml_filename = NULL;
-    const char *current_xml_filename = NULL;
-    const char *xml_content = NULL;
-    int i = 0;
-
-    /* 1. get correct file */
-    xml_filename = cc->gdb_core_xml_file;
-    for (i = 0; ; i++) {
-        current_xml_filename = xml_builtin[i][0];
-        if (!current_xml_filename || (strncmp(current_xml_filename,
-            xml_filename, strlen(xml_filename)) == 0
-            && strlen(current_xml_filename) == strlen(xml_filename)))
-            break;
-    }
-    /* without gpr registers we can do nothing */
-    if (!current_xml_filename) {
-        return -1;
-    }
-
-    /* 2. add group for gpr registers */
-    mcd_reg_group_st gprregs = {
-        .name = "GPR Registers",
-        .id = *current_group_id
-    };
-    g_array_append_vals(reggroups, (gconstpointer)&gprregs, 1);
-    *current_group_id = *current_group_id + 1;
-
-    /* 3. parse xml */
-    xml_content = xml_builtin[i][1];
-    parse_reg_xml(xml_content, strlen(xml_content), registers,
-        MCD_ARM_REG_TYPE_GPR);
-    return 0;
-}
-
-int mcd_arm_parse_general_xml_files(CPUState *cpu, GArray *reggroups,
-    GArray *registers, int *current_group_id) {
-    const char *xml_filename = NULL;
-    const char *current_xml_filename = NULL;
-    const char *xml_content = NULL;
-    int i = 0;
-    uint8_t reg_type;
-
-    /* iterate over all gdb xml files*/
-    GDBRegisterState *r;
-    for (r = cpu->gdb_regs; r; r = r->next) {
-        xml_filename = r->xml;
-        xml_content = NULL;
-
-        /* 1. get xml content */
-        xml_content = arm_mcd_get_dynamic_xml(cpu, xml_filename);
-        if (xml_content) {
-            if (strcmp(xml_filename, "system-registers.xml") == 0) {
-                /* these are the coprocessor register */
-                mcd_reg_group_st corprocessorregs = {
-                    .name = "CP15 Registers",
-                    .id = *current_group_id
-                };
-                g_array_append_vals(reggroups,
-                    (gconstpointer)&corprocessorregs, 1);
-                *current_group_id = *current_group_id + 1;
-                reg_type = MCD_ARM_REG_TYPE_CPR;
-            }
-        } else {
-            /* its not a coprocessor xml -> it is a static xml file */
-            for (i = 0; ; i++) {
-                current_xml_filename = xml_builtin[i][0];
-                if (!current_xml_filename || (strncmp(current_xml_filename,
-                    xml_filename, strlen(xml_filename)) == 0
-                    && strlen(current_xml_filename) == strlen(xml_filename)))
-                    break;
-            }
-            if (current_xml_filename) {
-                xml_content = xml_builtin[i][1];
-                /* select correct reg_type */
-                if (strcmp(current_xml_filename, "arm-vfp.xml") == 0) {
-                    reg_type = MCD_ARM_REG_TYPE_VFP;
-                } else if (strcmp(current_xml_filename, "arm-vfp3.xml") == 0) {
-                    reg_type = MCD_ARM_REG_TYPE_VFP;
-                } else if (strcmp(current_xml_filename,
-                    "arm-vfp-sysregs.xml") == 0) {
-                    reg_type = MCD_ARM_REG_TYPE_VFP_SYS;
-                } else if (strcmp(current_xml_filename,
-                    "arm-neon.xml") == 0) {
-                    reg_type = MCD_ARM_REG_TYPE_VFP;
-                } else if (strcmp(current_xml_filename,
-                    "arm-m-profile-mve.xml") == 0) {
-                    reg_type = MCD_ARM_REG_TYPE_MVE;
-                }
-            } else {
-                continue;
-            }
-        }
-        /* 2. parse xml */
-        parse_reg_xml(xml_content, strlen(xml_content), registers, reg_type);
-    }
-    return 0;
-}
-
-int mcd_arm_get_additional_register_info(GArray *reggroups, GArray *registers,
-    CPUState *cpu)
-{
-    mcd_reg_st *current_register;
-    uint32_t i = 0;
-
-    /* iterate over all registers */
-    for (i = 0; i < registers->len; i++) {
-        current_register = &(g_array_index(registers, mcd_reg_st, i));
-        current_register->id = i;
-        /* add mcd_reg_group_id and mcd_mem_space_id */
-        if (strcmp(current_register->group, "cp_regs") == 0) {
-            /* coprocessor registers */
-            current_register->mcd_reg_group_id = 2;
-            current_register->mcd_mem_space_id = 6;
-            /*
-             * get info for opcode
-             * for 32bit the opcode is only 16 bit long
-             * for 64bit it is 32 bit long
-             */
-            current_register->opcode |=
-                arm_mcd_get_opcode(cpu, current_register->internal_id);
-        } else {
-            /* gpr register */
-            current_register->mcd_reg_group_id = 1;
-            current_register->mcd_mem_space_id = 5;
-        }
-    }
-    return 0;
-}
-
 void handle_open_core(GArray *params, void *user_ctx)
 {
     uint32_t cpu_id = get_param(params, 0)->cpu_id;
@@ -1506,28 +1276,28 @@ void handle_open_core(GArray *params, void *user_ctx)
     GArray *reggroups = g_array_new(false, true, sizeof(mcd_reg_group_st));
     GArray *registers = g_array_new(false, true, sizeof(mcd_reg_st));
 
-    if (strcmp(arch, "arm") == 0) {
+    if (strcmp(arch, MCDSTUB_ARCH_ARM) == 0) {
         /* TODO: make group and memspace ids dynamic */
         int current_group_id = 1;
         /* 1. store mem spaces */
-        return_value = mcd_arm_store_mem_spaces(cpu, memspaces);
+        return_value = arm_mcd_store_mem_spaces(cpu, memspaces);
         if (return_value != 0) {
             g_assert_not_reached();
         }
         /* 2. parse core xml */
-        return_value = mcd_arm_parse_core_xml_file(cc, reggroups,
+        return_value = arm_mcd_parse_core_xml_file(cc, reggroups,
             registers, &current_group_id);
         if (return_value != 0) {
             g_assert_not_reached();
         }
         /* 3. parse other xmls */
-        return_value = mcd_arm_parse_general_xml_files(cpu, reggroups,
+        return_value = arm_mcd_parse_general_xml_files(cpu, reggroups,
             registers, &current_group_id);
         if (return_value != 0) {
             g_assert_not_reached();
         }
         /* 4. add additional data the the regs from the xmls */
-        return_value = mcd_arm_get_additional_register_info(reggroups,
+        return_value = arm_mcd_get_additional_register_info(reggroups,
             registers, cpu);
         if (return_value != 0) {
             g_assert_not_reached();
@@ -1939,7 +1709,7 @@ int mcd_read_register(CPUState *cpu, GByteArray *buf, int reg)
     /* 2. read register */
     CPUClass *cc = CPU_GET_CLASS(cpu);
     gchar *arch = cc->gdb_arch_name(cpu);
-    if (strcmp(arch, "arm") == 0) {
+    if (strcmp(arch, MCDSTUB_ARCH_ARM) == 0) {
         g_free(arch);
         return arm_mcd_read_register(cpu, buf, reg_type, internal_id);
     } else {
@@ -1959,7 +1729,7 @@ int mcd_write_register(CPUState *cpu, GByteArray *buf, int reg)
     /* 2. write register */
     CPUClass *cc = CPU_GET_CLASS(cpu);
     gchar *arch = cc->gdb_arch_name(cpu);
-    if (strcmp(arch, "arm") == 0) {
+    if (strcmp(arch, MCDSTUB_ARCH_ARM) == 0) {
         g_free(arch);
         return arm_mcd_write_register(cpu, buf, reg_type, internal_id);
     } else {
diff --git a/mcdstub/mcdstub.h b/mcdstub/mcdstub.h
index a436551bb1..d3f15da180 100644
--- a/mcdstub/mcdstub.h
+++ b/mcdstub/mcdstub.h
@@ -4,8 +4,7 @@
 #include "exec/cpu-common.h"
 #include "chardev/char.h"
 #include "hw/core/cpu.h"
-/* just used for the register xml files */
-#include "exec/gdbstub.h"
+#include "mcdstub_common.h"
 
 #define MAX_PACKET_LENGTH 1024
 
@@ -44,7 +43,9 @@ enum {
 #define QUERY_TOTAL_NUMBER 12
 #define CMD_SCHEMA_LENGTH 6
 #define MCD_SYSTEM_NAME "qemu-system"
-#define ARGUMENT_STRING_LENGTH 64
+
+/* supported architectures */
+#define MCDSTUB_ARCH_ARM "arm"
 
 /* tcp query packet values templates */
 #define DEVICE_NAME_TEMPLATE(s) "qemu-" #s "-device"
@@ -63,16 +64,6 @@ enum {
 #define STATE_STR_BREAK_RW(d) "stopped beacuse of read or write access at " #d
 #define STATE_STR_BREAK_UNKNOWN "stopped for unknown reason"
 
-typedef struct GDBRegisterState {
-    /* needed for the used gdb functions */
-    int base_reg;
-    int num_regs;
-    gdb_get_reg_cb get_reg;
-    gdb_set_reg_cb set_reg;
-    const char *xml;
-    struct GDBRegisterState *next;
-} GDBRegisterState;
-
 typedef struct MCDProcess {
     uint32_t pid;
     bool attached;
@@ -160,48 +151,11 @@ typedef struct MCDState {
 /* lives in main mcdstub.c */
 extern MCDState mcdserver_state;
 
-typedef struct mcd_mem_space_st {
-    const char *name;
-    uint32_t id;
-    uint32_t type;
-    uint32_t bits_per_mau;
-    uint8_t invariance;
-    uint32_t endian;
-    uint64_t min_addr;
-    uint64_t max_addr;
-    uint32_t supported_access_options;
-    /* internal */
-    bool is_secure;
-} mcd_mem_space_st;
-
-typedef struct mcd_reg_group_st {
-    const char *name;
-    uint32_t id;
-} mcd_reg_group_st;
-
 typedef struct xml_attrib {
     char argument[ARGUMENT_STRING_LENGTH];
     char value[ARGUMENT_STRING_LENGTH];
 } xml_attrib;
 
-typedef struct mcd_reg_st {
-    /* xml info */
-    char name[ARGUMENT_STRING_LENGTH];
-    char group[ARGUMENT_STRING_LENGTH];
-    char type[ARGUMENT_STRING_LENGTH];
-    uint32_t bitsize;
-    uint32_t id; /* id used by the mcd interface */
-    uint32_t internal_id; /* id inside reg type */
-    uint8_t reg_type;
-    /* mcd metadata */
-    uint32_t mcd_reg_group_id;
-    uint32_t mcd_mem_space_id;
-    uint32_t mcd_reg_type;
-    uint32_t mcd_hw_thread_id;
-    /* data for op-code */
-    uint32_t opcode;
-} mcd_reg_st;
-
 typedef struct mcd_reset_st {
     const char *name;
     uint8_t id;
@@ -291,8 +245,6 @@ void handle_query_mem_spaces_c(GArray *params, void *user_ctx);
 void handle_query_regs_f(GArray *params, void *user_ctx);
 void handle_query_regs_c(GArray *params, void *user_ctx);
 void handle_open_server(GArray *params, void *user_ctx);
-void parse_reg_xml(const char *xml, int size, GArray* registers,
-    uint8_t reg_type);
 void handle_reset(GArray *params, void *user_ctx);
 void handle_query_state(GArray *params, void *user_ctx);
 void handle_read_register(GArray *params, void *user_ctx);
@@ -308,14 +260,6 @@ void handle_breakpoint_remove(GArray *params, void *user_ctx);
 int mcd_breakpoint_insert(CPUState *cpu, int type, vaddr addr);
 int mcd_breakpoint_remove(CPUState *cpu, int type, vaddr addr);
 
-/* arm specific functions */
-int mcd_arm_store_mem_spaces(CPUState *cpu, GArray *memspaces);
-int mcd_arm_parse_core_xml_file(CPUClass *cc, GArray *reggroups,
-    GArray *registers, int *current_group_id);
-int mcd_arm_parse_general_xml_files(CPUState *cpu, GArray* reggroups,
-    GArray *registers, int *current_group_id);
-int mcd_arm_get_additional_register_info(GArray *reggroups, GArray *registers,
-    CPUState *cpu);
 /* sycall handling */
 void mcd_syscall_reset(void);
 void mcd_disable_syscalls(void);
diff --git a/mcdstub/mcdstub_common.h b/mcdstub/mcdstub_common.h
new file mode 100644
index 0000000000..f5175e3979
--- /dev/null
+++ b/mcdstub/mcdstub_common.h
@@ -0,0 +1,46 @@
+#ifndef MCDSTUB_COMMON_H
+#define MCDSTUB_COMMON_H
+
+#define ARGUMENT_STRING_LENGTH 64
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
+void parse_reg_xml(const char *xml, int size, GArray* registers,
+    uint8_t reg_type);
+
+#endif /* MCDSTUB_COMMON_H */
diff --git a/target/arm/mcdstub.c b/target/arm/mcdstub.c
index 3a35d1062d..d2a83a3cd9 100644
--- a/target/arm/mcdstub.c
+++ b/target/arm/mcdstub.c
@@ -344,3 +344,234 @@ int arm_mcd_set_scr(CPUState *cs, bool secure)
     }
     return 0;
 }
+
+int arm_mcd_store_mem_spaces(CPUState *cpu, GArray *memspaces)
+{
+    int nr_address_spaces = cpu->num_ases;
+    uint32_t mem_space_id = 0;
+
+    /*
+     * TODO: atm we can only access physical memory addresses,
+     * but trace32 needs fake locical spaces to work with
+    */
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
+    };
+    g_array_append_vals(memspaces, (gconstpointer)&phys_non_secure, 1);
+    if(nr_address_spaces > 1) {
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
+        };
+        g_array_append_vals(memspaces, (gconstpointer)&phys_secure, 1);
+    }
+    /* TODO: get dynamically how the per (CP15) space is called */
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
+        current_xml_filename = xml_builtin[i][0];
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
+    xml_content = xml_builtin[i][1];
+    parse_reg_xml(xml_content, strlen(xml_content), registers,
+        MCD_ARM_REG_TYPE_GPR);
+    return 0;
+}
+
+int arm_mcd_parse_general_xml_files(CPUState *cpu, GArray *reggroups,
+    GArray *registers, int *current_group_id) {
+    const char *xml_filename = NULL;
+    const char *current_xml_filename = NULL;
+    const char *xml_content = NULL;
+    int i = 0;
+    uint8_t reg_type;
+
+    /* iterate over all gdb xml files*/
+    GDBRegisterState *r;
+    for (r = cpu->gdb_regs; r; r = r->next) {
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
+            for (i = 0; ; i++) {
+                current_xml_filename = xml_builtin[i][0];
+                if (!current_xml_filename || (strncmp(current_xml_filename,
+                    xml_filename, strlen(xml_filename)) == 0
+                    && strlen(current_xml_filename) == strlen(xml_filename)))
+                    break;
+            }
+            if (current_xml_filename) {
+                xml_content = xml_builtin[i][1];
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
+        parse_reg_xml(xml_content, strlen(xml_content), registers, reg_type);
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
+        current_register->id = i;
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
diff --git a/target/arm/mcdstub.h b/target/arm/mcdstub.h
index c3b5c1ae8d..1321d5dc07 100644
--- a/target/arm/mcdstub.h
+++ b/target/arm/mcdstub.h
@@ -1,6 +1,21 @@
 #ifndef ARM_MCDSTUB_H
 #define ARM_MCDSTUB_H
 
+#include "hw/core/cpu.h"
+#include "mcdstub/mcdstub_common.h"
+/* just used for the register xml files */
+#include "exec/gdbstub.h"
+
+typedef struct GDBRegisterState {
+    /* needed for the used gdb functions */
+    int base_reg;
+    int num_regs;
+    gdb_get_reg_cb get_reg;
+    gdb_set_reg_cb set_reg;
+    const char *xml;
+    struct GDBRegisterState *next;
+} GDBRegisterState;
+
 /* ids for each different type of register */
 enum {
     MCD_ARM_REG_TYPE_GPR,
@@ -17,5 +32,12 @@ int arm_mcd_write_register(CPUState *cs, GByteArray *mem_buf, uint8_t reg_type,
     uint32_t n);
 uint16_t arm_mcd_get_opcode(CPUState *cs, uint32_t n);
 int arm_mcd_set_scr(CPUState *cs, bool secure);
+int arm_mcd_store_mem_spaces(CPUState *cpu, GArray *memspaces);
+int arm_mcd_parse_core_xml_file(CPUClass *cc, GArray *reggroups,
+    GArray *registers, int *current_group_id);
+int arm_mcd_parse_general_xml_files(CPUState *cpu, GArray* reggroups,
+    GArray *registers, int *current_group_id);
+int arm_mcd_get_additional_register_info(GArray *reggroups, GArray *registers,
+    CPUState *cpu);
 
 #endif /* ARM_MCDSTUB_H */
-- 
2.34.1


