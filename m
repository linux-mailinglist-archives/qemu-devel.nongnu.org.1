Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F557D0151
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:23:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXf1-0005st-4n; Thu, 19 Oct 2023 14:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXeS-0005fh-Ft
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:21:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXeQ-0000dq-Hi
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:21:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ichudybxzU8iz9vDb7x7lgGWFY23q5nvCS0lnP0+5LI=;
 b=XzYI0byf8AfUwY4B3aqBOf2Wsh1J8V9Bx1rXsnCAy0RNgcHJhsVX4M0nqTwvtL8Oi8YlNN
 YL4CD3iS1ideQeqrYexMki/Fp9dhdD2rwhH76FJiKmlZs/N424N8JvfnpOPo4/+hwDzq82
 ZjHzWSiPWMXEx5cbemU6LlLK4avQKiM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-InSOpwa5MmGMEQcJ0X3a_g-1; Thu, 19 Oct 2023 14:21:34 -0400
X-MC-Unique: InSOpwa5MmGMEQcJ0X3a_g-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40839252e81so14847285e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:21:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739693; x=1698344493;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ichudybxzU8iz9vDb7x7lgGWFY23q5nvCS0lnP0+5LI=;
 b=jjjyQywhxQnIqJLfE3b2dTW9C/PBDLt6gHje49FYO+SHbZi/DgLDHTC/+apWlWU7cm
 +h7pvTCyRmVmeQqcCv2ico2m16/yibJvWEU2ns6LyMBmxSQS4fLoDOJq1yMxlSECgIz9
 skMyc87oq0T/2leSyD1npjYXiIMycwr5bej3fWdQEQXHA/kpoA2JhcSjabnaHgDMmrNQ
 uOBzm+A1dFSDvRf5QUpm7Ef/pj+3+osjMgZTWEHbHGDyirb04pT+iw9vHZHbhE9QYujW
 26rOOkcKY8R0pPcJ3JQ6ZnD8c0vsxWYj5yfVKyPP5nZmLk7cMzD/6FqJzPlcFcNEU72C
 JEtA==
X-Gm-Message-State: AOJu0YxsDSsa1GICmmd5eM+Y/B0cDfIyT+IUV/E1HqZJ+T3q0JVN1G+c
 UNG5kMyzsuie72dluI8y7NoBTmJ1WKfEhc9BYFXYjCcxRjt4S0Zhbjn+ejj8YLxAQvQI1CVfGVK
 jrcQk4/Xrr+mOMrHZnZTqrkp4ITq4eEIau/4ZbajpgmI47Qa1PFBpcIkXdnPjxz9qKdGM
X-Received: by 2002:a05:600c:4f94:b0:407:7e7a:6017 with SMTP id
 n20-20020a05600c4f9400b004077e7a6017mr2615672wmq.11.1697739692769; 
 Thu, 19 Oct 2023 11:21:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG69LHmS/2ofE+RH77mv1V5UpqIH9yJTDNLiHjRUyBg6HAYscSpGHAEcEJz0ip4eFW2T8uXpg==
X-Received: by 2002:a05:600c:4f94:b0:407:7e7a:6017 with SMTP id
 n20-20020a05600c4f9400b004077e7a6017mr2615650wmq.11.1697739692288; 
 Thu, 19 Oct 2023 11:21:32 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 i18-20020a05600c481200b00407b93d8085sm4949890wmo.27.2023.10.19.11.21.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:21:31 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:21:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hawkins Jiawei <yin31149@gmail.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL v2 07/78] vdpa: Send cvq state load commands in parallel
Message-ID: <acec5f685c7ad6bd3c9bb9a57d4e509160480376.1697739629.git.mst@redhat.com>
References: <cover.1697739629.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1697739629.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Hawkins Jiawei <yin31149@gmail.com>

This patch enables sending CVQ state load commands
in parallel at device startup by following steps:

  * Refactor vhost_vdpa_net_load_cmd() to iterate through
the control commands shadow buffers. This allows different
CVQ state load commands to use their own unique buffers.

  * Delay the polling and checking of buffers until either
the SVQ is full or control commands shadow buffers are full.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1578
Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Message-Id: <9350f32278e39f7bce297b8f2d82dac27c6f8c9a.1697165821.git.yin31149@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 165 +++++++++++++++++++++++++++++------------------
 1 file changed, 102 insertions(+), 63 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index ef4d242811..4b7c3b81b8 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -661,6 +661,31 @@ static void vhost_vdpa_net_load_cursor_reset(VhostVDPAState *s,
     in_cursor->iov_len = vhost_vdpa_net_cvq_cmd_page_len();
 }
 
