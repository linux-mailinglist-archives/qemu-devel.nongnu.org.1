Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 717B0791460
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 11:09:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd5Xx-0001LI-BB; Mon, 04 Sep 2023 05:07:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=kZzc=EU=kaod.org=clg@ozlabs.org>)
 id 1qd5Xr-0001Dr-9A; Mon, 04 Sep 2023 05:06:55 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=kZzc=EU=kaod.org=clg@ozlabs.org>)
 id 1qd5Xk-0003br-LI; Mon, 04 Sep 2023 05:06:54 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RfN6n1Tfyz4wy8;
 Mon,  4 Sep 2023 19:06:41 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RfN6k0hCbz4wy1;
 Mon,  4 Sep 2023 19:06:37 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Shawn Anastasio <sanastasio@raptorengineering.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PULL 01/35] target/ppc: Generate storage interrupts for radix RC
 changes
Date: Mon,  4 Sep 2023 11:05:56 +0200
Message-ID: <20230904090630.725952-2-clg@kaod.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904090630.725952-1-clg@kaod.org>
References: <20230904090630.725952-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=kZzc=EU=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Shawn Anastasio <sanastasio@raptorengineering.com>

Change radix model to always generate a storage interrupt when the R/C
bits are not set appropriately in a PTE instead of setting the bits
itself.  According to the ISA both behaviors are valid, but in practice
this change more closely matches behavior observed on the POWER9 CPU.

From the POWER9 Processor User's Manual, Section 4.10.13.1: "When
performing Radix translation, the POWER9 hardware triggers the
appropriate interrupt ... for the mode and type of access whenever
Reference (R) and Change (C) bits require setting in either the guest or
host page-table entry (PTE)."

Signed-off-by: Shawn Anastasio <sanastasio@raptorengineering.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 target/ppc/mmu-radix64.c | 74 ++++++++++++++++++++++++++--------------
 1 file changed, 49 insertions(+), 25 deletions(-)

diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index 920084bd8ff2..5823e039e64f 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -219,27 +219,25 @@ static bool ppc_radix64_check_prot(PowerPCCPU *cpu, MMUAccessType access_type,
     return false;
 }
 
