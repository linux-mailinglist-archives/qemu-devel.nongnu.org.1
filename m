Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 260057711D6
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 21:40:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSN6t-00014d-FI; Sat, 05 Aug 2023 15:38:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qSN6p-00013A-Qp; Sat, 05 Aug 2023 15:38:43 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qSN6n-0007GG-R1; Sat, 05 Aug 2023 15:38:43 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9298D18646;
 Sat,  5 Aug 2023 22:38:35 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 561221BA3E;
 Sat,  5 Aug 2023 22:38:13 +0300 (MSK)
Received: (nullmailer pid 69542 invoked by uid 1000);
 Sat, 05 Aug 2023 19:38:11 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.5 43/44] target/ppc: Fix VRMA page size for ISA v3.0
Date: Sat,  5 Aug 2023 22:38:06 +0300
Message-Id: <20230805193811.69490-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.5-20230805210608@cover.tls.msk.ru>
References: <qemu-stable-7.2.5-20230805210608@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Nicholas Piggin <npiggin@gmail.com>

Until v2.07s, the VRMA page size (L||LP) was encoded in LPCR[VRMASD].
In v3.0 that moved to the partition table PS field.

The powernv machine can now run KVM HPT guests on POWER9/10 CPUs with
this fix and the patch to add ASDR.

Fixes: 3367c62f522b ("target/ppc: Support for POWER9 native hash")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Message-ID: <20230730111842.39292-1-npiggin@gmail.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
(cherry picked from commit 0e2a3ec36885f6d79a96230f582d4455878c6373)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index 2d8ed461c3..64c2a9cab3 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -874,12 +874,46 @@ static target_ulong rmls_limit(PowerPCCPU *cpu)
     return rma_sizes[rmls];
 }
 
-static int build_vrma_slbe(PowerPCCPU *cpu, ppc_slb_t *slb)
+/* Return the LLP in SLB_VSID format */
+static uint64_t get_vrma_llp(PowerPCCPU *cpu)
 {
     CPUPPCState *env = &cpu->env;
-    target_ulong lpcr = env->spr[SPR_LPCR];
-    uint32_t vrmasd = (lpcr & LPCR_VRMASD) >> LPCR_VRMASD_SHIFT;
-    target_ulong vsid = SLB_VSID_VRMA | ((vrmasd << 4) & SLB_VSID_LLP_MASK);
+    uint64_t llp;
+
+    if (env->mmu_model == POWERPC_MMU_3_00) {
+        ppc_v3_pate_t pate;
+        uint64_t ps, l, lp;
+
+        /*
+         * ISA v3.0 removes the LPCR[VRMASD] field and puts the VRMA base
+         * page size (L||LP equivalent) in the PS field in the HPT partition
+         * table entry.
+         */
+        if (!ppc64_v3_get_pate(cpu, cpu->env.spr[SPR_LPIDR], &pate)) {
+            error_report("Bad VRMA with no partition table entry");
+            return 0;
+        }
+        ps = PATE0_GET_PS(pate.dw0);
+        /* PS has L||LP in 3 consecutive bits, put them into SLB LLP format */
+        l = (ps >> 2) & 0x1;
+        lp = ps & 0x3;
+        llp = (l << SLB_VSID_L_SHIFT) | (lp << SLB_VSID_LP_SHIFT);
+
+    } else {
+        uint64_t lpcr = env->spr[SPR_LPCR];
+        target_ulong vrmasd = (lpcr & LPCR_VRMASD) >> LPCR_VRMASD_SHIFT;
+
+        /* VRMASD LLP matches SLB format, just shift and mask it */
+        llp = (vrmasd << SLB_VSID_LP_SHIFT) & SLB_VSID_LLP_MASK;
+    }
+
+    return llp;
+}
+
+static int build_vrma_slbe(PowerPCCPU *cpu, ppc_slb_t *slb)
+{
+    uint64_t llp = get_vrma_llp(cpu);
+    target_ulong vsid = SLB_VSID_VRMA | llp;
     int i;
 
     for (i = 0; i < PPC_PAGE_SIZES_MAX_SZ; i++) {
@@ -897,8 +931,7 @@ static int build_vrma_slbe(PowerPCCPU *cpu, ppc_slb_t *slb)
         }
     }
 
-    error_report("Bad page size encoding in LPCR[VRMASD]; LPCR=0x"
-                 TARGET_FMT_lx, lpcr);
+    error_report("Bad VRMA page size encoding 0x" TARGET_FMT_lx, llp);
 
     return -1;
 }
diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
index 1496955d38..de653fcae5 100644
--- a/target/ppc/mmu-hash64.h
+++ b/target/ppc/mmu-hash64.h
@@ -41,8 +41,10 @@ void ppc_hash64_finalize(PowerPCCPU *cpu);
 #define SLB_VSID_KP             0x0000000000000400ULL
 #define SLB_VSID_N              0x0000000000000200ULL /* no-execute */
 #define SLB_VSID_L              0x0000000000000100ULL
+#define SLB_VSID_L_SHIFT        PPC_BIT_NR(55)
 #define SLB_VSID_C              0x0000000000000080ULL /* class */
 #define SLB_VSID_LP             0x0000000000000030ULL
+#define SLB_VSID_LP_SHIFT       PPC_BIT_NR(59)
 #define SLB_VSID_ATTR           0x0000000000000FFFULL
 #define SLB_VSID_LLP_MASK       (SLB_VSID_L | SLB_VSID_LP)
 #define SLB_VSID_4K             0x0000000000000000ULL
@@ -58,6 +60,9 @@ void ppc_hash64_finalize(PowerPCCPU *cpu);
 #define SDR_64_HTABSIZE        0x000000000000001FULL
 
 #define PATE0_HTABORG           0x0FFFFFFFFFFC0000ULL
+#define PATE0_PS                PPC_BITMASK(56, 58)
+#define PATE0_GET_PS(dw0)       (((dw0) & PATE0_PS) >> PPC_BIT_NR(58))
+
 #define HPTES_PER_GROUP         8
 #define HASH_PTE_SIZE_64        16
 #define HASH_PTEG_SIZE_64       (HASH_PTE_SIZE_64 * HPTES_PER_GROUP)
-- 
2.39.2