+/*
+ * Poll SVQ for multiple pending control commands and check the device's ack.
+ *
+ * Caller should hold the BQL when invoking this function.
+ *
+ * @s: The VhostVDPAState
+ * @len: The length of the pending status shadow buffer
+ */
+static ssize_t vhost_vdpa_net_svq_flush(VhostVDPAState *s, size_t len)
+{
+    /* device uses a one-byte length ack for each control command */
+    ssize_t dev_written = vhost_vdpa_net_svq_poll(s, len);
+    if (unlikely(dev_written != len)) {
+        return -EIO;
+    }
+
+    /* check the device's ack */
+    for (int i = 0; i < len; ++i) {
+        if (s->status[i] != VIRTIO_NET_OK) {
+            return -EIO;
+        }
+    }
+    return 0;
+}
+
 static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s,
                                        struct iovec *out_cursor,
                                        struct iovec *in_cursor, uint8_t class,
@@ -671,11 +696,31 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s,
         .class = class,
         .cmd = cmd,
     };
-    size_t data_size = iov_size(data_sg, data_num);
+    size_t data_size = iov_size(data_sg, data_num), cmd_size;
     struct iovec out, in;
     ssize_t r;
+    unsigned dummy_cursor_iov_cnt;
+    VhostShadowVirtqueue *svq = g_ptr_array_index(s->vhost_vdpa.shadow_vqs, 0);
 
     assert(data_size < vhost_vdpa_net_cvq_cmd_page_len() - sizeof(ctrl));
+    cmd_size = sizeof(ctrl) + data_size;
+    if (vhost_svq_available_slots(svq) < 2 ||
+        iov_size(out_cursor, 1) < cmd_size) {
+        /*
+         * It is time to flush all pending control commands if SVQ is full
+         * or control commands shadow buffers are full.
+         *
+         * We can poll here since we've had BQL from the time
+         * we sent the descriptor.
+         */
+        r = vhost_vdpa_net_svq_flush(s, in_cursor->iov_base -
+                                     (void *)s->status);
+        if (unlikely(r < 0)) {
+            return r;
+        }
+
+        vhost_vdpa_net_load_cursor_reset(s, out_cursor, in_cursor);
+    }
 
     /* pack the CVQ command header */
     iov_from_buf(out_cursor, 1, 0, &ctrl, sizeof(ctrl));
@@ -684,7 +729,7 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s,
                out_cursor->iov_base + sizeof(ctrl), data_size);
 
     /* extract the required buffer from the cursor for output */
-    iov_copy(&out, 1, out_cursor, 1, 0, sizeof(ctrl) + data_size);
+    iov_copy(&out, 1, out_cursor, 1, 0, cmd_size);
     /* extract the required buffer from the cursor for input */
     iov_copy(&in, 1, in_cursor, 1, 0, sizeof(*s->status));
 
@@ -693,11 +738,13 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s,
         return r;
     }
 
-    /*
-     * We can poll here since we've had BQL from the time
-     * we sent the descriptor.
-     */
-    return vhost_vdpa_net_svq_poll(s, 1);
+    /* iterate the cursors */
+    dummy_cursor_iov_cnt = 1;
+    iov_discard_front(&out_cursor, &dummy_cursor_iov_cnt, cmd_size);
+    dummy_cursor_iov_cnt = 1;
+    iov_discard_front(&in_cursor, &dummy_cursor_iov_cnt, sizeof(*s->status));
+
+    return 0;
 }
 
 static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet *n,
@@ -709,15 +756,12 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet *n,
             .iov_base = (void *)n->mac,
             .iov_len = sizeof(n->mac),
         };
-        ssize_t dev_written = vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
-                                                  VIRTIO_NET_CTRL_MAC,
-                                                  VIRTIO_NET_CTRL_MAC_ADDR_SET,
-                                                  &data, 1);
-        if (unlikely(dev_written < 0)) {
-            return dev_written;
-        }
-        if (*s->status != VIRTIO_NET_OK) {
-            return -EIO;
+        ssize_t r = vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
+                                            VIRTIO_NET_CTRL_MAC,
+                                            VIRTIO_NET_CTRL_MAC_ADDR_SET,
+                                            &data, 1);
+        if (unlikely(r < 0)) {
+            return r;
         }
     }
 
@@ -762,15 +806,12 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet *n,
             .iov_len = mul_macs_size,
         },
     };
