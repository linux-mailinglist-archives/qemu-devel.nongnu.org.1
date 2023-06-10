Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5D472ABC9
	for <lists+qemu-devel@lfdr.de>; Sat, 10 Jun 2023 15:37:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7yhr-0004xL-P7; Sat, 10 Jun 2023 09:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7yhh-0004ry-EC; Sat, 10 Jun 2023 09:32:29 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7yhf-0007fK-Oq; Sat, 10 Jun 2023 09:32:29 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-39a95068c9cso1241739b6e.1; 
 Sat, 10 Jun 2023 06:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686403946; x=1688995946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SwwgSwbrhJWbyc3oxpVYxYIp5H503PfpamAq2kJFFZY=;
 b=a2ODRoFQ9CuvNDkSmubyCZIn/vERJtJF7WfeBAU4ro5FJzZkygj0+IsLqVq0WLt8Nc
 LflGQRCA7lQRa0eGeuFDHw6Mp+nd+LlMWvWekcRo+6gVisoP1qtc43NdQYSrOVyKnlnU
 tBBBDD8CtepyQF9/4Y3KVEMGJ4BHyeXprbRAGVDj14PExrfQeRJOq/5OUPeqPjA5NvPT
 +vgNY72cUPCyLaezcuxgdRlqAfy/q9CoIGjpS79a7ZxN8lt6aSUuiY1GSXBb3OB3Parb
 y1ZAfnhbYSaQjNdJ6XCAZe+u8fXCs0kkaKEsUv9m8hhBSFinfOtqxTWaX5QK50TYUfmd
 3MCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686403946; x=1688995946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SwwgSwbrhJWbyc3oxpVYxYIp5H503PfpamAq2kJFFZY=;
 b=ix4CIv3kuagbGJD93eoRb2aL6PcN8Y1j23flD9y1/R06mq+F/GKWvUBFAhYrq0fnVI
 LN1in3PhO8NemHhDlwcdR1jvouCdsnfqkFCfB5fXuUY8VklZYIwzV4ObsjeMhokROwdm
 lrVB3/Hmlbyat1Dn21WGftJMYuH9HVHGcJ2ne1V8UnpxpxltiijgKXW0RgkSrVrlPzuG
 WjJAewymB0+vIgPAtHxoo0PfE/yGRh5zItR+MJWhleAGaqWX/6gBRt5ExgEQMpWlQepQ
 p4q9w2NiEr+9u2VGtvZa4abGs0OC0+poxx/JEBoXgtQ/M+ccWkuZ2qO5Pft1eBw7wzVi
 W2PA==
X-Gm-Message-State: AC+VfDyt0J59gfkctkSuz+cKbTLJc57o0H4V9i9PrhNn1WbHCHCSn6Rt
 az8cc1owJ65ZmzyaUOn8HnUis9ky+Co=
X-Google-Smtp-Source: ACHHUZ6eGKt7PeTlSl6YrQIZxk3p+xpGxsfKg7iab/bfRr0qeZM9WkLsMpiKNTX13namF1KzgYEc1Q==
X-Received: by 2002:a05:6808:1790:b0:398:6495:5a9b with SMTP id
 bg16-20020a056808179000b0039864955a9bmr1244306oib.5.1686403946004; 
 Sat, 10 Jun 2023 06:32:26 -0700 (PDT)
Received: from grind.. ([177.170.117.52]) by smtp.gmail.com with ESMTPSA id
 y3-20020a544d83000000b00395f2c84b81sm2428420oix.54.2023.06.10.06.32.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Jun 2023 06:32:25 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 19/29] target/ppc: Eliminate goto in mmubooke_check_tlb()
Date: Sat, 10 Jun 2023 10:31:22 -0300
Message-Id: <20230610133132.290703-20-danielhb413@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230610133132.290703-1-danielhb413@gmail.com>
References: <20230610133132.290703-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=danielhb413@gmail.com; helo=mail-oi1-x22e.google.com
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

Move out checking PID registers into a separate function which makes
mmubooke_check_tlb() simpler and avoids using goto.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-Id: <bd84d5f38af0ba2983ccd5c07635db49267c828f.1685448535.git.balaton@eik.bme.hu>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 target/ppc/mmu_common.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index bd7d7d5257..ae1db6e348 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -601,37 +601,39 @@ static int mmu40x_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
     return ret;
 }
 
-static int mmubooke_check_tlb(CPUPPCState *env, ppcemb_tlb_t *tlb,
-                              hwaddr *raddr, int *prot, target_ulong address,
-                              MMUAccessType access_type, int i)
+static bool mmubooke_check_pid(CPUPPCState *env, ppcemb_tlb_t *tlb,
+                               hwaddr *raddr, target_ulong addr, int i)
 {
-    int prot2;
-
-    if (ppcemb_tlb_check(env, tlb, raddr, address,
-                         env->spr[SPR_BOOKE_PID], i)) {
+    if (ppcemb_tlb_check(env, tlb, raddr, addr, env->spr[SPR_BOOKE_PID], i)) {
         if (!env->nb_pids) {
             /* Extend the physical address to 36 bits */
             *raddr |= (uint64_t)(tlb->RPN & 0xF) << 32;
         }
-        goto found_tlb;
+        return true;
+    } else if (!env->nb_pids) {
+        return false;
     }
-
     if (env->spr[SPR_BOOKE_PID1] &&
-        ppcemb_tlb_check(env, tlb, raddr, address,
-                         env->spr[SPR_BOOKE_PID1], i)) {
-        goto found_tlb;
+        ppcemb_tlb_check(env, tlb, raddr, addr, env->spr[SPR_BOOKE_PID1], i)) {
+        return true;
     }
-
     if (env->spr[SPR_BOOKE_PID2] &&
-        ppcemb_tlb_check(env, tlb, raddr, address,
-                         env->spr[SPR_BOOKE_PID2], i)) {
-        goto found_tlb;
+        ppcemb_tlb_check(env, tlb, raddr, addr, env->spr[SPR_BOOKE_PID2], i)) {
+        return true;
     }
+    return false;
+}
 
-     qemu_log_mask(CPU_LOG_MMU, "%s: TLB entry not found\n", __func__);
-    return -1;
+static int mmubooke_check_tlb(CPUPPCState *env, ppcemb_tlb_t *tlb,
+                              hwaddr *raddr, int *prot, target_ulong address,
+                              MMUAccessType access_type, int i)
+{
+    int prot2;
 
-found_tlb:
+    if (!mmubooke_check_pid(env, tlb, raddr, address, i)) {
+        qemu_log_mask(CPU_LOG_MMU, "%s: TLB entry not found\n", __func__);
+        return -1;
+    }
 
     if (FIELD_EX64(env->msr, MSR, PR)) {
         prot2 = tlb->prot & 0xF;
-- 
2.40.1


