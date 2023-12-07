Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B9C809096
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 19:51:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBJSl-0003mf-Fy; Thu, 07 Dec 2023 13:51:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rBJSM-0003bD-25
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:50:42 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rBJSJ-00074q-3K
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:50:40 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B7HFTxP007979; Thu, 7 Dec 2023 18:50:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=q/OD/SQMRrvfSZtobhfq0UPv1L+/kMxXzcbtd0Vkdy8=;
 b=g52EoJ5jXOZ34zk1SZVNWxuGqQrD2O1C0iQkwXINSzKibrZbw9dd804gBoi52VSG1tCO
 tBrDcsKB0FuZGPC9WSrX6l33SzBlhTSMfoap+9CO5e0gdyMMGQnonN2r+rnWS5imA1SZ
 xpfnmp68OPvQH5Mge1UVb1lejBg6bzX2QzjnL2EUybxJWQEXIGNTjBmuXcHkrjZD3MJw
 7FR3Nv2MlLNthqMr7ZtXkjHlAA//i/CplTj4oJ0CG78KTH2t4bc+/5itGwMJHxbKKuEF
 v05A2uc8LiqRMrvZYc6agSDPebUYvzqDbHpagMhXq3QZaA3Xy0Bw12Ddf4yKR1DKuooy OA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utd0hmjtj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Dec 2023 18:50:36 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B7HW79E039466; Thu, 7 Dec 2023 18:50:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3utan7vhtc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Dec 2023 18:50:35 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B7Io90O008067;
 Thu, 7 Dec 2023 18:50:34 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3utan7vh2k-17; Thu, 07 Dec 2023 18:50:34 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: eperezma@redhat.com, jasowang@redhat.com, mst@redhat.com,
 dtatulea@nvidia.com, leiyang@redhat.com, yin31149@gmail.com,
 boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Cc: qemu-devel@nongnu.org
Subject: [PATCH 16/40] vdpa: indicate SVQ switching via flag
Date: Thu,  7 Dec 2023 09:39:29 -0800
Message-Id: <1701970793-6865-17-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_15,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 adultscore=0 bulkscore=0 mlxlogscore=959
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312070156
X-Proofpoint-GUID: T7qjZS8JQ86YnXnSajyUbZQKDxKYOjEt
X-Proofpoint-ORIG-GUID: T7qjZS8JQ86YnXnSajyUbZQKDxKYOjEt
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

svq_switching indicates the case where SVQ mode change
is on going. Positive (1) means switching from the
normal passthrough mode to SVQ mode, and negative (-1)
meaning switch SVQ back to the passthrough; zero (0)
indicates that there's no SVQ mode switch taking place.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 net/vhost-vdpa.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 7b8f047..04718b2 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -320,6 +320,7 @@ static void vhost_vdpa_net_log_global_enable(VhostVDPAState *s, bool enable)
     data_queue_pairs = n->multiqueue ? n->max_queue_pairs : 1;
     cvq = virtio_vdev_has_feature(vdev, VIRTIO_NET_F_CTRL_VQ) ?
                                   n->max_ncs - n->max_queue_pairs : 0;
+    v->shared->svq_switching = enable ? 1 : -1;
     /*
      * TODO: vhost_net_stop does suspend, get_base and reset. We can be smarter
      * in the future and resume the device if read-only operations between
@@ -332,6 +333,7 @@ static void vhost_vdpa_net_log_global_enable(VhostVDPAState *s, bool enable)
     if (unlikely(r < 0)) {
         error_report("unable to start vhost net: %s(%d)", g_strerror(-r), -r);
     }
+    v->shared->svq_switching = 0;
 }
 
 static void vdpa_net_migration_state_notifier(Notifier *notifier, void *data)
-- 
1.8.3.1


