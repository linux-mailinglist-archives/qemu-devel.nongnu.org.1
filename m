Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9FB75997D
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 17:22:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM906-0001FO-03; Wed, 19 Jul 2023 11:22:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1qM903-0001Ev-VT
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 11:21:59 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1qM902-000381-Dh
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 11:21:59 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-31297125334so644772f8f.0
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 08:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1689780117; x=1690384917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aYagYBx5aNBtVcZr1IGpbZU8GCLKBRP8hb8/PuqnjhI=;
 b=WKwU/Viv9Oo5W3b7umcmA8pIJHkIqovkHLzYYnx0+KIc71D4y3or+v3GjLxO6/g1Wk
 Dn6AKx6ojJfEe2iaji4Yw2gCvdTwRY1Hy/gjbg8fajgE8jIXbVtcX6SrWFa/kaxKaQEc
 TrVkCdSHjFpOF8rqabP8F6FVW1TtQ5EesahoypxRndYJZGNEssuWt35vh54njMd4bVKX
 RhCwh9mugj+ioMGB07sa6tiF8qLVJK/+c3hpg/33OW4CX3dbNQ6nCpaQ86dgl24/97lL
 8YmSgCNSIYoJ6LmllAEq0bgs7wvBv6tXXJ9uZqF63lFOrSgiM11JXnfUqz4hMRWO1k1e
 O+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689780117; x=1690384917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aYagYBx5aNBtVcZr1IGpbZU8GCLKBRP8hb8/PuqnjhI=;
 b=jUelmuk8+8hzVp2DIObyR0n/1BCsG++efhEVI6sCeI+XS3WMISI/vwqEwd1p2ZDqOK
 pMmaP1l4r/gcDqKE/N5JAhxWEus6l+E/NBDTBaInIMKMZSKJlhCSK7oEOYdKFtQwSlFG
 +BrEsG3OlG7QOJOv4bVmAwWKVDs0sPe/se766C53ejItVJZdOywJPcniWiDfuoZU+4Gi
 XpDdPaiUfMfVsmMjXizbKNrksjibuZPChJbhPqZTB4njcBQL0iUvhsHk+xd7q8cXauQh
 S0m1xCebr8rqjs7Bkd/f8g98Xv9LYUCqBWwsCmPIfMfq+krkrHU6LCs9wjJbywYAb+jo
 rpfQ==
X-Gm-Message-State: ABy/qLZ6HEWNPBLbDW+Po2pr7SKB4TsaOM0yJD3FFb+H2iM1rL1dU13x
 SDL71hPh4M7m6cN/CqeUO7a9ig==
X-Google-Smtp-Source: APBJJlEzT7LzXHlqSyWdDvHjHjaWzNCmTcD2UEU9Fy26AkSHPeYvkWmdwv0A7HNs/dYUnm2Epf5b4A==
X-Received: by 2002:a5d:6888:0:b0:314:3c72:d1ba with SMTP id
 h8-20020a5d6888000000b003143c72d1bamr198996wru.20.1689780117190; 
 Wed, 19 Jul 2023 08:21:57 -0700 (PDT)
Received: from localhost.localdomain
 ([2a06:c701:46e6:7e00:c5bb:d943:dc1b:8245])
 by smtp.gmail.com with ESMTPSA id
 b9-20020a5d6349000000b0030e52d4c1bcsm5626775wrw.71.2023.07.19.08.21.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jul 2023 08:21:56 -0700 (PDT)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, mst@redhat.com,
 Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org
Cc: yan@daynix.com,
	andrew@daynix.com
Subject: [PATCH 3/4] virtio-net: added USO support
Date: Wed, 19 Jul 2023 18:21:38 +0300
Message-Id: <20230719152139.1316570-4-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20230719152139.1316570-1-yuri.benditovich@daynix.com>
References: <20230719152139.1316570-1-yuri.benditovich@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::42b;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-wr1-x42b.google.com
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

virtio-net can suggest USO features TX, RX v4 and RX v6,
depending on kernel TUN ability to support them. These
features require explicit enable in command-line.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 hw/net/virtio-net.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index d2311e7d6e..e76cad923b 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -796,6 +796,10 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
         virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_TSO6);
         virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_ECN);
 
+        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_USO);
+        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO4);
+        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO6);
+
         virtio_clear_feature(&features, VIRTIO_NET_F_HASH_REPORT);
     }
 
@@ -864,14 +868,16 @@ static void virtio_net_apply_guest_offloads(VirtIONet *n)
             !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_USO6)));
 }
 
-static uint64_t virtio_net_guest_offloads_by_features(uint32_t features)
+static uint64_t virtio_net_guest_offloads_by_features(uint64_t features)
 {
     static const uint64_t guest_offloads_mask =
         (1ULL << VIRTIO_NET_F_GUEST_CSUM) |
         (1ULL << VIRTIO_NET_F_GUEST_TSO4) |
         (1ULL << VIRTIO_NET_F_GUEST_TSO6) |
         (1ULL << VIRTIO_NET_F_GUEST_ECN)  |
-        (1ULL << VIRTIO_NET_F_GUEST_UFO);
+        (1ULL << VIRTIO_NET_F_GUEST_UFO)  |
+        (1ULL << VIRTIO_NET_F_GUEST_USO4) |
+        (1ULL << VIRTIO_NET_F_GUEST_USO6);
 
     return guest_offloads_mask & features;
 }
@@ -3924,6 +3930,12 @@ static Property virtio_net_properties[] = {
     DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed, SPEED_UNKNOWN),
     DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_str),
     DEFINE_PROP_BOOL("failover", VirtIONet, failover, false),
+    DEFINE_PROP_BIT64("guest_uso4", VirtIONet, host_features,
+                      VIRTIO_NET_F_GUEST_USO4, false),
+    DEFINE_PROP_BIT64("guest_uso6", VirtIONet, host_features,
+                      VIRTIO_NET_F_GUEST_USO6, false),
+    DEFINE_PROP_BIT64("host_uso", VirtIONet, host_features,
+                      VIRTIO_NET_F_HOST_USO, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.34.3


