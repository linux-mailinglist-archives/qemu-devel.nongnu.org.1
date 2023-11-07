Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C48A57E3F93
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 14:05:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0LlM-0000OQ-4D; Tue, 07 Nov 2023 08:05:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1r0Ll2-00009I-3Q
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:04:42 -0500
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1r0Lkr-00062c-V0
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:04:32 -0500
Received: (qmail 31491 invoked by uid 484); 7 Nov 2023 13:04:16 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.125942 secs); 07 Nov 2023 13:04:16 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP for <qemu-devel@nongnu.org>; 7 Nov 2023 13:04:15 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: "Nicolas Eder" <nicolas.eder@lauterbach.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Christian Boenig" <christian.boenig@lauterbach.com>
Subject: [PATCH v3 18/20] mcdstub: read/write to memory added: This also
 includes various helper functions in the QEMU memory code
Date: Tue,  7 Nov 2023 14:03:21 +0100
Message-Id: <20231107130323.4126-19-nicolas.eder@lauterbach.com>
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
 include/exec/cpu-common.h     |   2 +
 include/exec/memory.h         |   9 ++
 include/mcdstub/arm_mcdstub.h |  16 ++++
 include/mcdstub/mcdstub.h     |  69 +++++++++++++++
 mcdstub/mcdstub.c             | 153 ++++++++++++++++++++++++++++++++++
 system/memory.c               |  11 +++
 system/physmem.c              |  26 ++++++
 target/arm/mcdstub.c          |  26 ++++++
 8 files changed, 312 insertions(+)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 30c376a4de..86b3176de5 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -185,6 +185,8 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length);
 int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
                         void *ptr, size_t len, bool is_write);
 
+int cpu_memory_get_physical_address(CPUState *cpu, vaddr *addr, size_t *len);
+
 /* vl.c */
 void list_cpus(void);
 
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 9087d02769..ff8642d883 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -3110,6 +3110,15 @@ bool ram_block_discard_is_disabled(void);
  */
 bool ram_block_discard_is_required(void);
 
+/*
+ * mcd_find_address_space() - Find the address spaces with the corresponding
+ * name.
+ *
+ * Currently only used by the mcd debugger.
+ * @as_name: Name to look for.
+ */
+AddressSpace *mcd_find_address_space(const char *as_name);
+
 #endif
 
 #endif
diff --git a/include/mcdstub/arm_mcdstub.h b/include/mcdstub/arm_mcdstub.h
index c71f6c3356..fb9abaaf7d 100644
--- a/include/mcdstub/arm_mcdstub.h
+++ b/include/mcdstub/arm_mcdstub.h
@@ -87,5 +87,21 @@ int arm_mcd_parse_general_xml_files(CPUState *cpu, GArray* reggroups,
  * @cpu: The CPU state.
  */
 int arm_mcd_get_additional_register_info(GArray *reggroups, GArray *registers,
+    CPUState *cpu);
+
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
 
 #endif /* ARM_MCDSTUB_H */
diff --git a/include/mcdstub/mcdstub.h b/include/mcdstub/mcdstub.h
index 6b2249f8fb..c55d52d2a7 100644
--- a/include/mcdstub/mcdstub.h
+++ b/include/mcdstub/mcdstub.h
@@ -709,6 +709,31 @@ void handle_read_register(GArray *params, void *user_ctx);
  * @params: GArray with all TCP packet parameters.
  */
 void handle_write_register(GArray *params, void *user_ctx);
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
+void handle_read_memory(GArray *params, void *user_ctx);
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
+void handle_write_memory(GArray *params, void *user_ctx);
+
 /**
  * mcd_read_register() - Reads a registers data and stores it into the buf.
  *
@@ -733,6 +758,50 @@ int mcd_read_register(CPUState *cpu, GByteArray *buf, int reg);
  */
 int mcd_write_register(CPUState *cpu, uint8_t *mem_buf, int reg);
 
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
+int mcd_read_write_physical_memory(AddressSpace *address_space,
+    MemTxAttrs attributes, hwaddr addr, uint8_t *buf, int len, bool is_write);
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
+int mcd_read_write_memory(CPUState *cpu, AddressSpace *address_space,
+    MemTxAttrs attributes, vaddr addr, uint8_t *buf, uint64_t len,
+    bool is_write);
+
+/**
+ * mcd_get_address_space() - Returnes the correct QEMU address space name
+ * @cpu: CPUState
+ * @cpu_id: Correct CPU ID
+ * @mem_space: Desired mcd specific memory space.
+ */
+AddressSpace *mcd_get_address_space(CPUState *cpu, uint32_t cpu_id,
+    mcd_mem_space_st mem_space);
+
+/**
+ * mcd_get_memtxattrs() - Returnes the correct QEMU address space access
+ * attributes
+ * @cpu: CPUState
+ * @mem_space: Desired mcd specific memory space.
+ */
+MemTxAttrs mcd_get_memtxattrs(CPUState *cpu, mcd_mem_space_st mem_space);
+
 /* helpers */
 
 /**
diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index 018900e914..8dc1e6a71d 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -545,6 +545,31 @@ int mcd_handle_packet(const char *line_buf)
             cmd_parser = &write_reg_cmd_desc;
         }
         break;
+    case TCP_CHAR_READ_MEMORY:
+        {
+            static MCDCmdParseEntry read_mem_cmd_desc = {
+                .handler = handle_read_memory,
+            };
+            read_mem_cmd_desc.cmd = (char[2]) { TCP_CHAR_READ_MEMORY, '\0' };
+            strcpy(read_mem_cmd_desc.schema,
+                (char[5]) { ARG_SCHEMA_CORENUM, ARG_SCHEMA_INT,
+                ARG_SCHEMA_UINT64_T, ARG_SCHEMA_INT, '\0' });
+            cmd_parser = &read_mem_cmd_desc;
+        }
+        break;
+    case TCP_CHAR_WRITE_MEMORY:
+        {
+            static MCDCmdParseEntry write_mem_cmd_desc = {
+                .handler = handle_write_memory,
+            };
+            write_mem_cmd_desc.cmd = (char[2]) { TCP_CHAR_WRITE_MEMORY, '\0' };
+            strcpy(write_mem_cmd_desc.schema,
+                (char[6]) { ARG_SCHEMA_CORENUM, ARG_SCHEMA_INT,
+                ARG_SCHEMA_UINT64_T, ARG_SCHEMA_INT,
+                ARG_SCHEMA_HEXDATA, '\0' });
+            cmd_parser = &write_mem_cmd_desc;
+        }
+        break;
     default:
         /* command not supported */
         mcd_put_packet("");
@@ -1727,3 +1752,131 @@ void handle_write_register(GArray *params, void *user_ctx)
         mcd_put_packet(TCP_EXECUTION_SUCCESS);
     }
 }
