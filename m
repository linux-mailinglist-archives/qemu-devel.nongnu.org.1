Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A86A70D52B
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 09:35:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1MYN-00051s-PS; Tue, 23 May 2023 03:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MXn-0004Oq-6q
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:34:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MXj-0004Rm-0i
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:34:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684827290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mIAKKQflt7a4dOqAv9tRXzrZFQSXUzGbYsgwEXYf9sI=;
 b=gBWmcqsn8pPAh9j8L+IpSKngYwpoV1+R7/0nghb1ACPW3gEdsDtg3gXPMqwe6KuIhrHfi4
 bLTEVhnXPLn+ZEvhU5BO4z2DjNwbVPiaaSrcYaCm5Ifvzseb1Ls3F3AI3hY2qs7VXDlp2W
 UNfRT6suvykvDuOwJi6kCUOEGbjpapY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-477-KIvvc23lN3KSOdUKhAArZg-1; Tue, 23 May 2023 03:34:46 -0400
X-MC-Unique: KIvvc23lN3KSOdUKhAArZg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 29473101A531;
 Tue, 23 May 2023 07:34:46 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-45.pek2.redhat.com [10.72.12.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9DD7B2166B25;
 Tue, 23 May 2023 07:34:43 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 41/50] igb: Implement igb-specific oversize check
Date: Tue, 23 May 2023 15:32:29 +0800
Message-Id: <20230523073238.54236-42-jasowang@redhat.com>
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

igb has a configurable size limit for LPE, and uses different limits
depending on whether the packet is treated as a VLAN packet.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/igb_core.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 5345f57..c04ec01 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -980,16 +980,13 @@ igb_rx_l4_cso_enabled(IGBCore *core)
     return !!(core->mac[RXCSUM] & E1000_RXCSUM_TUOFLD);
 }
 
-static bool
-igb_rx_is_oversized(IGBCore *core, uint16_t qn, size_t size)
+static bool igb_rx_is_oversized(IGBCore *core, const struct eth_header *ehdr,
+                                size_t size, size_t vlan_num,
+                                bool lpe, uint16_t rlpml)
 {
-    uint16_t pool = qn % IGB_NUM_VM_POOLS;
-    bool lpe = !!(core->mac[VMOLR0 + pool] & E1000_VMOLR_LPE);
-    int max_ethernet_lpe_size =
-        core->mac[VMOLR0 + pool] & E1000_VMOLR_RLPML_MASK;
-    int max_ethernet_vlan_size = 1522;
-
-    return size > (lpe ? max_ethernet_lpe_size : max_ethernet_vlan_size);
+    size_t vlan_header_size = sizeof(struct vlan_header) * vlan_num;
+    size_t header_size = sizeof(struct eth_header) + vlan_header_size;
+    return lpe ? size + ETH_FCS_LEN > rlpml : size > header_size + ETH_MTU;
 }
 
 static uint16_t igb_receive_assign(IGBCore *core, const L2Header *l2_header,
@@ -1002,6 +999,8 @@ static uint16_t igb_receive_assign(IGBCore *core, const L2Header *l2_header,
     uint16_t queues = 0;
     uint16_t oversized = 0;
     size_t vlan_num = 0;
+    bool lpe;
+    uint16_t rlpml;
     int i;
 
     memset(rss_info, 0, sizeof(E1000E_RSSInfo));
@@ -1021,6 +1020,14 @@ static uint16_t igb_receive_assign(IGBCore *core, const L2Header *l2_header,
         }
     }
 
+    lpe = !!(core->mac[RCTL] & E1000_RCTL_LPE);
+    rlpml = core->mac[RLPML];
+    if (!(core->mac[RCTL] & E1000_RCTL_SBP) &&
+        igb_rx_is_oversized(core, ehdr, size, vlan_num, lpe, rlpml)) {
+        trace_e1000x_rx_oversized(size);
+        return queues;
+    }
+
     if (vlan_num &&
         !e1000x_rx_vlan_filter(core->mac, l2_header->vlan + vlan_num - 1)) {
         return queues;
@@ -1106,7 +1113,11 @@ static uint16_t igb_receive_assign(IGBCore *core, const L2Header *l2_header,
         queues &= core->mac[VFRE];
         if (queues) {
             for (i = 0; i < IGB_NUM_VM_POOLS; i++) {
-                if ((queues & BIT(i)) && igb_rx_is_oversized(core, i, size)) {
+                lpe = !!(core->mac[VMOLR0 + i] & E1000_VMOLR_LPE);
+                rlpml = core->mac[VMOLR0 + i] & E1000_VMOLR_RLPML_MASK;
+                if ((queues & BIT(i)) &&
+                    igb_rx_is_oversized(core, ehdr, size, vlan_num,
+                                        lpe, rlpml)) {
                     oversized |= BIT(i);
                 }
             }
@@ -1662,11 +1673,6 @@ igb_receive_internal(IGBCore *core, const struct iovec *iov, int iovcnt,
         iov_to_buf(iov, iovcnt, iov_ofs, &buf, sizeof(buf.l2_header));
     }
 
-    /* Discard oversized packets if !LPE and !SBP. */
-    if (e1000x_is_oversized(core->mac, size)) {
-        return orig_size;
-    }
-
     net_rx_pkt_set_packet_type(core->rx_pkt,
                                get_eth_packet_type(&buf.l2_header.eth));
     net_rx_pkt_set_protocols(core->rx_pkt, iov, iovcnt, iov_ofs);
-- 
2.7.4


