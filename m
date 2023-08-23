Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 516AA785712
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 13:48:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYmJk-0001Zi-9a; Wed, 23 Aug 2023 07:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qYmJF-0001Tj-RR
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 07:46:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qYmJ7-0001OC-M0
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 07:45:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692791152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xYJlui688L5hS3PaC/CBbdriErtm8Ikgw7xUEycY5nA=;
 b=TZhK8Bzo35tAxH/gnrFSRk9k7ofxUN5ytz7+4Q334xXonsawZvyDmFMzJ2Bxi7IiS3+U07
 U27xE1mRfPjCOUbuNCRhyEz3tnUwMGAwAelkTaLKtRBKuC6IKNwWLvmO7ML33Zz0TiXu+Y
 1UMpbVgJ14ScC2JKnVuuzaQIajzgsBo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-113-Ohrz0P24PqyoUWjiDzrM-g-1; Wed, 23 Aug 2023 07:45:50 -0400
X-MC-Unique: Ohrz0P24PqyoUWjiDzrM-g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7ED69858EED;
 Wed, 23 Aug 2023 11:45:50 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7B6D9C15BAE;
 Wed, 23 Aug 2023 11:45:49 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PULL 02/12] s390x: Convert DPRINTF to trace events
Date: Wed, 23 Aug 2023 13:45:34 +0200
Message-Id: <20230823114544.216520-3-thuth@redhat.com>
In-Reply-To: <20230823114544.216520-1-thuth@redhat.com>
References: <20230823114544.216520-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Cédric Le Goater <clg@redhat.com>

Output message are slightly modified to ease selection with wildcards
and to report extra parameters.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20230804080415.56852-1-clg@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/s390-pci-bus.c       | 25 ++++++------------
 hw/s390x/s390-pci-inst.c      | 48 ++++++++++++++---------------------
 target/s390x/kvm/kvm.c        | 33 ++++++++----------------
 hw/s390x/trace-events         | 17 +++++++++++++
 target/s390x/kvm/trace-events |  7 +++++
 5 files changed, 62 insertions(+), 68 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 02751f3597..2ca36f9f3b 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -27,16 +27,7 @@
 #include "sysemu/reset.h"
 #include "sysemu/runstate.h"
 
