Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B63714B77
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 16:03:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3dRx-0002qS-Ef; Mon, 29 May 2023 10:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.dzieciol@partner.samsung.com>)
 id 1q3dRs-0002nV-Ls
 for qemu-devel@nongnu.org; Mon, 29 May 2023 10:02:12 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.dzieciol@partner.samsung.com>)
 id 1q3dRq-0006oA-5Q
 for qemu-devel@nongnu.org; Mon, 29 May 2023 10:02:12 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20230529140203euoutp02429bac1bd5e9ce5a13b3fe17f78e0dd5~johtZsYzy1118311183euoutp02n
 for <qemu-devel@nongnu.org>; Mon, 29 May 2023 14:02:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20230529140203euoutp02429bac1bd5e9ce5a13b3fe17f78e0dd5~johtZsYzy1118311183euoutp02n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1685368923;
 bh=zA/8FB39zbVbvqXYpTGtVq1emGaCToIPGE2RXa9MnJY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rBYx3mf22kpf/VFEjNHhOtGXcwmwhqZtaf7wrgxZaPRZLOk0Pvd2KyzyFxRQE8HGc
 IiJ91u+2o3ihYmc5SjoZhFBASF9gtO6xziwJ+blC1NTw2iJueAp6626LK58pTMPQCh
 oA9NkVuHEudvLlhX4/r7w1DZ6E5W6LSUpqgH41sY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20230529140203eucas1p24988edcdfbec8b226f4c7b97bb6a8618~johtNbNas0737807378eucas1p2K;
 Mon, 29 May 2023 14:02:03 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 9D.8B.11320.B50B4746; Mon, 29
 May 2023 15:02:03 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20230529140203eucas1p22232810ddde5658a5849b0f6cf145e91~johs1vFpJ2046920469eucas1p26;
 Mon, 29 May 2023 14:02:03 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20230529140203eusmtrp141de8428398bb5d704a3f0ee5c1aad96~johs1Kl4b0620706207eusmtrp19;
 Mon, 29 May 2023 14:02:03 +0000 (GMT)
X-AuditID: cbfec7f4-993ff70000022c38-7b-6474b05b029d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 8C.06.10549.B50B4746; Mon, 29
 May 2023 15:02:03 +0100 (BST)
