Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D82A386F0
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Feb 2025 15:51:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk2RT-0005hL-NT; Mon, 17 Feb 2025 09:49:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1tk2RR-0005h2-SY
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 09:49:49 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1tk2RP-0005Ei-9a
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 09:49:49 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51HEMZZ0023164;
 Mon, 17 Feb 2025 14:49:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=uRXnMoAhN/+4CXN4Uffthi0uDxS28qNOhsyVHVLAdNA=; b=
 KmILrjoxQuCR1gLyfUyHoxQMOg9d+fy4MkWl7GbvX1ZZQxCOaowrXnoZATzsedlh
 bG1S+pk3DR1J/SNSCYrvrMrI+uKUQQqpaNA63jojoRElJXQ6+tbGnnJf9NpxuXQs
 CoTRkg/G/z6eNuhsU0n8u/OvXuwN8QbuTp0BoyWPn+3zZVm+WroREGXHO6HOBWBb
 cZjGy8foj0AzHm8S4kXFLHcNKxVHFyUbqhYQPVYjrqhp6tuEPsgpPoFgVYFAy32k
 3BMjf+wShEnGdVfaVERNDycZrydbviJAPgHVTdkqzP8a0NJTtiQy/jRT6agZnUdZ
 5cg0vqQiNds2d3XZr6NXzw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44tjhscfwh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Feb 2025 14:49:44 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51HE1PSD024964; Mon, 17 Feb 2025 14:49:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44thc8036x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Feb 2025 14:49:43 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51HEndFa020797;
 Mon, 17 Feb 2025 14:49:42 GMT
Received: from jonah-ol8.us.oracle.com
 (dhcp-10-43-68-193.usdhcp.oraclecorp.com [10.43.68.193])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 44thc8033q-2; Mon, 17 Feb 2025 14:49:42 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: eperezma@redhat.com, mst@redhat.com, leiyang@redhat.com, peterx@redhat.com,
 dtatulea@nvidia.com, jasowang@redhat.com, si-wei.liu@oracle.com,
 boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Subject: [PATCH v2 1/3] vhost-iova-tree: Implement an IOVA-only tree
Date: Mon, 17 Feb 2025 09:49:32 -0500
Message-ID: <20250217144936.3589907-2-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250217144936.3589907-1-jonah.palmer@oracle.com>
References: <20250217144936.3589907-1-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_06,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502170125
X-Proofpoint-GUID: DziL2EyoVgnOtw7X5DtC-2wQo_zEV3Ii
X-Proofpoint-ORIG-GUID: DziL2EyoVgnOtw7X5DtC-2wQo_zEV3Ii
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Creates and supports an IOVA-only tree to support a SVQ IOVA->HVA and
GPA->IOVA tree for host-only and guest-backed memory, respectively, in
the next patch.

The IOVA allocator still allocates an IOVA range but now adds this range
to the IOVA-only tree as well as to the full IOVA->HVA tree.

In the next patch, the full IOVA->HVA tree will be split into a partial
SVQ IOVA->HVA tree and a GPA->IOVA tree. The motivation behind having an
IOVA-only tree was to have a single tree that would keep track of all
allocated IOVA ranges between the partial SVQ IOVA->HVA and GPA->IOVA
trees.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
---
 hw/virtio/vhost-iova-tree.c | 26 ++++++++++++++++++++------
 hw/virtio/vhost-iova-tree.h |  3 ++-
 hw/virtio/vhost-vdpa.c      | 29 +++++++++++++++++++++--------
 net/vhost-vdpa.c            | 10 ++++++++--
 4 files changed, 51 insertions(+), 17 deletions(-)

