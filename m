Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B81F57A6C04
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 22:06:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qigxq-00062i-3A; Tue, 19 Sep 2023 16:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3JuEJZQwKCj8obcjiftufgbohpphmf.dpnrfnv-efwfmopohov.psh@flex--nabihestefan.bounces.google.com>)
 id 1qieza-0005Dl-0V
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 13:58:35 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3JuEJZQwKCj8obcjiftufgbohpphmf.dpnrfnv-efwfmopohov.psh@flex--nabihestefan.bounces.google.com>)
 id 1qiez6-00013A-58
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 13:58:33 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-d8186d705a9so6506082276.3
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 10:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1695146278; x=1695751078; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=PDy0J3HuLcnZ1QJcHKrs1n48Vn9+vG2qQWW4gy5rkLs=;
 b=4lqsk+F86vMD/wPWI9hOheY+/7mrWn/IMzl8z+8boxHlbrc1VPQ59cXo6xc3ydc0tu
 lyZ8qjXTzbGlZB7bgcjmDX1P8HW+a701hd6ijnvJp9choqik2ewJabYoT7qFn0oYhvve
 fpAPDWfevoDJMR4QptLaeVlybUzIlaWzKqDI2nGF8OzTveAjPs/lN9edLZDKsSv1ypJy
 avUS0SzvMT1VrvsjUffgGI3j2M6+QqMJjGFbePPC18ehKPDXwH1xGUKfmqpT/TnwbsLB
 GiNQsNOzVvU94mRUUIRjI5WYJgdevw29gZkp12B6t0u4bOVYI4X3nSF+tfeHmIarFbQi
 FshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695146278; x=1695751078;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PDy0J3HuLcnZ1QJcHKrs1n48Vn9+vG2qQWW4gy5rkLs=;
 b=PNPqaCg19T4FSQ4qlv8ycMQQ5cBH/0U3JMum5jjCQjY6nO38WKiLNucR9BwYoKbJpB
 9boldfUSQGjzk8fyaMWCVo5oHsrfYpqCQ5FUdkOtM7CAWfu2qRK6QIYPAaf/dPhLeVGG
 3TZsFNk4AG0XxL4x5r/HQy9AqL7tF+1d1xp5KE8CQpho7sgyZ1YPU/vOHv3iQPUthuX4
 NpBKT5Jm0FwLviDsfjtIKIQGVPu4ZYNNWhGI06aLRAykuDgsTF9RPW6vsbUiSubfo2Yy
 Qb8lnx0BoTxZNuctVGv15y+NN5GXd+Gjgh6oIH1Jqe5R6H/SW5b3dXG+X2Dl8Mb+pr3G
 hKgA==
X-Gm-Message-State: AOJu0Yw8eHFu5wL488DhYY/D5RPbtTOHL1coRTBm531Qy7bRjFd2za+0
 rIXc8FFYjSd6tDP9lVfBvHAXSynsRsv2c8qGMWI=
X-Google-Smtp-Source: AGHT+IHEWvdfBzCh+8ouSACfPFOdbDJan2EeCBKZWowxTXDGjcWXvV8b4BZj+M2EeqzixflNbEVZcmVMS3HYp/tVE38=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a25:408f:0:b0:d7f:8774:dfd4 with SMTP
 id n137-20020a25408f000000b00d7f8774dfd4mr5735yba.12.1695146278626; Tue, 19
 Sep 2023 10:57:58 -0700 (PDT)
Date: Tue, 19 Sep 2023 17:57:21 +0000
In-Reply-To: <20230919175725.3413108-1-nabihestefan@google.com>
Mime-Version: 1.0
References: <20230919175725.3413108-1-nabihestefan@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230919175725.3413108-11-nabihestefan@google.com>
Subject: [PATCH 10/14] hw/net: General GMAC Implementation
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasonwang@redhat.com, Avi.Fishman@nuvoton.com, 
 Nabih Estefan Diaz <nabihestefan@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3JuEJZQwKCj8obcjiftufgbohpphmf.dpnrfnv-efwfmopohov.psh@flex--nabihestefan.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 19 Sep 2023 16:04:51 -0400
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

- General GMAC Register handling
- GMAC IRQ Handling
- Added traces in some methods for debugging
- Lots of declarations for accessing information on GMAC Descriptors (npcm_gmac.h file)

NOTE: With code on this state, the GMAC can boot-up properly and will show up in the ifconfig command on the BMC

