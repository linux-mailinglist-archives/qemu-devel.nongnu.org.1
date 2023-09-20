Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E9B7A8F2B
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 00:19:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj5Wn-0002RS-VU; Wed, 20 Sep 2023 18:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3tG8LZQwKCu8eRSZYVjkVWReXffXcV.TfdhVdl-UVmVcefeXel.fiX@flex--nabihestefan.bounces.google.com>)
 id 1qj5Wl-0002Os-JI
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 18:18:35 -0400
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3tG8LZQwKCu8eRSZYVjkVWReXffXcV.TfdhVdl-UVmVcefeXel.fiX@flex--nabihestefan.bounces.google.com>)
 id 1qj5Wf-0008AS-DI
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 18:18:35 -0400
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-59c0327b75dso4274197b3.2
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 15:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1695248308; x=1695853108; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=BurWM4dp/jQZPxr6+I6KVN5GAc2nLP2kiS9uvGh3egM=;
 b=drIJrXWoYQzSEK1sEr0oMnmDyKqeppCylBWNo6PLxngXHj4QTMfuxHQoPgIFbThnq1
 MR6uoX9yzgQgRzbSQXD+E83/1huNuexTlZ62t/XaJUTP8vbe9YPCCiuEonyUzUrtc4r4
 TeiaoLKQiJZz/aae6lKu5orI0GlHvXdQGZNxEOzTBbitb1LstrwrlGkhD7EOkaW6LhMy
 /DpFXo3DFc+q2vx1PM/+vWKkJZhBI26E/IfqOGNSFTCqLPJh5vfk2Yt5nPUTEjc64DC2
 49VjPmyuYyIbF2CvB2xr0IL31f5xZ5uLimG65I8lmmoN3fNw/ayto+R2iKtm8XvjCcx7
 mJFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695248308; x=1695853108;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BurWM4dp/jQZPxr6+I6KVN5GAc2nLP2kiS9uvGh3egM=;
 b=gxfVk8+x6TOvvf4NuOjQI0+SSgqG89Q5Ve8eCRdIecTLOQZpuMTBJk5A1pkkTocupg
 ywRBPGCarD1QXwYEjVL4Vlrxx2PA81ubz0XEW5vEc1PDW3QZu1GvAi45Uo7QzNXBZqjn
 7KAI3LHKWV5+DkyvciEHmCXDQXePPVPNCPzmad5+4B/wP3rPYRife7SZ935dWyz8ROP4
 eMkfmLN+djkmiQDkDgqwEBCvWYocKdypH5ZoSeMjTeYdfVkHgiyhkVrjbmrcEW5DEswH
 ZBaFbbqCHZpbM1AfB+XL1VnnWpa8RnZVPaO2qKJLYvbWwAtyoftwE++4VP2OpMyp91WJ
 bhBA==
X-Gm-Message-State: AOJu0YzbNlwPLy7s+C7AD9PHs4NINBcuHg9mXccdIWZPXtVuAdowbZKX
 Hisu+PqbBKUJQBiUCNOHJhr2Cdb+ptO8D9K2wec=
X-Google-Smtp-Source: AGHT+IHzTHm3wf8ifFYzMoje8JQk6xYipXsSpIEaaZszfIPnDJMvXUhgSHkt9Ow34G6icuRoh43sszMmC/tdCPFhve8=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a0d:ec4c:0:b0:592:83d2:1f86 with SMTP
 id r12-20020a0dec4c000000b0059283d21f86mr55086ywn.4.1695248308414; Wed, 20
 Sep 2023 15:18:28 -0700 (PDT)
Date: Wed, 20 Sep 2023 22:18:12 +0000
In-Reply-To: <20230920221819.1106029-1-nabihestefan@google.com>
Mime-Version: 1.0
References: <20230920221819.1106029-1-nabihestefan@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230920221819.1106029-5-nabihestefan@google.com>
Subject: [PATCH v2 04/11] hw/net: Add NPCMXXX GMAC device
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasonwang@redhat.com, avi.fishman@nuvoton.com, 
 Nabih Estefan Diaz <nabihestefan@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=3tG8LZQwKCu8eRSZYVjkVWReXffXcV.TfdhVdl-UVmVcefeXel.fiX@flex--nabihestefan.bounces.google.com;
 helo=mail-yw1-x1149.google.com
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

From: Hao Wu <wuhaotsh@google.com>

This patch implements the basic registers of GMAC device. Actual network
communications are not supported yet.

Signed-off-by: Hao Wu <wuhaotsh@google.com>

include/hw: Fix type problem in NPCMGMACState

