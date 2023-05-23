Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C4570D1B2
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 04:48:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1I0Q-00036V-T6; Mon, 22 May 2023 22:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I0O-000364-Rd
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:44:08 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I0H-00044K-US
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:44:08 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-25355609a04so5230101a91.0
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 19:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1684809841; x=1687401841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1IrqkktLU+tK6aiL60fs5u4i+ujMG6g/3y41kq771yc=;
 b=COX9WixmY7VA4TqfqwUizVpAXwWplNxBhJsz8aBZiDnfnEsVAT9zagGZvbEWSinN5R
 tS1O3572hMJt0qsrgcAg436feLmmsdQWdNTo9KEuEXsPyl97pXeJr92/yvC7L3ThFOjT
 ZA7YEKMuLPf3STdUTsnaKna5RFgOT71AJBFRo1mFp3WJUDU96kwtFso9RhzhEcpxoPNg
 crgYQdqDxlDdpy3Yr84rruAwsZ/WHsjq3mp/2++mCVs1PhymSMsr+8Eb5yLL+NKdcUnd
 YeoFCJZXExAzuY7jm5nEpcSr0oh4eopu1xpBSqPLWF6X9tLKwqqJC8q8s9Cnb02JJDCI
 d2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684809841; x=1687401841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1IrqkktLU+tK6aiL60fs5u4i+ujMG6g/3y41kq771yc=;
 b=MWA9j8LvSGwr0Rr6Ctw0JabhkOBSGWGj8Co2l0IT5vq6yVrV8cgJLYqh1F2xTGRDnJ
 HXhpAWtVKPINccU7QESYqEiHtDm+jEvTFhqZwQ0nEfhW4b/Z81hblY8C9sG7zt7Yl/U2
 oIb4Fab2NTGd4xaYa0PnBqcGQ/1sScUtmpQxgWdU6UvQwAEcvUaPm5C2k5Xh/QUINp6f
 SNZtAl2Zs/mnt2QWz9cBzuKz+kA9aRJW7o7yOjlwI7rSFmHOoTXJbUwvtDPe2nemofd7
 aE5DmgPef0Xtdy1HU5biv/7VwQPLHAOgwXvcKtCvMjz8QbraB2OVcte3fycz9M3nKVSz
 bvLA==
X-Gm-Message-State: AC+VfDzhaLDb4nX9N076Eb4AKXzh69T5qfdklV4QTZo2d9NtB6mvnzr8
 XSZWCmxbLbUV0al5N+KY4BfDQg==
X-Google-Smtp-Source: ACHHUZ7zvoKm9mrgJsfleBeCekC6oZAH7O/76SdLp4i49ymtUcdI/sL+0f5tYsFDjDcPoyFJ42FZaA==
X-Received: by 2002:a17:90b:190d:b0:247:afed:6d62 with SMTP id
 mp13-20020a17090b190d00b00247afed6d62mr11643658pjb.46.1684809840647; 
 Mon, 22 May 2023 19:44:00 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 o10-20020a17090aac0a00b002467717fa60sm4769847pjq.16.2023.05.22.19.43.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 19:44:00 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Tomasz Dzieciol <t.dzieciol@partner.samsung.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v5 02/48] hw/net/net_tx_pkt: Decouple interface from PCI
Date: Tue, 23 May 2023 11:42:53 +0900
Message-Id: <20230523024339.50875-3-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523024339.50875-1-akihiko.odaki@daynix.com>
References: <20230523024339.50875-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1031;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This allows to use the network packet abstractions even if PCI is not
used.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/net_tx_pkt.h  | 31 ++++++++++++++++++++-----------
 hw/net/e1000e_core.c | 13 ++++++++-----
 hw/net/igb_core.c    | 13 ++++++-------
 hw/net/net_tx_pkt.c  | 36 +++++++++++++-----------------------
 hw/net/vmxnet3.c     | 14 +++++++-------
 5 files changed, 54 insertions(+), 53 deletions(-)

diff --git a/hw/net/net_tx_pkt.h b/hw/net/net_tx_pkt.h
index 5eb123ef90..4d7233e975 100644
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
@@ -162,6 +161,16 @@ void net_tx_pkt_reset(struct NetTxPkt *pkt, PCIDevice *dev);
  */
 void net_tx_pkt_unmap_frag_pci(void *context, void *base, size_t len);
 
+/**
+ * map data fragment from PCI device and populate it into pkt context.
+ *
+ * @pci_dev:        PCI device owning fragment
+ * @pa:             physical address of fragment
+ * @len:            length of fragment
+ */
+bool net_tx_pkt_add_raw_fragment_pci(struct NetTxPkt *pkt, PCIDevice *pci_dev,
+                                     dma_addr_t pa, size_t len);
+
 /**
  * Send packet to qemu. handles sw offloads if vhdr is not supported.
  *
@@ -182,7 +191,7 @@ bool net_tx_pkt_send(struct NetTxPkt *pkt, NetClientState *nc);
  * @ret:            operation result
  */
 bool net_tx_pkt_send_custom(struct NetTxPkt *pkt, bool offload,
-                            NetTxPktCallback callback, void *context);
+                            NetTxPktSend callback, void *context);
 
 /**
  * parse raw packet data and analyze offload requirements.
diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index cfa3f55e96..15821a75e0 100644
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
index 826e7a6cf1..abfdce9aaf 100644
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
index aca12ff035..cc36750c9b 100644
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
 
diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index f7b874c139..9acff310e7 100644
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
2.40.1


