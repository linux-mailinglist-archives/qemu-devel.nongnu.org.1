Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BE7706D2D
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 17:49:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzJN7-0004ge-4X; Wed, 17 May 2023 11:47:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.dzieciol@partner.samsung.com>)
 id 1pzJMy-0004fi-L2
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:47:19 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.dzieciol@partner.samsung.com>)
 id 1pzJMw-0004fC-Jc
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:47:16 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20230517154709euoutp024ee7c0863923bc51a917d6d64b62e8aa~f_OCVn6Fq0527405274euoutp02Q
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 15:47:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20230517154709euoutp024ee7c0863923bc51a917d6d64b62e8aa~f_OCVn6Fq0527405274euoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1684338429;
 bh=RAdTRgkb5cVy6FP5ribk2kxIlvYd4xCVAvY0Bobfcq8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gJ+k9Z44EYkmb2ivV/AEZRKsuwAmRBEm+yNOUC74G67i93C2ZhNdfDmCvmiHS5v7K
 0Mp9d8Shphj1CkmV8L3yFvvupILtNFH4Hx+cdYSItDXIH1euMUvg0tei7ALlqsOa7K
 teSjo4FdoNBo+NN1iKn/pg8knKmpzJUEPf4nN8R0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20230517154708eucas1p1d45c3f3b6b737c99db4f9f21439588df~f_OCJ77Bj0470004700eucas1p1B;
 Wed, 17 May 2023 15:47:08 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 43.DD.42423.CF6F4646; Wed, 17
 May 2023 16:47:08 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20230517154708eucas1p2cb3cb75a307d9f13d981b07dabf683ee~f_OB0zciG2045220452eucas1p2b;
 Wed, 17 May 2023 15:47:08 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20230517154708eusmtrp10cec8c04e4d26b9ead82c9a6889022c8~f_OB0N2BJ2897228972eusmtrp1I;
 Wed, 17 May 2023 15:47:08 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-47-6464f6fc23ab
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 2D.07.10549.CF6F4646; Wed, 17
 May 2023 16:47:08 +0100 (BST)
