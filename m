Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D297708384
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 16:05:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzeFr-0007U2-ET; Thu, 18 May 2023 10:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.dzieciol@partner.samsung.com>)
 id 1pzeFo-0007TX-Sh
 for qemu-devel@nongnu.org; Thu, 18 May 2023 10:05:16 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.dzieciol@partner.samsung.com>)
 id 1pzeFa-0003oZ-MX
 for qemu-devel@nongnu.org; Thu, 18 May 2023 10:05:16 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20230518140501euoutp026b169745970b37e7178bebbc3b09a172~gQeJ5bz682928729287euoutp02D
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 14:05:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20230518140501euoutp026b169745970b37e7178bebbc3b09a172~gQeJ5bz682928729287euoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1684418701;
 bh=+EdCytTyEcIMBTi04ruCKz6tQx+pv46CQ6JPHaJIiNw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oyl6LZ/M4c9DPLD6+KniV3Fhs9jf7kiidZ7kF8V7TxyqW1w5pkj/Rt12h5Uo5bhoQ
 6lkPsViNdstCqyYri2eobKb4+znI4wY+gHCnO/CcrGWOF2cFFGZREN6vWrTx45F8mr
 0KScaMTl2eQhFVHSvCuH30PeVBQ5tHWBXt7utSLU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20230518140501eucas1p1b5537dc823473ea3e588b66039cbee0b~gQeJpKRKL1421314213eucas1p1b;
 Thu, 18 May 2023 14:05:01 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 8A.AF.35386.D8036646; Thu, 18
 May 2023 15:05:01 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20230518140500eucas1p1f92e6605c8a68a68d564ef5ad5de66dd~gQeJKySbu0591205912eucas1p1N;
 Thu, 18 May 2023 14:05:00 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20230518140500eusmtrp1d285209af9287c3ee3092c26d823d359~gQeJKRDKA3006630066eusmtrp1c;
 Thu, 18 May 2023 14:05:00 +0000 (GMT)
X-AuditID: cbfec7f4-cdfff70000028a3a-a4-6466308d6166
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 46.40.10549.C8036646; Thu, 18
 May 2023 15:05:00 +0100 (BST)
