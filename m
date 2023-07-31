Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF6C76A436
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 00:34:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQbRW-00013T-PS; Mon, 31 Jul 2023 18:32:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1qQbRU-00012w-G0
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 18:32:44 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1qQbRS-0002Uy-Sb
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 18:32:44 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-522462d8416so6937670a12.1
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 15:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1690842761; x=1691447561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kZEWQmnQQOwrf5Z+6mr58v42rgmvWm2TczTVPz1HEYc=;
 b=aeTXkq0tKcmnxsu12eJLQ5JQZIWH/PFZ6To49Q2eQLiq0H6LH1pEl1WCYVtnK/Fl7D
 cBkTH16pjdK40mx6KwxFdGyzrv1TcvATgYDVz0LzdirtxpUzdsHQMY/M2d7lJkn95b/f
 ekVfwr23aTEEK+Bi/uixEK10KnxcHVeVSAxkjSXdX1Fxpnik27hYBJLBNfo+1u3jyU9m
 EF3d9gCYCmAfhQuEdqWNOisOe5bxO/itFijWeSxT3wdzAPDIPdlXvnFfRZjC6kFf1bNC
 by9ppV90Sbonfthu1KD3KT1Q5phSeS+MTLMK9o2uNfQDzrOorhxCCMYLDWQhpvfofd1A
 h7Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690842761; x=1691447561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kZEWQmnQQOwrf5Z+6mr58v42rgmvWm2TczTVPz1HEYc=;
 b=XC7UsBUII6/dX9TuCAogPJxqPrQ5zz4mA0K4QJuLH6jxd+oWGNtc+XPvGRPJOjQEUz
 /IUJSUcczHaZ9wRBYyL6n/gAhPTSBl18Jbdbmeh7sHlO8x3A3+7EzzLqM8IiiwVATnDQ
 kl7MlxE2Jt48LrCvJ3QEXYv4aEXtn7Zg6z29OZuuvDjLKfq9dpAWmZ0nTifvdC/nKQ8L
 PSillW2rvtcJCiaETggyDfhtT3eZq8fCjGq6XP8zrgUH+/MrVwS4Zl9jgKonG4EfoQ53
 25dQTox6VQnmorPJndeW4z13dMHOHZRRGs+/IT4VN21zFHcLis9wydUpcwrSaN2TrIP0
 GgcQ==
X-Gm-Message-State: ABy/qLYZaAq7hI8fKrTxzpumR4WJ5p2MnwfefqIQ1RVCL9DafA9OpIHM
 CT6wKGaUbHUxM163Fv8H84KZnw==
X-Google-Smtp-Source: APBJJlGR5UIMJO/w/eGqXMZYNOvtGi09nG0ABA+coGinDCenDbgp1/lQ5itSXtipDwBOhVLzYARG3w==
X-Received: by 2002:aa7:c70c:0:b0:522:1d1d:1de8 with SMTP id
 i12-20020aa7c70c000000b005221d1d1de8mr834765edq.2.1690842761468; 
 Mon, 31 Jul 2023 15:32:41 -0700 (PDT)
Received: from localhost.localdomain
 ([2a06:c701:46e5:f400:91e1:5f50:afab:4c79])
 by smtp.gmail.com with ESMTPSA id
 x5-20020aa7dac5000000b005223c34259fsm5915088eds.57.2023.07.31.15.32.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 15:32:41 -0700 (PDT)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, dmitry.fleytman@gmail.com,
 akihiko.odaki@daynix.com, jasowang@redhat.com, sriram.yagnaraman@est.tech,
 mst@redhat.com, sw@weilnetz.de, qemu-devel@nongnu.org
Cc: yan@daynix.com
Subject: [PATCH v2 4/4] virtio-net: Add support for USO features
Date: Tue,  1 Aug 2023 01:31:48 +0300
Message-Id: <20230731223148.1002258-5-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20230731223148.1002258-1-yuri.benditovich@daynix.com>
References: <20230731223148.1002258-1-yuri.benditovich@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::536;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-ed1-x536.google.com
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

USO features of virtio-net device depend on kernel ability
to support them, for backward compatibility by default the
features are disabled on 8.0 and earlier.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
Signed-off-by: Andrew Melnychecnko <andrew@daynix.com>
---
 hw/core/machine.c   |  4 ++++
 hw/net/virtio-net.c | 31 +++++++++++++++++++++++++++++--
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index f0d35c6401..a725e76738 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -38,10 +38,14 @@
 #include "exec/confidential-guest-support.h"
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-pci.h"
+#include "hw/virtio/virtio-net.h"
 
 GlobalProperty hw_compat_8_0[] = {
     { "migration", "multifd-flush-after-each-section", "on"},
     { TYPE_PCI_DEVICE, "x-pcie-ari-nextfn-1", "on" },
+    { TYPE_VIRTIO_NET, "host_uso", "off"},
+    { TYPE_VIRTIO_NET, "guest_uso4", "off"},
+    { TYPE_VIRTIO_NET, "guest_uso6", "off"},
 };
 const size_t hw_compat_8_0_len = G_N_ELEMENTS(hw_compat_8_0);
 
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index d2311e7d6e..bd0ead94fe 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -659,6 +659,15 @@ static int peer_has_ufo(VirtIONet *n)
     return n->has_ufo;
 }
 
+static int peer_has_uso(VirtIONet *n)
+{
+    if (!peer_has_vnet_hdr(n)) {
+        return 0;
+    }
+
+    return qemu_has_uso(qemu_get_queue(n->nic)->peer);
+}
+
 static void virtio_net_set_mrg_rx_bufs(VirtIONet *n, int mergeable_rx_bufs,
                                        int version_1, int hash_report)
 {
@@ -796,6 +805,10 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
         virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_TSO6);
         virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_ECN);
 
+        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_USO);
+        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO4);
+        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO6);
+
         virtio_clear_feature(&features, VIRTIO_NET_F_HASH_REPORT);
     }
 
@@ -804,6 +817,12 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
         virtio_clear_feature(&features, VIRTIO_NET_F_HOST_UFO);
     }
 
+    if (!peer_has_uso(n)) {
+        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_USO);
+        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO4);
+        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO6);
+    }
+
     if (!get_vhost_net(nc->peer)) {
         return features;
     }
@@ -864,14 +883,16 @@ static void virtio_net_apply_guest_offloads(VirtIONet *n)
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
@@ -3924,6 +3945,12 @@ static Property virtio_net_properties[] = {
     DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed, SPEED_UNKNOWN),
     DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_str),
     DEFINE_PROP_BOOL("failover", VirtIONet, failover, false),
+    DEFINE_PROP_BIT64("guest_uso4", VirtIONet, host_features,
+                      VIRTIO_NET_F_GUEST_USO4, true),
+    DEFINE_PROP_BIT64("guest_uso6", VirtIONet, host_features,
+                      VIRTIO_NET_F_GUEST_USO6, true),
+    DEFINE_PROP_BIT64("host_uso", VirtIONet, host_features,
+                      VIRTIO_NET_F_HOST_USO, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.34.3


