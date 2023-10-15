Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF887C994C
	for <lists+qemu-devel@lfdr.de>; Sun, 15 Oct 2023 16:04:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qs1ij-0001lx-Bi; Sun, 15 Oct 2023 10:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qs1ig-0001hU-TJ
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 10:03:50 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qs1id-0007m7-Q1
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 10:03:49 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6bd0e1b1890so440351b3a.3
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 07:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697378626; x=1697983426;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0jYFppD2q/B6HW33loL41D2UDU5z3AZeu5hXH0ps2N0=;
 b=kto9T4HLa/y++9JMBdDw82hGTmi44iqHEGdTpR0aVCxXNmeyHHDyJ0nmxDD0gPdIDL
 +8y4b/wkwFKwUNKfIhXXfGsqkFOHTH2SJ5Ohg6J8No9ql7NX328O+CzmZWp+Wequ3hyp
 orejK5hBoEst0aSELRnQ58M3SxRHW10sZnZEEaM4aeF9+w/0ODOIXqt/JMCRnVESxPOW
 0EsiKjPKosehX9cpRDipJ5radd5TMB5beC8AKNVr8xL4JIgJiPr4DTtM8FBFLaBH4wMK
 EgF2rw9S2NqSr3cpy0NQs1m9juf3T/JbP5Z0AZ19lo0+7z1/vv8m+W32hA6OW7iFoQvK
 5YCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697378626; x=1697983426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0jYFppD2q/B6HW33loL41D2UDU5z3AZeu5hXH0ps2N0=;
 b=o31GTnm1Fr55iEi74R7/1oDULL4BN5Mxg93WYoTn6MgOHOmyJQLZBSOg0Z+nXVWBAm
 8acjdPU3o7Q7+H7/4Mqr1lj4n9rTfX8qr78g3uh19WrnpIiFua9p8MVN/mk0YBZGV2Jp
 /CMjjQLuB4817oWPAfqyzaQzoPBvFlkLrJ1pQ8j59kqQVU+6qFZyFAJy9V+xuMzvxYHm
 mvv+yhvqClzYeUrd318DULg0eWMHZf6D0xlW6c1qVBNTOSzpbBO+xPpE189t+6osckac
 PHY6CxkbL1TPE+eToCQl+dJMm+bYFb8ze7Uqx3DzCAuAMyL3097dhNwi6WVRTg6WFz9L
 n8dQ==
X-Gm-Message-State: AOJu0YxDNPevxYMlku/tbV4CQNqWRh6aSUmQCf65cIk3uBypC03AwXYh
 Vu0drvv7Ll3GsuvshI0v3A94rFjdO5hhawDh88JOEg==
X-Google-Smtp-Source: AGHT+IFag3ae6IdWZ3XjYAw5PDXCqonCHSXHdWXDRKWi17dPQlaDIU2HV9jdto8zvmgX/LXd0Md+qA==
X-Received: by 2002:a05:6a00:24d4:b0:6bd:b7c5:f776 with SMTP id
 d20-20020a056a0024d400b006bdb7c5f776mr581067pfv.8.1697378626383; 
 Sun, 15 Oct 2023 07:03:46 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 b28-20020aa7951c000000b006b725b2158bsm3035562pfp.41.2023.10.15.07.03.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Oct 2023 07:03:46 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v4 11/20] virtio-net: Return an error when vhost cannot enable
 RSS
Date: Sun, 15 Oct 2023 23:02:43 +0900
Message-ID: <20231015140259.259434-12-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231015140259.259434-1-akihiko.odaki@daynix.com>
References: <20231015140259.259434-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

vhost requires eBPF for RSS. Even when eBPF is not available, virtio-net
reported RSS availability, and raised a warning only after the
guest requested RSS, and the guest could not know that RSS is not
available.