diff --git a/hw/virtio/vhost-iova-tree.c b/hw/virtio/vhost-iova-tree.c
index 3d03395a77..216885aa3c 100644
--- a/hw/virtio/vhost-iova-tree.c
+++ b/hw/virtio/vhost-iova-tree.c
@@ -28,6 +28,9 @@ struct VhostIOVATree {
 
     /* IOVA address to qemu memory maps. */
     IOVATree *iova_taddr_map;
+
+    /* Allocated IOVA addresses */
+    IOVATree *iova_map;
 };
 
 /**
@@ -44,6 +47,7 @@ VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, hwaddr iova_last)
     tree->iova_last = iova_last;
 
     tree->iova_taddr_map = iova_tree_new();
+    tree->iova_map = iova_tree_new();
     return tree;
 }
 
@@ -53,6 +57,7 @@ VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, hwaddr iova_last)
 void vhost_iova_tree_delete(VhostIOVATree *iova_tree)
 {
     iova_tree_destroy(iova_tree->iova_taddr_map);
+    iova_tree_destroy(iova_tree->iova_map);
     g_free(iova_tree);
 }
 
@@ -75,6 +80,7 @@ const DMAMap *vhost_iova_tree_find_iova(const VhostIOVATree *tree,
  *
  * @tree: The iova tree
  * @map: The iova map
+ * @taddr: The translated address (HVA)
  *
  * Returns:
  * - IOVA_OK if the map fits in the container
@@ -83,19 +89,26 @@ const DMAMap *vhost_iova_tree_find_iova(const VhostIOVATree *tree,
  *
  * It returns assignated iova in map->iova if return value is VHOST_DMA_MAP_OK.
  */
-int vhost_iova_tree_map_alloc(VhostIOVATree *tree, DMAMap *map)
+int vhost_iova_tree_map_alloc(VhostIOVATree *tree, DMAMap *map, hwaddr taddr)
 {
+    int ret;
+
     /* Some vhost devices do not like addr 0. Skip first page */
     hwaddr iova_first = tree->iova_first ?: qemu_real_host_page_size();
 
-    if (map->translated_addr + map->size < map->translated_addr ||
-        map->perm == IOMMU_NONE) {
+    if (taddr + map->size < taddr || map->perm == IOMMU_NONE) {
         return IOVA_ERR_INVALID;
     }
 
-    /* Allocate a node in IOVA address */
-    return iova_tree_alloc_map(tree->iova_taddr_map, map, iova_first,
-                               tree->iova_last);
+    /* Allocate a node in the IOVA-only tree */
+    ret = iova_tree_alloc_map(tree->iova_map, map, iova_first, tree->iova_last);
+    if (unlikely(ret != IOVA_OK)) {
+        return ret;
+    }
+
+    /* Insert a node in the IOVA->HVA tree */
+    map->translated_addr = taddr;
+    return iova_tree_insert(tree->iova_taddr_map, map);
 }
 
 /**
@@ -107,4 +120,5 @@ int vhost_iova_tree_map_alloc(VhostIOVATree *tree, DMAMap *map)
 void vhost_iova_tree_remove(VhostIOVATree *iova_tree, DMAMap map)
 {
     iova_tree_remove(iova_tree->iova_taddr_map, map);
+    iova_tree_remove(iova_tree->iova_map, map);
 }
diff --git a/hw/virtio/vhost-iova-tree.h b/hw/virtio/vhost-iova-tree.h
index 4adfd79ff0..525ce72b1d 100644
--- a/hw/virtio/vhost-iova-tree.h
+++ b/hw/virtio/vhost-iova-tree.h
@@ -21,7 +21,8 @@ G_DEFINE_AUTOPTR_CLEANUP_FUNC(VhostIOVATree, vhost_iova_tree_delete);
 
 const DMAMap *vhost_iova_tree_find_iova(const VhostIOVATree *iova_tree,
                                         const DMAMap *map);
-int vhost_iova_tree_map_alloc(VhostIOVATree *iova_tree, DMAMap *map);
+int vhost_iova_tree_map_alloc(VhostIOVATree *iova_tree, DMAMap *map,
+                              hwaddr taddr);
 void vhost_iova_tree_remove(VhostIOVATree *iova_tree, DMAMap map);
 
 #endif
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 3cdaa12ed5..703dcfc929 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -360,14 +360,20 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
     llsize = int128_sub(llend, int128_make64(iova));
     if (s->shadow_data) {
         int r;
+        hwaddr hw_vaddr = (hwaddr)(uintptr_t)vaddr;
 
-        mem_region.translated_addr = (hwaddr)(uintptr_t)vaddr,
         mem_region.size = int128_get64(llsize) - 1,
         mem_region.perm = IOMMU_ACCESS_FLAG(true, section->readonly),
 
-        r = vhost_iova_tree_map_alloc(s->iova_tree, &mem_region);
+        r = vhost_iova_tree_map_alloc(s->iova_tree, &mem_region, hw_vaddr);
         if (unlikely(r != IOVA_OK)) {
             error_report("Can't allocate a mapping (%d)", r);
+
+            if (mem_region.translated_addr == hw_vaddr) {
+                error_report("Insertion to IOVA->HVA tree failed");
+                /* Remove the mapping from the IOVA-only tree */
+                goto fail_map;
+            }
             goto fail;
         }
 