+
+int mcd_read_write_physical_memory(AddressSpace *address_space,
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
+int mcd_read_write_memory(CPUState *cpu, AddressSpace *address_space,
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
+AddressSpace *mcd_get_address_space(CPUState *cpu, uint32_t cpu_id,
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
+MemTxAttrs mcd_get_memtxattrs(CPUState *cpu, mcd_mem_space_st mem_space)
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
+void handle_read_memory(GArray *params, void *user_ctx)
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
+void handle_write_memory(GArray *params, void *user_ctx)
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
diff --git a/system/memory.c b/system/memory.c
index 4928f2525d..bb3d2067c4 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3577,6 +3577,17 @@ void mtree_info(bool flatview, bool dispatch_tree, bool owner, bool disabled)
     }
 }
 
+AddressSpace *mcd_find_address_space(const char *as_name)
+{
+    AddressSpace *as;
+    QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
+        if (strcmp(as->name, as_name) == 0) {
+            return as;
+        }
+    }
+    return NULL;
+}
+
 void memory_region_init_ram(MemoryRegion *mr,
                             Object *owner,
                             const char *name,
diff --git a/system/physmem.c b/system/physmem.c
index fc2b0fee01..60c15546f8 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3400,6 +3400,32 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
     return 0;
 }
 
+int cpu_memory_get_physical_address(CPUState *cpu, vaddr *addr, size_t *len)
+{
+    hwaddr phys_addr;
+    vaddr l, page;
+
+    cpu_synchronize_state(cpu);
+    MemTxAttrs attrs;
+
+    page = *addr & TARGET_PAGE_MASK;
+    phys_addr = cpu_get_phys_page_attrs_debug(cpu, page, &attrs);
+    /* if no physical page mapped, return an error */
+    if (phys_addr == -1) {
+        return -1;
+    }
+    l = (page + TARGET_PAGE_SIZE) - *addr;
+    if (l > *len) {
+        l = *len;
+    }
+    phys_addr += (*addr & ~TARGET_PAGE_MASK);
+
+    /* set output values */
+    *addr = phys_addr;
+    *len = l;
+    return 0;
+}
+
 /*
  * Allows code that needs to deal with migration bitmaps etc to still be built
  * target independent.
diff --git a/target/arm/mcdstub.c b/target/arm/mcdstub.c
index ff1350831b..c87e0e4784 100644
--- a/target/arm/mcdstub.c
+++ b/target/arm/mcdstub.c
@@ -276,3 +276,29 @@ int arm_mcd_get_additional_register_info(GArray *reggroups, GArray *registers,
     return 0;
 }
 
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
-- 
2.34.1


