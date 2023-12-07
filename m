Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF9E8090AC
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 19:52:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBJSv-0003ym-RW; Thu, 07 Dec 2023 13:51:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rBJSr-0003wk-7B
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:51:13 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rBJSl-0007Bh-SH
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:51:12 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B7GDNQ5031482; Thu, 7 Dec 2023 18:50:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=5AgeQWyfy2Ho2yhA/SVB1fzSmEKhlEu+76jpsngIZG4=;
 b=NjeL04sf86y1ZL7zO8yZOuOybt/SUtemGfiYHUFqaUYRCISz4tJ1578gK3419CODdTRT
 yH7zjgt9pj+Hb6wAj84+fQbSUpZMDdOeCpAIm1i1uALWJFDRO4tbmxoShitQxVRFo1SU
 RRocGQyABqcbEtEPnOiyFcsW393gqsmfxqjDHcw1BdIq7w8nrvJDhZIgn5qelpNXrVlg
 Vo6xSBd//34SvStDkQkbuR2EY7OaXnlnBf6/S3e8L61UpVYpr9kPWGPV1JK/6vbfg0kf
 xt6vU/hM8d1k0bFUQV6TDE7nkdgKcju1bIrM6uOZ48a/kdAmrjS+28ETcf7K0OP5ZnoQ Lg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utdrvmpfu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Dec 2023 18:50:56 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B7ITt8L039503; Thu, 7 Dec 2023 18:50:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3utan7vj9s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Dec 2023 18:50:55 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B7Io90q008067;
 Thu, 7 Dec 2023 18:50:54 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3utan7vh2k-31; Thu, 07 Dec 2023 18:50:54 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: eperezma@redhat.com, jasowang@redhat.com, mst@redhat.com,
 dtatulea@nvidia.com, leiyang@redhat.com, yin31149@gmail.com,
 boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Cc: qemu-devel@nongnu.org
Subject: [PATCH 30/40] vdpa: batch map/unmap op per svq pair basis
Date: Thu,  7 Dec 2023 09:39:43 -0800
Message-Id: <1701970793-6865-31-git-send-email-si-wei.liu@oracle.com>
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
X-Proofpoint-GUID: KxJwXgfLbavtyNmFEvUIyeUJEW5kqX00
X-Proofpoint-ORIG-GUID: KxJwXgfLbavtyNmFEvUIyeUJEW5kqX00
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

Coalesce multiple map or unmap operations to just one
so that all mapping setup or teardown can occur in a
single DMA batch.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 hw/virtio/vhost-vdpa.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 68dc01b..d98704a 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -1288,6 +1288,7 @@ static bool vhost_vdpa_svqs_start(struct vhost_dev *dev)
         return true;
     }
 
+    vhost_vdpa_dma_batch_begin_once(v->shared, v->address_space_id);
     for (i = 0; i < v->shadow_vqs->len; ++i) {
         VirtQueue *vq = virtio_get_queue(dev->vdev, dev->vq_index + i);
         VhostShadowVirtqueue *svq = g_ptr_array_index(v->shadow_vqs, i);
@@ -1315,6 +1316,7 @@ static bool vhost_vdpa_svqs_start(struct vhost_dev *dev)
             goto err_set_addr;
         }
     }
+    vhost_vdpa_dma_batch_end_once(v->shared, v->address_space_id);
 
     return true;
 
@@ -1323,6 +1325,7 @@ err_set_addr:
 
 err_map:
     vhost_svq_stop(g_ptr_array_index(v->shadow_vqs, i));
+    vhost_vdpa_dma_batch_end_once(v->shared, v->address_space_id);
 
 err:
     error_reportf_err(err, "Cannot setup SVQ %u: ", i);
@@ -1343,6 +1346,7 @@ static void vhost_vdpa_svqs_stop(struct vhost_dev *dev)
         return;
     }
 
+    vhost_vdpa_dma_batch_begin_once(v->shared, v->address_space_id);
     for (unsigned i = 0; i < v->shadow_vqs->len; ++i) {
         VhostShadowVirtqueue *svq = g_ptr_array_index(v->shadow_vqs, i);
 
@@ -1352,6 +1356,7 @@ static void vhost_vdpa_svqs_stop(struct vhost_dev *dev)
         event_notifier_cleanup(&svq->hdev_kick);
         event_notifier_cleanup(&svq->hdev_call);
     }
+    vhost_vdpa_dma_batch_end_once(v->shared, v->address_space_id);
 }
 
 static void vhost_vdpa_suspend(struct vhost_dev *dev)
-- 
1.8.3.1


