Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4AE7E3FA0
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 14:07:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Lmo-0002UI-B3; Tue, 07 Nov 2023 08:06:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1r0Lkm-0008Ju-Lh
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:04:27 -0500
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1r0Lkg-00062M-Hq
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:04:24 -0500
Received: (qmail 31470 invoked by uid 484); 7 Nov 2023 13:04:14 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.244438 secs); 07 Nov 2023 13:04:14 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP for <qemu-devel@nongnu.org>; 7 Nov 2023 13:04:13 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: "Nicolas Eder" <nicolas.eder@lauterbach.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Christian Boenig" <christian.boenig@lauterbach.com>
Subject: [PATCH v3 17/20] mcdstub: reading/writing registers added
Date: Tue,  7 Nov 2023 14:03:20 +0100
Message-Id: <20231107130323.4126-18-nicolas.eder@lauterbach.com>
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
 include/mcdstub/mcdstub.h |  62 +++++++++++++++++++++
 mcdstub/mcdstub.c         | 113 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 175 insertions(+)

diff --git a/include/mcdstub/mcdstub.h b/include/mcdstub/mcdstub.h
index 000d832a39..6b2249f8fb 100644
--- a/include/mcdstub/mcdstub.h
+++ b/include/mcdstub/mcdstub.h
@@ -690,6 +690,49 @@ void handle_reset(GArray *params, void *user_ctx);
  */
 void handle_query_state(GArray *params, void *user_ctx);
 
+/**
+ * handle_read_register() - Handler for reading a register.
+ *
+ * This function calls :c:func:`mcd_read_register` to read a register. The
+ * register data gets stored in the mem_buf byte array. The data then gets
+ * converted into a hex string with :c:func:`mcd_memtohex` and then send.
+ * @params: GArray with all TCP packet parameters.
+ */
+void handle_read_register(GArray *params, void *user_ctx);
+
+/**
+ * handle_write_register() - Handler for writing a register.
+ *
+ * This function converts the incoming hex string data into a byte array with
+ * :c:func:`mcd_hextomem`. Then it calls :c:func:`mcd_write_register` to write
+ * to the register.
+ * @params: GArray with all TCP packet parameters.
+ */
+void handle_write_register(GArray *params, void *user_ctx);
+/**
+ * mcd_read_register() - Reads a registers data and stores it into the buf.
+ *
+ * This function collects the register type and internal ID
+ * (depending on the XML file). Then it calls the architecture specific
+ * read function. For ARM this is :c:func:`arm_mcd_read_register`.
+ * @cpu: CPU to which the register belongs.
+ * @buf: Byte array with register data.
+ * @reg: General ID of the register.
+ */
+int mcd_read_register(CPUState *cpu, GByteArray *buf, int reg);
+
+/**
+ * mcd_write_register() - Writes data from the buf to a register.
+ *
+ * This function collects the register type and internal ID
+ * (depending on the XML file). Then it calls the architecture specific
+ * write function. For ARM this is :c:func:`arm_mcd_write_register`.
+ * @cpu: CPU to which the register belongs.
+ * @mem_buf: Byte array with register data.
+ * @reg: General ID of the register.
+ */
+int mcd_write_register(CPUState *cpu, uint8_t *mem_buf, int reg);
+
 /* helpers */
 
 /**
@@ -699,6 +742,25 @@ void handle_query_state(GArray *params, void *user_ctx);
  * @b: Pointer to integer b.
  */
 int int_cmp(gconstpointer a, gconstpointer b);
+
+/**
+ * mcd_memtohex() - Converts a byte array into a hex string.
+ *
+ * @mem: Pointer to byte array.
+ * @buf: Pointer to hex string.
+ * @len: Number of bytes.
+ */
+void mcd_memtohex(GString *buf, const uint8_t *mem, int len);
+
+/**
+ * mcd_hextomem() - Converts a hex string into a byte array.
+ *
+ * @mem: Pointer to byte array.
+ * @buf: Pointer to hex string.
+ * @len: Number of bytes.
+ */
+void mcd_hextomem(GByteArray *mem, const char *buf, int len);
+
 /**
  * atouint64_t() - Converts a string into a unsigned 64 bit integer.
  *
diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index 1a10bc6c98..018900e914 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -521,6 +521,30 @@ int mcd_handle_packet(const char *line_buf)
             cmd_parser = &reset_cmd_desc;
         }
         break;
+    case TCP_CHAR_READ_REGISTER:
+        {
+            static MCDCmdParseEntry read_reg_cmd_desc = {
+                .handler = handle_read_register,
+            };
+            read_reg_cmd_desc.cmd = (char[2]) { TCP_CHAR_READ_REGISTER, '\0' };
+            strcpy(read_reg_cmd_desc.schema,
+                (char[3]) { ARG_SCHEMA_CORENUM, ARG_SCHEMA_UINT64_T, '\0' });
+            cmd_parser = &read_reg_cmd_desc;
+        }
+        break;
+    case TCP_CHAR_WRITE_REGISTER:
+        {
+            static MCDCmdParseEntry write_reg_cmd_desc = {
+                .handler = handle_write_register,
+            };
+            write_reg_cmd_desc.cmd =
+                (char[2]) { TCP_CHAR_WRITE_REGISTER, '\0' };
+            strcpy(write_reg_cmd_desc.schema,
+                (char[5]) { ARG_SCHEMA_CORENUM, ARG_SCHEMA_UINT64_T,
+                ARG_SCHEMA_INT, ARG_SCHEMA_HEXDATA, '\0' });
+            cmd_parser = &write_reg_cmd_desc;
+        }
+        break;
     default:
         /* command not supported */
         mcd_put_packet("");
