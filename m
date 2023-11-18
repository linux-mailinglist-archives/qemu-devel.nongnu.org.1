Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA6A7EFEBD
	for <lists+qemu-devel@lfdr.de>; Sat, 18 Nov 2023 10:28:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4HbM-0006ah-Rr; Sat, 18 Nov 2023 04:26:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r4HbJ-0006aJ-2R
 for qemu-devel@nongnu.org; Sat, 18 Nov 2023 04:26:53 -0500
Received: from mail-ua1-x92b.google.com ([2607:f8b0:4864:20::92b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r4HbH-0003jt-IR
 for qemu-devel@nongnu.org; Sat, 18 Nov 2023 04:26:52 -0500
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-7c1a46c943cso663055241.2
 for <qemu-devel@nongnu.org>; Sat, 18 Nov 2023 01:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1700299610; x=1700904410;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y2aH5ABx/6sAHKj/wV9ywMlvkfIl2yKHdTK3DR1AUwU=;
 b=ftHi0H7MPhgESpZL4zM2fltb77j7mgegyWQnpvZ7JTu62goywUck/yIj4b4BiF/HEZ
 iA5P7eGEpb1MPFjTNAAx4T+rKD1TTa6JXZ/wsbNtuAdaHtcV4scJucG7XtDMC8iiIz67
 Em5tb79HbyIV41EQqlsFYK+XUG1alUlXdABocM6JASYrRV4IctU4mAbEN7ZgaNkDwlMr
 BkEM+Yc4uUN94SfBRcquUJnqk+VKoONVxk0TXUrrWttiyeREe7KTvgnadG2WDeY3dIZY
 U1mBh2LqCMX/LT36hbzuXrMZBUDevcZXLbKWSd24GOraOyDwnyaDa/DREIb6AFud9hgi
 cQEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700299610; x=1700904410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y2aH5ABx/6sAHKj/wV9ywMlvkfIl2yKHdTK3DR1AUwU=;
 b=SamTyQIl24RYbhqap4kXzSXx2ZFLGyPQhj0U8YHqeBTxTYGbHdTOB8U1XLZ4SF5O8G
 VwcYiULmye14ECC/zjtVzh5Z6VaazZMA1F4aw1dVDv7aevSAnxz80UDlbwFwavAATTJG
 65jZal5pT8+Vl4nXgd2P7FB8N6R1uqi6YjGQCgaTAqXh4IIEoIITHfaGkdUDbly09ICt
 c4wwLpGt+dLh54aBXJBPNawIlg3oTs7N+Le6uEJ8DDn+ywWhfcWill7/ouYKZcuq6nSl
 9bZiRyW7qBlynS/bmJ3mVw4sT8XXOIFLAfRwrkram0AMo2l4bbysQl0v2ZTbOjGJiDuw
 EyRQ==
X-Gm-Message-State: AOJu0YwwI+zglWTw2Tz7ZnrUharDqSpXbJ3IVhAhGhpwOCVQwC/3yh7y
 guZXO0LOO0/RKzIIn4BS6xjOkwYgoqS0+qvKUGE=
X-Google-Smtp-Source: AGHT+IEW84nZpoIJIRPloghm2JYjwScrfHEPrNc7vfiCRZK5B2UfPx0P6sSWWWDjlJ/GypoPVp92UQ==
X-Received: by 2002:a67:ec8e:0:b0:460:5a82:fc55 with SMTP id
 h14-20020a67ec8e000000b004605a82fc55mr1281168vsp.28.1700299610530; 
 Sat, 18 Nov 2023 01:26:50 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 e37-20020a630f25000000b005c200d6486asm2546520pgl.72.2023.11.18.01.26.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Nov 2023 01:26:50 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Zhang, Chen" <chen.zhang@intel.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH RESEND v7 10/19] virtio-net: Return an error when vhost cannot
 enable RSS
Date: Sat, 18 Nov 2023 18:25:50 +0900
Message-ID: <20231118092601.7132-11-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231118092601.7132-1-akihiko.odaki@daynix.com>
References: <20231118092601.7132-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::92b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ua1-x92b.google.com
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
 hw/net/virtio-net.c | 98 ++++++++++++++++++++++-----------------------
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
2.42.1


