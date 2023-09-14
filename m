Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCEC79F85A
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 04:46:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgcLs-0000id-7Y; Wed, 13 Sep 2023 22:45:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgcLp-0000hg-7D
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:45:05 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgcLg-0000iS-4j
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:45:04 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1c35ee3b0d2so3463535ad.2
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 19:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694659493; x=1695264293; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=skNSUn67Ug/6vsn+Dhfw8oKIAijo+nwUGwKe8ststcw=;
 b=rNXIlk5eEOj0Fb/wEocWr5+SBmTquNwBQ7AFbn6t3HQHZPFVnGL9z4lGGFALA/4EEN
 nsM+YKGbmXGLIG0Nc8/VDOUJLpkgdXY9LbwuG4Mi9Fd5oSupqlInxlOwV1HbhrIF9KkL
 fJOhYCL4RTKL97vUYDCUGygCp/i2RAgun45FVXMaHhMuaQpNIofSDes1UyqXWGrk4ZTT
 TvSoWF+r9g13N27Okh7bILMyKi8QpYdfknKIq2inVIA+mvqqgCCFaNBucdvzQWSfCJSY
 plGlES3xEcIiwl01DL/c5HCTAP/jT6uj5q451LZRuLx13iTtfcrGjk+F/mkkVpIpdM0o
 3kJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694659493; x=1695264293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=skNSUn67Ug/6vsn+Dhfw8oKIAijo+nwUGwKe8ststcw=;
 b=WzTnnALBQb0dDdw12LvULlGix4+38sRi7+pmbp4nechX0JGWMMf4m6U1bCoJP37X/b
 FkQp9a67wjNcKZiawj4v9VQr7vluzF/qvH9wjMD9QHoPnVqy3tWeqAyDl9QsoGLcDJrp
 7cuLf326ZFenbwaFYWryEJ1OPDaU9r/MPJBGsTRWBCECMkYJR73uAwAYKu7YNGtzCrkt
 io4vEdOqPp3saWZktenSorkAU9d8uNIcva4gt/fQZHOJeufWNBrhG4RP1FDIpNnTBXQt
 5Jxgae2wnNUGLzvm5MJPkjefjFcEwarlUMsDP/cGbAzSjVhR7FYEZx8mCgk+Yx+LHU3h
 YeVQ==
X-Gm-Message-State: AOJu0YxisUTONS4bOkWLhuxBHjOg2mjt8XJgyeZw9xzsogzP/yJuxyu1
 oML2PIjJT/uajlkH0GMcqRHmiKPGQ9RQAeVGN+s=
X-Google-Smtp-Source: AGHT+IEnVyc6HzexlbLNK8a/Eo3Ey2t6Yzc7iVzqOHernHoGt38CbjFfm1O5Z5uj+mmj7HSTeXECjg==
X-Received: by 2002:a17:902:f693:b0:1c3:83e2:d0c6 with SMTP id
 l19-20020a170902f69300b001c383e2d0c6mr5736516plg.52.1694659493510; 
 Wed, 13 Sep 2023 19:44:53 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 x24-20020a170902b41800b001bbdf32f011sm304336plr.269.2023.09.13.19.44.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 19:44:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng,
	ale@rev.ng,
	philmd@linaro.org
Subject: [PATCH v2 18/24] accel/tcg: Modify probe_access_internal() to use
 CPUState
Date: Wed, 13 Sep 2023 19:44:29 -0700
Message-Id: <20230914024435.1381329-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914024435.1381329-1-richard.henderson@linaro.org>
References: <20230914024435.1381329-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
[rth: Use cpu->neg.tlb instead of cpu_tlb()]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 08df68f03a..f3ac87050e 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1504,27 +1504,24 @@ static void notdirty_write(CPUState *cpu, vaddr mem_vaddr, unsigned size,
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
@@ -1532,8 +1529,8 @@ static int probe_access_internal(CPUArchState *env, vaddr addr,
             }
 
             /* TLB resize via tlb_fill may have moved the entry.  */
-            index = tlb_index(env_cpu(env), mmu_idx, addr);
-            entry = tlb_entry(env_cpu(env), mmu_idx, addr);
+            index = tlb_index(cpu, mmu_idx, addr);
+            entry = tlb_entry(cpu, mmu_idx, addr);
 
             /*
              * With PAGE_WRITE_INV, we set TLB_INVALID_MASK immediately,
@@ -1546,7 +1543,7 @@ static int probe_access_internal(CPUArchState *env, vaddr addr,
     }
     flags &= tlb_addr;
 
-    *pfull = full = &env_tlb(env)->d[mmu_idx].fulltlb[index];
+    *pfull = full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
     flags |= full->slow_flags[access_type];
 
     /* Fold all "mmio-like" bits into TLB_MMIO.  This is not RAM.  */
@@ -1567,8 +1564,9 @@ int probe_access_full(CPUArchState *env, vaddr addr, int size,
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
@@ -1590,8 +1588,8 @@ int probe_access_full_mmu(CPUArchState *env, vaddr addr, int size,
     phost = phost ? phost : &discard_phost;
     pfull = pfull ? pfull : &discard_tlb;
 
-    int flags = probe_access_internal(env, addr, size, access_type, mmu_idx,
-                                      true, phost, pfull, 0, false);
+    int flags = probe_access_internal(env_cpu(env), addr, size, access_type,
+                                      mmu_idx, true, phost, pfull, 0, false);
 
     /* Handle clean RAM pages.  */
     if (unlikely(flags & TLB_NOTDIRTY)) {
@@ -1611,8 +1609,9 @@ int probe_access_flags(CPUArchState *env, vaddr addr, int size,
 
     g_assert(-(addr | TARGET_PAGE_MASK) >= size);
 
-    flags = probe_access_internal(env, addr, size, access_type, mmu_idx,
-                                  nonfault, phost, &full, retaddr, true);
+    flags = probe_access_internal(env_cpu(env), addr, size, access_type,
+                                  mmu_idx, nonfault, phost, &full, retaddr,
+                                  true);
 
     /* Handle clean RAM pages. */
     if (unlikely(flags & TLB_NOTDIRTY)) {
@@ -1632,8 +1631,9 @@ void *probe_access(CPUArchState *env, vaddr addr, int size,
 
     g_assert(-(addr | TARGET_PAGE_MASK) >= size);
 
-    flags = probe_access_internal(env, addr, size, access_type, mmu_idx,
-                                  false, &host, &full, retaddr, true);
+    flags = probe_access_internal(env_cpu(env), addr, size, access_type,
+                                  mmu_idx, false, &host, &full, retaddr,
+                                  true);
 
     /* Per the interface, size == 0 merely faults the access. */
     if (size == 0) {
@@ -1665,7 +1665,7 @@ void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
     void *host;
     int flags;
 
-    flags = probe_access_internal(env, addr, 0, access_type,
+    flags = probe_access_internal(env_cpu(env), addr, 0, access_type,
                                   mmu_idx, true, &host, &full, 0, false);
 
     /* No combination of flags are expected by the caller. */
@@ -1688,7 +1688,7 @@ tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, vaddr addr,
     CPUTLBEntryFull *full;
     void *p;
 
-    (void)probe_access_internal(env, addr, 1, MMU_INST_FETCH,
+    (void)probe_access_internal(env_cpu(env), addr, 1, MMU_INST_FETCH,
                                 cpu_mmu_index(env, true), false,
                                 &p, &full, 0, false);
     if (p == NULL) {
-- 
2.34.1


