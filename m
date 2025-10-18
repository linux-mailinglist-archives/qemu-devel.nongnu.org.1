Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31451BED256
	for <lists+qemu-devel@lfdr.de>; Sat, 18 Oct 2025 17:15:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vA8au-0008EG-Hx; Sat, 18 Oct 2025 11:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vA8ar-0008CM-8A; Sat, 18 Oct 2025 11:11:41 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vA8ap-0005fs-Nc; Sat, 18 Oct 2025 11:11:40 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A61F25972F5;
 Sat, 18 Oct 2025 17:11:37 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id TlBUK6klS8c8; Sat, 18 Oct 2025 17:11:35 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A80A05972EF; Sat, 18 Oct 2025 17:11:35 +0200 (CEST)
Message-ID: <1c95348927decbe66456a0be2ff5a63073cda90e.1760798392.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1760798392.git.balaton@eik.bme.hu>
References: <cover.1760798392.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v3 04/13] hw/ppc/pegasos2: Remove fdt pointer from machine
 state
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Date: Sat, 18 Oct 2025 17:11:35 +0200 (CEST)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The machine class has a field for storing the fdt so we don't need our
own and can use that instead.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ppc/pegasos2.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index 646755a3cc..7dc7803c64 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -74,7 +74,6 @@ struct Pegasos2MachineState {
     qemu_irq mv_pirq[PCI_NUM_PINS];
     qemu_irq via_pirq[PCI_NUM_PINS];
     Vof *vof;
-    void *fdt_blob;
     uint64_t kernel_addr;
     uint64_t kernel_entry;
     uint64_t kernel_size;
@@ -413,13 +412,11 @@ static void pegasos2_machine_reset(MachineState *machine, ResetType type)
     d[1] = cpu_to_be64(pm->kernel_size - (pm->kernel_entry - pm->kernel_addr));
     qemu_fdt_setprop(fdt, "/chosen", "qemu,boot-kernel", d, sizeof(d));
 
-    g_free(pm->fdt_blob);
-    pm->fdt_blob = fdt;
-
     vof_build_dt(fdt, pm->vof);
     vof_client_open_store(fdt, pm->vof, "/chosen", "stdout", "/failsafe");
 
     /* Set machine->fdt for 'dumpdtb' QMP/HMP command */
+    g_free(machine->fdt);
     machine->fdt = fdt;
 
     pm->cpu->vhyp = PPC_VIRTUAL_HYPERVISOR(machine);
@@ -559,7 +556,7 @@ static void pegasos2_hypercall(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu)
     } else if (env->gpr[3] == KVMPPC_H_RTAS) {
         env->gpr[3] = pegasos2_rtas(cpu, pm, env->gpr[4]);
     } else if (env->gpr[3] == KVMPPC_H_VOF_CLIENT) {
-        int ret = vof_client_call(MACHINE(pm), pm->vof, pm->fdt_blob,
+        int ret = vof_client_call(MACHINE(pm), pm->vof, MACHINE(pm)->fdt,
                                   env->gpr[4]);
         env->gpr[3] = (ret ? H_PARAMETER : H_SUCCESS);
     } else {
-- 
2.41.3


