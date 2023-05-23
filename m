Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6727470D559
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 09:39:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1MY1-0004Kp-0A; Tue, 23 May 2023 03:35:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MXR-0003ld-1M
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:34:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MXL-0004Nd-Au
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:34:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684827262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tojmvZ0U8HPXw2t7VCgXqo5aAuztIu05+K5sQRCeL2I=;
 b=V5GRxOxVwhhM1yr+1Kxt40E3TCLMcBZ8Tqvl1+AOFXgETf9/5tFd/hplRMZ3GRvb+4Aj1E
 Vw7EyKdggshaQ8skpGrzjWI+JD68yIgEAlzTOB9zxCMXxbTSy+yMdgVv5dED78BQmCKKDq
 gq+UHM5AdXxc/Gz66pSrXmgtqVywCOM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-56-e-ae93uqM4-XI4v5C7FWyw-1; Tue, 23 May 2023 03:34:19 -0400
X-MC-Unique: e-ae93uqM4-XI4v5C7FWyw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D6B42811E7C;
 Tue, 23 May 2023 07:34:18 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-45.pek2.redhat.com [10.72.12.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E14AD2166B26;
 Tue, 23 May 2023 07:34:16 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 32/50] net/eth: Always add VLAN tag
Date: Tue, 23 May 2023 15:32:20 +0800
Message-Id: <20230523073238.54236-33-jasowang@redhat.com>
In-Reply-To: <20230523073238.54236-1-jasowang@redhat.com>
References: <20230523073238.54236-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
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

It is possible to have another VLAN tag even if the packet is already
tagged.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/net_tx_pkt.c | 16 +++++++---------
 include/net/eth.h   |  4 ++--
 net/eth.c           | 22 ++++++----------------
 3 files changed, 15 insertions(+), 27 deletions(-)

diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
index ce6b102..af8f77a 100644
--- a/hw/net/net_tx_pkt.c
+++ b/hw/net/net_tx_pkt.c
@@ -40,7 +40,10 @@ struct NetTxPkt {
 
     struct iovec *vec;
 
-    uint8_t l2_hdr[ETH_MAX_L2_HDR_LEN];
+    struct {
+        struct eth_header eth;
+        struct vlan_header vlan[3];
+    } l2_hdr;
     union {
         struct ip_header ip;
         struct ip6_header ip6;
@@ -365,18 +368,13 @@ bool net_tx_pkt_build_vheader(struct NetTxPkt *pkt, bool tso_enable,
 void net_tx_pkt_setup_vlan_header_ex(struct NetTxPkt *pkt,
     uint16_t vlan, uint16_t vlan_ethtype)
 {
-    bool is_new;
     assert(pkt);
 
     eth_setup_vlan_headers(pkt->vec[NET_TX_PKT_L2HDR_FRAG].iov_base,
-        vlan, vlan_ethtype, &is_new);
+                           &pkt->vec[NET_TX_PKT_L2HDR_FRAG].iov_len,
+                           vlan, vlan_ethtype);
 
-    /* update l2hdrlen */
-    if (is_new) {
-        pkt->hdr_len += sizeof(struct vlan_header);
-        pkt->vec[NET_TX_PKT_L2HDR_FRAG].iov_len +=
-            sizeof(struct vlan_header);
-    }
+    pkt->hdr_len += sizeof(struct vlan_header);
 }
 
 bool net_tx_pkt_add_raw_fragment(struct NetTxPkt *pkt, void *base, size_t len)
diff --git a/include/net/eth.h b/include/net/eth.h
index 95ff24d..048e434 100644
--- a/include/net/eth.h
+++ b/include/net/eth.h
@@ -353,8 +353,8 @@ eth_strip_vlan_ex(const struct iovec *iov, int iovcnt, size_t iovoff,
 uint16_t
 eth_get_l3_proto(const struct iovec *l2hdr_iov, int iovcnt, size_t l2hdr_len);
 
-void eth_setup_vlan_headers(struct eth_header *ehdr, uint16_t vlan_tag,
-    uint16_t vlan_ethtype, bool *is_new);
+void eth_setup_vlan_headers(struct eth_header *ehdr, size_t *ehdr_size,
+                            uint16_t vlan_tag, uint16_t vlan_ethtype);
 
 
 uint8_t eth_get_gso_type(uint16_t l3_proto, uint8_t *l3_hdr, uint8_t l4proto);
diff --git a/net/eth.c b/net/eth.c
index f7ffbda..5307978 100644
--- a/net/eth.c
+++ b/net/eth.c
@@ -21,26 +21,16 @@
 #include "net/checksum.h"
 #include "net/tap.h"
 
-void eth_setup_vlan_headers(struct eth_header *ehdr, uint16_t vlan_tag,
-    uint16_t vlan_ethtype, bool *is_new)
+void eth_setup_vlan_headers(struct eth_header *ehdr, size_t *ehdr_size,
+                            uint16_t vlan_tag, uint16_t vlan_ethtype)
 {
     struct vlan_header *vhdr = PKT_GET_VLAN_HDR(ehdr);
 
-    switch (be16_to_cpu(ehdr->h_proto)) {
-    case ETH_P_VLAN:
-    case ETH_P_DVLAN:
-        /* vlan hdr exists */
-        *is_new = false;
-        break;
-
-    default:
-        /* No VLAN header, put a new one */
-        vhdr->h_proto = ehdr->h_proto;
-        ehdr->h_proto = cpu_to_be16(vlan_ethtype);
-        *is_new = true;
-        break;
-    }
+    memmove(vhdr + 1, vhdr, *ehdr_size - ETH_HLEN);
     vhdr->h_tci = cpu_to_be16(vlan_tag);
+    vhdr->h_proto = ehdr->h_proto;
+    ehdr->h_proto = cpu_to_be16(vlan_ethtype);
+    *ehdr_size += sizeof(*vhdr);
 }
 
 uint8_t
-- 
2.7.4


