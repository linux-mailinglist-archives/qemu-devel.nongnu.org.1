Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7F87C8042
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:31:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD4u-0003ge-TI; Fri, 13 Oct 2023 03:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD4n-0002nQ-B0
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:17 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD4j-00073S-DU
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:16 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-50435ad51bbso2324762e87.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183951; x=1697788751; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+rKbUk1oK2C+9eZvhinshKGq3PhrtpO9sOxhQoYvy9c=;
 b=zbnd/qGpbngIbRIljd3c7DMoczWLyYgUmnfFtBp0qz2ecmA/nntFCli6EjXKYC99hO
 d1emA7cCvMx4aKg27/9GNCmeKAiG86Lp8ayC5wkYwAoCcEctfpj9PO03W7BQBLQnsK9C
 Z3bRqxdlDWyUuEp2yzoHZuvg7KVBkGRAXtwhJa1bPdqwKcs46/flKjwFOe9M/yFhLiZW
 KOGS+LVPuBaRCMciKGdhYAVBJSz5QunG60/ypL41wSLX4W15toH/rh/YlizimcAdeID1
 H6qu2mbwMI2vudpaazgy/RTPzLHUuGTxl7jqeHE/mSbEsEnWbzsaWoyJ7wduGiST2xYL
 LZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183951; x=1697788751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+rKbUk1oK2C+9eZvhinshKGq3PhrtpO9sOxhQoYvy9c=;
 b=uL5+aL5jSd/5z1niO4Ca/NLAQOv7Qmek1T6vpcIG1SOLDybiWEZtpPfe8QKXda1iri
 TwKURKYwhin5kUx/wQG/+75EdE3YRq0EQmH0LHi5j/TrFmDDs3UZi0+kzngvXeNBYhKo
 OyNBFk6ydRobHmbcJY1i6xDIiADFOjbZC8wQzuOlwp2Z/jSmrLlztUk/OeXAADeP0+3v
 tWRxFF5gJyefqWDzXZmbYj8RAQ418/S2OFrrsJbnqOylt8jortq5Y8RZZqkTdGt3MQJm
 lXBmCu3UZl4CO2yBAkLqoSL4e19RN+B5WcVnebKLKndOeSzX2HjWYW8JZJDhYyxEPlkR
 YMew==
X-Gm-Message-State: AOJu0YxD39CzV8Ggbp1qzWCHAkTKpHJ3F/nRVpxteGnGRZDU6OZFfbnm
 SABIa7RqNMhi61txpfHCAOZZw9fa3kFBt92tcNM=
X-Google-Smtp-Source: AGHT+IGJ+9EZHl4sU1DT8ZI6gWlTd4ZaanzwPbIUx6rVQ19imWjjIL3yj1nukaRku9kVMMgpbSpPCA==
X-Received: by 2002:ac2:4a65:0:b0:4f8:7325:bcd4 with SMTP id
 q5-20020ac24a65000000b004f87325bcd4mr18833614lfp.0.1697183951075; 
 Fri, 13 Oct 2023 00:59:11 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.00.59.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:59:10 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-arm@nongnu.org (open list:ARM cores),
 qemu-ppc@nongnu.org (open list:New World (mac99))
Subject: [RFC PATCH v2 43/78] hw/misc: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:57:10 +0300
Message-Id: <f07ec9ad088ea2e6242b6a30d636722701edf5cf.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/misc/a9scu.c            |  2 ++
 hw/misc/aspeed_scu.c       |  2 +-
 hw/misc/bcm2835_property.c | 12 ++++++------
 hw/misc/mos6522.c          |  4 ++--
 4 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/hw/misc/a9scu.c b/hw/misc/a9scu.c
