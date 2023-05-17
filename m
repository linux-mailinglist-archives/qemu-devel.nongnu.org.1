Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC48706285
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 10:14:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzCH3-0006E2-I5; Wed, 17 May 2023 04:12:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.elsayed4420@gmail.com>)
 id 1pzCGv-00063N-QX; Wed, 17 May 2023 04:12:33 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <m.elsayed4420@gmail.com>)
 id 1pzCGo-0003Oc-9j; Wed, 17 May 2023 04:12:33 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-305f0491e62so411806f8f.3; 
 Wed, 17 May 2023 01:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684311144; x=1686903144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8jTtg6c8tXk3r3zlSLsfWvCTfAcAZwl11odHV82izYQ=;
 b=eRuQVvi8CwECCCMW1pJmIyNFr7xkWiG4y6PGWoH4CoAZ0lRhqRLFQ0QG5t6lXRe3EK
 A7inncCKnbpzgh8/oCdZDhlx2WR0Kv7kGazYPbxGol0ZkQFTG9uckRuk0MmCStgF87D9
 IpLKwDiDD3CX5tWdPyTz0MwEPXGcTl91fSHdQUAHI04OYAsIn+OtcBEtwWIXORH5qP+i
 loCeZpVwy/onUDqfgMOirtxlaG9M1JURfsTYpWfETpBz+YtXxj1z3OlT2dsupilM25/n
 RYj+HYw3G554fIVKw+A3Tzm+OdW82Ks4btuE3h/f+RYrGzL7ga6DgmLWON0/nhtipEh3
 qjfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684311144; x=1686903144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8jTtg6c8tXk3r3zlSLsfWvCTfAcAZwl11odHV82izYQ=;
 b=ciOkaE1FjbjVKERLmtljFLpgMf5oE+LrqtJ0IGo50Gelm5yx6SOVa7HzCRI+GUo4+V
 7eo8JP1bjFj9Ak24j9wzqF9CJ7TlHyBW5VfPT3v1q+IKowE0Nz7NxwYd1djRfrw3WR8s
 lCSTeNin1/oe0vJD8y6kixHwxXhCKrMqibK3wFW6TRRHHb5OjlNnUsCfJoEt09vt67HN
 dwl59IRHRQQBQzUNCwEkNHQNdzZfpVwW4DmrBQSa5hEeJtSjE1vgbq8VAKRoDKOd0DMY
 isi9BJ4ySQpyoP40BQGT2VX2VLJnBIzT1ATUz3HC2mPZs0fx2vU7P089mKCIJv2PBB2R
 utcA==
X-Gm-Message-State: AC+VfDzHxUSUEjX/sNLZL+lHM9nh8A9eYBrOj4q/kSd2x8uFkaiFeJuF
 Ui2z8TxmvABOn0OAM15/iNJNHaghjuw=
X-Google-Smtp-Source: ACHHUZ6x2l5J1oqGOFLCwZEiVY682R0m2hozgfpB23UJK3JuAGoTzM+SkRaIJ0UIR4lIlJj3PLueRw==
X-Received: by 2002:adf:df01:0:b0:306:cfba:3c32 with SMTP id
 y1-20020adfdf01000000b00306cfba3c32mr27994911wrl.48.1684311144084; 
 Wed, 17 May 2023 01:12:24 -0700 (PDT)
Received: from i.. ([41.236.82.205]) by smtp.gmail.com with ESMTPSA id
 o24-20020a1c7518000000b003f42158288dsm1414942wmc.20.2023.05.17.01.12.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 01:12:23 -0700 (PDT)
From: Mohamed ElSayed <m.elsayed4420@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Mohamed ElSayed <m.elsayed4420@gmail.com>
Subject: [PATCH 8/8] adding tiva c to the qemu build system and adding my info
 to the maintainers list
