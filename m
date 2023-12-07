Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59ABB8090DF
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 19:58:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBJTK-0004R9-43; Thu, 07 Dec 2023 13:51:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rBJT5-00049K-HA
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:51:27 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rBJSy-0007EX-D1
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:51:27 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B7EtJQQ015896; Thu, 7 Dec 2023 18:51:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=guD/rAL4AbaDzj4AqYJSf7e69luBS3Cz3m5iSUNPG84=;
 b=fSvndbRqFCmowwBNZziieAJr0s/cAI7xJRbhcr8y05J8Y1EjZQQoveG6j2QEnPCt/tXb
 f2XZ+dOCjrLTlhJzUrDpHpddEk6q/9p1ltLafYmQEdn5muLkZEKECp2EKHT6bFsgiOT0
 iSNQ3zpt4WDJ7z8X6pBSGxAl8ULE8Uo4vq5hHeKYDuEwGRb4DwJE+r0h7vEZ1AclSqMc
 yMOAzCkGhrNY7qrJxeGnke+XJTVJyk9VMmMOUMsJ7xPQvw2anOEmYgtVkl1Gaw8dtuTO
 K4sYWo9KojT6cgFFSr8Pu7AzSAaL4GjHtB4i0tO/lr5suzk+L0jDjJ5Yh0R3ulNGTHoR Ng== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utdmbmntt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Dec 2023 18:51:08 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B7InXqH039476; Thu, 7 Dec 2023 18:51:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3utan7vjgs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Dec 2023 18:51:07 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B7Io918008067;
 Thu, 7 Dec 2023 18:51:06 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3utan7vh2k-39; Thu, 07 Dec 2023 18:51:06 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: eperezma@redhat.com, jasowang@redhat.com, mst@redhat.com,
 dtatulea@nvidia.com, leiyang@redhat.com, yin31149@gmail.com,
 boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Cc: qemu-devel@nongnu.org
Subject: [PATCH 38/40] vdpa: add trace events for eval_flush
Date: Thu,  7 Dec 2023 09:39:51 -0800
Message-Id: <1701970793-6865-39-git-send-email-si-wei.liu@oracle.com>
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
X-Proofpoint-ORIG-GUID: aLQAQNz4LNudA147DlFBEZSSvsO5-Ay2
X-Proofpoint-GUID: aLQAQNz4LNudA147DlFBEZSSvsO5-Ay2
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

For better debuggability and observability.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 net/trace-events | 2 ++
 net/vhost-vdpa.c | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/net/trace-events b/net/trace-events
index aab666a..d650c71 100644
--- a/net/trace-events
+++ b/net/trace-events
@@ -26,3 +26,5 @@ colo_filter_rewriter_conn_offset(uint32_t offset) ": offset=%u"
 
 # vhost-vdpa.c
 vhost_vdpa_set_address_space_id(void *v, unsigned vq_group, unsigned asid_num) "vhost_vdpa: %p vq_group: %u asid: %u"
+vhost_vdpa_net_data_eval_flush(void *s, int qindex, int svq_switch, bool svq_flush) "vhost_vdpa: %p qp: %d svq_switch: %d flush_map: %d"
+vhost_vdpa_net_cvq_eval_flush(void *s, int qindex, int svq_switch, bool svq_flush) "vhost_vdpa: %p qp: %d svq_switch: %d flush_map: %d"
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 84876b0..a0bd8cd 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -608,6 +608,9 @@ static void vhost_vdpa_net_data_eval_flush(NetClientState *nc, bool stop)
                v->desc_group < 0) {
         v->shared->flush_map = true;
     }
+    trace_vhost_vdpa_net_data_eval_flush(v, s->vhost_vdpa.index,
+                                        v->shared->svq_switching,
+                                        v->shared->flush_map);
 }
 
 static NetClientInfo net_vhost_vdpa_info = {
@@ -1457,6 +1460,10 @@ static void vhost_vdpa_net_cvq_eval_flush(NetClientState *nc, bool stop)
         !s->cvq_isolated && v->desc_group < 0) {
         v->shared->flush_map = true;
     }
+
+    trace_vhost_vdpa_net_cvq_eval_flush(v, s->vhost_vdpa.index,
+                                       v->shared->svq_switching,
+                                       v->shared->flush_map);
 }
 
 static NetClientInfo net_vhost_vdpa_cvq_info = {
-- 
1.8.3.1