Received: from AMDN5139.EU.corp.samsungelectronics.net (unknown
 [106.210.135.112]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20230517154707eusmtip2830b0cc4cb818033cbb7f93c7fd25c50~f_OBPJFhn2117621176eusmtip2s;
 Wed, 17 May 2023 15:47:07 +0000 (GMT)
From: Tomasz Dzieciol <t.dzieciol@partner.samsung.com>
To: qemu-devel@nongnu.org, akihiko.odaki@daynix.com
Cc: sriram.yagnaraman@est.tech, jasowang@redhat.com, k.kwiecien@samsung.com,
 m.sochacki@samsung.com
Subject: [PATCH v7 1/7] igb: remove TCP ACK detection
Date: Wed, 17 May 2023 17:46:56 +0200
Message-Id: <20230517154702.4215-2-t.dzieciol@partner.samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230517154702.4215-1-t.dzieciol@partner.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0iTcRTl9z22T2H1bRZeLLRGD8pShymj1MoKFmQvikSyXNuHs+a0bWZF
 hTHbRm9mD5y9NEyzolrbnCarCbrMtJIsQSIbPbZRhinz0egxv0X9d+6559x7D1wKF5wgY6gC
 lZZRq6RKISeSsLePdy8OBuTyJN1Eknj46R2u+EbPMCY+evUSKbb1jnHF7lMOQnzK4sVWcCRP
 vrpIyQtPNy758PoBJvnm7OVITlsb0EYyJzJNzigL9jHqxIy8SEXAbyGK+8n9g69eYmWohTiO
 Iiigl8Bzg59zHEVSAroegcuu57LFCIJPPW/CxTCCC31vyb+Wj7d/4SEsoOsQGGvnsCIDBjXB
 WizU4NCp4Bm58sdAUdPoZBgyRIdonGagLeiaXB1Fp8Ajl4MbwgQ9FyzGxkmeR2dCr7uRy+6K
 g8qe0UkcQa8C45CTw2r40FH5gWBnxoHOVoWHbgD6DgW2b004a14N1xv84UFR4Hdbw3gmdFac
 DOcvhfEuO5c1lyNoOV8RFi2DHtv4ZACcXgB3mxNZeiWYBt4TIRroKdD3lc/eMAVM9os4S/PA
 qBew6kUQsFRyWDoGqvuOsLQEBut15Fk02/xfGPN/Ycz/1l5DeAOKZko0hfmMRqRiShM00kJN
 iSo/QVZUaEF//qXzp/u7A132DyW0IoxCrQgoXDiNt+m0TC7gyaUHDjLqop3qEiWjaUUzKEIY
 zYtP75AJ6HypltnDMMWM+m8XoyJiyrDcmXdT08+uS8s9XFEXs16RPDunbc0R0etSryAjO4fO
 Jd91ew2ODWm+L+0FIj25+9yEYKgD/9xeU0upl15fJQtO9dWPlxdoA2vy5j+z2xKde73U9GZm
 oJXfmZjVrzXezE7Rcz0/q3xn2mtSzLNUA+6tmRG7zukzlm//kRKb64me5UzSkWhiven2+eGx
 +Kj+ncEZeRnzDdY998fiR2P5inm6gCGq6mn9oVjP4jOjdl/Tcq2124Tv6PLHZd4S7fcdLH9s
 /lHOjT1W+7Fti1P7sqQIc09sljUp1x1TKZtM27wtumvPhNVH+QoXkTW4V+awZlVvvictQ9JP
 q2+s7XgoJDQKqWghrtZIfwMtJ5AAngMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsVy+t/xe7p/vqWkGFy8IGXx+dRadotllz4z
 WTTOn8NqsfXqD3aL4707WCx6N71gcmDzOPH2IKvHhUfnmD2eXNvM5PF+31U2j74tqxgDWKP0
 bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0Mr692sRS
 cJu14t2Vi0wNjHtYuhg5OSQETCServnPDGILCSxllDjz0BAiLiWxr+c/O4QtLPHnWhdbFyMX
 UE0rk8S0w5fBEmwCZhKPvsxj7WLk4BARMJV4tlcSJMwskClx+tU+NhBbGCi8/+AOsHIWAVWJ
 TR3bwfbyCjhJXD2+HWq+vMTMS9/BbE4BZ4mOjxC9QkA1H591sELUC0qcnPmEBWK+vETz1tnM
 ExgFZiFJzUKSWsDItIpRJLW0ODc9t9hQrzgxt7g0L10vOT93EyMwErYd+7l5B+O8Vx/1DjEy
 cTAeYpTgYFYS4Q3sS04R4k1JrKxKLcqPLyrNSS0+xGgKdPdEZinR5HxgLOaVxBuaGZgamphZ
 GphamhkrifN6FnQkCgmkJ5akZqemFqQWwfQxcXBKNTAZPfvubB08y9LbM3+75Y43YvEZpevt
 63a2+M5bLvTh+4ni7uNmx7Sl6h17zeRieHVKj61YXCLVYGTD3lt9OVo2d/XOz+en8ltzsBwU
 qjwYur3517/yVxNveVxhet0tuEM0pbLAZZ5yoqZpStGMbw52uQ/01mcdjsn88oLtf4+094L5
 mQdnXz9btahL4VLriRL5mY1XRCUFNI54L/48yetpzQaLK3d0jJZOlJq/pW23sWOcgMaKRRNW
 rCpMXsp0/Rzb7IuJEx6+XexoPXupLs90320/LrJstK64taXsMP+8NxmH1W65rqnQjNqwjOXi
 mocdMTN2/O4y5HRdy5XwZH1LWNh6dsFMtsk3PBdu+OStxFKckWioxVxUnAgA3r1ahg0DAAA=
X-CMS-MailID: 20230517154708eucas1p2cb3cb75a307d9f13d981b07dabf683ee
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230517154708eucas1p2cb3cb75a307d9f13d981b07dabf683ee
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230517154708eucas1p2cb3cb75a307d9f13d981b07dabf683ee
References: <20230517154702.4215-1-t.dzieciol@partner.samsung.com>
 <CGME20230517154708eucas1p2cb3cb75a307d9f13d981b07dabf683ee@eucas1p2.samsung.com>
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


