Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7683809098
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 19:51:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBJSq-0003w4-V2; Thu, 07 Dec 2023 13:51:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rBJSb-0003dE-FJ
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:50:58 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rBJSW-00079N-LL
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:50:56 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B7InVX4000548; Thu, 7 Dec 2023 18:50:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=6xgia7g1oUY0RjFvspZ/n8yXNYyUzWdL6U6DAU8F9r4=;
 b=hTnDnabomVnFFgH2CoIwMKRwtZ4aTSVcbwN8akolzv3wU2OpRwPR8gTeM+ImcmPWNJv+
 8Dx8aU86W3lr0PUPmH9BSkGkj5s6AgMm7eLUlL7ZgMBUUW+iqkL3O7UuJDAGaM01Qag2
 adFZ7GUxcdFCU13xYsVW4hEybj75rX5iiZ3lDGotkxvu5qsBnPWXPWfBQOWtGV+74woT
 tdyNr5u1YyZIL+VJ/oS5wGyi6clp9E2uHQzO3eN4L2zkqTVKsTCUoaBBKRFN1LMlxHAh
 v6KxEJrFv5Npw4pUfJnNEq3NkL1vspIeE+Ja7SxtuqQ5p7b/Sy1wi9xv4899D8bGTGc9 EA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utd0mmh5n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Dec 2023 18:50:50 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B7HVFSx039488; Thu, 7 Dec 2023 18:50:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3utan7vj6c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Dec 2023 18:50:49 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B7Io90i008067;
 Thu, 7 Dec 2023 18:50:49 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3utan7vh2k-27; Thu, 07 Dec 2023 18:50:49 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: eperezma@redhat.com, jasowang@redhat.com, mst@redhat.com,
 dtatulea@nvidia.com, leiyang@redhat.com, yin31149@gmail.com,
 boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Cc: qemu-devel@nongnu.org
Subject: [PATCH 26/40] vdpa: return int for dma_batch_once API
Date: Thu,  7 Dec 2023 09:39:39 -0800
Message-Id: <1701970793-6865-27-git-send-email-si-wei.liu@oracle.com>
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
X-Proofpoint-GUID: QJXnP9B189LUqMPQkKgFaTfqPY7WUPVl
X-Proofpoint-ORIG-GUID: QJXnP9B189LUqMPQkKgFaTfqPY7WUPVl
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

Return zero for success for now. Prepare for non-zero return
in the next few patches.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 hw/virtio/vhost-vdpa.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 2db2832..e0137f0 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -187,16 +187,18 @@ static bool vhost_vdpa_map_batch_begin(VhostVDPAShared *s, uint32_t asid)
     return true;
 }
 
-static void vhost_vdpa_dma_batch_begin_once(VhostVDPAShared *s)
+static int vhost_vdpa_dma_batch_begin_once(VhostVDPAShared *s)
 {
     if (!(s->backend_cap & (0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH)) ||
         s->iotlb_batch_begin_sent) {
-        return;
+        return 0;
     }
 
     if (vhost_vdpa_map_batch_begin(s, 0)) {
         s->iotlb_batch_begin_sent = true;
     }
+
+    return 0;
 }
 
 static bool vhost_vdpa_dma_batch_end(VhostVDPAShared *s, uint32_t asid)
@@ -225,19 +227,21 @@ static bool vhost_vdpa_dma_batch_end(VhostVDPAShared *s, uint32_t asid)
     return true;
 }
 
-static void vhost_vdpa_dma_batch_end_once(VhostVDPAShared *s)
+static int vhost_vdpa_dma_batch_end_once(VhostVDPAShared *s)
 {
     if (!(s->backend_cap & (0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH))) {
-        return;
+        return 0;
     }
 
     if (!s->iotlb_batch_begin_sent) {
-        return;
+        return 0;
     }
 
     if (vhost_vdpa_dma_batch_end(s, 0)) {
         s->iotlb_batch_begin_sent = false;
     }
+
+    return 0;
 }
 
 static void vhost_vdpa_listener_commit(MemoryListener *listener)
-- 
1.8.3.1


