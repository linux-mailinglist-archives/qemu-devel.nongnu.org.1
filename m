Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBFE710FCD
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 17:39:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2D2L-0003MX-8d; Thu, 25 May 2023 11:37:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.dzieciol@partner.samsung.com>)
 id 1q2D2H-0003I9-1N
 for qemu-devel@nongnu.org; Thu, 25 May 2023 11:37:53 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.dzieciol@partner.samsung.com>)
 id 1q2D2C-0000o7-Fu
 for qemu-devel@nongnu.org; Thu, 25 May 2023 11:37:52 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20230525153746euoutp019fd8e7802c6ae4d3d3fadb1becadbd65~ibQIMlZ9I0295002950euoutp01Q
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 15:37:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20230525153746euoutp019fd8e7802c6ae4d3d3fadb1becadbd65~ibQIMlZ9I0295002950euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1685029066;
 bh=AITdTqYKHscQqKN5hDpOQN76OhnFRQlLVPImMdPnlqM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=goqlmUzxmjJoBurGcBUHCoh/E4zBsCPZl5PCDiwAaYnlb1sta1loqYw8/bvyZvEPk
 PR5W/ohtxREd0njGrGcCt1IcYY25J/dYtfRaSrsyKZpyNPj3B1Vd7EXpXoNFgQG3jI
 MrcqpzSbEA8ZIJPlzd+4cMC3au+qX4R2libBjVDw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20230525153745eucas1p25baa66bc28b1927ae00a8d9d83e7b7a8~ibQH_VUag2952929529eucas1p2O;
 Thu, 25 May 2023 15:37:45 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id FE.28.11320.9C08F646; Thu, 25
 May 2023 16:37:45 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20230525153745eucas1p22c62582ef16e6d6c9da9ab58243414f0~ibQHtXMwi2755027550eucas1p2c;
 Thu, 25 May 2023 15:37:45 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20230525153745eusmtrp20b80a71f20fa9bec49a86418f660a62d~ibQHs3E1I0985909859eusmtrp2_;
 Thu, 25 May 2023 15:37:45 +0000 (GMT)
X-AuditID: cbfec7f4-993ff70000022c38-db-646f80c9d8e8
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id DB.A7.14344.9C08F646; Thu, 25
 May 2023 16:37:45 +0100 (BST)
