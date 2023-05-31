Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B947186CA
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 17:54:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4O8N-0003BF-Lk; Wed, 31 May 2023 11:53:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1q4O8K-00038v-Q3; Wed, 31 May 2023 11:53:08 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1q4O8H-00050Z-Vn; Wed, 31 May 2023 11:53:08 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3f606912ebaso62417085e9.3; 
 Wed, 31 May 2023 08:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685548383; x=1688140383;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=B3CBt5cR18X3/kTyjyKdHUofpIo5LTgCesa3oAsxEwQ=;
 b=R2LYnD/e7q33m0EEdi2FYUrI/Ax+xJMMFV3z9+LqVmD9l15JAZxv1OpPksxwFFn6WH
 HGwlbUSQ+0CMFNm2CvNjw3PGAyto6dOTVVC/pFh02lqXGHq+9eMF/qxPc66/Zo/7pD4W
 QRQzgJpp8064SCRESWZqCDQc6aFi5ec4yvf8PuO7iqSSZ1AJsXdee9VX99t+ift1CXkM
 LoNfgk0KQWTKNdVUSBjs51LYWauV0/w/3p9wwUDnRRlMjZcFE5qzxcK94F0OzW0LC457
 0phzLpiiZ/f94KVBThMiiQAdSLaElw/CHO64L/x0DK26B2vOsBM6u+RU4uRJ5oJNZNUy
 Dpaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685548383; x=1688140383;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B3CBt5cR18X3/kTyjyKdHUofpIo5LTgCesa3oAsxEwQ=;
 b=G/E4afIImnhejoqo924Vo57p0+mDkedNeWCbh1pfGF7n1uvZFMs0bdPMOmz5Q8pzMB
 QW/L4fKDiKXBxzIUw/8ooiCFg5XW7COgy1RCu8WPkfYuo1q09GjsCANuu1lyKEI67bCY
 RwpSwtDDegB5WXOCoLl/8w3urmM/C7Q+2CGQurEh5jlSsWgdzb3mCXICbR5PN8wi63YR
 ic/c1A4QMKKwmiMrIYOJbDf5L8DmN3q178jphop9EVyzuLNYRQGFaFXqQj7KUFFcMiVI
 dubyve7ujPG2Y/G46aFqcAiItM3ANYWVgYgULBupisSkHrI/y9JyG0LaJp6zUeKUny5y
 ID1g==
X-Gm-Message-State: AC+VfDwuGTV2Ng8TYdJiIuQ0g1n1xqg5He+SvI+LIWmkrfRIXYNQo9LJ
 1wBYQX5RllnHnAKlSm+IaBKDo32FCMwcOQ==
X-Google-Smtp-Source: ACHHUZ4AHcdALQOei5X+TPNNhR/fvqRX3L4alwNTHCGG6QjXqV7Vr2QmTf6S/kI+elyLgrrAZxQG/A==
X-Received: by 2002:a05:6000:36c:b0:30a:edc0:c960 with SMTP id
 f12-20020a056000036c00b0030aedc0c960mr4407462wrf.26.1685548383095; 
 Wed, 31 May 2023 08:53:03 -0700 (PDT)
Received: from sergevik-thinkpad.localdomain ([213.197.136.186])
 by smtp.gmail.com with ESMTPSA id
 m6-20020a7bce06000000b003f6050d35c9sm21077035wmc.20.2023.05.31.08.53.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 May 2023 08:53:02 -0700 (PDT)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH] Use named constants in BCM props
Date: Wed, 31 May 2023 18:52:58 +0300
Message-Id: <20230531155258.8361-1-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=serg.oker@gmail.com; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 hw/misc/bcm2835_property.c            | 120 ++++++++++---------
 include/hw/arm/raspi_platform.h       |   6 +
 include/hw/misc/raspberrypi-fw-defs.h | 163 ++++++++++++++++++++++++++
 3 files changed, 236 insertions(+), 53 deletions(-)
 create mode 100644 include/hw/misc/raspberrypi-fw-defs.h

diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
index 251b3d865d..871f71fdcd 100644
--- a/hw/misc/bcm2835_property.c
+++ b/hw/misc/bcm2835_property.c
@@ -12,10 +12,12 @@
 #include "migration/vmstate.h"
 #include "hw/irq.h"
 #include "hw/misc/bcm2835_mbox_defs.h"
+#include "hw/misc/raspberrypi-fw-defs.h"
 #include "sysemu/dma.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "trace.h"
+#include "hw/arm/raspi_platform.h"
 
 /* https://github.com/raspberrypi/firmware/wiki/Mailbox-property-interface */
 
@@ -51,48 +53,48 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
         /* @(value + 8) : Request/response indicator */
         resplen = 0;
         switch (tag) {
-        case 0x00000000: /* End tag */
+        case RPI_FWREQ_PROPERTY_END: /* End tag */
             break;
-        case 0x00000001: /* Get firmware revision */
+        case RPI_FWREQ_GET_FIRMWARE_REVISION: /* Get firmware revision */
             stl_le_phys(&s->dma_as, value + 12, 346337);
             resplen = 4;
             break;
-        case 0x00010001: /* Get board model */
+        case RPI_FWREQ_GET_BOARD_MODEL: /* Get board model */
             qemu_log_mask(LOG_UNIMP,
                           "bcm2835_property: 0x%08x get board model NYI\n",
                           tag);
             resplen = 4;
             break;
-        case 0x00010002: /* Get board revision */
+        case RPI_FWREQ_GET_BOARD_REVISION: /* Get board revision */
             stl_le_phys(&s->dma_as, value + 12, s->board_rev);
             resplen = 4;
             break;
-        case 0x00010003: /* Get board MAC address */
+        case RPI_FWREQ_GET_BOARD_MAC_ADDRESS: /* Get board MAC address */
             resplen = sizeof(s->macaddr.a);
             dma_memory_write(&s->dma_as, value + 12, s->macaddr.a, resplen,
                              MEMTXATTRS_UNSPECIFIED);
             break;
-        case 0x00010004: /* Get board serial */
+        case RPI_FWREQ_GET_BOARD_SERIAL: /* Get board serial */
             qemu_log_mask(LOG_UNIMP,
                           "bcm2835_property: 0x%08x get board serial NYI\n",
                           tag);
             resplen = 8;
             break;
-        case 0x00010005: /* Get ARM memory */
+        case RPI_FWREQ_GET_ARM_MEMORY: /* Get ARM memory */
             /* base */
             stl_le_phys(&s->dma_as, value + 12, 0);
             /* size */
             stl_le_phys(&s->dma_as, value + 16, s->fbdev->vcram_base);
             resplen = 8;
             break;
-        case 0x00010006: /* Get VC memory */
+        case RPI_FWREQ_GET_VC_MEMORY: /* Get VC memory */
             /* base */
             stl_le_phys(&s->dma_as, value + 12, s->fbdev->vcram_base);
             /* size */
             stl_le_phys(&s->dma_as, value + 16, s->fbdev->vcram_size);
             resplen = 8;
             break;
-        case 0x00028001: /* Set power state */
+        case RPI_FWREQ_SET_POWER_STATE: /* Set power state */
             /* Assume that whatever device they asked for exists,
              * and we'll just claim we set it to the desired state
              */
@@ -103,38 +105,42 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
 
         /* Clocks */
 
-        case 0x00030001: /* Get clock state */
+        case RPI_FWREQ_GET_CLOCK_STATE: /* Get clock state */
             stl_le_phys(&s->dma_as, value + 16, 0x1);
             resplen = 8;
             break;
 
-        case 0x00038001: /* Set clock state */
+        case RPI_FWREQ_SET_CLOCK_STATE: /* Set clock state */
             qemu_log_mask(LOG_UNIMP,
                           "bcm2835_property: 0x%08x set clock state NYI\n",
                           tag);
             resplen = 8;
             break;
 
-        case 0x00030002: /* Get clock rate */
-        case 0x00030004: /* Get max clock rate */
-        case 0x00030007: /* Get min clock rate */
+        case RPI_FWREQ_GET_CLOCK_RATE: /* Get clock rate */
+        case RPI_FWREQ_GET_MAX_CLOCK_RATE: /* Get max clock rate */
+        case RPI_FWREQ_GET_MIN_CLOCK_RATE: /* Get min clock rate */
             switch (ldl_le_phys(&s->dma_as, value + 12)) {
-            case 1: /* EMMC */
-                stl_le_phys(&s->dma_as, value + 16, 50000000);
+            case RPI_FIRMWARE_EMMC_CLK_ID: /* EMMC */
+                stl_le_phys(&s->dma_as, value + 16, RPI_FIRMWARE_EMMC_CLK_RATE);
                 break;
-            case 2: /* UART */
-                stl_le_phys(&s->dma_as, value + 16, 3000000);
+            case RPI_FIRMWARE_UART_CLK_ID: /* UART */
+                stl_le_phys(&s->dma_as, value + 16, RPI_FIRMWARE_UART_CLK_RATE);
+                break;
+            case RPI_FIRMWARE_CORE_CLK_ID: /* Core Clock */
+                stl_le_phys(&s->dma_as, value + 16, RPI_FIRMWARE_CORE_CLK_RATE);
                 break;
             default:
-                stl_le_phys(&s->dma_as, value + 16, 700000000);
+                stl_le_phys(&s->dma_as, value + 16,
+                            RPI_FIRMWARE_DEFAULT_CLK_RATE);
                 break;
             }
             resplen = 8;
             break;
 
-        case 0x00038002: /* Set clock rate */
-        case 0x00038004: /* Set max clock rate */
-        case 0x00038007: /* Set min clock rate */
+        case RPI_FWREQ_SET_CLOCK_RATE: /* Set clock rate */
+        case RPI_FWREQ_SET_MAX_CLOCK_RATE: /* Set max clock rate */
+        case RPI_FWREQ_SET_MIN_CLOCK_RATE: /* Set min clock rate */
             qemu_log_mask(LOG_UNIMP,
                           "bcm2835_property: 0x%08x set clock rate NYI\n",
                           tag);
@@ -143,121 +149,128 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
 
         /* Temperature */
 
-        case 0x00030006: /* Get temperature */
+        case RPI_FWREQ_GET_TEMPERATURE: /* Get temperature */
             stl_le_phys(&s->dma_as, value + 16, 25000);
             resplen = 8;
             break;
 
-        case 0x0003000A: /* Get max temperature */
+        case RPI_FWREQ_GET_MAX_TEMPERATURE: /* Get max temperature */
             stl_le_phys(&s->dma_as, value + 16, 99000);
             resplen = 8;
             break;
 
         /* Frame buffer */
 
-        case 0x00040001: /* Allocate buffer */
+        case RPI_FWREQ_FRAMEBUFFER_ALLOCATE: /* Allocate buffer */
             stl_le_phys(&s->dma_as, value + 12, fbconfig.base);
             stl_le_phys(&s->dma_as, value + 16,
                         bcm2835_fb_get_size(&fbconfig));
             resplen = 8;
             break;
-        case 0x00048001: /* Release buffer */
+        case RPI_FWREQ_FRAMEBUFFER_RELEASE: /* Release buffer */
             resplen = 0;
             break;
-        case 0x00040002: /* Blank screen */
+        case RPI_FWREQ_FRAMEBUFFER_BLANK: /* Blank screen */
             resplen = 4;
             break;
-        case 0x00044003: /* Test physical display width/height */
-        case 0x00044004: /* Test virtual display width/height */
+        /* Test physical display width/height */
+        case RPI_FWREQ_FRAMEBUFFER_TEST_PHYSICAL_WIDTH_HEIGHT:
+        /* Test virtual display width/height */
+        case RPI_FWREQ_FRAMEBUFFER_TEST_VIRTUAL_WIDTH_HEIGHT:
             resplen = 8;
             break;
-        case 0x00048003: /* Set physical display width/height */
+        /* Set physical display width/height */
+        case RPI_FWREQ_FRAMEBUFFER_SET_PHYSICAL_WIDTH_HEIGHT:
             fbconfig.xres = ldl_le_phys(&s->dma_as, value + 12);
             fbconfig.yres = ldl_le_phys(&s->dma_as, value + 16);
             bcm2835_fb_validate_config(&fbconfig);
             fbconfig_updated = true;
             /* fall through */
-        case 0x00040003: /* Get physical display width/height */
+        /* Get physical display width/height */
+        case RPI_FWREQ_FRAMEBUFFER_GET_PHYSICAL_WIDTH_HEIGHT:
             stl_le_phys(&s->dma_as, value + 12, fbconfig.xres);
             stl_le_phys(&s->dma_as, value + 16, fbconfig.yres);
             resplen = 8;
             break;
-        case 0x00048004: /* Set virtual display width/height */
+        /* Set virtual display width/height */
+        case RPI_FWREQ_FRAMEBUFFER_SET_VIRTUAL_WIDTH_HEIGHT:
             fbconfig.xres_virtual = ldl_le_phys(&s->dma_as, value + 12);
             fbconfig.yres_virtual = ldl_le_phys(&s->dma_as, value + 16);
             bcm2835_fb_validate_config(&fbconfig);
             fbconfig_updated = true;
             /* fall through */
-        case 0x00040004: /* Get virtual display width/height */
+        /* Get virtual display width/height */
+        case RPI_FWREQ_FRAMEBUFFER_GET_VIRTUAL_WIDTH_HEIGHT:
             stl_le_phys(&s->dma_as, value + 12, fbconfig.xres_virtual);
             stl_le_phys(&s->dma_as, value + 16, fbconfig.yres_virtual);
             resplen = 8;
             break;
-        case 0x00044005: /* Test depth */
+        case RPI_FWREQ_FRAMEBUFFER_TEST_DEPTH: /* Test depth */
             resplen = 4;
             break;
-        case 0x00048005: /* Set depth */
+        case RPI_FWREQ_FRAMEBUFFER_SET_DEPTH: /* Set depth */
             fbconfig.bpp = ldl_le_phys(&s->dma_as, value + 12);
             bcm2835_fb_validate_config(&fbconfig);
             fbconfig_updated = true;
             /* fall through */
-        case 0x00040005: /* Get depth */
+        case RPI_FWREQ_FRAMEBUFFER_GET_DEPTH: /* Get depth */
             stl_le_phys(&s->dma_as, value + 12, fbconfig.bpp);
             resplen = 4;
             break;
-        case 0x00044006: /* Test pixel order */
+        case RPI_FWREQ_FRAMEBUFFER_TEST_PIXEL_ORDER: /* Test pixel order */
             resplen = 4;
             break;
-        case 0x00048006: /* Set pixel order */
+        case RPI_FWREQ_FRAMEBUFFER_SET_PIXEL_ORDER: /* Set pixel order */
             fbconfig.pixo = ldl_le_phys(&s->dma_as, value + 12);
             bcm2835_fb_validate_config(&fbconfig);
             fbconfig_updated = true;
             /* fall through */
-        case 0x00040006: /* Get pixel order */
+        case RPI_FWREQ_FRAMEBUFFER_GET_PIXEL_ORDER: /* Get pixel order */
             stl_le_phys(&s->dma_as, value + 12, fbconfig.pixo);
             resplen = 4;
             break;
-        case 0x00044007: /* Test pixel alpha */
+        case RPI_FWREQ_FRAMEBUFFER_TEST_ALPHA_MODE: /* Test pixel alpha */
             resplen = 4;
             break;
-        case 0x00048007: /* Set alpha */
+        case RPI_FWREQ_FRAMEBUFFER_SET_ALPHA_MODE: /* Set alpha */
             fbconfig.alpha = ldl_le_phys(&s->dma_as, value + 12);
             bcm2835_fb_validate_config(&fbconfig);
             fbconfig_updated = true;
             /* fall through */
-        case 0x00040007: /* Get alpha */
+        case RPI_FWREQ_FRAMEBUFFER_GET_ALPHA_MODE: /* Get alpha */
             stl_le_phys(&s->dma_as, value + 12, fbconfig.alpha);
             resplen = 4;
             break;
-        case 0x00040008: /* Get pitch */
+        case RPI_FWREQ_FRAMEBUFFER_GET_PITCH: /* Get pitch */
             stl_le_phys(&s->dma_as, value + 12,
                         bcm2835_fb_get_pitch(&fbconfig));
             resplen = 4;
             break;
-        case 0x00044009: /* Test virtual offset */
+        /* Test virtual offset */
+        case RPI_FWREQ_FRAMEBUFFER_TEST_VIRTUAL_OFFSET:
             resplen = 8;
             break;
-        case 0x00048009: /* Set virtual offset */
+        case RPI_FWREQ_FRAMEBUFFER_SET_VIRTUAL_OFFSET: /* Set virtual offset */
             fbconfig.xoffset = ldl_le_phys(&s->dma_as, value + 12);
             fbconfig.yoffset = ldl_le_phys(&s->dma_as, value + 16);
             bcm2835_fb_validate_config(&fbconfig);
             fbconfig_updated = true;
             /* fall through */
-        case 0x00040009: /* Get virtual offset */
+        case RPI_FWREQ_FRAMEBUFFER_GET_VIRTUAL_OFFSET: /* Get virtual offset */
             stl_le_phys(&s->dma_as, value + 12, fbconfig.xoffset);
             stl_le_phys(&s->dma_as, value + 16, fbconfig.yoffset);
             resplen = 8;
             break;
-        case 0x0004000a: /* Get/Test/Set overscan */
-        case 0x0004400a:
-        case 0x0004800a:
+        case RPI_FWREQ_FRAMEBUFFER_GET_OVERSCAN: /* Get/Test/Set overscan */
+        case RPI_FWREQ_FRAMEBUFFER_TEST_OVERSCAN:
+        case RPI_FWREQ_FRAMEBUFFER_SET_OVERSCAN:
             stl_le_phys(&s->dma_as, value + 12, 0);
             stl_le_phys(&s->dma_as, value + 16, 0);
             stl_le_phys(&s->dma_as, value + 20, 0);
             stl_le_phys(&s->dma_as, value + 24, 0);
             resplen = 16;
             break;
-        case 0x0004800b: /* Set palette */
+        case RPI_FWREQ_FRAMEBUFFER_SET_PALETTE: /* Set palette */
             offset = ldl_le_phys(&s->dma_as, value + 12);
             length = ldl_le_phys(&s->dma_as, value + 16);
             n = 0;
@@ -270,18 +283,19 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
             stl_le_phys(&s->dma_as, value + 12, 0);
             resplen = 4;
             break;
-        case 0x00040013: /* Get number of displays */
+        /* Get number of displays */
+        case RPI_FWREQ_FRAMEBUFFER_GET_NUM_DISPLAYS:
             stl_le_phys(&s->dma_as, value + 12, 1);
             resplen = 4;
             break;
 
-        case 0x00060001: /* Get DMA channels */
+        case RPI_FWREQ_GET_DMA_CHANNELS: /* Get DMA channels */
             /* channels 2-5 */
             stl_le_phys(&s->dma_as, value + 12, 0x003C);
             resplen = 4;
             break;
 
-        case 0x00050001: /* Get command line */
+        case RPI_FWREQ_GET_COMMAND_LINE: /* Get command line */
             /*
              * We follow the firmware behaviour: no NUL terminator is
              * written to the buffer, and if the buffer is too short
diff --git a/include/hw/arm/raspi_platform.h b/include/hw/arm/raspi_platform.h
index 4a56dd4b89..92a317950a 100644
--- a/include/hw/arm/raspi_platform.h
+++ b/include/hw/arm/raspi_platform.h
@@ -170,4 +170,10 @@
 #define INTERRUPT_ILLEGAL_TYPE0        6
 #define INTERRUPT_ILLEGAL_TYPE1        7
 
+/* Clock rates */
+#define RPI_FIRMWARE_EMMC_CLK_RATE    50000000
+#define RPI_FIRMWARE_UART_CLK_RATE    3000000
+#define RPI_FIRMWARE_CORE_CLK_RATE    350000000
+#define RPI_FIRMWARE_DEFAULT_CLK_RATE 700000000
+
 #endif
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
2.34.1


