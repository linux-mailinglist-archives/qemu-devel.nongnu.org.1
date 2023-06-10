Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4996672ABC5
	for <lists+qemu-devel@lfdr.de>; Sat, 10 Jun 2023 15:36:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7yha-0004ij-Pz; Sat, 10 Jun 2023 09:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7yhX-0004g9-UO; Sat, 10 Jun 2023 09:32:20 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7yhW-0007dh-64; Sat, 10 Jun 2023 09:32:19 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-39c7f5706f0so1293921b6e.3; 
 Sat, 10 Jun 2023 06:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686403936; x=1688995936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ivav2ycIvnakR2ciKDG+0QBgSTpSm1FFjGE6ZxOkydU=;
 b=HWIha1pMgg3qaDIkX9W5bH3J4Ejn+4ele3/4XNHGGRRalurKRLyJTda+Gz51CSobCa
 iIHsXGUs+i6WhzRYUCplxa/uvt4vttz4778dHo6NbfrYpnOo1Dxb/YfmTY9vzkd9YbQX
 hoZcLN43hDSu40kta/Ni6m/KGF7V6e9c2rT2/US0lqoWbSZcH8L+g4oO8PDrU15+8Efz
 TB92zuUPg9j3LOJzT8Umu270UjDEBskH2DQpSNLwQRlo4M54s4SP/lSad/C0dVvsmbBb
 K2cqGseK5pzZcVt7ka/7NdKD3MReUz6N92IJYqDsILXlABFoDfGoLwqY80d4i+V5k4qW
 TTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686403936; x=1688995936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ivav2ycIvnakR2ciKDG+0QBgSTpSm1FFjGE6ZxOkydU=;
 b=gaqNijClTDScHzgvb3MwhnJEnzCMH0x++2CBA2nden8eRIvcxBcpN/rLRrtWINjAty
 15fwVX2WJrXxKGb0ZsrqIB0QHM4x5MozET/0CoZ4MTj3pn4nxo22xhePXOkLcxMzZaKz
 4sPOVJUrL7EaS8946DCLu8XaQ/uzwo4d6fMWlqsh+k5YO9MX7c3GQAa/xpN0t+/0C3mO
 vdHqAVoyY9qH5JhfKv3dWzJUGNKerIAoah4ZyfckSMEx0i+Lf0dN+sM4iLY/E4crpmXx
 eDLt3yNeJywIioKzuH6TrcyoLDPgZlf8kScs77ZT506wDyU9MpBPJJGsiIQXIT/+hpdx
 X3Lg==
X-Gm-Message-State: AC+VfDx87CNGCQzNUC78Bmgnub65ngIB/dgLXs251SSmd91nNdRKdIdM
 GLrAksDv9g5Hw94e540h0fc7EAg5mc8=
X-Google-Smtp-Source: ACHHUZ42kLmON6mz3KvuqWD4GtxsK3us+Zra2I24EaEgltAIYBpT0FLKfeBSESU0q3pERzpvjRtBzQ==
X-Received: by 2002:a05:6808:150d:b0:398:57fe:5fa with SMTP id
 u13-20020a056808150d00b0039857fe05famr1184716oiw.29.1686403936700; 
 Sat, 10 Jun 2023 06:32:16 -0700 (PDT)
Received: from grind.. ([177.170.117.52]) by smtp.gmail.com with ESMTPSA id
 y3-20020a544d83000000b00395f2c84b81sm2428420oix.54.2023.06.10.06.32.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Jun 2023 06:32:16 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 15/29] target/ppc: Move ppcemb_tlb_search() to mmu_common.c
Date: Sat, 10 Jun 2023 10:31:18 -0300
Message-Id: <20230610133132.290703-16-danielhb413@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230610133132.290703-1-danielhb413@gmail.com>
References: <20230610133132.290703-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=danielhb413@gmail.com; helo=mail-oi1-x235.google.com
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

This function is the only reason why ppcemb_tlb_check() is not static
to mmu_common.c but it also better fits in mmu_common.c so move it
there.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Message-Id: <b64fd712a773558dea9b84945c57785546c0ae2e.1685448535.git.balaton@eik.bme.hu>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 target/ppc/cpu.h        |  4 +---
 target/ppc/mmu_common.c | 22 +++++++++++++++++++++-
 target/ppc/mmu_helper.c | 21 ---------------------
 3 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 557e02e697..8001582d52 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1427,9 +1427,7 @@ void cpu_ppc_set_vhyp(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp);
 int ppcmas_tlb_check(CPUPPCState *env, ppcmas_tlb_t *tlb,
                             hwaddr *raddrp, target_ulong address,
                             uint32_t pid);
-int ppcemb_tlb_check(CPUPPCState *env, ppcemb_tlb_t *tlb,
-                            hwaddr *raddrp,
-                            target_ulong address, uint32_t pid, int i);
+int ppcemb_tlb_search(CPUPPCState *env, target_ulong address, uint32_t pid);
 hwaddr booke206_tlb_to_page_size(CPUPPCState *env,
                                         ppcmas_tlb_t *tlb);
 #endif
diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 21a353c51a..845eee4c6f 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -489,7 +489,7 @@ static int get_segment_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
 }
 
 /* Generic TLB check function for embedded PowerPC implementations */
-int ppcemb_tlb_check(CPUPPCState *env, ppcemb_tlb_t *tlb,
+static int ppcemb_tlb_check(CPUPPCState *env, ppcemb_tlb_t *tlb,
                             hwaddr *raddrp,
                             target_ulong address, uint32_t pid, int i)
 {
@@ -516,6 +516,26 @@ int ppcemb_tlb_check(CPUPPCState *env, ppcemb_tlb_t *tlb,
     return 0;
 }
 
+/* Generic TLB search function for PowerPC embedded implementations */
+int ppcemb_tlb_search(CPUPPCState *env, target_ulong address, uint32_t pid)
+{
+    ppcemb_tlb_t *tlb;
+    hwaddr raddr;
+    int i, ret;
+
+    /* Default return value is no match */
+    ret = -1;
+    for (i = 0; i < env->nb_tlb; i++) {
+        tlb = &env->tlb.tlbe[i];
+        if (ppcemb_tlb_check(env, tlb, &raddr, address, pid, i) == 0) {
+            ret = i;
+            break;
+        }
+    }
+
+    return ret;
+}
+
 static int mmu40x_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
                                        target_ulong address,
                                        MMUAccessType access_type)
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index e7275eaec1..d3ea7588f9 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -112,27 +112,6 @@ static void ppc6xx_tlb_store(CPUPPCState *env, target_ulong EPN, int way,
     env->last_way = way;
 }
 
-/* Generic TLB search function for PowerPC embedded implementations */
-static int ppcemb_tlb_search(CPUPPCState *env, target_ulong address,
-                             uint32_t pid)
-{
-    ppcemb_tlb_t *tlb;
-    hwaddr raddr;
-    int i, ret;
-
-    /* Default return value is no match */
-    ret = -1;
-    for (i = 0; i < env->nb_tlb; i++) {
-        tlb = &env->tlb.tlbe[i];
-        if (ppcemb_tlb_check(env, tlb, &raddr, address, pid, i) == 0) {
-            ret = i;
-            break;
-        }
-    }
-
-    return ret;
-}
-
 /* Helpers specific to PowerPC 40x implementations */
 static inline void ppc4xx_tlb_invalidate_all(CPUPPCState *env)
 {
-- 
2.40.1