@@ -1142,16 +1148,23 @@ static void vhost_vdpa_svq_unmap_rings(struct vhost_dev *dev,
  *
  * @v: Vhost-vdpa device
  * @needle: The area to search iova
+ * @taddr: The translated address (HVA)
  * @errorp: Error pointer
  */
 static bool vhost_vdpa_svq_map_ring(struct vhost_vdpa *v, DMAMap *needle,
-                                    Error **errp)
+                                    hwaddr taddr, Error **errp)
 {
     int r;
 
-    r = vhost_iova_tree_map_alloc(v->shared->iova_tree, needle);
+    r = vhost_iova_tree_map_alloc(v->shared->iova_tree, needle, taddr);
     if (unlikely(r != IOVA_OK)) {
         error_setg(errp, "Cannot allocate iova (%d)", r);
+
+        if (needle->translated_addr == taddr) {
+            error_append_hint(errp, "Insertion to IOVA->HVA tree failed");
+            /* Remove the mapping from the IOVA-only tree */
+            vhost_iova_tree_remove(v->shared->iova_tree, *needle);
+        }
         return false;
     }
 
@@ -1192,11 +1205,11 @@ static bool vhost_vdpa_svq_map_rings(struct vhost_dev *dev,
     vhost_svq_get_vring_addr(svq, &svq_addr);
 
     driver_region = (DMAMap) {
-        .translated_addr = svq_addr.desc_user_addr,
         .size = driver_size - 1,
         .perm = IOMMU_RO,
     };
-    ok = vhost_vdpa_svq_map_ring(v, &driver_region, errp);
+    ok = vhost_vdpa_svq_map_ring(v, &driver_region, svq_addr.desc_user_addr,
+                                 errp);
     if (unlikely(!ok)) {
         error_prepend(errp, "Cannot create vq driver region: ");
         return false;
@@ -1206,11 +1219,11 @@ static bool vhost_vdpa_svq_map_rings(struct vhost_dev *dev,
     addr->avail_user_addr = driver_region.iova + avail_offset;
 
     device_region = (DMAMap) {
-        .translated_addr = svq_addr.used_user_addr,
         .size = device_size - 1,
         .perm = IOMMU_RW,
     };
-    ok = vhost_vdpa_svq_map_ring(v, &device_region, errp);
+    ok = vhost_vdpa_svq_map_ring(v, &device_region, svq_addr.used_user_addr,
+                                 errp);
     if (unlikely(!ok)) {
         error_prepend(errp, "Cannot create vq device region: ");
         vhost_vdpa_svq_unmap_ring(v, driver_region.translated_addr);
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 231b45246c..5a3a57203d 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -510,14 +510,20 @@ static int vhost_vdpa_cvq_map_buf(struct vhost_vdpa *v, void *buf, size_t size,
                                   bool write)
 {
     DMAMap map = {};
+    hwaddr taddr = (hwaddr)(uintptr_t)buf;
     int r;
 
-    map.translated_addr = (hwaddr)(uintptr_t)buf;
     map.size = size - 1;
     map.perm = write ? IOMMU_RW : IOMMU_RO,
-    r = vhost_iova_tree_map_alloc(v->shared->iova_tree, &map);
+    r = vhost_iova_tree_map_alloc(v->shared->iova_tree, &map, taddr);
     if (unlikely(r != IOVA_OK)) {
         error_report("Cannot map injected element");
+
+        if (map.translated_addr == taddr) {
+            error_report("Insertion to IOVA->HVA tree failed");
+            /* Remove the mapping from the IOVA-only tree */
+            goto dma_map_err;
+        }
         return r;
     }
 
-- 
2.43.5


