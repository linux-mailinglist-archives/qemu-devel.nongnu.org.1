Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0482476FB9F
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 10:05:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRpnX-00056v-QK; Fri, 04 Aug 2023 04:04:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=QLN+=DV=redhat.com=clg@ozlabs.org>)
 id 1qRpnV-0004y8-PL; Fri, 04 Aug 2023 04:04:33 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=QLN+=DV=redhat.com=clg@ozlabs.org>)
 id 1qRpnS-0000fa-U4; Fri, 04 Aug 2023 04:04:33 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RHJC861kMz4wy5;
 Fri,  4 Aug 2023 18:04:20 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RHJC62cz3z4wxy;
 Fri,  4 Aug 2023 18:04:18 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-8.2] s390x: Convert DPRINTF to trace events
Date: Fri,  4 Aug 2023 10:04:15 +0200
Message-ID: <20230804080415.56852-1-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=QLN+=DV=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Output message are slightly modified to ease selection with wildcards
and to report extra parameters.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/s390x/s390-pci-bus.c       | 25 ++++++------------
 hw/s390x/s390-pci-inst.c      | 48 ++++++++++++++---------------------
 target/s390x/kvm/kvm.c        | 33 ++++++++----------------
 hw/s390x/trace-events         | 17 +++++++++++++
 target/s390x/kvm/trace-events |  7 +++++
 5 files changed, 62 insertions(+), 68 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 02751f35971a874b81113b1dc607e6af691c630b..2ca36f9f3be11866b6c9cb83a61da01d93a4b7c0 100644
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
index 8f84ac6251c478eb8ca9b48925db557ba83db940..30149546c0838e420fde3dda2d5b0f6dac9a7267 100644
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
index cfb96417bdea478c45252708b0f33cc9291a062e..5323a544cbe7a84f9556b483c3ecb90e670170ae 100644
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
 
@@ -914,11 +904,11 @@ static void determine_sw_breakpoint_instr(void)
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
 
@@ -1309,7 +1299,7 @@ static int handle_b2(S390CPU *cpu, struct kvm_run *run, uint8_t ipa1)
         break;
     default:
         rc = -1;
-        DPRINTF("KVM: unhandled PRIV: 0xb2%x\n", ipa1);
+        trace_kvm_insn_unhandled_priv(ipa1);
         break;
     }
 
@@ -1499,7 +1489,7 @@ static int handle_b9(S390CPU *cpu, struct kvm_run *run, uint8_t ipa1)
         break;
     default:
         r = -1;
-        DPRINTF("KVM: unhandled PRIV: 0xb9%x\n", ipa1);
+        trace_kvm_insn_unhandled_priv(ipa1);
         break;
     }
 
@@ -1523,7 +1513,7 @@ static int handle_eb(S390CPU *cpu, struct kvm_run *run, uint8_t ipbl)
         break;
     default:
         r = -1;
-        DPRINTF("KVM: unhandled PRIV: 0xeb%x\n", ipbl);
+        trace_kvm_insn_unhandled_priv(ipbl);
         break;
     }
 
@@ -1543,7 +1533,7 @@ static int handle_e3(S390CPU *cpu, struct kvm_run *run, uint8_t ipbl)
         break;
     default:
         r = -1;
-        DPRINTF("KVM: unhandled PRIV: 0xe3%x\n", ipbl);
+        trace_kvm_insn_unhandled_priv(ipbl);
         break;
     }
 
@@ -1666,7 +1656,7 @@ static int handle_diag(S390CPU *cpu, struct kvm_run *run, uint32_t ipb)
         r = handle_sw_breakpoint(cpu, run);
         break;
     default:
-        DPRINTF("KVM: unknown DIAG: 0x%x\n", func_code);
+        trace_kvm_insn_diag(func_code);
         kvm_s390_program_interrupt(cpu, PGM_SPECIFICATION);
         break;
     }
@@ -1696,8 +1686,7 @@ static int handle_instruction(S390CPU *cpu, struct kvm_run *run)
     uint8_t ipa1 = run->s390_sieic.ipa & 0x00ff;
     int r = -1;
 
-    DPRINTF("handle_instruction 0x%x 0x%x\n",
-            run->s390_sieic.ipa, run->s390_sieic.ipb);
+    trace_kvm_insn(run->s390_sieic.ipa, run->s390_sieic.ipb);
     switch (ipa0) {
     case IPA0_B2:
         r = handle_b2(cpu, run, ipa1);
@@ -1777,7 +1766,7 @@ static int handle_intercept(S390CPU *cpu)
     int icpt_code = run->s390_sieic.icptcode;
     int r = 0;
 
-    DPRINTF("intercept: 0x%x (at 0x%lx)\n", icpt_code, (long)run->psw_addr);
+    trace_kvm_intercept(icpt_code, (long)run->psw_addr);
     switch (icpt_code) {
         case ICPT_INSTRUCTION:
         case ICPT_PV_INSTR:
@@ -2165,13 +2154,13 @@ int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
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
index 8b9213eab90c31d1eb37816d350bf76e902ccd10..34da5ea3230a0ac82f72a4d7a2aee047194be493 100644
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
index 5289f5f6750e763c2e84f4d1626f70901a93d0ff..818f1a37a1525707ed0f61179ff03acb23fdf22c 100644
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
2.41.0


