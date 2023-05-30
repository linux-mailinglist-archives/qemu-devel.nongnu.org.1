Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F29B67161BF
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:27:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zNW-0007Kg-R0; Tue, 30 May 2023 09:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3zMy-0005hr-Fj
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:26:41 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3zMu-0001RW-7I
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:26:36 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3f611ccd06eso30785995e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 06:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685453190; x=1688045190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mYL3LqQwKo6whR+y+cEYnc1aL7I+kAVYmWyIjQ5daSk=;
 b=GAJmsmXxpeDhaNwbhOOWlM22HuMZICI+Wn4xVk8cNVqdSRF6qMrMKZgXpXJ0Cnc69r
 +yk9STYRhOz+qSr3Miq9maTbcj4QEk7YMm8Vjvz9Ho6rQRzjNfcnFSFYH/8FBaQYH/79
 LG9gf8vEmqoM/v8ti2GR8sM59265w/1ILhcbgCXZVPQC6ngjdiUeyuxlVEM3Y9meYyS4
 KqdqKtpBAJJDVQIZ4b4ERrTFfy6ZBj5jIEywG2LYmiCaXpEJWMSHiK3houKc8acFJ+od
 /Dtw5q2g3MM5H0EEJ3T/XChGkeqo4MPB6mYmrNmtyY2bKAN+r8B3koJar1OnAcdy+Pfb
 oueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685453190; x=1688045190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mYL3LqQwKo6whR+y+cEYnc1aL7I+kAVYmWyIjQ5daSk=;
 b=Aya6SjvENI2dQMUf1D79xUV+FMvz9KLjZLw+xdMwk5iQ6nFxk+fnsoEwPHOldTMSU7
 VyorqrMEzPyS0lfibSolvuhLWAYfaURZfG8oVFoLl6CNrQ4dKXciAjc9l2hyMHrk7rg6
 GnkPpXBPdAfxpPMy53gCP0ZKFnXZLgSqgWKxsvWLMwnHjmACT9WtrQ/6iyJW5WGnl0Gt
 nzk+Q/bL889s97C8ajEt2xmgkAy9Z/uVyGjVnIIgFVebO2UeNNz4V2ateuJMIDypsnt9
 cT+IV1ZsoiDmDjy2Hx4pSSaYoWckI+TMHFmOlMd7dSJKYvLiQsNqcgrEJhgTdGn/OuzB
 CpWg==
X-Gm-Message-State: AC+VfDxC7PdLO7YMxJDygNw6Dw4YfW1587V8C9Aziq55CXTSi7o2iMMG
 r5vWclqR4ls4xt/RccAvx24PQKURJ9kyJci7j/I=
X-Google-Smtp-Source: ACHHUZ5Xx28ReRQA5a0IGS2ABOf3Xr13DSdVa35QHcnL1n6Nbs2pYxmkcKo0CXW05Pl4NTlMgCjlDA==
X-Received: by 2002:a1c:4b09:0:b0:3f6:d09:5d46 with SMTP id
 y9-20020a1c4b09000000b003f60d095d46mr1687916wma.20.1685453189986; 
 Tue, 30 May 2023 06:26:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 p19-20020a1c7413000000b003f60e143d38sm17463615wmc.11.2023.05.30.06.26.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 06:26:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/21] arm/Kconfig: Make TCG dependence explicit
Date: Tue, 30 May 2023 14:26:17 +0100
Message-Id: <20230530132620.1583658-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530132620.1583658-1-peter.maydell@linaro.org>
References: <20230530132620.1583658-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Fabiano Rosas <farosas@suse.de>

Replace the 'default y if TCG' pattern with 'default y; depends on
TCG'.

