Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A43714B74
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 16:03:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3dSB-0002sf-57; Mon, 29 May 2023 10:02:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.dzieciol@partner.samsung.com>)
 id 1q3dRt-0002nw-H9
 for qemu-devel@nongnu.org; Mon, 29 May 2023 10:02:13 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.dzieciol@partner.samsung.com>)
 id 1q3dRr-0006pK-PF
 for qemu-devel@nongnu.org; Mon, 29 May 2023 10:02:13 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20230529140207euoutp0152eb2689a4adba32badbc82545c1e3f4~johwSvdS-1419514195euoutp015
 for <qemu-devel@nongnu.org>; Mon, 29 May 2023 14:02:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20230529140207euoutp0152eb2689a4adba32badbc82545c1e3f4~johwSvdS-1419514195euoutp015
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1685368927;
 bh=GpKLeGxhJ948k3AAv+MCQ78nH8+ei8bGGBtWQlF9R0A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=J8vXOo1k89XkK/e/ULddXsCTzqMwe+M1GzPuTlfufYmDdI21Bcji8UENrYs0+ExZI
 DW5N/ulbYJ26hU/xRmb2CMXwcqGBJk3TFyOI9LoL5SB/bhIqBXwKyCckn7m4DhUdPU
 6VXCX2PaQM06MXlT3bRC/jKYBtcLjyFYpCzdQIio=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20230529140206eucas1p25ff5327773a648f415ed4f895e662183~johwA8soG0412804128eucas1p2_;
 Mon, 29 May 2023 14:02:06 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 70.9B.11320.E50B4746; Mon, 29
 May 2023 15:02:06 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20230529140206eucas1p2d93f9498af491b27b4ed36d83f8b9c72~johvXsCmN2932729327eucas1p2k;
 Mon, 29 May 2023 14:02:06 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20230529140206eusmtrp28188e583aab038513d55766d3eaa622c~johvXLaAi1116611166eusmtrp2n;
 Mon, 29 May 2023 14:02:06 +0000 (GMT)
X-AuditID: cbfec7f4-993ff70000022c38-87-6474b05ef3fb
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 7A.38.14344.D50B4746; Mon, 29
 May 2023 15:02:05 +0100 (BST)
