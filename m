Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEED80B903
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Dec 2023 06:31:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCCOn-00022u-Kt; Sun, 10 Dec 2023 00:30:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCCOk-00022g-Cy
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 00:30:39 -0500
Received: from mail-io1-xd31.google.com ([2607:f8b0:4864:20::d31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCCOi-00035s-Sa
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 00:30:38 -0500
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-7b6fa79b547so180354739f.1
 for <qemu-devel@nongnu.org>; Sat, 09 Dec 2023 21:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702186236; x=1702791036;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zzTnbGcyelakQltg3An7fj+dMRnvxGxCBSQoD40yrkI=;
 b=Rm5mMfKMHEFzF3q6za8q+V9xVO+5wWdqMfSREEunk59j5wIL0FfxM3kkxatbe8KSqk
 5awRKbLCghzQtH096GC7XZ1GmfMZoq1bUGie3A4NC+9/PMvVrhWNENutGAwYB4a1he24
 9kOy9JevquF7/C0PDdDqiS2ows9gVKzqpcO0s8Ti8NgG+/SduzIru5Ba3adpqHROHnNc
 63jA90A4gaFocg8X6lIPH1wDUEyo0kpYYGM8FFlAPBXRjV/uLlX53jnbdyruzhxm6ng/
 +GDXeFuut4deVeZBU+Fdz+AI2RM3TJGCnHWA0d1qf81qzFnOLVhJhtyeMu0eFGfM6s6Z
 By3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702186236; x=1702791036;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zzTnbGcyelakQltg3An7fj+dMRnvxGxCBSQoD40yrkI=;
 b=d2ksg78AQOSsReRF3Vr+JMybeLAvy5S+BP/2yqQxjTfg3GCbe/KnNPBVE3OhBEpA4w
 Ad4lGj8Aw/C42b6bdOy63mBhg8w5+tbdB8mlTgUmWZpVggNgcZB+BJcSSRnkrfKrdFCT
 3Os69v6EgrIYUbexG9VCQVUEQRDZWP1hcBzRGHKmwClnGv19HMVpjXLYPzBCWPY2tmsR
 IhJp34CJMMqZkCxQqlC8W+Dcc7C8H7zrJ5dl3KH4pejQuFnrdlxaRvllznB/wAHa+frU
 sn2S8GVgfv3T3lCfLmwu+CTBpPZTPjrF13ds2D/GMAA4ELgX7rYJgx3gFVNEV+Rx91Ot
 yFZQ==
X-Gm-Message-State: AOJu0YwogH2TUPv0/WOuCav6OVNmSQ1ys4DM/dsmpEPVjzg8UP4mTsYV
 r64NJKDa0DXC4nMR/hUTBNj1Zg==
X-Google-Smtp-Source: AGHT+IFkG+E54a6jA5xVGDXoy3c5n6xwEql7nR2Yyk8YhbogYon7eEjEN/35zUHcVrFh47PQBKdqng==
X-Received: by 2002:a05:6e02:1a49:b0:35d:a0fd:858 with SMTP id
 u9-20020a056e021a4900b0035da0fd0858mr4292282ilv.30.1702186235895; 
 Sat, 09 Dec 2023 21:30:35 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 ja1-20020a170902efc100b001d04c097d1esm4218075plb.271.2023.12.09.21.30.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Dec 2023 21:30:35 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 10 Dec 2023 14:29:46 +0900
Subject: [PATCH v8 08/19] virtio-net: Disable RSS on reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231210-rss-v8-8-9553ee714d38@daynix.com>
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
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Michael Tokarev <mjt@tls.msk.ru>
X-Mailer: b4 0.12.4
Received-SPF: none client-ip=2607:f8b0:4864:20::d31;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-io1-xd31.google.com
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

RSS is disabled by default.

Fixes: 590790297c ("virtio-net: implement RSS configuration command")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/net/virtio-net.c | 70 +++++++++++++++++++++++++++--------------------------
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
2.43.0


