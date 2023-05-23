Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C67E70D555
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 09:38:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1MYc-0005wJ-Mx; Tue, 23 May 2023 03:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MXY-0004BA-OM
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:34:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MXW-0004Pm-SX
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:34:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684827278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1IyYh4aQC3mdBU8fhTGbKkm+211OAKcTJt6YYkTWQrk=;
 b=ECE5jHP3aB+vWllX39ct792kGrEV4AjxcG9IBIzE5V4sUcESA7boQYaewfROwJc4uL5s8Z
 YfLcIm9klws4Ot78lMAWhwqPeGMjOPeTF/RsrtBqSYh+YVOXv93KLonDmuI/TTjeVrhraH
 ijL161hfdwkJRegFd//2laGXpsyuM+U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-245-wAOKVXhjNQeIPGp9-lcNag-1; Tue, 23 May 2023 03:34:35 -0400
X-MC-Unique: wAOKVXhjNQeIPGp9-lcNag-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 878B8811E78;
 Tue, 23 May 2023 07:34:34 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-45.pek2.redhat.com [10.72.12.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 563DE2166B25;
 Tue, 23 May 2023 07:34:32 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 37/50] igb: Implement Rx SCTP CSO
Date: Tue, 23 May 2023 15:32:25 +0800
Message-Id: <20230523073238.54236-38-jasowang@redhat.com>
In-Reply-To: <20230523073238.54236-1-jasowang@redhat.com>
References: <20230523073238.54236-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/e1000e_core.c  |  5 ++++
 hw/net/igb_core.c     | 15 +++++++++++-
 hw/net/igb_regs.h     |  1 +
 hw/net/net_rx_pkt.c   | 64 ++++++++++++++++++++++++++++++++++++++++++---------
 include/net/eth.h     |  4 +++-
 include/qemu/crc32c.h |  1 +
 net/eth.c             |  4 ++++
 util/crc32c.c         |  8 +++++++
 8 files changed, 89 insertions(+), 13 deletions(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index aea70b7..0b939ff 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -1114,6 +1114,11 @@ e1000e_verify_csum_in_sw(E1000ECore *core,
         return;
     }
 
+    if (l4hdr_proto != ETH_L4_HDR_PROTO_TCP &&
+        l4hdr_proto != ETH_L4_HDR_PROTO_UDP) {
+        return;
+    }
+
     if (!net_rx_pkt_validate_l4_csum(pkt, &csum_valid)) {
         trace_e1000e_rx_metadata_l4_csum_validation_failed();
         return;
diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 41a2e5b..95d46d6 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -1220,7 +1220,7 @@ igb_build_rx_metadata(IGBCore *core,
                       uint16_t *vlan_tag)
 {
     struct virtio_net_hdr *vhdr;
-    bool hasip4, hasip6;
+    bool hasip4, hasip6, csum_valid;
     EthL4HdrProto l4hdr_proto;
 
     *status_flags = E1000_RXD_STAT_DD;
@@ -1280,6 +1280,10 @@ igb_build_rx_metadata(IGBCore *core,
             *pkt_info |= E1000_ADVRXD_PKT_UDP;
             break;
 
+        case ETH_L4_HDR_PROTO_SCTP:
+            *pkt_info |= E1000_ADVRXD_PKT_SCTP;
+            break;
+
         default:
             break;
         }
@@ -1312,6 +1316,15 @@ igb_build_rx_metadata(IGBCore *core,
 
     if (igb_rx_l4_cso_enabled(core)) {
         switch (l4hdr_proto) {
+        case ETH_L4_HDR_PROTO_SCTP:
+            if (!net_rx_pkt_validate_l4_csum(pkt, &csum_valid)) {
+                trace_e1000e_rx_metadata_l4_csum_validation_failed();
+                goto func_exit;
+            }
+            if (!csum_valid) {
+                *status_flags |= E1000_RXDEXT_STATERR_TCPE;
+            }
+            /* fall through */
         case ETH_L4_HDR_PROTO_TCP:
             *status_flags |= E1000_RXD_STAT_TCPCS;
             break;
diff --git a/hw/net/igb_regs.h b/hw/net/igb_regs.h
index e6ac26d..4b4ebd3 100644
--- a/hw/net/igb_regs.h
+++ b/hw/net/igb_regs.h
@@ -670,6 +670,7 @@ union e1000_adv_rx_desc {
 #define E1000_ADVRXD_PKT_IP6 BIT(6)
 #define E1000_ADVRXD_PKT_TCP BIT(8)
 #define E1000_ADVRXD_PKT_UDP BIT(9)
+#define E1000_ADVRXD_PKT_SCTP BIT(10)
 
 static inline uint8_t igb_ivar_entry_rx(uint8_t i)
 {
diff --git a/hw/net/net_rx_pkt.c b/hw/net/net_rx_pkt.c
index 1de42b4..3575c8b 100644
--- a/hw/net/net_rx_pkt.c
+++ b/hw/net/net_rx_pkt.c
@@ -16,6 +16,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/crc32c.h"
 #include "trace.h"
 #include "net_rx_pkt.h"
 #include "net/checksum.h"
@@ -554,32 +555,73 @@ _net_rx_pkt_calc_l4_csum(struct NetRxPkt *pkt)
     return csum;
 }
 
-bool net_rx_pkt_validate_l4_csum(struct NetRxPkt *pkt, bool *csum_valid)
+static bool
+_net_rx_pkt_validate_sctp_sum(struct NetRxPkt *pkt)
 {
-    uint16_t csum;
+    size_t csum_off;
+    size_t off = pkt->l4hdr_off;
+    size_t vec_len = pkt->vec_len;
+    struct iovec *vec;
+    uint32_t calculated = 0;
+    uint32_t original;
+    bool valid;
 
-    trace_net_rx_pkt_l4_csum_validate_entry();
+    for (vec = pkt->vec; vec->iov_len < off; vec++) {
+        off -= vec->iov_len;
+        vec_len--;
+    }
 
-    if (pkt->l4hdr_info.proto != ETH_L4_HDR_PROTO_TCP &&
-        pkt->l4hdr_info.proto != ETH_L4_HDR_PROTO_UDP) {
-        trace_net_rx_pkt_l4_csum_validate_not_xxp();
+    csum_off = off + 8;
+
+    if (!iov_to_buf(vec, vec_len, csum_off, &original, sizeof(original))) {
         return false;
     }
 
-    if (pkt->l4hdr_info.proto == ETH_L4_HDR_PROTO_UDP &&
-        pkt->l4hdr_info.hdr.udp.uh_sum == 0) {
-        trace_net_rx_pkt_l4_csum_validate_udp_with_no_checksum();
+    if (!iov_from_buf(vec, vec_len, csum_off,
+                      &calculated, sizeof(calculated))) {
         return false;
     }
 
+    calculated = crc32c(0xffffffff,
+                        (uint8_t *)vec->iov_base + off, vec->iov_len - off);
+    calculated = iov_crc32c(calculated ^ 0xffffffff, vec + 1, vec_len - 1);
+    valid = calculated == le32_to_cpu(original);
+    iov_from_buf(vec, vec_len, csum_off, &original, sizeof(original));
+
+    return valid;
+}
+
+bool net_rx_pkt_validate_l4_csum(struct NetRxPkt *pkt, bool *csum_valid)
+{
+    uint32_t csum;
+
+    trace_net_rx_pkt_l4_csum_validate_entry();
+
     if (pkt->hasip4 && pkt->ip4hdr_info.fragment) {
         trace_net_rx_pkt_l4_csum_validate_ip4_fragment();
         return false;
     }
 
-    csum = _net_rx_pkt_calc_l4_csum(pkt);
+    switch (pkt->l4hdr_info.proto) {
+    case ETH_L4_HDR_PROTO_UDP:
+        if (pkt->l4hdr_info.hdr.udp.uh_sum == 0) {
+            trace_net_rx_pkt_l4_csum_validate_udp_with_no_checksum();
+            return false;
+        }
+        /* fall through */
+    case ETH_L4_HDR_PROTO_TCP:
+        csum = _net_rx_pkt_calc_l4_csum(pkt);
+        *csum_valid = ((csum == 0) || (csum == 0xFFFF));
+        break;
+
+    case ETH_L4_HDR_PROTO_SCTP:
+        *csum_valid = _net_rx_pkt_validate_sctp_sum(pkt);
+        break;
 
-    *csum_valid = ((csum == 0) || (csum == 0xFFFF));
+    default:
+        trace_net_rx_pkt_l4_csum_validate_not_xxp();
+        return false;
+    }
 
     trace_net_rx_pkt_l4_csum_validate_csum(*csum_valid);
 
diff --git a/include/net/eth.h b/include/net/eth.h
index 048e434..75e7f15 100644
--- a/include/net/eth.h
+++ b/include/net/eth.h
@@ -224,6 +224,7 @@ struct tcp_hdr {
 #define IP_HEADER_VERSION_6       (6)
 #define IP_PROTO_TCP              (6)
 #define IP_PROTO_UDP              (17)
+#define IP_PROTO_SCTP             (132)
 #define IPTOS_ECN_MASK            0x03
 #define IPTOS_ECN(x)              ((x) & IPTOS_ECN_MASK)
 #define IPTOS_ECN_CE              0x03
@@ -379,7 +380,8 @@ typedef struct eth_ip4_hdr_info_st {
 typedef enum EthL4HdrProto {
     ETH_L4_HDR_PROTO_INVALID,
     ETH_L4_HDR_PROTO_TCP,
-    ETH_L4_HDR_PROTO_UDP
+    ETH_L4_HDR_PROTO_UDP,
+    ETH_L4_HDR_PROTO_SCTP
 } EthL4HdrProto;
 
 typedef struct eth_l4_hdr_info_st {
diff --git a/include/qemu/crc32c.h b/include/qemu/crc32c.h
index 5b78884..88b4d2b 100644
--- a/include/qemu/crc32c.h
+++ b/include/qemu/crc32c.h
@@ -30,5 +30,6 @@
 
 
 uint32_t crc32c(uint32_t crc, const uint8_t *data, unsigned int length);
+uint32_t iov_crc32c(uint32_t crc, const struct iovec *iov, size_t iov_cnt);
 
 #endif
diff --git a/net/eth.c b/net/eth.c
index 5307978..7f02aea 100644
--- a/net/eth.c
+++ b/net/eth.c
@@ -211,6 +211,10 @@ void eth_get_protocols(const struct iovec *iov, size_t iovcnt, size_t iovoff,
             *l5hdr_off = *l4hdr_off + sizeof(l4hdr_info->hdr.udp);
         }
         break;
+
+    case IP_PROTO_SCTP:
+        l4hdr_info->proto = ETH_L4_HDR_PROTO_SCTP;
+        break;
     }
 }
 
diff --git a/util/crc32c.c b/util/crc32c.c
index 762657d..ea7f345 100644
--- a/util/crc32c.c
+++ b/util/crc32c.c
@@ -113,3 +113,11 @@ uint32_t crc32c(uint32_t crc, const uint8_t *data, unsigned int length)
     return crc^0xffffffff;
 }
 
+uint32_t iov_crc32c(uint32_t crc, const struct iovec *iov, size_t iov_cnt)
+{
+    while (iov_cnt--) {
+        crc = crc32c(crc, iov->iov_base, iov->iov_len) ^ 0xffffffff;
+        iov++;
+    }
+    return crc ^ 0xffffffff;
+}
-- 
2.7.4


