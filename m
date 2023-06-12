Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C043C72D481
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 00:36:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8q83-0001bU-L1; Mon, 12 Jun 2023 18:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8q7u-0001ar-R7
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 18:35:07 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8q7s-0007ob-SP
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 18:35:06 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-97881a996a0so864433366b.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 15:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686609303; x=1689201303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vwHTwHQQJpeSodzqVHQU7tn+HPBO9TSgo8F/afQtA38=;
 b=cjaMbxtT7ggFoMo0DHFOuOWXAs+J1FPPl5bi5cySGNGzb/wHZ+7lT0BYu9AgwDU/aA
 8oMug5f2bN02/0W0jSVQY1QLR+zS3lEfHJnTwmdJxLf+PqF/r+lAiQdJxce8a6m94qt+
 HOSiP8CVMOyDNRSsfPlla2DQIyfeo0MOxFCFZTtibfwlx29i0L0W0C7yWVwo32qeNyFB
 nOmxX2gKD0zt8DrWRWehACNekPk+jcm9rKkMXX0wAiMNMeKvBE1GgRWnAqunY6q6CLYc
 6W1Irp3l+7M/uCwe7CCaT26oMjMZlHsgY2X6jF+n20bhULhf6Iqdi2sH2XlIrcioI3go
 qfeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686609303; x=1689201303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vwHTwHQQJpeSodzqVHQU7tn+HPBO9TSgo8F/afQtA38=;
 b=bGfm+hvWcuaY5Cxb7JtcF0P5IRZzdK9QLqNvWw5h10riarzn081yenDWCZekXSlCuv
 cAxnh8kS6KBUwB0U0KafblSzedAteVdLyczkCPkcuZgB8lO/UBHyXHI3QYqByA7ebt1v
 AHRAGN/nA6reBskc6+cIl/TrSu/cCpNHo5SmVjcHtItcMipfg8uPIR2f1RkK15ZfBm8I
 XqZKzoAU/jNDLCtXFotSE0I6oaKh/8GV9N3uRqqdUSeSm1lrAErUJl34WSUcCFS3laNh
 yPs7Ki+E8FW9kkToEcbsy+VhOZAEgLkBa/6oHw6gKQoAcXsACXRxrjh0bpPHizaZ2Kwp
 YoKg==
X-Gm-Message-State: AC+VfDxsM2F+GA9TUplq3HBvymgVcVBaRu5yyF+L/MJwxf7PdVWtOqbQ
 9ywrdM5sqxv/KCDFjwYWDV0RCpitESYNVgvR8VuiEg==
X-Google-Smtp-Source: ACHHUZ6RDcQszdUfg7w/eZYfNuLDbd3XNyDQhTPpyDHu0w1I4G2ciL2XnVkNG7wuYTxOcgr8LhwKbQ==
X-Received: by 2002:a17:907:3f21:b0:969:93f2:259a with SMTP id
 hq33-20020a1709073f2100b0096993f2259amr11415961ejc.73.1686609303104; 
 Mon, 12 Jun 2023 15:35:03 -0700 (PDT)
Received: from localhost.localdomain ([185.140.244.249])
 by smtp.gmail.com with ESMTPSA id
 f10-20020a170906824a00b00971433ed5fesm5737208ejx.184.2023.06.12.15.35.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jun 2023 15:35:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Sergey Kambalin <sergey.kambalin@auriga.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 1/4] hw/arm/raspi: Import Linux raspi definitions as
 'raspberrypi-fw-defs.h'
Date: Tue, 13 Jun 2023 00:34:53 +0200
Message-Id: <20230612223456.33824-2-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230612223456.33824-1-philmd@linaro.org>
References: <20230612223456.33824-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

From: Sergey Kambalin <sergey.kambalin@auriga.com>

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
Message-Id: <20230531155258.8361-1-sergey.kambalin@auriga.com>
[PMD: Split from bigger patch: 1/4]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/misc/raspberrypi-fw-defs.h | 163 ++++++++++++++++++++++++++
 1 file changed, 163 insertions(+)
 create mode 100644 include/hw/misc/raspberrypi-fw-defs.h

