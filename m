Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECFA7791F6
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 16:34:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUTD8-0008Pb-Vl; Fri, 11 Aug 2023 10:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets@ovn.org>)
 id 1qUTD4-0008P5-IA
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 10:33:51 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets@ovn.org>)
 id 1qUTD2-0005xK-I5
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 10:33:50 -0400
Received: by mail.gandi.net (Postfix) with ESMTPSA id 119F820005;
 Fri, 11 Aug 2023 14:33:44 +0000 (UTC)
From: Ilya Maximets <i.maximets@ovn.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH v2] virtio: don't zero out memory region cache for indirect
 descriptors
Date: Fri, 11 Aug 2023 16:34:23 +0200
Message-Id: <20230811143423.3258788-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: i.maximets@ovn.org
Received-SPF: pass client-ip=217.70.183.200; envelope-from=i.maximets@ovn.org;
 helo=relay7-d.mail.gandi.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Lots of virtio functions that are on a hot path in data transmission
are initializing indirect descriptor cache at the point of stack
allocation.  It's a 112 byte structure that is getting zeroed out on
each call adding unnecessary overhead.  It's going to be correctly
initialized later via special init function.  The only reason to
actually initialize right away is the ability to safely destruct it.
Replacing a designated initializer with a function to only initialize
what is necessary.

Removal of the unnecessary stack initializations improves throughput
of virtio-net devices in terms of 64B packets per second by 6-14 %
depending on the case.  Tested with a proposed af-xdp network backend
and a dpdk testpmd application in the guest, but should be beneficial
for other virtio devices as well.

Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---

Version 2:

  * Introduced an initialization function, so we don't need to compare
    pointers in the end. [Stefan]
  * Removed the now unused macro. [Jason]

 hw/virtio/virtio.c    | 20 +++++++++++++++-----
 include/exec/memory.h | 16 +++++++++++++---
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 309038fd46..3d768fda5a 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1071,10 +1071,12 @@ static void virtqueue_split_get_avail_bytes(VirtQueue *vq,
     VirtIODevice *vdev = vq->vdev;
     unsigned int idx;
     unsigned int total_bufs, in_total, out_total;
-    MemoryRegionCache indirect_desc_cache = MEMORY_REGION_CACHE_INVALID;
+    MemoryRegionCache indirect_desc_cache;
     int64_t len = 0;
     int rc;
 
+    address_space_cache_init_empty(&indirect_desc_cache);
+
     idx = vq->last_avail_idx;
     total_bufs = in_total = out_total = 0;
 
@@ -1207,12 +1209,14 @@ static void virtqueue_packed_get_avail_bytes(VirtQueue *vq,
     VirtIODevice *vdev = vq->vdev;
     unsigned int idx;
     unsigned int total_bufs, in_total, out_total;
+    MemoryRegionCache indirect_desc_cache;
     MemoryRegionCache *desc_cache;
-    MemoryRegionCache indirect_desc_cache = MEMORY_REGION_CACHE_INVALID;
     int64_t len = 0;
     VRingPackedDesc desc;
     bool wrap_counter;
 
+    address_space_cache_init_empty(&indirect_desc_cache);
+
     idx = vq->last_avail_idx;
     wrap_counter = vq->last_avail_wrap_counter;
     total_bufs = in_total = out_total = 0;
@@ -1487,7 +1491,7 @@ static void *virtqueue_split_pop(VirtQueue *vq, size_t sz)
 {
     unsigned int i, head, max;
     VRingMemoryRegionCaches *caches;
-    MemoryRegionCache indirect_desc_cache = MEMORY_REGION_CACHE_INVALID;
+    MemoryRegionCache indirect_desc_cache;
     MemoryRegionCache *desc_cache;
     int64_t len;
     VirtIODevice *vdev = vq->vdev;
@@ -1498,6 +1502,8 @@ static void *virtqueue_split_pop(VirtQueue *vq, size_t sz)
     VRingDesc desc;
     int rc;
 
+    address_space_cache_init_empty(&indirect_desc_cache);
+
     RCU_READ_LOCK_GUARD();
     if (virtio_queue_empty_rcu(vq)) {
         goto done;
@@ -1624,7 +1630,7 @@ static void *virtqueue_packed_pop(VirtQueue *vq, size_t sz)
 {
     unsigned int i, max;
     VRingMemoryRegionCaches *caches;
-    MemoryRegionCache indirect_desc_cache = MEMORY_REGION_CACHE_INVALID;
+    MemoryRegionCache indirect_desc_cache;
     MemoryRegionCache *desc_cache;
     int64_t len;
     VirtIODevice *vdev = vq->vdev;
@@ -1636,6 +1642,8 @@ static void *virtqueue_packed_pop(VirtQueue *vq, size_t sz)
     uint16_t id;
     int rc;
 
+    address_space_cache_init_empty(&indirect_desc_cache);
+
     RCU_READ_LOCK_GUARD();
     if (virtio_queue_packed_empty_rcu(vq)) {
         goto done;
@@ -3935,13 +3943,15 @@ VirtioQueueElement *qmp_x_query_virtio_queue_element(const char *path,
     } else {
         unsigned int head, i, max;
         VRingMemoryRegionCaches *caches;
-        MemoryRegionCache indirect_desc_cache = MEMORY_REGION_CACHE_INVALID;
+        MemoryRegionCache indirect_desc_cache;
         MemoryRegionCache *desc_cache;
         VRingDesc desc;
         VirtioRingDescList *list = NULL;
         VirtioRingDescList *node;
         int rc; int ndescs;
 
+        address_space_cache_init_empty(&indirect_desc_cache);
+
         RCU_READ_LOCK_GUARD();
 
         max = vq->vring.num;
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 68284428f8..b1c4329d11 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2664,9 +2664,6 @@ struct MemoryRegionCache {
     bool is_write;
 };
 
-#define MEMORY_REGION_CACHE_INVALID ((MemoryRegionCache) { .mrs.mr = NULL })
-
-
 /* address_space_ld*_cached: load from a cached #MemoryRegion
  * address_space_st*_cached: store into a cached #MemoryRegion
  *
@@ -2755,6 +2752,19 @@ int64_t address_space_cache_init(MemoryRegionCache *cache,
                                  hwaddr len,
                                  bool is_write);
 
+/**
+ * address_space_cache_init_empty: Initialize empty #MemoryRegionCache
+ *
+ * @cache: The #MemoryRegionCache to operate on.
+ *
+ * Initializes #MemoryRegionCache structure without memory region attached.
+ * Cache initialized this way can only be safely destroyed, but not used.
+ */
+static inline void address_space_cache_init_empty(MemoryRegionCache *cache)
+{
+    cache->mrs.mr = NULL;
+}
+
 /**
  * address_space_cache_invalidate: complete a write to a #MemoryRegionCache
  *
-- 
2.40.1


