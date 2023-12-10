Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C777680B90D
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Dec 2023 06:32:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCCPC-0002Zy-2f; Sun, 10 Dec 2023 00:31:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCCP0-0002Rh-RJ
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 00:30:55 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCCOu-00037w-Ob
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 00:30:54 -0500
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3b8b8372e30so2468554b6e.3
 for <qemu-devel@nongnu.org>; Sat, 09 Dec 2023 21:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702186244; x=1702791044;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BNgnfv/zSvemKd7qjLqkmsZs8RzUbSx3D0aifxdINUw=;
 b=W7SpWpD9Bd/FkJlzxf7jE2drsHZ8vLsNOhnRww08YCUFrDqo9tk5goTNrMUBDHXDyx
 Y4HSR7Gr+DoNDajGs8+5l1/jvgA1LNlGj9P5yxnLLejuo8aNmB2ChpXUw7/Ip+CvdBLP
 +e6XJrnlmnwsFkk/jCrhkq/wY71W8/xvfqDil6y8PQj8N+Ds7c7x6JTGedKkgjScHBTB
 keMMLS+3bSiYd/7I+uRxzSRwd97puKbXxw6+6rOe3k30o6z5TiBs4cvdrmiWcNcKgTql
 30JQ6XpIdzIVa/ae0TRfUy99NKnDfiOTmE70lUUcmByp2ZLIcMCms6F/39FhB9bVpdgJ
 Fr8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702186244; x=1702791044;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BNgnfv/zSvemKd7qjLqkmsZs8RzUbSx3D0aifxdINUw=;
 b=pfXcrfM3gwsthCsCwGp1XNPYxo/ahh/1ZaLmhwvko27WAlW16itoiVLgHWVsrT0vKp
 XrJ0or+vnk1CGfCRvHRdDgMWRiPhLNOCxa8PjAYchRbG2MLCWZhLC59jYDqx4FcaLJ83
 Y7P5luqWohZvwhQucL7SaX1cQWraqKH8cpaoMHdh+70ykqjLOc96nCOUlNsIq4j6Ht5b
 gJ7MVyAn/abWzMSg/FzZuN0l4jxpEjZRT2kgrHhirylfdsDauq1lt7BF7GgJtpbsPiv/
 Lt89kuf4teZ7/MHjn/dzjvN3FenyzwGcK/3NFg2WTL3RVELRI+4gzD50bEhQOz02J/O+
 lLRg==
X-Gm-Message-State: AOJu0YzPGMuFC0Rbicly3yGxhuOVq0p1CayGdiOAMcSvaoDVfaNw6iwp
 7CuUVB5atSiFucwb8EccKdtg6w==
X-Google-Smtp-Source: AGHT+IETTWwBpXW3sQLGZqhW6SsrfTzdOZk7x/wbXgF0AaYm/ReBsNuh96XrU9+dPgCQ54Sso2nKQQ==
X-Received: by 2002:a05:6808:4483:b0:3b8:b063:9b78 with SMTP id
 eq3-20020a056808448300b003b8b0639b78mr3880867oib.106.1702186244036; 
 Sat, 09 Dec 2023 21:30:44 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 y4-20020a62f244000000b006ce809948adsm3984683pfl.30.2023.12.09.21.30.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Dec 2023 21:30:43 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 10 Dec 2023 14:29:48 +0900
Subject: [PATCH v8 10/19] virtio-net: Return an error when vhost cannot
 enable RSS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231210-rss-v8-10-9553ee714d38@daynix.com>
References: <20231210-rss-v8-0-9553ee714d38@daynix.com>
In-Reply-To: <20231210-rss-v8-0-9553ee714d38@daynix.com>
To: Jason Wang <jasowang@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.4
Received-SPF: none client-ip=2607:f8b0:4864:20::234;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x234.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
 hw/net/virtio-net.c | 98 ++++++++++++++++++++++++++---------------------------
 1 file changed, 49 insertions(+), 49 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 5d4afd12b2..c2cbf39a5f 100644
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
@@ -3704,53 +3745,12 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
 
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
+        !virtio_net_load_ebpf(n) &&
+        get_vhost_net(nc->peer)) {
+        error_setg(errp, "Can't load eBPF RSS for vhost");
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
2.43.0


