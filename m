Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D78C7CE1CF
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 17:54:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8rj-0004Ue-3l; Wed, 18 Oct 2023 11:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8rh-0004Lt-7s
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:53:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8rf-0006M8-6S
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:53:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y7BTRbAv0zAui1dpeWzjUtaiUFjyDwO0B9v/G8QAxzQ=;
 b=P4C+u0wMjEVCjbna/F0yMu1TjCEY9P1bP5v3Eh1YN8yfftj98X2mG1Ud2a60/FaijuLti7
 EYO821i6DPLtW8KH08Ww7nx2MoaBdEZOfrcsj8mnkKrWaN/lj5elg0+z2oSHWZtFzDoJqS
 uheRS9aDY3s0tCoeePhRe9wkr+wx2+Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-WEZ13DTqMa2Ezk2B8TM4PQ-1; Wed, 18 Oct 2023 11:53:41 -0400
X-MC-Unique: WEZ13DTqMa2Ezk2B8TM4PQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fe1521678fso49831625e9.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:53:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644419; x=1698249219;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y7BTRbAv0zAui1dpeWzjUtaiUFjyDwO0B9v/G8QAxzQ=;
 b=VBh36Gvxvgr441XSPI2cwTFPshPhrBYa0mwzaFN7EUZIamlbBNPqxXFGh9iY9XTvG6
 A8A0gqtCX3LI6K6SPsUA7aY8sh+aNPKI9qd0fyZQb7MJ2uAspvGqudOz9oshEXjStZ0Q
 KKfWrSiG6Pw7oYPYcunajhIkBZHybVVYc2wuID031c8trV2IsemBUyKlte4DzxPScR6n
 YeejPxfXFrZu8HPNizIvDSbhATOR/7x4bkmweC0MWn/QTEEy8blqczF50qpa2/vZvbX8
 sPeWpVT6qFYBYOp5oM8nJ4iStqw/M39x0yxEvcMXrBOhC60lAYmxP19CHESK+n4UzObm
 mkaw==
X-Gm-Message-State: AOJu0YxYdc22EPwjqMUIg/FmsQbRbzdjUkKLd6wrB6FQdUe/pMEClyuh
 A1tcbG3dtIzg8eyhrGWAC186RU7TC0DM1KKbb3A4JkDGcTBY1eFQgq2TXlgXfi6SRY17qzi4q6B
 FWITFVWYjPLscvzI0W6U+88X4+oYXbWH9fNg5kLRBQihP4jS+NXmNPAGWFLM2Z4K7sDGvYpQ=
X-Received: by 2002:a05:600c:3b98:b0:408:2686:e1ba with SMTP id
 n24-20020a05600c3b9800b004082686e1bamr3515612wms.20.1697644419337; 
 Wed, 18 Oct 2023 08:53:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrPqSB0BtRD3mF0GJuhX8hxNYxNSOmAqtion2u84U4EYphRPv2pYs55tpI2IopGSthAKGYUA==
X-Received: by 2002:a05:600c:3b98:b0:408:2686:e1ba with SMTP id
 n24-20020a05600c3b9800b004082686e1bamr3515596wms.20.1697644418740; 
 Wed, 18 Oct 2023 08:53:38 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 x19-20020a05600c421300b003fc16ee2864sm1958115wmh.48.2023.10.18.08.53.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:53:38 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:53:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hawkins Jiawei <yin31149@gmail.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 05/83] vdpa: Introduce cursors to vhost_vdpa_net_loadx()
Message-ID: <1d7e2a8fd4996fdb20d74fce41fe897311f3b06a.1697644299.git.mst@redhat.com>
References: <cover.1697644299.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697644299.git.mst@redhat.com>
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
Message-Id: <1c6516e233a14cc222f0884e148e4e1adceda78d.1697165821.git.yin31149@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 111 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 75 insertions(+), 36 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index ea73e3c410..ef4d242811 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -648,7 +648,22 @@ static ssize_t vhost_vdpa_net_svq_poll(VhostVDPAState *s, size_t cmds_in_flight)
     return vhost_svq_poll(svq, cmds_in_flight);
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
@@ -657,25 +672,21 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s, uint8_t class,
         .cmd = cmd,
     };
     size_t data_size = iov_size(data_sg, data_num);
-    /* Buffers for the device */
-    const struct iovec out = {
-        .iov_base = s->cvq_cmd_out_buffer,
-        .iov_len = sizeof(ctrl) + data_size,
-    };
-    const struct iovec in = {
-        .iov_base = s->status,
-        .iov_len = sizeof(*s->status),
-    };
+    struct iovec out, in;
     ssize_t r;
 
     assert(data_size < vhost_vdpa_net_cvq_cmd_page_len() - sizeof(ctrl));
 
     /* pack the CVQ command header */
