Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5053B7BB3E7
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 11:08:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qognt-0000Hq-9A; Fri, 06 Oct 2023 05:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qognZ-0008HA-NN
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:07:06 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qognV-00012p-MI
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:07:05 -0400
Received: (qmail 19894 invoked by uid 484); 6 Oct 2023 09:06:49 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.333814 secs); 06 Oct 2023 09:06:49 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP for <qemu-devel@nongnu.org>; 6 Oct 2023 09:06:47 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Christian.Boenig@lauterbach.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicolas Eder <nicolas.eder@lauterbach.com>
Subject: [PATCH v2 21/29] switching between secure and non-secure memory added
Date: Fri,  6 Oct 2023 11:06:02 +0200
Message-Id: <20231006090610.26171-22-nicolas.eder@lauterbach.com>
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
 mcdstub/mcdstub.c    | 131 +++++++++++++++++++++++++++----------------
 mcdstub/mcdstub.h    |   4 +-
 target/arm/mcdstub.c |  14 +++++
 target/arm/mcdstub.h |   1 +
 4 files changed, 100 insertions(+), 50 deletions(-)

diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index 3772bda0a1..7d8ce634c8 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -548,8 +548,8 @@ int mcd_handle_packet(const char *line_buf)
             };
             read_mem_cmd_desc.cmd = (char[2]) { TCP_CHAR_READ_MEMORY, '\0' };
             strcpy(read_mem_cmd_desc.schema,
-                (char[4]) { ARG_SCHEMA_CORENUM, ARG_SCHEMA_UINT64_T,
-                ARG_SCHEMA_INT, '\0' });
+                (char[5]) { ARG_SCHEMA_CORENUM, ARG_SCHEMA_INT,
+                ARG_SCHEMA_UINT64_T, ARG_SCHEMA_INT, '\0' });
             cmd_parser = &read_mem_cmd_desc;
         }
         break;
@@ -560,8 +560,9 @@ int mcd_handle_packet(const char *line_buf)
             };
             write_mem_cmd_desc.cmd = (char[2]) { TCP_CHAR_WRITE_MEMORY, '\0' };
             strcpy(write_mem_cmd_desc.schema,
-                (char[5]) { ARG_SCHEMA_CORENUM, ARG_SCHEMA_UINT64_T,
-                ARG_SCHEMA_INT, ARG_SCHEMA_HEXDATA, '\0' });
+                (char[6]) { ARG_SCHEMA_CORENUM, ARG_SCHEMA_INT,
+                ARG_SCHEMA_UINT64_T, ARG_SCHEMA_INT,
+                ARG_SCHEMA_HEXDATA, '\0' });
             cmd_parser = &write_mem_cmd_desc;
         }
         break;
