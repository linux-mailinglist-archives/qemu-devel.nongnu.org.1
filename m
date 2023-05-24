Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F45E70FE5A
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 21:15:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1twk-0001AT-LH; Wed, 24 May 2023 15:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1q1twi-00019m-Rl; Wed, 24 May 2023 15:14:52 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1q1twf-0000Td-Mr; Wed, 24 May 2023 15:14:52 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3093a778089so838911f8f.1; 
 Wed, 24 May 2023 12:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684955686; x=1687547686;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mZBW7p0+R8VKp6a79N1D0UVeu3tzD3M81PcUxDkw39I=;
 b=OewNERxr5VG3XkRo6YjDVC9/KvCBUog57+e1R+V0P5VICzLBYlqHv7EdfR4Ftipz9d
 kLT3niQTfxDt6D21UbMss6G8M4GKkCEOxkBcS9rxnnhBGJJbjN9Dx+HbFFJWBWfmC6d/
 9woVgZBMsVjBsq8sJQkrBU8h1AyXZjG/HNy9zT1bSfrWxpWIIybbYxLEeuGlO8nLiobK
 ylGln08XUcMiv8F63M9lw6qDZGsWWDDhijneLMrWz/+mtnJOMeC1QV0xVpdknqObGkT+
 khB20fdeDkf5d/i13CwSi/ehAAt8TUOOx/Dga3r+22ayHpcQVNxAzP9m0raKgGt+OoRC
 HT1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684955686; x=1687547686;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mZBW7p0+R8VKp6a79N1D0UVeu3tzD3M81PcUxDkw39I=;
 b=ELKwmhOZCcR1MpS6Z4umA6i4tdTHTKe6plQN+W00OA/fVzSxkxKuJb2cDupIB53lam
 EJvFsYSwzCtu8qG+sIuklFYvAoQUF6XcsIe7rL2WbB8FYLJpf6ig/tKVijmpojcHdxHy
 0ZvLw+h2XFIfPM/C09OTSDTgA+5TaoX4fH3R9L9zzCTD+kME+yvCqs2Ai+0EWRXprhdm
 3/U2KptAI5G4gL7ihkC/tSoV7jbpqFYuqjb/9Q985lISqDilJHXDJNgcQclcvZ3QKX0C
 5iI+byblIac8N+bI+rfIwHL6KkEZD53+eYUn4JeMPaIL+pcVaUxYlJKCcgm2475J18M1
 cB1w==
X-Gm-Message-State: AC+VfDxuGFW6OlnTutI59v0jCzxXL7NqavXNpVnYxiv/SRX/o+lfAZjg
 32lxLmBJPv0OA49jvOH8REBz2yOrc70=
X-Google-Smtp-Source: ACHHUZ5qT0VyMGsafx0g8hGF4vF3EcpKq5M4HsBbKQh+7uR3k00EHiIfWDQjKtdbiXHJVTcu7IKQAQ==
X-Received: by 2002:a5d:4dc2:0:b0:306:3284:824f with SMTP id
 f2-20020a5d4dc2000000b003063284824fmr677553wru.8.1684955686063; 
 Wed, 24 May 2023 12:14:46 -0700 (PDT)
Received: from sergevik-thinkpad.localdomain ([213.197.136.186])
 by smtp.gmail.com with ESMTPSA id
 i18-20020a5d5232000000b002ff2c39d072sm15167301wra.104.2023.05.24.12.14.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 May 2023 12:14:45 -0700 (PDT)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH] Prepare bcm properties for videocore 4
Date: Wed, 24 May 2023 22:14:38 +0300
Message-Id: <20230524191438.172019-1-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=serg.oker@gmail.com; helo=mail-wr1-x42f.google.com
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

Hello!
Sorry for a quite a big patch, but most of the changes are the same type.
Most of the patch is about a definition of new constants/structs and replacing
magic numbers with those constants.


Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 hw/misc/bcm2835_property.c            | 314 +++++++++++++++++++++-----
 include/hw/arm/raspi_platform.h       |   5 +
 include/hw/misc/raspberrypi-fw-defs.h | 169 ++++++++++++++
 3 files changed, 431 insertions(+), 57 deletions(-)
 create mode 100644 include/hw/misc/raspberrypi-fw-defs.h

diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
index 251b3d865d..70a8ed0a8c 100644
--- a/hw/misc/bcm2835_property.c
+++ b/hw/misc/bcm2835_property.c
@@ -12,10 +12,56 @@
 #include "migration/vmstate.h"
 #include "hw/irq.h"
 #include "hw/misc/bcm2835_mbox_defs.h"
