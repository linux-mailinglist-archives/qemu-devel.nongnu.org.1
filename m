Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F40837A8F34
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 00:20:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj5Wv-0002Y4-Bz; Wed, 20 Sep 2023 18:18:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3uW8LZQwKCvQjWXedaopabWjckkcha.Ykimaiq-Zarahjkjcjq.knc@flex--nabihestefan.bounces.google.com>)
 id 1qj5Wo-0002Rg-CZ
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 18:18:38 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3uW8LZQwKCvQjWXedaopabWjckkcha.Ykimaiq-Zarahjkjcjq.knc@flex--nabihestefan.bounces.google.com>)
 id 1qj5Wk-0008Bb-OF
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 18:18:38 -0400
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-d77fa2e7771so476441276.1
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 15:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1695248313; x=1695853113; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=cYRFZd6rpYqcU9kFh7GOnIZNl0WmlG8NZvmZhOLAZ+A=;
 b=WwWW9uzmAQGH302YKHWvdSvnVl1y2FUzvm6RNJ+ebhSbSd7bV83C2NW+RIkUofUS5b
 px/CK5W/G2qO3LSzzK6sQLMFcr6C18A7tuvfwaSHMgt2pUKLCJKx8rnHIoDpov+H2tVb
 cI/m38KWx6Qo7AtwbqH08GsZIaTZrEvmEQBxOnUku1+8gqzTAJaTzr86K277s5uCpfb1
 CFaABndBfiEMme8jJ8N6jLKQaoJVJR6bpli8pO/nNIcsaKd++Y1AWpSP3kV65enMdbdl
 QGgNAGwHbTTLhKEB+gSxySwZ1TmeredjpTjonWwjU6OxOQmBeZ4HH5FH4SfFrEvqE+oW
 Rpxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695248313; x=1695853113;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cYRFZd6rpYqcU9kFh7GOnIZNl0WmlG8NZvmZhOLAZ+A=;
 b=G626SACHRLRQiyW8ySZl/VKTZ5/aiYylaEQ7I6sqpYZFPagI/xvXMGvjACHJsWYTFS
 djaFfknC/dH+BoA/AXERBEupMED3F+6TgOIyPOR/5oQVlKEjXFCs3edTo+tuRivLpGVP
 XuTAJZwIaD1UTFxU0+cuvcrhz9dd53Te7FNFgyOtM/haPBedIdv0O2EI0lqVv40+D5wC
 dHIo8jBCWe5rl8wwrxJBmDazLCpcAh6RpaQ0AkOpPnK3lzm7Qa4uJ0uNiZIsSXEpx72p
 cHurtn0VefRfbglcPqh3gIYtOgnkCx6+SqTL0bdcTGclueHRaXejtNzAqBCxt526JwjJ
 oSrA==
X-Gm-Message-State: AOJu0Yxex1IR+uV2J2m0sD3dq6D8bDxgNRcVkI1VRpnYK/UgKaSp6qIX
 PM1xx9xQyBe7jAizO/LjSNqos+LoFzpO9pL+BGc=
X-Google-Smtp-Source: AGHT+IFjqLQrhADoJhEpMu/evak8NwCcvJP2vEt40Uc5MmmItnWAvlj31CHvPiBTbkvTh7yzE87oo53nLtXN0Yv4hvU=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a25:bc6:0:b0:d7f:2cb6:7d8a with SMTP
 id 189-20020a250bc6000000b00d7f2cb67d8amr56146ybl.11.1695248313240; Wed, 20
 Sep 2023 15:18:33 -0700 (PDT)
Date: Wed, 20 Sep 2023 22:18:15 +0000
In-Reply-To: <20230920221819.1106029-1-nabihestefan@google.com>
Mime-Version: 1.0
References: <20230920221819.1106029-1-nabihestefan@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230920221819.1106029-8-nabihestefan@google.com>
Subject: [PATCH v2 07/11] include/hw/net: Implemented Classes and Masks for
 GMAC Descriptors
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasonwang@redhat.com, avi.fishman@nuvoton.com, 
 Nabih Estefan Diaz <nabihestefan@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3uW8LZQwKCvQjWXedaopabWjckkcha.Ykimaiq-Zarahjkjcjq.knc@flex--nabihestefan.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

