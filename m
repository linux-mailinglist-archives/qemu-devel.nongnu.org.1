Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA548090E0
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 19:58:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBJSH-0003Xn-Bl; Thu, 07 Dec 2023 13:50:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rBJS8-0003Vc-Ol
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:50:28 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rBJS4-0006cB-Tt
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:50:28 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B7IhZjg029893; Thu, 7 Dec 2023 18:50:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=PGF2vwqC9zOw5FzhQrsgKA+MWTLi1jrbI3MPbsVTPJs=;
 b=ejwpsie+fYnCTtlG6cq3uEUGAeoydRVfUGNKLBKORTJ5SQbGzSE0LEwXUBWmc64SazfA
 MPrpCsdyA1Y9OuZH7xpl5qAp6CjQ0AYYjYW73J7tKbBoLR8bTyM9WbXsAmI44Q+gEKc8
 3VVZuAZGdYVS50er2n4OeEQ58L4RST/9DRc331YRftl6ZWy6EJy3/7wbKWivYeeQ5pTB
 p9ef4TzNsAlSSjtWDEZvpo5yl1dQOmItClMHVf//376Jg+Z/r6OzvbRNYk9sG8ie/+9t
 AYo3AkSjnmovZNk+XHYsJuA51h2pE+xsLwlGcd4CCgJMlz8RsBcuNwHmh+MehHCMdTXG qg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utd1gcshk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Dec 2023 18:50:23 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B7HTkJI039553; Thu, 7 Dec 2023 18:50:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3utan7vhe7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Dec 2023 18:50:22 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B7Io906008067;
 Thu, 7 Dec 2023 18:50:21 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3utan7vh2k-8; Thu, 07 Dec 2023 18:50:21 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: eperezma@redhat.com, jasowang@redhat.com, mst@redhat.com,
 dtatulea@nvidia.com, leiyang@redhat.com, yin31149@gmail.com,
 boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Cc: qemu-devel@nongnu.org
Subject: [PATCH 07/40] vdpa: move around vhost_vdpa_set_address_space_id
Date: Thu,  7 Dec 2023 09:39:20 -0800
Message-Id: <1701970793-6865-8-git-send-email-si-wei.liu@oracle.com>
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
X-Proofpoint-ORIG-GUID: YWerNjCqHu8uuacLiG32N_6fvetHPbuP
X-Proofpoint-GUID: YWerNjCqHu8uuacLiG32N_6fvetHPbuP
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

Move it a few lines ahead to make function call easier for those
before it.  No funtional change involved.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 net/vhost-vdpa.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 1a738b2..dbfa192 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -335,6 +335,24 @@ static void vdpa_net_migration_state_notifier(Notifier *notifier, void *data)
     }
 }
 
+static int vhost_vdpa_set_address_space_id(struct vhost_vdpa *v,
+                                           unsigned vq_group,
+                                           unsigned asid_num)
+{
+    struct vhost_vring_state asid = {
+        .index = vq_group,
+        .num = asid_num,
+    };
+    int r;
+
+    r = ioctl(v->shared->device_fd, VHOST_VDPA_SET_GROUP_ASID, &asid);
+    if (unlikely(r < 0)) {
+        error_report("Can't set vq group %u asid %u, errno=%d (%s)",
+                     asid.index, asid.num, errno, g_strerror(errno));
+    }
+    return r;
+}
+
 static void vhost_vdpa_net_data_start_first(VhostVDPAState *s)
 {
     struct vhost_vdpa *v = &s->vhost_vdpa;
@@ -490,24 +508,6 @@ static int64_t vhost_vdpa_get_vring_desc_group(int device_fd,
     return state.num;
 }
 
-static int vhost_vdpa_set_address_space_id(struct vhost_vdpa *v,
-                                           unsigned vq_group,
-                                           unsigned asid_num)
-{
-    struct vhost_vring_state asid = {
-        .index = vq_group,
-        .num = asid_num,
-    };
-    int r;
-
-    r = ioctl(v->shared->device_fd, VHOST_VDPA_SET_GROUP_ASID, &asid);
-    if (unlikely(r < 0)) {
-        error_report("Can't set vq group %u asid %u, errno=%d (%s)",
-                     asid.index, asid.num, errno, g_strerror(errno));
-    }
-    return r;
-}
-
 static void vhost_vdpa_cvq_unmap_buf(struct vhost_vdpa *v, void *addr)
 {
     VhostIOVATree *tree = v->shared->iova_tree;
-- 
1.8.3.1


