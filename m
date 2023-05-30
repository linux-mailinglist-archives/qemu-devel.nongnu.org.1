Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D957161FC
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:32:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zOu-0001er-WF; Tue, 30 May 2023 09:28:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q3zOY-00015G-VA; Tue, 30 May 2023 09:28:16 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q3zOV-0002Da-6n; Tue, 30 May 2023 09:28:14 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 9FC3A748A56;
 Tue, 30 May 2023 15:28:09 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 77FFA748A4D; Tue, 30 May 2023 15:28:09 +0200 (CEST)
Message-Id: <b64fd712a773558dea9b84945c57785546c0ae2e.1685448535.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1685448535.git.balaton@eik.bme.hu>
References: <cover.1685448535.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 3/7] target/ppc: Move ppcemb_tlb_search() to mmu_common.c
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: clg@kaod.org, Greg Kurz <groug@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Tue, 30 May 2023 15:28:09 +0200 (CEST)
X-Spam-Probability: 8%
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
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

This function is the only reason why ppcemb_tlb_check() is not static
to mmu_common.c but it also better fits in mmu_common.c so move it
there.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/cpu.h        |  4 +---
 target/ppc/mmu_common.c | 22 +++++++++++++++++++++-
 target/ppc/mmu_helper.c | 21 ---------------------
 3 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 5cd1b442b4..77eb5edea2 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1428,9 +1428,7 @@ void cpu_ppc_set_vhyp(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp);
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
2.30.9


