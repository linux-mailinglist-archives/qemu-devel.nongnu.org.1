Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C392493088E
	for <lists+qemu-devel@lfdr.de>; Sun, 14 Jul 2024 07:12:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSrWL-0007RR-NG; Sun, 14 Jul 2024 01:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sSrWA-0007KF-G2
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 01:11:27 -0400
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sSrW5-00052O-Np
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 01:11:26 -0400
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-7f684af6af1so178616639f.2
 for <qemu-devel@nongnu.org>; Sat, 13 Jul 2024 22:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1720933880; x=1721538680;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lPZRIoBatCKfQlpKyAIr9YZsJwzc8VLAyqblnVRpsKs=;
 b=sQexyZuINSTJ3AusHlkv3xg34rU/3qwaQ/Y93A7p2axu+wiT/sp54LjTpeHvgFquIH
 LyVphRxVkJWt7VV2YbT1UozJ0qFv3QqG6nRmXsVzGTwtFw4uQ7w0TzhEEp+kDI3tyood
 /Pwf17XDvqw0h9f5cR76Dlx7r1TxaM9SLMRyGUPJQpvNmolXP81DKZapr9Hv0WrFfn/i
 8oWV+f9Dz7fgPAM6D64GEcTm+YPe+jCKOjbPI9Z4er9Xi51b39bLlGi8QWDPTq4sxX6Q
 mQbxApZZS7pEerwUo/a8mBRIebAOhgIu2hp0Gmr3nH/LPzBWF8CqrYtwhM5fFkZr/ePs
 hDpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720933880; x=1721538680;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lPZRIoBatCKfQlpKyAIr9YZsJwzc8VLAyqblnVRpsKs=;
 b=w0cCXX2e0y9IXs7YP15XzdcMx9atuqgh2QNbMP8117q8yrERia0u60BGtaDcaxXim2
 7xlcu5Exz+eSafCgr4iYfyDrcmLh0ze9VXCvDyEuMyvHNCylv0IkxawCXCnYuYozmpFK
 NSlU5wYPNXHIU2co376RpLuYVu3cklmPwPT6pQXKxb2xm2FIHb1WkJwmiuzh7uITpgMR
 1WBcXTsyjDVB+KJl3GzLHepLeGc0XbLs/Mrz2GPBeWOXTi0M/Nl0kkp1RbgbkuEt/G2+
 RApHzGCx32GTRnOJ7Gg+eqzYhqkMrvKF48/dnUg2RAiQUZolaMKni8aOu1I/bvenee9R
 RyYQ==
X-Gm-Message-State: AOJu0YwmzdCNvCPKXliUvW/fvRT3+hSeBOga8cFDkycfNVwBhmhIutZL
 3CS9pAjOxJDmYVd1RQKGX4fujZ7s/06whGaJ38YyvZBD4h0AZLOl5DR7qd6hqwA=
X-Google-Smtp-Source: AGHT+IGPCPVJOQ5Ec5n5V10C5hBtrKucO4MLzP6djBGNnlfQ2GeqmBybmv+zG01g0/hsYPH6iri7gQ==
X-Received: by 2002:a92:c54f:0:b0:375:c240:e7a6 with SMTP id
 e9e14a558f8ab-38a5a0798b7mr194434845ab.24.1720933880422; 
 Sat, 13 Jul 2024 22:11:20 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-78e32b6ba67sm1490300a12.11.2024.07.13.22.11.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 13 Jul 2024 22:11:20 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 14 Jul 2024 14:11:03 +0900
Subject: [PATCH v3 3/5] virtio-net: Convert feature properties to OnOffAuto
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240714-auto-v3-3-e27401aabab3@daynix.com>
References: <20240714-auto-v3-0-e27401aabab3@daynix.com>
In-Reply-To: <20240714-auto-v3-0-e27401aabab3@daynix.com>
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
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::d35;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-io1-xd35.google.com
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

Convert "on" to "auto" when using an old machine for compatbility.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/virtio/virtio-net.h |   3 +-
 hw/core/machine.c              |   1 +
 hw/net/virtio-net.c            | 254 +++++++++++++++++++++++++----------------
 3 files changed, 161 insertions(+), 97 deletions(-)

diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 060c23c04d2d..cfa87f739248 100644
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
@@ -218,6 +218,7 @@ struct VirtIONet {
     /* primary failover device is hidden*/
     bool failover_primary_hidden;
     bool failover;
+    bool force_features_auto;
     DeviceListener primary_listener;
     QDict *primary_opts;
     bool primary_opts_from_json;
diff --git a/hw/core/machine.c b/hw/core/machine.c
index f4cba6496c84..783d3e5695d8 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -39,6 +39,7 @@ GlobalProperty hw_compat_9_0[] = {
     {"scsi-disk-base", "migrate-emulated-scsi-request", "false" },
     {"vfio-pci", "skip-vsc-check", "false" },
     { "virtio-pci", "x-pcie-pm-no-soft-reset", "off" },
+    { TYPE_VIRTIO_NET, "x-force-features-auto", "on" },
 };
 const size_t hw_compat_9_0_len = G_N_ELEMENTS(hw_compat_9_0);
 
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 8f3097270869..bd285921d507 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -750,58 +750,101 @@ static void virtio_net_set_queue_pairs(VirtIONet *n)
 
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
+    if (n->force_features_auto) {
+        on_off_auto_features.auto_bits |= on_off_auto_features.on_bits;
+        on_off_auto_features.on_bits = 0;
+    }
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
 
@@ -820,6 +863,12 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
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
 
@@ -3592,7 +3641,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
     int i;
 
     if (n->net_conf.mtu) {
-        n->host_features |= (1ULL << VIRTIO_NET_F_MTU);
+        n->host_features.on_bits |= (1ULL << VIRTIO_NET_F_MTU);
     }
 
     if (n->net_conf.duplex_str) {
@@ -3604,7 +3653,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
             error_setg(errp, "'duplex' must be 'half' or 'full'");
             return;
         }
-        n->host_features |= (1ULL << VIRTIO_NET_F_SPEED_DUPLEX);
+        n->host_features.on_bits |= (1ULL << VIRTIO_NET_F_SPEED_DUPLEX);
     } else {
         n->net_conf.duplex = DUPLEX_UNKNOWN;
     }
@@ -3614,7 +3663,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
         return;
     }
     if (n->net_conf.speed >= 0) {
-        n->host_features |= (1ULL << VIRTIO_NET_F_SPEED_DUPLEX);
+        n->host_features.on_bits |= (1ULL << VIRTIO_NET_F_SPEED_DUPLEX);
     }
 
     if (n->failover) {
@@ -3623,10 +3672,12 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
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
@@ -3753,7 +3804,9 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
 
     net_rx_pkt_init(&n->rx_pkt);
 
-    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
+    if (virtio_has_feature(n->host_features.on_bits |
+                           n->host_features.auto_bits,
+                           VIRTIO_NET_F_RSS)) {
         virtio_net_load_ebpf(n);
     }
 }
@@ -3764,7 +3817,9 @@ static void virtio_net_device_unrealize(DeviceState *dev)
     VirtIONet *n = VIRTIO_NET(dev);
     int i, max_queue_pairs;
 
-    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
+    if (virtio_has_feature(n->host_features.on_bits |
+                           n->host_features.auto_bits,
+                           VIRTIO_NET_F_RSS)) {
         virtio_net_unload_ebpf(n);
     }
 
@@ -3908,53 +3963,58 @@ static const VMStateDescription vmstate_virtio_net = {
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
@@ -3973,12 +4033,14 @@ static Property virtio_net_properties[] = {
     DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed, SPEED_UNKNOWN),
     DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_str),
     DEFINE_PROP_BOOL("failover", VirtIONet, failover, false),
-    DEFINE_PROP_BIT64("guest_uso4", VirtIONet, host_features,
-                      VIRTIO_NET_F_GUEST_USO4, true),
-    DEFINE_PROP_BIT64("guest_uso6", VirtIONet, host_features,
-                      VIRTIO_NET_F_GUEST_USO6, true),
-    DEFINE_PROP_BIT64("host_uso", VirtIONet, host_features,
-                      VIRTIO_NET_F_HOST_USO, true),
+    DEFINE_PROP_BOOL("x-force-features-auto", VirtIONet, force_features_auto,
+                     false),
+    DEFINE_PROP_ON_OFF_AUTO_BIT64("guest_uso4", VirtIONet, host_features,
+                                  VIRTIO_NET_F_GUEST_USO4, ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO_BIT64("guest_uso6", VirtIONet, host_features,
+                                  VIRTIO_NET_F_GUEST_USO6, ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO_BIT64("host_uso", VirtIONet, host_features,
+                                  VIRTIO_NET_F_HOST_USO, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_END_OF_LIST(),
 };
 

-- 
2.45.2