+#include "hw/misc/raspberrypi-fw-defs.h"
 #include "sysemu/dma.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "trace.h"
+#include "hw/arm/raspi_platform.h"
+
+#define RPI_EXP_GPIO_BASE       128
+#define VC4_GPIO_EXPANDER_COUNT 8
+
+struct vc4_display_settings_t {
+    uint32_t display_num;
+    uint32_t width;
+    uint32_t height;
+    uint32_t depth;
+    uint16_t pitch;
+    uint32_t virtual_width;
+    uint32_t virtual_height;
+    uint16_t virtual_width_offset;
+    uint32_t virtual_height_offset;
+    unsigned long fb_bus_address;
+} QEMU_PACKED;
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
+struct vc4_gpio_expander_t {
+    uint32_t direction;
+    uint32_t polarity;
+    uint32_t term_en;
+    uint32_t term_pull_up;
+    uint32_t state;
+} vc4_gpio_expander[VC4_GPIO_EXPANDER_COUNT];
+
 
 /* https://github.com/raspberrypi/firmware/wiki/Mailbox-property-interface */
 
@@ -28,6 +74,7 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
     uint32_t tmp;
     int n;
     uint32_t offset, length, color;
+    uint32_t gpio_num;
 
     /*
      * Copy the current state of the framebuffer config; we will update
@@ -51,48 +98,48 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
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
@@ -102,39 +149,49 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
             break;
 
         /* Clocks */
-
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
+                break;
+            case RPI_FIRMWARE_UART_CLK_ID: /* UART */
+                stl_le_phys(&s->dma_as, value + 16, RPI_FIRMWARE_UART_CLK_RATE);
                 break;
-            case 2: /* UART */
-                stl_le_phys(&s->dma_as, value + 16, 3000000);
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
+        case RPI_FWREQ_GET_CLOCKS: /* Get clocks */
+            /* TODO: add more clock IDs if needed */
+            stl_le_phys(&s->dma_as, value + 12, 0);
+            stl_le_phys(&s->dma_as, value + 16, RPI_FIRMWARE_ARM_CLK_ID);
+            resplen = 8;
+            break;
+
+        case RPI_FWREQ_SET_CLOCK_RATE: /* Set clock rate */
+        case RPI_FWREQ_SET_MAX_CLOCK_RATE: /* Set max clock rate */
+        case RPI_FWREQ_SET_MIN_CLOCK_RATE: /* Set min clock rate */
             qemu_log_mask(LOG_UNIMP,
                           "bcm2835_property: 0x%08x set clock rate NYI\n",
                           tag);
@@ -142,122 +199,126 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
             break;
 
         /* Temperature */
-
-        case 0x00030006: /* Get temperature */
+        case RPI_FWREQ_GET_TEMPERATURE: /* Get temperature */
             stl_le_phys(&s->dma_as, value + 16, 25000);
             resplen = 8;
             break;
-
-        case 0x0003000A: /* Get max temperature */
+        case RPI_FWREQ_GET_MAX_TEMPERATURE: /* Get max temperature */
             stl_le_phys(&s->dma_as, value + 16, 99000);
             resplen = 8;
             break;
 
         /* Frame buffer */
-
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
@@ -270,18 +331,19 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
             stl_le_phys(&s->dma_as, value + 12, 0);
             resplen = 4;
             break;
-        case 0x00040013: /* Get number of displays */
+
+        case RPI_FWREQ_FRAMEBUFFER_GET_NUM_DISPLAYS: /* Get num of displays */
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
@@ -295,6 +357,144 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
                                     resplen);
             break;
 
