Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C70479F25AB
	for <lists+qemu-devel@lfdr.de>; Sun, 15 Dec 2024 20:12:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMtwV-0001K3-4a; Sun, 15 Dec 2024 14:06:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtwO-0001Hw-Or
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:06:08 -0500
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtwI-00013O-RM
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:06:07 -0500
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-294ec8e1d8aso2758079fac.1
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289559; x=1734894359; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FDkWHiXCGTFXhaVjhRbjm66X57QNKbz4zffh3T6MBjA=;
 b=LISV+m1DqsSLj2NmeKZ2M4C13P3/kWFBGxIhD7web4yVbPJeO4ztBs9KfNjG0OFQj0
 qrhywix46ZSHne1eDOlL5fuZkCfZ7ybr94Z7HRcpcf6UNafBJBESnY/zTLxN4h2sNdN7
 R/iCrxdEU6NoPQjmPcAxrUjTKF6NrTMLoG2CsYFgtsn1i95S9lMaaWkA0opS5xzthPAi
 ng4kXKvkUz8ZfXz67ZXB/vZWk1VESnGtJepAptWz4bIGB4djZKIa+hlckm2mkdMkcpTv
 +y6j9UhqRGOerbRv76z03V8zyD39SAgQei8ZTyBLMeL2Hc+t9tPP7WnxkyuxKKl1vzlS
 qdOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289559; x=1734894359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FDkWHiXCGTFXhaVjhRbjm66X57QNKbz4zffh3T6MBjA=;
 b=jIBpcaLmok0OJnwtRvTWOkXOPijAsymSMcgld1hSK/HZgmX0KALZ340qia/U2azLHC
 Ciz5gNF9nQdCfxBVVg+Dkcnj7Ax8L+U2ePoQu5ExFpTBs9h8QCFQFuQ6t9+AZAEBRXZU
 PUtZMDHcZxFilwT6Pkov40iQXf1XvyU2M/WVqtgL7GyBKJ4cge2PqAv+/CyCxZhmbczE
 YtQ1PerVSb3G4VCXttpo1EQcDvqNGhOPmPzcE75D0HSscjv/1joq7xJIsYT8QwG3T3/V
 Nh+AIZ8TekYBp9HfN7VMa2evRoq036Hol4JM/wFnQSAbB+u+NytVS5lfqctO8EXV+8aW
 1lLg==
X-Gm-Message-State: AOJu0YzDr0thHtLeSfnny7a5eikAG2EmdKwhnUEOQbmUgeLuDV8Y5cph
 HQ0PAQ5R/uAjuT370zkeOiV9He+E5ImpL0+8MvLE38fRGjzL9EPho4ZVFhgKUQuoU9XF316KGeh
 4N/4S5g12
X-Gm-Gg: ASbGncvgocIazbb7xCPgKzckJ2qJ7y3RU9uFoD3XnF2r2rZl0OsgcKNFhexaTw+4DGR
 M4LgXFNA3fDIqTsc+E2J76RzzeKTJY4oIS5Pfvq2t4jp4vQOh5SDlqGLqFv8ZRBC6oF82hERH8X
 dRtvQg+3cr+VW9jqJjrr9WF5ZjbFWnIDPnYlmqTHqZfjd9kyXFX9kvGnBjM3RtBr8x/DywzDYyx
 g7+IQ07sXA0lC02ZEP2nwykWlCIXDw7kY5IWLYk3AhtxfLB3GA/pjBW4J26/OGj2Ax1mKzCUxWy
 HKGH2EQuVlEP+WjFjClmKy4yALnf8i7uex7xPEfCPf0=
X-Google-Smtp-Source: AGHT+IEFiL70FaE9liYYcD74KPbcZlV7xE5T9dNxYW8qxUrE4Evk4GqP+UNS0EGIhPseGt/3jfPpQg==
X-Received: by 2002:a05:6871:68a:b0:29d:c832:7ef6 with SMTP id
 586e51a60fabf-2a3ac93400cmr5205263fac.39.1734289559528; 
 Sun, 15 Dec 2024 11:05:59 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2a3d2914ac6sm1423214fac.39.2024.12.15.11.05.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:05:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 14/67] hw/arm: Constify all Property
