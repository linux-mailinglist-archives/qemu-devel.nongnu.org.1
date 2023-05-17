Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4107063CD
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 11:15:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzDCM-0001s8-VJ; Wed, 17 May 2023 05:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzDBm-0000zx-En; Wed, 17 May 2023 05:11:19 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzDBj-0006Qm-Bm; Wed, 17 May 2023 05:11:18 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 74F17683E;
 Wed, 17 May 2023 12:10:46 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id E24375F0F;
 Wed, 17 May 2023 12:10:45 +0300 (MSK)
Received: (nullmailer pid 3626739 invoked by uid 1000);
 Wed, 17 May 2023 09:10:42 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH v7.2.3 24/30] virtio: fix reachable assertion due to stale
 value of cached region size
Date: Wed, 17 May 2023 12:10:36 +0300
Message-Id: <20230517091042.3626593-24-mjt@msgid.tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1684310574.git.mjt@msgid.tls.msk.ru>
References: <cover.1684310574.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Carlos López <clopez@suse.de>

In virtqueue_{split,packed}_get_avail_bytes() descriptors are read
in a loop via MemoryRegionCache regions and calls to
vring_{split,packed}_desc_read() - these take a region cache and the
index of the descriptor to be read.

For direct descriptors we use a cache provided by the caller, whose
size matches that of the virtqueue vring. We limit the number of
descriptors we can read by the size of that vring:

    max = vq->vring.num;
    ...
    MemoryRegionCache *desc_cache = &caches->desc;

For indirect descriptors, we initialize a new cache and limit the
number of descriptors by the size of the intermediate descriptor:

    len = address_space_cache_init(&indirect_desc_cache,
                                   vdev->dma_as,
                                   desc.addr, desc.len, false);
    desc_cache = &indirect_desc_cache;
    ...
    max = desc.len / sizeof(VRingDesc);

However, the first initialization of `max` is done outside the loop
where we process guest descriptors, while the second one is done
inside. This means that a sequence of an indirect descriptor followed
by a direct one will leave a stale value in `max`. If the second
descriptor's `next` field is smaller than the stale value, but
greater than the size of the virtqueue ring (and thus the cached
region), a failed assertion will be triggered in
address_space_read_cached() down the call chain.

Fix this by initializing `max` inside the loop in both functions.

Fixes: 9796d0ac8fb0 ("virtio: use address_space_map/unmap to access descriptors")
Signed-off-by: Carlos López <clopez@suse.de>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit bbc1c327d7974261c61566cdb950cc5fa0196b41)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/virtio/virtio.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index eb6347ab5d..384c8f0f08 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1478,7 +1478,7 @@ static void virtqueue_split_get_avail_bytes(VirtQueue *vq,
                             VRingMemoryRegionCaches *caches)
 {
     VirtIODevice *vdev = vq->vdev;
-    unsigned int max, idx;
+    unsigned int idx;
     unsigned int total_bufs, in_total, out_total;
     MemoryRegionCache indirect_desc_cache = MEMORY_REGION_CACHE_INVALID;
     int64_t len = 0;
@@ -1487,13 +1487,12 @@ static void virtqueue_split_get_avail_bytes(VirtQueue *vq,
     idx = vq->last_avail_idx;
     total_bufs = in_total = out_total = 0;
 
-    max = vq->vring.num;
-
     while ((rc = virtqueue_num_heads(vq, idx)) > 0) {
         MemoryRegionCache *desc_cache = &caches->desc;
         unsigned int num_bufs;
         VRingDesc desc;
         unsigned int i;
+        unsigned int max = vq->vring.num;
 
         num_bufs = total_bufs;
 
@@ -1615,7 +1614,7 @@ static void virtqueue_packed_get_avail_bytes(VirtQueue *vq,
                                              VRingMemoryRegionCaches *caches)
 {
     VirtIODevice *vdev = vq->vdev;
-    unsigned int max, idx;
+    unsigned int idx;
     unsigned int total_bufs, in_total, out_total;
     MemoryRegionCache *desc_cache;
     MemoryRegionCache indirect_desc_cache = MEMORY_REGION_CACHE_INVALID;
@@ -1627,14 +1626,14 @@ static void virtqueue_packed_get_avail_bytes(VirtQueue *vq,
     wrap_counter = vq->last_avail_wrap_counter;
     total_bufs = in_total = out_total = 0;
 
-    max = vq->vring.num;
-
     for (;;) {
         unsigned int num_bufs = total_bufs;
         unsigned int i = idx;
         int rc;
+        unsigned int max = vq->vring.num;
 
         desc_cache = &caches->desc;
+
         vring_packed_desc_read(vdev, &desc, desc_cache, idx, true);
         if (!is_desc_avail(desc.flags, wrap_counter)) {
             break;
-- 
2.39.2


