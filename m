Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FD778BE14
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 07:57:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qarhx-00057z-0q; Tue, 29 Aug 2023 01:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qarhk-000577-KF
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 01:55:58 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qarhe-0002ik-5S
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 01:55:54 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-68c3b9f83f4so2022571b3a.2
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 22:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693288547; x=1693893347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NfTx0Hrl4+YRf/62k7RWTHoALW+7G7pDoFFo6FwYUFU=;
 b=Hnkkyj1vfWRksHro803ocjqA2/MkfDRO9xNNzUFt/8ZsTznA33V2kGi3tec3r6bsbn
 c82syf00VATa6kMhJsxowhXYPBl4cvr/8tlHRuaMmUl0iVpmgma1eHuWqdH4wWfUCQ5U
 rQdohBSWvpAqplo1pVxDn+Ph1QnUFCiOePDkO9HIatgNJvqllQy6CJZavB1CPYZ56kNC
 BufXXlyFIWRRatxz5vccQeN1CA9hJ/3+VYVGdnQS/x9A+h6/NnlGKQTWS8a/IioKN6ae
 UPawoy14hIA8KKhvIo5XNq6iDQH5jZjLrRcyxqkQHg1bZbulA+TBPUyANWLzGNMxGXHy
 fXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693288547; x=1693893347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NfTx0Hrl4+YRf/62k7RWTHoALW+7G7pDoFFo6FwYUFU=;
 b=aHIeaqKot/Kc/LEhB9CCrlhELtMWS3Ql41ZjygYb1DtoNl49+ldkT1aUhevTAdYWHb
 +qSjLcD3bsU14VRGQle45HFrfvpCJeLLzwYyeSm/xVgZWrCvWU0TtJXt0JWPBNwxxjZE
 Uxu3orAevhobQlL01anb8m9/UXvqgRuEeW3upS5ybeApXAjVE4yeUw3m4TqNOAgNWQOM
 73J1bHGBz1bie6QCS82FVcDlF7iVPvXTHwIPgIuqMY4WPPSUCt9WFQdNnxB8dOo59Xf8
 vjtTtKyCIWyPQEncQ04h2K4f0YeSHkjOzw0VGBF9S7QtFpsDbmhtZ9jtUBogFt9ZVS7n
 IZdw==
X-Gm-Message-State: AOJu0YyzeFtbJas9LCNMf0dy51Ki+8bPKsnKDoBgd8KhyTEtE0gBAVj0
 3nsanN7v9qjeg9PbnSc3ED+DCPJf07tvpw==
X-Google-Smtp-Source: AGHT+IEx2hQDw26HuFo+F7JkSptld11CbnaVfwRi47YrnMwnjmLdTY7emYVp9jKUBQOsE6uO06TadQ==
X-Received: by 2002:a05:6a20:26a5:b0:13f:b028:7892 with SMTP id
 h37-20020a056a2026a500b0013fb0287892mr19631801pze.2.1693288546873; 
 Mon, 28 Aug 2023 22:55:46 -0700 (PDT)
Received: from localhost ([183.242.254.166]) by smtp.gmail.com with ESMTPSA id
 e12-20020aa7824c000000b0068bc6a75848sm7628575pfn.156.2023.08.28.22.55.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 22:55:46 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org, yin31149@gmail.com, leiyang@redhat.com,
 18801353760@163.com
Subject: [PATCH v4 7/8] vdpa: Introduce cursors to vhost_vdpa_net_loadx()
Date: Tue, 29 Aug 2023 13:54:49 +0800
Message-Id: <0e2af3ed5695a8044877911df791417fe0ba87af.1693287885.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1693287885.git.yin31149@gmail.com>
References: <cover.1693287885.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=yin31149@gmail.com; helo=mail-pf1-x429.google.com
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

This patch introduces two new arugments, `out_cursor`
and `in_cursor`, to vhost_vdpa_net_loadx(). Addtionally,
it includes a helper function
vhost_vdpa_net_load_cursor_reset() for resetting these
cursors.

Furthermore, this patch refactors vhost_vdpa_net_load_cmd()
so that vhost_vdpa_net_load_cmd() prepares buffers
for the device using the cursors arguments, instead
of directly accesses `s->cvq_cmd_out_buffer` and
`s->status` fields.

