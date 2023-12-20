Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E30681A4FD
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 17:28:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFzPF-0000VC-PV; Wed, 20 Dec 2023 11:26:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1rFzP5-0000SF-Sg
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 11:26:39 -0500
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1rFzP3-0004lU-8z
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 11:26:39 -0500
Received: (qmail 15377 invoked by uid 484); 20 Dec 2023 16:26:23 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.162234 secs); 20 Dec 2023 16:26:23 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP
 for <qemu-devel@nongnu.org>; 20 Dec 2023 16:26:21 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Christian Boenig" <christian.boenig@lauterbach.com>,
 "Nicolas Eder" <nicolas.eder@lauterbach.com>
Subject: [PATCH v5 12/18] mcdstub: all core specific queries added
Date: Wed, 20 Dec 2023 17:25:49 +0100
Message-Id: <20231220162555.19545-13-nicolas.eder@lauterbach.com>
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
 debug/mcdstub/mcdstub.c | 365 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 365 insertions(+)

diff --git a/debug/mcdstub/mcdstub.c b/debug/mcdstub/mcdstub.c
index 4095b3f8ce..e90fc81814 100644
--- a/debug/mcdstub/mcdstub.c
+++ b/debug/mcdstub/mcdstub.c
@@ -893,6 +893,301 @@ static void handle_query_cores(GArray *params, void *user_ctx)
     mcd_put_strbuf();
 }
 
