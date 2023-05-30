Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 302307161D9
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:29:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zOw-0001m1-7u; Tue, 30 May 2023 09:28:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q3zOa-00015t-4i; Tue, 30 May 2023 09:28:16 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q3zOW-0002Ev-Ad; Tue, 30 May 2023 09:28:15 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id AF2EA748A5B;
 Tue, 30 May 2023 15:28:10 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 90021748A4D; Tue, 30 May 2023 15:28:10 +0200 (CEST)
Message-Id: <70952ba2d82141db1cf5cfcf4b227402be575874.1685448535.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1685448535.git.balaton@eik.bme.hu>
References: <cover.1685448535.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 4/7] target/ppc: Remove some unneded line breaks
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: clg@kaod.org, Greg Kurz <groug@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Tue, 30 May 2023 15:28:10 +0200 (CEST)
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

Make lines shorter and fix indentation in some functions prototypes.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/cpu.h        | 8 +++-----
 target/ppc/mmu_common.c | 8 +++-----
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 77eb5edea2..4545f74fdd 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1425,12 +1425,10 @@ void store_booke_tsr(CPUPPCState *env, target_ulong val);
 void ppc_tlb_invalidate_all(CPUPPCState *env);
 void ppc_tlb_invalidate_one(CPUPPCState *env, target_ulong addr);
 void cpu_ppc_set_vhyp(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp);
-int ppcmas_tlb_check(CPUPPCState *env, ppcmas_tlb_t *tlb,
-                            hwaddr *raddrp, target_ulong address,
-                            uint32_t pid);
+int ppcmas_tlb_check(CPUPPCState *env, ppcmas_tlb_t *tlb, hwaddr *raddrp,
+                     target_ulong address, uint32_t pid);
 int ppcemb_tlb_search(CPUPPCState *env, target_ulong address, uint32_t pid);
-hwaddr booke206_tlb_to_page_size(CPUPPCState *env,
-                                        ppcmas_tlb_t *tlb);
+hwaddr booke206_tlb_to_page_size(CPUPPCState *env, ppcmas_tlb_t *tlb);
 #endif
 #endif
 
diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 845eee4c6f..a84bc7de88 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -694,8 +694,7 @@ static int mmubooke_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
     return ret;
 }
 
-hwaddr booke206_tlb_to_page_size(CPUPPCState *env,
-                                        ppcmas_tlb_t *tlb)
+hwaddr booke206_tlb_to_page_size(CPUPPCState *env, ppcmas_tlb_t *tlb)
 {
     int tlbm_size;
 
@@ -705,9 +704,8 @@ hwaddr booke206_tlb_to_page_size(CPUPPCState *env,
 }
 
 /* TLB check function for MAS based SoftTLBs */
-int ppcmas_tlb_check(CPUPPCState *env, ppcmas_tlb_t *tlb,
-                            hwaddr *raddrp, target_ulong address,
-                            uint32_t pid)
+int ppcmas_tlb_check(CPUPPCState *env, ppcmas_tlb_t *tlb, hwaddr *raddrp,
+                     target_ulong address, uint32_t pid)
 {
     hwaddr mask;
     uint32_t tlb_pid;
-- 
2.30.9


