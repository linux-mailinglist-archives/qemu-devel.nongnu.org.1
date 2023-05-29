Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FC9714B76
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 16:03:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3dRw-0002q3-9u; Mon, 29 May 2023 10:02:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.dzieciol@partner.samsung.com>)
 id 1q3dRs-0002nU-Kv
 for qemu-devel@nongnu.org; Mon, 29 May 2023 10:02:12 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.dzieciol@partner.samsung.com>)
 id 1q3dRp-0006oH-Jm
 for qemu-devel@nongnu.org; Mon, 29 May 2023 10:02:12 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20230529140204euoutp02565b1f7e8ab1227513381edc057a1350~johtu_tet1118311183euoutp02p
 for <qemu-devel@nongnu.org>; Mon, 29 May 2023 14:02:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20230529140204euoutp02565b1f7e8ab1227513381edc057a1350~johtu_tet1118311183euoutp02p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1685368924;
 bh=HnUWazik/RcbkpE38Ii94NHLcI0ykUtfyb/ADn8jrlM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Urd94jpHm2WSSBXJyaJZVhG3ig/3j28CMtY7q93VjKmdyhIZ+CuTjN1hlqu8AzdCj
 jjBvdpnd/Jjrw0Ird4ohUNrpKrMvxMWQCmYutqbjMKTCvqg9TIbeHPFQ2l3YWxxus2
 I21a45/BwP9jMbV78XrG8Y6nSUWTJaqhYg523KsY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20230529140204eucas1p1b5677e2737cc9dbc7346b2db4d523c19~johtl4RYD2126721267eucas1p12;
 Mon, 29 May 2023 14:02:04 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id F4.91.42423.C50B4746; Mon, 29
 May 2023 15:02:04 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20230529140203eucas1p22d5b4abfc497838b740807185913576e~johtTYepb2928329283eucas1p23;
 Mon, 29 May 2023 14:02:03 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20230529140203eusmtrp24d08865202028b9f49676ced70896835~johtSyRWb1116611166eusmtrp2k;
 Mon, 29 May 2023 14:02:03 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-dd-6474b05c4715
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 28.38.14344.B50B4746; Mon, 29
 May 2023 15:02:03 +0100 (BST)
