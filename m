Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E2B74FAEA
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 00:26:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJLmf-0008NT-6d; Tue, 11 Jul 2023 18:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sanastasio@raptorengineering.com>)
 id 1qJLmc-0008NB-SR; Tue, 11 Jul 2023 18:24:34 -0400
Received: from mail.raptorengineering.com ([23.155.224.40]
 helo=raptorengineering.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sanastasio@raptorengineering.com>)
 id 1qJLmZ-00042z-2C; Tue, 11 Jul 2023 18:24:33 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rptsys.com (Postfix) with ESMTP id 82F15828549E;
 Tue, 11 Jul 2023 17:24:21 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
 by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id iTbb7zi2dsqS; Tue, 11 Jul 2023 17:24:20 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.rptsys.com (Postfix) with ESMTP id 640C68285751;
 Tue, 11 Jul 2023 17:24:20 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 640C68285751
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
 t=1689114260; bh=o4OveDXgLcp/4SKUzDEYdxB5hcG9iUGQEyk8ii5G7/0=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=mskzOP2rcBeXpOg3gbp0lcsYq7QzwH9soGwrUbvTlXZJ+PiVKu2kUw1k527NkKgki
 BtrQETLtypouwkyYE1EsgqLGkhs3MYXNHZRs2W8Q/6spu+viZeJ1UvlcIJuWJ8Ey8I
 vGgIctvwpOFfXA+HDfbRaRtIWeSRyGJMn0epAu9E=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
 by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id ubVhUrGGwYzs; Tue, 11 Jul 2023 17:24:20 -0500 (CDT)
Received: from raptor-ewks-026.lan (5.edge.rptsys.com [23.155.224.38])
 by mail.rptsys.com (Postfix) with ESMTPSA id 4F97B828549E;
 Tue, 11 Jul 2023 17:24:19 -0500 (CDT)
From: Shawn Anastasio <sanastasio@raptorengineering.com>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Timothy Pearson <tpearson@raptorengineering.com>,
 Shawn Anastasio <sanastasio@raptorengineering.com>
Subject: [PATCH] target/ppc: Generate storage interrupts for radix RC changes
Date: Tue, 11 Jul 2023 17:24:05 -0500
Message-Id: <20230711222405.2712188-1-sanastasio@raptorengineering.com>
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

Change radix64_set_rc to always generate a storage interrupt when the
R/C bits are not set appropriately instead of setting the bits itself.
According to the ISA both behaviors are valid, but in practice this
change more closely matches behavior observed on the POWER9 CPU.

From the POWER9 Processor User's Manual, Section 4.10.13.1: "When
performing Radix translation, the POWER9 hardware triggers the
appropriate interrupt ... for the mode and type of access whenever
Reference (R) and Change (C) bits require setting in either the guest or
host page-table entry (PTE)."

Signed-off-by: Shawn Anastasio <sanastasio@raptorengineering.com>
---
 target/ppc/mmu-radix64.c | 57 ++++++++++++++++++++++++++++------------
 1 file changed, 40 insertions(+), 17 deletions(-)

diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index 920084bd8f..06e1cced31 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -219,27 +219,48 @@ static bool ppc_radix64_check_prot(PowerPCCPU *cpu,=
 MMUAccessType access_type,
     return false;
 }
=20
-static void ppc_radix64_set_rc(PowerPCCPU *cpu, MMUAccessType access_typ=
e,
-                               uint64_t pte, hwaddr pte_addr, int *prot)
+static int ppc_radix64_check_rc(PowerPCCPU *cpu, MMUAccessType access_ty=
pe,
+                               uint64_t pte, vaddr eaddr, bool partition=
_scoped,
+                               hwaddr g_raddr)
 {
-    CPUState *cs =3D CPU(cpu);
-    uint64_t npte;
+    uint64_t lpid =3D 0;
+    uint64_t pid =3D 0;
=20
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
=20
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
=20
-    if (pte ^ npte) { /* If pte has changed then write it back */
-        stq_phys(cs->as, pte_addr, npte);
+    /* Obtain effLPID */
+    (void)ppc_radix64_get_fully_qualified_addr(&cpu->env, eaddr, &lpid, =
&pid);
+
+    /*
+     * Per ISA 3.1 Book III, 7.5.3 and 7.5.5, failure to set R/C during
+     * partition-scoped translation when effLPID =3D 0 results in normal
+     * (non-Hypervisor) Data and Instruction Storage Interrupts respecti=
vely.
+     *
+     * ISA 3.0 is ambiguous about this, but tests on POWER9 hardware see=
m to
+     * exhibit the same behavior.
+     */
+    if (partition_scoped && lpid > 0) {
+        ppc_radix64_raise_hsi(cpu, access_type, eaddr, g_raddr,
+                              DSISR_ATOMIC_RC);
+    } else {
+        ppc_radix64_raise_si(cpu, access_type, eaddr, DSISR_ATOMIC_RC);
     }
+
+    return 1;
 }
=20
 static bool ppc_radix64_is_valid_level(int level, int psize, uint64_t nl=
s)
@@ -418,7 +439,8 @@ static int ppc_radix64_partition_scoped_xlate(PowerPC=
CPU *cpu,
     }
=20
     if (guest_visible) {
-        ppc_radix64_set_rc(cpu, access_type, pte, pte_addr, h_prot);
+        return ppc_radix64_check_rc(cpu, access_type, pte, eaddr, true,
+                                    g_raddr);
     }
=20
     return 0;
@@ -580,7 +602,8 @@ static int ppc_radix64_process_scoped_xlate(PowerPCCP=
U *cpu,
     }
=20
     if (guest_visible) {
-        ppc_radix64_set_rc(cpu, access_type, pte, pte_addr, g_prot);
+        return ppc_radix64_check_rc(cpu, access_type, pte, eaddr, false,
+                                    *g_raddr);
     }
=20
     return 0;
--=20
2.30.2


