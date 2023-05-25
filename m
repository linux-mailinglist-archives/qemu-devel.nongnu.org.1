Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D67710FCA
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 17:39:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2D2K-0003Lg-1J; Thu, 25 May 2023 11:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.dzieciol@partner.samsung.com>)
 id 1q2D2H-0003Jm-Oh
 for qemu-devel@nongnu.org; Thu, 25 May 2023 11:37:53 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.dzieciol@partner.samsung.com>)
 id 1q2D2E-0000nf-Ks
 for qemu-devel@nongnu.org; Thu, 25 May 2023 11:37:53 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20230525153744euoutp0234773a7a2e76fe33376915cd15c06ac3~ibQG5s_qW0293202932euoutp02O
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 15:37:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20230525153744euoutp0234773a7a2e76fe33376915cd15c06ac3~ibQG5s_qW0293202932euoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1685029064;
 bh=zA/8FB39zbVbvqXYpTGtVq1emGaCToIPGE2RXa9MnJY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aV1qVkelMb3fLlsJ1Ib2HJ6A2uCQKuQDOo+Iql00KLjegUEioV6bkgTS7j3M9OUpo
 2AlE4kmR6/OcUZ6PIU5m/C6pIPT6KXwB4HTrZ/2/mwnToDj4Tev4eDxfjkHA8UkgVU
 DLrfz/FXPXrKxuM9DEzux40lVbUxPstWZ1jZTKVI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20230525153744eucas1p22f8fa41e9c1857eb2842f76568697b42~ibQGw3WBO2758927589eucas1p2g;
 Thu, 25 May 2023 15:37:44 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id E3.52.37758.8C08F646; Thu, 25
 May 2023 16:37:44 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20230525153744eucas1p208318603e67e11c9ab3f0a6556b8d3a4~ibQGQXGp02755027550eucas1p2Z;
 Thu, 25 May 2023 15:37:44 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20230525153744eusmtrp2c365b0b1af660b917ca68ed8949618d7~ibQGP2Sy30985909859eusmtrp24;
 Thu, 25 May 2023 15:37:44 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-56-646f80c8badf
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 69.A7.14344.7C08F646; Thu, 25
 May 2023 16:37:43 +0100 (BST)