Received: from AMDN5139.EU.corp.samsungelectronics.net (unknown
 [106.210.135.112]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20230529140203eusmtip226bfcd9c30cc7f2096bff5b5e38e22a6~johs0H_Pg1093610936eusmtip20;
 Mon, 29 May 2023 14:02:03 +0000 (GMT)
From: Tomasz Dzieciol <t.dzieciol@partner.samsung.com>
To: qemu-devel@nongnu.org, akihiko.odaki@daynix.com
Cc: sriram.yagnaraman@est.tech, jasowang@redhat.com, k.kwiecien@samsung.com,
 m.sochacki@samsung.com
Subject: [PATCH v10 3/7] igb: RX descriptors guest writting refactoring
Date: Mon, 29 May 2023 16:01:49 +0200
Message-Id: <20230529140153.4053-4-t.dzieciol@partner.samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230529140153.4053-1-t.dzieciol@partner.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgleLIzCtJLcpLzFFi42LZduznOd2YDSUpBm+fMlt8PrWW3WLZpc9M
 Fo3z57BabL36g93ieO8OFoveTS+YHNg8Trw9yOpx4dE5Zo8n1zYzebzfd5XNo2/LKsYA1igu
 m5TUnMyy1CJ9uwSujB8rF7AWbPevuPfpKGMDY7d5FyMnh4SAicTyCe/Zuhi5OIQEVjBKLD6z
 H8r5wihx8P06RgjnM6PEt1VHgBwOsJbODf4Q8eWMErcOnGGHcNqZJA4v7WQBmcsmYCbx6Ms8
 VpAGEQFjiY/t4iBhZoFUiaN/DoKVCAu4S3RfvQlmswioSrS8O8kEYvMKOEnMfH6MDeI8eYmZ
 l76zg4zhFHCW6DzNAVEiKHFy5hMWiJHyEs1bZzODnCAhsIND4kRvNxNEr4vEya3zoeYIS7w6
 voUdwpaR+L9zPlRNucTPs9vYIZpbGCX2TJ0MVWQtcWnrT7D7mQU0Jdbv0of43VFi9uZKCJNP
 4sZbQYgT+CQmbZvODBHmlehoE4KYoSPxbdNMNoiwlMTCG3UQpodESx/7BEbFWUhemYXklVkI
 SxcwMq9iFE8tLc5NTy02zEst1ytOzC0uzUvXS87P3cQITCyn/x3/tINx7quPeocYmTgYDzFK
 cDArifDaJhanCPGmJFZWpRblxxeV5qQWH2KU5mBREufVtj2ZLCSQnliSmp2aWpBaBJNl4uCU
 amBqdZ6Rybr4ffEJ5mlf7t7I5P277xnXz0d/VuWUPjGf8Vp1aqXMgQWPxZKulx5YZRRR0LH/
 kjarx1S1itrMw6Fc170eZJ/80cyuMH/yxi+rqvrTJ8722Ob2qyen4sPfbQ/nXefOrfmgct/k
 od037osFMYLNeuUWKT+qpwbPdPasjymY+3b2ld5/wtOZX236/H/3ep0y+7CtHwz7AmtjbJ6u
 YJy4+Etq2BMuPvHIxD3vAreyLPA6m3eHvenk3xeeriyVq1bHp1f6Le5ct10lijc80u121w3d
 Q80NLqEqZaej6tYdX5p994jBi+slt9Y517r08357svilxbMzIa4+efvmzf2VpPRzRRn/i/CH
 sZGpSizFGYmGWsxFxYkAQ+OVaJsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJLMWRmVeSWpSXmKPExsVy+t/xe7rRG0pSDLb061p8PrWW3WLZpc9M
 Fo3z57BabL36g93ieO8OFoveTS+YHNg8Trw9yOpx4dE5Zo8n1zYzebzfd5XNo2/LKsYA1ig9
 m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jB8rF7AW
 bPevuPfpKGMDY7d5FyMHh4SAiUTnBv8uRi4OIYGljBJvvt9l6mLkBIpLSezr+c8OYQtL/LnW
 xQZR1MokceXgPzaQBJuAmcSjL/NYQQaJCJhKPNsrCRJmFsiUOP1qH1iJsIC7RPfVmywgNouA
 qkTLu5Ng83kFnCRmPj/GBjFfXmLmpe/sIGM4BZwlOk9zgISFgEo6791khSgXlDg58wkLxHh5
 ieats5knMArMQpKahSS1gJFpFaNIamlxbnpusZFecWJucWleul5yfu4mRmAcbDv2c8sOxpWv
 PuodYmTiYDzEKMHBrCTCa5tYnCLEm5JYWZValB9fVJqTWnyI0RTo7InMUqLJ+cBIzCuJNzQz
 MDU0MbM0MLU0M1YS5/Us6EgUEkhPLEnNTk0tSC2C6WPi4JRqYDJd/iJ76e59WscWLN3PvDZN
 5nub1c+JZU7Pbn2Q2eXBOfd40vXyX5cDMrOP/yuV4ilsvvPiw9/nXHO8rtzcwGDwQCVR50r+
 0YNP/3fsnqW9ZR2LxN5D3VpaMoIXnt/LmLy3xMqtK7reO1pub1qFiRNzjsbBfa9TnxssDr70
 ruLSpYmdErlnGHRXtb1Q7lg4LzatsbZdwHNh3pwzn1I2Hjob2O28xDTx/6PbPx1je55b899X
 nGrrcK27oEZhVt5dvgWrYr9UhBWYPknQfTHn0CUu705Vrrmu/SYvgpbdzvt7TOhJ+DKvP06H
 98+IKVT5uywjecGju72nyifJ91Sr7fzpvPnjo3Tz8nMi7Srf73YqsRRnJBpqMRcVJwIAiCN5
 tQwDAAA=
X-CMS-MailID: 20230529140203eucas1p22d5b4abfc497838b740807185913576e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230529140203eucas1p22d5b4abfc497838b740807185913576e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230529140203eucas1p22d5b4abfc497838b740807185913576e
References: <20230529140153.4053-1-t.dzieciol@partner.samsung.com>
 <CGME20230529140203eucas1p22d5b4abfc497838b740807185913576e@eucas1p2.samsung.com>
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


