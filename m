Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C786C70D548
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 09:37:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1MW5-00086Z-Qh; Tue, 23 May 2023 03:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MW0-00084H-UT
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:33:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MVz-000497-DD
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:33:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684827182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DHG7ZvklOJnV9k+3EaGZGz9cpSOjwFJJjjoXa20kv0k=;
 b=hu0HOcf7r/ycZvIaGtcOgZqPiYM/u8fV1paa9+Qp8K7dnbL4gvAK3JwQtG+AHLIu0f7Gs+
 afPFv42vcunHhAR43kFhimvxeD3qvw4J+zOu5U4fYPGVzLo1zE32tfCtUR/KQ6WDm5vVCI
 Ax15op/igxMPAbEmIwKdUYoa+Ul33Kk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-67-g-dXlI77NDSqnW1LIrkwzg-1; Tue, 23 May 2023 03:32:59 -0400
X-MC-Unique: g-dXlI77NDSqnW1LIrkwzg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4BC523C0C880;
 Tue, 23 May 2023 07:32:59 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-45.pek2.redhat.com [10.72.12.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 15CDE2166B25;
 Tue, 23 May 2023 07:32:56 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 05/50] igb: Fix Rx packet type encoding
Date: Tue, 23 May 2023 15:31:53 +0800
Message-Id: <20230523073238.54236-6-jasowang@redhat.com>
In-Reply-To: <20230523073238.54236-1-jasowang@redhat.com>
References: <20230523073238.54236-1-jasowang@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

igb's advanced descriptor uses a packet type encoding different from
one used in e1000e's extended descriptor. Fix the logic to encode
Rx packet type accordingly.

Fixes: 3a977deebe ("Intrdocue igb device emulation")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/igb_core.c | 38 +++++++++++++++++++-------------------
 hw/net/igb_regs.h |  5 +++++
 2 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 464a41d..dbd1192 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -1227,7 +1227,6 @@ igb_build_rx_metadata(IGBCore *core,
     struct virtio_net_hdr *vhdr;
     bool hasip4, hasip6;
     EthL4HdrProto l4hdr_proto;
-    uint32_t pkt_type;
 
     *status_flags = E1000_RXD_STAT_DD;
 
@@ -1266,28 +1265,29 @@ igb_build_rx_metadata(IGBCore *core,
         trace_e1000e_rx_metadata_ack();
     }
 
-    if (hasip6 && (core->mac[RFCTL] & E1000_RFCTL_IPV6_DIS)) {
-        trace_e1000e_rx_metadata_ipv6_filtering_disabled();
-        pkt_type = E1000_RXD_PKT_MAC;
-    } else if (l4hdr_proto == ETH_L4_HDR_PROTO_TCP ||
-               l4hdr_proto == ETH_L4_HDR_PROTO_UDP) {
-        pkt_type = hasip4 ? E1000_RXD_PKT_IP4_XDP : E1000_RXD_PKT_IP6_XDP;
-    } else if (hasip4 || hasip6) {
-        pkt_type = hasip4 ? E1000_RXD_PKT_IP4 : E1000_RXD_PKT_IP6;
-    } else {
-        pkt_type = E1000_RXD_PKT_MAC;
-    }
+    if (pkt_info) {
+        *pkt_info = rss_info->enabled ? rss_info->type : 0;
 
-    trace_e1000e_rx_metadata_pkt_type(pkt_type);
+        if (hasip4) {
+            *pkt_info |= E1000_ADVRXD_PKT_IP4;
+        }
 
-    if (pkt_info) {
-        if (rss_info->enabled) {
-            *pkt_info = rss_info->type;
+        if (hasip6) {
+            *pkt_info |= E1000_ADVRXD_PKT_IP6;
         }
 
-        *pkt_info |= (pkt_type << 4);
-    } else {
-        *status_flags |= E1000_RXD_PKT_TYPE(pkt_type);
+        switch (l4hdr_proto) {
+        case ETH_L4_HDR_PROTO_TCP:
+            *pkt_info |= E1000_ADVRXD_PKT_TCP;
+            break;
+
+        case ETH_L4_HDR_PROTO_UDP:
+            *pkt_info |= E1000_ADVRXD_PKT_UDP;
+            break;
+
+        default:
+            break;
+        }
     }
 
     if (hdr_info) {
diff --git a/hw/net/igb_regs.h b/hw/net/igb_regs.h
index c5c5b3c..21ee9a3 100644
--- a/hw/net/igb_regs.h
+++ b/hw/net/igb_regs.h
@@ -641,6 +641,11 @@ union e1000_adv_rx_desc {
 
 #define E1000_STATUS_NUM_VFS_SHIFT 14
 
+#define E1000_ADVRXD_PKT_IP4 BIT(4)
+#define E1000_ADVRXD_PKT_IP6 BIT(6)
+#define E1000_ADVRXD_PKT_TCP BIT(8)
+#define E1000_ADVRXD_PKT_UDP BIT(9)
+
 static inline uint8_t igb_ivar_entry_rx(uint8_t i)
 {
     return i < 8 ? i * 4 : (i - 8) * 4 + 2;
-- 
2.7.4


