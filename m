Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6092955744
	for <lists+qemu-devel@lfdr.de>; Sat, 17 Aug 2024 12:32:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfGeP-0008Ve-Ta; Sat, 17 Aug 2024 06:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <353rAZgUKChwL2NAH8GG8D6.4GEI6EM-56N6DFGF8FM.GJ8@flex--tavip.bounces.google.com>)
 id 1sfGeC-0007Sg-RM
 for qemu-devel@nongnu.org; Sat, 17 Aug 2024 06:27:01 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <353rAZgUKChwL2NAH8GG8D6.4GEI6EM-56N6DFGF8FM.GJ8@flex--tavip.bounces.google.com>)
 id 1sfGe2-0003Mj-Ml
 for qemu-devel@nongnu.org; Sat, 17 Aug 2024 06:26:56 -0400
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-e05e3938a37so4156878276.2
 for <qemu-devel@nongnu.org>; Sat, 17 Aug 2024 03:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1723890408; x=1724495208; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=LTgLYtsPdGmrKg3pkBZ/KZq29C9jiNwwJhUp1FgAfL0=;
 b=fStPnys47EizVLEapEXmTZOYcVQI8qfSIj9wyUpLM8iYlR6ocxzKuHUxcUuSworAKG
 zmaO1J41wavwjI14SDTu5e4o4pgaLEJfDIzW2hNeO1tgzdgJN5kAWY4N51aQykjB6+5s
 DgOxwSbXMTyvTIKLQUgsTQkSibd5CnnXJuqjlSq6+HGz6EHsLvYZNLnJMep9xuPB8Jrb
 CqPVXDw0ZCWK9IKAKo1KoSmUXc+T1n3qMA5C5yc1K1g1J3YiL9oA+QAp63+LcbC5LP4s
 WzPDtf/dxaPtqrmFYP2G3fixtrWC30v+GDL9xrDHLmSKhFM6DPa/jCdKfqqI8lcy3Erd
 81HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723890408; x=1724495208;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LTgLYtsPdGmrKg3pkBZ/KZq29C9jiNwwJhUp1FgAfL0=;
 b=ppyw043hZfSjVjfM7ZWZVPRuzTi7DmCGvNpcxXjROi59XDnlzKEGfvq9E0Hsr8vPlR
 jC3HFrHaDKALMaA2uRGZiIOTiIWcYO01gGb8sSwL+B0e+iBwO7X497BUooQhgO5J5lRD
 kPsoBINCPuK8+Xc1cb7uyrh8yZkjU4n2o+dg++xvqSczRn174MTl+cS3hiG43yVcFD2f
 buJWDXcdjGPhpqKb3AnCqmX84FENyiThLZpQsnBj9KHZZRmWh7JLU5184ODVKC1p27zR
 +JdxTWk7z0MwfHcbrSw+12ER6ty4k+fTwl81gVm2dcgisrmlRPtS7Pr0OlHan6Vg2IVz
 +5UA==
X-Gm-Message-State: AOJu0YwHUSuRbLL7RSYabflVjPOlsp027Q8CT+bzxAGbiMEYRNAqbKe2
 61+FJ7NOkO6qKxXiP1S3CNk8MuzMZxzjhUvH6yYbkwflYCMUIPsO0mu9syfnB5vDNfHgcirBIA6
 8JiRxhX0EusXeX7tylXsMK3QMItt6dC6FqOVy9fs77CQ6ypaU+9iex+r73QREb4iqjoLrwn7rFQ
 MhghM6Tqy0URhe5lsb/wZ8dAU9JA==
X-Google-Smtp-Source: AGHT+IFZCCo6Oolppj3OlZ2++bFGm4+cceis4d5ALul5nnZ4h7I80WcoyHB52I7X3bFkig+PkXtcbgugdw==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a5b:f4e:0:b0:e11:6c69:72ed with
 SMTP id
 3f1490d57ef6-e1180f6d94amr207843276.8.1723890407881; Sat, 17 Aug 2024
 03:26:47 -0700 (PDT)
Date: Sat, 17 Aug 2024 03:26:04 -0700
In-Reply-To: <20240817102606.3996242-1-tavip@google.com>
Mime-Version: 1.0
References: <20240817102606.3996242-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240817102606.3996242-22-tavip@google.com>
Subject: [RFC PATCH v2 21/23] hw/misc: add support for RT500's reset controller
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 thuth@redhat.com, peter.maydell@linaro.org, marcandre.lureau@redhat.com, 
 alistair@alistair23.me, berrange@redhat.com, philmd@linaro.org, 
 jsnow@redhat.com, crosa@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=353rAZgUKChwL2NAH8GG8D6.4GEI6EM-56N6DFGF8FM.GJ8@flex--tavip.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, UPPERCASE_50_75=0.008,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=no autolearn_force=no
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

The RT500 reset controller has two instances that have the same
register layout but with different fields for some registers.

The model only provides set and clear functionality for the various
reset lines which is common for both instances. Because of that only
one type is implemented for both controllers.

The patch includes automatically generated headers which contains the
register layout and helpers.

The header can be regenerated with the svd-rstctl0 and svd-rstctl1
targets when the build is configured with --enable-mcux-soc-svd.

Signed-off-by: Octavian Purdila <tavip@google.com>
---
 include/hw/arm/svd/rt500_rstctl0.h |  832 +++++++++++++++++
 include/hw/arm/svd/rt500_rstctl1.h | 1344 ++++++++++++++++++++++++++++
 include/hw/misc/rt500_rstctl.h     |   32 +
 hw/misc/rt500_rstctl.c             |  225 +++++
 hw/arm/svd/meson.build             |    6 +
 hw/misc/Kconfig                    |    3 +
 hw/misc/meson.build                |    1 +
 hw/misc/trace-events               |    4 +
 8 files changed, 2447 insertions(+)
 create mode 100644 include/hw/arm/svd/rt500_rstctl0.h
 create mode 100644 include/hw/arm/svd/rt500_rstctl1.h
 create mode 100644 include/hw/misc/rt500_rstctl.h
 create mode 100644 hw/misc/rt500_rstctl.c

