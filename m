Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1F7758FBD
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 09:56:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM21E-0005aK-G9; Wed, 19 Jul 2023 03:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qM21A-0005VV-4U
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 03:54:42 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qM218-0003Qc-3X
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 03:54:39 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-55b0e7efb1cso3806342a12.1
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 00:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689753276; x=1692345276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9hVkRZxgxwyHhUOFXwXUro/N/dlyZ2PieUblJXKdidQ=;
 b=i1afV9QtspKjBN0XBDmMR2ylTNo5KzTBnqB7wlR7T8F4vPZoiY12F4NyqiFuZc8l8L
 l47O5uZfmvytnFqjwAVQBDTIkLK1YzbU6TaRymFbCGBACeGcfSYKrtUnmls0YWkNR1iQ
 pwp9fqGDj5CNydXUPTtRPVtogP4/v7IsPeC4fYBWJz3fYJjqVhHtv0wul053GOODhPF1
 qyNsM8ImpuPta7yEtI+TyfQ6M28JQilCg0GFr/MkoHgwrxItdLEc/9WHWYy2EzBppDS5
 6UMIwx7hDzE4UDRijagJNfMIctnEJFC7oi5t5YGTixmxoeUyxXpmK09IGSnyrazkrtnx
 PRgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689753276; x=1692345276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9hVkRZxgxwyHhUOFXwXUro/N/dlyZ2PieUblJXKdidQ=;
 b=bcZsW4Rqo0fGTAq3KDQDjXkYJSqCzwn1rn1zLKxtl+u++MANdEcP7NNLeTXphfjTrl
 RPvfbFJ8pax5MvSnCs6iaBloGo7i7AetXO11Zu40SC+pM4Hpqqaa+5d34xw5z/pziaPl
 lO4tWvB3Hii+hOOK0S1Y5LejABdwe5/XGakXeXNJMtffe+y+ZiU628nLY7b0bKcXWDSN
 3Wxjj08zU0zgymAJaAskavqsYgbsOCr6fTezkfuisP0cz+a/KnR0Cvjyz6VLPXFbT8qE
 bamCUV/pAipEJVKoWWFlq8ESKUvEbB6KbMmJQnailvoh5DZ6HrsidjZ5SEqLZglkgdNj
 p5WA==
X-Gm-Message-State: ABy/qLY+lE+7IDXzdix7Fqe2hDQzFXPlfDM46V7qu8zwR+OzmfIHq2+v
 StNEd4Fo0HL5ZWxZ1Jd2rBc=
X-Google-Smtp-Source: APBJJlEdvkFVmDs7pgwnbs4ZmWJw4NMHDL2M0vvwwuKUjuB4sVUKXnTbyKcOcsoZyG+ObPzeR4WQBw==
X-Received: by 2002:a17:90a:990e:b0:267:6586:f39a with SMTP id
 b14-20020a17090a990e00b002676586f39amr15089251pjp.47.1689753276475; 
 Wed, 19 Jul 2023 00:54:36 -0700 (PDT)
Received: from localhost ([183.242.254.166]) by smtp.gmail.com with ESMTPSA id
 y10-20020a17090a1f4a00b0026094c23d0asm736822pjy.17.2023.07.19.00.54.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jul 2023 00:54:36 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v3 8/8] vdpa: Send cvq state load commands in parallel
Date: Wed, 19 Jul 2023 15:53:53 +0800
Message-Id: <3a002790e6c880af928c6470ecbf03e7c65a68bb.1689748694.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1689748694.git.yin31149@gmail.com>
References: <cover.1689748694.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=yin31149@gmail.com; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This patch enables sending CVQ state load commands
in parallel at device startup by following steps:

  * Refactor vhost_vdpa_net_load_cmd() to iterate through
the control commands shadow buffers. This allows different
CVQ state load commands to use their own unique buffers.

  * Delay the polling and checking of buffers until either
the SVQ is full or control commands shadow buffers are full.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1578
Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
 net/vhost-vdpa.c | 157 +++++++++++++++++++++++++++++------------------
 1 file changed, 96 insertions(+), 61 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 795c9c1fd2..1ebb58f7f6 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -633,6 +633,26 @@ static uint16_t vhost_vdpa_net_svq_available_slots(VhostVDPAState *s)
     return vhost_svq_available_slots(svq);
 }
 
+/*
+ * Poll SVQ for multiple pending control commands and check the device's ack.
+ *
+ * Caller should hold the BQL when invoking this function.
+ */
+static ssize_t vhost_vdpa_net_svq_flush(VhostVDPAState *s,
+                                        size_t cmds_in_flight)
+{
+    vhost_vdpa_net_svq_poll(s, cmds_in_flight);
+
+    /* Device should and must use only one byte ack each control command */
+    assert(cmds_in_flight < vhost_vdpa_net_cvq_cmd_page_len());
+    for (int i = 0; i < cmds_in_flight; ++i) {
+        if (s->status[i] != VIRTIO_NET_OK) {
+            return -EIO;
+        }
+    }
+    return 0;
+}
+
 static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s, void **out_cursor,
                                        void **in_cursor, uint8_t class,
                                        uint8_t cmd, const struct iovec *data_sg,
@@ -642,19 +662,41 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s, void **out_cursor,
         .class = class,
         .cmd = cmd,
     };
