Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9175570E41E
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 20:06:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1WOF-0006sj-Rv; Tue, 23 May 2023 14:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1q1WOC-0006rU-Et; Tue, 23 May 2023 14:05:40 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1q1WOA-0007Vz-C8; Tue, 23 May 2023 14:05:40 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B9F5E2039D;
 Tue, 23 May 2023 18:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1684865136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Z0gJW3+c85PO+0fYY9op8HomfuHWGJv4G+npvFWE+U=;
 b=RZdGwMaLummD2YgdHZkZ+s+fwXn0YoSvIfFwWpRtP/V4eQftZa2U5JIqjG2s5yvExCRx9V
 C5sO0qaNi4ftRl/NO3khdO27gdiD48PCMHWqJscbHE8GiQzwew6e8YS+p1j575dIHiFBH9
 Xh+lQtgX2Nh2wyJN8GTq49mgk18Jjpg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1684865136;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Z0gJW3+c85PO+0fYY9op8HomfuHWGJv4G+npvFWE+U=;
 b=iB3fhOVSLdhV5+1cTSx//zNvbmLDR8YRGEsHT222ORt9UsHXVc+J7e2zUi2HIp4cBwYbfw
 IHCZxrNQP+cVuXAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E89DF13A10;
 Tue, 23 May 2023 18:05:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id UEuJK24AbWQMQwAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 23 May 2023 18:05:34 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 3/3] arm/Kconfig: Make TCG dependence explicit
Date: Tue, 23 May 2023 15:05:25 -0300
Message-Id: <20230523180525.29994-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230523180525.29994-1-farosas@suse.de>
References: <20230523180525.29994-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Replace the 'default y if TCG' pattern with 'default y; depends on
TCG'.

That makes explict that there is a dependence on TCG and enabling
these CONFIGs via .mak files without TCG present will fail earlier.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 hw/arm/Kconfig | 123 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 82 insertions(+), 41 deletions(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 0f42c556d7..acc4371a4a 100644
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
2.35.3


