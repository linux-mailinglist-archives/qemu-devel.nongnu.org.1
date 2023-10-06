Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7FB7BB3EA
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 11:08:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qognv-0000fP-Fw; Fri, 06 Oct 2023 05:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qognZ-0008HB-Um
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:07:06 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qognX-00013M-QF
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:07:05 -0400
Received: (qmail 19924 invoked by uid 484); 6 Oct 2023 09:06:52 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.072039 secs); 06 Oct 2023 09:06:52 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP for <qemu-devel@nongnu.org>; 6 Oct 2023 09:06:50 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Christian.Boenig@lauterbach.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicolas Eder <nicolas.eder@lauterbach.com>
Subject: [PATCH v2 22/29] transitioning to unsinged integers in TCP packets
 and removing MCD-API-specific terms
Date: Fri,  6 Oct 2023 11:06:03 +0200
Message-Id: <20231006090610.26171-23-nicolas.eder@lauterbach.com>
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
 mcdstub/mcd_shared_defines.h |  8 ++++
 mcdstub/mcdstub.c            | 74 ++++++++++++++++++++----------------
 mcdstub/mcdstub.h            | 33 +++++-----------
 target/arm/mcdstub.c         |  2 +-
 4 files changed, 60 insertions(+), 57 deletions(-)

diff --git a/mcdstub/mcd_shared_defines.h b/mcdstub/mcd_shared_defines.h
index 91d476a555..5cfda4121d 100644
--- a/mcdstub/mcd_shared_defines.h
+++ b/mcdstub/mcd_shared_defines.h
@@ -91,4 +91,12 @@
 #define MCD_BREAKPOINT_WRITE 3
 #define MCD_BREAKPOINT_RW 4
 
+/* trigger data */
+#define MCD_TRIG_ACT_BREAK "check_data_value"
+#define MCD_TRIG_OPT_VALUE "break_on_trigger"
+
+/* register mem space key words */
+#define MCD_GRP_KEYWORD "GPR"
+#define MCD_CP_KEYWORD "CP"
+
 #endif
diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index 7d8ce634c8..8e711a0a40 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -1303,12 +1303,15 @@ int init_resets(GArray *resets)
 
 int init_trigger(mcd_trigger_into_st *trigger)
 {
-    trigger->type = (MCD_TRIG_TYPE_IP | MCD_TRIG_TYPE_READ |
-        MCD_TRIG_TYPE_WRITE | MCD_TRIG_TYPE_RW);
-    trigger->option = (MCD_TRIG_OPT_DATA_IS_CONDITION);
-    trigger->action = (MCD_TRIG_ACTION_DBG_DEBUG);
-    /* there is no specific upper limit for trigger */
-    trigger->nr_trigger = 0;
+    snprintf(trigger->type, sizeof(trigger->type),
+        "%d,%d,%d,%d", MCD_BREAKPOINT_HW, MCD_BREAKPOINT_READ,
+        MCD_BREAKPOINT_WRITE, MCD_BREAKPOINT_RW);
+    snprintf(trigger->option, sizeof(trigger->option),
+        "%s", MCD_TRIG_OPT_VALUE);
+    snprintf(trigger->action, sizeof(trigger->action),
+        "%s", MCD_TRIG_ACT_BREAK);
+    /* there can be 16 breakpoints and 16 watchpoints each */
+    trigger->nr_trigger = 16;
     return 0;
 }
 
@@ -1348,9 +1351,9 @@ void handle_query_cores(GArray *params, void *user_ctx)
     CPUClass *cc = CPU_GET_CLASS(cpu);
     gchar *arch = cc->gdb_arch_name(cpu);
 
-    int nr_cores = cpu->nr_cores;
+    uint32_t nr_cores = cpu->nr_cores;
     char device_name[] = DEVICE_NAME_TEMPLATE(arch);
-    g_string_printf(mcdserver_state.str_buf, "%s=%s.%s=%s.%s=%d.",
+    g_string_printf(mcdserver_state.str_buf, "%s=%s.%s=%s.%s=%u.",
         TCP_ARGUMENT_DEVICE, device_name, TCP_ARGUMENT_CORE, cpu_model,
         TCP_ARGUMENT_AMOUNT_CORE, nr_cores);
     mcd_put_strbuf();
@@ -1576,7 +1579,7 @@ void handle_query_reset_f(GArray *params, void *user_ctx)
     }
     /* 2. send data */
     mcd_reset_st reset = g_array_index(mcdserver_state.resets, mcd_reset_st, 0);
