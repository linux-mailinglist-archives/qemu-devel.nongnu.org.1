Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E709788D8E
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 19:04:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZaEQ-0005ZK-GT; Fri, 25 Aug 2023 13:04:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets@ovn.org>)
 id 1qZaEN-0005Yx-AX
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 13:04:19 -0400
Received: from relay6-d.mail.gandi.net ([2001:4b98:dc4:8::226])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets@ovn.org>)
 id 1qZaEK-00088t-Uw
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 13:04:19 -0400
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2CC57C0003;
 Fri, 25 Aug 2023 17:04:11 +0000 (UTC)
From: Ilya Maximets <i.maximets@ovn.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH] virtio: use shadow_avail_idx while checking number of heads
Date: Fri, 25 Aug 2023 19:04:48 +0200
Message-Id: <20230825170448.1953409-1-i.maximets@ovn.org>
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

We do not need the most up to date number of heads, we only want to
know if there is at least one.

Use shadow variable as long as it is not equal to the last available
index checked.  This avoids expensive qatomic dereference of the
RCU-protected memory region cache as well as the memory access itself
and the subsequent memory barrier.

The change improves performance of the af-xdp network backend by 2-3%.

Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 hw/virtio/virtio.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 309038fd46..04bf7cc977 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -999,7 +999,15 @@ void virtqueue_push(VirtQueue *vq, const VirtQueueElement *elem,
 /* Called within rcu_read_lock().  */
 static int virtqueue_num_heads(VirtQueue *vq, unsigned int idx)
 {
-    uint16_t num_heads = vring_avail_idx(vq) - idx;
+    uint16_t num_heads;
+
+    if (vq->shadow_avail_idx != idx) {
+        num_heads = vq->shadow_avail_idx - idx;
+
+        return num_heads;
+    }
+
+    num_heads = vring_avail_idx(vq) - idx;
 
     /* Check it isn't doing very strange things with descriptor numbers. */
     if (num_heads > vq->vring.num) {
-- 
2.40.1