Date: Sun, 15 Dec 2024 13:04:40 -0600
Message-ID: <20241215190533.3222854-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/arm/armsse.c            | 8 ++++----
 hw/arm/armv7m.c            | 4 ++--
 hw/arm/aspeed_soc_common.c | 2 +-
 hw/arm/bcm2836.c           | 2 +-
 hw/arm/fsl-imx25.c         | 2 +-
 hw/arm/fsl-imx6.c          | 2 +-
 hw/arm/fsl-imx6ul.c        | 2 +-
 hw/arm/fsl-imx7.c          | 2 +-
 hw/arm/integratorcp.c      | 2 +-
 hw/arm/msf2-soc.c          | 2 +-
 hw/arm/npcm7xx.c           | 2 +-
 hw/arm/nrf51_soc.c         | 2 +-
 hw/arm/smmu-common.c       | 2 +-
 hw/arm/smmuv3.c            | 2 +-
 hw/arm/stellaris.c         | 2 +-
 hw/arm/strongarm.c         | 2 +-
 hw/arm/xlnx-versal.c       | 2 +-
 hw/arm/xlnx-zynqmp.c       | 2 +-
 18 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index 58ed504b2b..1cd6b4a4b2 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -72,12 +72,12 @@ struct ARMSSEInfo {
     bool has_cpu_pwrctrl;
     bool has_sse_counter;
     bool has_tcms;
-    Property *props;
+    const Property *props;
     const ARMSSEDeviceInfo *devinfo;
     const bool *irq_is_common;
 };
 
