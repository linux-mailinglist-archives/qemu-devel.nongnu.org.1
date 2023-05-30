Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAFE716BCF
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 20:01:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q43dr-0008DQ-Gx; Tue, 30 May 2023 14:00:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q43dm-0008Cb-MH
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:00:15 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q43dk-0002Np-Ti
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:00:14 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34UE4uZU016936; Tue, 30 May 2023 18:00:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=o7vdUV+u0swzyTnaTw7LEKypTHbSrpeAeS+oiO09Tbk=;
 b=vU7IFxS6X921/0jjfZlnMRx0+kAf+2tzSXwEQUsige8UFPBCk5kd7WaF+ur20uFRIwK+
 8YmY8nAEAoEVnDrVchGKR1jnBmpqnz0SoOmnW7yXXSzx+DK5fllu+T4vleRvpUhB17K8
 qT83kpoEgEFdN6aZekkvaLpBAtrS7BVD10iiN3Mitt5fB2t6nQUgWCMNl74AJnT5hLJf
 jIrrfA4xi2l9/jngR216cS6NmDs2zFN9NJbggDZiIvvNTWdYRnK0/Tmyt9ui2Ff1e3jY
 1AvXXuui7pXrFLcbEaEMt72av14ohAUJLSeVG6hRCqGXoVZ8QEkKN6UIM9ZxBSDtycMz 3w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhjkkety-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 May 2023 18:00:08 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34UHhRLC014722; Tue, 30 May 2023 18:00:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3qu8a48ta2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 May 2023 18:00:08 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34UHxspH011459;
 Tue, 30 May 2023 18:00:07 GMT
Received: from joaomart-mac.uk.oracle.com (dhcp-10-175-191-61.vpn.oracle.com
 [10.175.191.61])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3qu8a48srr-4; Tue, 30 May 2023 18:00:07 +0000
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
Subject: [PATCH v3 03/15] hw/pci: Add a pci_device_iommu_memory_region() helper
Date: Tue, 30 May 2023 18:59:25 +0100
Message-Id: <20230530175937.24202-4-joao.m.martins@oracle.com>
In-Reply-To: <20230530175937.24202-1-joao.m.martins@oracle.com>
References: <20230530175937.24202-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_13,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxlogscore=805 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305300144
X-Proofpoint-ORIG-GUID: WG0YZoTsWjfPjPbE2EPEWZSizjDXu93s
X-Proofpoint-GUID: WG0YZoTsWjfPjPbE2EPEWZSizjDXu93s
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

Today's VFIO model of understanding if an IOMMU is behind the PCIDevice
is to check whether the address space backing the device is memory or
not, which is done via pci_device_iommu_address_space(pdev).

On the other hand, the IOMMU MR is used for example to fetch attributes,
or when doing an vIOMMU map and figuring out if it's under the vIOMMU.
However, such object is only available today by the time the IOMMU map
notifier is called which depends on the guest doing a DMA map or not.
Thus there's no way to get access to the IOMMU memory region early i.e.
at vfio device initialization where we attest migration support and
impose LM blockers or not.

Much like pci_device_iommu_address_space() fetches the IOMMU AS, add a
pci_device_iommu_memory_region() which lets it return an the IOMMU MR
associated with it. The IOMMU MR is returned correctly for vIOMMUs using
pci_setup_iommu_info(). Note that today most vIOMMUs create the address
space and IOMMU MR at the same time, it's just mainly that there's API
to make the latter available.

This is in preparation for VFIO to track both the AS and IOMMU MR into
VFIOSpace without being tied to a map taking place by the guest. The
IOMMU MR will then provide access to upper layers about various IOMMU
attributes.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 include/hw/pci/pci.h | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index d2c87d87a24e..0177f50e96a3 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -365,13 +365,14 @@ void pci_device_deassert_intx(PCIDevice *dev);
 
 typedef struct PCIAddressSpace {
     AddressSpace *as;
+    IOMMUMemoryRegion *iommu_mr;
 } PCIAddressSpace;
 
 typedef AddressSpace *(*PCIIOMMUFunc)(PCIBus *, void *, int);
 typedef PCIAddressSpace (*PCIIOMMUASFunc)(PCIBus *, void *, int);
 static inline PCIAddressSpace as_to_pci_as(AddressSpace *as)
 {
-    PCIAddressSpace ret = { .as = as };
+    PCIAddressSpace ret = { .as = as, .iommu_mr = NULL };
 
     return ret;
 }
@@ -379,6 +380,13 @@ static inline AddressSpace *pci_as_to_as(PCIAddressSpace pci_as)
 {
     return pci_as.as;
 }
+static inline PCIAddressSpace to_pci_as(AddressSpace *as,
+                                        IOMMUMemoryRegion *iommu_mr)
+{
+    PCIAddressSpace ret = { .as = as, .iommu_mr = iommu_mr };
+
+    return ret;
+}
 
 PCIAddressSpace pci_device_iommu_info(PCIDevice *dev);
 static inline AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
@@ -386,6 +394,13 @@ static inline AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
     return pci_as_to_as(pci_device_iommu_info(dev));
 }
 
+static inline IOMMUMemoryRegion *pci_device_iommu_memory_region(PCIDevice *dev)
+{
+    PCIAddressSpace ret = pci_device_iommu_info(dev);
+
+    return ret.iommu_mr;
+}
+
 void pci_setup_iommu(PCIBus *bus, PCIIOMMUFunc fn, void *opaque);
 void pci_setup_iommu_info(PCIBus *bus, PCIIOMMUASFunc fn, void *opaque);
 
-- 
2.39.3


