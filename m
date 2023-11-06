Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D4C7E1AC7
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:10:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztfv-0004zt-TJ; Mon, 06 Nov 2023 02:05:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztd0-0000bH-8i
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:32 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztce-0001yq-2Z
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:12 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-28120aa1c24so31962a91.0
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 23:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699254126; x=1699858926; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HLo1aQqLa5v3biawjddh47vuKf1vbxNy/IGAeNOMaks=;
 b=ASMbxefARI62vADXqb75rb7A4so354q0w9VG9hoF4ram6TfAR7bh3WMH6X0CYZfqZq
 gUOJI1xej8P0E5urqh3IBwNd6sIVzOWTpPj+By6Ng4iCj9WZbifmRk1rvkoHzUBaPWIC
 V04xDwciBB60Eb5sZoeMvZ6QFgFqTPTHSrwbBjmpFcWVAtsLDRWPfub3UmczR35Bm5b+
 7gF6BwscGjysgCIuzU26uXnbDqpbWNZS8UDD/8g9MbN7tPxyZ9RNotnmawsHC05AFCF0
 tpnHn//d+ogEN31hvZcc0qC7vZ6ITsFmqcuKBCKGmfN3HtNM0dS1cp7AyWlEX8I1ViPL
 fVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699254126; x=1699858926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HLo1aQqLa5v3biawjddh47vuKf1vbxNy/IGAeNOMaks=;
 b=F8iGfi2yDymjz4+HBdIZxd8W3piug1kUsf8SK/KNF/Im7vDUgqJxbDpnClMuWVUSmd
 AhGNxFDHSTta33Wgm8IeNkAopCoq8pNmxz4INwdii9LG4z0L7DWO0i36RoWQrxkOyCN0
 0AeeUlWCk/iUC0uVI9PGboZNu5B8j0NIUJpoDivmQnT1xdWm/29v3ankzVZsS/wJCqOx
 Zq/TTiAyThL+2rXPgV1iL2zGHN1nLlR05pDwmMC2erULX5mlBRXq5CV/2DdCzGQbWmv0
 XJpC+doL3gsJcm1k61CSN0Us2xOMRyteViqZEJD2kZ0JWzlrAJHvqf7FjtHIvVGvBeZK
 RiUA==
X-Gm-Message-State: AOJu0YzsZSRjL8OWk6ZzP5BYQ09wHL6RWvON5jUKZ9H81HvAmcLDLXpG
 mxd/7fYSSW483PVUKuTMvB/g2hK+RSoLzLcneNA=
X-Google-Smtp-Source: AGHT+IGYut+OaP7XS+nothU/uVj7pv6V7SSRpCzDjmpDPC6IHKNItVz+Al8jkOh8sWV7RbnyVCM6aA==
X-Received: by 2002:a17:90a:b387:b0:280:a01a:906a with SMTP id
 e7-20020a17090ab38700b00280a01a906amr14254882pjr.5.1699254125768; 
 Sun, 05 Nov 2023 23:02:05 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 8-20020a17090a194800b0027d88387287sm5319650pjh.51.2023.11.05.23.02.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 23:02:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 41/71] hw/net: Constify VMState
Date: Sun,  5 Nov 2023 22:57:57 -0800
Message-Id: <20231106065827.543129-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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
index fac4405f45..5b921310f1 100644
--- a/hw/net/allwinner-sun8i-emac.c
+++ b/hw/net/allwinner-sun8i-emac.c
@@ -850,7 +850,7 @@ static const VMStateDescription vmstate_aw_emac = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = allwinner_sun8i_emac_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(mii_phy_addr, AwSun8iEmacState),
         VMSTATE_UINT32(mii_cmd, AwSun8iEmacState),
         VMSTATE_UINT32(mii_data, AwSun8iEmacState),
