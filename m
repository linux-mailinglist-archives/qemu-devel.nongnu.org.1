Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A40180909C
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 19:52:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBJSW-0003ah-Ij; Thu, 07 Dec 2023 13:50:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rBJS6-0003UD-Pw
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:50:28 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rBJS4-0006c6-C7
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:50:26 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B7IJEpo006221; Thu, 7 Dec 2023 18:50:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=bYCoqd8Qwye+lfpvk+32JEchmO62alasv1pCQMgpYZI=;
 b=J6LYaBTF6FrqBs4x4Fb3zO6ZJLtUBPBnyzswuVdFpsNgycOLFEKnNq1jZA/S9emT9wQj
 M9mv1xJwlh2uh62CtaDIe0Lw2+lCQDQ+IcNPItenDqO9TxlQtoCzG80zvhdwRu5+9gnH
 ZHg0WL3ZD3WGsdWVihekLjyGEu1iQmR3B/hjHVFrj64budv4i4q45fh3lbOharbLTtIv
 BHaKWRQqlkFCPK2YRkd6yhn34FZFxCN4Q+9x+GA8iCaE7jhcaLb7Y6hBGu0cF2DdQf10
 pTxv3ksvArQEIk/XCJ27xEpOWgnukrmGY+9HWL22qBu33wYBDAcv+uCbOCXP60lAdrj/ 1A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utdabvgde-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Dec 2023 18:50:21 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B7I1di0039548; Thu, 7 Dec 2023 18:50:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3utan7vhch-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Dec 2023 18:50:20 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B7Io904008067;
 Thu, 7 Dec 2023 18:50:20 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3utan7vh2k-7; Thu, 07 Dec 2023 18:50:20 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: eperezma@redhat.com, jasowang@redhat.com, mst@redhat.com,
 dtatulea@nvidia.com, leiyang@redhat.com, yin31149@gmail.com,
 boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Cc: qemu-devel@nongnu.org
Subject: [PATCH 06/40] vhost: make svq work with gpa without iova translation
Date: Thu,  7 Dec 2023 09:39:19 -0800
Message-Id: <1701970793-6865-7-git-send-email-si-wei.liu@oracle.com>
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
X-Proofpoint-ORIG-GUID: ZPTuHOVey7VmsYHA5_lXz1rTlTS7gSQ9
X-Proofpoint-GUID: ZPTuHOVey7VmsYHA5_lXz1rTlTS7gSQ9
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

Make vhost_svq_vring_write_descs able to work with GPA directly
without going through iova tree for translation. This will be
needed in the next few patches where the SVQ has dedicated
address space to host its virtqueues. Instead of having to
translate qemu's VA to IOVA via the iova tree, with dedicated
or isolated address space for SVQ descriptors, the IOVA is
exactly same as the guest GPA space where translation would
not be needed any more.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 hw/virtio/vhost-shadow-virtqueue.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index fc5f408..97ccd45 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -136,8 +136,8 @@ static bool vhost_svq_translate_addr(const VhostShadowVirtqueue *svq,
  * Return true if success, false otherwise and print error.
  */
 static bool vhost_svq_vring_write_descs(VhostShadowVirtqueue *svq, hwaddr *sg,
-                                        const struct iovec *iovec, size_t num,
-                                        bool more_descs, bool write)
+                                        const struct iovec *iovec, hwaddr *addr,
+                                        size_t num, bool more_descs, bool write)
 {
     uint16_t i = svq->free_head, last = svq->free_head;
     unsigned n;
@@ -149,8 +149,15 @@ static bool vhost_svq_vring_write_descs(VhostShadowVirtqueue *svq, hwaddr *sg,
         return true;
     }
 
-    ok = vhost_svq_translate_addr(svq, sg, iovec, num);
-    if (unlikely(!ok)) {
+    if (svq->iova_tree) {
+        ok = vhost_svq_translate_addr(svq, sg, iovec, num);
+        if (unlikely(!ok)) {
+            return false;
+        }
+    } else if (!addr) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "No translation found for vaddr 0x%p\n",
+                      iovec[0].iov_base);
         return false;
     }
 
@@ -161,7 +168,7 @@ static bool vhost_svq_vring_write_descs(VhostShadowVirtqueue *svq, hwaddr *sg,
         } else {
             descs[i].flags = flags;
         }
-        descs[i].addr = cpu_to_le64(sg[n]);
+        descs[i].addr = cpu_to_le64(svq->iova_tree ? sg[n] : addr[n]);
         descs[i].len = cpu_to_le32(iovec[n].iov_len);
 
         last = i;
@@ -173,9 +180,10 @@ static bool vhost_svq_vring_write_descs(VhostShadowVirtqueue *svq, hwaddr *sg,
 }
 
 static bool vhost_svq_add_split(VhostShadowVirtqueue *svq,
-                                const struct iovec *out_sg, size_t out_num,
-                                const struct iovec *in_sg, size_t in_num,
-                                unsigned *head)
+                                const struct iovec *out_sg, hwaddr *out_addr,
+                                size_t out_num,
+                                const struct iovec *in_sg, hwaddr *in_addr,
+                                size_t in_num, unsigned *head)
 {
     unsigned avail_idx;
     vring_avail_t *avail = svq->vring.avail;
@@ -191,13 +199,14 @@ static bool vhost_svq_add_split(VhostShadowVirtqueue *svq,
         return false;
     }
 
-    ok = vhost_svq_vring_write_descs(svq, sgs, out_sg, out_num, in_num > 0,
-                                     false);
+    ok = vhost_svq_vring_write_descs(svq, sgs, out_sg, out_addr, out_num,
+                                     in_num > 0, false);
     if (unlikely(!ok)) {
         return false;
     }
 
-    ok = vhost_svq_vring_write_descs(svq, sgs, in_sg, in_num, false, true);
+    ok = vhost_svq_vring_write_descs(svq, sgs, in_sg, in_addr, in_num,
+                                     false, true);
     if (unlikely(!ok)) {
         return false;
     }
@@ -258,7 +267,9 @@ int vhost_svq_add(VhostShadowVirtqueue *svq, const struct iovec *out_sg,
         return -ENOSPC;
     }
 
-    ok = vhost_svq_add_split(svq, out_sg, out_num, in_sg, in_num, &qemu_head);
+    ok = vhost_svq_add_split(svq, out_sg, elem ? elem->out_addr : NULL,
+                             out_num, in_sg, elem ? elem->in_addr : NULL,
+                             in_num, &qemu_head);
     if (unlikely(!ok)) {
         return -EINVAL;
     }
-- 
1.8.3.1


