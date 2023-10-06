Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D73FA7BB3F5
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 11:09:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qognH-00089P-5T; Fri, 06 Oct 2023 05:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qognE-00088l-90
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:06:44 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qognA-0000x6-WE
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:06:44 -0400
Received: (qmail 19601 invoked by uid 484); 6 Oct 2023 09:06:27 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.072201 secs); 06 Oct 2023 09:06:27 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP for <qemu-devel@nongnu.org>; 6 Oct 2023 09:06:27 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Christian.Boenig@lauterbach.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicolas Eder <nicolas.eder@lauterbach.com>
Subject: [PATCH v2 12/29] handler for reading registers added
Date: Fri,  6 Oct 2023 11:05:53 +0200
Message-Id: <20231006090610.26171-13-nicolas.eder@lauterbach.com>
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
 mcdstub/internals.h          |  11 ++-
 mcdstub/mcd_shared_defines.h |   7 ++
 mcdstub/mcdstub.c            | 129 +++++++++++++++++++++++++++++++++++
 target/arm/mcdstub.c         |  75 ++++++++++++++++++++
 target/arm/mcdstub.h         |   7 ++
 5 files changed, 228 insertions(+), 1 deletion(-)
 create mode 100644 target/arm/mcdstub.c
 create mode 100644 target/arm/mcdstub.h

