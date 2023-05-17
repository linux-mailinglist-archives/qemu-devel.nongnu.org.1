Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8D6706D2F
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 17:49:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzJNR-0004lE-Ji; Wed, 17 May 2023 11:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.dzieciol@partner.samsung.com>)
 id 1pzJN1-0004fm-3e
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:47:19 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.dzieciol@partner.samsung.com>)
 id 1pzJMy-0004fI-Rf
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:47:18 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20230517154710euoutp01717316009cf5ed98e97e63e46339e9b6~f_OD5_F5K0235102351euoutp01R
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 15:47:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20230517154710euoutp01717316009cf5ed98e97e63e46339e9b6~f_OD5_F5K0235102351euoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1684338430;
 bh=ybHzB1d4xQS35lDW4MWBADg114fq0y9YJRfGGzfBrNQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Du9zVAJwkyqJkz+kbj2wa2MAZTUCMnLmQ3hk4XCXMvSeuM5CpkeGN2CJUqdgGfKDb
 q2fzsAfgnX0XZNM7oIBrayRbioHstPTsnCchEyxU7GLSYdqxXqOhNUQrjv+1KzvqzQ
 0xF+Nc2BJEBGC30WmLAi8Fdb5Z3ZogoYFolb8vWU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20230517154710eucas1p2bd9d6772edfc937568823c647d4310dc~f_ODeOP7D2205122051eucas1p2r;
 Wed, 17 May 2023 15:47:10 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 3E.F4.37758.EF6F4646; Wed, 17
 May 2023 16:47:10 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20230517154710eucas1p16d0d9aa2e516fce8f385fa888a602eb8~f_ODMBy9b2719527195eucas1p1M;
 Wed, 17 May 2023 15:47:10 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20230517154710eusmtrp172284d5e025fe62fa04f5bd6c8f5da47~f_ODLYnsC2897428974eusmtrp1G;
 Wed, 17 May 2023 15:47:10 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-25-6464f6fe3f67
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 2D.F8.14344.DF6F4646; Wed, 17
 May 2023 16:47:09 +0100 (BST)
