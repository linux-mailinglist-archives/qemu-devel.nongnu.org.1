Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DBD7BB3EF
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 11:09:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qogny-0001DR-IB; Fri, 06 Oct 2023 05:07:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qogna-0008HG-SZ
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:07:06 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qognT-00012I-AD
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:07:06 -0400
Received: (qmail 19868 invoked by uid 484); 6 Oct 2023 09:06:47 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.094354 secs); 06 Oct 2023 09:06:47 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP for <qemu-devel@nongnu.org>; 6 Oct 2023 09:06:45 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Christian.Boenig@lauterbach.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicolas Eder <nicolas.eder@lauterbach.com>
Subject: [PATCH v2 20/29] cp register read/write added
Date: Fri,  6 Oct 2023 11:06:01 +0200
Message-Id: <20231006090610.26171-21-nicolas.eder@lauterbach.com>
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
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
 mcdstub/mcd_shared_defines.h |   1 +
 mcdstub/mcdstub.c            | 117 ++++++++++------
 mcdstub/mcdstub.h            |  18 ++-
 target/arm/mcdstub.c         | 265 ++++++++++++++++++++++++++++++-----
 target/arm/mcdstub.h         |  16 ++-
 5 files changed, 330 insertions(+), 87 deletions(-)

diff --git a/mcdstub/mcd_shared_defines.h b/mcdstub/mcd_shared_defines.h
index 88d556cab1..91d476a555 100644
--- a/mcdstub/mcd_shared_defines.h
+++ b/mcdstub/mcd_shared_defines.h
@@ -74,6 +74,7 @@
 #define TCP_ARGUMENT_AMOUNT_TRIGGER "nr_trigger"
 #define TCP_ARGUMENT_OPTION "option"
 #define TCP_ARGUMENT_ACTION "action"
+#define TCP_ARGUMENT_OPCODE "opcode"
 
 /* for packets sent to qemu */
 #define ARGUMENT_SEPARATOR ';'
diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index bd532b0f4c..3772bda0a1 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -1064,10 +1064,12 @@ CPUState *find_cpu(uint32_t thread_id)
 }
 
 
-void parse_reg_xml(const char *xml, int size, GArray *registers)
+void parse_reg_xml(const char *xml, int size, GArray *registers,
+    uint8_t reg_type)
 {
     /* iterates over the complete xml file */
     int i, j;
+    uint32_t internal_id = 0;
     int still_to_skip = 0;
     char argument[64] = {0};
     char value[64] = {0};
@@ -1116,8 +1118,11 @@ void parse_reg_xml(const char *xml, int size, GArray *registers)
 
                     if (strcmp(argument_j, "name") == 0) {
                         strcpy(my_register.name, value_j);
-                    } else if (strcmp(argument_j, "regnum") == 0) {
-                        my_register.id = atoi(value_j);
+                    /*
+                     * we might want to read out the regnum
+                     * } else if (strcmp(argument_j, "regnum") == 0) {
+                     * my_register.internal_id = atoi(value_j);
+                     */
                     } else if (strcmp(argument_j, "bitsize") == 0) {
                         my_register.bitsize = atoi(value_j);
                     } else if (strcmp(argument_j, "type") == 0) {
@@ -1126,6 +1131,10 @@ void parse_reg_xml(const char *xml, int size, GArray *registers)
                         strcpy(my_register.group, value_j);
                     }
                 }
+                /* add reg_type and internal id */
+                my_register.reg_type = reg_type;
+                my_register.internal_id = internal_id;
+                internal_id++;
                 /* store register */
                 g_array_append_vals(registers, (gconstpointer)&my_register, 1);
                 /* free memory */
@@ -1238,6 +1247,7 @@ int mcd_arm_store_mem_spaces(CPUState *cpu, GArray *memspaces)
     };
     g_array_append_vals(memspaces, (gconstpointer)&space4, 1);
     }