That makes explict that there is a dependence on TCG and enabling
these CONFIGs via .mak files without TCG present will fail earlier.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20230523180525.29994-4-farosas@suse.de
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/Kconfig | 123 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 82 insertions(+), 41 deletions(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 0f42c556d73..acc4371a4ae 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -35,24 +35,28 @@ config ARM_VIRT
 
 config CHEETAH
     bool
-    default y if TCG && ARM
+    default y
+    depends on TCG && ARM
     select OMAP
     select TSC210X
 
 config CUBIEBOARD
     bool
-    default y if TCG && ARM
+    default y
+    depends on TCG && ARM
     select ALLWINNER_A10
 
 config DIGIC
     bool
-    default y if TCG && ARM
+    default y
+    depends on TCG && ARM
     select PTIMER
     select PFLASH_CFI02
 
 config EXYNOS4
     bool
-    default y if TCG && ARM
+    default y
+    depends on TCG && ARM
     imply I2C_DEVICES
     select A9MPCORE
     select I2C
@@ -65,7 +69,8 @@ config EXYNOS4
 
 config HIGHBANK
     bool
-    default y if TCG && ARM
+    default y
+    depends on TCG && ARM
     select A9MPCORE
     select A15MPCORE
     select AHCI
@@ -80,7 +85,8 @@ config HIGHBANK
 
 config INTEGRATOR
     bool
-    default y if TCG && ARM
+    default y
+    depends on TCG && ARM
     select ARM_TIMER
     select INTEGRATOR_DEBUG
     select PL011 # UART
@@ -93,14 +99,16 @@ config INTEGRATOR
 
 config MAINSTONE
     bool
-    default y if TCG && ARM
+    default y
+    depends on TCG && ARM
     select PXA2XX
     select PFLASH_CFI01
     select SMC91C111
 
 config MUSCA
     bool
-    default y if TCG && ARM
+    default y
+    depends on TCG && ARM
     select ARMSSE
     select PL011
     select PL031
@@ -112,7 +120,8 @@ config MARVELL_88W8618
 
 config MUSICPAL
     bool
-    default y if TCG && ARM
+    default y
+    depends on TCG && ARM
     select OR_IRQ
     select BITBANG_I2C
     select MARVELL_88W8618
@@ -123,22 +132,26 @@ config MUSICPAL
 
 config NETDUINO2
     bool
-    default y if TCG && ARM
+    default y
+    depends on TCG && ARM
     select STM32F205_SOC
 
 config NETDUINOPLUS2
     bool
-    default y if TCG && ARM
+    default y
+    depends on TCG && ARM
     select STM32F405_SOC
 
 config OLIMEX_STM32_H405
     bool
-    default y if TCG && ARM
+    default y
+    depends on TCG && ARM
     select STM32F405_SOC
 
 config NSERIES
     bool
-    default y if TCG && ARM
+    default y
+    depends on TCG && ARM
     select OMAP
     select TMP105   # temperature sensor
     select BLIZZARD # LCD/TV controller
@@ -171,14 +184,16 @@ config PXA2XX
 
 config GUMSTIX
     bool
-    default y if TCG && ARM
+    default y
+    depends on TCG && ARM
     select PFLASH_CFI01
     select SMC91C111
     select PXA2XX
 
 config TOSA
     bool
-    default y if TCG && ARM
+    default y
+    depends on TCG && ARM
     select ZAURUS  # scoop
     select MICRODRIVE
     select PXA2XX
@@ -186,7 +201,8 @@ config TOSA
 
 config SPITZ
     bool
-    default y if TCG && ARM
+    default y
+    depends on TCG && ARM
     select ADS7846 # touch-screen controller
     select MAX111X # A/D converter
     select WM8750  # audio codec
@@ -199,7 +215,8 @@ config SPITZ
 
 config Z2
     bool
-    default y if TCG && ARM
+    default y
+    depends on TCG && ARM
     select PFLASH_CFI01
     select WM8750
     select PL011 # UART
@@ -207,7 +224,8 @@ config Z2
 
 config REALVIEW
     bool
-    default y if TCG && ARM
+    default y
+    depends on TCG && ARM
     imply PCI_DEVICES
     imply PCI_TESTDEV
     imply I2C_DEVICES
@@ -236,7 +254,8 @@ config REALVIEW
 
 config SBSA_REF
     bool
-    default y if TCG && AARCH64
+    default y
+    depends on TCG && AARCH64
     imply PCI_DEVICES
     select AHCI
     select ARM_SMMUV3
@@ -252,13 +271,15 @@ config SBSA_REF
 
 config SABRELITE
     bool
-    default y if TCG && ARM
+    default y
+    depends on TCG && ARM
     select FSL_IMX6
     select SSI_M25P80
 
 config STELLARIS
     bool
-    default y if TCG && ARM
+    default y
+    depends on TCG && ARM
     imply I2C_DEVICES
     select ARM_V7M
     select CMSDK_APB_WATCHDOG
@@ -276,7 +297,8 @@ config STELLARIS
 
 config STM32VLDISCOVERY
     bool
-    default y if TCG && ARM
+    default y
+    depends on TCG && ARM
     select STM32F100_SOC
 
 config STRONGARM
@@ -285,19 +307,22 @@ config STRONGARM
 
 config COLLIE
     bool
-    default y if TCG && ARM
+    default y
+    depends on TCG && ARM
     select PFLASH_CFI01
     select ZAURUS  # scoop
     select STRONGARM
 
 config SX1
     bool
-    default y if TCG && ARM
+    default y
+    depends on TCG && ARM
     select OMAP
 
 config VERSATILE
     bool
-    default y if TCG && ARM
+    default y
+    depends on TCG && ARM
     select ARM_TIMER # sp804
     select PFLASH_CFI01
     select LSI_SCSI_PCI
@@ -309,7 +334,8 @@ config VERSATILE
 
 config VEXPRESS
     bool
-    default y if TCG && ARM
+    default y
+    depends on TCG && ARM
     select A9MPCORE
     select A15MPCORE
     select ARM_MPTIMER
@@ -325,7 +351,8 @@ config VEXPRESS
 
 config ZYNQ
     bool
-    default y if TCG && ARM
+    default y
+    depends on TCG && ARM
     select A9MPCORE
     select CADENCE # UART
     select PFLASH_CFI02
@@ -342,7 +369,8 @@ config ZYNQ
 config ARM_V7M
     bool
     # currently v7M must be included in a TCG build due to translate.c
-    default y if TCG && ARM
+    default y
+    depends on TCG && ARM
     select PTIMER
 
 config ALLWINNER_A10
@@ -361,7 +389,8 @@ config ALLWINNER_A10
 
 config ALLWINNER_H3
     bool
-    default y if TCG && ARM
+    default y
+    depends on TCG && ARM
     select ALLWINNER_A10_PIT
     select ALLWINNER_SUN8I_EMAC
     select ALLWINNER_I2C
@@ -376,7 +405,8 @@ config ALLWINNER_H3
 
 config RASPI
     bool
-    default y if TCG && ARM
+    default y
+    depends on TCG && ARM
     select FRAMEBUFFER
     select PL011 # UART
     select SDHCI
@@ -407,7 +437,8 @@ config STM32F405_SOC
 
 config XLNX_ZYNQMP_ARM
     bool
-    default y if TCG && AARCH64
+    default y
+    depends on TCG && AARCH64
     select AHCI
     select ARM_GIC
     select CADENCE
@@ -425,7 +456,8 @@ config XLNX_ZYNQMP_ARM
 
 config XLNX_VERSAL
     bool
-    default y if TCG && AARCH64
+    default y
+    depends on TCG && AARCH64
     select ARM_GIC
     select PL011
     select CADENCE
@@ -440,7 +472,8 @@ config XLNX_VERSAL
 
 config NPCM7XX
     bool
-    default y if TCG && ARM
+    default y
+    depends on TCG && ARM
     select A9MPCORE
     select ADM1272
     select ARM_GIC
@@ -457,7 +490,8 @@ config NPCM7XX
 
 config FSL_IMX25
     bool
-    default y if TCG && ARM
+    default y
+    depends on TCG && ARM
     imply I2C_DEVICES
     select IMX
     select IMX_FEC
@@ -467,7 +501,8 @@ config FSL_IMX25
 
 config FSL_IMX31
     bool
-    default y if TCG && ARM
+    default y
+    depends on TCG && ARM
     imply I2C_DEVICES
     select SERIAL
     select IMX
@@ -488,7 +523,8 @@ config FSL_IMX6
 
 config ASPEED_SOC
     bool
-    default y if TCG && ARM
+    default y
+    depends on TCG && ARM
     select DS1338
     select FTGMAC100
     select I2C
@@ -509,7 +545,8 @@ config ASPEED_SOC
 
 config MPS2
     bool
-    default y if TCG && ARM
+    default y
+    depends on TCG && ARM
     imply I2C_DEVICES
     select ARMSSE
     select LAN9118
@@ -525,7 +562,8 @@ config MPS2
 
 config FSL_IMX7
     bool
-    default y if TCG && ARM
+    default y
+    depends on TCG && ARM
     imply PCI_DEVICES
     imply TEST_DEVICES
     imply I2C_DEVICES
@@ -544,7 +582,8 @@ config ARM_SMMUV3
 
 config FSL_IMX6UL
     bool
-    default y if TCG && ARM
+    default y
+    depends on TCG && ARM
     imply I2C_DEVICES
     select A15MPCORE
     select IMX
@@ -556,7 +595,8 @@ config FSL_IMX6UL
 
 config MICROBIT
     bool
-    default y if TCG && ARM
+    default y
+    depends on TCG && ARM
     select NRF51_SOC
 
 config NRF51_SOC
@@ -568,7 +608,8 @@ config NRF51_SOC
 
 config EMCRAFT_SF2
     bool
-    default y if TCG && ARM
+    default y
+    depends on TCG && ARM
     select MSF2
     select SSI_M25P80
 
-- 
2.34.1


