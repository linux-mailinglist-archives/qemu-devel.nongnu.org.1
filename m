Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 730F6706D29
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 17:48:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzJNR-0004lQ-Kd; Wed, 17 May 2023 11:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.dzieciol@partner.samsung.com>)
 id 1pzJN4-0004gm-6o
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:47:22 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.dzieciol@partner.samsung.com>)
 id 1pzJN1-0004gh-Ie
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:47:21 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20230517154712euoutp0139656e044c836c3e3bc86c7955f89c20~f_OFay-5y0116201162euoutp01e
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 15:47:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20230517154712euoutp0139656e044c836c3e3bc86c7955f89c20~f_OFay-5y0116201162euoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1684338432;
 bh=+EdCytTyEcIMBTi04ruCKz6tQx+pv46CQ6JPHaJIiNw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OoR6/RmXd6EzYc8b2jqVZf7A5S2YfkJcCJJncbdQcmdUDPUmcI/Aup9ei/990s+GN
 7xlYKDZo0eWt1yCIBQ8rHJ7n25aiTsc5NOclyzIgmQkllmeovH6fY6dHL59P23PfVQ
 SdLhm54bS5/E9n5w+uzfup9mMDAz2KrcExYSNcmQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20230517154712eucas1p2f225fdb41a9c730228bfd2b80fc78536~f_OFFP0922205122051eucas1p2w;
 Wed, 17 May 2023 15:47:12 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id DF.BB.35386.FF6F4646; Wed, 17
 May 2023 16:47:11 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20230517154711eucas1p124a75ba193bf302825a2fa71d838725f~f_OErlz9E3180031800eucas1p1M;
 Wed, 17 May 2023 15:47:11 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20230517154711eusmtrp1926c6c0efd0f3faa3ad7638f0170483b~f_OErFR7C2897428974eusmtrp1L;
 Wed, 17 May 2023 15:47:11 +0000 (GMT)
X-AuditID: cbfec7f4-cc9ff70000028a3a-b8-6464f6fff0a4
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 1F.F8.14344.FF6F4646; Wed, 17
 May 2023 16:47:11 +0100 (BST)
