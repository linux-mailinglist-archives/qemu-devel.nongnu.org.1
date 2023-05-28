Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46734713829
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 08:59:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3ALV-0006Qm-SH; Sun, 28 May 2023 02:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q3ALG-0006Kl-1W; Sun, 28 May 2023 02:57:28 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q3ALE-0001ak-2p; Sun, 28 May 2023 02:57:25 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 121858DFA;
 Sun, 28 May 2023 09:57:16 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 87F0B7E1A;
 Sun, 28 May 2023 09:57:15 +0300 (MSK)
Received: (nullmailer pid 42057 invoked by uid 1000);
 Sun, 28 May 2023 06:57:15 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.1 62/73] igb: Fix Rx packet type encoding
Date: Sun, 28 May 2023 09:57:00 +0300
Message-Id: <20230528065714.42005-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.1-20230528095540@cover.tls.msk.ru>
References: <qemu-stable-8.0.1-20230528095540@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
(cherry picked from commit ed447c60b341f1714b3c800d7f9c68898e873f78)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 8a9fd1f729..1c7f4eaf76 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -1226,7 +1226,6 @@ igb_build_rx_metadata(IGBCore *core,
     struct virtio_net_hdr *vhdr;
     bool hasip4, hasip6;
     EthL4HdrProto l4hdr_proto;
-    uint32_t pkt_type;
 
     *status_flags = E1000_RXD_STAT_DD;
 
@@ -1265,28 +1264,29 @@ igb_build_rx_metadata(IGBCore *core,
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
index c5c5b3c3b8..21ee9a3b2d 100644
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
2.39.2