Signed-off-by: Nabih Estefan Diaz <nabihestefan@google.com>
---
 hw/net/npcm_gmac.c           | 183 ++++++++++++++++++++-------
 hw/net/trace-events          |   9 ++
 include/hw/net/npcm_gmac.h   | 233 ++++++++++++++++++++++++++++-------
 tests/qtest/npcm_gmac-test.c |   2 +-
 4 files changed, 338 insertions(+), 89 deletions(-)

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
index 27b006f40a..c133745fa6 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -470,6 +470,15 @@ npcm_gmac_reg_write(const char *name, uint64_t offset, uint32_t value) "%s: offs
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
index 067928fe0b..c8ff154868 100644
--- a/include/hw/net/npcm_gmac.h
+++ b/include/hw/net/npcm_gmac.h
@@ -35,22 +35,15 @@ struct NPCMGMACRxDesc {
 };
 
 /* NPCMGMACRxDesc.flags values */
-/* RDES2 and RDES3 are buffer address pointers */
-/* Owner: 0 = software, 1 = gmac */
-#define RX_DESC_RDES0_OWNER_MASK BIT(31)
-<<<<<<< HEAD
-/* Owner*/
-#define RX_DESC_RDES0_OWNER_SHIFT 31
-/* Destination Address Filter Fail */
-#define RX_DESC_RDES0_DEST_ADDR_FILT_FAIL_MASK BIT(30)
-/* Frame length*/
-#define RX_DESC_RDES0_FRAME_LEN_MASK(word) extract32(word, 16, 29)
-=======
+/* RDES2 and RDES3 are buffer addresses */
+/* Owner: 0 = software, 1 = dma */
+#define RX_DESC_RDES0_OWN BIT(31)
 /* Destination Address Filter Fail */
-#define RX_DESC_RDES0_DEST_ADDR_FILT_FAIL_MASK BIT(30)
-/* Frame length*/
-#define RX_DESC_RDES0_FRAME_LEN_MASK extract32(rdes0, 16, 29)
->>>>>>> f17fd3e311 (include/hw/net: Implemented Classes and Masks for GMAC Descriptors)
+#define RX_DESC_RDES0_DEST_ADDR_FILT_FAIL BIT(30)
+/* Frame length */
+#define RX_DESC_RDES0_FRAME_LEN_MASK(word) extract32(word, 16, 14)
+/* Frame length Shift*/
+#define RX_DESC_RDES0_FRAME_LEN_SHIFT 16
 /* Error Summary */
 #define RX_DESC_RDES0_ERR_SUMM_MASK BIT(15)
 /* Descriptor Error */
@@ -91,17 +84,11 @@ struct NPCMGMACRxDesc {
 /* Second Address Chained */
 #define RX_DESC_RDES1_SEC_ADDR_CHND_MASK BIT(24)
 /* Receive Buffer 2 Size */
-<<<<<<< HEAD
 #define RX_DESC_RDES1_BFFR2_SZ_SHIFT 11
 #define RX_DESC_RDES1_BFFR2_SZ_MASK(word) extract32(word, \
-    RX_DESC_RDES1_BFFR2_SZ_SHIFT, 10 + RX_DESC_RDES1_BFFR2_SZ_SHIFT)
+    RX_DESC_RDES1_BFFR2_SZ_SHIFT, 11)
 /* Receive Buffer 1 Size */
