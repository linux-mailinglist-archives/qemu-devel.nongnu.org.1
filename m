Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D629D710FC7
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 17:39:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2D2H-0003IY-R2; Thu, 25 May 2023 11:37:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.dzieciol@partner.samsung.com>)
 id 1q2D2F-0003Hl-Mr
 for qemu-devel@nongnu.org; Thu, 25 May 2023 11:37:51 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.dzieciol@partner.samsung.com>)
 id 1q2D2C-0000oP-L3
 for qemu-devel@nongnu.org; Thu, 25 May 2023 11:37:51 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20230525153747euoutp01e6123464ad188f731978885359582e20~ibQJJBMUL0294602946euoutp01P
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 15:37:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20230525153747euoutp01e6123464ad188f731978885359582e20~ibQJJBMUL0294602946euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1685029067;
 bh=GpKLeGxhJ948k3AAv+MCQ78nH8+ei8bGGBtWQlF9R0A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gJXU2DMqgU3C55GGj1LVRRT+FrY5Xo5SSwSNy6UARDrwcOrP8Mb3mqNVZjMmUUdr8
 jHGP0OLI6PaXm+AfZuQaCxYXtmhyCih4ALN1UnVxgD2l1fXk4BRGMdO1q1DvQb245e
 VRWq5Jd6pTja5mVd6SVSNqzE0AzfE0pFmdZvdv5I=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20230525153747eucas1p2d493d32cefe1afb8ec0cd8d987e46d7a~ibQJAGp-O2952929529eucas1p2Q;
 Thu, 25 May 2023 15:37:47 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id F5.52.37758.AC08F646; Thu, 25
 May 2023 16:37:46 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20230525153746eucas1p2903b5d0ecf65994f9b68ddf039d3d881~ibQItOdET0108401084eucas1p2G;
 Thu, 25 May 2023 15:37:46 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20230525153746eusmtrp1b38e9274d0a3140c4dfc46d88b2da6a6~ibQIsrKLe0099000990eusmtrp1P;
 Thu, 25 May 2023 15:37:46 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-5e-646f80cad5c3
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 1B.C4.10549.AC08F646; Thu, 25
 May 2023 16:37:46 +0100 (BST)