index a375ebc987..b422bec3c4 100644
--- a/hw/misc/a9scu.c
+++ b/hw/misc/a9scu.c
@@ -21,26 +21,27 @@
 static uint64_t a9_scu_read(void *opaque, hwaddr offset,
                             unsigned size)
 {
     A9SCUState *s = (A9SCUState *)opaque;
     switch (offset) {
     case 0x00: /* Control */
         return s->control;
     case 0x04: /* Configuration */
         return (((1 << s->num_cpu) - 1) << 4) | (s->num_cpu - 1);
     case 0x08: /* CPU Power Status */
         return s->status;
     case 0x0c: /* Invalidate All Registers In Secure State */
         return 0;
     case 0x40: /* Filtering Start Address Register */
     case 0x44: /* Filtering End Address Register */
         /* RAZ/WI, like an implementation with only one AXI master */
         return 0;
     case 0x50: /* SCU Access Control Register */
     case 0x54: /* SCU Non-secure Access Control Register */
         /* unimplemented, fall through */
+        fallthrough;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: Unsupported offset 0x%"HWADDR_PRIx"\n",
                       __func__, offset);
         return 0;
     }
 }
@@ -48,31 +49,32 @@ static uint64_t a9_scu_read(void *opaque, hwaddr offset,
 static void a9_scu_write(void *opaque, hwaddr offset,
                          uint64_t value, unsigned size)
 {
     A9SCUState *s = (A9SCUState *)opaque;
 
     switch (offset) {
     case 0x00: /* Control */
         s->control = value & 1;
         break;
     case 0x4: /* Configuration: RO */
         break;
     case 0x08: case 0x09: case 0x0A: case 0x0B: /* Power Control */
         s->status = value;
         break;
     case 0x0c: /* Invalidate All Registers In Secure State */
         /* no-op as we do not implement caches */
         break;
     case 0x40: /* Filtering Start Address Register */
     case 0x44: /* Filtering End Address Register */
         /* RAZ/WI, like an implementation with only one AXI master */
         break;
     case 0x50: /* SCU Access Control Register */
     case 0x54: /* SCU Non-secure Access Control Register */
         /* unimplemented, fall through */
+        fallthrough;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: Unsupported offset 0x%"HWADDR_PRIx
                                  " value 0x%"PRIx64"\n",
                       __func__, offset, value);
         break;
     }
 }
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index 8335364906..4a1ea2fa21 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -645,65 +645,65 @@ static uint64_t aspeed_ast2600_scu_read(void *opaque, hwaddr offset,
 static void aspeed_ast2600_scu_write(void *opaque, hwaddr offset,
                                      uint64_t data64, unsigned size)
 {
     AspeedSCUState *s = ASPEED_SCU(opaque);
     int reg = TO_REG(offset);
     /* Truncate here so bitwise operations below behave as expected */
     uint32_t data = data64;
 
     if (reg >= ASPEED_AST2600_SCU_NR_REGS) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Out-of-bounds write at offset 0x%" HWADDR_PRIx "\n",
                       __func__, offset);
         return;
     }
 
     if (reg > PROT_KEY && !s->regs[PROT_KEY]) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: SCU is locked!\n", __func__);
     }
 
     trace_aspeed_scu_write(offset, size, data);
 
     switch (reg) {
     case AST2600_PROT_KEY:
         s->regs[reg] = (data == ASPEED_SCU_PROT_KEY) ? 1 : 0;
         return;
     case AST2600_HW_STRAP1:
     case AST2600_HW_STRAP2:
         if (s->regs[reg + 2]) {
             return;
         }
-        /* fall through */
+        fallthrough;
     case AST2600_SYS_RST_CTRL:
     case AST2600_SYS_RST_CTRL2:
     case AST2600_CLK_STOP_CTRL:
     case AST2600_CLK_STOP_CTRL2:
         /* W1S (Write 1 to set) registers */
         s->regs[reg] |= data;
         return;
     case AST2600_SYS_RST_CTRL_CLR:
     case AST2600_SYS_RST_CTRL2_CLR:
     case AST2600_CLK_STOP_CTRL_CLR:
     case AST2600_CLK_STOP_CTRL2_CLR:
     case AST2600_HW_STRAP1_CLR:
     case AST2600_HW_STRAP2_CLR:
         /*
          * W1C (Write 1 to clear) registers are offset by one address from
          * the data register
          */
         s->regs[reg - 1] &= ~data;
         return;
 
     case AST2600_RNG_DATA:
     case AST2600_SILICON_REV:
     case AST2600_SILICON_REV2:
     case AST2600_CHIP_ID0:
     case AST2600_CHIP_ID1:
         /* Add read only registers here */
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Write to read-only offset 0x%" HWADDR_PRIx "\n",
                       __func__, offset);
         return;
     }
 
     s->regs[reg] = data;
 }
diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
index 4ed9faa54a..98170f34a6 100644
--- a/hw/misc/bcm2835_property.c
+++ b/hw/misc/bcm2835_property.c
@@ -24,303 +24,303 @@
 static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
 {
     uint32_t tag;
     uint32_t bufsize;
     uint32_t tot_len;
     size_t resplen;
     uint32_t tmp;
     int n;
     uint32_t offset, length, color;
 
     /*
      * Copy the current state of the framebuffer config; we will update
      * this copy as we process tags and then ask the framebuffer to use
      * it at the end.
      */
     BCM2835FBConfig fbconfig = s->fbdev->config;
     bool fbconfig_updated = false;
 
     value &= ~0xf;
 
     s->addr = value;
 
     tot_len = ldl_le_phys(&s->dma_as, value);
 
     /* @(addr + 4) : Buffer response code */
     value = s->addr + 8;
     while (value + 8 <= s->addr + tot_len) {
         tag = ldl_le_phys(&s->dma_as, value);
         bufsize = ldl_le_phys(&s->dma_as, value + 4);
         /* @(value + 8) : Request/response indicator */
         resplen = 0;
         switch (tag) {
         case RPI_FWREQ_PROPERTY_END:
             break;
         case RPI_FWREQ_GET_FIRMWARE_REVISION:
             stl_le_phys(&s->dma_as, value + 12, 346337);
             resplen = 4;
             break;
         case RPI_FWREQ_GET_BOARD_MODEL:
             qemu_log_mask(LOG_UNIMP,
                           "bcm2835_property: 0x%08x get board model NYI\n",
                           tag);
             resplen = 4;
             break;
         case RPI_FWREQ_GET_BOARD_REVISION:
             stl_le_phys(&s->dma_as, value + 12, s->board_rev);
             resplen = 4;
             break;
         case RPI_FWREQ_GET_BOARD_MAC_ADDRESS:
             resplen = sizeof(s->macaddr.a);
             dma_memory_write(&s->dma_as, value + 12, s->macaddr.a, resplen,
                              MEMTXATTRS_UNSPECIFIED);
             break;
         case RPI_FWREQ_GET_BOARD_SERIAL:
             qemu_log_mask(LOG_UNIMP,
                           "bcm2835_property: 0x%08x get board serial NYI\n",
                           tag);
             resplen = 8;
             break;
         case RPI_FWREQ_GET_ARM_MEMORY:
             /* base */
             stl_le_phys(&s->dma_as, value + 12, 0);
             /* size */
             stl_le_phys(&s->dma_as, value + 16, s->fbdev->vcram_base);
             resplen = 8;
             break;
         case RPI_FWREQ_GET_VC_MEMORY:
             /* base */
             stl_le_phys(&s->dma_as, value + 12, s->fbdev->vcram_base);
             /* size */
             stl_le_phys(&s->dma_as, value + 16, s->fbdev->vcram_size);
             resplen = 8;
             break;
         case RPI_FWREQ_SET_POWER_STATE:
             /* Assume that whatever device they asked for exists,
              * and we'll just claim we set it to the desired state
              */
             tmp = ldl_le_phys(&s->dma_as, value + 16);
             stl_le_phys(&s->dma_as, value + 16, (tmp & 1));
             resplen = 8;
             break;
 
         /* Clocks */
 
         case RPI_FWREQ_GET_CLOCK_STATE:
             stl_le_phys(&s->dma_as, value + 16, 0x1);
             resplen = 8;
             break;
 
         case RPI_FWREQ_SET_CLOCK_STATE:
             qemu_log_mask(LOG_UNIMP,
                           "bcm2835_property: 0x%08x set clock state NYI\n",
                           tag);
             resplen = 8;
             break;
 
         case RPI_FWREQ_GET_CLOCK_RATE:
         case RPI_FWREQ_GET_MAX_CLOCK_RATE:
         case RPI_FWREQ_GET_MIN_CLOCK_RATE:
             switch (ldl_le_phys(&s->dma_as, value + 12)) {
             case RPI_FIRMWARE_EMMC_CLK_ID:
                 stl_le_phys(&s->dma_as, value + 16, RPI_FIRMWARE_EMMC_CLK_RATE);
                 break;
             case RPI_FIRMWARE_UART_CLK_ID:
                 stl_le_phys(&s->dma_as, value + 16, RPI_FIRMWARE_UART_CLK_RATE);
                 break;
             case RPI_FIRMWARE_CORE_CLK_ID:
                 stl_le_phys(&s->dma_as, value + 16, RPI_FIRMWARE_CORE_CLK_RATE);
                 break;
             default:
                 stl_le_phys(&s->dma_as, value + 16,
                             RPI_FIRMWARE_DEFAULT_CLK_RATE);
                 break;
             }
             resplen = 8;
             break;
 
         case RPI_FWREQ_SET_CLOCK_RATE:
         case RPI_FWREQ_SET_MAX_CLOCK_RATE:
         case RPI_FWREQ_SET_MIN_CLOCK_RATE:
             qemu_log_mask(LOG_UNIMP,
                           "bcm2835_property: 0x%08x set clock rate NYI\n",
                           tag);
             resplen = 8;
             break;
 
         /* Temperature */
 
         case RPI_FWREQ_GET_TEMPERATURE:
             stl_le_phys(&s->dma_as, value + 16, 25000);
             resplen = 8;
             break;
 
         case RPI_FWREQ_GET_MAX_TEMPERATURE:
             stl_le_phys(&s->dma_as, value + 16, 99000);
             resplen = 8;
             break;
 
         /* Frame buffer */
 
         case RPI_FWREQ_FRAMEBUFFER_ALLOCATE:
             stl_le_phys(&s->dma_as, value + 12, fbconfig.base);
             stl_le_phys(&s->dma_as, value + 16,
                         bcm2835_fb_get_size(&fbconfig));
             resplen = 8;
             break;
         case RPI_FWREQ_FRAMEBUFFER_RELEASE:
             resplen = 0;
             break;
         case RPI_FWREQ_FRAMEBUFFER_BLANK:
             resplen = 4;
             break;
         case RPI_FWREQ_FRAMEBUFFER_TEST_PHYSICAL_WIDTH_HEIGHT:
         case RPI_FWREQ_FRAMEBUFFER_TEST_VIRTUAL_WIDTH_HEIGHT:
             resplen = 8;
             break;
         case RPI_FWREQ_FRAMEBUFFER_SET_PHYSICAL_WIDTH_HEIGHT:
             fbconfig.xres = ldl_le_phys(&s->dma_as, value + 12);
             fbconfig.yres = ldl_le_phys(&s->dma_as, value + 16);
             bcm2835_fb_validate_config(&fbconfig);
             fbconfig_updated = true;
-            /* fall through */
+            fallthrough;
         case RPI_FWREQ_FRAMEBUFFER_GET_PHYSICAL_WIDTH_HEIGHT:
             stl_le_phys(&s->dma_as, value + 12, fbconfig.xres);
             stl_le_phys(&s->dma_as, value + 16, fbconfig.yres);
             resplen = 8;
             break;
         case RPI_FWREQ_FRAMEBUFFER_SET_VIRTUAL_WIDTH_HEIGHT:
             fbconfig.xres_virtual = ldl_le_phys(&s->dma_as, value + 12);
             fbconfig.yres_virtual = ldl_le_phys(&s->dma_as, value + 16);
             bcm2835_fb_validate_config(&fbconfig);
             fbconfig_updated = true;
-            /* fall through */
+            fallthrough;
         case RPI_FWREQ_FRAMEBUFFER_GET_VIRTUAL_WIDTH_HEIGHT:
             stl_le_phys(&s->dma_as, value + 12, fbconfig.xres_virtual);
             stl_le_phys(&s->dma_as, value + 16, fbconfig.yres_virtual);
             resplen = 8;
             break;
         case RPI_FWREQ_FRAMEBUFFER_TEST_DEPTH:
             resplen = 4;
             break;
         case RPI_FWREQ_FRAMEBUFFER_SET_DEPTH:
             fbconfig.bpp = ldl_le_phys(&s->dma_as, value + 12);
             bcm2835_fb_validate_config(&fbconfig);
             fbconfig_updated = true;
-            /* fall through */
+            fallthrough;
         case RPI_FWREQ_FRAMEBUFFER_GET_DEPTH:
             stl_le_phys(&s->dma_as, value + 12, fbconfig.bpp);
             resplen = 4;
             break;
         case RPI_FWREQ_FRAMEBUFFER_TEST_PIXEL_ORDER:
             resplen = 4;
             break;
         case RPI_FWREQ_FRAMEBUFFER_SET_PIXEL_ORDER:
             fbconfig.pixo = ldl_le_phys(&s->dma_as, value + 12);
             bcm2835_fb_validate_config(&fbconfig);
             fbconfig_updated = true;
-            /* fall through */
+            fallthrough;
         case RPI_FWREQ_FRAMEBUFFER_GET_PIXEL_ORDER:
             stl_le_phys(&s->dma_as, value + 12, fbconfig.pixo);
             resplen = 4;
             break;
         case RPI_FWREQ_FRAMEBUFFER_TEST_ALPHA_MODE:
             resplen = 4;
             break;
         case RPI_FWREQ_FRAMEBUFFER_SET_ALPHA_MODE:
             fbconfig.alpha = ldl_le_phys(&s->dma_as, value + 12);
             bcm2835_fb_validate_config(&fbconfig);
             fbconfig_updated = true;
-            /* fall through */
+            fallthrough;
         case RPI_FWREQ_FRAMEBUFFER_GET_ALPHA_MODE:
             stl_le_phys(&s->dma_as, value + 12, fbconfig.alpha);
             resplen = 4;
             break;
         case RPI_FWREQ_FRAMEBUFFER_GET_PITCH:
             stl_le_phys(&s->dma_as, value + 12,
                         bcm2835_fb_get_pitch(&fbconfig));
             resplen = 4;
             break;
         case RPI_FWREQ_FRAMEBUFFER_TEST_VIRTUAL_OFFSET:
             resplen = 8;
             break;
         case RPI_FWREQ_FRAMEBUFFER_SET_VIRTUAL_OFFSET:
             fbconfig.xoffset = ldl_le_phys(&s->dma_as, value + 12);
             fbconfig.yoffset = ldl_le_phys(&s->dma_as, value + 16);
             bcm2835_fb_validate_config(&fbconfig);
             fbconfig_updated = true;
-            /* fall through */
+            fallthrough;
         case RPI_FWREQ_FRAMEBUFFER_GET_VIRTUAL_OFFSET:
             stl_le_phys(&s->dma_as, value + 12, fbconfig.xoffset);
             stl_le_phys(&s->dma_as, value + 16, fbconfig.yoffset);
             resplen = 8;
             break;
         case RPI_FWREQ_FRAMEBUFFER_GET_OVERSCAN:
         case RPI_FWREQ_FRAMEBUFFER_TEST_OVERSCAN:
         case RPI_FWREQ_FRAMEBUFFER_SET_OVERSCAN:
             stl_le_phys(&s->dma_as, value + 12, 0);
             stl_le_phys(&s->dma_as, value + 16, 0);
             stl_le_phys(&s->dma_as, value + 20, 0);
             stl_le_phys(&s->dma_as, value + 24, 0);
             resplen = 16;
             break;
         case RPI_FWREQ_FRAMEBUFFER_SET_PALETTE:
             offset = ldl_le_phys(&s->dma_as, value + 12);
             length = ldl_le_phys(&s->dma_as, value + 16);
             n = 0;
             while (n < length - offset) {
                 color = ldl_le_phys(&s->dma_as, value + 20 + (n << 2));
                 stl_le_phys(&s->dma_as,
                             s->fbdev->vcram_base + ((offset + n) << 2), color);
                 n++;
             }
             stl_le_phys(&s->dma_as, value + 12, 0);
             resplen = 4;
             break;
         case RPI_FWREQ_FRAMEBUFFER_GET_NUM_DISPLAYS:
             stl_le_phys(&s->dma_as, value + 12, 1);
             resplen = 4;
             break;
 
         case RPI_FWREQ_GET_DMA_CHANNELS:
             /* channels 2-5 */
             stl_le_phys(&s->dma_as, value + 12, 0x003C);
             resplen = 4;
             break;
 
         case RPI_FWREQ_GET_COMMAND_LINE:
             /*
              * We follow the firmware behaviour: no NUL terminator is
              * written to the buffer, and if the buffer is too short
              * we report the required length in the response header
              * and copy nothing to the buffer.
              */
             resplen = strlen(s->command_line);
             if (bufsize >= resplen)
                 address_space_write(&s->dma_as, value + 12,
                                     MEMTXATTRS_UNSPECIFIED, s->command_line,
                                     resplen);
             break;
 
         default:
             qemu_log_mask(LOG_UNIMP,
                           "bcm2835_property: unhandled tag 0x%08x\n", tag);
             break;
         }
 
         trace_bcm2835_mbox_property(tag, bufsize, resplen);
         if (tag == 0) {
             break;
         }
 
         stl_le_phys(&s->dma_as, value + 8, (1 << 31) | resplen);
         value += bufsize + 12;
     }
 
     /* Reconfigure framebuffer if required */
     if (fbconfig_updated) {
         bcm2835_fb_reconfigure(s->fbdev, &fbconfig);
     }
 
     /* Buffer response code */
     stl_le_phys(&s->dma_as, s->addr + 4, (1 << 31));
 }
diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
index d6ba47bde9..a62349e6a0 100644
--- a/hw/misc/mos6522.c
+++ b/hw/misc/mos6522.c
@@ -296,97 +296,97 @@ static void mos6522_portB_write(MOS6522State *s)
 uint64_t mos6522_read(void *opaque, hwaddr addr, unsigned size)
 {
     MOS6522State *s = opaque;
     uint32_t val;
     int ctrl;
     int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
 
     if (now >= s->timers[0].next_irq_time) {
         mos6522_timer1_update(s, &s->timers[0], now);
         s->ifr |= T1_INT;
     }
     if (now >= s->timers[1].next_irq_time) {
         mos6522_timer2_update(s, &s->timers[1], now);
         s->ifr |= T2_INT;
     }
     switch (addr) {
     case VIA_REG_B:
         val = s->b;
         ctrl = (s->pcr & CB2_CTRL_MASK) >> CB2_CTRL_SHIFT;
         if (!(ctrl & C2_IND)) {
             s->ifr &= ~CB2_INT;
         }
         s->ifr &= ~CB1_INT;
         mos6522_update_irq(s);
         break;
     case VIA_REG_A:
        qemu_log_mask(LOG_UNIMP, "Read access to register A with handshake");
-       /* fall through */
+       fallthrough;
     case VIA_REG_ANH:
         val = s->a;
         ctrl = (s->pcr & CA2_CTRL_MASK) >> CA2_CTRL_SHIFT;
         if (!(ctrl & C2_IND)) {
             s->ifr &= ~CA2_INT;
         }
         s->ifr &= ~CA1_INT;
         mos6522_update_irq(s);
         break;
     case VIA_REG_DIRB:
         val = s->dirb;
         break;
     case VIA_REG_DIRA:
         val = s->dira;
         break;
     case VIA_REG_T1CL:
         val = get_counter(s, &s->timers[0]) & 0xff;
         s->ifr &= ~T1_INT;
         mos6522_update_irq(s);
         break;
     case VIA_REG_T1CH:
         val = get_counter(s, &s->timers[0]) >> 8;
         mos6522_update_irq(s);
         break;
     case VIA_REG_T1LL:
         val = s->timers[0].latch & 0xff;
         break;
     case VIA_REG_T1LH:
         /* XXX: check this */
         val = (s->timers[0].latch >> 8) & 0xff;
         break;
     case VIA_REG_T2CL:
         val = get_counter(s, &s->timers[1]) & 0xff;
         s->ifr &= ~T2_INT;
         mos6522_update_irq(s);
         break;
     case VIA_REG_T2CH:
         val = get_counter(s, &s->timers[1]) >> 8;
         break;
     case VIA_REG_SR:
         val = s->sr;
         s->ifr &= ~SR_INT;
         mos6522_update_irq(s);
         break;
     case VIA_REG_ACR:
         val = s->acr;
         break;
     case VIA_REG_PCR:
         val = s->pcr;
         break;
     case VIA_REG_IFR:
         val = s->ifr;
         if (s->ifr & s->ier) {
             val |= 0x80;
         }
         break;
     case VIA_REG_IER:
         val = s->ier | 0x80;
         break;
     default:
         g_assert_not_reached();
     }
 
     if (addr != VIA_REG_IFR || val != 0) {
         trace_mos6522_read(addr, mos6522_reg_names[addr], val);
     }
 
     return val;
 }
