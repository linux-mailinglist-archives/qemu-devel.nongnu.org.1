Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A719C8090CC
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 19:56:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBJSi-0003ev-9V; Thu, 07 Dec 2023 13:51:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rBJSa-0003d6-9h
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:50:58 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rBJSS-000768-6S
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:50:53 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B7IJFbR006249; Thu, 7 Dec 2023 18:50:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=rCzHnfkwKPT4JYuH9v8Cdemma7Tb5LZVKQwQbSmCGCM=;
 b=S83Bwx0Sm+W8pLeWpegkjjLL2R8EriAiSKpfVWAJgkZySy0m0FzY7zHtrG2maYA6hQe7
 aiSCR4alCk7KgnJ11avOT/1c3qM3HSAWPeImwTSO4WQvKzLBuhvGPYjN+1EJjhQFBjEh
 nQRVQP9QJQAG/PuL2TWMhFGZPugDlfMCsaNxJe6zQaRyKPxsmsJdvhJr/CPr6nI/b8vH
 kjLLnzMTtzkOXeAMyg0WW+nZQK+aEXF1WgOKj3jIl47qrylZ0LDst/4aq/NJlOkaGWE2
 u5qhfNtumh6f/Gc6buzBM10sERIxNGhkz36PsMAvKg2YGCbHdYEVbsYfzVMhdQs3jKZH vg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utdabvge1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Dec 2023 18:50:43 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B7Hrf0K039610; Thu, 7 Dec 2023 18:50:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3utan7vj0n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Dec 2023 18:50:42 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B7Io90Y008067;
 Thu, 7 Dec 2023 18:50:42 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3utan7vh2k-22; Thu, 07 Dec 2023 18:50:41 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: eperezma@redhat.com, jasowang@redhat.com, mst@redhat.com,
 dtatulea@nvidia.com, leiyang@redhat.com, yin31149@gmail.com,
 boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Cc: qemu-devel@nongnu.org
Subject: [PATCH 21/40] vdpa: vhost_vdpa_dma_batch_end_once rename
Date: Thu,  7 Dec 2023 09:39:34 -0800
Message-Id: <1701970793-6865-22-git-send-email-si-wei.liu@oracle.com>
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
X-Proofpoint-ORIG-GUID: KdXaukVOZBlx2C3Dmk_NjLvQJU1DF52c
X-Proofpoint-GUID: KdXaukVOZBlx2C3Dmk_NjLvQJU1DF52c
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

No functional changes. Rename only.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 hw/virtio/vhost-vdpa.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 47c764b..013bfa2 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -191,7 +191,7 @@ static void vhost_vdpa_iotlb_batch_begin_once(VhostVDPAShared *s)
     s->iotlb_batch_begin_sent = true;
 }
 
-static void vhost_vdpa_dma_end_batch(VhostVDPAShared *s)
+static void vhost_vdpa_dma_batch_end_once(VhostVDPAShared *s)
 {
     struct vhost_msg_v2 msg = {};
     int fd = s->device_fd;
@@ -229,7 +229,7 @@ static void vhost_vdpa_listener_commit(MemoryListener *listener)
 {
     VhostVDPAShared *s = container_of(listener, VhostVDPAShared, listener);
 
-    vhost_vdpa_dma_end_batch(s);
+    vhost_vdpa_dma_batch_end_once(s);
 }
 
 static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
@@ -1367,7 +1367,7 @@ static void *vhost_vdpa_load_map(void *opaque)
             vhost_vdpa_iotlb_batch_begin_once(shared);
             break;
         case VHOST_IOTLB_BATCH_END:
-            vhost_vdpa_dma_end_batch(shared);
+            vhost_vdpa_dma_batch_end_once(shared);
             break;
         default:
             error_report("Invalid IOTLB msg type %d", msg->iotlb.type);
-- 
1.8.3.1