Received: from AMDN5139.EU.corp.samsungelectronics.net (unknown
 [106.210.135.112]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20230518140500eusmtip256b469c720fd64bb0ba23700b407c106~gQeIsdfjo2700627006eusmtip26;
 Thu, 18 May 2023 14:05:00 +0000 (GMT)
From: Tomasz Dzieciol <t.dzieciol@partner.samsung.com>
To: qemu-devel@nongnu.org, akihiko.odaki@daynix.com
Cc: sriram.yagnaraman@est.tech, jasowang@redhat.com, k.kwiecien@samsung.com,
 m.sochacki@samsung.com
Subject: [PATCH v8 7/7] e1000e: rename e1000e_ba_state and
 e1000e_write_hdr_to_rx_buffers
Date: Thu, 18 May 2023 16:04:48 +0200
Message-Id: <20230518140448.2001-8-t.dzieciol@partner.samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230518140448.2001-1-t.dzieciol@partner.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42LZduzned1eg7QUg0kt/BafT61lt1h26TOT
 ReP8OawWW6/+YLc43ruDxaJ30wsmBzaPE28PsnpceHSO2ePJtc1MHu/3XWXz6NuyijGANYrL
 JiU1J7MstUjfLoEr4913noJdMhUnms4xNzB+4+9i5OSQEDCR+L/qIWsXIxeHkMAKRon+F++Y
 IJwvjBJTfj9jhnA+M0rMv/iHDaZlx55fUInljBI/uj4wQjjtTBJrF81iAqliEzCTePRlHtBg
 Dg4RAWOJj+3iIGFmgVSJo38OsoDYwgLREo2LFrCD2CwCqhKdr6eA2bwCThLXLp9igVgmLzHz
 0newOKeAs8TF6asYIWoEJU7OfMICMVNeonnrbLCDJAS2cEh0PrvHCNHsIvFy8REmCFtY4tXx
 LewQtozE6ck9UAvKJX6e3cYO0dzCKLFn6mSoImuJS1t/gj3ALKApsX6XPkTYUeLs0QY2kLCE
 AJ/EjbeCEDfwSUzaNp0ZIswr0dEmBFGtI/Ft00yoaimJhTfqIMIeEhdW32CewKg4C8kzs5A8
 Mwth7QJG5lWM4qmlxbnpqcVGeanlesWJucWleel6yfm5mxiB6eX0v+NfdjAuf/VR7xAjEwfj
 IUYJDmYlEd7AvuQUId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzatieThQTSE0tSs1NTC1KLYLJM
 HJxSDUxCp8OP61ySaCnUmii0muuCZflEXfMPhlEf7f7ydF5do3NwcnX3nVVF952PXm5896Iv
 u1Lj14FTtQ6dc/wWpqTvWcUZkRDyxP9Uy7LpBi3N2tcmes62TJb/3fbBec/CCTfZzkk9fedu
 MeHXrlAGoXNJXlkqS7PMpxqXcTx2y9jmbbqXu7Cst23t7xuBZ7/88jvpmrpl9gujrbPU3s1p
 mvbq4IuWOtucosa9t56FvXmreXrWvx/+VaX/2L18kj45fQvuW9p6s35vxKef+kxiMqlnjdjy
 Vijo6cz9xrX8eQCf+4Vas801mqEbBAInTFIVP3bRVPk8H5eobhCrq/29bg2P+zfu/5r2/1a7
 obxi7xIlluKMREMt5qLiRABH/WSTngMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsVy+t/xe7o9BmkpBv+X6Vp8PrWW3WLZpc9M
 Fo3z57BabL36g93ieO8OFoveTS+YHNg8Trw9yOpx4dE5Zo8n1zYzebzfd5XNo2/LKsYA1ig9
 m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jHffeQp2
 yVScaDrH3MD4jb+LkZNDQsBEYseeX8xdjFwcQgJLGSU+/b3DBJGQktjX858dwhaW+HOtiw2i
 qJVJ4uSv9WwgCTYBM4lHX+axdjFycIgImEo82ysJEmYWyJQ4/WofWImwQKTE7C6IchYBVYnO
 11PAZvIKOElcu3yKBWK+vMTMS9/B4pwCzhIXp69iBLGFgGrmnnsAVS8ocXLmExaI+fISzVtn
 M09gFJiFJDULSWoBI9MqRpHU0uLc9NxiQ73ixNzi0rx0veT83E2MwEjYduzn5h2M81591DvE
 yMTBeIhRgoNZSYQ3sC85RYg3JbGyKrUoP76oNCe1+BCjKdDdE5mlRJPzgbGYVxJvaGZgamhi
 ZmlgamlmrCTO61nQkSgkkJ5YkpqdmlqQWgTTx8TBKdXAdPz8n8rY7Vaz/GbvmHOzsIF72j1p
 zsX7/nQybuhR2JgjG956P5ffbMG9H1u23P1e3nB/Y3p89f/DUzL37FNYfV3VTFKpwUlX+Z3Z
 umO+ascqu70OZprlBF/uZfth7ixvfe9WWZ9uVOun3NVTlrYXu+x/Eb5pynUrrU1PjW+sSNzg
 8MLgVNm84Ayzb1d9K39+2aO4vpOTu6i4hUlwep596r1nOgbit05v3rrrhhhrTTmPxYFfPAm3
 bk16GXxoZVIu+3sHZt5HD7+slZn+/IBO4a+oOf4XPnFMs+/ZEb792Qz76ZO2zKmYxLRoaZ2B
 cYzNolAx0Rd5gUs3T/y/uqzzuPmL8jcBFp5z533ef+f3uTYlluKMREMt5qLiRACUcGtjDQMA
 AA==
X-CMS-MailID: 20230518140500eucas1p1f92e6605c8a68a68d564ef5ad5de66dd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230518140500eucas1p1f92e6605c8a68a68d564ef5ad5de66dd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230518140500eucas1p1f92e6605c8a68a68d564ef5ad5de66dd
References: <20230518140448.2001-1-t.dzieciol@partner.samsung.com>
 <CGME20230518140500eucas1p1f92e6605c8a68a68d564ef5ad5de66dd@eucas1p1.samsung.com>
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


