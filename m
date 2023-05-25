Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7647710FCB
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 17:39:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2D2K-0003Ln-Rq; Thu, 25 May 2023 11:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.dzieciol@partner.samsung.com>)
 id 1q2D2H-0003Jp-TM
 for qemu-devel@nongnu.org; Thu, 25 May 2023 11:37:53 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.dzieciol@partner.samsung.com>)
 id 1q2D2E-0000ny-Mq
 for qemu-devel@nongnu.org; Thu, 25 May 2023 11:37:53 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20230525153745euoutp0239d104c740741d25907a1baea2fb6f5d~ibQHZmL5M0292402924euoutp02Z
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 15:37:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20230525153745euoutp0239d104c740741d25907a1baea2fb6f5d~ibQHZmL5M0292402924euoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1685029065;
 bh=HnUWazik/RcbkpE38Ii94NHLcI0ykUtfyb/ADn8jrlM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LErrvDXkzR4bWjSE42Z1IBgjAW3NmxOsPcUCws4BlRAv08ybAd/Drj0A33MQp0auP
 rwKQxLD6xMyXxXRTKo3MgNOtGajKgu1+OHQufMKDifqOeBcCj9O6Kflnl1fyFaqmf2
 7B/5a49Od1iy2EPGtF8dFZ7Auu5hjPcjeQIeYxrk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20230525153744eucas1p2990b72353361ecba748066367f147b38~ibQG-af6r2758927589eucas1p2k;
 Thu, 25 May 2023 15:37:44 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 94.52.37758.8C08F646; Thu, 25
 May 2023 16:37:44 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20230525153744eucas1p1844ba0a10563caff4bb0f92c82f30f7d~ibQGwAQMN0128401284eucas1p12;
 Thu, 25 May 2023 15:37:44 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20230525153744eusmtrp101bdbf492039ca411ad1910a8bd7fd3f~ibQGvdeVK0103701037eusmtrp1E;
 Thu, 25 May 2023 15:37:44 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-59-646f80c8bfa7
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id D9.C4.10549.8C08F646; Thu, 25
 May 2023 16:37:44 +0100 (BST)