-static void ppc_radix64_set_rc(PowerPCCPU *cpu, MMUAccessType access_type,
-                               uint64_t pte, hwaddr pte_addr, int *prot)
+static int ppc_radix64_check_rc(MMUAccessType access_type, uint64_t pte)
 {
-    CPUState *cs = CPU(cpu);
-    uint64_t npte;
-
-    npte = pte | R_PTE_R; /* Always set reference bit */
+    switch (access_type) {
+    case MMU_DATA_STORE:
+        if (!(pte & R_PTE_C)) {
+            break;
+        }
+        /* fall through */
+    case MMU_INST_FETCH:
+    case MMU_DATA_LOAD:
+        if (!(pte & R_PTE_R)) {
+            break;
+        }
 
-    if (access_type == MMU_DATA_STORE) { /* Store/Write */
-        npte |= R_PTE_C; /* Set change bit */
-    } else {
-        /*
-         * Treat the page as read-only for now, so that a later write
-         * will pass through this function again to set the C bit.
-         */
-        *prot &= ~PAGE_WRITE;
+        /* R/C bits are already set appropriately for this access */
+        return 0;
     }
 
-    if (pte ^ npte) { /* If pte has changed then write it back */
-        stq_phys(cs->as, pte_addr, npte);
-    }
+    return 1;
 }
 
 static bool ppc_radix64_is_valid_level(int level, int psize, uint64_t nls)
@@ -380,7 +378,8 @@ static int ppc_radix64_partition_scoped_xlate(PowerPCCPU *cpu,
                                               ppc_v3_pate_t pate,
                                               hwaddr *h_raddr, int *h_prot,
                                               int *h_page_size, bool pde_addr,
-                                              int mmu_idx, bool guest_visible)
+                                              int mmu_idx, uint64_t lpid,
+                                              bool guest_visible)
 {
     MMUAccessType access_type = orig_access_type;
     int fault_cause = 0;
@@ -418,7 +417,24 @@ static int ppc_radix64_partition_scoped_xlate(PowerPCCPU *cpu,
     }
 
     if (guest_visible) {
-        ppc_radix64_set_rc(cpu, access_type, pte, pte_addr, h_prot);
+        if (ppc_radix64_check_rc(access_type, pte)) {
+            /*
+             * Per ISA 3.1 Book III, 7.5.3 and 7.5.5, failure to set R/C during
+             * partition-scoped translation when effLPID = 0 results in normal
+             * (non-Hypervisor) Data and Instruction Storage Interrupts
+             * respectively.
+             *
+             * ISA 3.0 is ambiguous about this, but tests on POWER9 hardware
+             * seem to exhibit the same behavior.
+             */
+            if (lpid > 0) {
+                ppc_radix64_raise_hsi(cpu, access_type, eaddr, g_raddr,
+                                      DSISR_ATOMIC_RC);
+            } else {
+                ppc_radix64_raise_si(cpu, access_type, eaddr, DSISR_ATOMIC_RC);
+            }
+            return 1;
+        }
     }
 
     return 0;
@@ -447,7 +463,8 @@ static int ppc_radix64_process_scoped_xlate(PowerPCCPU *cpu,
                                             vaddr eaddr, uint64_t pid,
                                             ppc_v3_pate_t pate, hwaddr *g_raddr,
                                             int *g_prot, int *g_page_size,
-                                            int mmu_idx, bool guest_visible)
+                                            int mmu_idx, uint64_t lpid,
+                                            bool guest_visible)
 {
     CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
@@ -497,7 +514,7 @@ static int ppc_radix64_process_scoped_xlate(PowerPCCPU *cpu,
         ret = ppc_radix64_partition_scoped_xlate(cpu, access_type, eaddr,
                                                  prtbe_addr, pate, &h_raddr,
                                                  &h_prot, &h_page_size, true,
-                                                 5, guest_visible);
+                                                 5, lpid, guest_visible);
         if (ret) {
             return ret;
         }
@@ -539,7 +556,8 @@ static int ppc_radix64_process_scoped_xlate(PowerPCCPU *cpu,
             ret = ppc_radix64_partition_scoped_xlate(cpu, access_type, eaddr,
                                                      pte_addr, pate, &h_raddr,
                                                      &h_prot, &h_page_size,
-                                                     true, 5, guest_visible);
+                                                     true, 5, lpid,
+                                                     guest_visible);
             if (ret) {
                 return ret;
             }
@@ -580,7 +598,11 @@ static int ppc_radix64_process_scoped_xlate(PowerPCCPU *cpu,
     }
 
     if (guest_visible) {
-        ppc_radix64_set_rc(cpu, access_type, pte, pte_addr, g_prot);
+        /* R/C bits not appropriately set for access */
+        if (ppc_radix64_check_rc(access_type, pte)) {
+            ppc_radix64_raise_si(cpu, access_type, eaddr, DSISR_ATOMIC_RC);
+            return 1;
+        }
     }
 
     return 0;
@@ -695,7 +717,8 @@ static bool ppc_radix64_xlate_impl(PowerPCCPU *cpu, vaddr eaddr,
     if (relocation) {
         int ret = ppc_radix64_process_scoped_xlate(cpu, access_type, eaddr, pid,
                                                    pate, &g_raddr, &prot,
-                                                   &psize, mmu_idx, guest_visible);
+                                                   &psize, mmu_idx, lpid,
+                                                   guest_visible);
         if (ret) {
             return false;
         }
@@ -719,7 +742,8 @@ static bool ppc_radix64_xlate_impl(PowerPCCPU *cpu, vaddr eaddr,
             ret = ppc_radix64_partition_scoped_xlate(cpu, access_type, eaddr,
                                                      g_raddr, pate, raddr,
                                                      &prot, &psize, false,
-                                                     mmu_idx, guest_visible);
+                                                     mmu_idx, lpid,
+                                                     guest_visible);
             if (ret) {
                 return false;
             }
-- 
2.41.0


