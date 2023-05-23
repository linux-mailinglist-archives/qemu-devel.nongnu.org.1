Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDC570D523
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 09:35:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1MWD-00089Y-E6; Tue, 23 May 2023 03:33:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MWC-000899-2B
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:33:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MWA-0004Bt-7F
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:33:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684827193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=opNGbjLYXWoRbNndfqmzTZSWi6g+ohrc9Vo18IiIhL0=;
 b=bH1pAuaKUq9uGJpe1rvkJwOvMX6XYLWrVtm8aWX625euwhYDZIrDo4sDLPnpunWtSMyVTt
 ksISJlDpZE0VqHSvedvL3GoTpLEvE6y9JjFLelKEOK2tPZ3g2QYLNCEfSCAuQBD1wRICUg
 GdHNUTXKLzOkF4D+wBZK8qhxdcsekhI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-Ri_A2qNQNQ6gV53eaeDjWA-1; Tue, 23 May 2023 03:33:08 -0400
X-MC-Unique: Ri_A2qNQNQ6gV53eaeDjWA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F13941C0512A;
 Tue, 23 May 2023 07:33:07 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-45.pek2.redhat.com [10.72.12.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BF8D32166B26;
 Tue, 23 May 2023 07:33:05 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 08/50] net/net_rx_pkt: Use iovec for net_rx_pkt_set_protocols()
Date: Tue, 23 May 2023 15:31:56 +0800
Message-Id: <20230523073238.54236-9-jasowang@redhat.com>
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

igb does not properly ensure the buffer passed to
net_rx_pkt_set_protocols() is contiguous for the entire L2/L3/L4 header.
Allow it to pass scattered data to net_rx_pkt_set_protocols().

