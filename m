Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F0C714B75
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 16:03:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3dRt-0002nP-Bs; Mon, 29 May 2023 10:02:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.dzieciol@partner.samsung.com>)
 id 1q3dRq-0002mX-ON
 for qemu-devel@nongnu.org; Mon, 29 May 2023 10:02:10 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.dzieciol@partner.samsung.com>)
 id 1q3dRn-0006on-A0
 for qemu-devel@nongnu.org; Mon, 29 May 2023 10:02:10 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20230529140205euoutp02ed45e4449d8c7786143ee5a675fca2ba~johuwPaM11118711187euoutp02n
 for <qemu-devel@nongnu.org>; Mon, 29 May 2023 14:02:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20230529140205euoutp02ed45e4449d8c7786143ee5a675fca2ba~johuwPaM11118711187euoutp02n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1685368925;
 bh=BJFwp+qpLy3VsRJdf2coe0wRkVQnD7+Ws+fRABUaS4U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XtYlX0O0G+FSEVj4QmrasU1CaPbmWpJBkaj79/4nM+bMgVyK5fxhrIjfKMzZmntRU
 4/pjmuTW398E2deNPA96LBUzGJo8u084bmLr+5gMsBUIUFBriLChLSBgPVbl5yxY9G
 2xVLLVEEK8IF+s1AjK1rLke8d+ucXwmxI0F523g4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20230529140205eucas1p2c6b3e08bb00efec4d75c9088776322f0~johunAQrf0726107261eucas1p2N;
 Mon, 29 May 2023 14:02:05 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 0F.8B.11320.D50B4746; Mon, 29
 May 2023 15:02:05 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20230529140204eucas1p24077b0c513826b7d22592c77a4e5dbc5~johuVhzJD2932729327eucas1p2j;
 Mon, 29 May 2023 14:02:04 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20230529140204eusmtrp170b3381e32259749e22afecf546323af~johuVABJ10617406174eusmtrp1H;
 Mon, 29 May 2023 14:02:04 +0000 (GMT)
X-AuditID: cbfec7f4-993ff70000022c38-81-6474b05df58e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 8F.06.10549.C50B4746; Mon, 29
 May 2023 15:02:04 +0100 (BST)
