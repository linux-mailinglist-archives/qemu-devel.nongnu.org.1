Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E5E73ABD6
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 23:51:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCSBK-0003BU-Uk; Thu, 22 Jun 2023 17:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qCSBH-0003B6-Ti
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 17:49:31 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qCSBG-0007Qq-6u
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 17:49:31 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35MLWLTu007802; Thu, 22 Jun 2023 21:49:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=Im49a6fnTBbEY5Y0/C6Ivtgf1RhF+kCnOMpymBmRJlE=;
 b=MAUaOIR+o5opwNxPYHwqb37yf3TJVL99P/TEDX0qHSY1MUOrG29zmnzdI7QTPgDLjHaL
 CiwahljE8r0573CHvQ6NjexSO45eHXdiaN3q0N+dbJERXJbQvKcu0IrUxqLIsU9X8Cc9
 AX9qo6R/D56BgU1bXLoZZMXZidcplvxmZfNvdKoLwzlPCnVgo1z2J5KN0U3plnDUHcx/
 HfYrEpnf51oheOFzQVTOUhap6y5cjbNa2Uf91mCtJNvIJolzz2KQA3+ahxfjifZQ4wVb
 OfPxN/FMwy4a/R2+MsxCcIQ/3AMbD042GHiKaLYFku7B+QhDoaY7Fqks0KVjeB92FFhH eA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r938dtt09-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Jun 2023 21:49:25 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35MLYusj008585; Thu, 22 Jun 2023 21:49:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3r9398epb2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Jun 2023 21:49:24 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35MLn76q035791;
 Thu, 22 Jun 2023 21:49:23 GMT
Received: from joaomart-mac.uk.oracle.com (dhcp-10-175-180-251.vpn.oracle.com
 [10.175.180.251])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3r9398ep1g-4; Thu, 22 Jun 2023 21:49:22 +0000
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
Subject: [PATCH v4 03/15] hw/pci: Introduce pci_device_iommu_get_attr()
Date: Thu, 22 Jun 2023 22:48:33 +0100
Message-Id: <20230622214845.3980-4-joao.m.martins@oracle.com>
In-Reply-To: <20230622214845.3980-1-joao.m.martins@oracle.com>
References: <20230622214845.3980-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_16,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306220186
X-Proofpoint-GUID: Yu3OEggms4HqIgAQIioV4Yl6XoBIWb5a
X-Proofpoint-ORIG-GUID: Yu3OEggms4HqIgAQIioV4Yl6XoBIWb5a
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

Introduce pci_device_iommu_get_attr() to get vIOMMU attributes
from the PCI device.

This is in preparation to ask if vIOMMU has dma translation enabled
and also to get IOVA boundaries.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
[joao: Massage commit message; add one more argument in
 pci_device_get_iommu_bus_devfn(); rename to pci_device_iommu_get_attr()
 to align with the other already namespaced function. ]
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
follow-up version from:
https://lore.kernel.org/all/20210302203827.437645-6-yi.l.liu@intel.com/
---
 include/hw/pci/pci.h |  4 ++++
 hw/pci/pci.c         | 16 ++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index f59aef5a329a..10c81287b6b3 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -372,8 +372,12 @@ typedef struct PCIIOMMUOps PCIIOMMUOps;
 struct PCIIOMMUOps {
     AddressSpace * (*get_address_space)(PCIBus *bus,
                                 void *opaque, int32_t devfn);
+    int (*get_iommu_attr)(PCIBus *bus, void *opaque, int32_t devfn,
+                          enum IOMMUMemoryRegionAttr attr, void *data);
 };
 void pci_setup_iommu_ops(PCIBus *bus, const PCIIOMMUOps *iommu_ops, void *opaque);
+int pci_device_iommu_get_attr(PCIDevice *dev, enum IOMMUMemoryRegionAttr attr,
+                              void *data);
 
 pcibus_t pci_bar_address(PCIDevice *d,
                          int reg, uint8_t type, pcibus_t size);
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 90ae92a43d85..91ba6f0927a4 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2710,6 +2710,22 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
     return &address_space_memory;
 }
 
+int pci_device_iommu_get_attr(PCIDevice *dev, enum IOMMUMemoryRegionAttr attr,
+                              void *data)
+{
+    PCIBus *bus, *iommu_bus;
+    uint8_t devfn;
+
+    pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus, &devfn);
+    if (!pci_bus_bypass_iommu(bus) && iommu_bus &&
+        iommu_bus->iommu_ops && iommu_bus->iommu_ops->get_iommu_attr) {
+        return iommu_bus->iommu_ops->get_iommu_attr(bus, iommu_bus->iommu_opaque,
+                                                    devfn, attr, data);
+    }
+
+    return -ENOENT;
+}
+
 void pci_setup_iommu(PCIBus *bus, PCIIOMMUFunc fn, void *opaque)
 {
     bus->iommu_fn = fn;
-- 
2.17.2


