Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D74B178B7AF
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 20:57:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qahP9-0000ql-0V; Mon, 28 Aug 2023 14:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qahP3-0000oV-BB
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 14:55:57 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qahP0-0002QW-R8
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 14:55:57 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-26d1a17ce06so1725245a91.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 11:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693248953; x=1693853753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=03eKjHBSqhHdZ2C0Bhm1xZE8o9z6xsoYmMLEvVPH1DU=;
 b=V+4+WRs+wA91WtdmjuCmZv3m/bypY/4YkVMNzRqFJ0UWrTlNPYFZDRyvJUfuvpKsBT
 OgYD76e5SRD9GHYXTBB7vvGE4ILru+OFnoBy+OW/7iEvOVRx0Z1AJJGMJ+lhFWgv4Ndk
 7qhEpVoNb4R9eh7NIZrnqKJblISeg/hsjdgSFmBAfrRbmsRMwRaAfVMkkLZ2v4AITgW4
 5HnK2DsdE2psAAPBqRuwqKGRwUH0HEHmoOkSBrDweiqB9XaPTgC2yPhF+5AgoEq0Tun8
 83DzEgyFD5TOSVGxcDRG6UNRN5UQs0qA+gsnH1eeqcstD9xltohyhq7NaGUmdhieA5mT
 dDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693248953; x=1693853753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=03eKjHBSqhHdZ2C0Bhm1xZE8o9z6xsoYmMLEvVPH1DU=;
 b=P3nMveWNkQGdXqzmVSw7SHQstd5pA/wNi1hKh7A+eI/FqTgBh33S9VWeYuU7UaGoCB
 qnQfEnWwoR2G3ucmirFDRzO/bdiK+gmrrwojBqLdzfz+EpFCuxpMj8ZDuvubiCdsThke
 1ne1Sv8Bs9GiqnQm7QSWy8hdYxFLeN2clvNHzSKqR8jz2fYHJifjk8S1w8e2DzxfMRD5
 WytNffWFJ1qrnsLRg6OLfSqLZSGJOw7Y1jvPRiMqAujqKKRNUgkKNaJIaZWN61HFGzKY
 ONraQCew9r0p0/oOyWbhow3FZudGJtPZvxw5mbfjRycW0brCnQb2P+jpYMeF0JdYOBPZ
 9Cog==
X-Gm-Message-State: AOJu0Yz/YJVQ1XguCqukDjo74mlZccv/iQ+l+lmHTEzvzWQxV2u1c/Qo
 YaI7b2vndJ96gGMqksII88EU844YJ5QGbDFh9Us=
X-Google-Smtp-Source: AGHT+IEVOGjGCZAikiv2ZkLsXqzCZBOCeQXqKKjv7B7QXOwqeUfRjepT7HsuhqsB2stJkFqkbpIHkA==
X-Received: by 2002:a17:90a:a389:b0:268:4314:2dc6 with SMTP id
 x9-20020a17090aa38900b0026843142dc6mr20076489pjp.37.1693248953198; 
 Mon, 28 Aug 2023 11:55:53 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 4-20020a17090a190400b002680dfd368dsm7932835pjg.51.2023.08.28.11.55.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 11:55:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
Subject: [PATCH 01/10] accel/tcg: Simplify tlb_plugin_lookup
Date: Mon, 28 Aug 2023 11:55:41 -0700
Message-Id: <20230828185550.573653-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230828185550.573653-1-richard.henderson@linaro.org>
References: <20230828185550.573653-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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
index fdcbe87352..20e4f64d72 100644
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
index c643d66190..fcf6ccebff 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1364,21 +1364,6 @@ static inline void cpu_transaction_failed(CPUState *cpu, hwaddr physaddr,
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
@@ -1398,12 +1383,6 @@ static uint64_t io_readx(CPUArchState *env, CPUTLBEntryFull *full,
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
@@ -1438,12 +1417,6 @@ static void io_writex(CPUArchState *env, CPUTLBEntryFull *full,
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
@@ -1726,45 +1699,39 @@ tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, vaddr addr,
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


