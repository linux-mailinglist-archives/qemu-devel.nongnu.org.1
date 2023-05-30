Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F921716BC6
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 20:01:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q43dm-0008Bm-Cv; Tue, 30 May 2023 14:00:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q43dj-00089Z-IL
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:00:11 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q43dh-0002Mv-OX
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:00:11 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34UE4jsG021696; Tue, 30 May 2023 18:00:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=CXnIDx3G2VitmhWITlFxhYYmGCk6JD4I7r2Gk/ajJzo=;
 b=HXWcnb8TUJ5bjXkw66qrtHskjEvPtPCGvRh8VHJ52xvFibvwVsgWgo0hRZwEpVstyJCO
 14wBXWekaetL42Cg2Bp3fZ7iYAaZtyrfDJEr1SZTpO1hhOHixI0kfBGB/rfiqoe52+/S
 x8xBRIIgWuJwiyDEaLXX8zPmQMWu343wCLuHKrRhVbf13+lwF0XJ/jZsxkIitA64I4yq
 0lmiGKGH/HKXaJu8NXP6C5RctXVDG9eZQCSArFydRiHfpYB3aPLvFpmZZXCpBJE9WLCW
 Ngzleqa4uc6HMARTrtj0nFstWJgpRcVKLVSrdQ7vSZiUTA5bhZbwAohwN/PRBe2M5j+2 4w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhjh3ehj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 May 2023 18:00:04 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34UHcPx0014630; Tue, 30 May 2023 18:00:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3qu8a48t5c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 May 2023 18:00:03 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34UHxspF011459;
 Tue, 30 May 2023 18:00:03 GMT
Received: from joaomart-mac.uk.oracle.com (dhcp-10-175-191-61.vpn.oracle.com
 [10.175.191.61])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3qu8a48srr-3; Tue, 30 May 2023 18:00:02 +0000
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
Subject: [PATCH v3 02/15] hw/pci: Add a pci_setup_iommu_info() helper
Date: Tue, 30 May 2023 18:59:24 +0100
Message-Id: <20230530175937.24202-3-joao.m.martins@oracle.com>
In-Reply-To: <20230530175937.24202-1-joao.m.martins@oracle.com>
References: <20230530175937.24202-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_13,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxlogscore=940 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305300144
X-Proofpoint-GUID: 7Wsz83WunnVOsdentylhcdvxMJ4fdrSU
X-Proofpoint-ORIG-GUID: 7Wsz83WunnVOsdentylhcdvxMJ4fdrSU
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

Provide a second PCI iommu bus initialization function which returns
PCIAddressSpace rather than an AddressSpace. The function is meant to
superseed pci_setup_iommu().

Under the hood in pci_device_iommu_info() if the new function pointer is
set in the device bus, use that instead and return the new object.

This is preparation for vIOMMU MR to be stored in PCIAddressSpace, thus
made available regardless of guest behaviour.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 hw/pci/pci.c             | 14 ++++++++++++--
 include/hw/pci/pci.h     |  2 ++
 include/hw/pci/pci_bus.h |  1 +
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index ecf8a543aa77..ac10333b5097 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2681,8 +2681,12 @@ PCIAddressSpace pci_device_iommu_info(PCIDevice *dev)
     }
 
     as = &address_space_memory;
-    if (!pci_bus_bypass_iommu(bus) && iommu_bus && iommu_bus->iommu_fn) {
-        as = iommu_bus->iommu_fn(bus, iommu_bus->iommu_opaque, devfn);
+    if (!pci_bus_bypass_iommu(bus) && iommu_bus) {
+        if (iommu_bus->iommu_fn) {
+            as = iommu_bus->iommu_fn(bus, iommu_bus->iommu_opaque, devfn);
+        } else if (iommu_bus->iommu_as_fn) {
+            return iommu_bus->iommu_as_fn(bus, iommu_bus->iommu_opaque, devfn);
+        }
     }
     return as_to_pci_as(as);
 }
@@ -2693,6 +2697,12 @@ void pci_setup_iommu(PCIBus *bus, PCIIOMMUFunc fn, void *opaque)
     bus->iommu_opaque = opaque;
 }
 
+void pci_setup_iommu_info(PCIBus *bus, PCIIOMMUASFunc fn, void *opaque)
+{
+    bus->iommu_as_fn = fn;
+    bus->iommu_opaque = opaque;
+}
+
 static void pci_dev_get_w64(PCIBus *b, PCIDevice *dev, void *opaque)
 {
     Range *range = opaque;
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 9ffaf47fe2ab..d2c87d87a24e 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -368,6 +368,7 @@ typedef struct PCIAddressSpace {
 } PCIAddressSpace;
 
 typedef AddressSpace *(*PCIIOMMUFunc)(PCIBus *, void *, int);
+typedef PCIAddressSpace (*PCIIOMMUASFunc)(PCIBus *, void *, int);
 static inline PCIAddressSpace as_to_pci_as(AddressSpace *as)
 {
     PCIAddressSpace ret = { .as = as };
@@ -386,6 +387,7 @@ static inline AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
 }
 
 void pci_setup_iommu(PCIBus *bus, PCIIOMMUFunc fn, void *opaque);
+void pci_setup_iommu_info(PCIBus *bus, PCIIOMMUASFunc fn, void *opaque);
 
 pcibus_t pci_bar_address(PCIDevice *d,
                          int reg, uint8_t type, pcibus_t size);
diff --git a/include/hw/pci/pci_bus.h b/include/hw/pci/pci_bus.h
index 56531759578f..a2795b23a3b0 100644
--- a/include/hw/pci/pci_bus.h
+++ b/include/hw/pci/pci_bus.h
@@ -34,6 +34,7 @@ struct PCIBus {
     BusState qbus;
     enum PCIBusFlags flags;
     PCIIOMMUFunc iommu_fn;
+    PCIIOMMUASFunc iommu_as_fn;
     void *iommu_opaque;
     uint8_t devfn_min;
     uint32_t slot_reserved_mask;
-- 
2.39.3