-    ssize_t dev_written = vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
-                                VIRTIO_NET_CTRL_MAC,
-                                VIRTIO_NET_CTRL_MAC_TABLE_SET,
-                                data, ARRAY_SIZE(data));
-    if (unlikely(dev_written < 0)) {
-        return dev_written;
-    }
-    if (*s->status != VIRTIO_NET_OK) {
-        return -EIO;
+    ssize_t r = vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
+                                        VIRTIO_NET_CTRL_MAC,
+                                        VIRTIO_NET_CTRL_MAC_TABLE_SET,
+                                        data, ARRAY_SIZE(data));
+    if (unlikely(r < 0)) {
+        return r;
     }
 
     return 0;
@@ -782,7 +823,7 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
                                   struct iovec *in_cursor)
 {
     struct virtio_net_ctrl_mq mq;
-    ssize_t dev_written;
+    ssize_t r;
 
     if (!virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_MQ)) {
         return 0;
@@ -793,15 +834,12 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
         .iov_base = &mq,
         .iov_len = sizeof(mq),
     };
-    dev_written = vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
-                                          VIRTIO_NET_CTRL_MQ,
-                                          VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET,
-                                          &data, 1);
-    if (unlikely(dev_written < 0)) {
-        return dev_written;
-    }
-    if (*s->status != VIRTIO_NET_OK) {
-        return -EIO;
+    r = vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
+                                VIRTIO_NET_CTRL_MQ,
+                                VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET,
+                                &data, 1);
+    if (unlikely(r < 0)) {
+        return r;
     }
 
     return 0;
@@ -813,7 +851,7 @@ static int vhost_vdpa_net_load_offloads(VhostVDPAState *s,
                                         struct iovec *in_cursor)
 {
     uint64_t offloads;
-    ssize_t dev_written;
+    ssize_t r;
 
     if (!virtio_vdev_has_feature(&n->parent_obj,
                                  VIRTIO_NET_F_CTRL_GUEST_OFFLOADS)) {
@@ -841,15 +879,12 @@ static int vhost_vdpa_net_load_offloads(VhostVDPAState *s,
         .iov_base = &offloads,
         .iov_len = sizeof(offloads),
     };
-    dev_written = vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
-                                          VIRTIO_NET_CTRL_GUEST_OFFLOADS,
-                                          VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET,
-                                          &data, 1);
-    if (unlikely(dev_written < 0)) {
-        return dev_written;
-    }
-    if (*s->status != VIRTIO_NET_OK) {
-        return -EIO;
+    r = vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
+                                VIRTIO_NET_CTRL_GUEST_OFFLOADS,
+                                VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET,
+                                &data, 1);
+    if (unlikely(r < 0)) {
+        return r;
     }
 
     return 0;
@@ -865,16 +900,12 @@ static int vhost_vdpa_net_load_rx_mode(VhostVDPAState *s,
         .iov_base = &on,
         .iov_len = sizeof(on),
     };
-    ssize_t dev_written;
+    ssize_t r;
 
-    dev_written = vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
-                                          VIRTIO_NET_CTRL_RX,
-                                          cmd, &data, 1);
-    if (unlikely(dev_written < 0)) {
-        return dev_written;
-    }
-    if (*s->status != VIRTIO_NET_OK) {
-        return -EIO;
+    r = vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
+                                VIRTIO_NET_CTRL_RX, cmd, &data, 1);
+    if (unlikely(r < 0)) {
+        return r;
     }
 
     return 0;
@@ -1031,15 +1062,12 @@ static int vhost_vdpa_net_load_single_vlan(VhostVDPAState *s,
         .iov_base = &vid,
         .iov_len = sizeof(vid),
     };
-    ssize_t dev_written = vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
-                                                  VIRTIO_NET_CTRL_VLAN,
-                                                  VIRTIO_NET_CTRL_VLAN_ADD,
-                                                  &data, 1);
-    if (unlikely(dev_written < 0)) {
-        return dev_written;
-    }
-    if (unlikely(*s->status != VIRTIO_NET_OK)) {
-        return -EIO;
+    ssize_t r = vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
+                                        VIRTIO_NET_CTRL_VLAN,
+                                        VIRTIO_NET_CTRL_VLAN_ADD,
+                                        &data, 1);
+    if (unlikely(r < 0)) {
+        return r;
     }
 
     return 0;
@@ -1106,6 +1134,17 @@ static int vhost_vdpa_net_cvq_load(NetClientState *nc)
         if (unlikely(r)) {
             return r;
         }
+
+        /*
+         * We need to poll and check all pending device's used buffers.
+         *
+         * We can poll here since we've had BQL from the time
+         * we sent the descriptor.
+         */
+        r = vhost_vdpa_net_svq_flush(s, in_cursor.iov_base - (void *)s->status);
+        if (unlikely(r)) {
+            return r;
+        }
     }
 
     for (int i = 0; i < v->dev->vq_index; ++i) {
-- 
MST