-#ifndef DEBUG_S390PCI_BUS
-#define DEBUG_S390PCI_BUS  0
-#endif
-
-#define DPRINTF(fmt, ...)                                         \
-    do {                                                          \
-        if (DEBUG_S390PCI_BUS) {                                  \
-            fprintf(stderr, "S390pci-bus: " fmt, ## __VA_ARGS__); \
-        }                                                         \
-    } while (0)
+#include "trace.h"
 
 S390pciState *s390_get_phb(void)
 {
@@ -132,7 +123,7 @@ void s390_pci_sclp_configure(SCCB *sccb)
     uint16_t rc;
 
     if (!pbdev) {
-        DPRINTF("sclp config no dev found\n");
+        trace_s390_pci_sclp_nodev("configure", be32_to_cpu(psccb->aid));
         rc = SCLP_RC_ADAPTER_ID_NOT_RECOGNIZED;
         goto out;
     }
@@ -199,7 +190,7 @@ void s390_pci_sclp_deconfigure(SCCB *sccb)
     uint16_t rc;
 
     if (!pbdev) {
-        DPRINTF("sclp deconfig no dev found\n");
+        trace_s390_pci_sclp_nodev("deconfigure", be32_to_cpu(psccb->aid));
         rc = SCLP_RC_ADAPTER_ID_NOT_RECOGNIZED;
         goto out;
     }
@@ -573,7 +564,7 @@ static IOMMUTLBEntry s390_translate_iommu(IOMMUMemoryRegion *mr, hwaddr addr,
         return ret;
     }
 
-    DPRINTF("iommu trans addr 0x%" PRIx64 "\n", addr);
+    trace_s390_pci_iommu_xlate(addr);
 
     if (addr < iommu->pba || addr > iommu->pal) {
         error = ERR_EVENT_OORANGE;
@@ -692,8 +683,8 @@ static void s390_msi_ctrl_write(void *opaque, hwaddr addr, uint64_t data,
     uint32_t sum_bit;
 
     assert(pbdev);
-    DPRINTF("write_msix data 0x%" PRIx64 " idx %d vec 0x%x\n", data,
-            pbdev->idx, vec);
+
+    trace_s390_pci_msi_ctrl_write(data, pbdev->idx, vec);
 
     if (pbdev->state != ZPCI_FS_ENABLED) {
         return;
@@ -843,7 +834,7 @@ static void s390_pcihost_realize(DeviceState *dev, Error **errp)
     PCIHostState *phb = PCI_HOST_BRIDGE(dev);
     S390pciState *s = S390_PCI_HOST_BRIDGE(dev);
 
-    DPRINTF("host_init\n");
+    trace_s390_pcihost("realize");
 
     b = pci_register_root_bus(dev, NULL, s390_pci_set_irq, s390_pci_map_irq,
                               NULL, get_system_memory(), get_system_io(), 0,
@@ -1120,7 +1111,7 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                         return;
                     }
                 } else {
-                    DPRINTF("zPCI interpretation facilities missing.\n");
+                    trace_s390_pcihost("zPCI interpretation missing");
                     pbdev->interp = false;
                     pbdev->forwarding_assist = false;
                 }
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 8f84ac6251..30149546c0 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -23,16 +23,7 @@
 #include "hw/s390x/s390-pci-vfio.h"
 #include "hw/s390x/tod.h"
 
-#ifndef DEBUG_S390PCI_INST
-#define DEBUG_S390PCI_INST  0
-#endif
-
-#define DPRINTF(fmt, ...)                                          \
-    do {                                                           \
-        if (DEBUG_S390PCI_INST) {                                  \
-            fprintf(stderr, "s390pci-inst: " fmt, ## __VA_ARGS__); \
-        }                                                          \
-    } while (0)
+#include "trace.h"
 
 static inline void inc_dma_avail(S390PCIIOMMU *iommu)
 {
@@ -133,8 +124,7 @@ static int list_pci(ClpReqRspListPci *rrb, uint8_t *cc)
 
         g_l2 += sizeof(ClpFhListEntry);
         /* Add endian check for DPRINTF? */
-        DPRINTF("g_l2 %d vendor id 0x%x device id 0x%x fid 0x%x fh 0x%x\n",
-                g_l2,
+        trace_s390_pci_list_entry(g_l2,
                 lduw_p(&rrb->response.fh_list[i].vendor_id),
                 lduw_p(&rrb->response.fh_list[i].device_id),
                 ldl_p(&rrb->response.fh_list[i].fid),
@@ -153,7 +143,7 @@ static int list_pci(ClpReqRspListPci *rrb, uint8_t *cc)
     stw_p(&rrb->response.hdr.rsp, CLP_RC_OK);
 out:
     if (rc) {
-        DPRINTF("list pci failed rc 0x%x\n", rc);
+        trace_s390_pci_list(rc);
         stw_p(&rrb->response.hdr.rsp, res_code);
     }
     return rc;
@@ -280,7 +270,7 @@ int clp_service_call(S390CPU *cpu, uint8_t r2, uintptr_t ra)
             stw_p(&ressetpci->hdr.rsp, CLP_RC_OK);
             break;
         default:
-            DPRINTF("unknown set pci command\n");
+            trace_s390_pci_unknown("set-pci", reqsetpci->oc);
             stw_p(&ressetpci->hdr.rsp, CLP_RC_SETPCIFN_FHOP);
             break;
         }
@@ -292,7 +282,7 @@ int clp_service_call(S390CPU *cpu, uint8_t r2, uintptr_t ra)
 
         pbdev = s390_pci_find_dev_by_fh(s, ldl_p(&reqquery->fh));
         if (!pbdev) {
-            DPRINTF("query pci no pci dev\n");
+            trace_s390_pci_nodev("query", ldl_p(&reqquery->fh));
             stw_p(&resquery->hdr.rsp, CLP_RC_SETPCIFN_FH);
             goto out;
         }
@@ -317,7 +307,7 @@ int clp_service_call(S390CPU *cpu, uint8_t r2, uintptr_t ra)
             stl_p(&resquery->bar[i], data);
             resquery->bar_size[i] = pbdev->pdev->io_regions[i].size ?
                                     ctz64(pbdev->pdev->io_regions[i].size) : 0;
-            DPRINTF("bar %d addr 0x%x size 0x%" PRIx64 "barsize 0x%x\n", i,
+            trace_s390_pci_bar(i,
                     ldl_p(&resquery->bar[i]),
                     pbdev->pdev->io_regions[i].size,
                     resquery->bar_size[i]);
@@ -351,7 +341,7 @@ int clp_service_call(S390CPU *cpu, uint8_t r2, uintptr_t ra)
         break;
     }
     default:
-        DPRINTF("unknown clp command\n");
+        trace_s390_pci_unknown("clp", lduw_p(&reqh->cmd));
         stw_p(&resh->rsp, CLP_RC_CMD);
         break;
     }
@@ -459,7 +449,7 @@ int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
 
     pbdev = s390_pci_find_dev_by_fh(s390_get_phb(), fh);
     if (!pbdev) {
-        DPRINTF("pcilg no pci dev\n");
+        trace_s390_pci_nodev("pcilg", fh);
         setcc(cpu, ZPCI_PCI_LS_INVAL_HANDLE);
         return 0;
     }
@@ -500,7 +490,7 @@ int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
         }
         break;
     default:
-        DPRINTF("pcilg invalid space\n");
+        trace_s390_pci_invalid("pcilg", fh);
         setcc(cpu, ZPCI_PCI_LS_ERR);
         s390_set_status_code(env, r2, ZPCI_PCI_ST_INVAL_AS);
         return 0;
@@ -559,7 +549,7 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
 
     pbdev = s390_pci_find_dev_by_fh(s390_get_phb(), fh);
     if (!pbdev) {
-        DPRINTF("pcistg no pci dev\n");
+        trace_s390_pci_nodev("pcistg", fh);
         setcc(cpu, ZPCI_PCI_LS_INVAL_HANDLE);
         return 0;
     }
@@ -608,7 +598,7 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
                                      data, len);
         break;
     default:
-        DPRINTF("pcistg invalid space\n");
+        trace_s390_pci_invalid("pcistg", fh);
         setcc(cpu, ZPCI_PCI_LS_ERR);
         s390_set_status_code(env, r2, ZPCI_PCI_ST_INVAL_AS);
         return 0;
@@ -729,7 +719,7 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
 
     pbdev = s390_pci_find_dev_by_fh(s390_get_phb(), fh);
     if (!pbdev) {
-        DPRINTF("rpcit no pci dev\n");
+        trace_s390_pci_nodev("rpcit", fh);
         setcc(cpu, ZPCI_PCI_LS_INVAL_HANDLE);
         return 0;
     }
@@ -863,7 +853,7 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r1, uint8_t r3, uint64_t gaddr,
 
     pbdev = s390_pci_find_dev_by_fh(s390_get_phb(), fh);
     if (!pbdev) {
-        DPRINTF("pcistb no pci dev fh 0x%x\n", fh);
+        trace_s390_pci_nodev("pcistb", fh);
         setcc(cpu, ZPCI_PCI_LS_INVAL_HANDLE);
         return 0;
     }
@@ -879,7 +869,7 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r1, uint8_t r3, uint64_t gaddr,
     }
 
     if (pcias > ZPCI_IO_BAR_MAX) {
-        DPRINTF("pcistb invalid space\n");
+        trace_s390_pci_invalid("pcistb", fh);
         setcc(cpu, ZPCI_PCI_LS_ERR);
         s390_set_status_code(env, r1, ZPCI_PCI_ST_INVAL_AS);
         return 0;
@@ -971,7 +961,7 @@ static int reg_irqs(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib)
     pbdev->noi = FIB_DATA_NOI(ldl_p(&fib.data));
     pbdev->sum = FIB_DATA_SUM(ldl_p(&fib.data));
 
-    DPRINTF("reg_irqs adapter id %d\n", pbdev->routes.adapter.adapter_id);
+    trace_s390_pci_irqs("register", pbdev->routes.adapter.adapter_id);
     return 0;
 out:
     release_indicator(&pbdev->routes.adapter, pbdev->summary_ind);
@@ -996,7 +986,7 @@ int pci_dereg_irqs(S390PCIBusDevice *pbdev)
     pbdev->noi = 0;
     pbdev->sum = 0;
 
-    DPRINTF("dereg_irqs adapter id %d\n", pbdev->routes.adapter.adapter_id);
+    trace_s390_pci_irqs("unregister", pbdev->routes.adapter.adapter_id);
     return 0;
 }
 
@@ -1139,7 +1129,7 @@ static int mpcifc_reg_int_interp(S390PCIBusDevice *pbdev, ZpciFib *fib)
 
     rc = s390_pci_kvm_aif_enable(pbdev, fib, pbdev->forwarding_assist);
     if (rc) {
-        DPRINTF("Failed to enable interrupt forwarding\n");
+        trace_s390_pci_kvm_aif("enable");
         return rc;
     }
 
@@ -1152,7 +1142,7 @@ static int mpcifc_dereg_int_interp(S390PCIBusDevice *pbdev, ZpciFib *fib)
 
     rc = s390_pci_kvm_aif_disable(pbdev);
     if (rc) {
-        DPRINTF("Failed to disable interrupt forwarding\n");
+        trace_s390_pci_kvm_aif("disable");
         return rc;
     }
 
@@ -1185,7 +1175,7 @@ int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
 
     pbdev = s390_pci_find_dev_by_fh(s390_get_phb(), fh);
     if (!pbdev) {
-        DPRINTF("mpcifc no pci dev fh 0x%x\n", fh);
+        trace_s390_pci_nodev("mpcifc", fh);
         setcc(cpu, ZPCI_PCI_LS_INVAL_HANDLE);
         return 0;
     }
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index a9e5880349..c47a4a2c13 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -52,16 +52,6 @@
 #include "hw/s390x/s390-virtio-hcall.h"
 #include "target/s390x/kvm/pv.h"
 
-#ifndef DEBUG_KVM
-#define DEBUG_KVM  0
-#endif
-
-#define DPRINTF(fmt, ...) do {                \
-    if (DEBUG_KVM) {                          \
-        fprintf(stderr, fmt, ## __VA_ARGS__); \
-    }                                         \
-} while (0)
-
 #define kvm_vm_check_mem_attr(s, attr) \
     kvm_vm_check_attr(s, KVM_S390_VM_MEM_CTRL, attr)
 
@@ -912,11 +902,11 @@ static void determine_sw_breakpoint_instr(void)
         if (kvm_vm_enable_cap(kvm_state, KVM_CAP_S390_USER_INSTR0, 0)) {
             sw_bp_inst = diag_501;
             sw_bp_ilen = sizeof(diag_501);
-            DPRINTF("KVM: will use 4-byte sw breakpoints.\n");
+            trace_kvm_sw_breakpoint(4);
         } else {
             sw_bp_inst = instr_0x0000;
             sw_bp_ilen = sizeof(instr_0x0000);
-            DPRINTF("KVM: will use 2-byte sw breakpoints.\n");
+            trace_kvm_sw_breakpoint(2);
         }
 }
 
@@ -1307,7 +1297,7 @@ static int handle_b2(S390CPU *cpu, struct kvm_run *run, uint8_t ipa1)
         break;
     default:
         rc = -1;
-        DPRINTF("KVM: unhandled PRIV: 0xb2%x\n", ipa1);
+        trace_kvm_insn_unhandled_priv(ipa1);
         break;
     }
 
@@ -1487,7 +1477,7 @@ static int handle_b9(S390CPU *cpu, struct kvm_run *run, uint8_t ipa1)
         break;
     default:
         r = -1;
-        DPRINTF("KVM: unhandled PRIV: 0xb9%x\n", ipa1);
+        trace_kvm_insn_unhandled_priv(ipa1);
         break;
     }
 
