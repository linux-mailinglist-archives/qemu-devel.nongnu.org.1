Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4647C70D51E
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 09:34:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1MW4-00085n-Ig; Tue, 23 May 2023 03:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MVw-00082T-14
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:33:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MVt-00047l-Pe
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684827175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F9FNlAbok1JAr4KCaJWGURmBXLP4h+TNep1/jDtFdEo=;
 b=LJUltQ8bibI8mJFLLiKR2TEDI1xBip6cRnk+NTXDcGDMFyY3jcby3ZcCwi3CV8b7pawPMU
 jewYFnOtVnnvHHdLNDwJ7B5k+wJH+A3ZNjrZsFdcc+LptNi3rNgnfBlmJDfy2AjZaZbTD7
 Hy/g3VceG9utTCyjoKr07tFXfh9DArQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-145-xANBi2BiPGep99rtVqvSRw-1; Tue, 23 May 2023 03:32:54 -0400
X-MC-Unique: xANBi2BiPGep99rtVqvSRw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9659C101A52C;
 Tue, 23 May 2023 07:32:53 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-45.pek2.redhat.com [10.72.12.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6D6E42166B25;
 Tue, 23 May 2023 07:32:51 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 03/50] hw/net/net_tx_pkt: Decouple interface from PCI
Date: Tue, 23 May 2023 15:31:51 +0800
Message-Id: <20230523073238.54236-4-jasowang@redhat.com>
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

