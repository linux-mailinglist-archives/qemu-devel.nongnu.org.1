Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F516708381
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 16:05:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzeFi-0007Qx-P7; Thu, 18 May 2023 10:05:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.dzieciol@partner.samsung.com>)
 id 1pzeFe-0007Qe-GN
 for qemu-devel@nongnu.org; Thu, 18 May 2023 10:05:06 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.dzieciol@partner.samsung.com>)
 id 1pzeFZ-0003no-Ug
 for qemu-devel@nongnu.org; Thu, 18 May 2023 10:05:06 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20230518140459euoutp02e259d581e47f1af81709a65790179420~gQeH4UHsf3087930879euoutp02a
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 14:04:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20230518140459euoutp02e259d581e47f1af81709a65790179420~gQeH4UHsf3087930879euoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1684418699;
 bh=iqRWpzYbLSTI+wnPEVZlRrbYMCTVi9/gOevPrwkRwa4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=m6iUh9tng4ioZdwaQyg1h7EKNbB0C/+duCzsvziP1zSlhGmP5V8QRViY+Qymsadbr
 HubQQ0tmVt/o6qP/+SMcjeOTljBmRCuAxPWmfCn4uN9dHm9yTzgM4n2MZCSASJ0eYz
 u7aN+IUPLNNxAKLje5P48niPwuEvRV+q3n4nuFec=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20230518140459eucas1p16680ac97e3cbb0369e1b0c85529c746d~gQeHtZCKg0591205912eucas1p1E;
 Thu, 18 May 2023 14:04:59 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 2F.72.42423.B8036646; Thu, 18
 May 2023 15:04:59 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20230518140458eucas1p200bea061f622857ab8aa5140b9130515~gQeHUcw5Y1801418014eucas1p2P;
 Thu, 18 May 2023 14:04:58 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20230518140458eusmtrp2ea03a58d4a0c5e5407f777a8823a867e~gQeHT7XSe0300203002eusmtrp2J;
 Thu, 18 May 2023 14:04:58 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-1b-6466308bf123
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 82.61.14344.A8036646; Thu, 18
 May 2023 15:04:58 +0100 (BST)
