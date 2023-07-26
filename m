Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FE4763830
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 15:58:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOeX1-0003CN-LZ; Wed, 26 Jul 2023 09:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1qOeWt-00037B-IT; Wed, 26 Jul 2023 09:26:15 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1qOeWr-0003Yi-CM; Wed, 26 Jul 2023 09:26:15 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-4fb7373dd35so1271996e87.1; 
 Wed, 26 Jul 2023 06:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690377971; x=1690982771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qZ8mQb2fwd3M0PxPOmfQ9zLHyNEYGhredwUsDYKTh9Q=;
 b=DeiG0qtXzx1cnHACWBWSLkFbRrmqGcNF6UKBFkM4o74ylBatMNSLFne0NgVAsnQZMI
 SZbn/9YN53dKHb9BKtnTDKRyHGh5P5hjGZzFx2Ic3hyPLq9hfHeQymnPQYGUcDJnM69z
 iasrUTKsq6YvEWnjCQncXOfxtCOkqVd1pBsYyZGIcovXd35nflMrJloDtj5LaWLpy4kQ
 zlmWpVWOvC8NN4Tx6gXQOtXNNB5I8eEOeXkf4n4xA5FhaQbCGFMRMU9d9mDei5Jm+ejj
 c/o6ryfcDhGG+WlMPNs8STultpYkY83DGIxEQyZT+jSGp00YS0cdzMlDHGIsgvZkmyUP
 IjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690377971; x=1690982771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qZ8mQb2fwd3M0PxPOmfQ9zLHyNEYGhredwUsDYKTh9Q=;
 b=UBX31SnllhXZZlcbWOT3c4WB2oZG1cyIRzUfd1BM9sTZxAzGrNJBJmXUFex7cI4Py4
 tbF8zXmMVcolOk+Ln/ehL0IKMYbL+s6hEkJ+J71FGVksS/VMw8ARFXvFsYzcp8RjLCdS
 Eft57IRP3VFLYCvQT543ZnSSf1IRjf3kznlS/7AyY53cRRmdoHkEkgKhqt2B9u2XFol9
 tnsS4dvLzoTm3b2j1Gsvk/BuO0Okdyzz6X1l+ceZ9cjZu7O2tGUXvCXx473r7I6xzg0j
 7B0Tkj7rFY8KKu0Mcycmh8tX4kCvRjTJMlIQ93HsjcZruUWzpU7Ltyc+oiD/HEDBpQqj
 5TQQ==
X-Gm-Message-State: ABy/qLYGWeH4V5m3t183AAKSi5c4vQlfa8qh1oa216KRZti90JreC3Y3
 +3pJZuVQJ8JEv0fdUXw2r/rz5Wxa60M=
X-Google-Smtp-Source: APBJJlFSGK11HFtjzSu0n3UinacfXC7itsSty4gXeGwfr4sF/tmbnhg8QItHtHECWhvHBbMM6t5PZg==
X-Received: by 2002:a05:6512:224a:b0:4fe:6ff:dfba with SMTP id
 i10-20020a056512224a00b004fe06ffdfbamr1626141lfu.1.1690377970884; 
 Wed, 26 Jul 2023 06:26:10 -0700 (PDT)
Received: from sergevik-thinkpad.localdomain ([213.197.136.186])
 by smtp.gmail.com with ESMTPSA id
 j22-20020a19f516000000b004fe0c3d8bb4sm565079lfb.84.2023.07.26.06.26.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 06:26:10 -0700 (PDT)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH 43/44] Add missed BCM2835 properties
Date: Wed, 26 Jul 2023 16:25:11 +0300
Message-Id: <20230726132512.149618-44-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726132512.149618-1-sergey.kambalin@auriga.com>
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=serg.oker@gmail.com; helo=mail-lf1-x133.google.com
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
 hw/misc/bcm2835_property.c            | 170 ++++++++++++++++++++++++++
 include/hw/misc/raspberrypi-fw-defs.h |  11 ++
 2 files changed, 181 insertions(+)

diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
index 4ed9faa54a..7d2d6e518d 100644
--- a/hw/misc/bcm2835_property.c
+++ b/hw/misc/bcm2835_property.c
@@ -19,6 +19,31 @@
 #include "trace.h"
 #include "hw/arm/raspi_platform.h"
 
+#define RPI_EXP_GPIO_BASE       128
+#define VC4_GPIO_EXPANDER_COUNT 8
+#define VCHI_BUSADDR_SIZE       sizeof(uint32_t)
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
+struct vc4_gpio_expander_t {
+    uint32_t direction;
+    uint32_t polarity;
+    uint32_t term_en;
+    uint32_t term_pull_up;
+    uint32_t state;
+} vc4_gpio_expander[VC4_GPIO_EXPANDER_COUNT];
+
 /* https://github.com/raspberrypi/firmware/wiki/Mailbox-property-interface */
 
 static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
@@ -30,6 +55,7 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
     uint32_t tmp;
     int n;
     uint32_t offset, length, color;
+    uint32_t gpio_num;
 
     /*
      * Copy the current state of the framebuffer config; we will update
@@ -138,6 +164,13 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
             resplen = 8;
             break;
 
+        case RPI_FWREQ_GET_CLOCKS:
+            /* TODO: add more clock IDs if needed */
+            stl_le_phys(&s->dma_as, value + 12, 0);
+            stl_le_phys(&s->dma_as, value + 16, RPI_FIRMWARE_ARM_CLK_ID);
+            resplen = 8;
+            break;
+
         case RPI_FWREQ_SET_CLOCK_RATE:
         case RPI_FWREQ_SET_MAX_CLOCK_RATE:
         case RPI_FWREQ_SET_MIN_CLOCK_RATE:
@@ -276,6 +309,7 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
             stl_le_phys(&s->dma_as, value + 12, 0);
             resplen = 4;
             break;
+
         case RPI_FWREQ_FRAMEBUFFER_GET_NUM_DISPLAYS:
             stl_le_phys(&s->dma_as, value + 12, 1);
             resplen = 4;
@@ -301,6 +335,142 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
                                     resplen);
             break;
 
+        case RPI_FWREQ_GET_THROTTLED:
+            stl_le_phys(&s->dma_as, value + 12, 0);
+            resplen = 4;
+            break;
+
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
+        case RPI_FWREQ_FRAMEBUFFER_SET_PITCH:
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
         default:
             qemu_log_mask(LOG_UNIMP,
                           "bcm2835_property: unhandled tag 0x%08x\n", tag);
diff --git a/include/hw/misc/raspberrypi-fw-defs.h b/include/hw/misc/raspberrypi-fw-defs.h
index 4551fe7450..d461b30749 100644
--- a/include/hw/misc/raspberrypi-fw-defs.h
+++ b/include/hw/misc/raspberrypi-fw-defs.h
@@ -160,4 +160,15 @@ enum rpi_firmware_clk_id {
     RPI_FIRMWARE_NUM_CLK_ID,
 };
 
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
 #endif /* INCLUDE_HW_MISC_RASPBERRYPI_FW_DEFS_H_ */
-- 
2.34.1


