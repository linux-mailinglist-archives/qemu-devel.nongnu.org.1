Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 370928090D5
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 19:57:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBJSm-0003pK-Lh; Thu, 07 Dec 2023 13:51:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rBJSa-0003d9-Ag
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:50:58 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rBJSW-000796-Fi
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:50:56 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B7HFTxV007979; Thu, 7 Dec 2023 18:50:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=FuWoZYg+OylOSDGU0DmVC1aA59KXXhNhadiSgZ9OM78=;
 b=ZtFFnG35R8XaUpae/IkQLgcxtp5InSCZ614k4r3QImIljrfxQUy8hB+gyY9+mptx8tgi
 M2EAxig/QdKD9SRNhbOzJmu5RF8S+7TW+oHXkqdZBKu9MHaDr6lFbPOiLVxBJDpzp+q5
 B4UyFWI+E1GCIgHDARUYTyXpadOk0cldvcuna/D2KhHUCoHb37UgFfY2+vHFJ6UM8YNg
 FGx2Dww3L0SuW4xANb4ULJF1DAu8K9v3+ScDGnOv3yfzyi8S6DUCCUjz5ZBvyh7Rfftc
 25G+/q2jYyjXr8oWHjmRJk4NZuTlSM7dkB5mBm7thkQPclgZnWmnXecPj7VvtROT27y6 4g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utd0hmjtu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Dec 2023 18:50:49 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B7InFew039579; Thu, 7 Dec 2023 18:50:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3utan7vj5c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Dec 2023 18:50:48 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B7Io90g008067;
 Thu, 7 Dec 2023 18:50:47 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3utan7vh2k-26; Thu, 07 Dec 2023 18:50:47 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: eperezma@redhat.com, jasowang@redhat.com, mst@redhat.com,
 dtatulea@nvidia.com, leiyang@redhat.com, yin31149@gmail.com,
 boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Cc: qemu-devel@nongnu.org
Subject: [PATCH 25/40] vdpa: add asid to dma_batch_once API
Date: Thu,  7 Dec 2023 09:39:38 -0800
Message-Id: <1701970793-6865-26-git-send-email-si-wei.liu@oracle.com>
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
X-Proofpoint-GUID: GgEBq_STXTzs1jNyPD5vEXSIz9aX4Nug
X-Proofpoint-ORIG-GUID: GgEBq_STXTzs1jNyPD5vEXSIz9aX4Nug
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0a-00069f02.pphosted.com
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

So that DMA batching API can operate on other ASID than 0.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 hw/virtio/trace-events |  4 ++--
 hw/virtio/vhost-vdpa.c | 14 ++++++++------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 3411a07..196f32f 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -32,8 +32,8 @@ vhost_user_create_notifier(int idx, void *n) "idx:%d n:%p"
 # vhost-vdpa.c
 vhost_vdpa_dma_map(void *vdpa, int fd, uint32_t msg_type, uint32_t asid, uint64_t iova, uint64_t size, uint64_t uaddr, uint8_t perm, uint8_t type) "vdpa_shared:%p fd: %d msg_type: %"PRIu32" asid: %"PRIu32" iova: 0x%"PRIx64" size: 0x%"PRIx64" uaddr: 0x%"PRIx64" perm: 0x%"PRIx8" type: %"PRIu8
 vhost_vdpa_dma_unmap(void *vdpa, int fd, uint32_t msg_type, uint32_t asid, uint64_t iova, uint64_t size, uint8_t type) "vdpa_shared:%p fd: %d msg_type: %"PRIu32" asid: %"PRIu32" iova: 0x%"PRIx64" size: 0x%"PRIx64" type: %"PRIu8
