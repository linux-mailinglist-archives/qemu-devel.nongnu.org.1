Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 640979C8F23
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Nov 2024 17:05:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcIP-0004zv-7z; Thu, 14 Nov 2024 11:02:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcI0-0004xj-Ns
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:01:49 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcHt-0002CX-Q4
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:01:43 -0500
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-7ea8c4ce232so769670a12.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600100; x=1732204900; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XI4td4zXdpc3AvbTmQTiCq3YxLJsDwG9audmxtHxV6A=;
 b=IRfey1D/KtOfBn2QQfskqNzVyXMotSAmZrAeKvaqlXSbkua/H+wxbSAYa+4oYPMcKk
 ZtLIBb4AuM/OBG8FuDBlEa9JcYdRax4GxWqXgY5VNEayUEk8yaGAGDY3l0Yw4xHqqoBb
 EDlvBIWyBn4vZCtRRPizz/cS6qQc1cGyL54GYMJyHZIQOOfYgD2QgnQeyd4b7sKVRmWn
 RJdtG/fsex25es+Mx5nSBx1R/W/3xLyBNuweCUrz985qnt/ZbWpnncGEPoC+6newnEy8
 i+tss3TmsbMrTrTZ/488ReNecFQgPR5j9bAuQE6zHxQR2UMrPlH+NGVLEtgMd9D1P1eB
 PKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600100; x=1732204900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XI4td4zXdpc3AvbTmQTiCq3YxLJsDwG9audmxtHxV6A=;
 b=BThfWvBaL8YskgmnS3CG6WBBDi9g/wA5Y1sllw4NT6LycfIdeaD+O54aixIoQZMWBY
 wd/knMvmkKXq1wn0GWiawtUvY2b8NMtyz5rVPF6O7hVRfnKxAa/G6uo4XGN1FvgZ8qph
 p7/rVTwfle67a+B1qfk3wEMRhQ4qq4MeLNPaphCTEGjmENmwifmCjLIeug6apxjtx+Nw
 S/8byXRKglsh9nukRwghaF/4FK0uwOJBbUzlslro/6VBB/ZS528YT78lqr5+JDMvxTFV
 iu2d3JcT54/SxVRRJGip/y4/h544KnJWmZrGYFZTXXKxC0W0m7A4BNEeDTfbxLSp2J47
 CrDg==
X-Gm-Message-State: AOJu0YxSdz+/paZ6UC/oYjhYv2LFfeRxCXY6LRCh5kgaIfAHyj2gKjBB
 DfRSwk87Oz1yj1/RfnJbO08iVuVEcy3WAra8FrC7a034fRShNKYt3R9T7GWDr+WB97VN+ZLgKqU
 h
X-Google-Smtp-Source: AGHT+IEuwH57RqruKUul5HK6LB7ubc7jYrLG/M06QUbRhTpEVdLaouUVjy8IM8+BBWnZ6hZ77SOcPg==
X-Received: by 2002:a17:90a:d450:b0:2e0:894f:198e with SMTP id
 98e67ed59e1d1-2ea0639fc36mr2943291a91.30.1731600100006; 
 Thu, 14 Nov 2024 08:01:40 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024ec723sm1484438a91.46.2024.11.14.08.01.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 08:01:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/54] accel/tcg: Populate IntervalTree in tlb_set_page_full
Date: Thu, 14 Nov 2024 08:00:46 -0800
Message-ID: <20241114160131.48616-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114160131.48616-1-richard.henderson@linaro.org>
References: <20241114160131.48616-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

Add or replace an entry in the IntervalTree for each
page installed into softmmu.  We do not yet use the
tree for anything else.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index aa51fc1d26..ea6a5177de 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -305,6 +305,17 @@ static void tlbfast_flush_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast)
     memset(fast->table, -1, sizeof_tlb(fast));
 }
 
+static CPUTLBEntryTree *tlbtree_lookup_range(CPUTLBDesc *desc, vaddr s, vaddr l)
+{
+    IntervalTreeNode *i = interval_tree_iter_first(&desc->iroot, s, l);
+    return i ? container_of(i, CPUTLBEntryTree, itree) : NULL;
+}
+
+static CPUTLBEntryTree *tlbtree_lookup_addr(CPUTLBDesc *desc, vaddr addr)
+{
+    return tlbtree_lookup_range(desc, addr, addr);
+}
+
 static void tlb_mmu_flush_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast)
 {
     tlbfast_flush_locked(desc, fast);
@@ -1072,7 +1083,8 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
     MemoryRegionSection *section;
     unsigned int index, read_flags, write_flags;
     uintptr_t addend;
-    CPUTLBEntry *te, tn;
+    CPUTLBEntry *te;
+    CPUTLBEntryTree *node;
     hwaddr iotlb, xlat, sz, paddr_page;
     vaddr addr_page;
     int asidx, wp_flags, prot;
@@ -1180,6 +1192,15 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
         tlb_n_used_entries_dec(cpu, mmu_idx);
     }
 
+    /* Replace an old IntervalTree entry, or create a new one. */
+    node = tlbtree_lookup_addr(desc, addr_page);
+    if (!node) {
+        node = g_new(CPUTLBEntryTree, 1);
+        node->itree.start = addr_page;
+        node->itree.last = addr_page + TARGET_PAGE_SIZE - 1;
+        interval_tree_insert(&node->itree, &desc->iroot);
+    }
+
     /* refill the tlb */
     /*
      * When memory region is ram, iotlb contains a TARGET_PAGE_BITS
@@ -1201,15 +1222,15 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
     full->phys_addr = paddr_page;
 
     /* Now calculate the new entry */
-    tn.addend = addend - addr_page;
+    node->copy.addend = addend - addr_page;
 
-    tlb_set_compare(full, &tn, addr_page, read_flags,
+    tlb_set_compare(full, &node->copy, addr_page, read_flags,
                     MMU_INST_FETCH, prot & PAGE_EXEC);
 
     if (wp_flags & BP_MEM_READ) {
         read_flags |= TLB_WATCHPOINT;
     }
-    tlb_set_compare(full, &tn, addr_page, read_flags,
+    tlb_set_compare(full, &node->copy, addr_page, read_flags,
                     MMU_DATA_LOAD, prot & PAGE_READ);
 
     if (prot & PAGE_WRITE_INV) {
@@ -1218,10 +1239,11 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
     if (wp_flags & BP_MEM_WRITE) {
         write_flags |= TLB_WATCHPOINT;
     }
-    tlb_set_compare(full, &tn, addr_page, write_flags,
+    tlb_set_compare(full, &node->copy, addr_page, write_flags,
                     MMU_DATA_STORE, prot & PAGE_WRITE);
 
-    copy_tlb_helper_locked(te, &tn);
+    node->full = *full;
+    copy_tlb_helper_locked(te, &node->copy);
     tlb_n_used_entries_inc(cpu, mmu_idx);
     qemu_spin_unlock(&tlb->c.lock);
 }
-- 
2.43.0