-    g_string_append_printf(mcdserver_state.str_buf, "%s=%s.%s=%d.",
+    g_string_append_printf(mcdserver_state.str_buf, "%s=%s.%s=%u.",
         TCP_ARGUMENT_NAME, reset.name, TCP_ARGUMENT_ID, reset.id);
     mcd_put_strbuf();
 }
@@ -1592,13 +1595,13 @@ void handle_query_reset_c(GArray *params, void *user_ctx)
         /* indicates this is the last packet */
         g_string_printf(mcdserver_state.str_buf, "0!");
     } else {
-        g_string_printf(mcdserver_state.str_buf, "%d!", query_index + 1);
+        g_string_printf(mcdserver_state.str_buf, "%u!", query_index + 1);
     }
 
     /* 2. send data */
     mcd_reset_st reset = g_array_index(mcdserver_state.resets,
         mcd_reset_st, query_index);
-    g_string_append_printf(mcdserver_state.str_buf, "%s=%s.%s=%d.",
+    g_string_append_printf(mcdserver_state.str_buf, "%s=%s.%s=%u.",
         TCP_ARGUMENT_NAME, reset.name, TCP_ARGUMENT_ID, reset.id);
     mcd_put_strbuf();
 }
@@ -1652,9 +1655,10 @@ void handle_close_server(GArray *params, void *user_ctx)
 void handle_query_trigger(GArray *params, void *user_ctx)
 {
     mcd_trigger_into_st trigger = mcdserver_state.trigger;
-    g_string_printf(mcdserver_state.str_buf, "%s=%d.%s=%d.%s=%d.%s=%d.",
+    g_string_printf(mcdserver_state.str_buf, "%s=%u.%s=%s.%s=%s.%s=%s.",
         TCP_ARGUMENT_AMOUNT_TRIGGER, trigger.nr_trigger,
-        TCP_ARGUMENT_TYPE, trigger.type, TCP_ARGUMENT_OPTION, trigger.option,
+        TCP_ARGUMENT_TYPE, trigger.type,
+        TCP_ARGUMENT_OPTION, trigger.option,
         TCP_ARGUMENT_ACTION, trigger.action);
     mcd_put_strbuf();
 }
@@ -1714,13 +1718,16 @@ void handle_query_mem_spaces_f(GArray *params, void *user_ctx)
     /* 3. send data */
     mcd_mem_space_st space = g_array_index(memspaces, mcd_mem_space_st, 0);
     g_string_append_printf(mcdserver_state.str_buf,
-        "%s=%s.%s=%d.%s=%d.%s=%d.%s=%d.%s=%d.%s=%ld.%s=%ld.%s=%d.",
-        TCP_ARGUMENT_NAME, space.name, TCP_ARGUMENT_ID, space.id,
-        TCP_ARGUMENT_TYPE, space.type, TCP_ARGUMENT_BITS_PER_MAU,
-        space.bits_per_mau, TCP_ARGUMENT_INVARIANCE, space.invariance,
-        TCP_ARGUMENT_ENDIAN, space.endian, TCP_ARGUMENT_MIN, space.min_addr,
-        TCP_ARGUMENT_MAX, space.max_addr, TCP_ARGUMENT_SUPPORTED_ACCESS_OPTIONS,
-        space.supported_access_options);
+        "%s=%s.%s=%u.%s=%u.%s=%u.%s=%u.%s=%u.%s=%ld.%s=%ld.%s=%u.",
+        TCP_ARGUMENT_NAME, space.name,
+        TCP_ARGUMENT_ID, space.id,
+        TCP_ARGUMENT_TYPE, space.type,
+        TCP_ARGUMENT_BITS_PER_MAU, space.bits_per_mau,
+        TCP_ARGUMENT_INVARIANCE, space.invariance,
+        TCP_ARGUMENT_ENDIAN, space.endian,
+        TCP_ARGUMENT_MIN, space.min_addr,
+        TCP_ARGUMENT_MAX, space.max_addr,
+        TCP_ARGUMENT_SUPPORTED_ACCESS_OPTIONS, space.supported_access_options);
     mcd_put_strbuf();
 }
 
