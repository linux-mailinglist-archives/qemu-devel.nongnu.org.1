Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1188090D3
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 19:57:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBJSj-0003eX-3X; Thu, 07 Dec 2023 13:51:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rBJSL-0003bC-VD
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:50:42 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rBJSJ-000750-4N
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:50:40 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B7IJEpq006221; Thu, 7 Dec 2023 18:50:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=DAJgRMVF30Cp8qjJnARfP/QyVuDoThEW/b3dYAUZDFA=;
 b=SsiFgE/It4NP+DNrlL/5otSYr8bt53TZF8qVdpClG0OML2pAAvwGeKN+vikiaBr02Hq1
 PqZ1qTSob7MzAxguAcEkxhBvEkFGv7VuCkxciiY6vXHZJgRb04Hh3yNr53AG3rHQroa8
 GsWUOCOEDRaXvf33o/LnJNZ5KCe0ZDSKkIboNtNqk7aJLxyR+sRa7hYX3o3fV3XSz/ZS
 wLtINid2rix7QuWAD6tvV4wXhtPc74yvc0xknhz7x0Qz8VrHNac73YVLurxPYYWY63pa
 e844cyzLjpvGhwh9VMXXUTxy18iDl+LDNREdLqsFv7CRsICQgaeLKkeHQlcZ/mKCwTkB Dg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utdabvgds-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Dec 2023 18:50:37 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B7IltL1039527; Thu, 7 Dec 2023 18:50:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3utan7vhup-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Dec 2023 18:50:36 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B7Io90Q008067;
 Thu, 7 Dec 2023 18:50:36 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3utan7vh2k-18; Thu, 07 Dec 2023 18:50:36 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: eperezma@redhat.com, jasowang@redhat.com, mst@redhat.com,
 dtatulea@nvidia.com, leiyang@redhat.com, yin31149@gmail.com,
 boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Cc: qemu-devel@nongnu.org
Subject: [PATCH 17/40] vdpa: judge if map can be kept across reset
Date: Thu,  7 Dec 2023 09:39:30 -0800
Message-Id: <1701970793-6865-18-git-send-email-si-wei.liu@oracle.com>
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
X-Proofpoint-ORIG-GUID: flPk4cZaL6HQcNu2WbdikwEePuRy0azc
X-Proofpoint-GUID: flPk4cZaL6HQcNu2WbdikwEePuRy0azc
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

The descriptor group for SVQ ASID allows the guest memory mapping
to retain across SVQ switching, same as how isolated CVQ can do
with a different ASID than the guest GPA space. Introduce an
evaluation function to judge whether to flush or keep iotlb maps
based on virtqueue's descriptor group and cvq isolation capability.

Have to hook the evaluation function to NetClient's .poll op as
.vhost_reset_status runs ahead of .stop, and .vhost_dev_start
don't have access to the vhost-vdpa net's information.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 net/vhost-vdpa.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 04718b2..e9b96ed 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -504,12 +504,36 @@ static int vhost_vdpa_net_load_cleanup(NetClientState *nc, NICState *nic)
                              n->parent_obj.status & VIRTIO_CONFIG_S_DRIVER_OK);
 }
 
+static void vhost_vdpa_net_data_eval_flush(NetClientState *nc, bool stop)
+{
+    VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
+    struct vhost_vdpa *v = &s->vhost_vdpa;
+
+    if (!stop) {
+        return;
+    }
+
+    if (s->vhost_vdpa.index == 0) {
+        if (s->always_svq) {
+            v->shared->flush_map = true;
+        } else if (!v->shared->svq_switching || v->desc_group >= 0) {
+            v->shared->flush_map = false;
+        } else {
+            v->shared->flush_map = true;
+        }
+    } else if (!s->always_svq && v->shared->svq_switching &&
+               v->desc_group < 0) {
+        v->shared->flush_map = true;
+    }
+}
+
 static NetClientInfo net_vhost_vdpa_info = {
         .type = NET_CLIENT_DRIVER_VHOST_VDPA,
         .size = sizeof(VhostVDPAState),
         .receive = vhost_vdpa_receive,
         .start = vhost_vdpa_net_data_start,
         .load = vhost_vdpa_net_data_load,
+        .poll = vhost_vdpa_net_data_eval_flush,
         .stop = vhost_vdpa_net_client_stop,
         .cleanup = vhost_vdpa_cleanup,
         .has_vnet_hdr = vhost_vdpa_has_vnet_hdr,
@@ -1368,12 +1392,28 @@ static int vhost_vdpa_net_cvq_load(NetClientState *nc)
     return 0;
 }
 
+static void vhost_vdpa_net_cvq_eval_flush(NetClientState *nc, bool stop)
+{
+    VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
+    struct vhost_vdpa *v = &s->vhost_vdpa;
+
+    if (!stop) {
+        return;
+    }
+
+    if (!v->shared->flush_map && !v->shared->svq_switching &&
+        !s->cvq_isolated && v->desc_group < 0) {
+        v->shared->flush_map = true;
+    }
+}
+
 static NetClientInfo net_vhost_vdpa_cvq_info = {
     .type = NET_CLIENT_DRIVER_VHOST_VDPA,
     .size = sizeof(VhostVDPAState),
     .receive = vhost_vdpa_receive,
     .start = vhost_vdpa_net_cvq_start,
     .load = vhost_vdpa_net_cvq_load,
+    .poll = vhost_vdpa_net_cvq_eval_flush,
     .stop = vhost_vdpa_net_cvq_stop,
     .cleanup = vhost_vdpa_cleanup,
     .has_vnet_hdr = vhost_vdpa_has_vnet_hdr,
-- 
1.8.3.1


