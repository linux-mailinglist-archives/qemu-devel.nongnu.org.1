Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 660D27A44C2
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 10:33:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi9gJ-0006G3-Q9; Mon, 18 Sep 2023 04:32:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qi9fh-0005yO-Mh
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 04:32:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qi9fc-00049B-8D
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 04:31:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695025911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/nmaWjsPpo8aHQXy4GKGccTzKPwqiWrB88QchQGcoG0=;
 b=IRgwq0JGGFKtkxbe0EcCda8+OGE3vBIjOfjFcOgCFwmTW7RTQyNQaM7vTXP1AM83OsPDal
 slefzTGDBq9mIOgCRu1aFBgfMurRuW7RFgQHn+Tt8GtJz8GeJ6pPtui5WAH/9PFgu1HWkJ
 V9MBrXXil3uftmSfpXzK5Gv2VPE9dhA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-227-ZydnC40oPoWxaYXddxvz2g-1; Mon, 18 Sep 2023 04:31:49 -0400
X-MC-Unique: ZydnC40oPoWxaYXddxvz2g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE239945920;
 Mon, 18 Sep 2023 08:31:48 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.113.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 822602156A27;
 Mon, 18 Sep 2023 08:31:45 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychecnko <andrew@daynix.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL V2 04/17] virtio-net: Add support for USO features
Date: Mon, 18 Sep 2023 16:31:19 +0800
Message-Id: <20230918083132.55423-5-jasowang@redhat.com>
In-Reply-To: <20230918083132.55423-1-jasowang@redhat.com>
References: <20230918083132.55423-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Yuri Benditovich <yuri.benditovich@daynix.com>

USO features of virtio-net device depend on kernel ability
to support them, for backward compatibility by default the
features are disabled on 8.0 and earlier.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
Signed-off-by: Andrew Melnychecnko <andrew@daynix.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/core/machine.c   |  4 ++++
 hw/net/virtio-net.c | 31 +++++++++++++++++++++++++++++--
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index da699cf..230aab8 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -38,6 +38,7 @@
 #include "exec/confidential-guest-support.h"
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-pci.h"
+#include "hw/virtio/virtio-net.h"
 
 GlobalProperty hw_compat_8_1[] = {};
 const size_t hw_compat_8_1_len = G_N_ELEMENTS(hw_compat_8_1);
@@ -45,6 +46,9 @@ const size_t hw_compat_8_1_len = G_N_ELEMENTS(hw_compat_8_1);
 GlobalProperty hw_compat_8_0[] = {
     { "migration", "multifd-flush-after-each-section", "on"},
     { TYPE_PCI_DEVICE, "x-pcie-ari-nextfn-1", "on" },
+    { TYPE_VIRTIO_NET, "host_uso", "off"},
+    { TYPE_VIRTIO_NET, "guest_uso4", "off"},
+    { TYPE_VIRTIO_NET, "guest_uso6", "off"},
 };
 const size_t hw_compat_8_0_len = G_N_ELEMENTS(hw_compat_8_0);
 
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index d2311e7..bd0ead9 100644
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
2.7.4


