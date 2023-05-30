Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 361A6716BC3
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 20:00:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q43dz-0008Rv-7N; Tue, 30 May 2023 14:00:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q43dv-0008JH-Ce
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:00:23 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q43dt-0002R4-Bn
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:00:22 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34UE4i2V021684; Tue, 30 May 2023 18:00:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=ahvtNwQMdZfZKC1RYnrq2f+vHhBjZIejmeLgkq1wK6A=;
 b=B2fTCUwHiGWd32xMwKEDd5Mh0bG3fHkK8bzwhXWDv0VB86mGwsG6+cB2cP4boaooVScd
 R3nDF7P6+caScFzIEnM6VmF0ULR1xtICI33B5Mf5HjssOwqqraDs0xnYNj6suB6axiE5
 PznSSrpf0QkeVg2zadCaMp+SqJxIz4U3Ry0nx3NTq9TcBefRBqE8dhv57N/NWSo7X2TU
 MkmxycABtJrtujnWFPM9A86p9ygMQZ8r+D3Lz3QZrjeyEr8OnlUOArac/bSwzVCDMUkL
 W3xmSZbibhaJB0+4YlU4jKpz3sDElT8Ez8fcAkl7t/r2qFtGCpIx9C0IGOJfiSpkEk7T Gw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhjh3eht-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 May 2023 18:00:17 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34UH0NUb014665; Tue, 30 May 2023 18:00:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3qu8a48tm0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 May 2023 18:00:16 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34UHxspL011459;
 Tue, 30 May 2023 18:00:16 GMT
Received: from joaomart-mac.uk.oracle.com (dhcp-10-175-191-61.vpn.oracle.com
 [10.175.191.61])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3qu8a48srr-6; Tue, 30 May 2023 18:00:15 +0000
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
Subject: [PATCH v3 05/15] vfio/common: Track the IOMMU MR behind the device in
 addition to the AS
Date: Tue, 30 May 2023 18:59:27 +0100
Message-Id: <20230530175937.24202-6-joao.m.martins@oracle.com>
In-Reply-To: <20230530175937.24202-1-joao.m.martins@oracle.com>
References: <20230530175937.24202-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_13,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxlogscore=711 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305300144
X-Proofpoint-GUID: jeH73bkJz02jIbUYlnTfzdRP7TlNk9V7
X-Proofpoint-ORIG-GUID: jeH73bkJz02jIbUYlnTfzdRP7TlNk9V7
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

vfio_get_group() allocates and fills the group/container/space on
success which will store the AddressSpace inside the VFIOSpace struct.
Use the newly added pci_device_iommu_memory_region() and store the IOMMU
MR too.

Today, this means only intel-iommu sets it.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 hw/vfio/pci.c                 | 4 ++++
 include/hw/vfio/vfio-common.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 73874a94de12..9dc9a7d834ec 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2900,6 +2900,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     VFIOPCIDevice *vdev = VFIO_PCI(pdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
     VFIODevice *vbasedev_iter;
+    VFIOAddressSpace *space;
     VFIOGroup *group;
     char *tmp, *subsys, group_path[PATH_MAX], *group_name;
     Error *err = NULL;
@@ -2961,6 +2962,9 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         goto error;
     }
 
+    space = group->container->space;
+    space->iommu_mr = pci_device_iommu_memory_region(pdev);
+
     QLIST_FOREACH(vbasedev_iter, &group->device_list, next) {
         if (strcmp(vbasedev_iter->name, vbasedev->name) == 0) {
             error_setg(errp, "device is already attached");
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index eed244f25f34..92e6514fd757 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -70,6 +70,7 @@ typedef struct VFIOMigration {
 
 typedef struct VFIOAddressSpace {
     AddressSpace *as;
+    IOMMUMemoryRegion *iommu_mr;
     QLIST_HEAD(, VFIOContainer) containers;
     QLIST_ENTRY(VFIOAddressSpace) list;
 } VFIOAddressSpace;
-- 
2.39.3