diff --git a/mcdstub/internals.h b/mcdstub/internals.h
index 2c64cfc0f9..a85173d0d1 100644
--- a/mcdstub/internals.h
+++ b/mcdstub/internals.h
@@ -41,6 +41,7 @@ enum {
 #define ARG_SCHEMA_QRYHANDLE 'q'
 #define ARG_SCHEMA_STRING 's'
 #define ARG_SCHEMA_INT 'd'
+#define ARG_SCHEMA_UINT32_T 'l'
 #define ARG_SCHEMA_CORENUM 'c'
 
 // resets
@@ -50,7 +51,7 @@ enum {
 
 // more
 #define QUERY_TOTAL_NUMBER 12 //FIXME: set this to a usefull value in the end
-#define CMD_SCHEMA_LENGTH 2
+#define CMD_SCHEMA_LENGTH 3
 #define MCD_SYSTEM_NAME "qemu-system"
 // tcp query packet values templates
 #define DEVICE_NAME_TEMPLATE(s) "qemu-" #s "-device"
@@ -108,6 +109,7 @@ typedef union MCDCmdVariant {
     
     const char *data;
     int data_int;
+    uint64_t data_uint64_t;
     int query_handle;
     int cpu_id;
     struct {
@@ -321,6 +323,12 @@ void handle_open_server(GArray *params, void *user_ctx);
 void parse_reg_xml(const char *xml, int size, GArray* registers);
 void handle_reset(GArray *params, void *user_ctx);
 void handle_query_state(GArray *params, void *user_ctx);
+void handle_read_register(GArray *params, void *user_ctx);
+void handle_write_register(GArray *params, void *user_ctx);
+void handle_read_memory(GArray *params, void *user_ctx);
+void handle_write_memory(GArray *params, void *user_ctx);
+int mcd_read_register(CPUState *cpu, GByteArray *buf, int reg);
+int mcd_read_memory(CPUState *cpu, hwaddr addr, uint8_t *buf, int len);
 
 // arm specific functions
 int mcd_arm_store_mem_spaces(CPUState *cpu, GArray* memspaces);
@@ -334,5 +342,6 @@ void mcd_disable_syscalls(void);
 
 // helpers
 int int_cmp(gconstpointer a, gconstpointer b);
+void mcd_memtohex(GString *buf, const uint8_t *mem, int len);
 
 #endif /* MCDSTUB_INTERNALS_H */
diff --git a/mcdstub/mcd_shared_defines.h b/mcdstub/mcd_shared_defines.h
index 8cec2e9f23..47d5d46af3 100644
--- a/mcdstub/mcd_shared_defines.h
+++ b/mcdstub/mcd_shared_defines.h
@@ -13,6 +13,10 @@
 #define TCP_CHAR_CLOSE_CORE 'd'
 #define TCP_CHAR_KILLQEMU 'k'
 #define TCP_CHAR_RESET 'r'
+#define TCP_CHAR_READ_REGISTER 'p'
+#define TCP_CHAR_WRITE_REGISTER 'P'
+#define TCP_CHAR_READ_MEMORY 'm'
+#define TCP_CHAR_WRITE_MEMORY 'M'
 
 // tcp protocol chars
 #define TCP_ACKNOWLEDGED '+'
@@ -22,6 +26,8 @@
 #define TCP_WAS_LAST '|'
 #define TCP_WAS_NOT_LAST '~'
 #define TCP_HANDSHAKE_SUCCESS "shaking your hand"
+#define TCP_EXECUTION_SUCCESS "success"
+#define TCP_EXECUTION_ERROR ""
 
 // tcp query arguments
 #define QUERY_FIRST "f"
@@ -38,6 +44,7 @@
 
 // tcp query packet argument list
 #define TCP_ARGUMENT_NAME "name"
+#define TCP_ARGUMENT_DATA "data"
 #define TCP_ARGUMENT_ID "id"
 #define TCP_ARGUMENT_TYPE "type"
 #define TCP_ARGUMENT_BITS_PER_MAU "bpm"
diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index dc40a68338..21e9159876 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -544,6 +544,46 @@ int mcd_handle_packet(const char *line_buf)
             cmd_parser = &reset_cmd_desc;
         }
         break;
+    case TCP_CHAR_READ_REGISTER:
+        {
+            static MCDCmdParseEntry read_reg_cmd_desc = {
+                .handler = handle_read_register,
+            };
+            read_reg_cmd_desc.cmd = (char[2]) { (char) TCP_CHAR_READ_REGISTER, '\0' };
+            strcpy(read_reg_cmd_desc.schema, (char[3]) { ARG_SCHEMA_CORENUM, ARG_SCHEMA_INT, '\0' });
+            cmd_parser = &read_reg_cmd_desc;
+        }
+        break;
+    case TCP_CHAR_WRITE_REGISTER:
+        {
+            static MCDCmdParseEntry write_reg_cmd_desc = {
+                .handler = handle_write_register,
+            };
+            write_reg_cmd_desc.cmd = (char[2]) { (char) TCP_CHAR_WRITE_REGISTER, '\0' };
+            strcpy(write_reg_cmd_desc.schema, (char[3]) { ARG_SCHEMA_CORENUM, ARG_SCHEMA_INT, '\0' });
+            cmd_parser = &write_reg_cmd_desc;
+        }
+        break;
+    case TCP_CHAR_READ_MEMORY:
+        {
+            static MCDCmdParseEntry read_mem_cmd_desc = {
+                .handler = handle_read_memory,
+            };
+            read_mem_cmd_desc.cmd = (char[2]) { (char) TCP_CHAR_READ_MEMORY, '\0' };
+            strcpy(read_mem_cmd_desc.schema, (char[3]) { ARG_SCHEMA_CORENUM, ARG_SCHEMA_INT, '\0' });
+            cmd_parser = &read_mem_cmd_desc;
+        }
+        break;
+    case TCP_CHAR_WRITE_MEMORY:
+        {
+            static MCDCmdParseEntry write_mem_cmd_desc = {
+                .handler = handle_write_memory,
+            };
+            write_mem_cmd_desc.cmd = (char[2]) { (char) TCP_CHAR_WRITE_MEMORY, '\0' };
+            strcpy(write_mem_cmd_desc.schema, (char[3]) { ARG_SCHEMA_CORENUM, ARG_SCHEMA_INT, '\0' });
+            cmd_parser = &write_mem_cmd_desc;
+        }
+        break;
     default:
         // could not perform the command (because its unknown)
         mcd_put_packet("");
@@ -597,6 +637,18 @@ void run_cmd_parser(const char *data, const MCDCmdParseEntry *cmd)
     }
 }
 
+uint64_t atouint64_t(const char* in) {
+    uint64_t res = 0;
+    for (int i = 0; i < strlen(in); ++i)
+    {
+        const char c = in[i];
+        res *= 10;
+        res += c - '0';
+    }
+
+    return res;
+}
+
 int cmd_parse_params(const char *data, const char *schema, GArray *params) {
     
     char data_buffer[64] = {0};
@@ -621,6 +673,10 @@ int cmd_parse_params(const char *data, const char *schema, GArray *params) {
             this_param.data_int = atoi(data_buffer);
             g_array_append_val(params, this_param);
             break;
+        case ARG_SCHEMA_UINT32_T:
+            this_param.data_int = atoi(data_buffer);
+            g_array_append_val(params, this_param);
+            break;
         case ARG_SCHEMA_QRYHANDLE:
             this_param.query_handle = atoi(data_buffer);
             g_array_append_val(params, this_param);
@@ -1716,3 +1772,76 @@ void handle_query_state(GArray *params, void *user_ctx) {
         TCP_ARGUMENT_STOP_STRING, state_info.stop_str, TCP_ARGUMENT_INFO_STRING, state_info.info_str);
     mcd_put_strbuf();
 }
+
+int mcd_read_register(CPUState *cpu, GByteArray *buf, int reg) {
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+    gchar *arch = cc->gdb_arch_name(cpu);
+    if (strcmp(arch, "arm")==0) {
+        g_free(arch);
+        return arm_mcd_read_register(cpu, buf, reg);
+    }
+    else {
+        g_free(arch);
+        return 0;
+    }
+}
+
+void mcd_memtohex(GString *buf, const uint8_t *mem, int len) {
+    int i, c;
+    for(i = 0; i < len; i++) {
+        c = mem[i];
+        g_string_append_c(buf, tohex(c >> 4));
+        g_string_append_c(buf, tohex(c & 0xf));
+    }
+    g_string_append_c(buf, '\0');
+}
+
+void handle_read_register(GArray *params, void *user_ctx) {
+    uint32_t cpu_id = get_param(params, 0)->cpu_id;
+    int reg_num = get_param(params, 1)->data_int;
+    int reg_size;
+
+    CPUState *cpu = mcd_get_cpu(cpu_id);
+
+    reg_size = mcd_read_register(cpu, mcdserver_state.mem_buf, reg_num);
+    mcd_memtohex(mcdserver_state.str_buf,  mcdserver_state.mem_buf->data, reg_size);
+    //g_string_printf(mcdserver_state.str_buf, "%s=%d;%d.%s=%d.",
+    //    TCP_ARGUMENT_DATA, *mcdserver_state.mem_buf->data, mcdserver_state.mem_buf->data[1], TCP_ARGUMENT_SIZE, reg_size);
+    mcd_put_strbuf();
+}
+
+void handle_write_register(GArray *params, void *user_ctx) {
+
+}
+
+int mcd_read_memory(CPUState *cpu, hwaddr addr, uint8_t *buf, int len)
+{
+    CPUClass *cc;
+    //TODO: add physical mem cpu_physical_memory_read(addr, buf, len);
+    cc = CPU_GET_CLASS(cpu);
+    if (cc->memory_rw_debug) {
+        // TODO: check out the difference between those two calls
+        return cc->memory_rw_debug(cpu, addr, buf, len, false);
+    }
+
+    return cpu_memory_rw_debug(cpu, addr, buf, len, false);
+}
+
+void handle_read_memory(GArray *params, void *user_ctx) {
+    uint32_t cpu_id = get_param(params, 0)->cpu_id;
+    uint64_t mem_address = get_param(params, 1)->data_uint64_t;
+    int len = get_param(params, 2)->data_int;
+
+    CPUState *cpu = mcd_get_cpu(cpu_id);
+    if (mcd_read_memory(cpu, mem_address, mcdserver_state.mem_buf, len)!=0) {
+        mcd_put_packet(TCP_EXECUTION_ERROR);
+    }
+    else {
+        mcd_memtohex(mcdserver_state.str_buf,  mcdserver_state.mem_buf->data, len);
+        mcd_put_strbuf();
+    }
+}
+
+void handle_write_memory(GArray *params, void *user_ctx) {
+
+}
diff --git a/target/arm/mcdstub.c b/target/arm/mcdstub.c
new file mode 100644
index 0000000000..dc36a79a70
--- /dev/null
+++ b/target/arm/mcdstub.c
@@ -0,0 +1,75 @@
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "exec/mcdstub.h"
+#include "sysemu/tcg.h"
+#include "internals.h"
+#include "cpregs.h"
+#include "mcdstub.h"
+
+static inline int mcd_get_reg32(GByteArray *buf, uint32_t val)
+{
+    //FIXME: move this to a separate file
+    // convert endianess if necessary
+    uint32_t to_long = tswap32(val);
+    g_byte_array_append(buf, (uint8_t *) &to_long, 4);
+    return 4;
+}
+
+static inline int mcd_get_zeroes(GByteArray *array, size_t len)
+{
+    //FIXME: move this to a separate file
+    guint oldlen = array->len;
+    g_byte_array_set_size(array, oldlen + len);
+    memset(array->data + oldlen, 0, len);
+
+    return len;
+}
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
+int arm_mcd_read_register(CPUState *cs, GByteArray *mem_buf, int n) {
+    //CPUClass *cc = CPU_GET_CLASS(cpu);
+    //CPUArchState *env = cpu->env_ptr;
+
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+
+    if (n < 16) {
+        /* Core integer register.  */
+        return mcd_get_reg32(mem_buf, env->regs[n]);
+    }
+    if (n < 24) {
+        // TODO: these numbers don't match mine
+        return mcd_get_zeroes(mem_buf, 12);
+    }
+    switch (n) {
+    case 24:
+        // TODO: these numbers don't match mine
+        return mcd_get_reg32(mem_buf, 0);
+    case 25:
+        /* CPSR, or XPSR for M-profile */
+        if (arm_feature(env, ARM_FEATURE_M)) {
+            return mcd_get_reg32(mem_buf, xpsr_read(env));
+        } else {
+            return mcd_get_reg32(mem_buf, cpsr_read(env));
+        }
+    }
+    //TODO: add funcitons for regs with higher numbers (including cp_regs)
+    return 0;
+}
\ No newline at end of file
diff --git a/target/arm/mcdstub.h b/target/arm/mcdstub.h
new file mode 100644
index 0000000000..d61028c7f4
--- /dev/null
+++ b/target/arm/mcdstub.h
@@ -0,0 +1,7 @@
+#ifndef ARM_MCDSTUB_H
+#define ARM_MCDSTUB_H
+
+const char *arm_mcd_get_dynamic_xml(CPUState *cs, const char *xmlname);
+int arm_mcd_read_register(CPUState *cs, GByteArray *mem_buf, int n);
+
+#endif /* ARM_MCDSTUB_H */
-- 
2.34.1


