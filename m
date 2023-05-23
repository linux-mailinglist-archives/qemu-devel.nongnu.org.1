Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F4770D51F
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 09:34:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1MWe-0000nd-EL; Tue, 23 May 2023 03:33:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MWc-0000kM-S1
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:33:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MWb-0004Gh-1Q
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:33:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684827220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=93yTue/mkXac105qFbeLv0JGyfg9+AiswjwdGD+GlBg=;
 b=aO+EdtEe48ZQaVHc+o/2Jra60ABLbtl/c6hjDxfb3Xvk0XyqlTD2LiHEF8OxlanIz9e3Dm
 XAKkejN9nBmsqK6OHfBNMGrcVSaxOj6GdlXrk7DPAcAFvoAQa3avoAvrd7O0vfJOxYVOHD
 syhdNNiXDMBtTnok84L0jHWdUccZq+s=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-336-Jw8r_kU9MJaXFrVy2EinxA-1; Tue, 23 May 2023 03:33:37 -0400
X-MC-Unique: Jw8r_kU9MJaXFrVy2EinxA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 923601C02D2C;
 Tue, 23 May 2023 07:33:36 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-45.pek2.redhat.com [10.72.12.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3AAD62166B25;
 Tue, 23 May 2023 07:33:33 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 18/50] e1000x: Rename TcpIpv6 into TcpIpv6Ex
Date: Tue, 23 May 2023 15:32:06 +0800
Message-Id: <20230523073238.54236-19-jasowang@redhat.com>
In-Reply-To: <20230523073238.54236-1-jasowang@redhat.com>
References: <20230523073238.54236-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
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

e1000e and igb employs NetPktRssIpV6TcpEx for RSS hash if TcpIpv6 MRQC
bit is set. Moreover, igb also has a MRQC bit for NetPktRssIpV6Tcp
though it is not implemented yet. Rename it to TcpIpv6Ex to avoid
confusion.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/e1000e_core.c |  8 ++++----
 hw/net/e1000x_regs.h | 24 ++++++++++++------------
 hw/net/igb_core.c    |  8 ++++----
 hw/net/trace-events  |  2 +-
 4 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 41d2435..38d465a 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -537,7 +537,7 @@ e1000e_rss_get_hash_type(E1000ECore *core, struct NetRxPkt *pkt)
                                 ip6info->rss_ex_dst_valid,
                                 ip6info->rss_ex_src_valid,
                                 core->mac[MRQC],
-                                E1000_MRQC_EN_TCPIPV6(core->mac[MRQC]),
+                                E1000_MRQC_EN_TCPIPV6EX(core->mac[MRQC]),
                                 E1000_MRQC_EN_IPV6EX(core->mac[MRQC]),
                                 E1000_MRQC_EN_IPV6(core->mac[MRQC]));
 
