Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D40E77BCC74
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 07:43:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpMZ1-0003RU-BC; Sun, 08 Oct 2023 01:42:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qpMYv-0003Qr-EZ
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 01:42:45 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qpMYs-0002iB-VY
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 01:42:45 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-690d2441b95so2594491b3a.1
 for <qemu-devel@nongnu.org>; Sat, 07 Oct 2023 22:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1696743762; x=1697348562;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bktt96HaK9jSV/VfWxuKA2xiQeQu/9hYpvUZ9O8KUH0=;
 b=ADPg0vnzrMx3eXMM6Wip+A/h74ZwpNGGWUmSy/tQyqm24a7aA3GrxrAPDyefEswhhg
 xSkVEo/St1CFROgzqBCKIHaeftutx1gIo1a9/KuH7G9OdXYX4REHPwHIqyPhmlfTejxo
 DvWIYBCpTNevuHG/rFNMNoaLPDcHznNGM1ytOvrLvLgXl3HUpDfpy9Uu4cK/vXZj+61z
 4S8EqPxAw7Olsc+jn8/emBUCAiwcBB5ZPqeEUHEtQRR736w2WrVHbiZ6pUe3CMTGuRSF
 NVQQv1Y7vF83YoFwlm3wqo+czNlps2bZCLkmnKZgRaaaBh2ndA5HGpIj2fzQVOaEAjU1
 7O+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696743762; x=1697348562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bktt96HaK9jSV/VfWxuKA2xiQeQu/9hYpvUZ9O8KUH0=;
 b=pWp5kAzGyyVymi5pOvZziogmi1sRIuOtx8sZN7NC9tQ4uPi8Op1daoX3BbgHh8PFcL
 5fAsspSbp02tgfc2YRdUw9hA3KxmMNSu9vDjFog58JUtKa7xzeo8t5vQci0yv9Uyemgn
 d1/1+96xCJLH2mebZE+HUipASlNzQK8GGvs2mJpLFnzgqmYie6NxqefVNvQhaVJrYpZn
 1XWj7jJq2Vaijy2tw/tesFh7Ys/rM5mi1x0J1n2yZ87GF9FxYjPf73PsS1gp6pqHw5Hd
 uFmjZX0obpqvkPwNeLeqC2zBPRDfoSoX71ajKh3nnLimVwEnSKQ9ud8I73szWSP8U60P
 oBcw==
X-Gm-Message-State: AOJu0YzkI3mbuhPYdgcC7UussPaPMWtlotX9OveSZYLUgMhkAUys0NI3
 9htHd0wXVf1YIyx0Bk+/jQuS7y+BVkwd74JN6/moCw==
X-Google-Smtp-Source: AGHT+IHjiQBS/sBAdE8ugbrZv2UrXXTvj7Oxt+gCfLTg9/y/h4Y0B9USsQmMdgk9to+Ryl3JisCd+g==
X-Received: by 2002:a05:6a00:1d09:b0:692:6417:728a with SMTP id
 a9-20020a056a001d0900b006926417728amr10083566pfx.14.1696743761720; 
 Sat, 07 Oct 2023 22:42:41 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 g2-20020a62e302000000b0069370f32687sm4095636pfh.174.2023.10.07.22.42.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Oct 2023 22:42:41 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [RFC PATCH 3/4] virtio-net: Add hash type options
Date: Sun,  8 Oct 2023 14:42:17 +0900
Message-ID: <20231008054222.146228-4-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231008054222.146228-1-akihiko.odaki@daynix.com>
References: <20231008054222.146228-1-akihiko.odaki@daynix.com>
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

