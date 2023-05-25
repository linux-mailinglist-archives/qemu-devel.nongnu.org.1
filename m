Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B74710FCC
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 17:39:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2D2I-0003Jy-E9; Thu, 25 May 2023 11:37:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.dzieciol@partner.samsung.com>)
 id 1q2D2G-0003Hu-9r
 for qemu-devel@nongnu.org; Thu, 25 May 2023 11:37:52 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.dzieciol@partner.samsung.com>)
 id 1q2D2D-0000o2-6A
 for qemu-devel@nongnu.org; Thu, 25 May 2023 11:37:52 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20230525153745euoutp017163aa13a15646b3e181ae3d8c1b9fbc~ibQHw6t1v0295002950euoutp01P
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 15:37:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20230525153745euoutp017163aa13a15646b3e181ae3d8c1b9fbc~ibQHw6t1v0295002950euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1685029065;
 bh=6+yeCNnYMU7Bn+UWrdDvD034/jL7YTPt+NNRRS/nSME=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=D8z2Jielw9hDZMDNWx61vdRWOJtyGkFKz55X9V9uQiNL+G/kfLuSUaU4Rje7qDvDS
 +Pqf3f4UjEPYcRhmVEUpidzQd7fh0UOZKdlV8hX+gekmDrQ8hReMttve3PhvPmMgXG
 i8g+yBfKi8B6ztZKDtWQKY88Le+SN6qFDdGrtDCc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20230525153745eucas1p29b1bbe18c1e4617355a2b486112fe60e~ibQHicujl0108501085eucas1p2B;
 Thu, 25 May 2023 15:37:45 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id ED.28.11320.9C08F646; Thu, 25
 May 2023 16:37:45 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20230525153745eucas1p1cd6d947ed0cd46a8fdf637b514c237ff~ibQHMlqJn0128401284eucas1p13;
 Thu, 25 May 2023 15:37:45 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20230525153745eusmtrp2b96a068ccd0285686e1b94b19ab87f78~ibQHL-YFw0985909859eusmtrp29;
 Thu, 25 May 2023 15:37:45 +0000 (GMT)
X-AuditID: cbfec7f4-97dff70000022c38-da-646f80c95c9c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 5B.A7.14344.8C08F646; Thu, 25
 May 2023 16:37:44 +0100 (BST)