Received: from AMDN5139.EU.corp.samsungelectronics.net (unknown
 [106.210.135.112]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20230529140204eusmtip24546d40a3754f1f9b3b3b963a4a04121~johtwNOp80256502565eusmtip2g;
 Mon, 29 May 2023 14:02:04 +0000 (GMT)
From: Tomasz Dzieciol <t.dzieciol@partner.samsung.com>
To: qemu-devel@nongnu.org, akihiko.odaki@daynix.com
Cc: sriram.yagnaraman@est.tech, jasowang@redhat.com, k.kwiecien@samsung.com,
 m.sochacki@samsung.com
Subject: [PATCH v10 5/7] igb: add IPv6 extended headers traffic detection
Date: Mon, 29 May 2023 16:01:51 +0200
Message-Id: <20230529140153.4053-6-t.dzieciol@partner.samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230529140153.4053-1-t.dzieciol@partner.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42LZduzned3YDSUpBiv/cFl8PrWW3WLZpc9M
 Fo3z57BabL36g93ieO8OFoveTS+YHNg8Trw9yOpx4dE5Zo8n1zYzebzfd5XNo2/LKsYA1igu
 m5TUnMyy1CJ9uwSujBP9fAW7uSquP5zH2MC4hqOLkZNDQsBE4u6eTmYQW0hgBaPEhGtqXYxc
 QPYXRolvb54yQTifGSWm33zJ2sXIAdZx670RRHw5o0RT60IWCKedSeLzn9nsIKPYBMwkHn2Z
 B9YgImAs8bFdHCTMLJAqcfTPQRYQW1jAU+J4Yz+YzSKgKvFxykImkHJeASeJrfcjII6Tl5h5
 6Ts7SJhTwFmi8zTYzbwCghInZz5hgZgoL9G8dTYzyAUSAjs4JPb8m8EIcaaLxLlt2hBjhCVe
 Hd/CDmHLSJye3MMCYZdL/Dy7jR2it4VRYs/UyVBF1hKXtv4Eu55ZQFNi/S59iLCjROPGXiaI
 8XwSN94KQpzAJzFp23RmiDCvREebEES1jsS3TTPZIMJSEgtv1EGEPSS2/93POIFRcRaSX2Yh
 +WUWwtoFjMyrGMVTS4tz01OLjfJSy/WKE3OLS/PS9ZLzczcxApPK6X/Hv+xgXP7qo94hRiYO
 xkOMEhzMSiK8tonFKUK8KYmVValF+fFFpTmpxYcYpTlYlMR5tW1PJgsJpCeWpGanphakFsFk
 mTg4pRqYesIzDReU9Eoke/8s+8a6tHP1rRmvPeNX/xVyUcs/3ctTrb1WeeoJuxWxm99tZNlw
 MjPBSET94fefOROvfM4XP5x55s7bKVxvXu5desGDYVe0w5+HQQodh/o6Ll3cHH1opvSNazZx
 0X0FjU7ROqvlnwhe1mh2kztatcVKR983SoX9DheT9mmjj10Xl4hcWq5k2TLbUG69fXD0y5kx
 Z9l/ck/2PTBVdAVbu4ndzMM5nAqly2yXhO9UDqo+LHZpQ7BDn7O5ZeDjsJU3D+qkWLt0mNTn
 M8UrRnYWF5dExu3svi/YpvzziPCu+dHb7Xq/d/VOtGKNCJG0Dj/Vd55jf4DhrkW+bAZNYVYC
 G2qPLFFiKc5INNRiLipOBABtfAWvmQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOLMWRmVeSWpSXmKPExsVy+t/xe7oxG0pSDOb3GVh8PrWW3WLZpc9M
 Fo3z57BabL36g93ieO8OFoveTS+YHNg8Trw9yOpx4dE5Zo8n1zYzebzfd5XNo2/LKsYA1ig9
 m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jBP9fAW7
 uSquP5zH2MC4hqOLkYNDQsBE4tZ7oy5GLg4hgaWMEq8+L2TuYuQEiktJ7Ov5zw5hC0v8udbF
 BlHUyiRxa+txVpAEm4CZxKMv81hBBokImEo82ysJEmYWyJQ4/WofG4gtLOApcbyxnwXEZhFQ
 lfg4ZSETSDmvgJPE1vsREOPlJWZe+s4OEuYUcJboPM0BEhYCqui8dxNsEa+AoMTJmU9YIKbL
 SzRvnc08gVFgFpLULCSpBYxMqxhFUkuLc9Nziw31ihNzi0vz0vWS83M3MQJjYNuxn5t3MM57
 9VHvECMTB+MhRgkOZiURXtvE4hQh3pTEyqrUovz4otKc1OJDjKZAV09klhJNzgdGYV5JvKGZ
 gamhiZmlgamlmbGSOK9nQUeikEB6YklqdmpqQWoRTB8TB6dUA1NgYMLy8181A6eZ7Lg5zXD6
 Xev3i/SPSHCWHYsJvH/JYHes2bNTf2ZO5D9nIyv758bbhmkucpxxWQd+HDhey+tqW10jIXX2
 5lnmPZa3FQyKsiabZj8+lLLnlZwS94vdHT09Roqr/1a/tEhb4rKe+6fx3MNefdFXFzR4XlrO
 Uq2ye8PXubN3+9rfqv20/M6SnR4Pgv3K/y1ocvCK2BiQ39q173iO+aUZe7qemb1Nf9PgyMe/
 5HL7q20RXIb375w+E/1m0e4Nb4J2cRxiUC+Wmi73cr5d4Zs1RyOMN8ZtrbjTtawuwl/hVbFw
 xHZVFc3kyYY1zMlSFmVp0QvCGTRjFqRZtYvLTpeullM1t0z+5KHEUpyRaKjFXFScCAAxHRNg
 CgMAAA==
X-CMS-MailID: 20230529140204eucas1p24077b0c513826b7d22592c77a4e5dbc5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230529140204eucas1p24077b0c513826b7d22592c77a4e5dbc5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230529140204eucas1p24077b0c513826b7d22592c77a4e5dbc5
References: <20230529140153.4053-1-t.dzieciol@partner.samsung.com>
 <CGME20230529140204eucas1p24077b0c513826b7d22592c77a4e5dbc5@eucas1p2.samsung.com>
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

Signed-off-by: Tomasz Dzieciol <t.dzieciol@partner.samsung.com>
---
 hw/net/igb_core.c | 4 +++-
 hw/net/igb_regs.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 8c248683c3..b54d7af8d8 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -1420,7 +1420,9 @@ igb_rx_desc_get_packet_type(IGBCore *core, struct NetRxPkt *pkt, uint16_t etqf)
     net_rx_pkt_get_protocols(pkt, &hasip4, &hasip6, &l4hdr_proto);
 
     if (hasip6 && !(core->mac[RFCTL] & E1000_RFCTL_IPV6_DIS)) {
-        pkt_type = E1000_ADVRXD_PKT_IP6;
+        eth_ip6_hdr_info *ip6hdr_info = net_rx_pkt_get_ip6_info(pkt);
+        pkt_type = ip6hdr_info->has_ext_hdrs ? E1000_ADVRXD_PKT_IP6E :
+                                               E1000_ADVRXD_PKT_IP6;
     } else if (hasip4) {
         pkt_type = E1000_ADVRXD_PKT_IP4;
     } else {
diff --git a/hw/net/igb_regs.h b/hw/net/igb_regs.h
index 71a8833229..36763f2ff7 100644
--- a/hw/net/igb_regs.h
+++ b/hw/net/igb_regs.h
@@ -694,6 +694,7 @@ union e1000_adv_rx_desc {
 
 #define E1000_ADVRXD_PKT_IP4  BIT(0)
 #define E1000_ADVRXD_PKT_IP6  BIT(2)
+#define E1000_ADVRXD_PKT_IP6E BIT(3)
 #define E1000_ADVRXD_PKT_TCP  BIT(4)
 #define E1000_ADVRXD_PKT_UDP  BIT(5)
 #define E1000_ADVRXD_PKT_SCTP BIT(6)
-- 
2.25.1


