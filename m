Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B171A7A44D5
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 10:35:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi9gw-0006kj-9R; Mon, 18 Sep 2023 04:33:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qi9fp-0005zO-0P
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 04:32:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qi9fj-00049n-La
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 04:32:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695025919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x9BylYmdp6FxhYqvqXjmuM0XPKEm9v5bArROyfuij7E=;
 b=EAPkRZC2WUBtH2dsVAm25vMkpgU51jAK1HtwCi0+v27g62++4Xo2lCT+9d/6GMX/fQms/r
 EKr0IMMSE0VGDide/dFA7sshnv4mQ4du6mNUO5VeoisW5qBhgJ3lk0HwI3PKqdjxz4TY6c
 m++x2IYksVs1YZjQYS1rP+Fv5AfIG3E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-695-XmoXhb5yMDqoWZOUxjmrFA-1; Mon, 18 Sep 2023 04:31:55 -0400
X-MC-Unique: XmoXhb5yMDqoWZOUxjmrFA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D81C1185A79B;
 Mon, 18 Sep 2023 08:31:54 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.113.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 39A072156701;
 Mon, 18 Sep 2023 08:31:51 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tomasz Dzieciol <t.dzieciol@partner.samsung.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL V2 06/17] igb: rename E1000E_RingInfo_st
Date: Mon, 18 Sep 2023 16:31:21 +0800
Message-Id: <20230918083132.55423-7-jasowang@redhat.com>
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

Rename E1000E_RingInfo_st and E1000E_RingInfo according to qemu typdefs guide.

Signed-off-by: Tomasz Dzieciol <t.dzieciol@partner.samsung.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/e1000e_core.c | 34 +++++++++++++++++-----------------
 hw/net/igb_core.c    | 42 +++++++++++++++++++++---------------------
 2 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index d405595..91aae37 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -810,24 +810,24 @@ e1000e_txdesc_writeback(E1000ECore *core, dma_addr_t base,
     return e1000e_tx_wb_interrupt_cause(core, queue_idx);
 }
 
-typedef struct E1000E_RingInfo_st {
+typedef struct E1000ERingInfo {
     int dbah;
     int dbal;
     int dlen;
     int dh;
     int dt;
     int idx;
-} E1000E_RingInfo;
+} E1000ERingInfo;
 
 static inline bool
-e1000e_ring_empty(E1000ECore *core, const E1000E_RingInfo *r)
+e1000e_ring_empty(E1000ECore *core, const E1000ERingInfo *r)
 {
     return core->mac[r->dh] == core->mac[r->dt] ||
                 core->mac[r->dt] >= core->mac[r->dlen] / E1000_RING_DESC_LEN;
 }
 
 static inline uint64_t
-e1000e_ring_base(E1000ECore *core, const E1000E_RingInfo *r)
+e1000e_ring_base(E1000ECore *core, const E1000ERingInfo *r)
 {
     uint64_t bah = core->mac[r->dbah];
     uint64_t bal = core->mac[r->dbal];
@@ -836,13 +836,13 @@ e1000e_ring_base(E1000ECore *core, const E1000E_RingInfo *r)
 }
 
 static inline uint64_t
-e1000e_ring_head_descr(E1000ECore *core, const E1000E_RingInfo *r)
+e1000e_ring_head_descr(E1000ECore *core, const E1000ERingInfo *r)
 {
     return e1000e_ring_base(core, r) + E1000_RING_DESC_LEN * core->mac[r->dh];
 }
 
 static inline void
-e1000e_ring_advance(E1000ECore *core, const E1000E_RingInfo *r, uint32_t count)
+e1000e_ring_advance(E1000ECore *core, const E1000ERingInfo *r, uint32_t count)
 {
     core->mac[r->dh] += count;
 
@@ -852,7 +852,7 @@ e1000e_ring_advance(E1000ECore *core, const E1000E_RingInfo *r, uint32_t count)
 }
 
 static inline uint32_t
-e1000e_ring_free_descr_num(E1000ECore *core, const E1000E_RingInfo *r)
+e1000e_ring_free_descr_num(E1000ECore *core, const E1000ERingInfo *r)
 {
     trace_e1000e_ring_free_space(r->idx, core->mac[r->dlen],
                                  core->mac[r->dh],  core->mac[r->dt]);
@@ -871,19 +871,19 @@ e1000e_ring_free_descr_num(E1000ECore *core, const E1000E_RingInfo *r)
 }
 
 static inline bool