Received: from AMDN5139.EU.corp.samsungelectronics.net (unknown
 [106.210.135.112]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20230525153744eusmtip277d75860e9b8db66ea893769550678a9~ibQGr18Az1886218862eusmtip23;
 Thu, 25 May 2023 15:37:44 +0000 (GMT)
From: Tomasz Dzieciol <t.dzieciol@partner.samsung.com>
To: qemu-devel@nongnu.org, akihiko.odaki@daynix.com
Cc: sriram.yagnaraman@est.tech, jasowang@redhat.com, k.kwiecien@samsung.com,
 m.sochacki@samsung.com
Subject: [PATCH v9 4/7] igb: RX payload guest writting refactoring
Date: Thu, 25 May 2023 17:37:30 +0200
Message-Id: <20230525153733.4104-5-t.dzieciol@partner.samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230525153733.4104-1-t.dzieciol@partner.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42LZduzned2TDfkpBp3TRC0+n1rLbrHs0mcm
 i8b5c1gttl79wW5xvHcHi0XvphdMDmweJ94eZPW48Ogcs8eTa5uZPN7vu8rm0bdlFWMAaxSX
 TUpqTmZZapG+XQJXxqnmDSwFc9IrprS0MzUwrnLqYuTkkBAwkXi3YidLFyMXh5DACkaJv4fu
 M0E4XxglHq6bzwrhfGaUuHbyEBNMy/Xfq6ASyxklHr2ezA7htDNJfP/5D6yKTcBM4tGXeUBV
 HBwiAsYSH9vFQcLMAqkSR/8cZAGxhQWcJP7f7gezWQRUJXb+aWMEsXmB4ls+t7BDLJOXmHnp
 OzvIGE4BZ4mVXyshSgQlTs58wgIxUl6ieetsZpATJATWckhseXuaBaLXRWLe7TtQRwtLvDq+
 BWqmjMT/nfOh4uUSP89uY4dobmGU2DN1MlSRtcSlrT/B7mcW0JRYv0sfIuwo8a1nDyNIWEKA
 T+LGW0GIG/gkJm2bzgwR5pXoaBOCqNaR+LZpJhtEWEpi4Y06iLCHxO1zf9knMCrOQvLMLCTP
 zEJYu4CReRWjeGppcW56arFRXmq5XnFibnFpXrpecn7uJkZgejn97/iXHYzLX33UO8TIxMF4
 iFGCg1lJhHdDTn6KEG9KYmVValF+fFFpTmrxIUZpDhYlcV5t25PJQgLpiSWp2ampBalFMFkm
 Dk6pBiYW7up2u5fak5PSz16/cH3ONi5G34oJdu/LlOVUPlwNmlHkmWyUbD03hH2KmQ7T1YgP
 un+DltRJ/p8fvGTD7IBJDx22Jy9KkS34u9Se0+//vksSTHfi2QsObLYN3uyqpb482UByUam+
 TLfGPu4wlRsmvZMef3/kmJl5a0mwW036iXMq+U0vI6+UT1Hhbljef3cei+b9b1Nv+/xau37a
 saCieIWKEm+r909if7yRjXgszcJ8WHLKvKv7Xm6OuOL0eNsXk4TH0yxFQp0ZfOUFDrjLPa6b
 vKZsSk77Wbtq4Yt3T15+emGrd2JQ8vkEOZ5/77mFFh1vYJymun6mlugVge9S1Ycaf9btDtLo
 3735oZESS3FGoqEWc1FxIgB03g2/ngMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJLMWRmVeSWpSXmKPExsVy+t/xe7onG/JTDObrWHw+tZbdYtmlz0wW
 jfPnsFpsvfqD3eJ47w4Wi95NL5gc2DxOvD3I6nHh0TlmjyfXNjN5vN93lc2jb8sqxgDWKD2b
 ovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2MU80bWArm
 pFdMaWlnamBc5dTFyMkhIWAicf33KtYuRi4OIYGljBIHr+xggUhISezr+c8OYQtL/LnWxQZR
 1Mok8fXVdFaQBJuAmcSjL/OAbA4OEQFTiWd7JUHCzAKZEqdf7WMDsYUFnCT+3+4Hm8kioCqx
 808bI4jNCxTf8rkFar68xMxL39lBxnAKOEus/FoJEhYCKtn+YRorRLmgxMmZT1ggxstLNG+d
 zTyBUWAWktQsJKkFjEyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcxAuNg27GfW3Ywrnz1Ue8Q
 IxMH4yFGCQ5mJRHeDTn5KUK8KYmVValF+fFFpTmpxYcYTYHOnsgsJZqcD4zEvJJ4QzMDU0MT
 M0sDU0szYyVxXs+CjkQhgfTEktTs1NSC1CKYPiYOTqkGpjk7DtgHHr/XOePD9zRPadc98uv1
 LL9o2WRruZbdObD/wN2IyWuLJKt5Ij3DFJIim6Yabby8fI2l0vwPJZ8EVVP4tj5imvtAf3cs
 p4NjO+/hlG8H2fLVJylodtgufXPjVMbkHWsffVvIJRxvPWVmbWy3sv/OqS+5Nk15Y5xXyrTD
 Q7vya7r1G0d7wQ8yt7MMNGU4JP9NWys7e0K4WeTlm6vPMczoqVtxQOWr2LRkDgV/FzPxI59r
 FPZ/XTQx1DLBlOe0/ZQ4jlM9nBvmzCyuWT91nafclZm3U4T9Baevz79u/Tzj8h+ZFZ72EmWB
 8/fW27pNXqooa/aCeWpK5fKLQY4VDamGh/cJ7gtX2xJjr8RSnJFoqMVcVJwIAGu2dJcMAwAA
X-CMS-MailID: 20230525153745eucas1p1cd6d947ed0cd46a8fdf637b514c237ff
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230525153745eucas1p1cd6d947ed0cd46a8fdf637b514c237ff
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230525153745eucas1p1cd6d947ed0cd46a8fdf637b514c237ff
References: <20230525153733.4104-1-t.dzieciol@partner.samsung.com>
 <CGME20230525153745eucas1p1cd6d947ed0cd46a8fdf637b514c237ff@eucas1p1.samsung.com>
Received-SPF: none client-ip=210.118.77.11;
 envelope-from=t.dzieciol@partner.samsung.com; helo=mailout1.w1.samsung.com
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

Refactoring is done in preparation for support of multiple advanced
descriptors RX modes, especially packet-split modes.

Signed-off-by: Tomasz Dzieciol <t.dzieciol@partner.samsung.com>
---
 hw/net/e1000e_core.c     |  18 ++--
 hw/net/igb_core.c        | 214 +++++++++++++++++++++++++--------------
 tests/qtest/libqos/igb.c |   5 +
 3 files changed, 151 insertions(+), 86 deletions(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index f6b628eaef..f29e5e2897 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -1418,11 +1418,11 @@ e1000e_write_hdr_to_rx_buffers(E1000ECore *core,
 }
 
 static void
-e1000e_write_to_rx_buffers(E1000ECore *core,
-                           hwaddr ba[MAX_PS_BUFFERS],
-                           e1000e_ba_state *bastate,
-                           const char *data,
-                           dma_addr_t data_len)
+e1000e_write_payload_frag_to_rx_buffers(E1000ECore *core,
+                                        hwaddr ba[MAX_PS_BUFFERS],
+                                        e1000e_ba_state *bastate,
+                                        const char *data,
+                                        dma_addr_t data_len)
 {
     while (data_len > 0) {
         uint32_t cur_buf_len = core->rxbuf_sizes[bastate->cur_idx];
@@ -1594,8 +1594,10 @@ e1000e_write_packet_to_guest(E1000ECore *core, struct NetRxPkt *pkt,
                 while (copy_size) {
                     iov_copy = MIN(copy_size, iov->iov_len - iov_ofs);
 
-                    e1000e_write_to_rx_buffers(core, ba, &bastate,
-                                            iov->iov_base + iov_ofs, iov_copy);
+                    e1000e_write_payload_frag_to_rx_buffers(core, ba, &bastate,
+                                                            iov->iov_base +
+                                                            iov_ofs,
+                                                            iov_copy);
 
                     copy_size -= iov_copy;
                     iov_ofs += iov_copy;
@@ -1607,7 +1609,7 @@ e1000e_write_packet_to_guest(E1000ECore *core, struct NetRxPkt *pkt,
 
                 if (desc_offset + desc_size >= total_size) {
                     /* Simulate FCS checksum presence in the last descriptor */
-                    e1000e_write_to_rx_buffers(core, ba, &bastate,
+                    e1000e_write_payload_frag_to_rx_buffers(core, ba, &bastate,
                           (const char *) &fcs_pad, e1000x_fcs_len(core->mac));
                 }
             }
diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 3a6df0d55e..8e32f39ece 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -941,6 +941,14 @@ igb_has_rxbufs(IGBCore *core, const E1000ERingInfo *r, size_t total_size)
                          bufsize;
 }
 
+static uint32_t
+igb_rxhdrbufsize(IGBCore *core, const E1000ERingInfo *r)
+{
+    uint32_t srrctl = core->mac[E1000_SRRCTL(r->idx) >> 2];
+    return (srrctl & E1000_SRRCTL_BSIZEHDRSIZE_MASK) >>
+           E1000_SRRCTL_BSIZEHDRSIZE_SHIFT;
+}
+
 void
 igb_start_recv(IGBCore *core)
 {
@@ -1231,6 +1239,21 @@ igb_read_adv_rx_descr(IGBCore *core, union e1000_adv_rx_desc *desc,
     *buff_addr = le64_to_cpu(desc->read.pkt_addr);
 }
 
+typedef struct IGBPacketRxDMAState {
+    size_t size;
+    size_t total_size;
+    size_t ps_hdr_len;
+    size_t desc_size;
+    size_t desc_offset;
+    uint32_t rx_desc_packet_buf_size;
+    uint32_t rx_desc_header_buf_size;
+    struct iovec *iov;
+    size_t iov_ofs;
+    bool is_first;
+    uint16_t written;
+    hwaddr ba;
+} IGBPacketRxDMAState;
+
 static inline void
 igb_read_rx_descr(IGBCore *core, union e1000_rx_desc_union *desc,
                   hwaddr *buff_addr)
@@ -1514,19 +1537,6 @@ igb_pci_dma_write_rx_desc(IGBCore *core, PCIDevice *dev, dma_addr_t addr,
     }
 }
 
-static void
-igb_write_to_rx_buffers(IGBCore *core,
-                        PCIDevice *d,
-                        hwaddr ba,
-                        uint16_t *written,
-                        const char *data,
-                        dma_addr_t data_len)
-{
-    trace_igb_rx_desc_buff_write(ba, *written, data, data_len);
-    pci_dma_write(d, ba + *written, data, data_len);
-    *written += data_len;
-}
-
 static void
 igb_update_rx_stats(IGBCore *core, const E1000ERingInfo *rxi,
                     size_t pkt_size, size_t pkt_fcs_size)
@@ -1552,6 +1562,93 @@ igb_rx_descr_threshold_hit(IGBCore *core, const E1000ERingInfo *rxi)
            ((core->mac[E1000_SRRCTL(rxi->idx) >> 2] >> 20) & 31) * 16;
 }
 
+static void
+igb_truncate_to_descriptor_size(IGBPacketRxDMAState *pdma_st, size_t *size)
+{
+    if (*size > pdma_st->rx_desc_packet_buf_size) {
+        *size = pdma_st->rx_desc_packet_buf_size;
+    }
+}
+
+static void
+igb_write_payload_frag_to_rx_buffers(IGBCore *core,
+                                     PCIDevice *d,
+                                     hwaddr ba,
+                                     uint16_t *written,
+                                     uint32_t cur_buf_len,
+                                     const char *data,
+                                     dma_addr_t data_len)
+{
+    trace_igb_rx_desc_buff_write(ba, *written, data, data_len);
+    pci_dma_write(d, ba + *written, data, data_len);
+    *written += data_len;
+}
+
+static void
+igb_write_payload_to_rx_buffers(IGBCore *core,
+                                struct NetRxPkt *pkt,
+                                PCIDevice *d,
+                                IGBPacketRxDMAState *pdma_st,
+                                size_t *copy_size)
+{
+    static const uint32_t fcs_pad;
+    size_t iov_copy;
+
+    /* Copy packet payload */
+    while (*copy_size) {
+        iov_copy = MIN(*copy_size, pdma_st->iov->iov_len - pdma_st->iov_ofs);
+        igb_write_payload_frag_to_rx_buffers(core, d,
+                                             pdma_st->ba,
+                                             &pdma_st->written,
+                                             pdma_st->rx_desc_packet_buf_size,
+                                             pdma_st->iov->iov_base +
+                                             pdma_st->iov_ofs,
+                                             iov_copy);
+
+        *copy_size -= iov_copy;
+        pdma_st->iov_ofs += iov_copy;
+        if (pdma_st->iov_ofs == pdma_st->iov->iov_len) {
+            pdma_st->iov++;
+            pdma_st->iov_ofs = 0;
+        }
+    }
+
+    if (pdma_st->desc_offset + pdma_st->desc_size >= pdma_st->total_size) {
+        /* Simulate FCS checksum presence in the last descriptor */
+        igb_write_payload_frag_to_rx_buffers(core, d,
+                                             pdma_st->ba,
+                                             &pdma_st->written,
+                                             pdma_st->rx_desc_packet_buf_size,
+                                             (const char *) &fcs_pad,
+                                             e1000x_fcs_len(core->mac));
+    }
+}
+
+static void
+igb_write_to_rx_buffers(IGBCore *core,
+                        struct NetRxPkt *pkt,
+                        PCIDevice *d,
+                        IGBPacketRxDMAState *pdma_st)
+{
+    size_t copy_size;
+
+    if (!pdma_st->ba) {
+        /* as per intel docs; skip descriptors with null buf addr */
+        trace_e1000e_rx_null_descriptor();
+        return;
+    }
+
+    if (pdma_st->desc_offset >= pdma_st->size) {
+        return;
+    }
+
+    pdma_st->desc_size = pdma_st->total_size - pdma_st->desc_offset;
+    igb_truncate_to_descriptor_size(pdma_st, &pdma_st->desc_size);
+    copy_size = pdma_st->size - pdma_st->desc_offset;
+    igb_truncate_to_descriptor_size(pdma_st, &copy_size);
+    igb_write_payload_to_rx_buffers(core, pkt, d, pdma_st, &copy_size);
+}
+
 static void
 igb_write_packet_to_guest(IGBCore *core, struct NetRxPkt *pkt,
                           const E1000E_RxRing *rxr,
@@ -1561,91 +1658,52 @@ igb_write_packet_to_guest(IGBCore *core, struct NetRxPkt *pkt,
     PCIDevice *d;
     dma_addr_t base;
     union e1000_rx_desc_union desc;
-    size_t desc_size;
-    size_t desc_offset = 0;
-    size_t iov_ofs = 0;
-
-    struct iovec *iov = net_rx_pkt_get_iovec(pkt);
-    size_t size = net_rx_pkt_get_total_len(pkt);
-    size_t total_size = size + e1000x_fcs_len(core->mac);
-    const E1000ERingInfo *rxi = rxr->i;
-    size_t bufsize = igb_rxbufsize(core, rxi);
-
+    const E1000ERingInfo *rxi;
+    size_t rx_desc_len;
+
+    IGBPacketRxDMAState pdma_st = {0};
+    pdma_st.is_first = true;
+    pdma_st.size = net_rx_pkt_get_total_len(pkt);
+    pdma_st.total_size = pdma_st.size + e1000x_fcs_len(core->mac);
+
+    rxi = rxr->i;
+    rx_desc_len = core->rx_desc_len;
+    pdma_st.rx_desc_packet_buf_size = igb_rxbufsize(core, rxi);
+    pdma_st.rx_desc_header_buf_size = igb_rxhdrbufsize(core, rxi);
+    pdma_st.iov = net_rx_pkt_get_iovec(pkt);
     d = pcie_sriov_get_vf_at_index(core->owner, rxi->idx % 8);
     if (!d) {
         d = core->owner;
     }
 
     do {
-        hwaddr ba;
-        uint16_t written = 0;
+        pdma_st.written = 0;
         bool is_last = false;
 
-        desc_size = total_size - desc_offset;
-
-        if (desc_size > bufsize) {
-            desc_size = bufsize;
-        }
-
         if (igb_ring_empty(core, rxi)) {
             return;
         }
 
         base = igb_ring_head_descr(core, rxi);
+        pci_dma_read(d, base, &desc, rx_desc_len);
+        trace_e1000e_rx_descr(rxi->idx, base, rx_desc_len);
 
-        pci_dma_read(d, base, &desc, core->rx_desc_len);
-
-        trace_e1000e_rx_descr(rxi->idx, base, core->rx_desc_len);
-
-        igb_read_rx_descr(core, &desc, &ba);
-
-        if (ba) {
-            if (desc_offset < size) {
-                static const uint32_t fcs_pad;
-                size_t iov_copy;
-                size_t copy_size = size - desc_offset;
-                if (copy_size > bufsize) {
-                    copy_size = bufsize;
-                }
-
-                /* Copy packet payload */
-                while (copy_size) {
-                    iov_copy = MIN(copy_size, iov->iov_len - iov_ofs);
-
-                    igb_write_to_rx_buffers(core, d, ba, &written,
-                                            iov->iov_base + iov_ofs, iov_copy);
+        igb_read_rx_descr(core, &desc, &pdma_st.ba);
 
-                    copy_size -= iov_copy;
-                    iov_ofs += iov_copy;
-                    if (iov_ofs == iov->iov_len) {
-                        iov++;
-                        iov_ofs = 0;
-                    }
-                }
-
-                if (desc_offset + desc_size >= total_size) {
-                    /* Simulate FCS checksum presence in the last descriptor */
-                    igb_write_to_rx_buffers(core, d, ba, &written,
-                          (const char *) &fcs_pad, e1000x_fcs_len(core->mac));
-                }
-            }
-        } else { /* as per intel docs; skip descriptors with null buf addr */
-            trace_e1000e_rx_null_descriptor();
-        }
-        desc_offset += desc_size;
-        if (desc_offset >= total_size) {
+        igb_write_to_rx_buffers(core, pkt, d, &pdma_st);
+        pdma_st.desc_offset += pdma_st.desc_size;
+        if (pdma_st.desc_offset >= pdma_st.total_size) {
             is_last = true;
         }
 
         igb_write_rx_descr(core, &desc, is_last ? core->rx_pkt : NULL,
-                           rss_info, etqf, ts, written);
-        igb_pci_dma_write_rx_desc(core, d, base, &desc, core->rx_desc_len);
-
-        igb_ring_advance(core, rxi, core->rx_desc_len / E1000_MIN_RX_DESC_LEN);
-
-    } while (desc_offset < total_size);
+                           rss_info, etqf, ts, pdma_st.written);
+        igb_pci_dma_write_rx_desc(core, d, base, &desc, rx_desc_len);
+        igb_ring_advance(core, rxi,
+                         rx_desc_len / E1000_MIN_RX_DESC_LEN);
+    } while (pdma_st.desc_offset < pdma_st.total_size);
 
-    igb_update_rx_stats(core, rxi, size, total_size);
+    igb_update_rx_stats(core, rxi, pdma_st.size, pdma_st.total_size);
 }
 
 static bool
diff --git a/tests/qtest/libqos/igb.c b/tests/qtest/libqos/igb.c
index a603468beb..f40c4ec4cd 100644
--- a/tests/qtest/libqos/igb.c
+++ b/tests/qtest/libqos/igb.c
@@ -109,6 +109,11 @@ static void igb_pci_start_hw(QOSGraphObject *obj)
                         E1000_RAH_AV | E1000_RAH_POOL_1 |
                         le16_to_cpu(*(uint16_t *)(address + 4)));
 
+    /* Set supported receive descriptor mode */
+    e1000e_macreg_write(&d->e1000e,
+                        E1000_SRRCTL(0),
+                        E1000_SRRCTL_DESCTYPE_ADV_ONEBUF);
+
     /* Enable receive */
     e1000e_macreg_write(&d->e1000e, E1000_RFCTL, E1000_RFCTL_EXTEN);
     e1000e_macreg_write(&d->e1000e, E1000_RCTL, E1000_RCTL_EN);
-- 
2.25.1