From: Nabih Estefan Diaz <nabihestefan@google.com>

 - Implemeted classes for GMAC Receive and Transmit Descriptors
 - Implemented Masks for said descriptors

Signed-off-by: Nabih Estefan Diaz <nabihestefan@google.com>
---
 hw/net/npcm_gmac.c           | 183 +++++++++++++++++++++++++++--------
 hw/net/trace-events          |   9 ++
 include/hw/net/npcm_gmac.h   |   2 -
 tests/qtest/npcm_gmac-test.c |   2 +-
 4 files changed, 150 insertions(+), 46 deletions(-)

diff --git a/hw/net/npcm_gmac.c b/hw/net/npcm_gmac.c
index 5ce632858d..6f8109e0ee 100644
--- a/hw/net/npcm_gmac.c
+++ b/hw/net/npcm_gmac.c
@@ -32,7 +32,7 @@
 REG32(NPCM_DMA_BUS_MODE, 0x1000)
 REG32(NPCM_DMA_XMT_POLL_DEMAND, 0x1004)
 REG32(NPCM_DMA_RCV_POLL_DEMAND, 0x1008)
-REG32(NPCM_DMA_RCV_BASE_ADDR, 0x100c)
+REG32(NPCM_DMA_RX_BASE_ADDR, 0x100c)
 REG32(NPCM_DMA_TX_BASE_ADDR, 0x1010)
 REG32(NPCM_DMA_STATUS, 0x1014)
 REG32(NPCM_DMA_CONTROL, 0x1018)