@@ -1614,3 +1638,92 @@ void handle_query_state(GArray *params, void *user_ctx)
         mcdserver_state.cpu_state.bp_address = 0;
     }
 }
+
+int mcd_read_register(CPUState *cpu, GByteArray *buf, int reg)
+{
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+    CPUArchState *env = cpu_env(cpu);
+    GDBRegisterState *r;
+
+    if (reg < cc->gdb_num_core_regs) {
+        return cc->gdb_read_register(cpu, buf, reg);
+    }
+
+    for (guint i = 0; i < cpu->gdb_regs->len; i++) {
+        r = &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
+        if (r->base_reg <= reg && reg < r->base_reg + r->num_regs) {
+            return r->get_reg(env, buf, reg - r->base_reg);
+        }
+    }
+    return 0;
+}
+
+int mcd_write_register(CPUState *cpu, uint8_t *mem_buf, int reg)
+{
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+    CPUArchState *env = cpu_env(cpu);
+    GDBRegisterState *r;
+
+    if (reg < cc->gdb_num_core_regs) {
+        return cc->gdb_write_register(cpu, mem_buf, reg);
+    }
+
+    for (guint i = 0; i < cpu->gdb_regs->len; i++) {
+        r = &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
+        if (r->base_reg <= reg && reg < r->base_reg + r->num_regs) {
+            return r->set_reg(env, mem_buf, reg - r->base_reg);
+        }
+    }
+    return 0;
+}
+
+void mcd_memtohex(GString *buf, const uint8_t *mem, int len)
+{
+    int i, c;
+    for (i = 0; i < len; i++) {
+        c = mem[i];
+        g_string_append_c(buf, tohex(c >> 4));
+        g_string_append_c(buf, tohex(c & 0xf));
+    }
+    g_string_append_c(buf, '\0');
+}
+
+void mcd_hextomem(GByteArray *mem, const char *buf, int len)
+{
+    int i;
+
+    for (i = 0; i < len; i++) {
+        guint8 byte = fromhex(buf[0]) << 4 | fromhex(buf[1]);
+        g_byte_array_append(mem, &byte, 1);
+        buf += 2;
+    }
+}
+
+void handle_read_register(GArray *params, void *user_ctx)
+{
+    uint32_t cpu_id = get_param(params, 0)->cpu_id;
+    uint64_t reg_num = get_param(params, 1)->data_uint64_t;
+    int reg_size;
+
+    CPUState *cpu = mcd_get_cpu(cpu_id);
+    reg_size = mcd_read_register(cpu, mcdserver_state.mem_buf, reg_num);
+    mcd_memtohex(mcdserver_state.str_buf,
+        mcdserver_state.mem_buf->data, reg_size);
+    mcd_put_strbuf();
+}
+
+void handle_write_register(GArray *params, void *user_ctx)
+{
+    uint32_t cpu_id = get_param(params, 0)->cpu_id;
+    uint64_t reg_num = get_param(params, 1)->data_uint64_t;
+    uint32_t reg_size = get_param(params, 2)->data_uint32_t;
+
+    CPUState *cpu = mcd_get_cpu(cpu_id);
+    mcd_hextomem(mcdserver_state.mem_buf,
+        mcdserver_state.str_buf->str, reg_size);
+    if (mcd_write_register(cpu, mcdserver_state.mem_buf->data, reg_num) == 0) {
+        mcd_put_packet(TCP_EXECUTION_ERROR);
+    } else {
+        mcd_put_packet(TCP_EXECUTION_SUCCESS);
+    }
+}
-- 
2.34.1