Fixes: 3a977deebe ("Intrdocue igb device emulation")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/igb_core.c   |  2 +-
 hw/net/net_rx_pkt.c | 14 +++++---------
 hw/net/net_rx_pkt.h | 10 ++++++----
 hw/net/virtio-net.c |  7 +++++--
 hw/net/vmxnet3.c    |  7 ++++++-
 include/net/eth.h   |  6 +++---
 net/eth.c           | 18 ++++++++----------
 7 files changed, 34 insertions(+), 30 deletions(-)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index eaca5bd..21a8d9a 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -1650,7 +1650,7 @@ igb_receive_internal(IGBCore *core, const struct iovec *iov, int iovcnt,
 
     ehdr = PKT_GET_ETH_HDR(filter_buf);
     net_rx_pkt_set_packet_type(core->rx_pkt, get_eth_packet_type(ehdr));
-    net_rx_pkt_set_protocols(core->rx_pkt, filter_buf, size);
+    net_rx_pkt_set_protocols(core->rx_pkt, iov, iovcnt, iov_ofs);
 
     queues = igb_receive_assign(core, ehdr, size, &rss_info, external_tx);
     if (!queues) {
diff --git a/hw/net/net_rx_pkt.c b/hw/net/net_rx_pkt.c
index 39cdea0..63be6e0 100644
--- a/hw/net/net_rx_pkt.c
+++ b/hw/net/net_rx_pkt.c
@@ -103,7 +103,7 @@ net_rx_pkt_pull_data(struct NetRxPkt *pkt,
                                 iov, iovcnt, ploff, pkt->tot_len);
     }
 
-    eth_get_protocols(pkt->vec, pkt->vec_len, &pkt->hasip4, &pkt->hasip6,
+    eth_get_protocols(pkt->vec, pkt->vec_len, 0, &pkt->hasip4, &pkt->hasip6,
                       &pkt->l3hdr_off, &pkt->l4hdr_off, &pkt->l5hdr_off,
                       &pkt->ip6hdr_info, &pkt->ip4hdr_info, &pkt->l4hdr_info);
 
@@ -186,17 +186,13 @@ size_t net_rx_pkt_get_total_len(struct NetRxPkt *pkt)
     return pkt->tot_len;
 }
 
-void net_rx_pkt_set_protocols(struct NetRxPkt *pkt, const void *data,
-                              size_t len)
+void net_rx_pkt_set_protocols(struct NetRxPkt *pkt,
+                              const struct iovec *iov, size_t iovcnt,
+                              size_t iovoff)
 {
-    const struct iovec iov = {
-        .iov_base = (void *)data,
-        .iov_len = len
-    };
-
     assert(pkt);
 
-    eth_get_protocols(&iov, 1, &pkt->hasip4, &pkt->hasip6,
+    eth_get_protocols(iov, iovcnt, iovoff, &pkt->hasip4, &pkt->hasip6,
                       &pkt->l3hdr_off, &pkt->l4hdr_off, &pkt->l5hdr_off,
                       &pkt->ip6hdr_info, &pkt->ip4hdr_info, &pkt->l4hdr_info);
 }
diff --git a/hw/net/net_rx_pkt.h b/hw/net/net_rx_pkt.h
index d00b484..a06f5c2 100644
--- a/hw/net/net_rx_pkt.h
+++ b/hw/net/net_rx_pkt.h
@@ -55,12 +55,14 @@ size_t net_rx_pkt_get_total_len(struct NetRxPkt *pkt);
  * parse and set packet analysis results
  *
  * @pkt:            packet
- * @data:           pointer to the data buffer to be parsed
- * @len:            data length
+ * @iov:            received data scatter-gather list
+ * @iovcnt:         number of elements in iov
+ * @iovoff:         data start offset in the iov
  *
  */
-void net_rx_pkt_set_protocols(struct NetRxPkt *pkt, const void *data,
-                              size_t len);
+void net_rx_pkt_set_protocols(struct NetRxPkt *pkt,
+                              const struct iovec *iov, size_t iovcnt,
+                              size_t iovoff);
 
 /**
  * fetches packet analysis results
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 8ce239a..6df6b73 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1834,9 +1834,12 @@ static int virtio_net_process_rss(NetClientState *nc, const uint8_t *buf,
         VIRTIO_NET_HASH_REPORT_UDPv6,
         VIRTIO_NET_HASH_REPORT_UDPv6_EX
     };
+    struct iovec iov = {
+        .iov_base = (void *)buf,
+        .iov_len = size
+    };
 
-    net_rx_pkt_set_protocols(pkt, buf + n->host_hdr_len,
-                             size - n->host_hdr_len);
+    net_rx_pkt_set_protocols(pkt, &iov, 1, n->host_hdr_len);
     net_rx_pkt_get_protocols(pkt, &hasip4, &hasip6, &l4hdr_proto);
     net_hash_type = virtio_net_get_hash_type(hasip4, hasip6, l4hdr_proto,
                                              n->rss_data.hash_types);
diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 9acff31..05f41b6 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -2001,7 +2001,12 @@ vmxnet3_receive(NetClientState *nc, const uint8_t *buf, size_t size)
         get_eth_packet_type(PKT_GET_ETH_HDR(buf)));
 
     if (vmxnet3_rx_filter_may_indicate(s, buf, size)) {
-        net_rx_pkt_set_protocols(s->rx_pkt, buf, size);
+        struct iovec iov = {
+            .iov_base = (void *)buf,
+            .iov_len = size
+        };
+
+        net_rx_pkt_set_protocols(s->rx_pkt, &iov, 1, 0);
         vmxnet3_rx_need_csum_calculate(s->rx_pkt, buf, size);
         net_rx_pkt_attach_data(s->rx_pkt, buf, size, s->rx_vlan_stripping);
         bytes_indicated = vmxnet3_indicate_packet(s) ? size : -1;
diff --git a/include/net/eth.h b/include/net/eth.h
index c5ae449..9f19c3a 100644
--- a/include/net/eth.h
+++ b/include/net/eth.h
@@ -312,10 +312,10 @@ eth_get_l2_hdr_length(const void *p)
 }
 
 static inline uint32_t
-eth_get_l2_hdr_length_iov(const struct iovec *iov, int iovcnt)
+eth_get_l2_hdr_length_iov(const struct iovec *iov, size_t iovcnt, size_t iovoff)
 {
     uint8_t p[sizeof(struct eth_header) + sizeof(struct vlan_header)];
-    size_t copied = iov_to_buf(iov, iovcnt, 0, p, ARRAY_SIZE(p));
+    size_t copied = iov_to_buf(iov, iovcnt, iovoff, p, ARRAY_SIZE(p));
 
     if (copied < ARRAY_SIZE(p)) {
         return copied;
@@ -397,7 +397,7 @@ typedef struct eth_l4_hdr_info_st {
     bool has_tcp_data;
 } eth_l4_hdr_info;
 
-void eth_get_protocols(const struct iovec *iov, int iovcnt,
+void eth_get_protocols(const struct iovec *iov, size_t iovcnt, size_t iovoff,
                        bool *hasip4, bool *hasip6,
                        size_t *l3hdr_off,
                        size_t *l4hdr_off,
diff --git a/net/eth.c b/net/eth.c
index 70bcd8e..d7b30df 100644
--- a/net/eth.c
+++ b/net/eth.c
@@ -136,7 +136,7 @@ _eth_tcp_has_data(bool is_ip4,
     return l4len > TCP_HEADER_DATA_OFFSET(tcp);
 }
 
-void eth_get_protocols(const struct iovec *iov, int iovcnt,
+void eth_get_protocols(const struct iovec *iov, size_t iovcnt, size_t iovoff,
                        bool *hasip4, bool *hasip6,
                        size_t *l3hdr_off,
                        size_t *l4hdr_off,
@@ -147,26 +147,24 @@ void eth_get_protocols(const struct iovec *iov, int iovcnt,
 {
     int proto;
     bool fragment = false;
-    size_t l2hdr_len = eth_get_l2_hdr_length_iov(iov, iovcnt);
     size_t input_size = iov_size(iov, iovcnt);
     size_t copied;
     uint8_t ip_p;
 
     *hasip4 = *hasip6 = false;
+    *l3hdr_off = iovoff + eth_get_l2_hdr_length_iov(iov, iovcnt, iovoff);
     l4hdr_info->proto = ETH_L4_HDR_PROTO_INVALID;
 
-    proto = eth_get_l3_proto(iov, iovcnt, l2hdr_len);
-
-    *l3hdr_off = l2hdr_len;
+    proto = eth_get_l3_proto(iov, iovcnt, *l3hdr_off);
 
     if (proto == ETH_P_IP) {
         struct ip_header *iphdr = &ip4hdr_info->ip4_hdr;
 
-        if (input_size < l2hdr_len) {
+        if (input_size < *l3hdr_off) {
             return;
         }
 
-        copied = iov_to_buf(iov, iovcnt, l2hdr_len, iphdr, sizeof(*iphdr));
+        copied = iov_to_buf(iov, iovcnt, *l3hdr_off, iphdr, sizeof(*iphdr));
         if (copied < sizeof(*iphdr) ||
             IP_HEADER_VERSION(iphdr) != IP_HEADER_VERSION_4) {
             return;
@@ -175,17 +173,17 @@ void eth_get_protocols(const struct iovec *iov, int iovcnt,
         *hasip4 = true;
         ip_p = iphdr->ip_p;
         ip4hdr_info->fragment = IP4_IS_FRAGMENT(iphdr);
-        *l4hdr_off = l2hdr_len + IP_HDR_GET_LEN(iphdr);
+        *l4hdr_off = *l3hdr_off + IP_HDR_GET_LEN(iphdr);
 
         fragment = ip4hdr_info->fragment;
     } else if (proto == ETH_P_IPV6) {
-        if (!eth_parse_ipv6_hdr(iov, iovcnt, l2hdr_len, ip6hdr_info)) {
+        if (!eth_parse_ipv6_hdr(iov, iovcnt, *l3hdr_off, ip6hdr_info)) {
             return;
         }
 
         *hasip6 = true;
         ip_p = ip6hdr_info->l4proto;
-        *l4hdr_off = l2hdr_len + ip6hdr_info->full_hdr_len;
+        *l4hdr_off = *l3hdr_off + ip6hdr_info->full_hdr_len;
         fragment = ip6hdr_info->fragment;
     } else {
         return;
-- 
2.7.4