Received: from AMDN5139.EU.corp.samsungelectronics.net (unknown
 [106.210.135.112]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20230518140458eusmtip247af8e8225a0aee3baafd261ce259b58~gQeGy9sIf2700627006eusmtip24;
 Thu, 18 May 2023 14:04:58 +0000 (GMT)
From: Tomasz Dzieciol <t.dzieciol@partner.samsung.com>
To: qemu-devel@nongnu.org, akihiko.odaki@daynix.com
Cc: sriram.yagnaraman@est.tech, jasowang@redhat.com, k.kwiecien@samsung.com,
 m.sochacki@samsung.com
Subject: [PATCH v8 3/7] igb: RX descriptors guest writting refactoring
Date: Thu, 18 May 2023 16:04:44 +0200
Message-Id: <20230518140448.2001-4-t.dzieciol@partner.samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230518140448.2001-1-t.dzieciol@partner.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkleLIzCtJLcpLzFFi42LZduzned1ug7QUgxl7WSw+n1rLbrHs0mcm
 i8b5c1gttl79wW5xvHcHi0XvphdMDmweJ94eZPW48Ogcs8eTa5uZPN7vu8rm0bdlFWMAaxSX
 TUpqTmZZapG+XQJXRtfkNewFS4MrJr5ax9jA+NWyi5GTQ0LARKL71izGLkYuDiGBFYwSF190
 QzlfGCUm3GiBcj4zSlw6d5O9i5EDrOX2H12I+HJGiS+9m1ggnHYmiW/fl7OBzGUTMJN49GUe
 K0iDiICxxMd2cZAws0CqxNE/B1lAbGEBN4mHl4+xgtgsAqoSt8+uA5vPK+AksXKRD8R18hIz
 L31nB7E5BZwlLk5fxQhi8woISpyc+YQFYqS8RPPW2cwgJ0gI7OCQ2Dx/HgtEs4vE7qbvjBC2
 sMSr41vYIWwZif875zNB2OUSP89uY4dobmGU2DN1MlSRtcSlrT/B7mcW0JRYv0sf4ndHiS03
 6yBMPokbbwUhTuCTmLRtOjNEmFeio00IYoaOxLdNM9kgwlISC2/UQYQ9JLYsecsygVFxFpJf
 ZiH5ZRbC1gWMzKsYxVNLi3PTU4sN81LL9YoTc4tL89L1kvNzNzECU8vpf8c/7WCc++qj3iFG
 Jg7GQ4wSHMxKIryBfckpQrwpiZVVqUX58UWlOanFhxilOViUxHm1bU8mCwmkJ5akZqemFqQW
 wWSZODilGpj8lSy9/H4m/LVckbwhcHvPvf3rHvxZssdG3vrHDF6z+wbOYj/ilZb/2Xqn6v48
 NQXPcvlo7c29le3fZXyCzWR6NfvSt8o+m5uZ+3XZ42yf+drsvRxzvH+eCn3f/KjZ6pPCr8/X
 6yeGrJA8k/m0YNumWAm5xKjT7Klfn+5mc1IQ1dliu5NharW96ZQLqxUN0zNXlakdaYj5su3h
 87cHkhZp/Lt0O3ap6fvV+1i/TZ1eceb3/B7ms5nH7vTbiZ7UrEmeXbHkxBGt358Saz69r9xu
 9Nfr6JIkn66e4kX3p+tPDdaZxPpkm4n/x2VPe3c7JovPk9x+LWVGrOFeVdeAThXZ+OCV8vFn
 Jj3I8bvjtKNNiaU4I9FQi7moOBEAWcZEVZwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBLMWRmVeSWpSXmKPExsVy+t/xe7pdBmkpBp8nalt8PrWW3WLZpc9M
 Fo3z57BabL36g93ieO8OFoveTS+YHNg8Trw9yOpx4dE5Zo8n1zYzebzfd5XNo2/LKsYA1ig9
 m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jK7Ja9gL
 lgZXTHy1jrGB8atlFyMHh4SAicTtP7pdjJwcQgJLGSU2n84HsSUEpCT29fxnh7CFJf5c62Lr
 YuQCqmllkph6YSojSIJNwEzi0Zd5rCBzRARMJZ7tlQQJMwtkSpx+tY8NxBYWcJN4ePkYK4jN
 IqAqcfvsOnaQcl4BJ4mVi3wgxstLzLz0HWwVp4CzxMXpqxghznGSmHvuAVicV0BQ4uTMJywQ
 4+UlmrfOZp7AKDALSWoWktQCRqZVjCKppcW56bnFRnrFibnFpXnpesn5uZsYgVGw7djPLTsY
 V776qHeIkYmD8RCjBAezkghvYF9yihBvSmJlVWpRfnxRaU5q8SFGU6CzJzJLiSbnA+MwryTe
 0MzA1NDEzNLA1NLMWEmc17OgI1FIID2xJDU7NbUgtQimj4mDU6qBqfbi+sL2ewbGESf3+zgK
 WJs+v/bLM8/7f/TBXiV1xn6tu8/OhHOxO7M8cgjfnt2ioxLsepFr+7PIfboXy058kdc8/OlE
 uEin3NXkWSHPptzYo6J6dk10w/vzS1MvZS06MquKpzFgMwvn99Ad5ZquBcelvKe85fH2WqC0
 1u7Gy6Vn1+grqmu4zQqbMqstP2Li/WCffzddvwe83WW0aM3m2DAXVamdq4rnyrpxrGVQibjg
 2BG9Udp2+jkZ/sMa3RfmOC3+Wy92iJ/33TS9d/LTFbI+3fnz5ojsNdcIqUkNgkmzt6esv763
 yeflzUcrK2acOzGrhbHrtvve49WcYRcWd/Dc4zAuzbsgmrGo4XrEZiWW4oxEQy3mouJEAN19
 cfELAwAA
X-CMS-MailID: 20230518140458eucas1p200bea061f622857ab8aa5140b9130515
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230518140458eucas1p200bea061f622857ab8aa5140b9130515
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230518140458eucas1p200bea061f622857ab8aa5140b9130515
References: <20230518140448.2001-1-t.dzieciol@partner.samsung.com>
 <CGME20230518140458eucas1p200bea061f622857ab8aa5140b9130515@eucas1p2.samsung.com>
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

Refactoring is done in preparation for support of multiple advanced
descriptors RX modes, especially packet-split modes.

Signed-off-by: Tomasz Dzieciol <t.dzieciol@partner.samsung.com>
---
 hw/net/igb_core.c   | 178 +++++++++++++++++++++++---------------------
 hw/net/igb_regs.h   |  10 +--
 hw/net/trace-events |   6 +-
 3 files changed, 101 insertions(+), 93 deletions(-)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index b6031dea24..c987b26d09 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -1281,15 +1281,11 @@ igb_verify_csum_in_sw(IGBCore *core,
 }
 
 static void
-igb_build_rx_metadata(IGBCore *core,
-                      struct NetRxPkt *pkt,
-                      bool is_eop,
-                      const E1000E_RSSInfo *rss_info, uint16_t etqf, bool ts,
-                      uint16_t *pkt_info, uint16_t *hdr_info,
-                      uint32_t *rss,
-                      uint32_t *status_flags,
-                      uint16_t *ip_id,
-                      uint16_t *vlan_tag)
+igb_build_rx_metadata_common(IGBCore *core,
+                             struct NetRxPkt *pkt,
+                             bool is_eop,
+                             uint32_t *status_flags,
+                             uint16_t *vlan_tag)
 {
     struct virtio_net_hdr *vhdr;
     bool hasip4, hasip6, csum_valid;
@@ -1298,7 +1294,6 @@ igb_build_rx_metadata(IGBCore *core,
     *status_flags = E1000_RXD_STAT_DD;
 
     /* No additional metadata needed for non-EOP descriptors */
-    /* TODO: EOP apply only to status so don't skip whole function. */
     if (!is_eop) {
         goto func_exit;
     }
@@ -1315,59 +1310,6 @@ igb_build_rx_metadata(IGBCore *core,
         trace_e1000e_rx_metadata_vlan(*vlan_tag);
     }
 
-    /* Packet parsing results */
-    if ((core->mac[RXCSUM] & E1000_RXCSUM_PCSD) != 0) {
-        if (rss_info->enabled) {
-            *rss = cpu_to_le32(rss_info->hash);
-            trace_igb_rx_metadata_rss(*rss);
-        }
-    } else if (hasip4) {
-            *status_flags |= E1000_RXD_STAT_IPIDV;
-            *ip_id = cpu_to_le16(net_rx_pkt_get_ip_id(pkt));
-            trace_e1000e_rx_metadata_ip_id(*ip_id);
-    }
-
-    if (pkt_info) {
-        *pkt_info = rss_info->enabled ? rss_info->type : 0;
-
-        if (etqf < 8) {
-            *pkt_info |= BIT(11) | (etqf << 4);
-        } else {
-            if (hasip4) {
-                *pkt_info |= E1000_ADVRXD_PKT_IP4;
-            }
-
-            if (hasip6) {
-                *pkt_info |= E1000_ADVRXD_PKT_IP6;
-            }
-
-            switch (l4hdr_proto) {
-            case ETH_L4_HDR_PROTO_TCP:
-                *pkt_info |= E1000_ADVRXD_PKT_TCP;
-                break;
-
-            case ETH_L4_HDR_PROTO_UDP:
-                *pkt_info |= E1000_ADVRXD_PKT_UDP;
-                break;
-
-            case ETH_L4_HDR_PROTO_SCTP:
-                *pkt_info |= E1000_ADVRXD_PKT_SCTP;
-                break;
-
-            default:
-                break;
-            }
-        }
-    }
-
-    if (hdr_info) {
-        *hdr_info = 0;
-    }
-
-    if (ts) {
-        *status_flags |= BIT(16);
-    }
-
     /* RX CSO information */
     if (hasip6 && (core->mac[RFCTL] & E1000_RFCTL_IPV6_XSUM_DIS)) {
         trace_e1000e_rx_metadata_ipv6_sum_disabled();
@@ -1423,43 +1365,108 @@ func_exit:
 static inline void
 igb_write_lgcy_rx_descr(IGBCore *core, struct e1000_rx_desc *desc,
                         struct NetRxPkt *pkt,
-                        const E1000E_RSSInfo *rss_info, uint16_t etqf, bool ts,
+                        const E1000E_RSSInfo *rss_info,
                         uint16_t length)
 {
-    uint32_t status_flags, rss;
-    uint16_t ip_id;
+    uint32_t status_flags;
 
     assert(!rss_info->enabled);
+
+    memset(desc, 0, sizeof(*desc));
     desc->length = cpu_to_le16(length);
-    desc->csum = 0;
+    igb_build_rx_metadata_common(core, pkt, pkt != NULL,
+                                 &status_flags,
+                                 &desc->special);
 
-    igb_build_rx_metadata(core, pkt, pkt != NULL,
-                          rss_info, etqf, ts,
-                          NULL, NULL, &rss,
-                          &status_flags, &ip_id,
-                          &desc->special);
     desc->errors = (uint8_t) (le32_to_cpu(status_flags) >> 24);
     desc->status = (uint8_t) le32_to_cpu(status_flags);
 }
 
+static uint16_t
+igb_rx_desc_get_packet_type(IGBCore *core, struct NetRxPkt *pkt, uint16_t etqf)
+{
+    uint16_t pkt_type;
+    bool hasip4, hasip6;
+    EthL4HdrProto l4hdr_proto;
+
+    net_rx_pkt_get_protocols(pkt, &hasip4, &hasip6, &l4hdr_proto);
+
+    if (hasip6 && !(core->mac[RFCTL] & E1000_RFCTL_IPV6_DIS)) {
+        pkt_type = E1000_ADVRXD_PKT_IP6;
+    } else if (hasip4) {
+        pkt_type = E1000_ADVRXD_PKT_IP4;
+    } else {
+        pkt_type = 0;
+    }
+
+    if (etqf < 8) {
+        pkt_type |= (BIT(11) >> 4) | etqf;
+        return pkt_type;
+    }
+
+    switch (l4hdr_proto) {
+    case ETH_L4_HDR_PROTO_TCP:
+        pkt_type |= E1000_ADVRXD_PKT_TCP;
+        break;
+    case ETH_L4_HDR_PROTO_UDP:
+        pkt_type |= E1000_ADVRXD_PKT_UDP;
+        break;
+    case ETH_L4_HDR_PROTO_SCTP:
+        pkt_type |= E1000_ADVRXD_PKT_SCTP;
+        break;
+    default:
+        break;
+    }
+
+    return pkt_type;
+}
+
 static inline void
-igb_write_adv_rx_descr(IGBCore *core, union e1000_adv_rx_desc *desc,
+igb_write_adv_rx_descr(IGBCore *core,
+                       union e1000_adv_rx_desc *d,
                        struct NetRxPkt *pkt,
-                       const E1000E_RSSInfo *rss_info, uint16_t etqf, bool ts,
+                       const E1000E_RSSInfo *rss_info,
+                       uint16_t etqf,
+                       bool ts,
                        uint16_t length)
 {
-    memset(&desc->wb, 0, sizeof(desc->wb));
+    bool hasip4, hasip6;
+    EthL4HdrProto l4hdr_proto;
+    uint16_t rss_type = 0, pkt_type;
+    bool eop = (pkt != NULL);
+    memset(&d->wb, 0, sizeof(d->wb));
+
+    d->wb.upper.length = cpu_to_le16(length);
+    igb_build_rx_metadata_common(core, pkt, eop,
+                                 &d->wb.upper.status_error,
+                                 &d->wb.upper.vlan);
+
+    if (!eop) {
+        return;
+    }
+
+    net_rx_pkt_get_protocols(pkt, &hasip4, &hasip6, &l4hdr_proto);
 
-    desc->wb.upper.length = cpu_to_le16(length);
+    if ((core->mac[RXCSUM] & E1000_RXCSUM_PCSD) != 0) {
+        if (rss_info->enabled) {
+            d->wb.lower.hi_dword.rss = cpu_to_le32(rss_info->hash);
+            rss_type = rss_info->type;
+            trace_igb_rx_metadata_rss(d->wb.lower.hi_dword.rss, rss_type);
+        }
+    } else if (hasip4) {
+            d->wb.upper.status_error |= E1000_RXD_STAT_IPIDV;
+            d->wb.lower.hi_dword.csum_ip.ip_id =
+                cpu_to_le16(net_rx_pkt_get_ip_id(pkt));
+            trace_e1000e_rx_metadata_ip_id(d->wb.lower.hi_dword.csum_ip.ip_id);
+    }
+
+    if (ts) {
+        d->wb.upper.status_error |= BIT(16);
+    }
 
-    igb_build_rx_metadata(core, pkt, pkt != NULL,
-                          rss_info, etqf, ts,
-                          &desc->wb.lower.lo_dword.pkt_info,
-                          &desc->wb.lower.lo_dword.hdr_info,
-                          &desc->wb.lower.hi_dword.rss,
-                          &desc->wb.upper.status_error,
-                          &desc->wb.lower.hi_dword.csum_ip.ip_id,
-                          &desc->wb.upper.vlan);
+    pkt_type = igb_rx_desc_get_packet_type(core, pkt, etqf);
+    trace_e1000e_rx_metadata_pkt_type(pkt_type);
+    d->wb.lower.lo_dword.pkt_info = cpu_to_le16(rss_type | (pkt_type << 4));
 }
 
 static inline void
@@ -1468,8 +1475,7 @@ igb_write_rx_descr(IGBCore *core, union e1000_rx_desc_union *desc,
                    uint16_t etqf, bool ts, uint16_t length)
 {
     if (igb_rx_use_legacy_descriptor(core)) {
-        igb_write_lgcy_rx_descr(core, &desc->legacy, pkt, rss_info,
-                                etqf, ts, length);
+        igb_write_lgcy_rx_descr(core, &desc->legacy, pkt, rss_info, length);
     } else {
         igb_write_adv_rx_descr(core, &desc->adv, pkt, rss_info,
                                etqf, ts, length);
diff --git a/hw/net/igb_regs.h b/hw/net/igb_regs.h
index 82ff195dfc..71a8833229 100644
--- a/hw/net/igb_regs.h
+++ b/hw/net/igb_regs.h
@@ -692,11 +692,11 @@ union e1000_adv_rx_desc {
 
 #define E1000_STATUS_NUM_VFS_SHIFT 14
 
-#define E1000_ADVRXD_PKT_IP4 BIT(4)
-#define E1000_ADVRXD_PKT_IP6 BIT(6)
-#define E1000_ADVRXD_PKT_TCP BIT(8)
-#define E1000_ADVRXD_PKT_UDP BIT(9)
-#define E1000_ADVRXD_PKT_SCTP BIT(10)
+#define E1000_ADVRXD_PKT_IP4  BIT(0)
+#define E1000_ADVRXD_PKT_IP6  BIT(2)
+#define E1000_ADVRXD_PKT_TCP  BIT(4)
+#define E1000_ADVRXD_PKT_UDP  BIT(5)
+#define E1000_ADVRXD_PKT_SCTP BIT(6)
 
 static inline uint8_t igb_ivar_entry_rx(uint8_t i)
 {
diff --git a/hw/net/trace-events b/hw/net/trace-events
index e4a98b2c7d..def651c186 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -277,9 +277,9 @@ igb_core_mdic_write_unhandled(uint32_t addr) "MDIC WRITE: PHY[%u] UNHANDLED"
 igb_link_set_ext_params(bool asd_check, bool speed_select_bypass, bool pfrstd) "Set extended link params: ASD check: %d, Speed select bypass: %d, PF reset done: %d"
 
 igb_rx_desc_buff_size(uint32_t b) "buffer size: %u"
-igb_rx_desc_buff_write(uint64_t addr, uint16_t offset, const void* source, uint32_t len) "addr: 0x%"PRIx64", offset: %u, from: %p, length: %u"
+igb_rx_desc_buff_write(uint64_t addr, uint16_t offset, const void* source, uint32_t len) "buffer %u, addr: 0x%"PRIx64", offset: %u, from: %p, length: %u"
 
-igb_rx_metadata_rss(uint32_t rss) "RSS data: 0x%X"
+igb_rx_metadata_rss(uint32_t rss, uint16_t rss_pkt_type) "RSS data: rss: 0x%X, rss_pkt_type: 0x%X"
 
 igb_irq_icr_clear_gpie_nsicr(void) "Clearing ICR on read due to GPIE.NSICR enabled"
 igb_irq_set_iam(uint32_t icr) "Update IAM: 0x%x"
@@ -294,6 +294,8 @@ igb_irq_eitr_set(uint32_t eitr_num, uint32_t val) "EITR[%u] = 0x%x"
 igb_set_pfmailbox(uint32_t vf_num, uint32_t val) "PFMailbox[%d]: 0x%x"
 igb_set_vfmailbox(uint32_t vf_num, uint32_t val) "VFMailbox[%d]: 0x%x"
 
+igb_wrn_rx_desc_modes_not_supp(int desc_type) "Not supported descriptor type: %d"
+
 # igbvf.c
 igbvf_wrn_io_addr_unknown(uint64_t addr) "IO unknown register 0x%"PRIx64
 
-- 
2.25.1


