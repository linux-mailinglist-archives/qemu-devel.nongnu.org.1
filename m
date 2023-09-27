Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8E37B05D0
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 15:52:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlUws-0000Zf-7G; Wed, 27 Sep 2023 09:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets@ovn.org>)
 id 1qlUwd-0000ZK-Ue
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 09:51:17 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets@ovn.org>)
 id 1qlUwb-0004Pj-GB
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 09:51:15 -0400
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8EE2C1C000A;
 Wed, 27 Sep 2023 13:51:08 +0000 (UTC)
From: Ilya Maximets <i.maximets@ovn.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH v2] virtio: use shadow_avail_idx while checking number of heads
Date: Wed, 27 Sep 2023 15:50:33 +0200
Message-ID: <20230927135157.2316982-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: i.maximets@ovn.org
Received-SPF: pass client-ip=217.70.183.197; envelope-from=i.maximets@ovn.org;
 helo=relay5-d.mail.gandi.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

We do not need the most up to date number of heads, we only want to
know if there is at least one.

Use shadow variable as long as it is not equal to the last available
index checked.  This avoids expensive qatomic dereference of the
RCU-protected memory region cache as well as the memory access itself.

The change improves performance of the af-xdp network backend by 2-3%.

Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---

Version 2:
  - Changed to not skip error checks and a barrier.
  - Added comments about the need for a barrier.

 hw/virtio/virtio.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 4577f3f5b3..8a4c3e95d2 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -999,7 +999,12 @@ void virtqueue_push(VirtQueue *vq, const VirtQueueElement *elem,
 /* Called within rcu_read_lock().  */
 static int virtqueue_num_heads(VirtQueue *vq, unsigned int idx)
 {
-    uint16_t num_heads = vring_avail_idx(vq) - idx;
+    uint16_t avail_idx, num_heads;
+
+    /* Use shadow index whenever possible. */
+    avail_idx = (vq->shadow_avail_idx != idx) ? vq->shadow_avail_idx
+                                              : vring_avail_idx(vq);
+    num_heads = avail_idx - idx;
 
     /* Check it isn't doing very strange things with descriptor numbers. */
     if (num_heads > vq->vring.num) {
@@ -1007,8 +1012,15 @@ static int virtqueue_num_heads(VirtQueue *vq, unsigned int idx)
                      idx, vq->shadow_avail_idx);
         return -EINVAL;
     }
-    /* On success, callers read a descriptor at vq->last_avail_idx.
-     * Make sure descriptor read does not bypass avail index read. */
+    /*
+     * On success, callers read a descriptor at vq->last_avail_idx.
+     * Make sure descriptor read does not bypass avail index read.
+     *
+     * This is necessary even if we are using a shadow index, since
+     * the shadow index could have been initialized by calling
+     * vring_avail_idx() outside of this function, i.e., by a guest
+     * memory read not accompanied by a barrier.
+     */
     if (num_heads) {
         smp_rmb();
     }
-- 
2.41.0