@@ -546,8 +546,8 @@ e1000e_rss_get_hash_type(E1000ECore *core, struct NetRxPkt *pkt)
                               ip6info->rss_ex_src_valid))) {
 
             if (l4hdr_proto == ETH_L4_HDR_PROTO_TCP &&
-                E1000_MRQC_EN_TCPIPV6(core->mac[MRQC])) {
-                return E1000_MRQ_RSS_TYPE_IPV6TCP;
+                E1000_MRQC_EN_TCPIPV6EX(core->mac[MRQC])) {
+                return E1000_MRQ_RSS_TYPE_IPV6TCPEX;
             }
 
             if (E1000_MRQC_EN_IPV6EX(core->mac[MRQC])) {
@@ -581,7 +581,7 @@ e1000e_rss_calc_hash(E1000ECore *core,
     case E1000_MRQ_RSS_TYPE_IPV4TCP:
         type = NetPktRssIpV4Tcp;
         break;
-    case E1000_MRQ_RSS_TYPE_IPV6TCP:
+    case E1000_MRQ_RSS_TYPE_IPV6TCPEX:
         type = NetPktRssIpV6TcpEx;
         break;
     case E1000_MRQ_RSS_TYPE_IPV6:
diff --git a/hw/net/e1000x_regs.h b/hw/net/e1000x_regs.h
index 6d3c4c6..13760c6 100644
--- a/hw/net/e1000x_regs.h
+++ b/hw/net/e1000x_regs.h
@@ -290,18 +290,18 @@
 #define E1000_RETA_IDX(hash)        ((hash) & (BIT(7) - 1))
 #define E1000_RETA_VAL(reta, hash)  (((uint8_t *)(reta))[E1000_RETA_IDX(hash)])
 
-#define E1000_MRQC_EN_TCPIPV4(mrqc) ((mrqc) & BIT(16))
-#define E1000_MRQC_EN_IPV4(mrqc)    ((mrqc) & BIT(17))
-#define E1000_MRQC_EN_TCPIPV6(mrqc) ((mrqc) & BIT(18))
-#define E1000_MRQC_EN_IPV6EX(mrqc)  ((mrqc) & BIT(19))
-#define E1000_MRQC_EN_IPV6(mrqc)    ((mrqc) & BIT(20))
-
-#define E1000_MRQ_RSS_TYPE_NONE     (0)
-#define E1000_MRQ_RSS_TYPE_IPV4TCP  (1)
-#define E1000_MRQ_RSS_TYPE_IPV4     (2)
-#define E1000_MRQ_RSS_TYPE_IPV6TCP  (3)
-#define E1000_MRQ_RSS_TYPE_IPV6EX   (4)
-#define E1000_MRQ_RSS_TYPE_IPV6     (5)
+#define E1000_MRQC_EN_TCPIPV4(mrqc)   ((mrqc) & BIT(16))
+#define E1000_MRQC_EN_IPV4(mrqc)      ((mrqc) & BIT(17))
+#define E1000_MRQC_EN_TCPIPV6EX(mrqc) ((mrqc) & BIT(18))
+#define E1000_MRQC_EN_IPV6EX(mrqc)    ((mrqc) & BIT(19))
+#define E1000_MRQC_EN_IPV6(mrqc)      ((mrqc) & BIT(20))
+
+#define E1000_MRQ_RSS_TYPE_NONE       (0)
+#define E1000_MRQ_RSS_TYPE_IPV4TCP    (1)
+#define E1000_MRQ_RSS_TYPE_IPV4       (2)
+#define E1000_MRQ_RSS_TYPE_IPV6TCPEX  (3)
+#define E1000_MRQ_RSS_TYPE_IPV6EX     (4)
+#define E1000_MRQ_RSS_TYPE_IPV6       (5)
 
 #define E1000_ICR_ASSERTED BIT(31)
 #define E1000_EIAC_MASK    0x01F00000
diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 934db3c..209fdad 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -301,7 +301,7 @@ igb_rss_get_hash_type(IGBCore *core, struct NetRxPkt *pkt)
                                 ip6info->rss_ex_dst_valid,
                                 ip6info->rss_ex_src_valid,
                                 core->mac[MRQC],
-                                E1000_MRQC_EN_TCPIPV6(core->mac[MRQC]),
+                                E1000_MRQC_EN_TCPIPV6EX(core->mac[MRQC]),
                                 E1000_MRQC_EN_IPV6EX(core->mac[MRQC]),
                                 E1000_MRQC_EN_IPV6(core->mac[MRQC]));
 
@@ -310,8 +310,8 @@ igb_rss_get_hash_type(IGBCore *core, struct NetRxPkt *pkt)
                               ip6info->rss_ex_src_valid))) {
 
             if (l4hdr_proto == ETH_L4_HDR_PROTO_TCP &&
-                E1000_MRQC_EN_TCPIPV6(core->mac[MRQC])) {
-                return E1000_MRQ_RSS_TYPE_IPV6TCP;
+                E1000_MRQC_EN_TCPIPV6EX(core->mac[MRQC])) {
+                return E1000_MRQ_RSS_TYPE_IPV6TCPEX;
             }
 
             if (E1000_MRQC_EN_IPV6EX(core->mac[MRQC])) {
@@ -343,7 +343,7 @@ igb_rss_calc_hash(IGBCore *core, struct NetRxPkt *pkt, E1000E_RSSInfo *info)
     case E1000_MRQ_RSS_TYPE_IPV4TCP:
         type = NetPktRssIpV4Tcp;
         break;
-    case E1000_MRQ_RSS_TYPE_IPV6TCP:
+    case E1000_MRQ_RSS_TYPE_IPV6TCPEX:
         type = NetPktRssIpV6TcpEx;
         break;
     case E1000_MRQ_RSS_TYPE_IPV6:
diff --git a/hw/net/trace-events b/hw/net/trace-events
index a34d196..64d776b 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -179,7 +179,7 @@ e1000e_rx_rss_disabled(void) "RSS is disabled"
 e1000e_rx_rss_type(uint32_t type) "RSS type is %u"
 e1000e_rx_rss_ip4(int l4hdr_proto, uint32_t mrqc, bool tcpipv4_enabled, bool ipv4_enabled) "RSS IPv4: L4 header protocol %d, mrqc 0x%X, tcpipv4 enabled %d, ipv4 enabled %d"
 e1000e_rx_rss_ip6_rfctl(uint32_t rfctl) "RSS IPv6: rfctl 0x%X"
-e1000e_rx_rss_ip6(bool ex_dis, bool new_ex_dis, int l4hdr_proto, bool has_ext_headers, bool ex_dst_valid, bool ex_src_valid, uint32_t mrqc, bool tcpipv6_enabled, bool ipv6ex_enabled, bool ipv6_enabled) "RSS IPv6: ex_dis: %d, new_ex_dis: %d, L4 header protocol %d, has_ext_headers %d, ex_dst_valid %d, ex_src_valid %d, mrqc 0x%X, tcpipv6 enabled %d, ipv6ex enabled %d, ipv6 enabled %d"
+e1000e_rx_rss_ip6(bool ex_dis, bool new_ex_dis, int l4hdr_proto, bool has_ext_headers, bool ex_dst_valid, bool ex_src_valid, uint32_t mrqc, bool tcpipv6ex_enabled, bool ipv6ex_enabled, bool ipv6_enabled) "RSS IPv6: ex_dis: %d, new_ex_dis: %d, L4 header protocol %d, has_ext_headers %d, ex_dst_valid %d, ex_src_valid %d, mrqc 0x%X, tcpipv6ex enabled %d, ipv6ex enabled %d, ipv6 enabled %d"
 
 e1000e_rx_metadata_protocols(bool hasip4, bool hasip6, int l4hdr_protocol) "protocols: ip4: %d, ip6: %d, l4hdr: %d"
 e1000e_rx_metadata_vlan(uint16_t vlan_tag) "VLAN tag is 0x%X"
-- 
2.7.4


