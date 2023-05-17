Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC26706D33
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 17:49:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzJND-0004jD-ON; Wed, 17 May 2023 11:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.dzieciol@partner.samsung.com>)
 id 1pzJN5-0004i1-15
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:47:23 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.dzieciol@partner.samsung.com>)
 id 1pzJMy-0004fU-S1
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:47:22 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20230517154711euoutp01879ed8a1a20ae2777baa5110502a8504~f_OELgeVC0282502825euoutp01G
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 15:47:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20230517154711euoutp01879ed8a1a20ae2777baa5110502a8504~f_OELgeVC0282502825euoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1684338431;
 bh=8d3d7knSA1h90GUq91lu8F35PzB2WKOhxcES94nBXuU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SRXaKL2KwzxzCFXr2Gqe+tc/D0uBBkBDnbezZRgySXBvAtvYlP9O+XjCooQRIF2if
 hocu5gw8Eu2WIFT3F2ahXx9y/UoFUCd6cczBnhRJva1nbTvbeYIpnqg3q4GCD5uzwk
 N/I1r6RO9DBuT0e8ozxteU6npDNHTAm1hTogR82E=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20230517154710eucas1p29074b3ca0770dc4d6d319a6a400653f3~f_OEBV0hi2204722047eucas1p2H;
 Wed, 17 May 2023 15:47:10 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 1F.BB.35386.EF6F4646; Wed, 17
 May 2023 16:47:10 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20230517154710eucas1p2dffb26312189b86214130220a5da3df8~f_ODrilgY2178421784eucas1p20;
 Wed, 17 May 2023 15:47:10 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20230517154710eusmtrp1eee98032561b0580f116ef0e9ce3a9e6~f_ODq9htk2897228972eusmtrp1Q;
 Wed, 17 May 2023 15:47:10 +0000 (GMT)
X-AuditID: cbfec7f4-cc9ff70000028a3a-b4-6464f6feb698
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 01.17.10549.EF6F4646; Wed, 17
 May 2023 16:47:10 +0100 (BST)