Received: from AMDN5139.EU.corp.samsungelectronics.net (unknown
 [106.210.135.112]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20230525153746eusmtip2671deb7712f3ffb1c811dfadaffa3e84~ibQIO8pPB1848718487eusmtip2Y;
 Thu, 25 May 2023 15:37:46 +0000 (GMT)
From: Tomasz Dzieciol <t.dzieciol@partner.samsung.com>
To: qemu-devel@nongnu.org, akihiko.odaki@daynix.com
Cc: sriram.yagnaraman@est.tech, jasowang@redhat.com, k.kwiecien@samsung.com,
 m.sochacki@samsung.com
Subject: [PATCH v9 7/7] e1000e: rename e1000e_ba_state and
 e1000e_write_hdr_to_rx_buffers
Date: Thu, 25 May 2023 17:37:33 +0200
Message-Id: <20230525153733.4104-8-t.dzieciol@partner.samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230525153733.4104-1-t.dzieciol@partner.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRTmt3t3d11Mr1PwpJJoFpivzKhptV6GsyJXUFFWNtxFpTl1c74i
 s3eN7CVprsfsgZqhqekys8cWttSSNHwkhEzTfPRELUdjq3mN/O873/m+c74Dh8T4arY7mShP
 oxVyicyH4OK6l+a2wJbcZOni4SfhgvGWCo6gpGOcJTiivcYW1HVOcQTGvHpckFczzFpDiF59
 0bNFb/vbMNHHrgcs0bennYToXG05ErN3c1dKaVliOq0IFu7nJlwe7GanNHhmlja0E7nop5Ma
 OZBALYW+e7WYHfOpMgQVFUiNuH/xBIJPeSaCKcYRDPTpWf8cVb8tGNMoRWC5WM1hilMs6P5c
 OT2LoJZB/8QNthqRpCsVCj9OudlpjKKhyaLH7diFigHzAwthxzi1AGxfn01bedQ6aLrbijPL
 vKCo4xfHPsaBWg93J7MYiTM0F33EmZFecKzu6nQeoOpJsD4pn/FGQKG+l2CwC4waazkM9oTW
 /LMzmgwwv9FxGPNxBI2X82dEK6CjzjydH6P84H5DMEOvhdu6z7idBsoRer44Mxkc4ZKuEGNo
 Hpw+yWfUAfCzpohgaHe42ZPD0CLQT97kXEDemlnHaGYdo/m/thhh5ciNVimT4mllqJzOCFJK
 kpQqeXxQXHJSDfr7Lq1W42Q9Khv9EWRALBIZEJCYjyuvSpYs5fOkkqxsWpEcq1DJaKUBeZC4
 jxvPf1VzHJ+Kl6TRB2g6hVb867JIB/dcVojnFW46McbJMf+Oi5wflh4UL1HurJyYemz8ZkHz
 rCbh2Ori88V+IfvaFu3ip4s3CaQb1TYn3xLbYGZ31fMXc920e1aO3LF51EUsEQc7RhuIh2ve
 a4oCN68rGCE3y1PzgV95+J3vh9J9ZKm2vU8NR71xWE6WCA7pwdfipbCNNb7Z4r0/yte4oXuo
 ICwwJ1roaBVGyw76P5LEOizUJQYP7M0I2FY2XpD9Xf54LCa1U9R1zFbP99sYTh/dM8ekubU8
 0q8xdnuYa0O16vWQaQsu7NJarye0JGoNWTvKos6EHonMsfHMKs+e9lsnHh7aesc0tR31ine4
 UNX+2rVWsQ+uTJCELMIUSskfRGiM7p0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsVy+t/xe7qnGvJTDL4s0LD4fGotu8WyS5+Z
 LBrnz2G12Hr1B7vF8d4dLBa9m14wObB5nHh7kNXjwqNzzB5Prm1m8ni/7yqbR9+WVYwBrFF6
 NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GVOfXmct
 2CVTsXzXRbYGxm/8XYycHBICJhIbfv9h7mLk4hASWMooceFbLxNEQkpiX89/dghbWOLPtS42
 iKJWJonvp1azgCTYBMwkHn2Zx9rFyMEhImAq8WyvJEiYWSBT4vSrfWwgtrBApMSvKa8YQWwW
 AVWJ/+/2M4PYvAJOEkdXnmaBmC8vMfPSd3aQMZwCzhIrv1aChIWASrZ/mMYKUS4ocXLmExaI
 8fISzVtnM09gFJiFJDULSWoBI9MqRpHU0uLc9NxiQ73ixNzi0rx0veT83E2MwEjYduzn5h2M
 81591DvEyMTBeIhRgoNZSYR3Q05+ihBvSmJlVWpRfnxRaU5q8SFGU6CzJzJLiSbnA2MxryTe
 0MzA1NDEzNLA1NLMWEmc17OgI1FIID2xJDU7NbUgtQimj4mDU6qBiW2K1fVCC+0Cj1mL2nKC
 9dJmzmiW15Rxvu04c9LZKyd4nDZOP3MyW6Z5Wbt6P7/10rWH/8xg7Hxrz37e6+/mcvY/st7/
 /2W7fbnU8XDL+behabFd+kX699MbixRUPXyOb3ee0pGw6mLcwcRDOUHxv1wV1j7+7bTi0Pap
 KV6PtjgpvVpUvfdalnDKrr17G6uKDPkNen7YPEie+SBG37dRqV22n+EEt6nGgqTuxVevqK/R
 7F+nknn3hZjbDFnXI4dvvd7i0q60/+KX5Jt2ymqvzWbVWx/adnbt/ZzSbYyd9T7XJKaYH+9m
 SAxmqkqWWWfzQvWrftgEg7+JG37+ME299/zc9Ph/t1er5M3YYHdZVYmlOCPRUIu5qDgRACSR
 VwgNAwAA
X-CMS-MailID: 20230525153746eucas1p2903b5d0ecf65994f9b68ddf039d3d881
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230525153746eucas1p2903b5d0ecf65994f9b68ddf039d3d881
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230525153746eucas1p2903b5d0ecf65994f9b68ddf039d3d881
References: <20230525153733.4104-1-t.dzieciol@partner.samsung.com>
 <CGME20230525153746eucas1p2903b5d0ecf65994f9b68ddf039d3d881@eucas1p2.samsung.com>
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

Rename e1000e_ba_state according and e1000e_write_hdr_to_rx_buffers for
consistency with IGB.

Signed-off-by: Tomasz Dzieciol <t.dzieciol@partner.samsung.com>
---
 hw/net/e1000e_core.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index f29e5e2897..bbeafd6fd7 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -1397,17 +1397,17 @@ e1000e_pci_dma_write_rx_desc(E1000ECore *core, dma_addr_t addr,
     }
 }
 
