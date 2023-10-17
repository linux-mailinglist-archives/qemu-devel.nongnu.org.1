Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3AE7CB9A9
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 06:15:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsbPL-0007TS-Tj; Tue, 17 Oct 2023 00:10:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qsbPK-0007TD-3q
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 00:10:14 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qsbPH-0004LT-Cb
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 00:10:13 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-57ba5f05395so3205746eaf.1
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 21:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697515809; x=1698120609;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D/69rfPohqvKDRlGWjTNsJjjNzMQUnxk935JqjW0sqQ=;
 b=UDDiBPHmpSNNLBwRWEcRVHYuLmQQ7OJBgnNbR/4qdc5o3L+eNdpLc3xQtF31YRMuDP
 xM9fQo7296FeUp+gNGcoSnyuSZ8SFi6AdqBYxCQYg3S1Tdvu7CXc6SSJNGmhkSO7vcnE
 +KlQiKmwSx/hzsrG7J4eGWe76DqbXlLYjtJRlyQPENN+4GqA4WtiCZIcifv92BVtMsMc
 B60n2A9tL7PA4wd46OAz6C8xlWXEUIDFT+W5TEzPHimgvjOANYUivmJxIi3TgLSzX3WT
 JVuPs5WVH058e5ZlJjMHZk5DfLN+y1zf7vGnbSgGPsixyFIFnblTPsECLqbn/vdspJV5
 quzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697515809; x=1698120609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D/69rfPohqvKDRlGWjTNsJjjNzMQUnxk935JqjW0sqQ=;
 b=pvNYNTg+SgTZ+Yh9PdFK6mQzARGh3k70ffME+WYxmXTBSDiP0WwsJiBb8a7gnoXj5i
 Gp1HfUDaL6qJfXPebX2KCdjCh74dwac/5b//fRicFq0qDCFubgRviht7nuZiBBPExuKJ
 KyuEl76LvDvnA968qjwwVdu+l3GYkYz4s8RLe4B0exXQ334/Z/ogjaHkzAWS5kHDxUQl
 UifsHFE0MFvbxos+57TDMfGxd1IJgaJlrMvWHdzHzWvHJ3bxSQg3FkODIjqEOnu1ginG
 6fVPYKPvFB12NIblnZTgoi0Vo8vt1mxcxm+5LmJ3dZ2onHFPDrZWzIMy+CqvsSmhIXaQ
 HBzQ==
X-Gm-Message-State: AOJu0YznZmSxGpfdXvBRr9Gs5PuSto6otIxnN9lVm/b6CyRLEwVK2JoL
 h6sriwcI2QfQqTRG85Z0Lv6f0DI2c6VWRlVkus5tWQ==
X-Google-Smtp-Source: AGHT+IFux2GLjRsaLG0eqTc/kcGDP7itk70ny9SFajqkiYxvkySBe6NhhWJ+009x8pTzB8zy1I/7ig==
X-Received: by 2002:a05:6359:4209:b0:143:3845:e6fb with SMTP id
 kn9-20020a056359420900b001433845e6fbmr1382280rwb.27.1697515809456; 
 Mon, 16 Oct 2023 21:10:09 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 s20-20020aa78bd4000000b0068fb8e18971sm350716pfd.130.2023.10.16.21.10.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Oct 2023 21:10:09 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH v5 09/21] virtio-net: Disable RSS on reset
Date: Tue, 17 Oct 2023 13:09:15 +0900
Message-ID: <20231017040932.62997-10-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231017040932.62997-1-akihiko.odaki@daynix.com>
References: <20231017040932.62997-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c31;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc31.google.com
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

RSS is disabled by default.

Fixes: 590790297c ("virtio-net: implement RSS configuration command")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/net/virtio-net.c | 70 +++++++++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 34 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index b1cc74881a..cd533fb91a 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -601,40 +601,6 @@ static void virtio_net_queue_enable(VirtIODevice *vdev, uint32_t queue_index)
     }
 }
 
-static void virtio_net_reset(VirtIODevice *vdev)
-{
-    VirtIONet *n = VIRTIO_NET(vdev);
-    int i;
-
-    /* Reset back to compatibility mode */
-    n->promisc = 1;
-    n->allmulti = 0;
-    n->alluni = 0;
-    n->nomulti = 0;
-    n->nouni = 0;
-    n->nobcast = 0;
-    /* multiqueue is disabled by default */
-    n->curr_queue_pairs = 1;
-    timer_del(n->announce_timer.tm);
-    n->announce_timer.round = 0;
-    n->status &= ~VIRTIO_NET_S_ANNOUNCE;
-
-    /* Flush any MAC and VLAN filter table state */
-    n->mac_table.in_use = 0;
-    n->mac_table.first_multi = 0;
-    n->mac_table.multi_overflow = 0;
-    n->mac_table.uni_overflow = 0;
-    memset(n->mac_table.macs, 0, MAC_TABLE_ENTRIES * ETH_ALEN);
-    memcpy(&n->mac[0], &n->nic->conf->macaddr, sizeof(n->mac));
-    qemu_format_nic_info_str(qemu_get_queue(n->nic), n->mac);
-    memset(n->vlans, 0, MAX_VLAN >> 3);
-
-    /* Flush any async TX */
-    for (i = 0;  i < n->max_queue_pairs; i++) {
-        flush_or_purge_queued_packets(qemu_get_subqueue(n->nic, i));
-    }
-}
-
 static void peer_test_vnet_hdr(VirtIONet *n)
 {
     NetClientState *nc = qemu_get_queue(n->nic);
@@ -3786,6 +3752,42 @@ static void virtio_net_device_unrealize(DeviceState *dev)
     virtio_cleanup(vdev);
 }
 
+static void virtio_net_reset(VirtIODevice *vdev)
+{
+    VirtIONet *n = VIRTIO_NET(vdev);
+    int i;
+
+    /* Reset back to compatibility mode */
+    n->promisc = 1;
+    n->allmulti = 0;
+    n->alluni = 0;
+    n->nomulti = 0;
+    n->nouni = 0;
+    n->nobcast = 0;
+    /* multiqueue is disabled by default */
+    n->curr_queue_pairs = 1;
+    timer_del(n->announce_timer.tm);
+    n->announce_timer.round = 0;
+    n->status &= ~VIRTIO_NET_S_ANNOUNCE;
+
+    /* Flush any MAC and VLAN filter table state */
+    n->mac_table.in_use = 0;
+    n->mac_table.first_multi = 0;
+    n->mac_table.multi_overflow = 0;
+    n->mac_table.uni_overflow = 0;
+    memset(n->mac_table.macs, 0, MAC_TABLE_ENTRIES * ETH_ALEN);
+    memcpy(&n->mac[0], &n->nic->conf->macaddr, sizeof(n->mac));
+    qemu_format_nic_info_str(qemu_get_queue(n->nic), n->mac);
+    memset(n->vlans, 0, MAX_VLAN >> 3);
+
+    /* Flush any async TX */
+    for (i = 0;  i < n->max_queue_pairs; i++) {
+        flush_or_purge_queued_packets(qemu_get_subqueue(n->nic, i));
+    }
+
+    virtio_net_disable_rss(n);
+}
+
 static void virtio_net_instance_init(Object *obj)
 {
     VirtIONet *n = VIRTIO_NET(obj);
-- 
2.42.0


