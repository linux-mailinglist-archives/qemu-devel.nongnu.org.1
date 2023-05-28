Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D9E713830
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 09:01:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3ALW-0006Qw-FE; Sun, 28 May 2023 02:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q3ALP-0006ML-4f; Sun, 28 May 2023 02:57:36 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q3ALN-0001cH-Ad; Sun, 28 May 2023 02:57:34 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 03E718DFF;
 Sun, 28 May 2023 09:57:17 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 8008D7E1F;
 Sun, 28 May 2023 09:57:16 +0300 (MSK)
Received: (nullmailer pid 42072 invoked by uid 1000);
 Sun, 28 May 2023 06:57:15 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.1 67/73] igb: Always copy ethernet header
Date: Sun, 28 May 2023 09:57:05 +0300
Message-Id: <20230528065714.42005-8-mjt@tls.msk.ru>
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

igb_receive_internal() used to check the iov length to determine
copy the iovs to a contiguous buffer, but the check is flawed in two
ways:
- It does not ensure that iovcnt > 0.
- It does not take virtio-net header into consideration.

The size of this copy is just 22 octets, which can be even less than
the code size required for checks. This (wrong) optimization is probably
not worth so just remove it. Removing this also allows igb to assume
aligned accesses for the ethernet header.

Fixes: 3a977deebe ("Intrdocue igb device emulation")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit dc9ef1bf454811646b3ee6387f1b96f63f538a18)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index adcb8ac6f3..ce2f2186ab 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -67,6 +67,11 @@ typedef struct IGBTxPktVmdqCallbackContext {
     NetClientState *nc;
 } IGBTxPktVmdqCallbackContext;
 
+typedef struct L2Header {
+    struct eth_header eth;
+    struct vlan_header vlan;
+} L2Header;
+
 static ssize_t
 igb_receive_internal(IGBCore *core, const struct iovec *iov, int iovcnt,
                      bool has_vnet, bool *external_tx);
@@ -960,15 +965,16 @@ igb_rx_is_oversized(IGBCore *core, uint16_t qn, size_t size)
     return size > (lpe ? max_ethernet_lpe_size : max_ethernet_vlan_size);
 }
 
-static uint16_t igb_receive_assign(IGBCore *core, const struct eth_header *ehdr,
+static uint16_t igb_receive_assign(IGBCore *core, const L2Header *l2_header,
                                    size_t size, E1000E_RSSInfo *rss_info,
                                    bool *external_tx)
 {
     static const int ta_shift[] = { 4, 3, 2, 0 };
+    const struct eth_header *ehdr = &l2_header->eth;
     uint32_t f, ra[2], *macp, rctl = core->mac[RCTL];
     uint16_t queues = 0;
     uint16_t oversized = 0;
-    uint16_t vid = lduw_be_p(&PKT_GET_VLAN_HDR(ehdr)->h_tci) & VLAN_VID_MASK;
+    uint16_t vid = be16_to_cpu(l2_header->vlan.h_tci) & VLAN_VID_MASK;
     bool accepted = false;
     int i;
 
@@ -1589,14 +1595,13 @@ static ssize_t
 igb_receive_internal(IGBCore *core, const struct iovec *iov, int iovcnt,
                      bool has_vnet, bool *external_tx)
 {
-    static const int maximum_ethernet_hdr_len = (ETH_HLEN + 4);
-
     uint16_t queues = 0;
     uint32_t n = 0;
-    uint8_t min_buf[ETH_ZLEN];
+    union {
+        L2Header l2_header;
+        uint8_t octets[ETH_ZLEN];
+    } buf;
     struct iovec min_iov;
-    struct eth_header *ehdr;
-    uint8_t *filter_buf;
     size_t size, orig_size;
     size_t iov_ofs = 0;
     E1000E_RxRing rxr;
@@ -1622,24 +1627,21 @@ igb_receive_internal(IGBCore *core, const struct iovec *iov, int iovcnt,
         net_rx_pkt_unset_vhdr(core->rx_pkt);
     }
 
-    filter_buf = iov->iov_base + iov_ofs;
     orig_size = iov_size(iov, iovcnt);
     size = orig_size - iov_ofs;
 
     /* Pad to minimum Ethernet frame length */
-    if (size < sizeof(min_buf)) {
-        iov_to_buf(iov, iovcnt, iov_ofs, min_buf, size);
-        memset(&min_buf[size], 0, sizeof(min_buf) - size);
+    if (size < sizeof(buf)) {
+        iov_to_buf(iov, iovcnt, iov_ofs, &buf, size);
+        memset(&buf.octets[size], 0, sizeof(buf) - size);
         e1000x_inc_reg_if_not_full(core->mac, RUC);
-        min_iov.iov_base = filter_buf = min_buf;
-        min_iov.iov_len = size = sizeof(min_buf);
+        min_iov.iov_base = &buf;
+        min_iov.iov_len = size = sizeof(buf);
         iovcnt = 1;
         iov = &min_iov;
         iov_ofs = 0;
-    } else if (iov->iov_len < maximum_ethernet_hdr_len) {
-        /* This is very unlikely, but may happen. */
-        iov_to_buf(iov, iovcnt, iov_ofs, min_buf, maximum_ethernet_hdr_len);
-        filter_buf = min_buf;
+    } else {
+        iov_to_buf(iov, iovcnt, iov_ofs, &buf, sizeof(buf.l2_header));
     }
 
     /* Discard oversized packets if !LPE and !SBP. */
@@ -1647,11 +1649,12 @@ igb_receive_internal(IGBCore *core, const struct iovec *iov, int iovcnt,
         return orig_size;
     }
 
-    ehdr = PKT_GET_ETH_HDR(filter_buf);
-    net_rx_pkt_set_packet_type(core->rx_pkt, get_eth_packet_type(ehdr));
+    net_rx_pkt_set_packet_type(core->rx_pkt,
+                               get_eth_packet_type(&buf.l2_header.eth));
     net_rx_pkt_set_protocols(core->rx_pkt, iov, iovcnt, iov_ofs);
 
-    queues = igb_receive_assign(core, ehdr, size, &rss_info, external_tx);
+    queues = igb_receive_assign(core, &buf.l2_header, size,
+                                &rss_info, external_tx);
     if (!queues) {
         trace_e1000e_rx_flt_dropped();
         return orig_size;
-- 
2.39.2