@@ -1194,10 +1195,17 @@ int int_cmp(gconstpointer a, gconstpointer b)
 int mcd_arm_store_mem_spaces(CPUState *cpu, GArray *memspaces)
 {
     int nr_address_spaces = cpu->num_ases;
+    uint32_t mem_space_id = 0;
+
+    /*
+     * TODO: atm we can only access physical memory addresses,
+     * but trace32 needs fake locical spaces to work with
+    */
 
-    mcd_mem_space_st space1 = {
+    mem_space_id++;
+    mcd_mem_space_st non_secure = {
         .name = "Non Secure",
-        .id = 1,
+        .id = mem_space_id,
         .type = 34,
         .bits_per_mau = 8,
         .invariance = 1,
@@ -1205,38 +1213,13 @@ int mcd_arm_store_mem_spaces(CPUState *cpu, GArray *memspaces)
         .min_addr = 0,
         .max_addr = -1,
         .supported_access_options = 0,
+        .is_secure = false,
     };
-    g_array_append_vals(memspaces, (gconstpointer)&space1, 1);
-
-    mcd_mem_space_st space2 = {
+    g_array_append_vals(memspaces, (gconstpointer)&non_secure, 1);
+    mem_space_id++;
+    mcd_mem_space_st phys_non_secure = {
         .name = "Physical (Non Secure)",
-        .id = 2,
-        .type = 18,
-        .bits_per_mau = 8,
-        .invariance = 1,
-        .endian = 1,
-        .min_addr = 0,
-        .max_addr = -1,
-        .supported_access_options = 0,
-    };
-    g_array_append_vals(memspaces, (gconstpointer)&space2, 1);
-
-    if (nr_address_spaces == 2) {
-        mcd_mem_space_st space3 = {
-        .name = "Secure",
-        .id = 3,
-        .type = 34,
-        .bits_per_mau = 8,
-        .invariance = 1,
-        .endian = 1,
-        .min_addr = 0,
-        .max_addr = -1,
-        .supported_access_options = 0,
-    };
-    g_array_append_vals(memspaces, (gconstpointer)&space3, 1);
-    mcd_mem_space_st space4 = {
-        .name = "Physical (Secure)",
-        .id = 4,
+        .id = mem_space_id,
         .type = 18,
         .bits_per_mau = 8,
         .invariance = 1,
@@ -1244,14 +1227,44 @@ int mcd_arm_store_mem_spaces(CPUState *cpu, GArray *memspaces)
         .min_addr = 0,
         .max_addr = -1,
         .supported_access_options = 0,
+        .is_secure = false,
     };
-    g_array_append_vals(memspaces, (gconstpointer)&space4, 1);
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
     }
-
     /* TODO: get dynamically how the per (CP15) space is called */
-    mcd_mem_space_st space5 = {
+    mem_space_id++;
+    mcd_mem_space_st gpr = {
         .name = "GPR Registers",
-        .id = 5,
+        .id = mem_space_id,
         .type = 1,
         .bits_per_mau = 8,
         .invariance = 1,
@@ -1260,10 +1273,11 @@ int mcd_arm_store_mem_spaces(CPUState *cpu, GArray *memspaces)
         .max_addr = -1,
         .supported_access_options = 0,
     };
-    g_array_append_vals(memspaces, (gconstpointer)&space5, 1);
-    mcd_mem_space_st space6 = {
+    g_array_append_vals(memspaces, (gconstpointer)&gpr, 1);
+    mem_space_id++;
+    mcd_mem_space_st cpr = {
         .name = "CP15 Registers",
-        .id = 6,
+        .id = mem_space_id,
         .type = 1,
         .bits_per_mau = 8,
         .invariance = 1,
@@ -1272,7 +1286,7 @@ int mcd_arm_store_mem_spaces(CPUState *cpu, GArray *memspaces)
         .max_addr = -1,
         .supported_access_options = 0,
     };
-    g_array_append_vals(memspaces, (gconstpointer)&space6, 1);
+    g_array_append_vals(memspaces, (gconstpointer)&cpr, 1);
     return 0;
 }
 
@@ -2022,10 +2036,20 @@ int mcd_write_memory(CPUState *cpu, hwaddr addr, uint8_t *buf, int len)
 void handle_read_memory(GArray *params, void *user_ctx)
 {
     uint32_t cpu_id = get_param(params, 0)->cpu_id;
-    uint64_t mem_address = get_param(params, 1)->data_uint64_t;
-    uint32_t len = get_param(params, 2)->data_uint32_t;
+    uint32_t mem_space_id = get_param(params, 1)->data_uint32_t;
+    uint64_t mem_address = get_param(params, 2)->data_uint64_t;
+    uint32_t len = get_param(params, 3)->data_uint32_t;
 
     CPUState *cpu = mcd_get_cpu(cpu_id);
+    /* check if the mem space is secure */
+    GArray *memspaces = g_list_nth_data(mcdserver_state.all_memspaces, cpu_id);
+    mcd_mem_space_st space = g_array_index(memspaces, mcd_mem_space_st,
+        mem_space_id - 1);
+    if (arm_mcd_set_scr(cpu, space.is_secure)) {
+        mcd_put_packet(TCP_EXECUTION_ERROR);
+        return;
+    }
+    /* read memory */
     g_byte_array_set_size(mcdserver_state.mem_buf, len);
     if (mcd_read_memory(cpu, mem_address, mcdserver_state.mem_buf->data,
         mcdserver_state.mem_buf->len) != 0) {
@@ -2040,10 +2064,19 @@ void handle_read_memory(GArray *params, void *user_ctx)
 void handle_write_memory(GArray *params, void *user_ctx)
 {
     uint32_t cpu_id = get_param(params, 0)->cpu_id;
-    uint64_t mem_address = get_param(params, 1)->data_uint64_t;
-    uint32_t len = get_param(params, 2)->data_uint32_t;
-
+    uint32_t mem_space_id = get_param(params, 1)->data_uint32_t;
+    uint64_t mem_address = get_param(params, 2)->data_uint64_t;
+    uint32_t len = get_param(params, 3)->data_uint32_t;
     CPUState *cpu = mcd_get_cpu(cpu_id);
+    /* check if the mem space is secure */
+    GArray *memspaces = g_list_nth_data(mcdserver_state.all_memspaces, cpu_id);
+    mcd_mem_space_st space = g_array_index(memspaces, mcd_mem_space_st,
+        mem_space_id - 1);
+    if (arm_mcd_set_scr(cpu, space.is_secure)) {
+        mcd_put_packet(TCP_EXECUTION_ERROR);
+        return;
+    }
+    /* read memory */
     mcd_hextomem(mcdserver_state.mem_buf, mcdserver_state.str_buf->str, len);
     if (mcd_write_memory(cpu, mem_address,
         mcdserver_state.mem_buf->data, len) != 0) {
diff --git a/mcdstub/mcdstub.h b/mcdstub/mcdstub.h
index 25475acaf7..f8171cba71 100644
--- a/mcdstub/mcdstub.h
+++ b/mcdstub/mcdstub.h
@@ -58,7 +58,7 @@ enum {
 
 /* misc */
 #define QUERY_TOTAL_NUMBER 12
-#define CMD_SCHEMA_LENGTH 5
+#define CMD_SCHEMA_LENGTH 6
 #define MCD_SYSTEM_NAME "qemu-system"
 
 /* tcp query packet values templates */
@@ -185,6 +185,8 @@ typedef struct mcd_mem_space_st {
     uint64_t min_addr;
     uint64_t max_addr;
     uint32_t supported_access_options;
+    /* internal */
+    bool is_secure;
 } mcd_mem_space_st;
 
 typedef struct mcd_reg_group_st {
diff --git a/target/arm/mcdstub.c b/target/arm/mcdstub.c
index c0bd5bb545..8456352370 100644
--- a/target/arm/mcdstub.c
+++ b/target/arm/mcdstub.c
@@ -330,3 +330,17 @@ uint16_t arm_mcd_get_opcode(CPUState *cs, uint32_t n)
     }
     return 0;
 }
+
+int arm_mcd_set_scr(CPUState *cs, bool secure)
+{
+    /* swtiches between secure and non secure mode */
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+    /* set bit 0 to 1 if non secure, to 0 if secure*/
+    if (secure) {
+        env->cp15.scr_el3 &= 0xFFFFFFFE;
+    } else {
+        env->cp15.scr_el3 |= 1;
+    }
+    return 0;
+}
diff --git a/target/arm/mcdstub.h b/target/arm/mcdstub.h
index 81d67246d8..c3b5c1ae8d 100644
--- a/target/arm/mcdstub.h
+++ b/target/arm/mcdstub.h
@@ -16,5 +16,6 @@ int arm_mcd_read_register(CPUState *cs, GByteArray *mem_buf, uint8_t reg_type,
 int arm_mcd_write_register(CPUState *cs, GByteArray *mem_buf, uint8_t reg_type,
     uint32_t n);
 uint16_t arm_mcd_get_opcode(CPUState *cs, uint32_t n);
+int arm_mcd_set_scr(CPUState *cs, bool secure);
 
 #endif /* ARM_MCDSTUB_H */
-- 
2.34.1