Received: from AMDN5139.EU.corp.samsungelectronics.net (unknown
 [106.210.135.112]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20230529140205eusmtip224d89463dce5a091b9c9aab565e76412~johu0OwNW0256502565eusmtip2h;
 Mon, 29 May 2023 14:02:05 +0000 (GMT)
From: Tomasz Dzieciol <t.dzieciol@partner.samsung.com>
To: qemu-devel@nongnu.org, akihiko.odaki@daynix.com
Cc: sriram.yagnaraman@est.tech, jasowang@redhat.com, k.kwiecien@samsung.com,
 m.sochacki@samsung.com
Subject: [PATCH v10 7/7] e1000e: rename e1000e_ba_state and
 e1000e_write_hdr_to_rx_buffers
Date: Mon, 29 May 2023 16:01:53 +0200
Message-Id: <20230529140153.4053-8-t.dzieciol@partner.samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230529140153.4053-1-t.dzieciol@partner.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42LZduznOd24DSUpBp+Oq1p8PrWW3WLZpc9M
 Fo3z57BabL36g93ieO8OFoveTS+YHNg8Trw9yOpx4dE5Zo8n1zYzebzfd5XNo2/LKsYA1igu
 m5TUnMyy1CJ9uwSujKlPr7MW7JKpWL7rIlsD4zf+LkZODgkBE4k/M9YzdjFycQgJrGCUeHrm
 LTOE84VR4uiC6VCZz4wSjddXMsO0vJ36mxHEFhJYzigxv8UAoqidSeLFzG9MIAk2ATOJR1/m
 sXYxcnCICBhLfGwXBwkzC6RKHP1zkAXEFhaIkbg6+wo7iM0ioCpxacF/sFZeASeJRfsnMEHs
 kpeYeek7O8gYTgFnic7THBAlghInZz5hgRgpL9G8dTbY0RICOzgkTs25DNXrIrFi8yUoW1ji
 1fEt7BC2jMT/nfOh4uUSP89uY4dobmGU2DN1MlSRtcSlrT/B7mcW0JRYv0sfIuwosXriJmaQ
 sIQAn8SNt4IQN/BJTNo2HSrMK9HRJgRRrSPxbdNMNoiwlMTCG3UQYQ+J1Sv+sE5gVJyF5JlZ
 SJ6ZhbB2ASPzKkbx1NLi3PTUYqO81HK94sTc4tK8dL3k/NxNjMDkcvrf8S87GJe/+qh3iJGJ
 g/EQowQHs5IIr21icYoQb0piZVVqUX58UWlOavEhRmkOFiVxXm3bk8lCAumJJanZqakFqUUw
 WSYOTqkGJo3CyMiZGlzLDc2/pmU5/1bdqLGcaeIZgYVVrL21Ve90xdhWT++tvPcjbYVn8I1r
 P7eWV+w/e/PZo6PLJ12sPMTzyEq0vMe21HuiwB7HzRf09H6KGV9ISDjS7XxSaHsz0xcPfa8d
 38J5mctrAiZrlfX8fLRcyP3Df9FOpQvKwWH5WnOYQ/KXyAs82Jvtep7D/n3Bx7UGnffXhMcc
 mBr3/xvHnDwzt095S6Jijh/wbaiu2Xj0540A5XeHjzBcPn925vb0DQt5fn63LnPd3OHD9jDW
 dP0VUX+umGt9Rc8ymZr3dZh6Pt4ycX3S567DVY4mvLozRWW7HIUytL4+rX622y8jbrempGRG
 XJXsHiZ7JZbijERDLeai4kQAdPe7iZ0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsVy+t/xe7qxG0pSDBYuNbP4fGotu8WyS5+Z
 LBrnz2G12Hr1B7vF8d4dLBa9m14wObB5nHh7kNXjwqNzzB5Prm1m8ni/7yqbR9+WVYwBrFF6
 NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GVOfXmct
 2CVTsXzXRbYGxm/8XYycHBICJhJvp/5m7GLk4hASWMoo8WHVRCaIhJTEvp7/7BC2sMSfa11s
 EEWtTBJnb19mBkmwCZhJPPoyj7WLkYNDRMBU4tleSZAws0CmxOlX+9hAbGGBKImNB1aAlbMI
 qEpcWvAfbD6vgJPEov0ToHbJS8y89J0dZAyngLNE52kOkLAQUEnnvZusEOWCEidnPmGBGC8v
 0bx1NvMERoFZSFKzkKQWMDKtYhRJLS3OTc8tNtIrTswtLs1L10vOz93ECIyEbcd+btnBuPLV
 R71DjEwcjIcYJTiYlUR4bROLU4R4UxIrq1KL8uOLSnNSiw8xmgKdPZFZSjQ5HxiLeSXxhmYG
 poYmZpYGppZmxkrivJ4FHYlCAumJJanZqakFqUUwfUwcnFINTOUfblx2Otbgw3Tx0XH2e/kc
 Z3c9Plfw6vQpt0/a2WvPqXJc0o1a8y9yXdWhsGNXQ4tVJ9ds/uiu0savFLlR7EHc3UvXn/qz
 rlF/zu2/NW3C23+v/p/Y/lvolQ2/7zqjBZvmrmw09C8PYkkwE53Zz1N/xW9ZznM532cljKsv
 nlTeMulovsQkz2XmZ+4GXP1sdH36lk+PWN6LLPMt7dzTdepIxsNF+cemneO7a9VXNGPXwYap
 6y/J7WbP2R21oO3Xgpayy5fTPHYaWUh88X4xs88xLdxm3ibpv3mty+Wtq4ILGtkjr+1dK7zC
 nGOxFnNE0qH1i2snsDRPnWhotcvc136O+aNZ19f9imvqnrsm8peiEktxRqKhFnNRcSIAkgfg
 1Q0DAAA=
X-CMS-MailID: 20230529140206eucas1p2d93f9498af491b27b4ed36d83f8b9c72
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230529140206eucas1p2d93f9498af491b27b4ed36d83f8b9c72
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230529140206eucas1p2d93f9498af491b27b4ed36d83f8b9c72
References: <20230529140153.4053-1-t.dzieciol@partner.samsung.com>
 <CGME20230529140206eucas1p2d93f9498af491b27b4ed36d83f8b9c72@eucas1p2.samsung.com>
Received-SPF: none client-ip=210.118.77.11;
 envelope-from=t.dzieciol@partner.samsung.com; helo=mailout1.w1.samsung.com
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


