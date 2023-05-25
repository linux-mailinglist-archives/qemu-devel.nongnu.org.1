Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B134C710FC6
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 17:39:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2D2L-0003My-Ue; Thu, 25 May 2023 11:37:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.dzieciol@partner.samsung.com>)
 id 1q2D2J-0003Ka-2J
 for qemu-devel@nongnu.org; Thu, 25 May 2023 11:37:55 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.dzieciol@partner.samsung.com>)
 id 1q2D2E-0000oV-Mv
 for qemu-devel@nongnu.org; Thu, 25 May 2023 11:37:54 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20230525153747euoutp02987412a3c289a720467105030b7ad081~ibQJUmBsZ0292202922euoutp02X
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 15:37:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20230525153747euoutp02987412a3c289a720467105030b7ad081~ibQJUmBsZ0292202922euoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1685029067;
 bh=dbWL4RIfXeXcGY6r3658f8p0ZYGC2z8aX/hom6apjFw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Z6/UhCXHRUqtemLOF0vNNhOPyFH3kkaEtbxBs37JA+aL6BGpkm4CPmu9mMJT8u139
 kzWA1s17vcgN4UKTBSHxEsU/JA1FnniJAwxtzXl+JfQ6VliEzBZ6hJrK1FH2BSUOGB
 04egYrok9NM4sZaE210mvDG8r+WMmFXSCVShkGZc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20230525153746eucas1p2602115ab6df483a0c348a0b53546beb1~ibQI6E9ma2773427734eucas1p2f;
 Thu, 25 May 2023 15:37:46 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 85.52.37758.AC08F646; Thu, 25
 May 2023 16:37:46 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20230525153746eucas1p1957a3a91d90521a6d1c684595c848f52~ibQIPWe1q1861918619eucas1p1g;
 Thu, 25 May 2023 15:37:46 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20230525153746eusmtrp11cde4ff688815148aae6720cabcdac2d~ibQIO5DFW0103701037eusmtrp1F;
 Thu, 25 May 2023 15:37:46 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-5d-646f80cadfcc
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id AA.C4.10549.AC08F646; Thu, 25
 May 2023 16:37:46 +0100 (BST)
