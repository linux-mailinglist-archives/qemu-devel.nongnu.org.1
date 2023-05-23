Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8457970D537
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 09:36:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1MYg-0006CX-7b; Tue, 23 May 2023 03:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MXs-0004VW-8M
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:35:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MXn-0004S9-EP
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:34:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684827293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cwvtYIEhjYI9TIuvihqXAIyoLXdirYbBA12bRZoQido=;
 b=VIplf5T6O6S/kpEn3hHfLJA+A7fmUcaA3JwYADOCWcdx34eluNA7UMQUJBuV+zG8xF6G4f
 D2FWiyx8KSZdA1pH8Grzre5HnWUqheRCT2E/xqkYS6ktnetBFg48svwDbDWo+1t8S3Bzm7
 510aD895AIZWmRDSEUh0lDklK/eC70k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657--GwXPskKNxSCjhH7nj9EMQ-1; Tue, 23 May 2023 03:34:50 -0400
X-MC-Unique: -GwXPskKNxSCjhH7nj9EMQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C3459811E8E;
 Tue, 23 May 2023 07:34:49 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-45.pek2.redhat.com [10.72.12.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CB58F2166B25;
 Tue, 23 May 2023 07:34:46 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 42/50] igb: Implement Rx PTP2 timestamp
Date: Tue, 23 May 2023 15:32:30 +0800
Message-Id: <20230523073238.54236-43-jasowang@redhat.com>
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

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/igb_common.h |  16 ++++---
 hw/net/igb_core.c   | 129 ++++++++++++++++++++++++++++++++++++++--------------
 hw/net/igb_regs.h   |  23 ++++++++++
 3 files changed, 127 insertions(+), 41 deletions(-)

diff --git a/hw/net/igb_common.h b/hw/net/igb_common.h
index f2a9065..5c261ba 100644
--- a/hw/net/igb_common.h
+++ b/hw/net/igb_common.h
@@ -51,7 +51,7 @@
                    defreg_indexeda(x, 0), defreg_indexeda(x, 1), \
                    defreg_indexeda(x, 2), defreg_indexeda(x, 3)
 
-#define defregv(x) defreg_indexed(x, 0), defreg_indexed(x, 1),   \
+#define defreg8(x) defreg_indexed(x, 0), defreg_indexed(x, 1),   \
                    defreg_indexed(x, 2), defreg_indexed(x, 3),   \
                    defreg_indexed(x, 4), defreg_indexed(x, 5),   \
                    defreg_indexed(x, 6), defreg_indexed(x, 7)
