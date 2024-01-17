Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B736A83095E
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 16:14:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ7bO-0005BE-AY; Wed, 17 Jan 2024 10:13:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQ7bL-0005Ah-Gl; Wed, 17 Jan 2024 10:13:11 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQ7bJ-0005ce-Re; Wed, 17 Jan 2024 10:13:11 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6d9b267007fso6536702b3a.3; 
 Wed, 17 Jan 2024 07:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705504388; x=1706109188; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gcrsC5HeITlAiHB8md0qnF9rr1mpyQxvSObDbA4amTY=;
 b=UjKxsKVT/sJdjYt+qsOePbIwzFk4/s89QPYfPuDpVeSmMejr876cwMcpqG2Z2QVq72
 9dfIA5ZQr4tniGzS5IxzNeG9d54QzAAta20Fder4DASAhR5qsmqUXMSWi3jyWYnyJvRk
 zTuPJ8OYEQEm+GfY6wfcJGmaDrLx0qJi+9LM6ScNd0m8k2USGM1/MO9s0lSwWDzHW6FV
 zyibf+1lnPXxf38XCeZESI1SY4oHevBhf0+eRacunU5RI3uvN2Mp/f8yY78Or1MXSLMA
 jTYcsl58M0FAVo9E8SAdQDuaEZcV1utdX1SElkbQuXCg8bzOxqf5CZAVkVwG/+rrbB1m
 CiWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705504388; x=1706109188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gcrsC5HeITlAiHB8md0qnF9rr1mpyQxvSObDbA4amTY=;
 b=FT6pmk7rceXn7iXdnhK21mk1bbxbdiAiWQ/PX4g90tKkF3AwpvOMBC4uHX+zLVcKRV
 lk4TsmAY/K+W6VwYBOGEfZ7cUhAMx2/aVcch4qpdP5D3HbJrcyAGVfNM9KswGjhkNuKT
 SvHwnBfPWMD4Aco8iIu+Ftb8Tr2CWaQcmnpz+DQOySJAVObPLk5VAByOyuydoXkdUrg4
 vMwdQXGe9RE5KlMv2Zep3WhSICGO/30gm//me8jP3sD4wSAT2JNqvn3q2fuCUYvL3AY3
 fMQXuaYpTxBD/mG5HlwLAvhBmpHHIcFe89mNKoTGYO60QnaVPoUumgw/snUxlwyPq1S3
 FCIQ==
X-Gm-Message-State: AOJu0YwoLO7UeeV6DDMIZIKqR/RSvYEUYetXvstY+Ncq2+hAWTI3i/eW
 B5jjvOaZiVNVFN0d7xSH3RXMs7BtL+I=
X-Google-Smtp-Source: AGHT+IGmKO6SXN3z2NNDnwOfuiGOyuE9TiXJij1MF0EWfBKuJqHnBFGCfXjfqhWOPWUcVWCKgG3vJQ==
X-Received: by 2002:a62:5ec3:0:b0:6d9:f6a7:b3b9 with SMTP id
 s186-20020a625ec3000000b006d9f6a7b3b9mr4937966pfb.50.1705504386669; 
 Wed, 17 Jan 2024 07:13:06 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 fb42-20020a056a002daa00b006d9aa4b65fasm1586976pfb.98.2024.01.17.07.13.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 07:13:06 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Subject: [PATCH 6/6] target/ppc: optimise ppcemb_tlb_t flushing
Date: Thu, 18 Jan 2024 01:12:38 +1000
Message-ID: <20240117151238.93323-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240117151238.93323-1-npiggin@gmail.com>
References: <20240117151238.93323-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Filter TLB flushing by PID and mmuidx.

Zoltan reports that, together with the previous TLB flush changes,
performance of a sam460ex machine running lame to convert a wav to mp3
is improved nearly 10%:

                  CPU time    TLB partial flushes  TLB elided flushes