Received: from AMDN5139.EU.corp.samsungelectronics.net (unknown
 [106.210.135.112]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20230517154711eusmtip20c82b185f48ab13cd6ba7320f79e2dc0~f_OELld7q1009210092eusmtip2Z;
 Wed, 17 May 2023 15:47:11 +0000 (GMT)
From: Tomasz Dzieciol <t.dzieciol@partner.samsung.com>
To: qemu-devel@nongnu.org, akihiko.odaki@daynix.com
Cc: sriram.yagnaraman@est.tech, jasowang@redhat.com, k.kwiecien@samsung.com,
 m.sochacki@samsung.com
Subject: [PATCH v7 7/7] e1000e: rename e1000e_ba_state and
 e1000e_write_hdr_to_rx_buffers
Date: Wed, 17 May 2023 17:47:02 +0200
Message-Id: <20230517154702.4215-8-t.dzieciol@partner.samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230517154702.4215-1-t.dzieciol@partner.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfVCLcRzA/fbs2Z7GeCx3fW/coa6ImtfTjrjkbdc5hM7RXZrtsbBebCXq
 RJIS0pW3VfSia113DWvtMqTmVKSQli5MCF0n7LZbpZTWs07/fX6f7/vdj8B453E+cSgqllJE
 ieXuLA5TXz/40nfULpUuHdCtFlqfV7CFpa1WhjC5IB8XVpkG2MKGS9VM4SVtDyOAJWrsq8NF
 rz63YKLu9kqG6FeNiSXK1JWjHfg+jr+Ukh86RimWrAvnRPzsnxZjmHO88UwLdhrZZ2QgFwLI
 laAt+MF2MI8sQ1Bt98lAnDG2IbjfqcfohxWBWleHJiq6cpJxOqBG8MhscZanMUDzDncwi1wF
 n223xpggZpErwJLm5tAYScHT4Tqmg13JUNDkZbAczCQ94YtmZNxzyUCoV39g0rPmgqq1f7y9
 C7kB0i01LDpnJjxTdTPpnnMhpSpvfFEgKwhQFZY6F90IRtswTrMr9Dbo2DTPgaaci84B8TDY
 rGfTxWcRPLya40xaA61Vg+MHYKQ33DEsofV6qC66gTk0kNOho28mvcN0yNZfd2oupJ/j0dk+
 YNeqWLTmQ1FHEq1FYNX8xbLQ/NxJx+ROOib3/9hChJUjNypOGSmjlMujqHiBUhypjIuSCSTR
 kVo09luaRhps1UjdaxEYEYNARgQE5j6LG5wpkfK4UvGJBEoRvV8RJ6eURjSbYLq7cRevfSbh
 kTJxLHWEomIoxUSUQbjwTzOOxpcsjWzt26TZUxmA71bzdZLNT5IkL7b9Xn9qNChBsN2cZ7hy
 k9Vil2U+iojJTO/0akZcY3RTSn9cS/5dc5Kq9kHzFL9RyZ/hEuKahTTJ08x7O5Wl36b2YudC
 ao/48+qjtw59KpydiL/fsvP7rdupemlFWLhHr+8F/aaun649nTOCX/IbDps9EwPutb15xZlq
 YCOfvK6hw0H3BC6PF5iKr9d6evkWlIsP9rzZ6Jfv0b7V5+SOwtg/e7zmhRRno8ZdBzipfpbX
 8+zhOkVwqIRfLB9it7llvfW2ZfV9NNV8Wv41MMIjv2j1b8wQutBqU3VXrEkM1IbJprkurC8r
 uhxjdGcqI8TLFmEKpfgfSeb2CpwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsVy+t/xe7r/v6WkGCxqVbL4fGotu8WyS5+Z
 LBrnz2G12Hr1B7vF8d4dLBa9m14wObB5nHh7kNXjwqNzzB5Prm1m8ni/7yqbR9+WVYwBrFF6
 NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6Ge++8xTs
 kqk40XSOuYHxG38XIyeHhICJxIPJjaxdjFwcQgJLGSWublnNBpGQktjX858dwhaW+HOtiw2i
 qJVJYtr278wgCTYBM4lHX+YBdXNwiAiYSjzbKwkSZhbIlDj9ah/YHGGBSIn509+BzWERUJV4
 vO4fC4jNK+AkcWz5XRaI+fISMy99B6vhFHCW6PgI0SsEVPPxWQcrRL2gxMmZT1gg5stLNG+d
 zTyBUWAWktQsJKkFjEyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcxAiNh27GfW3Ywrnz1Ue8Q
 IxMH4yFGCQ5mJRHewL7kFCHelMTKqtSi/Pii0pzU4kOMpkB3T2SWEk3OB8ZiXkm8oZmBqaGJ
 maWBqaWZsZI4r2dBR6KQQHpiSWp2ampBahFMHxMHp1QDEzvLjqRNnSaf71rFGu0obWc+Y+oa
 Lvng3tHWP3P7YlQvarAX33hqpaCUp+86x8GdefU2gb2WOyUCu9kKFJ9t/X46ZtflTjn9vPZ5
 /dFtDwReBCT9+lByc/veaQ0ztpbPkfm4gcmdbeLM9/Wuzl1vpY5/DAk4KM2mXJIcyFNSxHp7
 94a37yNZtCKO/X1S9CUm1ku0e5fvb5VHS+p3rKvn9tkavcHk3cS9P3bvWdt8Xr5yGX/rmj27
 /+xdLfGZg+FuxqGO1kfx14z4vxw89OLP97in/CfP1H/Y7Dmjxjp+U8J92wWW8ld99x9Pf8Nq
 8uqRUHGAzYSv6xLfRJ/YbKvUqupuUajz7nN4zoQ1t1M5qpVYijMSDbWYi4oTAfCFploNAwAA
X-CMS-MailID: 20230517154711eucas1p124a75ba193bf302825a2fa71d838725f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230517154711eucas1p124a75ba193bf302825a2fa71d838725f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230517154711eucas1p124a75ba193bf302825a2fa71d838725f
References: <20230517154702.4215-1-t.dzieciol@partner.samsung.com>
 <CGME20230517154711eucas1p124a75ba193bf302825a2fa71d838725f@eucas1p1.samsung.com>
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
index f9ff31fd70..62c5dcfda5 100644
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


