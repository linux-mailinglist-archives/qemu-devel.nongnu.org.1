Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2965A7BCC68
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 07:31:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpMNW-0004Ju-2u; Sun, 08 Oct 2023 01:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qpMMZ-00048J-3c
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 01:30:01 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qpMMR-00077L-CM
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 01:29:57 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-578e33b6fb7so2267094a12.3
 for <qemu-devel@nongnu.org>; Sat, 07 Oct 2023 22:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1696742987; x=1697347787;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ynwsXo8IPpR9kTYC+gQRvJ4ScmqBJUKwmKxlFEEjPM4=;
 b=JkTEiW8j5Mi+7jBNW658dlG1BYnsyEhDhnyThQ/hdoUS20Ge58L0QNsjnyk05b4EZK
 TR5Lw04JST5VYp1zv0/ur0DvvttC7B00v+4HrOy+5jj8wrUUBYY7685p702FKNy3fleT
 YhXxzttLidK5qPKbkO6iGsvtksSh/u8K/aCvlus2Bw5mvPu0yADo0lQ6FsT0tGU8t4P0
 Eh75iadTcdScOEc6cnf9ybQHEeMWHWD4RhLiqLJZvKaxTHaML2vV+OfMbXUzedG1q9fT
 0djr3qDm8rzH16XCjWZmRgYXhbzfWB6cs8/xOAORovwqBGsqR+zxDBrIvry1VXoVOk3F
 QBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696742987; x=1697347787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ynwsXo8IPpR9kTYC+gQRvJ4ScmqBJUKwmKxlFEEjPM4=;
 b=Mx28A8vBUD/HUbUPYZCtVYXxSOq8b7Z5lDw/pqEh3a5lruwOjG+cYNa03cRmtYGkm9
 UPWLZ8UATSo/zO8C3E8cZ2wZQs/w3iknT99z2jvy+gKIIjVh1Fy0kD9Qe+KUrtT2AjAn
 JJ1vrizmzOI3Go0Q/u0Crdl/cLFr3OW7H7/L4gkD+8FZYzPJE1pv8CCpBQ6WZevouupE
 sewzaBLosPpxHCmoyZ5pGUjMYwNy1MOgCMvh5B7x1HYMUNRIqzBi67pIWEcSJahMV1pz
 IzepjTcnFkGyZGjengeooI7L1LUUSuenJYX35gsubwzhni27tS6ZX0XGI8TOFc2tNqBE
 pk4A==
X-Gm-Message-State: AOJu0YyaWE8KdJOvBg8oYpd7ttX5UEXmbw4Dir7pP13QIHKa3wmua0UX
 Hd2bVp8bSwYduwgWRBiRxVWI3Q==
X-Google-Smtp-Source: AGHT+IGsuS0YQhajxn1FGqOdcqIwxg4nAAW0AIolGol/kpXkuqk6zDn6gtKpimYwJR8VEeYQq09TBw==
X-Received: by 2002:a17:902:ef96:b0:1c6:c41:af37 with SMTP id
 iz22-20020a170902ef9600b001c60c41af37mr8429090plb.68.1696742987292; 
 Sat, 07 Oct 2023 22:29:47 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 c12-20020a170902c1cc00b001c60a548331sm6777468plc.304.2023.10.07.22.29.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Oct 2023 22:29:46 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH 5/6] virtio-net: Return an error when vhost cannot enable RSS
Date: Sun,  8 Oct 2023 14:29:14 +0900
Message-ID: <20231008052917.145245-6-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231008052917.145245-1-akihiko.odaki@daynix.com>
References: <20231008052917.145245-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::529;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x529.google.com
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
index 3c3440ab72..05f9abdbcd 100644
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
@@ -3688,53 +3723,16 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
 
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