- Fix type problem in NPCMGMACState
- Fix Register Initalization which was breaking boot-up in driver
- Added trace for NPCM_GMAC reset
- Added nd_table to npcm8xx.c for GMAC bootup

Signed-off-by: Nabih Estefan Diaz <nabihestefan@google.com>

hw/net: Add BCM54612E PHY regs for GMAC

This patch adds default values for PHYs to make the driver happy.
The device is derived from an actual Izumi machine.

Signed-off-by: Hao Wu <wuhaotsh@google.com>

hw/net: change GMAC PHY regs to indicate link is up

This change makes NPCM GMAC module to use BCM54612E unconditionally
and make some fake PHY registers such that the kernel driver thinks
the link partner is up.

Tested:
The following message shows up with the change:
Broadcom BCM54612E stmmac-0:00: attached PHY driver [Broadcom BCM54612E] (mii_bus:phy_addr=stmmac-0:00, irq=POLL)
stmmaceth f0802000.eth eth0: Link is Up - 1Gbps/Full - flow control rx/tx

Signed-off-by: Hao Wu <wuhaotsh@google.com>
---
 hw/net/meson.build         |   2 +-
 hw/net/npcm_gmac.c         | 395 +++++++++++++++++++++++++++++++++++++
 hw/net/trace-events        |  11 ++
 include/hw/net/npcm_gmac.h | 170 ++++++++++++++++
 4 files changed, 577 insertions(+), 1 deletion(-)
 create mode 100644 hw/net/npcm_gmac.c
 create mode 100644 include/hw/net/npcm_gmac.h

diff --git a/hw/net/meson.build b/hw/net/meson.build
index 2632634df3..8389a134d5 100644
--- a/hw/net/meson.build
+++ b/hw/net/meson.build
@@ -38,7 +38,7 @@ system_ss.add(when: 'CONFIG_I82596_COMMON', if_true: files('i82596.c'))
 system_ss.add(when: 'CONFIG_SUNHME', if_true: files('sunhme.c'))
 system_ss.add(when: 'CONFIG_FTGMAC100', if_true: files('ftgmac100.c'))
 system_ss.add(when: 'CONFIG_SUNGEM', if_true: files('sungem.c'))
-system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_emc.c'))
+system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_emc.c', 'npcm_gmac.c'))
 
 system_ss.add(when: 'CONFIG_ETRAXFS', if_true: files('etraxfs_eth.c'))
 system_ss.add(when: 'CONFIG_COLDFIRE', if_true: files('mcf_fec.c'))
