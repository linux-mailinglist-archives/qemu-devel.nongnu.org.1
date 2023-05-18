Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 708BC708385
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 16:05:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzeFk-0007S7-BZ; Thu, 18 May 2023 10:05:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.dzieciol@partner.samsung.com>)
 id 1pzeFi-0007Rl-8X
 for qemu-devel@nongnu.org; Thu, 18 May 2023 10:05:10 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.dzieciol@partner.samsung.com>)
 id 1pzeFa-0003ny-46
 for qemu-devel@nongnu.org; Thu, 18 May 2023 10:05:10 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20230518140500euoutp01e75005d5884e5e19e4f17ec46f33c36d~gQeI46l6F3129531295euoutp01a
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 14:05:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20230518140500euoutp01e75005d5884e5e19e4f17ec46f33c36d~gQeI46l6F3129531295euoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1684418700;
 bh=nEevv5Uux5QBhRz93nfyCQoMbsNGmWbJnhieiq0jaOM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hjrZl+t6fuxkAcumz/njYTjHpgXNm4QAgoUXO4SRLxhWJtCwVRzSdkZoyRgVHcVJW
 XHaoLE+FRL9kb+rXb4F0dkqn4Z41STSfMxrjmgtsedOrCGBzPN8CQbSZAjSqjvbazB
 wjd655Linijh/eh9AWrct0EHuOJWSYLGqJMEvnNk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20230518140500eucas1p1943da3e4133e85eb6d851bd6e0a9c919~gQeIm-VZt0128201282eucas1p12;
 Thu, 18 May 2023 14:05:00 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id DB.B9.37758.B8036646; Thu, 18
 May 2023 15:05:00 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20230518140459eucas1p24761544eb4d24535fa1e8402925817a0~gQeIQJ5vb1801018010eucas1p2L;
 Thu, 18 May 2023 14:04:59 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20230518140459eusmtrp22c6ffee7aac6d634bc23bb5c0c9d1fbb~gQeIPmTkp0300203002eusmtrp2K;
 Thu, 18 May 2023 14:04:59 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-b0-6466308bae9b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 63.61.14344.B8036646; Thu, 18
 May 2023 15:04:59 +0100 (BST)
