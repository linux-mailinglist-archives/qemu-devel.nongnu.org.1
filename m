Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E3E7BCC63
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 07:30:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpMMo-0004AD-Vd; Sun, 08 Oct 2023 01:30:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qpMMR-00045e-Jl
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 01:29:52 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qpMMI-000762-9B
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 01:29:48 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-690b7cb71aeso2602259b3a.0
 for <qemu-devel@nongnu.org>; Sat, 07 Oct 2023 22:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1696742980; x=1697347780;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4rLJUvKzJ/knH6vUIH+0Ji9GBhazQKzSi6QIe6BIJBk=;
 b=ZM/YScjleyvOdIgzY9/rYmRpzHhVatQ8UKpyS127e3Uh+tiNqcX86PggawsdhOgmUZ
 sEYKQ5IBYMg0RDRSbJgJX29eY2/euL8TWXp2ndITJU4RCB0uv6qxeWNM/+FtAmO45LmL
 DR/4A3IrS9rCkFD94bvGB9APMhVa9uVZGnxcpBsRWHZVP7KWlOOgwuXCNCkjBne4qsiQ
 4PWD4W4jfPnu9+OgRgpK/MEOon1pjyhwcS4rwd1YK9XLjsa/P9GpHUQhpTkMy3dshRVm
 cXEww819I6CsniMtA2JslyVRld7gboxuNbggz6yC4CPuVVeS7X5OCoeWZokj6WOknim8
 wYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696742980; x=1697347780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4rLJUvKzJ/knH6vUIH+0Ji9GBhazQKzSi6QIe6BIJBk=;
 b=Fik8X2hoNJkNmOBNdWVk8vzSqxXDEueyP7TDyTt6aQpUmtQ9zdx0A40vpnZMzE0dtQ
 PkJzxe1JfjB0GD5JTIoPzr606u/lyVlvUScrZ3X8xct3/hM+nYe0leXNUxqAPKkeb8sB
 nQipp7QDW4Zxg6weEzVaN/aEwVkT2jPYK9TKh/qfuFvXk7r2qdQvZXonOOjhZnOOFuFC
 VUKIGi52zE30YrpkPHnKxMoxjRQPuAgfBABJrcjmk+icGRBh1UB7gOm55Mq8ZjDjMqdX
 M2kcG0q7hvGgMe3djiJDYTisGku3UlFidR1K9DOzAFS7OgY4s4c27+MgTk+ZTjcPad4w
 icEg==
X-Gm-Message-State: AOJu0YzpGB31NFUJpUHkc4b50QclGkCgKsxg2pqoX23n81rt8u22e544
 7iu80bAJjE5HHes+7+6S4lKTb/+4CkicYZKSIjRsww==
X-Google-Smtp-Source: AGHT+IFAV7Cam6xAhrO4/67oGzA7t8ZxlMAdkF51bUt6ub+T9YUOUF3WgqsUU8kIUyiz82VkioxDzA==
X-Received: by 2002:a05:6a20:7f8f:b0:158:143d:e215 with SMTP id
 d15-20020a056a207f8f00b00158143de215mr14793633pzj.1.1696742980676; 
 Sat, 07 Oct 2023 22:29:40 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 n9-20020aa79049000000b0068fe7c4148fsm3943646pfo.57.2023.10.07.22.29.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Oct 2023 22:29:40 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH 3/6] virtio-net: Disable RSS on reset
Date: Sun,  8 Oct 2023 14:29:12 +0900
Message-ID: <20231008052917.145245-4-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231008052917.145245-1-akihiko.odaki@daynix.com>
References: <20231008052917.145245-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::436;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x436.google.com
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
---
 hw/net/virtio-net.c | 70 +++++++++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 34 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 1ba748c964..83bac9a98a 100644
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
@@ -3789,6 +3755,42 @@ static void virtio_net_device_unrealize(DeviceState *dev)
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