Received: from AMDN5139.EU.corp.samsungelectronics.net (unknown
 [106.210.135.112]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20230525153745eusmtip2cea6c9a2bece86d3e21724314f902d2a~ibQHKh9kr1970019700eusmtip2V;
 Thu, 25 May 2023 15:37:44 +0000 (GMT)
From: Tomasz Dzieciol <t.dzieciol@partner.samsung.com>
To: qemu-devel@nongnu.org, akihiko.odaki@daynix.com
Cc: sriram.yagnaraman@est.tech, jasowang@redhat.com, k.kwiecien@samsung.com,
 m.sochacki@samsung.com
Subject: [PATCH v9 5/7] igb: add IPv6 extended headers traffic detection
Date: Thu, 25 May 2023 17:37:31 +0200
Message-Id: <20230525153733.4104-6-t.dzieciol@partner.samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230525153733.4104-1-t.dzieciol@partner.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se2xLcRTH/e6jvSuVqx472bCpiGDm0Y2b2Tz3xyWCPyzikdFs14auXdrN
 jJB6bso2qTAbsTWyR2sLZl2qs0Y3VNVmZmVhQRrDjKzVYUXM6hL+++R7vud7zkkOhUvyyDBq
 hzKLUyvlCqlARDTcDTyc7dSqUuea+mSM/36tkKns8GPMwbILJGN2DwoZR4GFYArq3mFLBey9
 j3aSbfe04ezrJ9cxtt/mFrCF9Sa0jtwkik/lFDt2c+o5i7eJ0rt8n4SZjaI91T/f4FpUQ+lQ
 CAV0DHgL9GSQJXQ1gntPKZ4HEOj0i3VINMx+BINNDuJvg8/dSfKFKgSu8iME35GHwSU3E2QB
 vQA8AxeHTRQ1jpaBLy80KOM0B3d+2H/bx9IsFOVXYEEm6GnQ0lSJgiyml0Pr6f4/syKgpOOr
 MBgTQq8A4+dc3jIGnCWvCT4yAg6bz+PBdYC2UPDqiwsF/UAngrFxPB8zFt476oU8T4ShG2UY
 zzkQaG0Q8r1HENw8c/qPaRF0mAO/18fpGXDFOoeXl4HR7iH5+NHQ9XEMv8Jo0DcU47wshvxj
 Et4dBV/qSgS8HAaGrgO8zMKLl6fQKTSl9L9bSv+7pfTf2HKEm1Aol63JSOM085VcTrRGnqHJ
 VqZFp6gy6tDwr7h+OgYsqOq9L7oZYRRqRkDh0nHiqwpVqkScKs/dy6lVW9XZCk7TjMIpQhoq
 npXgTJHQafIsbhfHZXLqv1WMCgnTYutkXXGljeGFRbP9H55LtsTLrlHt35TSid2BhGz7y7wo
 9dTvdckJQ/W6MmPs3pUKqK28Hj4Y2eaKaHkQ3p6Sax+qzZeqetOVibfiDu/KLK/3Fh3fuiS+
 tdB27MfCVVdPHnUujLF4n67fXzOX9N5uuWXNH7EnurcC7z3Qk7DcakbKHLOps4Ld5NeCbWnn
 2ir4rk3WyXyX3/ZMf9Z6dkHxKGvimuMxa4icSNH2pKy+TnN/n6m6ZrMr0mAtOrhKn9ufFDi0
 YV9S22RD7EaaucTu7H5nJOMKbRebjD2xk6Y5BqpXR3lrT+g9EyINIx/ZHhvY5JP3h5pGWM45
 uxl3ieeDlNCky+fNxNUa+S/zOE9zmgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsVy+t/xe7onG/JTDL4sU7L4fGotu8WyS5+Z
 LBrnz2G12Hr1B7vF8d4dLBa9m14wObB5nHh7kNXjwqNzzB5Prm1m8ni/7yqbR9+WVYwBrFF6
 NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GTc+fmIv
 2M1VseLfM+YGxjUcXYycHBICJhIfr15h7WLk4hASWMooceDXHRaIhJTEvp7/7BC2sMSfa11s
 EEWtTBJL525lAkmwCZhJPPoyD6ibg0NEwFTi2V5JkDCzQKbE6Vf72EBsYQEPif6OpWDlLAKq
 Eof3LmMEsXkFnCTOTn4PtUteYual7+wgYzgFnCVWfq0ECQsBlWz/MI0VolxQ4uTMJywQ4+Ul
 mrfOZp7AKDALSWoWktQCRqZVjCKppcW56bnFRnrFibnFpXnpesn5uZsYgZGw7djPLTsYV776
 qHeIkYmD8RCjBAezkgjvhpz8FCHelMTKqtSi/Pii0pzU4kOMpkBnT2SWEk3OB8ZiXkm8oZmB
 qaGJmaWBqaWZsZI4r2dBR6KQQHpiSWp2ampBahFMHxMHp1QDU4vpLIanmx3vlLNufFJ+QpB7
 wm+98IWdj2r3ed45ts+06YprktQnnw9vyja9LMltzHwQ4VZlZJu0eMkZtzWHu4UtQiV6GO3m
 ii/32rDgqpnvuvlnI/U3fuJ8rMN+oOtOYp14uNHJvjfqL59cWBDZoL657cXyE3E73zJsn7Qi
 Yv7KboPvVie17HITfwsvnui/2q1tRdSdmhLF9cwiesIzZnbuvha5qTHEKWHD6YeZ/4qDGLSb
 vzu0WPKbC+/bvf/RdyfuialMFdcvrNaf2ue2P2/DT94JHY5xm3ec67h5nEu56dFrx3VLH61u
 vVVep7b6ssviA07nAqetXilYtEghUDlwWuGFnSYh5k5cki+XcymxFGckGmoxFxUnAgBFfSJM
 DQMAAA==
X-CMS-MailID: 20230525153745eucas1p22c62582ef16e6d6c9da9ab58243414f0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230525153745eucas1p22c62582ef16e6d6c9da9ab58243414f0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230525153745eucas1p22c62582ef16e6d6c9da9ab58243414f0
References: <20230525153733.4104-1-t.dzieciol@partner.samsung.com>
 <CGME20230525153745eucas1p22c62582ef16e6d6c9da9ab58243414f0@eucas1p2.samsung.com>
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
index 8e32f39ece..2bfae517fc 100644
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


