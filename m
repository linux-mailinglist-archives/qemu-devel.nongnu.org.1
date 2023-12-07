Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0038090AD
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 19:53:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBJSu-0003yj-MK; Thu, 07 Dec 2023 13:51:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rBJSd-0003dq-IL
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:50:59 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rBJSa-0007Ab-7s
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:50:59 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B7HVcZ3010797; Thu, 7 Dec 2023 18:50:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=MS8ZsyDAdKAh6RiaLiKLs0LxEX3ZzPIG9eACCh1nyIQ=;
 b=KRfkzehqZY+grL0T/CA66mzcVnpwjYGhJUZk3i/JZ25wJrQmGp1CguKHLzcPuy3YUZDZ
 foWczM37A0fQr3Vte1CLmmsK4PjNMoxATLF5VJgivSSyhOoYpwk8MP8WFUroqS1Cf1uk
 3pPkGotqqrt/IMq5vNiHaKcryshPIEtHETmwBnSMYjQOQR9yyN+Geyc9Lp8+o8yDZVnv
 Dr/0S4iA+F/0iqouV88wmpnn26W2Ab75xK4XVqpgb0YZMYNouAaypnd3zcn0EXlwdcfM
 NKzit8yOi4nF5B5AUOpt31tOSVZJuTe/M33tNuDr7fP/35nrE8K1UsOtrFXaLpRlz7Ff aA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utdc1cg0b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Dec 2023 18:50:53 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B7Hcvr8039979; Thu, 7 Dec 2023 18:50:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3utan7vj81-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Dec 2023 18:50:52 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B7Io90m008067;
 Thu, 7 Dec 2023 18:50:52 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3utan7vh2k-29; Thu, 07 Dec 2023 18:50:52 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: eperezma@redhat.com, jasowang@redhat.com, mst@redhat.com,
 dtatulea@nvidia.com, leiyang@redhat.com, yin31149@gmail.com,
 boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Cc: qemu-devel@nongnu.org
Subject: [PATCH 28/40] vdpa: support iotlb_batch_asid
Date: Thu,  7 Dec 2023 09:39:41 -0800
Message-Id: <1701970793-6865-29-git-send-email-si-wei.liu@oracle.com>
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
X-Proofpoint-GUID: xIk5cnj65ZpX3U_GR0QXTYhXhSti7wS-
X-Proofpoint-ORIG-GUID: xIk5cnj65ZpX3U_GR0QXTYhXhSti7wS-
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

Then it's possible to specify ASID when calling the DMA
batching API. If the ASID to work on doesn't align with
the ASID for ongoing transaction, the API will fail the
request and return negative, and the transaction will
remain intact as if no failed request ever had occured.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 hw/virtio/vhost-vdpa.c         | 25 +++++++++++++++++++------
 include/hw/virtio/vhost-vdpa.h |  1 +
 net/vhost-vdpa.c               |  1 +
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index d3f5721..b7896a8 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -189,15 +189,25 @@ static bool vhost_vdpa_map_batch_begin(VhostVDPAShared *s, uint32_t asid)
 
 static int vhost_vdpa_dma_batch_begin_once(VhostVDPAShared *s, uint32_t asid)
 {
-    if (!(s->backend_cap & (0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH)) ||
-        s->iotlb_batch_begin_sent) {
+    if (!(s->backend_cap & (0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH))) {
         return 0;
     }
 
-    if (vhost_vdpa_map_batch_begin(s, asid)) {
-        s->iotlb_batch_begin_sent = true;
+    if (s->iotlb_batch_begin_sent && s->iotlb_batch_asid != asid) {
+        return -1;
+    }
+
+    if (s->iotlb_batch_begin_sent) {
+        return 0;
     }
 
+    if (!vhost_vdpa_map_batch_begin(s, asid)) {
+        return 0;
+    }
+
+    s->iotlb_batch_begin_sent = true;
+    s->iotlb_batch_asid = asid;
+
     return 0;
 }
 
@@ -237,10 +247,13 @@ static int vhost_vdpa_dma_batch_end_once(VhostVDPAShared *s, uint32_t asid)
         return 0;
     }
 
-    if (vhost_vdpa_dma_batch_end(s, asid)) {
-        s->iotlb_batch_begin_sent = false;
+    if (!vhost_vdpa_dma_batch_end(s, asid)) {
+        return 0;
     }
 
+    s->iotlb_batch_begin_sent = false;
+    s->iotlb_batch_asid = -1;
+
     return 0;
 }
 
diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdpa.h
index 0fe0f60..219316f 100644
--- a/include/hw/virtio/vhost-vdpa.h
+++ b/include/hw/virtio/vhost-vdpa.h
@@ -61,6 +61,7 @@ typedef struct vhost_vdpa_shared {
     bool map_thread_enabled;
 
     bool iotlb_batch_begin_sent;
+    uint32_t iotlb_batch_asid;
 
     /*
      * The memory listener has been registered, so DMA maps have been sent to
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index e9b96ed..bc72345 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -1933,6 +1933,7 @@ static NetClientState *net_vhost_vdpa_init(NetClientState *peer,
         s->vhost_vdpa.shared->device_fd = vdpa_device_fd;
         s->vhost_vdpa.shared->iova_range = iova_range;
         s->vhost_vdpa.shared->shadow_data = svq;
+        s->vhost_vdpa.shared->iotlb_batch_asid = -1;
         s->vhost_vdpa.shared->refcnt++;
     } else if (!is_datapath) {
         s->cvq_cmd_out_buffer = mmap(NULL, vhost_vdpa_net_cvq_cmd_page_len(),
-- 
1.8.3.1