@@ -91,7 +91,8 @@ REG32(NPCM_GMAC_PTP_TTSR, 0x71c)
 #define NPCM_DMA_BUS_MODE_SWR               BIT(0)
 
 static const uint32_t npcm_gmac_cold_reset_values[NPCM_GMAC_NR_REGS] = {
-    [R_NPCM_GMAC_VERSION]         = 0x00001037,
+    /* Reduce version to 3.2 so that the kernel can enable interrupt. */
+    [R_NPCM_GMAC_VERSION]         = 0x00001032,
     [R_NPCM_GMAC_TIMER_CTRL]      = 0x03e80000,
     [R_NPCM_GMAC_MAC0_ADDR_HI]    = 0x8000ffff,
     [R_NPCM_GMAC_MAC0_ADDR_LO]    = 0xffffffff,
@@ -125,12 +126,12 @@ static const uint16_t phy_reg_init[] = {
     [MII_EXTSTAT]   = 0x3000, /* 1000BASTE_T full-duplex capable */
 };
 
-static void npcm_gmac_soft_reset(NPCMGMACState *s)
+static void npcm_gmac_soft_reset(NPCMGMACState *gmac)
 {
-    memcpy(s->regs, npcm_gmac_cold_reset_values,
+    memcpy(gmac->regs, npcm_gmac_cold_reset_values,
            NPCM_GMAC_NR_REGS * sizeof(uint32_t));
     /* Clear reset bits */
-    s->regs[R_NPCM_DMA_BUS_MODE] &= ~NPCM_DMA_BUS_MODE_SWR;
+    gmac->regs[R_NPCM_DMA_BUS_MODE] &= ~NPCM_DMA_BUS_MODE_SWR;
 }
 
 static void gmac_phy_set_link(NPCMGMACState *s, bool active)
@@ -148,11 +149,53 @@ static bool gmac_can_receive(NetClientState *nc)
     return true;
 }
 
-static ssize_t gmac_receive(NetClientState *nc, const uint8_t *buf, size_t len1)
+/*
+ * Function that updates the GMAC IRQ
+ * It find the logical OR of the enabled bits for NIS (if enabled)
+ * It find the logical OR of the enabled bits for AIS (if enabled)
+ */
+static void gmac_update_irq(NPCMGMACState *gmac)
 {
-    return 0;
+    /*
+     * Check if the normal interrupts summery is enabled
+     * if so, add the bits for the summary that are enabled
+     */
+    if (gmac->regs[R_NPCM_DMA_INTR_ENA] & gmac->regs[R_NPCM_DMA_STATUS] &
+        (NPCM_DMA_INTR_ENAB_NIE_BITS))
+    {
+        gmac->regs[R_NPCM_DMA_STATUS] |=  NPCM_DMA_STATUS_NIS;
+    }
+    /*
+     * Check if the abnormal interrupts summery is enabled
+     * if so, add the bits for the summary that are enabled
+     */
+    if (gmac->regs[R_NPCM_DMA_INTR_ENA] & gmac->regs[R_NPCM_DMA_STATUS] &
+        (NPCM_DMA_INTR_ENAB_AIE_BITS))
+    {
+        gmac->regs[R_NPCM_DMA_STATUS] |=  NPCM_DMA_STATUS_AIS;
+    }
+
+    /* Get the logical OR of both normal and abnormal interrupts */
+    int level = !!((gmac->regs[R_NPCM_DMA_STATUS] &
+                    gmac->regs[R_NPCM_DMA_INTR_ENA] &
+                    NPCM_DMA_STATUS_NIS) |
+                   (gmac->regs[R_NPCM_DMA_STATUS] &
+                   gmac->regs[R_NPCM_DMA_INTR_ENA] &
+                   NPCM_DMA_STATUS_AIS));
+
+    /* Set the IRQ */
+    trace_npcm_gmac_update_irq(DEVICE(gmac)->canonical_path,
+                               gmac->regs[R_NPCM_DMA_STATUS],
+                               gmac->regs[R_NPCM_DMA_INTR_ENA],
+                               level);
+    qemu_set_irq(gmac->irq, level);
 }
 
+static ssize_t gmac_receive(NetClientState *nc, const uint8_t *buf, size_t len)
+{
+    /* Placeholder */
+    return 0;
+}
 static void gmac_cleanup(NetClientState *nc)
 {
     /* Nothing to do yet. */
@@ -166,7 +209,7 @@ static void gmac_set_link(NetClientState *nc)
     gmac_phy_set_link(s, !nc->link_down);
 }
 
-static void npcm_gmac_mdio_access(NPCMGMACState *s, uint16_t v)
+static void npcm_gmac_mdio_access(NPCMGMACState *gmac, uint16_t v)
 {
     bool busy = v & NPCM_GMAC_MII_ADDR_BUSY;
     uint8_t is_write;
@@ -183,33 +226,38 @@ static void npcm_gmac_mdio_access(NPCMGMACState *s, uint16_t v)
 
 
         if (v & NPCM_GMAC_MII_ADDR_WRITE) {
-            data = s->regs[R_NPCM_GMAC_MII_DATA];
+            data = gmac->regs[R_NPCM_GMAC_MII_DATA];
             /* Clear reset bit for BMCR register */
             switch (gr) {
             case MII_BMCR:
                 data &= ~MII_BMCR_RESET;
-                /* Complete auto-negotiation immediately and set as complete */
-                if (data & MII_BMCR_AUTOEN) {
+                /* Autonegotiation is a W1C bit*/
+                if (data & MII_BMCR_ANRESTART) {
                     /* Tells autonegotiation to not restart again */
                     data &= ~MII_BMCR_ANRESTART;
+                }
+                if ((data & MII_BMCR_AUTOEN) &&
+                    !(gmac->phy_regs[pa][MII_BMSR] & MII_BMSR_AN_COMP)) {
                     /* sets autonegotiation as complete */
-                    s->phy_regs[pa][MII_BMSR] |= MII_BMSR_AN_COMP;
+                    gmac->phy_regs[pa][MII_BMSR] |= MII_BMSR_AN_COMP;
+                    /* Resolve AN automatically->need to set this */
+                    gmac->phy_regs[0][MII_ANLPAR] = 0x0000;
                 }
             }
-            s->phy_regs[pa][gr] = data;
+            gmac->phy_regs[pa][gr] = data;
         } else {
-            data = s->phy_regs[pa][gr];
-            s->regs[R_NPCM_GMAC_MII_DATA] = data;
+            data = gmac->phy_regs[pa][gr];
+            gmac->regs[R_NPCM_GMAC_MII_DATA] = data;
         }
-        trace_npcm_gmac_mdio_access(DEVICE(s)->canonical_path, is_write, pa,
-                                    gr, data);
+        trace_npcm_gmac_mdio_access(DEVICE(gmac)->canonical_path, is_write, pa,
+                                        gr, data);
     }
-    s->regs[R_NPCM_GMAC_MII_ADDR] = v & ~NPCM_GMAC_MII_ADDR_BUSY;
+    gmac->regs[R_NPCM_GMAC_MII_ADDR] = v & ~NPCM_GMAC_MII_ADDR_BUSY;
 }
 
 static uint64_t npcm_gmac_read(void *opaque, hwaddr offset, unsigned size)
 {
-    NPCMGMACState *s = opaque;
+    NPCMGMACState *gmac = opaque;
     uint32_t v = 0;
 
     switch (offset) {
@@ -218,22 +266,25 @@ static uint64_t npcm_gmac_read(void *opaque, hwaddr offset, unsigned size)
     case A_NPCM_DMA_RCV_POLL_DEMAND:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Read of write-only reg: offset: 0x%04" HWADDR_PRIx
-                      "\n", DEVICE(s)->canonical_path, offset);
+                      "\n", DEVICE(gmac)->canonical_path, offset);
         break;
 
     default:
-        v = s->regs[offset / sizeof(uint32_t)];
+        v = gmac->regs[offset / sizeof(uint32_t)];
     }
