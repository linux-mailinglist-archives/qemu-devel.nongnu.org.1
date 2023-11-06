Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E747E1AEF
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:14:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzte1-0002lC-7E; Mon, 06 Nov 2023 02:03:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztd0-0000bf-I9
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:32 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztcc-0001yg-Ir
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:13 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6b709048d8eso3440382b3a.2
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 23:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699254125; x=1699858925; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c0NYv5B4ebn7G3elVfK2CGFL9sdUxku38vOi4EUUh9s=;
 b=d0W891t7TlaSpc8DN85i6sXCEUi9UpQCLjMU1eyV/9iz0PSIWoN2+BJSS5hJJXVIAa
 ELtVCLhZsTG/coSMZQCo9kDU+Cn8g9lKR3cE6M2CoH3qnTaqnTb0/i9FBtkS1k5O0snF
 6Qqbqk8Uk/W5u7dZyNjYQ8CHKy/aSKl2KYi2DjGFgDC4+AwEIOcVL3Nl+pPkmf+aydtc
 5OIH3A4ACayjYYaAiD+a5gpMY7jlUqYU7fWZUastLPg1rPKDqrVVsNNeQkhscT709X+C
 7bM2d5zEJONLLHMNoSiFkcR4fyTj69rX+gAdWHp6OlgGMMt7v9b57E7YG9+dKogZWhQk
 bm9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699254125; x=1699858925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c0NYv5B4ebn7G3elVfK2CGFL9sdUxku38vOi4EUUh9s=;
 b=J4MgUiuxC3X2j+jhI+jR4Keoid8ipO5bwzuNkpyL7QvTN3nvK4bbkPuxD2+UJ4ICj4
 CbFODubRRQMNkJ0WDafIb6T8yAP4GwGtdrC3btcyrmepYeSLAd/3YTeBdvRMjiKWrCTE
 z36y20a69PItvdSrY/bzkZsRGB1Dk+gUFEQE4rl8+JBYFO6uTcpYCuZJ2C8SPywHAz05
 +gSSh6JMk9o04ZrbNDOeNdNP1Y3ojYWV/TEhBUaZ/dmjBECqcQ16grMpKh9iUhhPB/ge
 qPDgCiy/7sGplJtUA9E71vB6/lgNInl/qhkIK0KNYsInT7IYH/S2N3BMjdlGPDb6NpX/
 eScQ==
X-Gm-Message-State: AOJu0YyVPyuxJsSIafRjVbmzLA3qqiQNMZFQXplqlprLXz5ru0Ac/Kns
 qmPdw4dYc9rbDMgmSwBlk/0Y+CFWuqkmJK3t+Cc=
X-Google-Smtp-Source: AGHT+IHqgFefGXNVn/XhlM3nBuaanOvVu23EkqYHXebKNTJ9hCr+/0CiO2Ri7L2qro89YgPJZeBkig==
X-Received: by 2002:a05:6a21:7747:b0:180:e777:cfb2 with SMTP id
 bc7-20020a056a21774700b00180e777cfb2mr16817424pzc.36.1699254124796; 
 Sun, 05 Nov 2023 23:02:04 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 8-20020a17090a194800b0027d88387287sm5319650pjh.51.2023.11.05.23.02.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 23:02:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 40/71] hw/misc: Constify VMState
Date: Sun,  5 Nov 2023 22:57:56 -0800
Message-Id: <20231106065827.543129-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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
 hw/misc/a9scu.c                    |  2 +-
 hw/misc/allwinner-a10-ccm.c        |  2 +-
 hw/misc/allwinner-a10-dramc.c      |  2 +-
 hw/misc/allwinner-cpucfg.c         |  2 +-
 hw/misc/allwinner-h3-ccu.c         |  2 +-
 hw/misc/allwinner-h3-dramc.c       |  2 +-
 hw/misc/allwinner-h3-sysctrl.c     |  2 +-
 hw/misc/allwinner-r40-ccu.c        |  2 +-
 hw/misc/allwinner-r40-dramc.c      |  2 +-
 hw/misc/allwinner-sid.c            |  2 +-
 hw/misc/allwinner-sramc.c          |  2 +-
 hw/misc/arm_l2x0.c                 |  2 +-
 hw/misc/arm_sysctl.c               |  2 +-
 hw/misc/armsse-cpu-pwrctrl.c       |  2 +-
 hw/misc/armsse-mhu.c               |  2 +-
 hw/misc/aspeed_hace.c              |  2 +-
 hw/misc/aspeed_i3c.c               |  4 ++--
 hw/misc/aspeed_lpc.c               |  2 +-
 hw/misc/aspeed_sbc.c               |  2 +-
 hw/misc/aspeed_scu.c               |  2 +-
 hw/misc/aspeed_sdmc.c              |  2 +-
 hw/misc/aspeed_xdma.c              |  2 +-
 hw/misc/axp2xx.c                   |  2 +-
 hw/misc/bcm2835_cprman.c           | 10 +++++-----
 hw/misc/bcm2835_mbox.c             |  4 ++--
 hw/misc/bcm2835_mphi.c             |  2 +-
 hw/misc/bcm2835_powermgt.c         |  2 +-
 hw/misc/bcm2835_property.c         |  2 +-
 hw/misc/bcm2835_rng.c              |  2 +-
 hw/misc/bcm2835_thermal.c          |  2 +-
 hw/misc/djmemc.c                   |  2 +-
 hw/misc/eccmemctl.c                |  2 +-
 hw/misc/exynos4210_clk.c           |  2 +-
 hw/misc/exynos4210_pmu.c           |  2 +-
 hw/misc/exynos4210_rng.c           |  2 +-
 hw/misc/imx25_ccm.c                |  2 +-
 hw/misc/imx31_ccm.c                |  2 +-
 hw/misc/imx6_ccm.c                 |  2 +-
 hw/misc/imx6_src.c                 |  2 +-
 hw/misc/imx6ul_ccm.c               |  2 +-
 hw/misc/imx7_ccm.c                 |  4 ++--
 hw/misc/imx7_src.c                 |  2 +-
 hw/misc/imx_rngc.c                 |  2 +-
 hw/misc/iosb.c                     |  2 +-
 hw/misc/iotkit-secctl.c            | 10 +++++-----
 hw/misc/iotkit-sysctl.c            |  8 ++++----
 hw/misc/ivshmem.c                  |  4 ++--
 hw/misc/lasi.c                     |  2 +-
 hw/misc/led.c                      |  2 +-
 hw/misc/mac_via.c                  |  4 ++--
 hw/misc/mips_cmgcr.c               |  2 +-
 hw/misc/mips_cpc.c                 |  2 +-
 hw/misc/mos6522.c                  |  4 ++--
 hw/misc/mps2-fpgaio.c              |  2 +-
 hw/misc/mps2-scc.c                 |  2 +-
 hw/misc/msf2-sysreg.c              |  2 +-
 hw/misc/mst_fpga.c                 |  2 +-
 hw/misc/npcm7xx_clk.c              |  8 ++++----
 hw/misc/npcm7xx_gcr.c              |  2 +-
 hw/misc/npcm7xx_mft.c              |  2 +-
 hw/misc/npcm7xx_pwm.c              |  4 ++--
 hw/misc/npcm7xx_rng.c              |  2 +-
 hw/misc/nrf51_rng.c                |  2 +-
 hw/misc/pca9552.c                  |  2 +-
 hw/misc/pvpanic-pci.c              |  2 +-
 hw/misc/slavio_misc.c              |  2 +-
 hw/misc/stm32f4xx_exti.c           |  2 +-
 hw/misc/stm32f4xx_syscfg.c         |  2 +-
 hw/misc/tz-mpc.c                   |  2 +-
 hw/misc/tz-msc.c                   |  2 +-
 hw/misc/tz-ppc.c                   |  2 +-
 hw/misc/virt_ctrl.c                |  2 +-
 hw/misc/vmcoreinfo.c               |  2 +-
 hw/misc/xlnx-versal-cframe-reg.c   |  6 +++---
 hw/misc/xlnx-versal-cfu.c          |  6 +++---
 hw/misc/xlnx-versal-crl.c          |  2 +-
 hw/misc/xlnx-versal-pmc-iou-slcr.c |  2 +-
 hw/misc/xlnx-versal-trng.c         |  2 +-
 hw/misc/xlnx-versal-xramc.c        |  2 +-
 hw/misc/xlnx-zynqmp-apu-ctrl.c     |  2 +-
 hw/misc/xlnx-zynqmp-crf.c          |  2 +-
 hw/misc/zynq_slcr.c                |  2 +-
 82 files changed, 107 insertions(+), 107 deletions(-)

