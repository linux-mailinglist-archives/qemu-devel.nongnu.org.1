Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CF97A44D6
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 10:35:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi9gL-0006Ll-8H; Mon, 18 Sep 2023 04:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qi9fz-00062i-QM
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 04:32:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qi9fu-0004BE-4n
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 04:32:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695025929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6FD7y3TU1QjQM91sGPYItUQOmOAr6mnYmjdm4KZsWd0=;
 b=LvnMSdl5AjrFZgSB5inumHRJg+Nmlsue/lMNIVqZlV1vaKsMz8I1APZSJqRCYd6jVNkHJX
 21aDINVNHXCJI7IXtEmST/sfPIkku+7tsVoZ/Q1fhiHBbDGs30yOeqrxDXLHTaG7S45ABy
 jIy/5ST8HuS0lIDMmT7Um2znkijSA2A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-503-aocsSZ7POKSH7ZEZD6QrBw-1; Mon, 18 Sep 2023 04:32:06 -0400
X-MC-Unique: aocsSZ7POKSH7ZEZD6QrBw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 54763101A550;
 Mon, 18 Sep 2023 08:32:06 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.113.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 428C62156A27;
 Mon, 18 Sep 2023 08:32:02 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tomasz Dzieciol <t.dzieciol@partner.samsung.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL V2 10/17] igb: packet-split descriptors support
Date: Mon, 18 Sep 2023 16:31:25 +0800
Message-Id: <20230918083132.55423-11-jasowang@redhat.com>
In-Reply-To: <20230918083132.55423-1-jasowang@redhat.com>
References: <20230918083132.55423-1-jasowang@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Tomasz Dzieciol <t.dzieciol@partner.samsung.com>

Packet-split descriptors are used by Linux VF driver for MTU values from 2048

Signed-off-by: Tomasz Dzieciol <t.dzieciol@partner.samsung.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/igb_core.c   | 348 +++++++++++++++++++++++++++++++++++++++++++++-------
 hw/net/igb_regs.h   |   9 ++
 hw/net/trace-events |   2 +-
 3 files changed, 316 insertions(+), 43 deletions(-)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 9f43fe5..f6a5e23 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -267,6 +267,29 @@ igb_rx_use_legacy_descriptor(IGBCore *core)
     return false;
 }
 
+typedef struct E1000ERingInfo {
+    int dbah;
+    int dbal;
+    int dlen;
+    int dh;
+    int dt;
+    int idx;
+} E1000ERingInfo;
+
+static uint32_t
+igb_rx_queue_desctyp_get(IGBCore *core, const E1000ERingInfo *r)
+{
+    return core->mac[E1000_SRRCTL(r->idx) >> 2] & E1000_SRRCTL_DESCTYPE_MASK;
+}
+
+static bool
+igb_rx_use_ps_descriptor(IGBCore *core, const E1000ERingInfo *r)
+{
+    uint32_t desctyp = igb_rx_queue_desctyp_get(core, r);
+    return desctyp == E1000_SRRCTL_DESCTYPE_HDR_SPLIT ||
+           desctyp == E1000_SRRCTL_DESCTYPE_HDR_SPLIT_ALWAYS;
+}
+
 static inline bool
 igb_rss_enabled(IGBCore *core)
 {
@@ -694,15 +717,6 @@ static uint32_t igb_rx_wb_eic(IGBCore *core, int queue_idx)
     return (ent & E1000_IVAR_VALID) ? BIT(ent & 0x1f) : 0;
 }
 