Check RSS availability during device realization and return an error
if RSS is requested but not available. Assert RSS availability when
the guest actually requests the feature.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 ebpf/ebpf_rss.h      |   2 +-
 ebpf/ebpf_rss-stub.c |   4 +-
 ebpf/ebpf_rss.c      |  68 +++++++++-----------------
 hw/net/virtio-net.c  | 114 +++++++++++++++++++++----------------------
 4 files changed, 82 insertions(+), 106 deletions(-)

diff --git a/ebpf/ebpf_rss.h b/ebpf/ebpf_rss.h
index bf3f2572c7..1128173572 100644
--- a/ebpf/ebpf_rss.h
+++ b/ebpf/ebpf_rss.h
@@ -36,7 +36,7 @@ bool ebpf_rss_is_loaded(struct EBPFRSSContext *ctx);
 
 bool ebpf_rss_load(struct EBPFRSSContext *ctx);
 
-bool ebpf_rss_set_all(struct EBPFRSSContext *ctx, struct EBPFRSSConfig *config,
+void ebpf_rss_set_all(struct EBPFRSSContext *ctx, struct EBPFRSSConfig *config,
                       uint16_t *indirections_table, uint8_t *toeplitz_key);
 
 void ebpf_rss_unload(struct EBPFRSSContext *ctx);
diff --git a/ebpf/ebpf_rss-stub.c b/ebpf/ebpf_rss-stub.c
index e71e229190..525b358597 100644
--- a/ebpf/ebpf_rss-stub.c
+++ b/ebpf/ebpf_rss-stub.c
@@ -28,10 +28,10 @@ bool ebpf_rss_load(struct EBPFRSSContext *ctx)
     return false;
 }
 
-bool ebpf_rss_set_all(struct EBPFRSSContext *ctx, struct EBPFRSSConfig *config,
+void ebpf_rss_set_all(struct EBPFRSSContext *ctx, struct EBPFRSSConfig *config,
                       uint16_t *indirections_table, uint8_t *toeplitz_key)
 {
-    return false;
+    g_assert_not_reached();
 }
 
 void ebpf_rss_unload(struct EBPFRSSContext *ctx)
diff --git a/ebpf/ebpf_rss.c b/ebpf/ebpf_rss.c
index cee658c158..6cdf82d059 100644
--- a/ebpf/ebpf_rss.c
+++ b/ebpf/ebpf_rss.c
@@ -74,42 +74,32 @@ error:
     return false;
 }
 
