Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1AD8B4A7C
	for <lists+qemu-devel@lfdr.de>; Sun, 28 Apr 2024 09:22:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0yr3-0001DV-5m; Sun, 28 Apr 2024 03:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s0yqr-0001An-0X
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 03:21:33 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s0yqo-0001DS-PZ
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 03:21:32 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6ed691fb83eso2959028b3a.1
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 00:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1714288889; x=1714893689;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GDWyqhzciPQOPZ3x/iBLlBOkuaet8IxpeyVbCQSNO+Y=;
 b=2GnorXt4CoaS7XAsgRfSqzddXzQBKATyGiTBL4FdcvtN7jfT3LaK3XWR8a6gSds+/n
 KY4+yk0wuwtgTbNLsCtHj3ULNxvo0EdHu4aH/6kpq7aJN6rXN6GMbCl3ptTyBMrAfudN
 WNRRISxdRVsAZ1bwyKbhHv8unPLemQTSk4p1cRGWsgINijumqr03QGVE84At3wPdO0N1
 MVF4nqgqqsFR+HnZzbqyRGxdw8E0+qv3GRJlT0O2kNZNqe6ythjYiT3JQEw+xdCS+jb8
 43VFU95w+RpDn8plhUtBuX5+BOcdTREAc4PvdAdU3zqqHvZtZe/+4kqp4GMl61gMIdfb
 +dMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714288889; x=1714893689;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GDWyqhzciPQOPZ3x/iBLlBOkuaet8IxpeyVbCQSNO+Y=;
 b=ScjfhLgatRQ3DAJqKkvCVwc7eqzU7ZL9lIJIJZ5xE0A4mrPRquF3CEyifJqmSbIFmC
 q5vMVWUnGeRFdWC2tNUOof6RgYNpMi4OgDatod/V2FnVCn1T6/aTVmO/yTTbokdsCPMN
 vjiBduS0+7kW1tlryO4knjcb2IhUsFQxTTrfxz7+WsF75Pa2pe5xvzKPdtPvxYLJxFjn
 DqrBA4oXwQfQsr92yv7zjs0T5cc19jhs5HYHEqVclbZDmQmrI2/last9eYpNeQm/Rk2J
 FcW/vpg2HdoO5b9iRxPFCDIm5Wy1MU9cUnA4OpiQtCHJNmNC9OpHWBMfYRvk5ZfpaB+X
 4OKA==
X-Gm-Message-State: AOJu0Yz/i0MsTnciBWaz+kUhw5Skk7lBpnHnfyrRy+yh71alcxdjjW4U
 8yPqObJ2FgH8q9gLtVFMtIAn61u5saq6QmrUpxUm90o/imKlUfCgyLI6ilt7D3Q=
X-Google-Smtp-Source: AGHT+IEMt1Ydb67FbuuayLZAM+C4K24g9JPCnWYnsah77xk8kqdAAd/1WyQ7p6S3QZrAgXthaH1Yxg==
X-Received: by 2002:a05:6a20:841e:b0:1a7:7cae:24dc with SMTP id
 c30-20020a056a20841e00b001a77cae24dcmr9088183pzd.5.1714288889388; 
 Sun, 28 Apr 2024 00:21:29 -0700 (PDT)
Received: from localhost ([157.82.202.162])
 by smtp.gmail.com with UTF8SMTPSA id
 y17-20020a17090322d100b001eb4a42221asm2319513plg.32.2024.04.28.00.21.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 00:21:29 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 28 Apr 2024 16:21:08 +0900
Subject: [PATCH 2/3] virtio-net: Convert feature properties to OnOffAuto
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240428-auto-v1-2-7b012216a120@daynix.com>
References: <20240428-auto-v1-0-7b012216a120@daynix.com>
In-Reply-To: <20240428-auto-v1-0-7b012216a120@daynix.com>
To: Jason Wang <jasowang@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>
Cc: qemu-devel@nongnu.org, 20240428-rss-v10-0-73cbaa91aeb6@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev
Received-SPF: none client-ip=2607:f8b0:4864:20::431;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Some features are not always available, and virtio-net used to disable
them when not available even if the corresponding properties were
explicitly set to "on".

Convert feature properties to OnOffAuto so that the user can explicitly
tell QEMU to automatically select the value by setting them "auto".
QEMU will give an error if they are set "on".

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/virtio/virtio-net.h |   2 +-
 hw/net/virtio-net.c            | 247 +++++++++++++++++++++++++----------------
 2 files changed, 152 insertions(+), 97 deletions(-)

diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 060c23c04d2d..ff32e30f001b 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -178,7 +178,7 @@ struct VirtIONet {
     uint32_t has_vnet_hdr;
     size_t host_hdr_len;
     size_t guest_hdr_len;
-    uint64_t host_features;
+    OnOffAutoBit64 host_features;
     uint32_t rsc_timeout;
     uint8_t rsc4_enabled;
     uint8_t rsc6_enabled;
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index c8059dc99bd4..5b6c901915a9 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -750,58 +750,96 @@ static void virtio_net_set_queue_pairs(VirtIONet *n)
 
 static void virtio_net_set_multiqueue(VirtIONet *n, int multiqueue);
 
+static bool virtio_net_clear_features(OnOffAutoBit64 *features,
+                                      uint64_t clear_bits,
+                                      const char *reason, Error **errp)
+{
+    if (features->on_bits & clear_bits) {
+        error_setg(errp, "%s", reason);
+        return false;
+    }
+
+    features->auto_bits &= ~clear_bits;
+
+    return true;
+}
+
 static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
                                         Error **errp)
 {
     VirtIONet *n = VIRTIO_NET(vdev);
     NetClientState *nc = qemu_get_queue(n->nic);
-
-    /* Firstly sync all virtio-net possible supported features */
-    features |= n->host_features;
-
-    virtio_add_feature(&features, VIRTIO_NET_F_MAC);
-
-    if (!peer_has_vnet_hdr(n)) {
-        virtio_clear_feature(&features, VIRTIO_NET_F_CSUM);
-        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_TSO4);
-        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_TSO6);
-        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_ECN);
-
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_CSUM);
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_TSO4);
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_TSO6);
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_ECN);
-
-        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_USO);
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO4);
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO6);
-
-        virtio_clear_feature(&features, VIRTIO_NET_F_HASH_REPORT);
-    }
-
-    if (!peer_has_vnet_hdr(n) || !peer_has_ufo(n)) {
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_UFO);
-        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_UFO);
-    }
-
-    if (!peer_has_uso(n)) {
-        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_USO);
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO4);
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO6);
+    OnOffAutoBit64 on_off_auto_features = n->host_features;
+
+    on_off_auto_features.on_bits |= features;
+    virtio_add_feature(&on_off_auto_features.auto_bits, VIRTIO_NET_F_MAC);
+
+    if (!((peer_has_vnet_hdr(n) ||
+           virtio_net_clear_features(&on_off_auto_features,
+                                     BIT_ULL(VIRTIO_NET_F_CSUM) |
+                                     BIT_ULL(VIRTIO_NET_F_HOST_TSO4) |
+                                     BIT_ULL(VIRTIO_NET_F_HOST_TSO6) |
+                                     BIT_ULL(VIRTIO_NET_F_HOST_ECN) |
+                                     BIT_ULL(VIRTIO_NET_F_GUEST_UFO) |
+                                     BIT_ULL(VIRTIO_NET_F_GUEST_CSUM) |
+                                     BIT_ULL(VIRTIO_NET_F_GUEST_TSO4) |
+                                     BIT_ULL(VIRTIO_NET_F_GUEST_TSO6) |
+                                     BIT_ULL(VIRTIO_NET_F_GUEST_ECN) |
+                                     BIT_ULL(VIRTIO_NET_F_HOST_UFO) |
+                                     BIT_ULL(VIRTIO_NET_F_HOST_USO) |
+                                     BIT_ULL(VIRTIO_NET_F_GUEST_USO4) |
+                                     BIT_ULL(VIRTIO_NET_F_GUEST_USO6) |
+                                     BIT_ULL(VIRTIO_NET_F_HASH_REPORT),
+                                     "A requested feature requires the peer to support virtio-net headers.",
+                                     errp)) &&
+          (peer_has_ufo(n) ||
+           virtio_net_clear_features(&on_off_auto_features,
+                                     BIT_ULL(VIRTIO_NET_F_GUEST_UFO) |
+                                     BIT_ULL(VIRTIO_NET_F_HOST_UFO),
+                                     "UFO is on but the peer does not support it.",
+                                     errp)) &&
+          (peer_has_uso(n) ||
+           virtio_net_clear_features(&on_off_auto_features,
+                                     BIT_ULL(VIRTIO_NET_F_HOST_USO) |
+                                     BIT_ULL(VIRTIO_NET_F_GUEST_USO4) |
+                                     BIT_ULL(VIRTIO_NET_F_GUEST_USO6),
+                                     "USO is on but the peer does not support it.",
+                                     errp)) &&
+          (virtio_has_feature(on_off_auto_features.on_bits |
+                              on_off_auto_features.auto_bits,
+                              VIRTIO_NET_F_CTRL_VQ) ||
+           virtio_net_clear_features(&on_off_auto_features,
+                                     BIT_ULL(VIRTIO_NET_F_GUEST_ANNOUNCE),
+                                     "guest_announce is on but ctrl_vq is off.",
+                                     errp)))) {
+        return 0;
     }
 
     if (!get_vhost_net(nc->peer)) {
-        return features;
+        if (!ebpf_rss_is_loaded(&n->ebpf_rss)) {
+            virtio_clear_feature(&on_off_auto_features.auto_bits,
+                                 VIRTIO_NET_F_RSS);
+        }
+
+        return on_off_auto_features.on_bits | on_off_auto_features.auto_bits;
     }
 