diff --git a/hw/net/npcm_gmac.c b/hw/net/npcm_gmac.c
new file mode 100644
index 0000000000..5ce632858d
--- /dev/null
+++ b/hw/net/npcm_gmac.c
@@ -0,0 +1,395 @@
+/*
+ * Nuvoton NPCM7xx/8xx GMAC Module
+ *
+ * Copyright 2022 Google LLC
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
+ * for more details.
+ *
+ * Unsupported/unimplemented features:
+ * - MII is not implemented, MII_ADDR.BUSY and MII_DATA always return zero
+ * - Precision timestamp (PTP) is not implemented.
+ */
+
+#include "qemu/osdep.h"
+
+#include "hw/registerfields.h"
+#include "hw/net/mii.h"
+#include "hw/net/npcm_gmac.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/units.h"
+#include "sysemu/dma.h"
+#include "trace.h"
+
+REG32(NPCM_DMA_BUS_MODE, 0x1000)
+REG32(NPCM_DMA_XMT_POLL_DEMAND, 0x1004)
+REG32(NPCM_DMA_RCV_POLL_DEMAND, 0x1008)
+REG32(NPCM_DMA_RCV_BASE_ADDR, 0x100c)
+REG32(NPCM_DMA_TX_BASE_ADDR, 0x1010)
+REG32(NPCM_DMA_STATUS, 0x1014)
+REG32(NPCM_DMA_CONTROL, 0x1018)
+REG32(NPCM_DMA_INTR_ENA, 0x101c)
+REG32(NPCM_DMA_MISSED_FRAME_CTR, 0x1020)
+REG32(NPCM_DMA_HOST_TX_DESC, 0x1048)
+REG32(NPCM_DMA_HOST_RX_DESC, 0x104c)
+REG32(NPCM_DMA_CUR_TX_BUF_ADDR, 0x1050)
+REG32(NPCM_DMA_CUR_RX_BUF_ADDR, 0x1054)
+REG32(NPCM_DMA_HW_FEATURE, 0x1058)
+
+REG32(NPCM_GMAC_MAC_CONFIG, 0x0)
+REG32(NPCM_GMAC_FRAME_FILTER, 0x4)
+REG32(NPCM_GMAC_HASH_HIGH, 0x8)
+REG32(NPCM_GMAC_HASH_LOW, 0xc)
+REG32(NPCM_GMAC_MII_ADDR, 0x10)
+REG32(NPCM_GMAC_MII_DATA, 0x14)
+REG32(NPCM_GMAC_FLOW_CTRL, 0x18)
+REG32(NPCM_GMAC_VLAN_FLAG, 0x1c)
+REG32(NPCM_GMAC_VERSION, 0x20)
+REG32(NPCM_GMAC_WAKEUP_FILTER, 0x28)
+REG32(NPCM_GMAC_PMT, 0x2c)
+REG32(NPCM_GMAC_LPI_CTRL, 0x30)
+REG32(NPCM_GMAC_TIMER_CTRL, 0x34)
+REG32(NPCM_GMAC_INT_STATUS, 0x38)
+REG32(NPCM_GMAC_INT_MASK, 0x3c)
+REG32(NPCM_GMAC_MAC0_ADDR_HI, 0x40)
+REG32(NPCM_GMAC_MAC0_ADDR_LO, 0x44)
+REG32(NPCM_GMAC_MAC1_ADDR_HI, 0x48)
+REG32(NPCM_GMAC_MAC1_ADDR_LO, 0x4c)
+REG32(NPCM_GMAC_MAC2_ADDR_HI, 0x50)
+REG32(NPCM_GMAC_MAC2_ADDR_LO, 0x54)
+REG32(NPCM_GMAC_MAC3_ADDR_HI, 0x58)
+REG32(NPCM_GMAC_MAC3_ADDR_LO, 0x5c)
+REG32(NPCM_GMAC_RGMII_STATUS, 0xd8)
+REG32(NPCM_GMAC_WATCHDOG, 0xdc)
+REG32(NPCM_GMAC_PTP_TCR, 0x700)
+REG32(NPCM_GMAC_PTP_SSIR, 0x704)
+REG32(NPCM_GMAC_PTP_STSR, 0x708)
+REG32(NPCM_GMAC_PTP_STNSR, 0x70c)
+REG32(NPCM_GMAC_PTP_STSUR, 0x710)
+REG32(NPCM_GMAC_PTP_STNSUR, 0x714)
+REG32(NPCM_GMAC_PTP_TAR, 0x718)
+REG32(NPCM_GMAC_PTP_TTSR, 0x71c)
+
+/* Register Fields */
+#define NPCM_GMAC_MII_ADDR_BUSY             BIT(0)
+#define NPCM_GMAC_MII_ADDR_WRITE            BIT(1)
+#define NPCM_GMAC_MII_ADDR_GR(rv)           extract16((rv), 6, 5)
+#define NPCM_GMAC_MII_ADDR_PA(rv)           extract16((rv), 11, 5)
+
+#define NPCM_GMAC_INT_MASK_LPIIM            BIT(10)
+#define NPCM_GMAC_INT_MASK_PMTM             BIT(3)
+#define NPCM_GMAC_INT_MASK_RGIM             BIT(0)
+
+#define NPCM_DMA_BUS_MODE_SWR               BIT(0)
+
+static const uint32_t npcm_gmac_cold_reset_values[NPCM_GMAC_NR_REGS] = {
+    [R_NPCM_GMAC_VERSION]         = 0x00001037,
+    [R_NPCM_GMAC_TIMER_CTRL]      = 0x03e80000,
+    [R_NPCM_GMAC_MAC0_ADDR_HI]    = 0x8000ffff,
+    [R_NPCM_GMAC_MAC0_ADDR_LO]    = 0xffffffff,
+    [R_NPCM_GMAC_MAC1_ADDR_HI]    = 0x0000ffff,
+    [R_NPCM_GMAC_MAC1_ADDR_LO]    = 0xffffffff,
+    [R_NPCM_GMAC_MAC2_ADDR_HI]    = 0x0000ffff,
+    [R_NPCM_GMAC_MAC2_ADDR_LO]    = 0xffffffff,
+    [R_NPCM_GMAC_MAC3_ADDR_HI]    = 0x0000ffff,
+    [R_NPCM_GMAC_MAC3_ADDR_LO]    = 0xffffffff,
+    [R_NPCM_GMAC_PTP_TCR]         = 0x00002000,
+    [R_NPCM_DMA_BUS_MODE]         = 0x00020101,
+    [R_NPCM_DMA_HW_FEATURE]       = 0x100d4f37,
+};
+
+static const uint16_t phy_reg_init[] = {
+    [MII_BMCR]      = MII_BMCR_AUTOEN | MII_BMCR_FD | MII_BMCR_SPEED1000,
+    [MII_BMSR]      = MII_BMSR_100TX_FD | MII_BMSR_100TX_HD | MII_BMSR_10T_FD |
+                      MII_BMSR_10T_HD | MII_BMSR_EXTSTAT | MII_BMSR_AUTONEG |
+                      MII_BMSR_LINK_ST | MII_BMSR_EXTCAP,
+    [MII_PHYID1]    = 0x0362,
+    [MII_PHYID2]    = 0x5e6a,
+    [MII_ANAR]      = MII_ANAR_TXFD | MII_ANAR_TX | MII_ANAR_10FD |
+                      MII_ANAR_10 | MII_ANAR_CSMACD,
+    [MII_ANLPAR]    = MII_ANLPAR_ACK | MII_ANLPAR_PAUSE |
+                      MII_ANLPAR_TXFD | MII_ANLPAR_TX | MII_ANLPAR_10FD |
+                      MII_ANLPAR_10 | MII_ANLPAR_CSMACD,
+    [MII_ANER]      = 0x64 | MII_ANER_NWAY,
+    [MII_ANNP]      = 0x2001,
+    [MII_CTRL1000]  = MII_CTRL1000_FULL,
+    [MII_STAT1000]  = MII_STAT1000_FULL,
+    [MII_EXTSTAT]   = 0x3000, /* 1000BASTE_T full-duplex capable */
+};
+
+static void npcm_gmac_soft_reset(NPCMGMACState *s)
+{
+    memcpy(s->regs, npcm_gmac_cold_reset_values,
+           NPCM_GMAC_NR_REGS * sizeof(uint32_t));
+    /* Clear reset bits */
+    s->regs[R_NPCM_DMA_BUS_MODE] &= ~NPCM_DMA_BUS_MODE_SWR;
+}
+
+static void gmac_phy_set_link(NPCMGMACState *s, bool active)
+{
+    /* Autonegotiation status mirrors link status.  */
+    if (active) {
+        s->phy_regs[0][MII_BMSR] |= (MII_BMSR_LINK_ST | MII_BMSR_AN_COMP);
+    } else {
+        s->phy_regs[0][MII_BMSR] &= ~(MII_BMSR_LINK_ST | MII_BMSR_AN_COMP);
+    }
+}
+
+static bool gmac_can_receive(NetClientState *nc)
+{
+    return true;
+}
+
+static ssize_t gmac_receive(NetClientState *nc, const uint8_t *buf, size_t len1)
+{
+    return 0;
+}
+
+static void gmac_cleanup(NetClientState *nc)
+{
+    /* Nothing to do yet. */
+}
+
+static void gmac_set_link(NetClientState *nc)
+{
+    NPCMGMACState *s = qemu_get_nic_opaque(nc);
+
+    trace_npcm_gmac_set_link(!nc->link_down);
+    gmac_phy_set_link(s, !nc->link_down);
+}
+
+static void npcm_gmac_mdio_access(NPCMGMACState *s, uint16_t v)
+{
+    bool busy = v & NPCM_GMAC_MII_ADDR_BUSY;
+    uint8_t is_write;
+    uint8_t pa, gr;
+    uint16_t data;
+
+    if (busy) {
+        is_write = v & NPCM_GMAC_MII_ADDR_WRITE;
+        pa = NPCM_GMAC_MII_ADDR_PA(v);
+        gr = NPCM_GMAC_MII_ADDR_GR(v);
+        /* Both pa and gr are 5 bits, so they are less than 32. */
+        g_assert(pa < NPCM_GMAC_MAX_PHYS);
+        g_assert(gr < NPCM_GMAC_MAX_PHY_REGS);
+
+
+        if (v & NPCM_GMAC_MII_ADDR_WRITE) {
+            data = s->regs[R_NPCM_GMAC_MII_DATA];
+            /* Clear reset bit for BMCR register */
+            switch (gr) {
+            case MII_BMCR:
+                data &= ~MII_BMCR_RESET;
+                /* Complete auto-negotiation immediately and set as complete */
+                if (data & MII_BMCR_AUTOEN) {
+                    /* Tells autonegotiation to not restart again */
+                    data &= ~MII_BMCR_ANRESTART;
+                    /* sets autonegotiation as complete */
+                    s->phy_regs[pa][MII_BMSR] |= MII_BMSR_AN_COMP;
+                }
+            }
+            s->phy_regs[pa][gr] = data;
+        } else {
+            data = s->phy_regs[pa][gr];
+            s->regs[R_NPCM_GMAC_MII_DATA] = data;
+        }
+        trace_npcm_gmac_mdio_access(DEVICE(s)->canonical_path, is_write, pa,
+                                    gr, data);
+    }
+    s->regs[R_NPCM_GMAC_MII_ADDR] = v & ~NPCM_GMAC_MII_ADDR_BUSY;
+}
+
+static uint64_t npcm_gmac_read(void *opaque, hwaddr offset, unsigned size)
+{
+    NPCMGMACState *s = opaque;
+    uint32_t v = 0;
+
+    switch (offset) {
+    /* Write only registers */
+    case A_NPCM_DMA_XMT_POLL_DEMAND:
+    case A_NPCM_DMA_RCV_POLL_DEMAND:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Read of write-only reg: offset: 0x%04" HWADDR_PRIx
+                      "\n", DEVICE(s)->canonical_path, offset);
+        break;
+
+    default:
+        v = s->regs[offset / sizeof(uint32_t)];
+    }
+    trace_npcm_gmac_reg_read(DEVICE(s)->canonical_path, offset, v);
+    return v;
+}
+
+static void npcm_gmac_write(void *opaque, hwaddr offset,
+                              uint64_t v, unsigned size)
+{
+    NPCMGMACState *s = opaque;
+
+    trace_npcm_gmac_reg_write(DEVICE(s)->canonical_path, offset, v);
+    switch (offset) {
+    /* Read only registers */
+    case A_NPCM_GMAC_VERSION:
+    case A_NPCM_GMAC_INT_STATUS:
+    case A_NPCM_GMAC_RGMII_STATUS:
+    case A_NPCM_GMAC_PTP_STSR:
+    case A_NPCM_GMAC_PTP_STNSR:
+    case A_NPCM_DMA_MISSED_FRAME_CTR:
+    case A_NPCM_DMA_HOST_TX_DESC:
+    case A_NPCM_DMA_HOST_RX_DESC:
+    case A_NPCM_DMA_CUR_TX_BUF_ADDR:
+    case A_NPCM_DMA_CUR_RX_BUF_ADDR:
+    case A_NPCM_DMA_HW_FEATURE:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Write of read-only reg: offset: 0x%04" HWADDR_PRIx
+                      ", value: 0x%04" PRIx64 "\n",
+                      DEVICE(s)->canonical_path, offset, v);
+        break;
+
+    case A_NPCM_GMAC_MII_ADDR:
+        npcm_gmac_mdio_access(s, v);
+        break;
+
+    case A_NPCM_GMAC_MAC0_ADDR_HI:
+        s->regs[offset / sizeof(uint32_t)] = v;
+        s->conf.macaddr.a[0] = v >> 8;
+        s->conf.macaddr.a[1] = v >> 0;
+        break;
+
+    case A_NPCM_GMAC_MAC0_ADDR_LO:
+        s->regs[offset / sizeof(uint32_t)] = v;
+        s->conf.macaddr.a[2] = v >> 24;
+        s->conf.macaddr.a[3] = v >> 16;
+        s->conf.macaddr.a[4] = v >> 8;
+        s->conf.macaddr.a[5] = v >> 0;
+        break;
+
+    case A_NPCM_GMAC_MAC1_ADDR_HI:
+    case A_NPCM_GMAC_MAC1_ADDR_LO:
+    case A_NPCM_GMAC_MAC2_ADDR_HI:
+    case A_NPCM_GMAC_MAC2_ADDR_LO:
+    case A_NPCM_GMAC_MAC3_ADDR_HI:
+    case A_NPCM_GMAC_MAC3_ADDR_LO:
+        s->regs[offset / sizeof(uint32_t)] = v;
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: Only MAC Address 0 is supported. This request "
+                      "is ignored.\n", DEVICE(s)->canonical_path);
+        break;
+
+    case A_NPCM_DMA_BUS_MODE:
+        s->regs[offset / sizeof(uint32_t)] = v;
+        if (v & NPCM_DMA_BUS_MODE_SWR) {
+            npcm_gmac_soft_reset(s);
+        }
+        break;
+
+    default:
+        s->regs[offset / sizeof(uint32_t)] = v;
+        break;
+    }
+}
+
+static void npcm_gmac_reset(DeviceState *dev)
+{
+    NPCMGMACState *s = NPCM_GMAC(dev);
+
+    npcm_gmac_soft_reset(s);
+    memcpy(s->phy_regs[0], phy_reg_init, sizeof(phy_reg_init));
+
+    trace_npcm_gmac_reset(DEVICE(s)->canonical_path, s->phy_regs[0][MII_BMSR]);
+}
+
+static NetClientInfo net_npcm_gmac_info = {
+    .type = NET_CLIENT_DRIVER_NIC,
+    .size = sizeof(NICState),
+    .can_receive = gmac_can_receive,
+    .receive = gmac_receive,
+    .cleanup = gmac_cleanup,
+    .link_status_changed = gmac_set_link,
+};
+
+static const struct MemoryRegionOps npcm_gmac_ops = {
+    .read = npcm_gmac_read,
+    .write = npcm_gmac_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static void npcm_gmac_realize(DeviceState *dev, Error **errp)
+{
+    NPCMGMACState *gmac = NPCM_GMAC(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    memory_region_init_io(&gmac->iomem, OBJECT(gmac), &npcm_gmac_ops, gmac,
+                          TYPE_NPCM_GMAC, 8 * KiB);
+    sysbus_init_mmio(sbd, &gmac->iomem);
+    sysbus_init_irq(sbd, &gmac->irq);
+
+    qemu_macaddr_default_if_unset(&gmac->conf.macaddr);
+
+    gmac->nic = qemu_new_nic(&net_npcm_gmac_info, &gmac->conf, TYPE_NPCM_GMAC,
+                             dev->id, gmac);
+    qemu_format_nic_info_str(qemu_get_queue(gmac->nic), gmac->conf.macaddr.a);
+    gmac->regs[R_NPCM_GMAC_MAC0_ADDR_HI] = (gmac->conf.macaddr.a[0] << 8) + \
+                                            gmac->conf.macaddr.a[1];
+    gmac->regs[R_NPCM_GMAC_MAC0_ADDR_LO] = (gmac->conf.macaddr.a[2] << 24) + \
+                                           (gmac->conf.macaddr.a[3] << 16) + \
+                                           (gmac->conf.macaddr.a[4] << 8) + \
+                                            gmac->conf.macaddr.a[5];
+}
+
+static void npcm_gmac_unrealize(DeviceState *dev)
+{
+    NPCMGMACState *gmac = NPCM_GMAC(dev);
+
+    qemu_del_nic(gmac->nic);
+}
+
+static const VMStateDescription vmstate_npcm_gmac = {
+    .name = TYPE_NPCM_GMAC,
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, NPCMGMACState, NPCM_GMAC_NR_REGS),
+        VMSTATE_END_OF_LIST(),
+    },
+};
+
+static Property npcm_gmac_properties[] = {
+    DEFINE_NIC_PROPERTIES(NPCMGMACState, conf),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void npcm_gmac_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
+    dc->desc = "NPCM GMAC Controller";
+    dc->realize = npcm_gmac_realize;
+    dc->unrealize = npcm_gmac_unrealize;
+    dc->reset = npcm_gmac_reset;
+    dc->vmsd = &vmstate_npcm_gmac;
+    device_class_set_props(dc, npcm_gmac_properties);
+}
+
+static const TypeInfo npcm_gmac_types[] = {
+    {
+        .name = TYPE_NPCM_GMAC,
+        .parent = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(NPCMGMACState),
+        .class_init = npcm_gmac_class_init,
+    },
+};
+DEFINE_TYPES(npcm_gmac_types)
diff --git a/hw/net/trace-events b/hw/net/trace-events
index 3abfd65e5b..1dbb5d2d64 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -466,6 +466,17 @@ npcm7xx_emc_rx_done(uint32_t crxdsa) "RX done, CRXDSA=0x%x"
 npcm7xx_emc_reg_read(int emc_num, uint32_t result, const char *name, int regno) "emc%d: 0x%x = reg[%s/%d]"
 npcm7xx_emc_reg_write(int emc_num, const char *name, int regno, uint32_t value) "emc%d: reg[%s/%d] = 0x%x"
 