-typedef struct e1000e_ba_state_st {
+typedef struct E1000EBAState {
     uint16_t written[MAX_PS_BUFFERS];
     uint8_t cur_idx;
-} e1000e_ba_state;
+} E1000EBAState;
 
 static inline void
-e1000e_write_hdr_to_rx_buffers(E1000ECore *core,
-                               hwaddr ba[MAX_PS_BUFFERS],
-                               e1000e_ba_state *bastate,
-                               const char *data,
-                               dma_addr_t data_len)
+e1000e_write_hdr_frag_to_rx_buffers(E1000ECore *core,
+                                    hwaddr ba[MAX_PS_BUFFERS],
+                                    E1000EBAState *bastate,
+                                    const char *data,
+                                    dma_addr_t data_len)
 {
     assert(data_len <= core->rxbuf_sizes[0] - bastate->written[0]);
 
@@ -1420,7 +1420,7 @@ e1000e_write_hdr_to_rx_buffers(E1000ECore *core,
 static void
 e1000e_write_payload_frag_to_rx_buffers(E1000ECore *core,
                                         hwaddr ba[MAX_PS_BUFFERS],
-                                        e1000e_ba_state *bastate,
+                                        E1000EBAState *bastate,
                                         const char *data,
                                         dma_addr_t data_len)
 {
@@ -1530,7 +1530,7 @@ e1000e_write_packet_to_guest(E1000ECore *core, struct NetRxPkt *pkt,
 
     do {
         hwaddr ba[MAX_PS_BUFFERS];
-        e1000e_ba_state bastate = { { 0 } };
+        E1000EBAState bastate = { { 0 } };
         bool is_last = false;
 
         desc_size = total_size - desc_offset;
@@ -1568,8 +1568,10 @@ e1000e_write_packet_to_guest(E1000ECore *core, struct NetRxPkt *pkt,
                             iov_copy = MIN(ps_hdr_len - ps_hdr_copied,
                                            iov->iov_len - iov_ofs);
 
-                            e1000e_write_hdr_to_rx_buffers(core, ba, &bastate,
-                                                      iov->iov_base, iov_copy);
+                            e1000e_write_hdr_frag_to_rx_buffers(core, ba,
+                                                                &bastate,
+                                                                iov->iov_base,
+                                                                iov_copy);
 
                             copy_size -= iov_copy;
                             ps_hdr_copied += iov_copy;
@@ -1585,8 +1587,8 @@ e1000e_write_packet_to_guest(E1000ECore *core, struct NetRxPkt *pkt,
                     } else {
                         /* Leave buffer 0 of each descriptor except first */
                         /* empty as per spec 7.1.5.1                      */
-                        e1000e_write_hdr_to_rx_buffers(core, ba, &bastate,
-                                                       NULL, 0);
+                        e1000e_write_hdr_frag_to_rx_buffers(core, ba, &bastate,
+                                                            NULL, 0);
                     }
                 }
 
-- 
2.25.1