-    trace_npcm_gmac_reg_read(DEVICE(s)->canonical_path, offset, v);
+
+    trace_npcm_gmac_reg_read(DEVICE(gmac)->canonical_path, offset, v);
     return v;
 }
 
 static void npcm_gmac_write(void *opaque, hwaddr offset,
                               uint64_t v, unsigned size)
 {
-    NPCMGMACState *s = opaque;
+    NPCMGMACState *gmac = opaque;
+    uint32_t prev;
+
+    trace_npcm_gmac_reg_write(DEVICE(gmac)->canonical_path, offset, v);
 
-    trace_npcm_gmac_reg_write(DEVICE(s)->canonical_path, offset, v);
     switch (offset) {
     /* Read only registers */
     case A_NPCM_GMAC_VERSION:
@@ -250,25 +301,44 @@ static void npcm_gmac_write(void *opaque, hwaddr offset,
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Write of read-only reg: offset: 0x%04" HWADDR_PRIx
                       ", value: 0x%04" PRIx64 "\n",
-                      DEVICE(s)->canonical_path, offset, v);
+                      DEVICE(gmac)->canonical_path, offset, v);
+        break;
+
+    case A_NPCM_GMAC_MAC_CONFIG:
+        prev = gmac->regs[offset / sizeof(uint32_t)];
+        gmac->regs[offset / sizeof(uint32_t)] = v;
+
+        /* If transmit is being enabled for first time, update desc addr */
+        if (~(prev & NPCM_GMAC_MAC_CONFIG_TX_EN) &
+             (v & NPCM_GMAC_MAC_CONFIG_TX_EN)) {
+            gmac->regs[R_NPCM_DMA_HOST_TX_DESC] =
+                gmac->regs[R_NPCM_DMA_TX_BASE_ADDR];
+        }
+
+        /* If receive is being enabled for first time, update desc addr */
+        if (~(prev & NPCM_GMAC_MAC_CONFIG_RX_EN) &
+             (v & NPCM_GMAC_MAC_CONFIG_RX_EN)) {
+            gmac->regs[R_NPCM_DMA_HOST_RX_DESC] =
+                gmac->regs[R_NPCM_DMA_RX_BASE_ADDR];
+        }
         break;
 
     case A_NPCM_GMAC_MII_ADDR:
-        npcm_gmac_mdio_access(s, v);
+        npcm_gmac_mdio_access(gmac, v);
         break;
 
     case A_NPCM_GMAC_MAC0_ADDR_HI:
-        s->regs[offset / sizeof(uint32_t)] = v;
-        s->conf.macaddr.a[0] = v >> 8;
-        s->conf.macaddr.a[1] = v >> 0;
+        gmac->regs[offset / sizeof(uint32_t)] = v;
+        gmac->conf.macaddr.a[0] = v >> 8;
+        gmac->conf.macaddr.a[1] = v >> 0;
         break;
 
     case A_NPCM_GMAC_MAC0_ADDR_LO:
-        s->regs[offset / sizeof(uint32_t)] = v;
-        s->conf.macaddr.a[2] = v >> 24;
-        s->conf.macaddr.a[3] = v >> 16;
-        s->conf.macaddr.a[4] = v >> 8;
-        s->conf.macaddr.a[5] = v >> 0;
+        gmac->regs[offset / sizeof(uint32_t)] = v;
+        gmac->conf.macaddr.a[2] = v >> 24;
+        gmac->conf.macaddr.a[3] = v >> 16;
+        gmac->conf.macaddr.a[4] = v >> 8;
+        gmac->conf.macaddr.a[5] = v >> 0;
         break;
 
     case A_NPCM_GMAC_MAC1_ADDR_HI:
@@ -277,33 +347,60 @@ static void npcm_gmac_write(void *opaque, hwaddr offset,
     case A_NPCM_GMAC_MAC2_ADDR_LO:
     case A_NPCM_GMAC_MAC3_ADDR_HI:
     case A_NPCM_GMAC_MAC3_ADDR_LO:
-        s->regs[offset / sizeof(uint32_t)] = v;
+        gmac->regs[offset / sizeof(uint32_t)] = v;
         qemu_log_mask(LOG_UNIMP,
                       "%s: Only MAC Address 0 is supported. This request "
-                      "is ignored.\n", DEVICE(s)->canonical_path);
+                      "is ignored.\n", DEVICE(gmac)->canonical_path);
         break;
 
     case A_NPCM_DMA_BUS_MODE:
-        s->regs[offset / sizeof(uint32_t)] = v;
+        gmac->regs[offset / sizeof(uint32_t)] = v;
         if (v & NPCM_DMA_BUS_MODE_SWR) {
-            npcm_gmac_soft_reset(s);
+            npcm_gmac_soft_reset(gmac);
+        }
+        break;
+
+    case A_NPCM_DMA_RCV_POLL_DEMAND:
+        /* We dont actually care about the value */
+        break;
+
+    case A_NPCM_DMA_STATUS:
+        /* Check that RO bits are not written to */
+        if (NPCM_DMA_STATUS_RO_MASK(v)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: Write of read-only bits of reg: offset: 0x%04"
+                           HWADDR_PRIx ", value: 0x%04" PRIx64 "\n",
+                           DEVICE(gmac)->canonical_path, offset, v);
+        } else {
+            /* for W1c bits, implement W1C */
+            gmac->regs[offset / sizeof(uint32_t)] &=
+                ~NPCM_DMA_STATUS_W1C_MASK(v);
+            if (v & NPCM_DMA_STATUS_NIS_BITS) {
+                gmac->regs[offset / sizeof(uint32_t)] &= ~NPCM_DMA_STATUS_NIS;
+            }
+            if (v & NPCM_DMA_STATUS_AIS_BITS) {
+                gmac->regs[offset / sizeof(uint32_t)] &= ~NPCM_DMA_STATUS_AIS;
+            }
         }
         break;
 
     default:
