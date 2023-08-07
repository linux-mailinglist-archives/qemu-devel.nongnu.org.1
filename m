Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B277732FA
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 00:29:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT8i1-0000yY-75; Mon, 07 Aug 2023 18:28:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets@ovn.org>)
 id 1qT8hz-0000x2-Uc
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 18:28:15 -0400
Received: from relay6-d.mail.gandi.net ([2001:4b98:dc4:8::226])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets@ovn.org>)
 id 1qT8hx-0007Ea-QF
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 18:28:15 -0400
Received: by mail.gandi.net (Postfix) with ESMTPSA id DC0B9C0004;
 Mon,  7 Aug 2023 22:28:07 +0000 (UTC)
From: Ilya Maximets <i.maximets@ovn.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH] virtio: don't zero out memory region cache for indirect
 descriptors
Date: Tue,  8 Aug 2023 00:28:47 +0200
Message-Id: <20230807222847.2837393-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: i.maximets@ovn.org
Received-SPF: neutral client-ip=2001:4b98:dc4:8::226;
 envelope-from=i.maximets@ovn.org; helo=relay6-d.mail.gandi.net
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_PASS=-0.001, SPF_NEUTRAL=0.779 autolearn=ham autolearn_force=no
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
However, we only need to destruct it when it was used, i.e. when a
desc_cache points to it.

Removing these unnecessary stack initializations improves throughput
of virtio-net devices in terms of 64B packets per second by 6-14 %
depending on the case.  Tested with a proposed af-xdp network backend
and a dpdk testpmd application in the guest, but should be beneficial
for other virtio devices as well.

Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 hw/virtio/virtio.c | 42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 309038fd46..a65396e616 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1071,7 +1071,8 @@ static void virtqueue_split_get_avail_bytes(VirtQueue *vq,
     VirtIODevice *vdev = vq->vdev;
     unsigned int idx;
     unsigned int total_bufs, in_total, out_total;
-    MemoryRegionCache indirect_desc_cache = MEMORY_REGION_CACHE_INVALID;
+    MemoryRegionCache indirect_desc_cache;
+    MemoryRegionCache *desc_cache = NULL;
     int64_t len = 0;
     int rc;
 
@@ -1079,7 +1080,6 @@ static void virtqueue_split_get_avail_bytes(VirtQueue *vq,
     total_bufs = in_total = out_total = 0;
 
     while ((rc = virtqueue_num_heads(vq, idx)) > 0) {
-        MemoryRegionCache *desc_cache = &caches->desc;
         unsigned int num_bufs;
         VRingDesc desc;
         unsigned int i;
@@ -1091,6 +1091,8 @@ static void virtqueue_split_get_avail_bytes(VirtQueue *vq,
             goto err;
         }
 
+        desc_cache = &caches->desc;
+
         vring_split_desc_read(vdev, &desc, desc_cache, i);
 
         if (desc.flags & VRING_DESC_F_INDIRECT) {
@@ -1156,7 +1158,9 @@ static void virtqueue_split_get_avail_bytes(VirtQueue *vq,
     }
 
 done:
-    address_space_cache_destroy(&indirect_desc_cache);
+    if (desc_cache == &indirect_desc_cache) {
+        address_space_cache_destroy(&indirect_desc_cache);
+    }
     if (in_bytes) {
         *in_bytes = in_total;
     }
@@ -1207,8 +1211,8 @@ static void virtqueue_packed_get_avail_bytes(VirtQueue *vq,
     VirtIODevice *vdev = vq->vdev;
     unsigned int idx;
     unsigned int total_bufs, in_total, out_total;
-    MemoryRegionCache *desc_cache;
-    MemoryRegionCache indirect_desc_cache = MEMORY_REGION_CACHE_INVALID;
+    MemoryRegionCache indirect_desc_cache;
+    MemoryRegionCache *desc_cache = NULL;
     int64_t len = 0;
     VRingPackedDesc desc;
     bool wrap_counter;
@@ -1297,7 +1301,9 @@ static void virtqueue_packed_get_avail_bytes(VirtQueue *vq,
     vq->shadow_avail_idx = idx;
     vq->shadow_avail_wrap_counter = wrap_counter;
 done:
-    address_space_cache_destroy(&indirect_desc_cache);
+    if (desc_cache == &indirect_desc_cache) {
+        address_space_cache_destroy(&indirect_desc_cache);
+    }
     if (in_bytes) {
         *in_bytes = in_total;
     }
@@ -1487,8 +1493,8 @@ static void *virtqueue_split_pop(VirtQueue *vq, size_t sz)
 {
     unsigned int i, head, max;
     VRingMemoryRegionCaches *caches;
-    MemoryRegionCache indirect_desc_cache = MEMORY_REGION_CACHE_INVALID;
-    MemoryRegionCache *desc_cache;
+    MemoryRegionCache indirect_desc_cache;
+    MemoryRegionCache *desc_cache = NULL;
     int64_t len;
     VirtIODevice *vdev = vq->vdev;
     VirtQueueElement *elem = NULL;
@@ -1611,7 +1617,9 @@ static void *virtqueue_split_pop(VirtQueue *vq, size_t sz)
 
     trace_virtqueue_pop(vq, elem, elem->in_num, elem->out_num);
 done:
-    address_space_cache_destroy(&indirect_desc_cache);
+    if (desc_cache == &indirect_desc_cache) {
+        address_space_cache_destroy(&indirect_desc_cache);
+    }
 
     return elem;
 
@@ -1624,8 +1632,8 @@ static void *virtqueue_packed_pop(VirtQueue *vq, size_t sz)
 {
     unsigned int i, max;
     VRingMemoryRegionCaches *caches;
-    MemoryRegionCache indirect_desc_cache = MEMORY_REGION_CACHE_INVALID;
-    MemoryRegionCache *desc_cache;
+    MemoryRegionCache indirect_desc_cache;
+    MemoryRegionCache *desc_cache = NULL;
     int64_t len;
     VirtIODevice *vdev = vq->vdev;
     VirtQueueElement *elem = NULL;
@@ -1746,7 +1754,9 @@ static void *virtqueue_packed_pop(VirtQueue *vq, size_t sz)
 
     trace_virtqueue_pop(vq, elem, elem->in_num, elem->out_num);
 done:
-    address_space_cache_destroy(&indirect_desc_cache);
+    if (desc_cache == &indirect_desc_cache) {
+        address_space_cache_destroy(&indirect_desc_cache);
+    }
 
     return elem;
 
@@ -3935,8 +3945,8 @@ VirtioQueueElement *qmp_x_query_virtio_queue_element(const char *path,
     } else {
         unsigned int head, i, max;
         VRingMemoryRegionCaches *caches;
-        MemoryRegionCache indirect_desc_cache = MEMORY_REGION_CACHE_INVALID;
-        MemoryRegionCache *desc_cache;
+        MemoryRegionCache indirect_desc_cache;
+        MemoryRegionCache *desc_cache = NULL;
         VRingDesc desc;
         VirtioRingDescList *list = NULL;
         VirtioRingDescList *node;
@@ -4011,7 +4021,9 @@ VirtioQueueElement *qmp_x_query_virtio_queue_element(const char *path,
         } while (rc == VIRTQUEUE_READ_DESC_MORE);
         element->descs = list;
 done:
-        address_space_cache_destroy(&indirect_desc_cache);
+        if (desc_cache == &indirect_desc_cache) {
+            address_space_cache_destroy(&indirect_desc_cache);
+        }
     }
 
     return element;
-- 
2.40.1