+        case RPI_FWREQ_GET_THROTTLED: /* Get throttled */
+            stl_le_phys(&s->dma_as, value + 12, 0);
+            resplen = 4;
+            break;
+
+        /* Get display settings*/
+        case RPI_FWREQ_FRAMEBUFFER_GET_DISPLAY_SETTINGS:
+            stl_le_phys(&s->dma_as, value + 12, 0); /* display_num */
+            stl_le_phys(&s->dma_as, value + 16, 800); /* width */
+            stl_le_phys(&s->dma_as, value + 20, 600); /* height */
+            stl_le_phys(&s->dma_as, value + 24, 32); /* depth */
+            stl_le_phys(&s->dma_as, value + 28, 32); /* pitch */
+            stl_le_phys(&s->dma_as, value + 30, 0); /* virtual_width */
+            stl_le_phys(&s->dma_as, value + 34, 0); /* virtual_height */
+            stl_le_phys(&s->dma_as, value + 38, 0); /* virtual_width_offset */
+            stl_le_phys(&s->dma_as, value + 40, 0); /* virtual_height_offset */
+            stl_le_phys(&s->dma_as, value + 44, 0); /* fb_bus_address low */
+            stl_le_phys(&s->dma_as, value + 48, 0); /* fb_bus_address hi */
+            resplen = sizeof(struct vc4_display_settings_t);
+            break;
+
+        case RPI_FWREQ_FRAMEBUFFER_SET_PITCH: /* Set Pitch */
+            resplen = 0;
+            break;
+
+        case RPI_FWREQ_GET_GPIO_CONFIG:
+            if (ldl_le_phys(&s->dma_as, value + 12) < RPI_EXP_GPIO_BASE) {
+                qemu_log_mask(LOG_UNIMP, "RPI_FWREQ_GET_GPIO_CONFIG "
+                              "not implemented for gpiochip0\n");
+            } else {
+                gpio_num = ldl_le_phys(&s->dma_as, value + 12)
+                           - RPI_EXP_GPIO_BASE;
+
+                if (gpio_num < VC4_GPIO_EXPANDER_COUNT) {
+                    stl_le_phys(&s->dma_as, value + 16,
+                                vc4_gpio_expander[gpio_num].direction);
+                    stl_le_phys(&s->dma_as, value + 20,
+                                vc4_gpio_expander[gpio_num].polarity);
+                    stl_le_phys(&s->dma_as, value + 24,
+                                vc4_gpio_expander[gpio_num].term_en);
+                    stl_le_phys(&s->dma_as, value + 28,
+                                vc4_gpio_expander[gpio_num].term_pull_up);
+                    /* must be equal 0 */
+                    stl_le_phys(&s->dma_as, value + 12, 0);
+                    resplen = 4 * 5;
+                } else {
+                    qemu_log_mask(LOG_GUEST_ERROR,
+                                  "RPI_FWREQ_GET_GPIO_CONFIG "
+                                  "gpio num must be < %d",
+                                  RPI_EXP_GPIO_BASE + VC4_GPIO_EXPANDER_COUNT);
+                }
+            }
+            break;
+
+        case RPI_FWREQ_SET_GPIO_CONFIG:
+            if (ldl_le_phys(&s->dma_as, value + 12) < RPI_EXP_GPIO_BASE) {
+                qemu_log_mask(LOG_UNIMP, "RPI_FWREQ_SET_GPIO_CONFIG "
+                              "not implemented for gpiochip0\n");
+            } else {
+                gpio_num = ldl_le_phys(&s->dma_as, value + 12)
+                           - RPI_EXP_GPIO_BASE;
+
+                if (gpio_num < VC4_GPIO_EXPANDER_COUNT) {
+                    vc4_gpio_expander[gpio_num].direction =
+                        ldl_le_phys(&s->dma_as, value + 16);
+                    vc4_gpio_expander[gpio_num].polarity =
+                        ldl_le_phys(&s->dma_as, value + 20);
+                    vc4_gpio_expander[gpio_num].term_en =
+                        ldl_le_phys(&s->dma_as, value + 24);
+                    vc4_gpio_expander[gpio_num].term_pull_up =
+                        ldl_le_phys(&s->dma_as, value + 28);
+                    vc4_gpio_expander[gpio_num].state =
+                        ldl_le_phys(&s->dma_as, value + 32);
+                    /* must be equal 0 */
+                    stl_le_phys(&s->dma_as, value + 12, 0);
+                    resplen = 4;
+                } else {
+                    qemu_log_mask(LOG_GUEST_ERROR,
+                                  "RPI_FWREQ_SET_GPIO_CONFIG "
+                                  "gpio num must be < %d",
+                                  RPI_EXP_GPIO_BASE + VC4_GPIO_EXPANDER_COUNT);
+                }
+            }
+            break;
+
+        case RPI_FWREQ_GET_GPIO_STATE:
+            if (ldl_le_phys(&s->dma_as, value + 12) < RPI_EXP_GPIO_BASE) {
+                qemu_log_mask(LOG_UNIMP, "RPI_FWREQ_GET_GPIO_STATE "
+                              "not implemented for gpiochip0\n");
+            } else {
+                gpio_num = ldl_le_phys(&s->dma_as, value + 12)
+                           - RPI_EXP_GPIO_BASE;
+
+                if (gpio_num < VC4_GPIO_EXPANDER_COUNT) {
+                    stl_le_phys(&s->dma_as, value + 16,
+                                vc4_gpio_expander[gpio_num].state);
+                    /* must be equal 0 */
+                    stl_le_phys(&s->dma_as, value + 12, 0);
+                    resplen = 8;
+                } else {
+                    qemu_log_mask(LOG_GUEST_ERROR,
+                                  "RPI_FWREQ_GET_GPIO_STATE "
+                                  "gpio num must be < %d",
+                                  RPI_EXP_GPIO_BASE + VC4_GPIO_EXPANDER_COUNT);
+                }
+            }
+            break;
+
+        case RPI_FWREQ_SET_GPIO_STATE:
+            if (ldl_le_phys(&s->dma_as, value + 12) < RPI_EXP_GPIO_BASE) {
+                qemu_log_mask(LOG_UNIMP, "RPI_FWREQ_SET_GPIO_STATE not "
+                              "implemented for gpiochip0\n");
+            } else {
+                gpio_num = ldl_le_phys(&s->dma_as, value + 12)
+                           - RPI_EXP_GPIO_BASE;
+
+                if (gpio_num < VC4_GPIO_EXPANDER_COUNT) {
+                    vc4_gpio_expander[gpio_num].state = ldl_le_phys(&s->dma_as,
+                                                                    value + 16);
+                    /* must be equal 0 */
+                    stl_le_phys(&s->dma_as, value + 12, 0);
+                    resplen = 4;
+                } else {
+                    qemu_log_mask(LOG_GUEST_ERROR,
+                                  "RPI_FWREQ_SET_GPIO_STATE "
+                                  "gpio num must be < %d",
+                                  RPI_EXP_GPIO_BASE + VC4_GPIO_EXPANDER_COUNT);
+                }
+            }
+            break;
+
+        case RPI_FWREQ_VCHIQ_INIT:
+            stl_le_phys(&s->dma_as,
+                        value + offsetof(rpi_firmware_prop_request_t, payload),
+                        0);
+            resplen = VCHI_BUSADDR_SIZE;
+            break;
+
         default:
             qemu_log_mask(LOG_UNIMP,
                           "bcm2835_property: unhandled tag 0x%08x\n", tag);
