Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1391D758FB4
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 09:55:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM21E-0005cX-PQ; Wed, 19 Jul 2023 03:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qM214-0005PD-OG
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 03:54:38 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qM212-0003QC-N8
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 03:54:34 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6689430d803so4467272b3a.0
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 00:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689753271; x=1692345271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kax3kZAFUArGF7G0Eefgbu80wcduxB0sSZaLz99i4/w=;
 b=MwaT8sRLJxkkShb4xfnrHRXvq+R85TGXUr/A6xi2eegnjmmXIW/8FX49jl+aLs1mid
 SgWg5tEzIxCPFHtTLwSIP20OO4R7Tjyznrau5j+Y//S2TIFnso4OC2liMhqe3D8l+km+
 L/eIMiqG0uv8BTmmOPMhhcATJOLYiM5aDZrhugbfw8yTxDG3owF68iFXLR4b73OnxNqz
 E9V5xUI6bmp1XC1k9CVDJrHbP3P0PFXHHCkeSjWILLS6M+Lnu5SUbtmt7MvwskVnUexF
 5iJujhDNSdnnecKfjT3ZRkHRpg7jjAU9lN3CFJXJgK0gjd/WJi2bZ6mH9xBQRD30klSz
 I1Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689753271; x=1692345271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kax3kZAFUArGF7G0Eefgbu80wcduxB0sSZaLz99i4/w=;
 b=P3tpskeYhb7ri6nqotJjk6Mo6Y8C65xRdBEP28oJcw80zy/AFfTFHpbUCZZBBzM2rq
 By+jWoI/5su/TLx54xi/cXOeshNAL2f5i2h4w4swB/okh1McDgay/9BJxrK73e3As2sX
 JTzesGY0gtn3lqa8hrTLRq6Mkdf4yZkslPIG04s+Ypj9IHJDYgUJviKAweKP4q8N2EPa
 YeXBey1ttPAfN/ORhqdI+vIF2pbx57b2wcXuilVWq84is7YXbmvldsQ8cEpICbqSWmdD
 7NFaofXYh3Oh25RIMcTvVjmpifKz1DBmkH+izVMZoSZbx8TTHWu38ptAmWOFUxWSP++P
 bBLA==
X-Gm-Message-State: ABy/qLb5QaGuwhaUaIUJdwEifn+FlgDWRA+gHe+q8Ap/puGxcx4lpotG
 b1rLXMoAhHqlePa2tyE4ZrI=
X-Google-Smtp-Source: APBJJlFnR9xSsebEzXfPnwyKnus63+cClM7+nCUPU88UJzITZnh07tSzG6J3AQeBhZBMJtchPr57SQ==
X-Received: by 2002:a05:6a00:b56:b0:67f:e74a:d309 with SMTP id
 p22-20020a056a000b5600b0067fe74ad309mr20469348pfo.30.1689753271060; 
 Wed, 19 Jul 2023 00:54:31 -0700 (PDT)
Received: from localhost ([183.242.254.166]) by smtp.gmail.com with ESMTPSA id
 j10-20020aa783ca000000b0063f2a5a59d1sm2635231pfn.190.2023.07.19.00.54.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jul 2023 00:54:30 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v3 7/8] vdpa: Add cursors to vhost_vdpa_net_loadx()
Date: Wed, 19 Jul 2023 15:53:52 +0800
Message-Id: <bf390934673f2b613359ea9d7ac6c89199c31384.1689748694.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1689748694.git.yin31149@gmail.com>
References: <cover.1689748694.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=yin31149@gmail.com; helo=mail-pf1-x429.google.com
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

This patch adds `out_cursor` and `in_cursor` arguments
to vhost_vdpa_net_loadx().

By making this change, next patches in this series
can refactor vhost_vdpa_net_load_cmd() directly to
iterate through the control commands shadow buffers,
allowing QEMU to send CVQ state load commands in parallel
at device startup.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
 net/vhost-vdpa.c | 79 ++++++++++++++++++++++++++++++------------------
 1 file changed, 50 insertions(+), 29 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index d06f38403f..795c9c1fd2 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -633,7 +633,8 @@ static uint16_t vhost_vdpa_net_svq_available_slots(VhostVDPAState *s)
     return vhost_svq_available_slots(svq);
 }
 
