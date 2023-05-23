Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D0270D52D
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 09:35:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1MWZ-0000Wb-ME; Tue, 23 May 2023 03:33:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MWX-0000V1-Kj
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:33:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MWV-0004G0-FP
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:33:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684827214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cBqDWjb7tndAlYZeGuaPqom8RanKtp2IbvSnkXMnmkY=;
 b=P7UqGYazl2jErUaV4FOsXw9sXYpX6B+J4jSmVDCfZBh/IUcxIe8tQcrGq4e9/1nNh6R0O2
 XoGEFl8MBFkWoz4w+EMNoTEi92Gg2Z0daP5tcz31o0M/m3EuDs9f/Wnj7/A2MeOQMfQ2B7
 t7Je8FH4Cv+OImNzs0nlxkmeUzzweds=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-sXA5AP9wPFWZe9ZPPNStBA-1; Tue, 23 May 2023 03:33:31 -0400
X-MC-Unique: sXA5AP9wPFWZe9ZPPNStBA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 11935185A78B;
 Tue, 23 May 2023 07:33:31 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-45.pek2.redhat.com [10.72.12.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AE3942166B25;
 Tue, 23 May 2023 07:33:28 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 16/50] e1000x: Share more Rx filtering logic
Date: Tue, 23 May 2023 15:32:04 +0800
Message-Id: <20230523073238.54236-17-jasowang@redhat.com>
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

This saves some code and enables tracepoint for e1000's VLAN filtering.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/e1000.c         | 35 +++++------------------------------
 hw/net/e1000e_core.c   | 47 +++++------------------------------------------
 hw/net/e1000x_common.c | 44 ++++++++++++++++++++++++++++++++++++++------
 hw/net/e1000x_common.h |  4 +++-
 hw/net/igb_core.c      | 41 +++--------------------------------------
 hw/net/trace-events    |  4 ++--
 6 files changed, 56 insertions(+), 119 deletions(-)

diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index 18eb6d8..aae5f0b 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -804,36 +804,11 @@ start_xmit(E1000State *s)
 }
 
 static int
-receive_filter(E1000State *s, const uint8_t *buf, int size)
+receive_filter(E1000State *s, const void *buf)
 {
-    uint32_t rctl = s->mac_reg[RCTL];
-    int isbcast = is_broadcast_ether_addr(buf);
-    int ismcast = is_multicast_ether_addr(buf);
-
-    if (e1000x_is_vlan_packet(buf, le16_to_cpu(s->mac_reg[VET])) &&
-        e1000x_vlan_rx_filter_enabled(s->mac_reg)) {
-        uint16_t vid = lduw_be_p(&PKT_GET_VLAN_HDR(buf)->h_tci);
-        uint32_t vfta =
-            ldl_le_p((uint32_t *)(s->mac_reg + VFTA) +
-                     ((vid >> E1000_VFTA_ENTRY_SHIFT) & E1000_VFTA_ENTRY_MASK));
-        if ((vfta & (1 << (vid & E1000_VFTA_ENTRY_BIT_SHIFT_MASK))) == 0) {
-            return 0;
-        }
-    }
-
-    if (!isbcast && !ismcast && (rctl & E1000_RCTL_UPE)) { /* promiscuous ucast */
-        return 1;
-    }
-
-    if (ismcast && (rctl & E1000_RCTL_MPE)) {          /* promiscuous mcast */
-        return 1;
-    }
-
-    if (isbcast && (rctl & E1000_RCTL_BAM)) {          /* broadcast enabled */
-        return 1;
-    }
-
-    return e1000x_rx_group_filter(s->mac_reg, buf);
+    return (!e1000x_is_vlan_packet(buf, s->mac_reg[VET]) ||
+            e1000x_rx_vlan_filter(s->mac_reg, PKT_GET_VLAN_HDR(buf))) &&
+           e1000x_rx_group_filter(s->mac_reg, buf);
 }
 
 static void
@@ -949,7 +924,7 @@ e1000_receive_iov(NetClientState *nc, const struct iovec *iov, int iovcnt)
         return size;
     }
 
-    if (!receive_filter(s, filter_buf, size)) {
+    if (!receive_filter(s, filter_buf)) {
         return size;
     }
 
diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 14b94db..41d2435 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -1034,48 +1034,11 @@ e1000e_rx_l4_cso_enabled(E1000ECore *core)
 }
 
 static bool
