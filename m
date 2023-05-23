Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD7170D534
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 09:36:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1MYb-0005pR-MZ; Tue, 23 May 2023 03:35:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MXh-0004Kq-IH
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:34:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MXe-0004Qo-DO
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:34:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684827283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+geZvF+58+w9wC+o2zr+Vk+xMXqTt/r5+Zpz9kOvkc4=;
 b=ESu3DbOtx9vX1HREL3UfncepYEKI94a8fIYHTmDPiacQ8Jq6gA+eo5cmrd1X5p9RYF9Ucj
 CAtKd8zqqsCkAyy0JEXjn+KpLtGDy3SssQ9ra3p+MAz7omPSocsBj5Evg+aU9QbX/qnAph
 ycj3M+GPqoGyCVvzZFb5zkLBrcV9nxs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-247-TkJU7MhqOr6c9v9x02gcMw-1; Tue, 23 May 2023 03:34:40 -0400
X-MC-Unique: TkJU7MhqOr6c9v9x02gcMw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2C048811E7F;
 Tue, 23 May 2023 07:34:40 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-45.pek2.redhat.com [10.72.12.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 02BE62166B25;
 Tue, 23 May 2023 07:34:37 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 39/50] igb: Strip the second VLAN tag for extended VLAN
Date: Tue, 23 May 2023 15:32:27 +0800
Message-Id: <20230523073238.54236-40-jasowang@redhat.com>
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
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/e1000e_core.c |  3 ++-
 hw/net/igb_core.c    | 14 ++++++++++++--
 hw/net/net_rx_pkt.c  | 15 ++++++---------
 hw/net/net_rx_pkt.h  | 19 ++++++++++---------
 include/net/eth.h    |  4 ++--
 net/eth.c            | 52 +++++++++++++++++++++++++++++++++-------------------
 6 files changed, 65 insertions(+), 42 deletions(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 0b939ff..d601386 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -1711,7 +1711,8 @@ e1000e_receive_internal(E1000ECore *core, const struct iovec *iov, int iovcnt,
     }
 
     net_rx_pkt_attach_iovec_ex(core->rx_pkt, iov, iovcnt, iov_ofs,
-                               e1000x_vlan_enabled(core->mac), core->mac[VET]);
+                               e1000x_vlan_enabled(core->mac) ? 0 : -1,
+                               core->mac[VET], 0);
 
     e1000e_rss_parse_packet(core, core->rx_pkt, &rss_info);
     e1000e_rx_ring_init(core, &rxr, rss_info.queue);
diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 5eacf1c..688eaf7 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -1611,6 +1611,7 @@ igb_receive_internal(IGBCore *core, const struct iovec *iov, int iovcnt,
     E1000E_RxRing rxr;
     E1000E_RSSInfo rss_info;
     size_t total_size;
+    int strip_vlan_index;
     int i;
 
     trace_e1000e_rx_receive_iov(iovcnt);
@@ -1672,9 +1673,18 @@ igb_receive_internal(IGBCore *core, const struct iovec *iov, int iovcnt,
 
         igb_rx_ring_init(core, &rxr, i);
 
+        if (!igb_rx_strip_vlan(core, rxr.i)) {
+            strip_vlan_index = -1;
+        } else if (core->mac[CTRL_EXT] & BIT(26)) {
+            strip_vlan_index = 1;
+        } else {
+            strip_vlan_index = 0;
+        }
+
         net_rx_pkt_attach_iovec_ex(core->rx_pkt, iov, iovcnt, iov_ofs,
-                                   igb_rx_strip_vlan(core, rxr.i),
-                                   core->mac[VET] & 0xffff);
+                                   strip_vlan_index,
+                                   core->mac[VET] & 0xffff,
+                                   core->mac[VET] >> 16);
 
         total_size = net_rx_pkt_get_total_len(core->rx_pkt) +
             e1000x_fcs_len(core->mac);
diff --git a/hw/net/net_rx_pkt.c b/hw/net/net_rx_pkt.c
index 3575c8b..32e5f3f 100644
--- a/hw/net/net_rx_pkt.c
+++ b/hw/net/net_rx_pkt.c
@@ -137,20 +137,17 @@ void net_rx_pkt_attach_iovec(struct NetRxPkt *pkt,
 
 void net_rx_pkt_attach_iovec_ex(struct NetRxPkt *pkt,
                                 const struct iovec *iov, int iovcnt,
-                                size_t iovoff, bool strip_vlan,
-                                uint16_t vet)
+                                size_t iovoff, int strip_vlan_index,
+                                uint16_t vet, uint16_t vet_ext)
 {
     uint16_t tci = 0;
     uint16_t ploff = iovoff;
     assert(pkt);
 
-    if (strip_vlan) {
-        pkt->ehdr_buf_len = eth_strip_vlan_ex(iov, iovcnt, iovoff, vet,
-                                              &pkt->ehdr_buf,
-                                              &ploff, &tci);
-    } else {
-        pkt->ehdr_buf_len = 0;
-    }
+    pkt->ehdr_buf_len = eth_strip_vlan_ex(iov, iovcnt, iovoff,
+                                          strip_vlan_index, vet, vet_ext,
+                                          &pkt->ehdr_buf,
+                                          &ploff, &tci);
 
     pkt->tci = tci;
 
diff --git a/hw/net/net_rx_pkt.h b/hw/net/net_rx_pkt.h
index ce8dbdb..55ec67a 100644
--- a/hw/net/net_rx_pkt.h
+++ b/hw/net/net_rx_pkt.h
@@ -223,18 +223,19 @@ void net_rx_pkt_attach_iovec(struct NetRxPkt *pkt,
 /**
 * attach scatter-gather data to rx packet
 *
-* @pkt:            packet
-* @iov:            received data scatter-gather list
-* @iovcnt          number of elements in iov
-* @iovoff          data start offset in the iov
-* @strip_vlan:     should the module strip vlan from data
-* @vet:            VLAN tag Ethernet type
+* @pkt:              packet
+* @iov:              received data scatter-gather list
+* @iovcnt:           number of elements in iov
+* @iovoff:           data start offset in the iov
+* @strip_vlan_index: index of Q tag if it is to be stripped. negative otherwise.
+* @vet:              VLAN tag Ethernet type
+* @vet_ext:          outer VLAN tag Ethernet type
 *
 */
 void net_rx_pkt_attach_iovec_ex(struct NetRxPkt *pkt,
-                                   const struct iovec *iov, int iovcnt,
-                                   size_t iovoff, bool strip_vlan,
-                                   uint16_t vet);
+                                const struct iovec *iov, int iovcnt,
+                                size_t iovoff, int strip_vlan_index,
+                                uint16_t vet, uint16_t vet_ext);
 
 /**
  * attach data to rx packet
diff --git a/include/net/eth.h b/include/net/eth.h
index 75e7f15..3b80b6e 100644
--- a/include/net/eth.h
+++ b/include/net/eth.h
@@ -347,8 +347,8 @@ eth_strip_vlan(const struct iovec *iov, int iovcnt, size_t iovoff,
                uint16_t *payload_offset, uint16_t *tci);
 
 size_t
-eth_strip_vlan_ex(const struct iovec *iov, int iovcnt, size_t iovoff,
-                  uint16_t vet, void *new_ehdr_buf,
+eth_strip_vlan_ex(const struct iovec *iov, int iovcnt, size_t iovoff, int index,
+                  uint16_t vet, uint16_t vet_ext, void *new_ehdr_buf,
                   uint16_t *payload_offset, uint16_t *tci);
 
 uint16_t
diff --git a/net/eth.c b/net/eth.c
index 7f02aea..649e66b 100644
--- a/net/eth.c
+++ b/net/eth.c
@@ -269,36 +269,50 @@ eth_strip_vlan(const struct iovec *iov, int iovcnt, size_t iovoff,
 }
 
 size_t
-eth_strip_vlan_ex(const struct iovec *iov, int iovcnt, size_t iovoff,
-                  uint16_t vet, void *new_ehdr_buf,
+eth_strip_vlan_ex(const struct iovec *iov, int iovcnt, size_t iovoff, int index,
+                  uint16_t vet, uint16_t vet_ext, void *new_ehdr_buf,
                   uint16_t *payload_offset, uint16_t *tci)
 {
     struct vlan_header vlan_hdr;
-    struct eth_header *new_ehdr = (struct eth_header *) new_ehdr_buf;
-
-    size_t copied = iov_to_buf(iov, iovcnt, iovoff,
-                               new_ehdr, sizeof(*new_ehdr));
-
-    if (copied < sizeof(*new_ehdr)) {
-        return 0;
-    }
+    uint16_t *new_ehdr_proto;
+    size_t new_ehdr_size;
+    size_t copied;
 
-    if (be16_to_cpu(new_ehdr->h_proto) == vet) {
-        copied = iov_to_buf(iov, iovcnt, iovoff + sizeof(*new_ehdr),
-                            &vlan_hdr, sizeof(vlan_hdr));
+    switch (index) {
+    case 0:
+        new_ehdr_proto = &PKT_GET_ETH_HDR(new_ehdr_buf)->h_proto;
+        new_ehdr_size = sizeof(struct eth_header);
+        copied = iov_to_buf(iov, iovcnt, iovoff, new_ehdr_buf, new_ehdr_size);
+        break;
 
-        if (copied < sizeof(vlan_hdr)) {
+    case 1:
+        new_ehdr_proto = &PKT_GET_VLAN_HDR(new_ehdr_buf)->h_proto;
+        new_ehdr_size = sizeof(struct eth_header) + sizeof(struct vlan_header);
+        copied = iov_to_buf(iov, iovcnt, iovoff, new_ehdr_buf, new_ehdr_size);
+        if (be16_to_cpu(PKT_GET_ETH_HDR(new_ehdr_buf)->h_proto) != vet_ext) {
             return 0;
         }
+        break;
 
-        new_ehdr->h_proto = vlan_hdr.h_proto;
+    default:
+        return 0;
+    }
 
-        *tci = be16_to_cpu(vlan_hdr.h_tci);
-        *payload_offset = iovoff + sizeof(*new_ehdr) + sizeof(vlan_hdr);
-        return sizeof(struct eth_header);
+    if (copied < new_ehdr_size || be16_to_cpu(*new_ehdr_proto) != vet) {
+        return 0;
+    }
+
+    copied = iov_to_buf(iov, iovcnt, iovoff + new_ehdr_size,
+                        &vlan_hdr, sizeof(vlan_hdr));
+    if (copied < sizeof(vlan_hdr)) {
+        return 0;
     }
 
-    return 0;
+    *new_ehdr_proto = vlan_hdr.h_proto;
+    *payload_offset = iovoff + new_ehdr_size + sizeof(vlan_hdr);
+    *tci = be16_to_cpu(vlan_hdr.h_tci);
+
+    return new_ehdr_size;
 }
 
 void
-- 
2.7.4


