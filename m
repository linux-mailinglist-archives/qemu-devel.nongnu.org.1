Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9395A8201C1
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:29:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKPW-0005Nt-PP; Fri, 29 Dec 2023 16:28:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKPF-00053v-Ny
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:28:38 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKPB-0000JU-NI
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:28:37 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6d9344f30caso4789337b3a.1
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885312; x=1704490112; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pRvRbNjEbIwOczpWL3bW5tExgcKzvngsOhwJnChX8Bg=;
 b=kDeFc8L02Zv7wpPH2wVU9pAu7Fj+dj4/pSU8C+1L+61RKKfJz90ajrHNjNkSy8OS6C
 ZOCoq5buVjgfR66dM9KN8FGWTxheC/I0QNLjv4wr/XYX1mTnLT0aOaRXWiSQBjIG5vW4
 HrfOHhLSlFXq+c1c6UGTyg3Bri9Y3JQbxzL3zJzMPWGP/t0gUS8hUQ7ITvqQ5ySD7oT1
 CAbusY2z+wiIDgXfMw9rILk3zzxiQyPzR3FN7vSIdnmvCMxuvYpBT9I6xmjoT9NNyr16
 I6KuVc5072sSd24D5e2M9UYJ98uC81Vhdw8K4kr9nzn10yS04ZLrSzEdpyaulkAZhoVy
 8XKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885312; x=1704490112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pRvRbNjEbIwOczpWL3bW5tExgcKzvngsOhwJnChX8Bg=;
 b=sLX/b9KA78NApQQHuZCyLSMOY+WIWenazHaGhFLRt8kOARdvZWgoT3XwK052+uIJdg
 hOVJetIimPvuNIk1XM2pvAxzFOqX/zayyvJ9xQDiwg4rxWDAqPW0shI2YksQERv0CUdK
 A7lr9j4rk4pXCb+9bKB4TJmqkotvo3T20eVO7nYwVhi+JASJJ9J1h3qLqDs1prjZtU2r
 lceER5ojcRZkcG4AuxEZW1WGeXmNtx2x7MyC1y+jK5NQ7I/0dnHbgYxEWIjr04Q9bBdo
 mxuOTprxT6DkzThbDAPxWwUdaT0xaqxGRsm8faXJu8cRsssusSWTsIMj/LctTG2aMMA8
 uELA==
X-Gm-Message-State: AOJu0YxNZXTylU4zcOsJQnJ+dg1pdQqjqsLreja7NExspynT1jnfKv4+
 roHAauXOU/GlbV+idsKwXhf8i+/kczCNP3ubjiUt093xwd2NGg==
X-Google-Smtp-Source: AGHT+IEBdzJY3t+swMwvR4IJNYCBjqqzVSVRn/3D+Q0/WG0OLyxnh+IJusxdAkSXLR2GWvcsKD7GNg==
X-Received: by 2002:a05:6a00:1c85:b0:6d9:bee5:702d with SMTP id
 y5-20020a056a001c8500b006d9bee5702dmr9403381pfw.18.1703885312065; 
 Fri, 29 Dec 2023 13:28:32 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 bd33-20020a056a0027a100b006d9a96b7d0dsm11285396pfb.208.2023.12.29.13.28.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:28:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 41/71] hw/net: Constify VMState
Date: Sat, 30 Dec 2023 08:23:16 +1100
Message-Id: <20231229212346.147149-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231221031652.119827-42-richard.henderson@linaro.org>
---
 hw/net/allwinner-sun8i-emac.c  |  2 +-
 hw/net/allwinner_emac.c        |  4 ++--
 hw/net/cadence_gem.c           |  2 +-
 hw/net/can/can_kvaser_pci.c    |  2 +-
 hw/net/can/can_mioe3680_pci.c  |  2 +-
 hw/net/can/can_pcm3680_pci.c   |  2 +-
 hw/net/can/can_sja1000.c       |  4 ++--
 hw/net/can/ctucan_core.c       |  4 ++--
 hw/net/can/ctucan_pci.c        |  2 +-
 hw/net/can/xlnx-versal-canfd.c |  2 +-
 hw/net/can/xlnx-zynqmp-can.c   |  2 +-
 hw/net/dp8393x.c               |  2 +-
 hw/net/e1000.c                 | 10 +++++-----
 hw/net/e1000e.c                |  6 +++---
 hw/net/eepro100.c              |  2 +-
 hw/net/ftgmac100.c             |  4 ++--
 hw/net/i82596.c                |  2 +-
 hw/net/igb.c                   |  8 ++++----
 hw/net/imx_fec.c               |  6 +++---
 hw/net/lan9118.c               |  4 ++--
 hw/net/lance.c                 |  2 +-
 hw/net/lasi_i82596.c           |  2 +-
 hw/net/mipsnet.c               |  2 +-
 hw/net/msf2-emac.c             |  2 +-
 hw/net/mv88w8618_eth.c         |  2 +-
 hw/net/ne2000-isa.c            |  2 +-
 hw/net/ne2000-pci.c            |  2 +-
 hw/net/ne2000.c                |  2 +-
 hw/net/npcm7xx_emc.c           |  2 +-
 hw/net/pcnet-pci.c             |  2 +-
 hw/net/pcnet.c                 |  2 +-
 hw/net/rtl8139.c               |  6 +++---
 hw/net/smc91c111.c             |  2 +-
 hw/net/spapr_llan.c            |  8 ++++----
 hw/net/stellaris_enet.c        |  4 ++--
 hw/net/sungem.c                |  2 +-
 hw/net/sunhme.c                |  2 +-
 hw/net/tulip.c                 |  2 +-
 hw/net/virtio-net.c            | 18 +++++++++---------
 hw/net/vmxnet3.c               | 18 +++++++++---------
 hw/net/xgmac.c                 |  4 ++--
 41 files changed, 80 insertions(+), 80 deletions(-)

