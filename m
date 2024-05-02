Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 373E78B928D
	for <lists+qemu-devel@lfdr.de>; Thu,  2 May 2024 01:48:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Jbo-0002KC-HN; Wed, 01 May 2024 19:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s2Jbm-0002IJ-Fm; Wed, 01 May 2024 19:43:30 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s2Jbb-00050T-Kw; Wed, 01 May 2024 19:43:30 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2D6C14E602D;
 Thu, 02 May 2024 01:43:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id eYr6ChIWpkQ8; Thu,  2 May 2024 01:43:16 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 3EDC54E602F; Thu, 02 May 2024 01:43:16 +0200 (CEST)
Message-Id: <af31ebb6090c4875472b2e31a41569bf0e40ba37.1714606359.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1714606359.git.balaton@eik.bme.hu>
References: <cover.1714606359.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 10/28] target/ppc/mmu_common.c: Introduce
 mmu6xx_get_physical_address()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Thu, 02 May 2024 01:43:16 +0200 (CEST)
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Repurpose get_segment_6xx_tlb() to do the whole address translation
for POWERPC_MMU_SOFT_6xx MMU model by moving the BAT check there and
renaming it to match other similar functions. These are only called
once together so no need to keep these separate functions and
combining them simplifies the caller allowing further restructuring.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/mmu_common.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 98730035b1..ef1669b01d 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -359,19 +359,25 @@ static int get_bat_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
     return ret;
 }
 
-/* Perform segment based translation */
-static int get_segment_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
-                               target_ulong eaddr, MMUAccessType access_type,
-                               int type)
+static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
+                                       target_ulong eaddr,
+                                       MMUAccessType access_type, int type)
 {
     PowerPCCPU *cpu = env_archcpu(env);
     hwaddr hash;
-    target_ulong vsid;
-    int ds, target_page_bits;
+    target_ulong vsid, sr, pgidx;
     bool pr;
-    int ret;
-    target_ulong sr, pgidx;
+    int ds, target_page_bits, ret = -1;
 
+    /* First try to find a BAT entry if there are any */
+    if (env->nb_BATs != 0) {
+        ret = get_bat_6xx_tlb(env, ctx, eaddr, access_type);
+    }
+    if (ret >= 0) {
+        return ret;
+    }
+
+    /* Perform segment based translation when no BATs matched */
     pr = FIELD_EX64(env->msr, MSR, PR);
     ctx->eaddr = eaddr;
 
@@ -1193,14 +1199,8 @@ int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
         if (real_mode) {
             ret = check_physical(env, ctx, eaddr, access_type);
         } else {
-            /* Try to find a BAT */
-            if (env->nb_BATs != 0) {
-                ret = get_bat_6xx_tlb(env, ctx, eaddr, access_type);
-            }
-            if (ret < 0) {
-                /* We didn't match any BAT entry or don't have BATs */
-                ret = get_segment_6xx_tlb(env, ctx, eaddr, access_type, type);
-            }
+            ret = mmu6xx_get_physical_address(env, ctx, eaddr, access_type,
+                                              type);
         }
         break;
 
-- 
2.30.9


