Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B92B72ABBF
	for <lists+qemu-devel@lfdr.de>; Sat, 10 Jun 2023 15:34:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7yhn-0004t3-3m; Sat, 10 Jun 2023 09:32:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7yhf-0004mc-1k; Sat, 10 Jun 2023 09:32:27 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7yhd-0007et-9C; Sat, 10 Jun 2023 09:32:26 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6b2d356530eso626170a34.0; 
 Sat, 10 Jun 2023 06:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686403943; x=1688995943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S3DY05uzPRXUwH2framOi4921lYLe/N/xjiE9DXGWT8=;
 b=rVKhF/Qpvpo4YiRTz2f0pWtCMagbiw4j30iwkHWUY9a56ir92MKYm2kN/Io2kmIjYn
 ytPbvkE1frnFnqgk92ysDmoYSiG9Uj90jMZPF9UhShA/owSegxCnAYVpmhW2mQWOJPDm
 uFG4iQ1QdGG3AH8adSfO8vpl09q4CCvIYvokZDNTDeCrs1HWs85SUN9ZzdZc02ssRfjr
 aykFtlTxrWfgHYFq+FlMZ98oA0MobI1lW95nkXS+iumTnmhHOWpuojDdaiMsv7BdAikj
 zoBz13l8h1RmtWfnkLPY8ahsQR42C/rvZJVmeQmkzSFa7WG1wh0sIeGNckQ9uvI25j+N
 H6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686403943; x=1688995943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S3DY05uzPRXUwH2framOi4921lYLe/N/xjiE9DXGWT8=;
 b=AffsNQCudEXsUwlnJpbTxkCoz4Gcw5g+XhhV6PNfoVd7SCSYrbcY2BqG4hdNXFPV8d
 lUKBYd6JcVkz3FLjuHo82npyyVxd50Kr2W1LJJOPNKLqn6OFeWM0n8uWzlpT1VDrkXdC
 zQBy07YnIilhCGYEHL/yl+8lQn5pNeYapJ+5XmD28+Kbd8LjRShQLO5iQ3wXpMtyP/JE
 50uXHs1WOFHFTT9/y+yg9k62m/fTWda5XGkBFk30kp8UIToP27rJ8+tiMGmDHPYyY61Y
 m6sE2ndApksu1ZmYgUv+PgjbkNbmbo4DtraazoTf/pJbpkbcrfLcqN0u1Q5ACVyEQZS8
 BCaw==
X-Gm-Message-State: AC+VfDwD8VY2ij0azkAINQWyvYEjkxib7vFLa0Qk/fEWX6/Q5naOyPeo
 s3Luuo394hh+Po+O3T4qrZgZ+qP5yEI=
X-Google-Smtp-Source: ACHHUZ7sWfFkoZ7u7ou9upWytqhSH6XmqbP0D7Lo5Y1twYCtJ6UK+mEfgpCAvP0X2x6YZ0z/01aMnw==
X-Received: by 2002:a05:6870:e144:b0:1a3:100f:bf41 with SMTP id
 z4-20020a056870e14400b001a3100fbf41mr2489160oaa.23.1686403943593; 
 Sat, 10 Jun 2023 06:32:23 -0700 (PDT)
Received: from grind.. ([177.170.117.52]) by smtp.gmail.com with ESMTPSA id
 y3-20020a544d83000000b00395f2c84b81sm2428420oix.54.2023.06.10.06.32.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Jun 2023 06:32:23 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 18/29] target/ppc: Change ppcemb_tlb_check() to return bool
Date: Sat, 10 Jun 2023 10:31:21 -0300
Message-Id: <20230610133132.290703-19-danielhb413@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230610133132.290703-1-danielhb413@gmail.com>
References: <20230610133132.290703-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x336.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Message-Id: <bacd1bcbe99c07930c29a9815915da9ac75f6920.1685448535.git.balaton@eik.bme.hu>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 target/ppc/mmu_common.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index ff7f987546..bd7d7d5257 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -489,15 +489,15 @@ static int get_segment_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
 }
 
 /* Generic TLB check function for embedded PowerPC implementations */