-static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s, uint8_t class,
+static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s, void **out_cursor,
+                                       void **in_cursor, uint8_t class,
                                        uint8_t cmd, const struct iovec *data_sg,
                                        size_t data_num)
 {
@@ -644,11 +645,11 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s, uint8_t class,
     size_t data_size = iov_size(data_sg, data_num);
     /* Buffers for the device */
     struct iovec out = {
-        .iov_base = s->cvq_cmd_out_buffer,
+        .iov_base = *out_cursor,
         .iov_len = sizeof(ctrl) + data_size,
     };
     struct iovec in = {
-        .iov_base = s->status,
+        .iov_base = *in_cursor,
         .iov_len = sizeof(*s->status),
     };
     ssize_t r;
@@ -658,11 +659,11 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s, uint8_t class,
     assert(vhost_vdpa_net_svq_available_slots(s) >= 2);
 
     /* pack the CVQ command header */
-    memcpy(s->cvq_cmd_out_buffer, &ctrl, sizeof(ctrl));
+    memcpy(out.iov_base, &ctrl, sizeof(ctrl));
 
     /* pack the CVQ command command-specific-data */
     iov_to_buf(data_sg, data_num, 0,
-               s->cvq_cmd_out_buffer + sizeof(ctrl), data_size);
+               out.iov_base + sizeof(ctrl), data_size);
 
     r = vhost_vdpa_net_cvq_add(s, &out, 1, &in, 1);
     if (unlikely(r < 0)) {
@@ -676,14 +677,16 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s, uint8_t class,
     return vhost_vdpa_net_svq_poll(s, 1);
 }
 
-static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet *n)
+static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet *n,
+                                   void **out_cursor, void **in_cursor)
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
@@ -735,7 +738,7 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet *n)
             .iov_len = mul_macs_size,
         },
     };
-    ssize_t dev_written = vhost_vdpa_net_load_cmd(s,
+    ssize_t dev_written = vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
                                 VIRTIO_NET_CTRL_MAC,
                                 VIRTIO_NET_CTRL_MAC_TABLE_SET,
                                 data, ARRAY_SIZE(data));
@@ -750,7 +753,8 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet *n)
 }
 
 static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
-                                  const VirtIONet *n)
+                                  const VirtIONet *n,
+                                  void **out_cursor, void **in_cursor)
 {
     struct virtio_net_ctrl_mq mq;
     ssize_t dev_written;
@@ -764,7 +768,8 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
         .iov_base = &mq,
         .iov_len = sizeof(mq),
     };
-    dev_written = vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_MQ,
+    dev_written = vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
+                                          VIRTIO_NET_CTRL_MQ,
                                           VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET,
                                           &data, 1);
     if (unlikely(dev_written < 0)) {
@@ -778,7 +783,8 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
 }
 
 static int vhost_vdpa_net_load_offloads(VhostVDPAState *s,
-                                        const VirtIONet *n)
+                                        const VirtIONet *n,
+                                        void **out_cursor, void **in_cursor)
 {
     uint64_t offloads;
     ssize_t dev_written;
@@ -809,7 +815,8 @@ static int vhost_vdpa_net_load_offloads(VhostVDPAState *s,
         .iov_base = &offloads,
         .iov_len = sizeof(offloads),
     };
-    dev_written = vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_GUEST_OFFLOADS,
+    dev_written = vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
+                                          VIRTIO_NET_CTRL_GUEST_OFFLOADS,
                                           VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET,
                                           &data, 1);
     if (unlikely(dev_written < 0)) {
@@ -823,6 +830,7 @@ static int vhost_vdpa_net_load_offloads(VhostVDPAState *s,
 }
 
 static int vhost_vdpa_net_load_rx_mode(VhostVDPAState *s,
+                                       void **out_cursor, void **in_cursor,
                                        uint8_t cmd,
                                        uint8_t on)
 {
@@ -832,8 +840,8 @@ static int vhost_vdpa_net_load_rx_mode(VhostVDPAState *s,
     };
     ssize_t dev_written;
 
-    dev_written = vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_RX,
-                                          cmd, &data, 1);
+    dev_written = vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
+                                          VIRTIO_NET_CTRL_RX, cmd, &data, 1);
     if (unlikely(dev_written < 0)) {
         return dev_written;
     }
@@ -845,7 +853,8 @@ static int vhost_vdpa_net_load_rx_mode(VhostVDPAState *s,
 }
 
 static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
