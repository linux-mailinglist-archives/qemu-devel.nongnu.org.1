Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DCA7C5855
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 17:43:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqbKX-0003QA-Qv; Wed, 11 Oct 2023 11:41:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqbJv-0002Si-Vz
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 11:40:25 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqbJu-000203-83
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 11:40:23 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6c644a1845cso4732809a34.2
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 08:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697038820; x=1697643620;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aEzHr5lZ6dSfodClgg1dqSkcYC39YYxzyUu7VYPY81M=;
 b=k2xy+9mtfzTwMKg3hamlEsdAkxNnclSStiN0TYabgJYbPlF2enblaXYrsR9S72zcnc
 w8NCRE+BYsKmrBij0zwM9957xbJ2+wjyQ5G9rOyEuyYlDjfG+kk2GX5tusoGR7nkAEXf
 gNdldVxqg80DynwDG18oZzLdPwPpeJ1Ksyri99GjN1yWgw57BMjnXYtz+k7ew0LHdeCH
 qecINDe3mg5sSROUIsrqTPIyX2Of+iJYIts4cWYn5ufGNGJYvYpKYTztdtkE/1jD5ze3
 wdjqpfRH82EtO4vibyBdRkVGdp166cBAdDPP99gytqsUyTJAeJse0SRz7OLHLjeCLco2
 a07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697038820; x=1697643620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aEzHr5lZ6dSfodClgg1dqSkcYC39YYxzyUu7VYPY81M=;
 b=KdOFBZgVAcibvtfydTDqykU4Brb/Ftd240adDvChtL+8QNslrhggocFffjhNnD3OeM
 oJgCZmgM9pBYG9iXwgyIJynGlvk43k1ETSjZpU9xDoupKqqlV/obTayHZpezzNjdgvAR
 m38zohGBah7dHGqu4OCZExFTE2WS1gC3t2IMvwviI/EEfu+8dMchMLOjbYifXSXT1ox1
 iS96YfG23aNwI/zbziP7f7NSUeC081kthLqSTROOIDoczKYBetrLxuL32tQdULYYVNtg
 KebtRcxS/PEK0tr4QevdzKUYpfnTOsAJkW3H4B7APDJlI0UuIPmKYGqIsUmSOS4fbPZ2
 l1qA==
X-Gm-Message-State: AOJu0Yy/Vw/EnV8Hy1qyd3ZgwUMTEp3dOl/cqMwD7UCpj0pSxdSBzi7l
 cGS8ekiz2FELXd7yt3QahPE77qQqMgeHZKZMU1mM3A==
X-Google-Smtp-Source: AGHT+IGva1MmKtVgOy7WeW0GoZpiou68AeVj/V/Q9h7ZBd1NfCFkYC11uPZ5ulWMuLDTNoHWPfl5UQ==
X-Received: by 2002:a05:6830:16:b0:6c0:abdd:a875 with SMTP id
 c22-20020a056830001600b006c0abdda875mr23292197otp.18.1697038819763; 
 Wed, 11 Oct 2023 08:40:19 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 y28-20020a056a001c9c00b00690d1269691sm1378276pfw.22.2023.10.11.08.40.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 08:40:19 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v3 07/11] virtio-net: Disable RSS on reset
Date: Thu, 12 Oct 2023 00:39:38 +0900
Message-ID: <20231011153944.39572-8-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231011153944.39572-1-akihiko.odaki@daynix.com>
References: <20231011153944.39572-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::32d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x32d.google.com
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