@@ -1511,7 +1501,7 @@ static int handle_eb(S390CPU *cpu, struct kvm_run *run, uint8_t ipbl)
         break;
     default:
         r = -1;
-        DPRINTF("KVM: unhandled PRIV: 0xeb%x\n", ipbl);
+        trace_kvm_insn_unhandled_priv(ipbl);
         break;
     }
 
@@ -1531,7 +1521,7 @@ static int handle_e3(S390CPU *cpu, struct kvm_run *run, uint8_t ipbl)
         break;
     default:
         r = -1;
-        DPRINTF("KVM: unhandled PRIV: 0xe3%x\n", ipbl);
+        trace_kvm_insn_unhandled_priv(ipbl);
         break;
     }
 
@@ -1654,7 +1644,7 @@ static int handle_diag(S390CPU *cpu, struct kvm_run *run, uint32_t ipb)
         r = handle_sw_breakpoint(cpu, run);
         break;
     default:
-        DPRINTF("KVM: unknown DIAG: 0x%x\n", func_code);
+        trace_kvm_insn_diag(func_code);
         kvm_s390_program_interrupt(cpu, PGM_SPECIFICATION);
         break;
     }
@@ -1684,8 +1674,7 @@ static int handle_instruction(S390CPU *cpu, struct kvm_run *run)
     uint8_t ipa1 = run->s390_sieic.ipa & 0x00ff;
     int r = -1;
 