@@ -1740,20 +1747,23 @@ void handle_query_mem_spaces_c(GArray *params, void *user_ctx)
         /* indicates this is the last packet */
         g_string_printf(mcdserver_state.str_buf, "0!");
     } else {
-        g_string_printf(mcdserver_state.str_buf, "%d!", query_index + 1);
+        g_string_printf(mcdserver_state.str_buf, "%u!", query_index + 1);
     }
 
     /* 3. send the correct memspace */
     mcd_mem_space_st space = g_array_index(memspaces,
         mcd_mem_space_st, query_index);
     g_string_append_printf(mcdserver_state.str_buf,
-        "%s=%s.%s=%d.%s=%d.%s=%d.%s=%d.%s=%d.%s=%ld.%s=%ld.%s=%d.",
-        TCP_ARGUMENT_NAME, space.name, TCP_ARGUMENT_ID,
-        space.id, TCP_ARGUMENT_TYPE, space.type, TCP_ARGUMENT_BITS_PER_MAU,
-        space.bits_per_mau, TCP_ARGUMENT_INVARIANCE, space.invariance,
-        TCP_ARGUMENT_ENDIAN, space.endian, TCP_ARGUMENT_MIN, space.min_addr,
-        TCP_ARGUMENT_MAX, space.max_addr, TCP_ARGUMENT_SUPPORTED_ACCESS_OPTIONS,
-        space.supported_access_options);
+        "%s=%s.%s=%u.%s=%u.%s=%u.%s=%u.%s=%u.%s=%ld.%s=%ld.%s=%u.",
+        TCP_ARGUMENT_NAME, space.name,
+        TCP_ARGUMENT_ID, space.id,
+        TCP_ARGUMENT_TYPE, space.type,
+        TCP_ARGUMENT_BITS_PER_MAU, space.bits_per_mau,
+        TCP_ARGUMENT_INVARIANCE, space.invariance,
+        TCP_ARGUMENT_ENDIAN, space.endian,
+        TCP_ARGUMENT_MIN, space.min_addr,
+        TCP_ARGUMENT_MAX, space.max_addr,
+        TCP_ARGUMENT_SUPPORTED_ACCESS_OPTIONS, space.supported_access_options);
     mcd_put_strbuf();
 }
 
@@ -1774,7 +1784,7 @@ void handle_query_reg_groups_f(GArray *params, void *user_ctx)
     }
     /* 3. send data */
     mcd_reg_group_st group = g_array_index(reggroups, mcd_reg_group_st, 0);
-    g_string_append_printf(mcdserver_state.str_buf, "%s=%d.%s=%s.",
+    g_string_append_printf(mcdserver_state.str_buf, "%s=%u.%s=%s.",
         TCP_ARGUMENT_ID, group.id, TCP_ARGUMENT_NAME, group.name);
     mcd_put_strbuf();
 }
@@ -1795,13 +1805,13 @@ void handle_query_reg_groups_c(GArray *params, void *user_ctx)
         /* indicates this is the last packet */
         g_string_printf(mcdserver_state.str_buf, "0!");
     } else {
-        g_string_printf(mcdserver_state.str_buf, "%d!", query_index + 1);
+        g_string_printf(mcdserver_state.str_buf, "%u!", query_index + 1);
     }
 
     /* 3. send the correct reggroup */
     mcd_reg_group_st group = g_array_index(reggroups, mcd_reg_group_st,
         query_index);
-    g_string_append_printf(mcdserver_state.str_buf, "%s=%d.%s=%s.",
+    g_string_append_printf(mcdserver_state.str_buf, "%s=%u.%s=%s.",
         TCP_ARGUMENT_ID, group.id, TCP_ARGUMENT_NAME, group.name);
     mcd_put_strbuf();
 }
