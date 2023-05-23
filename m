Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D29D70D510
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 09:33:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1MW1-000848-9a; Tue, 23 May 2023 03:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MVr-00081k-N2
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:32:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MVp-00047G-KC
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:32:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684827172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LK51sUAkrkFqOcVnU+SZma4sH8QIp1DLn3dbyZx7yfs=;
 b=cC4nHNPBb9blFbfxiXeZIK7x5flXtdgS9dLxDAtXRSO+ij4uk+wrAkrU/B/tkygH2h4GjX
 /Iy0vLtYYJwRLq+QmWeEhz5wmuklq26BY7gfiqKponaHszFb1Th/OcoCBxPvsertZ5/mkj
 ZRu0fOShZOJqykyScQYpAh8yUo3X6vk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-193-hfWss3zLOGek8aXmazD5Nw-1; Tue, 23 May 2023 03:32:51 -0400
X-MC-Unique: hfWss3zLOGek8aXmazD5Nw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA4BE185A78F;
 Tue, 23 May 2023 07:32:50 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-45.pek2.redhat.com [10.72.12.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CB0D02166B25;
 Tue, 23 May 2023 07:32:47 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 02/50] hw/net/net_tx_pkt: Decouple implementation from PCI
Date: Tue, 23 May 2023 15:31:50 +0800
Message-Id: <20230523073238.54236-3-jasowang@redhat.com>
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

This is intended to be followed by another change for the interface.
It also fixes the leak of memory mapping when the specified memory is
partially mapped.

Fixes: e263cd49c7 ("Packet abstraction for VMWARE network devices")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/net_tx_pkt.c | 53 +++++++++++++++++++++++++++++++++--------------------
 hw/net/net_tx_pkt.h |  9 +++++++++
 2 files changed, 42 insertions(+), 20 deletions(-)

diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
index 8dc8568..aca12ff 100644
--- a/hw/net/net_tx_pkt.c
+++ b/hw/net/net_tx_pkt.c
@@ -384,10 +384,9 @@ void net_tx_pkt_setup_vlan_header_ex(struct NetTxPkt *pkt,
     }
 }
 
-bool net_tx_pkt_add_raw_fragment(struct NetTxPkt *pkt, hwaddr pa,
-    size_t len)
+static bool net_tx_pkt_add_raw_fragment_common(struct NetTxPkt *pkt,
+                                               void *base, size_t len)
 {
-    hwaddr mapped_len = 0;
     struct iovec *ventry;
     assert(pkt);
 
@@ -395,23 +394,12 @@ bool net_tx_pkt_add_raw_fragment(struct NetTxPkt *pkt, hwaddr pa,
         return false;
     }
 
-    if (!len) {
-        return true;
-     }
-
     ventry = &pkt->raw[pkt->raw_frags];
-    mapped_len = len;
+    ventry->iov_base = base;
+    ventry->iov_len = len;
+    pkt->raw_frags++;
 
-    ventry->iov_base = pci_dma_map(pkt->pci_dev, pa,
-                                   &mapped_len, DMA_DIRECTION_TO_DEVICE);
-
-    if ((ventry->iov_base != NULL) && (len == mapped_len)) {
-        ventry->iov_len = mapped_len;
-        pkt->raw_frags++;
-        return true;
-    } else {
-        return false;
-    }
+    return true;
 }
 
 bool net_tx_pkt_has_fragments(struct NetTxPkt *pkt)
@@ -465,8 +453,9 @@ void net_tx_pkt_reset(struct NetTxPkt *pkt, PCIDevice *pci_dev)
         assert(pkt->raw);
         for (i = 0; i < pkt->raw_frags; i++) {
             assert(pkt->raw[i].iov_base);
-            pci_dma_unmap(pkt->pci_dev, pkt->raw[i].iov_base,
-                          pkt->raw[i].iov_len, DMA_DIRECTION_TO_DEVICE, 0);
+            net_tx_pkt_unmap_frag_pci(pkt->pci_dev,
+                                      pkt->raw[i].iov_base,
+                                      pkt->raw[i].iov_len);
         }
     }
     pkt->pci_dev = pci_dev;
@@ -476,6 +465,30 @@ void net_tx_pkt_reset(struct NetTxPkt *pkt, PCIDevice *pci_dev)
     pkt->l4proto = 0;
 }
 
+void net_tx_pkt_unmap_frag_pci(void *context, void *base, size_t len)
+{
+    pci_dma_unmap(context, base, len, DMA_DIRECTION_TO_DEVICE, 0);
+}
+
+bool net_tx_pkt_add_raw_fragment(struct NetTxPkt *pkt, hwaddr pa,
+    size_t len)
+{
+    dma_addr_t mapped_len = len;
+    void *base = pci_dma_map(pkt->pci_dev, pa, &mapped_len,
+                             DMA_DIRECTION_TO_DEVICE);
+    if (!base) {
+        return false;
+    }
+
+    if (mapped_len != len ||
+        !net_tx_pkt_add_raw_fragment_common(pkt, base, len)) {
+        net_tx_pkt_unmap_frag_pci(pkt->pci_dev, base, mapped_len);
+        return false;
+    }
+
+    return true;
+}
+
 static void net_tx_pkt_do_sw_csum(struct NetTxPkt *pkt,
                                   struct iovec *iov, uint32_t iov_len,
                                   uint16_t csl)
diff --git a/hw/net/net_tx_pkt.h b/hw/net/net_tx_pkt.h
index e5ce6f2..5eb123e 100644
--- a/hw/net/net_tx_pkt.h
+++ b/hw/net/net_tx_pkt.h
@@ -154,6 +154,15 @@ void net_tx_pkt_dump(struct NetTxPkt *pkt);
 void net_tx_pkt_reset(struct NetTxPkt *pkt, PCIDevice *dev);
 
 /**
+ * Unmap a fragment mapped from a PCI device.
+ *
+ * @context:        PCI device owning fragment
+ * @base:           pointer to fragment
+ * @len:            length of fragment
+ */
+void net_tx_pkt_unmap_frag_pci(void *context, void *base, size_t len);
+
+/**
  * Send packet to qemu. handles sw offloads if vhdr is not supported.
  *
  * @pkt:            packet
-- 
2.7.4


