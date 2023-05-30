Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA66716BD0
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 20:01:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q43dw-0008Hj-G3; Tue, 30 May 2023 14:00:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q43dr-0008Fc-P6
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:00:20 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q43do-0002PB-Vl
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:00:19 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34UE4umR016924; Tue, 30 May 2023 18:00:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=bNWd+8qg+HQMGADbnG4d7mUSP5zBAyGayHx2RMjErd0=;
 b=1JyV13rIqfN9b5y6yGfVSQP9UlWFJsylzEOXNOBF5KDeCNM+QvUvAdGL6jad2bggdohR
 vCE55p0sTSmnLAW7nxWU0JOcjLCArBmhn/MusJYFJ61Pc4yuYczsQR9nHpWjdFDyglUJ
 FpK0BZFlg8C4h3pKISs2h3iTmnUGHWH2GZyEJ8i88Pvlzi/b1QrSfP0m41W01k8hrJpu
 6ROJyMMXYtMpQSU1K6XywAK3jVx5BMku/jwe0Yc8CLy2q0IgoptToxCWYSlzE0/x81X8
 jIzAijYOa6Tm9978I1nlP7sEhm2io9qt/NxJ13AJQFEi/MvSBEKOL+p5F3OTOSz486HC Kg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhjkkeu1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 May 2023 18:00:13 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34UHfg4d014618; Tue, 30 May 2023 18:00:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3qu8a48teu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 May 2023 18:00:12 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34UHxspJ011459;
 Tue, 30 May 2023 18:00:11 GMT
Received: from joaomart-mac.uk.oracle.com (dhcp-10-175-191-61.vpn.oracle.com
 [10.175.191.61])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3qu8a48srr-5; Tue, 30 May 2023 18:00:11 +0000
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
Subject: [PATCH v3 04/15] intel-iommu: Switch to pci_setup_iommu_info()
Date: Tue, 30 May 2023 18:59:26 +0100
Message-Id: <20230530175937.24202-5-joao.m.martins@oracle.com>
In-Reply-To: <20230530175937.24202-1-joao.m.martins@oracle.com>
References: <20230530175937.24202-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_13,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305300144
X-Proofpoint-ORIG-GUID: Us0O5CmZc99Blx5peVHeh2uvs1EuJW8g
X-Proofpoint-GUID: Us0O5CmZc99Blx5peVHeh2uvs1EuJW8g
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

Use the PCI IOMMU setup function that allows returning the
IOMMUMemoryRegion in addition to the AddressSpace. To faciliate
conversion use the new to_pci_as()/pci_as_to_as() helpers.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 hw/i386/intel_iommu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 94d52f4205d2..c344d49fe290 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4021,7 +4021,7 @@ static void vtd_reset(DeviceState *dev)
     vtd_address_space_refresh_all(s);
 }
 
-static AddressSpace *vtd_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
+static PCIAddressSpace vtd_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
 {
     IntelIOMMUState *s = opaque;
     VTDAddressSpace *vtd_as;
@@ -4029,7 +4029,7 @@ static AddressSpace *vtd_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
     assert(0 <= devfn && devfn < PCI_DEVFN_MAX);
 
     vtd_as = vtd_find_add_as(s, bus, devfn, PCI_NO_PASID);
-    return &vtd_as->as;
+    return to_pci_as(&vtd_as->as, &vtd_as->iommu);
 }
 
 static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
@@ -4155,9 +4155,10 @@ static void vtd_realize(DeviceState *dev, Error **errp)
                                       g_free, g_free);
     vtd_init(s);
     sysbus_mmio_map(SYS_BUS_DEVICE(s), 0, Q35_HOST_BRIDGE_IOMMU_ADDR);
-    pci_setup_iommu(bus, vtd_host_dma_iommu, dev);
+    pci_setup_iommu_info(bus, vtd_host_dma_iommu, dev);
     /* Pseudo address space under root PCI bus. */
-    x86ms->ioapic_as = vtd_host_dma_iommu(bus, s, Q35_PSEUDO_DEVFN_IOAPIC);
+    x86ms->ioapic_as = pci_as_to_as(vtd_host_dma_iommu(bus,
+                                                s, Q35_PSEUDO_DEVFN_IOAPIC));
     qemu_add_machine_init_done_notifier(&vtd_machine_done_notify);
 }
 
-- 
2.39.3


