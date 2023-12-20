Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D115081A50B
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 17:28:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFzPK-0000Wy-KN; Wed, 20 Dec 2023 11:26:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1rFzPF-0000Vp-Pg
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 11:26:49 -0500
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1rFzPD-0004oE-A9
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 11:26:49 -0500
Received: (qmail 15607 invoked by uid 484); 20 Dec 2023 16:26:34 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 4e-06 secs); 20 Dec 2023 16:26:34 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP
 for <qemu-devel@nongnu.org>; 20 Dec 2023 16:26:33 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Christian Boenig" <christian.boenig@lauterbach.com>,
 "Nicolas Eder" <nicolas.eder@lauterbach.com>
Subject: [PATCH v5 17/18] mcdstub: memory access added
Date: Wed, 20 Dec 2023 17:25:54 +0100
Message-Id: <20231220162555.19545-18-nicolas.eder@lauterbach.com>
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
 debug/mcdstub/arm_mcdstub.c   |  28 +++++
 debug/mcdstub/mcdstub.c       | 203 ++++++++++++++++++++++++++++++++++
 include/mcdstub/arm_mcdstub.h |  15 +++
 3 files changed, 246 insertions(+)

diff --git a/debug/mcdstub/arm_mcdstub.c b/debug/mcdstub/arm_mcdstub.c
index ce5264a617..6eaf2d754f 100644
--- a/debug/mcdstub/arm_mcdstub.c
+++ b/debug/mcdstub/arm_mcdstub.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "exec/memory.h"
 #include "mcdstub/arm_mcdstub.h"
 
 int arm_mcd_store_mem_spaces(CPUState *cpu, GArray *memspaces)
@@ -259,3 +260,30 @@ uint16_t arm_mcd_get_opcode(CPUState *cs, uint32_t n)
     /* TODO: not working with current build structure */
     return 0;
 }
+
+AddressSpace *arm_mcd_get_address_space(uint32_t cpu_id,
+    mcd_mem_space_st mem_space)
+{
+    /* get correct address space name */
+    char as_name[ARGUMENT_STRING_LENGTH] = {0};
+    if (mem_space.is_secure) {
+        sprintf(as_name, "cpu-secure-memory-%u", cpu_id);
+    } else {
+        sprintf(as_name, "cpu-memory-%u", cpu_id);
+    }
+    /* return correct address space */
+    AddressSpace *as = mcd_find_address_space(as_name);
+    return as;
+}
+
+MemTxAttrs arm_mcd_get_memtxattrs(mcd_mem_space_st mem_space)
+{
+    MemTxAttrs attributes = {0};
+    if (mem_space.is_secure) {
+        attributes.secure = 1;
+        attributes.space = 2;
+    } else {
+        attributes.space = 1;
+    }
+    return attributes;
+}
diff --git a/debug/mcdstub/mcdstub.c b/debug/mcdstub/mcdstub.c
index df98453558..954d06c0b7 100644
--- a/debug/mcdstub/mcdstub.c
+++ b/debug/mcdstub/mcdstub.c
@@ -997,6 +997,186 @@ static void handle_write_register(GArray *params, void *user_ctx)
     }
 }
 