-    memcpy(s->cvq_cmd_out_buffer, &ctrl, sizeof(ctrl));
-
+    iov_from_buf(out_cursor, 1, 0, &ctrl, sizeof(ctrl));
     /* pack the CVQ command command-specific-data */
     iov_to_buf(data_sg, data_num, 0,
-               s->cvq_cmd_out_buffer + sizeof(ctrl), data_size);
+               out_cursor->iov_base + sizeof(ctrl), data_size);
+
+    /* extract the required buffer from the cursor for output */
+    iov_copy(&out, 1, out_cursor, 1, 0, sizeof(ctrl) + data_size);
+    /* extract the required buffer from the cursor for input */
+    iov_copy(&in, 1, in_cursor, 1, 0, sizeof(*s->status));
 
     r = vhost_vdpa_net_cvq_add(s, &out, 1, &in, 1);
     if (unlikely(r < 0)) {
@@ -689,14 +700,17 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s, uint8_t class,
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
@@ -748,7 +762,7 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet *n)
             .iov_len = mul_macs_size,
         },
     };
-    ssize_t dev_written = vhost_vdpa_net_load_cmd(s,
+    ssize_t dev_written = vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
                                 VIRTIO_NET_CTRL_MAC,
                                 VIRTIO_NET_CTRL_MAC_TABLE_SET,
                                 data, ARRAY_SIZE(data));
@@ -763,7 +777,9 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet *n)
 }
 
 static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
-                                  const VirtIONet *n)
+                                  const VirtIONet *n,
+                                  struct iovec *out_cursor,
+                                  struct iovec *in_cursor)
 {
     struct virtio_net_ctrl_mq mq;
     ssize_t dev_written;
@@ -777,7 +793,8 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
         .iov_base = &mq,
         .iov_len = sizeof(mq),
     };
