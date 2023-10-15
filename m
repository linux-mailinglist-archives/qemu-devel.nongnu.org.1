Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E53AD7C9945
	for <lists+qemu-devel@lfdr.de>; Sun, 15 Oct 2023 16:04:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qs1ia-0001TS-B3; Sun, 15 Oct 2023 10:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qs1iY-0001Sw-A9
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 10:03:42 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qs1iW-0007lP-Ce
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 10:03:42 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1c8a1541233so22363555ad.1
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 07:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697378619; x=1697983419;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D/69rfPohqvKDRlGWjTNsJjjNzMQUnxk935JqjW0sqQ=;
 b=lDXcrh+aAi8tnq4ywacFtoaHPDirHxXaGXG2Dc09lT9RiajeT6hUDjXqrqXj0rXBD3
 3qOVlLusXdOrAQymYcKRDbbYiT5c7KxR0lRF05WJVfoqVVCmb8FIhgxkLDAAz3qJnG3z
 NSzblrGrR41pbsr4kaUEKu4elN8ody/fRt69n9FpSv+iVi7dDXwb1mhImE8CrV4oqFji
 alInF/ooPpMRSnoZ6ntf7Gl8P+c7DPoRumMtHJqKTnWiIpXTqcCDH72srrsMHglO0VFC
 yupt4xylY0yj7LZqvqGtly+RzGnScAUWibV2B6xhpQ5Eb7A/mk92bHFDeEe4fXJ75mQG
 xKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697378619; x=1697983419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D/69rfPohqvKDRlGWjTNsJjjNzMQUnxk935JqjW0sqQ=;
 b=VfqRyrFlKu+6rmfY+zO3rFZXznC7alcCB9QizlWQ3bRcz5Fyoxme+yLjSEP7Cu7UrK
 YTIQz+bzK1bupp5GifjM7yuu5q5h+Qdkjx1Jp5ViQTbwPhM+R1p8IgD6bhBQgXMke6X/
 GhqzGuUWXBF1pHHn9xQLpUONkCNzLF3YcV27fu91Go0pY++MheZ/EoLTD6x6lV9aZny2
 pw7qPFHQ9ZpyWtveBMkbkZjQtyIFgTMUztH5TuVYzOZa177yuITQb9t+2519tetzF7NA
 70zMsiY9liVOZZj2p1ra5R0F67HtaeQozhuUlsxeQoqEzGqptpbx7E3YEEHgYfcz4Cg0
 fGig==
X-Gm-Message-State: AOJu0YzElAsFKTF2XWjQR8JDGd2/vgd3O9fILJv/bDfJgN2/w6LUUeU9
 4iDxT/VOEtFC0sEEB6hZE/c1UJNdg6BczRaC4nFPFg==
X-Google-Smtp-Source: AGHT+IELK6ccz0mCZ356pWHTmaP/FI+UHEYlHs+ZLmDMI9j1DBmG114MeNVDf8MLofIKG6nDfAtqag==
X-Received: by 2002:a17:903:1252:b0:1c2:36a:52a5 with SMTP id
 u18-20020a170903125200b001c2036a52a5mr33392560plh.57.1697378619023; 
 Sun, 15 Oct 2023 07:03:39 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 q22-20020a170902bd9600b001bdc9daadc9sm6852635pls.89.2023.10.15.07.03.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Oct 2023 07:03:38 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH v4 09/20] virtio-net: Disable RSS on reset
Date: Sun, 15 Oct 2023 23:02:41 +0900
Message-ID: <20231015140259.259434-10-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231015140259.259434-1-akihiko.odaki@daynix.com>
References: <20231015140259.259434-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
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