+/**
+ * mcd_read_write_physical_memory() - Reades or writes from/to a logical
+ * memory address.
+ * @address_space: Desired QEMU address space (e.g. secure/non-secure)
+ * @attributes: Access attributes
+ * @addr: (physical) memory address
+ * @buf: Buffer for memory data
+ * @len: Length of the memory access
+ * @is_write: True for writing and false for reading
+ */
+static int mcd_read_write_physical_memory(AddressSpace *address_space,
+    MemTxAttrs attributes, hwaddr addr, uint8_t *buf, int len, bool is_write)
+{
+    if (is_write) {
+        return address_space_write_rom(address_space, addr, attributes, buf,
+            len);
+    } else {
+        return address_space_read_full(address_space, addr, attributes, buf,
+            len);
+    }
+}
+
+/**
+ * mcd_read_write_memory() - Reades or writes from/to a logical memory address.
+ * @cpu: CPUState
+ * @address_space: Desired QEMU address space (e.g. secure/non-secure)
+ * @attributes: Access attributes
+ * @addr: (logical) memory address
+ * @buf: Buffer for memory data
+ * @len: Length of the memory access
+ * @is_write: True for writing and false for reading
+ */
+static int mcd_read_write_memory(CPUState *cpu, AddressSpace *address_space,
+    MemTxAttrs attributes, vaddr addr, uint8_t *buf, uint64_t len,
+    bool is_write)
+{
+    /* get physical address */
+    if (cpu_memory_get_physical_address(cpu, &addr, &len) != 0) {
+        return -1;
+    }
+    /* read memory */
+    return mcd_read_write_physical_memory(address_space, attributes, addr, buf,
+        len, is_write);
+}
+
+/**
+ * mcd_get_address_space() - Returnes the correct QEMU address space name
+ * @cpu: CPUState
+ * @cpu_id: Correct CPU ID
+ * @mem_space: Desired mcd specific memory space.
+ */
+static AddressSpace *mcd_get_address_space(CPUState *cpu, uint32_t cpu_id,
+    mcd_mem_space_st mem_space)
+{
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+    const gchar *arch = cc->gdb_arch_name(cpu);
+    if (strcmp(arch, MCDSTUB_ARCH_ARM) == 0) {
+        return arm_mcd_get_address_space(cpu_id, mem_space);
+    } else {
+        g_assert_not_reached();
+    }
+}
+
+/**
+ * mcd_get_memtxattrs() - Returnes the correct QEMU address space access
+ * attributes
+ * @cpu: CPUState
+ * @mem_space: Desired mcd specific memory space.
+ */
+static MemTxAttrs mcd_get_memtxattrs(CPUState *cpu, mcd_mem_space_st mem_space)
+{
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+    const gchar *arch = cc->gdb_arch_name(cpu);
+    if (strcmp(arch, MCDSTUB_ARCH_ARM) == 0) {
+        return arm_mcd_get_memtxattrs(mem_space);
+    } else {
+        g_assert_not_reached();
+    }
+}
+
+/**
+ * handle_read_memory() - Handler for reading memory.
+ *
+ * First, this function checks whether reading a secure memory space is
+ * requested and changes the access mode with :c:func:`arm_mcd_set_scr`.
+ * Then it calls :c:func:`mcd_read_memory` to read memory. The collected
+ * data gets stored in the mem_buf byte array. The data then gets converted
+ * into a hex string with :c:func:`mcd_memtohex` and then send.
+ * @params: GArray with all TCP packet parameters.
+ */
+static void handle_read_memory(GArray *params, void *user_ctx)
+{
+    /* read input parameters */
+    uint32_t cpu_id = get_param(params, 0)->cpu_id;
+    uint32_t mem_space_id = get_param(params, 1)->data_uint32_t;
+    uint64_t mem_address = get_param(params, 2)->data_uint64_t;
+    uint32_t len = get_param(params, 3)->data_uint32_t;
+    /* check which memory space was requested */
+    CPUState *cpu = mcd_get_cpu(cpu_id);
+    GArray *memspaces =
+        g_list_nth_data(mcdserver_state.all_memspaces, cpu_id);
+    mcd_mem_space_st space = g_array_index(memspaces, mcd_mem_space_st,
+        mem_space_id - 1);
+    /* get data in the QEMU address space and access attributes */
+    AddressSpace *address_space = mcd_get_address_space(cpu, cpu_id, space);
+    MemTxAttrs attributes = mcd_get_memtxattrs(cpu, space);
+    /* read memory data */
+    g_byte_array_set_size(mcdserver_state.mem_buf, len);
+    if (space.is_physical) {
+        /* physical memory */
+        if (mcd_read_write_physical_memory(address_space, attributes,
+            mem_address, mcdserver_state.mem_buf->data,
+            mcdserver_state.mem_buf->len, false) != 0) {
+            mcd_put_packet(TCP_EXECUTION_ERROR);
+            return;
+        }
+    } else {
+        /* user space memory */
+        if (mcd_read_write_memory(cpu, address_space, attributes, mem_address,
+            mcdserver_state.mem_buf->data, mcdserver_state.mem_buf->len,
+            false) != 0) {
+            mcd_put_packet(TCP_EXECUTION_ERROR);
+            return;
+        }
+    }
+    /* send data */
+    mcd_memtohex(mcdserver_state.str_buf, mcdserver_state.mem_buf->data,
+        mcdserver_state.mem_buf->len);
+    mcd_put_strbuf();
+}
+
+/**
+ * handle_write_memory() - Handler for writing memory.
+ *
+ * First, this function checks whether reading a secure memory space is
+ * requested and changes the access mode with :c:func:`arm_mcd_set_scr`.
+ * Then it converts the incoming hex string data into a byte array with
+ * :c:func:`mcd_hextomem`. Then it calls :c:func:`mcd_write_memory` to write to
+ * the register.
+ * @params: GArray with all TCP packet parameters.
+ */
+static void handle_write_memory(GArray *params, void *user_ctx)
+{
+    /* read input parameters */
+    uint32_t cpu_id = get_param(params, 0)->cpu_id;
+    uint32_t mem_space_id = get_param(params, 1)->data_uint32_t;
+    uint64_t mem_address = get_param(params, 2)->data_uint64_t;
+    uint32_t len = get_param(params, 3)->data_uint32_t;
+    /* check which memory space was requested */
+    CPUState *cpu = mcd_get_cpu(cpu_id);
+    GArray *memspaces =
+        g_list_nth_data(mcdserver_state.all_memspaces, cpu_id);
+    mcd_mem_space_st space = g_array_index(memspaces, mcd_mem_space_st,
+        mem_space_id - 1);
+    /* get data in the QEMU address space and access attributes */
+    AddressSpace *address_space = mcd_get_address_space(cpu, cpu_id, space);
+    MemTxAttrs attributes = mcd_get_memtxattrs(cpu, space);
+    /* write memory data */
+    mcd_hextomem(mcdserver_state.mem_buf, mcdserver_state.str_buf->str, len);
+    if (space.is_physical) {
+        /* physical memory */
+        if (mcd_read_write_physical_memory(address_space, attributes,
+            mem_address, mcdserver_state.mem_buf->data,
+            mcdserver_state.mem_buf->len, true) != 0) {
+            mcd_put_packet(TCP_EXECUTION_ERROR);
+            return;
+        }
+    } else {
+        /* user space memory */
+        if (mcd_read_write_memory(cpu, address_space, attributes, mem_address,
+            mcdserver_state.mem_buf->data, mcdserver_state.mem_buf->len,
+            true) != 0) {
+            mcd_put_packet(TCP_EXECUTION_ERROR);
+            return;
+        }
+    }
+    /* send acknowledge */
+    mcd_put_packet(TCP_EXECUTION_SUCCESS);
+}
+
 /**
  * mcd_handle_packet() - Evaluates the type of received packet and chooses the
  * correct handler.
@@ -1128,6 +1308,29 @@ static int mcd_handle_packet(const char *line_buf)
             cmd_parser = &write_reg_cmd_desc;
         }
         break;
+    case TCP_CHAR_READ_MEMORY:
+        {
+            static MCDCmdParseEntry read_mem_cmd_desc = {
+                .handler = handle_read_memory,
+                .cmd = {TCP_CHAR_READ_MEMORY, '\0'},
+                .schema = {ARG_SCHEMA_CORENUM, ARG_SCHEMA_INT,
+                           ARG_SCHEMA_UINT64_T, ARG_SCHEMA_INT, '\0'},
+            };
+            cmd_parser = &read_mem_cmd_desc;
+        }
+        break;
+    case TCP_CHAR_WRITE_MEMORY:
+        {
+            static MCDCmdParseEntry write_mem_cmd_desc = {
+                .handler = handle_write_memory,
+                .cmd = {TCP_CHAR_WRITE_MEMORY, '\0'},
+                .schema = {ARG_SCHEMA_CORENUM, ARG_SCHEMA_INT,
+                           ARG_SCHEMA_UINT64_T, ARG_SCHEMA_INT,
+                           ARG_SCHEMA_HEXDATA, '\0'},
+            };
+            cmd_parser = &write_mem_cmd_desc;
+        }
+        break;
     default:
         /* command not supported */
         mcd_put_packet("");
diff --git a/include/mcdstub/arm_mcdstub.h b/include/mcdstub/arm_mcdstub.h
index 9961145f07..69f6e2d487 100644
--- a/include/mcdstub/arm_mcdstub.h
+++ b/include/mcdstub/arm_mcdstub.h
@@ -100,4 +100,19 @@ int arm_mcd_get_additional_register_info(GArray *reggroups, GArray *registers,
  */
 uint16_t arm_mcd_get_opcode(CPUState *cs, uint32_t n);
 
+/**
+ * arm_mcd_get_address_space() - Returnes the correct QEMU address space name
+ * @cpu_id: Correct CPU ID
+ * @mem_space: Desired mcd specific memory space.
+ */
+AddressSpace *arm_mcd_get_address_space(uint32_t cpu_id,
+    mcd_mem_space_st mem_space);
+
+/**
+ * arm_mcd_get_memtxattrs() - Returnes the correct QEMU address space access
+ * attributes
+ * @mem_space: Desired mcd specific memory space.
+ */
+MemTxAttrs arm_mcd_get_memtxattrs(mcd_mem_space_st mem_space);
+
 #endif /* ARM_MCDSTUB_H */
-- 
2.34.1