-static bool ebpf_rss_set_config(struct EBPFRSSContext *ctx,
+static void ebpf_rss_set_config(struct EBPFRSSContext *ctx,
                                 struct EBPFRSSConfig *config)
 {
     uint32_t map_key = 0;
 
-    if (!ebpf_rss_is_loaded(ctx)) {
-        return false;
-    }
-    if (bpf_map_update_elem(ctx->map_configuration,
-                            &map_key, config, 0) < 0) {
-        return false;
-    }
-    return true;
+    assert(ebpf_rss_is_loaded(ctx));
+    assert(!bpf_map_update_elem(ctx->map_configuration, &map_key, config, 0));
 }
 
-static bool ebpf_rss_set_indirections_table(struct EBPFRSSContext *ctx,
+static void ebpf_rss_set_indirections_table(struct EBPFRSSContext *ctx,
                                             uint16_t *indirections_table,
                                             size_t len)
 {
     uint32_t i = 0;
 
-    if (!ebpf_rss_is_loaded(ctx) || indirections_table == NULL ||
-       len > VIRTIO_NET_RSS_MAX_TABLE_LEN) {
-        return false;
-    }
+    assert(ebpf_rss_is_loaded(ctx));
+    assert(indirections_table);
+    assert(len <= VIRTIO_NET_RSS_MAX_TABLE_LEN);
 
     for (; i < len; ++i) {
-        if (bpf_map_update_elem(ctx->map_indirections_table, &i,
-                                indirections_table + i, 0) < 0) {
-            return false;
-        }
+        assert(!bpf_map_update_elem(ctx->map_indirections_table, &i,
+                                    indirections_table + i, 0));
     }
-    return true;
 }
 
-static bool ebpf_rss_set_toepliz_key(struct EBPFRSSContext *ctx,
+static void ebpf_rss_set_toepliz_key(struct EBPFRSSContext *ctx,
                                      uint8_t *toeplitz_key)
 {
     uint32_t map_key = 0;
@@ -117,41 +107,29 @@ static bool ebpf_rss_set_toepliz_key(struct EBPFRSSContext *ctx,
     /* prepare toeplitz key */
     uint8_t toe[VIRTIO_NET_RSS_MAX_KEY_SIZE] = {};
 
-    if (!ebpf_rss_is_loaded(ctx) || toeplitz_key == NULL) {
-        return false;
-    }
+    assert(ebpf_rss_is_loaded(ctx));
+    assert(toeplitz_key);
+
     memcpy(toe, toeplitz_key, VIRTIO_NET_RSS_MAX_KEY_SIZE);
     *(uint32_t *)toe = ntohl(*(uint32_t *)toe);
 
-    if (bpf_map_update_elem(ctx->map_toeplitz_key, &map_key, toe,
-                            0) < 0) {
-        return false;
-    }
-    return true;
+    assert(!bpf_map_update_elem(ctx->map_toeplitz_key, &map_key, toe, 0));
 }
 
-bool ebpf_rss_set_all(struct EBPFRSSContext *ctx, struct EBPFRSSConfig *config,
+void ebpf_rss_set_all(struct EBPFRSSContext *ctx, struct EBPFRSSConfig *config,
                       uint16_t *indirections_table, uint8_t *toeplitz_key)
 {
-    if (!ebpf_rss_is_loaded(ctx) || config == NULL ||
-        indirections_table == NULL || toeplitz_key == NULL) {
-        return false;
-    }
-
-    if (!ebpf_rss_set_config(ctx, config)) {
-        return false;
-    }
+    assert(ebpf_rss_is_loaded(ctx));
+    assert(config);
+    assert(indirections_table);
+    assert(toeplitz_key);
 
-    if (!ebpf_rss_set_indirections_table(ctx, indirections_table,
-                                      config->indirections_len)) {
-        return false;
-    }
+    ebpf_rss_set_config(ctx, config);
 
-    if (!ebpf_rss_set_toepliz_key(ctx, toeplitz_key)) {
-        return false;
-    }
+    ebpf_rss_set_indirections_table(ctx, indirections_table,
+                                    config->indirections_len);
 
-    return true;
+    ebpf_rss_set_toepliz_key(ctx, toeplitz_key);
 }
 
 void ebpf_rss_unload(struct EBPFRSSContext *ctx)
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 25fc06bd93..20feb20bb1 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1242,14 +1242,10 @@ static bool virtio_net_attach_epbf_rss(VirtIONet *n)
 
     rss_data_to_rss_config(&n->rss_data, &config);
 
-    if (!ebpf_rss_set_all(&n->ebpf_rss, &config,
-                          n->rss_data.indirections_table, n->rss_data.key)) {
-        return false;
-    }
+    ebpf_rss_set_all(&n->ebpf_rss, &config,
+                     n->rss_data.indirections_table, n->rss_data.key);
 
-    if (!virtio_net_attach_ebpf_to_backend(n->nic, n->ebpf_rss.program_fd)) {
-        return false;
-    }
+    assert(virtio_net_attach_ebpf_to_backend(n->nic, n->ebpf_rss.program_fd));
 
     return true;
 }
@@ -1266,12 +1262,7 @@ static void virtio_net_commit_rss_config(VirtIONet *n)
         if (n->rss_data.populate_hash) {
             virtio_net_detach_epbf_rss(n);
         } else if (!virtio_net_attach_epbf_rss(n)) {
-            if (get_vhost_net(qemu_get_queue(n->nic)->peer)) {
-                warn_report("Can't use eBPF RSS for vhost");
-            } else {
-                warn_report("Can't use eBPF RSS - fallback to software RSS");
-                n->rss_data.enabled_software_rss = true;
-            }
+            n->rss_data.enabled_software_rss = true;
         }
 
         trace_virtio_net_rss_enable(n->rss_data.hash_types,
@@ -3514,6 +3505,50 @@ static bool failover_hide_primary_device(DeviceListener *listener,
     return qatomic_read(&n->failover_primary_hidden);
 }
 
+static void virtio_net_device_unrealize(DeviceState *dev)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VirtIONet *n = VIRTIO_NET(dev);
+    int i, max_queue_pairs;
+
+    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
+        virtio_net_unload_ebpf(n);
+    }
+
+    /* This will stop vhost backend if appropriate. */
+    virtio_net_set_status(vdev, 0);
+
+    g_free(n->netclient_name);
+    n->netclient_name = NULL;
+    g_free(n->netclient_type);
+    n->netclient_type = NULL;
+
+    g_free(n->mac_table.macs);
+    g_free(n->vlans);
+
+    if (n->failover) {
+        qobject_unref(n->primary_opts);
+        device_listener_unregister(&n->primary_listener);
+        remove_migration_state_change_notifier(&n->migration_state);
+    } else {
+        assert(n->primary_opts == NULL);
+    }
+
+    max_queue_pairs = n->multiqueue ? n->max_queue_pairs : 1;
+    for (i = 0; i < max_queue_pairs; i++) {
+        virtio_net_del_queue(n, i);
+    }
+    /* delete also control vq */
+    virtio_del_queue(vdev, max_queue_pairs * 2);
+    qemu_announce_timer_del(&n->announce_timer, false);
+    g_free(n->vqs);
+    qemu_del_nic(n->nic);
+    virtio_net_rsc_cleanup(n);
+    g_free(n->rss_data.indirections_table);
+    net_rx_pkt_uninit(n->rx_pkt);
+    virtio_cleanup(vdev);
+}
+
 static void virtio_net_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
@@ -3685,53 +3720,16 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
 
     net_rx_pkt_init(&n->rx_pkt);
 
-    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
-        virtio_net_load_ebpf(n);
-    }
-}
-
-static void virtio_net_device_unrealize(DeviceState *dev)
-{
-    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
-    VirtIONet *n = VIRTIO_NET(dev);
-    int i, max_queue_pairs;
-
-    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
-        virtio_net_unload_ebpf(n);
-    }
-
-    /* This will stop vhost backend if appropriate. */
-    virtio_net_set_status(vdev, 0);
-
-    g_free(n->netclient_name);
-    n->netclient_name = NULL;
-    g_free(n->netclient_type);
-    n->netclient_type = NULL;
-
-    g_free(n->mac_table.macs);
-    g_free(n->vlans);
-
-    if (n->failover) {
-        qobject_unref(n->primary_opts);
-        device_listener_unregister(&n->primary_listener);
-        remove_migration_state_change_notifier(&n->migration_state);
-    } else {
-        assert(n->primary_opts == NULL);
-    }
+    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS) &&
+        !virtio_net_load_ebpf(n)) {
+        if (get_vhost_net(nc->peer)) {
+            error_setg(errp, "Can't load eBPF RSS for vhost");
+            virtio_net_device_unrealize(dev);
+            return;
+        }
 
-    max_queue_pairs = n->multiqueue ? n->max_queue_pairs : 1;
-    for (i = 0; i < max_queue_pairs; i++) {
-        virtio_net_del_queue(n, i);
+        warn_report_once("Can't load eBPF RSS - fallback to software RSS");
     }
-    /* delete also control vq */
-    virtio_del_queue(vdev, max_queue_pairs * 2);
-    qemu_announce_timer_del(&n->announce_timer, false);
-    g_free(n->vqs);
-    qemu_del_nic(n->nic);
-    virtio_net_rsc_cleanup(n);
-    g_free(n->rss_data.indirections_table);
-    net_rx_pkt_uninit(n->rx_pkt);
-    virtio_cleanup(vdev);
 }
 
 static void virtio_net_reset(VirtIODevice *vdev)
-- 
2.42.0