-    dev_written = vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_MQ,
+    dev_written = vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
+                                          VIRTIO_NET_CTRL_MQ,
                                           VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET,
                                           &data, 1);
     if (unlikely(dev_written < 0)) {
@@ -791,7 +808,9 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
 }
 
 static int vhost_vdpa_net_load_offloads(VhostVDPAState *s,
-                                        const VirtIONet *n)
+                                        const VirtIONet *n,
+                                        struct iovec *out_cursor,
+                                        struct iovec *in_cursor)
 {
     uint64_t offloads;
     ssize_t dev_written;
@@ -822,7 +841,8 @@ static int vhost_vdpa_net_load_offloads(VhostVDPAState *s,
         .iov_base = &offloads,
         .iov_len = sizeof(offloads),
     };
-    dev_written = vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_GUEST_OFFLOADS,
+    dev_written = vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
+                                          VIRTIO_NET_CTRL_GUEST_OFFLOADS,
                                           VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET,
                                           &data, 1);
     if (unlikely(dev_written < 0)) {
@@ -836,6 +856,8 @@ static int vhost_vdpa_net_load_offloads(VhostVDPAState *s,
 }
 
 static int vhost_vdpa_net_load_rx_mode(VhostVDPAState *s,
+                                       struct iovec *out_cursor,
+                                       struct iovec *in_cursor,
                                        uint8_t cmd,
                                        uint8_t on)
 {
@@ -845,7 +867,8 @@ static int vhost_vdpa_net_load_rx_mode(VhostVDPAState *s,
     };
     ssize_t dev_written;
 
-    dev_written = vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_RX,
+    dev_written = vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
+                                          VIRTIO_NET_CTRL_RX,
                                           cmd, &data, 1);
     if (unlikely(dev_written < 0)) {
         return dev_written;
@@ -858,7 +881,9 @@ static int vhost_vdpa_net_load_rx_mode(VhostVDPAState *s,
 }
 
 static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
-                                  const VirtIONet *n)
+                                  const VirtIONet *n,
+                                  struct iovec *out_cursor,
+                                  struct iovec *in_cursor)
 {
     ssize_t r;
 
@@ -885,7 +910,8 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
      * configuration only at live migration.
      */
     if (!n->mac_table.uni_overflow && !n->promisc) {
-        r = vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_PROMISC, 0);
+        r = vhost_vdpa_net_load_rx_mode(s, out_cursor, in_cursor,
+                                        VIRTIO_NET_CTRL_RX_PROMISC, 0);
         if (unlikely(r < 0)) {
             return r;
         }
@@ -909,7 +935,8 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
      * configuration only at live migration.
      */
     if (n->mac_table.multi_overflow || n->allmulti) {
-        r = vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_ALLMULTI, 1);
+        r = vhost_vdpa_net_load_rx_mode(s, out_cursor, in_cursor,
+                                        VIRTIO_NET_CTRL_RX_ALLMULTI, 1);
         if (unlikely(r < 0)) {
             return r;
         }
@@ -930,7 +957,8 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
      * configuration only at live migration.
      */
     if (n->alluni) {
-        r = vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_ALLUNI, 1);
+        r = vhost_vdpa_net_load_rx_mode(s, out_cursor, in_cursor,
+                                        VIRTIO_NET_CTRL_RX_ALLUNI, 1);
         if (r < 0) {
             return r;
         }
@@ -947,7 +975,8 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
      * configuration only at live migration.
      */
     if (n->nomulti) {
-        r = vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_NOMULTI, 1);
+        r = vhost_vdpa_net_load_rx_mode(s, out_cursor, in_cursor,
+                                        VIRTIO_NET_CTRL_RX_NOMULTI, 1);
         if (r < 0) {
             return r;
         }
@@ -964,7 +993,8 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
      * configuration only at live migration.
      */
     if (n->nouni) {
-        r = vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_NOUNI, 1);
+        r = vhost_vdpa_net_load_rx_mode(s, out_cursor, in_cursor,
+                                        VIRTIO_NET_CTRL_RX_NOUNI, 1);
         if (r < 0) {
             return r;
         }
@@ -981,7 +1011,8 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
      * configuration only at live migration.
      */
     if (n->nobcast) {
-        r = vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_NOBCAST, 1);
+        r = vhost_vdpa_net_load_rx_mode(s, out_cursor, in_cursor,
+                                        VIRTIO_NET_CTRL_RX_NOBCAST, 1);
         if (r < 0) {
             return r;
         }
@@ -992,13 +1023,16 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
 
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
@@ -1012,7 +1046,9 @@ static int vhost_vdpa_net_load_single_vlan(VhostVDPAState *s,
 }
 
 static int vhost_vdpa_net_load_vlan(VhostVDPAState *s,
-                                    const VirtIONet *n)
+                                    const VirtIONet *n,
+                                    struct iovec *out_cursor,
+                                    struct iovec *in_cursor)
 {
     int r;
 
@@ -1023,7 +1059,8 @@ static int vhost_vdpa_net_load_vlan(VhostVDPAState *s,
     for (int i = 0; i < MAX_VLAN >> 5; i++) {
         for (int j = 0; n->vlans[i] && j <= 0x1f; j++) {
             if (n->vlans[i] & (1U << j)) {
-                r = vhost_vdpa_net_load_single_vlan(s, n, (i << 5) + j);
+                r = vhost_vdpa_net_load_single_vlan(s, n, out_cursor,
+                                                    in_cursor, (i << 5) + j);
                 if (unlikely(r != 0)) {
                     return r;
                 }
@@ -1040,6 +1077,7 @@ static int vhost_vdpa_net_cvq_load(NetClientState *nc)
     struct vhost_vdpa *v = &s->vhost_vdpa;
     const VirtIONet *n;
     int r;
+    struct iovec out_cursor, in_cursor;
 
     assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
 
@@ -1047,23 +1085,24 @@ static int vhost_vdpa_net_cvq_load(NetClientState *nc)
 
     if (v->shadow_vqs_enabled) {
         n = VIRTIO_NET(v->dev->vdev);
-        r = vhost_vdpa_net_load_mac(s, n);
+        vhost_vdpa_net_load_cursor_reset(s, &out_cursor, &in_cursor);
+        r = vhost_vdpa_net_load_mac(s, n, &out_cursor, &in_cursor);
         if (unlikely(r < 0)) {
             return r;
         }
-        r = vhost_vdpa_net_load_mq(s, n);
+        r = vhost_vdpa_net_load_mq(s, n, &out_cursor, &in_cursor);
         if (unlikely(r)) {
             return r;
         }
-        r = vhost_vdpa_net_load_offloads(s, n);
+        r = vhost_vdpa_net_load_offloads(s, n, &out_cursor, &in_cursor);
         if (unlikely(r)) {
             return r;
         }
-        r = vhost_vdpa_net_load_rx(s, n);
+        r = vhost_vdpa_net_load_rx(s, n, &out_cursor, &in_cursor);
         if (unlikely(r)) {
             return r;
         }
-        r = vhost_vdpa_net_load_vlan(s, n);
+        r = vhost_vdpa_net_load_vlan(s, n, &out_cursor, &in_cursor);
         if (unlikely(r)) {
             return r;
         }
-- 
MST