-                                  const VirtIONet *n)
+                                  const VirtIONet *n,
+                                  void **out_cursor, void **in_cursor)
 {
     ssize_t r;
 
@@ -872,7 +881,8 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
      * configuration only at live migration.
      */
     if (!n->mac_table.uni_overflow && !n->promisc) {
-        r = vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_PROMISC, 0);
+        r = vhost_vdpa_net_load_rx_mode(s, out_cursor, in_cursor,
+                                        VIRTIO_NET_CTRL_RX_PROMISC, 0);
         if (unlikely(r < 0)) {
             return r;
         }
@@ -896,7 +906,8 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
      * configuration only at live migration.
      */
     if (n->mac_table.multi_overflow || n->allmulti) {
-        r = vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_ALLMULTI, 1);
+        r = vhost_vdpa_net_load_rx_mode(s, out_cursor, in_cursor,
+                                        VIRTIO_NET_CTRL_RX_ALLMULTI, 1);
         if (unlikely(r < 0)) {
             return r;
         }
@@ -917,7 +928,8 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
      * configuration only at live migration.
      */
     if (n->alluni) {
-        r = vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_ALLUNI, 1);
+        r = vhost_vdpa_net_load_rx_mode(s, out_cursor, in_cursor,
+                                        VIRTIO_NET_CTRL_RX_ALLUNI, 1);
         if (r < 0) {
             return r;
         }
@@ -934,7 +946,8 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
      * configuration only at live migration.
      */
     if (n->nomulti) {
-        r = vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_NOMULTI, 1);
+        r = vhost_vdpa_net_load_rx_mode(s, out_cursor, in_cursor,
+                                        VIRTIO_NET_CTRL_RX_NOMULTI, 1);
         if (r < 0) {
             return r;
         }
@@ -951,7 +964,8 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
      * configuration only at live migration.
      */
     if (n->nouni) {
-        r = vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_NOUNI, 1);
+        r = vhost_vdpa_net_load_rx_mode(s, out_cursor, in_cursor,
+                                        VIRTIO_NET_CTRL_RX_NOUNI, 1);
         if (r < 0) {
             return r;
         }
@@ -968,7 +982,8 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
      * configuration only at live migration.
      */
     if (n->nobcast) {
-        r = vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_NOBCAST, 1);
+        r = vhost_vdpa_net_load_rx_mode(s, out_cursor, in_cursor,
+                                        VIRTIO_NET_CTRL_RX_NOBCAST, 1);
         if (r < 0) {
             return r;
         }
@@ -979,13 +994,15 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
 
 static int vhost_vdpa_net_load_single_vlan(VhostVDPAState *s,
                                            const VirtIONet *n,
+                                           void **out_cursor, void **in_cursor,
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
@@ -999,7 +1016,8 @@ static int vhost_vdpa_net_load_single_vlan(VhostVDPAState *s,
 }
 
 static int vhost_vdpa_net_load_vlan(VhostVDPAState *s,
-                                    const VirtIONet *n)
+                                    const VirtIONet *n,
+                                    void **out_cursor, void **in_cursor)
 {
     int r;
 
@@ -1010,7 +1028,8 @@ static int vhost_vdpa_net_load_vlan(VhostVDPAState *s,
     for (int i = 0; i < MAX_VLAN >> 5; i++) {
         for (int j = 0; n->vlans[i] && j <= 0x1f; j++) {
             if (n->vlans[i] & (1U << j)) {
-                r = vhost_vdpa_net_load_single_vlan(s, n, (i << 5) + j);
+                r = vhost_vdpa_net_load_single_vlan(s, n, out_cursor,
+                                                    in_cursor, (i << 5) + j);
                 if (unlikely(r != 0)) {
                     return r;
                 }
@@ -1028,6 +1047,8 @@ static int vhost_vdpa_net_load(NetClientState *nc)
     struct vhost_vdpa *v = &s->vhost_vdpa;
     const VirtIONet *n;
     int r;
+    void *out_cursor = s->cvq_cmd_out_buffer,
+         *in_cursor = s->status;
 
     assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
 
@@ -1036,23 +1057,23 @@ static int vhost_vdpa_net_load(NetClientState *nc)
     }
 
     n = VIRTIO_NET(v->dev->vdev);
-    r = vhost_vdpa_net_load_mac(s, n);
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