Received: from AMDN5139.EU.corp.samsungelectronics.net (unknown
 [106.210.135.112]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20230518140459eusmtip229ab9d38b53baeddc1781fdca2beea1a~gQeHtffm02700627006eusmtip25;
 Thu, 18 May 2023 14:04:59 +0000 (GMT)
From: Tomasz Dzieciol <t.dzieciol@partner.samsung.com>
To: qemu-devel@nongnu.org, akihiko.odaki@daynix.com
Cc: sriram.yagnaraman@est.tech, jasowang@redhat.com, k.kwiecien@samsung.com,
 m.sochacki@samsung.com
Subject: [PATCH v8 5/7] igb: add IPv6 extended headers traffic detection
Date: Thu, 18 May 2023 16:04:46 +0200
Message-Id: <20230518140448.2001-6-t.dzieciol@partner.samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230518140448.2001-1-t.dzieciol@partner.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42LZduznOd0eg7QUg3sPGS0+n1rLbrHs0mcm
 i8b5c1gttl79wW5xvHcHi0XvphdMDmweJ94eZPW48Ogcs8eTa5uZPN7vu8rm0bdlFWMAaxSX
 TUpqTmZZapG+XQJXxq+5lQW7uSo+rzvI3MC4hqOLkZNDQsBEYvqFnyxdjFwcQgIrGCWetYI4
 nEDOF0aJbRNtIBKfGSVm3jvMDNPx4t49ZojEckaJxqZHrBBOO5PE32MXWEGq2ATMJB59mQdk
 c3CICBhLfGwXBwkzC6RKHP1zEGyDsICHxN+VLWA2i4CqxLqP98EW8Ao4SZw+u4wNYpm8xMxL
 39lBbE4BZ4mL01cxQtQISpyc+YQFYqa8RPPW2WAHSQhs4ZB4uH8jK0Szi8Saif+YIGxhiVfH
 t7BD2DIS/3fOh4qXS/w8u40dormFUWLP1MlQRdYSl7b+BHuAWUBTYv0ufYiwo8TCSX/BwhIC
 fBI33gpC3MAnMWnbdGaIMK9ER5sQRLWOxLdNM9kgwlISC2/UQYQ9JFZsesw6gVFxFpJnZiF5
 ZhbC2gWMzKsYxVNLi3PTU4uN81LL9YoTc4tL89L1kvNzNzECk8vpf8e/7mBc8eqj3iFGJg7G
 Q4wSHMxKIryBfckpQrwpiZVVqUX58UWlOanFhxilOViUxHm1bU8mCwmkJ5akZqemFqQWwWSZ
 ODilGphmbzfdqpr5g2mp4rWi9bK932dznvKyV/qW8NDrTGA6j1OmyMb1hiuuNziE1EqGH2cO
 ChRgT68I26zaLTQjs+L7hOx8llveIvvPzmM9/22/7xoptrmsP+d0CT941Jd04crdw/FR65wK
 9ua8Sl/8JnDyV/MD7umRcSdCbzK+mvo/1iB08rvJjrd+LxZYfip25YzVh88vFlzufm5B9ILM
 BWyfvnY++nly9qolpyM5nrIau97OEtyjnrfKoZ1tShLjhQXTH57QkXmw6438H82mYOH+v79P
 eBY0FRVq732RGqz1t/7A1GYhJxvlJkWuqwpin98+1OvuZA5rFJ65RvCH1q4LKY8exP7/eWK2
 8CsHDlt9JZbijERDLeai4kQAt/cWCJ0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsVy+t/xe7rdBmkpBndvaVt8PrWW3WLZpc9M
 Fo3z57BabL36g93ieO8OFoveTS+YHNg8Trw9yOpx4dE5Zo8n1zYzebzfd5XNo2/LKsYA1ig9
 m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jF9zKwt2
 c1V8XneQuYFxDUcXIyeHhICJxIt795i7GLk4hASWMkp8O76TFSIhJbGv5z87hC0s8edaFxtE
 USuTxKPpNxlBEmwCZhKPvswDauDgEBEwlXi2VxIkzCyQKXH61T42EFtYwEPi78oWFhCbRUBV
 Yt3H+8wgNq+Ak8Tps8vYIObLS8y89B1sF6eAs8TF6avAxgsB1cw994Adol5Q4uTMJywQ8+Ul
 mrfOZp7AKDALSWoWktQCRqZVjCKppcW56bnFRnrFibnFpXnpesn5uZsYgZGw7djPLTsYV776
 qHeIkYmD8RCjBAezkghvYF9yihBvSmJlVWpRfnxRaU5q8SFGU6C7JzJLiSbnA2MxryTe0MzA
 1NDEzNLA1NLMWEmc17OgI1FIID2xJDU7NbUgtQimj4mDU6qBafFN5l2Re7/6H7rv+vbUTyHN
 PY1cN//wNNv+Nk3M/ztpg4r8h7Rtl5YkXOJQO9Noz/xVgP+587Q5b0PuLFqtaHjlh+i5+/6Z
 wR26/3333rNs2z1BLPj1+Z65nPG2bD3Wt9ZtmrBu/lHemK4azytXNROkz9alhy9daOZrfNUr
 RLCf52fzkYRFpq86lQ8Y+bqt+nfv/W0B9ctZn0WevDj3oy6jPkJGqrZOs+XSJelvRVdaVvom
 fDPwTRMWYV/DHZh1xnpeE9On6oMa6kZtrDbJpq8EWrNKj0gcOFzHHsdUcDrAa/Ohkjj/p6tz
 e1mLObvb+WMrQ9OZZiawcby58mvaxfa9ugdlNT29N/vs/s6txFKckWioxVxUnAgAvV7SFw0D
 AAA=
X-CMS-MailID: 20230518140459eucas1p24761544eb4d24535fa1e8402925817a0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230518140459eucas1p24761544eb4d24535fa1e8402925817a0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230518140459eucas1p24761544eb4d24535fa1e8402925817a0
References: <20230518140448.2001-1-t.dzieciol@partner.samsung.com>
 <CGME20230518140459eucas1p24761544eb4d24535fa1e8402925817a0@eucas1p2.samsung.com>
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
index 7a4a01c4a1..c9aa3dcfa8 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -1415,7 +1415,9 @@ igb_rx_desc_get_packet_type(IGBCore *core, struct NetRxPkt *pkt, uint16_t etqf)
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