-static int ppcemb_tlb_check(CPUPPCState *env, ppcemb_tlb_t *tlb,
-                            hwaddr *raddrp,
-                            target_ulong address, uint32_t pid, int i)
+static bool ppcemb_tlb_check(CPUPPCState *env, ppcemb_tlb_t *tlb,
+                             hwaddr *raddrp,
+                             target_ulong address, uint32_t pid, int i)
 {
     target_ulong mask;
 
     /* Check valid flag */
     if (!(tlb->prot & PAGE_VALID)) {
-        return -1;
+        return false;
     }
     mask = ~(tlb->size - 1);
     qemu_log_mask(CPU_LOG_MMU, "%s: TLB %d address " TARGET_FMT_lx
@@ -506,14 +506,14 @@ static int ppcemb_tlb_check(CPUPPCState *env, ppcemb_tlb_t *tlb,
                   mask, (uint32_t)tlb->PID, tlb->prot);
     /* Check PID */
     if (tlb->PID != 0 && tlb->PID != pid) {
-        return -1;
+        return false;
     }
     /* Check effective address */
     if ((address & mask) != tlb->EPN) {
-        return -1;
+        return false;
     }
     *raddrp = (tlb->RPN & mask) | (address & ~mask);
-    return 0;
+    return true;
 }
 
 /* Generic TLB search function for PowerPC embedded implementations */
@@ -525,7 +525,7 @@ int ppcemb_tlb_search(CPUPPCState *env, target_ulong address, uint32_t pid)
 
     for (i = 0; i < env->nb_tlb; i++) {
         tlb = &env->tlb.tlbe[i];
-        if (ppcemb_tlb_check(env, tlb, &raddr, address, pid, i) == 0) {
+        if (ppcemb_tlb_check(env, tlb, &raddr, address, pid, i)) {
             return i;
         }
     }
@@ -545,8 +545,8 @@ static int mmu40x_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
     pr = FIELD_EX64(env->msr, MSR, PR);
     for (i = 0; i < env->nb_tlb; i++) {
         tlb = &env->tlb.tlbe[i];
-        if (ppcemb_tlb_check(env, tlb, &raddr, address,
-                             env->spr[SPR_40x_PID], i) < 0) {
+        if (!ppcemb_tlb_check(env, tlb, &raddr, address,
+                              env->spr[SPR_40x_PID], i)) {
             continue;
         }
         zsel = (tlb->attr >> 4) & 0xF;
@@ -608,7 +608,7 @@ static int mmubooke_check_tlb(CPUPPCState *env, ppcemb_tlb_t *tlb,
     int prot2;
 
     if (ppcemb_tlb_check(env, tlb, raddr, address,
-                         env->spr[SPR_BOOKE_PID], i) >= 0) {
+                         env->spr[SPR_BOOKE_PID], i)) {
         if (!env->nb_pids) {
             /* Extend the physical address to 36 bits */
             *raddr |= (uint64_t)(tlb->RPN & 0xF) << 32;
@@ -618,13 +618,13 @@ static int mmubooke_check_tlb(CPUPPCState *env, ppcemb_tlb_t *tlb,
 
     if (env->spr[SPR_BOOKE_PID1] &&
         ppcemb_tlb_check(env, tlb, raddr, address,
-                         env->spr[SPR_BOOKE_PID1], i) >= 0) {
+                         env->spr[SPR_BOOKE_PID1], i)) {
         goto found_tlb;
     }
 
     if (env->spr[SPR_BOOKE_PID2] &&
         ppcemb_tlb_check(env, tlb, raddr, address,
-                         env->spr[SPR_BOOKE_PID2], i) >= 0) {
+                         env->spr[SPR_BOOKE_PID2], i)) {
         goto found_tlb;
     }
 
-- 
2.40.1


