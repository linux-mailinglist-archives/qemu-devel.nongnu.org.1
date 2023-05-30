Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02335716BC9
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 20:01:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q43eS-0001dA-2l; Tue, 30 May 2023 14:00:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q43eP-0001ZX-7I
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:00:53 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q43eN-0002hm-LW
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:00:52 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34UE4tkr008512; Tue, 30 May 2023 18:00:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=Ec2yjzcuWoT8Qe2E87T1LVSwwhoAWx9rdoJA8pHb+Ok=;
 b=i5VpUtr9riioSi3Iuwen9Es82WopMNT15RWZJmR9jBsZLp7qjxb/5ET/pwOT121HX0pR
 XxNBzVfbg9fiqklmEeKWspqXyoFOmH5cElmEQyloNgTSLc0Tj+CCx72nUglt19wRF2sE
 GUwl1m0/gL4wGCxcBq394oeyB/ulW0FpaXcCCWJ7Agvac6gIfx5c00Kn1l8LPjMeL4u1
 b8DP0b0muSsoH2ERgqNw0Y9QpUePEprIjBqfCAUk0nm5V4djl6PBCM+la6fhrTyVWWsK
 S+drdlqkRlDaU8zpK7ng8iAVCteQ8q6rx02MYQbrG8+dYgjWTiUfy4NAEF1WOAX8orKv 4w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhmjkesw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 May 2023 18:00:47 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34UHmbFm014623; Tue, 30 May 2023 18:00:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3qu8a48uwv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 May 2023 18:00:46 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34UHxspX011459;
 Tue, 30 May 2023 18:00:46 GMT
Received: from joaomart-mac.uk.oracle.com (dhcp-10-175-191-61.vpn.oracle.com
 [10.175.191.61])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3qu8a48srr-12; Tue, 30 May 2023 18:00:45 +0000
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
Subject: [PATCH v3 11/15] vfio/common: Move dirty tracking ranges update to
 helper
Date: Tue, 30 May 2023 18:59:33 +0100
Message-Id: <20230530175937.24202-12-joao.m.martins@oracle.com>
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
X-Proofpoint-ORIG-GUID: akBRhUbZ4ZK7OFE2gJj6uasiIVzHqHsH
X-Proofpoint-GUID: akBRhUbZ4ZK7OFE2gJj6uasiIVzHqHsH
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

Separate the code that update the ranges from the listener, in
preparation to expand its use to vIOMMU support.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 hw/vfio/common.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 060acccb3443..b8d97577f856 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1432,20 +1432,10 @@ typedef struct VFIODirtyRangesListener {
     MemoryListener listener;
 } VFIODirtyRangesListener;
 
-static void vfio_dirty_tracking_update(MemoryListener *listener,
-                                       MemoryRegionSection *section)
+static void vfio_dirty_tracking_update(hwaddr iova, hwaddr end,
+                                       VFIODirtyRanges *range)
 {
-    VFIODirtyRangesListener *dirty = container_of(listener,
-                                                  VFIODirtyRangesListener,
-                                                  listener);
-    VFIODirtyRanges *range = &dirty->ranges;
-    hwaddr iova, end, *min, *max;
-
-    if (!vfio_listener_valid_section(section, "tracking_update") ||
-        !vfio_get_section_iova_range(dirty->container, section,
-                                     &iova, &end, NULL)) {
-        return;
-    }
+    hwaddr *min, *max;
 
     /*
      * The address space passed to the dirty tracker is reduced to two ranges:
@@ -1469,12 +1459,28 @@ static void vfio_dirty_tracking_update(MemoryListener *listener,
     }
 
     trace_vfio_device_dirty_tracking_update(iova, end, *min, *max);
-    return;
+}
+
+static void vfio_listener_dirty_tracking_update(MemoryListener *listener,
+                                                MemoryRegionSection *section)
+{
+    VFIODirtyRangesListener *dirty = container_of(listener,
+                                                  VFIODirtyRangesListener,
+                                                  listener);
+    hwaddr iova, end;
+
+    if (!vfio_listener_valid_section(section, "tracking_update") ||
+        !vfio_get_section_iova_range(dirty->container, section,
+                                     &iova, &end, NULL)) {
+        return;
+    }
+
+    vfio_dirty_tracking_update(iova, end, &dirty->ranges);
 }
 
 static const MemoryListener vfio_dirty_tracking_listener = {
     .name = "vfio-tracking",
-    .region_add = vfio_dirty_tracking_update,
+    .region_add = vfio_listener_dirty_tracking_update,
 };
 
 static void vfio_dirty_tracking_init(VFIOContainer *container,
-- 
2.39.3


