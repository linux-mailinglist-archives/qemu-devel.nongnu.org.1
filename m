Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A0E8216A0
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 04:30:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKVT5-0004fk-Fb; Mon, 01 Jan 2024 22:29:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rKVT3-0004fS-JG
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 22:29:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rKVT1-00042c-Tf
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 22:29:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704166162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZptoMoesx/ux09C7cxSVBrOtp5ga2aPVoYXiAiiNAwE=;
 b=BSjJS8nAY1hj4Lem9X1WnSSED8QIG4yeHqDxO8PG23/LaG2kkFLeTiEmN9NLTspR+zJB7L
 vVTM9FNpphZqbzG1GUkkcu9gZXBDUmugmFmr3CV+Iv3ZL9+aknm9ScCrmedYKwfv19r8N7
 9OFm7AKgh2R5z8b2VcCZPBbFOiyLOBw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-Ot12dtESNtGyCuj2tbnBTA-1; Mon, 01 Jan 2024 22:29:12 -0500
X-MC-Unique: Ot12dtESNtGyCuj2tbnBTA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EEC7F85A588;
 Tue,  2 Jan 2024 03:29:11 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.113])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D746BC15A0C;
 Tue,  2 Jan 2024 03:29:04 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	qemu-devel@nongnu.org
Cc: Xiao Lei <leixiao.nop@zju.edu.cn>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, qemu-stable@nongnu.org,
 Mauro Matteo Cascella <mcascell@redhat.com>
Subject: [PATCH] virtio-net: correctly copy vnet header when flushing TX
Date: Tue,  2 Jan 2024 11:29:01 +0800
Message-ID: <20240102032901.3234-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.246,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

When HASH_REPORT is negotiated, the guest_hdr_len might be larger than
the size of the mergeable rx buffer header. Using
virtio_net_hdr_mrg_rxbuf during the header swap might lead a stack
overflow in this case. Fixing this by using virtio_net_hdr_v1_hash
instead.

Reported-by: Xiao Lei <leixiao.nop@zju.edu.cn>
Cc: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: qemu-stable@nongnu.org
Cc: Mauro Matteo Cascella <mcascell@redhat.com>
Fixes: CVE-2023-6693
Fixes: e22f0603fb2f ("virtio-net: reference implementation of hash report")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/virtio-net.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 80c56f0cfc..73024babd4 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -674,6 +674,11 @@ static void virtio_net_set_mrg_rx_bufs(VirtIONet *n, int mergeable_rx_bufs,
 
     n->mergeable_rx_bufs = mergeable_rx_bufs;
 
+    /*
+     * Note: when extending the vnet header, please make sure to
+     * change the vnet header copying logic in virtio_net_flush_tx()
+     * as well.
+     */
     if (version_1) {
         n->guest_hdr_len = hash_report ?
             sizeof(struct virtio_net_hdr_v1_hash) :
@@ -2693,7 +2698,7 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
         ssize_t ret;
         unsigned int out_num;
         struct iovec sg[VIRTQUEUE_MAX_SIZE], sg2[VIRTQUEUE_MAX_SIZE + 1], *out_sg;
-        struct virtio_net_hdr_mrg_rxbuf mhdr;
+        struct virtio_net_hdr_v1_hash vhdr;
 
         elem = virtqueue_pop(q->tx_vq, sizeof(VirtQueueElement));
         if (!elem) {
@@ -2710,7 +2715,7 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
         }
 
         if (n->has_vnet_hdr) {
-            if (iov_to_buf(out_sg, out_num, 0, &mhdr, n->guest_hdr_len) <
+            if (iov_to_buf(out_sg, out_num, 0, &vhdr, n->guest_hdr_len) <
                 n->guest_hdr_len) {
                 virtio_error(vdev, "virtio-net header incorrect");
                 virtqueue_detach_element(q->tx_vq, elem, 0);
@@ -2718,8 +2723,8 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
                 return -EINVAL;
             }
             if (n->needs_vnet_hdr_swap) {
-                virtio_net_hdr_swap(vdev, (void *) &mhdr);
-                sg2[0].iov_base = &mhdr;
+                virtio_net_hdr_swap(vdev, (void *) &vhdr);
+                sg2[0].iov_base = &vhdr;
                 sg2[0].iov_len = n->guest_hdr_len;
                 out_num = iov_copy(&sg2[1], ARRAY_SIZE(sg2) - 1,
                                    out_sg, out_num,
-- 
2.42.0