-e1000e_receive_filter(E1000ECore *core, const uint8_t *buf, int size)
+e1000e_receive_filter(E1000ECore *core, const void *buf)
 {
-    uint32_t rctl = core->mac[RCTL];
-
-    if (e1000x_is_vlan_packet(buf, core->mac[VET]) &&
-        e1000x_vlan_rx_filter_enabled(core->mac)) {
-        uint16_t vid = lduw_be_p(&PKT_GET_VLAN_HDR(buf)->h_tci);
-        uint32_t vfta =
-            ldl_le_p((uint32_t *)(core->mac + VFTA) +
-                     ((vid >> E1000_VFTA_ENTRY_SHIFT) & E1000_VFTA_ENTRY_MASK));
-        if ((vfta & (1 << (vid & E1000_VFTA_ENTRY_BIT_SHIFT_MASK))) == 0) {
-            trace_e1000e_rx_flt_vlan_mismatch(vid);
-            return false;
-        } else {
-            trace_e1000e_rx_flt_vlan_match(vid);
-        }
-    }
-
-    switch (net_rx_pkt_get_packet_type(core->rx_pkt)) {
-    case ETH_PKT_UCAST:
-        if (rctl & E1000_RCTL_UPE) {
-            return true; /* promiscuous ucast */
-        }
-        break;
-
-    case ETH_PKT_BCAST:
-        if (rctl & E1000_RCTL_BAM) {
-            return true; /* broadcast enabled */
-        }
-        break;
-
-    case ETH_PKT_MCAST:
-        if (rctl & E1000_RCTL_MPE) {
-            return true; /* promiscuous mcast */
-        }
-        break;
-
-    default:
-        g_assert_not_reached();
-    }
-
-    return e1000x_rx_group_filter(core->mac, buf);
+    return (!e1000x_is_vlan_packet(buf, core->mac[VET]) ||
+            e1000x_rx_vlan_filter(core->mac, PKT_GET_VLAN_HDR(buf))) &&
+           e1000x_rx_group_filter(core->mac, buf);
 }
 
 static inline void
