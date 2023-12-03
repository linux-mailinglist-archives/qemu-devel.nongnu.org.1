Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6D680293E
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 00:50:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9w88-000175-3B; Sun, 03 Dec 2023 18:44:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9w7J-0007YZ-V7; Sun, 03 Dec 2023 18:43:22 -0500
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9w7E-0002u3-PV; Sun, 03 Dec 2023 18:43:17 -0500
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5d33574f64eso41617707b3.3; 
 Sun, 03 Dec 2023 15:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701646990; x=1702251790; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1GNEkGSGTayvrkpE/A09q7fosCX6vgAb65BjfPwzFOc=;
 b=GhbD0Aw53+W/scaqWtfY/2pK5nd2ISM0o3Y2WI+smqyqApMgyk+VHEt1p8Z+3L/y87
 myaow3Tn6bumD4QQ9KuEltYOQNcR9//jvxCpfnhrsoCOoeH2jgqtMUD5XOFMtInPjFT2
 uoJHZCIRq4Yp9jObAE5/q29GDH2AY0GO40YfGuaE6QAqj/23FjUGLbeGXA+SxiKya5q1
 viDoJfMPQ/kgCAU3RGw7v+9AQ25kj25ej/4YUjsNpyoXksTojF26pnijJzo/cBEUCmQb
 RDagG0E82yMD1Qnr8TRpktjB/NZFimm9aBTnxLymC0V8wVIJfOAlwi5obzoJlDGY2uGK
 ooXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701646990; x=1702251790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1GNEkGSGTayvrkpE/A09q7fosCX6vgAb65BjfPwzFOc=;
 b=mNN3CzqrGEspIQ+c2fvd2XzVZgLcQW4QWSMC5qISVR0wStxDRkTa/EUAfFmMYd2hi2
 yQxfJrLMwppK4Rs6KAt6I16RkPjidOyyEwHgsOX4lnFEiRrKg+yHF947r09CUsH4nyPP
 DkhhzlbT4rUqviDXUNxnu3E/aG/sY409CqvgjlXm74uI4OIb250DS0nciUOCOTseJI/d
 bAo0oKT6LHMV/2BmaSF5tiKT7grNUbTcvWfur7YTAxPkY2tXONE+LTFncmv8xQqwlsKw
 qlXMqUam5qjavyw4FTMvcM91b2dE9Nva8G0SpqZfy4YpXo9NV+gErKzrepxFmNCeyouD
 z2Yw==
X-Gm-Message-State: AOJu0Yz3fqv097BqKNDEJcFVx8crAXo46kIgdc41cueCvOKZWqdl0Dzt
 f3Cpb48lv//FYgTOFOYrLrUuy+yYvMC7aQ==
X-Google-Smtp-Source: AGHT+IE4cPEwwqzflcmlf2bUmYOk7DUyeKKLyujANV7mt+t+F0R7am9zMoRfPx8kiicxNs+w8SCz4g==
X-Received: by 2002:a81:a507:0:b0:5cb:d645:8cdf with SMTP id
 u7-20020a81a507000000b005cbd6458cdfmr2839591ywg.48.1701646989837; 
 Sun, 03 Dec 2023 15:43:09 -0800 (PST)
Received: from localhost.localdomain ([201.206.180.22])
 by smtp.gmail.com with ESMTPSA id
 c126-20020a0dda84000000b005d718fff165sm1536299ywe.78.2023.12.03.15.43.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 15:43:09 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v3 43/45] Add missed BCM2835 properties
Date: Sun,  3 Dec 2023 17:42:11 -0600
Message-Id: <20231203234213.1366214-44-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726132512.149618-1-sergey.kambalin@auriga.com>
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=serg.oker@gmail.com; helo=mail-yw1-x1132.google.com
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
 hw/misc/bcm2835_property.c           | 47 ++++++++++++++++++++++++++++
 include/hw/arm/raspberrypi-fw-defs.h | 12 ++++++-
 2 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
index ff55a4e2cd..dfeb793b3e 100644
--- a/hw/misc/bcm2835_property.c
+++ b/hw/misc/bcm2835_property.c
@@ -19,6 +19,9 @@
 #include "trace.h"
 #include "hw/arm/raspi_platform.h"
 
+#define RPI_EXP_GPIO_BASE       128
+#define VCHI_BUSADDR_SIZE       sizeof(uint32_t)
+
 /* https://github.com/raspberrypi/firmware/wiki/Mailbox-property-interface */
 
 static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
@@ -138,6 +141,13 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
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
@@ -276,6 +286,7 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
             stl_le_phys(&s->dma_as, value + 12, 0);
             resplen = 4;
             break;
+
         case RPI_FWREQ_FRAMEBUFFER_GET_NUM_DISPLAYS:
             stl_le_phys(&s->dma_as, value + 12, 1);
             resplen = 4;
@@ -301,6 +312,42 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
                                     resplen);
             break;
 
+        case RPI_FWREQ_GET_THROTTLED:
+            stl_le_phys(&s->dma_as, value + 12, 0);
+            resplen = 4;
+            break;
+
+        case RPI_FWREQ_FRAMEBUFFER_SET_PITCH:
+            qemu_log_mask(LOG_UNIMP, "RPI_FWREQ_FRAMEBUFFER_SET_PITCH "
+                              "is not implemented\n");
+            break;
+
+        case RPI_FWREQ_GET_GPIO_CONFIG:
+            qemu_log_mask(LOG_UNIMP, "RPI_FWREQ_GET_GPIO_CONFIG "
+                          "is not implemented\n");
+            break;
+
+        case RPI_FWREQ_SET_GPIO_CONFIG:
+            qemu_log_mask(LOG_UNIMP, "RPI_FWREQ_SET_GPIO_CONFIG "
+                          "is not implemented\n");
+            break;
+
+        case RPI_FWREQ_GET_GPIO_STATE:
+            qemu_log_mask(LOG_UNIMP, "RPI_FWREQ_GET_GPIO_STATE "
+                          "is not implemented\n");
+            break;
+
+        case RPI_FWREQ_SET_GPIO_STATE:
+            qemu_log_mask(LOG_UNIMP, "RPI_FWREQ_SET_GPIO_STATE "
+                          "is not implemented\n");
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
diff --git a/include/hw/arm/raspberrypi-fw-defs.h b/include/hw/arm/raspberrypi-fw-defs.h
index 4551fe7450..ded7a22f02 100644
--- a/include/hw/arm/raspberrypi-fw-defs.h
+++ b/include/hw/arm/raspberrypi-fw-defs.h
@@ -101,7 +101,6 @@ enum rpi_firmware_property_tag {
     RPI_FWREQ_FRAMEBUFFER_GET_DISPLAY_ID =             0x00040016,
     RPI_FWREQ_FRAMEBUFFER_SET_DISPLAY_NUM =            0x00048013,
     RPI_FWREQ_FRAMEBUFFER_GET_NUM_DISPLAYS =           0x00040013,
-    RPI_FWREQ_FRAMEBUFFER_GET_DISPLAY_SETTINGS =       0x00040014,
     RPI_FWREQ_FRAMEBUFFER_TEST_PHYSICAL_WIDTH_HEIGHT = 0x00044003,
     RPI_FWREQ_FRAMEBUFFER_TEST_VIRTUAL_WIDTH_HEIGHT =  0x00044004,
     RPI_FWREQ_FRAMEBUFFER_TEST_DEPTH =                 0x00044005,
@@ -160,4 +159,15 @@ enum rpi_firmware_clk_id {
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