+
     /* TODO: get dynamically how the per (CP15) space is called */
     mcd_mem_space_st space5 = {
         .name = "GPR Registers",
@@ -1263,7 +1273,6 @@ int mcd_arm_store_mem_spaces(CPUState *cpu, GArray *memspaces)
         .supported_access_options = 0,
     };
     g_array_append_vals(memspaces, (gconstpointer)&space6, 1);
-
     return 0;
 }
 
@@ -1366,7 +1375,8 @@ int mcd_arm_parse_core_xml_file(CPUClass *cc, GArray *reggroups,
 
     /* 3. parse xml */
     xml_content = xml_builtin[i][1];
-    parse_reg_xml(xml_content, strlen(xml_content), registers);
+    parse_reg_xml(xml_content, strlen(xml_content), registers,
+        MCD_ARM_REG_TYPE_GPR);
     return 0;
 }
 
@@ -1376,6 +1386,7 @@ int mcd_arm_parse_general_xml_files(CPUState *cpu, GArray *reggroups,
     const char *current_xml_filename = NULL;
     const char *xml_content = NULL;
     int i = 0;
+    uint8_t reg_type;
 
     /* iterate over all gdb xml files*/
     GDBRegisterState *r;
@@ -1395,6 +1406,7 @@ int mcd_arm_parse_general_xml_files(CPUState *cpu, GArray *reggroups,
                 g_array_append_vals(reggroups,
                     (gconstpointer)&corprocessorregs, 1);
                 *current_group_id = *current_group_id + 1;
+                reg_type = MCD_ARM_REG_TYPE_CPR;
             }
         } else {
             /* its not a coprocessor xml -> it is a static xml file */
@@ -1407,58 +1419,59 @@ int mcd_arm_parse_general_xml_files(CPUState *cpu, GArray *reggroups,
             }
             if (current_xml_filename) {
                 xml_content = xml_builtin[i][1];
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
             } else {
                 continue;
             }
         }
         /* 2. parse xml */
-        parse_reg_xml(xml_content, strlen(xml_content), registers);
+        parse_reg_xml(xml_content, strlen(xml_content), registers, reg_type);
     }
     return 0;
 }
 
-int mcd_arm_get_additional_register_info(GArray *reggroups, GArray *registers)
+int mcd_arm_get_additional_register_info(GArray *reggroups, GArray *registers,
+    CPUState *cpu)
 {
-    GList *register_numbers = NULL;
     mcd_reg_st *current_register;
-    int i = 0;
-    int id_neg_offset = 0;
-    int effective_id = 0;
+    uint32_t i = 0;
 
     /* iterate over all registers */
     for (i = 0; i < registers->len; i++) {
         current_register = &(g_array_index(registers, mcd_reg_st, i));
-        /* 1. ad the id */
-        if (current_register->id) {
-            /*
-             *id is already in place
-             *NOTE: qemu doesn't emulate the FPA regs
-             *(so we are missing the indices 16 to 24)
-             */
-            int used_id = current_register->id;
-            register_numbers = g_list_append(register_numbers, &used_id);
-            id_neg_offset++;
-        } else {
-            effective_id = i - id_neg_offset;
-            if (g_list_find_custom(register_numbers, &effective_id,
-                (GCompareFunc)int_cmp) != NULL) {
-                id_neg_offset--;
-            }
-            current_register->id = i - id_neg_offset;
-        }
-        /* 2. add mcd_reg_group_id and mcd_mem_space_id */
+        current_register->id = i;
+        /* add mcd_reg_group_id and mcd_mem_space_id */
         if (strcmp(current_register->group, "cp_regs") == 0) {
             /* coprocessor registers */
             current_register->mcd_reg_group_id = 2;
             current_register->mcd_mem_space_id = 6;
-            /* TODO: get info for opcode */
+            /*
+             * get info for opcode
+             * for 32bit the opcode is only 16 bit long
+             * for 64bit it is 32 bit long
+             */
+            current_register->opcode |=
+                arm_mcd_get_opcode(cpu, current_register->internal_id);
         } else {
             /* gpr register */
             current_register->mcd_reg_group_id = 1;
             current_register->mcd_mem_space_id = 5;
         }
     }
-    g_list_free(register_numbers);
     return 0;
 }
 
