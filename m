Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FCE73ABD1
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 23:50:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCSBY-0003Ex-N7; Thu, 22 Jun 2023 17:49:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qCSBW-0003El-SW
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 17:49:46 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qCSBV-0007TY-6Z
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 17:49:46 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35MIbN5I031279; Thu, 22 Jun 2023 21:49:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=2XsM4/X8GgWe6VN83nLwHow/PhcL0rm5V9PFVUE9tL0=;
 b=t0Nyj1zx9l7cZHMqvTeHWdO7Mef8jYa/nPbuJFPqDT5gqWwQ7SQ6Z7yPgF/r8hMrcQd7
 1cp8D/ncZy6/Jt4g1OcZKlAC4QhHWauCCI8xLRdNBhIGtDqNztQXXbXWnaDM+PkP2Mz9
 5ikx1tKgxuTcCnqNhOPl/VnB/Ku8AlGPRYBoN5b+Lmsq1Jvf69wVoiKL4E+cNzedpUm+
 VFRgUoCN+nezYExfu2wwsMKa4BBrnxT/eXMGleplA38t0Df+q0PvwsEoxG85jauIGWwd
 q5mXYOuZ4JmrCWZIDSKphxjgc5jxJiQ6cooOhrp97S+UgiWWhHWJspHJhK7rdf5oyvGZ XA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r94ettxm9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Jun 2023 21:49:43 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35MJgThM008357; Thu, 22 Jun 2023 21:49:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3r9398epj8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Jun 2023 21:49:41 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35MLn770035791;
 Thu, 22 Jun 2023 21:49:41 GMT
Received: from joaomart-mac.uk.oracle.com (dhcp-10-175-180-251.vpn.oracle.com
 [10.175.180.251])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3r9398ep1g-8; Thu, 22 Jun 2023 21:49:41 +0000
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
Subject: [PATCH v4 07/15] vfio/common: Track whether DMA Translation is
 enabled on the vIOMMU
Date: Thu, 22 Jun 2023 22:48:37 +0100
Message-Id: <20230622214845.3980-8-joao.m.martins@oracle.com>
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
X-Proofpoint-GUID: egVIolT5eitF4iXJX4JhxLyUc6xTIC-z
X-Proofpoint-ORIG-GUID: egVIolT5eitF4iXJX4JhxLyUc6xTIC-z
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

vfio_get_group() allocates and fills the group/container/space on
success which will store the AddressSpace inside the VFIOSpace struct.
Use the newly added pci_device_iommu_get_attr() to see if DMA
translation is enabled or not. Assume that by default it is enabled.

Today, this means only intel-iommu supports it.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 include/hw/vfio/vfio-common.h |  1 +
 hw/vfio/pci.c                 | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index eed244f25f34..f41860988d6b 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -70,6 +70,7 @@ typedef struct VFIOMigration {
 
 typedef struct VFIOAddressSpace {
     AddressSpace *as;
+    bool no_dma_translation;
     QLIST_HEAD(, VFIOContainer) containers;
     QLIST_ENTRY(VFIOAddressSpace) list;
 } VFIOAddressSpace;
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 73874a94de12..8a98e6ffc480 100644
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
@@ -2907,7 +2908,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     struct stat st;
     int groupid;
     int i, ret;
-    bool is_mdev;
+    bool is_mdev, dma_translation;
     char uuid[UUID_FMT_LEN];
     char *name;
 
@@ -2961,6 +2962,18 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         goto error;
     }
 
+    space = group->container->space;
+
+    /*
+     * Support for toggling DMA translation is optional.
+     * By default, DMA translation is assumed to be enabled i.e.
+     * space::no_dma_translation is 0.
+     */
+    dma_translation = true;
+    pci_device_iommu_get_attr(pdev, IOMMU_ATTR_DMA_TRANSLATION,
+                              &dma_translation);
+    space->no_dma_translation = !dma_translation;
+
     QLIST_FOREACH(vbasedev_iter, &group->device_list, next) {
         if (strcmp(vbasedev_iter->name, vbasedev->name) == 0) {
             error_setg(errp, "device is already attached");
-- 
2.17.2


