Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E211D70D184
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 04:44:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1I0H-00035U-U7; Mon, 22 May 2023 22:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I0G-00035H-7w
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:44:00 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I0E-00043m-KB
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:44:00 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-25343f0c693so4663927a91.3
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 19:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1684809837; x=1687401837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YV5jLwKxJCy8fH3BR1nWl7y3w5hfwEqFDtdAfG5oNfs=;
 b=5Injns11iiNztnTw3y0hcY2mp2Cvo4wctnTpfiqQ2r3Fy3JYPhwZt2MPARoSkyijM7
 dGku6tkdGk/SVSusaF8HR4f/Qz7WEhQI9ub2FClwUlWxiCI58c2pUey964otZ8VZVxcO
 XiJPu7gs1RZzp4luwKoObTGnyD5FdToGeFrPOPCyyxwkrsMBIgw9keZ6ouDPYf/7a4va
 RJqkarqEwQdIaEYSQVfflcLXqaswrUvBBAEQ1u6VnYENDXWe53x5UjN1GL4ffiT9Wfzs
 PYDGMKad3V/q2uTSzerecPNIxGdCyHkfa6zcHy0wxE+HD700GZWmXiHuuNPqDH1hbNp3
 ys3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684809837; x=1687401837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YV5jLwKxJCy8fH3BR1nWl7y3w5hfwEqFDtdAfG5oNfs=;
 b=OrLh7Ub4mVUJ7w+mUYHnMrAHpDFo965LS9kFWvhpm3zdpaUvvWlIzecTtbWI64SxSj
 Fr5UkpFWI2K+f35wiblq0koncngF8cn13RHQ71gYZxUo6fDGcivNACq9tCcxdrCqYMlG
 IDKIGFt39Sc/fhAfCs0/5SW+NsIaMrnicam90jeosXqXYlf/76kRqs2JPtbAPChFY5+e
 s5Qh3xXHW1Mf8Aa9nh+V5uIYyfvRfrI4cN2WVMDWMuPybgYtcZ8S1FFAVRzd9CMrxIc6
 VERqOp8+WkJiDRgSxiJsDY6XO5acj/eL96EwBwA8FF8tYJkb9Xtgy/8vjc7GgZaG84J+
 xoew==
X-Gm-Message-State: AC+VfDwYqWCj/z5MM5hTtACmoFvtGLLeQc7LdTlBTxxdOV9bWO27PHo5
 Ml8hf+sQVHRuJePsy/dtB1wwcg==
X-Google-Smtp-Source: ACHHUZ6Oc0tlyH/pUphDuP3qeWcuBUNdZmh9J6UcLlkvD2nZ/13pMIEKkFnLZ1impYmlcngGSxAk5A==
X-Received: by 2002:a17:90b:4b01:b0:250:faff:e201 with SMTP id
 lx1-20020a17090b4b0100b00250faffe201mr12093934pjb.36.1684809837183; 
 Mon, 22 May 2023 19:43:57 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 o10-20020a17090aac0a00b002467717fa60sm4769847pjq.16.2023.05.22.19.43.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 19:43:56 -0700 (PDT)
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
Subject: [PATCH v5 01/48] hw/net/net_tx_pkt: Decouple implementation from PCI
Date: Tue, 23 May 2023 11:42:52 +0900
Message-Id: <20230523024339.50875-2-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523024339.50875-1-akihiko.odaki@daynix.com>
References: <20230523024339.50875-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::102f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102f.google.com
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

This is intended to be followed by another change for the interface.
It also fixes the leak of memory mapping when the specified memory is
partially mapped.

Fixes: e263cd49c7 ("Packet abstraction for VMWARE network devices")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/net_tx_pkt.h |  9 ++++++++
 hw/net/net_tx_pkt.c | 53 ++++++++++++++++++++++++++++-----------------
 2 files changed, 42 insertions(+), 20 deletions(-)

diff --git a/hw/net/net_tx_pkt.h b/hw/net/net_tx_pkt.h
index e5ce6f20bc..5eb123ef90 100644
--- a/hw/net/net_tx_pkt.h
+++ b/hw/net/net_tx_pkt.h
@@ -153,6 +153,15 @@ void net_tx_pkt_dump(struct NetTxPkt *pkt);
  */
 void net_tx_pkt_reset(struct NetTxPkt *pkt, PCIDevice *dev);
 
+/**
+ * Unmap a fragment mapped from a PCI device.
+ *
+ * @context:        PCI device owning fragment
+ * @base:           pointer to fragment
+ * @len:            length of fragment
+ */
+void net_tx_pkt_unmap_frag_pci(void *context, void *base, size_t len);
+
 /**
  * Send packet to qemu. handles sw offloads if vhdr is not supported.
  *
diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
index 8dc8568ba2..aca12ff035 100644
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
-- 
2.40.1


