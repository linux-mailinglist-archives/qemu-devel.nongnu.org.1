Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5065972ABCF
	for <lists+qemu-devel@lfdr.de>; Sat, 10 Jun 2023 15:40:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7yhZ-0004iD-W7; Sat, 10 Jun 2023 09:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7yhW-0004eW-O5; Sat, 10 Jun 2023 09:32:18 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7yhU-0007dQ-Uo; Sat, 10 Jun 2023 09:32:18 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-55af55a0fdaso1777442eaf.2; 
 Sat, 10 Jun 2023 06:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686403934; x=1688995934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ThMh6llT32g9rSMGS7qb8vHGAY5K0tlxJ7yUX4mE0qQ=;
 b=RSXCrko1xDhgfK9w7KqSadH/NLQcQt1yyrJ+O3aHvvu5Hs7y43ZdV/tGBaj59p7D2O
 ICWFhBKLP8EP0cekFMObrRvDxVj6GjDqpnAXr7JEpk2ICHNTvH1NzkEm85Oy0wnq7KX7
 tvXGWLr7KLCI19vP7ySZZLrOLDKvhs04t1yUHUH2hg6zisL5PpS0fvnhBqBk7jZ9aWiP
 HW0pEeAB2VVMw4VXB6fjv6vJNodXOta9oZcfsxim1Ydvy8LAjnVQV7ITLIPZ0uDwVIjz
 I371mc1F5LTT4A3rGNqZggZh8csh4C70bsch6NLG/R1mpxCOANSnUtrkodFtVNADZ2mP
 m3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686403934; x=1688995934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ThMh6llT32g9rSMGS7qb8vHGAY5K0tlxJ7yUX4mE0qQ=;
 b=fSmeTrsFWGDDbbdZSWO+g/M0bunWfTVDEjzCyPYCn12db61rtt+68PKgL8C/m2guJI
 euiMlWM08yeUU5rYLduoWoSuz+zQtJ9BDekxDQB3ZQa7PTPLgg5CVe0FkrlhFyHlF43L
 bs2PMGIew37b0ay9lpgbG/jqFpR/w37qcN96Mgo96CKC+kEWmMdzvXGrDN+w5v8UCdg2
 l7Iogif6C0AWosP8E5JDsThHuKNefV0NDDQrhClkfN+ueHW3CA+T/x/YFeostX1hLchL
 JimC3i2Pte3JQCODfCPCJ2EdpxbA46633V+dJWNq/lzLgaxcfQu0HWYzt/PNma3buJSZ
 FPEA==
X-Gm-Message-State: AC+VfDxNJpCMbQAwM61VCeHifOuRNwVOxA3LfL+z/17mS7jzoZTH5ktN
 M2seO73yKFFcEAsbG1nZ7hdLirZ/EOA=
X-Google-Smtp-Source: ACHHUZ53w7CJEndXazMxZ0zU+XmO2qMscoxrGZvq0Lf8tjDBpTJ6njUSiTTDjwAPXuOtbmgbCiqCgw==
X-Received: by 2002:a4a:b6c1:0:b0:558:b7e5:1dd0 with SMTP id
 w1-20020a4ab6c1000000b00558b7e51dd0mr2552224ooo.3.1686403934418; 
 Sat, 10 Jun 2023 06:32:14 -0700 (PDT)
Received: from grind.. ([177.170.117.52]) by smtp.gmail.com with ESMTPSA id
 y3-20020a544d83000000b00395f2c84b81sm2428420oix.54.2023.06.10.06.32.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Jun 2023 06:32:14 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 14/29] target/ppc: Remove "ext" parameter of ppcemb_tlb_check()
Date: Sat, 10 Jun 2023 10:31:17 -0300
Message-Id: <20230610133132.290703-15-danielhb413@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230610133132.290703-1-danielhb413@gmail.com>
References: <20230610133132.290703-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=danielhb413@gmail.com; helo=mail-oo1-xc32.google.com
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

