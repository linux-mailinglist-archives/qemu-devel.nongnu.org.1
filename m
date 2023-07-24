Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 905E175EE64
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 10:54:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNrK4-00028N-A6; Mon, 24 Jul 2023 04:53:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNrK1-00027C-H0
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 04:53:41 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNrJw-0000f7-0T
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 04:53:41 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fbc244d307so38915625e9.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 01:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690188814; x=1690793614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MwLIjhqnbiVZ/y9qr7U0+BJ2Kjk5/r2inTh7YJ6LvNY=;
 b=M3GpOBBs+/ZuFc8vFlyz30at+l1qOFV/I8aDEgi9jyJM7T7XGyMAWfLJ2TF+EAvqql
 aOPlGE9twb+SwYO3q2Ev+bCzj/LdtOcfdJMpEiQPwbGdAi7ornpgyHGAx7mE9qz8T6zb
 dAHfz5D6QuIegRovguNtz8v6RgDlIkC5nt8Ktkqt6OkYYCFXxy29lOMsbh0980s/kvWG
 5dkZQYQwPQD1uwqRKUtegrw8a5Ym1tOgy8T7a3Nbm8ykiB+Q4FQxXpAqb4nUCKy34HRA
 Ti9SXs/lvkPrAqGWqCs0AOS1pfPPKMQuvz4j7JFzyaXiAH8g4uUIJFZFrHMgKYkjwJy6
 umhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690188814; x=1690793614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MwLIjhqnbiVZ/y9qr7U0+BJ2Kjk5/r2inTh7YJ6LvNY=;
 b=jcYGrgrA0PXluNNiaKmpjNSTp4V3xwS7HzLQ8GT1ewlO4BahTvj3PJ8Rzxr6QImWOL
 mgD4zmlkmWJlbYArpSRKjyxjgOf9V+J5jUDRPlw8HfZNBNUF+S9BgEZOajdOOoZxL5W0
 YrSEDucXvTnt5re2bhSBY2sHPbD10kcMC2wakHsjK39m50hBPHACH+rNsXw7Qnmw4Zq4
 NLHzCTych5/J7Gad/byEOgP01K2FnhfJaWG73dxD36qS3ufaMkHmD5N1tlWu851qSV0J
 chhdhmNdarcUoSZlGDpzLbNXSqW1L1yD2kh27AwEj/jhkLK3wv1toM/sy48TzLNfeD8d
 7iTw==
X-Gm-Message-State: ABy/qLbefCvLZOpKNnhAXpUqIVEnDUVocNMvbkJ++EZ9ibaPVqKm/Syj
 dOFMC65xB5m2ImVr+LhrzHTsU22gLvA9noPfkmygew==
X-Google-Smtp-Source: APBJJlFbSzyI/K4AVQb1ODAZXOvY+NuGWDpAmUVwmwfGy0eS12K6xvlsLueevYT9YakKgWosL57LCQ==
X-Received: by 2002:a05:600c:259:b0:3fd:30f7:2be1 with SMTP id
 25-20020a05600c025900b003fd30f72be1mr3774360wmj.39.1690188814654; 
 Mon, 24 Jul 2023 01:53:34 -0700 (PDT)
Received: from stoup.. ([62.252.144.58]) by smtp.gmail.com with ESMTPSA id
 t8-20020a1c7708000000b003fa74bff02asm9570994wmi.26.2023.07.24.01.53.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jul 2023 01:53:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	Anton Johansson <anjo@rev.ng>
Subject: [PULL 6/7] accel/tcg: Zero-pad vaddr in tlb_debug output
Date: Mon, 24 Jul 2023 09:53:27 +0100
Message-Id: <20230724085328.4936-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724085328.4936-1-richard.henderson@linaro.org>
References: <20230724085328.4936-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

