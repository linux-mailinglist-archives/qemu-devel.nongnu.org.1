Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1547B8090AE
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 19:53:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBJSu-0003yd-HQ; Thu, 07 Dec 2023 13:51:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rBJSq-0003vx-4b
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:51:13 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rBJSl-0007B3-71
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:51:11 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B7InVX5000548; Thu, 7 Dec 2023 18:50:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=i6V4YQb4G5hm1g+p/0CXNDXC0WWgyQ8rR9Uz9vRtnJI=;
 b=R1vXdULLkQlxFJb1tucQB1ZVfGngOrxUv/0BhrJ6/G3Tv69wIEpAsdXhjbSLwi5W66d2
 zhpet4Lf6XFoFpkYvjysxcDzzBsekJxVsoj140CUMzlBtTauPsYsaM5ytloeGMJHKjEI
 DDfDdITw7l95qeaX5NI84Y89Z7Vxml8gh9XIp4HacK1oL2cH71E4wLfywPBHVjI4KT68
 IpVk9QnhjOUvU/Y6loXf372spGaeNpcLBAlJodIC4Wix5eIr1FL3CYp2YVoEiK/G4jws
 geyctaZyTc4fXvAqoRrDz4IWSDr/MStiOgxqK3W6UebzzYZIGEL/PXPhIwR/AjATqasi YQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utd0mmh5t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Dec 2023 18:50:54 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B7HRJYR039470; Thu, 7 Dec 2023 18:50:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3utan7vj8t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Dec 2023 18:50:54 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B7Io90o008067;
 Thu, 7 Dec 2023 18:50:53 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3utan7vh2k-30; Thu, 07 Dec 2023 18:50:53 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: eperezma@redhat.com, jasowang@redhat.com, mst@redhat.com,
 dtatulea@nvidia.com, leiyang@redhat.com, yin31149@gmail.com,
 boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Cc: qemu-devel@nongnu.org
Subject: [PATCH 29/40] vdpa: expose API vhost_vdpa_dma_batch_once
Date: Thu,  7 Dec 2023 09:39:42 -0800
Message-Id: <1701970793-6865-30-git-send-email-si-wei.liu@oracle.com>
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
X-Proofpoint-GUID: CJ0dY195PKGyL1AhpqpBieLNrl9Dqe0z
X-Proofpoint-ORIG-GUID: CJ0dY195PKGyL1AhpqpBieLNrl9Dqe0z
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

So that the batching API can be called from other file
externally than the local.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 hw/virtio/vhost-vdpa.c         | 21 +++++++++++++++------
 include/hw/virtio/vhost-vdpa.h |  3 +++
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index b7896a8..68dc01b 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -187,7 +187,7 @@ static bool vhost_vdpa_map_batch_begin(VhostVDPAShared *s, uint32_t asid)
     return true;
 }
 
-static int vhost_vdpa_dma_batch_begin_once(VhostVDPAShared *s, uint32_t asid)
+int vhost_vdpa_dma_batch_begin_once(VhostVDPAShared *s, uint32_t asid)
 {
     if (!(s->backend_cap & (0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH))) {
         return 0;
@@ -237,7 +237,7 @@ static bool vhost_vdpa_dma_batch_end(VhostVDPAShared *s, uint32_t asid)
     return true;
 }
 
-static int vhost_vdpa_dma_batch_end_once(VhostVDPAShared *s, uint32_t asid)
+int vhost_vdpa_dma_batch_end_once(VhostVDPAShared *s, uint32_t asid)
 {
     if (!(s->backend_cap & (0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH))) {
         return 0;
@@ -436,7 +436,12 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
         iova = mem_region.iova;
     }
 
-    vhost_vdpa_dma_batch_begin_once(s, VHOST_VDPA_GUEST_PA_ASID);
+    ret = vhost_vdpa_dma_batch_begin_once(s, VHOST_VDPA_GUEST_PA_ASID);
+    if (unlikely(ret)) {
+        error_report("Can't batch mapping on asid 0 (%p)", s);
+        goto fail_map;
+    }
+
     ret = vhost_vdpa_dma_map(s, VHOST_VDPA_GUEST_PA_ASID, iova,
                              int128_get64(llsize), vaddr, section->readonly);
     if (ret) {
@@ -518,7 +523,11 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
         iova = result->iova;
         vhost_iova_tree_remove(s->iova_tree, *result);
     }
-    vhost_vdpa_dma_batch_begin_once(s, VHOST_VDPA_GUEST_PA_ASID);
+    ret = vhost_vdpa_dma_batch_begin_once(s, VHOST_VDPA_GUEST_PA_ASID);
+    if (ret) {
+        error_report("Can't batch mapping on asid 0 (%p)", s);
+    }
+
     /*
      * The unmap ioctl doesn't accept a full 64-bit. need to check it
      */
@@ -1396,10 +1405,10 @@ static void *vhost_vdpa_load_map(void *opaque)
                                      msg->iotlb.size);
             break;
         case VHOST_IOTLB_BATCH_BEGIN:
-            vhost_vdpa_dma_batch_begin_once(shared, msg->asid);
+            r = vhost_vdpa_dma_batch_begin_once(shared, msg->asid);
             break;
         case VHOST_IOTLB_BATCH_END:
-            vhost_vdpa_dma_batch_end_once(shared, msg->asid);
+            r = vhost_vdpa_dma_batch_end_once(shared, msg->asid);
             break;
         default:
             error_report("Invalid IOTLB msg type %d", msg->iotlb.type);
diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdpa.h
index 219316f..aa13679 100644
--- a/include/hw/virtio/vhost-vdpa.h
+++ b/include/hw/virtio/vhost-vdpa.h
@@ -106,6 +106,9 @@ int vhost_vdpa_dma_map(VhostVDPAShared *s, uint32_t asid, hwaddr iova,
                        hwaddr size, void *vaddr, bool readonly);
 int vhost_vdpa_dma_unmap(VhostVDPAShared *s, uint32_t asid, hwaddr iova,
                          hwaddr size);
+int vhost_vdpa_dma_batch_begin_once(VhostVDPAShared *s, uint32_t asid);
+int vhost_vdpa_dma_batch_end_once(VhostVDPAShared *s, uint32_t asid);
+
 int vhost_vdpa_load_setup(VhostVDPAShared *s, AddressSpace *dma_as);
 int vhost_vdpa_load_cleanup(VhostVDPAShared *s, bool vhost_will_start);
 
-- 
1.8.3.1


