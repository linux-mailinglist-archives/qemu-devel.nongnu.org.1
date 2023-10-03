Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 305A67B7017
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:42:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnjFA-0008Vx-VS; Tue, 03 Oct 2023 13:31:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjEy-0008PN-UU
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:24 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjEw-0007Vd-IL
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:24 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-690fe10b6a4so926263b3a.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 10:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696354281; x=1696959081; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TVqkrTpBkS08OOtc33GfGLABbq/z0dDCKK+SIF9n4BI=;
 b=bkfbqShFPuLkYl3zqtRN64L5F+KjEPQa8VFZWw8IOt1OqR7gaL5q0H40nhZFovsT5a
 YelmDNBIBh8UBEIB6MV+Ezq+ghCPDNPSgkHhgMwKIRHQZKVEK0MxEcRGfuJFNEJe6WQU
 NAIkoyPTR+2Lwe/x5y2SSSH2qMhgvWIcbbDjNcl/21M9Cumzv/Ja2hFFlJxpofAbqR6w
 d2y4035YOQhC39TnQHQ/OcHBTHLkt1/4KV6GBquI1xo2WbSac13xSZeLuEFfB5AoZJ/G
 QoD9q55IYh2b4cF7B+Um4FegV2qbTJu6xhFWaoBD6ybpiWRtB0iuQ4onQnDHnKU/dnDx
 eIEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696354281; x=1696959081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TVqkrTpBkS08OOtc33GfGLABbq/z0dDCKK+SIF9n4BI=;
 b=juSL5EE2Nj7hwOI8A0GUK/pcKRm8DAwqDI6py3bAQx3GimWIJmO26bjZ1nRRzEWG0q
 blda6HZX5h7pbdrolIGVzoIaCFcJqma2OIkplwMhfPeV+rfD74+ObGxff3xSHIIDQQIl
 bNP0HsQVTrH7Kf0YNsz0yNGFEhMcpKcAU+tgWuDLGNQGevb6poIIBIx9vTKppINFnBl5
 oLlRqc4ZUbPQFQdm8xFCxyWi7jLVxGgHgmrvMJAAIqNQ6LqTzRAY4n04eZ5hj3HGM7ye
 xKF1dbddyc0Kzujbn+BrhF2Aby5lTFdyP7Jivit0HefPWx0XyxQY/6DpDQqIVfyAVuS9
 nIGw==
X-Gm-Message-State: AOJu0YxniXCGJ0+jm3NTaj0ItaNJda+630/vLH9T8Xomfwvu/lbY3Cgj
 OOd4cK0qkVZOgaGdqeBqHISbKwRkgaG68gSrOmU=
X-Google-Smtp-Source: AGHT+IG3ucSaG01zoX5luBcpR0auJUW2NqwTcNIywGRkhSshu67B9E3P7dVJXdG02vFyaUnFRGoxsQ==
X-Received: by 2002:a05:6a00:1a50:b0:690:d2de:14cc with SMTP id
 h16-20020a056a001a5000b00690d2de14ccmr254592pfv.33.1696354281356; 
 Tue, 03 Oct 2023 10:31:21 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 n7-20020aa78a47000000b00692c5b1a731sm1620195pfa.186.2023.10.03.10.31.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 10:31:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 24/47] accel/tcg: Modify probe_access_internal() to use CPUState
Date: Tue,  3 Oct 2023 10:30:29 -0700
Message-Id: <20231003173052.1601813-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003173052.1601813-1-richard.henderson@linaro.org>
References: <20231003173052.1601813-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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