diff --git a/hw/net/allwinner_emac.c b/hw/net/allwinner_emac.c
index 372e5b66da..478f8b171b 100644
--- a/hw/net/allwinner_emac.c
+++ b/hw/net/allwinner_emac.c
@@ -471,7 +471,7 @@ static const VMStateDescription vmstate_mii = {
     .name = "rtl8201cp",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT16(bmcr, RTL8201CPState),
         VMSTATE_UINT16(bmsr, RTL8201CPState),
         VMSTATE_UINT16(anar, RTL8201CPState),
@@ -494,7 +494,7 @@ static const VMStateDescription vmstate_aw_emac = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = aw_emac_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(mii, AwEmacState, 1, vmstate_mii, RTL8201CPState),
         VMSTATE_UINT32(ctl, AwEmacState),
         VMSTATE_UINT32(tx_mode, AwEmacState),
diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 5b989f5b52..7460b13d6c 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -1770,7 +1770,7 @@ static const VMStateDescription vmstate_cadence_gem = {
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
index e93e6c5e19..624f0ab2c8 100644
--- a/hw/net/can/xlnx-zynqmp-can.c
+++ b/hw/net/can/xlnx-zynqmp-can.c
@@ -1114,7 +1114,7 @@ static const VMStateDescription vmstate_can = {
     .name = TYPE_XLNX_ZYNQMP_CAN,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_FIFO32(rx_fifo, XlnxZynqMPCANState),
         VMSTATE_FIFO32(tx_fifo, XlnxZynqMPCANState),
         VMSTATE_FIFO32(txhpb_fifo, XlnxZynqMPCANState),
diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index c6f5fb7dce..177f1da889 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -923,7 +923,7 @@ static const VMStateDescription vmstate_dp8393x = {
     .name = "dp8393x",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField []) {
+    .fields = (const VMStateField []) {
         VMSTATE_UINT16_2DARRAY(cam, dp8393xState, 16, 3),
         VMSTATE_UINT16_ARRAY(regs, dp8393xState, SONIC_REG_COUNT),
         VMSTATE_END_OF_LIST()
diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index 548bcabcbb..eb09518317 100644
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
index c3848797b8..5e746b312d 100644
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
index 94ce9e18ff..08e3875a1c 100644
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
index 702b001be2..d4d8b92a97 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -1118,7 +1118,7 @@ static const VMStateDescription vmstate_ftgmac100 = {
     .name = TYPE_FTGMAC100,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(irq_state, FTGMAC100State),
         VMSTATE_UINT32(isr, FTGMAC100State),
         VMSTATE_UINT32(ier, FTGMAC100State),
@@ -1303,7 +1303,7 @@ static const VMStateDescription vmstate_aspeed_mii = {
     .name = TYPE_ASPEED_MII,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(phycr, FTGMAC100State),
         VMSTATE_UINT32(phydata, FTGMAC100State),
         VMSTATE_END_OF_LIST()
diff --git a/hw/net/i82596.c b/hw/net/i82596.c
index 6defa9d3a1..b0f3fcbd3f 100644
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
index 8ff832acfc..fb17f83c0c 100644
--- a/hw/net/igb.c
+++ b/hw/net/igb.c
@@ -506,7 +506,7 @@ static const VMStateDescription igb_vmstate_tx_ctx = {
     .name = "igb-tx-ctx",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(vlan_macip_lens, struct e1000_adv_tx_context_desc),
         VMSTATE_UINT32(seqnum_seed, struct e1000_adv_tx_context_desc),
         VMSTATE_UINT32(type_tucmd_mlhl, struct e1000_adv_tx_context_desc),
@@ -519,7 +519,7 @@ static const VMStateDescription igb_vmstate_tx = {
     .name = "igb-tx",
     .version_id = 2,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT_ARRAY(ctx, struct igb_tx, 2, 0, igb_vmstate_tx_ctx,
                              struct e1000_adv_tx_context_desc),
         VMSTATE_UINT32(first_cmd_type_len, struct igb_tx),
@@ -534,7 +534,7 @@ static const VMStateDescription igb_vmstate_intr_timer = {
     .name = "igb-intr-timer",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_TIMER_PTR(timer, IGBIntrDelayTimer),
         VMSTATE_BOOL(running, IGBIntrDelayTimer),
         VMSTATE_END_OF_LIST()
@@ -555,7 +555,7 @@ static const VMStateDescription igb_vmstate = {
     .minimum_version_id = 1,
     .pre_save = igb_pre_save,
     .post_load = igb_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(parent_obj, IGBState),
         VMSTATE_MSIX(parent_obj, IGBState),
 
diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index 5d1f1f104c..5235e547bd 100644
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
index e5c4af182d..116c373d49 100644
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
index 2ade72dea0..f7f0501fbc 100644
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
index db3a04deb1..1c24917aa2 100644
--- a/hw/net/msf2-emac.c
+++ b/hw/net/msf2-emac.c
@@ -556,7 +556,7 @@ static const VMStateDescription vmstate_msf2_emac = {
     .name = TYPE_MSS_EMAC,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8_ARRAY(mac_addr, MSF2EmacState, ETH_ALEN),
         VMSTATE_UINT32(rx_desc, MSF2EmacState),
         VMSTATE_UINT16_ARRAY(phy_regs, MSF2EmacState, PHY_MAX_REGS),
diff --git a/hw/net/mv88w8618_eth.c b/hw/net/mv88w8618_eth.c
index ef30b0d4a6..990c3dff58 100644
--- a/hw/net/mv88w8618_eth.c
+++ b/hw/net/mv88w8618_eth.c
@@ -357,7 +357,7 @@ static const VMStateDescription mv88w8618_eth_vmsd = {
     .name = "mv88w8618_eth",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(smir, mv88w8618_eth_state),
         VMSTATE_UINT32(icr, mv88w8618_eth_state),
         VMSTATE_UINT32(imr, mv88w8618_eth_state),
diff --git a/hw/net/ne2000-isa.c b/hw/net/ne2000-isa.c
index 6ced6775ff..f1a730ae14 100644
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
index edc6689d33..e5bbed8fab 100644
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
index 8156f701b0..d7c11e698c 100644
--- a/hw/net/npcm7xx_emc.c
+++ b/hw/net/npcm7xx_emc.c
@@ -836,7 +836,7 @@ static const VMStateDescription vmstate_npcm7xx_emc = {
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
index 02828ae716..0c8b5f44de 100644
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
index 4525fda383..0846d47d23 100644
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
index ddbceda967..d51f673a52 100644
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
index a6876a936d..3a2e8beaf1 100644
--- a/hw/net/spapr_llan.c
+++ b/hw/net/spapr_llan.c
@@ -799,7 +799,7 @@ static const VMStateDescription vmstate_rx_buffer_pool = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = spapr_vlan_rx_buffer_pools_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT32(bufsize, RxBufPool),
         VMSTATE_INT32(count, RxBufPool),
         VMSTATE_UINT64_ARRAY(bds, RxBufPool, RX_POOL_MAX_BDS),
@@ -812,7 +812,7 @@ static const VMStateDescription vmstate_rx_pools = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = spapr_vlan_rx_buffer_pools_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_ARRAY_OF_POINTER_TO_STRUCT(rx_pool, SpaprVioVlan,
                                            RX_MAX_POOLS, 1,
                                            vmstate_rx_buffer_pool, RxBufPool),
@@ -824,7 +824,7 @@ static const VMStateDescription vmstate_spapr_llan = {
     .name = "spapr_llan",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_SPAPR_VIO(sdev, SpaprVioVlan),
         /* LLAN state */
         VMSTATE_BOOL(isopen, SpaprVioVlan),
@@ -836,7 +836,7 @@ static const VMStateDescription vmstate_spapr_llan = {
 
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription * []) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_rx_pools,
         NULL
     }
diff --git a/hw/net/stellaris_enet.c b/hw/net/stellaris_enet.c
index 8dd60783d8..17b18b621f 100644
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
index c2e2c90668..5f2cab6012 100644
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
index 64d4ea5850..a74f887c2e 100644
--- a/hw/net/sunhme.c
+++ b/hw/net/sunhme.c
@@ -924,7 +924,7 @@ static const VMStateDescription vmstate_hme = {
     .name = "sunhme",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(parent_obj, SunHMEState),
         VMSTATE_MACADDR(conf.macaddr, SunHMEState),
         VMSTATE_UINT32_ARRAY(sebregs, SunHMEState, (HME_SEB_REG_SIZE >> 2)),
diff --git a/hw/net/tulip.c b/hw/net/tulip.c
index 11d866e431..de26bc1356 100644
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
index b85c7946a7..c7631e5798 100644
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
@@ -3869,7 +3869,7 @@ static const VMStateDescription vmstate_virtio_net = {
     .name = "virtio-net",
     .minimum_version_id = VIRTIO_NET_VM_VERSION,
     .version_id = VIRTIO_NET_VM_VERSION,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_VIRTIO_DEVICE,
         VMSTATE_END_OF_LIST()
     },
diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 1b48d7743e..5104c84504 100644
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
index 0ab6ae91aa..656ad4a9c3 100644
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


