Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADD073ABD9
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 23:51:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCSBv-0003Pa-Il; Thu, 22 Jun 2023 17:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qCSBt-0003Oz-GJ
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 17:50:09 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qCSBr-0007lU-Po
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 17:50:09 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35MK24Dp019481; Thu, 22 Jun 2023 21:50:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=bQtVazwT3QoQkJyOPrjd5tGv+nILONCMQ+b89mlhz4c=;
 b=V3li4+yIeP+qLVozSIfmAoUe1oI2Kmp4Gvp/cVhtqZCRDuNEYyZ0yfZEAJQfbcTqosl6
 zR4zfVtll92jMBp/YLFWUJLt+2X0e9VXkU7VfpGJmfQnnLzDgKCsXzl+mNEYGSSS6nSg
 I8O+KYa8O+mptKxLEbtx04At9TS7vbDeLOBauwdJu8yXK/3UbctenGmoiqGgEd4Hnvrf
 jPdZp8CKRhFwnuxz9BVRMjR7OcWnv72Md9v4r0+8f/K/+TM8nDEV5YrRvMDT1QZQWMQ7
 Ue9yfVj1UhZL7vo8foFkb5o8gbcKjbd6q4uLupbKl/4AqxJLMIPii+DWhYJSRs5MQTDo wQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r938dtt0w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Jun 2023 21:50:05 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35MJv6Ag008427; Thu, 22 Jun 2023 21:50:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3r9398epwr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Jun 2023 21:50:04 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35MLn778035791;
 Thu, 22 Jun 2023 21:50:04 GMT
Received: from joaomart-mac.uk.oracle.com (dhcp-10-175-180-251.vpn.oracle.com
 [10.175.180.251])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3r9398ep1g-12; Thu, 22 Jun 2023 21:50:03 +0000
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
Subject: [PATCH v4 11/15] vfio/common: Move dirty tracking ranges update to
 helper
Date: Thu, 22 Jun 2023 22:48:41 +0100
Message-Id: <20230622214845.3980-12-joao.m.martins@oracle.com>
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
X-Proofpoint-GUID: 0u0E5PCU_Cow0xh1xsnImdt7MZzSl9xp
X-Proofpoint-ORIG-GUID: 0u0E5PCU_Cow0xh1xsnImdt7MZzSl9xp
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

Separate the changes that updates the ranges from the listener, to
make it reusable in preparation to expand its use to vIOMMU support.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 hw/vfio/common.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 17c1d882e221..ecfb9afb3fb6 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1413,20 +1413,10 @@ typedef struct VFIODirtyRangesListener {
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
@@ -1450,12 +1440,28 @@ static void vfio_dirty_tracking_update(MemoryListener *listener,
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
2.17.2