In replacing target_ulong with vaddr and TARGET_FMT_lx with VADDR_PRIx,
the zero-padding of TARGET_FMT_lx got lost.  Readd 16-wide zero-padding
for logging consistency.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20230713120746.26897-1-anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index e0079c9a9d..ba44501a7c 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -497,8 +497,8 @@ static void tlb_flush_page_locked(CPUArchState *env, int midx, vaddr page)
 
     /* Check if we need to flush due to large pages.  */
     if ((page & lp_mask) == lp_addr) {
-        tlb_debug("forcing full flush midx %d (%"
-                  VADDR_PRIx "/%" VADDR_PRIx ")\n",
+        tlb_debug("forcing full flush midx %d (%016"
+                  VADDR_PRIx "/%016" VADDR_PRIx ")\n",
                   midx, lp_addr, lp_mask);
         tlb_flush_one_mmuidx_locked(env, midx, get_clock_realtime());
     } else {
@@ -527,7 +527,7 @@ static void tlb_flush_page_by_mmuidx_async_0(CPUState *cpu,
 
     assert_cpu_is_self(cpu);
 
-    tlb_debug("page addr: %" VADDR_PRIx " mmu_map:0x%x\n", addr, idxmap);
+    tlb_debug("page addr: %016" VADDR_PRIx " mmu_map:0x%x\n", addr, idxmap);
 
     qemu_spin_lock(&env_tlb(env)->c.lock);
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
@@ -591,7 +591,7 @@ static void tlb_flush_page_by_mmuidx_async_2(CPUState *cpu,
 
 void tlb_flush_page_by_mmuidx(CPUState *cpu, vaddr addr, uint16_t idxmap)
 {
-    tlb_debug("addr: %" VADDR_PRIx " mmu_idx:%" PRIx16 "\n", addr, idxmap);
+    tlb_debug("addr: %016" VADDR_PRIx " mmu_idx:%" PRIx16 "\n", addr, idxmap);
 
     /* This should already be page aligned */
     addr &= TARGET_PAGE_MASK;
@@ -625,7 +625,7 @@ void tlb_flush_page(CPUState *cpu, vaddr addr)
 void tlb_flush_page_by_mmuidx_all_cpus(CPUState *src_cpu, vaddr addr,
                                        uint16_t idxmap)
 {
-    tlb_debug("addr: %" VADDR_PRIx " mmu_idx:%"PRIx16"\n", addr, idxmap);
+    tlb_debug("addr: %016" VADDR_PRIx " mmu_idx:%"PRIx16"\n", addr, idxmap);
 
     /* This should already be page aligned */
     addr &= TARGET_PAGE_MASK;
@@ -666,7 +666,7 @@ void tlb_flush_page_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
                                               vaddr addr,
                                               uint16_t idxmap)
 {
-    tlb_debug("addr: %" VADDR_PRIx " mmu_idx:%"PRIx16"\n", addr, idxmap);
+    tlb_debug("addr: %016" VADDR_PRIx " mmu_idx:%"PRIx16"\n", addr, idxmap);
 
     /* This should already be page aligned */
     addr &= TARGET_PAGE_MASK;
@@ -728,7 +728,7 @@ static void tlb_flush_range_locked(CPUArchState *env, int midx,
      */
     if (mask < f->mask || len > f->mask) {
         tlb_debug("forcing full flush midx %d ("
-                  "%" VADDR_PRIx "/%" VADDR_PRIx "+%" VADDR_PRIx ")\n",
+                  "%016" VADDR_PRIx "/%016" VADDR_PRIx "+%016" VADDR_PRIx ")\n",
                   midx, addr, mask, len);
         tlb_flush_one_mmuidx_locked(env, midx, get_clock_realtime());
         return;
@@ -741,7 +741,7 @@ static void tlb_flush_range_locked(CPUArchState *env, int midx,
      */
     if (((addr + len - 1) & d->large_page_mask) == d->large_page_addr) {
         tlb_debug("forcing full flush midx %d ("
-                  "%" VADDR_PRIx "/%" VADDR_PRIx ")\n",
+                  "%016" VADDR_PRIx "/%016" VADDR_PRIx ")\n",
                   midx, d->large_page_addr, d->large_page_mask);
         tlb_flush_one_mmuidx_locked(env, midx, get_clock_realtime());
         return;
@@ -773,7 +773,7 @@ static void tlb_flush_range_by_mmuidx_async_0(CPUState *cpu,
 
     assert_cpu_is_self(cpu);
 
-    tlb_debug("range: %" VADDR_PRIx "/%u+%" VADDR_PRIx " mmu_map:0x%x\n",
+    tlb_debug("range: %016" VADDR_PRIx "/%u+%016" VADDR_PRIx " mmu_map:0x%x\n",
               d.addr, d.bits, d.len, d.idxmap);
 
     qemu_spin_lock(&env_tlb(env)->c.lock);
@@ -1165,7 +1165,7 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
                                                 &xlat, &sz, full->attrs, &prot);
     assert(sz >= TARGET_PAGE_SIZE);
 
-    tlb_debug("vaddr=%" VADDR_PRIx " paddr=0x" HWADDR_FMT_plx
+    tlb_debug("vaddr=%016" VADDR_PRIx " paddr=0x" HWADDR_FMT_plx
               " prot=%x idx=%d\n",
               addr, full->phys_addr, prot, mmu_idx);
 
-- 
2.34.1