+# npcm_gmac.c
+npcm_gmac_reg_read(const char *name, uint64_t offset, uint32_t value) "%s: offset: 0x%04" PRIx64 " value: 0x%04" PRIx32
+npcm_gmac_reg_write(const char *name, uint64_t offset, uint32_t value) "%s: offset: 0x%04" PRIx64 " value: 0x%04" PRIx32
+npcm_gmac_mdio_access(const char *name, uint8_t is_write, uint8_t pa, uint8_t gr, uint16_t val) "%s: is_write: %" PRIu8 " pa: %" PRIu8 " gr: %" PRIu8 " val: 0x%04" PRIx16
+npcm_gmac_reset(const char *name, uint16_t value) "%s: phy_regs[0][1]: 0x%04" PRIx16
+npcm_gmac_set_link(bool active) "Set link: active=%u"
+
+# npcm_pcs.c
+npcm_pcs_reg_read(const char *name, uint16_t indirect_access_baes, uint64_t offset, uint16_t value) "%s: IND: 0x%02" PRIx16 " offset: 0x%04" PRIx64 " value: 0x%04" PRIx16
+npcm_pcs_reg_write(const char *name, uint16_t indirect_access_baes, uint64_t offset, uint16_t value) "%s: IND: 0x%02" PRIx16 " offset: 0x%04" PRIx64 " value: 0x%04" PRIx16
+
 # dp8398x.c
 dp8393x_raise_irq(int isr) "raise irq, isr is 0x%04x"
 dp8393x_lower_irq(void) "lower irq"