Received: from AMDN5139.EU.corp.samsungelectronics.net (unknown
 [106.210.135.112]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20230525153745eusmtip221738c5a37fa36873e54450ad9bfe89e~ibQHsC_kQ1970019700eusmtip2W;
 Thu, 25 May 2023 15:37:45 +0000 (GMT)
From: Tomasz Dzieciol <t.dzieciol@partner.samsung.com>
To: qemu-devel@nongnu.org, akihiko.odaki@daynix.com
Cc: sriram.yagnaraman@est.tech, jasowang@redhat.com, k.kwiecien@samsung.com,
 m.sochacki@samsung.com
Subject: [PATCH v9 6/7] igb: packet-split descriptors support
Date: Thu, 25 May 2023 17:37:32 +0200
Message-Id: <20230525153733.4104-7-t.dzieciol@partner.samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230525153733.4104-1-t.dzieciol@partner.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe3fOtqM2O81ijxqIU7tYaqOwk6VoRUyT6oMhXVCHO6g1N9lx
 mpWpaVmmFYqV6zbNyklZ2TbMS5GVppGZYCYkkpmXYuZdpxE5T5HffvzeP//neeAlMOFprhMR
 p0yk1UqZQsyzxU0Nlhav5nSVfH3FNwk11vyAT91tG+NQGbeucylj+zSfasyrwqm8ygFOIE/6
 xvyCK23tacGkvR+fcKQ/n7XzpBcM5Wgv94DtVjmtiEui1T4BUbax/SOHEm7dQEfNHY/xdNSq
 yEE2BJAboaq3B1lZSJYhyP28kuVxBH2WJSyPIbjaI/2XN/af57H+HoK2OjwH2c5xNgcaOvXz
 RTzSF3rGb3JzEEEsIzfASLbIqjGShte/XuBWdiD9Ia/p2jzjpAfo3gzxrSwgt0Fr/iBiZ7lA
 UdsU31pjQ24H/UQKG1kKTUW9OFvpApnGaxgbNxCgex3M8g648yr3r3eA740GPssr4G1BLs5y
 MljemfjW9YHMQlBbWPA3tAXajJb59TFyDTys9mF1EIyWXkRWDaQ9fDIvZVewh3zTFYzVAjh7
 Rsim18FkZRGP1U5Q/Okki1IYPZd0CblqF5yiXXCK9v9UHcLKkYjWMPExNLNBSSd7M7J4RqOM
 8Y5WxVeiuZ/y9nfjRBUq+z7iXY84BKpHQGDiZYJHCpVcKJDLUo7RalWkWqOgmXrkTOBikWCt
 f1O0kIyRJdJHaDqBVv975RA2TumcZIj26BooLp6tLdvp3OTu7xKYqTOVhMguuwVHmAzy3OYM
 epGDX4X5fqh75Gqfej35cFix2+KyR1vcMR5Wouv6IWG8irZEdsdwo/yol75hI47l9iG7SvTh
 3DIqLExU4WpwHU40iEy7wlP13aERjouyJYjJ0ipWLBd8SAtZLJ75crhdWNgb0bee0g9NnI9V
 u43jpSebJTad+0URdaknnvPyLYPHF5fs8K2tXj1dwA3QUq5f31OqSWwyseN2HqehHwX1abKf
 1gx3zVxN6zhknEnY9C56b8vBbfumPA2t3Z7+Gyu3r9oZGpKmmQi0M22Oyziln5w1T1+yU1aI
 7TtrxDgTK5N4YmpG9gdCKEMZmAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsVy+t/xe7qnGvJTDGbO4bT4fGotu8WyS5+Z
 LBrnz2G12Hr1B7vF8d4dLBa9m14wObB5nHh7kNXjwqNzzB5Prm1m8ni/7yqbR9+WVYwBrFF6
 NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6Gc8/xhTM
 n8tY8fb6RpYGxgs5XYycHBICJhJbn3ezdTFycQgJLGWUmP7uOBNEQkpiX89/dghbWOLPtS6o
 olYmif1rDrKCJNgEzCQefZkHZHNwiAiYSjzbKwkSZhbIlDj9ah8biC0sYCvRe3I2C4jNIqAq
 seDEO7CZvAJOEhcmvWSEmC8vMfPSd3aQMZwCzhIrv1aChIWASrZ/mMYKUS4ocXLmExaI8fIS
 zVtnM09gFJiFJDULSWoBI9MqRpHU0uLc9NxiQ73ixNzi0rx0veT83E2MwEjYduzn5h2M8159
 1DvEyMTBeIhRgoNZSYR3Q05+ihBvSmJlVWpRfnxRaU5q8SFGU6CzJzJLiSbnA2MxryTe0MzA
 1NDEzNLA1NLMWEmc17OgI1FIID2xJDU7NbUgtQimj4mDU6qBqeLEjhwh2+mpPZEmr08Ea637
 k7J//6vvkk4lX52MYo+4m0jm8jcnfp1w6vbHFP69zSoleyYf4dJawHfJ6MUexi6Dgl+tjw7/
 t93bUmzxX0PDmMlU2WkB95acafX7fu/991IjSnGW3nHNx/5fjEyfiP0zrtXgWvBbW/+fn/ln
 7Xydz4kHGbhTw5bN1/twc3ey/nr+lkt+30V5GuLkV/vr9h7mXvcg1ipg5i4F04a/yf9d0l51
 5Vjct+8y+Vq3rWN/3u67Qd/v/ojcrtv8Rif1ya2yDyxdt9Lzzp71Eg4z37dQ3ndeF7/rqYtc
 tw4evRSePXtBSNbrU5fmVzbWNDvpd3KuPBDw7fsP1sVBbElvlFiKMxINtZiLihMBZQEu8g0D
 AAA=
X-CMS-MailID: 20230525153746eucas1p1957a3a91d90521a6d1c684595c848f52
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230525153746eucas1p1957a3a91d90521a6d1c684595c848f52
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230525153746eucas1p1957a3a91d90521a6d1c684595c848f52
References: <20230525153733.4104-1-t.dzieciol@partner.samsung.com>
 <CGME20230525153746eucas1p1957a3a91d90521a6d1c684595c848f52@eucas1p1.samsung.com>
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

Packet-split descriptors are used by Linux VF driver for MTU values from 2048

Signed-off-by: Tomasz Dzieciol <t.dzieciol@partner.samsung.com>
---
 hw/net/igb_core.c   | 357 ++++++++++++++++++++++++++++++++++++++------
 hw/net/igb_regs.h   |   9 ++
 hw/net/trace-events |   2 +-
 3 files changed, 325 insertions(+), 43 deletions(-)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 2bfae517fc..c1a8dfbca8 100644
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
@@ -1233,12 +1247,25 @@ igb_read_lgcy_rx_descr(IGBCore *core, struct e1000_rx_desc *desc,
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
 typedef struct IGBPacketRxDMAState {
     size_t size;
     size_t total_size;
@@ -1249,20 +1276,41 @@ typedef struct IGBPacketRxDMAState {
     uint32_t rx_desc_header_buf_size;
     struct iovec *iov;
     size_t iov_ofs;
+    bool do_ps;
     bool is_first;
-    uint16_t written;
-    hwaddr ba;
+    IGBBAState bastate;
+    hwaddr ba[IGB_MAX_PS_BUFFERS];
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
@@ -1405,6 +1453,13 @@ igb_write_lgcy_rx_descr(IGBCore *core, struct e1000_rx_desc *desc,
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
@@ -1494,16 +1549,64 @@ igb_write_adv_rx_descr(IGBCore *core, union e1000_adv_rx_desc *desc,
     desc->wb.upper.status_error |= cpu_to_le32(adv_desc_status_error);
 }
 
+typedef struct IGBSplitDescriptorData {
+    bool sph;
+    bool hbo;
+    size_t hdr_len;
+} IGBSplitDescriptorData;
+
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
+                          IGBSplitDescriptorData *ps_desc_data,
+                          IGBPacketRxDMAState *pdma_st)
+{
+    size_t pkt_len;
+    size_t hdr_len = ps_desc_data->hdr_len;
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
+    hdr_info = (hdr_len << E1000_ADVRXD_HDR_LEN_OFFSET) &
+               E1000_ADVRXD_ADV_HDR_LEN_MASK;
+    hdr_info |= ps_desc_data->sph ? E1000_ADVRXD_HDR_SPH : 0;
+    desc->wb.lower.lo_dword.hdr_info = cpu_to_le16(hdr_info);
+
+    desc->wb.upper.status_error |= cpu_to_le32(
+        ps_desc_data->hbo ? E1000_ADVRXD_ST_ERR_HBO_OFFSET : 0);
+}
+
+static inline void
+igb_write_rx_descr(IGBCore *core,
+                   union e1000_rx_desc_union *desc,
+                   struct NetRxPkt *pkt,
+                   const E1000E_RSSInfo *rss_info,
+                   uint16_t etqf,
+                   bool ts,
+                   IGBSplitDescriptorData *ps_desc_data,
+                   IGBPacketRxDMAState *pdma_st,
+                   const E1000ERingInfo *r)
 {
     if (igb_rx_use_legacy_descriptor(core)) {
-        igb_write_lgcy_rx_descr(core, &desc->legacy, pkt, rss_info, length);
+        igb_write_lgcy_rx_descr(core, &desc->legacy, pkt, rss_info,
+                                pdma_st->bastate.written[1]);
+    } else if (igb_rx_use_ps_descriptor(core, r)) {
+        igb_write_adv_ps_rx_descr(core, &desc->adv, pkt, rss_info, r, etqf, ts,
+                                  ps_desc_data, pdma_st);
     } else {
         igb_write_adv_rx_descr(core, &desc->adv, pkt, rss_info,
-                               etqf, ts, length);
+                               etqf, ts, pdma_st->bastate.written[1]);
     }
 }
 
@@ -1564,26 +1667,182 @@ igb_rx_descr_threshold_hit(IGBCore *core, const E1000ERingInfo *rxi)
            ((core->mac[E1000_SRRCTL(rxi->idx) >> 2] >> 20) & 31) * 16;
 }
 
+static bool
+igb_do_ps(IGBCore *core,
+          const E1000ERingInfo *r,
+          struct NetRxPkt *pkt,
+          size_t *hdr_len,
+          IGBSplitDescriptorData *ps_desc_data)
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
+    memset(ps_desc_data, 0, sizeof(IGBSplitDescriptorData));
+
+    total_pkt_len = net_rx_pkt_get_total_len(pkt);
+    bheader_size = igb_rxhdrbufsize(core, r);
+    split_always = igb_rx_ps_descriptor_split_always(core, r);
+    if (split_always && total_pkt_len <= bheader_size) {
+        *hdr_len = total_pkt_len;
+        ps_desc_data->hdr_len = total_pkt_len;
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
+        ps_desc_data->hdr_len = bheader_size;
+        goto header_not_handled;
+    }
+
+    if (fragment && (core->mac[RFCTL] & E1000_RFCTL_IPFRSP_DIS)) {
+        ps_desc_data->hdr_len = bheader_size;
+        goto header_not_handled;
+    }
+
+    /* no header splitting for SCTP */
+    if (!fragment && (l4hdr_proto == ETH_L4_HDR_PROTO_UDP ||
+                      l4hdr_proto == ETH_L4_HDR_PROTO_TCP)) {
+        *hdr_len = net_rx_pkt_get_l5_hdr_offset(pkt);
+    } else {
+        *hdr_len = net_rx_pkt_get_l4_hdr_offset(pkt);
+    }
+
+    ps_desc_data->sph = true;
+    ps_desc_data->hdr_len = *hdr_len;
+
+    if (*hdr_len > bheader_size) {
+        ps_desc_data->hbo = true;
+        goto header_not_handled;
+    }
+
+    return true;
+
+header_not_handled:
+    if (split_always) {
+        *hdr_len = bheader_size;
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
     }
 }
 
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
+    }
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
+}
+
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
@@ -1600,9 +1859,7 @@ igb_write_payload_to_rx_buffers(IGBCore *core,
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
@@ -1618,9 +1875,7 @@ igb_write_payload_to_rx_buffers(IGBCore *core,
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
@@ -1634,7 +1889,7 @@ igb_write_to_rx_buffers(IGBCore *core,
 {
     size_t copy_size;
 
-    if (!pdma_st->ba) {
+    if (!(pdma_st->ba)[1] || (pdma_st->do_ps && !(pdma_st->ba[0]))) {
         /* as per intel docs; skip descriptors with null buf addr */
         trace_e1000e_rx_null_descriptor();
         return;
@@ -1648,6 +1903,14 @@ igb_write_to_rx_buffers(IGBCore *core,
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
 
@@ -1662,6 +1925,7 @@ igb_write_packet_to_guest(IGBCore *core, struct NetRxPkt *pkt,
     union e1000_rx_desc_union desc;
     const E1000ERingInfo *rxi;
     size_t rx_desc_len;
+    IGBSplitDescriptorData ps_desc_data;
 
     IGBPacketRxDMAState pdma_st = {0};
     pdma_st.is_first = true;
@@ -1678,8 +1942,12 @@ igb_write_packet_to_guest(IGBCore *core, struct NetRxPkt *pkt,
         d = core->owner;
     }
 
+    pdma_st.do_ps = igb_do_ps(core, rxi, pkt,
+                              &pdma_st.ps_hdr_len,
+                              &ps_desc_data);
+
     do {
-        pdma_st.written = 0;
+        memset(&pdma_st.bastate, 0, sizeof(IGBBAState));
         bool is_last = false;
 
         if (igb_ring_empty(core, rxi)) {
@@ -1690,7 +1958,7 @@ igb_write_packet_to_guest(IGBCore *core, struct NetRxPkt *pkt,
         pci_dma_read(d, base, &desc, rx_desc_len);
         trace_e1000e_rx_descr(rxi->idx, base, rx_desc_len);
 
-        igb_read_rx_descr(core, &desc, &pdma_st.ba);
+        igb_read_rx_descr(core, &desc, &pdma_st, rxi);
 
         igb_write_to_rx_buffers(core, pkt, d, &pdma_st);
         pdma_st.desc_offset += pdma_st.desc_size;
@@ -1698,8 +1966,13 @@ igb_write_packet_to_guest(IGBCore *core, struct NetRxPkt *pkt,
             is_last = true;
         }
 
-        igb_write_rx_descr(core, &desc, is_last ? core->rx_pkt : NULL,
-                           rss_info, etqf, ts, pdma_st.written);
+        igb_write_rx_descr(core, &desc,
+                           is_last ? pkt : NULL,
+                           rss_info,
+                           etqf, ts,
+                           &ps_desc_data,
+                           &pdma_st,
+                           rxi);
         igb_pci_dma_write_rx_desc(core, d, base, &desc, rx_desc_len);
         igb_ring_advance(core, rxi,
                          rx_desc_len / E1000_MIN_RX_DESC_LEN);
diff --git a/hw/net/igb_regs.h b/hw/net/igb_regs.h
index 36763f2ff7..ed7427b8fe 100644
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
index 159df09014..e97e9dc17b 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -277,7 +277,7 @@ igb_core_mdic_write_unhandled(uint32_t addr) "MDIC WRITE: PHY[%u] UNHANDLED"
 igb_link_set_ext_params(bool asd_check, bool speed_select_bypass, bool pfrstd) "Set extended link params: ASD check: %d, Speed select bypass: %d, PF reset done: %d"
 
 igb_rx_desc_buff_size(uint32_t b) "buffer size: %u"
-igb_rx_desc_buff_write(uint64_t addr, uint16_t offset, const void* source, uint32_t len) "addr: 0x%"PRIx64", offset: %u, from: %p, length: %u"
+igb_rx_desc_buff_write(uint8_t idx, uint64_t addr, uint16_t offset, const void* source, uint32_t len) "buffer %u, addr: 0x%"PRIx64", offset: %u, from: %p, length: %u"
 
 igb_rx_metadata_rss(uint32_t rss, uint16_t rss_pkt_type) "RSS data: rss: 0x%X, rss_pkt_type: 0x%X"
 
-- 
2.25.1