diff --git a/hw/net/allwinner-sun8i-emac.c b/hw/net/allwinner-sun8i-emac.c
index cc350d40e5..108ae9c853 100644
--- a/hw/net/allwinner-sun8i-emac.c
+++ b/hw/net/allwinner-sun8i-emac.c
@@ -851,7 +851,7 @@ static const VMStateDescription vmstate_aw_emac = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = allwinner_sun8i_emac_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(mii_phy_addr, AwSun8iEmacState),
         VMSTATE_UINT32(mii_cmd, AwSun8iEmacState),
         VMSTATE_UINT32(mii_data, AwSun8iEmacState),
diff --git a/hw/net/allwinner_emac.c b/hw/net/allwinner_emac.c
index e10965de14..989839784a 100644
--- a/hw/net/allwinner_emac.c
+++ b/hw/net/allwinner_emac.c
@@ -472,7 +472,7 @@ static const VMStateDescription vmstate_mii = {
     .name = "rtl8201cp",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT16(bmcr, RTL8201CPState),
         VMSTATE_UINT16(bmsr, RTL8201CPState),
         VMSTATE_UINT16(anar, RTL8201CPState),
@@ -495,7 +495,7 @@ static const VMStateDescription vmstate_aw_emac = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = aw_emac_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(mii, AwEmacState, 1, vmstate_mii, RTL8201CPState),
         VMSTATE_UINT32(ctl, AwEmacState),
         VMSTATE_UINT32(tx_mode, AwEmacState),
diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 296bba238e..d7b7b134b0 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -1771,7 +1771,7 @@ static const VMStateDescription vmstate_cadence_gem = {
     .name = "cadence_gem",
     .version_id = 4,
     .minimum_version_id = 4,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, CadenceGEMState, CADENCE_GEM_MAXREG),
         VMSTATE_UINT16_ARRAY(phy_regs, CadenceGEMState, 32),
         VMSTATE_UINT8(phy_loop, CadenceGEMState),
diff --git a/hw/net/can/can_kvaser_pci.c b/hw/net/can/can_kvaser_pci.c
index 2cd90cef1e..bf41e6b261 100644
--- a/hw/net/can/can_kvaser_pci.c
+++ b/hw/net/can/can_kvaser_pci.c
@@ -266,7 +266,7 @@ static const VMStateDescription vmstate_kvaser_pci = {
     .name = "kvaser_pci",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(dev, KvaserPCIState),
         /* Load this before sja_state.  */
         VMSTATE_UINT32(s5920_intcsr, KvaserPCIState),
diff --git a/hw/net/can/can_mioe3680_pci.c b/hw/net/can/can_mioe3680_pci.c
index b9918773b3..308b17e0c0 100644
--- a/hw/net/can/can_mioe3680_pci.c
+++ b/hw/net/can/can_mioe3680_pci.c
@@ -203,7 +203,7 @@ static const VMStateDescription vmstate_mioe3680_pci = {
     .name = "mioe3680_pci",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(dev, Mioe3680PCIState),
         VMSTATE_STRUCT(sja_state[0], Mioe3680PCIState, 0, vmstate_can_sja,
                        CanSJA1000State),
diff --git a/hw/net/can/can_pcm3680_pci.c b/hw/net/can/can_pcm3680_pci.c
index 8ef3e4659c..e4c8d93b98 100644
--- a/hw/net/can/can_pcm3680_pci.c
+++ b/hw/net/can/can_pcm3680_pci.c
@@ -204,7 +204,7 @@ static const VMStateDescription vmstate_pcm3680i_pci = {
     .name = "pcm3680i_pci",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(dev, Pcm3680iPCIState),
         VMSTATE_STRUCT(sja_state[0], Pcm3680iPCIState, 0,
                        vmstate_can_sja, CanSJA1000State),
diff --git a/hw/net/can/can_sja1000.c b/hw/net/can/can_sja1000.c
index 73201f9139..1165d59824 100644
--- a/hw/net/can/can_sja1000.c
+++ b/hw/net/can/can_sja1000.c
@@ -929,7 +929,7 @@ const VMStateDescription vmstate_qemu_can_filter = {
     .name = "qemu_can_filter",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(can_id, qemu_can_filter),
         VMSTATE_UINT32(can_mask, qemu_can_filter),
         VMSTATE_END_OF_LIST()
@@ -953,7 +953,7 @@ const VMStateDescription vmstate_can_sja = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = can_sja_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(mode, CanSJA1000State),
 
         VMSTATE_UINT8(status_pel, CanSJA1000State),
diff --git a/hw/net/can/ctucan_core.c b/hw/net/can/ctucan_core.c
index f2c3b6a706..812b83e93e 100644
--- a/hw/net/can/ctucan_core.c
+++ b/hw/net/can/ctucan_core.c
@@ -617,7 +617,7 @@ const VMStateDescription vmstate_qemu_ctucan_tx_buffer = {
     .name = "qemu_ctucan_tx_buffer",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8_ARRAY(data, CtuCanCoreMsgBuffer, CTUCAN_CORE_MSG_MAX_LEN),
         VMSTATE_END_OF_LIST()
     }
@@ -636,7 +636,7 @@ const VMStateDescription vmstate_ctucan = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = ctucan_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(mode_settings.u32, CtuCanCoreState),
         VMSTATE_UINT32(status.u32, CtuCanCoreState),
         VMSTATE_UINT32(int_stat.u32, CtuCanCoreState),
diff --git a/hw/net/can/ctucan_pci.c b/hw/net/can/ctucan_pci.c
index ea079e2af5..d8f7344ddc 100644
--- a/hw/net/can/ctucan_pci.c
+++ b/hw/net/can/ctucan_pci.c
@@ -215,7 +215,7 @@ static const VMStateDescription vmstate_ctucan_pci = {
     .name = "ctucan_pci",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(dev, CtuCanPCIState),
         VMSTATE_STRUCT(ctucan_state[0], CtuCanPCIState, 0, vmstate_ctucan,
                        CtuCanCoreState),
diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
index 5b8ce0a285..47a14cfe63 100644
--- a/hw/net/can/xlnx-versal-canfd.c
+++ b/hw/net/can/xlnx-versal-canfd.c
@@ -2060,7 +2060,7 @@ static const VMStateDescription vmstate_canfd = {
     .name = TYPE_XILINX_CANFD,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, XlnxVersalCANFDState,
                              XLNX_VERSAL_CANFD_R_MAX),
         VMSTATE_PTIMER(canfd_timer, XlnxVersalCANFDState),
diff --git a/hw/net/can/xlnx-zynqmp-can.c b/hw/net/can/xlnx-zynqmp-can.c
index f60e480c3a..ca0ce4e8bb 100644
--- a/hw/net/can/xlnx-zynqmp-can.c
+++ b/hw/net/can/xlnx-zynqmp-can.c
@@ -1159,7 +1159,7 @@ static const VMStateDescription vmstate_can = {
     .name = TYPE_XLNX_ZYNQMP_CAN,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_FIFO32(rx_fifo, XlnxZynqMPCANState),
         VMSTATE_FIFO32(tx_fifo, XlnxZynqMPCANState),
         VMSTATE_FIFO32(txhpb_fifo, XlnxZynqMPCANState),
diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index b16b18b3c3..bf0652da1b 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -924,7 +924,7 @@ static const VMStateDescription vmstate_dp8393x = {
     .name = "dp8393x",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField []) {
+    .fields = (const VMStateField []) {
         VMSTATE_UINT16_2DARRAY(cam, dp8393xState, 16, 3),
         VMSTATE_UINT16_ARRAY(regs, dp8393xState, SONIC_REG_COUNT),
         VMSTATE_END_OF_LIST()
diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index 8ffe1077f1..43f3a4a701 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -1437,7 +1437,7 @@ static const VMStateDescription vmstate_e1000_mit_state = {
     .name = "e1000/mit_state",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(mac_reg[RDTR], E1000State),
         VMSTATE_UINT32(mac_reg[RADV], E1000State),
         VMSTATE_UINT32(mac_reg[TADV], E1000State),
@@ -1452,7 +1452,7 @@ static const VMStateDescription vmstate_e1000_full_mac_state = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = e1000_full_mac_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(mac_reg, E1000State, 0x8000),
         VMSTATE_END_OF_LIST()
     }
@@ -1464,7 +1464,7 @@ static const VMStateDescription vmstate_e1000_tx_tso_state = {
     .minimum_version_id = 1,
     .needed = e1000_tso_state_needed,
     .post_load = e1000_tx_tso_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(tx.tso_props.ipcss, E1000State),
         VMSTATE_UINT8(tx.tso_props.ipcso, E1000State),
         VMSTATE_UINT16(tx.tso_props.ipcse, E1000State),
@@ -1486,7 +1486,7 @@ static const VMStateDescription vmstate_e1000 = {
     .minimum_version_id = 1,
     .pre_save = e1000_pre_save,
     .post_load = e1000_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(parent_obj, E1000State),
         VMSTATE_UNUSED_TEST(is_version_1, 4), /* was instance id */
         VMSTATE_UNUSED(4), /* Was mmio_base.  */
@@ -1558,7 +1558,7 @@ static const VMStateDescription vmstate_e1000 = {
                                  E1000_VLAN_FILTER_TBL_SIZE),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription*[]) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_e1000_mit_state,
         &vmstate_e1000_full_mac_state,
         &vmstate_e1000_tx_tso_state,
diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index e41a6c1038..7c6f602951 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -564,7 +564,7 @@ static const VMStateDescription e1000e_vmstate_tx = {
     .name = "e1000e-tx",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(sum_needed, struct e1000e_tx),
         VMSTATE_UINT8(props.ipcss, struct e1000e_tx),
         VMSTATE_UINT8(props.ipcso, struct e1000e_tx),
@@ -588,7 +588,7 @@ static const VMStateDescription e1000e_vmstate_intr_timer = {
     .name = "e1000e-intr-timer",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_TIMER_PTR(timer, E1000IntrDelayTimer),
         VMSTATE_BOOL(running, E1000IntrDelayTimer),
         VMSTATE_END_OF_LIST()
@@ -609,7 +609,7 @@ static const VMStateDescription e1000e_vmstate = {
     .minimum_version_id = 1,
     .pre_save = e1000e_pre_save,
     .post_load = e1000e_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(parent_obj, E1000EState),
         VMSTATE_MSIX(parent_obj, E1000EState),
 
diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
index 69e1c4bb89..d9a70c4544 100644
--- a/hw/net/eepro100.c
+++ b/hw/net/eepro100.c
@@ -1772,7 +1772,7 @@ static ssize_t nic_receive(NetClientState *nc, const uint8_t * buf, size_t size)
 static const VMStateDescription vmstate_eepro100 = {
     .version_id = 3,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(dev, EEPRO100State),
         VMSTATE_UNUSED(32),
         VMSTATE_BUFFER(mult, EEPRO100State),
diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index 78e594afa4..74b6c3d9a7 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -1119,7 +1119,7 @@ static const VMStateDescription vmstate_ftgmac100 = {
     .name = TYPE_FTGMAC100,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(irq_state, FTGMAC100State),
         VMSTATE_UINT32(isr, FTGMAC100State),
         VMSTATE_UINT32(ier, FTGMAC100State),
@@ -1304,7 +1304,7 @@ static const VMStateDescription vmstate_aspeed_mii = {
     .name = TYPE_ASPEED_MII,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(phycr, FTGMAC100State),
         VMSTATE_UINT32(phydata, FTGMAC100State),
         VMSTATE_END_OF_LIST()
diff --git a/hw/net/i82596.c b/hw/net/i82596.c
index a907f0df8c..6cc8292a65 100644
--- a/hw/net/i82596.c
+++ b/hw/net/i82596.c
@@ -713,7 +713,7 @@ const VMStateDescription vmstate_i82596 = {
     .name = "i82596",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT16(lnkst, I82596State),
         VMSTATE_TIMER_PTR(flush_queue_timer, I82596State),
         VMSTATE_END_OF_LIST()
diff --git a/hw/net/igb.c b/hw/net/igb.c
index 8089acfea4..0b5c31a58b 100644
--- a/hw/net/igb.c
+++ b/hw/net/igb.c
@@ -520,7 +520,7 @@ static const VMStateDescription igb_vmstate_tx_ctx = {
     .name = "igb-tx-ctx",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(vlan_macip_lens, struct e1000_adv_tx_context_desc),
         VMSTATE_UINT32(seqnum_seed, struct e1000_adv_tx_context_desc),
         VMSTATE_UINT32(type_tucmd_mlhl, struct e1000_adv_tx_context_desc),
@@ -533,7 +533,7 @@ static const VMStateDescription igb_vmstate_tx = {
     .name = "igb-tx",
     .version_id = 2,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT_ARRAY(ctx, struct igb_tx, 2, 0, igb_vmstate_tx_ctx,
                              struct e1000_adv_tx_context_desc),
         VMSTATE_UINT32(first_cmd_type_len, struct igb_tx),
@@ -548,7 +548,7 @@ static const VMStateDescription igb_vmstate_intr_timer = {
     .name = "igb-intr-timer",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_TIMER_PTR(timer, IGBIntrDelayTimer),
         VMSTATE_BOOL(running, IGBIntrDelayTimer),
         VMSTATE_END_OF_LIST()
@@ -569,7 +569,7 @@ static const VMStateDescription igb_vmstate = {
     .minimum_version_id = 1,
     .pre_save = igb_pre_save,
     .post_load = igb_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(parent_obj, IGBState),
         VMSTATE_MSIX(parent_obj, IGBState),
 
diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index 6881e3e4f0..cee84af7ba 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -195,7 +195,7 @@ static const VMStateDescription vmstate_imx_eth_txdescs = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = imx_eth_is_multi_tx_ring,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
          VMSTATE_UINT32(tx_descriptor[1], IMXFECState),
          VMSTATE_UINT32(tx_descriptor[2], IMXFECState),
          VMSTATE_END_OF_LIST()
@@ -206,7 +206,7 @@ static const VMStateDescription vmstate_imx_eth = {
     .name = TYPE_IMX_FEC,
     .version_id = 2,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, IMXFECState, ENET_MAX),
         VMSTATE_UINT32(rx_descriptor, IMXFECState),
         VMSTATE_UINT32(tx_descriptor[0], IMXFECState),
@@ -217,7 +217,7 @@ static const VMStateDescription vmstate_imx_eth = {
         VMSTATE_UINT32(phy_int_mask, IMXFECState),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription * []) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_imx_eth_txdescs,
         NULL
     },
diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index cf7b8c897a..598dd79e17 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -173,7 +173,7 @@ static const VMStateDescription vmstate_lan9118_packet = {
     .name = "lan9118_packet",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(state, LAN9118Packet),
         VMSTATE_UINT32(cmd_a, LAN9118Packet),
         VMSTATE_UINT32(cmd_b, LAN9118Packet),
@@ -271,7 +271,7 @@ static const VMStateDescription vmstate_lan9118 = {
     .name = "lan9118",
     .version_id = 2,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PTIMER(timer, lan9118_state),
         VMSTATE_UINT32(irq_cfg, lan9118_state),
         VMSTATE_UINT32(int_sts, lan9118_state),
diff --git a/hw/net/lance.c b/hw/net/lance.c
index 4c5f01baad..e1ed24c2ce 100644
--- a/hw/net/lance.c
+++ b/hw/net/lance.c
@@ -94,7 +94,7 @@ static const VMStateDescription vmstate_lance = {
     .name = "pcnet",
     .version_id = 3,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(state, SysBusPCNetState, 0, vmstate_pcnet, PCNetState),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/net/lasi_i82596.c b/hw/net/lasi_i82596.c
index e37f7fabe9..6a3147fe2d 100644
--- a/hw/net/lasi_i82596.c
+++ b/hw/net/lasi_i82596.c
@@ -99,7 +99,7 @@ static const VMStateDescription vmstate_lasi_82596 = {
     .name = "i82596",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(state, SysBusI82596State, 0, vmstate_i82596,
                 I82596State),
         VMSTATE_END_OF_LIST()
diff --git a/hw/net/mipsnet.c b/hw/net/mipsnet.c
index 8e925de867..df5101aed7 100644
--- a/hw/net/mipsnet.c
+++ b/hw/net/mipsnet.c
@@ -218,7 +218,7 @@ static const VMStateDescription vmstate_mipsnet = {
     .name = "mipsnet",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(busy, MIPSnetState),
         VMSTATE_UINT32(rx_count, MIPSnetState),
         VMSTATE_UINT32(rx_read, MIPSnetState),
diff --git a/hw/net/msf2-emac.c b/hw/net/msf2-emac.c
index 145a5e46ab..c1fc10de2a 100644
--- a/hw/net/msf2-emac.c
+++ b/hw/net/msf2-emac.c
@@ -557,7 +557,7 @@ static const VMStateDescription vmstate_msf2_emac = {
     .name = TYPE_MSS_EMAC,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8_ARRAY(mac_addr, MSF2EmacState, ETH_ALEN),
         VMSTATE_UINT32(rx_desc, MSF2EmacState),
         VMSTATE_UINT16_ARRAY(phy_regs, MSF2EmacState, PHY_MAX_REGS),
diff --git a/hw/net/mv88w8618_eth.c b/hw/net/mv88w8618_eth.c
index 2185f1131a..96c65f4d46 100644
--- a/hw/net/mv88w8618_eth.c
+++ b/hw/net/mv88w8618_eth.c
@@ -358,7 +358,7 @@ static const VMStateDescription mv88w8618_eth_vmsd = {
     .name = "mv88w8618_eth",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(smir, mv88w8618_eth_state),
         VMSTATE_UINT32(icr, mv88w8618_eth_state),
         VMSTATE_UINT32(imr, mv88w8618_eth_state),
diff --git a/hw/net/ne2000-isa.c b/hw/net/ne2000-isa.c
index a79f7fad1f..26980e087e 100644
--- a/hw/net/ne2000-isa.c
+++ b/hw/net/ne2000-isa.c
@@ -53,7 +53,7 @@ static const VMStateDescription vmstate_isa_ne2000 = {
     .name = "ne2000",
     .version_id = 2,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(ne2000, ISANE2000State, 0, vmstate_ne2000, NE2000State),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/net/ne2000-pci.c b/hw/net/ne2000-pci.c
index fee93c6ec0..74773069c6 100644
--- a/hw/net/ne2000-pci.c
+++ b/hw/net/ne2000-pci.c
@@ -39,7 +39,7 @@ static const VMStateDescription vmstate_pci_ne2000 = {
     .name = "ne2000",
     .version_id = 3,
     .minimum_version_id = 3,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(dev, PCINE2000State),
         VMSTATE_STRUCT(ne2000, PCINE2000State, 0, vmstate_ne2000, NE2000State),
         VMSTATE_END_OF_LIST()
diff --git a/hw/net/ne2000.c b/hw/net/ne2000.c
index d79c884d50..b482c5f3af 100644
--- a/hw/net/ne2000.c
+++ b/hw/net/ne2000.c
@@ -606,7 +606,7 @@ const VMStateDescription vmstate_ne2000 = {
     .version_id = 2,
     .minimum_version_id = 0,
     .post_load = ne2000_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8_V(rxcr, NE2000State, 2),
         VMSTATE_UINT8(cmd, NE2000State),
         VMSTATE_UINT32(start, NE2000State),
diff --git a/hw/net/npcm7xx_emc.c b/hw/net/npcm7xx_emc.c
index 1d4e8f59f3..d1583b6f9b 100644
--- a/hw/net/npcm7xx_emc.c
+++ b/hw/net/npcm7xx_emc.c
@@ -837,7 +837,7 @@ static const VMStateDescription vmstate_npcm7xx_emc = {
     .name = TYPE_NPCM7XX_EMC,
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(emc_num, NPCM7xxEMCState),
         VMSTATE_UINT32_ARRAY(regs, NPCM7xxEMCState, NPCM7XX_NUM_EMC_REGS),
         VMSTATE_BOOL(tx_active, NPCM7xxEMCState),
diff --git a/hw/net/pcnet-pci.c b/hw/net/pcnet-pci.c
index 96a302c141..fe1a845b2b 100644
--- a/hw/net/pcnet-pci.c
+++ b/hw/net/pcnet-pci.c
@@ -147,7 +147,7 @@ static const VMStateDescription vmstate_pci_pcnet = {
     .name = "pcnet",
     .version_id = 3,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(parent_obj, PCIPCNetState),
         VMSTATE_STRUCT(state, PCIPCNetState, 0, vmstate_pcnet, PCNetState),
         VMSTATE_END_OF_LIST()
diff --git a/hw/net/pcnet.c b/hw/net/pcnet.c
index a7e123e60d..494eab8479 100644
--- a/hw/net/pcnet.c
+++ b/hw/net/pcnet.c
@@ -1682,7 +1682,7 @@ const VMStateDescription vmstate_pcnet = {
     .name = "pcnet",
     .version_id = 3,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT32(rap, PCNetState),
         VMSTATE_INT32(isr, PCNetState),
         VMSTATE_INT32(lnkst, PCNetState),
diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index 4af8c66266..897c86ec41 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -3150,7 +3150,7 @@ static const VMStateDescription vmstate_rtl8139_hotplug_ready ={
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = rtl8139_hotplug_ready_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_END_OF_LIST()
     }
 };
@@ -3173,7 +3173,7 @@ static const VMStateDescription vmstate_rtl8139 = {
     .minimum_version_id = 3,
     .post_load = rtl8139_post_load,
     .pre_save  = rtl8139_pre_save,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(parent_obj, RTL8139State),
         VMSTATE_PARTIAL_BUFFER(phys, RTL8139State, 6),
         VMSTATE_BUFFER(mult, RTL8139State),
@@ -3257,7 +3257,7 @@ static const VMStateDescription vmstate_rtl8139 = {
         VMSTATE_UINT32_V(cplus_enabled, RTL8139State, 4),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription*[]) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_rtl8139_hotplug_ready,
         NULL
     }
diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
index 876a78456a..49b7c26102 100644
--- a/hw/net/smc91c111.c
+++ b/hw/net/smc91c111.c
@@ -62,7 +62,7 @@ static const VMStateDescription vmstate_smc91c111 = {
     .name = "smc91c111",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT16(tcr, smc91c111_state),
         VMSTATE_UINT16(rcr, smc91c111_state),
         VMSTATE_UINT16(cr, smc91c111_state),
diff --git a/hw/net/spapr_llan.c b/hw/net/spapr_llan.c
index 475d5f3a34..ecb30b7c76 100644
--- a/hw/net/spapr_llan.c
+++ b/hw/net/spapr_llan.c
@@ -800,7 +800,7 @@ static const VMStateDescription vmstate_rx_buffer_pool = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = spapr_vlan_rx_buffer_pools_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT32(bufsize, RxBufPool),
         VMSTATE_INT32(count, RxBufPool),
         VMSTATE_UINT64_ARRAY(bds, RxBufPool, RX_POOL_MAX_BDS),
@@ -813,7 +813,7 @@ static const VMStateDescription vmstate_rx_pools = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = spapr_vlan_rx_buffer_pools_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_ARRAY_OF_POINTER_TO_STRUCT(rx_pool, SpaprVioVlan,
                                            RX_MAX_POOLS, 1,
                                            vmstate_rx_buffer_pool, RxBufPool),
@@ -825,7 +825,7 @@ static const VMStateDescription vmstate_spapr_llan = {
     .name = "spapr_llan",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_SPAPR_VIO(sdev, SpaprVioVlan),
         /* LLAN state */
         VMSTATE_BOOL(isopen, SpaprVioVlan),
@@ -837,7 +837,7 @@ static const VMStateDescription vmstate_spapr_llan = {
 
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription * []) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_rx_pools,
         NULL
     }
diff --git a/hw/net/stellaris_enet.c b/hw/net/stellaris_enet.c
index 6768a6912f..db95766e29 100644
--- a/hw/net/stellaris_enet.c
+++ b/hw/net/stellaris_enet.c
@@ -88,7 +88,7 @@ static const VMStateDescription vmstate_rx_frame = {
     .name = "stellaris_enet/rx_frame",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8_ARRAY(data, StellarisEnetRxFrame, 2048),
         VMSTATE_UINT32(len, StellarisEnetRxFrame),
         VMSTATE_END_OF_LIST()
@@ -133,7 +133,7 @@ static const VMStateDescription vmstate_stellaris_enet = {
     .version_id = 2,
     .minimum_version_id = 2,
     .post_load = stellaris_enet_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(ris, stellaris_enet_state),
         VMSTATE_UINT32(im, stellaris_enet_state),
         VMSTATE_UINT32(rctl, stellaris_enet_state),
diff --git a/hw/net/sungem.c b/hw/net/sungem.c
index 013cfc2736..dd1b4a1344 100644
--- a/hw/net/sungem.c
+++ b/hw/net/sungem.c
@@ -1434,7 +1434,7 @@ static const VMStateDescription vmstate_sungem = {
     .name = "sungem",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(pdev, SunGEMState),
         VMSTATE_MACADDR(conf.macaddr, SunGEMState),
         VMSTATE_UINT32(phy_addr, SunGEMState),
diff --git a/hw/net/sunhme.c b/hw/net/sunhme.c
index ddc83a64bd..ae8452e5f9 100644
--- a/hw/net/sunhme.c
+++ b/hw/net/sunhme.c
@@ -925,7 +925,7 @@ static const VMStateDescription vmstate_hme = {
     .name = "sunhme",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(parent_obj, SunHMEState),
         VMSTATE_MACADDR(conf.macaddr, SunHMEState),
         VMSTATE_UINT32_ARRAY(sebregs, SunHMEState, (HME_SEB_REG_SIZE >> 2)),
diff --git a/hw/net/tulip.c b/hw/net/tulip.c
index 962086aae4..6d4fb06dad 100644
--- a/hw/net/tulip.c
+++ b/hw/net/tulip.c
@@ -48,7 +48,7 @@ struct TULIPState {
 
 static const VMStateDescription vmstate_pci_tulip = {
     .name = "tulip",
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(dev, TULIPState),
         VMSTATE_UINT32_ARRAY(csr, TULIPState, 16),
         VMSTATE_UINT32(old_csr9, TULIPState),
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 80c56f0cfc..7a2846fa1c 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3113,7 +3113,7 @@ static int virtio_net_post_load_virtio(VirtIODevice *vdev)
 /* tx_waiting field of a VirtIONetQueue */
 static const VMStateDescription vmstate_virtio_net_queue_tx_waiting = {
     .name = "virtio-net-queue-tx_waiting",
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(tx_waiting, VirtIONetQueue),
         VMSTATE_END_OF_LIST()
    },
@@ -3191,7 +3191,7 @@ static const VMStateDescription vmstate_virtio_net_tx_waiting = {
     .name      = "virtio-net-tx_waiting",
     .pre_load  = virtio_net_tx_waiting_pre_load,
     .pre_save  = virtio_net_tx_waiting_pre_save,
-    .fields    = (VMStateField[]) {
+    .fields    = (const VMStateField[]) {
         VMSTATE_STRUCT_VARRAY_POINTER_UINT16(vqs_1, struct VirtIONetMigTmp,
                                      curr_queue_pairs_1,
                                      vmstate_virtio_net_queue_tx_waiting,
@@ -3228,7 +3228,7 @@ static const VMStateDescription vmstate_virtio_net_has_ufo = {
     .name      = "virtio-net-ufo",
     .post_load = virtio_net_ufo_post_load,
     .pre_save  = virtio_net_ufo_pre_save,
-    .fields    = (VMStateField[]) {
+    .fields    = (const VMStateField[]) {
         VMSTATE_UINT8(has_ufo, struct VirtIONetMigTmp),
         VMSTATE_END_OF_LIST()
     },
@@ -3262,7 +3262,7 @@ static const VMStateDescription vmstate_virtio_net_has_vnet = {
     .name      = "virtio-net-vnet",
     .post_load = virtio_net_vnet_post_load,
     .pre_save  = virtio_net_vnet_pre_save,
-    .fields    = (VMStateField[]) {
+    .fields    = (const VMStateField[]) {
         VMSTATE_UINT32(has_vnet_hdr, struct VirtIONetMigTmp),
         VMSTATE_END_OF_LIST()
     },
@@ -3278,7 +3278,7 @@ static const VMStateDescription vmstate_virtio_net_rss = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = virtio_net_rss_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BOOL(rss_data.enabled, VirtIONet),
         VMSTATE_BOOL(rss_data.redirect, VirtIONet),
         VMSTATE_BOOL(rss_data.populate_hash, VirtIONet),
@@ -3299,7 +3299,7 @@ static const VMStateDescription vmstate_virtio_net_device = {
     .version_id = VIRTIO_NET_VM_VERSION,
     .minimum_version_id = VIRTIO_NET_VM_VERSION,
     .post_load = virtio_net_post_load_device,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8_ARRAY(mac, VirtIONet, ETH_ALEN),
         VMSTATE_STRUCT_POINTER(vqs, VirtIONet,
                                vmstate_virtio_net_queue_tx_waiting,
@@ -3343,8 +3343,8 @@ static const VMStateDescription vmstate_virtio_net_device = {
         VMSTATE_UINT64_TEST(curr_guest_offloads, VirtIONet,
                             has_ctrl_guest_offloads),
         VMSTATE_END_OF_LIST()
-   },
-    .subsections = (const VMStateDescription * []) {
+    },
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_virtio_net_rss,
         NULL
     }
@@ -3871,7 +3871,7 @@ static const VMStateDescription vmstate_virtio_net = {
     .name = "virtio-net",
     .minimum_version_id = VIRTIO_NET_VM_VERSION,
     .version_id = VIRTIO_NET_VM_VERSION,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_VIRTIO_DEVICE,
         VMSTATE_END_OF_LIST()
     },
diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 6fb4102d03..707487c636 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -2307,7 +2307,7 @@ static const VMStateDescription vmxstate_vmxnet3_mcast_list = {
     .minimum_version_id = 1,
     .pre_load = vmxnet3_mcast_list_pre_load,
     .needed = vmxnet3_mc_list_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_VBUFFER_UINT32(mcast_list, VMXNET3State, 0, NULL,
             mcast_list_buff_size),
         VMSTATE_END_OF_LIST()
@@ -2317,7 +2317,7 @@ static const VMStateDescription vmxstate_vmxnet3_mcast_list = {
 static const VMStateDescription vmstate_vmxnet3_ring = {
     .name = "vmxnet3-ring",
     .version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(pa, Vmxnet3Ring),
         VMSTATE_UINT32(size, Vmxnet3Ring),
         VMSTATE_UINT32(cell_size, Vmxnet3Ring),
@@ -2330,7 +2330,7 @@ static const VMStateDescription vmstate_vmxnet3_ring = {
 static const VMStateDescription vmstate_vmxnet3_tx_stats = {
     .name = "vmxnet3-tx-stats",
     .version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(TSOPktsTxOK, struct UPT1_TxStats),
         VMSTATE_UINT64(TSOBytesTxOK, struct UPT1_TxStats),
         VMSTATE_UINT64(ucastPktsTxOK, struct UPT1_TxStats),
@@ -2348,7 +2348,7 @@ static const VMStateDescription vmstate_vmxnet3_tx_stats = {
 static const VMStateDescription vmstate_vmxnet3_txq_descr = {
     .name = "vmxnet3-txq-descr",
     .version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(tx_ring, Vmxnet3TxqDescr, 0, vmstate_vmxnet3_ring,
                        Vmxnet3Ring),
         VMSTATE_STRUCT(comp_ring, Vmxnet3TxqDescr, 0, vmstate_vmxnet3_ring,
@@ -2364,7 +2364,7 @@ static const VMStateDescription vmstate_vmxnet3_txq_descr = {
 static const VMStateDescription vmstate_vmxnet3_rx_stats = {
     .name = "vmxnet3-rx-stats",
     .version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(LROPktsRxOK, struct UPT1_RxStats),
         VMSTATE_UINT64(LROBytesRxOK, struct UPT1_RxStats),
         VMSTATE_UINT64(ucastPktsRxOK, struct UPT1_RxStats),
@@ -2382,7 +2382,7 @@ static const VMStateDescription vmstate_vmxnet3_rx_stats = {
 static const VMStateDescription vmstate_vmxnet3_rxq_descr = {
     .name = "vmxnet3-rxq-descr",
     .version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT_ARRAY(rx_ring, Vmxnet3RxqDescr,
                              VMXNET3_RX_RINGS_PER_QUEUE, 0,
                              vmstate_vmxnet3_ring, Vmxnet3Ring),
@@ -2418,7 +2418,7 @@ static int vmxnet3_post_load(void *opaque, int version_id)
 static const VMStateDescription vmstate_vmxnet3_int_state = {
     .name = "vmxnet3-int-state",
     .version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BOOL(is_masked, Vmxnet3IntState),
         VMSTATE_BOOL(is_pending, Vmxnet3IntState),
         VMSTATE_BOOL(is_asserted, Vmxnet3IntState),
@@ -2432,7 +2432,7 @@ static const VMStateDescription vmstate_vmxnet3 = {
     .minimum_version_id = 1,
     .pre_save = vmxnet3_pre_save,
     .post_load = vmxnet3_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
             VMSTATE_PCI_DEVICE(parent_obj, VMXNET3State),
             VMSTATE_MSIX(parent_obj, VMXNET3State),
             VMSTATE_BOOL(rx_packets_compound, VMXNET3State),
@@ -2468,7 +2468,7 @@ static const VMStateDescription vmstate_vmxnet3 = {
 
             VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription*[]) {
+    .subsections = (const VMStateDescription * const []) {
         &vmxstate_vmxnet3_mcast_list,
         NULL
     }
diff --git a/hw/net/xgmac.c b/hw/net/xgmac.c
index 1f4f277d84..ffe3fc8dbe 100644
--- a/hw/net/xgmac.c
+++ b/hw/net/xgmac.c
@@ -159,7 +159,7 @@ static const VMStateDescription vmstate_rxtx_stats = {
     .name = "xgmac_stats",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(rx_bytes, RxTxStats),
         VMSTATE_UINT64(tx_bytes, RxTxStats),
         VMSTATE_UINT64(rx, RxTxStats),
@@ -173,7 +173,7 @@ static const VMStateDescription vmstate_xgmac = {
     .name = "xgmac",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(stats, XgmacState, 0, vmstate_rxtx_stats, RxTxStats),
         VMSTATE_UINT32_ARRAY(regs, XgmacState, R_MAX),
         VMSTATE_END_OF_LIST()
-- 
2.34.1


