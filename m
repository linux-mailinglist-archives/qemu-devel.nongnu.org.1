Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE6AA1BD55
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Jan 2025 21:22:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbQBR-00060g-Qc; Fri, 24 Jan 2025 15:21:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1tbQBD-0005z7-9l; Fri, 24 Jan 2025 15:21:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1tbQBB-0007VR-A1; Fri, 24 Jan 2025 15:21:27 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OF1JQT017605;
 Fri, 24 Jan 2025 20:21:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=UiXuPFdhHHG9cCrhh
 qaZFsiQvkoLt05Wq1ZIcrlg2r8=; b=GqBGuyBnd+S0yJekLpT5afaqHsi6QcMqi
 2Aff4INY+Cm54SWDSGxntN3G0WyPERrTGexmzR/mQU5dibVXcfgjEA7PKlCJDZ78
 9TTAnl/bJrYQcbe3PDvGW7GMJIGq+OACzT3gaity8YAAwKHoWC+5o9XWlkmetcIB
 OqeQNryvAG1br4hNXYEdsqystpquT9KjUgaKOpu25mD7aEjOfcCCpBSep0RoZVY/
 7Q180zW5jIDBpN+VJvMAYD0IIHJzaeL6WeYUnqoUNlFLzP3cii/CTNGG4+w18NXO
 RGDe1oYknag01EkvnTOgur/0UZni0SixHVwZuelFrm6I9qwoVoljQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44cd4yhjsg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jan 2025 20:21:19 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50OIXO2H024252;
 Fri, 24 Jan 2025 20:21:18 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 448q0yne3m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jan 2025 20:21:18 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50OKLHLB33030742
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jan 2025 20:21:17 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3621858052;
 Fri, 24 Jan 2025 20:21:17 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 66EE558067;
 Fri, 24 Jan 2025 20:21:16 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown
 [9.61.77.196]) by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 Jan 2025 20:21:16 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, schnelle@linux.ibm.com, thuth@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 clegoate@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v3 1/2] s390x/pci: add support for guests that request direct
 mapping
Date: Fri, 24 Jan 2025 15:21:14 -0500
Message-ID: <20250124202115.349386-2-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250124202115.349386-1-mjrosato@linux.ibm.com>
References: <20250124202115.349386-1-mjrosato@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Sx8P8kry0f96Ej7-j7VNoLicGT-vs4ow
X-Proofpoint-ORIG-GUID: Sx8P8kry0f96Ej7-j7VNoLicGT-vs4ow
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_08,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501240137
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

When receiving a guest mpcifc(4) or mpcifc(6) instruction without the T
bit set, treat this as a request to perform direct mapping instead of
address translation.  In order to facilitate this, pin the entirety of
guest memory into the host iommu.

Pinning for the direct mapping case is handled via vfio and its memory
listener.  Additionally, ram discard settings are inherited from vfio:
coordinated discards (e.g. virtio-mem) are allowed while uncoordinated
discards (e.g. virtio-balloon) are disabled.

Subsequent guest DMA operations are all expected to be of the format
guest_phys+sdma, allowing them to be used as lookup into the host
iommu table.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c         | 36 +++++++++++++++++++++++++++++++--
 hw/s390x/s390-pci-inst.c        | 13 ++++++++++--
 hw/s390x/s390-pci-vfio.c        | 15 ++++++++++----
 hw/s390x/s390-virtio-ccw.c      |  5 +++++
 include/hw/s390x/s390-pci-bus.h |  4 ++++
 5 files changed, 65 insertions(+), 8 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index eead269cc2..8cf5aec1a2 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -18,6 +18,8 @@
 #include "hw/s390x/s390-pci-inst.h"
 #include "hw/s390x/s390-pci-kvm.h"
 #include "hw/s390x/s390-pci-vfio.h"
+#include "hw/s390x/s390-virtio-ccw.h"
+#include "hw/boards.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/qdev-properties.h"
 #include "hw/pci/pci_bridge.h"
@@ -720,16 +722,44 @@ void s390_pci_iommu_enable(S390PCIIOMMU *iommu)
                              TYPE_S390_IOMMU_MEMORY_REGION, OBJECT(&iommu->mr),
                              name, iommu->pal + 1);
     iommu->enabled = true;
+    iommu->direct_map = false;
     memory_region_add_subregion(&iommu->mr, 0, MEMORY_REGION(&iommu->iommu_mr));
     g_free(name);
 }
 
+void s390_pci_iommu_dm_enable(S390PCIIOMMU *iommu)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+    S390CcwMachineState *s390ms = S390_CCW_MACHINE(ms);
+
+    /*
+     * For direct-mapping we must map the entire guest address space.  Rather
+     * than using an iommu, create a memory region alias that maps GPA X to
+     * iova X + SDMA.  VFIO will handle pinning via its memory listener.
+     */
+    g_autofree char *name = g_strdup_printf("iommu-dm-s390-%04x",
+                                            iommu->pbdev->uid);
+    memory_region_init_alias(&iommu->dm_mr, OBJECT(&iommu->mr), name, ms->ram,
+                             0, s390_get_memory_limit(s390ms));
+    iommu->enabled = true;
+    iommu->direct_map = true;
+    memory_region_add_subregion(&iommu->mr, iommu->pbdev->zpci_fn.sdma,
+                                &iommu->dm_mr);
+}
+
 void s390_pci_iommu_disable(S390PCIIOMMU *iommu)
 {
     iommu->enabled = false;
     g_hash_table_remove_all(iommu->iotlb);
-    memory_region_del_subregion(&iommu->mr, MEMORY_REGION(&iommu->iommu_mr));
-    object_unparent(OBJECT(&iommu->iommu_mr));
+    if (iommu->direct_map) {
+        memory_region_del_subregion(&iommu->mr, &iommu->dm_mr);
+        iommu->direct_map = false;
+        object_unparent(OBJECT(&iommu->dm_mr));
+    } else {
+        memory_region_del_subregion(&iommu->mr,
+                                    MEMORY_REGION(&iommu->iommu_mr));
+        object_unparent(OBJECT(&iommu->iommu_mr));
+    }
 }
 
 static void s390_pci_iommu_free(S390pciState *s, PCIBus *bus, int32_t devfn)
