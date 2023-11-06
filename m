Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D18377E1ADB
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:13:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztdq-0002BT-2U; Mon, 06 Nov 2023 02:03:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztd2-0000jq-7q
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:34 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztcr-00020J-MJ
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:30 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-280260db156so3902369a91.2
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 23:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699254137; x=1699858937; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=banUh+d6b940PszGiSGfVhNqwANhWklXgy9q1SyElF0=;
 b=wb9AjTt+pHER/NYKCEMmK1QX2c7iWpYd423dSsYWpuIgU73xCv6vARi0dF+Rwd1gEE
 Cx0PL8rZDsAEsSClwEgdY+BtUhCDovPV1Zx7phB0O9fru9Eoo9xjXxPzRbshxoNFI9SN
 FsM30TI0uEnm2DeyBbckOTYmqs3V8Ud9MctaLXhT+UY5fowK5dXN1y+pBeR4kEZgV+l5
 0vsrfimPlltpECyfodVQ6o4c6PSaDDhH26JdfptbOwPdKR3Yj7sxw+mWUcRgv5saHxcT
 wF2o6OJXqDCEt9hMvrqmyk/32gFsCQczKJnA1NXfDZDDX7PzLP3JIYKMRbD2NWLL90S4
 PvqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699254137; x=1699858937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=banUh+d6b940PszGiSGfVhNqwANhWklXgy9q1SyElF0=;
 b=Ors+NXd7nDGAKLTA7ay9PF/V1ZRwiaWZjiT9z7Yhx+0P7GOdEVzKCdN9TBF0aPm1b9
 JayhXZ0B6eiv4fC3jc64ffSb29tJK0IOaIdsPpTu1wFn/kprAtbtOd/vIQ+N4GgDsSwL
 MI1Zlfma+r3LzZD7eySuddj8qNDfmtS43Nw+1scV9D5jLtm/pNY5mtzq3+WRZqzwM7ca
 +cRaVtUazW08M+8yNnyHrqK/sn3sF5rbMaXYgrkdH59xaLZL6sAYgX6gaGSoHM9K+qok
 lQXhC6yKrLyAJQ2gYx91mn+PU96LHaZyL+TMc7mgkPgTV3h0w8MZVBtQ8BKhElvhNfEa
 u7eQ==
X-Gm-Message-State: AOJu0Yw5g0V7d6mXDFp+1CZd3LWyuqiuguJA+DsbusAsE5Jw65+iUMoi
 TXO7w91b0ua9NsSKbFHs3zG0EUkTunDnzdw0RzY=
X-Google-Smtp-Source: AGHT+IFRVST3ZBnW2Ch2zvzum/xzPlqTr48X0J/yRNBgkjbpbSsJziga+HJrcObkeWPpaTYEWrTZ3A==
X-Received: by 2002:a17:90a:d814:b0:280:3d2c:2a85 with SMTP id
 a20-20020a17090ad81400b002803d2c2a85mr21448392pjv.4.1699254136839; 
 Sun, 05 Nov 2023 23:02:16 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 8-20020a17090a194800b0027d88387287sm5319650pjh.51.2023.11.05.23.02.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 23:02:16 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 55/71] hw/ssi: Constify VMState
Date: Sun,  5 Nov 2023 22:58:11 -0800
Message-Id: <20231106065827.543129-56-richard.henderson@linaro.org>
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
index 1ee7d88c22..e6dfda865d 100644
--- a/hw/ssi/ibex_spi_host.c
+++ b/hw/ssi/ibex_spi_host.c
@@ -568,7 +568,7 @@ static const VMStateDescription vmstate_ibex = {
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
index a3955c6c50..e77270bddb 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -1367,7 +1367,7 @@ static const VMStateDescription vmstate_xilinx_spips = {
     .version_id = 2,
     .minimum_version_id = 2,
     .post_load = xilinx_spips_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_FIFO8(tx_fifo, XilinxSPIPS),
         VMSTATE_FIFO8(rx_fifo, XilinxSPIPS),
         VMSTATE_UINT32_ARRAY(regs, XilinxSPIPS, XLNX_SPIPS_R_MAX),
@@ -1393,7 +1393,7 @@ static const VMStateDescription vmstate_xilinx_qspips = {
     .name = "xilinx_qspips",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(parent_obj, XilinxQSPIPS, 0,
                        vmstate_xilinx_spips, XilinxSPIPS),
         VMSTATE_END_OF_LIST()
@@ -1405,7 +1405,7 @@ static const VMStateDescription vmstate_xlnx_zynqmp_qspips = {
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