@@ -1736,7 +1699,7 @@ e1000e_receive_internal(E1000ECore *core, const struct iovec *iov, int iovcnt,
     net_rx_pkt_set_packet_type(core->rx_pkt,
         get_eth_packet_type(PKT_GET_ETH_HDR(buf)));
 
-    if (!e1000e_receive_filter(core, buf, size)) {
+    if (!e1000e_receive_filter(core, buf)) {
         trace_e1000e_rx_flt_dropped();
         return orig_size;
     }
diff --git a/hw/net/e1000x_common.c b/hw/net/e1000x_common.c
index 7694673..6cc2313 100644
--- a/hw/net/e1000x_common.c
+++ b/hw/net/e1000x_common.c
@@ -58,32 +58,64 @@ bool e1000x_is_vlan_packet(const void *buf, uint16_t vet)
     return res;
 }
 
-bool e1000x_rx_group_filter(uint32_t *mac, const uint8_t *buf)
+bool e1000x_rx_vlan_filter(uint32_t *mac, const struct vlan_header *vhdr)
+{
+    if (e1000x_vlan_rx_filter_enabled(mac)) {
+        uint16_t vid = lduw_be_p(&vhdr->h_tci);
+        uint32_t vfta =
+            ldl_le_p((uint32_t *)(mac + VFTA) +
+                     ((vid >> E1000_VFTA_ENTRY_SHIFT) & E1000_VFTA_ENTRY_MASK));
+        if ((vfta & (1 << (vid & E1000_VFTA_ENTRY_BIT_SHIFT_MASK))) == 0) {
+            trace_e1000x_rx_flt_vlan_mismatch(vid);
+            return false;
+        }
+
+        trace_e1000x_rx_flt_vlan_match(vid);
+    }
+
+    return true;
+}
+
+bool e1000x_rx_group_filter(uint32_t *mac, const struct eth_header *ehdr)
 {
     static const int mta_shift[] = { 4, 3, 2, 0 };
     uint32_t f, ra[2], *rp, rctl = mac[RCTL];
 
+    if (is_broadcast_ether_addr(ehdr->h_dest)) {
+        if (rctl & E1000_RCTL_BAM) {
+            return true;
+        }
+    } else if (is_multicast_ether_addr(ehdr->h_dest)) {
+        if (rctl & E1000_RCTL_MPE) {
+            return true;
+        }
+    } else {
+        if (rctl & E1000_RCTL_UPE) {
+            return true;
+        }
+    }
+
     for (rp = mac + RA; rp < mac + RA + 32; rp += 2) {
         if (!(rp[1] & E1000_RAH_AV)) {
             continue;
         }
         ra[0] = cpu_to_le32(rp[0]);
         ra[1] = cpu_to_le32(rp[1]);
-        if (!memcmp(buf, (uint8_t *)ra, ETH_ALEN)) {
+        if (!memcmp(ehdr->h_dest, (uint8_t *)ra, ETH_ALEN)) {
             trace_e1000x_rx_flt_ucast_match((int)(rp - mac - RA) / 2,
-                                            MAC_ARG(buf));
+                                            MAC_ARG(ehdr->h_dest));
             return true;
         }
     }
-    trace_e1000x_rx_flt_ucast_mismatch(MAC_ARG(buf));
+    trace_e1000x_rx_flt_ucast_mismatch(MAC_ARG(ehdr->h_dest));
 
     f = mta_shift[(rctl >> E1000_RCTL_MO_SHIFT) & 3];
-    f = (((buf[5] << 8) | buf[4]) >> f) & 0xfff;
+    f = (((ehdr->h_dest[5] << 8) | ehdr->h_dest[4]) >> f) & 0xfff;
     if (mac[MTA + (f >> 5)] & (1 << (f & 0x1f))) {
         return true;
     }
 
-    trace_e1000x_rx_flt_inexact_mismatch(MAC_ARG(buf),
+    trace_e1000x_rx_flt_inexact_mismatch(MAC_ARG(ehdr->h_dest),
                                          (rctl >> E1000_RCTL_MO_SHIFT) & 3,
                                          f >> 5,
                                          mac[MTA + (f >> 5)]);
diff --git a/hw/net/e1000x_common.h b/hw/net/e1000x_common.h
index 0298e06..be29168 100644
--- a/hw/net/e1000x_common.h
+++ b/hw/net/e1000x_common.h
@@ -107,7 +107,9 @@ bool e1000x_rx_ready(PCIDevice *d, uint32_t *mac);
 
 bool e1000x_is_vlan_packet(const void *buf, uint16_t vet);
 
-bool e1000x_rx_group_filter(uint32_t *mac, const uint8_t *buf);
+bool e1000x_rx_vlan_filter(uint32_t *mac, const struct vlan_header *vhdr);
+
+bool e1000x_rx_group_filter(uint32_t *mac, const struct eth_header *ehdr);
 
 bool e1000x_hw_rx_enabled(uint32_t *mac);
 
diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 1123df9..934db3c 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -976,7 +976,6 @@ static uint16_t igb_receive_assign(IGBCore *core, const L2Header *l2_header,
     uint16_t queues = 0;
     uint16_t oversized = 0;
     uint16_t vid = be16_to_cpu(l2_header->vlan.h_tci) & VLAN_VID_MASK;
-    bool accepted = false;
     int i;
 
     memset(rss_info, 0, sizeof(E1000E_RSSInfo));
@@ -986,16 +985,8 @@ static uint16_t igb_receive_assign(IGBCore *core, const L2Header *l2_header,
     }
 
     if (e1000x_is_vlan_packet(ehdr, core->mac[VET] & 0xffff) &&
-        e1000x_vlan_rx_filter_enabled(core->mac)) {
-        uint32_t vfta =
-            ldl_le_p((uint32_t *)(core->mac + VFTA) +
-                     ((vid >> E1000_VFTA_ENTRY_SHIFT) & E1000_VFTA_ENTRY_MASK));
-        if ((vfta & (1 << (vid & E1000_VFTA_ENTRY_BIT_SHIFT_MASK))) == 0) {
-            trace_e1000e_rx_flt_vlan_mismatch(vid);
-            return queues;
-        } else {
-            trace_e1000e_rx_flt_vlan_match(vid);
-        }
+        !e1000x_rx_vlan_filter(core->mac, PKT_GET_VLAN_HDR(ehdr))) {
+        return queues;
     }
 
     if (core->mac[MRQC] & 1) {
@@ -1103,33 +1094,7 @@ static uint16_t igb_receive_assign(IGBCore *core, const L2Header *l2_header,
             }
         }
     } else {
-        switch (net_rx_pkt_get_packet_type(core->rx_pkt)) {
-        case ETH_PKT_UCAST:
-            if (rctl & E1000_RCTL_UPE) {
-                accepted = true; /* promiscuous ucast */
-            }
-            break;
-
-        case ETH_PKT_BCAST:
-            if (rctl & E1000_RCTL_BAM) {
-                accepted = true; /* broadcast enabled */
-            }
-            break;
-
-        case ETH_PKT_MCAST:
-            if (rctl & E1000_RCTL_MPE) {
-                accepted = true; /* promiscuous mcast */
-            }
-            break;
-
-        default:
-            g_assert_not_reached();
-        }
-
-        if (!accepted) {
-            accepted = e1000x_rx_group_filter(core->mac, ehdr->h_dest);
-        }
-
+        bool accepted = e1000x_rx_group_filter(core->mac, ehdr);
         if (!accepted) {
             for (macp = core->mac + RA2; macp < core->mac + RA2 + 16; macp += 2) {
                 if (!(macp[1] & E1000_RAH_AV)) {
diff --git a/hw/net/trace-events b/hw/net/trace-events
index d35554f..a34d196 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -106,6 +106,8 @@ e1000_receiver_overrun(size_t s, uint32_t rdh, uint32_t rdt) "Receiver overrun:
 # e1000x_common.c
 e1000x_rx_can_recv_disabled(bool link_up, bool rx_enabled, bool pci_master) "link_up: %d, rx_enabled %d, pci_master %d"
 e1000x_vlan_is_vlan_pkt(bool is_vlan_pkt, uint16_t eth_proto, uint16_t vet) "Is VLAN packet: %d, ETH proto: 0x%X, VET: 0x%X"
+e1000x_rx_flt_vlan_mismatch(uint16_t vid) "VID mismatch: 0x%X"
+e1000x_rx_flt_vlan_match(uint16_t vid) "VID match: 0x%X"
 e1000x_rx_flt_ucast_match(uint32_t idx, uint8_t b0, uint8_t b1, uint8_t b2, uint8_t b3, uint8_t b4, uint8_t b5) "unicast match[%d]: %02x:%02x:%02x:%02x:%02x:%02x"
 e1000x_rx_flt_ucast_mismatch(uint8_t b0, uint8_t b1, uint8_t b2, uint8_t b3, uint8_t b4, uint8_t b5) "unicast mismatch: %02x:%02x:%02x:%02x:%02x:%02x"
 e1000x_rx_flt_inexact_mismatch(uint8_t b0, uint8_t b1, uint8_t b2, uint8_t b3, uint8_t b4, uint8_t b5, uint32_t mo, uint32_t mta, uint32_t mta_val) "inexact mismatch: %02x:%02x:%02x:%02x:%02x:%02x MO %d MTA[%d] 0x%x"
@@ -154,8 +156,6 @@ e1000e_rx_can_recv_rings_full(void) "Cannot receive: all rings are full"
 e1000e_rx_can_recv(void) "Can receive"
 e1000e_rx_has_buffers(int ridx, uint32_t free_desc, size_t total_size, uint32_t desc_buf_size) "ring #%d: free descr: %u, packet size %zu, descr buffer size %u"
 e1000e_rx_null_descriptor(void) "Null RX descriptor!!"
-e1000e_rx_flt_vlan_mismatch(uint16_t vid) "VID mismatch: 0x%X"
-e1000e_rx_flt_vlan_match(uint16_t vid) "VID match: 0x%X"
 e1000e_rx_desc_ps_read(uint64_t a0, uint64_t a1, uint64_t a2, uint64_t a3) "buffers: [0x%"PRIx64", 0x%"PRIx64", 0x%"PRIx64", 0x%"PRIx64"]"
 e1000e_rx_desc_ps_write(uint16_t a0, uint16_t a1, uint16_t a2, uint16_t a3) "bytes written: [%u, %u, %u, %u]"
 e1000e_rx_desc_buff_sizes(uint32_t b0, uint32_t b1, uint32_t b2, uint32_t b3) "buffer sizes: [%u, %u, %u, %u]"
-- 
2.7.4