@@ -1852,7 +1862,7 @@ void handle_query_regs_c(GArray *params, void *user_ctx)
         /* indicates this is the last packet */
         g_string_printf(mcdserver_state.str_buf, "0!");
     } else {
-        g_string_printf(mcdserver_state.str_buf, "%d!", query_index + 1);
+        g_string_printf(mcdserver_state.str_buf, "%u!", query_index + 1);
     }
 
     /* 3. send the correct register */
diff --git a/mcdstub/mcdstub.h b/mcdstub/mcdstub.h
index f8171cba71..a436551bb1 100644
--- a/mcdstub/mcdstub.h
+++ b/mcdstub/mcdstub.h
@@ -13,22 +13,6 @@
 #define MCD_TRIG_OPT_DATA_IS_CONDITION 0x00000008
 #define MCD_TRIG_ACTION_DBG_DEBUG 0x00000001
 
-typedef uint32_t mcd_trig_type_et;
-/* TODO: replace mcd defines with custom layer */
-enum {
-    MCD_TRIG_TYPE_UNDEFINED = 0x00000000,
-    MCD_TRIG_TYPE_IP        = 0x00000001,
-    MCD_TRIG_TYPE_READ      = 0x00000002,
-    MCD_TRIG_TYPE_WRITE     = 0x00000004,
-    MCD_TRIG_TYPE_RW        = 0x00000008,
-    MCD_TRIG_TYPE_NOCYCLE   = 0x00000010,
-    MCD_TRIG_TYPE_TRIG_BUS  = 0x00000020,
-    MCD_TRIG_TYPE_COUNTER   = 0x00000040,
-    MCD_TRIG_TYPE_CUSTOM    = 0x00000080,
-    MCD_TRIG_TYPE_CUSTOM_LO = 0x00010000,
-    MCD_TRIG_TYPE_CUSTOM_HI = 0x40000000,
-};
-
 typedef uint32_t mcd_core_event_et;
 /* TODO: replace mcd defines with custom layer */
 enum {
@@ -60,6 +44,7 @@ enum {
 #define QUERY_TOTAL_NUMBER 12
 #define CMD_SCHEMA_LENGTH 6
 #define MCD_SYSTEM_NAME "qemu-system"
+#define ARGUMENT_STRING_LENGTH 64
 
 /* tcp query packet values templates */
 #define DEVICE_NAME_TEMPLATE(s) "qemu-" #s "-device"
@@ -126,9 +111,9 @@ typedef struct breakpoint_st {
 } breakpoint_st;
 
 typedef struct mcd_trigger_into_st {
-    uint32_t type;
-    uint32_t option;
-    uint32_t action;
+    char type[ARGUMENT_STRING_LENGTH];
+    char option[ARGUMENT_STRING_LENGTH];
+    char action[ARGUMENT_STRING_LENGTH];
     uint32_t nr_trigger;
 } mcd_trigger_into_st;
 
@@ -195,15 +180,15 @@ typedef struct mcd_reg_group_st {
 } mcd_reg_group_st;
 
 typedef struct xml_attrib {
-    char argument[64];
-    char value[64];
+    char argument[ARGUMENT_STRING_LENGTH];
+    char value[ARGUMENT_STRING_LENGTH];
 } xml_attrib;
 
 typedef struct mcd_reg_st {
     /* xml info */
-    char name[64];
-    char group[64];
-    char type[64];
+    char name[ARGUMENT_STRING_LENGTH];
+    char group[ARGUMENT_STRING_LENGTH];
+    char type[ARGUMENT_STRING_LENGTH];
     uint32_t bitsize;
     uint32_t id; /* id used by the mcd interface */
     uint32_t internal_id; /* id inside reg type */
diff --git a/target/arm/mcdstub.c b/target/arm/mcdstub.c
index 8456352370..3a35d1062d 100644
--- a/target/arm/mcdstub.c
+++ b/target/arm/mcdstub.c
@@ -333,7 +333,7 @@ uint16_t arm_mcd_get_opcode(CPUState *cs, uint32_t n)
 
 int arm_mcd_set_scr(CPUState *cs, bool secure)
 {
-    /* swtiches between secure and non secure mode */
+    /* switches between secure and non secure mode */
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
     /* set bit 0 to 1 if non secure, to 0 if secure*/
-- 
2.34.1