@@ -1498,7 +1511,7 @@ void handle_open_core(GArray *params, void *user_ctx)
         }
         /* 4. add additional data the the regs from the xmls */
         return_value = mcd_arm_get_additional_register_info(reggroups,
-            registers);
+            registers, cpu);
         if (return_value != 0) {
             g_assert_not_reached();
         }
@@ -1797,13 +1810,15 @@ void handle_query_regs_f(GArray *params, void *user_ctx)
     /* 3. send data */
     mcd_reg_st my_register = g_array_index(registers, mcd_reg_st, 0);
     g_string_append_printf(mcdserver_state.str_buf,
-        "%s=%d.%s=%s.%s=%d.%s=%d.%s=%d.%s=%d.%s=%d.",
-        TCP_ARGUMENT_ID, my_register.id, TCP_ARGUMENT_NAME,
-        my_register.name, TCP_ARGUMENT_SIZE, my_register.bitsize,
+        "%s=%u.%s=%s.%s=%u.%s=%u.%s=%u.%s=%u.%s=%u.%s=%u.",
+        TCP_ARGUMENT_ID, my_register.id,
+        TCP_ARGUMENT_NAME, my_register.name,
+        TCP_ARGUMENT_SIZE, my_register.bitsize,
         TCP_ARGUMENT_REGGROUPID, my_register.mcd_reg_group_id,
         TCP_ARGUMENT_MEMSPACEID, my_register.mcd_mem_space_id,
         TCP_ARGUMENT_TYPE, my_register.mcd_reg_type,
-        TCP_ARGUMENT_THREAD, my_register.mcd_hw_thread_id);
+        TCP_ARGUMENT_THREAD, my_register.mcd_hw_thread_id,
+        TCP_ARGUMENT_OPCODE, my_register.opcode);
     mcd_put_strbuf();
 }
 
@@ -1829,13 +1844,15 @@ void handle_query_regs_c(GArray *params, void *user_ctx)
     /* 3. send the correct register */
     mcd_reg_st my_register = g_array_index(registers, mcd_reg_st, query_index);
     g_string_append_printf(mcdserver_state.str_buf,
-        "%s=%d.%s=%s.%s=%d.%s=%d.%s=%d.%s=%d.%s=%d.",
-        TCP_ARGUMENT_ID, my_register.id, TCP_ARGUMENT_NAME,
-        my_register.name, TCP_ARGUMENT_SIZE, my_register.bitsize,
+        "%s=%u.%s=%s.%s=%u.%s=%u.%s=%u.%s=%u.%s=%u.%s=%u.",
+        TCP_ARGUMENT_ID, my_register.id,
+        TCP_ARGUMENT_NAME, my_register.name,
+        TCP_ARGUMENT_SIZE, my_register.bitsize,
         TCP_ARGUMENT_REGGROUPID, my_register.mcd_reg_group_id,
         TCP_ARGUMENT_MEMSPACEID, my_register.mcd_mem_space_id,
         TCP_ARGUMENT_TYPE, my_register.mcd_reg_type,
-        TCP_ARGUMENT_THREAD, my_register.mcd_hw_thread_id);
+        TCP_ARGUMENT_THREAD, my_register.mcd_hw_thread_id,
+        TCP_ARGUMENT_OPCODE, my_register.opcode);
     mcd_put_strbuf();
 }
 
