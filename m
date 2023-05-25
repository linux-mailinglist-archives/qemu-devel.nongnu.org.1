Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4795B710FC8
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 17:39:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2D2J-0003KZ-GE; Thu, 25 May 2023 11:37:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.dzieciol@partner.samsung.com>)
 id 1q2D2H-0003ID-2T
 for qemu-devel@nongnu.org; Thu, 25 May 2023 11:37:53 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.dzieciol@partner.samsung.com>)
 id 1q2D2E-0000mU-Mg
 for qemu-devel@nongnu.org; Thu, 25 May 2023 11:37:52 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20230525153744euoutp021e1e717acd1f38bbc47be37ec8bf8a81~ibQGQa-7P0292202922euoutp02T
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 15:37:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20230525153744euoutp021e1e717acd1f38bbc47be37ec8bf8a81~ibQGQa-7P0292202922euoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1685029064;
 bh=lunVsi6HsaJ1+/9Yrq8KWQx64hHneMocNeqfFm1EqMY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mOjCqeyLnUigZvEeRrEL6dueDCvYjEyJaWaKTKZLM4pCBn2bm2i9q58E6kmhDi46v
 GcMKQyC6OcJYQaKlt0XKklzklI9tduckqJR9C6pakVOIa0nWS7QOmkFXfTD3xA8FZ2
 dFmA0ze6NVTka8CM5cfv2KLcDtL77Of0PLMAPf2I=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20230525153743eucas1p24e3b65884024e5cd660bd2d9a5be98d5~ibQGHI5EC2758927589eucas1p2e;
 Thu, 25 May 2023 15:37:43 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id FC.28.11320.7C08F646; Thu, 25
 May 2023 16:37:43 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20230525153743eucas1p2cfe25bb5c0bfc59064189d58b328a537~ibQF0ASXR2954329543eucas1p2Q;
 Thu, 25 May 2023 15:37:43 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20230525153743eusmtrp26c9250e2a7cc97f13ac2e6732a89b71f~ibQFzXLX90985909859eusmtrp22;
 Thu, 25 May 2023 15:37:43 +0000 (GMT)
X-AuditID: cbfec7f4-97dff70000022c38-d4-646f80c74da7
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 48.A7.14344.7C08F646; Thu, 25
 May 2023 16:37:43 +0100 (BST)