Received: from AMDN5139.EU.corp.samsungelectronics.net (unknown
 [106.210.135.112]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20230525153743eusmtip2007f52f1e8124c6c38d364b65828f80a~ibQFuzEEM2502125021eusmtip2r;
 Thu, 25 May 2023 15:37:43 +0000 (GMT)
From: Tomasz Dzieciol <t.dzieciol@partner.samsung.com>
To: qemu-devel@nongnu.org, akihiko.odaki@daynix.com
Cc: sriram.yagnaraman@est.tech, jasowang@redhat.com, k.kwiecien@samsung.com,
 m.sochacki@samsung.com
Subject: [PATCH v9 2/7] igb: rename E1000E_RingInfo_st
Date: Thu, 25 May 2023 17:37:28 +0200
Message-Id: <20230525153733.4104-3-t.dzieciol@partner.samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230525153733.4104-1-t.dzieciol@partner.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42LZduzned0TDfkpBjs/yVl8PrWW3WLZpc9M
 Fo3z57BabL36g93ieO8OFoveTS+YHNg8Trw9yOpx4dE5Zo8n1zYzebzfd5XNo2/LKsYA1igu
 m5TUnMyy1CJ9uwSujO77V5kLpsVVvDwyn62B8adXFyMnh4SAicTZ+XsZuxi5OIQEVjBKXPr4
 nB3C+cIo8e3lbTYI5zOjxMQ7s1hhWubObYRqWc4o8WhiOxOE084kMff/b7AqNgEziUdf5gHZ
 HBwiAsYSH9vFQcLMAqkSR/8cZAGxhYFKPk88xwZiswioSqy9fgCslVfASaJp5gt2iGXyEjMv
 fWcHGcMp4Cyx8mslRImgxMmZT1ggRspLNG+dzQxygoTAWg6JSa1NTBC9LhLzPrUwQ9jCEq+O
 b4GaKSPxf+d8qJpyiZ9nt7FDNLcwSuyZOhmqyFri0tafYPczC2hKrN+lDxF2lGib+pcJJCwh
 wCdx460gxA18EpO2TWeGCPNKdLQJQVTrSHzbNJMNIiwlsfBGHUTYQ2LzteUsExgVZyF5ZhaS
 Z2YhrF3AyLyKUTy1tDg3PbXYOC+1XK84Mbe4NC9dLzk/dxMjML2c/nf86w7GFa8+6h1iZOJg
 PMQowcGsJMK7ISc/RYg3JbGyKrUoP76oNCe1+BCjNAeLkjivtu3JZCGB9MSS1OzU1ILUIpgs
 EwenVAOTSESt9gbOp1N4rmj/e+xX+Pr21lAuoUuaSd2zKyK3yOabbp6R/PGCs8m9xlsGkzcz
 u32Ot5pyscnSZW+169/y10lzyp57GJxalrBr6Ydmj8iXB4w55z7dpWkx5ci8/QeP7L6zryOi
 JEDp3fHbpz8prnS+M8d6tpHzs0v8yoe6tc6sUFoRnGlwz7p0+YUvLTeCuTMYN5ytmVzAve6I
 4/W3rzS+FEpslPDyk2CR7//SGB6ZyHcokmPvu309C/avNdTmjm/bE6ayNCd/LTdb6PcrCfP3
 vXXn5JxxyCcle9Z587DOCQL75nrOuVtlUDzNN3//vDu+Uvun+ZkdvmZx922mcYiVbLGF9AWx
 Y1Vz0jdIKbEUZyQaajEXFScCADoDt3CeAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsVy+t/xe7rHG/JTDC7NsLH4fGotu8WyS5+Z
 LBrnz2G12Hr1B7vF8d4dLBa9m14wObB5nHh7kNXjwqNzzB5Prm1m8ni/7yqbR9+WVYwBrFF6
 NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6Gd33rzIX
 TIureHlkPlsD40+vLkZODgkBE4m5cxsZuxi5OIQEljJK7FvawAyRkJLY1/OfHcIWlvhzrYsN
 oqiVSWLO2QmsIAk2ATOJR1/mAdkcHCICphLP9kqChJkFMiVOv9rHBmILA5V8nngOzGYRUJVY
 e/0AWCuvgJNE08wXUPPlJWZe+s4OMoZTwFli5ddKkLAQUMn2D9OgygUlTs58wgIxXl6ieets
 5gmMArOQpGYhSS1gZFrFKJJaWpybnltspFecmFtcmpeul5yfu4kRGAnbjv3csoNx5auPeocY
 mTgYDzFKcDArifBuyMlPEeJNSaysSi3Kjy8qzUktPsRoCnT2RGYp0eR8YCzmlcQbmhmYGpqY
 WRqYWpoZK4nzehZ0JAoJpCeWpGanphakFsH0MXFwSjUw2Uf+3HJ7SVLM180b3s3/Kves8seD
 BforzmdEM1ssOtm4j1XXedNvdvfomxKSOnMaVu+dkbetREFkxQa/h782le1JeXefyf2L9OXK
 eyzlVScd+rOdX6nfMp6izGr+soyH9WPZk8O2AocS1N9XGM/OSjIrcc3dqn5KTeqG+q6PNfo+
 /zqS33pwd1af4me4Pztxi6G6iVr+WvHac5feTXd/3BrH3bFoQ92d2Jzf7yU6ZR5tCNzn5vR3
 6d8S9tap0ypuLjacZWh+49BxiRBRo9wS13dn95zeet80YlqwSl2yrfmjrzeOGB7X//4uPMW7
 u0Hnxq2d5eK2LjZTDDtTHl4X3Zh4Kz5xbpnGB3fxjaqHlViKMxINtZiLihMBUxDtBA0DAAA=
X-CMS-MailID: 20230525153744eucas1p208318603e67e11c9ab3f0a6556b8d3a4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230525153744eucas1p208318603e67e11c9ab3f0a6556b8d3a4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230525153744eucas1p208318603e67e11c9ab3f0a6556b8d3a4
References: <20230525153733.4104-1-t.dzieciol@partner.samsung.com>
 <CGME20230525153744eucas1p208318603e67e11c9ab3f0a6556b8d3a4@eucas1p2.samsung.com>
Received-SPF: none client-ip=210.118.77.12;
 envelope-from=t.dzieciol@partner.samsung.com; helo=mailout2.w1.samsung.com
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Rename E1000E_RingInfo_st and E1000E_RingInfo according to qemu typdefs guide.

Signed-off-by: Tomasz Dzieciol <t.dzieciol@partner.samsung.com>
---
 hw/net/e1000e_core.c | 34 +++++++++++++++++-----------------
 hw/net/igb_core.c    | 42 +++++++++++++++++++++---------------------
 2 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 9f185d099c..f6b628eaef 100644
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
index e927c51061..051980b4f5 100644
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
2.25.1


