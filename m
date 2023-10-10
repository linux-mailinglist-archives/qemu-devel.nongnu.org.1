Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEC97BF124
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 05:00:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq2yM-00046T-5m; Mon, 09 Oct 2023 22:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qq2yL-00046K-22
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 22:59:49 -0400
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qq2yJ-0007x6-HQ
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 22:59:48 -0400
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7742da399a2so345510585a.0
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 19:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1696906786; x=1697511586;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4rLJUvKzJ/knH6vUIH+0Ji9GBhazQKzSi6QIe6BIJBk=;
 b=iETMrO6OtuharinXARWol1ICpjrt4AfNn4PrKpBoD4ZXlYYw/mlvNl4TroeXftxjw9
 UZjb9uk1AFeK94qM90w4TA2VcYeTC3/CB4CvHDCPwJOCxGRxfvg8O3knR7b/wT0EjVuN
 6dszMe5b82fy36eKWdAjZ/MbZw8Pz7sGBDLPPf8UM4LToSB9KnktBgI1UvJp2j8vVmxw
 BUemVgD+56lPiW6DIWw85KT+Tu/hPsdEgt0QC/ENXku+wHEui/fKBIAaauRILMi6lQlx
 9yTi3nL1XIS1BJQ+cJZ5GcV1GeI09xf6z8s0Z7BArNpPoZdii5OX5mZPjUpiCoI7ROd2
 FfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696906786; x=1697511586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4rLJUvKzJ/knH6vUIH+0Ji9GBhazQKzSi6QIe6BIJBk=;
 b=cWjZ8U+ObSg0bW+jnPIXYlSH/BYLGL7LKhlS9TqWb/SwHkg7rhXvMOKPAZyMroYesh
 HIOYaR4RFNb/iTcHcsstf7wohOMZVuYGt2/0XttHdedZUG/frUJ3BXJjGWgBZnUhmE+6
 SgkAHxsW9beAhR0dzxUfW2zTjHacHcGJd5SkA/RCoPxdR9UwHu0dUzYTiQkZ6bY2d2yb
 dLmHAqjAQ2J2gW7UkK7pUSdwtwcQX+PV6by/EyQn6EclWGcbQ8MxindjaVJr5+2V5KHb
 AeAStuSeIJzgMOGfKju6GsRU8eYY9KcNFDXbHmJM0Cm8Nkqtm2AAKZ5rEn91oCW9Hrj+
 RS7g==
X-Gm-Message-State: AOJu0YwZZmf5MdB5qXO/Y0Yz2h2nMir+1N336MVzNvtH3ogcClIn7IP9
 W6FSNze3/Mr7fdSzXt/WtH84fGHvX4/AHZbKjXj+EA==
X-Google-Smtp-Source: AGHT+IFPbYsWqiYKWyiq+e2YVqM+T3vqQ3jSj+JF2aNVRLpO/eRLBLxIpdKKFM4MOtlchn0YRhjyvA==
X-Received: by 2002:a05:620a:4513:b0:777:2723:ea77 with SMTP id
 t19-20020a05620a451300b007772723ea77mr787861qkp.65.1696906786586; 
 Mon, 09 Oct 2023 19:59:46 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 n20-20020a638f14000000b00563e1ef0491sm9155105pgd.8.2023.10.09.19.59.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 19:59:46 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 3/7] virtio-net: Disable RSS on reset
Date: Tue, 10 Oct 2023 11:59:17 +0900
Message-ID: <20231010025924.14593-4-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231010025924.14593-1-akihiko.odaki@daynix.com>
References: <20231010025924.14593-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::730;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-qk1-x730.google.com
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


