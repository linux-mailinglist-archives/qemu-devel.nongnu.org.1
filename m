Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C885973ABCD
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 23:50:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCSBC-0003AH-4x; Thu, 22 Jun 2023 17:49:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qCSB7-00039a-Ur
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 17:49:22 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qCSB5-0007PY-PQ
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 17:49:21 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35MK25oo019495; Thu, 22 Jun 2023 21:49:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=KGe7u2IMV2l3K8bxEpI70HCAGNDFcdBWxbYQ0h4LJYw=;
 b=VsOMb8BMhOQs9bZXLYXRQX5B0QdzcYhYol9MEc2wavnqi33EJ+E1BuGYoTpXqAx0HNLw
 ibwOoRqJTYyfwrj5t/Ve0GVzFXDVd19TEYg2HDmwdbR4i0sjtIbKnaRN0Gzxa+uGLazr
 qrvA4PFPD6ItlJx58YybQq2k1h4aESlSF/UMgutWI8bjYYDkN1JNCTm54DCCkgoF0yMj
 IRW11lVFcmLTB1o9kt81igW8uKR68KHWAvD7LwLX42g66lMGY70xQQ4zs/HMcThUn3Fa
 fx54j3GmbUHHeSOvcue+ijJI9I1mlGL05rdhHqyLytQ0OOQqT7VP23DaSsofNEmaTCiG oA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r938dtt02-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Jun 2023 21:49:15 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35MKiP1g008398; Thu, 22 Jun 2023 21:49:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3r9398ep6y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Jun 2023 21:49:14 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35MLn76m035791;
 Thu, 22 Jun 2023 21:49:14 GMT
Received: from joaomart-mac.uk.oracle.com (dhcp-10-175-180-251.vpn.oracle.com
 [10.175.180.251])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3r9398ep1g-2; Thu, 22 Jun 2023 21:49:11 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Avihai Horon <avihaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v4 01/15] hw/pci: Add a pci_setup_iommu_ops() helper
Date: Thu, 22 Jun 2023 22:48:31 +0100
Message-Id: <20230622214845.3980-2-joao.m.martins@oracle.com>
In-Reply-To: <20230622214845.3980-1-joao.m.martins@oracle.com>
References: <20230622214845.3980-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_16,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=862
 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306220186
X-Proofpoint-GUID: jnafCakYlNaiLi0NhGgJH6_NQ6hWRtQ9
X-Proofpoint-ORIG-GUID: jnafCakYlNaiLi0NhGgJH6_NQ6hWRtQ9
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Yi Liu <yi.l.liu@intel.com>

Add a pci_setup_iommu_ops() that uses a newly added structure
(PCIIOMMUOps) instead of using PCIIOMMUFunc. The old pci_setup_iommu()
that uses PCIIOMMUFunc is still kept for other IOMMUs to get an
an address space for a PCI device in vendor specific way.

In preparation to expand to supplying vIOMMU attributes, add a
alternate helper pci_setup_iommu_ops() to setup the PCI device IOMMU.
For now the PCIIOMMUOps just defines the address_space, but it will
be extended to have another callback.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
[joao: Massage commit message and subject, and make it a complementary
rather than changing every single consumer of pci_setup_iommu()]
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
v1: https://lore.kernel.org/all/20210302203827.437645-5-yi.l.liu@intel.com/
---
 include/hw/pci/pci.h     |  7 +++++++
 include/hw/pci/pci_bus.h |  1 +
 hw/pci/pci.c             | 26 +++++++++++++++++++++++---
 3 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index e6d0574a2999..f59aef5a329a 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -368,6 +368,13 @@ typedef AddressSpace *(*PCIIOMMUFunc)(PCIBus *, void *, int);
 AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
 void pci_setup_iommu(PCIBus *bus, PCIIOMMUFunc fn, void *opaque);
 
+typedef struct PCIIOMMUOps PCIIOMMUOps;
+struct PCIIOMMUOps {
+    AddressSpace * (*get_address_space)(PCIBus *bus,
+                                void *opaque, int32_t devfn);
+};
+void pci_setup_iommu_ops(PCIBus *bus, const PCIIOMMUOps *iommu_ops, void *opaque);
+
 pcibus_t pci_bar_address(PCIDevice *d,
                          int reg, uint8_t type, pcibus_t size);
 
diff --git a/include/hw/pci/pci_bus.h b/include/hw/pci/pci_bus.h
index 56531759578f..fb770b236d69 100644
--- a/include/hw/pci/pci_bus.h
+++ b/include/hw/pci/pci_bus.h
@@ -35,6 +35,7 @@ struct PCIBus {
     enum PCIBusFlags flags;
     PCIIOMMUFunc iommu_fn;
     void *iommu_opaque;
+    const PCIIOMMUOps *iommu_ops;
     uint8_t devfn_min;
     uint32_t slot_reserved_mask;
     pci_set_irq_fn set_irq;
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index bf38905b7dc0..4e32c09e81d6 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2639,7 +2639,15 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
     PCIBus *iommu_bus = bus;
     uint8_t devfn = dev->devfn;
 
-    while (iommu_bus && !iommu_bus->iommu_fn && iommu_bus->parent_dev) {
+    /*
+     * get_address_space() callback is mandatory when iommu uses
+     * pci_setup_iommu_ops(), so needs to ensure its presence in
+     * the iommu_bus search.
+     */
+    while (iommu_bus &&
+           !(iommu_bus->iommu_fn ||
+            (iommu_bus->iommu_ops && iommu_bus->iommu_ops->get_address_space)) &&
+           iommu_bus->parent_dev) {
         PCIBus *parent_bus = pci_get_bus(iommu_bus->parent_dev);
 
         /*
@@ -2678,8 +2686,14 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
 
         iommu_bus = parent_bus;
     }
-    if (!pci_bus_bypass_iommu(bus) && iommu_bus && iommu_bus->iommu_fn) {
-        return iommu_bus->iommu_fn(bus, iommu_bus->iommu_opaque, devfn);
+    if (!pci_bus_bypass_iommu(bus) && iommu_bus) {
+        if (iommu_bus->iommu_fn) {
+           return iommu_bus->iommu_fn(bus, iommu_bus->iommu_opaque, devfn);
+        } else if (iommu_bus->iommu_ops &&
+                   iommu_bus->iommu_ops->get_address_space) {
+           return iommu_bus->iommu_ops->get_address_space(bus,
+                                           iommu_bus->iommu_opaque, devfn);
+        }
     }
     return &address_space_memory;
 }
@@ -2690,6 +2704,12 @@ void pci_setup_iommu(PCIBus *bus, PCIIOMMUFunc fn, void *opaque)
     bus->iommu_opaque = opaque;
 }
 
+void pci_setup_iommu_ops(PCIBus *bus, const PCIIOMMUOps *ops, void *opaque)
+{
+    bus->iommu_ops = ops;
+    bus->iommu_opaque = opaque;
+}
+
 static void pci_dev_get_w64(PCIBus *b, PCIDevice *dev, void *opaque)
 {
     Range *range = opaque;
-- 
2.17.2