@@ -1889,11 +1906,18 @@ void handle_query_state(GArray *params, void *user_ctx)
 
 int mcd_read_register(CPUState *cpu, GByteArray *buf, int reg)
 {
+    /* 1. get reg type and internal id */
+    GArray *registers =
+        g_list_nth_data(mcdserver_state.all_registers, cpu->cpu_index);
+    mcd_reg_st desired_register = g_array_index(registers, mcd_reg_st, reg);
+    uint8_t reg_type = desired_register.reg_type;
+    uint32_t internal_id = desired_register.internal_id;
+    /* 2. read register */
     CPUClass *cc = CPU_GET_CLASS(cpu);
     gchar *arch = cc->gdb_arch_name(cpu);
     if (strcmp(arch, "arm") == 0) {
         g_free(arch);
-        return arm_mcd_read_register(cpu, buf, reg);
+        return arm_mcd_read_register(cpu, buf, reg_type, internal_id);
     } else {
         g_free(arch);
         return 0;
@@ -1902,11 +1926,18 @@ int mcd_read_register(CPUState *cpu, GByteArray *buf, int reg)
 
 int mcd_write_register(CPUState *cpu, GByteArray *buf, int reg)
 {
+    /* 1. get reg type and internal id */
+    GArray *registers =
+        g_list_nth_data(mcdserver_state.all_registers, cpu->cpu_index);
+    mcd_reg_st desired_register = g_array_index(registers, mcd_reg_st, reg);
+    uint8_t reg_type = desired_register.reg_type;
+    uint32_t internal_id = desired_register.internal_id;
+    /* 2. write register */
     CPUClass *cc = CPU_GET_CLASS(cpu);
     gchar *arch = cc->gdb_arch_name(cpu);
     if (strcmp(arch, "arm") == 0) {
         g_free(arch);
-        return arm_mcd_write_register(cpu, buf, reg);
+        return arm_mcd_write_register(cpu, buf, reg_type, internal_id);
     } else {
         g_free(arch);
         return 0;
diff --git a/mcdstub/mcdstub.h b/mcdstub/mcdstub.h
index 7a63a01a39..25475acaf7 100644
--- a/mcdstub/mcdstub.h
+++ b/mcdstub/mcdstub.h
@@ -203,19 +203,16 @@ typedef struct mcd_reg_st {
     char group[64];
     char type[64];
     uint32_t bitsize;
-    uint32_t id;
+    uint32_t id; /* id used by the mcd interface */
+    uint32_t internal_id; /* id inside reg type */
+    uint8_t reg_type;
     /* mcd metadata */
     uint32_t mcd_reg_group_id;
     uint32_t mcd_mem_space_id;
     uint32_t mcd_reg_type;
     uint32_t mcd_hw_thread_id;
     /* data for op-code */
-    uint8_t cp;
-    uint8_t crn;
-    uint8_t crm;
-    uint8_t opc0; /* <- might not be needed! */
-    uint8_t opc1;
-    uint8_t opc2;
+    uint32_t opcode;
 } mcd_reg_st;
 
 typedef struct mcd_reset_st {
@@ -307,7 +304,8 @@ void handle_query_mem_spaces_c(GArray *params, void *user_ctx);
 void handle_query_regs_f(GArray *params, void *user_ctx);
 void handle_query_regs_c(GArray *params, void *user_ctx);
 void handle_open_server(GArray *params, void *user_ctx);
-void parse_reg_xml(const char *xml, int size, GArray* registers);
+void parse_reg_xml(const char *xml, int size, GArray* registers,
+    uint8_t reg_type);
 void handle_reset(GArray *params, void *user_ctx);
 void handle_query_state(GArray *params, void *user_ctx);
 void handle_read_register(GArray *params, void *user_ctx);
@@ -329,8 +327,8 @@ int mcd_arm_parse_core_xml_file(CPUClass *cc, GArray *reggroups,
     GArray *registers, int *current_group_id);
 int mcd_arm_parse_general_xml_files(CPUState *cpu, GArray* reggroups,
     GArray *registers, int *current_group_id);
-int mcd_arm_get_additional_register_info(GArray *reggroups, GArray *registers);
-
+int mcd_arm_get_additional_register_info(GArray *reggroups, GArray *registers,
+    CPUState *cpu);
 /* sycall handling */
 void mcd_syscall_reset(void);
 void mcd_disable_syscalls(void);
diff --git a/target/arm/mcdstub.c b/target/arm/mcdstub.c
index e4e632d3f3..c0bd5bb545 100644
--- a/target/arm/mcdstub.c
+++ b/target/arm/mcdstub.c
@@ -17,6 +17,31 @@ static inline int mcd_get_reg32(GByteArray *buf, uint32_t val)
     return 4;
 }
 
+static inline int mcd_get_reg64(GByteArray *buf, uint64_t val)
+{
+    uint64_t to_quad = tswap64(val);
+    g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
+    return 8;
+}
+
+static inline int mcd_get_reg128(GByteArray *buf, uint64_t val_hi,
+                                 uint64_t val_lo)
+{
+    uint64_t to_quad;
+#if TARGET_BIG_ENDIAN
+    to_quad = tswap64(val_hi);
+    g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
+    to_quad = tswap64(val_lo);
+    g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
+#else
+    to_quad = tswap64(val_lo);
+    g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
+    to_quad = tswap64(val_hi);
+    g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
+#endif
+    return 16;
+}
+
 static inline int mcd_get_zeroes(GByteArray *array, size_t len)
 {
     /*TODO: move this to a separate file */
@@ -45,24 +70,13 @@ const char *arm_mcd_get_dynamic_xml(CPUState *cs, const char *xmlname)
     return NULL;
 }
 
-int arm_mcd_read_register(CPUState *cs, GByteArray *mem_buf, int n)
+static int arm_mcd_read_gpr_register(CPUARMState *env, GByteArray *mem_buf,
+    uint32_t n)
 {
-    ARMCPU *cpu = ARM_CPU(cs);
-    CPUARMState *env = &cpu->env;
-
     if (n < 16) {
         /* Core integer register.  */
         return mcd_get_reg32(mem_buf, env->regs[n]);
-    }
-    if (n < 24) {
-        /* TODO: these numbers don't match mine */
-        return mcd_get_zeroes(mem_buf, 12);
-    }
-    switch (n) {
-    case 24:
-        /* TODO: these numbers don't match mine */
-        return mcd_get_reg32(mem_buf, 0);
-    case 25:
+    } else if (n == 16) {
         /* CPSR, or XPSR for M-profile */
         if (arm_feature(env, ARM_FEATURE_M)) {
             return mcd_get_reg32(mem_buf, xpsr_read(env));
@@ -70,21 +84,17 @@ int arm_mcd_read_register(CPUState *cs, GByteArray *mem_buf, int n)
             return mcd_get_reg32(mem_buf, cpsr_read(env));
         }
     }
-    /* TODO: add funcitons for the remaining regs (including cp_regs) */
     return 0;
 }
 
-int arm_mcd_write_register(CPUState *cs, GByteArray *mem_buf, int n)
+static int arm_mcd_write_gpr_register(CPUARMState *env, uint8_t *mem_buf,
+    uint32_t n)
 {
-    ARMCPU *cpu = ARM_CPU(cs);
-    CPUARMState *env = &cpu->env;
     uint32_t tmp;
 
     tmp = ldl_p(mem_buf);
-    tmp = *((uint32_t *)mem_buf->data);
-
     /*
-     * Mask out low bits of PC to workaround gdb bugs.
+     * Mask out low bits of PC
      * This avoids an assert in thumb_tr_translate_insn, because it is
      * architecturally impossible to misalign the pc.
      * This will probably cause problems if we ever implement the
@@ -102,16 +112,7 @@ int arm_mcd_write_register(CPUState *cs, GByteArray *mem_buf, int n)
         }
         env->regs[n] = tmp;
         return 4;
-    }
-    if (n < 24) { /* 16-23 */
-        /* FPA registers (ignored).  */
-        return 4;
-    }
-    switch (n) {
-    case 24:
-        /* FPA status register (ignored).  */
-        return 4;
-    case 25:
+    } else if (n == 16) {
         /* CPSR, or XPSR for M-profile */
         if (arm_feature(env, ARM_FEATURE_M)) {
             /*
@@ -126,6 +127,206 @@ int arm_mcd_write_register(CPUState *cs, GByteArray *mem_buf, int n)
         }
         return 4;
     }
-    /* TODO: add funcitons for the remaining regs (including cp_regs) */
+    return 0;
+}
+
+static int arm_mcd_read_vfp_register(CPUARMState *env, GByteArray *buf,
+    uint32_t reg)
+{
+    ARMCPU *cpu = env_archcpu(env);
+    int nregs = cpu_isar_feature(aa32_simd_r32, cpu) ? 32 : 16;
+
+    /* VFP data registers are always little-endian.  */
+    if (reg < nregs) {
+        return mcd_get_reg64(buf, *aa32_vfp_dreg(env, reg));
+    }
+    if (arm_feature(env, ARM_FEATURE_NEON)) {
+        /* Aliases for Q regs.  */
+        nregs += 16;
+        if (reg < nregs) {
+            uint64_t *q = aa32_vfp_qreg(env, reg - 32);
+            return mcd_get_reg128(buf, q[0], q[1]);
+        }
+    }
+    switch (reg - nregs) {
+    case 0:
+        return mcd_get_reg32(buf, vfp_get_fpscr(env));
+    }
+    return 0;
+}
+
+static int arm_mcd_write_vfp_register(CPUARMState *env, uint8_t *buf,
+    uint32_t reg)
+{
+    ARMCPU *cpu = env_archcpu(env);
+    int nregs = cpu_isar_feature(aa32_simd_r32, cpu) ? 32 : 16;
+
+    if (reg < nregs) {
+        *aa32_vfp_dreg(env, reg) = ldq_le_p(buf);
+        return 8;
+    }
+    if (arm_feature(env, ARM_FEATURE_NEON)) {
+        nregs += 16;
+        if (reg < nregs) {
+            uint64_t *q = aa32_vfp_qreg(env, reg - 32);
+            q[0] = ldq_le_p(buf);
+            q[1] = ldq_le_p(buf + 8);
+            return 16;
+        }
+    }
+    switch (reg - nregs) {
+    case 0:
+        vfp_set_fpscr(env, ldl_p(buf));
+        return 4;
+    }
+    return 0;
+}
+
+static int arm_mcd_read_vfp_sys_register(CPUARMState *env, GByteArray *buf,
+    uint32_t reg)
+{
+    switch (reg) {
+    case 0:
+        return mcd_get_reg32(buf, env->vfp.xregs[ARM_VFP_FPSID]);
+    case 1:
+        return mcd_get_reg32(buf, env->vfp.xregs[ARM_VFP_FPEXC]);
+    }
+    return 0;
+}
+
+static int arm_mcd_write_vfp_sys_register(CPUARMState *env, uint8_t *buf,
+    uint32_t reg)
+{
+    switch (reg) {
+    case 0:
+        env->vfp.xregs[ARM_VFP_FPSID] = ldl_p(buf);
+        return 4;
+    case 1:
+        env->vfp.xregs[ARM_VFP_FPEXC] = ldl_p(buf) & (1 << 30);
+        return 4;
+    }
+    return 0;
+}
+
+static int arm_mcd_read_mve_register(CPUARMState *env, GByteArray *buf,
+    uint32_t reg)
+{
+    switch (reg) {
+    case 0:
+        return mcd_get_reg32(buf, env->v7m.vpr);
+    default:
+        return 0;
+    }
+}
+
+static int arm_mcd_write_mve_register(CPUARMState *env, uint8_t *buf,
+    uint32_t reg)
+{
+    switch (reg) {
+    case 0:
+        env->v7m.vpr = ldl_p(buf);
+        return 4;
+    default:
+        return 0;
+    }
+}
+
+static int arm_mcd_read_cpr_register(CPUARMState *env, GByteArray *buf,
+    uint32_t reg)
+{
+    ARMCPU *cpu = env_archcpu(env);
+    const ARMCPRegInfo *ri;
+    uint32_t key;
+
+    key = cpu->dyn_sysreg_xml.data.cpregs.keys[reg];
+    ri = get_arm_cp_reginfo(cpu->cp_regs, key);
+    if (ri) {
+        if (cpreg_field_is_64bit(ri)) {
+            return mcd_get_reg64(buf, (uint64_t)read_raw_cp_reg(env, ri));
+        } else {
+            return mcd_get_reg32(buf, (uint32_t)read_raw_cp_reg(env, ri));
+        }
+    }
+    return 0;
+}
+
+static int arm_mcd_write_cpr_register(CPUARMState *env, uint8_t *buf,
+    uint32_t reg)
+{
+    /* try write_raw_cp_reg here*/
+    return 0;
+}
+
+int arm_mcd_read_register(CPUState *cs, GByteArray *mem_buf, uint8_t reg_type,
+    uint32_t n)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+    switch (reg_type) {
+    case MCD_ARM_REG_TYPE_GPR:
+        return arm_mcd_read_gpr_register(env, mem_buf, n);
+        break;
+    case MCD_ARM_REG_TYPE_VFP:
+        return arm_mcd_read_vfp_register(env, mem_buf, n);
+        break;
+    case MCD_ARM_REG_TYPE_VFP_SYS:
+        return arm_mcd_read_vfp_sys_register(env, mem_buf, n);
+        break;
+    case MCD_ARM_REG_TYPE_MVE:
+        return arm_mcd_read_mve_register(env, mem_buf, n);
+        break;
+    case MCD_ARM_REG_TYPE_CPR:
+        return arm_mcd_read_cpr_register(env, mem_buf, n);
+        break;
+    default:
+        /* unknown register type*/
+        return 0;
+    }
+}
+
+int arm_mcd_write_register(CPUState *cs, GByteArray *mem_buf, uint8_t reg_type,
+    uint32_t n)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+    switch (reg_type) {
+    case MCD_ARM_REG_TYPE_GPR:
+        return arm_mcd_write_gpr_register(env, mem_buf->data, n);
+        break;
+    case MCD_ARM_REG_TYPE_VFP:
+        return arm_mcd_write_vfp_register(env, mem_buf->data, n);
+        break;
+    case MCD_ARM_REG_TYPE_VFP_SYS:
+        return arm_mcd_write_vfp_sys_register(env, mem_buf->data, n);
+        break;
+    case MCD_ARM_REG_TYPE_MVE:
+        return arm_mcd_write_mve_register(env, mem_buf->data, n);
+        break;
+    case MCD_ARM_REG_TYPE_CPR:
+        return arm_mcd_write_cpr_register(env, mem_buf->data, n);
+        break;
+    default:
+        /* unknown register type*/
+        return 0;
+    }
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
     return 0;
 }
diff --git a/target/arm/mcdstub.h b/target/arm/mcdstub.h
index 28c7f2baec..81d67246d8 100644
--- a/target/arm/mcdstub.h
+++ b/target/arm/mcdstub.h
@@ -1,8 +1,20 @@
 #ifndef ARM_MCDSTUB_H
 #define ARM_MCDSTUB_H
 
+/* ids for each different type of register */
+enum {
+    MCD_ARM_REG_TYPE_GPR,
+    MCD_ARM_REG_TYPE_VFP,
+    MCD_ARM_REG_TYPE_VFP_SYS,
+    MCD_ARM_REG_TYPE_MVE,
+    MCD_ARM_REG_TYPE_CPR,
+};
+
 const char *arm_mcd_get_dynamic_xml(CPUState *cs, const char *xmlname);
-int arm_mcd_read_register(CPUState *cs, GByteArray *mem_buf, int n);
-int arm_mcd_write_register(CPUState *cs, GByteArray *mem_buf, int n);
+int arm_mcd_read_register(CPUState *cs, GByteArray *mem_buf, uint8_t reg_type,
+    uint32_t n);
+int arm_mcd_write_register(CPUState *cs, GByteArray *mem_buf, uint8_t reg_type,
+    uint32_t n);
+uint16_t arm_mcd_get_opcode(CPUState *cs, uint32_t n);
 
 #endif /* ARM_MCDSTUB_H */
-- 
2.34.1


