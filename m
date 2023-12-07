Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A608090B5
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 19:54:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBJSe-0003cs-7k; Thu, 07 Dec 2023 13:51:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rBJSG-0003Ym-QQ
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:50:37 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rBJSE-00074A-Mv
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:50:36 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B7GDP6M031570; Thu, 7 Dec 2023 18:50:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=e0mpqwBWjWSiuQVcV0ZNzMbrYl/rSZxxr7/pXeGCxhg=;
 b=WKTjdpyJb9DfeGSt3HQz3MFCe+mTiE3INyI3GLxJQIor33DtlGu+KNPeL11m0JYeRKD7
 wbhJ3P5qa+mFXByWHUNj1+ps5D4YNbtH6ZhxUnBKxaLk6rV72LJ3KUm0EdWSaOe32rFq
 MfVvzbUezhxzyQ9IH/Mg5q22FxG2G7ZOxYZNL1jeYRQhXD77aDaWy9TgTGrMXoG4Q/YA
 90aJyDncdmWLGgA706U/MqG6caIaBny0Rdhly9M+OOobNUsTzTKnhJsf2W3FUMD0ykZU
 j8qvWLv+10p3FivS2dgu9uZ7LcOzoyFVYjAtobveClXgFBxjUsS6xTHkbEW/AjGmgB6X bA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utdrvmpf8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Dec 2023 18:50:33 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B7HW79B039466; Thu, 7 Dec 2023 18:50:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3utan7vhqp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Dec 2023 18:50:32 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B7Io90K008067;
 Thu, 7 Dec 2023 18:50:31 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3utan7vh2k-15; Thu, 07 Dec 2023 18:50:31 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: eperezma@redhat.com, jasowang@redhat.com, mst@redhat.com,
 dtatulea@nvidia.com, leiyang@redhat.com, yin31149@gmail.com,
 boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Cc: qemu-devel@nongnu.org
Subject: [PATCH 14/40] vdpa: convert iova_tree to ref count based
Date: Thu,  7 Dec 2023 09:39:27 -0800
Message-Id: <1701970793-6865-15-git-send-email-si-wei.liu@oracle.com>
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
X-Proofpoint-GUID: G7S8G0A10AUV155r3ZU6Dkd7LnaxHw3A
X-Proofpoint-ORIG-GUID: G7S8G0A10AUV155r3ZU6Dkd7LnaxHw3A
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

So that it can be freed from vhost_vdpa_cleanup on
the last deref. The next few patches will try to
make iova tree life cycle not depend on memory
listener, and there's possiblity to keep iova tree
around when memory mapping is not changed across
device reset.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 net/vhost-vdpa.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index a126e5c..7b8f047 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -238,6 +238,8 @@ static void vhost_vdpa_cleanup(NetClientState *nc)
     }
     if (--s->vhost_vdpa.shared->refcnt == 0) {
         qemu_close(s->vhost_vdpa.shared->device_fd);
+        g_clear_pointer(&s->vhost_vdpa.shared->iova_tree,
+                        vhost_iova_tree_delete);
         g_free(s->vhost_vdpa.shared);
     }
     s->vhost_vdpa.shared = NULL;
@@ -461,19 +463,12 @@ static int vhost_vdpa_net_data_load(NetClientState *nc)
 static void vhost_vdpa_net_client_stop(NetClientState *nc)
 {
     VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
-    struct vhost_dev *dev;
 
     assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
 
     if (s->vhost_vdpa.index == 0) {
         migration_remove_notifier(&s->migration_state);
     }
-
-    dev = s->vhost_vdpa.dev;
-    if (dev->vq_index + dev->nvqs == dev->vq_index_end) {
-        g_clear_pointer(&s->vhost_vdpa.shared->iova_tree,
-                        vhost_iova_tree_delete);
-    }
 }
 
 static int vhost_vdpa_net_load_setup(NetClientState *nc, NICState *nic)
-- 
1.8.3.1


