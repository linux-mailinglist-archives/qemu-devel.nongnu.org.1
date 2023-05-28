Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BD271383A
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 09:02:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3AOW-0004kP-FE; Sun, 28 May 2023 03:00:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q3ANY-0004C8-7A; Sun, 28 May 2023 02:59:48 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q3ANW-0001q2-5R; Sun, 28 May 2023 02:59:47 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 18CEF8E1F;
 Sun, 28 May 2023 09:59:41 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id A641F7E29;
 Sun, 28 May 2023 09:59:40 +0300 (MSK)
Received: (nullmailer pid 42622 invoked by uid 1000);
 Sun, 28 May 2023 06:59:40 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.3 48/53] e1000x: Fix BPRC and MPRC
Date: Sun, 28 May 2023 09:59:21 +0300
Message-Id: <20230528065940.42582-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.3-20230528095720@cover.tls.msk.ru>
References: <qemu-stable-7.2.3-20230528095720@cover.tls.msk.ru>
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

Before this change, e1000 and the common code updated BPRC and MPRC
depending on the matched filter, but e1000e and igb decided to update
those counters by deriving the packet type independently. This
inconsistency caused a multicast packet to be counted twice.

Updating BPRC and MPRC depending on are fundamentally flawed anyway as
a filter can be used for different types of packets. For example, it is
possible to filter broadcast packets with MTA.

Always determine what counters to update by inspecting the packets.

Fixes: 3b27430177 ("e1000: Implementing various counters")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit f3f9b726afba1f53663768603189e574f80b5907)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: removed hw/net/igb_core.c bits: igb introduced past 7.2)

diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index 0dfdf47313..81354ef9e3 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -818,12 +818,10 @@ receive_filter(E1000State *s, const uint8_t *buf, int size)
     }
 
     if (ismcast && (rctl & E1000_RCTL_MPE)) {          /* promiscuous mcast */
-        e1000x_inc_reg_if_not_full(s->mac_reg, MPRC);
         return 1;
     }
 
     if (isbcast && (rctl & E1000_RCTL_BAM)) {          /* broadcast enabled */
-        e1000x_inc_reg_if_not_full(s->mac_reg, BPRC);
         return 1;
     }
 
@@ -914,6 +912,7 @@ e1000_receive_iov(NetClientState *nc, const struct iovec *iov, int iovcnt)
     size_t desc_offset;
     size_t desc_size;
     size_t total_size;
+    eth_pkt_types_e pkt_type;
 
     if (!e1000x_hw_rx_enabled(s->mac_reg)) {
         return -1;
@@ -963,6 +962,7 @@ e1000_receive_iov(NetClientState *nc, const struct iovec *iov, int iovcnt)
         size -= 4;
     }
 
+    pkt_type = get_eth_packet_type(PKT_GET_ETH_HDR(filter_buf));
     rdh_start = s->mac_reg[RDH];
     desc_offset = 0;
     total_size = size + e1000x_fcs_len(s->mac_reg);
@@ -1028,7 +1028,7 @@ e1000_receive_iov(NetClientState *nc, const struct iovec *iov, int iovcnt)
         }
     } while (desc_offset < total_size);
 
-    e1000x_update_rx_total_stats(s->mac_reg, size, total_size);
+    e1000x_update_rx_total_stats(s->mac_reg, pkt_type, size, total_size);
 
     n = E1000_ICS_RXT0;
     if ((rdt = s->mac_reg[RDT]) < s->mac_reg[RDH])
diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index c71d82ce1d..879f0387f2 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -1470,24 +1470,10 @@ e1000e_write_to_rx_buffers(E1000ECore *core,
 }
 
 static void