-vhost_vdpa_map_batch_begin(void *v, int fd, uint32_t msg_type, uint8_t type)  "vdpa_shared:%p fd: %d msg_type: %"PRIu32" type: %"PRIu8
-vhost_vdpa_dma_batch_end(void *v, int fd, uint32_t msg_type, uint8_t type)  "vdpa_shared:%p fd: %d msg_type: %"PRIu32" type: %"PRIu8
+vhost_vdpa_map_batch_begin(void *v, int fd, uint32_t msg_type, uint8_t type, uint32_t asid)  "vdpa_shared:%p fd: %d msg_type: %"PRIu32" type: %"PRIu8" asid: %"PRIu32
+vhost_vdpa_dma_batch_end(void *v, int fd, uint32_t msg_type, uint8_t type, uint32_t asid)  "vdpa_shared:%p fd: %d msg_type: %"PRIu32" type: %"PRIu8" asid: %"PRIu32
 vhost_vdpa_listener_region_add_unaligned(void *v, const char *name, uint64_t offset_as, uint64_t offset_page) "vdpa_shared: %p region %s offset_within_address_space %"PRIu64" offset_within_region %"PRIu64
 vhost_vdpa_listener_region_add(void *vdpa, uint64_t iova, uint64_t llend, void *vaddr, bool readonly) "vdpa: %p iova 0x%"PRIx64" llend 0x%"PRIx64" vaddr: %p read-only: %d"
 vhost_vdpa_listener_region_del_unaligned(void *v, const char *name, uint64_t offset_as, uint64_t offset_page) "vdpa_shared: %p region %s offset_within_address_space %"PRIu64" offset_within_region %"PRIu64
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 999a97a..2db2832 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -161,11 +161,12 @@ int vhost_vdpa_dma_unmap(VhostVDPAShared *s, uint32_t asid, hwaddr iova,
     return ret;
 }
 
-static bool vhost_vdpa_map_batch_begin(VhostVDPAShared *s)
+static bool vhost_vdpa_map_batch_begin(VhostVDPAShared *s, uint32_t asid)
 {
     int fd = s->device_fd;
     struct vhost_msg_v2 msg = {
         .type = VHOST_IOTLB_MSG_V2,
+        .asid = asid,
         .iotlb.type = VHOST_IOTLB_BATCH_BEGIN,
     };
 
@@ -178,7 +179,7 @@ static bool vhost_vdpa_map_batch_begin(VhostVDPAShared *s)
         return false;
     }
 
-    trace_vhost_vdpa_map_batch_begin(s, fd, msg.type, msg.iotlb.type);
+    trace_vhost_vdpa_map_batch_begin(s, fd, msg.type, msg.iotlb.type, msg.asid);
     if (write(fd, &msg, sizeof(msg)) != sizeof(msg)) {
         error_report("failed to write, fd=%d, errno=%d (%s)",
                      fd, errno, strerror(errno));
@@ -193,17 +194,18 @@ static void vhost_vdpa_dma_batch_begin_once(VhostVDPAShared *s)
         return;
     }
 
-    if (vhost_vdpa_map_batch_begin(s)) {
+    if (vhost_vdpa_map_batch_begin(s, 0)) {
         s->iotlb_batch_begin_sent = true;
     }
 }
 
-static bool vhost_vdpa_dma_batch_end(VhostVDPAShared *s)
+static bool vhost_vdpa_dma_batch_end(VhostVDPAShared *s, uint32_t asid)
 {
     struct vhost_msg_v2 msg = {};
     int fd = s->device_fd;
 
     msg.type = VHOST_IOTLB_MSG_V2;
+    msg.asid = asid;
     msg.iotlb.type = VHOST_IOTLB_BATCH_END;
 
     if (s->map_thread_enabled && !qemu_thread_is_self(&s->map_thread)) {
@@ -215,7 +217,7 @@ static bool vhost_vdpa_dma_batch_end(VhostVDPAShared *s)
         return false;
     }
 
-    trace_vhost_vdpa_dma_batch_end(s, fd, msg.type, msg.iotlb.type);
+    trace_vhost_vdpa_dma_batch_end(s, fd, msg.type, msg.iotlb.type, msg.asid);
     if (write(fd, &msg, sizeof(msg)) != sizeof(msg)) {
         error_report("failed to write, fd=%d, errno=%d (%s)",
                      fd, errno, strerror(errno));
@@ -233,7 +235,7 @@ static void vhost_vdpa_dma_batch_end_once(VhostVDPAShared *s)
         return;
     }
 
-    if (vhost_vdpa_dma_batch_end(s)) {
+    if (vhost_vdpa_dma_batch_end(s, 0)) {
         s->iotlb_batch_begin_sent = false;
     }
 }
-- 
1.8.3.1


