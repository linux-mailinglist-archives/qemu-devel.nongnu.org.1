Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2F18090CF
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 19:56:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBJT3-00047e-8y; Thu, 07 Dec 2023 13:51:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rBJT1-000435-5e
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:51:23 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rBJSq-0007Dc-PQ
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:51:22 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B7InVX7000548; Thu, 7 Dec 2023 18:51:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=kxSpiE8Ke1O5BLHfgTteE8AERnFgFLmrr+RYhHE9PCg=;
 b=jY9g3wdOmkIfelJ/yBFJy6tK7LjF0+RM21dYA4b5YsbYy+EimVg9CzipYKqpE5EkrieX
 I4fBQ6Y0vpYb9rvuvNSsRITClvZMgFBdMi3gDkucu1xSLMEkQUiLgOGO+WjLA6gc3aMC
 EAd3DyFqFOuJHOw9b6Y8TA7vufWz2OYxqTg4YZU7nwBzz10MbNxeelfKGiTlWpNq42Fj
 Pd/Bp6zH8ZAY3e8pNQVkrSumA3mEbDXbRVJCpm+pHJkmMua5WAoO49EqvWwgZtrWAFen
 FO4wFtisG5xMqZ7asT+h1CGn+VUHX7O38Pax7HNu7Q9CjUr/d74FQHW+BGp+dfUKwIsQ Ew== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utd0mmh64-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Dec 2023 18:51:00 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B7InFf7039579; Thu, 7 Dec 2023 18:50:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3utan7vjct-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Dec 2023 18:50:59 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B7Io90w008067;
 Thu, 7 Dec 2023 18:50:59 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3utan7vh2k-34; Thu, 07 Dec 2023 18:50:59 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: eperezma@redhat.com, jasowang@redhat.com, mst@redhat.com,
 dtatulea@nvidia.com, leiyang@redhat.com, yin31149@gmail.com,
 boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Cc: qemu-devel@nongnu.org
Subject: [PATCH 33/40] vdpa: batch multiple dma_unmap to a single call for vm
 stop
Date: Thu,  7 Dec 2023 09:39:46 -0800
Message-Id: <1701970793-6865-34-git-send-email-si-wei.liu@oracle.com>
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
X-Proofpoint-GUID: Ok6zt6Qx_oseqpQofEMTPRb2ZoIhLeDE
X-Proofpoint-ORIG-GUID: Ok6zt6Qx_oseqpQofEMTPRb2ZoIhLeDE
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

Should help live migration downtime on source host. Below are the
coalesced dma_unmap time series on 2 queue pair config (no
dedicated descriptor group ASID for SVQ).

109531@1693367276.853503:vhost_vdpa_reset_device dev: 0x55c933926890
109531@1693367276.853513:vhost_vdpa_add_status dev: 0x55c933926890 status: 0x3
109531@1693367276.853520:vhost_vdpa_flush_map dev: 0x55c933926890 doit: 1 svq_flush: 0 persist: 1
109531@1693367276.853524:vhost_vdpa_set_config_call dev: 0x55c933926890 fd: -1
109531@1693367276.853579:vhost_vdpa_iotlb_begin_batch vdpa:0x7fa2aa895190 fd: 16 msg_type: 2 type: 5
109531@1693367276.853586:vhost_vdpa_dma_unmap vdpa:0x7fa2aa895190 fd: 16 msg_type: 2 asid: 0 iova: 0x1000 size: 0x2000 type: 3
109531@1693367276.853600:vhost_vdpa_dma_unmap vdpa:0x7fa2aa895190 fd: 16 msg_type: 2 asid: 0 iova: 0x3000 size: 0x1000 type: 3
109531@1693367276.853618:vhost_vdpa_dma_unmap vdpa:0x7fa2aa895190 fd: 16 msg_type: 2 asid: 0 iova: 0x4000 size: 0x2000 type: 3
109531@1693367276.853625:vhost_vdpa_dma_unmap vdpa:0x7fa2aa895190 fd: 16 msg_type: 2 asid: 0 iova: 0x6000 size: 0x1000 type: 3
109531@1693367276.853630:vhost_vdpa_dma_unmap vdpa:0x7fa2aa84c190 fd: 16 msg_type: 2 asid: 0 iova: 0x7000 size: 0x2000 type: 3
109531@1693367276.853636:vhost_vdpa_dma_unmap vdpa:0x7fa2aa84c190 fd: 16 msg_type: 2 asid: 0 iova: 0x9000 size: 0x1000 type: 3
109531@1693367276.853642:vhost_vdpa_dma_unmap vdpa:0x7fa2aa84c190 fd: 16 msg_type: 2 asid: 0 iova: 0xa000 size: 0x2000 type: 3
109531@1693367276.853648:vhost_vdpa_dma_unmap vdpa:0x7fa2aa84c190 fd: 16 msg_type: 2 asid: 0 iova: 0xc000 size: 0x1000 type: 3
109531@1693367276.853654:vhost_vdpa_dma_unmap vdpa:0x7fa2aa6b6190 fd: 16 msg_type: 2 asid: 0 iova: 0xf000 size: 0x1000 type: 3
109531@1693367276.853660:vhost_vdpa_dma_unmap vdpa:0x7fa2aa6b6190 fd: 16 msg_type: 2 asid: 0 iova: 0x10000 size: 0x1000 type: 3
109531@1693367276.853666:vhost_vdpa_dma_unmap vdpa:0x7fa2aa6b6190 fd: 16 msg_type: 2 asid: 0 iova: 0xd000 size: 0x1000 type: 3
109531@1693367276.853670:vhost_vdpa_dma_unmap vdpa:0x7fa2aa6b6190 fd: 16 msg_type: 2 asid: 0 iova: 0xe000 size: 0x1000 type: 3
109531@1693367276.853675:vhost_vdpa_iotlb_end_batch vdpa:0x7fa2aa895190 fd: 16 msg_type: 2 type: 6
109531@1693367277.014697:vhost_vdpa_get_vq_index dev: 0x55c933925de0 idx: 0 vq idx: 0
109531@1693367277.014747:vhost_vdpa_get_vq_index dev: 0x55c933925de0 idx: 1 vq idx: 1
109531@1693367277.014753:vhost_vdpa_get_vq_index dev: 0x55c9339262e0 idx: 2 vq idx: 2
109531@1693367277.014756:vhost_vdpa_get_vq_index dev: 0x55c9339262e0 idx: 3 vq idx: 3

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 hw/virtio/vhost-vdpa.c         |   7 +--
 include/hw/virtio/vhost-vdpa.h |   3 ++
 net/vhost-vdpa.c               | 112 +++++++++++++++++++++++++++--------------
 3 files changed, 80 insertions(+), 42 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index d98704a..4010fd9 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -1162,8 +1162,8 @@ static void vhost_vdpa_svq_unmap_ring(struct vhost_vdpa *v, hwaddr addr)
     vhost_iova_tree_remove(v->shared->iova_tree, *result);
 }
 
