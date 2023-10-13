Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 272937C7FD5
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:18:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDFq-0000Nh-Hz; Fri, 13 Oct 2023 04:10:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qrDFn-0000LM-8R
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:10:39 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qrDFd-0001uD-Id
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:10:38 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1c9b95943beso15818935ad.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697184628; x=1697789428; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OaRHVh+YUDmOgYXrkkTq1bhMOwcUQ/jKkeQOpSeohxY=;
 b=JGrrtMAibKeA+FVIryUj9iPQjmDmtk/kiRgo6LJjiMTO/yHGgcMY6RKOymbsOM48WW
 k4kfWpczIamNOQ7ird5cKlnzqYsCO3P6itQ7XZ6U1wE5/0gUy4ypriOi/m5lSCciZXXZ
 Urwp9koRuw6XGsQ2O61K29RJGFZJgm8eGTHFqv2djEDVWrcd6nQY9f13YH49tnbdEBSP
 okehHqjM3v8bFdPOfEy1bWfK0S699aT80JawE8DnzylECDOISPf7SogiidHRrSk3cYOQ
 6HyupR3pRUC1HPpLSkA1iPzvgdi7c9W7UOVg0zCxT0tvgYgk2frpiY57WVNKCtxi+wBe
 U2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697184628; x=1697789428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OaRHVh+YUDmOgYXrkkTq1bhMOwcUQ/jKkeQOpSeohxY=;
 b=S8AN7NMn1hv3cg9kVcTryAkvUef36CqG7jvbanCQ2J4nmjTJeQwxqdX+RmxUfXsIzb
 RsXgBpbGpgI9IUcxwGqqMM1rH/1T1C7R4GgeAgRsbMvQE0lnIXFrZWJnidIbv/gT6IPt
 BSOCk9tQQ0HFleQ5HcbIrYpkfLbJR9HyQhA9DHpNVnJoSbYnqRZwpyUpsb1auL+1YSF6
 Uy05ITPtCUDh2E0M7VYDx5UFZgiYw3N4KZT7VQ6m4AztpczlI0LakfeQBgcC3NUOPju6
 jFhKr8BMhe8DNKjoQCw52Q6sJSLNejF7qf8bxXcUWhdDvt5gwkmfrgx7oT4pRiwwvcwq
 Qjow==
X-Gm-Message-State: AOJu0YwDmP9Y7O+31BIHjUVqDafOufYgr3BSg7cNgssFhHW/CZJHnse4
 mEeTzatqW70hVjQuobceHUmk97UhpcUWUi4s
X-Google-Smtp-Source: AGHT+IEP3nQtWc4GiDAvPXFwFQu5Kk+DUI0tp7utbHO8zYckbebo+shVHzz9rLw82r7zqRCNaQYorw==
X-Received: by 2002:a17:903:1c8:b0:1c8:a63a:2087 with SMTP id
 e8-20020a17090301c800b001c8a63a2087mr16816701plh.65.1697184628062; 
 Fri, 13 Oct 2023 01:10:28 -0700 (PDT)
Received: from localhost ([183.242.254.166]) by smtp.gmail.com with ESMTPSA id
 u9-20020a17090341c900b001c631236505sm3255497ple.228.2023.10.13.01.10.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:10:27 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v5 7/7] vdpa: Send cvq state load commands in parallel
Date: Fri, 13 Oct 2023 16:09:42 +0800
Message-Id: <9350f32278e39f7bce297b8f2d82dac27c6f8c9a.1697165821.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1697165821.git.yin31149@gmail.com>
References: <cover.1697165821.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=yin31149@gmail.com; helo=mail-pl1-x630.google.com
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
Acked-by: Eugenio Pérez <eperezma@redhat.com>
---
v5:
  - remove the assertion suggested by Eugenio
  - inline the vhost_svq_available_slots() in vhost_vdpa_net_load_cmd()
suggested by Eugenio
  - fix conflicts with master branch

v4: https://lore.kernel.org/all/f25fea0b0aed78bad2dd5744a4cc5538243672e6.1693287885.git.yin31149@gmail.com/
  - refactor argument `cmds_in_flight` to `len` for
vhost_vdpa_net_svq_full()
  - check the return value of vhost_vdpa_net_svq_poll()
in vhost_vdpa_net_svq_flush() suggested by Eugenio
  - use iov_size(), vhost_vdpa_net_load_cursor_reset()
and iov_discard_front() to update the cursors instead of
accessing it directly according to Eugenio

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
2.25.1


