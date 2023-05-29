Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADAB3714B73
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 16:03:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3dRv-0002q1-KF; Mon, 29 May 2023 10:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.dzieciol@partner.samsung.com>)
 id 1q3dRr-0002mm-7A
 for qemu-devel@nongnu.org; Mon, 29 May 2023 10:02:11 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.dzieciol@partner.samsung.com>)
 id 1q3dRp-0006nw-ID
 for qemu-devel@nongnu.org; Mon, 29 May 2023 10:02:10 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20230529140203euoutp01578a6dcf5d812ddf617499fc90db3fea~johs7D_Pi1419514195euoutp010
 for <qemu-devel@nongnu.org>; Mon, 29 May 2023 14:02:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20230529140203euoutp01578a6dcf5d812ddf617499fc90db3fea~johs7D_Pi1419514195euoutp010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1685368923;
 bh=lunVsi6HsaJ1+/9Yrq8KWQx64hHneMocNeqfFm1EqMY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pN2wnzD9qkLxAI1NjozDf5ar3Dg0/CL+k7WvpuCe8m18YdM64tbdD2upOG0qiTYdp
 Uu4bdQqbgatgieRgZsC9Bz1bGtGqSetSHWlLrS5VovcNgmWkReDwNFZUZCix/pnZTl
 czLaA+PWuzz6JXhqZEK6+YGdijvAaFg8qQ7p4ISg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20230529140203eucas1p135a4750334729a519b6d3d9358f9db25~johspkB-L1338413384eucas1p1v;
 Mon, 29 May 2023 14:02:03 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 93.91.42423.A50B4746; Mon, 29
 May 2023 15:02:03 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20230529140202eucas1p1c29796815f0cdf65f72d300842da16b8~johsYLIIR2126721267eucas1p1z;
 Mon, 29 May 2023 14:02:02 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20230529140202eusmtrp21370e5b101f5c2b9b710ba3bda478f71~johsXpS7v0803108031eusmtrp2W;
 Mon, 29 May 2023 14:02:02 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-d8-6474b05a3387
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id A7.38.14344.A50B4746; Mon, 29
 May 2023 15:02:02 +0100 (BST)
