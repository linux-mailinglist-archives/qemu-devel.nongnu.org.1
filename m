Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7D380909D
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 19:52:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBJSr-0003wv-ST; Thu, 07 Dec 2023 13:51:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rBJSp-0003vj-Rs
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:51:11 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rBJSj-0007AC-VR
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:51:11 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B7EtJQM015896; Thu, 7 Dec 2023 18:50:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=Jnkj8GEJTOW6vXOQA2mRArcmep3dLye1fLL8tT9XBa0=;
 b=TMY+GN35Ciijutl/r949GpyDzd63HdaIefN+03riqV6duwNhy0RPtbqJ1vlIfTY97ohr
 auhF9ri3wLj38ADM+d9hsPqrOS+3wEvpmW1qggEg2xmROn1sH9tTZoVmqeoQl71tVXBx
 MnAQnrWsLGK3LsNCkn/TH0NV7UZiA+IE+nyRKJsD94lHyAyPuOHwS/Hq1l/yXbmnJnkR
 v1B/bCLUTjBaNbMOJzi0U1yb+9LpGvsETl1gKwo4+qVCOZTrB4UErZYst5DYWRf5VmCl
 uUa9m+WbosWQCWegY9GW/YhNUrf+BKo3yvT2K/YoqJ/Kfyyve9YPVfzK3kAmoyxzv4XT cA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utdmbmnt8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Dec 2023 18:50:52 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B7IVo0G039480; Thu, 7 Dec 2023 18:50:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3utan7vj77-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Dec 2023 18:50:51 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B7Io90k008067;
 Thu, 7 Dec 2023 18:50:50 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3utan7vh2k-28; Thu, 07 Dec 2023 18:50:50 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: eperezma@redhat.com, jasowang@redhat.com, mst@redhat.com,
 dtatulea@nvidia.com, leiyang@redhat.com, yin31149@gmail.com,
 boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Cc: qemu-devel@nongnu.org
Subject: [PATCH 27/40] vdpa: add asid to all dma_batch call sites
Date: Thu,  7 Dec 2023 09:39:40 -0800
Message-Id: <1701970793-6865-28-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_15,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312070156
X-Proofpoint-ORIG-GUID: Y8IbbPfJkJuWdiEkUypV9_KhpWVQl7xj
X-Proofpoint-GUID: Y8IbbPfJkJuWdiEkUypV9_KhpWVQl7xj
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0b-00069f02.pphosted.com
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

Will allow other callers to specifcy asid when calling the
dma_batch API.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 hw/virtio/vhost-vdpa.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index e0137f0..d3f5721 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -187,14 +187,14 @@ static bool vhost_vdpa_map_batch_begin(VhostVDPAShared *s, uint32_t asid)
     return true;
 }
 
-static int vhost_vdpa_dma_batch_begin_once(VhostVDPAShared *s)
+static int vhost_vdpa_dma_batch_begin_once(VhostVDPAShared *s, uint32_t asid)
 {
     if (!(s->backend_cap & (0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH)) ||
         s->iotlb_batch_begin_sent) {
         return 0;
     }
 
-    if (vhost_vdpa_map_batch_begin(s, 0)) {
+    if (vhost_vdpa_map_batch_begin(s, asid)) {
         s->iotlb_batch_begin_sent = true;
     }
 
@@ -227,7 +227,7 @@ static bool vhost_vdpa_dma_batch_end(VhostVDPAShared *s, uint32_t asid)
     return true;
 }
 
-static int vhost_vdpa_dma_batch_end_once(VhostVDPAShared *s)
+static int vhost_vdpa_dma_batch_end_once(VhostVDPAShared *s, uint32_t asid)
 {
     if (!(s->backend_cap & (0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH))) {
         return 0;
@@ -237,7 +237,7 @@ static int vhost_vdpa_dma_batch_end_once(VhostVDPAShared *s)
         return 0;
     }
 
-    if (vhost_vdpa_dma_batch_end(s, 0)) {
+    if (vhost_vdpa_dma_batch_end(s, asid)) {
         s->iotlb_batch_begin_sent = false;
     }
 
@@ -248,7 +248,7 @@ static void vhost_vdpa_listener_commit(MemoryListener *listener)
 {
     VhostVDPAShared *s = container_of(listener, VhostVDPAShared, listener);
 
-    vhost_vdpa_dma_batch_end_once(s);
+    vhost_vdpa_dma_batch_end_once(s, VHOST_VDPA_GUEST_PA_ASID);
 }
 
 static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
@@ -423,7 +423,7 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
         iova = mem_region.iova;
     }
 
-    vhost_vdpa_dma_batch_begin_once(s);
+    vhost_vdpa_dma_batch_begin_once(s, VHOST_VDPA_GUEST_PA_ASID);
     ret = vhost_vdpa_dma_map(s, VHOST_VDPA_GUEST_PA_ASID, iova,
                              int128_get64(llsize), vaddr, section->readonly);
     if (ret) {
@@ -505,7 +505,7 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
         iova = result->iova;
         vhost_iova_tree_remove(s->iova_tree, *result);
     }
-    vhost_vdpa_dma_batch_begin_once(s);
+    vhost_vdpa_dma_batch_begin_once(s, VHOST_VDPA_GUEST_PA_ASID);
     /*
      * The unmap ioctl doesn't accept a full 64-bit. need to check it
      */
@@ -1383,10 +1383,10 @@ static void *vhost_vdpa_load_map(void *opaque)
                                      msg->iotlb.size);
             break;
         case VHOST_IOTLB_BATCH_BEGIN:
-            vhost_vdpa_dma_batch_begin_once(shared);
+            vhost_vdpa_dma_batch_begin_once(shared, msg->asid);
             break;
         case VHOST_IOTLB_BATCH_END:
-            vhost_vdpa_dma_batch_end_once(shared);
+            vhost_vdpa_dma_batch_end_once(shared, msg->asid);
             break;
         default:
             error_report("Invalid IOTLB msg type %d", msg->iotlb.type);
-- 
1.8.3.1


