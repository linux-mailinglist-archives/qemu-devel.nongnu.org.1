Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8720A73ABDA
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 23:51:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCSCI-0004Ew-Jg; Thu, 22 Jun 2023 17:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qCSC8-0003zF-9U
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 17:50:24 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qCSC6-0007vY-JI
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 17:50:24 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35ML3wKM002927; Thu, 22 Jun 2023 21:50:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=7yxtD0o2/JPTW1QMXSr2K1uLEa3RYqb7B3xWOE/Esi8=;
 b=De6JWYhMnjQuqW+aQXMIgsLTPOfwSsSlaqB8xgU7jhF9fnH0Ra6PiGLvawm+cc9RVFSj
 cb9OutfTiAooXth1lX6Qt09O0ASxGXZkNbCZJucSRZBmy3wbgXS5gVKafH2vlHVLISrF
 cMacfv0IC2G7pUyFrMkXq2raA/tNlvJqKzBeeymHHaOm5uZb1ra8odtYQBSb5VWivSGn
 H58XfmJ0iTv/f3qcdhL5qiAwWHXWaq9v1QJykQUVsKEBSXeuOmxJ0d19pndcNYZGEhVY
 Bpo6cASQhKywkIJG4RHpRSe9HCIVlZS2q1Ln2HzrPqKHR6wNYm13Oe+U6HgWO34z/g71 Gw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r94qaanq6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Jun 2023 21:50:18 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35MKN19w008428; Thu, 22 Jun 2023 21:50:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3r9398eq5r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Jun 2023 21:50:14 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35MLn77E035791;
 Thu, 22 Jun 2023 21:50:13 GMT
Received: from joaomart-mac.uk.oracle.com (dhcp-10-175-180-251.vpn.oracle.com
 [10.175.180.251])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3r9398ep1g-14; Thu, 22 Jun 2023 21:50:12 +0000
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
Subject: [PATCH v4 13/15] vfio/common: Extract vIOMMU code from
 vfio_sync_dirty_bitmap()
Date: Thu, 22 Jun 2023 22:48:43 +0100
Message-Id: <20230622214845.3980-14-joao.m.martins@oracle.com>
In-Reply-To: <20230622214845.3980-1-joao.m.martins@oracle.com>
References: <20230622214845.3980-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_16,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=877
 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306220186
X-Proofpoint-GUID: WjT9HdHYQJmMfLHHOvA4x2DWXpTkjzCe
X-Proofpoint-ORIG-GUID: WjT9HdHYQJmMfLHHOvA4x2DWXpTkjzCe
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

From: Avihai Horon <avihaih@nvidia.com>

Extract vIOMMU code from vfio_sync_dirty_bitmap() to a new function and
restructure the code.

This is done in preparation for optimizing vIOMMU deviice dirty page
tracking. No functional changes intended.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 hw/vfio/common.c | 63 +++++++++++++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 25 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 85fddef24026..c530e9d87f21 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1914,37 +1914,50 @@ static int vfio_sync_ram_discard_listener_dirty_bitmap(VFIOContainer *container,
                                                 &vrdl);
 }
 
+static int vfio_sync_iommu_dirty_bitmap(VFIOContainer *container,
+                                        MemoryRegionSection *section)
+{
+    VFIOGuestIOMMU *giommu;
+    bool found = false;
+    Int128 llend;
+    vfio_giommu_dirty_notifier gdn;
+    int idx;
+
+    QLIST_FOREACH(giommu, &container->giommu_list, giommu_next) {
+        if (MEMORY_REGION(giommu->iommu_mr) == section->mr &&
+            giommu->n.start == section->offset_within_region) {
+            found = true;
+            break;
+        }
+    }
+
+    if (!found) {
+        return 0;
+    }
+
+    gdn.giommu = giommu;
+    idx = memory_region_iommu_attrs_to_index(giommu->iommu_mr,
+                                             MEMTXATTRS_UNSPECIFIED);
+
+    llend = int128_add(int128_make64(section->offset_within_region),
+                       section->size);
+    llend = int128_sub(llend, int128_one());
+
+    iommu_notifier_init(&gdn.n, vfio_iommu_map_dirty_notify, IOMMU_NOTIFIER_MAP,
+                        section->offset_within_region, int128_get64(llend),
+                        idx);
+    memory_region_iommu_replay(giommu->iommu_mr, &gdn.n);
+
+    return 0;
+}
+
 static int vfio_sync_dirty_bitmap(VFIOContainer *container,
                                   MemoryRegionSection *section)
 {
     ram_addr_t ram_addr;
 
     if (memory_region_is_iommu(section->mr)) {
-        VFIOGuestIOMMU *giommu;
-
-        QLIST_FOREACH(giommu, &container->giommu_list, giommu_next) {
-            if (MEMORY_REGION(giommu->iommu_mr) == section->mr &&
-                giommu->n.start == section->offset_within_region) {
-                Int128 llend;
-                vfio_giommu_dirty_notifier gdn = { .giommu = giommu };
-                int idx = memory_region_iommu_attrs_to_index(giommu->iommu_mr,
-                                                       MEMTXATTRS_UNSPECIFIED);
-
-                llend = int128_add(int128_make64(section->offset_within_region),
-                                   section->size);
-                llend = int128_sub(llend, int128_one());
-
-                iommu_notifier_init(&gdn.n,
-                                    vfio_iommu_map_dirty_notify,
-                                    IOMMU_NOTIFIER_MAP,
-                                    section->offset_within_region,
-                                    int128_get64(llend),
-                                    idx);
-                memory_region_iommu_replay(giommu->iommu_mr, &gdn.n);
-                break;
-            }
-        }
-        return 0;
+        return vfio_sync_iommu_dirty_bitmap(container, section);
     } else if (memory_region_has_ram_discard_manager(section->mr)) {
         return vfio_sync_ram_discard_listener_dirty_bitmap(container, section);
     }
-- 
2.17.2


