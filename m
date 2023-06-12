Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A6172D482
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 00:36:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8q85-0001cn-A0; Mon, 12 Jun 2023 18:35:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8q80-0001c7-M2
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 18:35:15 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8q7y-0007pQ-BM
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 18:35:12 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-4f642a24568so5829930e87.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 15:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686609307; x=1689201307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vgLyKz9BCFYWpYlkXL1B5ecjS40jUV0mgb/FFd9TOhc=;
 b=M1a8xQiLJv+kZDdxHPXbuVRgKVgjyyOjbcQ/YYf9ZzPc1k99S20jOSmA5lM5eQtGip
 0KCOdMPz6jTr4VtDMuM46WgycQCETfNam0uBn4x1ChTEkY6dTZpl7CeVADlfn4uPMibk
 gQ/l9irRyjpV5Y6GmANQ7XILPIPvsSD7SFICejDSR8PzM+b5b8oo6sy5sUMkgmt4BjNW
 wrrOX9KTU/UyeN7XIvyFjXftbuncQWSiEsBVUiHl0XNi+0L2ykW8lxnoXHlKtHR8VU4o
 Xys0eiZO+BeCFhW19KXkmOfYNhg2u8dHVkhVbz3s+qT0YCgYQTtxe7Wa9RyDZ3v10zfK
 hZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686609307; x=1689201307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vgLyKz9BCFYWpYlkXL1B5ecjS40jUV0mgb/FFd9TOhc=;
 b=g9Qc4DcRf6Q2edohPzhXGRABPpH12frDEZUikx2HLP1shO9Nv+GK++lug0lVJrgJBP
 7FUxpVL+XF8+7623vJucRC1BU2tiv5S/6ZgcxvDxJIGvNuWfeEoDo39m41JY5ea3wwY9
 0QWqtyUZ3lMGab9LiPN3XVl+shVLllgqVvdtvbfCahOTmRimE9pwM52/1ZA9o6Rm0amq
 +oLQb3uEGWeMn+Q1QmYDxcnNeiFxTg6sjwbZj414r8jtOqHlNmwMIpdrKt0KT1EKBlaB
 mW92okLZ0kSXEPyPmb/6K4A5VwdeWz9KhWMF/szSfMasDjgooOq2koMOiy7B5huQ5j2e
 lHCQ==
X-Gm-Message-State: AC+VfDxUlFhI+beRlo7gZG/H4UL0fkMl0Ev6xcAKc+/1DKDd10XOG/Mh
 Nn5GEB9iyRuGv21doboUaTvyOTn4OwirtE3Czi0S7w==
X-Google-Smtp-Source: ACHHUZ6ym6J3rqplHpmk4kpizwdKhtbiFfayk4akBpJcr14b7+uk3xU5jgKQqsmQdGw9dZIdEHgnvA==
X-Received: by 2002:ac2:4db4:0:b0:4f3:789c:8bcf with SMTP id
 h20-20020ac24db4000000b004f3789c8bcfmr4687321lfe.4.1686609307402; 
 Mon, 12 Jun 2023 15:35:07 -0700 (PDT)
Received: from localhost.localdomain ([185.140.244.249])
 by smtp.gmail.com with ESMTPSA id
 q24-20020aa7d458000000b00518286f5837sm3476840edr.58.2023.06.12.15.35.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jun 2023 15:35:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Sergey Kambalin <sergey.kambalin@auriga.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 2/4] hw/misc/bcm2835_property: Use 'raspberrypi-fw-defs.h'
 definitions
Date: Tue, 13 Jun 2023 00:34:54 +0200
Message-Id: <20230612223456.33824-3-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230612223456.33824-1-philmd@linaro.org>
References: <20230612223456.33824-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Replace magic property values by a proper definition,
removing redundant comments.

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
Message-Id: <20230531155258.8361-1-sergey.kambalin@auriga.com>
[PMD: Split from bigger patch: 2/4]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/bcm2835_property.c | 101 +++++++++++++++++++------------------
 1 file changed, 51 insertions(+), 50 deletions(-)

diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
index 251b3d865d..7d398a6f75 100644
--- a/hw/misc/bcm2835_property.c
+++ b/hw/misc/bcm2835_property.c
@@ -12,6 +12,7 @@
 #include "migration/vmstate.h"
 #include "hw/irq.h"
 #include "hw/misc/bcm2835_mbox_defs.h"
+#include "hw/misc/raspberrypi-fw-defs.h"
 #include "sysemu/dma.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