-static void vhost_vdpa_svq_unmap_rings(struct vhost_dev *dev,
-                                       const VhostShadowVirtqueue *svq)
+void vhost_vdpa_svq_unmap_rings(struct vhost_dev *dev,
+                                const VhostShadowVirtqueue *svq)
 {
     struct vhost_vdpa *v = dev->opaque;
     struct vhost_vring_addr svq_addr;
@@ -1346,17 +1346,14 @@ static void vhost_vdpa_svqs_stop(struct vhost_dev *dev)
         return;
     }
 
-    vhost_vdpa_dma_batch_begin_once(v->shared, v->address_space_id);
     for (unsigned i = 0; i < v->shadow_vqs->len; ++i) {
         VhostShadowVirtqueue *svq = g_ptr_array_index(v->shadow_vqs, i);
 
         vhost_svq_stop(svq);
-        vhost_vdpa_svq_unmap_rings(dev, svq);
 
         event_notifier_cleanup(&svq->hdev_kick);
         event_notifier_cleanup(&svq->hdev_call);
     }
-    vhost_vdpa_dma_batch_end_once(v->shared, v->address_space_id);
 }
 
 static void vhost_vdpa_suspend(struct vhost_dev *dev)
diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdpa.h
index aa13679..f426e2c 100644
--- a/include/hw/virtio/vhost-vdpa.h
+++ b/include/hw/virtio/vhost-vdpa.h
@@ -112,6 +112,9 @@ int vhost_vdpa_dma_batch_end_once(VhostVDPAShared *s, uint32_t asid);
 int vhost_vdpa_load_setup(VhostVDPAShared *s, AddressSpace *dma_as);
 int vhost_vdpa_load_cleanup(VhostVDPAShared *s, bool vhost_will_start);
 