Before            37s         508238               7680722
After             34s             73                  1143

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_helper.c | 43 +++++++++++++++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index ba965f1779..c071b4d5e2 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -751,11 +751,20 @@ target_ulong helper_4xx_tlbre_lo(CPUPPCState *env, target_ulong entry)
 
 static void ppcemb_tlb_flush(CPUState *cs, ppcemb_tlb_t *tlb)
 {
-    target_ulong ea;
+    unsigned mmu_idx = 0;
 
-    for (ea = tlb->EPN; ea < tlb->EPN + tlb->size; ea += TARGET_PAGE_SIZE) {
-        tlb_flush_page(cs, ea);
+    if (tlb->prot & 0xf) {
+        mmu_idx |= 0x1;
     }
+    if ((tlb->prot >> 4) & 0xf) {
+        mmu_idx |= 0x2;
+    }
+    if (tlb->attr & 1) {
+        mmu_idx <<= 2;
+    }
+
+    tlb_flush_range_by_mmuidx(cs, tlb->EPN, tlb->size, mmu_idx,
+                              TARGET_LONG_BITS);
 }
 
 void helper_4xx_tlbwe_hi(CPUPPCState *env, target_ulong entry,
@@ -770,7 +779,7 @@ void helper_4xx_tlbwe_hi(CPUPPCState *env, target_ulong entry,
     entry &= PPC4XX_TLB_ENTRY_MASK;
     tlb = &env->tlb.tlbe[entry];
     /* Invalidate previous TLB (if it's valid) */
-    if (tlb->prot & PAGE_VALID) {
+    if ((tlb->prot & PAGE_VALID) && tlb->PID == env->spr[SPR_40x_PID]) {
         qemu_log_mask(CPU_LOG_MMU, "%s: invalidate old TLB %d start "
                       TARGET_FMT_lx " end " TARGET_FMT_lx "\n", __func__,
                       (int)entry, tlb->EPN, tlb->EPN + tlb->size);
@@ -821,7 +830,7 @@ void helper_4xx_tlbwe_lo(CPUPPCState *env, target_ulong entry,
     entry &= PPC4XX_TLB_ENTRY_MASK;
     tlb = &env->tlb.tlbe[entry];
     /* Invalidate previous TLB (if it's valid) */
-    if (tlb->prot & PAGE_VALID) {
+    if ((tlb->prot & PAGE_VALID) && tlb->PID == env->spr[SPR_40x_PID]) {
         qemu_log_mask(CPU_LOG_MMU, "%s: invalidate old TLB %d start "
                       TARGET_FMT_lx " end " TARGET_FMT_lx "\n", __func__,
                       (int)entry, tlb->EPN, tlb->EPN + tlb->size);
@@ -851,6 +860,25 @@ target_ulong helper_4xx_tlbsx(CPUPPCState *env, target_ulong address)
     return ppcemb_tlb_search(env, address, env->spr[SPR_40x_PID]);
 }
 
+static bool mmubooke_pid_match(CPUPPCState *env, ppcemb_tlb_t *tlb)
+{
+    if (tlb->PID == env->spr[SPR_BOOKE_PID]) {
+        return true;
+    }
+    if (!env->nb_pids) {
+        return false;
+    }
+
+    if (env->spr[SPR_BOOKE_PID1] && tlb->PID == env->spr[SPR_BOOKE_PID1]) {
+        return true;
+    }
+    if (env->spr[SPR_BOOKE_PID2] && tlb->PID == env->spr[SPR_BOOKE_PID2]) {
+        return true;
+    }
+
+    return false;
+}
+
 /* PowerPC 440 TLB management */
 void helper_440_tlbwe(CPUPPCState *env, uint32_t word, target_ulong entry,
                       target_ulong value)
@@ -863,7 +891,10 @@ void helper_440_tlbwe(CPUPPCState *env, uint32_t word, target_ulong entry,
     tlb = &env->tlb.tlbe[entry];
 
     /* Invalidate previous TLB (if it's valid) */
-    if (tlb->prot & PAGE_VALID) {
+    if ((tlb->prot & PAGE_VALID) && mmubooke_pid_match(env, tlb)) {
+        qemu_log_mask(CPU_LOG_MMU, "%s: invalidate old TLB %d start "
+                      TARGET_FMT_lx " end " TARGET_FMT_lx "\n", __func__,
+                      (int)entry, tlb->EPN, tlb->EPN + tlb->size);
         ppcemb_tlb_flush(env_cpu(env), tlb);
     }
 
-- 
2.42.0


