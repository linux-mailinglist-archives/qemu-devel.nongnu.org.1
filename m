Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC40070DA35
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 12:19:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1P4T-0007nb-Fy; Tue, 23 May 2023 06:16:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q1P4K-0007Nd-5g; Tue, 23 May 2023 06:16:42 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q1P4H-00022E-Vq; Tue, 23 May 2023 06:16:39 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B9C5D7D01;
 Tue, 23 May 2023 13:15:52 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 0ACB77291;
 Tue, 23 May 2023 13:15:52 +0300 (MSK)
Received: (nullmailer pid 85535 invoked by uid 1000);
 Tue, 23 May 2023 10:15:49 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Hawkins Jiawei <yin31149@gmail.com>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Lei Yang <leiyang@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.1 51/59] vhost: fix possible wrap in SVQ descriptor ring
Date: Tue, 23 May 2023 13:15:11 +0300
Message-Id: <20230523101536.85424-15-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.1-20230523131351@cover.tls.msk.ru>
References: <qemu-stable-8.0.1-20230523131351@cover.tls.msk.ru>
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

From: Hawkins Jiawei <yin31149@gmail.com>

QEMU invokes vhost_svq_add() when adding a guest's element
into SVQ. In vhost_svq_add(), it uses vhost_svq_available_slots()
to check whether QEMU can add the element into SVQ. If there is
enough space, then QEMU combines some out descriptors and some
in descriptors into one descriptor chain, and adds it into
`svq->vring.desc` by vhost_svq_vring_write_descs().

Yet the problem is that, `svq->shadow_avail_idx - svq->shadow_used_idx`
in vhost_svq_available_slots() returns the number of occupied elements,
or the number of descriptor chains, instead of the number of occupied
descriptors, which may cause wrapping in SVQ descriptor ring.

Here is an example. In vhost_handle_guest_kick(), QEMU forwards
as many available buffers to device by virtqueue_pop() and
vhost_svq_add_element(). virtqueue_pop() returns a guest's element,
and then this element is added into SVQ by vhost_svq_add_element(),
a wrapper to vhost_svq_add(). If QEMU invokes virtqueue_pop() and
vhost_svq_add_element() `svq->vring.num` times,
vhost_svq_available_slots() thinks QEMU just ran out of slots and
everything should work fine. But in fact, virtqueue_pop() returns
`svq->vring.num` elements or descriptor chains, more than
`svq->vring.num` descriptors due to guest memory fragmentation,
and this causes wrapping in SVQ descriptor ring.

This bug is valid even before marking the descriptors used.
If the guest memory is fragmented, SVQ must add chains
so it can try to add more descriptors than possible.

This patch solves it by adding `num_free` field in
VhostShadowVirtqueue structure and updating this field
in vhost_svq_add() and vhost_svq_get_buf(), to record
the number of free descriptors.

Fixes: 100890f7ca ("vhost: Shadow virtqueue buffers forwarding")
Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Message-Id: <20230509084817.3973-1-yin31149@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
(cherry picked from commit 5d410557dea452f6231a7c66155e29a37e168528)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index 8361e70d1b..bd7c12b6d3 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -68,7 +68,7 @@ bool vhost_svq_valid_features(uint64_t features, Error **errp)
  */
 static uint16_t vhost_svq_available_slots(const VhostShadowVirtqueue *svq)
 {
-    return svq->vring.num - (svq->shadow_avail_idx - svq->shadow_used_idx);
+    return svq->num_free;
 }
 
 /**
@@ -263,6 +263,7 @@ int vhost_svq_add(VhostShadowVirtqueue *svq, const struct iovec *out_sg,
         return -EINVAL;
     }
 
+    svq->num_free -= ndescs;
     svq->desc_state[qemu_head].elem = elem;
     svq->desc_state[qemu_head].ndescs = ndescs;
     vhost_svq_kick(svq);
@@ -449,6 +450,7 @@ static VirtQueueElement *vhost_svq_get_buf(VhostShadowVirtqueue *svq,
     last_used_chain = vhost_svq_last_desc_of_chain(svq, num, used_elem.id);
     svq->desc_next[last_used_chain] = svq->free_head;
     svq->free_head = used_elem.id;
+    svq->num_free += num;
 
     *len = used_elem.len;
     return g_steal_pointer(&svq->desc_state[used_elem.id].elem);
@@ -659,6 +661,7 @@ void vhost_svq_start(VhostShadowVirtqueue *svq, VirtIODevice *vdev,
     svq->iova_tree = iova_tree;
 
     svq->vring.num = virtio_queue_get_num(vdev, virtio_get_queue_index(vq));
+    svq->num_free = svq->vring.num;
     driver_size = vhost_svq_driver_area_size(svq);
     device_size = vhost_svq_device_area_size(svq);
     svq->vring.desc = qemu_memalign(qemu_real_host_page_size(), driver_size);
diff --git a/hw/virtio/vhost-shadow-virtqueue.h b/hw/virtio/vhost-shadow-virtqueue.h
index 926a4897b1..6efe051a70 100644
--- a/hw/virtio/vhost-shadow-virtqueue.h
+++ b/hw/virtio/vhost-shadow-virtqueue.h
@@ -107,6 +107,9 @@ typedef struct VhostShadowVirtqueue {
 
     /* Next head to consume from the device */
     uint16_t last_used_idx;
+
+    /* Size of SVQ vring free descriptors */
+    uint16_t num_free;
 } VhostShadowVirtqueue;
 
 bool vhost_svq_valid_features(uint64_t features, Error **errp);
-- 
2.39.2