Received: from AMDN5139.EU.corp.samsungelectronics.net (unknown
 [106.210.135.112]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20230525153744eusmtip286fc9ba5aa70a961f62a3f8e9a73aa10~ibQGNwG9C1970019700eusmtip2U;
 Thu, 25 May 2023 15:37:43 +0000 (GMT)
From: Tomasz Dzieciol <t.dzieciol@partner.samsung.com>
To: qemu-devel@nongnu.org, akihiko.odaki@daynix.com
Cc: sriram.yagnaraman@est.tech, jasowang@redhat.com, k.kwiecien@samsung.com,
 m.sochacki@samsung.com
Subject: [PATCH v9 3/7] igb: RX descriptors guest writting refactoring
Date: Thu, 25 May 2023 17:37:29 +0200
Message-Id: <20230525153733.4104-4-t.dzieciol@partner.samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230525153733.4104-1-t.dzieciol@partner.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42LZduzned0TDfkpBievGVh8PrWW3WLZpc9M
 Fo3z57BabL36g93ieO8OFoveTS+YHNg8Trw9yOpx4dE5Zo8n1zYzebzfd5XNo2/LKsYA1igu
 m5TUnMyy1CJ9uwSujB8rF7AWbPevuPfpKGMDY7d5FyMnh4SAicSaOyuYuxi5OIQEVjBK9K5+
 DuV8YZToOdzDBOF8ZpR48+80K0zL/bUTWCESyxkl9pzcwALhtDNJ3Nl5EayKTcBM4tGXeUA2
 B4eIgLHEx3ZxkDCzQKrE0T8HWUBsYQE3iXmbF4LZLAKqEo1PTzOD2LwCThKzFnYzQiyTl5h5
 6Ts7yBhOAWeJlV8rIUoEJU7OfMICMVJeonnrbLCrJQS2cEisv/2TGaLXRaJj234WCFtY4tXx
 LewQtozE6ck9UPFyiZ9nt7FDNLcAPTN1MlSRtcSlrT/B7mcW0JRYv0sfIuwo8f55CzNIWEKA
 T+LGW0GIG/gkJm2bDhXmlehoE4Ko1pH4tmkmG0RYSmLhjTqIsIfE7+0PGCcwKs5C8swsJM/M
 Qli7gJF5FaN4amlxbnpqsXFearlecWJucWleul5yfu4mRmB6Of3v+NcdjCtefdQ7xMjEwXiI
 UYKDWUmEd0NOfooQb0piZVVqUX58UWlOavEhRmkOFiVxXm3bk8lCAumJJanZqakFqUUwWSYO
 TqkGpjx27ZdxVrLLRVdq+sqq35jxTcb9sXdy/cK5Xw5Pz9vytez85oln5kxYNvm4/tPTvMud
 H2k+2pF2cn+dBMfsh1492mw86qoqvvukXLk1Ip3/RmlHVLH9ndxmxPBQQKLVdGXx60PJ7c3i
 0/+vne5Ux9t9nufq3FVbD3dKrD6Rk776mvqBN9YeNe7XZl6xlDm84vJc9RJh38ezfBbMT2l4
 cZXn5xVfsyyZEr3d7veWGt+e0RH067VxhdgJ2cMm0wxSp2748/Zn3rqlwTYmS6fZBb3u2xP4
 oITv/jQuYTF2Hd2QOXmKPT0Gzdk+/K3/Nfzc/j+Y9upCyU/nqawbsqL97v63t7q7/2m2Q5X4
 tDiHlUosxRmJhlrMRcWJAAXmMeaeAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJLMWRmVeSWpSXmKPExsVy+t/xe7onGvJTDGbOkLP4fGotu8WyS5+Z
 LBrnz2G12Hr1B7vF8d4dLBa9m14wObB5nHh7kNXjwqNzzB5Prm1m8ni/7yqbR9+WVYwBrFF6
 NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GT9WLmAt
 2O5fce/TUcYGxm7zLkZODgkBE4n7ayewgthCAksZJZ6cKoeIS0ns6/nPDmELS/y51sXWxcgF
 VNPKJPFuYytYA5uAmcSjL/OAbA4OEQFTiWd7JUHCzAKZEqdf7WMDsYUF3CTmbV7IAmKzCKhK
 ND49zQxi8wo4Scxa2M0IMV9eYual7+wgYzgFnCVWfq2EOMdJYvuHaawQ5YISJ2c+YYEYLy/R
 vHU28wRGgVlIUrOQpBYwMq1iFEktLc5Nzy021CtOzC0uzUvXS87P3cQIjINtx35u3sE479VH
 vUOMTByMhxglOJiVRHg35OSnCPGmJFZWpRblxxeV5qQWH2I0BTp7IrOUaHI+MBLzSuINzQxM
 DU3MLA1MLc2MlcR5PQs6EoUE0hNLUrNTUwtSi2D6mDg4pRqY1h1qD3OQfOQrONftenVWxcac
 C7dl8qvr7PZd/cj0a15s6Ptri7T/pMvd39m7qrOPj83ynj7ninUPbv+dYdPtGTGNRS/Vr39V
 nurx6nlsmtzv+g4mBSuLKtRkT9xnJP+uNmm/1knma7rFz2p6k9If6czmPbuS5esb10j/C3uC
 Y6KVI1SqLecebA5kz5tU57CLc5tR2pRzG6V2n3u2+mn1+h1191LE5yos2/I01mGZ5Y/8nMT3
 580+Rd3j54rOs9HauoPptqIUNysDw8eb+SIbv/mHJfiVb9tok3zmkDenRPmW9e0TD03WFZto
 HWcauTpk2cz1DwRnxeX8rZCtOys/We9+3PdTLevNP58q5BFRYinOSDTUYi4qTgQAXDnGFwwD
 AAA=
X-CMS-MailID: 20230525153744eucas1p1844ba0a10563caff4bb0f92c82f30f7d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230525153744eucas1p1844ba0a10563caff4bb0f92c82f30f7d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230525153744eucas1p1844ba0a10563caff4bb0f92c82f30f7d
References: <20230525153733.4104-1-t.dzieciol@partner.samsung.com>
 <CGME20230525153744eucas1p1844ba0a10563caff4bb0f92c82f30f7d@eucas1p1.samsung.com>
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
 hw/net/igb_core.c   | 170 +++++++++++++++++++++++---------------------
 hw/net/igb_regs.h   |  10 +--
 hw/net/trace-events |   4 +-
 3 files changed, 96 insertions(+), 88 deletions(-)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 051980b4f5..3a6df0d55e 100644
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
-            *pkt_info |= (BIT(11) | etqf) << 4;
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
+    if (etqf < 8) {
+        pkt_type = BIT(11) | etqf;
+        return pkt_type;
+    }
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
 igb_write_adv_rx_descr(IGBCore *core, union e1000_adv_rx_desc *desc,
                        struct NetRxPkt *pkt,
                        const E1000E_RSSInfo *rss_info, uint16_t etqf, bool ts,
                        uint16_t length)
 {
+    bool hasip4, hasip6;
+    EthL4HdrProto l4hdr_proto;
+    uint16_t rss_type = 0, pkt_type;
+    bool eop = (pkt != NULL);
+    uint32_t adv_desc_status_error = 0;
     memset(&desc->wb, 0, sizeof(desc->wb));
 
     desc->wb.upper.length = cpu_to_le16(length);
+    igb_build_rx_metadata_common(core, pkt, eop,
+                                 &desc->wb.upper.status_error,
+                                 &desc->wb.upper.vlan);
+
+    if (!eop) {
+        return;
+    }
+
+    net_rx_pkt_get_protocols(pkt, &hasip4, &hasip6, &l4hdr_proto);
+
+    if ((core->mac[RXCSUM] & E1000_RXCSUM_PCSD) != 0) {
+        if (rss_info->enabled) {
+            desc->wb.lower.hi_dword.rss = cpu_to_le32(rss_info->hash);
+            rss_type = rss_info->type;
+            trace_igb_rx_metadata_rss(desc->wb.lower.hi_dword.rss, rss_type);
+        }
+    } else if (hasip4) {
+            adv_desc_status_error |= E1000_RXD_STAT_IPIDV;
+            desc->wb.lower.hi_dword.csum_ip.ip_id =
+                cpu_to_le16(net_rx_pkt_get_ip_id(pkt));
+            trace_e1000e_rx_metadata_ip_id(
+                desc->wb.lower.hi_dword.csum_ip.ip_id);
+    }
+
+    if (ts) {
+        adv_desc_status_error |= BIT(16);
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
+    desc->wb.lower.lo_dword.pkt_info = cpu_to_le16(rss_type | (pkt_type << 4));
+    desc->wb.upper.status_error |= cpu_to_le32(adv_desc_status_error);
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
index e4a98b2c7d..159df09014 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -279,7 +279,7 @@ igb_link_set_ext_params(bool asd_check, bool speed_select_bypass, bool pfrstd) "
 igb_rx_desc_buff_size(uint32_t b) "buffer size: %u"
 igb_rx_desc_buff_write(uint64_t addr, uint16_t offset, const void* source, uint32_t len) "addr: 0x%"PRIx64", offset: %u, from: %p, length: %u"
 
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