-#define RX_DESC_RDES1_BFFR1_SZ_MASK(word) extract32(word, 0, 10)
-=======
-#define RX_DESC_RDES1_BFFR2_SZ_MASK extract32(rdes1, 11, 21)
-/* Receive Buffer 1 Size */
-#define RX_DESC_RDES1_BFFR1_SZ_MASK extract32(rdes1, 0, 10)
->>>>>>> f17fd3e311 (include/hw/net: Implemented Classes and Masks for GMAC Descriptors)
+#define RX_DESC_RDES1_BFFR1_SZ_MASK(word) extract32(word, 0, 11)
 
 
 struct NPCMGMACTxDesc {
@@ -112,9 +99,9 @@ struct NPCMGMACTxDesc {
 };
 
 /* NPCMGMACTxDesc.flags values */
-/* TDES2 and TDES3 are buffer address pointers */
+/* TDES2 and TDES3 are buffer addresses */
 /* Owner: 0 = software, 1 = gmac */
-#define TX_DESC_TDES0_OWNER_MASK BIT(31)
+#define TX_DESC_TDES0_OWN BIT(31)
 /* Tx Time Stamp Status */
 #define TX_DESC_TDES0_TTSS_MASK BIT(17)
 /* IP Header Error */
@@ -138,11 +125,7 @@ struct NPCMGMACTxDesc {
 /* VLAN Frame */
 #define TX_DESC_TDES0_VLAN_FRM_MASK BIT(7)
 /* Collision Count */
-<<<<<<< HEAD
-#define TX_DESC_TDES0_COLL_CNT_MASK(word) extract32(word, 3, 6)
-=======
-#define TX_DESC_TDES0_COLL_CNT_MASK extract32(tdes0, 3, 6)
->>>>>>> f17fd3e311 (include/hw/net: Implemented Classes and Masks for GMAC Descriptors)
+#define TX_DESC_TDES0_COLL_CNT_MASK(word) extract32(word, 3, 4)
 /* Excessive Deferral */
 #define TX_DESC_TDES0_EXCS_DEF_MASK BIT(2)
 /* Underflow Error */
@@ -154,14 +137,10 @@ struct NPCMGMACTxDesc {
 #define TX_DESC_TDES1_INTERR_COMP_MASK BIT(31)
 /* Last Segment */
 #define TX_DESC_TDES1_LAST_SEG_MASK BIT(30)
-/* Last Segment */
+/* First Segment */
 #define TX_DESC_TDES1_FIRST_SEG_MASK BIT(29)
 /* Checksum Insertion Control */
-<<<<<<< HEAD
-#define TX_DESC_TDES1_CHKSM_INS_CTRL_MASK(word) extract32(word, 27, 28)
-=======
-#define TX_DESC_TDES1_CHKSM_INS_CTRL_MASK extract32(tdes1, 27, 28)
->>>>>>> f17fd3e311 (include/hw/net: Implemented Classes and Masks for GMAC Descriptors)
+#define TX_DESC_TDES1_CHKSM_INS_CTRL_MASK(word) extract32(word, 27, 2)
 /* Disable Cyclic Redundancy Check */
 #define TX_DESC_TDES1_DIS_CDC_MASK BIT(26)
 /* Transmit End of Ring */
@@ -169,15 +148,9 @@ struct NPCMGMACTxDesc {
 /* Secondary Address Chained */
 #define TX_DESC_TDES1_SEC_ADDR_CHND_MASK BIT(24)
 /* Transmit Buffer 2 Size */
-<<<<<<< HEAD
-#define TX_DESC_TDES1_BFFR2_SZ_MASK(word) extract32(word, 11, 21)
+#define TX_DESC_TDES1_BFFR2_SZ_MASK(word) extract32(word, 11, 11)
 /* Transmit Buffer 1 Size */
-#define TX_DESC_TDES1_BFFR1_SZ_MASK(word) extract32(word, 0, 10)
-=======
-#define TX_DESC_TDES1_BFFR2_SZ_MASK extract32(tdes1, 11, 21)
-/* Transmit Buffer 1 Size */
-#define TX_DESC_TDES1_BFFR1_SZ_MASK extract32(tdes1, 0, 10)
->>>>>>> f17fd3e311 (include/hw/net: Implemented Classes and Masks for GMAC Descriptors)
+#define TX_DESC_TDES1_BFFR1_SZ_MASK(word) extract32(word, 0, 11)
 
 typedef struct NPCMGMACState {
     SysBusDevice parent;
@@ -196,4 +169,174 @@ typedef struct NPCMGMACState {
 #define TYPE_NPCM_GMAC "npcm-gmac"
 OBJECT_DECLARE_SIMPLE_TYPE(NPCMGMACState, NPCM_GMAC)
 
-#endif /* NPCM_GMAC_H */
+/* Mask for RO bits in Status */
+#define NPCM_DMA_STATUS_RO_MASK(word) (word & 0xfffe0000)
+/* Mask for RO bits in Status */
+#define NPCM_DMA_STATUS_W1C_MASK(word) (word & 0x1e7ff)
+
+/* Transmit Process State */
+#define NPCM_DMA_STATUS_TX_PROCESS_STATE_SHIFT 20
+/* Transmit States */
+#define NPCM_DMA_STATUS_TX_STOPPED_STATE \
+    (0b000)
+#define NPCM_DMA_STATUS_TX_RUNNING_FETCHING_STATE \
+    (0b001)
+#define NPCM_DMA_STATUS_TX_RUNNING_WAITING_STATE \
+    (0b010)
+#define NPCM_DMA_STATUS_TX_RUNNING_READ_STATE \
+    (0b011)
+#define NPCM_DMA_STATUS_TX_SUSPENDED_STATE \
+    (0b110)
+#define NPCM_DMA_STATUS_TX_RUNNING_CLOSING_STATE \
+    (0b111)
+/* Transmit Process State */
+#define NPCM_DMA_STATUS_RX_PROCESS_STATE_SHIFT 17
+/* Receive States */
+#define NPCM_DMA_STATUS_RX_STOPPED_STATE \
+    (0b000)
+#define NPCM_DMA_STATUS_RX_RUNNING_FETCHING_STATE \
+    (0b001)
+#define NPCM_DMA_STATUS_RX_RUNNING_WAITING_STATE \
+    (0b011)
+#define NPCM_DMA_STATUS_RX_SUSPENDED_STATE \
+    (0b100)
+#define NPCM_DMA_STATUS_RX_RUNNING_CLOSING_STATE \
+    (0b101)
+#define NPCM_DMA_STATUS_RX_RUNNING_TRANSFERRING_STATE \
+    (0b111)
+
+
+/* Early Receive Interrupt */
+#define NPCM_DMA_STATUS_ERI BIT(14)
+/* Fatal Bus Error Interrupt */
+#define NPCM_DMA_STATUS_FBI BIT(13)
+/* Early transmit Interrupt */
+#define NPCM_DMA_STATUS_ETI BIT(10)
+/* Receive Watchdog Timout */
+#define NPCM_DMA_STATUS_RWT BIT(9)
+/* Receive Process Stopped */
+#define NPCM_DMA_STATUS_RPS BIT(8)
+/* Receive Buffer Unavailable */
+#define NPCM_DMA_STATUS_RU BIT(7)
+/* Receive Interrupt */
+#define NPCM_DMA_STATUS_RI BIT(6)
+/* Transmit Underflow */
+#define NPCM_DMA_STATUS_UNF BIT(5)
+/* Receive Overflow */
+#define NPCM_DMA_STATUS_OVF BIT(4)
+/* Transmit Jabber Timeout */
+#define NPCM_DMA_STATUS_TJT BIT(3)
+/* Transmit Buffer Unavailable */
+#define NPCM_DMA_STATUS_TU BIT(2)
+/* Transmit Process Stopped */
+#define NPCM_DMA_STATUS_TPS BIT(1)
+/* Transmit Interrupt */
+#define NPCM_DMA_STATUS_TI BIT(0)
+
+/* Normal Interrupt Summary */
+#define NPCM_DMA_STATUS_NIS BIT(16)
+/* Interrupts enabled by NIE */
+#define NPCM_DMA_STATUS_NIS_BITS (NPCM_DMA_STATUS_TI | \
+                                  NPCM_DMA_STATUS_TU | \
+                                  NPCM_DMA_STATUS_RI | \
+                                  NPCM_DMA_STATUS_ERI)
+/* Abnormal Interrupt Summary */
+#define NPCM_DMA_STATUS_AIS BIT(15)
+/* Interrupts enabled by AIE */
+#define NPCM_DMA_STATUS_AIS_BITS (NPCM_DMA_STATUS_TPS | \
+                                  NPCM_DMA_STATUS_TJT | \
+                                  NPCM_DMA_STATUS_OVF | \
+                                  NPCM_DMA_STATUS_UNF | \
+                                  NPCM_DMA_STATUS_RU  | \
+                                  NPCM_DMA_STATUS_RPS | \
+                                  NPCM_DMA_STATUS_RWT | \
+                                  NPCM_DMA_STATUS_ETI | \
+                                  NPCM_DMA_STATUS_FBI)
+
+/* Early Receive Interrupt Enable */
+#define NPCM_DMA_INTR_ENAB_ERE BIT(14)
+/* Fatal Bus Error Interrupt Enable */
+#define NPCM_DMA_INTR_ENAB_FBE BIT(13)
+/* Early transmit Interrupt Enable */
+#define NPCM_DMA_INTR_ENAB_ETE BIT(10)
+/* Receive Watchdog Timout Enable */
+#define NPCM_DMA_INTR_ENAB_RWE BIT(9)
+/* Receive Process Stopped Enable */
+#define NPCM_DMA_INTR_ENAB_RSE BIT(8)
+/* Receive Buffer Unavailable Enable */
+#define NPCM_DMA_INTR_ENAB_RUE BIT(7)
+/* Receive Interrupt Enable */
+#define NPCM_DMA_INTR_ENAB_RIE BIT(6)
+/* Transmit Underflow Enable */
+#define NPCM_DMA_INTR_ENAB_UNE BIT(5)
+/* Receive Overflow Enable */
+#define NPCM_DMA_INTR_ENAB_OVE BIT(4)
+/* Transmit Jabber Timeout Enable */
+#define NPCM_DMA_INTR_ENAB_TJE BIT(3)
+/* Transmit Buffer Unavailable Enable */
+#define NPCM_DMA_INTR_ENAB_TUE BIT(2)
+/* Transmit Process Stopped Enable */
+#define NPCM_DMA_INTR_ENAB_TSE BIT(1)
+/* Transmit Interrupt Enable */
+#define NPCM_DMA_INTR_ENAB_TIE BIT(0)
+
+/* Normal Interrupt Summary Enable */
+#define NPCM_DMA_INTR_ENAB_NIE BIT(16)
+/* Interrupts enabled by NIE Enable */
+#define NPCM_DMA_INTR_ENAB_NIE_BITS (NPCM_DMA_INTR_ENAB_TIE | \
+                                     NPCM_DMA_INTR_ENAB_TUE | \
+                                     NPCM_DMA_INTR_ENAB_RIE | \
+                                     NPCM_DMA_INTR_ENAB_ERE)
+/* Abnormal Interrupt Summary Enable */
+#define NPCM_DMA_INTR_ENAB_AIE BIT(15)
+/* Interrupts enabled by AIE Enable */
+#define NPCM_DMA_INTR_ENAB_AIE_BITS (NPCM_DMA_INTR_ENAB_TSE | \
+                                     NPCM_DMA_INTR_ENAB_TJE | \
+                                     NPCM_DMA_INTR_ENAB_OVE | \
+                                     NPCM_DMA_INTR_ENAB_UNE | \
+                                     NPCM_DMA_INTR_ENAB_RUE | \
+                                     NPCM_DMA_INTR_ENAB_RSE | \
+                                     NPCM_DMA_INTR_ENAB_RWE | \
+                                     NPCM_DMA_INTR_ENAB_ETE | \
+                                     NPCM_DMA_INTR_ENAB_FBE)
+
+/* Flushing Disabled */
+#define NPCM_DMA_CONTROL_FLUSH_MASK BIT(24)
+/* Start/stop Transmit */
+#define NPCM_DMA_CONTROL_START_STOP_TX BIT(13)
+/* Start/stop Receive */
+#define NPCM_DMA_CONTROL_START_STOP_RX BIT(1)
+/* Next receive descriptor start address */
+#define NPCM_DMA_HOST_RX_DESC_MASK(word) ((uint32_t) (word) & ~3u)
+/* Next transmit descriptor start address */
+#define NPCM_DMA_HOST_TX_DESC_MASK(word) ((uint32_t) (word) & ~3u)
+
+/* Receive enable */
+#define NPCM_GMAC_MAC_CONFIG_RX_EN BIT(2)
+/* Transmit enable */
+#define NPCM_GMAC_MAC_CONFIG_TX_EN BIT(3)
+
+/* Frame Receive All */
+#define NPCM_GMAC_FRAME_FILTER_REC_ALL_MASK BIT(31)
+/* Frame HPF Filter*/
+#define NPCM_GMAC_FRAME_FILTER_HPF_MASK BIT(10)
+/* Frame SAF Filter*/
+#define NPCM_GMAC_FRAME_FILTER_SAF_MASK BIT(9)
+/* Frame SAIF Filter*/
+#define NPCM_GMAC_FRAME_FILTER_SAIF_MASK BIT(8)
+/* Frame PCF Filter*/
+#define NPCM_GMAC_FRAME_FILTER_PCF_MASK BIT(word) extract32((word), 6, 2)
+/* Frame DBF Filter*/
+#define NPCM_GMAC_FRAME_FILTER_DBF_MASK BIT(5)
+/* Frame PM Filter*/
+#define NPCM_GMAC_FRAME_FILTER_PM_MASK BIT(4)
+/* Frame DAIF Filter*/
+#define NPCM_GMAC_FRAME_FILTER_DAIF_MASK BIT(3)
+/* Frame HMC Filter*/
+#define NPCM_GMAC_FRAME_FILTER_HMC_MASK BIT(2)
+/* Frame HUC Filter*/
+#define NPCM_GMAC_FRAME_FILTER_HUC_MASK BIT(1)
+/* Frame PR Filter*/
+#define NPCM_GMAC_FRAME_FILTER_PR_MASK BIT(0)
+
+#endif /* NPCM_GMAC_H */
\ No newline at end of file
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


