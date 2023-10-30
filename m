Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9198C7DB2BD
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 06:17:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxKc4-00029f-He; Mon, 30 Oct 2023 01:14:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qxKc1-00029C-FS
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 01:14:53 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qxKbz-0001me-Uc
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 01:14:53 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1cc330e8f58so5980235ad.3
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 22:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698642890; x=1699247690;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GRzviBK8mXMBEC7IZo660+bUdOfJtuca+lJaFgU90mc=;
 b=dYJP9AoZvASa/tA4BokLXjEdcD4//0/q9pWsr2Ku50q7R/rjmohHTWTxlVLePGiEEN
 m7OvKjVzZk3dZNz/Ry/z4uAM31XD1xnl2DQ5/I8zgCjJVrD5iNttxTuzz5c9aI4QU3uj
 34FKonVPlazGJlOgF8+R1SGu15wD25bXT3a+0JzlMGHyteoALtfYvrqrn+ITW5eD0xB8
 qkd1oxsnZpodpF5QxPsjoTbsjyb3xtpnH9ReYTas7XrTOo+uIQ77AolVjoiKd7kYOMCp
 2JdYO81zVZ1Zm8ytmtiugpp7GzrtXnPIHNpKg01mYYzwqTZ+SVi+get3dDiYJXKsktsd
 NBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698642890; x=1699247690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GRzviBK8mXMBEC7IZo660+bUdOfJtuca+lJaFgU90mc=;
 b=axoAg/ZlRYcrydagC7QlS9g9KWQAl7PHJdjhGcMOTt4EoEGCfCSK5LEHSg3yRmQGy+
 b4/O7yYdTXKsSoyPjzTKRmPqcVXL9zscGEr0vdlb0oEhaKGM7iRgLETbfVVbyX6+6ILw
 398Tm0nktiZLwHwVhbMjMrkKQZK02Rfj6BHAsUIHjCzV0oPKMyvrlziGYUFRC8iIJgOB
 cOkLE7t0Q+0yg3M49Q0im/Eqe7twkOtY9FKQoFonupM8oanlu9GEuvM8/Qjhqz4mPUCo
 rvs+k7tCGYSRqyFbUDen+U0JTgOeRZcReoFaU73uhKgi5m1y+B2BVuS3HFr7ICvwXmcm
 eggg==
X-Gm-Message-State: AOJu0Yzds33bcNR6+/wjJsFppgnLTBb4WKOI+ENe/3EwlGYAaEW7BMDx
 Bz5NlumtOBa1rxZJFEL6+T+53MrTplix0C+4tEluUA==
X-Google-Smtp-Source: AGHT+IEGnJ6YO8GB3x6l1Hz2jD++b4nGgKBUx0dADC2Jz4r07CxP0ivmp8aH+q117LuY3+kkn1W1Pw==
X-Received: by 2002:a17:902:db0a:b0:1cc:492c:2918 with SMTP id
 m10-20020a170902db0a00b001cc492c2918mr1400376plx.69.1698642890448; 
 Sun, 29 Oct 2023 22:14:50 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 l3-20020a170902f68300b001c61921d4d2sm5287576plg.302.2023.10.29.22.14.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Oct 2023 22:14:50 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v6 11/21] virtio-net: Return an error when vhost cannot enable
 RSS
Date: Mon, 30 Oct 2023 14:12:32 +0900
Message-ID: <20231030051356.33123-12-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231030051356.33123-1-akihiko.odaki@daynix.com>
References: <20231030051356.33123-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62a.google.com
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

vhost requires eBPF for RSS. When eBPF is not available, virtio-net
implicitly disables RSS even if the user explicitly requests it. Return
an error instead of implicitly disabling RSS if RSS is requested but not
available.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/virtio-net.c | 97 ++++++++++++++++++++++-----------------------
 1 file changed, 48 insertions(+), 49 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 5d4afd12b2..7bb91617d0 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -792,9 +792,6 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
         return features;
     }
 
-    if (!ebpf_rss_is_loaded(&n->ebpf_rss)) {
-        virtio_clear_feature(&features, VIRTIO_NET_F_RSS);
-    }
     features = vhost_net_get_features(get_vhost_net(nc->peer), features);
     vdev->backend_features = features;
 
@@ -3533,6 +3530,50 @@ static bool failover_hide_primary_device(DeviceListener *listener,
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
+        migration_remove_notifier(&n->migration_state);
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
@@ -3704,53 +3745,11 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
 
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
+    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS) &&
+        !virtio_net_load_ebpf(n)) {
+        error_setg(errp, "Can't load eBPF RSS");
+        virtio_net_device_unrealize(dev);
     }
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
-        migration_remove_notifier(&n->migration_state);
-    } else {
-        assert(n->primary_opts == NULL);
-    }
-
-    max_queue_pairs = n->multiqueue ? n->max_queue_pairs : 1;
-    for (i = 0; i < max_queue_pairs; i++) {
-        virtio_net_del_queue(n, i);
-    }
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