This allows to use the network packet abstractions even if PCI is not
used.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/e1000e_core.c | 13 ++++++++-----
 hw/net/igb_core.c    | 13 ++++++-------
 hw/net/net_tx_pkt.c  | 36 +++++++++++++-----------------------
 hw/net/net_tx_pkt.h  | 31 ++++++++++++++++++++-----------
 hw/net/vmxnet3.c     | 14 +++++++-------
 5 files changed, 54 insertions(+), 53 deletions(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index cfa3f55..15821a7 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -746,7 +746,8 @@ e1000e_process_tx_desc(E1000ECore *core,
     addr = le64_to_cpu(dp->buffer_addr);
 
     if (!tx->skip_cp) {
-        if (!net_tx_pkt_add_raw_fragment(tx->tx_pkt, addr, split_size)) {
+        if (!net_tx_pkt_add_raw_fragment_pci(tx->tx_pkt, core->owner,
+                                             addr, split_size)) {
             tx->skip_cp = true;
         }
     }
@@ -764,7 +765,7 @@ e1000e_process_tx_desc(E1000ECore *core,
         }
 
         tx->skip_cp = false;
-        net_tx_pkt_reset(tx->tx_pkt, core->owner);
+        net_tx_pkt_reset(tx->tx_pkt, net_tx_pkt_unmap_frag_pci, core->owner);
 
         tx->sum_needed = 0;
         tx->cptse = 0;
@@ -3421,7 +3422,7 @@ e1000e_core_pci_realize(E1000ECore     *core,
         qemu_add_vm_change_state_handler(e1000e_vm_state_change, core);
 
     for (i = 0; i < E1000E_NUM_QUEUES; i++) {
-        net_tx_pkt_init(&core->tx[i].tx_pkt, core->owner, E1000E_MAX_TX_FRAGS);
+        net_tx_pkt_init(&core->tx[i].tx_pkt, E1000E_MAX_TX_FRAGS);
     }
 
     net_rx_pkt_init(&core->rx_pkt);
@@ -3446,7 +3447,8 @@ e1000e_core_pci_uninit(E1000ECore *core)
     qemu_del_vm_change_state_handler(core->vmstate);
 
     for (i = 0; i < E1000E_NUM_QUEUES; i++) {
-        net_tx_pkt_reset(core->tx[i].tx_pkt, core->owner);
+        net_tx_pkt_reset(core->tx[i].tx_pkt,
+                         net_tx_pkt_unmap_frag_pci, core->owner);
         net_tx_pkt_uninit(core->tx[i].tx_pkt);
     }
 
@@ -3571,7 +3573,8 @@ static void e1000e_reset(E1000ECore *core, bool sw)
     e1000x_reset_mac_addr(core->owner_nic, core->mac, core->permanent_mac);
 
     for (i = 0; i < ARRAY_SIZE(core->tx); i++) {
-        net_tx_pkt_reset(core->tx[i].tx_pkt, core->owner);
+        net_tx_pkt_reset(core->tx[i].tx_pkt,
+                         net_tx_pkt_unmap_frag_pci, core->owner);
         memset(&core->tx[i].props, 0, sizeof(core->tx[i].props));
         core->tx[i].skip_cp = false;
     }
diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 826e7a6..abfdce9 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -597,7 +597,8 @@ igb_process_tx_desc(IGBCore *core,
     length = cmd_type_len & 0xFFFF;
 
     if (!tx->skip_cp) {
-        if (!net_tx_pkt_add_raw_fragment(tx->tx_pkt, buffer_addr, length)) {
+        if (!net_tx_pkt_add_raw_fragment_pci(tx->tx_pkt, dev,
+                                             buffer_addr, length)) {
             tx->skip_cp = true;
         }
     }
@@ -616,7 +617,7 @@ igb_process_tx_desc(IGBCore *core,
 
         tx->first = true;
         tx->skip_cp = false;
-        net_tx_pkt_reset(tx->tx_pkt, dev);
+        net_tx_pkt_reset(tx->tx_pkt, net_tx_pkt_unmap_frag_pci, dev);
     }
 }
 
@@ -842,8 +843,6 @@ igb_start_xmit(IGBCore *core, const IGB_TxRing *txr)
         d = core->owner;
     }
 
-    net_tx_pkt_reset(txr->tx->tx_pkt, d);
-
     while (!igb_ring_empty(core, txi)) {
         base = igb_ring_head_descr(core, txi);
 
@@ -861,6 +860,8 @@ igb_start_xmit(IGBCore *core, const IGB_TxRing *txr)
         core->mac[EICR] |= eic;
         igb_set_interrupt_cause(core, E1000_ICR_TXDW);
     }
+
+    net_tx_pkt_reset(txr->tx->tx_pkt, net_tx_pkt_unmap_frag_pci, d);
 }
 
 static uint32_t
@@ -3954,7 +3955,7 @@ igb_core_pci_realize(IGBCore        *core,
     core->vmstate = qemu_add_vm_change_state_handler(igb_vm_state_change, core);
 
     for (i = 0; i < IGB_NUM_QUEUES; i++) {
-        net_tx_pkt_init(&core->tx[i].tx_pkt, NULL, E1000E_MAX_TX_FRAGS);
+        net_tx_pkt_init(&core->tx[i].tx_pkt, E1000E_MAX_TX_FRAGS);
     }
 
     net_rx_pkt_init(&core->rx_pkt);
@@ -3979,7 +3980,6 @@ igb_core_pci_uninit(IGBCore *core)
     qemu_del_vm_change_state_handler(core->vmstate);
 
     for (i = 0; i < IGB_NUM_QUEUES; i++) {
-        net_tx_pkt_reset(core->tx[i].tx_pkt, NULL);
         net_tx_pkt_uninit(core->tx[i].tx_pkt);
     }
 
@@ -4158,7 +4158,6 @@ static void igb_reset(IGBCore *core, bool sw)
 
     for (i = 0; i < ARRAY_SIZE(core->tx); i++) {
         tx = &core->tx[i];
-        net_tx_pkt_reset(tx->tx_pkt, NULL);
         memset(tx->ctx, 0, sizeof(tx->ctx));
         tx->first = true;
         tx->skip_cp = false;
diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
index aca12ff..cc36750 100644
--- a/hw/net/net_tx_pkt.c
+++ b/hw/net/net_tx_pkt.c
@@ -16,12 +16,12 @@
  */
 
 #include "qemu/osdep.h"
-#include "net_tx_pkt.h"
 #include "net/eth.h"
 #include "net/checksum.h"
 #include "net/tap.h"
 #include "net/net.h"
 #include "hw/pci/pci_device.h"
+#include "net_tx_pkt.h"
 
 enum {
     NET_TX_PKT_VHDR_FRAG = 0,
@@ -32,8 +32,6 @@ enum {
 
 /* TX packet private context */
 struct NetTxPkt {
-    PCIDevice *pci_dev;
-
     struct virtio_net_hdr virt_hdr;
 
     struct iovec *raw;
@@ -59,13 +57,10 @@ struct NetTxPkt {
     uint8_t l4proto;
 };
 
-void net_tx_pkt_init(struct NetTxPkt **pkt, PCIDevice *pci_dev,
-    uint32_t max_frags)
+void net_tx_pkt_init(struct NetTxPkt **pkt, uint32_t max_frags)
 {
     struct NetTxPkt *p = g_malloc0(sizeof *p);
 
-    p->pci_dev = pci_dev;
-
     p->vec = g_new(struct iovec, max_frags + NET_TX_PKT_PL_START_FRAG);
 
     p->raw = g_new(struct iovec, max_frags);
@@ -384,8 +379,7 @@ void net_tx_pkt_setup_vlan_header_ex(struct NetTxPkt *pkt,
     }
 }
 
-static bool net_tx_pkt_add_raw_fragment_common(struct NetTxPkt *pkt,
-                                               void *base, size_t len)
+bool net_tx_pkt_add_raw_fragment(struct NetTxPkt *pkt, void *base, size_t len)
 {
     struct iovec *ventry;
     assert(pkt);
@@ -433,7 +427,8 @@ void net_tx_pkt_dump(struct NetTxPkt *pkt)
 #endif
 }
 
-void net_tx_pkt_reset(struct NetTxPkt *pkt, PCIDevice *pci_dev)
+void net_tx_pkt_reset(struct NetTxPkt *pkt,
+                      NetTxPktFreeFrag callback, void *context)
 {
     int i;
 
@@ -453,12 +448,9 @@ void net_tx_pkt_reset(struct NetTxPkt *pkt, PCIDevice *pci_dev)
         assert(pkt->raw);
         for (i = 0; i < pkt->raw_frags; i++) {
             assert(pkt->raw[i].iov_base);
-            net_tx_pkt_unmap_frag_pci(pkt->pci_dev,
-                                      pkt->raw[i].iov_base,
-                                      pkt->raw[i].iov_len);
+            callback(context, pkt->raw[i].iov_base, pkt->raw[i].iov_len);
         }
     }
-    pkt->pci_dev = pci_dev;
     pkt->raw_frags = 0;
 
     pkt->hdr_len = 0;
@@ -470,19 +462,17 @@ void net_tx_pkt_unmap_frag_pci(void *context, void *base, size_t len)
     pci_dma_unmap(context, base, len, DMA_DIRECTION_TO_DEVICE, 0);
 }
 
-bool net_tx_pkt_add_raw_fragment(struct NetTxPkt *pkt, hwaddr pa,
-    size_t len)
+bool net_tx_pkt_add_raw_fragment_pci(struct NetTxPkt *pkt, PCIDevice *pci_dev,
+                                     dma_addr_t pa, size_t len)
 {
     dma_addr_t mapped_len = len;
-    void *base = pci_dma_map(pkt->pci_dev, pa, &mapped_len,
-                             DMA_DIRECTION_TO_DEVICE);
+    void *base = pci_dma_map(pci_dev, pa, &mapped_len, DMA_DIRECTION_TO_DEVICE);
     if (!base) {
         return false;
     }
 
-    if (mapped_len != len ||
-        !net_tx_pkt_add_raw_fragment_common(pkt, base, len)) {
-        net_tx_pkt_unmap_frag_pci(pkt->pci_dev, base, mapped_len);
+    if (mapped_len != len || !net_tx_pkt_add_raw_fragment(pkt, base, len)) {
+        net_tx_pkt_unmap_frag_pci(pci_dev, base, mapped_len);
         return false;
     }
 
@@ -710,7 +700,7 @@ static void net_tx_pkt_udp_fragment_fix(struct NetTxPkt *pkt,
 }
 
 static bool net_tx_pkt_do_sw_fragmentation(struct NetTxPkt *pkt,
-                                           NetTxPktCallback callback,
+                                           NetTxPktSend callback,
                                            void *context)
 {
     uint8_t gso_type = pkt->virt_hdr.gso_type & ~VIRTIO_NET_HDR_GSO_ECN;
@@ -807,7 +797,7 @@ bool net_tx_pkt_send(struct NetTxPkt *pkt, NetClientState *nc)
 }
 
 bool net_tx_pkt_send_custom(struct NetTxPkt *pkt, bool offload,
-                            NetTxPktCallback callback, void *context)
+                            NetTxPktSend callback, void *context)
 {
     assert(pkt);
 
diff --git a/hw/net/net_tx_pkt.h b/hw/net/net_tx_pkt.h
index 5eb123e..4d7233e 100644
--- a/hw/net/net_tx_pkt.h
+++ b/hw/net/net_tx_pkt.h
@@ -26,17 +26,16 @@
 
 struct NetTxPkt;
 
-typedef void (* NetTxPktCallback)(void *, const struct iovec *, int, const struct iovec *, int);
+typedef void (*NetTxPktFreeFrag)(void *, void *, size_t);
+typedef void (*NetTxPktSend)(void *, const struct iovec *, int, const struct iovec *, int);
 
 /**
  * Init function for tx packet functionality
  *
  * @pkt:            packet pointer
- * @pci_dev:        PCI device processing this packet
  * @max_frags:      max tx ip fragments
  */
-void net_tx_pkt_init(struct NetTxPkt **pkt, PCIDevice *pci_dev,
-    uint32_t max_frags);
+void net_tx_pkt_init(struct NetTxPkt **pkt, uint32_t max_frags);
 
 /**
  * Clean all tx packet resources.
@@ -95,12 +94,11 @@ net_tx_pkt_setup_vlan_header(struct NetTxPkt *pkt, uint16_t vlan)
  * populate data fragment into pkt context.
  *
  * @pkt:            packet
- * @pa:             physical address of fragment
+ * @base:           pointer to fragment
  * @len:            length of fragment
  *
  */
-bool net_tx_pkt_add_raw_fragment(struct NetTxPkt *pkt, hwaddr pa,
-    size_t len);
+bool net_tx_pkt_add_raw_fragment(struct NetTxPkt *pkt, void *base, size_t len);
 
 /**
  * Fix ip header fields and calculate IP header and pseudo header checksums.
@@ -148,10 +146,11 @@ void net_tx_pkt_dump(struct NetTxPkt *pkt);
  * reset tx packet private context (needed to be called between packets)
  *
  * @pkt:            packet
- * @dev:            PCI device processing the next packet
- *
+ * @callback:       function to free the fragments
+ * @context:        pointer to be passed to the callback
  */
-void net_tx_pkt_reset(struct NetTxPkt *pkt, PCIDevice *dev);
+void net_tx_pkt_reset(struct NetTxPkt *pkt,
+                      NetTxPktFreeFrag callback, void *context);
 
 /**
  * Unmap a fragment mapped from a PCI device.
@@ -163,6 +162,16 @@ void net_tx_pkt_reset(struct NetTxPkt *pkt, PCIDevice *dev);
 void net_tx_pkt_unmap_frag_pci(void *context, void *base, size_t len);
 
 /**
+ * map data fragment from PCI device and populate it into pkt context.
+ *
+ * @pci_dev:        PCI device owning fragment
+ * @pa:             physical address of fragment
+ * @len:            length of fragment
+ */
+bool net_tx_pkt_add_raw_fragment_pci(struct NetTxPkt *pkt, PCIDevice *pci_dev,
+                                     dma_addr_t pa, size_t len);
+
+/**
  * Send packet to qemu. handles sw offloads if vhdr is not supported.
  *
  * @pkt:            packet
@@ -182,7 +191,7 @@ bool net_tx_pkt_send(struct NetTxPkt *pkt, NetClientState *nc);
  * @ret:            operation result
  */
 bool net_tx_pkt_send_custom(struct NetTxPkt *pkt, bool offload,
-                            NetTxPktCallback callback, void *context);
+                            NetTxPktSend callback, void *context);
 
 /**
  * parse raw packet data and analyze offload requirements.
diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index f7b874c..9acff31 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -651,9 +651,8 @@ static void vmxnet3_process_tx_queue(VMXNET3State *s, int qidx)
             data_len = (txd.len > 0) ? txd.len : VMXNET3_MAX_TX_BUF_SIZE;
             data_pa = txd.addr;
 
-            if (!net_tx_pkt_add_raw_fragment(s->tx_pkt,
-                                                data_pa,
-                                                data_len)) {
+            if (!net_tx_pkt_add_raw_fragment_pci(s->tx_pkt, PCI_DEVICE(s),
+                                                 data_pa, data_len)) {
                 s->skip_current_tx_pkt = true;
             }
         }
@@ -678,7 +677,8 @@ static void vmxnet3_process_tx_queue(VMXNET3State *s, int qidx)
             vmxnet3_complete_packet(s, qidx, txd_idx);
             s->tx_sop = true;
             s->skip_current_tx_pkt = false;
-            net_tx_pkt_reset(s->tx_pkt, PCI_DEVICE(s));
+            net_tx_pkt_reset(s->tx_pkt,
+                             net_tx_pkt_unmap_frag_pci, PCI_DEVICE(s));
         }
     }
 }
@@ -1159,7 +1159,7 @@ static void vmxnet3_deactivate_device(VMXNET3State *s)
 {
     if (s->device_active) {
         VMW_CBPRN("Deactivating vmxnet3...");
-        net_tx_pkt_reset(s->tx_pkt, PCI_DEVICE(s));
+        net_tx_pkt_reset(s->tx_pkt, net_tx_pkt_unmap_frag_pci, PCI_DEVICE(s));
         net_tx_pkt_uninit(s->tx_pkt);
         net_rx_pkt_uninit(s->rx_pkt);
         s->device_active = false;
@@ -1519,7 +1519,7 @@ static void vmxnet3_activate_device(VMXNET3State *s)
 
     /* Preallocate TX packet wrapper */
     VMW_CFPRN("Max TX fragments is %u", s->max_tx_frags);
-    net_tx_pkt_init(&s->tx_pkt, PCI_DEVICE(s), s->max_tx_frags);
+    net_tx_pkt_init(&s->tx_pkt, s->max_tx_frags);
     net_rx_pkt_init(&s->rx_pkt);
 
     /* Read rings memory locations for RX queues */
@@ -2399,7 +2399,7 @@ static int vmxnet3_post_load(void *opaque, int version_id)
 {
     VMXNET3State *s = opaque;
 
-    net_tx_pkt_init(&s->tx_pkt, PCI_DEVICE(s), s->max_tx_frags);
+    net_tx_pkt_init(&s->tx_pkt, s->max_tx_frags);
     net_rx_pkt_init(&s->rx_pkt);
 
     if (s->msix_used) {
-- 
2.7.4


