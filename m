Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7B8708383
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 16:05:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzeFj-0007Rt-FH; Thu, 18 May 2023 10:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.dzieciol@partner.samsung.com>)
 id 1pzeFf-0007Qn-GZ
 for qemu-devel@nongnu.org; Thu, 18 May 2023 10:05:07 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.dzieciol@partner.samsung.com>)
 id 1pzeFa-0003nh-MV
 for qemu-devel@nongnu.org; Thu, 18 May 2023 10:05:07 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20230518140458euoutp022724a82e319abe0d52086e3a33489f35~gQeGzCQoR2931929319euoutp02u
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 14:04:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20230518140458euoutp022724a82e319abe0d52086e3a33489f35~gQeGzCQoR2931929319euoutp02u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1684418698;
 bh=RAdTRgkb5cVy6FP5ribk2kxIlvYd4xCVAvY0Bobfcq8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=uTTB84Tw4+XathJ1rh4/l9cF9LwLHAMi9VtUb1z2my4l8tNLBgX8lhzlA1DhiAU1A
 3NV9roibtjQiZLyU2H6wCwXRT2bnetMPenMMMIMVTkxoXZbdAUNO7yxqtummmg/Lz7
 dXiRcGdupOsmPZr1Dwb8TsBL7gugZO5KrQ5kHQkw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20230518140458eucas1p1527bb6d1d151c8fdea164fbcb35a971c~gQeGpfZ7j1422214222eucas1p1a;
 Thu, 18 May 2023 14:04:58 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 88.AF.35386.98036646; Thu, 18
 May 2023 15:04:58 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20230518140457eucas1p21b5db6f35c3f2c77081eeaf1779ce3ab~gQeGXvJ051477214772eucas1p21;
 Thu, 18 May 2023 14:04:57 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20230518140457eusmtrp1593fe0cbcc1a68136219becb44692135~gQeGXJ50q3006630066eusmtrp1T;
 Thu, 18 May 2023 14:04:57 +0000 (GMT)
X-AuditID: cbfec7f4-cc9ff70000028a3a-9d-646630891992
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id E2.40.10549.98036646; Thu, 18
 May 2023 15:04:57 +0100 (BST)
