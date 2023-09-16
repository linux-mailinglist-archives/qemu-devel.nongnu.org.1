Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C017A2DB9
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 05:36:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhM14-00063t-P1; Fri, 15 Sep 2023 23:30:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM10-00061n-IA
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:38 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM0y-00083m-Mv
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:38 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-68fc9a4ebe9so2579941b3a.2
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 20:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694835035; x=1695439835; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AjeCPzUocYg1JKJ2KMopCouMlpFmZ9U4rN+3dpEuC9M=;
 b=p2XFWhNF5d9hTo1GLfKMzamaAYkXdtSSftYuXsYjknx864R7owLG6o/NVukAPnnUnR
 yqW1nAPSXNba+w+vMa8O42RcQA7tnDVCaSL/I5D5DGWAbJYkfUDNLDp1vZARzLvQbFPb
 ARSbHJjRIvGnq5XxscF0rLaIpDHK+UdHiSxJBnOjsycnkDnq/PIdIyETKMluIvyc4oQz
 pWL42/hOncJhF64nvjchRX7GI3vyMCdz1tp8mqAd9v6/ZxMKOZbXjodoatWKGPRM39j6
 Ua2boXbEUX5/clz+26c92eCJGQPOTIgLaF8+nvMM9yrvZACGvKci/njarKP62FULAMV7
 sSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694835035; x=1695439835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AjeCPzUocYg1JKJ2KMopCouMlpFmZ9U4rN+3dpEuC9M=;
 b=W3bHUslMe25IT/W5IJSKxGYYMCPqu9yw0vODuIX8iO1ZwkWor2t2FBTMFKiu9j4fHQ
 5GVinBJ39b3PBGsxQM97Irc8uABwqxS+MnXKIuEUAR6aIaaoROchWaP0nXO2CRgm3X4q
 yIGduchzCEyN+XHo+iTly56NsSSig4XGa9uFNIeAOVpCqHuWida0aG2olK3Wwc5ulKjf
 4X0/4nlqzhZCjXrFF34P4JtGJkFtKMpsO+zl/snasGQNrV98v31maFpOthc1OhxOsk8o
 LERVLqjq2xhomHLrDTOjwLvIzMynBDWDL+ji1yy5VS5N1/quUCmu85pKeM3uOhBrjpcB
 c6qA==
X-Gm-Message-State: AOJu0Yz7vbCqWWPWQKU0QuKFjSkBpRdG1SliJjEffiOuNdJf9NnyvF0Z
 RIqe+o6tdI4dMndelWNQAt+09/Fqe/cTyqsdWPw=
X-Google-Smtp-Source: AGHT+IF9n4aWbpIiAeL6BYYfuqQNi0ewg1q6Uxy86Gb9pjF2hocSGLavS0/P3ywiNNuNKINUKNExLw==
X-Received: by 2002:a05:6a21:7888:b0:153:56b1:8417 with SMTP id
 bf8-20020a056a21788800b0015356b18417mr4579835pzc.21.1694835035379; 
 Fri, 15 Sep 2023 20:30:35 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 j26-20020aa783da000000b00687a4b70d1esm3577320pfn.218.2023.09.15.20.30.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 20:30:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/39] accel/tcg: Simplify tlb_plugin_lookup
Date: Fri, 15 Sep 2023 20:29:56 -0700
Message-Id: <20230916033011.479144-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916033011.479144-1-richard.henderson@linaro.org>
References: <20230916033011.479144-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Now that we defer address space update and tlb_flush until
the next async_run_on_cpu, the plugin run at the end of the
instruction no longer has to contend with a flushed tlb.
Therefore, delete SavedIOTLB entirely.

Properly return false from tlb_plugin_lookup when we do
not have a tlb match.

Fixes a bug in which SavedIOTLB had stale data, because
there were multiple i/o accesses within a single insn.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h   | 13 -------
 include/qemu/typedefs.h |  1 -
 accel/tcg/cputlb.c      | 79 ++++++++++++-----------------------------
 3 files changed, 23 insertions(+), 70 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 92a4234439..648b5b3586 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -227,17 +227,6 @@ struct CPUWatchpoint {
     QTAILQ_ENTRY(CPUWatchpoint) entry;
 };
 
-#ifdef CONFIG_PLUGIN
-/*
- * For plugins we sometime need to save the resolved iotlb data before
- * the memory regions get moved around  by io_writex.
- */
-typedef struct SavedIOTLB {
-    MemoryRegionSection *section;
-    hwaddr mr_offset;
-} SavedIOTLB;
-#endif
-
 struct KVMState;
 struct kvm_run;
 
@@ -409,8 +398,6 @@ struct CPUState {
 
 #ifdef CONFIG_PLUGIN
     GArray *plugin_mem_cbs;
-    /* saved iotlb data from io_writex */
-    SavedIOTLB saved_iotlb;
 #endif
 
     /* TODO Move common fields from CPUArchState here. */
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 834b0e47a0..5abdbc3874 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -129,7 +129,6 @@ typedef struct QString QString;
 typedef struct RAMBlock RAMBlock;
 typedef struct Range Range;
 typedef struct ReservedRegion ReservedRegion;
-typedef struct SavedIOTLB SavedIOTLB;
 typedef struct SHPCDevice SHPCDevice;
 typedef struct SSIBus SSIBus;
 typedef struct TCGHelperInfo TCGHelperInfo;
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 03e27b2a38..9cbcd202d2 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1367,21 +1367,6 @@ static inline void cpu_transaction_failed(CPUState *cpu, hwaddr physaddr,
     }
 }
 
