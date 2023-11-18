Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED907EFEB3
	for <lists+qemu-devel@lfdr.de>; Sat, 18 Nov 2023 10:28:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4HbS-0006eM-7K; Sat, 18 Nov 2023 04:27:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r4HbN-0006bC-5o
 for qemu-devel@nongnu.org; Sat, 18 Nov 2023 04:26:57 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r4HbL-0003kG-KN
 for qemu-devel@nongnu.org; Sat, 18 Nov 2023 04:26:56 -0500
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3b5ff072fc4so1776243b6e.3
 for <qemu-devel@nongnu.org>; Sat, 18 Nov 2023 01:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1700299614; x=1700904414;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l/lHbU4/oDBLKv3jXrOOKcZeQNDjdt0rMM5xcx7BuII=;
 b=MVDeght0BWOShSW1D37YfNvwsn/+kEO5wQ1YAoTMi9P2lQGjGc09JIgy2WJBt1T0TR
 8X5c58rVBmL100vUWFiDS8rGz/RAjx3gbdjXI4StYNFRCyiY95FYD9mUxssHmEa/59yx
 aXBVKlcWE/xfIEgxOEqKpBuUzvpRc0KJCWgu37o+0E1PmdQKPZOaVbPMFIHgzg+hA79m
 GJIEDumhMK0YIbOsCbCTDtGw1oHWWkKVLX+Sqp5ux6CVEmHhHlT33njvKL2Cy5fSSgf8
 z5nLKwf5XioHUbQnqgbbtKe7hf2jeWCgWnslNmyz1/x7Jsp8aNgFI14aET+74pcG9Nv9
 dToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700299614; x=1700904414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l/lHbU4/oDBLKv3jXrOOKcZeQNDjdt0rMM5xcx7BuII=;
 b=KVSq+YVLp5KFNjmUPQqucYYgHFB2pB/o6ff8g9p3Ct9nEyLgNKuy/NYpT5FoWYocoQ
 2dpuRwHk5A81sGDC7OjzjFuqFN8peliWl52e9pvmv0Yf+1bc3NBbwQ34XndHWEAfP5gw
 CwfknB+Q3TGJ3eRGvnccpbgE2/c2/Lj0M6/0MJc2nuURvWBWdDfOo/7gRAk0tCU6uyUd
 c8XLahySuM39DWB3qlKrPyJ7aEN4zv8NzAIk8x9RTIxiVEXxQvBAs650LQCp9MmY/VQ6
 G3+L2h83G1A6HvuzFcYZ4D1vQi4Bvjr/ME4uoc0Tzt81XbjNRFM//iZnpB1SyDXXN4Ce
 wVMw==
X-Gm-Message-State: AOJu0YxNBbA4urvMZlE7C3HGuZM+dqZEFor1YexUfKDJ8By4XJa36Y5X
 dVb+g3s3q9CO1/Q0fNoQQ92fb8qvF8S6b8eBBzA=
X-Google-Smtp-Source: AGHT+IHCl6a9PfEPLR/pBGSfTYxMFrSM4Bn6lJ6g4bvE6RBvWiBm8ZyYxuAC/QrsCx1aLWj9qmin4g==
X-Received: by 2002:a05:6870:4349:b0:1e9:af81:54b6 with SMTP id
 x9-20020a056870434900b001e9af8154b6mr2456537oah.55.1700299614605; 
 Sat, 18 Nov 2023 01:26:54 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 b1-20020a17090a9bc100b0027d219d3ac6sm4381143pjw.47.2023.11.18.01.26.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Nov 2023 01:26:54 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Zhang, Chen" <chen.zhang@intel.com>, Akihiko Odaki <aodaki@redhat.com>
Subject: [PATCH RESEND v7 11/19] virtio-net: Report RSS warning at device
 realization
Date: Sat, 18 Nov 2023 18:25:51 +0900
Message-ID: <20231118092601.7132-12-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231118092601.7132-1-akihiko.odaki@daynix.com>
References: <20231118092601.7132-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::235;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x235.google.com
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

From: Akihiko Odaki <aodaki@redhat.com>

Warning about RSS fallback at device realization allows the user to
notice the configuration problem early.

Signed-off-by: Akihiko Odaki <aodaki@redhat.com>
---
 hw/net/virtio-net.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index c2cbf39a5f..40beff2262 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1260,10 +1260,12 @@ static bool virtio_net_attach_epbf_rss(VirtIONet *n)
 
     if (!ebpf_rss_set_all(&n->ebpf_rss, &config,
                           n->rss_data.indirections_table, n->rss_data.key)) {
+        error_report("Failed to configure eBPF RSS");
         return false;
     }
 
     if (!virtio_net_attach_ebpf_to_backend(n->nic, n->ebpf_rss.program_fd)) {
+        error_report("Failed to attach eBPF to backend");
         return false;
     }
 
@@ -1278,16 +1280,10 @@ static void virtio_net_detach_epbf_rss(VirtIONet *n)
 static void virtio_net_commit_rss_config(VirtIONet *n)
 {
     if (n->rss_data.enabled) {
-        n->rss_data.enabled_software_rss = n->rss_data.populate_hash;
+        n->rss_data.enabled_software_rss = n->rss_data.populate_hash ||
+                                           !virtio_net_attach_epbf_rss(n);
         if (n->rss_data.populate_hash) {
             virtio_net_detach_epbf_rss(n);
-        } else if (!virtio_net_attach_epbf_rss(n)) {
-            if (get_vhost_net(qemu_get_queue(n->nic)->peer)) {
-                warn_report("Can't load eBPF RSS for vhost");
-            } else {
-                warn_report("Can't load eBPF RSS - fallback to software RSS");
-                n->rss_data.enabled_software_rss = true;
-            }
         }
 
         trace_virtio_net_rss_enable(n->rss_data.hash_types,
@@ -3746,10 +3742,14 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
     net_rx_pkt_init(&n->rx_pkt);
 
     if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS) &&
-        !virtio_net_load_ebpf(n) &&
-        get_vhost_net(nc->peer)) {
-        error_setg(errp, "Can't load eBPF RSS for vhost");
-        virtio_net_device_unrealize(dev);
+        !virtio_net_load_ebpf(n)) {
+        if (get_vhost_net(nc->peer)) {
+            error_setg(errp, "Can't load eBPF RSS for vhost");
+            virtio_net_device_unrealize(dev);
+            return;
+        }
+
+        warn_report("Can't load eBPF RSS - fallback to software RSS");
     }
 }
 
-- 
2.42.1


