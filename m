Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D91750DCE
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 18:16:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJcVL-0006wO-Km; Wed, 12 Jul 2023 12:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sanastasio@raptorengineering.com>)
 id 1qJcVH-0006vx-Cl; Wed, 12 Jul 2023 12:15:47 -0400
Received: from mail.raptorengineering.com ([23.155.224.40]
 helo=raptorengineering.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sanastasio@raptorengineering.com>)
 id 1qJcVF-0000UT-IA; Wed, 12 Jul 2023 12:15:47 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rptsys.com (Postfix) with ESMTP id EE231828546E;
 Wed, 12 Jul 2023 11:15:43 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
 by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id apBH8_26uJ3z; Wed, 12 Jul 2023 11:15:42 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.rptsys.com (Postfix) with ESMTP id 96FCB82856DE;
 Wed, 12 Jul 2023 11:15:42 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 96FCB82856DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
 t=1689178542; bh=zPQhauFsoaOCYYYe5STkWG10WGAQCF5tpTaB5fxeL54=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=og6S/BzKs165l7j9WMC2/sNYZ2GBFWJCpQzONcZOu/4fI4nr/gcailLGUWBHCbsgM
 tgNlycaC1ssyCdw9ZevScZeNd7V7N31LVBsUnmvBDdoSgplXyNS0FPb/gz6STFRpsi
 EG4iPWkgd1PrK3RAu6xtKkMDbGPRDEnliKKpO88A=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
 by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id tmZnWWhhCuZ0; Wed, 12 Jul 2023 11:15:42 -0500 (CDT)
Received: from raptor-ewks-026.lan (5.edge.rptsys.com [23.155.224.38])
 by mail.rptsys.com (Postfix) with ESMTPSA id E635C828546E;
 Wed, 12 Jul 2023 11:15:41 -0500 (CDT)
From: Shawn Anastasio <sanastasio@raptorengineering.com>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Timothy Pearson <tpearson@raptorengineering.com>,
 Shawn Anastasio <sanastasio@raptorengineering.com>
Subject: [PATCH v2] target/ppc: Generate storage interrupts for radix RC
 changes
Date: Wed, 12 Jul 2023 11:13:22 -0500
Message-Id: <20230712161322.2729950-1-sanastasio@raptorengineering.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=23.155.224.40;
 envelope-from=sanastasio@raptorengineering.com; helo=raptorengineering.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
---
Changes in v2:
  - Raise interrupt in ppc_radix64_process_scoped_xlate and
    ppc_radix64_partition_scoped_xlate instead of ppc_radix64_check_rc

 target/ppc/mmu-radix64.c | 74 ++++++++++++++++++++++++++--------------
 1 file changed, 49 insertions(+), 25 deletions(-)

diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index 920084bd8f..5823e039e6 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -219,27 +219,25 @@ static bool ppc_radix64_check_prot(PowerPCCPU *cpu,=
 MMUAccessType access_type,
     return false;
 }

