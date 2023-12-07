Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B3980908F
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 19:51:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBJSE-0003XO-Jo; Thu, 07 Dec 2023 13:50:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rBJS5-0003U6-8t
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:50:27 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rBJS0-0006Z3-DK
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:50:24 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B7HY0pW009542; Thu, 7 Dec 2023 18:50:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=PXaBos3iadjASSJZj10OoTka/EF5tVh7f2/9jG/IaBk=;
 b=QIomfy/rCMx5KAtw18PQeVo/HP37wR3SPJZ9wAymwaedglXoFqYf+cU5nH+7BTalpuD7
 hjWwKOSTitIru0/IkRb/85U/1BqHg3PwiGL6XVZgqqs/5/o9Fam43UdmX32/nD6qm2OR
 zGQSlvScJiHTp8hulAD9vzISn03DBNPREXGIx+RFjRx7ahR56duC3B4WR2lYEHWaF3Xh
 osHxzhNZ+vrC9oe+hVQZire88BLpjXKMCQ2LmCFVqiW4TcTj9tKwoO9V+ESXu7eakQNd
 xTr84XVhawd80Nk3r21Bxb593kvbFyQYFtR+033slTYXSum1l/x0uKeWAxOComx7wjfB Ww== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utd1gcshf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Dec 2023 18:50:18 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B7HQKhr039445; Thu, 7 Dec 2023 18:50:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3utan7vh90-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Dec 2023 18:50:17 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B7Io900008067;
 Thu, 7 Dec 2023 18:50:17 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3utan7vh2k-5; Thu, 07 Dec 2023 18:50:17 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: eperezma@redhat.com, jasowang@redhat.com, mst@redhat.com,
 dtatulea@nvidia.com, leiyang@redhat.com, yin31149@gmail.com,
 boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Cc: qemu-devel@nongnu.org
Subject: [PATCH 04/40] vdpa: piggyback desc_group index when probing isolated
 cvq
Date: Thu,  7 Dec 2023 09:39:17 -0800
Message-Id: <1701970793-6865-5-git-send-email-si-wei.liu@oracle.com>
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
X-Proofpoint-ORIG-GUID: h2pRchlMPATXGGR-NWKj99Zcx7z4f-Fx
X-Proofpoint-GUID: h2pRchlMPATXGGR-NWKj99Zcx7z4f-Fx
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

Same as the previous commit, but do it for cvq instead of data vqs.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 net/vhost-vdpa.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 0cf3147..cb5705d 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -1601,16 +1601,19 @@ static const VhostShadowVirtqueueOps vhost_vdpa_net_svq_ops = {
 };
 
 /**
- * Probe if CVQ is isolated
+ * Probe if CVQ is isolated, and piggyback its descriptor group
+ * index if supported
  *
  * @device_fd         The vdpa device fd
  * @features          Features offered by the device.
  * @cvq_index         The control vq pair index
+ * @desc_grpidx       The CVQ's descriptor group index to return
  *
- * Returns <0 in case of failure, 0 if false and 1 if true.
+ * Returns <0 in case of failure, 0 if false and 1 if true (isolated).
  */
 static int vhost_vdpa_probe_cvq_isolation(int device_fd, uint64_t features,
-                                          int cvq_index, Error **errp)
+                                          int cvq_index, int64_t *desc_grpidx,
+                                          Error **errp)
 {
     uint64_t backend_features;
     int64_t cvq_group;
@@ -1667,6 +1670,13 @@ static int vhost_vdpa_probe_cvq_isolation(int device_fd, uint64_t features,
         goto out;
     }
 
+    if (backend_features & BIT_ULL(VHOST_BACKEND_F_DESC_ASID)) {
+        int64_t desc_group = vhost_vdpa_get_vring_desc_group(device_fd,
+                                                             cvq_index, errp);
+        if (likely(desc_group >= 0) && desc_group != cvq_group)
+            *desc_grpidx = desc_group;
+    }
+
     for (int i = 0; i < cvq_index; ++i) {
         int64_t group = vhost_vdpa_get_vring_group(device_fd, i, errp);
         if (unlikely(group < 0)) {
@@ -1685,6 +1695,8 @@ static int vhost_vdpa_probe_cvq_isolation(int device_fd, uint64_t features,
 out:
     status = 0;
     ioctl(device_fd, VHOST_VDPA_SET_STATUS, &status);
+    status = VIRTIO_CONFIG_S_ACKNOWLEDGE | VIRTIO_CONFIG_S_DRIVER;
+    ioctl(device_fd, VHOST_VDPA_SET_STATUS, &status);
     return r;
 }
 
@@ -1791,6 +1803,7 @@ static NetClientState *net_vhost_vdpa_init(NetClientState *peer,
                                        Error **errp)
 {
     NetClientState *nc = NULL;
+    int64_t desc_group = -1;
     VhostVDPAState *s;
     int ret = 0;
     assert(name);
@@ -1802,7 +1815,7 @@ static NetClientState *net_vhost_vdpa_init(NetClientState *peer,
     } else {
         cvq_isolated = vhost_vdpa_probe_cvq_isolation(vdpa_device_fd, features,
                                                       queue_pair_index * 2,
-                                                      errp);
+                                                      &desc_group, errp);
         if (unlikely(cvq_isolated < 0)) {
             return NULL;
         }
-- 
1.8.3.1


