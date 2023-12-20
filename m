Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A5981A508
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 17:28:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFzP6-0000Rh-8U; Wed, 20 Dec 2023 11:26:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1rFzP3-0000Pa-Ex
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 11:26:37 -0500
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1rFzOz-0004ht-A1
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 11:26:36 -0500
Received: (qmail 15166 invoked by uid 484); 20 Dec 2023 16:26:08 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.07155 secs); 20 Dec 2023 16:26:08 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP
 for <qemu-devel@nongnu.org>; 20 Dec 2023 16:26:07 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Christian Boenig" <christian.boenig@lauterbach.com>,
 "Nicolas Eder" <nicolas.eder@lauterbach.com>
Subject: [PATCH v5 05/18] mcdstub: memory helper functions added
Date: Wed, 20 Dec 2023 17:25:42 +0100
Message-Id: <20231220162555.19545-6-nicolas.eder@lauterbach.com>
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
 include/exec/cpu-common.h |  3 +++
 include/exec/memory.h     |  9 +++++++++
 system/memory.c           | 11 +++++++++++
 system/physmem.c          | 26 ++++++++++++++++++++++++++
 4 files changed, 49 insertions(+)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 41115d8919..dd989b5ab2 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -182,6 +182,9 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length);
 int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
                         void *ptr, size_t len, bool is_write);
 
+int cpu_memory_get_physical_address(CPUState *cpu, vaddr *addr, size_t *len);
+
+
 /* vl.c */
 void list_cpus(void);
 
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 831f7c996d..174de807d5 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -3142,6 +3142,15 @@ bool ram_block_discard_is_disabled(void);
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
diff --git a/system/memory.c b/system/memory.c
index 798b6c0a17..9a8fa79e0c 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3562,6 +3562,17 @@ void mtree_info(bool flatview, bool dispatch_tree, bool owner, bool disabled)
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
index a63853a7bc..70733c67c7 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3422,6 +3422,32 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
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
-- 
2.34.1


