Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F4B71382C
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 09:00:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3ALd-0006T2-8L; Sun, 28 May 2023 02:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q3ALM-0006Lz-Me; Sun, 28 May 2023 02:57:35 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q3ALK-0001bi-4Y; Sun, 28 May 2023 02:57:31 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9E8988DFD;
 Sun, 28 May 2023 09:57:16 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 3A4A97E1D;
 Sun, 28 May 2023 09:57:16 +0300 (MSK)
Received: (nullmailer pid 42066 invoked by uid 1000);
 Sun, 28 May 2023 06:57:15 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.1 65/73] net/net_rx_pkt: Use iovec for
 net_rx_pkt_set_protocols()
Date: Sun, 28 May 2023 09:57:03 +0300
Message-Id: <20230528065714.42005-6-mjt@tls.msk.ru>
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

igb does not properly ensure the buffer passed to
net_rx_pkt_set_protocols() is contiguous for the entire L2/L3/L4 header.
Allow it to pass scattered data to net_rx_pkt_set_protocols().

Fixes: 3a977deebe ("Intrdocue igb device emulation")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit 2f0fa232b8c330df029120a6824c8be3d4eb5cae)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index e0ee70d1d7..adcb8ac6f3 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -1649,7 +1649,7 @@ igb_receive_internal(IGBCore *core, const struct iovec *iov, int iovcnt,
 
     ehdr = PKT_GET_ETH_HDR(filter_buf);
     net_rx_pkt_set_packet_type(core->rx_pkt, get_eth_packet_type(ehdr));
-    net_rx_pkt_set_protocols(core->rx_pkt, filter_buf, size);
+    net_rx_pkt_set_protocols(core->rx_pkt, iov, iovcnt, iov_ofs);
 
     queues = igb_receive_assign(core, ehdr, size, &rss_info, external_tx);
     if (!queues) {
diff --git a/hw/net/net_rx_pkt.c b/hw/net/net_rx_pkt.c
index 39cdea06de..63be6e05ad 100644
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
index d00b484900..a06f5c2675 100644
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
index 4ea33b6e2e..af1e89706c 100644
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
index f7b874c139..cb52db96a2 100644
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
index c5ae4493b4..9f19c3a695 100644
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
index 70bcd8e355..d7b30df79f 100644
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
2.39.2