-/*
- * Save a potentially trashed CPUTLBEntryFull for later lookup by plugin.
- * This is read by tlb_plugin_lookup if the fulltlb entry doesn't match
- * because of the side effect of io_writex changing memory layout.
- */
-static void save_iotlb_data(CPUState *cs, MemoryRegionSection *section,
-                            hwaddr mr_offset)
-{
-#ifdef CONFIG_PLUGIN
-    SavedIOTLB *saved = &cs->saved_iotlb;
-    saved->section = section;
-    saved->mr_offset = mr_offset;
-#endif
-}
-
 static uint64_t io_readx(CPUArchState *env, CPUTLBEntryFull *full,
                          int mmu_idx, vaddr addr, uintptr_t retaddr,
                          MMUAccessType access_type, MemOp op)
@@ -1401,12 +1386,6 @@ static uint64_t io_readx(CPUArchState *env, CPUTLBEntryFull *full,
         cpu_io_recompile(cpu, retaddr);
     }
 
-    /*
-     * The memory_region_dispatch may trigger a flush/resize
-     * so for plugins we save the iotlb_data just in case.
-     */
-    save_iotlb_data(cpu, section, mr_offset);
-
     {
         QEMU_IOTHREAD_LOCK_GUARD();
         r = memory_region_dispatch_read(mr, mr_offset, &val, op, full->attrs);
@@ -1441,12 +1420,6 @@ static void io_writex(CPUArchState *env, CPUTLBEntryFull *full,
     }
     cpu->mem_io_pc = retaddr;
 
-    /*
-     * The memory_region_dispatch may trigger a flush/resize
-     * so for plugins we save the iotlb_data just in case.
-     */
-    save_iotlb_data(cpu, section, mr_offset);
-
     {
         QEMU_IOTHREAD_LOCK_GUARD();
         r = memory_region_dispatch_write(mr, mr_offset, val, op, full->attrs);
@@ -1729,45 +1702,39 @@ tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, vaddr addr,
  * in the softmmu lookup code (or helper). We don't handle re-fills or
  * checking the victim table. This is purely informational.
  *
- * This almost never fails as the memory access being instrumented
- * should have just filled the TLB. The one corner case is io_writex
- * which can cause TLB flushes and potential resizing of the TLBs
- * losing the information we need. In those cases we need to recover
- * data from a copy of the CPUTLBEntryFull. As long as this always occurs
- * from the same thread (which a mem callback will be) this is safe.
+ * The one corner case is i/o write, which can cause changes to the
+ * address space.  Those changes, and the corresponding tlb flush,
+ * should be delayed until the next TB, so even then this ought not fail.
+ * But check, Just in Case.
  */
-
 bool tlb_plugin_lookup(CPUState *cpu, vaddr addr, int mmu_idx,
                        bool is_store, struct qemu_plugin_hwaddr *data)
 {
     CPUArchState *env = cpu->env_ptr;
     CPUTLBEntry *tlbe = tlb_entry(env, mmu_idx, addr);
     uintptr_t index = tlb_index(env, mmu_idx, addr);
-    uint64_t tlb_addr = is_store ? tlb_addr_write(tlbe) : tlbe->addr_read;
+    MMUAccessType access_type = is_store ? MMU_DATA_STORE : MMU_DATA_LOAD;
+    uint64_t tlb_addr = tlb_read_idx(tlbe, access_type);
 
-    if (likely(tlb_hit(tlb_addr, addr))) {
-        /* We must have an iotlb entry for MMIO */
-        if (tlb_addr & TLB_MMIO) {
-            CPUTLBEntryFull *full;
-            full = &env_tlb(env)->d[mmu_idx].fulltlb[index];
-            data->is_io = true;
-            data->v.io.section =
-                iotlb_to_section(cpu, full->xlat_section, full->attrs);
-            data->v.io.offset = (full->xlat_section & TARGET_PAGE_MASK) + addr;
-        } else {
-            data->is_io = false;
-            data->v.ram.hostaddr = (void *)((uintptr_t)addr + tlbe->addend);
-        }
-        return true;
-    } else {
-        SavedIOTLB *saved = &cpu->saved_iotlb;
-        data->is_io = true;
-        data->v.io.section = saved->section;
-        data->v.io.offset = saved->mr_offset;
-        return true;
+    if (unlikely(!tlb_hit(tlb_addr, addr))) {
+        return false;
     }
-}
 
+    /* We must have an iotlb entry for MMIO */
+    if (tlb_addr & TLB_MMIO) {
+        CPUTLBEntryFull *full = &env_tlb(env)->d[mmu_idx].fulltlb[index];
+        hwaddr xlat = full->xlat_section;
+
+        data->is_io = true;
+        data->v.io.offset = (xlat & TARGET_PAGE_MASK) + addr;
+        data->v.io.section =
+            iotlb_to_section(cpu, xlat & ~TARGET_PAGE_MASK, full->attrs);
+    } else {
+        data->is_io = false;
+        data->v.ram.hostaddr = (void *)((uintptr_t)addr + tlbe->addend);
+    }
+    return true;
+}
 #endif
 
 /*
-- 
2.34.1