-static Property iotkit_properties[] = {
+static const Property iotkit_properties[] = {
     DEFINE_PROP_LINK("memory", ARMSSE, board_memory, TYPE_MEMORY_REGION,
                      MemoryRegion *),
     DEFINE_PROP_UINT32("EXP_NUMIRQ", ARMSSE, exp_numirq, 64),
@@ -90,7 +90,7 @@ static Property iotkit_properties[] = {
     DEFINE_PROP_END_OF_LIST()
 };
 
-static Property sse200_properties[] = {
+static const Property sse200_properties[] = {
     DEFINE_PROP_LINK("memory", ARMSSE, board_memory, TYPE_MEMORY_REGION,
                      MemoryRegion *),
     DEFINE_PROP_UINT32("EXP_NUMIRQ", ARMSSE, exp_numirq, 64),
@@ -107,7 +107,7 @@ static Property sse200_properties[] = {
     DEFINE_PROP_END_OF_LIST()
 };
 
-static Property sse300_properties[] = {
+static const Property sse300_properties[] = {
     DEFINE_PROP_LINK("memory", ARMSSE, board_memory, TYPE_MEMORY_REGION,
                      MemoryRegion *),
     DEFINE_PROP_UINT32("EXP_NUMIRQ", ARMSSE, exp_numirq, 64),
diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 7c68525a9e..e20f719c9b 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -538,7 +538,7 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static Property armv7m_properties[] = {
+static const Property armv7m_properties[] = {
     DEFINE_PROP_STRING("cpu-type", ARMv7MState, cpu_type),
     DEFINE_PROP_LINK("memory", ARMv7MState, board_memory, TYPE_MEMORY_REGION,
                      MemoryRegion *),
@@ -631,7 +631,7 @@ void armv7m_load_kernel(ARMCPU *cpu, const char *kernel_filename,
     qemu_register_reset(armv7m_reset, cpu);
 }
 
-static Property bitband_properties[] = {
+static const Property bitband_properties[] = {
     DEFINE_PROP_UINT32("base", BitBandState, base, 0),
     DEFINE_PROP_LINK("source-memory", BitBandState, source_memory,
                      TYPE_MEMORY_REGION, MemoryRegion *),
diff --git a/hw/arm/aspeed_soc_common.c b/hw/arm/aspeed_soc_common.c
index a5ff33c46d..4221cacd51 100644
--- a/hw/arm/aspeed_soc_common.c
+++ b/hw/arm/aspeed_soc_common.c
@@ -139,7 +139,7 @@ static bool aspeed_soc_boot_from_emmc(AspeedSoCState *s)
     return false;
 }
 
-static Property aspeed_soc_properties[] = {
+static const Property aspeed_soc_properties[] = {
     DEFINE_PROP_LINK("dram", AspeedSoCState, dram_mr, TYPE_MEMORY_REGION,
                      MemoryRegion *),
     DEFINE_PROP_LINK("memory", AspeedSoCState, memory, TYPE_MEMORY_REGION,
diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 40a379bc36..95e16806fa 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -18,7 +18,7 @@
 #include "target/arm/cpu-qom.h"
 #include "target/arm/gtimer.h"
 
-static Property bcm2836_enabled_cores_property =
+static const Property bcm2836_enabled_cores_property =
     DEFINE_PROP_UINT32("enabled-cpus", BCM283XBaseState, enabled_cpus, 0);
 
 static void bcm283x_base_init(Object *obj)
diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index 5ed87edfe4..48763b03fe 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -309,7 +309,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
                                 &s->iram_alias);
 }
 
-static Property fsl_imx25_properties[] = {
+static const Property fsl_imx25_properties[] = {
     DEFINE_PROP_UINT32("fec-phy-num", FslIMX25State, phy_num, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 85748cb233..236d15bc9c 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -481,7 +481,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                                 &s->ocram_alias);
 }
 
-static Property fsl_imx6_properties[] = {
+static const Property fsl_imx6_properties[] = {
     DEFINE_PROP_UINT32("fec-phy-num", FslIMX6State, phy_num, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index 19f443570b..1e0bbbb5d7 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -718,7 +718,7 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
                                 FSL_IMX6UL_OCRAM_ALIAS_ADDR, &s->ocram_alias);
 }
 
-static Property fsl_imx6ul_properties[] = {
+static const Property fsl_imx6ul_properties[] = {
     DEFINE_PROP_UINT32("fec1-phy-num", FslIMX6ULState, phy_num[0], 0),
     DEFINE_PROP_UINT32("fec2-phy-num", FslIMX6ULState, phy_num[1], 1),
     DEFINE_PROP_BOOL("fec1-phy-connected", FslIMX6ULState, phy_connected[0],
diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index 9f2ef34555..0310c15b0c 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -736,7 +736,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
                                 &s->caam);
 }
 
-static Property fsl_imx7_properties[] = {
+static const Property fsl_imx7_properties[] = {
     DEFINE_PROP_UINT32("fec1-phy-num", FslIMX7State, phy_num[0], 0),
     DEFINE_PROP_UINT32("fec2-phy-num", FslIMX7State, phy_num[1], 1),
     DEFINE_PROP_BOOL("fec1-phy-connected", FslIMX7State, phy_connected[0],
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index feb0dd63df..ee6c7e0c0d 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -694,7 +694,7 @@ static void integratorcp_machine_init(MachineClass *mc)
 
 DEFINE_MACHINE("integratorcp", integratorcp_machine_init)
 
-static Property core_properties[] = {
+static const Property core_properties[] = {
     DEFINE_PROP_UINT32("memsz", IntegratorCMState, memsz, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
index c4999ebce3..5d7c3f2e5a 100644
--- a/hw/arm/msf2-soc.c
+++ b/hw/arm/msf2-soc.c
@@ -222,7 +222,7 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
     create_unimplemented_device("usb", 0x40043000, 0x1000);
 }
 
-static Property m2sxxx_soc_properties[] = {
+static const Property m2sxxx_soc_properties[] = {
     /*
      * part name specifies the type of SmartFusion2 device variant(this
      * property is for information purpose only.
diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index af04c4b7ec..2960b63b59 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -810,7 +810,7 @@ static void npcm7xx_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("npcm7xx.spix",         0xfb001000,   4 * KiB);
 }
 
-static Property npcm7xx_properties[] = {
+static const Property npcm7xx_properties[] = {
     DEFINE_PROP_LINK("dram-mr", NPCM7xxState, dram, TYPE_MEMORY_REGION,
                      MemoryRegion *),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
index ac53441630..43fac8a8db 100644
--- a/hw/arm/nrf51_soc.c
+++ b/hw/arm/nrf51_soc.c
@@ -208,7 +208,7 @@ static void nrf51_soc_init(Object *obj)
     s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
 }
 
-static Property nrf51_soc_properties[] = {
+static const Property nrf51_soc_properties[] = {
     DEFINE_PROP_LINK("memory", NRF51State, board_memory, TYPE_MEMORY_REGION,
                      MemoryRegion *),
     DEFINE_PROP_UINT32("sram-size", NRF51State, sram_size, NRF51822_SRAM_SIZE),
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 3f82728758..6baa9d0fc3 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -934,7 +934,7 @@ static void smmu_base_reset_hold(Object *obj, ResetType type)
     g_hash_table_remove_all(s->iotlb);
 }
 
-static Property smmu_dev_properties[] = {
+static const Property smmu_dev_properties[] = {
     DEFINE_PROP_UINT8("bus_num", SMMUState, bus_num, 0),
     DEFINE_PROP_LINK("primary-bus", SMMUState, primary_bus,
                      TYPE_PCI_BUS, PCIBus *),
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 6e847e8773..026838f9ac 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1976,7 +1976,7 @@ static const VMStateDescription vmstate_smmuv3 = {
     }
 };
 
-static Property smmuv3_properties[] = {
+static const Property smmuv3_properties[] = {
     /*
      * Stages of translation advertised.
      * "1": Stage 1
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 376746251e..7fc13d96c9 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -438,7 +438,7 @@ static const VMStateDescription vmstate_stellaris_sys = {
     }
 };
 
-static Property stellaris_sys_properties[] = {
+static const Property stellaris_sys_properties[] = {
     DEFINE_PROP_UINT32("user0", ssys_state, user0, 0),
     DEFINE_PROP_UINT32("user1", ssys_state, user1, 0),
     DEFINE_PROP_UINT32("did0", ssys_state, did0, 0),
diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index 612115ab5b..4c4ff21e80 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -1332,7 +1332,7 @@ static const VMStateDescription vmstate_strongarm_uart_regs = {
     },
 };
 
-static Property strongarm_uart_properties[] = {
+static const Property strongarm_uart_properties[] = {
     DEFINE_PROP_CHR("chardev", StrongARMUARTState, chr),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 3a1e2e29f1..3adbe7b1fb 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -968,7 +968,7 @@ static void versal_init(Object *obj)
                              "mr-rpu-ps-alias", &s->mr_ps, 0, UINT64_MAX);
 }
 
-static Property versal_properties[] = {
+static const Property versal_properties[] = {
     DEFINE_PROP_LINK("ddr", Versal, cfg.mr_ddr, TYPE_MEMORY_REGION,
                      MemoryRegion *),
     DEFINE_PROP_LINK("canbus0", Versal, lpd.iou.canbus[0],
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index ab2d50e31b..1082c62c30 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -857,7 +857,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static Property xlnx_zynqmp_props[] = {
+static const Property xlnx_zynqmp_props[] = {
     DEFINE_PROP_STRING("boot-cpu", XlnxZynqMPState, boot_cpu),
     DEFINE_PROP_BOOL("secure", XlnxZynqMPState, secure, false),
     DEFINE_PROP_BOOL("virtualization", XlnxZynqMPState, virt, false),
-- 
2.43.0