By default, virtio-net limits the hash types that will be advertised to
the guest so that all hash types are covered by the offloading
capability the client provides. This change allows to override this
behavior and to advertise hash types that require user-space hash
calculation by specifying "on" for the corresponding properties.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/virtio/virtio-net.h |  1 +
 hw/net/virtio-net.c            | 48 +++++++++++++++++++++++++++++++---
 2 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index deba793ec2..33857dd3c2 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -142,6 +142,7 @@ typedef struct VirtioNetRssData {
     uint32_t runtime_hash_types;
     uint32_t supported_hash_types;
     uint32_t peer_hash_types;
+    OnOffAuto specified_hash_types[8];
     uint8_t key[VIRTIO_NET_RSS_MAX_KEY_SIZE];
     uint16_t indirections_len;
     uint16_t *indirections_table;
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 3bf1fec2ac..9146a65aa4 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1379,16 +1379,31 @@ static bool virtio_net_configure_rss_host(VirtIONet *n, Error **errp)
 {
     NetVnetHashCap cap;
 
+    n->rss_data.supported_hash_types = VIRTIO_NET_RSS_SUPPORTED_HASHES;
+
     if (qemu_get_vnet_hash_cap(qemu_get_queue(n->nic)->peer, &cap) &&
         cap.max_indirection_table_length >= VIRTIO_NET_RSS_MAX_TABLE_LEN) {
         n->rss_data.peer_hash_available = true;
-        n->rss_data.supported_hash_types = cap.types;
         n->rss_data.peer_hash_types = cap.types;
 
-        return true;
+        for (size_t i = 0; ; i++) {
+            if (i >= ARRAY_SIZE(n->rss_data.specified_hash_types)) {
+                n->rss_data.supported_hash_types = cap.types;
+                break;
+            }
+
+            if (n->rss_data.specified_hash_types[i] == ON_OFF_AUTO_ON &&
+                !(cap.types & BIT(i + 1))) {
+                break;
+            }
+        }
     }
 
-    n->rss_data.supported_hash_types = VIRTIO_NET_RSS_SUPPORTED_HASHES;
+    for (size_t i = 0; i < ARRAY_SIZE(n->rss_data.specified_hash_types); i++) {
+        if (n->rss_data.specified_hash_types[i] == ON_OFF_AUTO_OFF) {
+            n->rss_data.supported_hash_types &= ~BIT(i + 1);
+        }
+    }
 
     return virtio_net_commit_rss_host_config(n, errp);
 }
@@ -4013,6 +4028,33 @@ static Property virtio_net_properties[] = {
     DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed, SPEED_UNKNOWN),
     DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_str),
     DEFINE_PROP_BOOL("failover", VirtIONet, failover, false),
+    DEFINE_PROP_ON_OFF_AUTO("hash-ipv4", VirtIONet,
+                            rss_data.specified_hash_types[VIRTIO_NET_HASH_REPORT_IPv4 - 1],
+                            ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO("hash-tcp4", VirtIONet,
+                            rss_data.specified_hash_types[VIRTIO_NET_HASH_REPORT_TCPv4 - 1],
+                            ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO("hash-udp4", VirtIONet,
+                            rss_data.specified_hash_types[VIRTIO_NET_HASH_REPORT_UDPv4 - 1],
+                            ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO("hash-ipv6", VirtIONet,
+                            rss_data.specified_hash_types[VIRTIO_NET_HASH_REPORT_IPv6 - 1],
+                            ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO("hash-tcp6", VirtIONet,
+                            rss_data.specified_hash_types[VIRTIO_NET_HASH_REPORT_TCPv6 - 1],
+                            ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO("hash-udp6", VirtIONet,
+                            rss_data.specified_hash_types[VIRTIO_NET_HASH_REPORT_UDPv6 - 1],
+                            ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO("hash-ipv6ex", VirtIONet,
+                            rss_data.specified_hash_types[VIRTIO_NET_HASH_REPORT_IPv6_EX - 1],
+                            ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO("hash-tcp6ex", VirtIONet,
+                            rss_data.specified_hash_types[VIRTIO_NET_HASH_REPORT_TCPv6_EX - 1],
+                            ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO("hash-udp6ex", VirtIONet,
+                            rss_data.specified_hash_types[VIRTIO_NET_HASH_REPORT_UDPv6_EX - 1],
+                            ON_OFF_AUTO_AUTO),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.42.0