diff --git a/include/hw/arm/raspi_platform.h b/include/hw/arm/raspi_platform.h
index 4a56dd4b89..9c34987c60 100644
--- a/include/hw/arm/raspi_platform.h
+++ b/include/hw/arm/raspi_platform.h
@@ -170,4 +170,9 @@
 #define INTERRUPT_ILLEGAL_TYPE0        6
 #define INTERRUPT_ILLEGAL_TYPE1        7
 
+#define RPI_FIRMWARE_EMMC_CLK_RATE    50000000
+#define RPI_FIRMWARE_UART_CLK_RATE    3000000
+#define RPI_FIRMWARE_CORE_CLK_RATE    350000000
+#define RPI_FIRMWARE_DEFAULT_CLK_RATE 700000000
+
 #endif
diff --git a/include/hw/misc/raspberrypi-fw-defs.h b/include/hw/misc/raspberrypi-fw-defs.h
new file mode 100644
index 0000000000..2688e88522
--- /dev/null
+++ b/include/hw/misc/raspberrypi-fw-defs.h
@@ -0,0 +1,169 @@
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
+
+/**
+ * struct rpi_firmware_property_tag_header - Firmware property tag header
+ * @tag:    One of enum_mbox_property_tag.
+ * @buf_size:   The number of bytes in the value buffer following this
+ *  struct.
+ * @req_resp_size:  On submit, the length of the request (though it doesn't
+ *  appear to be currently used by the firmware).  On return,
+ *  the length of the response (always 4 byte aligned), with
+ *  the low bit set.
+ */
+struct rpi_firmware_property_tag_header {
+    uint32_t tag;
+    uint32_t buf_size;
+    uint32_t req_resp_size;
+};
+
+typedef struct rpi_firmware_prop_request {
+    struct rpi_firmware_property_tag_header hdr;
+    uint8_t payload[0];
+} rpi_firmware_prop_request_t;
+
+
+#define VCHI_BUSADDR_SIZE           sizeof(uint32_t)
+
+#endif /* INCLUDE_HW_MISC_RASPBERRYPI_FW_DEFS_H_ */
-- 
2.34.1