-    if (!ebpf_rss_is_loaded(&n->ebpf_rss)) {
-        virtio_clear_feature(&features, VIRTIO_NET_F_RSS);
+    if (!ebpf_rss_is_loaded(&n->ebpf_rss) &&
+        !virtio_net_clear_features(&on_off_auto_features,
+                                   BIT_ULL(VIRTIO_NET_F_RSS),
+                                   "Both RSS and vhost are on but eBPF is unavailable; fix eBPF or disable RSS.",
+                                   errp)) {
+        return 0;
     }
-    features = vhost_net_get_features(get_vhost_net(nc->peer), features);
+    features = vhost_net_get_features(get_vhost_net(nc->peer),
+                                      on_off_auto_features.on_bits |
+                                      on_off_auto_features.auto_bits);
     vdev->backend_features = features;
 
     if (n->mtu_bypass_backend &&
-            (n->host_features & 1ULL << VIRTIO_NET_F_MTU)) {
+        virtio_has_feature(on_off_auto_features.on_bits |
+                           on_off_auto_features.auto_bits,
+                           VIRTIO_NET_F_MTU)) {
         features |= (1ULL << VIRTIO_NET_F_MTU);
     }
 
@@ -820,6 +858,12 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
         virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_ANNOUNCE);
     }
 
+    if ((features & on_off_auto_features.on_bits) !=
+        on_off_auto_features.on_bits) {
+        error_setg(errp, "A requested feature is incompatible with vhost.");
+        return 0;
+    }
+
     return features;
 }
 
@@ -3598,7 +3642,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
     int i;
 
     if (n->net_conf.mtu) {
-        n->host_features |= (1ULL << VIRTIO_NET_F_MTU);
+        n->host_features.on_bits |= (1ULL << VIRTIO_NET_F_MTU);
     }
 
     if (n->net_conf.duplex_str) {
@@ -3610,7 +3654,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
             error_setg(errp, "'duplex' must be 'half' or 'full'");
             return;
         }
-        n->host_features |= (1ULL << VIRTIO_NET_F_SPEED_DUPLEX);
+        n->host_features.on_bits |= (1ULL << VIRTIO_NET_F_SPEED_DUPLEX);
     } else {
         n->net_conf.duplex = DUPLEX_UNKNOWN;
     }
@@ -3620,7 +3664,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
         return;
     }
     if (n->net_conf.speed >= 0) {
-        n->host_features |= (1ULL << VIRTIO_NET_F_SPEED_DUPLEX);
+        n->host_features.on_bits |= (1ULL << VIRTIO_NET_F_SPEED_DUPLEX);
     }
 
     if (n->failover) {
@@ -3629,10 +3673,12 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
         device_listener_register(&n->primary_listener);
         migration_add_notifier(&n->migration_state,
                                virtio_net_migration_state_notifier);
-        n->host_features |= (1ULL << VIRTIO_NET_F_STANDBY);
+        n->host_features.on_bits |= (1ULL << VIRTIO_NET_F_STANDBY);
     }
 