+void vhost_vdpa_svq_unmap_rings(struct vhost_dev *dev,
+                                const VhostShadowVirtqueue *svq);
+
 typedef struct vdpa_iommu {
     VhostVDPAShared *dev_shared;
     IOMMUMemoryRegion *iommu_mr;
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 683619f..41714d1 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -29,6 +29,7 @@
 #include "migration/migration.h"
 #include "migration/misc.h"
 #include "hw/virtio/vhost.h"
+#include "hw/virtio/vhost-vdpa.h"
 
 /* Todo:need to add the multiqueue support here */
 typedef struct VhostVDPAState {
@@ -467,15 +468,89 @@ static int vhost_vdpa_net_data_load(NetClientState *nc)
     return 0;
 }
 
+static void vhost_vdpa_cvq_unmap_buf(struct vhost_vdpa *v, void *addr)
+{
+    VhostIOVATree *tree = v->shared->iova_tree;
+    DMAMap needle = {
+        /*
+         * No need to specify size or to look for more translations since
+         * this contiguous chunk was allocated by us.
+         */
+        .translated_addr = (hwaddr)(uintptr_t)addr,
+    };
+    const DMAMap *map = vhost_iova_tree_find_iova(tree, &needle);
+    int r;
+
+    if (unlikely(!map)) {
+        error_report("Cannot locate expected map");
+        return;
+    }
+
+    r = vhost_vdpa_dma_unmap(v->shared, v->address_space_id, map->iova,
+                             map->size + 1);
+    if (unlikely(r != 0)) {
+        error_report("Device cannot unmap: %s(%d)", g_strerror(r), r);
+    }
+
+    vhost_iova_tree_remove(tree, *map);
+}
+
 static void vhost_vdpa_net_client_stop(NetClientState *nc)
 {
     VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
+    struct vhost_vdpa *v = &s->vhost_vdpa;
+    struct vhost_vdpa *last_vi = NULL;
+    bool has_cvq = v->dev->vq_index_end % 2;
+    int nvqp;
 
     assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
 
     if (s->vhost_vdpa.index == 0) {
         migration_remove_notifier(&s->migration_state);
     }
+
+    if (v->dev->vq_index + v->dev->nvqs != v->dev->vq_index_end) {
+        return;
+    }
+
+    nvqp = (v->dev->vq_index_end + 1) / 2;
+    for (int i = 0; i < nvqp; ++i) {
+        VhostVDPAState *s_i = vhost_vdpa_net_get_nc_vdpa(s, i);
+        struct vhost_vdpa *v_i = &s_i->vhost_vdpa;
+
+        if (!v_i->shadow_vqs_enabled) {
+            continue;
+        }
+        if (!last_vi) {
+            vhost_vdpa_dma_batch_begin_once(v_i->shared,
+                                            v_i->address_space_id);
+            last_vi = v_i;
+        } else if (last_vi->address_space_id != v_i->address_space_id) {
+            vhost_vdpa_dma_batch_end_once(last_vi->shared,
+                                          last_vi->address_space_id);
+            vhost_vdpa_dma_batch_begin_once(v_i->shared,
+                                            v_i->address_space_id);
+            last_vi = v_i;
+        }
+
+        for (unsigned j = 0; j < v_i->shadow_vqs->len; ++j) {
+            VhostShadowVirtqueue *svq = g_ptr_array_index(v_i->shadow_vqs, j);
+
+            vhost_vdpa_svq_unmap_rings(v_i->dev, svq);
+        }
+    }
+    if (has_cvq) {
+        if (last_vi) {
+            assert(last_vi->address_space_id == v->address_space_id);
+        }
+        vhost_vdpa_cvq_unmap_buf(&s->vhost_vdpa, s->cvq_cmd_out_buffer);
+        vhost_vdpa_cvq_unmap_buf(&s->vhost_vdpa, s->status);
+    }
+    if (last_vi) {
+        vhost_vdpa_dma_batch_end_once(last_vi->shared,
+                                      last_vi->address_space_id);
+        last_vi = NULL;
+    }
 }
 
 static int vhost_vdpa_net_load_setup(NetClientState *nc, NICState *nic)
@@ -585,33 +660,6 @@ static int64_t vhost_vdpa_get_vring_desc_group(int device_fd,
     return state.num;
 }
 
-static void vhost_vdpa_cvq_unmap_buf(struct vhost_vdpa *v, void *addr)
-{
-    VhostIOVATree *tree = v->shared->iova_tree;
-    DMAMap needle = {
-        /*
-         * No need to specify size or to look for more translations since
-         * this contiguous chunk was allocated by us.
-         */
-        .translated_addr = (hwaddr)(uintptr_t)addr,
-    };
-    const DMAMap *map = vhost_iova_tree_find_iova(tree, &needle);
-    int r;
-
-    if (unlikely(!map)) {
-        error_report("Cannot locate expected map");
-        return;
-    }
-
-    r = vhost_vdpa_dma_unmap(v->shared, v->address_space_id, map->iova,
-                             map->size + 1);
-    if (unlikely(r != 0)) {
-        error_report("Device cannot unmap: %s(%d)", g_strerror(r), r);
-    }
-
-    vhost_iova_tree_remove(tree, *map);
-}
-
 /** Map CVQ buffer. */
 static int vhost_vdpa_cvq_map_buf(struct vhost_vdpa *v, void *buf, size_t size,
                                   bool write)
@@ -740,18 +788,8 @@ err:
 
 static void vhost_vdpa_net_cvq_stop(NetClientState *nc)
 {
-    VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
-    struct vhost_vdpa *v = &s->vhost_vdpa;
-
     assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
 
-    if (s->vhost_vdpa.shadow_vqs_enabled) {
-        vhost_vdpa_dma_batch_begin_once(v->shared, v->address_space_id);
-        vhost_vdpa_cvq_unmap_buf(&s->vhost_vdpa, s->cvq_cmd_out_buffer);
-        vhost_vdpa_cvq_unmap_buf(&s->vhost_vdpa, s->status);
-        vhost_vdpa_dma_batch_end_once(v->shared, v->address_space_id);
-    }
-
     vhost_vdpa_net_client_stop(nc);
 }
 
-- 
1.8.3.1


