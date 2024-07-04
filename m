Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBD4927A99
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jul 2024 17:56:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPOlu-0000RX-47; Thu, 04 Jul 2024 11:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sPOlg-0000Dq-KW; Thu, 04 Jul 2024 11:53:08 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sPOlb-0001zk-44; Thu, 04 Jul 2024 11:53:07 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6212377490;
 Thu,  4 Jul 2024 18:52:46 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 2A574FEADB;
 Thu,  4 Jul 2024 18:52:51 +0300 (MSK)
Received: (nullmailer pid 1481674 invoked by uid 1000);
 Thu, 04 Jul 2024 15:52:51 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alexey Dobriyan <adobriyan@yandex-team.ru>,
 Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.6 02/18] virtio-net: drop too short packets early
Date: Thu,  4 Jul 2024 18:52:33 +0300
Message-Id: <20240704155251.1481617-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.6-20240704154854@cover.tls.msk.ru>
References: <qemu-stable-8.2.6-20240704154854@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Alexey Dobriyan <adobriyan@yandex-team.ru>

Reproducer from https://gitlab.com/qemu-project/qemu/-/issues/1451
creates small packet (1 segment, len = 10 == n->guest_hdr_len),
then destroys queue.

"if (n->host_hdr_len != n->guest_hdr_len)" is triggered, if body creates
zero length/zero segment packet as there is nothing after guest header.

qemu_sendv_packet_async() tries to send it.

slirp discards it because it is smaller than Ethernet header,
but returns 0 because tx hooks are supposed to return total length of data.

0 is propagated upwards and is interpreted as "packet has been sent"
which is terrible because queue is being destroyed, nobody is waiting for TX
to complete and assert it triggered.

Fix is discard such empty packets instead of sending them.

Length 1 packets will go via different codepath:

	virtqueue_push(q->tx_vq, elem, 0);
	virtio_notify(vdev, q->tx_vq);
	g_free(elem);

and aren't problematic.

Signed-off-by: Alexey Dobriyan <adobriyan@yandex-team.ru>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit 2c3e4e2de699cd4d9f6c71f30a22d8f125cd6164)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 8451dbee41..0467b3bd8a 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2709,18 +2709,14 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
         out_sg = elem->out_sg;
         if (out_num < 1) {
             virtio_error(vdev, "virtio-net header not in first element");
-            virtqueue_detach_element(q->tx_vq, elem, 0);
-            g_free(elem);
-            return -EINVAL;
+            goto detach;
         }
 
         if (n->has_vnet_hdr) {
             if (iov_to_buf(out_sg, out_num, 0, &vhdr, n->guest_hdr_len) <
                 n->guest_hdr_len) {
                 virtio_error(vdev, "virtio-net header incorrect");
-                virtqueue_detach_element(q->tx_vq, elem, 0);
-                g_free(elem);
-                return -EINVAL;
+                goto detach;
             }
             if (n->needs_vnet_hdr_swap) {
                 virtio_net_hdr_swap(vdev, (void *) &vhdr);
@@ -2751,6 +2747,11 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
                              n->guest_hdr_len, -1);
             out_num = sg_num;
             out_sg = sg;
+
+            if (out_num < 1) {
+                virtio_error(vdev, "virtio-net nothing to send");
+                goto detach;
+            }
         }
 
         ret = qemu_sendv_packet_async(qemu_get_subqueue(n->nic, queue_index),
@@ -2771,6 +2772,11 @@ drop:
         }
     }
     return num_packets;
+
+detach:
+    virtqueue_detach_element(q->tx_vq, elem, 0);
+    g_free(elem);
+    return -EINVAL;
 }
 
 static void virtio_net_tx_timer(void *opaque);
-- 
2.39.2