diff --git a/include/hw/net/npcm_gmac.h b/include/hw/net/npcm_gmac.h
new file mode 100644
index 0000000000..a92a654278
--- /dev/null
+++ b/include/hw/net/npcm_gmac.h
@@ -0,0 +1,170 @@
+/*
+ * Nuvoton NPCM7xx/8xx GMAC Module
+ *
+ * Copyright 2022 Google LLC
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
+ * for more details.
+ */
+
+#ifndef NPCM_GMAC_H
+#define NPCM_GMAC_H
+
+#include "hw/irq.h"
+#include "hw/sysbus.h"
+#include "net/net.h"
+
+#define NPCM_GMAC_NR_REGS (0x1060 / sizeof(uint32_t))
+
+#define NPCM_GMAC_MAX_PHYS 32
+#define NPCM_GMAC_MAX_PHY_REGS 32
+
+struct NPCMGMACRxDesc {
+    uint32_t rdes0;
+    uint32_t rdes1;
+    uint32_t rdes2;
+    uint32_t rdes3;
+};
+
+/* NPCMGMACRxDesc.flags values */
+/* RDES2 and RDES3 are buffer address pointers */
+/* Owner: 0 = software, 1 = gmac */
+#define RX_DESC_RDES0_OWNER_MASK BIT(31)
+/* Owner*/
+#define RX_DESC_RDES0_OWNER_SHIFT 31
+/* Destination Address Filter Fail */
+#define RX_DESC_RDES0_DEST_ADDR_FILT_FAIL_MASK BIT(30)
+/* Frame length*/
+#define RX_DESC_RDES0_FRAME_LEN_MASK(word) extract32(word, 16, 29)
+/* Error Summary */
+#define RX_DESC_RDES0_ERR_SUMM_MASK BIT(15)
+/* Descriptor Error */
+#define RX_DESC_RDES0_DESC_ERR_MASK BIT(14)
+/* Source Address Filter Fail */
+#define RX_DESC_RDES0_SRC_ADDR_FILT_FAIL_MASK BIT(13)
+/* Length Error */
+#define RX_DESC_RDES0_LEN_ERR_MASK BIT(12)
+/* Overflow Error */
+#define RX_DESC_RDES0_OVRFLW_ERR_MASK BIT(11)
+/* VLAN Tag */
+#define RX_DESC_RDES0_VLAN_TAG_MASK BIT(10)
+/* First Descriptor */
+#define RX_DESC_RDES0_FIRST_DESC_MASK BIT(9)
+/* Last Descriptor */
+#define RX_DESC_RDES0_LAST_DESC_MASK BIT(8)
+/* IPC Checksum Error/Giant Frame */
+#define RX_DESC_RDES0_IPC_CHKSM_ERR_GNT_FRM_MASK BIT(7)
+/* Late Collision */
+#define RX_DESC_RDES0_LT_COLL_MASK BIT(6)
+/* Frame Type */
+#define RX_DESC_RDES0_FRM_TYPE_MASK BIT(5)
+/* Receive Watchdog Timeout */
+#define RX_DESC_RDES0_REC_WTCHDG_TMT_MASK BIT(4)
+/* Receive Error */
+#define RX_DESC_RDES0_RCV_ERR_MASK BIT(3)
+/* Dribble Bit Error */
+#define RX_DESC_RDES0_DRBL_BIT_ERR_MASK BIT(2)
+/* Cyclcic Redundancy Check Error */
+#define RX_DESC_RDES0_CRC_ERR_MASK BIT(1)
+/* Rx MAC Address/Payload Checksum Error */
+#define RC_DESC_RDES0_RCE_MASK BIT(0)
+
+/* Disable Interrupt on Completion */
+#define RX_DESC_RDES1_DIS_INTR_COMP_MASK BIT(31)
+/* Recieve end of ring */
+#define RX_DESC_RDES1_RC_END_RING_MASK BIT(25)
+/* Second Address Chained */
+#define RX_DESC_RDES1_SEC_ADDR_CHND_MASK BIT(24)
+/* Receive Buffer 2 Size */
+#define RX_DESC_RDES1_BFFR2_SZ_SHIFT 11
+#define RX_DESC_RDES1_BFFR2_SZ_MASK(word) extract32(word, \
+    RX_DESC_RDES1_BFFR2_SZ_SHIFT, 10 + RX_DESC_RDES1_BFFR2_SZ_SHIFT)
+/* Receive Buffer 1 Size */
+#define RX_DESC_RDES1_BFFR1_SZ_MASK(word) extract32(word, 0, 10)
+
+
+struct NPCMGMACTxDesc {
+    uint32_t tdes0;
+    uint32_t tdes1;
+    uint32_t tdes2;
+    uint32_t tdes3;
+};
+
+/* NPCMGMACTxDesc.flags values */
+/* TDES2 and TDES3 are buffer address pointers */
+/* Owner: 0 = software, 1 = gmac */
+#define TX_DESC_TDES0_OWNER_MASK BIT(31)
+/* Tx Time Stamp Status */
+#define TX_DESC_TDES0_TTSS_MASK BIT(17)
+/* IP Header Error */
+#define TX_DESC_TDES0_IP_HEAD_ERR_MASK BIT(16)
+/* Error Summary */
+#define TX_DESC_TDES0_ERR_SUMM_MASK BIT(15)
+/* Jabber Timeout */
+#define TX_DESC_TDES0_JBBR_TMT_MASK BIT(14)
+/* Frame Flushed */
+#define TX_DESC_TDES0_FRM_FLSHD_MASK BIT(13)
+/* Payload Checksum Error */
+#define TX_DESC_TDES0_PYLD_CHKSM_ERR_MASK BIT(12)
+/* Loss of Carrier */
+#define TX_DESC_TDES0_LSS_CARR_MASK BIT(11)
+/* No Carrier */
+#define TX_DESC_TDES0_NO_CARR_MASK BIT(10)
+/* Late Collision */
+#define TX_DESC_TDES0_LATE_COLL_MASK BIT(9)
+/* Excessive Collision */
+#define TX_DESC_TDES0_EXCS_COLL_MASK BIT(8)
+/* VLAN Frame */
+#define TX_DESC_TDES0_VLAN_FRM_MASK BIT(7)
+/* Collision Count */
+#define TX_DESC_TDES0_COLL_CNT_MASK(word) extract32(word, 3, 6)
+/* Excessive Deferral */
+#define TX_DESC_TDES0_EXCS_DEF_MASK BIT(2)
+/* Underflow Error */
+#define TX_DESC_TDES0_UNDRFLW_ERR_MASK BIT(1)
+/* Deferred Bit */
+#define TX_DESC_TDES0_DFRD_BIT_MASK BIT(0)
+
+/* Interrupt of Completion */
+#define TX_DESC_TDES1_INTERR_COMP_MASK BIT(31)
+/* Last Segment */
+#define TX_DESC_TDES1_LAST_SEG_MASK BIT(30)
+/* Last Segment */
+#define TX_DESC_TDES1_FIRST_SEG_MASK BIT(29)
+/* Checksum Insertion Control */
+#define TX_DESC_TDES1_CHKSM_INS_CTRL_MASK(word) extract32(word, 27, 28)
+/* Disable Cyclic Redundancy Check */
+#define TX_DESC_TDES1_DIS_CDC_MASK BIT(26)
+/* Transmit End of Ring */
+#define TX_DESC_TDES1_TX_END_RING_MASK BIT(25)
+/* Secondary Address Chained */
+#define TX_DESC_TDES1_SEC_ADDR_CHND_MASK BIT(24)
+/* Transmit Buffer 2 Size */
+#define TX_DESC_TDES1_BFFR2_SZ_MASK(word) extract32(word, 11, 21)
+/* Transmit Buffer 1 Size */
+#define TX_DESC_TDES1_BFFR1_SZ_MASK(word) extract32(word, 0, 10)
+
+typedef struct NPCMGMACState {
+    SysBusDevice parent;
+
+    MemoryRegion iomem;
+    qemu_irq irq;
+
+    NICState *nic;
+    NICConf conf;
+
+    uint32_t regs[NPCM_GMAC_NR_REGS];
+    uint16_t phy_regs[NPCM_GMAC_MAX_PHYS][NPCM_GMAC_MAX_PHY_REGS];
+} NPCMGMACState;
+
+#define TYPE_NPCM_GMAC "npcm-gmac"
+OBJECT_DECLARE_SIMPLE_TYPE(NPCMGMACState, NPCM_GMAC)
+
+#endif /* NPCM_GMAC_H */
-- 
2.42.0.459.ge4e396fd5e-goog