Date: Wed, 17 May 2023 11:12:04 +0300
Message-Id: <20230517081204.30333-9-m.elsayed4420@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230517081204.30333-1-m.elsayed4420@gmail.com>
References: <20230517081204.30333-1-m.elsayed4420@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=m.elsayed4420@gmail.com; helo=mail-wr1-x430.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Signed-off-by: Mohamed ElSayed <m.elsayed4420@gmail.com>
---
 MAINTAINERS                             |  9 +++++++++
 configs/devices/arm-softmmu/default.mak |  1 +
 hw/arm/Kconfig                          | 13 +++++++++++++
 hw/arm/meson.build                      |  3 +++
 hw/char/Kconfig                         |  3 +++
 hw/char/meson.build                     |  1 +
 hw/gpio/Kconfig                         |  3 +++
 hw/gpio/meson.build                     |  1 +
 hw/misc/Kconfig                         |  3 +++
 hw/misc/meson.build                     |  1 +
 hw/timer/Kconfig                        |  3 +++
 hw/timer/meson.build                    |  1 +
 hw/watchdog/Kconfig                     |  3 +++
 hw/watchdog/meson.build                 |  1 +
 14 files changed, 46 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b22b85bc3a..dcd902fadf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1008,6 +1008,15 @@ F: include/hw/misc/zynq_slcr.h
 F: include/hw/adc/zynq-xadc.h
 X: hw/ssi/xilinx_*
 
+Tiva C
+M: Mohamed ElSayed <m.elsayed4420@gmail.com>
+L: qemu-arm@nongnu.org
+S: Maintained
+F: hw/*/tm4c123*
+F: include/hw/*/tm4c123*
+F: hw/arm/tivac.c
+F: docs/system/arm/tivac.rst
+
 Xilinx ZynqMP and Versal
 M: Alistair Francis <alistair@alistair23.me>
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
diff --git a/configs/devices/arm-softmmu/default.mak b/configs/devices/arm-softmmu/default.mak
index 1b49a7830c..d3490f6d11 100644
--- a/configs/devices/arm-softmmu/default.mak
+++ b/configs/devices/arm-softmmu/default.mak
@@ -43,3 +43,4 @@ CONFIG_FSL_IMX6UL=y
 CONFIG_SEMIHOSTING=y
 CONFIG_ARM_COMPATIBLE_SEMIHOSTING=y
 CONFIG_ALLWINNER_H3=y
+CONFIG_TIVAC=y
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index b53bd7f0b2..ef8046ab1b 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -581,3 +581,16 @@ config ARMSSE
     select UNIMP
     select SSE_COUNTER
     select SSE_TIMER
+
+config TM4C123GH6PM_SOC
+    bool
+    select ARM_V7M
+    select TM4C123_USART
+    select TM4C123_SYSCTL
+    select TM4C123_GPIO
+    select TM4C123_WDT
+    select TM4C123_GPTM
+
+config TIVAC
+    bool
+    select TM4C123GH6PM_SOC
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index b545ba0e4f..29503388a5 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -62,10 +62,13 @@ arm_ss.add(when: 'CONFIG_FSL_IMX7', if_true: files('fsl-imx7.c', 'mcimx7d-sabre.
 arm_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
 arm_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-imx6ul.c', 'mcimx6ul-evk.c'))
 arm_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))
+arm_ss.add(when: 'CONFIG_TM4C123GH6PM_SOC', if_true: files('tm4c123gh6pm_soc.c'))
+arm_ss.add(when: 'CONFIG_TIVAC', if_true: files('tivac.c'))
 
 softmmu_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmu-common.c'))
 softmmu_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4_boards.c'))
 softmmu_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_peripherals.c'))
 softmmu_ss.add(when: 'CONFIG_TOSA', if_true: files('tosa.c'))
 
+
 hw_arch += {'arm': arm_ss}
diff --git a/hw/char/Kconfig b/hw/char/Kconfig
index 6b6cf2fc1d..88da979b75 100644
--- a/hw/char/Kconfig
+++ b/hw/char/Kconfig
@@ -71,3 +71,6 @@ config GOLDFISH_TTY
 
 config SHAKTI_UART
     bool
+
+config TM4C123_USART
+    bool
diff --git a/hw/char/meson.build b/hw/char/meson.build
index 0807e00ae4..8461748c8d 100644
--- a/hw/char/meson.build
+++ b/hw/char/meson.build
@@ -33,6 +33,7 @@ softmmu_ss.add(when: 'CONFIG_SH_SCI', if_true: files('sh_serial.c'))
 softmmu_ss.add(when: 'CONFIG_STM32F2XX_USART', if_true: files('stm32f2xx_usart.c'))
 softmmu_ss.add(when: 'CONFIG_MCHP_PFSOC_MMUART', if_true: files('mchp_pfsoc_mmuart.c'))
 softmmu_ss.add(when: 'CONFIG_HTIF', if_true: files('riscv_htif.c'))