-    size_t data_size = iov_size(data_sg, data_num);
+    size_t data_size = iov_size(data_sg, data_num),
+           left_bytes = vhost_vdpa_net_cvq_cmd_page_len() -
+                        (*out_cursor - s->cvq_cmd_out_buffer);
     /* Buffers for the device */
     struct iovec out = {
-        .iov_base = *out_cursor,
         .iov_len = sizeof(ctrl) + data_size,
     };
     struct iovec in = {
-        .iov_base = *in_cursor,
         .iov_len = sizeof(*s->status),
     };
     ssize_t r;
 
-    assert(data_size < vhost_vdpa_net_cvq_cmd_page_len() - sizeof(ctrl));
+    if (sizeof(ctrl) > left_bytes || data_size > left_bytes - sizeof(ctrl) ||
+        vhost_vdpa_net_svq_available_slots(s) < 2) {
+        /*
+         * It is time to flush all pending control commands if SVQ is full
+         * or control commands shadow buffers are full.
+         *
+         * We can poll here since we've had BQL from the time
+         * we sent the descriptor.
+         */
+        r = vhost_vdpa_net_svq_flush(s, *in_cursor - (void *)s->status);
+        if (unlikely(r < 0)) {
+            return r;
+        }
+
+        *out_cursor = s->cvq_cmd_out_buffer;
+        *in_cursor = s->status;
+        left_bytes = vhost_vdpa_net_cvq_cmd_page_len();
+    }
+
+    out.iov_base = *out_cursor;
+    in.iov_base = *in_cursor;
+
+    assert(data_size <= left_bytes - sizeof(ctrl));
     /* Each CVQ command has one out descriptor and one in descriptor */
     assert(vhost_vdpa_net_svq_available_slots(s) >= 2);
 
@@ -670,11 +712,11 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s, void **out_cursor,
         return r;
     }
 
-    /*
-     * We can poll here since we've had BQL from the time
-     * we sent the descriptor.
-     */
-    return vhost_vdpa_net_svq_poll(s, 1);
+    /* iterate the cursors */
+    *out_cursor += out.iov_len;
+    *in_cursor += in.iov_len;
+
+    return 0;
 }
 
 static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet *n,
@@ -685,15 +727,12 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet *n,
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
+                                               VIRTIO_NET_CTRL_MAC,
+                                               VIRTIO_NET_CTRL_MAC_ADDR_SET,
+                                               &data, 1);
+        if (unlikely(r < 0)) {
+            return r;
         }
     }
 
@@ -738,15 +777,12 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet *n,
             .iov_len = mul_macs_size,
         },
     };
-    ssize_t dev_written = vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
+    ssize_t r = vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
                                 VIRTIO_NET_CTRL_MAC,
                                 VIRTIO_NET_CTRL_MAC_TABLE_SET,
                                 data, ARRAY_SIZE(data));
-    if (unlikely(dev_written < 0)) {
-        return dev_written;
-    }
-    if (*s->status != VIRTIO_NET_OK) {
-        return -EIO;
+    if (unlikely(r < 0)) {
+        return r;
     }
 
     return 0;
@@ -757,7 +793,7 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
                                   void **out_cursor, void **in_cursor)
 {
     struct virtio_net_ctrl_mq mq;
-    ssize_t dev_written;
+    ssize_t r;
 
     if (!virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_MQ)) {
         return 0;
@@ -768,15 +804,12 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
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
+                                   VIRTIO_NET_CTRL_MQ,
+                                   VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET,
+                                   &data, 1);
+    if (unlikely(r < 0)) {
+        return r;
     }
 
     return 0;
@@ -787,7 +820,7 @@ static int vhost_vdpa_net_load_offloads(VhostVDPAState *s,
                                         void **out_cursor, void **in_cursor)
 {
     uint64_t offloads;
-    ssize_t dev_written;
+    ssize_t r;
 
     if (!virtio_vdev_has_feature(&n->parent_obj,
                                  VIRTIO_NET_F_CTRL_GUEST_OFFLOADS)) {
@@ -815,15 +848,12 @@ static int vhost_vdpa_net_load_offloads(VhostVDPAState *s,
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
+                                   VIRTIO_NET_CTRL_GUEST_OFFLOADS,
+                                   VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET,
+                                   &data, 1);
+    if (unlikely(r < 0)) {
+        return r;
     }
 
     return 0;
@@ -838,15 +868,12 @@ static int vhost_vdpa_net_load_rx_mode(VhostVDPAState *s,
         .iov_base = &on,
         .iov_len = sizeof(on),
     };
-    ssize_t dev_written;
+    ssize_t r;
 
-    dev_written = vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
-                                          VIRTIO_NET_CTRL_RX, cmd, &data, 1);
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
@@ -1001,15 +1028,12 @@ static int vhost_vdpa_net_load_single_vlan(VhostVDPAState *s,
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
+                                           VIRTIO_NET_CTRL_VLAN,
+                                           VIRTIO_NET_CTRL_VLAN_ADD,
+                                           &data, 1);
+    if (unlikely(r < 0)) {
+        return r;
     }
 
     return 0;
@@ -1078,6 +1102,17 @@ static int vhost_vdpa_net_load(NetClientState *nc)
         return r;
     }
 
+    /*
+     * We need to poll and check all pending device's used buffers.
+     *
+     * We can poll here since we've had BQL from the time
+     * we sent the descriptor.
+     */
+    r = vhost_vdpa_net_svq_flush(s, in_cursor - (void *)s->status);
+    if (unlikely(r)) {
+        return r;
+    }
+
     return 0;
 }
 
-- 
2.25.1