This is only used by one caller so simplify function by removing this
parameter and move the operation to the single place where it's used.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Message-Id: <b21f11ae20e8a8c2e8b5d943f2bff12b5356005a.1685448535.git.balaton@eik.bme.hu>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 target/ppc/cpu.h        |  3 +--
 target/ppc/mmu_common.c | 21 +++++++++------------
 target/ppc/mmu_helper.c |  2 +-
 3 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 10c4ffa148..557e02e697 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1429,8 +1429,7 @@ int ppcmas_tlb_check(CPUPPCState *env, ppcmas_tlb_t *tlb,
                             uint32_t pid);
 int ppcemb_tlb_check(CPUPPCState *env, ppcemb_tlb_t *tlb,
                             hwaddr *raddrp,
-                            target_ulong address, uint32_t pid, int ext,
-                            int i);
+                            target_ulong address, uint32_t pid, int i);
 hwaddr booke206_tlb_to_page_size(CPUPPCState *env,
                                         ppcmas_tlb_t *tlb);
 #endif
diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 7235a4befe..21a353c51a 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -491,8 +491,7 @@ static int get_segment_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
 /* Generic TLB check function for embedded PowerPC implementations */
 int ppcemb_tlb_check(CPUPPCState *env, ppcemb_tlb_t *tlb,
                             hwaddr *raddrp,
-                            target_ulong address, uint32_t pid, int ext,
-                            int i)
+                            target_ulong address, uint32_t pid, int i)
 {
     target_ulong mask;
 
@@ -514,11 +513,6 @@ int ppcemb_tlb_check(CPUPPCState *env, ppcemb_tlb_t *tlb,
         return -1;
     }
     *raddrp = (tlb->RPN & mask) | (address & ~mask);
-    if (ext) {
-        /* Extend the physical address to 36 bits */
-        *raddrp |= (uint64_t)(tlb->RPN & 0xF) << 32;
-    }
-
     return 0;
 }
 
@@ -536,7 +530,7 @@ static int mmu40x_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
     for (i = 0; i < env->nb_tlb; i++) {
         tlb = &env->tlb.tlbe[i];
         if (ppcemb_tlb_check(env, tlb, &raddr, address,
-                             env->spr[SPR_40x_PID], 0, i) < 0) {
+                             env->spr[SPR_40x_PID], i) < 0) {
             continue;
         }
         zsel = (tlb->attr >> 4) & 0xF;
@@ -598,20 +592,23 @@ static int mmubooke_check_tlb(CPUPPCState *env, ppcemb_tlb_t *tlb,
     int prot2;
 
     if (ppcemb_tlb_check(env, tlb, raddr, address,
-                         env->spr[SPR_BOOKE_PID],
-                         !env->nb_pids, i) >= 0) {
+                         env->spr[SPR_BOOKE_PID], i) >= 0) {
+        if (!env->nb_pids) {
+            /* Extend the physical address to 36 bits */
+            *raddr |= (uint64_t)(tlb->RPN & 0xF) << 32;
+        }
         goto found_tlb;
     }
 
     if (env->spr[SPR_BOOKE_PID1] &&
         ppcemb_tlb_check(env, tlb, raddr, address,
-                         env->spr[SPR_BOOKE_PID1], 0, i) >= 0) {
+                         env->spr[SPR_BOOKE_PID1], i) >= 0) {
         goto found_tlb;
     }
 
     if (env->spr[SPR_BOOKE_PID2] &&
         ppcemb_tlb_check(env, tlb, raddr, address,
-                         env->spr[SPR_BOOKE_PID2], 0, i) >= 0) {
+                         env->spr[SPR_BOOKE_PID2], i) >= 0) {
         goto found_tlb;
     }
 
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index c0c71a68ff..e7275eaec1 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -124,7 +124,7 @@ static int ppcemb_tlb_search(CPUPPCState *env, target_ulong address,
     ret = -1;
     for (i = 0; i < env->nb_tlb; i++) {
         tlb = &env->tlb.tlbe[i];
-        if (ppcemb_tlb_check(env, tlb, &raddr, address, pid, 0, i) == 0) {
+        if (ppcemb_tlb_check(env, tlb, &raddr, address, pid, i) == 0) {
             ret = i;
             break;
         }
-- 
2.40.1