+softmmu_ss.add(when: 'CONFIG_TM4C123_USART', if_true: files('tm4c123_usart.c'))
 softmmu_ss.add(when: 'CONFIG_GOLDFISH_TTY', if_true: files('goldfish_tty.c'))
 
 specific_ss.add(when: 'CONFIG_TERMINAL3270', if_true: files('terminal3270.c'))
diff --git a/hw/gpio/Kconfig b/hw/gpio/Kconfig
index d2cf3accc8..1b843d669a 100644
--- a/hw/gpio/Kconfig
+++ b/hw/gpio/Kconfig
@@ -16,3 +16,6 @@ config GPIO_PWR
 
 config SIFIVE_GPIO
     bool
+
+config TM4C123_GPIO
+    bool
diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build
index b726e6d27a..b253e8ce67 100644
--- a/hw/gpio/meson.build
+++ b/hw/gpio/meson.build
@@ -12,3 +12,4 @@ softmmu_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_gpio.c'))
 softmmu_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_gpio.c'))
 softmmu_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_gpio.c'))
 softmmu_ss.add(when: 'CONFIG_SIFIVE_GPIO', if_true: files('sifive_gpio.c'))
+softmmu_ss.add(when: 'CONFIG_TM4C123_GPIO', if_true: files('tm4c123_gpio.c'))
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 2ef5781ef8..c8be9ae285 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -180,4 +180,7 @@ config AXP209_PMU
     bool
     depends on I2C
 
+config TM4C123_SYSCTL
+    bool
+
 source macio/Kconfig
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index a40245ad44..95ddb4b1b4 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -141,3 +141,4 @@ softmmu_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
 
 # HPPA devices
 softmmu_ss.add(when: 'CONFIG_LASI', if_true: files('lasi.c'))
+softmmu_ss.add(when: 'CONFIG_TM4C123_SYSCTL', if_true: files('tm4c123_sysctl.c'))
diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
index 010be7ed1f..aaf42e3f3f 100644
--- a/hw/timer/Kconfig
+++ b/hw/timer/Kconfig
@@ -60,3 +60,6 @@ config STELLARIS_GPTM
 
 config AVR_TIMER16
     bool
+
+config TM4C123_GPTM
+    bool
diff --git a/hw/timer/meson.build b/hw/timer/meson.build
index 03092e2ceb..118593e959 100644
--- a/hw/timer/meson.build
+++ b/hw/timer/meson.build
@@ -36,5 +36,6 @@ softmmu_ss.add(when: 'CONFIG_STM32F2XX_TIMER', if_true: files('stm32f2xx_timer.c
 softmmu_ss.add(when: 'CONFIG_XILINX', if_true: files('xilinx_timer.c'))
 specific_ss.add(when: 'CONFIG_IBEX', if_true: files('ibex_timer.c'))
 softmmu_ss.add(when: 'CONFIG_SIFIVE_PWM', if_true: files('sifive_pwm.c'))
+softmmu_ss.add(when: 'CONFIG_TM4C123_GPTM', if_true: files('tm4c123_gptm.c'))
 
 specific_ss.add(when: 'CONFIG_AVR_TIMER16', if_true: files('avr_timer16.c'))
diff --git a/hw/watchdog/Kconfig b/hw/watchdog/Kconfig
index 861fd00334..ada7163055 100644
--- a/hw/watchdog/Kconfig
+++ b/hw/watchdog/Kconfig
@@ -24,3 +24,6 @@ config WDT_SBSA
 config ALLWINNER_WDT
     bool
     select PTIMER
+
+config TM4C123_WDT
+    bool
diff --git a/hw/watchdog/meson.build b/hw/watchdog/meson.build
index 5dcd4fbe2f..cc48d2dec9 100644
--- a/hw/watchdog/meson.build
+++ b/hw/watchdog/meson.build
@@ -7,4 +7,5 @@ softmmu_ss.add(when: 'CONFIG_WDT_DIAG288', if_true: files('wdt_diag288.c'))
 softmmu_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('wdt_aspeed.c'))
 softmmu_ss.add(when: 'CONFIG_WDT_IMX2', if_true: files('wdt_imx2.c'))
 softmmu_ss.add(when: 'CONFIG_WDT_SBSA', if_true: files('sbsa_gwdt.c'))
+softmmu_ss.add(when: 'CONFIG_TM4C123_WDT', if_true: files('tm4c123_watchdog.c'))
 specific_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr_watchdog.c'))
-- 
2.34.1