+/**
+ * handle_query_reset_f() - Handler for the first reset query.
+ *
+ * This function sends the first reset name and ID.
+ * @params: GArray with all TCP packet parameters.
+ */
+static void handle_query_reset_f(GArray *params, void *user_ctx)
+{
+    /* 1. check length */
+    int nb_resets = mcdserver_state.resets->len;
+    if (nb_resets == 1) {
+        /* indicates this is the last packet */
+        g_string_printf(mcdserver_state.str_buf, "0%s", QUERY_END_INDEX);
+    } else {
+        g_string_printf(mcdserver_state.str_buf, "1%s", QUERY_END_INDEX);
+    }
+    /* 2. send data */
+    mcd_reset_st reset = g_array_index(mcdserver_state.resets, mcd_reset_st, 0);
+    g_string_append_printf(mcdserver_state.str_buf, "%s=%s.%s=%u.",
+        TCP_ARGUMENT_NAME, reset.name, TCP_ARGUMENT_ID, reset.id);
+    mcd_put_strbuf();
+}
+
+/**
+ * handle_query_reset_c() - Handler for all consecutive reset queries.
+ *
+ * This functions sends all consecutive reset names and IDs. It uses the
+ * query_index parameter to determine which reset is queried next.
+ * @params: GArray with all TCP packet parameters.
+ */
+static void handle_query_reset_c(GArray *params, void *user_ctx)
+{
+    /* reset options are the same for every cpu! */
+    uint32_t query_index = get_param(params, 0)->query_handle;
+
+    /* 1. check weather this was the last mem space */
+    int nb_groups = mcdserver_state.resets->len;
+    if (query_index + 1 == nb_groups) {
+        /* indicates this is the last packet */
+        g_string_printf(mcdserver_state.str_buf, "0%s", QUERY_END_INDEX);
+    } else {
+        g_string_printf(mcdserver_state.str_buf, "%u!", query_index + 1);
+    }
+
+    /* 2. send data */
+    mcd_reset_st reset = g_array_index(mcdserver_state.resets,
+        mcd_reset_st, query_index);
+    g_string_append_printf(mcdserver_state.str_buf, "%s=%s.%s=%u.",
+        TCP_ARGUMENT_NAME, reset.name, TCP_ARGUMENT_ID, reset.id);
+    mcd_put_strbuf();
+}
+
+/**
+ * handle_query_trigger() - Handler for trigger query.
+ *
+ * Sends data on the different types of trigger and their options and actions.
+ * @params: GArray with all TCP packet parameters.
+ */
+static void handle_query_trigger(GArray *params, void *user_ctx)
+{
+    mcd_trigger_into_st trigger = mcdserver_state.trigger;
+    g_string_printf(mcdserver_state.str_buf, "%s=%u.%s=%s.%s=%s.%s=%s.",
+        TCP_ARGUMENT_AMOUNT_TRIGGER, trigger.nr_trigger,
+        TCP_ARGUMENT_TYPE, trigger.type,
+        TCP_ARGUMENT_OPTION, trigger.option,
+        TCP_ARGUMENT_ACTION, trigger.action);
+    mcd_put_strbuf();
+}
+
+/**
+ * handle_query_mem_spaces_f() Handler for the first memory space query.
+ *
+ * This function sends the first memory space name, ID, type and accessing
+ * options.
+ * @params: GArray with all TCP packet parameters.
+ */
+static void handle_query_mem_spaces_f(GArray *params, void *user_ctx)
+{
+    /* 1. get correct memspaces and set the query_cpu */
+    uint32_t cpu_id = get_param(params, 0)->cpu_id;
+    mcdserver_state.query_cpu_id = cpu_id;
+    GArray *memspaces = g_list_nth_data(mcdserver_state.all_memspaces, cpu_id);
+
+    /* 2. check length */
+    int nb_groups = memspaces->len;
+    if (nb_groups == 1) {
+        /* indicates this is the last packet */
+        g_string_printf(mcdserver_state.str_buf, "0%s", QUERY_END_INDEX);
+    } else {
+        g_string_printf(mcdserver_state.str_buf, "1%s", QUERY_END_INDEX);
+    }
+
+    /* 3. send data */
+    mcd_mem_space_st space = g_array_index(memspaces, mcd_mem_space_st, 0);
+    g_string_append_printf(mcdserver_state.str_buf,
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
+    mcd_put_strbuf();
+}
+
+/**
+ * handle_query_mem_spaces_c() - Handler for all consecutive memory space
+ * queries.
+ *
+ * This function sends all consecutive memory space names, IDs, types and
+ * accessing options.
+ * It uses the query_index parameter to determine
+ * which memory space is queried next.
+ * @params: GArray with all TCP packet parameters.
+ */
+static void handle_query_mem_spaces_c(GArray *params, void *user_ctx)
+{
+    /*
+     * this funcitons send all mem spaces except for the first
+     * 1. get parameter and memspace
+     */
+    uint32_t query_index = get_param(params, 0)->query_handle;
+    uint32_t cpu_id = mcdserver_state.query_cpu_id;
+    GArray *memspaces = g_list_nth_data(mcdserver_state.all_memspaces, cpu_id);
+
+    /* 2. check weather this was the last mem space */
+    int nb_groups = memspaces->len;
+    if (query_index + 1 == nb_groups) {
+        /* indicates this is the last packet */
+        g_string_printf(mcdserver_state.str_buf, "0%s", QUERY_END_INDEX);
+    } else {
+        g_string_printf(mcdserver_state.str_buf, "%u!", query_index + 1);
+    }
+
+    /* 3. send the correct memspace */
+    mcd_mem_space_st space = g_array_index(memspaces,
+        mcd_mem_space_st, query_index);
+    g_string_append_printf(mcdserver_state.str_buf,
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
+    mcd_put_strbuf();
+}
+
+/**
+ * handle_query_reg_groups_f() - Handler for the first register group query.
+ *
+ * This function sends the first register group name and ID.
+ * @params: GArray with all TCP packet parameters.
+ */
+static void handle_query_reg_groups_f(GArray *params, void *user_ctx)
+{
+    /* 1. get correct reggroups and set the query_cpu */
+    uint32_t cpu_id = get_param(params, 0)->cpu_id;
+    mcdserver_state.query_cpu_id = cpu_id;
+    GArray *reggroups = g_list_nth_data(mcdserver_state.all_reggroups, cpu_id);
+
+    /* 2. check length */
+    int nb_groups = reggroups->len;
+    if (nb_groups == 1) {
+        /* indicates this is the last packet */
+        g_string_printf(mcdserver_state.str_buf, "0%s", QUERY_END_INDEX);
+    } else {
+        g_string_printf(mcdserver_state.str_buf, "1%s", QUERY_END_INDEX);
+    }
+    /* 3. send data */
+    mcd_reg_group_st group = g_array_index(reggroups, mcd_reg_group_st, 0);
+    g_string_append_printf(mcdserver_state.str_buf, "%s=%u.%s=%s.",
+        TCP_ARGUMENT_ID, group.id, TCP_ARGUMENT_NAME, group.name);
+    mcd_put_strbuf();
+}
+
+/**
+ * handle_query_reg_groups_c() - Handler for all consecutive register group
+ * queries.
+ *
+ * This function sends all consecutive register group names and IDs. It uses
+ * the query_index parameter to determine which register group is queried next.
+ * @params: GArray with all TCP packet parameters.
+ */
+static void handle_query_reg_groups_c(GArray *params, void *user_ctx)
+{
+    /*
+     * this funcitons send all reg groups except for the first
+     * 1. get parameter and memspace
+     */
+    uint32_t query_index = get_param(params, 0)->query_handle;
+    uint32_t cpu_id = mcdserver_state.query_cpu_id;
+    GArray *reggroups = g_list_nth_data(mcdserver_state.all_reggroups, cpu_id);
+
+    /* 2. check weather this was the last reg group */
+    int nb_groups = reggroups->len;
+    if (query_index + 1 == nb_groups) {
+        /* indicates this is the last packet */
+        g_string_printf(mcdserver_state.str_buf, "0%s", QUERY_END_INDEX);
+    } else {
+        g_string_printf(mcdserver_state.str_buf, "%u!", query_index + 1);
+    }
+
+    /* 3. send the correct reggroup */
+    mcd_reg_group_st group = g_array_index(reggroups, mcd_reg_group_st,
+        query_index);
+    g_string_append_printf(mcdserver_state.str_buf, "%s=%u.%s=%s.",
+        TCP_ARGUMENT_ID, group.id, TCP_ARGUMENT_NAME, group.name);
+    mcd_put_strbuf();
+}
+
+/**
+ * handle_query_regs_f() - Handler for the first register query.
+ *
+ * This function sends the first register with all its information.
+ * @params: GArray with all TCP packet parameters.
+ */
+static void handle_query_regs_f(GArray *params, void *user_ctx)
+{
+    /* 1. get correct registers and set the query_cpu */
+    uint32_t cpu_id = get_param(params, 0)->cpu_id;
+    mcdserver_state.query_cpu_id = cpu_id;
+    GArray *registers = g_list_nth_data(mcdserver_state.all_registers, cpu_id);
+
+    /* 2. check length */
+    int nb_regs = registers->len;
+    if (nb_regs == 1) {
+        /* indicates this is the last packet */
+        g_string_printf(mcdserver_state.str_buf, "0%s", QUERY_END_INDEX);
+    } else {
+        g_string_printf(mcdserver_state.str_buf, "1%s", QUERY_END_INDEX);
+    }
+    /* 3. send data */
+    mcd_reg_st my_register = g_array_index(registers, mcd_reg_st, 0);
+    g_string_append_printf(mcdserver_state.str_buf,
+        "%s=%u.%s=%s.%s=%u.%s=%u.%s=%u.%s=%u.%s=%u.%s=%u.",
+        TCP_ARGUMENT_ID, my_register.id,
+        TCP_ARGUMENT_NAME, my_register.name,
+        TCP_ARGUMENT_SIZE, my_register.bitsize,
+        TCP_ARGUMENT_REGGROUPID, my_register.mcd_reg_group_id,
+        TCP_ARGUMENT_MEMSPACEID, my_register.mcd_mem_space_id,
+        TCP_ARGUMENT_TYPE, my_register.mcd_reg_type,
+        TCP_ARGUMENT_THREAD, my_register.mcd_hw_thread_id,
+        TCP_ARGUMENT_OPCODE, my_register.opcode);
+    mcd_put_strbuf();
+}
+
+/**
+ * handle_query_regs_c() - Handler for all consecutive register queries.
+ *
+ * This function sends all consecutive registers with all their information.
+ * It uses the query_index parameter to determine
+ * which register is queried next.
+ * @params: GArray with all TCP packet parameters.
+ */
+static void handle_query_regs_c(GArray *params, void *user_ctx)
+{
+    /*
+     * this funcitons send all regs except for the first
+     * 1. get parameter and registers
+     */
+    uint32_t query_index = get_param(params, 0)->query_handle;
+    uint32_t cpu_id = mcdserver_state.query_cpu_id;
+    GArray *registers = g_list_nth_data(mcdserver_state.all_registers, cpu_id);
+
+    /* 2. check weather this was the last register */
+    int nb_regs = registers->len;
+    if (query_index + 1 == nb_regs) {
+        /* indicates this is the last packet */
+        g_string_printf(mcdserver_state.str_buf, "0%s", QUERY_END_INDEX);
+    } else {
+        g_string_printf(mcdserver_state.str_buf, "%u!", query_index + 1);
+    }
+
+    /* 3. send the correct register */
+    mcd_reg_st my_register = g_array_index(registers, mcd_reg_st, query_index);
+    g_string_append_printf(mcdserver_state.str_buf,
+        "%s=%u.%s=%s.%s=%u.%s=%u.%s=%u.%s=%u.%s=%u.%s=%u.",
+        TCP_ARGUMENT_ID, my_register.id,
+        TCP_ARGUMENT_NAME, my_register.name,
+        TCP_ARGUMENT_SIZE, my_register.bitsize,
+        TCP_ARGUMENT_REGGROUPID, my_register.mcd_reg_group_id,
+        TCP_ARGUMENT_MEMSPACEID, my_register.mcd_mem_space_id,
+        TCP_ARGUMENT_TYPE, my_register.mcd_reg_type,
+        TCP_ARGUMENT_THREAD, my_register.mcd_hw_thread_id,
+        TCP_ARGUMENT_OPCODE, my_register.opcode);
+    mcd_put_strbuf();
+}
+
 /**
  * init_query_cmds_table() - Initializes all query functions.
  *
@@ -918,6 +1213,76 @@ static void init_query_cmds_table(MCDCmdParseEntry *mcd_query_cmds_table)
     };
     mcd_query_cmds_table[cmd_number] = query_cores;
     cmd_number++;
+
+    MCDCmdParseEntry query_reset_f = {
+        .handler = handle_query_reset_f,
+        .cmd = QUERY_ARG_RESET QUERY_FIRST,
+    };
+    mcd_query_cmds_table[cmd_number] = query_reset_f;
+    cmd_number++;
+
+    MCDCmdParseEntry query_reset_c = {
+        .handler = handle_query_reset_c,
+        .cmd = QUERY_ARG_RESET QUERY_CONSEQUTIVE,
+    };
+    strcpy(query_reset_c.schema, (char[2]) { ARG_SCHEMA_QRYHANDLE, '\0' });
+    mcd_query_cmds_table[cmd_number] = query_reset_c;
+    cmd_number++;
+
+    MCDCmdParseEntry query_trigger = {
+        .handler = handle_query_trigger,
+        .cmd = QUERY_ARG_TRIGGER,
+    };
+    mcd_query_cmds_table[cmd_number] = query_trigger;
+    cmd_number++;
+
+    MCDCmdParseEntry query_mem_spaces_f = {
+        .handler = handle_query_mem_spaces_f,
+        .cmd = QUERY_ARG_MEMORY QUERY_FIRST,
+    };
+    strcpy(query_mem_spaces_f.schema, (char[2]) { ARG_SCHEMA_CORENUM, '\0' });
+    mcd_query_cmds_table[cmd_number] = query_mem_spaces_f;
+    cmd_number++;
+
+    MCDCmdParseEntry query_mem_spaces_c = {
+        .handler = handle_query_mem_spaces_c,
+        .cmd = QUERY_ARG_MEMORY QUERY_CONSEQUTIVE,
+    };
+    strcpy(query_mem_spaces_c.schema, (char[2]) { ARG_SCHEMA_QRYHANDLE, '\0' });
+    mcd_query_cmds_table[cmd_number] = query_mem_spaces_c;
+    cmd_number++;
+
+    MCDCmdParseEntry query_reg_groups_f = {
+        .handler = handle_query_reg_groups_f,
+        .cmd = QUERY_ARG_REGGROUP QUERY_FIRST,
+    };
+    strcpy(query_reg_groups_f.schema, (char[2]) { ARG_SCHEMA_CORENUM, '\0' });
+    mcd_query_cmds_table[cmd_number] = query_reg_groups_f;
+    cmd_number++;
+
+    MCDCmdParseEntry query_reg_groups_c = {
+        .handler = handle_query_reg_groups_c,
+        .cmd = QUERY_ARG_REGGROUP QUERY_CONSEQUTIVE,
+    };
+    strcpy(query_reg_groups_c.schema, (char[2]) { ARG_SCHEMA_QRYHANDLE, '\0' });
+    mcd_query_cmds_table[cmd_number] = query_reg_groups_c;
+    cmd_number++;
+
+    MCDCmdParseEntry query_regs_f = {
+        .handler = handle_query_regs_f,
+        .cmd = QUERY_ARG_REG QUERY_FIRST,
+    };
+    strcpy(query_regs_f.schema, (char[2]) { ARG_SCHEMA_CORENUM, '\0' });
+    mcd_query_cmds_table[cmd_number] = query_regs_f;
+    cmd_number++;
+
+    MCDCmdParseEntry query_regs_c = {
+        .handler = handle_query_regs_c,
+        .cmd = QUERY_ARG_REG QUERY_CONSEQUTIVE,
+    };
+    strcpy(query_regs_c.schema, (char[2]) { ARG_SCHEMA_QRYHANDLE, '\0' });
+    mcd_query_cmds_table[cmd_number] = query_regs_c;
+    cmd_number++;
 }
 
 /**
-- 
2.34.1