Received: from AMDN5139.EU.corp.samsungelectronics.net (unknown
 [106.210.135.112]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20230517154709eusmtip23beb019525dd6e07ee5524aa4d059a64~f_OCrtFWN0886608866eusmtip2m;
 Wed, 17 May 2023 15:47:09 +0000 (GMT)
From: Tomasz Dzieciol <t.dzieciol@partner.samsung.com>
To: qemu-devel@nongnu.org, akihiko.odaki@daynix.com
Cc: sriram.yagnaraman@est.tech, jasowang@redhat.com, k.kwiecien@samsung.com,
 m.sochacki@samsung.com
Subject: [PATCH v7 4/7] igb: RX payload guest writting refactoring
Date: Wed, 17 May 2023 17:46:59 +0200
Message-Id: <20230517154702.4215-5-t.dzieciol@partner.samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230517154702.4215-1-t.dzieciol@partner.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkleLIzCtJLcpLzFFi42LZduznOd1/31JSDJZ/4LP4fGotu8WyS5+Z
 LBrnz2G12Hr1B7vF8d4dLBa9m14wObB5nHh7kNXjwqNzzB5Prm1m8ni/7yqbR9+WVYwBrFFc
 NimpOZllqUX6dglcGdcW7GIt6Eqv6D1s0sA406mLkZNDQsBEYtPiM8wgtpDACkaJzxsCuxi5
 gOwvjBJzL91mgnA+M0r8eXaQEabjwd8vrBAdyxklGiZLQRS1M0mcvr+CCSTBJmAm8ejLPKAi
 Dg4RAWOJj+3iIGFmgVSJo38OsoDYwgJOEmdbDoCVswioStz78wAszgsUb9++BmqXvMTMS9/Z
 QWxOAWeJjo/72CBqBCVOznzCAjFTXqJ562xmkBskBFZySGzYd58NotlFYlX7X6hBwhKvjm9h
 h7BlJE5P7mGBsMslfp7dxg7R3MIosWfqZKgia4lLW3+CPcAsoCmxfpc+RNhRYuuaVmaQsIQA
 n8SNt4IQN/BJTNo2HSrMK9HRJgRRrSPxbdNMNoiwlMTCG3UQYQ+JNafaWCcwKs5C8swsJM/M
 Qli7gJF5FaN4amlxbnpqsXFearlecWJucWleul5yfu4mRmBqOf3v+NcdjCtefdQ7xMjEwXiI
 UYKDWUmEN7AvOUWINyWxsiq1KD++qDQntfgQozQHi5I4r7btyWQhgfTEktTs1NSC1CKYLBMH
 p1QDU+guoZX3Mx82TMthd5rG8+3B55if9W9tdz5pXqJq8v3BwbxDz5MWcm4zD4/YOMuy+ITg
 qnubtOrWvUwNMo4OfLBg3vF5y5Yf/6LiWFQwgWN5Z6+Zl0bW88p5c8sesu04EzWld9rDfrWr
 QipzrM1efv61TCq1XvyfwV2GL92PfY4uZm1716kdenHPstWLM2Pkn3o/PyT8L9EwwVTv4IRV
 v9YLhRwNqdkU3nuq0K30Uf7fuaytinF2T/+25x9d0lr8Mrpd9KNM+srjMcLZmwT9Gw1Vls6V
 tD6tOvXQ/BXb0nIW6C3t68hnPeV97+i0HR6mbs4zWD69Ec5f+D/LhK9QyWT9gqfNG8P0eLcI
 BXEleSixFGckGmoxFxUnAgBcD9jAnAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsVy+t/xe7p/v6WkGNzfZmXx+dRadotllz4z
 WTTOn8NqsfXqD3aL4707WCx6N71gcmDzOPH2IKvHhUfnmD2eXNvM5PF+31U2j74tqxgDWKP0
 bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0Mq4t2MVa
 0JVe0XvYpIFxplMXIyeHhICJxIO/X1i7GLk4hASWMko0rv7ACJGQktjX858dwhaW+HOtiw2i
 qJVJYubR62AJNgEziUdf5gF1c3CICJhKPNsrCRJmFsiUOP1qHxuILSzgJHG25QATiM0ioCpx
 788DFhCbFyjevn0N1C55iZmXvoON5BRwluj4CNErBFTz8VkHK0S9oMTJmU9YIObLSzRvnc08
 gVFgFpLULCSpBYxMqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQIjYduxn1t2MK589VHvECMT
 B+MhRgkOZiUR3sC+5BQh3pTEyqrUovz4otKc1OJDjKZAd09klhJNzgfGYl5JvKGZgamhiZml
 gamlmbGSOK9nQUeikEB6YklqdmpqQWoRTB8TB6dUA5PStY/TVTtm9ymrzzCZHmfKyjqvN0T3
 6+Ftx0OPq56cL7usZ8ej1BAn066mG9cE/ij9++MSEaHw6FLj0Qyvte7sodFVVyOPH9dS6/PI
 tTE9r/Zko2GK2+yKFTbfa+92cPzU79l2Vszz1Tfp/NWlHQ+qGu32Tc5O/+Q3v6vxg0TWzWX1
 Ybo/D+8545Hrv4wzaF2t9OXWA8onb4XLnXFWsV2e62qQEdh69Lvu+wsyJbo+MnNnzM3icEj7
 sVj73H/eVdNXPexkm5XjXPHTuvu6UdbBxWGrFR7lXJFQuXp7Zxd/qcLM+YlySVFCuxaVND27
 WNRQUSKrVy/RXOy//kST/MUM1fZG1UUv3dOUNYW+KrEUZyQaajEXFScCAKDwpY4NAwAA
X-CMS-MailID: 20230517154710eucas1p16d0d9aa2e516fce8f385fa888a602eb8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230517154710eucas1p16d0d9aa2e516fce8f385fa888a602eb8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230517154710eucas1p16d0d9aa2e516fce8f385fa888a602eb8
References: <20230517154702.4215-1-t.dzieciol@partner.samsung.com>
 <CGME20230517154710eucas1p16d0d9aa2e516fce8f385fa888a602eb8@eucas1p1.samsung.com>
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
index b2e54fe802..f9ff31fd70 100644
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
index 774b34fc92..605ea09e41 100644
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
@@ -1512,19 +1535,6 @@ igb_pci_dma_write_rx_desc(IGBCore *core, PCIDevice *dev, dma_addr_t addr,
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
@@ -1550,6 +1560,93 @@ igb_rx_descr_threshold_hit(IGBCore *core, const E1000ERingInfo *rxi)
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
@@ -1559,91 +1656,52 @@ igb_write_packet_to_guest(IGBCore *core, struct NetRxPkt *pkt,
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
+        pci_dma_write(d, base, &desc, rx_desc_len);
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