By making these change, next patches in this series
can refactor vhost_vdpa_net_load_cmd() directly to
iterate through the control commands shadow buffers,
allowing QEMU to send CVQ state load commands in parallel
at device startup.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
v4:
  - use `struct iovec` instead of `void **` as cursor
suggested by Eugenio
  - add vhost_vdpa_net_load_cursor_reset() helper function
to reset the cursors
  - refactor vhost_vdpa_net_load_cmd() to prepare buffers
by iov_copy() instead of accessing `in` and `out` directly
suggested by Eugenio

v3: https://lore.kernel.org/all/bf390934673f2b613359ea9d7ac6c89199c31384.1689748694.git.yin31149@gmail.com/

 net/vhost-vdpa.c | 114 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 77 insertions(+), 37 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index d9b8b3cf6c..a71e8c9090 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -633,7 +633,22 @@ static uint16_t vhost_vdpa_net_svq_available_slots(VhostVDPAState *s)
     return vhost_svq_available_slots(svq);
 }
 
-static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s, uint8_t class,
+static void vhost_vdpa_net_load_cursor_reset(VhostVDPAState *s,
+                                             struct iovec *out_cursor,
+                                             struct iovec *in_cursor)
+{
+    /* reset the cursor of the output buffer for the device */
+    out_cursor->iov_base = s->cvq_cmd_out_buffer;
+    out_cursor->iov_len = vhost_vdpa_net_cvq_cmd_page_len();
+
+    /* reset the cursor of the in buffer for the device */
+    in_cursor->iov_base = s->status;
+    in_cursor->iov_len = vhost_vdpa_net_cvq_cmd_page_len();
+}
+
+static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s,
+                                       struct iovec *out_cursor,
+                                       struct iovec *in_cursor, uint8_t class,
                                        uint8_t cmd, const struct iovec *data_sg,
                                        size_t data_num)
 {
@@ -641,28 +656,25 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s, uint8_t class,
         .class = class,
         .cmd = cmd,
     };
-    size_t data_size = iov_size(data_sg, data_num);
-    /* Buffers for the device */
-    const struct iovec out = {
-        .iov_base = s->cvq_cmd_out_buffer,
-        .iov_len = sizeof(ctrl) + data_size,
-    };
-    const struct iovec in = {
-        .iov_base = s->status,
-        .iov_len = sizeof(*s->status),
-    };
+    size_t data_size = iov_size(data_sg, data_num),
+           cmd_size = sizeof(ctrl) + data_size;
+    struct iovec out, in;
     ssize_t r;
 
     assert(data_size < vhost_vdpa_net_cvq_cmd_page_len() - sizeof(ctrl));
     /* Each CVQ command has one out descriptor and one in descriptor */
     assert(vhost_vdpa_net_svq_available_slots(s) >= 2);
 
-    /* pack the CVQ command header */
-    memcpy(s->cvq_cmd_out_buffer, &ctrl, sizeof(ctrl));
+    /* Prepare the buffer for out descriptor for the device */
+    iov_copy(&out, 1, out_cursor, 1, 0, cmd_size);
+    /* Prepare the buffer for in descriptor for the device. */
+    iov_copy(&in, 1, in_cursor, 1, 0, sizeof(*s->status));
 
+    /* pack the CVQ command header */
+    iov_from_buf(&out, 1, 0, &ctrl, sizeof(ctrl));
     /* pack the CVQ command command-specific-data */
     iov_to_buf(data_sg, data_num, 0,
-               s->cvq_cmd_out_buffer + sizeof(ctrl), data_size);
+               out.iov_base + sizeof(ctrl), data_size);
 
     r = vhost_vdpa_net_cvq_add(s, &out, 1, &in, 1);
     if (unlikely(r < 0)) {
@@ -676,14 +688,17 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s, uint8_t class,
     return vhost_vdpa_net_svq_poll(s, 1);
 }
 
-static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet *n)
+static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet *n,
+                                   struct iovec *out_cursor,
+                                   struct iovec *in_cursor)
 {
     if (virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_CTRL_MAC_ADDR)) {
         const struct iovec data = {
             .iov_base = (void *)n->mac,
             .iov_len = sizeof(n->mac),
         };
-        ssize_t dev_written = vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_MAC,
+        ssize_t dev_written = vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
+                                                  VIRTIO_NET_CTRL_MAC,
                                                   VIRTIO_NET_CTRL_MAC_ADDR_SET,
                                                   &data, 1);
         if (unlikely(dev_written < 0)) {
@@ -735,7 +750,7 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet *n)
             .iov_len = mul_macs_size,
         },
     };