diff --git a/include/hw/misc/raspberrypi-fw-defs.h b/include/hw/misc/raspberrypi-fw-defs.h
new file mode 100644
index 0000000000..4551fe7450
--- /dev/null
+++ b/include/hw/misc/raspberrypi-fw-defs.h
@@ -0,0 +1,163 @@
+/*
+ * Raspberry Pi firmware definitions
+ *
+ * Copyright (C) 2022  Auriga LLC, based on Linux kernel
+ *   `include/soc/bcm2835/raspberrypi-firmware.h` (Copyright © 2015 Broadcom)
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef INCLUDE_HW_MISC_RASPBERRYPI_FW_DEFS_H_
+#define INCLUDE_HW_MISC_RASPBERRYPI_FW_DEFS_H_
+
+#include "qemu/osdep.h"
+
+enum rpi_firmware_property_tag {
+    RPI_FWREQ_PROPERTY_END =                           0,
+    RPI_FWREQ_GET_FIRMWARE_REVISION =                  0x00000001,
+    RPI_FWREQ_GET_FIRMWARE_VARIANT =                   0x00000002,
+    RPI_FWREQ_GET_FIRMWARE_HASH =                      0x00000003,
+
+    RPI_FWREQ_SET_CURSOR_INFO =                        0x00008010,
+    RPI_FWREQ_SET_CURSOR_STATE =                       0x00008011,
+
+    RPI_FWREQ_GET_BOARD_MODEL =                        0x00010001,
+    RPI_FWREQ_GET_BOARD_REVISION =                     0x00010002,
+    RPI_FWREQ_GET_BOARD_MAC_ADDRESS =                  0x00010003,
+    RPI_FWREQ_GET_BOARD_SERIAL =                       0x00010004,
+    RPI_FWREQ_GET_ARM_MEMORY =                         0x00010005,
+    RPI_FWREQ_GET_VC_MEMORY =                          0x00010006,
+    RPI_FWREQ_GET_CLOCKS =                             0x00010007,
+    RPI_FWREQ_GET_POWER_STATE =                        0x00020001,
+    RPI_FWREQ_GET_TIMING =                             0x00020002,
+    RPI_FWREQ_SET_POWER_STATE =                        0x00028001,
+    RPI_FWREQ_GET_CLOCK_STATE =                        0x00030001,
+    RPI_FWREQ_GET_CLOCK_RATE =                         0x00030002,
+    RPI_FWREQ_GET_VOLTAGE =                            0x00030003,
+    RPI_FWREQ_GET_MAX_CLOCK_RATE =                     0x00030004,
+    RPI_FWREQ_GET_MAX_VOLTAGE =                        0x00030005,
+    RPI_FWREQ_GET_TEMPERATURE =                        0x00030006,
+    RPI_FWREQ_GET_MIN_CLOCK_RATE =                     0x00030007,
+    RPI_FWREQ_GET_MIN_VOLTAGE =                        0x00030008,
+    RPI_FWREQ_GET_TURBO =                              0x00030009,
+    RPI_FWREQ_GET_MAX_TEMPERATURE =                    0x0003000a,
+    RPI_FWREQ_GET_STC =                                0x0003000b,
+    RPI_FWREQ_ALLOCATE_MEMORY =                        0x0003000c,
+    RPI_FWREQ_LOCK_MEMORY =                            0x0003000d,
+    RPI_FWREQ_UNLOCK_MEMORY =                          0x0003000e,
+    RPI_FWREQ_RELEASE_MEMORY =                         0x0003000f,
+    RPI_FWREQ_EXECUTE_CODE =                           0x00030010,
+    RPI_FWREQ_EXECUTE_QPU =                            0x00030011,
+    RPI_FWREQ_SET_ENABLE_QPU =                         0x00030012,
+    RPI_FWREQ_GET_DISPMANX_RESOURCE_MEM_HANDLE =       0x00030014,
+    RPI_FWREQ_GET_EDID_BLOCK =                         0x00030020,
+    RPI_FWREQ_GET_CUSTOMER_OTP =                       0x00030021,
+    RPI_FWREQ_GET_EDID_BLOCK_DISPLAY =                 0x00030023,
+    RPI_FWREQ_GET_DOMAIN_STATE =                       0x00030030,
+    RPI_FWREQ_GET_THROTTLED =                          0x00030046,
+    RPI_FWREQ_GET_CLOCK_MEASURED =                     0x00030047,
+    RPI_FWREQ_NOTIFY_REBOOT =                          0x00030048,
+    RPI_FWREQ_SET_CLOCK_STATE =                        0x00038001,
+    RPI_FWREQ_SET_CLOCK_RATE =                         0x00038002,
+    RPI_FWREQ_SET_VOLTAGE =                            0x00038003,
+    RPI_FWREQ_SET_MAX_CLOCK_RATE =                     0x00038004,
+    RPI_FWREQ_SET_MIN_CLOCK_RATE =                     0x00038007,
+    RPI_FWREQ_SET_TURBO =                              0x00038009,
+    RPI_FWREQ_SET_CUSTOMER_OTP =                       0x00038021,
+    RPI_FWREQ_SET_DOMAIN_STATE =                       0x00038030,
+    RPI_FWREQ_GET_GPIO_STATE =                         0x00030041,
+    RPI_FWREQ_SET_GPIO_STATE =                         0x00038041,
+    RPI_FWREQ_SET_SDHOST_CLOCK =                       0x00038042,
+    RPI_FWREQ_GET_GPIO_CONFIG =                        0x00030043,
+    RPI_FWREQ_SET_GPIO_CONFIG =                        0x00038043,
+    RPI_FWREQ_GET_PERIPH_REG =                         0x00030045,
+    RPI_FWREQ_SET_PERIPH_REG =                         0x00038045,
+    RPI_FWREQ_GET_POE_HAT_VAL =                        0x00030049,
+    RPI_FWREQ_SET_POE_HAT_VAL =                        0x00038049,
+    RPI_FWREQ_SET_POE_HAT_VAL_OLD =                    0x00030050,
+    RPI_FWREQ_NOTIFY_XHCI_RESET =                      0x00030058,
+    RPI_FWREQ_GET_REBOOT_FLAGS =                       0x00030064,
+    RPI_FWREQ_SET_REBOOT_FLAGS =                       0x00038064,
+    RPI_FWREQ_NOTIFY_DISPLAY_DONE =                    0x00030066,
+
+    /* Dispmanx TAGS */
+    RPI_FWREQ_FRAMEBUFFER_ALLOCATE =                   0x00040001,
+    RPI_FWREQ_FRAMEBUFFER_BLANK =                      0x00040002,
+    RPI_FWREQ_FRAMEBUFFER_GET_PHYSICAL_WIDTH_HEIGHT =  0x00040003,
+    RPI_FWREQ_FRAMEBUFFER_GET_VIRTUAL_WIDTH_HEIGHT =   0x00040004,
+    RPI_FWREQ_FRAMEBUFFER_GET_DEPTH =                  0x00040005,
+    RPI_FWREQ_FRAMEBUFFER_GET_PIXEL_ORDER =            0x00040006,
+    RPI_FWREQ_FRAMEBUFFER_GET_ALPHA_MODE =             0x00040007,
+    RPI_FWREQ_FRAMEBUFFER_GET_PITCH =                  0x00040008,
+    RPI_FWREQ_FRAMEBUFFER_GET_VIRTUAL_OFFSET =         0x00040009,
+    RPI_FWREQ_FRAMEBUFFER_GET_OVERSCAN =               0x0004000a,
+    RPI_FWREQ_FRAMEBUFFER_GET_PALETTE =                0x0004000b,
+    RPI_FWREQ_FRAMEBUFFER_GET_LAYER =                  0x0004000c,
+    RPI_FWREQ_FRAMEBUFFER_GET_TRANSFORM =              0x0004000d,
+    RPI_FWREQ_FRAMEBUFFER_GET_VSYNC =                  0x0004000e,
+    RPI_FWREQ_FRAMEBUFFER_GET_TOUCHBUF =               0x0004000f,
+    RPI_FWREQ_FRAMEBUFFER_GET_GPIOVIRTBUF =            0x00040010,
+    RPI_FWREQ_FRAMEBUFFER_RELEASE =                    0x00048001,
+    RPI_FWREQ_FRAMEBUFFER_GET_DISPLAY_ID =             0x00040016,
+    RPI_FWREQ_FRAMEBUFFER_SET_DISPLAY_NUM =            0x00048013,
+    RPI_FWREQ_FRAMEBUFFER_GET_NUM_DISPLAYS =           0x00040013,
+    RPI_FWREQ_FRAMEBUFFER_GET_DISPLAY_SETTINGS =       0x00040014,
+    RPI_FWREQ_FRAMEBUFFER_TEST_PHYSICAL_WIDTH_HEIGHT = 0x00044003,
+    RPI_FWREQ_FRAMEBUFFER_TEST_VIRTUAL_WIDTH_HEIGHT =  0x00044004,
+    RPI_FWREQ_FRAMEBUFFER_TEST_DEPTH =                 0x00044005,
+    RPI_FWREQ_FRAMEBUFFER_TEST_PIXEL_ORDER =           0x00044006,
+    RPI_FWREQ_FRAMEBUFFER_TEST_ALPHA_MODE =            0x00044007,
+    RPI_FWREQ_FRAMEBUFFER_TEST_VIRTUAL_OFFSET =        0x00044009,
+    RPI_FWREQ_FRAMEBUFFER_TEST_OVERSCAN =              0x0004400a,
+    RPI_FWREQ_FRAMEBUFFER_TEST_PALETTE =               0x0004400b,
+    RPI_FWREQ_FRAMEBUFFER_TEST_LAYER =                 0x0004400c,
+    RPI_FWREQ_FRAMEBUFFER_TEST_TRANSFORM =             0x0004400d,
+    RPI_FWREQ_FRAMEBUFFER_TEST_VSYNC =                 0x0004400e,
+    RPI_FWREQ_FRAMEBUFFER_SET_PHYSICAL_WIDTH_HEIGHT =  0x00048003,
+    RPI_FWREQ_FRAMEBUFFER_SET_VIRTUAL_WIDTH_HEIGHT =   0x00048004,
+    RPI_FWREQ_FRAMEBUFFER_SET_DEPTH =                  0x00048005,
+    RPI_FWREQ_FRAMEBUFFER_SET_PIXEL_ORDER =            0x00048006,
+    RPI_FWREQ_FRAMEBUFFER_SET_ALPHA_MODE =             0x00048007,
+    RPI_FWREQ_FRAMEBUFFER_SET_PITCH =                  0x00048008,
+    RPI_FWREQ_FRAMEBUFFER_SET_VIRTUAL_OFFSET =         0x00048009,
+    RPI_FWREQ_FRAMEBUFFER_SET_OVERSCAN =               0x0004800a,
+    RPI_FWREQ_FRAMEBUFFER_SET_PALETTE =                0x0004800b,
+
+    RPI_FWREQ_FRAMEBUFFER_SET_TOUCHBUF =               0x0004801f,
+    RPI_FWREQ_FRAMEBUFFER_SET_GPIOVIRTBUF =            0x00048020,
+    RPI_FWREQ_FRAMEBUFFER_SET_VSYNC =                  0x0004800e,
+    RPI_FWREQ_FRAMEBUFFER_SET_LAYER =                  0x0004800c,
+    RPI_FWREQ_FRAMEBUFFER_SET_TRANSFORM =              0x0004800d,
+    RPI_FWREQ_FRAMEBUFFER_SET_BACKLIGHT =              0x0004800f,
+
+    RPI_FWREQ_VCHIQ_INIT =                             0x00048010,
+
+    RPI_FWREQ_SET_PLANE =                              0x00048015,
+    RPI_FWREQ_GET_DISPLAY_TIMING =                     0x00040017,
+    RPI_FWREQ_SET_TIMING =                             0x00048017,
+    RPI_FWREQ_GET_DISPLAY_CFG =                        0x00040018,
+    RPI_FWREQ_SET_DISPLAY_POWER =                      0x00048019,
+    RPI_FWREQ_GET_COMMAND_LINE =                       0x00050001,
+    RPI_FWREQ_GET_DMA_CHANNELS =                       0x00060001,
+};
+
+enum rpi_firmware_clk_id {
+    RPI_FIRMWARE_EMMC_CLK_ID = 1,
+    RPI_FIRMWARE_UART_CLK_ID,
+    RPI_FIRMWARE_ARM_CLK_ID,
+    RPI_FIRMWARE_CORE_CLK_ID,
+    RPI_FIRMWARE_V3D_CLK_ID,
+    RPI_FIRMWARE_H264_CLK_ID,
+    RPI_FIRMWARE_ISP_CLK_ID,
+    RPI_FIRMWARE_SDRAM_CLK_ID,
+    RPI_FIRMWARE_PIXEL_CLK_ID,
+    RPI_FIRMWARE_PWM_CLK_ID,
+    RPI_FIRMWARE_HEVC_CLK_ID,
+    RPI_FIRMWARE_EMMC2_CLK_ID,
+    RPI_FIRMWARE_M2MC_CLK_ID,
+    RPI_FIRMWARE_PIXEL_BVB_CLK_ID,
+    RPI_FIRMWARE_VEC_CLK_ID,
+    RPI_FIRMWARE_NUM_CLK_ID,
+};
+
+#endif /* INCLUDE_HW_MISC_RASPBERRYPI_FW_DEFS_H_ */
-- 
2.38.1