Received: from AMDN5139.EU.corp.samsungelectronics.net (unknown
 [106.210.135.112]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20230529140202eusmtip2b0e5e0d734fb1b002de7f2f7017f13eb~johr1TIkt3109331093eusmtip2d;
 Mon, 29 May 2023 14:02:02 +0000 (GMT)
From: Tomasz Dzieciol <t.dzieciol@partner.samsung.com>
To: qemu-devel@nongnu.org, akihiko.odaki@daynix.com
Cc: sriram.yagnaraman@est.tech, jasowang@redhat.com, k.kwiecien@samsung.com,
 m.sochacki@samsung.com
Subject: [PATCH v10 1/7] igb: remove TCP ACK detection
Date: Mon, 29 May 2023 16:01:47 +0200
Message-Id: <20230529140153.4053-2-t.dzieciol@partner.samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230529140153.4053-1-t.dzieciol@partner.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42LZduznOd3oDSUpBve2Mll8PrWW3WLZpc9M
 Fo3z57BabL36g93ieO8OFoveTS+YHNg8Trw9yOpx4dE5Zo8n1zYzebzfd5XNo2/LKsYA1igu
 m5TUnMyy1CJ9uwSujL5dC1kKbrNW9Oy+wNbAuIeli5GTQ0LAROLA/03MXYxcHEICKxglzi5/
 wwbhfGGUWPh5BQuE85lR4vPhs0wwLU1z3rCC2EICyxklZk3OhChqZ5LonL6GGSTBJmAm8ejL
 PKAiDg4RAWOJj+3iIGFmgVSJo38Ogq0WBio5t7EfrJxFQFViw6qNYDavgJNE++/TUOfJS8y8
 9J0dZAyngLNE52kOiBJBiZMzn7BAjJSXaN46G+wDCYG1HBK/dj1nheh1kfjS/Q9qjrDEq+Nb
 2CFsGYn/O+dD/VIu8fPsNnaI5hZGiT1TJ0MVWUtc2voT7H5mAU2J9bv0IcKOEr+2XAQLSwjw
 Sdx4KwhxA5/EpG3TmSHCvBIdbUIQ1ToS3zbNZIMIS0ksvFEHEfaQ+Lmij2kCo+IsJM/MQvLM
 LIS1CxiZVzGKp5YW56anFhvmpZbrFSfmFpfmpesl5+duYgQml9P/jn/awTj31Ue9Q4xMHIyH
 GCU4mJVEeG0Ti1OEeFMSK6tSi/Lji0pzUosPMUpzsCiJ82rbnkwWEkhPLEnNTk0tSC2CyTJx
 cEo1MGWIzA/8XZXIWd976OPGuVbh7S+WXujJ9l2436du7UOWO+XX9wZqTLBi32r4zKeR4Wh/
 s5z+RtNZey4/q/+7977x3zarprKbCpm6ay8e8Xeyn1bjbt63+RbPXd6kbKOeuqX5fBPadrX+
 /1avlVqf81ju/uPIfXEJixY/Xe33TD/K/ISe8rInTQckvyxue83X7OMe8iBOrMPA5AzzE9U/
 +e3y2aKH7/XPWlawSenlsinm/6eEsv64cbbnJ1OxRk0655uQ+lcRp5rt/FUCf/NwnWRQ5d6c
 9si08LLB+kte6Q5W1ZcZnj4Usg2IT+a12ZLX+u3cEYaDr06uDZln1ar1nMfjS03Kp6lX+l+F
 9MQaK7EUZyQaajEXFScCAChN5p+dAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsVy+t/xe7pRG0pSDJY+0rH4fGotu8WyS5+Z
 LBrnz2G12Hr1B7vF8d4dLBa9m14wObB5nHh7kNXjwqNzzB5Prm1m8ni/7yqbR9+WVYwBrFF6
 NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GX27FrIU
 3Gat6Nl9ga2BcQ9LFyMnh4SAiUTTnDesXYxcHEICSxklrp9/yAiRkJLY1/OfHcIWlvhzrYsN
 oqiVSeJH81E2kASbgJnEoy/zgLo5OEQETCWe7ZUECTMLZEqcfrUPrEQYqOTcxn5mEJtFQFVi
 w6qNYDavgJNE++/TUEfIS8y89J0dZAyngLNE52kOkLAQUEnnvZusEOWCEidnPmGBGC8v0bx1
 NvMERoFZSFKzkKQWMDKtYhRJLS3OTc8tNtIrTswtLs1L10vOz93ECIyEbcd+btnBuPLVR71D
 jEwcjIcYJTiYlUR4bROLU4R4UxIrq1KL8uOLSnNSiw8xmgKdPZFZSjQ5HxiLeSXxhmYGpoYm
 ZpYGppZmxkrivJ4FHYlCAumJJanZqakFqUUwfUwcnFINTPvLY9JttVoeZ52Sbja5dN+f86e/
 R50UR3374RmMwXMN4+azPTpwQ+nGjSpm5St7typpr8zWU5OcavqVgWO7H3v7QtMV2ReMLW7x
 8rOq7dqeKN629pb7q//mQfxeuSnPz7ybOCW/9a3LjrVFD0JkEj6K799synFMSbbWZr5X+gqe
 gnVNa1Wzu61mvDstcK4wL32Si115cmfWdkYFySnRh6I4OJ4euXjxeLPlntIHvGzdisenhskt
 jFV84v919ZFNq2/eC4h69bFXRCQ/XPta75Q/totlvFVWTm83firQ/iHbTpMrZnLl9nvJ54R7
 LEwd5W4HbootY271tDGTaL6Q6mYfe+yQ/l/JP7tVtacosRRnJBpqMRcVJwIAKgdF9A0DAAA=
X-CMS-MailID: 20230529140202eucas1p1c29796815f0cdf65f72d300842da16b8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230529140202eucas1p1c29796815f0cdf65f72d300842da16b8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230529140202eucas1p1c29796815f0cdf65f72d300842da16b8
References: <20230529140153.4053-1-t.dzieciol@partner.samsung.com>
 <CGME20230529140202eucas1p1c29796815f0cdf65f72d300842da16b8@eucas1p1.samsung.com>
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

TCP ACK detection is no longer present in igb.

Signed-off-by: Tomasz Dzieciol <t.dzieciol@partner.samsung.com>
---
 hw/net/igb_core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index d00b1caa6a..e927c51061 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -1327,11 +1327,6 @@ igb_build_rx_metadata(IGBCore *core,
             trace_e1000e_rx_metadata_ip_id(*ip_id);
     }
 
-    if (l4hdr_proto == ETH_L4_HDR_PROTO_TCP && net_rx_pkt_is_tcp_ack(pkt)) {
-        *status_flags |= E1000_RXD_STAT_ACK;
-        trace_e1000e_rx_metadata_ack();
-    }
-
     if (pkt_info) {
         *pkt_info = rss_info->enabled ? rss_info->type : 0;
 
-- 
2.25.1


