Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 212E57DB2B8
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 06:17:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxKbv-00026i-Nv; Mon, 30 Oct 2023 01:14:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qxKbu-00026Z-0x
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 01:14:46 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qxKbs-0001kX-Fm
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 01:14:45 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1cc37fb1310so5790675ad.1
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 22:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698642883; x=1699247683;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z/GTEqNE9JSu+ejolP4ab5BgH9qq+VRexA8TbITvA3k=;
 b=QkxzVoyzv6S78ELj8a2jEURntnTRSeVIgvRHmLEb+i0ZFcKv17By+1nGYIdM8/kk+k
 AEJuB/SPHzYbirA0PwBiOnTmzWv/C/sTZK9UO4nV6/zr/qcn7zo5bvzJuPxeFV4NUmno
 IDMvtZ/lMnsIrJyj9OAJHGZDk4i4f6Ra6CoNmjJ3YaOcnxKIY5XJzN1zzYftaxXcFC83
 xRVB9Xq9OrWryeBOTe6TvzKjh6TbFf9R+5n6VfQPkPA92GQfHm/ila3EXQqv9WPWupeD
 CPvqaVwwUdNRgXr1LdlF6lvnNtEwpQOLd8DztfOf7o/WjbTgfPNOi65SKcrXo0pEz5/0
 T3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698642883; x=1699247683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z/GTEqNE9JSu+ejolP4ab5BgH9qq+VRexA8TbITvA3k=;
 b=QZ27J5RO97y0lfgpwf20bKF8Nz/16zA7TojJ3b8W+M653gjr2mLUN1/0FVxQntOE5F
 KcVBSGMFrXxwwrE4VsAKZUoblFfDIesD65/5SNLxis2zwuGavQpQmfLhtsh/m8VIiTr6
 i8yBQE2ZlSzOymLJ6AeoQy6M2gLv1ilDA96sVs36FxzD73oXnOIgZdBgC83JRfr0yApl
 +a7I0b5COyMQBbfnfRIETQwnNLxpAfMgNs2bX/2oRgSaaQ9nJwpat86U6yJA1KzsbSBQ
 7WGXOceFML5KkczpjcbDbDFM6NGUMoE7OTl0KRd09NLm1xg7kkgkgkjP8Hc6Ay0uGHBz
 K2DQ==
X-Gm-Message-State: AOJu0YyckeZeH8Y1DD/yV0IsuYKK3BKmTjbN8v3iF6Un4EWFQvncCE/V
 q79WZtvoBt0li1di1rU8ieu642sMylkH2vbcAU3d5A==
X-Google-Smtp-Source: AGHT+IFb+bUuh4KQPoD3E1/X/FTHruOaR26SmpyRb/3pHFZURVsiwR7X6201KVyfgGEmlZzknxPRPw==
X-Received: by 2002:a17:902:cec1:b0:1cc:345b:c7f5 with SMTP id
 d1-20020a170902cec100b001cc345bc7f5mr2341936plg.23.1698642883166; 
 Sun, 29 Oct 2023 22:14:43 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 ji22-20020a170903325600b001c0bf60ba5csm5303392plb.272.2023.10.29.22.14.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Oct 2023 22:14:42 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH v6 09/21] virtio-net: Disable RSS on reset
Date: Mon, 30 Oct 2023 14:12:30 +0900
Message-ID: <20231030051356.33123-10-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231030051356.33123-1-akihiko.odaki@daynix.com>
References: <20231030051356.33123-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62e.google.com
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
index b6223031e1..4c528baad9 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -599,40 +599,6 @@ static void virtio_net_queue_enable(VirtIODevice *vdev, uint32_t queue_index)
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
@@ -3805,6 +3771,42 @@ static void virtio_net_device_unrealize(DeviceState *dev)
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