@@ -51,48 +52,48 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
         /* @(value + 8) : Request/response indicator */
         resplen = 0;
         switch (tag) {
-        case 0x00000000: /* End tag */
+        case RPI_FWREQ_PROPERTY_END:
             break;
-        case 0x00000001: /* Get firmware revision */
+        case RPI_FWREQ_GET_FIRMWARE_REVISION:
             stl_le_phys(&s->dma_as, value + 12, 346337);
             resplen = 4;
             break;
-        case 0x00010001: /* Get board model */
+        case RPI_FWREQ_GET_BOARD_MODEL:
             qemu_log_mask(LOG_UNIMP,
                           "bcm2835_property: 0x%08x get board model NYI\n",
                           tag);
             resplen = 4;
             break;
-        case 0x00010002: /* Get board revision */
+        case RPI_FWREQ_GET_BOARD_REVISION:
             stl_le_phys(&s->dma_as, value + 12, s->board_rev);
             resplen = 4;
             break;
-        case 0x00010003: /* Get board MAC address */
+        case RPI_FWREQ_GET_BOARD_MAC_ADDRESS:
             resplen = sizeof(s->macaddr.a);
             dma_memory_write(&s->dma_as, value + 12, s->macaddr.a, resplen,
                              MEMTXATTRS_UNSPECIFIED);
             break;
-        case 0x00010004: /* Get board serial */
+        case RPI_FWREQ_GET_BOARD_SERIAL:
             qemu_log_mask(LOG_UNIMP,
                           "bcm2835_property: 0x%08x get board serial NYI\n",
                           tag);
             resplen = 8;
             break;
-        case 0x00010005: /* Get ARM memory */
+        case RPI_FWREQ_GET_ARM_MEMORY:
             /* base */
             stl_le_phys(&s->dma_as, value + 12, 0);
             /* size */
             stl_le_phys(&s->dma_as, value + 16, s->fbdev->vcram_base);
             resplen = 8;
             break;
-        case 0x00010006: /* Get VC memory */
+        case RPI_FWREQ_GET_VC_MEMORY:
             /* base */
             stl_le_phys(&s->dma_as, value + 12, s->fbdev->vcram_base);
             /* size */
             stl_le_phys(&s->dma_as, value + 16, s->fbdev->vcram_size);
             resplen = 8;
             break;
-        case 0x00028001: /* Set power state */
+        case RPI_FWREQ_SET_POWER_STATE:
             /* Assume that whatever device they asked for exists,
              * and we'll just claim we set it to the desired state
              */
@@ -103,26 +104,26 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
 
         /* Clocks */
 
-        case 0x00030001: /* Get clock state */
+        case RPI_FWREQ_GET_CLOCK_STATE:
             stl_le_phys(&s->dma_as, value + 16, 0x1);
             resplen = 8;
             break;
 
-        case 0x00038001: /* Set clock state */
+        case RPI_FWREQ_SET_CLOCK_STATE:
             qemu_log_mask(LOG_UNIMP,
                           "bcm2835_property: 0x%08x set clock state NYI\n",
                           tag);
             resplen = 8;
             break;
 
-        case 0x00030002: /* Get clock rate */
-        case 0x00030004: /* Get max clock rate */
-        case 0x00030007: /* Get min clock rate */
+        case RPI_FWREQ_GET_CLOCK_RATE:
+        case RPI_FWREQ_GET_MAX_CLOCK_RATE:
+        case RPI_FWREQ_GET_MIN_CLOCK_RATE:
             switch (ldl_le_phys(&s->dma_as, value + 12)) {
-            case 1: /* EMMC */
+            case RPI_FIRMWARE_EMMC_CLK_ID:
                 stl_le_phys(&s->dma_as, value + 16, 50000000);
                 break;
-            case 2: /* UART */
+            case RPI_FIRMWARE_UART_CLK_ID:
                 stl_le_phys(&s->dma_as, value + 16, 3000000);
                 break;
             default:
@@ -132,9 +133,9 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
             resplen = 8;
             break;
 
-        case 0x00038002: /* Set clock rate */
-        case 0x00038004: /* Set max clock rate */
-        case 0x00038007: /* Set min clock rate */
+        case RPI_FWREQ_SET_CLOCK_RATE:
+        case RPI_FWREQ_SET_MAX_CLOCK_RATE:
+        case RPI_FWREQ_SET_MIN_CLOCK_RATE:
             qemu_log_mask(LOG_UNIMP,
                           "bcm2835_property: 0x%08x set clock rate NYI\n",
                           tag);
@@ -143,121 +144,121 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
 
         /* Temperature */
 
-        case 0x00030006: /* Get temperature */
+        case RPI_FWREQ_GET_TEMPERATURE:
             stl_le_phys(&s->dma_as, value + 16, 25000);
             resplen = 8;
             break;
 
-        case 0x0003000A: /* Get max temperature */
+        case RPI_FWREQ_GET_MAX_TEMPERATURE:
             stl_le_phys(&s->dma_as, value + 16, 99000);
             resplen = 8;
             break;
 
         /* Frame buffer */
 
-        case 0x00040001: /* Allocate buffer */
+        case RPI_FWREQ_FRAMEBUFFER_ALLOCATE:
             stl_le_phys(&s->dma_as, value + 12, fbconfig.base);
             stl_le_phys(&s->dma_as, value + 16,
                         bcm2835_fb_get_size(&fbconfig));
             resplen = 8;
             break;
-        case 0x00048001: /* Release buffer */
+        case RPI_FWREQ_FRAMEBUFFER_RELEASE:
             resplen = 0;
             break;
-        case 0x00040002: /* Blank screen */
+        case RPI_FWREQ_FRAMEBUFFER_BLANK:
             resplen = 4;
             break;
-        case 0x00044003: /* Test physical display width/height */
-        case 0x00044004: /* Test virtual display width/height */
+        case RPI_FWREQ_FRAMEBUFFER_TEST_PHYSICAL_WIDTH_HEIGHT:
+        case RPI_FWREQ_FRAMEBUFFER_TEST_VIRTUAL_WIDTH_HEIGHT:
             resplen = 8;
             break;
-        case 0x00048003: /* Set physical display width/height */
+        case RPI_FWREQ_FRAMEBUFFER_SET_PHYSICAL_WIDTH_HEIGHT:
             fbconfig.xres = ldl_le_phys(&s->dma_as, value + 12);
             fbconfig.yres = ldl_le_phys(&s->dma_as, value + 16);
             bcm2835_fb_validate_config(&fbconfig);
             fbconfig_updated = true;
             /* fall through */
-        case 0x00040003: /* Get physical display width/height */
+        case RPI_FWREQ_FRAMEBUFFER_GET_PHYSICAL_WIDTH_HEIGHT:
             stl_le_phys(&s->dma_as, value + 12, fbconfig.xres);
             stl_le_phys(&s->dma_as, value + 16, fbconfig.yres);
             resplen = 8;
             break;
-        case 0x00048004: /* Set virtual display width/height */
+        case RPI_FWREQ_FRAMEBUFFER_SET_VIRTUAL_WIDTH_HEIGHT:
             fbconfig.xres_virtual = ldl_le_phys(&s->dma_as, value + 12);
             fbconfig.yres_virtual = ldl_le_phys(&s->dma_as, value + 16);
             bcm2835_fb_validate_config(&fbconfig);
             fbconfig_updated = true;
             /* fall through */
-        case 0x00040004: /* Get virtual display width/height */
+        case RPI_FWREQ_FRAMEBUFFER_GET_VIRTUAL_WIDTH_HEIGHT:
             stl_le_phys(&s->dma_as, value + 12, fbconfig.xres_virtual);
             stl_le_phys(&s->dma_as, value + 16, fbconfig.yres_virtual);
             resplen = 8;
             break;
-        case 0x00044005: /* Test depth */
+        case RPI_FWREQ_FRAMEBUFFER_TEST_DEPTH:
             resplen = 4;
             break;
-        case 0x00048005: /* Set depth */
+        case RPI_FWREQ_FRAMEBUFFER_SET_DEPTH:
             fbconfig.bpp = ldl_le_phys(&s->dma_as, value + 12);
             bcm2835_fb_validate_config(&fbconfig);
             fbconfig_updated = true;
             /* fall through */
-        case 0x00040005: /* Get depth */
+        case RPI_FWREQ_FRAMEBUFFER_GET_DEPTH:
             stl_le_phys(&s->dma_as, value + 12, fbconfig.bpp);
             resplen = 4;
             break;
-        case 0x00044006: /* Test pixel order */
+        case RPI_FWREQ_FRAMEBUFFER_TEST_PIXEL_ORDER:
             resplen = 4;
             break;
-        case 0x00048006: /* Set pixel order */
+        case RPI_FWREQ_FRAMEBUFFER_SET_PIXEL_ORDER:
             fbconfig.pixo = ldl_le_phys(&s->dma_as, value + 12);
             bcm2835_fb_validate_config(&fbconfig);
             fbconfig_updated = true;
             /* fall through */
-        case 0x00040006: /* Get pixel order */
+        case RPI_FWREQ_FRAMEBUFFER_GET_PIXEL_ORDER:
             stl_le_phys(&s->dma_as, value + 12, fbconfig.pixo);
             resplen = 4;
             break;
-        case 0x00044007: /* Test pixel alpha */
+        case RPI_FWREQ_FRAMEBUFFER_TEST_ALPHA_MODE:
             resplen = 4;
             break;
-        case 0x00048007: /* Set alpha */
+        case RPI_FWREQ_FRAMEBUFFER_SET_ALPHA_MODE:
             fbconfig.alpha = ldl_le_phys(&s->dma_as, value + 12);
             bcm2835_fb_validate_config(&fbconfig);
             fbconfig_updated = true;
             /* fall through */
-        case 0x00040007: /* Get alpha */
+        case RPI_FWREQ_FRAMEBUFFER_GET_ALPHA_MODE:
             stl_le_phys(&s->dma_as, value + 12, fbconfig.alpha);
             resplen = 4;
             break;
-        case 0x00040008: /* Get pitch */
+        case RPI_FWREQ_FRAMEBUFFER_GET_PITCH:
             stl_le_phys(&s->dma_as, value + 12,
                         bcm2835_fb_get_pitch(&fbconfig));
             resplen = 4;
             break;
-        case 0x00044009: /* Test virtual offset */
+        case RPI_FWREQ_FRAMEBUFFER_TEST_VIRTUAL_OFFSET:
             resplen = 8;
             break;
-        case 0x00048009: /* Set virtual offset */
+        case RPI_FWREQ_FRAMEBUFFER_SET_VIRTUAL_OFFSET:
             fbconfig.xoffset = ldl_le_phys(&s->dma_as, value + 12);
             fbconfig.yoffset = ldl_le_phys(&s->dma_as, value + 16);
             bcm2835_fb_validate_config(&fbconfig);
             fbconfig_updated = true;
             /* fall through */
-        case 0x00040009: /* Get virtual offset */
+        case RPI_FWREQ_FRAMEBUFFER_GET_VIRTUAL_OFFSET:
             stl_le_phys(&s->dma_as, value + 12, fbconfig.xoffset);
             stl_le_phys(&s->dma_as, value + 16, fbconfig.yoffset);
             resplen = 8;
             break;
-        case 0x0004000a: /* Get/Test/Set overscan */
-        case 0x0004400a:
-        case 0x0004800a:
+        case RPI_FWREQ_FRAMEBUFFER_GET_OVERSCAN:
+        case RPI_FWREQ_FRAMEBUFFER_TEST_OVERSCAN:
+        case RPI_FWREQ_FRAMEBUFFER_SET_OVERSCAN:
             stl_le_phys(&s->dma_as, value + 12, 0);
             stl_le_phys(&s->dma_as, value + 16, 0);
             stl_le_phys(&s->dma_as, value + 20, 0);
             stl_le_phys(&s->dma_as, value + 24, 0);
             resplen = 16;
             break;
-        case 0x0004800b: /* Set palette */
+        case RPI_FWREQ_FRAMEBUFFER_SET_PALETTE:
             offset = ldl_le_phys(&s->dma_as, value + 12);
             length = ldl_le_phys(&s->dma_as, value + 16);
             n = 0;
@@ -270,18 +271,18 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
             stl_le_phys(&s->dma_as, value + 12, 0);
             resplen = 4;
             break;
-        case 0x00040013: /* Get number of displays */
+        case RPI_FWREQ_FRAMEBUFFER_GET_NUM_DISPLAYS:
             stl_le_phys(&s->dma_as, value + 12, 1);
             resplen = 4;
             break;
 
-        case 0x00060001: /* Get DMA channels */
+        case RPI_FWREQ_GET_DMA_CHANNELS:
             /* channels 2-5 */
             stl_le_phys(&s->dma_as, value + 12, 0x003C);
             resplen = 4;
             break;
 
-        case 0x00050001: /* Get command line */
+        case RPI_FWREQ_GET_COMMAND_LINE:
             /*
              * We follow the firmware behaviour: no NUL terminator is
              * written to the buffer, and if the buffer is too short
-- 
2.38.1


