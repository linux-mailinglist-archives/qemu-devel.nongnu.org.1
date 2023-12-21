Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F6E81AD53
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 04:24:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG9fJ-0000ic-SA; Wed, 20 Dec 2023 22:24:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9f8-0008T0-E7
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:23:55 -0500
Received: from mail-qv1-xf2b.google.com ([2607:f8b0:4864:20::f2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9f5-0008HT-VD
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:23:53 -0500
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-67f83812a32so491036d6.3
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703129031; x=1703733831; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=w0xRQgfIAOqXx/CYoB5Lm4VrIi0aaCvUN3HKdeU/s94=;
 b=yD12RMxPry314JAAXshKCPEtJfBe7QEzkBR6qXuXPtz04VNd6Ea6j+DP5tIdhczKyE
 s1YiwMFB5K9pgtqWcesQ1CD8AcnIOE6gGrWLufomP84zfZC3TlxulM/CyHP+rchBUvL3
 J6olYmG0p9fE8aufBjUN5bjzJ2G5K0nfuQoqeuS2vssrfPNP9CWOJLSkreGQdFdy+a8N
 WbBbeayEz+AKhbeFH6C11B4WLz+y7S0Ng55tTBOEjjAnauISiBs+YCD7GnNVDW5l1GWp
 HGBGVGRqVGi8SOY5oA0pMLV5jDrcGoKa5j1NvxIep5KLhqIrxYHddByJt6R8Gx2TweP1
 RtXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703129031; x=1703733831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w0xRQgfIAOqXx/CYoB5Lm4VrIi0aaCvUN3HKdeU/s94=;
 b=CybTu4Z/bI1B1DJOEE0Mi6+5hF8YS2mqc/FIzZN48Xs5RRhfwUN763zfeB8HYYIZyA
 zvtjBQS0R1d5HYZWSqhXgcKAUbgNTjPEGJtmEIYvE+bMfLS526adgZ4jEQPF7gjIbCqK
 OFaVDP4lY6CJk2MN4vPt3LKfFgv4TsD9lbeLePKYCqHh0DoRv83TLpFsLNYwa3vLQomL
 iSPatMGVOJ2mcldg3ec1RGlDijWMic+ajsvZQ1es8u1igeglrJkWBJebrZM0O5aa1oKA
 Cji9gCw4EOB2D8lSZcnKF8IM1/yrZq7OPIVMXwNpl2hYEEYs59QLDMQotZKrF72Mszyx
 O2Eg==
X-Gm-Message-State: AOJu0YzIJXxC63V9e/3xbMpiT4ILzR/b8l8MExKGBoi4ENv+26rD6KeF
 U1O2hOQyEpKGrT6P2zUi8fOhHR/U1XulQJxNmwL5MNay
X-Google-Smtp-Source: AGHT+IHeOwq4AXPcknMfZ69CL/rybSTsZ6n6l+4S9TaMwaoH7tulUmtsm28QGAocPaM63/hB1eKo6A==
X-Received: by 2002:ad4:470b:0:b0:67a:92ea:4f4a with SMTP id
 qb11-20020ad4470b000000b0067a92ea4f4amr14691815qvb.27.1703129031128; 
 Wed, 20 Dec 2023 19:23:51 -0800 (PST)
Received: from stoup.. ([172.58.139.164]) by smtp.gmail.com with ESMTPSA id
 l16-20020ad44d10000000b0067f7b6318b9sm347257qvl.10.2023.12.20.19.23.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 19:23:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 55/71] hw/ssi: Constify VMState
Date: Thu, 21 Dec 2023 14:16:36 +1100
Message-Id: <20231221031652.119827-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221031652.119827-1-richard.henderson@linaro.org>
References: <20231221031652.119827-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf2b.google.com
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
 hw/ssi/aspeed_smc.c       | 2 +-
 hw/ssi/ibex_spi_host.c    | 2 +-
 hw/ssi/imx_spi.c          | 2 +-
 hw/ssi/mss-spi.c          | 2 +-
 hw/ssi/npcm7xx_fiu.c      | 2 +-
 hw/ssi/npcm_pspi.c        | 2 +-
 hw/ssi/pl022.c            | 2 +-
 hw/ssi/ssi.c              | 2 +-
 hw/ssi/stm32f2xx_spi.c    | 2 +-
 hw/ssi/xilinx_spi.c       | 2 +-
 hw/ssi/xilinx_spips.c     | 6 +++---
 hw/ssi/xlnx-versal-ospi.c | 4 ++--
 12 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 2a4001b774..3c93936fd1 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -1201,7 +1201,7 @@ static const VMStateDescription vmstate_aspeed_smc = {
     .name = "aspeed.smc",
     .version_id = 2,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, AspeedSMCState, ASPEED_SMC_R_MAX),
         VMSTATE_UINT8(snoop_index, AspeedSMCState),
         VMSTATE_UINT8(snoop_dummies, AspeedSMCState),
diff --git a/hw/ssi/ibex_spi_host.c b/hw/ssi/ibex_spi_host.c
index c300ec294d..863b5fd60e 100644
--- a/hw/ssi/ibex_spi_host.c
+++ b/hw/ssi/ibex_spi_host.c
@@ -570,7 +570,7 @@ static const VMStateDescription vmstate_ibex = {
     .name = TYPE_IBEX_SPI_HOST,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, IbexSPIHostState, IBEX_SPI_HOST_MAX_REGS),
         VMSTATE_VARRAY_UINT32(config_opts, IbexSPIHostState,
                               num_cs, 0, vmstate_info_uint32, uint32_t),
diff --git a/hw/ssi/imx_spi.c b/hw/ssi/imx_spi.c
index 189423bb3a..d8a7583ff3 100644
--- a/hw/ssi/imx_spi.c
+++ b/hw/ssi/imx_spi.c
@@ -62,7 +62,7 @@ static const VMStateDescription vmstate_imx_spi = {
     .name = TYPE_IMX_SPI,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_FIFO32(tx_fifo, IMXSPIState),
         VMSTATE_FIFO32(rx_fifo, IMXSPIState),
         VMSTATE_INT16(burst_length, IMXSPIState),
diff --git a/hw/ssi/mss-spi.c b/hw/ssi/mss-spi.c
index b2432c5a13..1d25ba23aa 100644
--- a/hw/ssi/mss-spi.c
+++ b/hw/ssi/mss-spi.c
@@ -390,7 +390,7 @@ static const VMStateDescription vmstate_mss_spi = {
     .name = TYPE_MSS_SPI,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_FIFO32(tx_fifo, MSSSpiState),
         VMSTATE_FIFO32(rx_fifo, MSSSpiState),
         VMSTATE_UINT32_ARRAY(regs, MSSSpiState, R_SPI_MAX),
diff --git a/hw/ssi/npcm7xx_fiu.c b/hw/ssi/npcm7xx_fiu.c
index 4eedb2927e..81dd972ee8 100644
--- a/hw/ssi/npcm7xx_fiu.c
+++ b/hw/ssi/npcm7xx_fiu.c
@@ -534,7 +534,7 @@ static const VMStateDescription vmstate_npcm7xx_fiu = {
     .name = "npcm7xx-fiu",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT32(active_cs, NPCM7xxFIUState),
         VMSTATE_UINT32_ARRAY(regs, NPCM7xxFIUState, NPCM7XX_FIU_NR_REGS),
         VMSTATE_END_OF_LIST(),
diff --git a/hw/ssi/npcm_pspi.c b/hw/ssi/npcm_pspi.c
index 3fb935043a..41a5323530 100644
--- a/hw/ssi/npcm_pspi.c
+++ b/hw/ssi/npcm_pspi.c
@@ -192,7 +192,7 @@ static const VMStateDescription vmstate_npcm_pspi = {
     .name = "npcm-pspi",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT16_ARRAY(regs, NPCMPSPIState, NPCM_PSPI_NR_REGS),
         VMSTATE_END_OF_LIST(),
     },
diff --git a/hw/ssi/pl022.c b/hw/ssi/pl022.c
index 8954ffebb1..b8be8ddf0e 100644
--- a/hw/ssi/pl022.c
+++ b/hw/ssi/pl022.c
@@ -249,7 +249,7 @@ static const VMStateDescription vmstate_pl022 = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = pl022_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(cr0, PL022State),
         VMSTATE_UINT32(cr1, PL022State),
         VMSTATE_UINT32(bitmask, PL022State),
diff --git a/hw/ssi/ssi.c b/hw/ssi/ssi.c
index 1f3e540ab8..3f357e8f16 100644
--- a/hw/ssi/ssi.c
+++ b/hw/ssi/ssi.c
@@ -172,7 +172,7 @@ const VMStateDescription vmstate_ssi_peripheral = {
     .name = "SSISlave",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BOOL(cs, SSIPeripheral),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/ssi/stm32f2xx_spi.c b/hw/ssi/stm32f2xx_spi.c
index cd6e8443db..a37139fe5a 100644
--- a/hw/ssi/stm32f2xx_spi.c
+++ b/hw/ssi/stm32f2xx_spi.c
@@ -174,7 +174,7 @@ static const VMStateDescription vmstate_stm32f2xx_spi = {
     .name = TYPE_STM32F2XX_SPI,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(spi_cr1, STM32F2XXSPIState),
         VMSTATE_UINT32(spi_cr2, STM32F2XXSPIState),
         VMSTATE_UINT32(spi_sr, STM32F2XXSPIState),
diff --git a/hw/ssi/xilinx_spi.c b/hw/ssi/xilinx_spi.c
index d4de2e7aab..2e0687ac90 100644
--- a/hw/ssi/xilinx_spi.c
+++ b/hw/ssi/xilinx_spi.c
@@ -353,7 +353,7 @@ static const VMStateDescription vmstate_xilinx_spi = {
     .name = "xilinx_spi",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_FIFO8(tx_fifo, XilinxSPI),
         VMSTATE_FIFO8(rx_fifo, XilinxSPI),
         VMSTATE_UINT32_ARRAY(regs, XilinxSPI, R_MAX),
diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index 0bdfad7e2e..71952a410d 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -1369,7 +1369,7 @@ static const VMStateDescription vmstate_xilinx_spips = {
     .version_id = 2,
     .minimum_version_id = 2,
     .post_load = xilinx_spips_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_FIFO8(tx_fifo, XilinxSPIPS),
         VMSTATE_FIFO8(rx_fifo, XilinxSPIPS),
         VMSTATE_UINT32_ARRAY(regs, XilinxSPIPS, XLNX_SPIPS_R_MAX),
@@ -1395,7 +1395,7 @@ static const VMStateDescription vmstate_xilinx_qspips = {
     .name = "xilinx_qspips",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(parent_obj, XilinxQSPIPS, 0,
                        vmstate_xilinx_spips, XilinxSPIPS),
         VMSTATE_END_OF_LIST()
@@ -1407,7 +1407,7 @@ static const VMStateDescription vmstate_xlnx_zynqmp_qspips = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = xlnx_zynqmp_qspips_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(parent_obj, XlnxZynqMPQSPIPS, 0,
                        vmstate_xilinx_qspips, XilinxQSPIPS),
         VMSTATE_FIFO8(tx_fifo_g, XlnxZynqMPQSPIPS),
diff --git a/hw/ssi/xlnx-versal-ospi.c b/hw/ssi/xlnx-versal-ospi.c
index 1a61679c2f..c7b95b1f37 100644
--- a/hw/ssi/xlnx-versal-ospi.c
+++ b/hw/ssi/xlnx-versal-ospi.c
@@ -1787,7 +1787,7 @@ static const VMStateDescription vmstate_ind_op = {
     .name = "OSPIIndOp",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(flash_addr, IndOp),
         VMSTATE_UINT32(num_bytes, IndOp),
         VMSTATE_UINT32(done_bytes, IndOp),
@@ -1800,7 +1800,7 @@ static const VMStateDescription vmstate_xlnx_versal_ospi = {
     .name = TYPE_XILINX_VERSAL_OSPI,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_FIFO8(rx_fifo, XlnxVersalOspi),
         VMSTATE_FIFO8(tx_fifo, XlnxVersalOspi),
         VMSTATE_FIFO8(rx_sram, XlnxVersalOspi),
-- 
2.34.1


