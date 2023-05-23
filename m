Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF3570D552
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 09:38:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1MWH-0008I0-4O; Tue, 23 May 2023 03:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MWE-0008AB-I7
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:33:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MWC-0004CE-SQ
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:33:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684827196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jVPy+tHzfqhGk/2yjzWqCJOji3iyN1rObI85wWsPVCc=;
 b=RRtRqqi3NizHj4VLafkXULZXOTLDJGPZ53hquEMVvSuEduh37F1YlcOMwt6Sj2wWrckLT9
 QKIAofDkj2b1k57eRQvaO5XPxe4o/VZ/dEjQPyHKY9SxoMcGn5Giv1Is+N6IjbTQNTMQ3H
 7GRGBgST3yBkxTwvjo/M7iEh9ycQ5FI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-9yD0jRQFN4W3YDSRqojWpQ-1; Tue, 23 May 2023 03:33:13 -0400
X-MC-Unique: 9yD0jRQFN4W3YDSRqojWpQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 86FF7800B2A;
 Tue, 23 May 2023 07:33:13 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-45.pek2.redhat.com [10.72.12.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 319C22166B25;
 Tue, 23 May 2023 07:33:10 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 10/50] igb: Always copy ethernet header
Date: Tue, 23 May 2023 15:31:58 +0800
Message-Id: <20230523073238.54236-11-jasowang@redhat.com>
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
---
 hw/net/igb_core.c | 43 +++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 21a8d9a..1123df9 100644
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
@@ -961,15 +966,16 @@ igb_rx_is_oversized(IGBCore *core, uint16_t qn, size_t size)
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
 
@@ -1590,14 +1596,13 @@ static ssize_t
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
@@ -1623,24 +1628,21 @@ igb_receive_internal(IGBCore *core, const struct iovec *iov, int iovcnt,
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
@@ -1648,11 +1650,12 @@ igb_receive_internal(IGBCore *core, const struct iovec *iov, int iovcnt,
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
2.7.4