@@ -1488,6 +1518,8 @@ static const Property s390_pci_device_properties[] = {
     DEFINE_PROP_BOOL("interpret", S390PCIBusDevice, interp, true),
     DEFINE_PROP_BOOL("forwarding-assist", S390PCIBusDevice, forwarding_assist,
                      true),
+    DEFINE_PROP_BOOL("relaxed-translation", S390PCIBusDevice, rtr_allowed,
+                     true),
 };
 
 static const VMStateDescription s390_pci_device_vmstate = {
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index e386d75d58..4c108fa8c4 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -16,6 +16,7 @@
 #include "exec/memory.h"
 #include "qemu/error-report.h"
 #include "system/hw_accel.h"
+#include "hw/boards.h"
 #include "hw/pci/pci_device.h"
 #include "hw/s390x/s390-pci-inst.h"
 #include "hw/s390x/s390-pci-bus.h"
@@ -1008,17 +1009,25 @@ static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
     }
 
     /* currently we only support designation type 1 with translation */
-    if (!(dt == ZPCI_IOTA_RTTO && t)) {
+    if (t && !(dt == ZPCI_IOTA_RTTO)) {
         error_report("unsupported ioat dt %d t %d", dt, t);
         s390_program_interrupt(env, PGM_OPERAND, ra);
         return -EINVAL;
+    } else if (!t && !pbdev->rtr_allowed) {
+        error_report("relaxed translation not allowed");
+        s390_program_interrupt(env, PGM_OPERAND, ra);
+        return -EINVAL;
     }
 
     iommu->pba = pba;
     iommu->pal = pal;
     iommu->g_iota = g_iota;
 
-    s390_pci_iommu_enable(iommu);
+    if (t) {
+        s390_pci_iommu_enable(iommu);
+    } else {
+        s390_pci_iommu_dm_enable(iommu);
+    }
 
     return 0;
 }
diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
index 7dbbc76823..dad525c81c 100644
--- a/hw/s390x/s390-pci-vfio.c
+++ b/hw/s390x/s390-pci-vfio.c
@@ -133,11 +133,18 @@ static void s390_pci_read_base(S390PCIBusDevice *pbdev,
 
     /*
      * If appropriate, reduce the size of the supported DMA aperture reported
-     * to the guest based upon the vfio DMA limit.
+     * to the guest based upon the vfio DMA limit.  This is applicable for
+     * devices that are guaranteed to not use relaxed translation.  If the
+     * device is capable of relaxed translation then we must advertise the
+     * full aperture.  In this case, if translation is used then we will
+     * rely on the vfio DMA limit counting and use RPCIT CC1 / status 16
+     * to request the guest free DMA mappings when necessary.
      */
-    vfio_size = pbdev->iommu->max_dma_limit << TARGET_PAGE_BITS;
-    if (vfio_size > 0 && vfio_size < cap->end_dma - cap->start_dma + 1) {
-        pbdev->zpci_fn.edma = cap->start_dma + vfio_size - 1;
+    if (!pbdev->rtr_allowed) {
+        vfio_size = pbdev->iommu->max_dma_limit << TARGET_PAGE_BITS;
+        if (vfio_size > 0 && vfio_size < cap->end_dma - cap->start_dma + 1) {
+            pbdev->zpci_fn.edma = cap->start_dma + vfio_size - 1;
+        }
     }
 }
 
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 3af613d4e9..c96cd0d4bb 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -907,8 +907,13 @@ static void ccw_machine_9_2_instance_options(MachineState *machine)
 
 static void ccw_machine_9_2_class_options(MachineClass *mc)
 {
+    static GlobalProperty compat[] = {
+        { TYPE_S390_PCI_DEVICE, "relaxed-translation", "off", },
+    };
+
     ccw_machine_10_0_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_9_2, hw_compat_9_2_len);
+    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
 }
 DEFINE_CCW_MACHINE(9, 2);
 
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index 2c43ea123f..27732247cf 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -277,7 +277,9 @@ struct S390PCIIOMMU {
     AddressSpace as;
     MemoryRegion mr;
     IOMMUMemoryRegion iommu_mr;
+    MemoryRegion dm_mr;
     bool enabled;
+    bool direct_map;
     uint64_t g_iota;
     uint64_t pba;
     uint64_t pal;
@@ -362,6 +364,7 @@ struct S390PCIBusDevice {
     bool interp;
     bool forwarding_assist;
     bool aif;
+    bool rtr_allowed;
     QTAILQ_ENTRY(S390PCIBusDevice) link;
 };
 
@@ -389,6 +392,7 @@ int pci_chsc_sei_nt2_have_event(void);
 void s390_pci_sclp_configure(SCCB *sccb);
 void s390_pci_sclp_deconfigure(SCCB *sccb);
 void s390_pci_iommu_enable(S390PCIIOMMU *iommu);
+void s390_pci_iommu_dm_enable(S390PCIIOMMU *iommu);
 void s390_pci_iommu_disable(S390PCIIOMMU *iommu);
 void s390_pci_generate_error_event(uint16_t pec, uint32_t fh, uint32_t fid,
                                    uint64_t faddr, uint32_t e);
-- 
2.48.1


