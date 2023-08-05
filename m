Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3117711E3
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 21:42:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSN9i-0007dC-Ht; Sat, 05 Aug 2023 15:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qSN9e-0007bP-KY; Sat, 05 Aug 2023 15:41:38 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qSN9c-0007sA-QT; Sat, 05 Aug 2023 15:41:38 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C73FC18661;
 Sat,  5 Aug 2023 22:41:50 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 963701BA47;
 Sat,  5 Aug 2023 22:41:28 +0300 (MSK)
Received: (nullmailer pid 70361 invoked by uid 1000);
 Sat, 05 Aug 2023 19:41:27 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.4 68/71] target/ppc: Implement ASDR register for ISA v3.0
 for HPT
Date: Sat,  5 Aug 2023 22:41:09 +0300
Message-Id: <20230805194127.70304-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.4-20230805223954@cover.tls.msk.ru>
References: <qemu-stable-8.0.4-20230805223954@cover.tls.msk.ru>
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

The ASDR register was introduced in ISA v3.0. It has not been
implemented for HPT. With HPT, ASDR is the format of the slbmte RS
operand (containing VSID), which matches the ppc_slb_t field.

Fixes: 3367c62f522b ("target/ppc: Support for POWER9 native hash")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Message-ID: <20230726182230.433945-2-npiggin@gmail.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
(cherry picked from commit 9201af096962a1967ce5d0b270ed16ae4edd3db6)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index 900f906990..a0c90df3ce 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -770,7 +770,8 @@ static bool ppc_hash64_use_vrma(CPUPPCState *env)
     }
 }
 
-static void ppc_hash64_set_isi(CPUState *cs, int mmu_idx, uint64_t error_code)
+static void ppc_hash64_set_isi(CPUState *cs, int mmu_idx, uint64_t slb_vsid,
+                               uint64_t error_code)
 {
     CPUPPCState *env = &POWERPC_CPU(cs)->env;
     bool vpm;
@@ -782,13 +783,15 @@ static void ppc_hash64_set_isi(CPUState *cs, int mmu_idx, uint64_t error_code)
     }
     if (vpm && !mmuidx_hv(mmu_idx)) {
         cs->exception_index = POWERPC_EXCP_HISI;
+        env->spr[SPR_ASDR] = slb_vsid;
     } else {
         cs->exception_index = POWERPC_EXCP_ISI;
     }
     env->error_code = error_code;
 }
 
-static void ppc_hash64_set_dsi(CPUState *cs, int mmu_idx, uint64_t dar, uint64_t dsisr)
+static void ppc_hash64_set_dsi(CPUState *cs, int mmu_idx, uint64_t slb_vsid,
+                               uint64_t dar, uint64_t dsisr)
 {
     CPUPPCState *env = &POWERPC_CPU(cs)->env;
     bool vpm;
@@ -802,6 +805,7 @@ static void ppc_hash64_set_dsi(CPUState *cs, int mmu_idx, uint64_t dar, uint64_t
         cs->exception_index = POWERPC_EXCP_HDSI;
         env->spr[SPR_HDAR] = dar;
         env->spr[SPR_HDSISR] = dsisr;
+        env->spr[SPR_ASDR] = slb_vsid;
     } else {
         cs->exception_index = POWERPC_EXCP_DSI;
         env->spr[SPR_DAR] = dar;
@@ -963,13 +967,13 @@ bool ppc_hash64_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
                 }
                 switch (access_type) {
                 case MMU_INST_FETCH:
-                    ppc_hash64_set_isi(cs, mmu_idx, SRR1_PROTFAULT);
+                    ppc_hash64_set_isi(cs, mmu_idx, 0, SRR1_PROTFAULT);
                     break;
                 case MMU_DATA_LOAD:
-                    ppc_hash64_set_dsi(cs, mmu_idx, eaddr, DSISR_PROTFAULT);
+                    ppc_hash64_set_dsi(cs, mmu_idx, 0, eaddr, DSISR_PROTFAULT);
                     break;
                 case MMU_DATA_STORE:
-                    ppc_hash64_set_dsi(cs, mmu_idx, eaddr,
+                    ppc_hash64_set_dsi(cs, mmu_idx, 0, eaddr,
                                        DSISR_PROTFAULT | DSISR_ISSTORE);
                     break;
                 default:
@@ -1022,7 +1026,7 @@ bool ppc_hash64_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
     /* 3. Check for segment level no-execute violation */
     if (access_type == MMU_INST_FETCH && (slb->vsid & SLB_VSID_N)) {
         if (guest_visible) {
-            ppc_hash64_set_isi(cs, mmu_idx, SRR1_NOEXEC_GUARD);
+            ppc_hash64_set_isi(cs, mmu_idx, slb->vsid, SRR1_NOEXEC_GUARD);
         }
         return false;
     }
@@ -1035,13 +1039,14 @@ bool ppc_hash64_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
         }
         switch (access_type) {
         case MMU_INST_FETCH:
-            ppc_hash64_set_isi(cs, mmu_idx, SRR1_NOPTE);
+            ppc_hash64_set_isi(cs, mmu_idx, slb->vsid, SRR1_NOPTE);
             break;
         case MMU_DATA_LOAD:
-            ppc_hash64_set_dsi(cs, mmu_idx, eaddr, DSISR_NOPTE);
+            ppc_hash64_set_dsi(cs, mmu_idx, slb->vsid, eaddr, DSISR_NOPTE);
             break;
         case MMU_DATA_STORE:
-            ppc_hash64_set_dsi(cs, mmu_idx, eaddr, DSISR_NOPTE | DSISR_ISSTORE);
+            ppc_hash64_set_dsi(cs, mmu_idx, slb->vsid, eaddr,
+                               DSISR_NOPTE | DSISR_ISSTORE);
             break;
         default:
             g_assert_not_reached();
@@ -1075,7 +1080,7 @@ bool ppc_hash64_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
             if (PAGE_EXEC & ~amr_prot) {
                 srr1 |= SRR1_IAMR; /* Access violates virt pg class key prot */
             }
-            ppc_hash64_set_isi(cs, mmu_idx, srr1);
+            ppc_hash64_set_isi(cs, mmu_idx, slb->vsid, srr1);
         } else {
             int dsisr = 0;
             if (need_prot & ~pp_prot) {
@@ -1087,7 +1092,7 @@ bool ppc_hash64_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
             if (need_prot & ~amr_prot) {
                 dsisr |= DSISR_AMR;
             }
-            ppc_hash64_set_dsi(cs, mmu_idx, eaddr, dsisr);
+            ppc_hash64_set_dsi(cs, mmu_idx, slb->vsid, eaddr, dsisr);
         }
         return false;
     }
-- 
2.39.2