-    virtio_net_set_config_size(n, n->host_features);
+    virtio_net_set_config_size(n,
+                               n->host_features.on_bits |
+                               n->host_features.auto_bits);
     virtio_init(vdev, VIRTIO_ID_NET, n->config_size);
 
     /*
@@ -3759,7 +3805,9 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
 
     net_rx_pkt_init(&n->rx_pkt);
 
-    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
+    if (virtio_has_feature(n->host_features.on_bits |
+                           n->host_features.auto_bits,
+                           VIRTIO_NET_F_RSS)) {
         virtio_net_load_ebpf(n);
     }
 }
@@ -3770,7 +3818,9 @@ static void virtio_net_device_unrealize(DeviceState *dev)
     VirtIONet *n = VIRTIO_NET(dev);
     int i, max_queue_pairs;
 
-    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
+    if (virtio_has_feature(n->host_features.on_bits |
+                           n->host_features.auto_bits,
+                           VIRTIO_NET_F_RSS)) {
         virtio_net_unload_ebpf(n);
     }
 
@@ -3914,53 +3964,58 @@ static const VMStateDescription vmstate_virtio_net = {
 };
 
 static Property virtio_net_properties[] = {
-    DEFINE_PROP_BIT64("csum", VirtIONet, host_features,
-                    VIRTIO_NET_F_CSUM, true),
-    DEFINE_PROP_BIT64("guest_csum", VirtIONet, host_features,
-                    VIRTIO_NET_F_GUEST_CSUM, true),
-    DEFINE_PROP_BIT64("gso", VirtIONet, host_features, VIRTIO_NET_F_GSO, true),
-    DEFINE_PROP_BIT64("guest_tso4", VirtIONet, host_features,
-                    VIRTIO_NET_F_GUEST_TSO4, true),
-    DEFINE_PROP_BIT64("guest_tso6", VirtIONet, host_features,
-                    VIRTIO_NET_F_GUEST_TSO6, true),
-    DEFINE_PROP_BIT64("guest_ecn", VirtIONet, host_features,
-                    VIRTIO_NET_F_GUEST_ECN, true),
-    DEFINE_PROP_BIT64("guest_ufo", VirtIONet, host_features,
-                    VIRTIO_NET_F_GUEST_UFO, true),
-    DEFINE_PROP_BIT64("guest_announce", VirtIONet, host_features,
-                    VIRTIO_NET_F_GUEST_ANNOUNCE, true),
-    DEFINE_PROP_BIT64("host_tso4", VirtIONet, host_features,
-                    VIRTIO_NET_F_HOST_TSO4, true),
-    DEFINE_PROP_BIT64("host_tso6", VirtIONet, host_features,
-                    VIRTIO_NET_F_HOST_TSO6, true),
-    DEFINE_PROP_BIT64("host_ecn", VirtIONet, host_features,
-                    VIRTIO_NET_F_HOST_ECN, true),
-    DEFINE_PROP_BIT64("host_ufo", VirtIONet, host_features,
-                    VIRTIO_NET_F_HOST_UFO, true),
-    DEFINE_PROP_BIT64("mrg_rxbuf", VirtIONet, host_features,
-                    VIRTIO_NET_F_MRG_RXBUF, true),
-    DEFINE_PROP_BIT64("status", VirtIONet, host_features,
-                    VIRTIO_NET_F_STATUS, true),
-    DEFINE_PROP_BIT64("ctrl_vq", VirtIONet, host_features,
-                    VIRTIO_NET_F_CTRL_VQ, true),
-    DEFINE_PROP_BIT64("ctrl_rx", VirtIONet, host_features,
-                    VIRTIO_NET_F_CTRL_RX, true),
-    DEFINE_PROP_BIT64("ctrl_vlan", VirtIONet, host_features,
-                    VIRTIO_NET_F_CTRL_VLAN, true),
-    DEFINE_PROP_BIT64("ctrl_rx_extra", VirtIONet, host_features,
-                    VIRTIO_NET_F_CTRL_RX_EXTRA, true),
-    DEFINE_PROP_BIT64("ctrl_mac_addr", VirtIONet, host_features,
-                    VIRTIO_NET_F_CTRL_MAC_ADDR, true),
-    DEFINE_PROP_BIT64("ctrl_guest_offloads", VirtIONet, host_features,
-                    VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, true),
-    DEFINE_PROP_BIT64("mq", VirtIONet, host_features, VIRTIO_NET_F_MQ, false),
-    DEFINE_PROP_BIT64("rss", VirtIONet, host_features,
-                    VIRTIO_NET_F_RSS, false),
-    DEFINE_PROP_BIT64("hash", VirtIONet, host_features,
-                    VIRTIO_NET_F_HASH_REPORT, false),
+    DEFINE_PROP_ON_OFF_AUTO_BIT64("csum", VirtIONet, host_features,
+                                  VIRTIO_NET_F_CSUM, ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO_BIT64("guest_csum", VirtIONet, host_features,
+                                  VIRTIO_NET_F_GUEST_CSUM, ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO_BIT64("gso", VirtIONet, host_features,
+                                  VIRTIO_NET_F_GSO, ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO_BIT64("guest_tso4", VirtIONet, host_features,
+                                  VIRTIO_NET_F_GUEST_TSO4, ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO_BIT64("guest_tso6", VirtIONet, host_features,
+                                  VIRTIO_NET_F_GUEST_TSO6, ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO_BIT64("guest_ecn", VirtIONet, host_features,
+                                  VIRTIO_NET_F_GUEST_ECN, ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO_BIT64("guest_ufo", VirtIONet, host_features,
+                                  VIRTIO_NET_F_GUEST_UFO, ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO_BIT64("guest_announce", VirtIONet, host_features,
+                                  VIRTIO_NET_F_GUEST_ANNOUNCE,
+                                  ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO_BIT64("host_tso4", VirtIONet, host_features,
+                                  VIRTIO_NET_F_HOST_TSO4, ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO_BIT64("host_tso6", VirtIONet, host_features,
+                                  VIRTIO_NET_F_HOST_TSO6, ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO_BIT64("host_ecn", VirtIONet, host_features,
+                                  VIRTIO_NET_F_HOST_ECN, ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO_BIT64("host_ufo", VirtIONet, host_features,
+                                  VIRTIO_NET_F_HOST_UFO, ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO_BIT64("mrg_rxbuf", VirtIONet, host_features,
+                                  VIRTIO_NET_F_MRG_RXBUF, ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO_BIT64("status", VirtIONet, host_features,
+                                  VIRTIO_NET_F_STATUS, ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO_BIT64("ctrl_vq", VirtIONet, host_features,
+                                  VIRTIO_NET_F_CTRL_VQ, ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO_BIT64("ctrl_rx", VirtIONet, host_features,
+                                  VIRTIO_NET_F_CTRL_RX, ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO_BIT64("ctrl_vlan", VirtIONet, host_features,
+                                  VIRTIO_NET_F_CTRL_VLAN, ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO_BIT64("ctrl_rx_extra", VirtIONet, host_features,
+                                  VIRTIO_NET_F_CTRL_RX_EXTRA, ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO_BIT64("ctrl_mac_addr", VirtIONet, host_features,
+                                  VIRTIO_NET_F_CTRL_MAC_ADDR, ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO_BIT64("ctrl_guest_offloads", VirtIONet,
+                                  host_features,
+                                  VIRTIO_NET_F_CTRL_GUEST_OFFLOADS,
+                                  ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO_BIT64("mq", VirtIONet, host_features,
+                                  VIRTIO_NET_F_MQ, ON_OFF_AUTO_OFF),
+    DEFINE_PROP_ON_OFF_AUTO_BIT64("rss", VirtIONet, host_features,
+                                  VIRTIO_NET_F_RSS, ON_OFF_AUTO_OFF),
+    DEFINE_PROP_ON_OFF_AUTO_BIT64("hash", VirtIONet, host_features,
+                                  VIRTIO_NET_F_HASH_REPORT, ON_OFF_AUTO_OFF),
     DEFINE_PROP_ARRAY("ebpf-rss-fds", VirtIONet, nr_ebpf_rss_fds,
                       ebpf_rss_fds, qdev_prop_string, char*),
-    DEFINE_PROP_BIT64("guest_rsc_ext", VirtIONet, host_features,
+    DEFINE_PROP_BIT64("guest_rsc_ext", VirtIONet, host_features.on_bits,
                     VIRTIO_NET_F_RSC_EXT, false),
     DEFINE_PROP_UINT32("rsc_interval", VirtIONet, rsc_timeout,
                        VIRTIO_NET_RSC_DEFAULT_INTERVAL),
@@ -3979,12 +4034,12 @@ static Property virtio_net_properties[] = {
     DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed, SPEED_UNKNOWN),
     DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_str),
     DEFINE_PROP_BOOL("failover", VirtIONet, failover, false),
-    DEFINE_PROP_BIT64("guest_uso4", VirtIONet, host_features,
-                      VIRTIO_NET_F_GUEST_USO4, true),
-    DEFINE_PROP_BIT64("guest_uso6", VirtIONet, host_features,
-                      VIRTIO_NET_F_GUEST_USO6, true),
-    DEFINE_PROP_BIT64("host_uso", VirtIONet, host_features,
-                      VIRTIO_NET_F_HOST_USO, true),
+    DEFINE_PROP_ON_OFF_AUTO_BIT64("guest_uso4", VirtIONet, host_features,
+                                  VIRTIO_NET_F_GUEST_USO4, ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO_BIT64("guest_uso6", VirtIONet, host_features,
+                                  VIRTIO_NET_F_GUEST_USO6, ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO_BIT64("host_uso", VirtIONet, host_features,
+                                  VIRTIO_NET_F_HOST_USO, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_END_OF_LIST(),
 };
 

-- 
2.44.0


