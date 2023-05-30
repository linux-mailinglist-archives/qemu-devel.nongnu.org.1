Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B49647161EE
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:31:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zOz-0001vc-6A; Tue, 30 May 2023 09:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q3zOd-0001LA-OW; Tue, 30 May 2023 09:28:21 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q3zOa-0002Jy-9n; Tue, 30 May 2023 09:28:19 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id DB321748A68;
 Tue, 30 May 2023 15:28:13 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B823E748A65; Tue, 30 May 2023 15:28:13 +0200 (CEST)
Message-Id: <bd84d5f38af0ba2983ccd5c07635db49267c828f.1685448535.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1685448535.git.balaton@eik.bme.hu>
References: <cover.1685448535.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 7/7] target/ppc: Eliminate goto in mmubooke_check_tlb()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: clg@kaod.org, Greg Kurz <groug@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Tue, 30 May 2023 15:28:13 +0200 (CEST)
X-Spam-Probability: 8%
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Move out checking PID registers into a separate function which makes
mmubooke_check_tlb() simpler and avoids using goto.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
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
2.30.9