Received: from AMDN5139.EU.corp.samsungelectronics.net (unknown
 [106.210.135.112]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20230529140202eusmtip23cf89d9478a8951c001ae8cd6d93f1a7~johsVz9KD1126611266eusmtip2s;
 Mon, 29 May 2023 14:02:02 +0000 (GMT)
From: Tomasz Dzieciol <t.dzieciol@partner.samsung.com>
To: qemu-devel@nongnu.org, akihiko.odaki@daynix.com
Cc: sriram.yagnaraman@est.tech, jasowang@redhat.com, k.kwiecien@samsung.com,
 m.sochacki@samsung.com
Subject: [PATCH v10 2/7] igb: rename E1000E_RingInfo_st
Date: Mon, 29 May 2023 16:01:48 +0200
Message-Id: <20230529140153.4053-3-t.dzieciol@partner.samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230529140153.4053-1-t.dzieciol@partner.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkleLIzCtJLcpLzFFi42LZduzned3oDSUpBm3vlSw+n1rLbrHs0mcm
 i8b5c1gttl79wW5xvHcHi0XvphdMDmweJ94eZPW48Ogcs8eTa5uZPN7vu8rm0bdlFWMAaxSX
 TUpqTmZZapG+XQJXRvf9q8wF0+IqXh6Zz9bA+NOri5GTQ0LARKL711OWLkYuDiGBFYwSF14c
 hnK+MErMebCPDcL5zCjx79RGFpiWhXdbmSESyxkltrSfg3LamSSuntnGDlLFJmAm8ejLPNYu
 Rg4OEQFjiY/t4iBhZoFUiaN/DoINEhYwlzh1/hgjiM0ioCqx+t0msDivgJPE7s7bjBDL5CVm
 XvrODjKGU8BZovM0B0SJoMTJmU9YIEbKSzRvnQ12goTADg6JN3/mQR3qIrHsQCM7hC0s8er4
 FihbRuL05B6omnKJn2dBTgZpbmGU2DN1MlSRtcSlrT/B7mcW0JRYv0sfxJQQcJR4tdwbwuST
 uPFWEOIEPolJ26YzQ4R5JTrahCBm6Eh82zSTDSIsJbHwRh2E6SHxcH7wBEbFWUhemYXklVkI
 SxcwMq9iFE8tLc5NTy02ykst1ytOzC0uzUvXS87P3cQITC2n/x3/soNx+auPeocYmTgYDzFK
 cDArifDaJhanCPGmJFZWpRblxxeV5qQWH2KU5mBREufVtj2ZLCSQnliSmp2aWpBaBJNl4uCU
 amBi1ji8rZ3XudLveO2Tcx90WvS604yu3n57U+zg1fg11evrUicamBl6T3RTeXrMyYnd7PL0
 1c4mHLqPS14ZVZhfPXvo7KNd69X2Rsdyyf7/MutH2YZbfFE3/PJrL6XYFW38vU7J4vTHtzZR
 yRm3K18fesxgIfhMLMmGqypiad/xWPV9N9skrhU0PnuXUH412ezsqf8OXBcn6i+x1Emqklgx
 Wzq0sefICpnQ5vW/XRd5J7ewR83NTBEXco/1Xs75df3KlkDf8My2mk9rQzMnrM/IL2yVea5V
 vM5Bl5W50fHU5E/TT/rmOnzJLfolmLBk+QEn4cc/d9klKIvJ7XileKp354Jbalyp1+4t3f/t
 1y0lluKMREMt5qLiRAApkMionAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsVy+t/xe7rRG0pSDJqv8Fl8PrWW3WLZpc9M
 Fo3z57BabL36g93ieO8OFoveTS+YHNg8Trw9yOpx4dE5Zo8n1zYzebzfd5XNo2/LKsYA1ig9
 m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jO77V5kL
 psVVvDwyn62B8adXFyMnh4SAicTCu63MXYxcHEICSxklTv7bxwSRkJLY1/OfHcIWlvhzrYsN
 oqiVSaKlr4MFJMEmYCbx6Ms81i5GDg4RAVOJZ3slQcLMApkSp1/tYwOxhQXMJU6dP8YIYrMI
 qEqsfrcJrJVXwElid+dtRoj58hIzL31nBxnDKeAs0XmaAyQsBFTSee8mK0S5oMTJmU9YIMbL
 SzRvnc08gVFgFpLULCSpBYxMqxhFUkuLc9Nziw31ihNzi0vz0vWS83M3MQIjYduxn5t3MM57
 9VHvECMTB+MhRgkOZiURXtvE4hQh3pTEyqrUovz4otKc1OJDjKZAZ09klhJNzgfGYl5JvKGZ
 gamhiZmlgamlmbGSOK9nQUeikEB6YklqdmpqQWoRTB8TB6dUAxPTpZdlohzbVAs/PDpfls16
 dmHYwd+mX7hLGpQn9aZMZvzqWf7GVFpI+9HlZIGS1EWvk9NErisYXl60unX1O9m9doXfso5d
 SDzyon7a/zDZonefd71+wTs5QP/rHpnflZI/0mf712nElf/qeV/fs1nDiVOvKcdv1duZ3Wnq
 qjVv7/fumem9SfvljmPVuf/n2dcc4PE0/LBN9W/Dw6vxbr/MpszPPf507tbL/HenRX6OWvRH
 WPyg/n6mGyzvO3b6vdnOaOw3b8+OezFCjt8Ya+YlpT59zT+Pp034xtOXstZB+l96lY0D/S0v
 zZpqo5/zgPNfZ8Gkk012M78s9vrNvNVrh9k8XtXdc/jWnNiiUMysxFKckWioxVxUnAgA26tx
 iQ0DAAA=
X-CMS-MailID: 20230529140203eucas1p22232810ddde5658a5849b0f6cf145e91
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230529140203eucas1p22232810ddde5658a5849b0f6cf145e91
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230529140203eucas1p22232810ddde5658a5849b0f6cf145e91
References: <20230529140153.4053-1-t.dzieciol@partner.samsung.com>
 <CGME20230529140203eucas1p22232810ddde5658a5849b0f6cf145e91@eucas1p2.samsung.com>
Received-SPF: none client-ip=210.118.77.12;
 envelope-from=t.dzieciol@partner.samsung.com; helo=mailout2.w1.samsung.com
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
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


