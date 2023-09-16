Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 342E17A32A7
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 23:43:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhd32-0005Bt-8D; Sat, 16 Sep 2023 17:41:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd2x-0005AE-Iw
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:41:47 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd2t-0000Sl-SV
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:41:47 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-68fbbb953cfso2904802b3a.2
 for <qemu-devel@nongnu.org>; Sat, 16 Sep 2023 14:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694900502; x=1695505302; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TVqkrTpBkS08OOtc33GfGLABbq/z0dDCKK+SIF9n4BI=;
 b=xBhSxwBFxtMVxXpESsrhr4sY7V/isHrdnVzr/wuhWM4Ftg9pGipAi4QBNh3Gu/y1pD
 hY6NAugzDYBEiiozKUKUJob+ZoORPkO7zCQaxwxu85XsGub1zBfQviYDBynECf7AVLhi
 fynuc4ODWs6iYhN8U6BV6ZJbuIEdZX2hXepE5RgpCWTfLvxeyem0Uxpp6h7lrOvXT9WM
 Ue0Y1rMjFBnWY4U5jccXer3BYS0gEZi14Gtjir88bz6liuwOA8PuW8kEeelae5/0QS1/
 4n1ChtIehRncTLWOkdTLu+GtKKk1veTzvKK1Znt/g2y5o7K6rGvvLqAQAJI66TwyNMT9
 Jzrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694900502; x=1695505302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TVqkrTpBkS08OOtc33GfGLABbq/z0dDCKK+SIF9n4BI=;
 b=bCL5CJbaS31YTzvYcTuxI9Hp8Msh9KKDqca13BE0PnGwvPS3QiTI/iJWRngiGV2cd7
 ryaQr1equLBP/LCbweInudDWbTp1pQhuKPyPOrcS97AiHDrt5/Y/sMaln9y+56aY2C2m
 DKRcly2yHzOyn5RvX2A2BRymcaM5cC1onC5scOSaZXEgpjNFtRUCpFsZTyRV5JkZ75L5
 ZkkvYjZj1u5zFGOk97V1xJqVu62SCmWi9coKY3SId4AVcI0BWr1NfW/utjyzvJvs678M
 AEegRAS0QnullGtyrwUqRFgz/Jss61p9XCeWVbjktJOWtR3Xaa5X6RSl5EMD2Qp6Xrjl
 rx5Q==
X-Gm-Message-State: AOJu0YygJTGpzDI2zet9p4F7lbCfT6hQ/YdOY4jAacpXBQNWFFF4Ovox
 8J5N88fpnOxOx3SRQU/lz6fpuQ+G66VTGQl2sD0=
X-Google-Smtp-Source: AGHT+IHanDw+X59OTMvGbSm548V7cHPuQ2nar0uTOAzAUC/wAYOMJieVpkafANx29dQt6jSMj6H3wA==
X-Received: by 2002:a05:6a00:1250:b0:68c:69c8:e0f0 with SMTP id
 u16-20020a056a00125000b0068c69c8e0f0mr6434709pfi.18.1694900502660; 
 Sat, 16 Sep 2023 14:41:42 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 n21-20020aa79055000000b0068fde95aa93sm4871708pfo.135.2023.09.16.14.41.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Sep 2023 14:41:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH v3 17/39] accel/tcg: Modify probe_access_internal() to use
 CPUState
Date: Sat, 16 Sep 2023 14:41:01 -0700
Message-Id: <20230916214123.525796-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916214123.525796-1-richard.henderson@linaro.org>
References: <20230916214123.525796-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

From: Anton Johansson <anjo@rev.ng>

probe_access_internal() is changed to instead take the generic CPUState
over CPUArchState, in order to lessen the target-specific coupling of
cputlb.c. Note: probe_access*() also don't need the full CPUArchState,
but aren't touched in this patch as they are target-facing.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20230912153428.17816-5-anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
[rth: Use cpu->neg.tlb instead of cpu_tlb()]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index f88c394594..ab52afb3f3 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1432,27 +1432,24 @@ static void notdirty_write(CPUState *cpu, vaddr mem_vaddr, unsigned size,
     }
 }
 