-static void ppc_radix64_set_rc(PowerPCCPU *cpu, MMUAccessType access_typ=
e,
-                               uint64_t pte, hwaddr pte_addr, int *prot)
+static int ppc_radix64_check_rc(MMUAccessType access_type, uint64_t pte)
 {
-    CPUState *cs =3D CPU(cpu);
-    uint64_t npte;
-
-    npte =3D pte | R_PTE_R; /* Always set reference bit */
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

-    if (access_type =3D=3D MMU_DATA_STORE) { /* Store/Write */
-        npte |=3D R_PTE_C; /* Set change bit */
-    } else {
-        /*
-         * Treat the page as read-only for now, so that a later write
-         * will pass through this function again to set the C bit.
-         */
-        *prot &=3D ~PAGE_WRITE;
+        /* R/C bits are already set appropriately for this access */
+        return 0;
     }

-    if (pte ^ npte) { /* If pte has changed then write it back */
-        stq_phys(cs->as, pte_addr, npte);
-    }
+    return 1;
 }

 static bool ppc_radix64_is_valid_level(int level, int psize, uint64_t nl=
s)
@@ -380,7 +378,8 @@ static int ppc_radix64_partition_scoped_xlate(PowerPC=
CPU *cpu,
                                               ppc_v3_pate_t pate,
                                               hwaddr *h_raddr, int *h_pr=
ot,
                                               int *h_page_size, bool pde=
_addr,
-                                              int mmu_idx, bool guest_vi=
sible)
+                                              int mmu_idx, uint64_t lpid=
,
+                                              bool guest_visible)
 {
     MMUAccessType access_type =3D orig_access_type;
     int fault_cause =3D 0;
@@ -418,7 +417,24 @@ static int ppc_radix64_partition_scoped_xlate(PowerP=
CCPU *cpu,
     }

     if (guest_visible) {
-        ppc_radix64_set_rc(cpu, access_type, pte, pte_addr, h_prot);
+        if (ppc_radix64_check_rc(access_type, pte)) {
+            /*
+             * Per ISA 3.1 Book III, 7.5.3 and 7.5.5, failure to set R/C=
 during
+             * partition-scoped translation when effLPID =3D 0 results i=
n normal
+             * (non-Hypervisor) Data and Instruction Storage Interrupts
+             * respectively.
+             *
+             * ISA 3.0 is ambiguous about this, but tests on POWER9 hard=
ware
+             * seem to exhibit the same behavior.
+             */
+            if (lpid > 0) {
+                ppc_radix64_raise_hsi(cpu, access_type, eaddr, g_raddr,
+                                      DSISR_ATOMIC_RC);
+            } else {
+                ppc_radix64_raise_si(cpu, access_type, eaddr, DSISR_ATOM=
IC_RC);
+            }
+            return 1;
+        }
     }

     return 0;
@@ -447,7 +463,8 @@ static int ppc_radix64_process_scoped_xlate(PowerPCCP=
U *cpu,
                                             vaddr eaddr, uint64_t pid,
                                             ppc_v3_pate_t pate, hwaddr *=
g_raddr,
                                             int *g_prot, int *g_page_siz=
e,
-                                            int mmu_idx, bool guest_visi=
ble)
+                                            int mmu_idx, uint64_t lpid,
+                                            bool guest_visible)
 {
     CPUState *cs =3D CPU(cpu);
     CPUPPCState *env =3D &cpu->env;
@@ -497,7 +514,7 @@ static int ppc_radix64_process_scoped_xlate(PowerPCCP=
U *cpu,
         ret =3D ppc_radix64_partition_scoped_xlate(cpu, access_type, ead=
dr,
                                                  prtbe_addr, pate, &h_ra=
ddr,
                                                  &h_prot, &h_page_size, =
true,
-                                                 5, guest_visible);
+                                                 5, lpid, guest_visible)=
;
         if (ret) {
             return ret;
         }
@@ -539,7 +556,8 @@ static int ppc_radix64_process_scoped_xlate(PowerPCCP=
U *cpu,
             ret =3D ppc_radix64_partition_scoped_xlate(cpu, access_type,=
 eaddr,
                                                      pte_addr, pate, &h_=
raddr,
                                                      &h_prot, &h_page_si=
ze,
-                                                     true, 5, guest_visi=
ble);
+                                                     true, 5, lpid,
+                                                     guest_visible);
             if (ret) {
                 return ret;
             }
@@ -580,7 +598,11 @@ static int ppc_radix64_process_scoped_xlate(PowerPCC=
PU *cpu,
     }

     if (guest_visible) {
-        ppc_radix64_set_rc(cpu, access_type, pte, pte_addr, g_prot);
+        /* R/C bits not appropriately set for access */
+        if (ppc_radix64_check_rc(access_type, pte)) {
+            ppc_radix64_raise_si(cpu, access_type, eaddr, DSISR_ATOMIC_R=
C);
+            return 1;
+        }
     }

     return 0;
@@ -695,7 +717,8 @@ static bool ppc_radix64_xlate_impl(PowerPCCPU *cpu, v=
addr eaddr,
     if (relocation) {
         int ret =3D ppc_radix64_process_scoped_xlate(cpu, access_type, e=
addr, pid,
                                                    pate, &g_raddr, &prot=
,
-                                                   &psize, mmu_idx, gues=
t_visible);
+                                                   &psize, mmu_idx, lpid=
,
+                                                   guest_visible);
         if (ret) {
             return false;
         }
@@ -719,7 +742,8 @@ static bool ppc_radix64_xlate_impl(PowerPCCPU *cpu, v=
addr eaddr,
             ret =3D ppc_radix64_partition_scoped_xlate(cpu, access_type,=
 eaddr,
                                                      g_raddr, pate, radd=
r,
                                                      &prot, &psize, fals=
e,
-                                                     mmu_idx, guest_visi=
ble);
+                                                     mmu_idx, lpid,
+                                                     guest_visible);
             if (ret) {
                 return false;
             }
--
2.30.2