-        s->regs[offset / sizeof(uint32_t)] = v;
+        gmac->regs[offset / sizeof(uint32_t)] = v;
         break;
     }
+
+    gmac_update_irq(gmac);
 }
 
 static void npcm_gmac_reset(DeviceState *dev)
 {
-    NPCMGMACState *s = NPCM_GMAC(dev);
+    NPCMGMACState *gmac = NPCM_GMAC(dev);
 
-    npcm_gmac_soft_reset(s);
-    memcpy(s->phy_regs[0], phy_reg_init, sizeof(phy_reg_init));
+    npcm_gmac_soft_reset(gmac);
+    memcpy(gmac->phy_regs[0], phy_reg_init, sizeof(phy_reg_init));
 
-    trace_npcm_gmac_reset(DEVICE(s)->canonical_path, s->phy_regs[0][MII_BMSR]);
+    trace_npcm_gmac_reset(DEVICE(gmac)->canonical_path,
+                          gmac->phy_regs[0][MII_BMSR]);
 }
 
 static NetClientInfo net_npcm_gmac_info = {
diff --git a/hw/net/trace-events b/hw/net/trace-events
index 1dbb5d2d64..2843f1eaf8 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -472,6 +472,15 @@ npcm_gmac_reg_write(const char *name, uint64_t offset, uint32_t value) "%s: offs
 npcm_gmac_mdio_access(const char *name, uint8_t is_write, uint8_t pa, uint8_t gr, uint16_t val) "%s: is_write: %" PRIu8 " pa: %" PRIu8 " gr: %" PRIu8 " val: 0x%04" PRIx16
 npcm_gmac_reset(const char *name, uint16_t value) "%s: phy_regs[0][1]: 0x%04" PRIx16
 npcm_gmac_set_link(bool active) "Set link: active=%u"
+npcm_gmac_update_irq(const char *name, uint32_t status, uint32_t intr_en, int level) "%s: Status Reg: 0x%04" PRIX32 " Interrupt Enable Reg: 0x%04" PRIX32 " IRQ Set: %d"
+npcm_gmac_packet_desc_read(const char* name, uint32_t desc_addr) "%s: attempting to read descriptor @0x%04" PRIX32
+npcm_gmac_packet_receive(const char* name, uint32_t len) "%s: RX packet length: 0x%04" PRIX32
+npcm_gmac_packet_receiving_buffer(const char* name, uint32_t buf_len, uint32_t rx_buf_addr) "%s: Receiving into Buffer size: 0x%04" PRIX32 " at address 0x%04" PRIX32
+npcm_gmac_packet_received(const char* name, uint32_t len) "%s: Reception finished, packet left: 0x%04" PRIX32
+npcm_gmac_packet_transmit(const char* name, uint16_t len) "%s: TX transmission start, packed length 0x%04" PRIX16
+npcm_gmac_packet_sent(const char* name, uint16_t len) "%s: TX packet sent!, length: 0x%04" PRIX16
+npcm_gmac_debug_desc_data(const char* name, void* addr, uint32_t des0, uint32_t des1, uint32_t des2, uint32_t des3)"%s: Address: %p Descriptor 0: 0x%04" PRIX32 " Descriptor 1: 0x%04" PRIX32 "Descriptor 2: 0x%04" PRIX32 " Descriptor 3: 0x%04" PRIX32
+npcm_gmac_packet_tx_desc_data(const char* name, uint32_t tdes0, uint32_t tdes1) "%s: Tdes0: 0x%04" PRIX32 " Tdes1: 0x%04" PRIX32
 
 # npcm_pcs.c
 npcm_pcs_reg_read(const char *name, uint16_t indirect_access_baes, uint64_t offset, uint16_t value) "%s: IND: 0x%02" PRIx16 " offset: 0x%04" PRIx64 " value: 0x%04" PRIx16
diff --git a/include/hw/net/npcm_gmac.h b/include/hw/net/npcm_gmac.h
index a92a654278..e5729e83ea 100644
--- a/include/hw/net/npcm_gmac.h
+++ b/include/hw/net/npcm_gmac.h
@@ -37,8 +37,6 @@ struct NPCMGMACRxDesc {
 /* RDES2 and RDES3 are buffer address pointers */
 /* Owner: 0 = software, 1 = gmac */
 #define RX_DESC_RDES0_OWNER_MASK BIT(31)
-/* Owner*/
-#define RX_DESC_RDES0_OWNER_SHIFT 31
 /* Destination Address Filter Fail */
 #define RX_DESC_RDES0_DEST_ADDR_FILT_FAIL_MASK BIT(30)
 /* Frame length*/
diff --git a/tests/qtest/npcm_gmac-test.c b/tests/qtest/npcm_gmac-test.c
index 30d27e8dcc..84511fd915 100644
--- a/tests/qtest/npcm_gmac-test.c
+++ b/tests/qtest/npcm_gmac-test.c
@@ -154,7 +154,7 @@ static void test_init(gconstpointer test_data)
     CHECK_REG32(NPCM_GMAC_MII_DATA, 0);
     CHECK_REG32(NPCM_GMAC_FLOW_CTRL, 0);
     CHECK_REG32(NPCM_GMAC_VLAN_FLAG, 0);
-    CHECK_REG32(NPCM_GMAC_VERSION, 0x00001037);
+    CHECK_REG32(NPCM_GMAC_VERSION, 0x00001032);
     CHECK_REG32(NPCM_GMAC_WAKEUP_FILTER, 0);
     CHECK_REG32(NPCM_GMAC_PMT, 0);
     CHECK_REG32(NPCM_GMAC_LPI_CTRL, 0);
-- 
2.42.0.459.ge4e396fd5e-goog