Received: from AMDN5139.EU.corp.samsungelectronics.net (unknown
 [106.210.135.112]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20230525153742eusmtip2f38d56f4724934f3c35b9573700e773e~ibQFNmCrd2411924119eusmtip2E;
 Thu, 25 May 2023 15:37:42 +0000 (GMT)
From: Tomasz Dzieciol <t.dzieciol@partner.samsung.com>
To: qemu-devel@nongnu.org, akihiko.odaki@daynix.com
Cc: sriram.yagnaraman@est.tech, jasowang@redhat.com, k.kwiecien@samsung.com,
 m.sochacki@samsung.com
Subject: [PATCH v9 1/7] igb: remove TCP ACK detection
Date: Thu, 25 May 2023 17:37:27 +0200
Message-Id: <20230525153733.4104-2-t.dzieciol@partner.samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230525153733.4104-1-t.dzieciol@partner.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42LZduzned3jDfkpBvs+Glh8PrWW3WLZpc9M
 Fo3z57BabL36g93ieO8OFoveTS+YHNg8Trw9yOpx4dE5Zo8n1zYzebzfd5XNo2/LKsYA1igu
 m5TUnMyy1CJ9uwSujL5dC1kKbrNW9Oy+wNbAuIeli5GTQ0LAROJuw03WLkYuDiGBFYwSZ548
 YoZwvjBK/Pj+lAnC+cwocWd7O1AZB1jLktW6EPHljBLrriyD6mhnkuj/vIkNZC6bgJnEoy/z
 wBpEBIwlPraLg4SZBVIljv45CLZaWMBUovvXZDCbRUBV4vO//2A2r4CTxLl/h5ghzpOXmHnp
 OzvIGE4BZ4mVXyshSgQlTs58wgIxUl6ieetssBMkBLZwSNx70sgI0esisfDQT3YIW1ji1fEt
 ULaMxP+d85kg7HKJn2e3sUM0tzBK7Jk6GarIWuLS1p9g9zMLaEqs36UPEXaUeLV0ARMkHPgk
 brwVhLiBT2LStunMEGFeiY42IYhqHYlvm2ayQYSlJBbeqIMIe0gsuH2HfQKj4iwkz8xC8sws
 hLULGJlXMYqnlhbnpqcWG+WllusVJ+YWl+al6yXn525iBCaX0/+Of9nBuPzVR71DjEwcjIcY
 JTiYlUR4N+TkpwjxpiRWVqUW5ccXleakFh9ilOZgURLn1bY9mSwkkJ5YkpqdmlqQWgSTZeLg
 lGpgKpb4IifC+aRHTbTPPOUVb9+FyaeP24to3p+yO0Zj6qx3OctupOdMWZdXvW/Kpb0Ch2We
 mrvXOX4OVYl44PV+l5OboGjYgqY5Kyq/7GtbcsD1zWyHB12TZoic6nKaOms5t7Lp+T/XX0if
 m3xsd+SuT51cz5TMoz8/u/SlXeP4Y7snNuXF3ZPf62cqVmi7Xy9afKiX+9j/neJq09ecnHpx
 w6q6NZvZvrJs6/wu3SvAbci9sCahwyTsLm9z5WMrL3m2rJTy7PPLktmyGVeV+5/b6PK49z/n
 kz2PRDQ6IhWs7yZbAVPFvPt6e+RDdjq72r5LuPIqi+3Wiulqe1c9XGm6tOhTwYxpnNcZec2n
 KvStUmIpzkg01GIuKk4EADQ1+8CdAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJLMWRmVeSWpSXmKPExsVy+t/xe7rHG/JTDJ6ulLH4fGotu8WyS5+Z
 LBrnz2G12Hr1B7vF8d4dLBa9m14wObB5nHh7kNXjwqNzzB5Prm1m8ni/7yqbR9+WVYwBrFF6
 NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GX27FrIU
 3Gat6Nl9ga2BcQ9LFyMHh4SAicSS1bpdjFwcQgJLGSWmd8xj72LkBIpLSezr+Q9lC0v8udbF
 BlHUyiSx6udrsASbgJnEoy/zWEEGiQiYSjzbKwkSZhbIlDj9ah8biC0MFO7+NZkFxGYRUJX4
 /O8/mM0r4CRx7t8hZoj58hIzL31nBxnDKeAssfJrJUhYCKhk+4dprBDlghInZz5hgRgvL9G8
 dTbzBEaBWUhSs5CkFjAyrWIUSS0tzk3PLTbSK07MLS7NS9dLzs/dxAiMg23Hfm7Zwbjy1Ue9
 Q4xMHIyHGCU4mJVEeDfk5KcI8aYkVlalFuXHF5XmpBYfYjQFOnsis5Rocj4wEvNK4g3NDEwN
 TcwsDUwtzYyVxHk9CzoShQTSE0tSs1NTC1KLYPqYODilGpjCV829yD9TRSvpQ3n+hi1eacFu
 JhpT9R6/iFBO3ybBG+brFqaiUXFX0zql5fqq6xwv9OVcyxKYru2+5MGkfEdK4P48v9DMPb6X
 r5r67extf/tB4/bZNxOjTrA/Ps8a6J447+irkFdVQf+P3bj4oHd+1qekQ84nWhUqeGx+ensf
 7DpRaVDZn5PyJO7C0zWiNxn3m5RaXtFsL3stqr/QKGpBWrryx6vCr0/WB4s8tBKwP/zls/9P
 OeefGtwBb0sY76VI7nXQFTgddFLn6hfNg06C6hNVp3jfWtC551jCuox5iWF33zYs8O64nhWo
 u4dNoXfh8buxnVMu38jN9Kv83j5ZstxNZ/l/9vsyJ5+6blNiKc5INNRiLipOBABMcNYJDAMA
 AA==
X-CMS-MailID: 20230525153743eucas1p2cfe25bb5c0bfc59064189d58b328a537
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230525153743eucas1p2cfe25bb5c0bfc59064189d58b328a537
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230525153743eucas1p2cfe25bb5c0bfc59064189d58b328a537
References: <20230525153733.4104-1-t.dzieciol@partner.samsung.com>
 <CGME20230525153743eucas1p2cfe25bb5c0bfc59064189d58b328a537@eucas1p2.samsung.com>
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