-e1000e_ring_enabled(E1000ECore *core, const E1000E_RingInfo *r)
+e1000e_ring_enabled(E1000ECore *core, const E1000ERingInfo *r)
 {
     return core->mac[r->dlen] > 0;
 }
 
 static inline uint32_t
-e1000e_ring_len(E1000ECore *core, const E1000E_RingInfo *r)
+e1000e_ring_len(E1000ECore *core, const E1000ERingInfo *r)
 {
     return core->mac[r->dlen];
 }
 
 typedef struct E1000E_TxRing_st {
-    const E1000E_RingInfo *i;
+    const E1000ERingInfo *i;
     struct e1000e_tx *tx;
 } E1000E_TxRing;
 
@@ -896,7 +896,7 @@ e1000e_mq_queue_idx(int base_reg_idx, int reg_idx)
 static inline void
 e1000e_tx_ring_init(E1000ECore *core, E1000E_TxRing *txr, int idx)
 {
-    static const E1000E_RingInfo i[E1000E_NUM_QUEUES] = {
+    static const E1000ERingInfo i[E1000E_NUM_QUEUES] = {
         { TDBAH,  TDBAL,  TDLEN,  TDH,  TDT, 0 },
         { TDBAH1, TDBAL1, TDLEN1, TDH1, TDT1, 1 }
     };
@@ -908,13 +908,13 @@ e1000e_tx_ring_init(E1000ECore *core, E1000E_TxRing *txr, int idx)
 }
 
 typedef struct E1000E_RxRing_st {
-    const E1000E_RingInfo *i;
+    const E1000ERingInfo *i;
 } E1000E_RxRing;
 
 static inline void
 e1000e_rx_ring_init(E1000ECore *core, E1000E_RxRing *rxr, int idx)
 {
-    static const E1000E_RingInfo i[E1000E_NUM_QUEUES] = {
+    static const E1000ERingInfo i[E1000E_NUM_QUEUES] = {
         { RDBAH0, RDBAL0, RDLEN0, RDH0, RDT0, 0 },
         { RDBAH1, RDBAL1, RDLEN1, RDH1, RDT1, 1 }
     };
@@ -930,7 +930,7 @@ e1000e_start_xmit(E1000ECore *core, const E1000E_TxRing *txr)
     dma_addr_t base;
     struct e1000_tx_desc desc;
     bool ide = false;
-    const E1000E_RingInfo *txi = txr->i;
+    const E1000ERingInfo *txi = txr->i;
     uint32_t cause = E1000_ICS_TXQE;
 
     if (!(core->mac[TCTL] & E1000_TCTL_EN)) {
@@ -960,7 +960,7 @@ e1000e_start_xmit(E1000ECore *core, const E1000E_TxRing *txr)
 }
 
 static bool
-e1000e_has_rxbufs(E1000ECore *core, const E1000E_RingInfo *r,
+e1000e_has_rxbufs(E1000ECore *core, const E1000ERingInfo *r,
                   size_t total_size)
 {
     uint32_t bufs = e1000e_ring_free_descr_num(core, r);
@@ -1460,7 +1460,7 @@ e1000e_update_rx_stats(E1000ECore *core, size_t pkt_size, size_t pkt_fcs_size)
 }
 
 static inline bool
-e1000e_rx_descr_threshold_hit(E1000ECore *core, const E1000E_RingInfo *rxi)
+e1000e_rx_descr_threshold_hit(E1000ECore *core, const E1000ERingInfo *rxi)
 {
     return e1000e_ring_free_descr_num(core, rxi) ==
            e1000e_ring_len(core, rxi) >> core->rxbuf_min_shift;
@@ -1521,7 +1521,7 @@ e1000e_write_packet_to_guest(E1000ECore *core, struct NetRxPkt *pkt,
     struct iovec *iov = net_rx_pkt_get_iovec(pkt);
     size_t size = net_rx_pkt_get_total_len(pkt);
     size_t total_size = size + e1000x_fcs_len(core->mac);
-    const E1000E_RingInfo *rxi;
+    const E1000ERingInfo *rxi;
     size_t ps_hdr_len = 0;
     bool do_ps = e1000e_do_ps(core, pkt, &ps_hdr_len);
     bool is_first = true;
diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index a83e4aa..d50e6b1 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -694,24 +694,24 @@ static uint32_t igb_rx_wb_eic(IGBCore *core, int queue_idx)
     return (ent & E1000_IVAR_VALID) ? BIT(ent & 0x1f) : 0;
 }
 
-typedef struct E1000E_RingInfo_st {
+typedef struct E1000ERingInfo {
     int dbah;
     int dbal;
     int dlen;
     int dh;
     int dt;
     int idx;
-} E1000E_RingInfo;
+} E1000ERingInfo;
 
 static inline bool
-igb_ring_empty(IGBCore *core, const E1000E_RingInfo *r)
+igb_ring_empty(IGBCore *core, const E1000ERingInfo *r)
 {
     return core->mac[r->dh] == core->mac[r->dt] ||
                 core->mac[r->dt] >= core->mac[r->dlen] / E1000_RING_DESC_LEN;
 }
 
 static inline uint64_t
-igb_ring_base(IGBCore *core, const E1000E_RingInfo *r)
+igb_ring_base(IGBCore *core, const E1000ERingInfo *r)
 {
     uint64_t bah = core->mac[r->dbah];
     uint64_t bal = core->mac[r->dbal];
@@ -720,13 +720,13 @@ igb_ring_base(IGBCore *core, const E1000E_RingInfo *r)
 }
 
 static inline uint64_t
-igb_ring_head_descr(IGBCore *core, const E1000E_RingInfo *r)
+igb_ring_head_descr(IGBCore *core, const E1000ERingInfo *r)
 {
     return igb_ring_base(core, r) + E1000_RING_DESC_LEN * core->mac[r->dh];
 }
 
 static inline void
-igb_ring_advance(IGBCore *core, const E1000E_RingInfo *r, uint32_t count)
+igb_ring_advance(IGBCore *core, const E1000ERingInfo *r, uint32_t count)
 {
     core->mac[r->dh] += count;
 
@@ -736,7 +736,7 @@ igb_ring_advance(IGBCore *core, const E1000E_RingInfo *r, uint32_t count)
 }
 
 static inline uint32_t
-igb_ring_free_descr_num(IGBCore *core, const E1000E_RingInfo *r)
+igb_ring_free_descr_num(IGBCore *core, const E1000ERingInfo *r)
 {
     trace_e1000e_ring_free_space(r->idx, core->mac[r->dlen],
                                  core->mac[r->dh],  core->mac[r->dt]);
@@ -755,13 +755,13 @@ igb_ring_free_descr_num(IGBCore *core, const E1000E_RingInfo *r)
 }
 
 static inline bool
-igb_ring_enabled(IGBCore *core, const E1000E_RingInfo *r)
+igb_ring_enabled(IGBCore *core, const E1000ERingInfo *r)
 {
     return core->mac[r->dlen] > 0;
 }
 
 typedef struct IGB_TxRing_st {
-    const E1000E_RingInfo *i;
+    const E1000ERingInfo *i;
     struct igb_tx *tx;
 } IGB_TxRing;
 
@@ -774,7 +774,7 @@ igb_mq_queue_idx(int base_reg_idx, int reg_idx)
 static inline void
 igb_tx_ring_init(IGBCore *core, IGB_TxRing *txr, int idx)
 {
-    static const E1000E_RingInfo i[IGB_NUM_QUEUES] = {
+    static const E1000ERingInfo i[IGB_NUM_QUEUES] = {
         { TDBAH0, TDBAL0, TDLEN0, TDH0, TDT0, 0 },
         { TDBAH1, TDBAL1, TDLEN1, TDH1, TDT1, 1 },
         { TDBAH2, TDBAL2, TDLEN2, TDH2, TDT2, 2 },
@@ -800,13 +800,13 @@ igb_tx_ring_init(IGBCore *core, IGB_TxRing *txr, int idx)
 }
 
 typedef struct E1000E_RxRing_st {
-    const E1000E_RingInfo *i;
+    const E1000ERingInfo *i;
 } E1000E_RxRing;
 
 static inline void
 igb_rx_ring_init(IGBCore *core, E1000E_RxRing *rxr, int idx)
 {
-    static const E1000E_RingInfo i[IGB_NUM_QUEUES] = {
+    static const E1000ERingInfo i[IGB_NUM_QUEUES] = {
         { RDBAH0, RDBAL0, RDLEN0, RDH0, RDT0, 0 },
         { RDBAH1, RDBAL1, RDLEN1, RDH1, RDT1, 1 },
         { RDBAH2, RDBAL2, RDLEN2, RDH2, RDT2, 2 },
@@ -833,7 +833,7 @@ igb_rx_ring_init(IGBCore *core, E1000E_RxRing *rxr, int idx)
 static uint32_t
 igb_txdesc_writeback(IGBCore *core, dma_addr_t base,
                      union e1000_adv_tx_desc *tx_desc,
-                     const E1000E_RingInfo *txi)
+                     const E1000ERingInfo *txi)
 {
     PCIDevice *d;
     uint32_t cmd_type_len = le32_to_cpu(tx_desc->read.cmd_type_len);
@@ -866,7 +866,7 @@ igb_txdesc_writeback(IGBCore *core, dma_addr_t base,
 }
 
 static inline bool
-igb_tx_enabled(IGBCore *core, const E1000E_RingInfo *txi)
+igb_tx_enabled(IGBCore *core, const E1000ERingInfo *txi)
 {
     bool vmdq = core->mac[MRQC] & 1;
     uint16_t qn = txi->idx;
@@ -883,7 +883,7 @@ igb_start_xmit(IGBCore *core, const IGB_TxRing *txr)
     PCIDevice *d;
     dma_addr_t base;
     union e1000_adv_tx_desc desc;
-    const E1000E_RingInfo *txi = txr->i;
+    const E1000ERingInfo *txi = txr->i;
     uint32_t eic = 0;
 
     if (!igb_tx_enabled(core, txi)) {
@@ -918,7 +918,7 @@ igb_start_xmit(IGBCore *core, const IGB_TxRing *txr)
 }
 
 static uint32_t
-igb_rxbufsize(IGBCore *core, const E1000E_RingInfo *r)
+igb_rxbufsize(IGBCore *core, const E1000ERingInfo *r)
 {
     uint32_t srrctl = core->mac[E1000_SRRCTL(r->idx) >> 2];
     uint32_t bsizepkt = srrctl & E1000_SRRCTL_BSIZEPKT_MASK;
@@ -930,7 +930,7 @@ igb_rxbufsize(IGBCore *core, const E1000E_RingInfo *r)
 }
 
 static bool
-igb_has_rxbufs(IGBCore *core, const E1000E_RingInfo *r, size_t total_size)
+igb_has_rxbufs(IGBCore *core, const E1000ERingInfo *r, size_t total_size)
 {
     uint32_t bufs = igb_ring_free_descr_num(core, r);
     uint32_t bufsize = igb_rxbufsize(core, r);
@@ -1522,7 +1522,7 @@ igb_write_to_rx_buffers(IGBCore *core,
 }
 
 static void
-igb_update_rx_stats(IGBCore *core, const E1000E_RingInfo *rxi,
+igb_update_rx_stats(IGBCore *core, const E1000ERingInfo *rxi,
                     size_t pkt_size, size_t pkt_fcs_size)
 {
     eth_pkt_types_e pkt_type = net_rx_pkt_get_packet_type(core->rx_pkt);
@@ -1540,7 +1540,7 @@ igb_update_rx_stats(IGBCore *core, const E1000E_RingInfo *rxi,
 }
 
 static inline bool
-igb_rx_descr_threshold_hit(IGBCore *core, const E1000E_RingInfo *rxi)
+igb_rx_descr_threshold_hit(IGBCore *core, const E1000ERingInfo *rxi)
 {
     return igb_ring_free_descr_num(core, rxi) ==
            ((core->mac[E1000_SRRCTL(rxi->idx) >> 2] >> 20) & 31) * 16;
@@ -1562,7 +1562,7 @@ igb_write_packet_to_guest(IGBCore *core, struct NetRxPkt *pkt,
     struct iovec *iov = net_rx_pkt_get_iovec(pkt);
     size_t size = net_rx_pkt_get_total_len(pkt);
     size_t total_size = size + e1000x_fcs_len(core->mac);
-    const E1000E_RingInfo *rxi = rxr->i;
+    const E1000ERingInfo *rxi = rxr->i;
     size_t bufsize = igb_rxbufsize(core, rxi);
 
     d = pcie_sriov_get_vf_at_index(core->owner, rxi->idx % 8);
@@ -1643,7 +1643,7 @@ igb_write_packet_to_guest(IGBCore *core, struct NetRxPkt *pkt,
 }
 
 static bool
-igb_rx_strip_vlan(IGBCore *core, const E1000E_RingInfo *rxi)
+igb_rx_strip_vlan(IGBCore *core, const E1000ERingInfo *rxi)
 {
     if (core->mac[MRQC] & 1) {
         uint16_t pool = rxi->idx % IGB_NUM_VM_POOLS;
-- 
2.7.4


