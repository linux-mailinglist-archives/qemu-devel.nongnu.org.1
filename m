Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A9B716BC8
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 20:01:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q43e9-0000rz-LY; Tue, 30 May 2023 14:00:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q43e7-0000lX-Hf
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:00:35 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q43e5-0002YJ-Q3
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:00:35 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34UE54a0020898; Tue, 30 May 2023 18:00:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=oeF/xgJgz8YKtGSx6YH+wUQ+893UdJNG0ePybKsC06Q=;
 b=xC+r6DQM7jgRj6klgdp84tREkEODwU7h7Dc7ACvo9snSafAmaSlJA13hhGKKZHsblw5y
 kULnEX10/zDYzolr4LwI4z8vxJltSkrJ7G0FDGRimD+9QzVLIWGY+ywR4drKlmS4JRHa
 iAe5lKNjQLKuK79mysOIyGMep4H+QyWGxHD819PgGpEwxcb+xCprxnzG50isokydg8kG
 3H9AjuC1w/03yuAk/79EWyxL0eNzmijek6rbG9PYL7zYCVstS1m2vMFB4hAH+zGBff6D
 Buci2ETG+qgYDK7NHyKBVBhrbE7h6tGfUaqlayMXkBwKhSfTs/nNtIcV9MKFI9T7EtaA fA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhb93ge4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 May 2023 18:00:29 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34UHTTA1014592; Tue, 30 May 2023 18:00:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3qu8a48u4d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 May 2023 18:00:29 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34UHxspR011459;
 Tue, 30 May 2023 18:00:28 GMT
Received: from joaomart-mac.uk.oracle.com (dhcp-10-175-191-61.vpn.oracle.com
 [10.175.191.61])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3qu8a48srr-9; Tue, 30 May 2023 18:00:28 +0000
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
Subject: [PATCH v3 08/15] vfio/common: Relax vIOMMU detection when DMA
 translation is off
Date: Tue, 30 May 2023 18:59:30 +0100
Message-Id: <20230530175937.24202-9-joao.m.martins@oracle.com>
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
X-Proofpoint-GUID: 0LmWS7nQmjh2Qd6Zn1vfwm_gsDbnNjb1
X-Proofpoint-ORIG-GUID: 0LmWS7nQmjh2Qd6Zn1vfwm_gsDbnNjb1
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

Relax the vIOMMU migration blocker when the underlying IOMMU reports that
DMA translation disabled. When it is disabled there will be no DMA mappings
via the vIOMMU and the guest only uses it for Interrupt Remapping.

The latter is done via the vfio_viommu_preset() return value whereby in
addition to validating that the address space is memory, we also check
whether the IOMMU MR has DMA translation on. Assume it is enabled if
there's no IOMMU MR or if no dma-translation property is supported.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 hw/vfio/common.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index fa8fd949b1cf..060acccb3443 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -414,12 +414,32 @@ void vfio_unblock_multiple_devices_migration(void)
     multiple_devices_migration_blocker = NULL;
 }
 
+static bool vfio_viommu_dma_translation_enabled(VFIOAddressSpace *space)
+{
+    bool enabled = false;
+    int ret;
+
+    if (!space->iommu_mr) {
+        return true;
+    }
+
+    ret = memory_region_iommu_get_attr(space->iommu_mr,
+                                       IOMMU_ATTR_DMA_TRANSLATION,
+                                       &enabled);
+    if (ret || enabled) {
+        return true;
+    }
+
+    return false;
+}
+
 static bool vfio_viommu_preset(void)
 {
     VFIOAddressSpace *space;
 
     QLIST_FOREACH(space, &vfio_address_spaces, list) {
-        if (space->as != &address_space_memory) {
+        if ((space->as != &address_space_memory) &&
+            vfio_viommu_dma_translation_enabled(space)) {
             return true;
         }
     }
-- 
2.39.3