diff --git a/hw/misc/a9scu.c b/hw/misc/a9scu.c
index a375ebc987..04225dfb78 100644
--- a/hw/misc/a9scu.c
+++ b/hw/misc/a9scu.c
@@ -116,7 +116,7 @@ static const VMStateDescription vmstate_a9_scu = {
     .name = "a9-scu",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(control, A9SCUState),
         VMSTATE_UINT32(status, A9SCUState),
         VMSTATE_END_OF_LIST()
diff --git a/hw/misc/allwinner-a10-ccm.c b/hw/misc/allwinner-a10-ccm.c
index 68146ee340..575b018952 100644
--- a/hw/misc/allwinner-a10-ccm.c
+++ b/hw/misc/allwinner-a10-ccm.c
@@ -193,7 +193,7 @@ static const VMStateDescription allwinner_a10_ccm_vmstate = {
     .name = "allwinner-a10-ccm",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, AwA10ClockCtlState, AW_A10_CCM_REGS_NUM),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/misc/allwinner-a10-dramc.c b/hw/misc/allwinner-a10-dramc.c
index e118b0c2fd..a7c58fa6d0 100644
--- a/hw/misc/allwinner-a10-dramc.c
+++ b/hw/misc/allwinner-a10-dramc.c
@@ -147,7 +147,7 @@ static const VMStateDescription allwinner_a10_dramc_vmstate = {
     .name = "allwinner-a10-dramc",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, AwA10DramControllerState,
                              AW_A10_DRAMC_REGS_NUM),
         VMSTATE_END_OF_LIST()
diff --git a/hw/misc/allwinner-cpucfg.c b/hw/misc/allwinner-cpucfg.c
index bbd33a7dac..31b9780969 100644
--- a/hw/misc/allwinner-cpucfg.c
+++ b/hw/misc/allwinner-cpucfg.c
@@ -250,7 +250,7 @@ static const VMStateDescription allwinner_cpucfg_vmstate = {
     .name = "allwinner-cpucfg",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(gen_ctrl, AwCpuCfgState),
         VMSTATE_UINT32(super_standby, AwCpuCfgState),
         VMSTATE_UINT32(entry_addr, AwCpuCfgState),
diff --git a/hw/misc/allwinner-h3-ccu.c b/hw/misc/allwinner-h3-ccu.c
index 18d1074545..cfc68522d3 100644
--- a/hw/misc/allwinner-h3-ccu.c
+++ b/hw/misc/allwinner-h3-ccu.c
@@ -212,7 +212,7 @@ static const VMStateDescription allwinner_h3_ccu_vmstate = {
     .name = "allwinner-h3-ccu",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, AwH3ClockCtlState, AW_H3_CCU_REGS_NUM),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/misc/allwinner-h3-dramc.c b/hw/misc/allwinner-h3-dramc.c
index 1d37cf422c..e168ffe623 100644
--- a/hw/misc/allwinner-h3-dramc.c
+++ b/hw/misc/allwinner-h3-dramc.c
@@ -324,7 +324,7 @@ static const VMStateDescription allwinner_h3_dramc_vmstate = {
     .name = "allwinner-h3-dramc",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(dramcom, AwH3DramCtlState, AW_H3_DRAMCOM_REGS_NUM),
         VMSTATE_UINT32_ARRAY(dramctl, AwH3DramCtlState, AW_H3_DRAMCTL_REGS_NUM),
         VMSTATE_UINT32_ARRAY(dramphy, AwH3DramCtlState, AW_H3_DRAMPHY_REGS_NUM),
diff --git a/hw/misc/allwinner-h3-sysctrl.c b/hw/misc/allwinner-h3-sysctrl.c
index 1d07efa880..2d29be83e3 100644
--- a/hw/misc/allwinner-h3-sysctrl.c
+++ b/hw/misc/allwinner-h3-sysctrl.c
@@ -110,7 +110,7 @@ static const VMStateDescription allwinner_h3_sysctrl_vmstate = {
     .name = "allwinner-h3-sysctrl",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, AwH3SysCtrlState, AW_H3_SYSCTRL_REGS_NUM),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/misc/allwinner-r40-ccu.c b/hw/misc/allwinner-r40-ccu.c
index d82fee12db..33baf4429d 100644
--- a/hw/misc/allwinner-r40-ccu.c
+++ b/hw/misc/allwinner-r40-ccu.c
@@ -179,7 +179,7 @@ static const VMStateDescription allwinner_r40_ccu_vmstate = {
     .name = "allwinner-r40-ccu",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, AwR40ClockCtlState, AW_R40_CCU_REGS_NUM),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/misc/allwinner-r40-dramc.c b/hw/misc/allwinner-r40-dramc.c
index 3d81ddb2e1..75b0bef4fd 100644
--- a/hw/misc/allwinner-r40-dramc.c
+++ b/hw/misc/allwinner-r40-dramc.c
@@ -474,7 +474,7 @@ static const VMStateDescription allwinner_r40_dramc_vmstate = {
     .name = "allwinner-r40-dramc",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(dramcom, AwR40DramCtlState,
                              AW_R40_DRAMCOM_REGS_NUM),
         VMSTATE_UINT32_ARRAY(dramctl, AwR40DramCtlState,
diff --git a/hw/misc/allwinner-sid.c b/hw/misc/allwinner-sid.c
index 6d61f55b1d..e5cd431743 100644
--- a/hw/misc/allwinner-sid.c
+++ b/hw/misc/allwinner-sid.c
@@ -136,7 +136,7 @@ static const VMStateDescription allwinner_sid_vmstate = {
     .name = "allwinner-sid",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(control, AwSidState),
         VMSTATE_UINT32(rdkey, AwSidState),
         VMSTATE_UINT8_ARRAY_V(identifier.data, AwSidState, sizeof(QemuUUID), 1),
diff --git a/hw/misc/allwinner-sramc.c b/hw/misc/allwinner-sramc.c
index d76c24d081..cf10ca8ffe 100644
--- a/hw/misc/allwinner-sramc.c
+++ b/hw/misc/allwinner-sramc.c
@@ -116,7 +116,7 @@ static const VMStateDescription allwinner_sramc_vmstate = {
     .name = "allwinner-sramc",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(sram_ver, AwSRAMCState),
         VMSTATE_UINT32(sram_soft_entry_reg0, AwSRAMCState),
         VMSTATE_END_OF_LIST()
diff --git a/hw/misc/arm_l2x0.c b/hw/misc/arm_l2x0.c
index 75c3eb8982..b14d0a2676 100644
--- a/hw/misc/arm_l2x0.c
+++ b/hw/misc/arm_l2x0.c
@@ -49,7 +49,7 @@ static const VMStateDescription vmstate_l2x0 = {
     .name = "l2x0",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(ctrl, L2x0State),
         VMSTATE_UINT32(aux_ctrl, L2x0State),
         VMSTATE_UINT32(data_ctrl, L2x0State),
diff --git a/hw/misc/arm_sysctl.c b/hw/misc/arm_sysctl.c
index 3e4f4b0524..5108f3eda9 100644
--- a/hw/misc/arm_sysctl.c
+++ b/hw/misc/arm_sysctl.c
@@ -57,7 +57,7 @@ static const VMStateDescription vmstate_arm_sysctl = {
     .name = "realview_sysctl",
     .version_id = 4,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(leds, arm_sysctl_state),
         VMSTATE_UINT16(lockval, arm_sysctl_state),
         VMSTATE_UINT32(cfgdata1, arm_sysctl_state),
diff --git a/hw/misc/armsse-cpu-pwrctrl.c b/hw/misc/armsse-cpu-pwrctrl.c
index 42fc38879f..bfc51d175c 100644
--- a/hw/misc/armsse-cpu-pwrctrl.c
+++ b/hw/misc/armsse-cpu-pwrctrl.c
@@ -109,7 +109,7 @@ static const VMStateDescription pwrctrl_vmstate = {
     .name = "armsse-cpu-pwrctrl",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(cpupwrcfg, ARMSSECPUPwrCtrl),
         VMSTATE_END_OF_LIST()
     },
diff --git a/hw/misc/armsse-mhu.c b/hw/misc/armsse-mhu.c
index 0be7f0fc87..55625b2cca 100644
--- a/hw/misc/armsse-mhu.c
+++ b/hw/misc/armsse-mhu.c
@@ -157,7 +157,7 @@ static const VMStateDescription armsse_mhu_vmstate = {
     .name = "armsse-mhu",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(cpu0intr, ARMSSEMHU),
         VMSTATE_UINT32(cpu1intr, ARMSSEMHU),
         VMSTATE_END_OF_LIST()
diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c
index b07506ec04..c06c04ddc6 100644
--- a/hw/misc/aspeed_hace.c
+++ b/hw/misc/aspeed_hace.c
@@ -433,7 +433,7 @@ static const VMStateDescription vmstate_aspeed_hace = {
     .name = TYPE_ASPEED_HACE,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, AspeedHACEState, ASPEED_HACE_NR_REGS),
         VMSTATE_UINT32(total_req_len, AspeedHACEState),
         VMSTATE_UINT32(iov_count, AspeedHACEState),
diff --git a/hw/misc/aspeed_i3c.c b/hw/misc/aspeed_i3c.c
index d1ff617671..827c9e522d 100644
--- a/hw/misc/aspeed_i3c.c
+++ b/hw/misc/aspeed_i3c.c
@@ -168,7 +168,7 @@ static const VMStateDescription aspeed_i3c_device_vmstate = {
     .name = TYPE_ASPEED_I3C,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]){
+    .fields = (const VMStateField[]){
         VMSTATE_UINT32_ARRAY(regs, AspeedI3CDevice, ASPEED_I3C_DEVICE_NR_REGS),
         VMSTATE_END_OF_LIST(),
     }
@@ -349,7 +349,7 @@ static const VMStateDescription vmstate_aspeed_i3c = {
     .name = TYPE_ASPEED_I3C,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, AspeedI3CState, ASPEED_I3C_NR_REGS),
         VMSTATE_STRUCT_ARRAY(devices, AspeedI3CState, ASPEED_I3C_NR_DEVICES, 1,
                              aspeed_i3c_device_vmstate, AspeedI3CDevice),
diff --git a/hw/misc/aspeed_lpc.c b/hw/misc/aspeed_lpc.c
index 2dddb27c35..193f0dea59 100644
--- a/hw/misc/aspeed_lpc.c
+++ b/hw/misc/aspeed_lpc.c
@@ -447,7 +447,7 @@ static const VMStateDescription vmstate_aspeed_lpc = {
     .name = TYPE_ASPEED_LPC,
     .version_id = 2,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, AspeedLPCState, ASPEED_LPC_NR_REGS),
         VMSTATE_UINT32(subdevice_irqs_pending, AspeedLPCState),
         VMSTATE_END_OF_LIST(),
diff --git a/hw/misc/aspeed_sbc.c b/hw/misc/aspeed_sbc.c
index c6f328e3be..8bb1f90e4e 100644
--- a/hw/misc/aspeed_sbc.c
+++ b/hw/misc/aspeed_sbc.c
@@ -130,7 +130,7 @@ static const VMStateDescription vmstate_aspeed_sbc = {
     .name = TYPE_ASPEED_SBC,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, AspeedSBCState, ASPEED_SBC_NR_REGS),
         VMSTATE_END_OF_LIST(),
     }
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index 8335364906..1ac04b6cb0 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -531,7 +531,7 @@ static const VMStateDescription vmstate_aspeed_scu = {
     .name = "aspeed.scu",
     .version_id = 2,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, AspeedSCUState, ASPEED_AST2600_SCU_NR_REGS),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index abb2727933..64cd1a81dc 100644
--- a/hw/misc/aspeed_sdmc.c
+++ b/hw/misc/aspeed_sdmc.c
@@ -243,7 +243,7 @@ static const VMStateDescription vmstate_aspeed_sdmc = {
     .name = "aspeed.sdmc",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, AspeedSDMCState, ASPEED_SDMC_NR_REGS),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/misc/aspeed_xdma.c b/hw/misc/aspeed_xdma.c
index 1c21577c98..76ab8467dd 100644
--- a/hw/misc/aspeed_xdma.c
+++ b/hw/misc/aspeed_xdma.c
@@ -144,7 +144,7 @@ static void aspeed_xdma_reset(DeviceState *dev)
 static const VMStateDescription aspeed_xdma_vmstate = {
     .name = TYPE_ASPEED_XDMA,
     .version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, AspeedXDMAState, ASPEED_XDMA_NUM_REGS),
         VMSTATE_END_OF_LIST(),
     },
diff --git a/hw/misc/axp2xx.c b/hw/misc/axp2xx.c
index 41538c1cd7..af646878cd 100644
--- a/hw/misc/axp2xx.c
+++ b/hw/misc/axp2xx.c
@@ -217,7 +217,7 @@ static int axp2xx_tx(I2CSlave *i2c, uint8_t data)
 static const VMStateDescription vmstate_axp2xx = {
     .name = TYPE_AXP2XX,
     .version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8_ARRAY(regs, AXP2xxI2CState, NR_REGS),
         VMSTATE_UINT8(ptr, AXP2xxI2CState),
         VMSTATE_UINT8(count, AXP2xxI2CState),
diff --git a/hw/misc/bcm2835_cprman.c b/hw/misc/bcm2835_cprman.c
index 75e6c574d4..91c8f7bd17 100644
--- a/hw/misc/bcm2835_cprman.c
+++ b/hw/misc/bcm2835_cprman.c
@@ -125,7 +125,7 @@ static const VMStateDescription pll_vmstate = {
     .name = TYPE_CPRMAN_PLL,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_CLOCK(xosc_in, CprmanPllState),
         VMSTATE_END_OF_LIST()
     }
@@ -229,7 +229,7 @@ static const VMStateDescription pll_channel_vmstate = {
     .name = TYPE_CPRMAN_PLL_CHANNEL,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_CLOCK(pll_in, CprmanPllChannelState),
         VMSTATE_END_OF_LIST()
     }
@@ -349,7 +349,7 @@ static const VMStateDescription clock_mux_vmstate = {
     .name = TYPE_CPRMAN_CLOCK_MUX,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_ARRAY_CLOCK(srcs, CprmanClockMuxState,
                             CPRMAN_NUM_CLOCK_MUX_SRC),
         VMSTATE_END_OF_LIST()
@@ -404,7 +404,7 @@ static const VMStateDescription dsi0hsck_mux_vmstate = {
     .name = TYPE_CPRMAN_DSI0HSCK_MUX,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_CLOCK(plla_in, CprmanDsi0HsckMuxState),
         VMSTATE_CLOCK(plld_in, CprmanDsi0HsckMuxState),
         VMSTATE_END_OF_LIST()
@@ -772,7 +772,7 @@ static const VMStateDescription cprman_vmstate = {
     .name = TYPE_BCM2835_CPRMAN,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, BCM2835CprmanState, CPRMAN_NUM_REGS),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/misc/bcm2835_mbox.c b/hw/misc/bcm2835_mbox.c
index 1e4e061bc1..67bfc3bd71 100644
--- a/hw/misc/bcm2835_mbox.c
+++ b/hw/misc/bcm2835_mbox.c
@@ -257,7 +257,7 @@ static const VMStateDescription vmstate_bcm2835_mbox_box = {
     .name = TYPE_BCM2835_MBOX "_box",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(reg, BCM2835Mbox, MBOX_SIZE),
         VMSTATE_UINT32(count, BCM2835Mbox),
         VMSTATE_UINT32(status, BCM2835Mbox),
@@ -271,7 +271,7 @@ static const VMStateDescription vmstate_bcm2835_mbox = {
     .name = TYPE_BCM2835_MBOX,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields      = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BOOL_ARRAY(available, BCM2835MboxState, MBOX_CHAN_COUNT),
         VMSTATE_STRUCT_ARRAY(mbox, BCM2835MboxState, 2, 1,
                              vmstate_bcm2835_mbox_box, BCM2835Mbox),
diff --git a/hw/misc/bcm2835_mphi.c b/hw/misc/bcm2835_mphi.c
index 0428e10ba5..f1eeda2786 100644
--- a/hw/misc/bcm2835_mphi.c
+++ b/hw/misc/bcm2835_mphi.c
@@ -156,7 +156,7 @@ const VMStateDescription vmstate_mphi_state = {
     .name = "mphi",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(outdda, BCM2835MphiState),
         VMSTATE_UINT32(outddb, BCM2835MphiState),
         VMSTATE_UINT32(ctrl, BCM2835MphiState),
diff --git a/hw/misc/bcm2835_powermgt.c b/hw/misc/bcm2835_powermgt.c
index 976f3d34e5..1649da8668 100644
--- a/hw/misc/bcm2835_powermgt.c
+++ b/hw/misc/bcm2835_powermgt.c
@@ -109,7 +109,7 @@ static const VMStateDescription vmstate_bcm2835_powermgt = {
     .name = TYPE_BCM2835_POWERMGT,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(rstc, BCM2835PowerMgtState),
         VMSTATE_UINT32(rsts, BCM2835PowerMgtState),
         VMSTATE_UINT32(wdog, BCM2835PowerMgtState),
diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
index ff55a4e2cd..5c48f8d743 100644
--- a/hw/misc/bcm2835_property.c
+++ b/hw/misc/bcm2835_property.c
@@ -384,7 +384,7 @@ static const VMStateDescription vmstate_bcm2835_property = {
     .name = TYPE_BCM2835_PROPERTY,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields      = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_MACADDR(macaddr, BCM2835PropertyState),
         VMSTATE_UINT32(addr, BCM2835PropertyState),
         VMSTATE_BOOL(pending, BCM2835PropertyState),
diff --git a/hw/misc/bcm2835_rng.c b/hw/misc/bcm2835_rng.c
index b3c80cf186..10e741b11d 100644
--- a/hw/misc/bcm2835_rng.c
+++ b/hw/misc/bcm2835_rng.c
@@ -99,7 +99,7 @@ static const VMStateDescription vmstate_bcm2835_rng = {
     .name = TYPE_BCM2835_RNG,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(rng_ctrl, BCM2835RngState),
         VMSTATE_UINT32(rng_status, BCM2835RngState),
         VMSTATE_END_OF_LIST()
diff --git a/hw/misc/bcm2835_thermal.c b/hw/misc/bcm2835_thermal.c
index c6f3b1ad60..ee7816b8a5 100644
--- a/hw/misc/bcm2835_thermal.c
+++ b/hw/misc/bcm2835_thermal.c
@@ -105,7 +105,7 @@ static const VMStateDescription bcm2835_thermal_vmstate = {
     .name = "bcm2835_thermal",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(ctl, Bcm2835ThermalState),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/misc/djmemc.c b/hw/misc/djmemc.c
index fd02640838..9b69656c3a 100644
--- a/hw/misc/djmemc.c
+++ b/hw/misc/djmemc.c
@@ -107,7 +107,7 @@ static const VMStateDescription vmstate_djmemc = {
     .name = "djMEMC",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, DJMEMCState, DJMEMC_NUM_REGS),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/misc/eccmemctl.c b/hw/misc/eccmemctl.c
index c65806e3d9..5a14a48999 100644
--- a/hw/misc/eccmemctl.c
+++ b/hw/misc/eccmemctl.c
@@ -272,7 +272,7 @@ static const VMStateDescription vmstate_ecc = {
     .name ="ECC",
     .version_id = 3,
     .minimum_version_id = 3,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, ECCState, ECC_NREGS),
         VMSTATE_BUFFER(diag, ECCState),
         VMSTATE_UINT32(version, ECCState),
diff --git a/hw/misc/exynos4210_clk.c b/hw/misc/exynos4210_clk.c
index 58cec282f7..4566a426fa 100644
--- a/hw/misc/exynos4210_clk.c
+++ b/hw/misc/exynos4210_clk.c
@@ -135,7 +135,7 @@ static const VMStateDescription exynos4210_clk_vmstate = {
     .name = TYPE_EXYNOS4210_CLK,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(reg, Exynos4210ClkState, EXYNOS4210_REGS_NUM),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/misc/exynos4210_pmu.c b/hw/misc/exynos4210_pmu.c
index e24139c630..7e28e790d7 100644
--- a/hw/misc/exynos4210_pmu.c
+++ b/hw/misc/exynos4210_pmu.c
@@ -492,7 +492,7 @@ static const VMStateDescription exynos4210_pmu_vmstate = {
     .name = "exynos4210.pmu",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(reg, Exynos4210PmuState, PMU_NUM_OF_REGISTERS),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/misc/exynos4210_rng.c b/hw/misc/exynos4210_rng.c
index 9214ec14cc..0756bd3205 100644
--- a/hw/misc/exynos4210_rng.c
+++ b/hw/misc/exynos4210_rng.c
@@ -243,7 +243,7 @@ static const VMStateDescription exynos4210_rng_vmstate = {
     .name = TYPE_EXYNOS4210_RNG,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT32_ARRAY(randr_value, Exynos4210RngState,
                             EXYNOS4210_RNG_PRNG_NUM),
         VMSTATE_UINT32(seed_set, Exynos4210RngState),
diff --git a/hw/misc/imx25_ccm.c b/hw/misc/imx25_ccm.c
index ff996e2f2c..d888966014 100644
--- a/hw/misc/imx25_ccm.c
+++ b/hw/misc/imx25_ccm.c
@@ -101,7 +101,7 @@ static const VMStateDescription vmstate_imx25_ccm = {
     .name = TYPE_IMX25_CCM,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(reg, IMX25CCMState, IMX25_CCM_MAX_REG),
         VMSTATE_END_OF_LIST()
     },
diff --git a/hw/misc/imx31_ccm.c b/hw/misc/imx31_ccm.c
index ad30a4b2c0..a9059bb1f7 100644
--- a/hw/misc/imx31_ccm.c
+++ b/hw/misc/imx31_ccm.c
@@ -98,7 +98,7 @@ static const VMStateDescription vmstate_imx31_ccm = {
     .name = TYPE_IMX31_CCM,
     .version_id = 2,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(reg, IMX31CCMState, IMX31_CCM_MAX_REG),
         VMSTATE_END_OF_LIST()
     },
diff --git a/hw/misc/imx6_ccm.c b/hw/misc/imx6_ccm.c
index 85af466c2b..56489d8b57 100644
--- a/hw/misc/imx6_ccm.c
+++ b/hw/misc/imx6_ccm.c
@@ -235,7 +235,7 @@ static const VMStateDescription vmstate_imx6_ccm = {
     .name = TYPE_IMX6_CCM,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(ccm, IMX6CCMState, CCM_MAX),
         VMSTATE_UINT32_ARRAY(analog, IMX6CCMState, CCM_ANALOG_MAX),
         VMSTATE_END_OF_LIST()
diff --git a/hw/misc/imx6_src.c b/hw/misc/imx6_src.c
index a9c64d06eb..d20727e20b 100644
--- a/hw/misc/imx6_src.c
+++ b/hw/misc/imx6_src.c
@@ -77,7 +77,7 @@ static const VMStateDescription vmstate_imx6_src = {
     .name = TYPE_IMX6_SRC,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, IMX6SRCState, SRC_MAX),
         VMSTATE_END_OF_LIST()
     },
diff --git a/hw/misc/imx6ul_ccm.c b/hw/misc/imx6ul_ccm.c
index e01bb68ac7..bbc0be9921 100644
--- a/hw/misc/imx6ul_ccm.c
+++ b/hw/misc/imx6ul_ccm.c
@@ -285,7 +285,7 @@ static const VMStateDescription vmstate_imx6ul_ccm = {
     .name = TYPE_IMX6UL_CCM,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(ccm, IMX6ULCCMState, CCM_MAX),
         VMSTATE_UINT32_ARRAY(analog, IMX6ULCCMState, CCM_ANALOG_MAX),
         VMSTATE_END_OF_LIST()
diff --git a/hw/misc/imx7_ccm.c b/hw/misc/imx7_ccm.c
index 7539f7fb45..88354f020e 100644
--- a/hw/misc/imx7_ccm.c
+++ b/hw/misc/imx7_ccm.c
@@ -214,7 +214,7 @@ static const VMStateDescription vmstate_imx7_ccm = {
     .name = TYPE_IMX7_CCM,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(ccm, IMX7CCMState, CCM_MAX),
         VMSTATE_END_OF_LIST()
     },
@@ -286,7 +286,7 @@ static const VMStateDescription vmstate_imx7_analog = {
     .name = TYPE_IMX7_ANALOG,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(analog, IMX7AnalogState, ANALOG_MAX),
         VMSTATE_UINT32_ARRAY(pmu,    IMX7AnalogState, PMU_MAX),
         VMSTATE_END_OF_LIST()
diff --git a/hw/misc/imx7_src.c b/hw/misc/imx7_src.c
index 983251e86f..24a0b4618c 100644
--- a/hw/misc/imx7_src.c
+++ b/hw/misc/imx7_src.c
@@ -84,7 +84,7 @@ static const VMStateDescription vmstate_imx7_src = {
     .name = TYPE_IMX7_SRC,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, IMX7SRCState, SRC_MAX),
         VMSTATE_END_OF_LIST()
     },
diff --git a/hw/misc/imx_rngc.c b/hw/misc/imx_rngc.c
index 082c6980ad..ab7775e095 100644
--- a/hw/misc/imx_rngc.c
+++ b/hw/misc/imx_rngc.c
@@ -245,7 +245,7 @@ static const VMStateDescription vmstate_imx_rngc = {
     .name = RNGC_NAME,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(op_self_test, IMXRNGCState),
         VMSTATE_UINT8(op_seed, IMXRNGCState),
         VMSTATE_UINT8(mask, IMXRNGCState),
diff --git a/hw/misc/iosb.c b/hw/misc/iosb.c
index e7e9dcca47..e20305e801 100644
--- a/hw/misc/iosb.c
+++ b/hw/misc/iosb.c
@@ -105,7 +105,7 @@ static const VMStateDescription vmstate_iosb = {
     .name = "IOSB",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, IOSBState, IOSB_REGS),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/misc/iotkit-secctl.c b/hw/misc/iotkit-secctl.c
index b5a9e30a2c..f9c45f60bf 100644
--- a/hw/misc/iotkit-secctl.c
+++ b/hw/misc/iotkit-secctl.c
@@ -753,7 +753,7 @@ static const VMStateDescription iotkit_secctl_ppc_vmstate = {
     .name = "iotkit-secctl-ppc",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(ns, IoTKitSecCtlPPC),
         VMSTATE_UINT32(sp, IoTKitSecCtlPPC),
         VMSTATE_UINT32(nsp, IoTKitSecCtlPPC),
@@ -765,7 +765,7 @@ static const VMStateDescription iotkit_secctl_mpcintstatus_vmstate = {
     .name = "iotkit-secctl-mpcintstatus",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(mpcintstatus, IoTKitSecCtl),
         VMSTATE_END_OF_LIST()
     }
@@ -781,7 +781,7 @@ static const VMStateDescription iotkit_secctl_msc_vmstate = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = needed_always,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(secmscintstat, IoTKitSecCtl),
         VMSTATE_UINT32(secmscinten, IoTKitSecCtl),
         VMSTATE_UINT32(nsmscexp, IoTKitSecCtl),
@@ -793,7 +793,7 @@ static const VMStateDescription iotkit_secctl_vmstate = {
     .name = "iotkit-secctl",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(secppcintstat, IoTKitSecCtl),
         VMSTATE_UINT32(secppcinten, IoTKitSecCtl),
         VMSTATE_UINT32(secrespcfg, IoTKitSecCtl),
@@ -807,7 +807,7 @@ static const VMStateDescription iotkit_secctl_vmstate = {
                              iotkit_secctl_ppc_vmstate, IoTKitSecCtlPPC),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription*[]) {
+    .subsections = (const VMStateDescription * const []) {
         &iotkit_secctl_mpcintstatus_vmstate,
         &iotkit_secctl_msc_vmstate,
         NULL
diff --git a/hw/misc/iotkit-sysctl.c b/hw/misc/iotkit-sysctl.c
index e664215ee6..45393e84ba 100644
--- a/hw/misc/iotkit-sysctl.c
+++ b/hw/misc/iotkit-sysctl.c
@@ -777,7 +777,7 @@ static const VMStateDescription iotkit_sysctl_sse300_vmstate = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = sse300_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(pwrctrl, IoTKitSysCtl),
         VMSTATE_UINT32(pdcm_pd_cpu0_sense, IoTKitSysCtl),
         VMSTATE_UINT32(pdcm_pd_vmr0_sense, IoTKitSysCtl),
@@ -798,7 +798,7 @@ static const VMStateDescription iotkit_sysctl_sse200_vmstate = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = sse200_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(scsecctrl, IoTKitSysCtl),
         VMSTATE_UINT32(fclk_div, IoTKitSysCtl),
         VMSTATE_UINT32(sysclk_div, IoTKitSysCtl),
@@ -818,7 +818,7 @@ static const VMStateDescription iotkit_sysctl_vmstate = {
     .name = "iotkit-sysctl",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(secure_debug, IoTKitSysCtl),
         VMSTATE_UINT32(reset_syndrome, IoTKitSysCtl),
         VMSTATE_UINT32(reset_mask, IoTKitSysCtl),
@@ -828,7 +828,7 @@ static const VMStateDescription iotkit_sysctl_vmstate = {
         VMSTATE_UINT32(wicctrl, IoTKitSysCtl),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription*[]) {
+    .subsections = (const VMStateDescription * const []) {
         &iotkit_sysctl_sse200_vmstate,
         &iotkit_sysctl_sse300_vmstate,
         NULL
diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index 0447888029..62af75e862 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -1015,7 +1015,7 @@ static const VMStateDescription ivshmem_plain_vmsd = {
     .minimum_version_id = 0,
     .pre_load = ivshmem_pre_load,
     .post_load = ivshmem_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(parent_obj, IVShmemState),
         VMSTATE_UINT32(intrstatus, IVShmemState),
         VMSTATE_UINT32(intrmask, IVShmemState),
@@ -1069,7 +1069,7 @@ static const VMStateDescription ivshmem_doorbell_vmsd = {
     .minimum_version_id = 0,
     .pre_load = ivshmem_pre_load,
     .post_load = ivshmem_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(parent_obj, IVShmemState),
         VMSTATE_MSIX(parent_obj, IVShmemState),
         VMSTATE_UINT32(intrstatus, IVShmemState),
diff --git a/hw/misc/lasi.c b/hw/misc/lasi.c
index ff9dc893ae..003f5b5ed8 100644
--- a/hw/misc/lasi.c
+++ b/hw/misc/lasi.c
@@ -196,7 +196,7 @@ static const VMStateDescription vmstate_lasi = {
     .name = "Lasi",
     .version_id = 2,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(irr, LasiState),
         VMSTATE_UINT32(imr, LasiState),
         VMSTATE_UINT32(ipr, LasiState),
diff --git a/hw/misc/led.c b/hw/misc/led.c
index 42bb43a39a..d9998ab895 100644
--- a/hw/misc/led.c
+++ b/hw/misc/led.c
@@ -77,7 +77,7 @@ static const VMStateDescription vmstate_led = {
     .name = TYPE_LED,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(intensity_percent, LEDState),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index b6206ef73c..db6142b5f4 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -1292,7 +1292,7 @@ static const VMStateDescription vmstate_q800_via1 = {
     .version_id = 0,
     .minimum_version_id = 0,
     .post_load = via1_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(parent_obj, MOS6522Q800VIA1State, 0, vmstate_mos6522,
                        MOS6522State),
         VMSTATE_UINT8(last_b, MOS6522Q800VIA1State),
@@ -1411,7 +1411,7 @@ static const VMStateDescription vmstate_q800_via2 = {
     .name = "q800-via2",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(parent_obj, MOS6522Q800VIA2State, 0, vmstate_mos6522,
                        MOS6522State),
         VMSTATE_END_OF_LIST()
diff --git a/hw/misc/mips_cmgcr.c b/hw/misc/mips_cmgcr.c
index 66eb11662c..2703040f45 100644
--- a/hw/misc/mips_cmgcr.c
+++ b/hw/misc/mips_cmgcr.c
@@ -205,7 +205,7 @@ static const VMStateDescription vmstate_mips_gcr = {
     .name = "mips-gcr",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(cpc_base, MIPSGCRState),
         VMSTATE_END_OF_LIST()
     },
diff --git a/hw/misc/mips_cpc.c b/hw/misc/mips_cpc.c
index 4a94c87054..1e8fd2e699 100644
--- a/hw/misc/mips_cpc.c
+++ b/hw/misc/mips_cpc.c
@@ -157,7 +157,7 @@ static const VMStateDescription vmstate_mips_cpc = {
     .name = "mips-cpc",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(vp_running, MIPSCPCState),
         VMSTATE_END_OF_LIST()
     },
diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
index d6ba47bde9..e3fe87c20c 100644
--- a/hw/misc/mos6522.c
+++ b/hw/misc/mos6522.c
@@ -611,7 +611,7 @@ static const VMStateDescription vmstate_mos6522_timer = {
     .name = "mos6522_timer",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT16(latch, MOS6522Timer),
         VMSTATE_UINT16(counter_value, MOS6522Timer),
         VMSTATE_INT64(load_time, MOS6522Timer),
@@ -625,7 +625,7 @@ const VMStateDescription vmstate_mos6522 = {
     .name = "mos6522",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(a, MOS6522State),
         VMSTATE_UINT8(b, MOS6522State),
         VMSTATE_UINT8(dira, MOS6522State),
diff --git a/hw/misc/mps2-fpgaio.c b/hw/misc/mps2-fpgaio.c
index 07b8cbdad2..aa1bb83e72 100644
--- a/hw/misc/mps2-fpgaio.c
+++ b/hw/misc/mps2-fpgaio.c
@@ -305,7 +305,7 @@ static const VMStateDescription mps2_fpgaio_vmstate = {
     .name = "mps2-fpgaio",
     .version_id = 3,
     .minimum_version_id = 3,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(led0, MPS2FPGAIO),
         VMSTATE_UINT32(prescale, MPS2FPGAIO),
         VMSTATE_UINT32(misc, MPS2FPGAIO),
diff --git a/hw/misc/mps2-scc.c b/hw/misc/mps2-scc.c
index b3b42a792c..8b5163f656 100644
--- a/hw/misc/mps2-scc.c
+++ b/hw/misc/mps2-scc.c
@@ -333,7 +333,7 @@ static const VMStateDescription mps2_scc_vmstate = {
     .name = "mps2-scc",
     .version_id = 3,
     .minimum_version_id = 3,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(cfg0, MPS2SCC),
         VMSTATE_UINT32(cfg1, MPS2SCC),
         VMSTATE_UINT32(cfg2, MPS2SCC),
diff --git a/hw/misc/msf2-sysreg.c b/hw/misc/msf2-sysreg.c
index 2dce55c364..f54382a816 100644
--- a/hw/misc/msf2-sysreg.c
+++ b/hw/misc/msf2-sysreg.c
@@ -112,7 +112,7 @@ static const VMStateDescription vmstate_msf2_sysreg = {
     .name = TYPE_MSF2_SYSREG,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, MSF2SysregState, MSF2_SYSREG_MMIO_SIZE / 4),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/misc/mst_fpga.c b/hw/misc/mst_fpga.c
index 7692825867..2d7bfa5ad9 100644
--- a/hw/misc/mst_fpga.c
+++ b/hw/misc/mst_fpga.c
@@ -227,7 +227,7 @@ static const VMStateDescription vmstate_mst_fpga_regs = {
     .version_id = 0,
     .minimum_version_id = 0,
     .post_load = mst_fpga_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
 		VMSTATE_UINT32(prev_level, mst_irq_state),
 		VMSTATE_UINT32(leddat1, mst_irq_state),
 		VMSTATE_UINT32(leddat2, mst_irq_state),
diff --git a/hw/misc/npcm7xx_clk.c b/hw/misc/npcm7xx_clk.c
index bc2b879feb..ac1622c38a 100644
--- a/hw/misc/npcm7xx_clk.c
+++ b/hw/misc/npcm7xx_clk.c
@@ -976,7 +976,7 @@ static const VMStateDescription vmstate_npcm7xx_clk_pll = {
     .name = "npcm7xx-clock-pll",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields =  (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_CLOCK(clock_in, NPCM7xxClockPLLState),
         VMSTATE_END_OF_LIST(),
     },
@@ -986,7 +986,7 @@ static const VMStateDescription vmstate_npcm7xx_clk_sel = {
     .name = "npcm7xx-clock-sel",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields =  (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_ARRAY_OF_POINTER_TO_STRUCT(clock_in, NPCM7xxClockSELState,
                 NPCM7XX_CLK_SEL_MAX_INPUT, 0, vmstate_clock, Clock),
         VMSTATE_END_OF_LIST(),
@@ -997,7 +997,7 @@ static const VMStateDescription vmstate_npcm7xx_clk_divider = {
     .name = "npcm7xx-clock-divider",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields =  (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_CLOCK(clock_in, NPCM7xxClockDividerState),
         VMSTATE_END_OF_LIST(),
     },
@@ -1008,7 +1008,7 @@ static const VMStateDescription vmstate_npcm7xx_clk = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = npcm7xx_clk_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, NPCM7xxCLKState, NPCM7XX_CLK_NR_REGS),
         VMSTATE_INT64(ref_ns, NPCM7xxCLKState),
         VMSTATE_CLOCK(clkref, NPCM7xxCLKState),
diff --git a/hw/misc/npcm7xx_gcr.c b/hw/misc/npcm7xx_gcr.c
index eace9e1967..9252f9d148 100644
--- a/hw/misc/npcm7xx_gcr.c
+++ b/hw/misc/npcm7xx_gcr.c
@@ -227,7 +227,7 @@ static const VMStateDescription vmstate_npcm7xx_gcr = {
     .name = "npcm7xx-gcr",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, NPCM7xxGCRState, NPCM7XX_GCR_NR_REGS),
         VMSTATE_END_OF_LIST(),
     },
diff --git a/hw/misc/npcm7xx_mft.c b/hw/misc/npcm7xx_mft.c
index a30583a1b0..9a848584e1 100644
--- a/hw/misc/npcm7xx_mft.c
+++ b/hw/misc/npcm7xx_mft.c
@@ -503,7 +503,7 @@ static const VMStateDescription vmstate_npcm7xx_mft = {
     .name = "npcm7xx-mft-module",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_CLOCK(clock_in, NPCM7xxMFTState),
         VMSTATE_CLOCK(clock_1, NPCM7xxMFTState),
         VMSTATE_CLOCK(clock_2, NPCM7xxMFTState),
diff --git a/hw/misc/npcm7xx_pwm.c b/hw/misc/npcm7xx_pwm.c
index 2be5bd25c6..fca2dd2e5a 100644
--- a/hw/misc/npcm7xx_pwm.c
+++ b/hw/misc/npcm7xx_pwm.c
@@ -511,7 +511,7 @@ static const VMStateDescription vmstate_npcm7xx_pwm = {
     .name = "npcm7xx-pwm",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BOOL(running, NPCM7xxPWM),
         VMSTATE_BOOL(inverted, NPCM7xxPWM),
         VMSTATE_UINT8(index, NPCM7xxPWM),
@@ -529,7 +529,7 @@ static const VMStateDescription vmstate_npcm7xx_pwm_module = {
     .name = "npcm7xx-pwm-module",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_CLOCK(clock, NPCM7xxPWMState),
         VMSTATE_STRUCT_ARRAY(pwm, NPCM7xxPWMState,
                              NPCM7XX_PWM_PER_MODULE, 0, vmstate_npcm7xx_pwm,
diff --git a/hw/misc/npcm7xx_rng.c b/hw/misc/npcm7xx_rng.c
index b01df7cdb2..7f7e5eca62 100644
--- a/hw/misc/npcm7xx_rng.c
+++ b/hw/misc/npcm7xx_rng.c
@@ -150,7 +150,7 @@ static const VMStateDescription vmstate_npcm7xx_rng = {
     .name = "npcm7xx-rng",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(rngcs, NPCM7xxRNGState),
         VMSTATE_UINT8(rngd, NPCM7xxRNGState),
         VMSTATE_UINT8(rngmode, NPCM7xxRNGState),
diff --git a/hw/misc/nrf51_rng.c b/hw/misc/nrf51_rng.c
index fc86e1b697..2d76c45718 100644
--- a/hw/misc/nrf51_rng.c
+++ b/hw/misc/nrf51_rng.c
@@ -231,7 +231,7 @@ static const VMStateDescription vmstate_rng = {
     .name = "nrf51_soc.rng",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(active, NRF51RNGState),
         VMSTATE_UINT32(event_valrdy, NRF51RNGState),
         VMSTATE_UINT32(shortcut_stop_on_valrdy, NRF51RNGState),
diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
index fff19e369a..72b653463f 100644
--- a/hw/misc/pca9552.c
+++ b/hw/misc/pca9552.c
@@ -328,7 +328,7 @@ static const VMStateDescription pca9552_vmstate = {
     .name = "PCA9552",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(len, PCA955xState),
         VMSTATE_UINT8(pointer, PCA955xState),
         VMSTATE_UINT8_ARRAY(regs, PCA955xState, PCA955X_NR_REGS),
diff --git a/hw/misc/pvpanic-pci.c b/hw/misc/pvpanic-pci.c
index fbcaa50731..c01e4ce864 100644
--- a/hw/misc/pvpanic-pci.c
+++ b/hw/misc/pvpanic-pci.c
@@ -37,7 +37,7 @@ static const VMStateDescription vmstate_pvpanic_pci = {
     .name = "pvpanic-pci",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(dev, PVPanicPCIState),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/misc/slavio_misc.c b/hw/misc/slavio_misc.c
index e8eb71570a..94369e4cc8 100644
--- a/hw/misc/slavio_misc.c
+++ b/hw/misc/slavio_misc.c
@@ -408,7 +408,7 @@ static const VMStateDescription vmstate_misc = {
     .name ="slavio_misc",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(dummy, MiscState),
         VMSTATE_UINT8(config, MiscState),
         VMSTATE_UINT8(aux1, MiscState),
diff --git a/hw/misc/stm32f4xx_exti.c b/hw/misc/stm32f4xx_exti.c
index 02e7810046..7bd3afcd7c 100644
--- a/hw/misc/stm32f4xx_exti.c
+++ b/hw/misc/stm32f4xx_exti.c
@@ -153,7 +153,7 @@ static const VMStateDescription vmstate_stm32f4xx_exti = {
     .name = TYPE_STM32F4XX_EXTI,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(exti_imr, STM32F4xxExtiState),
         VMSTATE_UINT32(exti_emr, STM32F4xxExtiState),
         VMSTATE_UINT32(exti_rtsr, STM32F4xxExtiState),
diff --git a/hw/misc/stm32f4xx_syscfg.c b/hw/misc/stm32f4xx_syscfg.c
index f960e4ea1e..854fce6a95 100644
--- a/hw/misc/stm32f4xx_syscfg.c
+++ b/hw/misc/stm32f4xx_syscfg.c
@@ -137,7 +137,7 @@ static const VMStateDescription vmstate_stm32f4xx_syscfg = {
     .name = TYPE_STM32F4XX_SYSCFG,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(syscfg_memrmp, STM32F4xxSyscfgState),
         VMSTATE_UINT32(syscfg_pmc, STM32F4xxSyscfgState),
         VMSTATE_UINT32_ARRAY(syscfg_exticr, STM32F4xxSyscfgState,
diff --git a/hw/misc/tz-mpc.c b/hw/misc/tz-mpc.c
index 30481e1c90..92b994919b 100644
--- a/hw/misc/tz-mpc.c
+++ b/hw/misc/tz-mpc.c
@@ -574,7 +574,7 @@ static const VMStateDescription tz_mpc_vmstate = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = tz_mpc_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(ctrl, TZMPC),
         VMSTATE_UINT32(blk_idx, TZMPC),
         VMSTATE_UINT32(int_stat, TZMPC),
diff --git a/hw/misc/tz-msc.c b/hw/misc/tz-msc.c
index acbe94400b..de5a3126cc 100644
--- a/hw/misc/tz-msc.c
+++ b/hw/misc/tz-msc.c
@@ -269,7 +269,7 @@ static const VMStateDescription tz_msc_vmstate = {
     .name = "tz-msc",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BOOL(cfg_nonsec, TZMSC),
         VMSTATE_BOOL(cfg_sec_resp, TZMSC),
         VMSTATE_BOOL(irq_clear, TZMSC),
diff --git a/hw/misc/tz-ppc.c b/hw/misc/tz-ppc.c
index 36495c68e7..6450778720 100644
--- a/hw/misc/tz-ppc.c
+++ b/hw/misc/tz-ppc.c
@@ -290,7 +290,7 @@ static const VMStateDescription tz_ppc_vmstate = {
     .name = "tz-ppc",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BOOL_ARRAY(cfg_nonsec, TZPPC, 16),
         VMSTATE_BOOL_ARRAY(cfg_ap, TZPPC, 16),
         VMSTATE_BOOL(cfg_sec_resp, TZPPC),
diff --git a/hw/misc/virt_ctrl.c b/hw/misc/virt_ctrl.c
index e75d1e7e17..1a6c744bac 100644
--- a/hw/misc/virt_ctrl.c
+++ b/hw/misc/virt_ctrl.c
@@ -108,7 +108,7 @@ static const VMStateDescription vmstate_virt_ctrl = {
     .name = "virt-ctrl",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(irq_enabled, VirtCtrlState),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/misc/vmcoreinfo.c b/hw/misc/vmcoreinfo.c
index a9d718fc23..833773ade5 100644
--- a/hw/misc/vmcoreinfo.c
+++ b/hw/misc/vmcoreinfo.c
@@ -73,7 +73,7 @@ static const VMStateDescription vmstate_vmcoreinfo = {
     .name = "vmcoreinfo",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BOOL(has_vmcoreinfo, VMCoreInfoState),
         VMSTATE_UINT16(vmcoreinfo.host_format, VMCoreInfoState),
         VMSTATE_UINT16(vmcoreinfo.guest_format, VMCoreInfoState),
diff --git a/hw/misc/xlnx-versal-cframe-reg.c b/hw/misc/xlnx-versal-cframe-reg.c
index 8e8ec0715a..a6ab287b01 100644
--- a/hw/misc/xlnx-versal-cframe-reg.c
+++ b/hw/misc/xlnx-versal-cframe-reg.c
@@ -697,7 +697,7 @@ static const VMStateDescription vmstate_cframe = {
     .name = "cframe",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(data, XlnxCFrame, FRAME_NUM_WORDS),
         VMSTATE_END_OF_LIST()
     }
@@ -707,7 +707,7 @@ static const VMStateDescription vmstate_cframe_reg = {
     .name = TYPE_XLNX_VERSAL_CFRAME_REG,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(wfifo, XlnxVersalCFrameReg, 4),
         VMSTATE_UINT32_ARRAY(regs, XlnxVersalCFrameReg, CFRAME_REG_R_MAX),
         VMSTATE_BOOL(rowon, XlnxVersalCFrameReg),
@@ -765,7 +765,7 @@ static const VMStateDescription vmstate_cframe_bcast_reg = {
     .name = TYPE_XLNX_VERSAL_CFRAME_BCAST_REG,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(wfifo, XlnxVersalCFrameBcastReg, 4),
         VMSTATE_END_OF_LIST(),
     }
diff --git a/hw/misc/xlnx-versal-cfu.c b/hw/misc/xlnx-versal-cfu.c
index 8e588ac1d8..6bb82e51c1 100644
--- a/hw/misc/xlnx-versal-cfu.c
+++ b/hw/misc/xlnx-versal-cfu.c
@@ -463,7 +463,7 @@ static const VMStateDescription vmstate_cfu_apb = {
     .name = TYPE_XLNX_VERSAL_CFU_APB,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(wfifo, XlnxVersalCFUAPB, 4),
         VMSTATE_UINT32_ARRAY(regs, XlnxVersalCFUAPB, R_MAX),
         VMSTATE_UINT8(fdri_row_addr, XlnxVersalCFUAPB),
@@ -475,7 +475,7 @@ static const VMStateDescription vmstate_cfu_fdro = {
     .name = TYPE_XLNX_VERSAL_CFU_FDRO,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_FIFO32(fdro_data, XlnxVersalCFUFDRO),
         VMSTATE_END_OF_LIST(),
     }
@@ -485,7 +485,7 @@ static const VMStateDescription vmstate_cfu_sfr = {
     .name = TYPE_XLNX_VERSAL_CFU_SFR,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(wfifo, XlnxVersalCFUSFR, 4),
         VMSTATE_END_OF_LIST(),
     }
diff --git a/hw/misc/xlnx-versal-crl.c b/hw/misc/xlnx-versal-crl.c
index 767106b7a3..ac6889fcf2 100644
--- a/hw/misc/xlnx-versal-crl.c
+++ b/hw/misc/xlnx-versal-crl.c
@@ -387,7 +387,7 @@ static const VMStateDescription vmstate_crl = {
     .name = TYPE_XLNX_VERSAL_CRL,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, XlnxVersalCRL, CRL_R_MAX),
         VMSTATE_END_OF_LIST(),
     }
diff --git a/hw/misc/xlnx-versal-pmc-iou-slcr.c b/hw/misc/xlnx-versal-pmc-iou-slcr.c
index 07b7ebc217..60e13a78ab 100644
--- a/hw/misc/xlnx-versal-pmc-iou-slcr.c
+++ b/hw/misc/xlnx-versal-pmc-iou-slcr.c
@@ -1412,7 +1412,7 @@ static const VMStateDescription vmstate_pmc_iou_slcr = {
     .name = TYPE_XILINX_VERSAL_PMC_IOU_SLCR,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, XlnxVersalPmcIouSlcr,
                              XILINX_VERSAL_PMC_IOU_SLCR_R_MAX),
         VMSTATE_END_OF_LIST(),
diff --git a/hw/misc/xlnx-versal-trng.c b/hw/misc/xlnx-versal-trng.c
index 4d41c262c4..b8111b8b66 100644
--- a/hw/misc/xlnx-versal-trng.c
+++ b/hw/misc/xlnx-versal-trng.c
@@ -674,7 +674,7 @@ static const VMStateDescription vmstate_trng = {
     .name = TYPE_XLNX_VERSAL_TRNG,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(rand_count, XlnxVersalTRng),
         VMSTATE_UINT64(rand_reseed, XlnxVersalTRng),
         VMSTATE_UINT64(forced_prng_count, XlnxVersalTRng),
diff --git a/hw/misc/xlnx-versal-xramc.c b/hw/misc/xlnx-versal-xramc.c
index e5b719a0ed..a5f78c190e 100644
--- a/hw/misc/xlnx-versal-xramc.c
+++ b/hw/misc/xlnx-versal-xramc.c
@@ -212,7 +212,7 @@ static const VMStateDescription vmstate_xram_ctrl = {
     .name = TYPE_XLNX_XRAM_CTRL,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, XlnxXramCtrl, XRAM_CTRL_R_MAX),
         VMSTATE_END_OF_LIST(),
     }
diff --git a/hw/misc/xlnx-zynqmp-apu-ctrl.c b/hw/misc/xlnx-zynqmp-apu-ctrl.c
index 3d2be95e6d..1d441b41df 100644
--- a/hw/misc/xlnx-zynqmp-apu-ctrl.c
+++ b/hw/misc/xlnx-zynqmp-apu-ctrl.c
@@ -218,7 +218,7 @@ static const VMStateDescription vmstate_zynqmp_apu = {
     .name = TYPE_XLNX_ZYNQMP_APU_CTRL,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, XlnxZynqMPAPUCtrl, APU_R_MAX),
         VMSTATE_END_OF_LIST(),
     }
diff --git a/hw/misc/xlnx-zynqmp-crf.c b/hw/misc/xlnx-zynqmp-crf.c
index 57bc8cf49a..a83efb44e3 100644
--- a/hw/misc/xlnx-zynqmp-crf.c
+++ b/hw/misc/xlnx-zynqmp-crf.c
@@ -233,7 +233,7 @@ static const VMStateDescription vmstate_crf = {
     .name = TYPE_XLNX_ZYNQMP_CRF,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, XlnxZynqMPCRF, CRF_R_MAX),
         VMSTATE_END_OF_LIST(),
     }
diff --git a/hw/misc/zynq_slcr.c b/hw/misc/zynq_slcr.c
index 41f38a98e9..d2ac2e77f2 100644
--- a/hw/misc/zynq_slcr.c
+++ b/hw/misc/zynq_slcr.c
@@ -603,7 +603,7 @@ static const VMStateDescription vmstate_zynq_slcr = {
     .name = "zynq_slcr",
     .version_id = 3,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, ZynqSLCRState, ZYNQ_SLCR_NUM_REGS),
         VMSTATE_CLOCK_V(ps_clk, ZynqSLCRState, 3),
         VMSTATE_END_OF_LIST()
-- 
2.34.1