-    DPRINTF("handle_instruction 0x%x 0x%x\n",
-            run->s390_sieic.ipa, run->s390_sieic.ipb);
+    trace_kvm_insn(run->s390_sieic.ipa, run->s390_sieic.ipb);
     switch (ipa0) {
     case IPA0_B2:
         r = handle_b2(cpu, run, ipa1);
@@ -1765,7 +1754,7 @@ static int handle_intercept(S390CPU *cpu)
     int icpt_code = run->s390_sieic.icptcode;
     int r = 0;
 
-    DPRINTF("intercept: 0x%x (at 0x%lx)\n", icpt_code, (long)run->psw_addr);
+    trace_kvm_intercept(icpt_code, (long)run->psw_addr);
     switch (icpt_code) {
         case ICPT_INSTRUCTION:
         case ICPT_PV_INSTR:
@@ -2150,13 +2139,13 @@ int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
     uint32_t vec = data & ZPCI_MSI_VEC_MASK;
 
     if (!dev) {
-        DPRINTF("add_msi_route no pci device\n");
+        trace_kvm_msi_route_fixup("no pci device");
         return -ENODEV;
     }
 
     pbdev = s390_pci_find_dev_by_target(s390_get_phb(), DEVICE(dev)->id);
     if (!pbdev) {
-        DPRINTF("add_msi_route no zpci device\n");
+        trace_kvm_msi_route_fixup("no zpci device");
         return -ENODEV;
     }
 
diff --git a/hw/s390x/trace-events b/hw/s390x/trace-events
index 8b9213eab9..34da5ea323 100644
--- a/hw/s390x/trace-events
+++ b/hw/s390x/trace-events
@@ -19,3 +19,20 @@ virtio_ccw_set_ind(uint64_t ind_loc, uint8_t ind_old, uint8_t ind_new) "VIRTIO-C
 s390_pci_clp_cap(const char *id, uint32_t cap) "PCI: %s: missing expected CLP capability %u"
 s390_pci_clp_cap_size(const char *id, uint32_t size, uint32_t cap) "PCI: %s: bad size (%u) for CLP capability %u"
 s390_pci_clp_dev_info(const char *id) "PCI: %s: cannot read vfio device info"
+
+# s390-pci-bus.c
+s390_pci_sclp_nodev(const char *str, uint32_t aid) "%s no dev found aid 0x%x"
+s390_pci_iommu_xlate(uint64_t addr) "iommu trans addr 0x%" PRIx64
+s390_pci_msi_ctrl_write(uint64_t data, uint32_t idx, uint32_t vec) "write_msix data 0x%" PRIx64 " idx %d vec 0x%x"
+s390_pcihost(const char *msg) "%s"
+
+# s390-pci-inst.c
+s390_pci_irqs(const char *str, uint32_t id) "%s irqs for adapter id %d"
+s390_pci_kvm_aif(const char *str) "Failed to %s interrupt forwarding"
+
+s390_pci_list_entry(uint32_t g_l2, uint32_t vid, uint32_t did, uint32_t fid, uint32_t fh) "g_l2 %d vendor id 0x%x device id 0x%x fid 0x%x fh 0x%x"
+s390_pci_list(uint32_t rc) "failed rc 0x%x"
+s390_pci_unknown(const char *msg, uint32_t cmd) "%s unknown command 0x%x"
+s390_pci_bar(uint32_t bar, uint32_t addr, uint64_t size, uint32_t barsize) "bar %d addr 0x%x size 0x%" PRIx64 "barsize 0x%x"
+s390_pci_nodev(const char *cmd, uint32_t fh) "%s no pci dev fh 0x%x"
+s390_pci_invalid(const char *cmd, uint32_t fh) "%s invalid space fh 0x%x"
diff --git a/target/s390x/kvm/trace-events b/target/s390x/kvm/trace-events
index 5289f5f675..818f1a37a1 100644
--- a/target/s390x/kvm/trace-events
+++ b/target/s390x/kvm/trace-events
@@ -5,3 +5,10 @@ kvm_enable_cmma(int rc) "CMMA: enabling with result code %d"
 kvm_clear_cmma(int rc) "CMMA: clearing with result code %d"
 kvm_failed_cpu_state_set(int cpu_index, uint8_t state, const char *msg) "Warning: Unable to set cpu %d state %" PRIu8 " to KVM: %s"
 kvm_assign_subch_ioeventfd(int fd, uint32_t addr, bool assign, int datamatch) "fd: %d sch: @0x%x assign: %d vq: %d"
+
+kvm_sw_breakpoint(uint32_t n) "KVM: will use %d-byte sw breakpoints"
+kvm_insn_unhandled_priv(uint32_t x) "KVM: unhandled PRIV: 0x%x"
+kvm_insn_diag(uint32_t x) "KVM: unknown DIAG: 0x%x"
+kvm_insn(uint32_t ipa, uint32_t ipb) "handle_instruction 0x%x 0x%x"
+kvm_intercept(uint32_t icpt_code, uint64_t psw_addr) "intercept: 0x%x (at 0x%"PRIx64"lx)"
+kvm_msi_route_fixup(const char* msg) "%s"
-- 
2.39.3