-static int probe_access_internal(CPUArchState *env, vaddr addr,
+static int probe_access_internal(CPUState *cpu, vaddr addr,
                                  int fault_size, MMUAccessType access_type,
                                  int mmu_idx, bool nonfault,
                                  void **phost, CPUTLBEntryFull **pfull,
                                  uintptr_t retaddr, bool check_mem_cbs)
 {
-    uintptr_t index = tlb_index(env_cpu(env), mmu_idx, addr);
-    CPUTLBEntry *entry = tlb_entry(env_cpu(env), mmu_idx, addr);
+    uintptr_t index = tlb_index(cpu, mmu_idx, addr);
+    CPUTLBEntry *entry = tlb_entry(cpu, mmu_idx, addr);
     uint64_t tlb_addr = tlb_read_idx(entry, access_type);
     vaddr page_addr = addr & TARGET_PAGE_MASK;
     int flags = TLB_FLAGS_MASK & ~TLB_FORCE_SLOW;
-    bool force_mmio = check_mem_cbs && cpu_plugin_mem_cbs_enabled(env_cpu(env));
+    bool force_mmio = check_mem_cbs && cpu_plugin_mem_cbs_enabled(cpu);
     CPUTLBEntryFull *full;
 
     if (!tlb_hit_page(tlb_addr, page_addr)) {
-        if (!victim_tlb_hit(env_cpu(env), mmu_idx, index,
-                            access_type, page_addr)) {
-            CPUState *cs = env_cpu(env);
-
-            if (!cs->cc->tcg_ops->tlb_fill(cs, addr, fault_size, access_type,
-                                           mmu_idx, nonfault, retaddr)) {
+        if (!victim_tlb_hit(cpu, mmu_idx, index, access_type, page_addr)) {
+            if (!cpu->cc->tcg_ops->tlb_fill(cpu, addr, fault_size, access_type,
+                                            mmu_idx, nonfault, retaddr)) {
                 /* Non-faulting page table read failed.  */
                 *phost = NULL;
                 *pfull = NULL;
@@ -1460,8 +1457,8 @@ static int probe_access_internal(CPUArchState *env, vaddr addr,
             }
 
             /* TLB resize via tlb_fill may have moved the entry.  */
-            index = tlb_index(env_cpu(env), mmu_idx, addr);
-            entry = tlb_entry(env_cpu(env), mmu_idx, addr);
+            index = tlb_index(cpu, mmu_idx, addr);
+            entry = tlb_entry(cpu, mmu_idx, addr);
 
             /*
              * With PAGE_WRITE_INV, we set TLB_INVALID_MASK immediately,
@@ -1474,7 +1471,7 @@ static int probe_access_internal(CPUArchState *env, vaddr addr,
     }
     flags &= tlb_addr;
 
-    *pfull = full = &env_tlb(env)->d[mmu_idx].fulltlb[index];
+    *pfull = full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
     flags |= full->slow_flags[access_type];
 
     /* Fold all "mmio-like" bits into TLB_MMIO.  This is not RAM.  */
@@ -1495,8 +1492,9 @@ int probe_access_full(CPUArchState *env, vaddr addr, int size,
                       bool nonfault, void **phost, CPUTLBEntryFull **pfull,
                       uintptr_t retaddr)
 {
-    int flags = probe_access_internal(env, addr, size, access_type, mmu_idx,
-                                      nonfault, phost, pfull, retaddr, true);
+    int flags = probe_access_internal(env_cpu(env), addr, size, access_type,
+                                      mmu_idx, nonfault, phost, pfull, retaddr,
+                                      true);
 
     /* Handle clean RAM pages.  */
     if (unlikely(flags & TLB_NOTDIRTY)) {
@@ -1518,8 +1516,8 @@ int probe_access_full_mmu(CPUArchState *env, vaddr addr, int size,
     phost = phost ? phost : &discard_phost;
     pfull = pfull ? pfull : &discard_tlb;
 
-    int flags = probe_access_internal(env, addr, size, access_type, mmu_idx,
-                                      true, phost, pfull, 0, false);
+    int flags = probe_access_internal(env_cpu(env), addr, size, access_type,
+                                      mmu_idx, true, phost, pfull, 0, false);
 
     /* Handle clean RAM pages.  */
     if (unlikely(flags & TLB_NOTDIRTY)) {
@@ -1539,8 +1537,9 @@ int probe_access_flags(CPUArchState *env, vaddr addr, int size,
 
     g_assert(-(addr | TARGET_PAGE_MASK) >= size);
 
-    flags = probe_access_internal(env, addr, size, access_type, mmu_idx,
-                                  nonfault, phost, &full, retaddr, true);
+    flags = probe_access_internal(env_cpu(env), addr, size, access_type,
+                                  mmu_idx, nonfault, phost, &full, retaddr,
+                                  true);
 
     /* Handle clean RAM pages. */
     if (unlikely(flags & TLB_NOTDIRTY)) {
@@ -1560,8 +1559,9 @@ void *probe_access(CPUArchState *env, vaddr addr, int size,
 
     g_assert(-(addr | TARGET_PAGE_MASK) >= size);
 
-    flags = probe_access_internal(env, addr, size, access_type, mmu_idx,
-                                  false, &host, &full, retaddr, true);
+    flags = probe_access_internal(env_cpu(env), addr, size, access_type,
+                                  mmu_idx, false, &host, &full, retaddr,
+                                  true);
 
     /* Per the interface, size == 0 merely faults the access. */
     if (size == 0) {
@@ -1593,7 +1593,7 @@ void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
     void *host;
     int flags;
 
-    flags = probe_access_internal(env, addr, 0, access_type,
+    flags = probe_access_internal(env_cpu(env), addr, 0, access_type,
                                   mmu_idx, true, &host, &full, 0, false);
 
     /* No combination of flags are expected by the caller. */
@@ -1616,7 +1616,7 @@ tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, vaddr addr,
     CPUTLBEntryFull *full;
     void *p;
 
-    (void)probe_access_internal(env, addr, 1, MMU_INST_FETCH,
+    (void)probe_access_internal(env_cpu(env), addr, 1, MMU_INST_FETCH,
                                 cpu_mmu_index(env, true), false,
                                 &p, &full, 0, false);
     if (p == NULL) {
-- 
2.34.1