@@ -394,105 +394,105 @@ uint64_t mos6522_read(void *opaque, hwaddr addr, unsigned size)
 void mos6522_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
 {
     MOS6522State *s = opaque;
     MOS6522DeviceClass *mdc = MOS6522_GET_CLASS(s);
     int ctrl;
 
     trace_mos6522_write(addr, mos6522_reg_names[addr], val);
 
     switch (addr) {
     case VIA_REG_B:
         s->b = (s->b & ~s->dirb) | (val & s->dirb);
         mdc->portB_write(s);
         ctrl = (s->pcr & CB2_CTRL_MASK) >> CB2_CTRL_SHIFT;
         if (!(ctrl & C2_IND)) {
             s->ifr &= ~CB2_INT;
         }
         s->ifr &= ~CB1_INT;
         mos6522_update_irq(s);
         break;
     case VIA_REG_A:
        qemu_log_mask(LOG_UNIMP, "Write access to register A with handshake");
-       /* fall through */
+       fallthrough;
     case VIA_REG_ANH:
         s->a = (s->a & ~s->dira) | (val & s->dira);
         mdc->portA_write(s);
         ctrl = (s->pcr & CA2_CTRL_MASK) >> CA2_CTRL_SHIFT;
         if (!(ctrl & C2_IND)) {
             s->ifr &= ~CA2_INT;
         }
         s->ifr &= ~CA1_INT;
         mos6522_update_irq(s);
         break;
     case VIA_REG_DIRB:
         s->dirb = val;
         break;
     case VIA_REG_DIRA:
         s->dira = val;
         break;
     case VIA_REG_T1CL:
         s->timers[0].latch = (s->timers[0].latch & 0xff00) | val;
         mos6522_timer1_update(s, &s->timers[0],
                               qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
         break;
     case VIA_REG_T1CH:
         s->timers[0].latch = (s->timers[0].latch & 0xff) | (val << 8);
         s->ifr &= ~T1_INT;
         set_counter(s, &s->timers[0], s->timers[0].latch);
         break;
     case VIA_REG_T1LL:
         s->timers[0].latch = (s->timers[0].latch & 0xff00) | val;
         mos6522_timer1_update(s, &s->timers[0],
                               qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
         break;
     case VIA_REG_T1LH:
         s->timers[0].latch = (s->timers[0].latch & 0xff) | (val << 8);
         s->ifr &= ~T1_INT;
         mos6522_timer1_update(s, &s->timers[0],
                               qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
         break;
     case VIA_REG_T2CL:
         s->timers[1].latch = (s->timers[1].latch & 0xff00) | val;
         break;
     case VIA_REG_T2CH:
         /* To ensure T2 generates an interrupt on zero crossing with the
            common timer code, write the value directly from the latch to
            the counter */
         s->timers[1].latch = (s->timers[1].latch & 0xff) | (val << 8);
         s->ifr &= ~T2_INT;
         set_counter(s, &s->timers[1], s->timers[1].latch);
         break;
     case VIA_REG_SR:
         s->sr = val;
         break;
     case VIA_REG_ACR:
         s->acr = val;
         mos6522_timer1_update(s, &s->timers[0],
                               qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
         break;
     case VIA_REG_PCR:
         s->pcr = val;
         break;
     case VIA_REG_IFR:
         /* reset bits */
         s->ifr &= ~val;
         mos6522_update_irq(s);
         break;
     case VIA_REG_IER:
         if (val & IER_SET) {
             /* set bits */
             s->ier |= val & 0x7f;
         } else {
             /* reset bits */
             s->ier &= ~val;
         }
         mos6522_update_irq(s);
         /* if IER is modified starts needed timers */
         mos6522_timer1_update(s, &s->timers[0],
                               qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
         mos6522_timer2_update(s, &s->timers[1],
                               qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
         break;
     default:
         g_assert_not_reached();
     }
 }
-- 
2.39.2