-e1000e_update_rx_stats(E1000ECore *core,
-                       size_t data_size,
-                       size_t data_fcs_size)
+e1000e_update_rx_stats(E1000ECore *core, size_t pkt_size, size_t pkt_fcs_size)
 {
-    e1000x_update_rx_total_stats(core->mac, data_size, data_fcs_size);
-
-    switch (net_rx_pkt_get_packet_type(core->rx_pkt)) {
-    case ETH_PKT_BCAST:
-        e1000x_inc_reg_if_not_full(core->mac, BPRC);
-        break;
-
-    case ETH_PKT_MCAST:
-        e1000x_inc_reg_if_not_full(core->mac, MPRC);
-        break;
-
-    default:
-        break;
-    }
+    eth_pkt_types_e pkt_type = net_rx_pkt_get_packet_type(core->rx_pkt);
+    e1000x_update_rx_total_stats(core->mac, pkt_type, pkt_size, pkt_fcs_size);
 }
 
 static inline bool
diff --git a/hw/net/e1000x_common.c b/hw/net/e1000x_common.c
index 3fdc34f753..e3d2c4277d 100644
--- a/hw/net/e1000x_common.c
+++ b/hw/net/e1000x_common.c
@@ -77,7 +77,6 @@ bool e1000x_rx_group_filter(uint32_t *mac, const uint8_t *buf)
     f = mta_shift[(rctl >> E1000_RCTL_MO_SHIFT) & 3];
     f = (((buf[5] << 8) | buf[4]) >> f) & 0xfff;
     if (mac[MTA + (f >> 5)] & (1 << (f & 0x1f))) {
-        e1000x_inc_reg_if_not_full(mac, MPRC);
         return true;
     }
 
@@ -209,13 +208,14 @@ e1000x_rxbufsize(uint32_t rctl)
 
 void
 e1000x_update_rx_total_stats(uint32_t *mac,
-                             size_t data_size,
-                             size_t data_fcs_size)
+                             eth_pkt_types_e pkt_type,
+                             size_t pkt_size,
+                             size_t pkt_fcs_size)
 {
     static const int PRCregs[6] = { PRC64, PRC127, PRC255, PRC511,
                                     PRC1023, PRC1522 };
 
-    e1000x_increase_size_stats(mac, PRCregs, data_fcs_size);
+    e1000x_increase_size_stats(mac, PRCregs, pkt_fcs_size);
     e1000x_inc_reg_if_not_full(mac, TPR);
     e1000x_inc_reg_if_not_full(mac, GPRC);
     /* TOR - Total Octets Received:
@@ -223,8 +223,21 @@ e1000x_update_rx_total_stats(uint32_t *mac,
     * Address> field through the <CRC> field, inclusively.
     * Always include FCS length (4) in size.
     */
-    e1000x_grow_8reg_if_not_full(mac, TORL, data_size + 4);
-    e1000x_grow_8reg_if_not_full(mac, GORCL, data_size + 4);
+    e1000x_grow_8reg_if_not_full(mac, TORL, pkt_size + 4);
+    e1000x_grow_8reg_if_not_full(mac, GORCL, pkt_size + 4);
+
+    switch (pkt_type) {
+    case ETH_PKT_BCAST:
+        e1000x_inc_reg_if_not_full(mac, BPRC);
+        break;
+
+    case ETH_PKT_MCAST:
+        e1000x_inc_reg_if_not_full(mac, MPRC);
+        break;
+
+    default:
+        break;
+    }
 }
 
 void
diff --git a/hw/net/e1000x_common.h b/hw/net/e1000x_common.h
index b7742775c4..148ea3137b 100644
--- a/hw/net/e1000x_common.h
+++ b/hw/net/e1000x_common.h
@@ -165,8 +165,9 @@ e1000x_update_regs_on_link_up(uint32_t *mac, uint16_t *phy)
 }
 
 void e1000x_update_rx_total_stats(uint32_t *mac,
-                                  size_t data_size,
-                                  size_t data_fcs_size);
+                                  eth_pkt_types_e pkt_type,
+                                  size_t pkt_size,
+                                  size_t pkt_fcs_size);
 
 void e1000x_core_prepare_eeprom(uint16_t       *eeprom,
                                 const uint16_t *templ,
-- 
2.39.2