@@ -122,6 +122,8 @@ enum {
     defreg(EICS),        defreg(EIMS),        defreg(EIMC),       defreg(EIAM),
     defreg(EICR),        defreg(IVAR_MISC),   defreg(GPIE),
 
+    defreg(TSYNCRXCFG), defreg8(ETQF),
+
     defreg(RXPBS),      defregd(RDBAL),       defregd(RDBAH),     defregd(RDLEN),
     defregd(SRRCTL),    defregd(RDH),         defregd(RDT),
     defregd(RXDCTL),    defregd(RXCTL),       defregd(RQDPC),     defreg(RA2),
@@ -133,15 +135,15 @@ enum {
 
     defreg(VT_CTL),
 
-    defregv(P2VMAILBOX), defregv(V2PMAILBOX), defreg(MBVFICR),    defreg(MBVFIMR),
+    defreg8(P2VMAILBOX), defreg8(V2PMAILBOX), defreg(MBVFICR),    defreg(MBVFIMR),
     defreg(VFLRE),       defreg(VFRE),        defreg(VFTE),       defreg(WVBR),
     defreg(QDE),         defreg(DTXSWC),      defreg_indexed(VLVF, 0),
-    defregv(VMOLR),      defreg(RPLOLR),      defregv(VMBMEM),    defregv(VMVIR),
+    defreg8(VMOLR),      defreg(RPLOLR),      defreg8(VMBMEM),    defreg8(VMVIR),
 
-    defregv(PVTCTRL),    defregv(PVTEICS),    defregv(PVTEIMS),   defregv(PVTEIMC),
-    defregv(PVTEIAC),    defregv(PVTEIAM),    defregv(PVTEICR),   defregv(PVFGPRC),
-    defregv(PVFGPTC),    defregv(PVFGORC),    defregv(PVFGOTC),   defregv(PVFMPRC),
-    defregv(PVFGPRLBC),  defregv(PVFGPTLBC),  defregv(PVFGORLBC), defregv(PVFGOTLBC),
+    defreg8(PVTCTRL),    defreg8(PVTEICS),    defreg8(PVTEIMS),   defreg8(PVTEIMC),
+    defreg8(PVTEIAC),    defreg8(PVTEIAM),    defreg8(PVTEICR),   defreg8(PVFGPRC),
+    defreg8(PVFGPTC),    defreg8(PVFGORC),    defreg8(PVFGOTC),   defreg8(PVFMPRC),
+    defreg8(PVFGPRLBC),  defreg8(PVFGPTLBC),  defreg8(PVFGORLBC), defreg8(PVFGOTLBC),
 
     defreg(MTA_A),
 
diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index c04ec01..43d23c7 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -72,6 +72,24 @@ typedef struct L2Header {
     struct vlan_header vlan[2];
 } L2Header;
 
+typedef struct PTP2 {
+    uint8_t message_id_transport_specific;
+    uint8_t version_ptp;
+    uint16_t message_length;
+    uint8_t subdomain_number;
+    uint8_t reserved0;
+    uint16_t flags;
+    uint64_t correction;
+    uint8_t reserved1[5];
+    uint8_t source_communication_technology;
+    uint32_t source_uuid_lo;
+    uint16_t source_uuid_hi;
+    uint16_t source_port_id;
+    uint16_t sequence_id;
+    uint8_t control;
+    uint8_t log_message_period;
+} PTP2;
+
 static ssize_t
 igb_receive_internal(IGBCore *core, const struct iovec *iov, int iovcnt,
                      bool has_vnet, bool *external_tx);
@@ -989,9 +1007,11 @@ static bool igb_rx_is_oversized(IGBCore *core, const struct eth_header *ehdr,
     return lpe ? size + ETH_FCS_LEN > rlpml : size > header_size + ETH_MTU;
 }
 
-static uint16_t igb_receive_assign(IGBCore *core, const L2Header *l2_header,
-                                   size_t size, E1000E_RSSInfo *rss_info,
-                                   bool *external_tx)
+static uint16_t igb_receive_assign(IGBCore *core, const struct iovec *iov,
+                                   size_t iovcnt, size_t iov_ofs,
+                                   const L2Header *l2_header, size_t size,
+                                   E1000E_RSSInfo *rss_info,
+                                   uint16_t *etqf, bool *ts, bool *external_tx)
 {
     static const int ta_shift[] = { 4, 3, 2, 0 };
     const struct eth_header *ehdr = &l2_header->eth;
@@ -999,11 +1019,13 @@ static uint16_t igb_receive_assign(IGBCore *core, const L2Header *l2_header,
     uint16_t queues = 0;
     uint16_t oversized = 0;
     size_t vlan_num = 0;
+    PTP2 ptp2;
     bool lpe;
     uint16_t rlpml;
     int i;
 
     memset(rss_info, 0, sizeof(E1000E_RSSInfo));
+    *ts = false;
 
     if (external_tx) {
         *external_tx = true;
@@ -1028,6 +1050,26 @@ static uint16_t igb_receive_assign(IGBCore *core, const L2Header *l2_header,
         return queues;
     }
 
+    for (*etqf = 0; *etqf < 8; (*etqf)++) {
+        if ((core->mac[ETQF0 + *etqf] & E1000_ETQF_FILTER_ENABLE) &&
+            be16_to_cpu(ehdr->h_proto) == (core->mac[ETQF0 + *etqf] & E1000_ETQF_ETYPE_MASK)) {
+            if ((core->mac[ETQF0 + *etqf] & E1000_ETQF_1588) &&
+                (core->mac[TSYNCRXCTL] & E1000_TSYNCRXCTL_ENABLED) &&
+                !(core->mac[TSYNCRXCTL] & E1000_TSYNCRXCTL_VALID) &&
+                iov_to_buf(iov, iovcnt, iov_ofs + ETH_HLEN, &ptp2, sizeof(ptp2)) >= sizeof(ptp2) &&
+                (ptp2.version_ptp & 15) == 2 &&
+                ptp2.message_id_transport_specific == ((core->mac[TSYNCRXCFG] >> 8) & 255)) {
+                e1000x_timestamp(core->mac, core->timadj, RXSTMPL, RXSTMPH);
+                *ts = true;
+                core->mac[TSYNCRXCTL] |= E1000_TSYNCRXCTL_VALID;
+                core->mac[RXSATRL] = le32_to_cpu(ptp2.source_uuid_lo);
+                core->mac[RXSATRH] = le16_to_cpu(ptp2.source_uuid_hi) |
+                                     (le16_to_cpu(ptp2.sequence_id) << 16);
+            }
+            break;
+        }
+    }
+
     if (vlan_num &&
         !e1000x_rx_vlan_filter(core->mac, l2_header->vlan + vlan_num - 1)) {
         return queues;
@@ -1238,7 +1280,7 @@ static void
 igb_build_rx_metadata(IGBCore *core,
                       struct NetRxPkt *pkt,
                       bool is_eop,
-                      const E1000E_RSSInfo *rss_info,
+                      const E1000E_RSSInfo *rss_info, uint16_t etqf, bool ts,
                       uint16_t *pkt_info, uint16_t *hdr_info,
                       uint32_t *rss,
                       uint32_t *status_flags,
@@ -1289,29 +1331,33 @@ igb_build_rx_metadata(IGBCore *core,
     if (pkt_info) {
         *pkt_info = rss_info->enabled ? rss_info->type : 0;
 
-        if (hasip4) {
-            *pkt_info |= E1000_ADVRXD_PKT_IP4;
-        }
+        if (etqf < 8) {
+            *pkt_info |= (BIT(11) | etqf) << 4;
+        } else {
+            if (hasip4) {
+                *pkt_info |= E1000_ADVRXD_PKT_IP4;
+            }
 
-        if (hasip6) {
-            *pkt_info |= E1000_ADVRXD_PKT_IP6;
-        }
+            if (hasip6) {
+                *pkt_info |= E1000_ADVRXD_PKT_IP6;
+            }
 
-        switch (l4hdr_proto) {
-        case ETH_L4_HDR_PROTO_TCP:
-            *pkt_info |= E1000_ADVRXD_PKT_TCP;
-            break;
+            switch (l4hdr_proto) {
+            case ETH_L4_HDR_PROTO_TCP:
+                *pkt_info |= E1000_ADVRXD_PKT_TCP;
+                break;
 
-        case ETH_L4_HDR_PROTO_UDP:
-            *pkt_info |= E1000_ADVRXD_PKT_UDP;
-            break;
+            case ETH_L4_HDR_PROTO_UDP:
+                *pkt_info |= E1000_ADVRXD_PKT_UDP;
+                break;
 
-        case ETH_L4_HDR_PROTO_SCTP:
-            *pkt_info |= E1000_ADVRXD_PKT_SCTP;
-            break;
+            case ETH_L4_HDR_PROTO_SCTP:
+                *pkt_info |= E1000_ADVRXD_PKT_SCTP;
+                break;
 
-        default:
-            break;
+            default:
+                break;
+            }
         }
     }
 
@@ -1319,6 +1365,10 @@ igb_build_rx_metadata(IGBCore *core,
         *hdr_info = 0;
     }
 
+    if (ts) {
+        *status_flags |= BIT(16);
+    }
+
     /* RX CSO information */
     if (hasip6 && (core->mac[RFCTL] & E1000_RFCTL_IPV6_XSUM_DIS)) {
         trace_e1000e_rx_metadata_ipv6_sum_disabled();
@@ -1374,7 +1424,7 @@ func_exit:
 static inline void
 igb_write_lgcy_rx_descr(IGBCore *core, struct e1000_rx_desc *desc,
                         struct NetRxPkt *pkt,
-                        const E1000E_RSSInfo *rss_info,
+                        const E1000E_RSSInfo *rss_info, uint16_t etqf, bool ts,
                         uint16_t length)
 {
     uint32_t status_flags, rss;
@@ -1385,7 +1435,7 @@ igb_write_lgcy_rx_descr(IGBCore *core, struct e1000_rx_desc *desc,
     desc->csum = 0;
 
     igb_build_rx_metadata(core, pkt, pkt != NULL,
-                          rss_info,
+                          rss_info, etqf, ts,
                           NULL, NULL, &rss,
                           &status_flags, &ip_id,
                           &desc->special);
@@ -1396,7 +1446,7 @@ igb_write_lgcy_rx_descr(IGBCore *core, struct e1000_rx_desc *desc,
 static inline void
 igb_write_adv_rx_descr(IGBCore *core, union e1000_adv_rx_desc *desc,
                        struct NetRxPkt *pkt,
-                       const E1000E_RSSInfo *rss_info,
+                       const E1000E_RSSInfo *rss_info, uint16_t etqf, bool ts,
                        uint16_t length)
 {
     memset(&desc->wb, 0, sizeof(desc->wb));
@@ -1404,7 +1454,7 @@ igb_write_adv_rx_descr(IGBCore *core, union e1000_adv_rx_desc *desc,
     desc->wb.upper.length = cpu_to_le16(length);
 
     igb_build_rx_metadata(core, pkt, pkt != NULL,
-                          rss_info,
+                          rss_info, etqf, ts,
                           &desc->wb.lower.lo_dword.pkt_info,
                           &desc->wb.lower.lo_dword.hdr_info,
                           &desc->wb.lower.hi_dword.rss,
@@ -1415,12 +1465,15 @@ igb_write_adv_rx_descr(IGBCore *core, union e1000_adv_rx_desc *desc,
 
 static inline void
 igb_write_rx_descr(IGBCore *core, union e1000_rx_desc_union *desc,
-struct NetRxPkt *pkt, const E1000E_RSSInfo *rss_info, uint16_t length)
+                   struct NetRxPkt *pkt, const E1000E_RSSInfo *rss_info,
+                   uint16_t etqf, bool ts, uint16_t length)
 {
     if (igb_rx_use_legacy_descriptor(core)) {
-        igb_write_lgcy_rx_descr(core, &desc->legacy, pkt, rss_info, length);
+        igb_write_lgcy_rx_descr(core, &desc->legacy, pkt, rss_info,
+                                etqf, ts, length);
     } else {
-        igb_write_adv_rx_descr(core, &desc->adv, pkt, rss_info, length);
+        igb_write_adv_rx_descr(core, &desc->adv, pkt, rss_info,
+                               etqf, ts, length);
     }
 }
 
@@ -1497,7 +1550,8 @@ igb_rx_descr_threshold_hit(IGBCore *core, const E1000E_RingInfo *rxi)
 static void
 igb_write_packet_to_guest(IGBCore *core, struct NetRxPkt *pkt,
                           const E1000E_RxRing *rxr,
-                          const E1000E_RSSInfo *rss_info)
+                          const E1000E_RSSInfo *rss_info,
+                          uint16_t etqf, bool ts)
 {
     PCIDevice *d;
     dma_addr_t base;
@@ -1579,7 +1633,7 @@ igb_write_packet_to_guest(IGBCore *core, struct NetRxPkt *pkt,
         }
 
         igb_write_rx_descr(core, &desc, is_last ? core->rx_pkt : NULL,
-                           rss_info, written);
+                           rss_info, etqf, ts, written);
         igb_pci_dma_write_rx_desc(core, d, base, &desc, core->rx_desc_len);
 
         igb_ring_advance(core, rxi, core->rx_desc_len / E1000_MIN_RX_DESC_LEN);
@@ -1634,6 +1688,8 @@ igb_receive_internal(IGBCore *core, const struct iovec *iov, int iovcnt,
     size_t iov_ofs = 0;
     E1000E_RxRing rxr;
     E1000E_RSSInfo rss_info;
+    uint16_t etqf;
+    bool ts;
     size_t total_size;
     int strip_vlan_index;
     int i;
@@ -1677,8 +1733,9 @@ igb_receive_internal(IGBCore *core, const struct iovec *iov, int iovcnt,
                                get_eth_packet_type(&buf.l2_header.eth));
     net_rx_pkt_set_protocols(core->rx_pkt, iov, iovcnt, iov_ofs);
 
-    queues = igb_receive_assign(core, &buf.l2_header, size,
-                                &rss_info, external_tx);
+    queues = igb_receive_assign(core, iov, iovcnt, iov_ofs,
+                                &buf.l2_header, size,
+                                &rss_info, &etqf, &ts, external_tx);
     if (!queues) {
         trace_e1000e_rx_flt_dropped();
         return orig_size;
@@ -1717,7 +1774,7 @@ igb_receive_internal(IGBCore *core, const struct iovec *iov, int iovcnt,
         causes |= E1000_ICR_RXDW;
 
         igb_rx_fix_l4_csum(core, core->rx_pkt);
-        igb_write_packet_to_guest(core, core->rx_pkt, &rxr, &rss_info);
+        igb_write_packet_to_guest(core, core->rx_pkt, &rxr, &rss_info, etqf, ts);
 
         /* Check if receive descriptor minimum threshold hit */
         if (igb_rx_descr_threshold_hit(core, rxr.i)) {
@@ -3305,6 +3362,8 @@ static const readops igb_macreg_readops[] = {
     [EIAM]       = igb_mac_readreg,
     [IVAR0 ... IVAR0 + 7] = igb_mac_readreg,
     igb_getreg(IVAR_MISC),
+    igb_getreg(TSYNCRXCFG),
+    [ETQF0 ... ETQF0 + 7] = igb_mac_readreg,
     igb_getreg(VT_CTL),
     [P2VMAILBOX0 ... P2VMAILBOX7] = igb_mac_readreg,
     [V2PMAILBOX0 ... V2PMAILBOX7] = igb_mac_vfmailbox_read,
@@ -3712,6 +3771,8 @@ static const writeops igb_macreg_writeops[] = {
     [EIMS] = igb_set_eims,
     [IVAR0 ... IVAR0 + 7] = igb_mac_writereg,
     igb_putreg(IVAR_MISC),
+    igb_putreg(TSYNCRXCFG),
+    [ETQF0 ... ETQF0 + 7] = igb_mac_writereg,
     igb_putreg(VT_CTL),
     [P2VMAILBOX0 ... P2VMAILBOX7] = igb_set_pfmailbox,
     [V2PMAILBOX0 ... V2PMAILBOX7] = igb_set_vfmailbox,
diff --git a/hw/net/igb_regs.h b/hw/net/igb_regs.h
index 4b4ebd3..8947055 100644
--- a/hw/net/igb_regs.h
+++ b/hw/net/igb_regs.h
@@ -210,6 +210,15 @@ union e1000_adv_rx_desc {
 #define E1000_DCA_TXCTRL_CPUID_SHIFT 24 /* Tx CPUID now in the last byte */
 #define E1000_DCA_RXCTRL_CPUID_SHIFT 24 /* Rx CPUID now in the last byte */
 
+/* ETQF register bit definitions */
+#define E1000_ETQF_FILTER_ENABLE   BIT(26)
+#define E1000_ETQF_1588            BIT(30)
+#define E1000_ETQF_IMM_INT         BIT(29)
+#define E1000_ETQF_QUEUE_ENABLE    BIT(31)
+#define E1000_ETQF_QUEUE_SHIFT     16
+#define E1000_ETQF_QUEUE_MASK      0x00070000
+#define E1000_ETQF_ETYPE_MASK      0x0000FFFF
+
 #define E1000_DTXSWC_MAC_SPOOF_MASK   0x000000FF /* Per VF MAC spoof control */
 #define E1000_DTXSWC_VLAN_SPOOF_MASK  0x0000FF00 /* Per VF VLAN spoof control */
 #define E1000_DTXSWC_LLE_MASK         0x00FF0000 /* Per VF Local LB enables */
@@ -384,6 +393,20 @@ union e1000_adv_rx_desc {
 #define E1000_FRTIMER   0x01048  /* Free Running Timer - RW */
 #define E1000_FCRTV     0x02460  /* Flow Control Refresh Timer Value - RW */
 
+#define E1000_TSYNCRXCFG 0x05F50 /* Time Sync Rx Configuration - RW */
+
+/* Filtering Registers */
+#define E1000_SAQF(_n) (0x5980 + 4 * (_n))
+#define E1000_DAQF(_n) (0x59A0 + 4 * (_n))
+#define E1000_SPQF(_n) (0x59C0 + 4 * (_n))
+#define E1000_FTQF(_n) (0x59E0 + 4 * (_n))
+#define E1000_SAQF0 E1000_SAQF(0)
+#define E1000_DAQF0 E1000_DAQF(0)
+#define E1000_SPQF0 E1000_SPQF(0)
+#define E1000_FTQF0 E1000_FTQF(0)
+#define E1000_SYNQF(_n) (0x055FC + (4 * (_n))) /* SYN Packet Queue Fltr */
+#define E1000_ETQF(_n)  (0x05CB0 + (4 * (_n))) /* EType Queue Fltr */
+
 #define E1000_RQDPC(_n) (0x0C030 + ((_n) * 0x40))
 
 #define E1000_RXPBS 0x02404  /* Rx Packet Buffer Size - RW */
-- 
2.7.4


