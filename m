Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AB9716BC4
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 20:00:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q43do-0008Cl-90; Tue, 30 May 2023 14:00:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q43dl-0008Bp-Cp
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:00:13 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q43dd-0002Bt-FU
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:00:13 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34UE4wGu017005; Tue, 30 May 2023 18:00:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=gL0CLVOm8SGnDZaw05UgGdYm3M9XJQzrTCLBW7+qBi0=;
 b=V65n4XPUr80R3rxZ/4Cmcx2fxEZ1NMyqXxSASzYQnGnavULEwhO9uH2id2XuZyAEtOaz
 nIorNuXV6NRjtnrzDuLjaerHD+p5M6/HZjoNhzcH/z2qvrKPFgNEwF5pLYvJYVGm3j3e
 R60308FHS6Gpr5gRPO07WIEqf39qyeWq+wFpi6e2NDJN8gFFIkDrG2XwYTWO+ZE913hX
 1IN5gLfYqos5Jxoyum6E4gXTwsiI33J6hgkfPaBc4UxRLQEMdoldMqtNSuOQ7PIPMDBn
 LkPDuz9GX37SOZsbNjhEwOKYZZo5F2+AOAZAIe1yX0rn2d4iBU3dsJh2OMeA1e/zAYOf eQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhjkketn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 May 2023 18:00:00 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34UHaGvd014712; Tue, 30 May 2023 17:59:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3qu8a48t12-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 May 2023 17:59:59 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34UHxspD011459;
 Tue, 30 May 2023 17:59:58 GMT
Received: from joaomart-mac.uk.oracle.com (dhcp-10-175-191-61.vpn.oracle.com
 [10.175.191.61])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3qu8a48srr-2; Tue, 30 May 2023 17:59:58 +0000
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
 Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v3 01/15] hw/pci: Refactor pci_device_iommu_address_space()
Date: Tue, 30 May 2023 18:59:23 +0100
Message-Id: <20230530175937.24202-2-joao.m.martins@oracle.com>
In-Reply-To: <20230530175937.24202-1-joao.m.martins@oracle.com>
References: <20230530175937.24202-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_13,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxlogscore=833 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305300144
X-Proofpoint-ORIG-GUID: qIc0ztAymb9v3Bgs5IgKvop2mUn3P9_g
X-Proofpoint-GUID: qIc0ztAymb9v3Bgs5IgKvop2mUn3P9_g
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
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

Rename pci_device_iommu_address_space() into pci_device_iommu_info().
In the new function return a new type PCIAddressSpace that encapsulates
the AddressSpace pointer that originally was returned.

The new type is added in preparation to expanding it to include the IOMMU
memory region as a new field, such that we are able to fetch attributes of
the vIOMMU e.g. at vfio migration setup.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 hw/pci/pci.c         |  9 ++++++---
 include/hw/pci/pci.h | 21 ++++++++++++++++++++-
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 1cc7c89036b5..ecf8a543aa77 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2633,11 +2633,12 @@ static void pci_device_class_base_init(ObjectClass *klass, void *data)
     }
 }
 
-AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
+PCIAddressSpace pci_device_iommu_info(PCIDevice *dev)
 {
     PCIBus *bus = pci_get_bus(dev);
     PCIBus *iommu_bus = bus;
     uint8_t devfn = dev->devfn;
+    AddressSpace *as = NULL;
 
     while (iommu_bus && !iommu_bus->iommu_fn && iommu_bus->parent_dev) {
         PCIBus *parent_bus = pci_get_bus(iommu_bus->parent_dev);
@@ -2678,10 +2679,12 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
 
         iommu_bus = parent_bus;
     }
+
+    as = &address_space_memory;
     if (!pci_bus_bypass_iommu(bus) && iommu_bus && iommu_bus->iommu_fn) {
-        return iommu_bus->iommu_fn(bus, iommu_bus->iommu_opaque, devfn);
+        as = iommu_bus->iommu_fn(bus, iommu_bus->iommu_opaque, devfn);
     }
-    return &address_space_memory;
+    return as_to_pci_as(as);
 }
 
 void pci_setup_iommu(PCIBus *bus, PCIIOMMUFunc fn, void *opaque)
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index e6d0574a2999..9ffaf47fe2ab 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -363,9 +363,28 @@ void pci_bus_get_w64_range(PCIBus *bus, Range *range);
 
 void pci_device_deassert_intx(PCIDevice *dev);
 
+typedef struct PCIAddressSpace {
+    AddressSpace *as;
+} PCIAddressSpace;
+
 typedef AddressSpace *(*PCIIOMMUFunc)(PCIBus *, void *, int);
+static inline PCIAddressSpace as_to_pci_as(AddressSpace *as)
+{
+    PCIAddressSpace ret = { .as = as };
+
+    return ret;
+}
+static inline AddressSpace *pci_as_to_as(PCIAddressSpace pci_as)
+{
+    return pci_as.as;
+}
+
+PCIAddressSpace pci_device_iommu_info(PCIDevice *dev);
+static inline AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
+{
+    return pci_as_to_as(pci_device_iommu_info(dev));
+}
 
-AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
 void pci_setup_iommu(PCIBus *bus, PCIIOMMUFunc fn, void *opaque);
 
 pcibus_t pci_bar_address(PCIDevice *d,
-- 
2.39.3