diff --git a/include/hw/arm/svd/rt500_rstctl0.h b/include/hw/arm/svd/rt500_rstctl0.h
new file mode 100644
index 0000000000..b6de46c1e1
--- /dev/null
+++ b/include/hw/arm/svd/rt500_rstctl0.h
@@ -0,0 +1,832 @@
+/*
+ * Copyright 2016-2023 NXP SPDX-License-Identifier: BSD-3-Clause
+ *
+ * Automatically generated by svd-gen-header.py from MIMXRT595S_cm33.xml
+ */
+#pragma once
+
+#include "hw/registerfields.h"
+
+/* Reset Controller 0 */
+#define RT500_RSTCTL0_REGS_NO (31)
+
+/* System Reset Status Register */
+REG32(RT500_RSTCTL0_SYSRSTSTAT, 0);
+/* VDD CORE Power-On Reset (POR) was detected */
+FIELD(RT500_RSTCTL0_SYSRSTSTAT, VDD_POR, 0, 1);
+/* RESETN pin reset was detected */
+FIELD(RT500_RSTCTL0_SYSRSTSTAT, PAD_RESET, 4, 1);
+/* ARM reset was detected */
+FIELD(RT500_RSTCTL0_SYSRSTSTAT, ARM_RESET, 5, 1);
+/* WatchDog Timer 0 reset was detected */
+FIELD(RT500_RSTCTL0_SYSRSTSTAT, WDT0_RESET, 6, 1);
+/* WatchDog Timer 1 reset was detected */
+FIELD(RT500_RSTCTL0_SYSRSTSTAT, WDT1_RESET, 7, 1);
+
+/* Peripheral Reset Control Register 0 */
+REG32(RT500_RSTCTL0_PRSTCTL0, 16);
+/* Fusion F1 DSP reset control */
+FIELD(RT500_RSTCTL0_PRSTCTL0, DSP, 1, 1);
+/* AXI Switch reset control */
+FIELD(RT500_RSTCTL0_PRSTCTL0, AXI_SWITCH, 3, 1);
+/* POWERQUAD reset control */
+FIELD(RT500_RSTCTL0_PRSTCTL0, POWERQUAD, 8, 1);
+/* CASPER reset control */
+FIELD(RT500_RSTCTL0_PRSTCTL0, CASPER, 9, 1);
+/* Hash-Crypt reset control */
+FIELD(RT500_RSTCTL0_PRSTCTL0, HASHCRYPT, 10, 1);
+/* PUF reset control */
+FIELD(RT500_RSTCTL0_PRSTCTL0, PUF, 11, 1);
+/* RNG reset control */
+FIELD(RT500_RSTCTL0_PRSTCTL0, RNG, 12, 1);
+/* FLEXSPI0 and OTFAD reset control */
+FIELD(RT500_RSTCTL0_PRSTCTL0, FLEXSPI0_OTFAD, 16, 1);
+/* FLEXSPI1 reset control */
+FIELD(RT500_RSTCTL0_PRSTCTL0, FLEXSPI1, 18, 1);
+/* USB PHY reset control */
+FIELD(RT500_RSTCTL0_PRSTCTL0, USBHS_PHY, 20, 1);
+/* USB HS Device reset control */
+FIELD(RT500_RSTCTL0_PRSTCTL0, USBHS_DEVICE, 21, 1);
+/* USB HOST reset control */
+FIELD(RT500_RSTCTL0_PRSTCTL0, USBHS_HOST, 22, 1);
+/* USB RAM reset control */
+FIELD(RT500_RSTCTL0_PRSTCTL0, USBHS_SRAM, 23, 1);
+/* SCTimer reset control */
+FIELD(RT500_RSTCTL0_PRSTCTL0, SCT, 24, 1);
+/* GPU reset control */
+FIELD(RT500_RSTCTL0_PRSTCTL0, GPU, 26, 1);
+/* LCDIF Display Controller reset control */
+FIELD(RT500_RSTCTL0_PRSTCTL0, DISPLAY_CONTROLLER, 27, 1);
+/* MIPI Digital serial Interface controller reset control */
+FIELD(RT500_RSTCTL0_PRSTCTL0, MIPI_DSI_CONTROLLER, 28, 1);
+/* MIPI DSI PHY reset control */
+FIELD(RT500_RSTCTL0_PRSTCTL0, MIPI_DSI_PHY, 29, 1);
+/* SMARTDMA Event/Algorithm handler reset control */
+FIELD(RT500_RSTCTL0_PRSTCTL0, SMARTDMA, 30, 1);
+
+/* Peripheral Reset Control Register 1 */
+REG32(RT500_RSTCTL0_PRSTCTL1, 20);
+/* SDIO0 reset control */
+FIELD(RT500_RSTCTL0_PRSTCTL1, SDIO0, 2, 1);
+/* SDIO1 reset control */
+FIELD(RT500_RSTCTL0_PRSTCTL1, SDIO1, 3, 1);
+/* Analog comparator reset control */
+FIELD(RT500_RSTCTL0_PRSTCTL1, ACMP0, 15, 1);
+/* Analog-to-Digital converter reset control */
+FIELD(RT500_RSTCTL0_PRSTCTL1, ADC0, 16, 1);
+/* Secure GPIO 0 reset control */
+FIELD(RT500_RSTCTL0_PRSTCTL1, SHSGPIO0, 24, 1);
+
+/* Peripheral Reset Control Register 2 */
+REG32(RT500_RSTCTL0_PRSTCTL2, 24);
+/* Micro-tick timer reset control */
+FIELD(RT500_RSTCTL0_PRSTCTL2, UTICK0, 0, 1);
+/* Watchdog timer reset control */
+FIELD(RT500_RSTCTL0_PRSTCTL2, WWDT0, 1, 1);
+
+/* Peripheral Reset Control Register 0 SET */
+REG32(RT500_RSTCTL0_PRSTCTL0_SET, 64);
+/* Fusion_ DSP reset set */
+FIELD(RT500_RSTCTL0_PRSTCTL0_SET, DSP, 1, 1);
+/* AXI SWITCH reset set */
+FIELD(RT500_RSTCTL0_PRSTCTL0_SET, AXI_SWITCH, 3, 1);
+/* POWERQUAD reset set */
+FIELD(RT500_RSTCTL0_PRSTCTL0_SET, POWERQUAD, 8, 1);
+/* CASPER reset set */
+FIELD(RT500_RSTCTL0_PRSTCTL0_SET, CASPER, 9, 1);
+/* HASHCRYPT reset set */
+FIELD(RT500_RSTCTL0_PRSTCTL0_SET, HASHCRYPT, 10, 1);
+/* PUF reset set */
+FIELD(RT500_RSTCTL0_PRSTCTL0_SET, PUF, 11, 1);
+/* RNG reset set */
+FIELD(RT500_RSTCTL0_PRSTCTL0_SET, RNG, 12, 1);
+/* FLEXSPI0 and OTFAD reset set */
+FIELD(RT500_RSTCTL0_PRSTCTL0_SET, FLEXSPI0_OTFAD, 16, 1);
+/* FLEXSPI1 reset set */
+FIELD(RT500_RSTCTL0_PRSTCTL0_SET, FLEXSPI1, 18, 1);
+/* USB PHY reset set */
+FIELD(RT500_RSTCTL0_PRSTCTL0_SET, USBHS_PHY, 20, 1);
+/* USB Device reset set */
+FIELD(RT500_RSTCTL0_PRSTCTL0_SET, USBHS_DEVICE, 21, 1);
+/* USB HOST reset set */
+FIELD(RT500_RSTCTL0_PRSTCTL0_SET, USBHS_HOST, 22, 1);
+/* USBHS SRAM reset set */
+FIELD(RT500_RSTCTL0_PRSTCTL0_SET, USBHS_SRAM, 23, 1);
+/* SCTimer reset set */
+FIELD(RT500_RSTCTL0_PRSTCTL0_SET, SCT, 24, 1);
+/* GPU reset set */
+FIELD(RT500_RSTCTL0_PRSTCTL0_SET, GPU, 26, 1);
+/* LCDIF DISPLAY CONTROLLER reset set */
+FIELD(RT500_RSTCTL0_PRSTCTL0_SET, DISPLAY_CONTROLLER, 27, 1);
+/* MIPI DSI controller reset set */
+FIELD(RT500_RSTCTL0_PRSTCTL0_SET, MIPI_DSI_CONTROLLER, 28, 1);
+/* MIPI DSI PHY reset set */
+FIELD(RT500_RSTCTL0_PRSTCTL0_SET, MIPI_DSI_PHY, 29, 1);
+/* SMARTDMA Event/Algorithm handler reset set */
+FIELD(RT500_RSTCTL0_PRSTCTL0_SET, SMARTDMA, 30, 1);
+
+/* Peripheral Reset Control Register 1 SET */
+REG32(RT500_RSTCTL0_PRSTCTL1_SET, 68);
+/* SDIO0 reset set */
+FIELD(RT500_RSTCTL0_PRSTCTL1_SET, SDIO0, 2, 1);
+/* SDIO1 reset set */
+FIELD(RT500_RSTCTL0_PRSTCTL1_SET, SDIO1, 3, 1);
+/* ACMP0 reset set */
+FIELD(RT500_RSTCTL0_PRSTCTL1_SET, ACMP0, 15, 1);
+/* ADC0 reset set */
+FIELD(RT500_RSTCTL0_PRSTCTL1_SET, ADC0, 16, 1);
+/* SHSGPIO0 reset set */
+FIELD(RT500_RSTCTL0_PRSTCTL1_SET, SHSGPIO0, 24, 1);
+
+/* Peripheral Reset Control Register 2 SET */
+REG32(RT500_RSTCTL0_PRSTCTL2_SET, 72);
+/* Micro-tick timer 0 reset set */
+FIELD(RT500_RSTCTL0_PRSTCTL2_SET, UTICK0, 0, 1);
+/* WWDT0 reset set */
+FIELD(RT500_RSTCTL0_PRSTCTL2_SET, WWDT0, 1, 1);
+
+/* Peripheral Reset Control Register 0 CLR */
+REG32(RT500_RSTCTL0_PRSTCTL0_CLR, 112);
+/* Fusion_ F1 DSP reset clear */
+FIELD(RT500_RSTCTL0_PRSTCTL0_CLR, DSP, 1, 1);
+/* AXI SWITCH reset clear */
+FIELD(RT500_RSTCTL0_PRSTCTL0_CLR, AXI_SWITCH, 3, 1);
+/* POWERQUAD reset clear */
+FIELD(RT500_RSTCTL0_PRSTCTL0_CLR, POWERQUAD, 8, 1);
+/* CASPER reset clear */
+FIELD(RT500_RSTCTL0_PRSTCTL0_CLR, CASPER, 9, 1);
+/* HASHCRYPT reset clear */
+FIELD(RT500_RSTCTL0_PRSTCTL0_CLR, HASHCRYPT, 10, 1);
+/* PUF reset clear */
+FIELD(RT500_RSTCTL0_PRSTCTL0_CLR, PUF, 11, 1);
+/* RNG reset clear */
+FIELD(RT500_RSTCTL0_PRSTCTL0_CLR, RNG, 12, 1);
+/* FLEXSPI0 and OTFAD reset clear */
+FIELD(RT500_RSTCTL0_PRSTCTL0_CLR, FLEXSPI0_OTFAD, 16, 1);
+/* FLEXSPI1 reset clear */
+FIELD(RT500_RSTCTL0_PRSTCTL0_CLR, FLEXSPI1, 18, 1);
+/* USB PHY reset clear */
+FIELD(RT500_RSTCTL0_PRSTCTL0_CLR, USBHS_PHY, 20, 1);
+/* USB DEVICE reset clear */
+FIELD(RT500_RSTCTL0_PRSTCTL0_CLR, USBHS_DEVICE, 21, 1);
+/* USB HOST reset clear */
+FIELD(RT500_RSTCTL0_PRSTCTL0_CLR, USBHS_HOST, 22, 1);
+/* USBHS SRAM reset clear */
+FIELD(RT500_RSTCTL0_PRSTCTL0_CLR, USBHS_SRAM, 23, 1);
+/* SCT reset clear */
+FIELD(RT500_RSTCTL0_PRSTCTL0_CLR, SCT, 24, 1);
+/* GPU reset clear */
+FIELD(RT500_RSTCTL0_PRSTCTL0_CLR, GPU, 26, 1);
+/* LCDIF DISPLAY CONTROLLER reset clear */
+FIELD(RT500_RSTCTL0_PRSTCTL0_CLR, DISPLAY_CONTROLLER, 27, 1);
+/* MIPI DSI controller reset clear */
+FIELD(RT500_RSTCTL0_PRSTCTL0_CLR, MIPI_DSI_CONTROLLER, 28, 1);
+/* MIPI DSI PHY reset clear */
+FIELD(RT500_RSTCTL0_PRSTCTL0_CLR, MIPI_DSI_PHY, 29, 1);
+/* SMARTDMA Event/Algorithm handler reset clear */
+FIELD(RT500_RSTCTL0_PRSTCTL0_CLR, SMARTDMA, 30, 1);
+
+/* Peripheral Reset Control Register 1 CLR */
+REG32(RT500_RSTCTL0_PRSTCTL1_CLR, 116);
+/* SDIO0 reset clear */
+FIELD(RT500_RSTCTL0_PRSTCTL1_CLR, SDIO0, 2, 1);
+/* SDIO1 reset clear */
+FIELD(RT500_RSTCTL0_PRSTCTL1_CLR, SDIO1, 3, 1);
+/* ACMP0 reset clear */
+FIELD(RT500_RSTCTL0_PRSTCTL1_CLR, ACMP0, 15, 1);
+/* ADC0 reset clear */
+FIELD(RT500_RSTCTL0_PRSTCTL1_CLR, ADC0, 16, 1);
+/* Secure HSGPIO0 reset clear */
+FIELD(RT500_RSTCTL0_PRSTCTL1_CLR, SHSGPIO0, 24, 1);
+
+/* Peripheral Reset Control Register 2 CLR */
+REG32(RT500_RSTCTL0_PRSTCTL2_CLR, 120);
+/* Micro-tick timer 0 reset clear */
+FIELD(RT500_RSTCTL0_PRSTCTL2_CLR, UTICK0, 0, 1);
+/* WWDT0 reset clear */
+FIELD(RT500_RSTCTL0_PRSTCTL2_CLR, WWDT0, 1, 1);
+
+
+typedef enum {
+    /* No VDD CORE POR event is detected */
+    RT500_RSTCTL0_SYSRSTSTAT_VDD_POR_VDD_POR_EVENT_IS_NOT_DETECTED = 0,
+    /* VDD CORE POR event was detected */
+    RT500_RSTCTL0_SYSRSTSTAT_VDD_POR_VDD_POR_EVENT_WAS_DETECTED = 1,
+} RT500_RSTCTL0_SYSRSTSTAT_VDD_POR_Enum;
+
+typedef enum {
+    /* No RESETN pin event is detected */
+    RT500_RSTCTL0_SYSRSTSTAT_PAD_RESET_PAD_RESET_IS_NOT_DETECTED = 0,
+    /* RESETN pin event was detected. Write '1' to clear this bit */
+    RT500_RSTCTL0_SYSRSTSTAT_PAD_RESET_PAD_RESET_WAS_DETECTED = 1,
+} RT500_RSTCTL0_SYSRSTSTAT_PAD_RESET_Enum;
+
+typedef enum {
+    /* No ARM reset event is detected */
+    RT500_RSTCTL0_SYSRSTSTAT_ARM_RESET_ARM_RESET_IS_NOT_DETECTED = 0,
+    /* ARM reset was detected. Write '1' to clear this bit */
+    RT500_RSTCTL0_SYSRSTSTAT_ARM_RESET_ARM_RESET_WAS_DETECTED = 1,
+} RT500_RSTCTL0_SYSRSTSTAT_ARM_RESET_Enum;
+
+typedef enum {
+    /* No WDT0 reset event detected */
+    RT500_RSTCTL0_SYSRSTSTAT_WDT0_RESET_WDT0_RESET_IS_NOT_DETECTED = 0,
+    /* WDT0 reset event detected. Write '1' to clear this bit */
+    RT500_RSTCTL0_SYSRSTSTAT_WDT0_RESET_WDT0_RESET_WAS_DETECTED = 1,
+} RT500_RSTCTL0_SYSRSTSTAT_WDT0_RESET_Enum;
+
+typedef enum {
+    /* No WDT1 reset event detected */
+    RT500_RSTCTL0_SYSRSTSTAT_WDT1_RESET_WDT1_RESET_IS_NOT_DETECTED = 0,
+    /* WDT1 reset event detected. Write '1' to clear this bit */
+    RT500_RSTCTL0_SYSRSTSTAT_WDT1_RESET_WDT1_RESET_WAS_DETECTED = 1,
+} RT500_RSTCTL0_SYSRSTSTAT_WDT1_RESET_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL0_PRSTCTL0_DSP_DSP_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL0_PRSTCTL0_DSP_DSP_SET = 1,
+} RT500_RSTCTL0_PRSTCTL0_DSP_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL0_PRSTCTL0_AXI_SWITCH_AXI_SWITCH_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL0_PRSTCTL0_AXI_SWITCH_AXI_SWITCH_SET = 1,
+} RT500_RSTCTL0_PRSTCTL0_AXI_SWITCH_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL0_PRSTCTL0_POWERQUAD_POWERQUAD_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL0_PRSTCTL0_POWERQUAD_POWERQUAD_SET = 1,
+} RT500_RSTCTL0_PRSTCTL0_POWERQUAD_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL0_PRSTCTL0_CASPER_CASPER_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL0_PRSTCTL0_CASPER_CASPER_SET = 1,
+} RT500_RSTCTL0_PRSTCTL0_CASPER_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL0_PRSTCTL0_HASHCRYPT_HASHCRYPT_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL0_PRSTCTL0_HASHCRYPT_HASHCRYPT_SET = 1,
+} RT500_RSTCTL0_PRSTCTL0_HASHCRYPT_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL0_PRSTCTL0_PUF_PUF_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL0_PRSTCTL0_PUF_PUF_SET = 1,
+} RT500_RSTCTL0_PRSTCTL0_PUF_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL0_PRSTCTL0_RNG_RNG_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL0_PRSTCTL0_RNG_RNG_SET = 1,
+} RT500_RSTCTL0_PRSTCTL0_RNG_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL0_PRSTCTL0_FLEXSPI0_OTFAD_FLEXSPI0_OTFAD_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL0_PRSTCTL0_FLEXSPI0_OTFAD_FLEXSPI0_OTFAD_SET = 1,
+} RT500_RSTCTL0_PRSTCTL0_FLEXSPI0_OTFAD_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL0_PRSTCTL0_FLEXSPI1_FLEXSPI1_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL0_PRSTCTL0_FLEXSPI1_FLEXSPI1_SET = 1,
+} RT500_RSTCTL0_PRSTCTL0_FLEXSPI1_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL0_PRSTCTL0_USBHS_PHY_USBHS_PHY_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL0_PRSTCTL0_USBHS_PHY_USBHS_PHY_SET = 1,
+} RT500_RSTCTL0_PRSTCTL0_USBHS_PHY_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL0_PRSTCTL0_USBHS_DEVICE_USBHS_DEVICE_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL0_PRSTCTL0_USBHS_DEVICE_USBHS_DEVICE_SET = 1,
+} RT500_RSTCTL0_PRSTCTL0_USBHS_DEVICE_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL0_PRSTCTL0_USBHS_HOST_USBHS_HOST_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL0_PRSTCTL0_USBHS_HOST_USBHS_HOST_SET = 1,
+} RT500_RSTCTL0_PRSTCTL0_USBHS_HOST_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL0_PRSTCTL0_USBHS_SRAM_USBHS_SRAM_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL0_PRSTCTL0_USBHS_SRAM_USBHS_SRAM_SET = 1,
+} RT500_RSTCTL0_PRSTCTL0_USBHS_SRAM_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL0_PRSTCTL0_SCT_SCT_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL0_PRSTCTL0_SCT_SCT_SET = 1,
+} RT500_RSTCTL0_PRSTCTL0_SCT_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL0_PRSTCTL0_GPU_GPU_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL0_PRSTCTL0_GPU_GPU_SET = 1,
+} RT500_RSTCTL0_PRSTCTL0_GPU_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL0_PRSTCTL0_DISPLAY_CONTROLLER_DISPLAY_CONTROLLER_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL0_PRSTCTL0_DISPLAY_CONTROLLER_DISPLAY_CONTROLLER_SET = 1,
+} RT500_RSTCTL0_PRSTCTL0_DISPLAY_CONTROLLER_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL0_PRSTCTL0_MIPI_DSI_CONTROLLER_MIPI_DSI_CONTROLLER_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL0_PRSTCTL0_MIPI_DSI_CONTROLLER_MIPI_DSI_CONTROLLER_SET = 1,
+} RT500_RSTCTL0_PRSTCTL0_MIPI_DSI_CONTROLLER_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL0_PRSTCTL0_MIPI_DSI_PHY_MIPI_DSI_PHY_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL0_PRSTCTL0_MIPI_DSI_PHY_MIPI_DSI_PHY_SET = 1,
+} RT500_RSTCTL0_PRSTCTL0_MIPI_DSI_PHY_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL0_PRSTCTL0_SMARTDMA_SMARTDMA_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL0_PRSTCTL0_SMARTDMA_SMARTDMA_SET = 1,
+} RT500_RSTCTL0_PRSTCTL0_SMARTDMA_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL0_PRSTCTL1_SDIO0_SDIO0_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL0_PRSTCTL1_SDIO0_SDIO0_SET = 1,
+} RT500_RSTCTL0_PRSTCTL1_SDIO0_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL0_PRSTCTL1_SDIO1_SDIO1_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL0_PRSTCTL1_SDIO1_SDIO1_SET = 1,
+} RT500_RSTCTL0_PRSTCTL1_SDIO1_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL0_PRSTCTL1_ACMP0_ACMP0_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL0_PRSTCTL1_ACMP0_ACMP0_SET = 1,
+} RT500_RSTCTL0_PRSTCTL1_ACMP0_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL0_PRSTCTL1_ADC0_ADC0_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL0_PRSTCTL1_ADC0_ADC0_SET = 1,
+} RT500_RSTCTL0_PRSTCTL1_ADC0_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL0_PRSTCTL1_SHSGPIO0_SHSGPIO0_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL0_PRSTCTL1_SHSGPIO0_SHSGPIO0_SET = 1,
+} RT500_RSTCTL0_PRSTCTL1_SHSGPIO0_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL0_PRSTCTL2_UTICK0_UTICK0_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL0_PRSTCTL2_UTICK0_UTICK0_SET = 1,
+} RT500_RSTCTL0_PRSTCTL2_UTICK0_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL0_PRSTCTL2_WWDT0_WWDT0_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL0_PRSTCTL2_WWDT0_WWDT0_SET = 1,
+} RT500_RSTCTL0_PRSTCTL2_WWDT0_Enum;
+
+typedef enum {
+    /* No Effect */
+    RT500_RSTCTL0_PRSTCTL0_SET_DSP_DSP_CLR = 0,
+    /* Sets the PRSTCTL0 Bit */
+    RT500_RSTCTL0_PRSTCTL0_SET_DSP_DSP_SET = 1,
+} RT500_RSTCTL0_PRSTCTL0_SET_DSP_Enum;
+
+typedef enum {
+    /* No Effect */
+    RT500_RSTCTL0_PRSTCTL0_SET_AXI_SWITCH_AXI_SWITCH_CLR = 0,
+    /* Sets the PRSTCTL0 Bit */
+    RT500_RSTCTL0_PRSTCTL0_SET_AXI_SWITCH_AXI_SWITCH_SET = 1,
+} RT500_RSTCTL0_PRSTCTL0_SET_AXI_SWITCH_Enum;
+
+typedef enum {
+    /* No Effect */
+    RT500_RSTCTL0_PRSTCTL0_SET_POWERQUAD_POWERQUAD_CLR = 0,
+    /* Sets the PRSTCTL0 Bit */
+    RT500_RSTCTL0_PRSTCTL0_SET_POWERQUAD_POWERQUAD_SET = 1,
+} RT500_RSTCTL0_PRSTCTL0_SET_POWERQUAD_Enum;
+
+typedef enum {
+    /* No Effect */
+    RT500_RSTCTL0_PRSTCTL0_SET_CASPER_CASPER_CLR = 0,
+    /* Sets the PRSTCTL0 Bit */
+    RT500_RSTCTL0_PRSTCTL0_SET_CASPER_CASPER_SET = 1,
+} RT500_RSTCTL0_PRSTCTL0_SET_CASPER_Enum;
+
+typedef enum {
+    /* No Effect */
+    RT500_RSTCTL0_PRSTCTL0_SET_HASHCRYPT_HASHCRYPT_CLR = 0,
+    /* Sets the PRSTCTL0 Bit */
+    RT500_RSTCTL0_PRSTCTL0_SET_HASHCRYPT_HASHCRYPT_SET = 1,
+} RT500_RSTCTL0_PRSTCTL0_SET_HASHCRYPT_Enum;
+
+typedef enum {
+    /* No Effect */
+    RT500_RSTCTL0_PRSTCTL0_SET_PUF_PUF_CLR = 0,
+    /* Sets the PRSTCTL0 Bit */
+    RT500_RSTCTL0_PRSTCTL0_SET_PUF_PUF_SET = 1,
+} RT500_RSTCTL0_PRSTCTL0_SET_PUF_Enum;
+
+typedef enum {
+    /* No Effect */
+    RT500_RSTCTL0_PRSTCTL0_SET_RNG_RNG_CLR = 0,
+    /* Sets the PRSTCTL0 Bit */
+    RT500_RSTCTL0_PRSTCTL0_SET_RNG_RNG_SET = 1,
+} RT500_RSTCTL0_PRSTCTL0_SET_RNG_Enum;
+
+typedef enum {
+    /* No Effect */
+    RT500_RSTCTL0_PRSTCTL0_SET_FLEXSPI0_OTFAD_FLEXSPI0_OTFAD_CLR = 0,
+    /* Sets the PRSTCTL0 Bit */
+    RT500_RSTCTL0_PRSTCTL0_SET_FLEXSPI0_OTFAD_FLEXSPI0_OTFAD_SET = 1,
+} RT500_RSTCTL0_PRSTCTL0_SET_FLEXSPI0_OTFAD_Enum;
+
+typedef enum {
+    /* No Effect */
+    RT500_RSTCTL0_PRSTCTL0_SET_FLEXSPI1_FLEXSPI1_CLR = 0,
+    /* Sets the PRSTCTL0 Bit */
+    RT500_RSTCTL0_PRSTCTL0_SET_FLEXSPI1_FLEXSPI1_SET = 1,
+} RT500_RSTCTL0_PRSTCTL0_SET_FLEXSPI1_Enum;
+
+typedef enum {
+    /* No Effect */
+    RT500_RSTCTL0_PRSTCTL0_SET_USBHS_PHY_USBHS_PHY_CLR = 0,
+    /* Sets the PRSTCTL0 Bit */
+    RT500_RSTCTL0_PRSTCTL0_SET_USBHS_PHY_USBHS_PHY_SET = 1,
+} RT500_RSTCTL0_PRSTCTL0_SET_USBHS_PHY_Enum;
+
+typedef enum {
+    /* No Effect */
+    RT500_RSTCTL0_PRSTCTL0_SET_USBHS_DEVICE_USBHS_DEVICE_CLR = 0,
+    /* Sets the PRSTCTL0 Bit */
+    RT500_RSTCTL0_PRSTCTL0_SET_USBHS_DEVICE_USBHS_DEVICE_SET = 1,
+} RT500_RSTCTL0_PRSTCTL0_SET_USBHS_DEVICE_Enum;
+
+typedef enum {
+    /* No Effect */
+    RT500_RSTCTL0_PRSTCTL0_SET_USBHS_HOST_USBHS_HOST_CLR = 0,
+    /* Sets the PRSTCTL0 Bit */
+    RT500_RSTCTL0_PRSTCTL0_SET_USBHS_HOST_USBHS_HOST_SET = 1,
+} RT500_RSTCTL0_PRSTCTL0_SET_USBHS_HOST_Enum;
+
+typedef enum {
+    /* No Effect */
+    RT500_RSTCTL0_PRSTCTL0_SET_USBHS_SRAM_USBHS_SRAM_CLR = 0,
+    /* Sets the PRSTCTL0 Bit */
+    RT500_RSTCTL0_PRSTCTL0_SET_USBHS_SRAM_USBHS_SRAM_SET = 1,
+} RT500_RSTCTL0_PRSTCTL0_SET_USBHS_SRAM_Enum;
+
+typedef enum {
+    /* No Effect */
+    RT500_RSTCTL0_PRSTCTL0_SET_SCT_SCT_CLR = 0,
+    /* Sets the PRSTCTL0 Bit */
+    RT500_RSTCTL0_PRSTCTL0_SET_SCT_SCT_SET = 1,
+} RT500_RSTCTL0_PRSTCTL0_SET_SCT_Enum;
+
+typedef enum {
+    /* No Effect */
+    RT500_RSTCTL0_PRSTCTL0_SET_GPU_GPU_CLR = 0,
+    /* Sets the PRSTCTL0 Bit */
+    RT500_RSTCTL0_PRSTCTL0_SET_GPU_GPU_SET = 1,
+} RT500_RSTCTL0_PRSTCTL0_SET_GPU_Enum;
+
+typedef enum {
+    /* No Effect */
+    RT500_RSTCTL0_PRSTCTL0_SET_DISPLAY_CONTROLLER_DISPLAY_CONTROLLER_CLR = 0,
+    /* Sets the PRSTCTL0 Bit */
+    RT500_RSTCTL0_PRSTCTL0_SET_DISPLAY_CONTROLLER_DISPLAY_CONTROLLER_SET = 1,
+} RT500_RSTCTL0_PRSTCTL0_SET_DISPLAY_CONTROLLER_Enum;
+
+typedef enum {
+    /* No Effect */
+    RT500_RSTCTL0_PRSTCTL0_SET_MIPI_DSI_CONTROLLER_MIPI_DSI_CONTROLLER_CLR = 0,
+    /* Sets the PRSTCTL0 Bit */
+    RT500_RSTCTL0_PRSTCTL0_SET_MIPI_DSI_CONTROLLER_MIPI_DSI_CONTROLLER_SET = 1,
+} RT500_RSTCTL0_PRSTCTL0_SET_MIPI_DSI_CONTROLLER_Enum;
+
+typedef enum {
+    /* No Effect */
+    RT500_RSTCTL0_PRSTCTL0_SET_MIPI_DSI_PHY_MIPI_DSI_PHY_CLR = 0,
+    /* Sets the PRSTCTL0 Bit */
+    RT500_RSTCTL0_PRSTCTL0_SET_MIPI_DSI_PHY_MIPI_DSI_PHY_SET = 1,
+} RT500_RSTCTL0_PRSTCTL0_SET_MIPI_DSI_PHY_Enum;
+
+typedef enum {
+    /* No Effect */
+    RT500_RSTCTL0_PRSTCTL0_SET_SMARTDMA_SMARTDMA_CLR = 0,
+    /* Sets the PRSTCTL0 Bit */
+    RT500_RSTCTL0_PRSTCTL0_SET_SMARTDMA_SMARTDMA_SET = 1,
+} RT500_RSTCTL0_PRSTCTL0_SET_SMARTDMA_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL0_PRSTCTL1_SET_SDIO0_SDIO0_CLR = 0,
+    /* Sets the PRSTCTL1 Bit */
+    RT500_RSTCTL0_PRSTCTL1_SET_SDIO0_SDIO0_SET = 1,
+} RT500_RSTCTL0_PRSTCTL1_SET_SDIO0_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL0_PRSTCTL1_SET_SDIO1_SDIO1_CLR = 0,
+    /* Sets the PRSTCTL1 Bit */
+    RT500_RSTCTL0_PRSTCTL1_SET_SDIO1_SDIO1_SET = 1,
+} RT500_RSTCTL0_PRSTCTL1_SET_SDIO1_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL0_PRSTCTL1_SET_ACMP0_ACMP0_CLR = 0,
+    /* Sets the PRSTCTL1 Bit */
+    RT500_RSTCTL0_PRSTCTL1_SET_ACMP0_ACMP0_SET = 1,
+} RT500_RSTCTL0_PRSTCTL1_SET_ACMP0_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL0_PRSTCTL1_SET_ADC0_ADC0_CLR = 0,
+    /* Sets the PRSTCTL1 Bit */
+    RT500_RSTCTL0_PRSTCTL1_SET_ADC0_ADC0_SET = 1,
+} RT500_RSTCTL0_PRSTCTL1_SET_ADC0_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL0_PRSTCTL1_SET_SHSGPIO0_SHSGPIO0_CLR = 0,
+    /* Sets the PRSTCTL1 Bit */
+    RT500_RSTCTL0_PRSTCTL1_SET_SHSGPIO0_SHSGPIO0_SET = 1,
+} RT500_RSTCTL0_PRSTCTL1_SET_SHSGPIO0_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL0_PRSTCTL2_SET_UTICK0_UTICK0_CLR = 0,
+    /* Sets the PRSTCTL2 Bit */
+    RT500_RSTCTL0_PRSTCTL2_SET_UTICK0_UTICK0_SET = 1,
+} RT500_RSTCTL0_PRSTCTL2_SET_UTICK0_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL0_PRSTCTL2_SET_WWDT0_WWDT0_CLR = 0,
+    /* Sets the PRSTCTL2 Bit */
+    RT500_RSTCTL0_PRSTCTL2_SET_WWDT0_WWDT0_SET = 1,
+} RT500_RSTCTL0_PRSTCTL2_SET_WWDT0_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL0_PRSTCTL0_CLR_DSP_DSP_CLR = 0,
+    /* Clears the PRSTCTL0 Bit */
+    RT500_RSTCTL0_PRSTCTL0_CLR_DSP_DSP_SET = 1,
+} RT500_RSTCTL0_PRSTCTL0_CLR_DSP_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL0_PRSTCTL0_CLR_AXI_SWITCH_AXI_SWITCH_CLR = 0,
+    /* Clears the PRSTCTL0 Bit */
+    RT500_RSTCTL0_PRSTCTL0_CLR_AXI_SWITCH_AXI_SWITCH_SET = 1,
+} RT500_RSTCTL0_PRSTCTL0_CLR_AXI_SWITCH_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL0_PRSTCTL0_CLR_POWERQUAD_POWERQUAD_CLR = 0,
+    /* Clears the PRSTCTL0 Bit */
+    RT500_RSTCTL0_PRSTCTL0_CLR_POWERQUAD_POWERQUAD_SET = 1,
+} RT500_RSTCTL0_PRSTCTL0_CLR_POWERQUAD_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL0_PRSTCTL0_CLR_CASPER_CASPER_CLR = 0,
+    /* Clears the PRSTCTL0 Bit */
+    RT500_RSTCTL0_PRSTCTL0_CLR_CASPER_CASPER_SET = 1,
+} RT500_RSTCTL0_PRSTCTL0_CLR_CASPER_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL0_PRSTCTL0_CLR_HASHCRYPT_HASHCRYPT_CLR = 0,
+    /* Clears the PRSTCTL0 Bit */
+    RT500_RSTCTL0_PRSTCTL0_CLR_HASHCRYPT_HASHCRYPT_SET = 1,
+} RT500_RSTCTL0_PRSTCTL0_CLR_HASHCRYPT_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL0_PRSTCTL0_CLR_PUF_PUF_CLR = 0,
+    /* Clears the PRSTCTL0 Bit */
+    RT500_RSTCTL0_PRSTCTL0_CLR_PUF_PUF_SET = 1,
+} RT500_RSTCTL0_PRSTCTL0_CLR_PUF_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL0_PRSTCTL0_CLR_RNG_RNG_CLR = 0,
+    /* Clears the PRSTCTL0 Bit */
+    RT500_RSTCTL0_PRSTCTL0_CLR_RNG_RNG_SET = 1,
+} RT500_RSTCTL0_PRSTCTL0_CLR_RNG_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL0_PRSTCTL0_CLR_FLEXSPI0_OTFAD_FLEXSPI0_OTFAD_CLR = 0,
+    /* Clears the PRSTCTL0 Bit */
+    RT500_RSTCTL0_PRSTCTL0_CLR_FLEXSPI0_OTFAD_FLEXSPI0_OTFAD_SET = 1,
+} RT500_RSTCTL0_PRSTCTL0_CLR_FLEXSPI0_OTFAD_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL0_PRSTCTL0_CLR_FLEXSPI1_FLEXSPI1_CLR = 0,
+    /* Clears the PRSTCTL0 Bit */
+    RT500_RSTCTL0_PRSTCTL0_CLR_FLEXSPI1_FLEXSPI1_SET = 1,
+} RT500_RSTCTL0_PRSTCTL0_CLR_FLEXSPI1_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL0_PRSTCTL0_CLR_USBHS_PHY_USBHS_PHY_CLR = 0,
+    /* Clears the PRSTCTL0 Bit */
+    RT500_RSTCTL0_PRSTCTL0_CLR_USBHS_PHY_USBHS_PHY_SET = 1,
+} RT500_RSTCTL0_PRSTCTL0_CLR_USBHS_PHY_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL0_PRSTCTL0_CLR_USBHS_DEVICE_USBHS_DEVICE_CLR = 0,
+    /* Clears the PRSTCTL0 Bit */
+    RT500_RSTCTL0_PRSTCTL0_CLR_USBHS_DEVICE_USBHS_DEVICE_SET = 1,
+} RT500_RSTCTL0_PRSTCTL0_CLR_USBHS_DEVICE_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL0_PRSTCTL0_CLR_USBHS_HOST_USBHS_HOST_CLR = 0,
+    /* Clears the PRSTCTL0 Bit */
+    RT500_RSTCTL0_PRSTCTL0_CLR_USBHS_HOST_USBHS_HOST_SET = 1,
+} RT500_RSTCTL0_PRSTCTL0_CLR_USBHS_HOST_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL0_PRSTCTL0_CLR_USBHS_SRAM_USBHS_SRAM_CLR = 0,
+    /* Clears the PRSTCTL0 Bit */
+    RT500_RSTCTL0_PRSTCTL0_CLR_USBHS_SRAM_USBHS_SRAM_SET = 1,
+} RT500_RSTCTL0_PRSTCTL0_CLR_USBHS_SRAM_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL0_PRSTCTL0_CLR_SCT_SCT_CLR = 0,
+    /* Clears the PRSTCTL0 Bit */
+    RT500_RSTCTL0_PRSTCTL0_CLR_SCT_SCT_SET = 1,
+} RT500_RSTCTL0_PRSTCTL0_CLR_SCT_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL0_PRSTCTL0_CLR_GPU_GPU_CLR = 0,
+    /* Clears the PRSTCTL0 Bit */
+    RT500_RSTCTL0_PRSTCTL0_CLR_GPU_GPU_SET = 1,
+} RT500_RSTCTL0_PRSTCTL0_CLR_GPU_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL0_PRSTCTL0_CLR_DISPLAY_CONTROLLER_DISPLAY_CONTROLLER_CLR = 0,
+    /* Clears the PRSTCTL0 Bit */
+    RT500_RSTCTL0_PRSTCTL0_CLR_DISPLAY_CONTROLLER_DISPLAY_CONTROLLER_SET = 1,
+} RT500_RSTCTL0_PRSTCTL0_CLR_DISPLAY_CONTROLLER_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL0_PRSTCTL0_CLR_MIPI_DSI_CONTROLLER_MIPI_DSI_CONTROLLER_CLR = 0,
+    /* Clears the PRSTCTL0 Bit */
+    RT500_RSTCTL0_PRSTCTL0_CLR_MIPI_DSI_CONTROLLER_MIPI_DSI_CONTROLLER_SET = 1,
+} RT500_RSTCTL0_PRSTCTL0_CLR_MIPI_DSI_CONTROLLER_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL0_PRSTCTL0_CLR_MIPI_DSI_PHY_MIPI_DSI_PHY_CLR = 0,
+    /* Clears the PRSTCTL0 Bit */
+    RT500_RSTCTL0_PRSTCTL0_CLR_MIPI_DSI_PHY_MIPI_DSI_PHY_SET = 1,
+} RT500_RSTCTL0_PRSTCTL0_CLR_MIPI_DSI_PHY_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL0_PRSTCTL0_CLR_SMARTDMA_SMARTDMA_CLR = 0,
+    /* Clears the PRSTCTL0 Bit */
+    RT500_RSTCTL0_PRSTCTL0_CLR_SMARTDMA_SMARTDMA_SET = 1,
+} RT500_RSTCTL0_PRSTCTL0_CLR_SMARTDMA_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL0_PRSTCTL1_CLR_SDIO0_SDIO0_CLR = 0,
+    /* Clears the PRSTCTL1 Bit */
+    RT500_RSTCTL0_PRSTCTL1_CLR_SDIO0_SDIO0_SET = 1,
+} RT500_RSTCTL0_PRSTCTL1_CLR_SDIO0_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL0_PRSTCTL1_CLR_SDIO1_SDIO1_CLR = 0,
+    /* Clears the PRSTCTL1 Bit */
+    RT500_RSTCTL0_PRSTCTL1_CLR_SDIO1_SDIO1_SET = 1,
+} RT500_RSTCTL0_PRSTCTL1_CLR_SDIO1_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL0_PRSTCTL1_CLR_ACMP0_ACMP0_CLR = 0,
+    /* Clears the PRSTCTL1 Bit */
+    RT500_RSTCTL0_PRSTCTL1_CLR_ACMP0_ACMP0_SET = 1,
+} RT500_RSTCTL0_PRSTCTL1_CLR_ACMP0_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL0_PRSTCTL1_CLR_ADC0_ADC0_CLR = 0,
+    /* Clears the PRSTCTL1 Bit */
+    RT500_RSTCTL0_PRSTCTL1_CLR_ADC0_ADC0_SET = 1,
+} RT500_RSTCTL0_PRSTCTL1_CLR_ADC0_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL0_PRSTCTL1_CLR_SHSGPIO0_SHSGPIO0_CLR = 0,
+    /* Clears the PRSTCTL1 Bit */
+    RT500_RSTCTL0_PRSTCTL1_CLR_SHSGPIO0_SHSGPIO0_SET = 1,
+} RT500_RSTCTL0_PRSTCTL1_CLR_SHSGPIO0_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL0_PRSTCTL2_CLR_UTICK0_UTICK0_CLR = 0,
+    /* Clears the PRSTCTL2 Bit */
+    RT500_RSTCTL0_PRSTCTL2_CLR_UTICK0_UTICK0_SET = 1,
+} RT500_RSTCTL0_PRSTCTL2_CLR_UTICK0_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL0_PRSTCTL2_CLR_WWDT0_WWDT0_CLR = 0,
+    /* Clears the PRSTCTL2 Bit */
+    RT500_RSTCTL0_PRSTCTL2_CLR_WWDT0_WWDT0_SET = 1,
+} RT500_RSTCTL0_PRSTCTL2_CLR_WWDT0_Enum;
+
+
+#define RT500_RSTCTL0_REGISTER_NAMES_ARRAY(_name) \
+    const char *_name[RT500_RSTCTL0_REGS_NO] = { \
+        [R_RT500_RSTCTL0_SYSRSTSTAT] = "SYSRSTSTAT", \
+        [R_RT500_RSTCTL0_PRSTCTL0] = "PRSTCTL0", \
+        [R_RT500_RSTCTL0_PRSTCTL1] = "PRSTCTL1", \
+        [R_RT500_RSTCTL0_PRSTCTL2] = "PRSTCTL2", \
+        [R_RT500_RSTCTL0_PRSTCTL0_SET] = "PRSTCTL0_SET", \
+        [R_RT500_RSTCTL0_PRSTCTL1_SET] = "PRSTCTL1_SET", \
+        [R_RT500_RSTCTL0_PRSTCTL2_SET] = "PRSTCTL2_SET", \
+        [R_RT500_RSTCTL0_PRSTCTL0_CLR] = "PRSTCTL0_CLR", \
+        [R_RT500_RSTCTL0_PRSTCTL1_CLR] = "PRSTCTL1_CLR", \
+        [R_RT500_RSTCTL0_PRSTCTL2_CLR] = "PRSTCTL2_CLR", \
+    }
+
+#define RT500_RSTCTL0_REGISTER_WMASK_ARRAY(_name) \
+    const uint32_t _name[RT500_RSTCTL0_REGS_NO] = { \
+        [R_RT500_RSTCTL0_SYSRSTSTAT] = 0xF1, \
+        [R_RT500_RSTCTL0_PRSTCTL0] = 0x7DF51F0A, \
+        [R_RT500_RSTCTL0_PRSTCTL1] = 0x101800C, \
+        [R_RT500_RSTCTL0_PRSTCTL2] = 0x3, \
+        [R_RT500_RSTCTL0_PRSTCTL0_SET] = 0x7DF51F0A, \
+        [R_RT500_RSTCTL0_PRSTCTL1_SET] = 0x101800C, \
+        [R_RT500_RSTCTL0_PRSTCTL2_SET] = 0x3, \
+        [R_RT500_RSTCTL0_PRSTCTL0_CLR] = 0x7DF51F0A, \
+        [R_RT500_RSTCTL0_PRSTCTL1_CLR] = 0x101800C, \
+        [R_RT500_RSTCTL0_PRSTCTL2_CLR] = 0x3, \
+    }
+
+static inline void rt500_rstctl0_reset_registers(uint32_t *regs)
+{
+    regs[R_RT500_RSTCTL0_SYSRSTSTAT] = 0x1;
+    regs[R_RT500_RSTCTL0_PRSTCTL0] = 0x7df51f0a;
+    regs[R_RT500_RSTCTL0_PRSTCTL1] = 0x101800c;
+    regs[R_RT500_RSTCTL0_PRSTCTL2] = 0x1c000001;
+    regs[R_RT500_RSTCTL0_PRSTCTL0_SET] = 0x0;
+    regs[R_RT500_RSTCTL0_PRSTCTL1_SET] = 0x0;
+    regs[R_RT500_RSTCTL0_PRSTCTL2_SET] = 0x0;
+    regs[R_RT500_RSTCTL0_PRSTCTL0_CLR] = 0x0;
+    regs[R_RT500_RSTCTL0_PRSTCTL1_CLR] = 0x0;
+    regs[R_RT500_RSTCTL0_PRSTCTL2_CLR] = 0x0;
+}
diff --git a/include/hw/arm/svd/rt500_rstctl1.h b/include/hw/arm/svd/rt500_rstctl1.h
new file mode 100644
index 0000000000..b3f6f31356
--- /dev/null
+++ b/include/hw/arm/svd/rt500_rstctl1.h
@@ -0,0 +1,1344 @@
+/*
+ * Copyright 2016-2023 NXP SPDX-License-Identifier: BSD-3-Clause
+ *
+ * Automatically generated by svd-gen-header.py from MIMXRT595S_cm33.xml
+ */
+#pragma once
+
+#include "hw/registerfields.h"
+
+/* Reset Controller 1 */
+#define RT500_RSTCTL1_REGS_NO (31)
+
+/* System Reset Status Register */
+REG32(RT500_RSTCTL1_SYSRSTSTAT, 0);
+/* VDD Power-On Reset (POR) was detected */
+FIELD(RT500_RSTCTL1_SYSRSTSTAT, VDD_POR, 0, 1);
+/* RESETN pin reset was detected */
+FIELD(RT500_RSTCTL1_SYSRSTSTAT, PAD_RESET, 4, 1);
+/* ARM reset was detected */
+FIELD(RT500_RSTCTL1_SYSRSTSTAT, ARM_RESET, 5, 1);
+/* WDT0 reset was detected */
+FIELD(RT500_RSTCTL1_SYSRSTSTAT, WDT0_RESET, 6, 1);
+/* WDT1 reset was detected */
+FIELD(RT500_RSTCTL1_SYSRSTSTAT, WDT1_RESET, 7, 1);
+
+/* Peripheral Reset Control Register 0 */
+REG32(RT500_RSTCTL1_PRSTCTL0, 16);
+/* Flexcomm0 reset control */
+FIELD(RT500_RSTCTL1_PRSTCTL0, FLEXCOMM0, 8, 1);
+/* Flexcomm1 reset control */
+FIELD(RT500_RSTCTL1_PRSTCTL0, FLEXCOMM1, 9, 1);
+/* Flexcomm2 reset control */
+FIELD(RT500_RSTCTL1_PRSTCTL0, FLEXCOMM2, 10, 1);
+/* Flexcomm3 reset control */
+FIELD(RT500_RSTCTL1_PRSTCTL0, FLEXCOMM3, 11, 1);
+/* Flexcomm4 reset control */
+FIELD(RT500_RSTCTL1_PRSTCTL0, FLEXCOMM4, 12, 1);
+/* Flexcomm5 reset control */
+FIELD(RT500_RSTCTL1_PRSTCTL0, FLEXCOMM5, 13, 1);
+/* Flexcomm6 reset control */
+FIELD(RT500_RSTCTL1_PRSTCTL0, FLEXCOMM6, 14, 1);
+/* Flexcomm7 reset control */
+FIELD(RT500_RSTCTL1_PRSTCTL0, FLEXCOMM7, 15, 1);
+/* Flexcomm8 reset control */
+FIELD(RT500_RSTCTL1_PRSTCTL0, FLEXCOMM8, 16, 1);
+/* Flexcomm9 reset control */
+FIELD(RT500_RSTCTL1_PRSTCTL0, FLEXCOMM9, 17, 1);
+/* Flexcomm10 reset control */
+FIELD(RT500_RSTCTL1_PRSTCTL0, FLEXCOMM10, 18, 1);
+/* Flexcomm11 reset control */
+FIELD(RT500_RSTCTL1_PRSTCTL0, FLEXCOMM11, 19, 1);
+/* Flexcomm12 reset control */
+FIELD(RT500_RSTCTL1_PRSTCTL0, FLEXCOMM12, 20, 1);
+/* Flexcomm13 reset control */
+FIELD(RT500_RSTCTL1_PRSTCTL0, FLEXCOMM13, 21, 1);
+/* Flexcomm14 SPI0 reset control */
+FIELD(RT500_RSTCTL1_PRSTCTL0, FLEXCOMM14, 22, 1);
+/* Flexcomm15 I2C reset control */
+FIELD(RT500_RSTCTL1_PRSTCTL0, FLEXCOMM15_I2C, 23, 1);
+/* DMIC0 reset control */
+FIELD(RT500_RSTCTL1_PRSTCTL0, DMIC0, 24, 1);
+/* Flexcomm SPI reset control */
+FIELD(RT500_RSTCTL1_PRSTCTL0, FLEXCOMM16, 25, 1);
+/* OSEVENT Timer reset control */
+FIELD(RT500_RSTCTL1_PRSTCTL0, OSEVENT_TIMER, 27, 1);
+/* FLEXIO reset control */
+FIELD(RT500_RSTCTL1_PRSTCTL0, FLEXIO, 29, 1);
+
+/* Peripheral Reset Control Register 1 */
+REG32(RT500_RSTCTL1_PRSTCTL1, 20);
+/* HSGPIO[7:0] reset control */
+FIELD(RT500_RSTCTL1_PRSTCTL1, HSGPIO0, 0, 1);
+/* HSGPIO[7:0] reset control */
+FIELD(RT500_RSTCTL1_PRSTCTL1, HSGPIO1, 1, 1);
+/* HSGPIO[7:0] reset control */
+FIELD(RT500_RSTCTL1_PRSTCTL1, HSGPIO2, 2, 1);
+/* HSGPIO[7:0] reset control */
+FIELD(RT500_RSTCTL1_PRSTCTL1, HSGPIO3, 3, 1);
+/* HSGPIO[7:0] reset control */
+FIELD(RT500_RSTCTL1_PRSTCTL1, HSGPIO4, 4, 1);
+/* HSGPIO[7:0] reset control */
+FIELD(RT500_RSTCTL1_PRSTCTL1, HSGPIO5, 5, 1);
+/* HSGPIO[7:0] reset control */
+FIELD(RT500_RSTCTL1_PRSTCTL1, HSGPIO6, 6, 1);
+/* HSGPIO[7:0] reset control */
+FIELD(RT500_RSTCTL1_PRSTCTL1, HSGPIO7, 7, 1);
+/* CRC reset control */
+FIELD(RT500_RSTCTL1_PRSTCTL1, CRC, 16, 1);
+/* DMAC reset control */
+FIELD(RT500_RSTCTL1_PRSTCTL1, DMAC0, 23, 1);
+/* DMAC reset control */
+FIELD(RT500_RSTCTL1_PRSTCTL1, DMAC1, 24, 1);
+/* MU reset control */
+FIELD(RT500_RSTCTL1_PRSTCTL1, MU, 28, 1);
+/* SEMA reset control */
+FIELD(RT500_RSTCTL1_PRSTCTL1, SEMA, 29, 1);
+/* FREQME reset control */
+FIELD(RT500_RSTCTL1_PRSTCTL1, FREQME, 31, 1);
+
+/* Peripheral Reset Control Register 2 */
+REG32(RT500_RSTCTL1_PRSTCTL2, 24);
+/* CT32BIT[4:0] reset */
+FIELD(RT500_RSTCTL1_PRSTCTL2, CT32BIT0, 0, 1);
+/* CT32BIT[4:0] reset */
+FIELD(RT500_RSTCTL1_PRSTCTL2, CT32BIT1, 1, 1);
+/* CT32BIT[4:0] reset */
+FIELD(RT500_RSTCTL1_PRSTCTL2, CT32BIT2, 2, 1);
+/* CT32BIT[4:0] reset */
+FIELD(RT500_RSTCTL1_PRSTCTL2, CT32BIT3, 3, 1);
+/* CT32BIT[4:0] reset */
+FIELD(RT500_RSTCTL1_PRSTCTL2, CT32BIT4, 4, 1);
+/* MRT0 reset control */
+FIELD(RT500_RSTCTL1_PRSTCTL2, MRT0, 8, 1);
+/* WWDT1 reset control */
+FIELD(RT500_RSTCTL1_PRSTCTL2, WWDT1, 10, 1);
+/* I3C0 reset control */
+FIELD(RT500_RSTCTL1_PRSTCTL2, I3C0, 16, 1);
+/* I3C1 reset control */
+FIELD(RT500_RSTCTL1_PRSTCTL2, I3C1, 17, 1);
+/* GPIOINTCTL reset control */
+FIELD(RT500_RSTCTL1_PRSTCTL2, GPIOINTCTL, 30, 1);
+/* INPUTMUX reset control */
+FIELD(RT500_RSTCTL1_PRSTCTL2, PIMCTL, 31, 1);
+
+/* Peripheral Reset Control Register 0 SET */
+REG32(RT500_RSTCTL1_PRSTCTL0_SET, 64);
+/* Flexcomm0 reset set */
+FIELD(RT500_RSTCTL1_PRSTCTL0_SET, FLEXCOMM0, 8, 1);
+/* Flexcomm1 reset set */
+FIELD(RT500_RSTCTL1_PRSTCTL0_SET, FLEXCOMM1, 9, 1);
+/* Flexcomm2 reset set */
+FIELD(RT500_RSTCTL1_PRSTCTL0_SET, FLEXCOMM2, 10, 1);
+/* Flexcomm3 reset set */
+FIELD(RT500_RSTCTL1_PRSTCTL0_SET, FLEXCOMM3, 11, 1);
+/* Flexcomm4 reset set */
+FIELD(RT500_RSTCTL1_PRSTCTL0_SET, FLEXCOMM4, 12, 1);
+/* Flexcomm5 reset set */
+FIELD(RT500_RSTCTL1_PRSTCTL0_SET, FLEXCOMM5, 13, 1);
+/* Flexcomm6 reset set */
+FIELD(RT500_RSTCTL1_PRSTCTL0_SET, FLEXCOMM6, 14, 1);
+/* Flexcomm7 reset set */
+FIELD(RT500_RSTCTL1_PRSTCTL0_SET, FLEXCOMM7, 15, 1);
+/* Flexcomm8 reset set */
+FIELD(RT500_RSTCTL1_PRSTCTL0_SET, FLEXCOMM8, 16, 1);
+/* Flexcomm9 reset set */
+FIELD(RT500_RSTCTL1_PRSTCTL0_SET, FLEXCOMM9, 17, 1);
+/* Flexcomm10 reset set */
+FIELD(RT500_RSTCTL1_PRSTCTL0_SET, FLEXCOMM10, 18, 1);
+/* Flexcomm11 reset set */
+FIELD(RT500_RSTCTL1_PRSTCTL0_SET, FLEXCOMM11, 19, 1);
+/* Flexcomm12 reset set */
+FIELD(RT500_RSTCTL1_PRSTCTL0_SET, FLEXCOMM12, 20, 1);
+/* Flexcomm13 reset set */
+FIELD(RT500_RSTCTL1_PRSTCTL0_SET, FLEXCOMM13, 21, 1);
+/* Flexcomm14 SPI0 reset set */
+FIELD(RT500_RSTCTL1_PRSTCTL0_SET, FLEXCOMM14, 22, 1);
+/* Flexcomm15 I2C reset set */
+FIELD(RT500_RSTCTL1_PRSTCTL0_SET, FLEXCOMM15_I2C, 23, 1);
+/* DMIC0 reset set */
+FIELD(RT500_RSTCTL1_PRSTCTL0_SET, DMIC0, 24, 1);
+/* Flexcomm16 SPI1 reset set */
+FIELD(RT500_RSTCTL1_PRSTCTL0_SET, FLEXCOMM16, 25, 1);
+/* OSEVENT Timer reset set */
+FIELD(RT500_RSTCTL1_PRSTCTL0_SET, OSEVENT_TIMER, 27, 1);
+/* FEXIO reset set */
+FIELD(RT500_RSTCTL1_PRSTCTL0_SET, FLEXIO, 29, 1);
+
+/* Peripheral Reset Control Register 1 SET */
+REG32(RT500_RSTCTL1_PRSTCTL1_SET, 68);
+/* HSGPIO0 reset set */
+FIELD(RT500_RSTCTL1_PRSTCTL1_SET, HSGPIO0, 0, 1);
+/* HSGPIO1 reset set */
+FIELD(RT500_RSTCTL1_PRSTCTL1_SET, HSGPIO1, 1, 1);
+/* HSGPIO2 reset set */
+FIELD(RT500_RSTCTL1_PRSTCTL1_SET, HSGPIO2, 2, 1);
+/* HSGPIO3 reset set */
+FIELD(RT500_RSTCTL1_PRSTCTL1_SET, HSGPIO3, 3, 1);
+/* HSGPIO4 reset set */
+FIELD(RT500_RSTCTL1_PRSTCTL1_SET, HSGPIO4, 4, 1);
+/* HSGPIO5 reset set */
+FIELD(RT500_RSTCTL1_PRSTCTL1_SET, HSGPIO5, 5, 1);
+/* HSGPIO6 reset set */
+FIELD(RT500_RSTCTL1_PRSTCTL1_SET, HSGPIO6, 6, 1);
+/* HSGPIO7 reset set */
+FIELD(RT500_RSTCTL1_PRSTCTL1_SET, HSGPIO7, 7, 1);
+/* CRC reset set */
+FIELD(RT500_RSTCTL1_PRSTCTL1_SET, CRC, 16, 1);
+/* DMAC0 reset set */
+FIELD(RT500_RSTCTL1_PRSTCTL1_SET, DMAC0, 23, 1);
+/* DMAC1 reset set */
+FIELD(RT500_RSTCTL1_PRSTCTL1_SET, DMAC1, 24, 1);
+/* MU reset set */
+FIELD(RT500_RSTCTL1_PRSTCTL1_SET, MU, 28, 1);
+/* SEMA reset set */
+FIELD(RT500_RSTCTL1_PRSTCTL1_SET, SEMA, 29, 1);
+/* FREQME reset set */
+FIELD(RT500_RSTCTL1_PRSTCTL1_SET, FREQME, 31, 1);
+
+/* Peripheral Reset Control Register 2 SET */
+REG32(RT500_RSTCTL1_PRSTCTL2_SET, 72);
+/* CT32BIT0 reset set */
+FIELD(RT500_RSTCTL1_PRSTCTL2_SET, CT32BIT0, 0, 1);
+/* CT32BIT1 reset set */
+FIELD(RT500_RSTCTL1_PRSTCTL2_SET, CT32BIT1, 1, 1);
+/* CT32BIT2 reset set */
+FIELD(RT500_RSTCTL1_PRSTCTL2_SET, CT32BIT2, 2, 1);
+/* CT32BIT3 reset set */
+FIELD(RT500_RSTCTL1_PRSTCTL2_SET, CT32BIT3, 3, 1);
+/* CT32BIT4 reset set */
+FIELD(RT500_RSTCTL1_PRSTCTL2_SET, CT32BIT4, 4, 1);
+/* MRT0 reset set */
+FIELD(RT500_RSTCTL1_PRSTCTL2_SET, MRT0, 8, 1);
+/* WWDT1 reset set */
+FIELD(RT500_RSTCTL1_PRSTCTL2_SET, WWDT1, 10, 1);
+/* I3C0 reset set */
+FIELD(RT500_RSTCTL1_PRSTCTL2_SET, I3C0, 16, 1);
+/* I3C1 reset set */
+FIELD(RT500_RSTCTL1_PRSTCTL2_SET, I3C1, 17, 1);
+/* GPIOINTCTL reset set */
+FIELD(RT500_RSTCTL1_PRSTCTL2_SET, GPIOINTCTL, 30, 1);
+/* PIMCTL reset set */
+FIELD(RT500_RSTCTL1_PRSTCTL2_SET, PIMCTL, 31, 1);
+
+/* Peripheral Reset Control Register 0 CLR */
+REG32(RT500_RSTCTL1_PRSTCTL0_CLR, 112);
+/* Flexcomm0 reset clear */
+FIELD(RT500_RSTCTL1_PRSTCTL0_CLR, FLEXCOMM0, 8, 1);
+/* Flexcomm1 reset clear */
+FIELD(RT500_RSTCTL1_PRSTCTL0_CLR, FLEXCOMM1, 9, 1);
+/* Flexcomm2 reset clear */
+FIELD(RT500_RSTCTL1_PRSTCTL0_CLR, FLEXCOMM2, 10, 1);
+/* Flexcomm3 reset clear */
+FIELD(RT500_RSTCTL1_PRSTCTL0_CLR, FLEXCOMM3, 11, 1);
+/* Flexcomm4 reset clear */
+FIELD(RT500_RSTCTL1_PRSTCTL0_CLR, FLEXCOMM4, 12, 1);
+/* Flexcomm5 reset clear */
+FIELD(RT500_RSTCTL1_PRSTCTL0_CLR, FLEXCOMM5, 13, 1);
+/* Flexcomm6 reset clear */
+FIELD(RT500_RSTCTL1_PRSTCTL0_CLR, FLEXCOMM6, 14, 1);
+/* Flexcomm7 reset clear */
+FIELD(RT500_RSTCTL1_PRSTCTL0_CLR, FLEXCOMM7, 15, 1);
+/* Flexcomm8 reset clear */
+FIELD(RT500_RSTCTL1_PRSTCTL0_CLR, FLEXCOMM8, 16, 1);
+/* Flexcomm9 reset clear */
+FIELD(RT500_RSTCTL1_PRSTCTL0_CLR, FLEXCOMM9, 17, 1);
+/* Flexcomm10 reset clear */
+FIELD(RT500_RSTCTL1_PRSTCTL0_CLR, FLEXCOMM10, 18, 1);
+/* Flexcomm11 reset clear */
+FIELD(RT500_RSTCTL1_PRSTCTL0_CLR, FLEXCOMM11, 19, 1);
+/* Flexcomm12 reset clear */
+FIELD(RT500_RSTCTL1_PRSTCTL0_CLR, FLEXCOMM12, 20, 1);
+/* Flexcomm13 reset clear */
+FIELD(RT500_RSTCTL1_PRSTCTL0_CLR, FLEXCOMM13, 21, 1);
+/* FLexcomm SPI0 reset clear */
+FIELD(RT500_RSTCTL1_PRSTCTL0_CLR, FLEXCOMM14, 22, 1);
+/* Flexcomm I2C reset clear */
+FIELD(RT500_RSTCTL1_PRSTCTL0_CLR, FLEXCOMM15_I2C, 23, 1);
+/* DMIC0 reset clear */
+FIELD(RT500_RSTCTL1_PRSTCTL0_CLR, DMIC0, 24, 1);
+/* Flexcomm SPI1 reset clear */
+FIELD(RT500_RSTCTL1_PRSTCTL0_CLR, FLEXCOMM16, 25, 1);
+/* OSEVENT Timer reset clear */
+FIELD(RT500_RSTCTL1_PRSTCTL0_CLR, OSEVENT_TIMER, 27, 1);
+/* FLEXIO reset clear */
+FIELD(RT500_RSTCTL1_PRSTCTL0_CLR, FLEXIO, 29, 1);
+
+/* Peripheral Reset Control Register 1 CLR */
+REG32(RT500_RSTCTL1_PRSTCTL1_CLR, 116);
+/* HSGPIO0 reset clear */
+FIELD(RT500_RSTCTL1_PRSTCTL1_CLR, HSGPIO0, 0, 1);
+/* HSGPIO1 reset clear */
+FIELD(RT500_RSTCTL1_PRSTCTL1_CLR, HSGPIO1, 1, 1);
+/* HSGPIO2 reset clear */
+FIELD(RT500_RSTCTL1_PRSTCTL1_CLR, HSGPIO2, 2, 1);
+/* HSGPIO3 reset clear */
+FIELD(RT500_RSTCTL1_PRSTCTL1_CLR, HSGPIO3, 3, 1);
+/* HSGPIO4 reset clear */
+FIELD(RT500_RSTCTL1_PRSTCTL1_CLR, HSGPIO4, 4, 1);
+/* HSGPIO5 reset clear */
+FIELD(RT500_RSTCTL1_PRSTCTL1_CLR, HSGPIO5, 5, 1);
+/* HSGPIO6 reset clear */
+FIELD(RT500_RSTCTL1_PRSTCTL1_CLR, HSGPIO6, 6, 1);
+/* HSGPIO7 reset clear */
+FIELD(RT500_RSTCTL1_PRSTCTL1_CLR, HSGPIO7, 7, 1);
+/* CRC reset clear */
+FIELD(RT500_RSTCTL1_PRSTCTL1_CLR, CRC, 16, 1);
+/* DMAC0 reset clear */
+FIELD(RT500_RSTCTL1_PRSTCTL1_CLR, DMAC0, 23, 1);
+/* DMAC1 reset clear */
+FIELD(RT500_RSTCTL1_PRSTCTL1_CLR, DMAC1, 24, 1);
+/* MU reset clear */
+FIELD(RT500_RSTCTL1_PRSTCTL1_CLR, MU, 28, 1);
+/* SMEA reset clear */
+FIELD(RT500_RSTCTL1_PRSTCTL1_CLR, SEMA, 29, 1);
+/* FREQME reset clear */
+FIELD(RT500_RSTCTL1_PRSTCTL1_CLR, FREQME, 31, 1);
+
+/* Peripheral Reset Control Register 2 CLR */
+REG32(RT500_RSTCTL1_PRSTCTL2_CLR, 120);
+/* CT32BIT0 reset clear */
+FIELD(RT500_RSTCTL1_PRSTCTL2_CLR, CT32BIT0, 0, 1);
+/* CT32BIT1 reset clear */
+FIELD(RT500_RSTCTL1_PRSTCTL2_CLR, CT32BIT1, 1, 1);
+/* CT32BIT2 reset clear */
+FIELD(RT500_RSTCTL1_PRSTCTL2_CLR, CT32BIT2, 2, 1);
+/* CT32BIT3 reset clear */
+FIELD(RT500_RSTCTL1_PRSTCTL2_CLR, CT32BIT3, 3, 1);
+/* CT32BIT4 reset clear */
+FIELD(RT500_RSTCTL1_PRSTCTL2_CLR, CT32BIT4, 4, 1);
+/* MRT0 reset clear */
+FIELD(RT500_RSTCTL1_PRSTCTL2_CLR, MRT0, 8, 1);
+/* WWDT1 reset clear */
+FIELD(RT500_RSTCTL1_PRSTCTL2_CLR, WWDT1, 10, 1);
+/* I3C[1:0] reset clear */
+FIELD(RT500_RSTCTL1_PRSTCTL2_CLR, I3C0, 16, 1);
+/* I3C[1:0] reset clear */
+FIELD(RT500_RSTCTL1_PRSTCTL2_CLR, I3C1, 17, 1);
+/* GPIOINTCTL reset clear */
+FIELD(RT500_RSTCTL1_PRSTCTL2_CLR, GPIOINTCTL, 30, 1);
+/* PIMCTL reset clear */
+FIELD(RT500_RSTCTL1_PRSTCTL2_CLR, PIMCTL, 31, 1);
+
+
+typedef enum {
+    /* No VDD POR event is detected */
+    RT500_RSTCTL1_SYSRSTSTAT_VDD_POR_VDD_POR_EVENT_IS_NOT_DETECTED = 0,
+    /* VDD POR event was detected */
+    RT500_RSTCTL1_SYSRSTSTAT_VDD_POR_VDD_POR_EVENT_WAS_DETECTED = 1,
+} RT500_RSTCTL1_SYSRSTSTAT_VDD_POR_Enum;
+
+typedef enum {
+    /* No RESETN pin event is detected */
+    RT500_RSTCTL1_SYSRSTSTAT_PAD_RESET_PAD_RESET_IS_NOT_DETECTED = 0,
+    /* RESETN pin reset event was detected */
+    RT500_RSTCTL1_SYSRSTSTAT_PAD_RESET_PAD_RESET_WAS_DETECTED = 1,
+} RT500_RSTCTL1_SYSRSTSTAT_PAD_RESET_Enum;
+
+typedef enum {
+    /* No ARM reset event is detected */
+    RT500_RSTCTL1_SYSRSTSTAT_ARM_RESET_ARM_RESET_IS_NOT_DETECTED = 0,
+    /* ARM reset was detected */
+    RT500_RSTCTL1_SYSRSTSTAT_ARM_RESET_ARM_RESET_WAS_DETECTED = 1,
+} RT500_RSTCTL1_SYSRSTSTAT_ARM_RESET_Enum;
+
+typedef enum {
+    /* No WDT0 reset event is detected */
+    RT500_RSTCTL1_SYSRSTSTAT_WDT0_RESET_WDT0_RESET_IS_NOT_DETECTED = 0,
+    /* WDT0 reset was detected */
+    RT500_RSTCTL1_SYSRSTSTAT_WDT0_RESET_WDT0_RESET_WAS_DETECTED = 1,
+} RT500_RSTCTL1_SYSRSTSTAT_WDT0_RESET_Enum;
+
+typedef enum {
+    /* No WDT1 reset event is detected */
+    RT500_RSTCTL1_SYSRSTSTAT_WDT1_RESET_WDT1_RESET_IS_NOT_DETECTED = 0,
+    /* WDT1 reset was detected */
+    RT500_RSTCTL1_SYSRSTSTAT_WDT1_RESET_WDT1_RESET_WAS_DETECTED = 1,
+} RT500_RSTCTL1_SYSRSTSTAT_WDT1_RESET_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL1_PRSTCTL0_FLEXCOMM0_FLEXCOMM_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL1_PRSTCTL0_FLEXCOMM0_FLEXCOMM_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_FLEXCOMM0_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL1_PRSTCTL0_FLEXCOMM1_FLEXCOMM_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL1_PRSTCTL0_FLEXCOMM1_FLEXCOMM_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_FLEXCOMM1_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL1_PRSTCTL0_FLEXCOMM2_FLEXCOMM_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL1_PRSTCTL0_FLEXCOMM2_FLEXCOMM_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_FLEXCOMM2_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL1_PRSTCTL0_FLEXCOMM3_FLEXCOMM_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL1_PRSTCTL0_FLEXCOMM3_FLEXCOMM_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_FLEXCOMM3_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL1_PRSTCTL0_FLEXCOMM4_FLEXCOMM_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL1_PRSTCTL0_FLEXCOMM4_FLEXCOMM_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_FLEXCOMM4_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL1_PRSTCTL0_FLEXCOMM5_FLEXCOMM_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL1_PRSTCTL0_FLEXCOMM5_FLEXCOMM_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_FLEXCOMM5_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL1_PRSTCTL0_FLEXCOMM6_FLEXCOMM_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL1_PRSTCTL0_FLEXCOMM6_FLEXCOMM_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_FLEXCOMM6_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL1_PRSTCTL0_FLEXCOMM7_FLEXCOMM_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL1_PRSTCTL0_FLEXCOMM7_FLEXCOMM_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_FLEXCOMM7_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL1_PRSTCTL0_FLEXCOMM8_FLEXCOMM_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL1_PRSTCTL0_FLEXCOMM8_FLEXCOMM_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_FLEXCOMM8_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL1_PRSTCTL0_FLEXCOMM9_FLEXCOMM_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL1_PRSTCTL0_FLEXCOMM9_FLEXCOMM_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_FLEXCOMM9_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL1_PRSTCTL0_FLEXCOMM10_FLEXCOMM_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL1_PRSTCTL0_FLEXCOMM10_FLEXCOMM_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_FLEXCOMM10_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL1_PRSTCTL0_FLEXCOMM11_FLEXCOMM_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL1_PRSTCTL0_FLEXCOMM11_FLEXCOMM_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_FLEXCOMM11_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL1_PRSTCTL0_FLEXCOMM12_FLEXCOMM_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL1_PRSTCTL0_FLEXCOMM12_FLEXCOMM_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_FLEXCOMM12_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL1_PRSTCTL0_FLEXCOMM13_FLEXCOMM_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL1_PRSTCTL0_FLEXCOMM13_FLEXCOMM_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_FLEXCOMM13_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL1_PRSTCTL0_FLEXCOMM14_FLEXCOMM_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL1_PRSTCTL0_FLEXCOMM14_FLEXCOMM_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_FLEXCOMM14_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL1_PRSTCTL0_FLEXCOMM15_I2C_FLEXCOMM15_I2C_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL1_PRSTCTL0_FLEXCOMM15_I2C_FLEXCOMM15_I2C_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_FLEXCOMM15_I2C_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL1_PRSTCTL0_DMIC0_DMIC0_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL1_PRSTCTL0_DMIC0_DMIC0_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_DMIC0_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL1_PRSTCTL0_FLEXCOMM16_FLEXCOMM16_SPI1_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL1_PRSTCTL0_FLEXCOMM16_FLEXCOMM16_SPI1_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_FLEXCOMM16_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL1_PRSTCTL0_OSEVENT_TIMER_OSEVENT_TIMER_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL1_PRSTCTL0_OSEVENT_TIMER_OSEVENT_TIMER_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_OSEVENT_TIMER_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL1_PRSTCTL0_FLEXIO_FLEXIO_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL1_PRSTCTL0_FLEXIO_FLEXIO_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_FLEXIO_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL1_PRSTCTL1_HSGPIO0_HSGPIO_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL1_PRSTCTL1_HSGPIO0_HSGPIO_SET = 1,
+} RT500_RSTCTL1_PRSTCTL1_HSGPIO0_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL1_PRSTCTL1_HSGPIO1_HSGPIO_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL1_PRSTCTL1_HSGPIO1_HSGPIO_SET = 1,
+} RT500_RSTCTL1_PRSTCTL1_HSGPIO1_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL1_PRSTCTL1_HSGPIO2_HSGPIO_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL1_PRSTCTL1_HSGPIO2_HSGPIO_SET = 1,
+} RT500_RSTCTL1_PRSTCTL1_HSGPIO2_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL1_PRSTCTL1_HSGPIO3_HSGPIO_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL1_PRSTCTL1_HSGPIO3_HSGPIO_SET = 1,
+} RT500_RSTCTL1_PRSTCTL1_HSGPIO3_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL1_PRSTCTL1_HSGPIO4_HSGPIO_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL1_PRSTCTL1_HSGPIO4_HSGPIO_SET = 1,
+} RT500_RSTCTL1_PRSTCTL1_HSGPIO4_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL1_PRSTCTL1_HSGPIO5_HSGPIO_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL1_PRSTCTL1_HSGPIO5_HSGPIO_SET = 1,
+} RT500_RSTCTL1_PRSTCTL1_HSGPIO5_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL1_PRSTCTL1_HSGPIO6_HSGPIO_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL1_PRSTCTL1_HSGPIO6_HSGPIO_SET = 1,
+} RT500_RSTCTL1_PRSTCTL1_HSGPIO6_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL1_PRSTCTL1_HSGPIO7_HSGPIO_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL1_PRSTCTL1_HSGPIO7_HSGPIO_SET = 1,
+} RT500_RSTCTL1_PRSTCTL1_HSGPIO7_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL1_PRSTCTL1_CRC_CRC_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL1_PRSTCTL1_CRC_CRC_SET = 1,
+} RT500_RSTCTL1_PRSTCTL1_CRC_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL1_PRSTCTL1_DMAC0_DMAC_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL1_PRSTCTL1_DMAC0_DMAC_SET = 1,
+} RT500_RSTCTL1_PRSTCTL1_DMAC0_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL1_PRSTCTL1_DMAC1_DMAC_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL1_PRSTCTL1_DMAC1_DMAC_SET = 1,
+} RT500_RSTCTL1_PRSTCTL1_DMAC1_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL1_PRSTCTL1_MU_MU_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL1_PRSTCTL1_MU_MU_SET = 1,
+} RT500_RSTCTL1_PRSTCTL1_MU_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL1_PRSTCTL1_SEMA_SEMA_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL1_PRSTCTL1_SEMA_SEMA_SET = 1,
+} RT500_RSTCTL1_PRSTCTL1_SEMA_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL1_PRSTCTL1_FREQME_FREQME_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL1_PRSTCTL1_FREQME_FREQME_SET = 1,
+} RT500_RSTCTL1_PRSTCTL1_FREQME_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL1_PRSTCTL2_CT32BIT0_CT32BIT_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL1_PRSTCTL2_CT32BIT0_CT32BIT_SET = 1,
+} RT500_RSTCTL1_PRSTCTL2_CT32BIT0_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL1_PRSTCTL2_CT32BIT1_CT32BIT_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL1_PRSTCTL2_CT32BIT1_CT32BIT_SET = 1,
+} RT500_RSTCTL1_PRSTCTL2_CT32BIT1_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL1_PRSTCTL2_CT32BIT2_CT32BIT_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL1_PRSTCTL2_CT32BIT2_CT32BIT_SET = 1,
+} RT500_RSTCTL1_PRSTCTL2_CT32BIT2_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL1_PRSTCTL2_CT32BIT3_CT32BIT_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL1_PRSTCTL2_CT32BIT3_CT32BIT_SET = 1,
+} RT500_RSTCTL1_PRSTCTL2_CT32BIT3_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL1_PRSTCTL2_CT32BIT4_CT32BIT_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL1_PRSTCTL2_CT32BIT4_CT32BIT_SET = 1,
+} RT500_RSTCTL1_PRSTCTL2_CT32BIT4_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL1_PRSTCTL2_MRT0_MRT0_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL1_PRSTCTL2_MRT0_MRT0_SET = 1,
+} RT500_RSTCTL1_PRSTCTL2_MRT0_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL1_PRSTCTL2_WWDT1_WWDT1_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL1_PRSTCTL2_WWDT1_WWDT1_SET = 1,
+} RT500_RSTCTL1_PRSTCTL2_WWDT1_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL1_PRSTCTL2_I3C0_I3C_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL1_PRSTCTL2_I3C0_I3C_SET = 1,
+} RT500_RSTCTL1_PRSTCTL2_I3C0_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL1_PRSTCTL2_I3C1_I3C_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL1_PRSTCTL2_I3C1_I3C_SET = 1,
+} RT500_RSTCTL1_PRSTCTL2_I3C1_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL1_PRSTCTL2_GPIOINTCTL_GPIOINTCTL_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL1_PRSTCTL2_GPIOINTCTL_GPIOINTCTL_SET = 1,
+} RT500_RSTCTL1_PRSTCTL2_GPIOINTCTL_Enum;
+
+typedef enum {
+    /* Clear Reset */
+    RT500_RSTCTL1_PRSTCTL2_PIMCTL_PIMCTL_CLR = 0,
+    /* Set Reset */
+    RT500_RSTCTL1_PRSTCTL2_PIMCTL_PIMCTL_SET = 1,
+} RT500_RSTCTL1_PRSTCTL2_PIMCTL_Enum;
+
+typedef enum {
+    /* No Effect */
+    RT500_RSTCTL1_PRSTCTL0_SET_FLEXCOMM0_FLEXCOMM_CLR = 0,
+    /* Sets the PRSTCTL0 Bit */
+    RT500_RSTCTL1_PRSTCTL0_SET_FLEXCOMM0_FLEXCOMM_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_SET_FLEXCOMM0_Enum;
+
+typedef enum {
+    /* No Effect */
+    RT500_RSTCTL1_PRSTCTL0_SET_FLEXCOMM1_FLEXCOMM_CLR = 0,
+    /* Sets the PRSTCTL0 Bit */
+    RT500_RSTCTL1_PRSTCTL0_SET_FLEXCOMM1_FLEXCOMM_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_SET_FLEXCOMM1_Enum;
+
+typedef enum {
+    /* No Effect */
+    RT500_RSTCTL1_PRSTCTL0_SET_FLEXCOMM2_FLEXCOMM_CLR = 0,
+    /* Sets the PRSTCTL0 Bit */
+    RT500_RSTCTL1_PRSTCTL0_SET_FLEXCOMM2_FLEXCOMM_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_SET_FLEXCOMM2_Enum;
+
+typedef enum {
+    /* No Effect */
+    RT500_RSTCTL1_PRSTCTL0_SET_FLEXCOMM3_FLEXCOMM_CLR = 0,
+    /* Sets the PRSTCTL0 Bit */
+    RT500_RSTCTL1_PRSTCTL0_SET_FLEXCOMM3_FLEXCOMM_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_SET_FLEXCOMM3_Enum;
+
+typedef enum {
+    /* No Effect */
+    RT500_RSTCTL1_PRSTCTL0_SET_FLEXCOMM4_FLEXCOMM_CLR = 0,
+    /* Sets the PRSTCTL0 Bit */
+    RT500_RSTCTL1_PRSTCTL0_SET_FLEXCOMM4_FLEXCOMM_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_SET_FLEXCOMM4_Enum;
+
+typedef enum {
+    /* No Effect */
+    RT500_RSTCTL1_PRSTCTL0_SET_FLEXCOMM5_FLEXCOMM_CLR = 0,
+    /* Sets the PRSTCTL0 Bit */
+    RT500_RSTCTL1_PRSTCTL0_SET_FLEXCOMM5_FLEXCOMM_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_SET_FLEXCOMM5_Enum;
+
+typedef enum {
+    /* No Effect */
+    RT500_RSTCTL1_PRSTCTL0_SET_FLEXCOMM6_FLEXCOMM_CLR = 0,
+    /* Sets the PRSTCTL0 Bit */
+    RT500_RSTCTL1_PRSTCTL0_SET_FLEXCOMM6_FLEXCOMM_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_SET_FLEXCOMM6_Enum;
+
+typedef enum {
+    /* No Effect */
+    RT500_RSTCTL1_PRSTCTL0_SET_FLEXCOMM7_FLEXCOMM_CLR = 0,
+    /* Sets the PRSTCTL0 Bit */
+    RT500_RSTCTL1_PRSTCTL0_SET_FLEXCOMM7_FLEXCOMM_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_SET_FLEXCOMM7_Enum;
+
+typedef enum {
+    /* No Effect */
+    RT500_RSTCTL1_PRSTCTL0_SET_FLEXCOMM8_FLEXCOMM_CLR = 0,
+    /* Sets the PRSTCTL0 Bit */
+    RT500_RSTCTL1_PRSTCTL0_SET_FLEXCOMM8_FLEXCOMM_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_SET_FLEXCOMM8_Enum;
+
+typedef enum {
+    /* No Effect */
+    RT500_RSTCTL1_PRSTCTL0_SET_FLEXCOMM9_FLEXCOMM_CLR = 0,
+    /* Sets the PRSTCTL0 Bit */
+    RT500_RSTCTL1_PRSTCTL0_SET_FLEXCOMM9_FLEXCOMM_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_SET_FLEXCOMM9_Enum;
+
+typedef enum {
+    /* No Effect */
+    RT500_RSTCTL1_PRSTCTL0_SET_FLEXCOMM10_FLEXCOMM_CLR = 0,
+    /* Sets the PRSTCTL0 Bit */
+    RT500_RSTCTL1_PRSTCTL0_SET_FLEXCOMM10_FLEXCOMM_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_SET_FLEXCOMM10_Enum;
+
+typedef enum {
+    /* No Effect */
+    RT500_RSTCTL1_PRSTCTL0_SET_FLEXCOMM11_FLEXCOMM_CLR = 0,
+    /* Sets the PRSTCTL0 Bit */
+    RT500_RSTCTL1_PRSTCTL0_SET_FLEXCOMM11_FLEXCOMM_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_SET_FLEXCOMM11_Enum;
+
+typedef enum {
+    /* No Effect */
+    RT500_RSTCTL1_PRSTCTL0_SET_FLEXCOMM12_FLEXCOMM_CLR = 0,
+    /* Sets the PRSTCTL0 Bit */
+    RT500_RSTCTL1_PRSTCTL0_SET_FLEXCOMM12_FLEXCOMM_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_SET_FLEXCOMM12_Enum;
+
+typedef enum {
+    /* No Effect */
+    RT500_RSTCTL1_PRSTCTL0_SET_FLEXCOMM13_FLEXCOMM_CLR = 0,
+    /* Sets the PRSTCTL0 Bit */
+    RT500_RSTCTL1_PRSTCTL0_SET_FLEXCOMM13_FLEXCOMM_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_SET_FLEXCOMM13_Enum;
+
+typedef enum {
+    /* No Effect */
+    RT500_RSTCTL1_PRSTCTL0_SET_FLEXCOMM14_FLEXCOMM_CLR = 0,
+    /* Sets the PRSTCTL0 Bit */
+    RT500_RSTCTL1_PRSTCTL0_SET_FLEXCOMM14_FLEXCOMM_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_SET_FLEXCOMM14_Enum;
+
+typedef enum {
+    /* No Effect */
+    RT500_RSTCTL1_PRSTCTL0_SET_FLEXCOMM15_I2C_FLEXCOMM15_I2C_CLR = 0,
+    /* Sets the PRSTCTL0 Bit */
+    RT500_RSTCTL1_PRSTCTL0_SET_FLEXCOMM15_I2C_FLEXCOMM15_I2C_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_SET_FLEXCOMM15_I2C_Enum;
+
+typedef enum {
+    /* No Effect */
+    RT500_RSTCTL1_PRSTCTL0_SET_DMIC0_FLEXCOMM_CLR = 0,
+    /* Sets the PRSTCTL0 Bit */
+    RT500_RSTCTL1_PRSTCTL0_SET_DMIC0_FLEXCOMM_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_SET_DMIC0_Enum;
+
+typedef enum {
+    /* No Effect */
+    RT500_RSTCTL1_PRSTCTL0_SET_FLEXCOMM16_FLEXCOMM16_SPI1_CLR = 0,
+    /* Sets the PRSTCTL0 Bit */
+    RT500_RSTCTL1_PRSTCTL0_SET_FLEXCOMM16_FLEXCOMM16_SPI1_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_SET_FLEXCOMM16_Enum;
+
+typedef enum {
+    /* No Effect */
+    RT500_RSTCTL1_PRSTCTL0_SET_OSEVENT_TIMER_OSEVENT_TIMER_CLR = 0,
+    /* Sets the PRSTCTL0 Bit */
+    RT500_RSTCTL1_PRSTCTL0_SET_OSEVENT_TIMER_OSEVENT_TIMER_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_SET_OSEVENT_TIMER_Enum;
+
+typedef enum {
+    /* No Effect */
+    RT500_RSTCTL1_PRSTCTL0_SET_FLEXIO_FLEXIO_CLR = 0,
+    /* Sets the PRSTCTL0 Bit */
+    RT500_RSTCTL1_PRSTCTL0_SET_FLEXIO_FLEXIO_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_SET_FLEXIO_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL1_SET_HSGPIO0_HSGPIO_CLR = 0,
+    /* Sets the PRSTCTL1 Bit */
+    RT500_RSTCTL1_PRSTCTL1_SET_HSGPIO0_HSGPIO_SET = 1,
+} RT500_RSTCTL1_PRSTCTL1_SET_HSGPIO0_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL1_SET_HSGPIO1_HSGPIO_CLR = 0,
+    /* Sets the PRSTCTL1 Bit */
+    RT500_RSTCTL1_PRSTCTL1_SET_HSGPIO1_HSGPIO_SET = 1,
+} RT500_RSTCTL1_PRSTCTL1_SET_HSGPIO1_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL1_SET_HSGPIO2_HSGPIO_CLR = 0,
+    /* Sets the PRSTCTL1 Bit */
+    RT500_RSTCTL1_PRSTCTL1_SET_HSGPIO2_HSGPIO_SET = 1,
+} RT500_RSTCTL1_PRSTCTL1_SET_HSGPIO2_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL1_SET_HSGPIO3_HSGPIO_CLR = 0,
+    /* Sets the PRSTCTL1 Bit */
+    RT500_RSTCTL1_PRSTCTL1_SET_HSGPIO3_HSGPIO_SET = 1,
+} RT500_RSTCTL1_PRSTCTL1_SET_HSGPIO3_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL1_SET_HSGPIO4_HSGPIO_CLR = 0,
+    /* Sets the PRSTCTL1 Bit */
+    RT500_RSTCTL1_PRSTCTL1_SET_HSGPIO4_HSGPIO_SET = 1,
+} RT500_RSTCTL1_PRSTCTL1_SET_HSGPIO4_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL1_SET_HSGPIO5_HSGPIO_CLR = 0,
+    /* Sets the PRSTCTL1 Bit */
+    RT500_RSTCTL1_PRSTCTL1_SET_HSGPIO5_HSGPIO_SET = 1,
+} RT500_RSTCTL1_PRSTCTL1_SET_HSGPIO5_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL1_SET_HSGPIO6_HSGPIO_CLR = 0,
+    /* Sets the PRSTCTL1 Bit */
+    RT500_RSTCTL1_PRSTCTL1_SET_HSGPIO6_HSGPIO_SET = 1,
+} RT500_RSTCTL1_PRSTCTL1_SET_HSGPIO6_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL1_SET_HSGPIO7_HSGPIO_CLR = 0,
+    /* Sets the PRSTCTL1 Bit */
+    RT500_RSTCTL1_PRSTCTL1_SET_HSGPIO7_HSGPIO_SET = 1,
+} RT500_RSTCTL1_PRSTCTL1_SET_HSGPIO7_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL1_SET_CRC_CRC_CLR = 0,
+    /* Sets the PRSTCTL1 Bit */
+    RT500_RSTCTL1_PRSTCTL1_SET_CRC_CRC_SET = 1,
+} RT500_RSTCTL1_PRSTCTL1_SET_CRC_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL1_SET_DMAC0_DMAC_CLR = 0,
+    /* Sets the PRSTCTL1 Bit */
+    RT500_RSTCTL1_PRSTCTL1_SET_DMAC0_DMAC_SET = 1,
+} RT500_RSTCTL1_PRSTCTL1_SET_DMAC0_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL1_SET_DMAC1_DMAC_CLR = 0,
+    /* Sets the PRSTCTL1 Bit */
+    RT500_RSTCTL1_PRSTCTL1_SET_DMAC1_DMAC_SET = 1,
+} RT500_RSTCTL1_PRSTCTL1_SET_DMAC1_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL1_SET_MU_MU_CLR = 0,
+    /* Sets the PRSTCTL1 Bit */
+    RT500_RSTCTL1_PRSTCTL1_SET_MU_MU_SET = 1,
+} RT500_RSTCTL1_PRSTCTL1_SET_MU_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL1_SET_SEMA_SEMA_CLR = 0,
+    /* Sets the PRSTCTL1 Bit */
+    RT500_RSTCTL1_PRSTCTL1_SET_SEMA_SEMA_SET = 1,
+} RT500_RSTCTL1_PRSTCTL1_SET_SEMA_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL1_SET_FREQME_FREQME_CLR = 0,
+    /* Sets the PRSTCTL1 Bit */
+    RT500_RSTCTL1_PRSTCTL1_SET_FREQME_FREQME_SET = 1,
+} RT500_RSTCTL1_PRSTCTL1_SET_FREQME_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL2_SET_CT32BIT0_CT32BIT_CLR = 0,
+    /* Sets the PRSTCTL2 Bit */
+    RT500_RSTCTL1_PRSTCTL2_SET_CT32BIT0_CT32BIT_SET = 1,
+} RT500_RSTCTL1_PRSTCTL2_SET_CT32BIT0_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL2_SET_CT32BIT1_CT32BIT_CLR = 0,
+    /* Sets the PRSTCTL2 Bit */
+    RT500_RSTCTL1_PRSTCTL2_SET_CT32BIT1_CT32BIT_SET = 1,
+} RT500_RSTCTL1_PRSTCTL2_SET_CT32BIT1_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL2_SET_CT32BIT2_CT32BIT_CLR = 0,
+    /* Sets the PRSTCTL2 Bit */
+    RT500_RSTCTL1_PRSTCTL2_SET_CT32BIT2_CT32BIT_SET = 1,
+} RT500_RSTCTL1_PRSTCTL2_SET_CT32BIT2_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL2_SET_CT32BIT3_CT32BIT_CLR = 0,
+    /* Sets the PRSTCTL2 Bit */
+    RT500_RSTCTL1_PRSTCTL2_SET_CT32BIT3_CT32BIT_SET = 1,
+} RT500_RSTCTL1_PRSTCTL2_SET_CT32BIT3_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL2_SET_CT32BIT4_CT32BIT_CLR = 0,
+    /* Sets the PRSTCTL2 Bit */
+    RT500_RSTCTL1_PRSTCTL2_SET_CT32BIT4_CT32BIT_SET = 1,
+} RT500_RSTCTL1_PRSTCTL2_SET_CT32BIT4_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL2_SET_MRT0_MRT0_CLR = 0,
+    /* Sets the PRSTCTL2 Bit */
+    RT500_RSTCTL1_PRSTCTL2_SET_MRT0_MRT0_SET = 1,
+} RT500_RSTCTL1_PRSTCTL2_SET_MRT0_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL2_SET_WWDT1_WWDT1_CLR = 0,
+    /* Sets the PRSTCTL2 Bit */
+    RT500_RSTCTL1_PRSTCTL2_SET_WWDT1_WWDT1_SET = 1,
+} RT500_RSTCTL1_PRSTCTL2_SET_WWDT1_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL2_SET_I3C0_I3C_CLR = 0,
+    /* Sets the PRSTCTL2 Bit */
+    RT500_RSTCTL1_PRSTCTL2_SET_I3C0_I3C_SET = 1,
+} RT500_RSTCTL1_PRSTCTL2_SET_I3C0_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL2_SET_I3C1_I3C_CLR = 0,
+    /* Sets the PRSTCTL2 Bit */
+    RT500_RSTCTL1_PRSTCTL2_SET_I3C1_I3C_SET = 1,
+} RT500_RSTCTL1_PRSTCTL2_SET_I3C1_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL2_SET_GPIOINTCTL_GPIOINTCTL_CLR = 0,
+    /* Sets the PRSTCTL2 Bit */
+    RT500_RSTCTL1_PRSTCTL2_SET_GPIOINTCTL_GPIOINTCTL_SET = 1,
+} RT500_RSTCTL1_PRSTCTL2_SET_GPIOINTCTL_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL2_SET_PIMCTL_PIMCTL_CLR = 0,
+    /* Sets the PRSTCTL2 Bit */
+    RT500_RSTCTL1_PRSTCTL2_SET_PIMCTL_PIMCTL_SET = 1,
+} RT500_RSTCTL1_PRSTCTL2_SET_PIMCTL_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL0_CLR_FLEXCOMM0_FLEXCOMM_CLR = 0,
+    /* Clears the PRSTCTL0 Bit */
+    RT500_RSTCTL1_PRSTCTL0_CLR_FLEXCOMM0_FLEXCOMM_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_CLR_FLEXCOMM0_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL0_CLR_FLEXCOMM1_FLEXCOMM_CLR = 0,
+    /* Clears the PRSTCTL0 Bit */
+    RT500_RSTCTL1_PRSTCTL0_CLR_FLEXCOMM1_FLEXCOMM_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_CLR_FLEXCOMM1_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL0_CLR_FLEXCOMM2_FLEXCOMM_CLR = 0,
+    /* Clears the PRSTCTL0 Bit */
+    RT500_RSTCTL1_PRSTCTL0_CLR_FLEXCOMM2_FLEXCOMM_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_CLR_FLEXCOMM2_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL0_CLR_FLEXCOMM3_FLEXCOMM_CLR = 0,
+    /* Clears the PRSTCTL0 Bit */
+    RT500_RSTCTL1_PRSTCTL0_CLR_FLEXCOMM3_FLEXCOMM_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_CLR_FLEXCOMM3_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL0_CLR_FLEXCOMM4_FLEXCOMM_CLR = 0,
+    /* Clears the PRSTCTL0 Bit */
+    RT500_RSTCTL1_PRSTCTL0_CLR_FLEXCOMM4_FLEXCOMM_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_CLR_FLEXCOMM4_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL0_CLR_FLEXCOMM5_FLEXCOMM_CLR = 0,
+    /* Clears the PRSTCTL0 Bit */
+    RT500_RSTCTL1_PRSTCTL0_CLR_FLEXCOMM5_FLEXCOMM_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_CLR_FLEXCOMM5_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL0_CLR_FLEXCOMM6_FLEXCOMM_CLR = 0,
+    /* Clears the PRSTCTL0 Bit */
+    RT500_RSTCTL1_PRSTCTL0_CLR_FLEXCOMM6_FLEXCOMM_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_CLR_FLEXCOMM6_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL0_CLR_FLEXCOMM7_FLEXCOMM_CLR = 0,
+    /* Clears the PRSTCTL0 Bit */
+    RT500_RSTCTL1_PRSTCTL0_CLR_FLEXCOMM7_FLEXCOMM_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_CLR_FLEXCOMM7_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL0_CLR_FLEXCOMM8_FLEXCOMM_CLR = 0,
+    /* Clears the PRSTCTL0 Bit */
+    RT500_RSTCTL1_PRSTCTL0_CLR_FLEXCOMM8_FLEXCOMM_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_CLR_FLEXCOMM8_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL0_CLR_FLEXCOMM9_FLEXCOMM_CLR = 0,
+    /* Clears the PRSTCTL0 Bit */
+    RT500_RSTCTL1_PRSTCTL0_CLR_FLEXCOMM9_FLEXCOMM_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_CLR_FLEXCOMM9_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL0_CLR_FLEXCOMM10_FLEXCOMM_CLR = 0,
+    /* Clears the PRSTCTL0 Bit */
+    RT500_RSTCTL1_PRSTCTL0_CLR_FLEXCOMM10_FLEXCOMM_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_CLR_FLEXCOMM10_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL0_CLR_FLEXCOMM11_FLEXCOMM_CLR = 0,
+    /* Clears the PRSTCTL0 Bit */
+    RT500_RSTCTL1_PRSTCTL0_CLR_FLEXCOMM11_FLEXCOMM_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_CLR_FLEXCOMM11_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL0_CLR_FLEXCOMM12_FLEXCOMM_CLR = 0,
+    /* Clears the PRSTCTL0 Bit */
+    RT500_RSTCTL1_PRSTCTL0_CLR_FLEXCOMM12_FLEXCOMM_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_CLR_FLEXCOMM12_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL0_CLR_FLEXCOMM13_FLEXCOMM_CLR = 0,
+    /* Clears the PRSTCTL0 Bit */
+    RT500_RSTCTL1_PRSTCTL0_CLR_FLEXCOMM13_FLEXCOMM_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_CLR_FLEXCOMM13_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL0_CLR_FLEXCOMM14_FLEXCOMM_CLR = 0,
+    /* Clears the PRSTCTL0 Bit */
+    RT500_RSTCTL1_PRSTCTL0_CLR_FLEXCOMM14_FLEXCOMM_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_CLR_FLEXCOMM14_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL0_CLR_FLEXCOMM15_I2C_FLEXCOMM15_I2C_CLR = 0,
+    /* Clears the PRSTCTL0 Bit */
+    RT500_RSTCTL1_PRSTCTL0_CLR_FLEXCOMM15_I2C_FLEXCOMM15_I2C_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_CLR_FLEXCOMM15_I2C_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL0_CLR_DMIC0_FLEXCOMM_CLR = 0,
+    /* Clears the PRSTCTL0 Bit */
+    RT500_RSTCTL1_PRSTCTL0_CLR_DMIC0_FLEXCOMM_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_CLR_DMIC0_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL0_CLR_FLEXCOMM16_FLEXCOMM16_SPI1_CLR = 0,
+    /* Clears the PRSTCTL0 Bit */
+    RT500_RSTCTL1_PRSTCTL0_CLR_FLEXCOMM16_FLEXCOMM16_SPI1_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_CLR_FLEXCOMM16_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL0_CLR_OSEVENT_TIMER_OSEVENT_TIMER_CLR = 0,
+    /* Clears the PRSTCTL0 Bit */
+    RT500_RSTCTL1_PRSTCTL0_CLR_OSEVENT_TIMER_OSEVENT_TIMER_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_CLR_OSEVENT_TIMER_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL0_CLR_FLEXIO_FLEXIO_CLR = 0,
+    /* Clears the PRSTCTL0 Bit */
+    RT500_RSTCTL1_PRSTCTL0_CLR_FLEXIO_FLEXIO_SET = 1,
+} RT500_RSTCTL1_PRSTCTL0_CLR_FLEXIO_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL1_CLR_HSGPIO0_HSGPIO_CLR = 0,
+    /* Clears the PRSTCTL1 Bit */
+    RT500_RSTCTL1_PRSTCTL1_CLR_HSGPIO0_HSGPIO_SET = 1,
+} RT500_RSTCTL1_PRSTCTL1_CLR_HSGPIO0_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL1_CLR_HSGPIO1_HSGPIO_CLR = 0,
+    /* Clears the PRSTCTL1 Bit */
+    RT500_RSTCTL1_PRSTCTL1_CLR_HSGPIO1_HSGPIO_SET = 1,
+} RT500_RSTCTL1_PRSTCTL1_CLR_HSGPIO1_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL1_CLR_HSGPIO2_HSGPIO_CLR = 0,
+    /* Clears the PRSTCTL1 Bit */
+    RT500_RSTCTL1_PRSTCTL1_CLR_HSGPIO2_HSGPIO_SET = 1,
+} RT500_RSTCTL1_PRSTCTL1_CLR_HSGPIO2_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL1_CLR_HSGPIO3_HSGPIO_CLR = 0,
+    /* Clears the PRSTCTL1 Bit */
+    RT500_RSTCTL1_PRSTCTL1_CLR_HSGPIO3_HSGPIO_SET = 1,
+} RT500_RSTCTL1_PRSTCTL1_CLR_HSGPIO3_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL1_CLR_HSGPIO4_HSGPIO_CLR = 0,
+    /* Clears the PRSTCTL1 Bit */
+    RT500_RSTCTL1_PRSTCTL1_CLR_HSGPIO4_HSGPIO_SET = 1,
+} RT500_RSTCTL1_PRSTCTL1_CLR_HSGPIO4_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL1_CLR_HSGPIO5_HSGPIO_CLR = 0,
+    /* Clears the PRSTCTL1 Bit */
+    RT500_RSTCTL1_PRSTCTL1_CLR_HSGPIO5_HSGPIO_SET = 1,
+} RT500_RSTCTL1_PRSTCTL1_CLR_HSGPIO5_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL1_CLR_HSGPIO6_HSGPIO_CLR = 0,
+    /* Clears the PRSTCTL1 Bit */
+    RT500_RSTCTL1_PRSTCTL1_CLR_HSGPIO6_HSGPIO_SET = 1,
+} RT500_RSTCTL1_PRSTCTL1_CLR_HSGPIO6_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL1_CLR_HSGPIO7_HSGPIO_CLR = 0,
+    /* Clears the PRSTCTL1 Bit */
+    RT500_RSTCTL1_PRSTCTL1_CLR_HSGPIO7_HSGPIO_SET = 1,
+} RT500_RSTCTL1_PRSTCTL1_CLR_HSGPIO7_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL1_CLR_CRC_CRC_CLR = 0,
+    /* Clears the PRSTCTL1 Bit */
+    RT500_RSTCTL1_PRSTCTL1_CLR_CRC_CRC_SET = 1,
+} RT500_RSTCTL1_PRSTCTL1_CLR_CRC_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL1_CLR_DMAC0_DMAC_CLR = 0,
+    /* Clears the PRSTCTL1 Bit */
+    RT500_RSTCTL1_PRSTCTL1_CLR_DMAC0_DMAC_SET = 1,
+} RT500_RSTCTL1_PRSTCTL1_CLR_DMAC0_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL1_CLR_DMAC1_DMAC_CLR = 0,
+    /* Clears the PRSTCTL1 Bit */
+    RT500_RSTCTL1_PRSTCTL1_CLR_DMAC1_DMAC_SET = 1,
+} RT500_RSTCTL1_PRSTCTL1_CLR_DMAC1_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL1_CLR_MU_MU_CLR = 0,
+    /* Clears the PRSTCTL1 Bit */
+    RT500_RSTCTL1_PRSTCTL1_CLR_MU_MU_SET = 1,
+} RT500_RSTCTL1_PRSTCTL1_CLR_MU_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL1_CLR_SEMA_SEMA_CLR = 0,
+    /* Clears the PRSTCTL1 Bit */
+    RT500_RSTCTL1_PRSTCTL1_CLR_SEMA_SEMA_SET = 1,
+} RT500_RSTCTL1_PRSTCTL1_CLR_SEMA_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL1_CLR_FREQME_FREQME_CLR = 0,
+    /* Clears the PRSTCTL1 Bit */
+    RT500_RSTCTL1_PRSTCTL1_CLR_FREQME_FREQME_SET = 1,
+} RT500_RSTCTL1_PRSTCTL1_CLR_FREQME_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL2_CLR_CT32BIT0_CT32BIT_CLR = 0,
+    /* Clears the PRSTCTL2 Bit */
+    RT500_RSTCTL1_PRSTCTL2_CLR_CT32BIT0_CT32BIT_SET = 1,
+} RT500_RSTCTL1_PRSTCTL2_CLR_CT32BIT0_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL2_CLR_CT32BIT1_CT32BIT_CLR = 0,
+    /* Clears the PRSTCTL2 Bit */
+    RT500_RSTCTL1_PRSTCTL2_CLR_CT32BIT1_CT32BIT_SET = 1,
+} RT500_RSTCTL1_PRSTCTL2_CLR_CT32BIT1_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL2_CLR_CT32BIT2_CT32BIT_CLR = 0,
+    /* Clears the PRSTCTL2 Bit */
+    RT500_RSTCTL1_PRSTCTL2_CLR_CT32BIT2_CT32BIT_SET = 1,
+} RT500_RSTCTL1_PRSTCTL2_CLR_CT32BIT2_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL2_CLR_CT32BIT3_CT32BIT_CLR = 0,
+    /* Clears the PRSTCTL2 Bit */
+    RT500_RSTCTL1_PRSTCTL2_CLR_CT32BIT3_CT32BIT_SET = 1,
+} RT500_RSTCTL1_PRSTCTL2_CLR_CT32BIT3_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL2_CLR_CT32BIT4_CT32BIT_CLR = 0,
+    /* Clears the PRSTCTL2 Bit */
+    RT500_RSTCTL1_PRSTCTL2_CLR_CT32BIT4_CT32BIT_SET = 1,
+} RT500_RSTCTL1_PRSTCTL2_CLR_CT32BIT4_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL2_CLR_MRT0_MRT0_CLR = 0,
+    /* Clears the PRSTCTL2 Bit */
+    RT500_RSTCTL1_PRSTCTL2_CLR_MRT0_MRT0_SET = 1,
+} RT500_RSTCTL1_PRSTCTL2_CLR_MRT0_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL2_CLR_WWDT1_WWDT1_CLR = 0,
+    /* Clears the PRSTCTL2 Bit */
+    RT500_RSTCTL1_PRSTCTL2_CLR_WWDT1_WWDT1_SET = 1,
+} RT500_RSTCTL1_PRSTCTL2_CLR_WWDT1_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL2_CLR_I3C0_I3C_CLR = 0,
+    /* Clears the PRSTCTL2 Bit */
+    RT500_RSTCTL1_PRSTCTL2_CLR_I3C0_I3C_SET = 1,
+} RT500_RSTCTL1_PRSTCTL2_CLR_I3C0_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL2_CLR_I3C1_I3C_CLR = 0,
+    /* Clears the PRSTCTL2 Bit */
+    RT500_RSTCTL1_PRSTCTL2_CLR_I3C1_I3C_SET = 1,
+} RT500_RSTCTL1_PRSTCTL2_CLR_I3C1_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL2_CLR_GPIOINTCTL_GPIOINTCTL_CLR = 0,
+    /* Clears the PRSTCTL2 Bit */
+    RT500_RSTCTL1_PRSTCTL2_CLR_GPIOINTCTL_GPIOINTCTL_SET = 1,
+} RT500_RSTCTL1_PRSTCTL2_CLR_GPIOINTCTL_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_RSTCTL1_PRSTCTL2_CLR_PIMCTL_PIMCTL_CLR = 0,
+    /* Clears the PRSTCTL2 Bit */
+    RT500_RSTCTL1_PRSTCTL2_CLR_PIMCTL_PIMCTL_SET = 1,
+} RT500_RSTCTL1_PRSTCTL2_CLR_PIMCTL_Enum;
+
+
+#define RT500_RSTCTL1_REGISTER_NAMES_ARRAY(_name) \
+    const char *_name[RT500_RSTCTL1_REGS_NO] = { \
+        [R_RT500_RSTCTL1_SYSRSTSTAT] = "SYSRSTSTAT", \
+        [R_RT500_RSTCTL1_PRSTCTL0] = "PRSTCTL0", \
+        [R_RT500_RSTCTL1_PRSTCTL1] = "PRSTCTL1", \
+        [R_RT500_RSTCTL1_PRSTCTL2] = "PRSTCTL2", \
+        [R_RT500_RSTCTL1_PRSTCTL0_SET] = "PRSTCTL0_SET", \
+        [R_RT500_RSTCTL1_PRSTCTL1_SET] = "PRSTCTL1_SET", \
+        [R_RT500_RSTCTL1_PRSTCTL2_SET] = "PRSTCTL2_SET", \
+        [R_RT500_RSTCTL1_PRSTCTL0_CLR] = "PRSTCTL0_CLR", \
+        [R_RT500_RSTCTL1_PRSTCTL1_CLR] = "PRSTCTL1_CLR", \
+        [R_RT500_RSTCTL1_PRSTCTL2_CLR] = "PRSTCTL2_CLR", \
+    }
+
+#define RT500_RSTCTL1_REGISTER_WMASK_ARRAY(_name) \
+    const uint32_t _name[RT500_RSTCTL1_REGS_NO] = { \
+        [R_RT500_RSTCTL1_PRSTCTL0] = 0x2BFFFF00, \
+        [R_RT500_RSTCTL1_PRSTCTL1] = 0xB18100FF, \
+        [R_RT500_RSTCTL1_PRSTCTL2] = 0xC003051F, \
+        [R_RT500_RSTCTL1_PRSTCTL0_SET] = 0x2BFFFF00, \
+        [R_RT500_RSTCTL1_PRSTCTL1_SET] = 0xB18100FF, \
+        [R_RT500_RSTCTL1_PRSTCTL2_SET] = 0xC003051F, \
+        [R_RT500_RSTCTL1_PRSTCTL0_CLR] = 0x2BFFFF00, \
+        [R_RT500_RSTCTL1_PRSTCTL1_CLR] = 0xB18100FF, \
+        [R_RT500_RSTCTL1_PRSTCTL2_CLR] = 0xC003051F, \
+    }
+
+static inline void rt500_rstctl1_reset_registers(uint32_t *regs)
+{
+    regs[R_RT500_RSTCTL1_SYSRSTSTAT] = 0x1;
+    regs[R_RT500_RSTCTL1_PRSTCTL0] = 0x1c0ff00;
+    regs[R_RT500_RSTCTL1_PRSTCTL1] = 0xb18100ff;
+    regs[R_RT500_RSTCTL1_PRSTCTL2] = 0xc001011f;
+    regs[R_RT500_RSTCTL1_PRSTCTL0_SET] = 0x0;
+    regs[R_RT500_RSTCTL1_PRSTCTL1_SET] = 0x0;
+    regs[R_RT500_RSTCTL1_PRSTCTL2_SET] = 0x0;
+    regs[R_RT500_RSTCTL1_PRSTCTL0_CLR] = 0x0;
+    regs[R_RT500_RSTCTL1_PRSTCTL1_CLR] = 0x0;
+    regs[R_RT500_RSTCTL1_PRSTCTL2_CLR] = 0x0;
+}
diff --git a/include/hw/misc/rt500_rstctl.h b/include/hw/misc/rt500_rstctl.h
new file mode 100644
index 0000000000..ae7e304b2e
--- /dev/null
+++ b/include/hw/misc/rt500_rstctl.h
@@ -0,0 +1,32 @@
+/*
+ * QEMU model for RT500 Reset Controller
+ *
+ * Copyright (c) 2024 Google LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_MISC_RT500_RSTCTL_H
+#define HW_MISC_RT500_RSTCTL_H
+
+#include "hw/arm/svd/rt500_rstctl0.h"
+#include "hw/arm/svd/rt500_rstctl1.h"
+#include "hw/sysbus.h"
+
+#define TYPE_RT500_RSTCTL "rt500-rstctl"
+#define RT500_RSTCTL(o) OBJECT_CHECK(RT500RstCtlState, o, TYPE_RT500_RSTCTL)
+
+#define TYPE_RT500_RSTCTL0 "rt500-rstctl0"
+#define TYPE_RT500_RSTCTL1 "rt500-rstctl1"
+
+typedef struct {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+    uint32_t regs[RT500_RSTCTL1_REGS_NO];
+} RT500RstCtlState;
+
+#endif /* HW_MISC_RT500_RSTCTL_H */
diff --git a/hw/misc/rt500_rstctl.c b/hw/misc/rt500_rstctl.c
new file mode 100644
index 0000000000..b5a5a4502b
--- /dev/null
+++ b/hw/misc/rt500_rstctl.c
@@ -0,0 +1,225 @@
+/*
+ * QEMU model for RT500 Reset Controller
+ *
+ * Copyright (c) 2024 Google LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/irq.h"
+#include "hw/qdev-properties.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "exec/address-spaces.h"
+#include "hw/regs.h"
+#include "hw/misc/rt500_rstctl.h"
+
+#include "trace.h"
+
+/*
+ * There are two intances for RSTCTL with the same register names and layout but
+ * with different fields.
+ */
+#define BUILD_BUG_REG_ADDR(reg) \
+    QEMU_BUILD_BUG_ON((int)A_RT500_RSTCTL0_##reg != (int)A_RT500_RSTCTL1_##reg)
+
+#define REG(s, reg) (s->regs[R_RT500_RSTCTL0_##reg])
+#define RF_WR(s, reg, field, val) \
+    ARRAY_FIELD_DP32(s->regs, RT500_RSTCTL0_##reg, field, val)
+#define RF_RD(s, reg, field) \
+    ARRAY_FIELD_EX32(s->regs, RT500_RSTCTL0_##reg, field)
+
+#define RSTCTL_SYSRSTSTAT_WMASK (BITS(7, 4) | BIT(0))
+#define RSTCL0_PRSCTL0_WMASK (BITS(30, 26) | BITS(24, 20) | BIT(18) | \
+                              BIT(16) | BITS(12, 8) | BIT(3) | BIT(1))
+#define RSTCL0_PRSCTL1_WMASK (BIT(24) | BITS(16, 15) | BITS(3, 2))
+#define RSTCL0_PRSCTL2_WMASK (BITS(1, 0))
+#define RSTCL1_PRSCTL0_WMASK (BIT(29) | BIT(27) |  BITS(25, 8))
+#define RSTCL1_PRSCTL1_WMASK (BIT(31) | BITS(29, 28) | BITS(24, 23) | \
+                              BIT(16) | BITS(7, 0))
+#define RSTCL1_PRSCTL2_WMASK (BITS(31, 30) | BITS(17, 16) | BIT(10) | \
+                              BIT(8) | BITS(4, 0))
+
+
+/*
+ * The two RSTCLK modules have different write register masks.
+ */
+typedef struct {
+    SysBusDeviceClass parent;
+    const uint32_t *wmask;
+} RT500RstCtlClass;
+
+#define RT500_RSTCTL_CLASS(klass) \
+    OBJECT_CLASS_CHECK(RT500RstCtlClass, (klass), TYPE_RT500_RSTCTL)
+#define RT500_RSTCTL_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(RT500RstCtlClass, (obj), TYPE_RT500_RSTCTL)
+
+BUILD_BUG_REG_ADDR(SYSRSTSTAT);
+BUILD_BUG_REG_ADDR(PRSTCTL0);
+BUILD_BUG_REG_ADDR(PRSTCTL1);
+BUILD_BUG_REG_ADDR(PRSTCTL2);
+BUILD_BUG_REG_ADDR(PRSTCTL0_SET);
+BUILD_BUG_REG_ADDR(PRSTCTL1_SET);
+BUILD_BUG_REG_ADDR(PRSTCTL2_SET);
+BUILD_BUG_REG_ADDR(PRSTCTL0_CLR);
+BUILD_BUG_REG_ADDR(PRSTCTL1_CLR);
+BUILD_BUG_REG_ADDR(PRSTCTL2_CLR);
+
+static RT500_RSTCTL0_REGISTER_NAMES_ARRAY(reg_names);
+
+static MemTxResult rt500_rstctl_read(void *opaque, hwaddr addr,
+                                     uint64_t *data, unsigned size,
+                                     MemTxAttrs attrs)
+{
+    RT500RstCtlState *s = opaque;
+    MemTxResult ret = MEMTX_OK;
+
+    switch (addr) {
+    case A_RT500_RSTCTL0_SYSRSTSTAT:
+    case A_RT500_RSTCTL0_PRSTCTL0:
+    case A_RT500_RSTCTL0_PRSTCTL1:
+    case A_RT500_RSTCTL0_PRSTCTL2:
+        *data = s->regs[addr / 4];
+        break;
+    default:
+        ret = MEMTX_ERROR;
+    }
+
+    trace_rt500_rstctl_reg_read(DEVICE(s)->id, reg_names[addr / 4], addr,
+                                *data);
+    return ret;
+}
+
+static MemTxResult rt500_rstctl_write(void *opaque, hwaddr addr,
+                                      uint64_t value, unsigned size,
+                                      MemTxAttrs attrs)
+{
+    RT500RstCtlState *s = opaque;
+    RT500RstCtlClass *c = RT500_RSTCTL_GET_CLASS(s);
+
+    trace_rt500_rstctl_reg_write(DEVICE(s)->id, reg_names[addr / 4], addr,
+                                 value);
+
+    value &= c->wmask[addr / 4];
+
+    switch (addr) {
+    case A_RT500_RSTCTL0_SYSRSTSTAT:
+    {
+        /* write 1 to clear bits */
+        REG(s, SYSRSTSTAT) &= ~value;
+        break;
+    }
+    case A_RT500_RSTCTL0_PRSTCTL0:
+    case A_RT500_RSTCTL0_PRSTCTL1:
+    case A_RT500_RSTCTL0_PRSTCTL2:
+    {
+        s->regs[addr / 4] = value;
+        break;
+    }
+    case A_RT500_RSTCTL0_PRSTCTL0_SET:
+    case A_RT500_RSTCTL0_PRSTCTL1_SET:
+    case A_RT500_RSTCTL0_PRSTCTL2_SET:
+    {
+        uint32_t tmp;
+
+        tmp = A_RT500_RSTCTL0_PRSTCTL0 + (addr - A_RT500_RSTCTL0_PRSTCTL0_SET);
+        s->regs[tmp / 4] |= value;
+        break;
+    }
+    case A_RT500_RSTCTL0_PRSTCTL0_CLR:
+    case A_RT500_RSTCTL0_PRSTCTL1_CLR:
+    case A_RT500_RSTCTL0_PRSTCTL2_CLR:
+    {
+        uint32_t tmp;
+
+        tmp = A_RT500_RSTCTL0_PRSTCTL0 + (addr - A_RT500_RSTCTL0_PRSTCTL0_CLR);
+        s->regs[tmp / 4] &= ~value;
+        break;
+    }
+    }
+
+    return MEMTX_OK;
+}
+
+static const MemoryRegionOps rt500_rstctl_ops = {
+    .read_with_attrs = rt500_rstctl_read,
+    .write_with_attrs = rt500_rstctl_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .max_access_size = 4,
+        .min_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static void rt500_rstctl0_reset(DeviceState *dev)
+{
+    RT500RstCtlState *s = RT500_RSTCTL(dev);
+
+    memset(&s->regs, 0, sizeof(s->regs));
+    rt500_rstctl0_reset_registers(s->regs);
+}
+
+static void rt500_rstctl1_reset(DeviceState *dev)
+{
+    RT500RstCtlState *s = RT500_RSTCTL(dev);
+
+    memset(&s->regs, 0, sizeof(s->regs));
+    rt500_rstctl1_reset_registers(s->regs);
+}
+
+static void rt500_rstctl_init(Object *obj)
+{
+    RT500RstCtlState *s = RT500_RSTCTL(obj);
+
+    memory_region_init_io(&s->mmio, obj, &rt500_rstctl_ops, s,
+                          TYPE_RT500_RSTCTL, sizeof(s->regs));
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+}
+
+static void rt500_rstctl0_class_init(ObjectClass *klass, void *data)
+{
+    RT500RstCtlClass *rc = RT500_RSTCTL_CLASS(klass);
+    static const RT500_RSTCTL0_REGISTER_WMASK_ARRAY(wmask);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = rt500_rstctl0_reset;
+    rc->wmask = wmask;
+}
+
+static void rt500_rstctl1_class_init(ObjectClass *klass, void *data)
+{
+    RT500RstCtlClass *rc = RT500_RSTCTL_CLASS(klass);
+    static const RT500_RSTCTL1_REGISTER_WMASK_ARRAY(wmask);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = rt500_rstctl1_reset;
+    rc->wmask = wmask;
+}
+
+static const TypeInfo rt500_rstctl_types[] = {
+    {
+        .name          = TYPE_RT500_RSTCTL,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(RT500RstCtlState),
+        .instance_init = rt500_rstctl_init,
+        .abstract      = true,
+    },
+    {
+        .name          = TYPE_RT500_RSTCTL0,
+        .parent        = TYPE_RT500_RSTCTL,
+        .class_init    = rt500_rstctl0_class_init,
+    },
+    {
+        .name          = TYPE_RT500_RSTCTL1,
+        .parent        = TYPE_RT500_RSTCTL,
+        .class_init    = rt500_rstctl1_class_init,
+    },
+};
+
+DEFINE_TYPES(rt500_rstctl_types);
diff --git a/hw/arm/svd/meson.build b/hw/arm/svd/meson.build
index 7e59eda0d3..25f4917089 100644
--- a/hw/arm/svd/meson.build
+++ b/hw/arm/svd/meson.build
@@ -22,4 +22,10 @@ if get_option('mcux-soc-svd')
   run_target('svd-flexspi', command: svd_gen_header +
     [ '-i', rt595, '-o', '@SOURCE_ROOT@/include/hw/arm/svd/flexspi.h',
       '-p', 'FLEXSPI0', '-t', 'FLEXSPI'])
+  run_target('svd-rt500-rstctl0', command: svd_gen_header +
+    [ '-i', rt595, '-o', '@SOURCE_ROOT@/include/hw/arm/svd/rt500_rstctl0.h',
+      '-p', 'RSTCTL0', '-t', 'RT500_RSTCTL0'])
+  run_target('svd-rt500-rstctl1', command: svd_gen_header +
+    [ '-i', rt595, '-o', '@SOURCE_ROOT@/include/hw/arm/svd/rt500_rstctl1.h',
+      '-p', 'RSTCTL1', '-t', 'RT500_RSTCTL1'])
 endif
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 392ae9e84f..70a2a269ac 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -222,4 +222,7 @@ config RT500_CLKCTL0
 config RT500_CLKCTL1
     bool
 
+config RT500_RSTCTL
+    bool
+
 source macio/Kconfig
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 68929949a6..5e2728e982 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -160,3 +160,4 @@ system_ss.add(when: 'CONFIG_LASI', if_true: files('lasi.c'))
 system_ss.add(when: 'CONFIG_FLEXCOMM', if_true: files('flexcomm.c'))
 system_ss.add(when: 'CONFIG_RT500_CLKCTL0', if_true: files('rt500_clkctl0.c'))
 system_ss.add(when: 'CONFIG_RT500_CLKCTL1', if_true: files('rt500_clkctl1.c'))
+system_ss.add(when: 'CONFIG_RT500_RSTCTL', if_true: files('rt500_rstctl.c'))
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index e65fcfa613..41a94d5ef6 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -365,3 +365,7 @@ rt500_clkctl0_reg_write(const char *regname, uint32_t addr, uint32_t val) "%s[0x
 # rt500_clkctl1.c
 rt500_clkctl1_reg_read(const char *regname, uint32_t addr, uint32_t val) "%s[0x%04x] -> 0x%08x"
 rt500_clkctl1_reg_write(const char *regname, uint32_t addr, uint32_t val) "%s[0x%04x] <- 0x%08x"
+
+# rt500_rstctl.c
+rt500_rstctl_reg_read(const char *id, const char *regname, uint32_t addr, uint32_t val) "%s: %s[0x%04x] -> 0x%08x"
+rt500_rstctl_reg_write(const char *id, const char *regname, uint32_t addr, uint32_t val) "%s: %s[0x%04x] <- 0x%08x"
-- 
2.46.0.184.g6999bdac58-goog