Received: from AMDN5139.EU.corp.samsungelectronics.net (unknown
 [106.210.135.112]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20230517154710eusmtip233d75a9595132da6a2b8bf45026ec756~f_ODKOy5_1593615936eusmtip2k;
 Wed, 17 May 2023 15:47:09 +0000 (GMT)
From: Tomasz Dzieciol <t.dzieciol@partner.samsung.com>
To: qemu-devel@nongnu.org, akihiko.odaki@daynix.com
Cc: sriram.yagnaraman@est.tech, jasowang@redhat.com, k.kwiecien@samsung.com,
 m.sochacki@samsung.com
Subject: [PATCH v7 5/7] igb: add IPv6 extended headers traffic detection
Date: Wed, 17 May 2023 17:47:00 +0200
Message-Id: <20230517154702.4215-6-t.dzieciol@partner.samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230517154702.4215-1-t.dzieciol@partner.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkleLIzCtJLcpLzFFi42LZduzned1/31JSDH6dM7H4fGotu8WyS5+Z
 LBrnz2G12Hr1B7vF8d4dLBa9m14wObB5nHh7kNXjwqNzzB5Prm1m8ni/7yqbR9+WVYwBrFFc
 NimpOZllqUX6dglcGdO3TGEq2MFV8fDFOpYGxpUcXYycHBICJhJNh86xdDFycQgJrGCUuHX7
 LhOE84VRYv2xtUwgVUICnxklnj2ugOmYevAsK0R8OaNEy4tciIZ2JolrrVvAGtgEzCQefZkH
 VMTBISJgLPGxXRwkzCyQKnH0z0EWkLCwgIfE2rmMIGEWAVWJmzv3s4PYvAJOElf2/2eHWCUv
 MfPSdzCbU8BZouPjPjaIGkGJkzOfsECMlJdo3jqbGeQECYG1HBKPl/SwQTS7SHxpWMUMYQtL
 vDq+BWqojMTpyT0sEHa5xM+z29ghmlsYJfZMnQxVZC1xaetPsPuZBTQl1u/Shwg7ShxetJwd
 JCwhwCdx460gxA18EpO2TWeGCPNKdLQJQVTrSHzbNJMNIiwlsfBGHUTYQ+LFp3esExgVZyF5
 ZhaSZ2YhrF3AyLyKUTy1tDg3PbXYKC+1XK84Mbe4NC9dLzk/dxMjMLWc/nf8yw7G5a8+6h1i
 ZOJgPMQowcGsJMIb2JecIsSbklhZlVqUH19UmpNafIhRmoNFSZxX2/ZkspBAemJJanZqakFq
 EUyWiYNTqoGJ3chP62jthzwhlY1LOeSFIs+XbDZtDalUO+bL8nX5jYNLt0ppmb0q3FSftmJO
 svqf/Nhntg98Wx0WqcWvt4vd8Pi8q8SvAomWEN+QftUPwk0PstcEKx7wNZuVlbj+nzpPiLvX
 24KqkLzI52VpsyYxvBZwiG5aFxMouHi/wfyldx5HGd5dvmJyQob2j7kn3MRzri/fmPZxCnfN
 633u0fXfXn+61PfOacuLGfLWO2N0EzP6AthNO1lYsxZ6fFHukPs6zcFz/uGu9as1c8XsJpRO
 uDyPObA9Ufa2e0Cm4pEVhWcDoxRP+05asnph9weVCyVzFkx6vXzKvzOi9i1df5/WLCi0OGSz
 1vvbB54TK7cosRRnJBpqMRcVJwIAaupoRpwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJLMWRmVeSWpSXmKPExsVy+t/xe7r/vqWkGNx+IWfx+dRadotllz4z
 WTTOn8NqsfXqD3aL4707WCx6N71gcmDzOPH2IKvHhUfnmD2eXNvM5PF+31U2j74tqxgDWKP0
 bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0MqZvmcJU
 sIOr4uGLdSwNjCs5uhg5OSQETCSmHjzLCmILCSxllNhziQ0iLiWxr+c/O4QtLPHnWhdQnAuo
 ppVJ4sLpBcwgCTYBM4lHX+YBNXNwiAiYSjzbKwkSZhbIlDj9ah8bSFhYwENi7VxGkDCLgKrE
 zZ37wUbyCjhJXNkPM15eYual72A2p4CzRMfHfWwQ5zhJfHzWwQpRLyhxcuYTFojx8hLNW2cz
 T2AUmIUkNQtJagEj0ypGkdTS4tz03GJDveLE3OLSvHS95PzcTYzAONh27OfmHYzzXn3UO8TI
 xMF4iFGCg1lJhDewLzlFiDclsbIqtSg/vqg0J7X4EKMp0N0TmaVEk/OBkZhXEm9oZmBqaGJm
 aWBqaWasJM7rWdCRKCSQnliSmp2aWpBaBNPHxMEp1cBU8zL2yaWydjVOJZVmobVy1rdXfrNr
 DrzaVqjNwShyeqFEi4WxpUHw4z6/6hWt3+YyqfuKBTzT3JwazKHO+er4YvFrEssNxNdM7ErI
 a78ZtsAr59NRxdl8SvYnPswuVRO4vy3njJvDia1JFx7vdWyKfMKlYq0hNe/ZvZ+Wqi1FNxWy
 G6rMCt4/fKe6L3tHVojb9Jjns1Ido+5vjF3w5L6NV2DCny3dcxlfnv1WNe3Kuzd/Pl9pfSpl
 dPhmUbyR5609n/W7vi9nEkp7vPS6x4p+fa0rmnusEr/8sIs0cKlqSHqZFSPIu5Y3P/62mHRG
 sMp5r83WC8M/cno8OLN/k7T7cbVrjed/2IYUTl9rsFeJpTgj0VCLuag4EQB3wPuWDAMAAA==
X-CMS-MailID: 20230517154710eucas1p2dffb26312189b86214130220a5da3df8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230517154710eucas1p2dffb26312189b86214130220a5da3df8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230517154710eucas1p2dffb26312189b86214130220a5da3df8
References: <20230517154702.4215-1-t.dzieciol@partner.samsung.com>
 <CGME20230517154710eucas1p2dffb26312189b86214130220a5da3df8@eucas1p2.samsung.com>
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

Signed-off-by: Tomasz Dzieciol <t.dzieciol@partner.samsung.com>
---
 hw/net/igb_core.c | 4 +++-
 hw/net/igb_regs.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 605ea09e41..442ad55cc0 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -1415,7 +1415,9 @@ igb_rx_desc_get_packet_type(IGBCore *core, struct NetRxPkt *pkt, uint16_t etqf)
     net_rx_pkt_get_protocols(pkt, &hasip4, &hasip6, &l4hdr_proto);
 
     if (hasip6 && !(core->mac[RFCTL] & E1000_RFCTL_IPV6_DIS)) {
-        pkt_type |= E1000_ADVRXD_PKT_IP6;
+        eth_ip6_hdr_info *ip6hdr_info  = net_rx_pkt_get_ip6_info(pkt);
+        pkt_type |= ip6hdr_info->has_ext_hdrs ? E1000_ADVRXD_PKT_IP6E :
+                                                E1000_ADVRXD_PKT_IP6;
     } else if (hasip4) {
         pkt_type = E1000_ADVRXD_PKT_IP4;
     }
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


