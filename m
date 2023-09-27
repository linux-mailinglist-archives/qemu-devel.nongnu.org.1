Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB317B05EA
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 15:59:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlV4m-0005ag-7o; Wed, 27 Sep 2023 09:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets@ovn.org>)
 id 1qlV4i-0005US-Nc
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 09:59:36 -0400
Received: from relay6-d.mail.gandi.net ([2001:4b98:dc4:8::226])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets@ovn.org>)
 id 1qlV4h-0007CI-83
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 09:59:36 -0400
Received: by mail.gandi.net (Postfix) with ESMTPSA id AC796C0013;
 Wed, 27 Sep 2023 13:59:32 +0000 (UTC)
From: Ilya Maximets <i.maximets@ovn.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH v2 2/2] virtio: remove unused next argument from
 virtqueue_split_read_next_desc()
Date: Wed, 27 Sep 2023 15:59:42 +0200
Message-ID: <20230927140016.2317404-3-i.maximets@ovn.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230927140016.2317404-1-i.maximets@ovn.org>
References: <20230927140016.2317404-1-i.maximets@ovn.org>
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

The 'next' was converted from a local variable to an output parameter
in commit:
  412e0e81b174 ("virtio: handle virtqueue_read_next_desc() errors")

But all the actual uses of the 'i/next' as an output were removed a few
months prior in commit:
  aa570d6fb6bd ("virtio: combine the read of a descriptor")

Remove the unused argument to simplify the code.

Also, adding a comment to the function to describe what it is actually
doing, as it is not obvious that the 'desc' is both an input and an
output argument.

Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 hw/virtio/virtio.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 37584aaa74..bc0388d45b 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1039,9 +1039,10 @@ enum {
     VIRTQUEUE_READ_DESC_MORE = 1,   /* more buffers in chain */
 };
 
+/* Reads the 'desc->next' descriptor into '*desc'. */
 static int virtqueue_split_read_next_desc(VirtIODevice *vdev, VRingDesc *desc,
                                           MemoryRegionCache *desc_cache,
-                                          unsigned int max, unsigned int *next)
+                                          unsigned int max)
 {
     /* If this descriptor says it doesn't chain, we're done. */
     if (!(desc->flags & VRING_DESC_F_NEXT)) {
@@ -1049,14 +1050,12 @@ static int virtqueue_split_read_next_desc(VirtIODevice *vdev, VRingDesc *desc,
     }
 
     /* Check they're not leading us off end of descriptors. */
-    *next = desc->next;
-
-    if (*next >= max) {
-        virtio_error(vdev, "Desc next is %u", *next);
+    if (desc->next >= max) {
+        virtio_error(vdev, "Desc next is %u", desc->next);
         return VIRTQUEUE_READ_DESC_ERROR;
     }
 
-    vring_split_desc_read(vdev, desc, desc_cache, *next);
+    vring_split_desc_read(vdev, desc, desc_cache, desc->next);
     return VIRTQUEUE_READ_DESC_MORE;
 }
 
@@ -1134,7 +1133,7 @@ static void virtqueue_split_get_avail_bytes(VirtQueue *vq,
                 goto done;
             }
 
-            rc = virtqueue_split_read_next_desc(vdev, &desc, desc_cache, max, &i);
+            rc = virtqueue_split_read_next_desc(vdev, &desc, desc_cache, max);
         } while (rc == VIRTQUEUE_READ_DESC_MORE);
 
         if (rc == VIRTQUEUE_READ_DESC_ERROR) {
@@ -1585,7 +1584,7 @@ static void *virtqueue_split_pop(VirtQueue *vq, size_t sz)
             goto err_undo_map;
         }
 
-        rc = virtqueue_split_read_next_desc(vdev, &desc, desc_cache, max, &i);
+        rc = virtqueue_split_read_next_desc(vdev, &desc, desc_cache, max);
     } while (rc == VIRTQUEUE_READ_DESC_MORE);
 
     if (rc == VIRTQUEUE_READ_DESC_ERROR) {
@@ -4039,8 +4038,7 @@ VirtioQueueElement *qmp_x_query_virtio_queue_element(const char *path,
             list = node;
 
             ndescs++;
-            rc = virtqueue_split_read_next_desc(vdev, &desc, desc_cache,
-                                                max, &i);
+            rc = virtqueue_split_read_next_desc(vdev, &desc, desc_cache, max);
         } while (rc == VIRTQUEUE_READ_DESC_MORE);
         element->descs = list;
 done:
-- 
2.41.0


