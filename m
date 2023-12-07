Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D924809097
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 19:51:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBJSV-0003bB-U9; Thu, 07 Dec 2023 13:50:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rBJSF-0003YZ-1k
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:50:36 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rBJSD-0006xy-7M
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:50:34 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B7IXRY1021815; Thu, 7 Dec 2023 18:50:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=BfrNOM61HQk1Refk9aUivCtpc5yjhyjOFXJvrx8vuEY=;
 b=dmY5cGU+ZGNtQ2mD9MOouxy7sZjUV+YMUCwfcUER27O3jIeX9I4K/UWP2CGW4G+CBEwk
 QTbpxzXGueAQ05hzZZJDklcl4bmlOEHaV/dIXNWALpW7Nv9jp2upHC/uLj/mSQQX9obw
 9PzRcJSX34TQFgwPoBz9Y2rFw+humF0hItCYeBWJYoPhQprIK9lvQIDlOW8RTN86QVyJ
 q0VEGMGxRjVLTvL4pxB9Mz0M9ok80g1jxp3oZ3t/tD6fBFUG/5J75IdZt/jdVr07ppQ9
 XVQdVrqRQUepOT2hoM1zU15/xF28WAMaXnVjBw9YkguxPiQSt3tleNnNSownG6LXEFdv ZQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utdmbmnsn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Dec 2023 18:50:31 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B7HNN8s039498; Thu, 7 Dec 2023 18:50:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3utan7vhpj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Dec 2023 18:50:30 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B7Io90I008067;
 Thu, 7 Dec 2023 18:50:30 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3utan7vh2k-14; Thu, 07 Dec 2023 18:50:30 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: eperezma@redhat.com, jasowang@redhat.com, mst@redhat.com,
 dtatulea@nvidia.com, leiyang@redhat.com, yin31149@gmail.com,
 boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Cc: qemu-devel@nongnu.org
Subject: [PATCH 13/40] vdpa: ref counting VhostVDPAShared
Date: Thu,  7 Dec 2023 09:39:26 -0800
Message-Id: <1701970793-6865-14-git-send-email-si-wei.liu@oracle.com>
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
X-Proofpoint-ORIG-GUID: pAv6TUJR0jCfrTDP25p5yCJ6gVZ-M29W
X-Proofpoint-GUID: pAv6TUJR0jCfrTDP25p5yCJ6gVZ-M29W
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

Subsequent patches attempt to release VhostVDPAShared resources,
for example iova tree to free and memory listener to unregister,
in vdpa_dev_cleanup(). Instead of checking against the vq index,
which is not always available in all of the callers, counting
the usage by reference. Then it'll be easy to free resource
upon the last deref.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 include/hw/virtio/vhost-vdpa.h |  2 ++
 net/vhost-vdpa.c               | 14 ++++++++++----
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdpa.h
index 63493ff..7b8d3bf 100644
--- a/include/hw/virtio/vhost-vdpa.h
+++ b/include/hw/virtio/vhost-vdpa.h
@@ -70,6 +70,8 @@ typedef struct vhost_vdpa_shared {
 
     /* Vdpa must send shadow addresses as IOTLB key for data queues, not GPA */
     bool shadow_data;
+
+    unsigned refcnt;
 } VhostVDPAShared;
 
 typedef struct vhost_vdpa {
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index aebaa53..a126e5c 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -236,11 +236,11 @@ static void vhost_vdpa_cleanup(NetClientState *nc)
         g_free(s->vhost_net);
         s->vhost_net = NULL;
     }
-    if (s->vhost_vdpa.index != 0) {
-        return;
+    if (--s->vhost_vdpa.shared->refcnt == 0) {
+        qemu_close(s->vhost_vdpa.shared->device_fd);
+        g_free(s->vhost_vdpa.shared);
     }
-    qemu_close(s->vhost_vdpa.shared->device_fd);
-    g_free(s->vhost_vdpa.shared);
+    s->vhost_vdpa.shared = NULL;
 }
 
 /** Dummy SetSteeringEBPF to support RSS for vhost-vdpa backend  */
@@ -1896,6 +1896,7 @@ static NetClientState *net_vhost_vdpa_init(NetClientState *peer,
         s->vhost_vdpa.shared->device_fd = vdpa_device_fd;
         s->vhost_vdpa.shared->iova_range = iova_range;
         s->vhost_vdpa.shared->shadow_data = svq;
+        s->vhost_vdpa.shared->refcnt++;
     } else if (!is_datapath) {
         s->cvq_cmd_out_buffer = mmap(NULL, vhost_vdpa_net_cvq_cmd_page_len(),
                                      PROT_READ | PROT_WRITE,
@@ -1910,6 +1911,7 @@ static NetClientState *net_vhost_vdpa_init(NetClientState *peer,
     }
     if (queue_pair_index != 0) {
         s->vhost_vdpa.shared = shared;
+        s->vhost_vdpa.shared->refcnt++;
     }
 
     ret = vhost_vdpa_add(nc, (void *)&s->vhost_vdpa, queue_pair_index, nvqs);
@@ -1928,6 +1930,10 @@ static NetClientState *net_vhost_vdpa_init(NetClientState *peer,
     return nc;
 
 err:
+    if (--s->vhost_vdpa.shared->refcnt == 0) {
+        g_free(s->vhost_vdpa.shared);
+    }
+    s->vhost_vdpa.shared = NULL;
     qemu_del_net_client(nc);
     return NULL;
 }
-- 
1.8.3.1


