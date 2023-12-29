Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AF78201D7
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:32:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKPm-0007Nj-RD; Fri, 29 Dec 2023 16:29:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKPk-0007Iv-RE
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:29:08 -0500
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKPg-0000Mh-Dh
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:29:08 -0500
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6dbca115636so4323313a34.2
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885343; x=1704490143; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HTmpw0MQad52gS7rP7XqCUxFlfy+t9AtuwDtiqTIOjM=;
 b=vzDuVpB9YheOF9OH0ceSyfCO1eip7H+h30drOznMO5SBvHXNxu5ugSXCp6kPAwAKSC
 lwcj4bdqPRhXSAsyBdkBkabrwNUn3tNCHlWmycDkvoTFv9c7fcv2kI65/Et/p5tp+Y1P
 LfbA3S5Bar9osaJgXC+p3aCh2sec2RZLkHsE6jeeSEwXS2RpjzI8IWNlqpbE7YiSxp6w
 KMES6jFNWZ5jXJs67HO/AcXV3mZEHPtelqgL1ZQb9PixgwkIXHuf87ig8ilKaKTT1wMW
 EljD2w1cEEenUOX+8C/vAGfZ/bdPq3SN3RLQy1s7gWXfZhQlsscgs5cmZRzzc4uOcSkR
 BoiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885343; x=1704490143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HTmpw0MQad52gS7rP7XqCUxFlfy+t9AtuwDtiqTIOjM=;
 b=snt7mqIyHp0hOMW2ZL7leLygIdFm1Z1TxAs+2rcKkfs6x9sJ2osg0nhGz6oHup68HH
 mCI3s/+x5XQhHDM7Ok8XwPOQf8BujtIgxE3opOjoLoEL4zI/WrrqqVU2bidMIyqkR/Ve
 t0kcimwx7UOj5tnnoU7eUrX+JwMQwt5Mkz5WGRqsFcu9ZjcLhfLm7aihZOvGvshFCzkh
 6zwoeQTolP014zvJuzh7H7G+rkdpYG+wDluMOfAKmDM4ZGMgEZvW1P0ooomVyOFWsBRn
 yhSlpm64U6XqgzWPevnJrKGiYypo6idxXQSVMjgisZ2B64HxZuE2GKgZMTmD/jgRjQKg
 fVjw==
X-Gm-Message-State: AOJu0YyC8g12MCJ6WVha3wO6G9u4w9rXDUhdkaOHP/ETaR4Z3WUbMDEo
 hhXBfSCmVdvBg14H0t+4iT5iZJgFfxPkh8OZ4yFrkPWaNPJrNg==
X-Google-Smtp-Source: AGHT+IFhsY1o6PTA6+JSDAZKhptKE5fHJMToKka9rsLwMB4d2rneNz8v3XbJ1pCk+O327T28fWxvqw==
X-Received: by 2002:a05:6870:ac26:b0:203:7dc:6f26 with SMTP id
 kw38-20020a056870ac2600b0020307dc6f26mr14632786oab.63.1703885343207; 
 Fri, 29 Dec 2023 13:29:03 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 bd33-20020a056a0027a100b006d9a96b7d0dsm11285396pfb.208.2023.12.29.13.29.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:29:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 55/71] hw/ssi: Constify VMState
Date: Sat, 30 Dec 2023 08:23:30 +1100
Message-Id: <20231229212346.147149-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x329.google.com
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
Message-Id: <20231221031652.119827-56-richard.henderson@linaro.org>
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