-    ssize_t dev_written = vhost_vdpa_net_load_cmd(s,
+    ssize_t dev_written = vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
                                 VIRTIO_NET_CTRL_MAC,
                                 VIRTIO_NET_CTRL_MAC_TABLE_SET,
                                 data, ARRAY_SIZE(data));
@@ -750,7 +765,9 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet *n)
 }
 
 static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
-                                  const VirtIONet *n)
+                                  const VirtIONet *n,
+                                  struct iovec *out_cursor,
+                                  struct iovec *in_cursor)
 {
     struct virtio_net_ctrl_mq mq;
     ssize_t dev_written;
@@ -764,7 +781,8 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
         .iov_base = &mq,
         .iov_len = sizeof(mq),
     };
-    dev_written = vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_MQ,
+    dev_written = vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
+                                          VIRTIO_NET_CTRL_MQ,
                                           VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET,
                                           &data, 1);
     if (unlikely(dev_written < 0)) {
@@ -778,7 +796,9 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
 }
 
 static int vhost_vdpa_net_load_offloads(VhostVDPAState *s,
-                                        const VirtIONet *n)
+                                        const VirtIONet *n,
+                                        struct iovec *out_cursor,
+                                        struct iovec *in_cursor)
 {
     uint64_t offloads;
     ssize_t dev_written;
@@ -809,7 +829,8 @@ static int vhost_vdpa_net_load_offloads(VhostVDPAState *s,
         .iov_base = &offloads,
         .iov_len = sizeof(offloads),
     };
-    dev_written = vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_GUEST_OFFLOADS,
+    dev_written = vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
+                                          VIRTIO_NET_CTRL_GUEST_OFFLOADS,
                                           VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET,
                                           &data, 1);
     if (unlikely(dev_written < 0)) {
@@ -823,6 +844,8 @@ static int vhost_vdpa_net_load_offloads(VhostVDPAState *s,
 }
 
 static int vhost_vdpa_net_load_rx_mode(VhostVDPAState *s,
+                                       struct iovec *out_cursor,
+                                       struct iovec *in_cursor,
                                        uint8_t cmd,
                                        uint8_t on)
 {
@@ -832,7 +855,8 @@ static int vhost_vdpa_net_load_rx_mode(VhostVDPAState *s,
     };
     ssize_t dev_written;
 
-    dev_written = vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_RX,
+    dev_written = vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
+                                          VIRTIO_NET_CTRL_RX,
                                           cmd, &data, 1);
     if (unlikely(dev_written < 0)) {
         return dev_written;
@@ -845,7 +869,9 @@ static int vhost_vdpa_net_load_rx_mode(VhostVDPAState *s,
 }
 
 static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
-                                  const VirtIONet *n)
+                                  const VirtIONet *n,
+                                  struct iovec *out_cursor,
+                                  struct iovec *in_cursor)
 {
     ssize_t r;
 
@@ -872,7 +898,8 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
      * configuration only at live migration.
      */
     if (!n->mac_table.uni_overflow && !n->promisc) {
-        r = vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_PROMISC, 0);
+        r = vhost_vdpa_net_load_rx_mode(s, out_cursor, in_cursor,
+                                        VIRTIO_NET_CTRL_RX_PROMISC, 0);
         if (unlikely(r < 0)) {
             return r;
         }
@@ -896,7 +923,8 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
      * configuration only at live migration.
      */
     if (n->mac_table.multi_overflow || n->allmulti) {
-        r = vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_ALLMULTI, 1);
+        r = vhost_vdpa_net_load_rx_mode(s, out_cursor, in_cursor,
+                                        VIRTIO_NET_CTRL_RX_ALLMULTI, 1);
         if (unlikely(r < 0)) {
             return r;
         }
@@ -917,7 +945,8 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
      * configuration only at live migration.
      */
     if (n->alluni) {
-        r = vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_ALLUNI, 1);
+        r = vhost_vdpa_net_load_rx_mode(s, out_cursor, in_cursor,
+                                        VIRTIO_NET_CTRL_RX_ALLUNI, 1);
         if (r < 0) {
             return r;
         }
@@ -934,7 +963,8 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
      * configuration only at live migration.
      */
     if (n->nomulti) {
-        r = vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_NOMULTI, 1);
+        r = vhost_vdpa_net_load_rx_mode(s, out_cursor, in_cursor,
+                                        VIRTIO_NET_CTRL_RX_NOMULTI, 1);
         if (r < 0) {
             return r;
         }
@@ -951,7 +981,8 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
      * configuration only at live migration.
      */
     if (n->nouni) {
-        r = vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_NOUNI, 1);
+        r = vhost_vdpa_net_load_rx_mode(s, out_cursor, in_cursor,
+                                        VIRTIO_NET_CTRL_RX_NOUNI, 1);
         if (r < 0) {
             return r;
         }
@@ -968,7 +999,8 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
      * configuration only at live migration.
      */
     if (n->nobcast) {
-        r = vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_NOBCAST, 1);
+        r = vhost_vdpa_net_load_rx_mode(s, out_cursor, in_cursor,
+                                        VIRTIO_NET_CTRL_RX_NOBCAST, 1);
         if (r < 0) {
             return r;
         }
@@ -979,13 +1011,16 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
 
 static int vhost_vdpa_net_load_single_vlan(VhostVDPAState *s,
                                            const VirtIONet *n,
+                                           struct iovec *out_cursor,
+                                           struct iovec *in_cursor,
                                            uint16_t vid)
 {
     const struct iovec data = {
         .iov_base = &vid,
         .iov_len = sizeof(vid),
     };
-    ssize_t dev_written = vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_VLAN,
+    ssize_t dev_written = vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
+                                                  VIRTIO_NET_CTRL_VLAN,
                                                   VIRTIO_NET_CTRL_VLAN_ADD,
                                                   &data, 1);
     if (unlikely(dev_written < 0)) {
@@ -999,7 +1034,9 @@ static int vhost_vdpa_net_load_single_vlan(VhostVDPAState *s,
 }
 
 static int vhost_vdpa_net_load_vlan(VhostVDPAState *s,
-                                    const VirtIONet *n)
+                                    const VirtIONet *n,
+                                    struct iovec *out_cursor,
+                                    struct iovec *in_cursor)
 {
     int r;
 
@@ -1010,7 +1047,8 @@ static int vhost_vdpa_net_load_vlan(VhostVDPAState *s,
     for (int i = 0; i < MAX_VLAN >> 5; i++) {
         for (int j = 0; n->vlans[i] && j <= 0x1f; j++) {
             if (n->vlans[i] & (1U << j)) {
-                r = vhost_vdpa_net_load_single_vlan(s, n, (i << 5) + j);
+                r = vhost_vdpa_net_load_single_vlan(s, n, out_cursor,
+                                                    in_cursor, (i << 5) + j);
                 if (unlikely(r != 0)) {
                     return r;
                 }
@@ -1027,6 +1065,7 @@ static int vhost_vdpa_net_load(NetClientState *nc)
     struct vhost_vdpa *v = &s->vhost_vdpa;
     const VirtIONet *n;
     int r;
+    struct iovec out_cursor, in_cursor;
 
     assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
 
@@ -1035,23 +1074,24 @@ static int vhost_vdpa_net_load(NetClientState *nc)
     }
 
     n = VIRTIO_NET(v->dev->vdev);
-    r = vhost_vdpa_net_load_mac(s, n);
+    vhost_vdpa_net_load_cursor_reset(s, &out_cursor, &in_cursor);
+    r = vhost_vdpa_net_load_mac(s, n, &out_cursor, &in_cursor);
     if (unlikely(r < 0)) {
         return r;
     }
-    r = vhost_vdpa_net_load_mq(s, n);
+    r = vhost_vdpa_net_load_mq(s, n, &out_cursor, &in_cursor);
     if (unlikely(r)) {
         return r;
     }
-    r = vhost_vdpa_net_load_offloads(s, n);
+    r = vhost_vdpa_net_load_offloads(s, n, &out_cursor, &in_cursor);
     if (unlikely(r)) {
         return r;
     }
-    r = vhost_vdpa_net_load_rx(s, n);
+    r = vhost_vdpa_net_load_rx(s, n, &out_cursor, &in_cursor);
     if (unlikely(r)) {
         return r;
     }
-    r = vhost_vdpa_net_load_vlan(s, n);
+    r = vhost_vdpa_net_load_vlan(s, n, &out_cursor, &in_cursor);
     if (unlikely(r)) {
         return r;
     }
-- 
2.25.1