-typedef struct E1000ERingInfo {
-    int dbah;
-    int dbal;
-    int dlen;
-    int dh;
-    int dt;
-    int idx;
-} E1000ERingInfo;
-
 static inline bool
 igb_ring_empty(IGBCore *core, const E1000ERingInfo *r)
 {
@@ -1233,12 +1247,31 @@ igb_read_lgcy_rx_descr(IGBCore *core, struct e1000_rx_desc *desc,
 }
 
 static inline void
-igb_read_adv_rx_descr(IGBCore *core, union e1000_adv_rx_desc *desc,
-                      hwaddr *buff_addr)
+igb_read_adv_rx_single_buf_descr(IGBCore *core, union e1000_adv_rx_desc *desc,
+                                 hwaddr *buff_addr)
 {
     *buff_addr = le64_to_cpu(desc->read.pkt_addr);
 }
 
+static inline void
+igb_read_adv_rx_split_buf_descr(IGBCore *core, union e1000_adv_rx_desc *desc,
+                                hwaddr *buff_addr)
+{
+    buff_addr[0] = le64_to_cpu(desc->read.hdr_addr);
+    buff_addr[1] = le64_to_cpu(desc->read.pkt_addr);
+}
+
+typedef struct IGBBAState {
+    uint16_t written[IGB_MAX_PS_BUFFERS];
+    uint8_t cur_idx;
+} IGBBAState;
+
+typedef struct IGBSplitDescriptorData {
+    bool sph;
+    bool hbo;
+    size_t hdr_len;
+} IGBSplitDescriptorData;
+
 typedef struct IGBPacketRxDMAState {
     size_t size;
     size_t total_size;
@@ -1249,20 +1282,42 @@ typedef struct IGBPacketRxDMAState {
     uint32_t rx_desc_header_buf_size;
     struct iovec *iov;
     size_t iov_ofs;
+    bool do_ps;
     bool is_first;
-    uint16_t written;
-    hwaddr ba;
+    IGBBAState bastate;
+    hwaddr ba[IGB_MAX_PS_BUFFERS];
+    IGBSplitDescriptorData ps_desc_data;
 } IGBPacketRxDMAState;
 
 static inline void
-igb_read_rx_descr(IGBCore *core, union e1000_rx_desc_union *desc,
-                  hwaddr *buff_addr)
+igb_read_rx_descr(IGBCore *core,
+                  union e1000_rx_desc_union *desc,
+                  IGBPacketRxDMAState *pdma_st,
+                  const E1000ERingInfo *r)
 {
+    uint32_t desc_type;
+
     if (igb_rx_use_legacy_descriptor(core)) {
-        igb_read_lgcy_rx_descr(core, &desc->legacy, buff_addr);
-    } else {
-        igb_read_adv_rx_descr(core, &desc->adv, buff_addr);
+        igb_read_lgcy_rx_descr(core, &desc->legacy, &pdma_st->ba[1]);
+        pdma_st->ba[0] = 0;
+        return;
+    }
+
+    /* advanced header split descriptor */
+    if (igb_rx_use_ps_descriptor(core, r)) {
+        igb_read_adv_rx_split_buf_descr(core, &desc->adv, &pdma_st->ba[0]);
+        return;
+    }
+
+    /* descriptor replication modes not supported */
+    desc_type = igb_rx_queue_desctyp_get(core, r);
+    if (desc_type != E1000_SRRCTL_DESCTYPE_ADV_ONEBUF) {
+        trace_igb_wrn_rx_desc_modes_not_supp(desc_type);
     }
+
+    /* advanced single buffer descriptor */
+    igb_read_adv_rx_single_buf_descr(core, &desc->adv, &pdma_st->ba[1]);
+    pdma_st->ba[0] = 0;
 }
 
 static void
@@ -1405,6 +1460,13 @@ igb_write_lgcy_rx_descr(IGBCore *core, struct e1000_rx_desc *desc,
     desc->status = (uint8_t) le32_to_cpu(status_flags);
 }
 
+static bool
+igb_rx_ps_descriptor_split_always(IGBCore *core, const E1000ERingInfo *r)
+{
+    uint32_t desctyp = igb_rx_queue_desctyp_get(core, r);
+    return desctyp == E1000_SRRCTL_DESCTYPE_HDR_SPLIT_ALWAYS;
+}
+
 static uint16_t
 igb_rx_desc_get_packet_type(IGBCore *core, struct NetRxPkt *pkt, uint16_t etqf)
 {
@@ -1495,15 +1557,54 @@ igb_write_adv_rx_descr(IGBCore *core, union e1000_adv_rx_desc *desc,
 }
 
 static inline void
-igb_write_rx_descr(IGBCore *core, union e1000_rx_desc_union *desc,
-                   struct NetRxPkt *pkt, const E1000E_RSSInfo *rss_info,
-                   uint16_t etqf, bool ts, uint16_t length)
+igb_write_adv_ps_rx_descr(IGBCore *core,
+                          union e1000_adv_rx_desc *desc,
+                          struct NetRxPkt *pkt,
+                          const E1000E_RSSInfo *rss_info,
+                          const E1000ERingInfo *r,
+                          uint16_t etqf,
+                          bool ts,
+                          IGBPacketRxDMAState *pdma_st)
+{
+    size_t pkt_len;
+    uint16_t hdr_info = 0;
+
+    if (pdma_st->do_ps) {
+        pkt_len = pdma_st->bastate.written[1];
+    } else {
+        pkt_len = pdma_st->bastate.written[0] + pdma_st->bastate.written[1];
+    }
+
+    igb_write_adv_rx_descr(core, desc, pkt, rss_info, etqf, ts, pkt_len);
+
+    hdr_info = (pdma_st->ps_desc_data.hdr_len << E1000_ADVRXD_HDR_LEN_OFFSET) &
+               E1000_ADVRXD_ADV_HDR_LEN_MASK;
+    hdr_info |= pdma_st->ps_desc_data.sph ? E1000_ADVRXD_HDR_SPH : 0;
+    desc->wb.lower.lo_dword.hdr_info = cpu_to_le16(hdr_info);
+
+    desc->wb.upper.status_error |= cpu_to_le32(
+        pdma_st->ps_desc_data.hbo ? E1000_ADVRXD_ST_ERR_HBO_OFFSET : 0);
+}
+
+static inline void
+igb_write_rx_descr(IGBCore *core,
+                   union e1000_rx_desc_union *desc,
+                   struct NetRxPkt *pkt,
+                   const E1000E_RSSInfo *rss_info,
+                   uint16_t etqf,
+                   bool ts,
+                   IGBPacketRxDMAState *pdma_st,
+                   const E1000ERingInfo *r)
 {
     if (igb_rx_use_legacy_descriptor(core)) {
-        igb_write_lgcy_rx_descr(core, &desc->legacy, pkt, rss_info, length);
+        igb_write_lgcy_rx_descr(core, &desc->legacy, pkt, rss_info,
+                                pdma_st->bastate.written[1]);
+    } else if (igb_rx_use_ps_descriptor(core, r)) {
+        igb_write_adv_ps_rx_descr(core, &desc->adv, pkt, rss_info, r, etqf, ts,
+                                  pdma_st);
     } else {
         igb_write_adv_rx_descr(core, &desc->adv, pkt, rss_info,
-                               etqf, ts, length);
+                               etqf, ts, pdma_st->bastate.written[1]);
     }
 }
 
@@ -1564,26 +1665,179 @@ igb_rx_descr_threshold_hit(IGBCore *core, const E1000ERingInfo *rxi)
            ((core->mac[E1000_SRRCTL(rxi->idx) >> 2] >> 20) & 31) * 16;
 }
 
+static bool
+igb_do_ps(IGBCore *core,
+          const E1000ERingInfo *r,
+          struct NetRxPkt *pkt,
+          IGBPacketRxDMAState *pdma_st)
+{
+    bool hasip4, hasip6;
+    EthL4HdrProto l4hdr_proto;
+    bool fragment;
+    bool split_always;
+    size_t bheader_size;
+    size_t total_pkt_len;
+
+    if (!igb_rx_use_ps_descriptor(core, r)) {
+        return false;
+    }
+
+    total_pkt_len = net_rx_pkt_get_total_len(pkt);
+    bheader_size = igb_rxhdrbufsize(core, r);
+    split_always = igb_rx_ps_descriptor_split_always(core, r);
+    if (split_always && total_pkt_len <= bheader_size) {
+        pdma_st->ps_hdr_len = total_pkt_len;
+        pdma_st->ps_desc_data.hdr_len = total_pkt_len;
+        return true;
+    }
+
+    net_rx_pkt_get_protocols(pkt, &hasip4, &hasip6, &l4hdr_proto);
+
+    if (hasip4) {
+        fragment = net_rx_pkt_get_ip4_info(pkt)->fragment;
+    } else if (hasip6) {
+        fragment = net_rx_pkt_get_ip6_info(pkt)->fragment;
+    } else {
+        pdma_st->ps_desc_data.hdr_len = bheader_size;
+        goto header_not_handled;
+    }
+
+    if (fragment && (core->mac[RFCTL] & E1000_RFCTL_IPFRSP_DIS)) {
+        pdma_st->ps_desc_data.hdr_len = bheader_size;
+        goto header_not_handled;
+    }
+
+    /* no header splitting for SCTP */
+    if (!fragment && (l4hdr_proto == ETH_L4_HDR_PROTO_UDP ||
+                      l4hdr_proto == ETH_L4_HDR_PROTO_TCP)) {
+        pdma_st->ps_hdr_len = net_rx_pkt_get_l5_hdr_offset(pkt);
+    } else {
+        pdma_st->ps_hdr_len = net_rx_pkt_get_l4_hdr_offset(pkt);
+    }
+
+    pdma_st->ps_desc_data.sph = true;
+    pdma_st->ps_desc_data.hdr_len = pdma_st->ps_hdr_len;
+
+    if (pdma_st->ps_hdr_len > bheader_size) {
+        pdma_st->ps_desc_data.hbo = true;
+        goto header_not_handled;
+    }
+
+    return true;
+
+header_not_handled:
+    if (split_always) {
+        pdma_st->ps_hdr_len = bheader_size;
+        return true;
+    }
+
+    return false;
+}
+
 static void
 igb_truncate_to_descriptor_size(IGBPacketRxDMAState *pdma_st, size_t *size)
 {
-    if (*size > pdma_st->rx_desc_packet_buf_size) {
-        *size = pdma_st->rx_desc_packet_buf_size;
+    if (pdma_st->do_ps && pdma_st->is_first) {
+        if (*size > pdma_st->rx_desc_packet_buf_size + pdma_st->ps_hdr_len) {
+            *size = pdma_st->rx_desc_packet_buf_size + pdma_st->ps_hdr_len;
+        }
+    } else {
+        if (*size > pdma_st->rx_desc_packet_buf_size) {
+            *size = pdma_st->rx_desc_packet_buf_size;
+        }
+    }
+}
+
+static inline void
+igb_write_hdr_frag_to_rx_buffers(IGBCore *core,
+                                 PCIDevice *d,
+                                 IGBPacketRxDMAState *pdma_st,
+                                 const char *data,
+                                 dma_addr_t data_len)
+{
+    assert(data_len <= pdma_st->rx_desc_header_buf_size -
+                       pdma_st->bastate.written[0]);
+    pci_dma_write(d,
+                  pdma_st->ba[0] + pdma_st->bastate.written[0],
+                  data, data_len);
+    pdma_st->bastate.written[0] += data_len;
+    pdma_st->bastate.cur_idx = 1;
+}
+
+static void
+igb_write_header_to_rx_buffers(IGBCore *core,
+                               struct NetRxPkt *pkt,
+                               PCIDevice *d,
+                               IGBPacketRxDMAState *pdma_st,
+                               size_t *copy_size)
+{
+    size_t iov_copy;
+    size_t ps_hdr_copied = 0;
+
+    if (!pdma_st->is_first) {
+        /* Leave buffer 0 of each descriptor except first */
+        /* empty                                          */
+        pdma_st->bastate.cur_idx = 1;
+        return;
     }
+
+    do {
+        iov_copy = MIN(pdma_st->ps_hdr_len - ps_hdr_copied,
+                       pdma_st->iov->iov_len - pdma_st->iov_ofs);
+
+        igb_write_hdr_frag_to_rx_buffers(core, d, pdma_st,
+                                         pdma_st->iov->iov_base,
+                                         iov_copy);
+
+        *copy_size -= iov_copy;
+        ps_hdr_copied += iov_copy;
+
+        pdma_st->iov_ofs += iov_copy;
+        if (pdma_st->iov_ofs == pdma_st->iov->iov_len) {
+            pdma_st->iov++;
+            pdma_st->iov_ofs = 0;
+        }
+    } while (ps_hdr_copied < pdma_st->ps_hdr_len);
+
+    pdma_st->is_first = false;
 }
 
 static void
 igb_write_payload_frag_to_rx_buffers(IGBCore *core,
                                      PCIDevice *d,
-                                     hwaddr ba,
-                                     uint16_t *written,
-                                     uint32_t cur_buf_len,
+                                     IGBPacketRxDMAState *pdma_st,
                                      const char *data,
                                      dma_addr_t data_len)
 {
-    trace_igb_rx_desc_buff_write(ba, *written, data, data_len);
-    pci_dma_write(d, ba + *written, data, data_len);
-    *written += data_len;
+    while (data_len > 0) {
+        assert(pdma_st->bastate.cur_idx < IGB_MAX_PS_BUFFERS);
+
+        uint32_t cur_buf_bytes_left =
+            pdma_st->rx_desc_packet_buf_size -
+            pdma_st->bastate.written[pdma_st->bastate.cur_idx];
+        uint32_t bytes_to_write = MIN(data_len, cur_buf_bytes_left);
+
+        trace_igb_rx_desc_buff_write(
+            pdma_st->bastate.cur_idx,
+            pdma_st->ba[pdma_st->bastate.cur_idx],
+            pdma_st->bastate.written[pdma_st->bastate.cur_idx],
+            data,
+            bytes_to_write);
+
+        pci_dma_write(d,
+                      pdma_st->ba[pdma_st->bastate.cur_idx] +
+                      pdma_st->bastate.written[pdma_st->bastate.cur_idx],
+                      data, bytes_to_write);
+
+        pdma_st->bastate.written[pdma_st->bastate.cur_idx] += bytes_to_write;
+        data += bytes_to_write;
+        data_len -= bytes_to_write;
+
+        if (pdma_st->bastate.written[pdma_st->bastate.cur_idx] ==
+            pdma_st->rx_desc_packet_buf_size) {
+            pdma_st->bastate.cur_idx++;
+        }
+    }
 }
 
 static void
@@ -1600,9 +1854,7 @@ igb_write_payload_to_rx_buffers(IGBCore *core,
     while (*copy_size) {
         iov_copy = MIN(*copy_size, pdma_st->iov->iov_len - pdma_st->iov_ofs);
         igb_write_payload_frag_to_rx_buffers(core, d,
-                                             pdma_st->ba,
-                                             &pdma_st->written,
-                                             pdma_st->rx_desc_packet_buf_size,
+                                             pdma_st,
                                              pdma_st->iov->iov_base +
                                              pdma_st->iov_ofs,
                                              iov_copy);
@@ -1618,9 +1870,7 @@ igb_write_payload_to_rx_buffers(IGBCore *core,
     if (pdma_st->desc_offset + pdma_st->desc_size >= pdma_st->total_size) {
         /* Simulate FCS checksum presence in the last descriptor */
         igb_write_payload_frag_to_rx_buffers(core, d,
-                                             pdma_st->ba,
-                                             &pdma_st->written,
-                                             pdma_st->rx_desc_packet_buf_size,
+                                             pdma_st,
                                              (const char *) &fcs_pad,
                                              e1000x_fcs_len(core->mac));
     }
@@ -1634,7 +1884,7 @@ igb_write_to_rx_buffers(IGBCore *core,
 {
     size_t copy_size;
 
-    if (!pdma_st->ba) {
+    if (!(pdma_st->ba)[1] || (pdma_st->do_ps && !(pdma_st->ba[0]))) {
         /* as per intel docs; skip descriptors with null buf addr */
         trace_e1000e_rx_null_descriptor();
         return;
@@ -1648,6 +1898,14 @@ igb_write_to_rx_buffers(IGBCore *core,
     igb_truncate_to_descriptor_size(pdma_st, &pdma_st->desc_size);
     copy_size = pdma_st->size - pdma_st->desc_offset;
     igb_truncate_to_descriptor_size(pdma_st, &copy_size);
+
+    /* For PS mode copy the packet header first */
+    if (pdma_st->do_ps) {
+        igb_write_header_to_rx_buffers(core, pkt, d, pdma_st, &copy_size);
+    } else {
+        pdma_st->bastate.cur_idx = 1;
+    }
+
     igb_write_payload_to_rx_buffers(core, pkt, d, pdma_st, &copy_size);
 }
 
@@ -1678,8 +1936,10 @@ igb_write_packet_to_guest(IGBCore *core, struct NetRxPkt *pkt,
         d = core->owner;
     }
 
+    pdma_st.do_ps = igb_do_ps(core, rxi, pkt, &pdma_st);
+
     do {
-        pdma_st.written = 0;
+        memset(&pdma_st.bastate, 0, sizeof(IGBBAState));
         bool is_last = false;
 
         if (igb_ring_empty(core, rxi)) {
@@ -1690,7 +1950,7 @@ igb_write_packet_to_guest(IGBCore *core, struct NetRxPkt *pkt,
         pci_dma_read(d, base, &desc, rx_desc_len);
         trace_e1000e_rx_descr(rxi->idx, base, rx_desc_len);
 
-        igb_read_rx_descr(core, &desc, &pdma_st.ba);
+        igb_read_rx_descr(core, &desc, &pdma_st, rxi);
 
         igb_write_to_rx_buffers(core, pkt, d, &pdma_st);
         pdma_st.desc_offset += pdma_st.desc_size;
@@ -1698,8 +1958,12 @@ igb_write_packet_to_guest(IGBCore *core, struct NetRxPkt *pkt,
             is_last = true;
         }
 
-        igb_write_rx_descr(core, &desc, is_last ? core->rx_pkt : NULL,
-                           rss_info, etqf, ts, pdma_st.written);
+        igb_write_rx_descr(core, &desc,
+                           is_last ? pkt : NULL,
+                           rss_info,
+                           etqf, ts,
+                           &pdma_st,
+                           rxi);
         igb_pci_dma_write_rx_desc(core, d, base, &desc, rx_desc_len);
         igb_ring_advance(core, rxi, rx_desc_len / E1000_MIN_RX_DESC_LEN);
     } while (pdma_st.desc_offset < pdma_st.total_size);
diff --git a/hw/net/igb_regs.h b/hw/net/igb_regs.h
index 36763f2..ed7427b 100644
--- a/hw/net/igb_regs.h
+++ b/hw/net/igb_regs.h
@@ -452,6 +452,7 @@ union e1000_adv_rx_desc {
 #define E1000_SRRCTL_BSIZEHDRSIZE_MASK         0x00000F00
 #define E1000_SRRCTL_BSIZEHDRSIZE_SHIFT        2  /* Shift _left_ */
 #define E1000_SRRCTL_DESCTYPE_ADV_ONEBUF       0x02000000
+#define E1000_SRRCTL_DESCTYPE_HDR_SPLIT        0x04000000
 #define E1000_SRRCTL_DESCTYPE_HDR_SPLIT_ALWAYS 0x0A000000
 #define E1000_SRRCTL_DESCTYPE_MASK             0x0E000000
 #define E1000_SRRCTL_DROP_EN                   0x80000000
@@ -699,6 +700,14 @@ union e1000_adv_rx_desc {
 #define E1000_ADVRXD_PKT_UDP  BIT(5)
 #define E1000_ADVRXD_PKT_SCTP BIT(6)
 
+#define IGB_MAX_PS_BUFFERS 2
+
+#define E1000_ADVRXD_HDR_LEN_OFFSET    (21 - 16)
+#define E1000_ADVRXD_ADV_HDR_LEN_MASK  ((BIT(10) - 1) << \
+                                        E1000_ADVRXD_HDR_LEN_OFFSET)
+#define E1000_ADVRXD_HDR_SPH           BIT(15)
+#define E1000_ADVRXD_ST_ERR_HBO_OFFSET BIT(3 + 20)
+
 static inline uint8_t igb_ivar_entry_rx(uint8_t i)
 {
     return i < 8 ? i * 4 : (i - 8) * 4 + 2;
diff --git a/hw/net/trace-events b/hw/net/trace-events
index b8305c0..3abfd65 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -278,7 +278,7 @@ igb_core_mdic_write_unhandled(uint32_t addr) "MDIC WRITE: PHY[%u] UNHANDLED"
 igb_link_set_ext_params(bool asd_check, bool speed_select_bypass, bool pfrstd) "Set extended link params: ASD check: %d, Speed select bypass: %d, PF reset done: %d"
 
 igb_rx_desc_buff_size(uint32_t b) "buffer size: %u"
-igb_rx_desc_buff_write(uint64_t addr, uint16_t offset, const void* source, uint32_t len) "addr: 0x%"PRIx64", offset: %u, from: %p, length: %u"
+igb_rx_desc_buff_write(uint8_t idx, uint64_t addr, uint16_t offset, const void* source, uint32_t len) "buffer %u, addr: 0x%"PRIx64", offset: %u, from: %p, length: %u"
 
 igb_rx_metadata_rss(uint32_t rss, uint16_t rss_pkt_type) "RSS data: rss: 0x%X, rss_pkt_type: 0x%X"
 
-- 
2.7.4


