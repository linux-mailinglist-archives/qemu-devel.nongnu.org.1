Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C1C78BE18
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 07:57:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qarhz-00058o-NK; Tue, 29 Aug 2023 01:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qarhs-000580-Lt
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 01:56:07 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qarhk-0002l9-31
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 01:56:04 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1bc8a2f71eeso23775285ad.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 22:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693288552; x=1693893352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7dsgzwmViTn9/wS4VhlcvKq+IPKkq446pVF0AUIy9js=;
 b=jWWXnzncvNvOdG3bOlMtOHq0kzBN5tVAyqhg0Jj9YS6TysuzEUpmebtuc/9+O+jc4U
 ZCMxptn1XAGjXI31sc1gROrbcBiXufuh7pe/s//xtOFcfVyOWma9J+xzppIKUDUrbX66
 07SsXS89/xyP9Lhl76TyCR/pe3q1bY6nbR7FYG0EAcjXcXX8PW0ITX/sJfhYraJWrXB2
 H2Bk2uckFn5X0NPHhpGV+5QUZUlebuOfH3EZDJ5H140XkI/IxX9JVyxfn+TEvlbU+vIq
 dNf41foJi9bQg7SmH4xADkbzodkWfGcMevMAV8RwXeAXsF1W/fEz6WfWFEDealljrwKk
 qI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693288552; x=1693893352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7dsgzwmViTn9/wS4VhlcvKq+IPKkq446pVF0AUIy9js=;
 b=IOkqdVMl3gB06jF99Ot6PW2PaEipywmXlMXVEePMy0Z+ZAE08npDyYe/x9YGX7Cqw0
 KkzsN2CKtSzKjlXbr4RUggc4os4jCTJMc+mXGclN3cn+GHxTvWE8pYthpSwATkl8VR3M
 VhZHgOB5kbq0+4axN610XRohlVbz+f8DUC9+6j0eEAG2ANhSYdCdHf6Z3BpvgtX3a0Hq
 MZAG+VHCu1X0+kA7BdMrDQByH2ACtorLoA7IQz+b8xYS/G9SrWkIvzHomXU55zeN2fcV
 5VJ/5Iu+0DJIIqnbuwbbQvxuPx561MWIse8VXy+moCfdxZqeRN4gPL3P73Yu02i1832U
 b+lQ==
X-Gm-Message-State: AOJu0YxxU85MDTQVOPxw6wocDWlS15EnlkTLGmZdB3P5I7At6/P3WjXZ
 A3dZmXsr9hDM/cXn5DbGFeo=
X-Google-Smtp-Source: AGHT+IGZHjMpXFmJoHHr+SHT4wnIfgQQ9A8rShiepyo3QPaH7Ld9umjBt34GtZ6uaeFYDkQILPYbWw==
X-Received: by 2002:a17:902:cec9:b0:1be:c879:6e71 with SMTP id
 d9-20020a170902cec900b001bec8796e71mr27357410plg.63.1693288551821; 
 Mon, 28 Aug 2023 22:55:51 -0700 (PDT)
Received: from localhost ([183.242.254.166]) by smtp.gmail.com with ESMTPSA id
 ji18-20020a170903325200b001b9da8b4eb7sm8442002plb.35.2023.08.28.22.55.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 22:55:51 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org, yin31149@gmail.com, leiyang@redhat.com,
 18801353760@163.com
Subject: [PATCH v4 8/8] vdpa: Send cvq state load commands in parallel
Date: Tue, 29 Aug 2023 13:54:50 +0800
Message-Id: <f25fea0b0aed78bad2dd5744a4cc5538243672e6.1693287885.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1693287885.git.yin31149@gmail.com>
References: <cover.1693287885.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=yin31149@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
v4:
  - refactor argument `cmds_in_flight` to `len` for
vhost_vdpa_net_svq_full()
  - check the return value of vhost_vdpa_net_svq_poll()
in vhost_vdpa_net_svq_flush() suggested by Eugenio
  - use iov_size(), vhost_vdpa_net_load_cursor_reset()
and iov_discard_front() to update the cursors instead of
accessing it directly according to Eugenio

v3: https://lore.kernel.org/all/3a002790e6c880af928c6470ecbf03e7c65a68bb.1689748694.git.yin31149@gmail.com/

 net/vhost-vdpa.c | 155 +++++++++++++++++++++++++++++------------------
 1 file changed, 97 insertions(+), 58 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index a71e8c9090..818464b702 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -646,6 +646,31 @@ static void vhost_vdpa_net_load_cursor_reset(VhostVDPAState *s,
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
+    /* Device uses a one-byte length ack for each control command */
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
@@ -660,10 +685,30 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s,
            cmd_size = sizeof(ctrl) + data_size;
     struct iovec out, in;
     ssize_t r;
+    unsigned dummy_cursor_iov_cnt;
 
     assert(data_size < vhost_vdpa_net_cvq_cmd_page_len() - sizeof(ctrl));
+    if (vhost_vdpa_net_svq_available_slots(s) < 2 ||
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
+
     /* Each CVQ command has one out descriptor and one in descriptor */
     assert(vhost_vdpa_net_svq_available_slots(s) >= 2);
+    assert(iov_size(out_cursor, 1) >= cmd_size);
 
     /* Prepare the buffer for out descriptor for the device */
     iov_copy(&out, 1, out_cursor, 1, 0, cmd_size);
@@ -681,11 +726,13 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s,
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
@@ -697,15 +744,12 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet *n,
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
 
@@ -750,15 +794,12 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet *n,
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
@@ -770,7 +811,7 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
                                   struct iovec *in_cursor)
 {
     struct virtio_net_ctrl_mq mq;
-    ssize_t dev_written;
+    ssize_t r;
 
     if (!virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_MQ)) {
         return 0;
@@ -781,15 +822,12 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
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
@@ -801,7 +839,7 @@ static int vhost_vdpa_net_load_offloads(VhostVDPAState *s,
                                         struct iovec *in_cursor)
 {
     uint64_t offloads;
-    ssize_t dev_written;
+    ssize_t r;
 
     if (!virtio_vdev_has_feature(&n->parent_obj,
                                  VIRTIO_NET_F_CTRL_GUEST_OFFLOADS)) {
@@ -829,15 +867,12 @@ static int vhost_vdpa_net_load_offloads(VhostVDPAState *s,
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
@@ -853,16 +888,12 @@ static int vhost_vdpa_net_load_rx_mode(VhostVDPAState *s,
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
@@ -1019,15 +1050,12 @@ static int vhost_vdpa_net_load_single_vlan(VhostVDPAState *s,
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
@@ -1096,6 +1124,17 @@ static int vhost_vdpa_net_load(NetClientState *nc)
         return r;
     }
 
+    /*
+     * We need to poll and check all pending device's used buffers.
+     *
+     * We can poll here since we've had BQL from the time
+     * we sent the descriptor.
+     */
+    r = vhost_vdpa_net_svq_flush(s, in_cursor.iov_base - (void *)s->status);
+    if (unlikely(r)) {
+        return r;
+    }
+
     return 0;
 }
 
-- 
2.25.1