Received: from AMDN5139.EU.corp.samsungelectronics.net (unknown
 [106.210.135.112]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20230518140457eusmtip240845607153f194ada952d6b590372a1~gQeF3W_RD0690106901eusmtip2T;
 Thu, 18 May 2023 14:04:57 +0000 (GMT)
From: Tomasz Dzieciol <t.dzieciol@partner.samsung.com>
To: qemu-devel@nongnu.org, akihiko.odaki@daynix.com
Cc: sriram.yagnaraman@est.tech, jasowang@redhat.com, k.kwiecien@samsung.com,
 m.sochacki@samsung.com
Subject: [PATCH v8 1/7] igb: remove TCP ACK detection
Date: Thu, 18 May 2023 16:04:42 +0200
Message-Id: <20230518140448.2001-2-t.dzieciol@partner.samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230518140448.2001-1-t.dzieciol@partner.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42LZduzned0ug7QUgx2tTBafT61lt1h26TOT
 ReP8OawWW6/+YLc43ruDxaJ30wsmBzaPE28PsnpceHSO2ePJtc1MHu/3XWXz6NuyijGANYrL
 JiU1J7MstUjfLoEr49urTSwFt1kr3l25yNTAuIeli5GTQ0LARGLLhFfsXYxcHEICKxgltt9Z
 BeV8YZRo3/mYCcL5zCjRsmMOG0zLu4VX2EFsIYHljBL7TitDFLUzSax4fYsJJMEmYCbx6Ms8
 1i5GDg4RAWOJj+3iIGFmgVSJo38Ogq0WFjCVeLO7iRXEZhFQldg4ZQeYzSvgJPFpzQpWiF3y
 EjMvfQfbxSngLHFx+ipGiBpBiZMzn7BAzJSXaN46mxnkBgmBLRwSPZ+WM0E0u0j8OfYGyhaW
 eHV8CzuELSNxenIP1P/lEj/PbmOHaG5hlNgzdTJUkbXEpa0/wR5gFtCUWL9LHyLsKHHg0W9G
 kLCEAJ/EjbeCEDfwSUzaNp0ZIswr0dEmBFGtI/Ft00w2iLCUxMIbdRBhD4lj166xTGBUnIXk
 mVlInpmFsHYBI/MqRvHU0uLc9NRio7zUcr3ixNzi0rx0veT83E2MwPRy+t/xLzsYl7/6qHeI
 kYmD8RCjBAezkghvYF9yihBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFebduTyUIC6YklqdmpqQWp
 RTBZJg5OqQYmFz3OiZ9zW6+9/J9o5a4XNfOh5NJDZ7fKzzUuVrq1ff9MdfdvKZf0bkxkmXb7
 054dX32/drWv//ROODqHi0OndaKD/YHwwOMK0wPtgjpnxdV/P8jemKLMmWG2zPf0fimdE6vS
 7i+wlX8SnquxkpFv0SOmazK2IqWPvJNiS68d2HRLhm/ugZv+aWVPjdUN/K9LWekWTOGZ7fFz
 pn6ljV+Lt6xa8ga+j5+vHTwTlzvPOsmOubO8fKbHobsd09516zxe+vdI3gOxvl0Nrqdm7kza
 skFG5GfOgaRbb+YV7mLi/G67WURYit2Q4Y1rtfiNPZprC+rzHBbvsF524MO1g3vOv05MuN52
 +EWdvaf66tipSizFGYmGWsxFxYkAUaXUOZ4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNLMWRmVeSWpSXmKPExsVy+t/xe7qdBmkpBss/6lh8PrWW3WLZpc9M
 Fo3z57BabL36g93ieO8OFoveTS+YHNg8Trw9yOpx4dE5Zo8n1zYzebzfd5XNo2/LKsYA1ig9
 m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jG+vNrEU
 3GateHflIlMD4x6WLkZODgkBE4l3C6+wdzFycQgJLGWUWNa+nh0iISWxr+c/lC0s8edaFxtE
 USuTxIfNExlBEmwCZhKPvsxj7WLk4BARMJV4tlcSJMwskClx+tU+NhBbGCj8ZncTK4jNIqAq
 sXHKDjCbV8BJ4tOaFawQ8+UlZl76DraLU8BZ4uL0VWDjhYBq5p57wA5RLyhxcuYTFoj58hLN
 W2czT2AUmIUkNQtJagEj0ypGkdTS4tz03GJDveLE3OLSvHS95PzcTYzAWNh27OfmHYzzXn3U
 O8TIxMF4iFGCg1lJhDewLzlFiDclsbIqtSg/vqg0J7X4EKMp0N0TmaVEk/OB0ZhXEm9oZmBq
 aGJmaWBqaWasJM7rWdCRKCSQnliSmp2aWpBaBNPHxMEp1cA0RWNy0kGZxCPuqV3rrR79FdO4
 H2tw7vvT9E1L7pZL7T27TccoZeW7yA+ZZyed3C48sXHTcSNHRme1iyY6ht+mSJlZewW23nrK
 VPE/iPOiozh/PpNwiUxM8MLXrNnvb3d8657WzHPzxORlrzsWcBpIHrbSMbijuNrbcd/Hv783
 ya6a7TK1/tCXNjuv64239vJr7HmQXKE1ddudnxFnd/hHLT3qY31oqVXtGQfHXcLm3k+PT9YN
 40swD/Gdl8BUnnvBJXPb9lyjCzK3w2RKmhx+r9HmlXZcsnWy+/03mvOvrVe9e76H4a3M0VUr
 m/7O641vm67KOcdva/YNNpsfjiJaBnXHqsprHjSt/Nva126vxFKckWioxVxUnAgAEG4e/A4D
 AAA=
X-CMS-MailID: 20230518140457eucas1p21b5db6f35c3f2c77081eeaf1779ce3ab
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230518140457eucas1p21b5db6f35c3f2c77081eeaf1779ce3ab
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230518140457eucas1p21b5db6f35c3f2c77081eeaf1779ce3ab
References: <20230518140448.2001-1-t.dzieciol@partner.samsung.com>
 <CGME20230518140457eucas1p21b5db6f35c3f2c77081eeaf1779ce3ab@eucas1p2.samsung.com>
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

TCP ACK detection is no longer present in igb.

Signed-off-by: Tomasz Dzieciol <t.dzieciol@partner.samsung.com>
---
 hw/net/igb_core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 96b7335b31..012eb1e1b9 100644
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


