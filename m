Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1028E80290E
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 00:43:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9w6m-000758-C2; Sun, 03 Dec 2023 18:42:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9w6a-0006qD-3Q; Sun, 03 Dec 2023 18:42:33 -0500
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9w6W-0002iv-9H; Sun, 03 Dec 2023 18:42:31 -0500
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5d8a772157fso1882367b3.3; 
 Sun, 03 Dec 2023 15:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701646946; x=1702251746; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GKpCBrUqkr8L/zjThyY7FG08zFIoOF+cembaEspqQBk=;
 b=KgvmM/txXPjmk7BH28CAi9YJG1Ge+k8DfJNhNcpa7mCL/31WpnP1fntjKNVcxRs5fK
 uUHZXWCVr6MEw1sEeVQQxazeyzszWMA6BShFS+xMdlpw8jv9VDkrcgbcycZ4jpu7jjr7
 Am0v3XUrDNHENG/NK01/SlwCK5ujmGQy3T1GQVWuq4iaKOIu8Fzy3FJHoW3bbbcHWjsk
 1NQBxAL+8XfZCJAnp2eS/7WP+ybH0THfah2aJtk+OlSUcEh+3755BnSNi6a9vjYn7r29
 PjHMR8Xaktf6c5ounCQqjz/3kGl1V/X3PlOnTaIkFEsTTwcJgupCYnbn5YtuBh2rpeAK
 9sJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701646946; x=1702251746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GKpCBrUqkr8L/zjThyY7FG08zFIoOF+cembaEspqQBk=;
 b=vPvf2C6LJD8TbdbCDC9+7qjOGnE7HFI3WQKEP9kRqEqExzfNPtiftvHoMkByd91siX
 azNMhlaHr8H5WVEdkJNcIsTqKUY+ArZefYRZ4u7k8bpg19BgssQIidoJ5+obno8JsBJw
 lpAMv+gIWy1p/qkbTHB8fI5gpTQqHFKxu90RiZRypi5cBLLiiN8o6Hy/E9wjKVw1px73
 ALIa4pNmQrx8BjJaLfITaO/OoNYg78kklGBsiXBlMrmhL1+9a9ENuScMpGa4NjIOK2Rp
 JZaK2UY/HRRq7YTV1yi6vFZZlaB1i8TP+pzqAr9r6aS0a0ow2X+5RJlE/r5kCke7waOc
 g/+Q==
X-Gm-Message-State: AOJu0Yx/uiuUKiqQ1Iveq7XA7r9vsv6DwCEWn6YBXmoji4oYa5Udpd3Q
 jtomUuu83goVYGSzhpZqd6HIcV8GwxFn2g==
X-Google-Smtp-Source: AGHT+IG5QRO1lM3njAZ4uUxX+JGgZXuYVWwikCL2MrrFiePqHhcvLd4Q4j6FZqqIcgNiDJKzF6lL3A==
X-Received: by 2002:a81:5344:0:b0:5ca:e4a6:bb47 with SMTP id
 h65-20020a815344000000b005cae4a6bb47mr2332087ywb.35.1701646946156; 
 Sun, 03 Dec 2023 15:42:26 -0800 (PST)
Received: from localhost.localdomain ([201.206.180.22])
 by smtp.gmail.com with ESMTPSA id
 c126-20020a0dda84000000b005d718fff165sm1536299ywe.78.2023.12.03.15.42.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 15:42:25 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v3 08/45] Connect SD controller to BCM2838 GPIO
Date: Sun,  3 Dec 2023 17:41:36 -0600
Message-Id: <20231203234213.1366214-9-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726132512.149618-1-sergey.kambalin@auriga.com>
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=serg.oker@gmail.com; helo=mail-yw1-x1133.google.com
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
 hw/gpio/bcm2838_gpio.c         | 59 +++++++++++++++++++++++++++++++---
 include/hw/gpio/bcm2838_gpio.h |  5 +++
 2 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/hw/gpio/bcm2838_gpio.c b/hw/gpio/bcm2838_gpio.c
index 51eb55b00a..f166ce7959 100644
--- a/hw/gpio/bcm2838_gpio.c
+++ b/hw/gpio/bcm2838_gpio.c
@@ -17,9 +17,10 @@
 #include "qemu/timer.h"
 #include "qapi/error.h"
 #include "hw/sysbus.h"
-#include "migration/vmstate.h"
+#include "hw/sd/sd.h"
 #include "hw/gpio/bcm2838_gpio.h"
 #include "hw/irq.h"
+#include "migration/vmstate.h"
 
 #define GPFSEL0   0x00
 #define GPFSEL1   0x04
@@ -64,6 +65,16 @@
 
 #define BYTES_IN_WORD        4
 
+/* bcm,function property */
+#define BCM2838_FSEL_GPIO_IN    0
+#define BCM2838_FSEL_GPIO_OUT   1
+#define BCM2838_FSEL_ALT5       2
+#define BCM2838_FSEL_ALT4       3
+#define BCM2838_FSEL_ALT0       4
+#define BCM2838_FSEL_ALT1       5
+#define BCM2838_FSEL_ALT2       6
+#define BCM2838_FSEL_ALT3       7
+
 static uint32_t gpfsel_get(BCM2838GpioState *s, uint8_t reg)
 {
     int i;
@@ -87,6 +98,31 @@ static void gpfsel_set(BCM2838GpioState *s, uint8_t reg, uint32_t value)
             s->fsel[index] = fsel;
         }
     }
+
+    /* SD controller selection (48-53) */
+    if (s->sd_fsel != BCM2838_FSEL_GPIO_IN
+        && (s->fsel[48] == BCM2838_FSEL_GPIO_IN)
+        && (s->fsel[49] == BCM2838_FSEL_GPIO_IN)
+        && (s->fsel[50] == BCM2838_FSEL_GPIO_IN)
+        && (s->fsel[51] == BCM2838_FSEL_GPIO_IN)
+        && (s->fsel[52] == BCM2838_FSEL_GPIO_IN)
+        && (s->fsel[53] == BCM2838_FSEL_GPIO_IN)
+       ) {
+        /* SDHCI controller selected */
+        sdbus_reparent_card(s->sdbus_sdhost, s->sdbus_sdhci);
+        s->sd_fsel = BCM2838_FSEL_GPIO_IN;
+    } else if (s->sd_fsel != BCM2838_FSEL_ALT0
+               && (s->fsel[48] == BCM2838_FSEL_ALT0) /* SD_CLK_R */
+               && (s->fsel[49] == BCM2838_FSEL_ALT0) /* SD_CMD_R */
+               && (s->fsel[50] == BCM2838_FSEL_ALT0) /* SD_DATA0_R */
+               && (s->fsel[51] == BCM2838_FSEL_ALT0) /* SD_DATA1_R */
+               && (s->fsel[52] == BCM2838_FSEL_ALT0) /* SD_DATA2_R */
+               && (s->fsel[53] == BCM2838_FSEL_ALT0) /* SD_DATA3_R */
+              ) {
+        /* SDHost controller selected */
+        sdbus_reparent_card(s->sdbus_sdhci, s->sdbus_sdhost);
+        s->sd_fsel = BCM2838_FSEL_ALT0;
+    }
 }
 
 static int gpfsel_is_out(BCM2838GpioState *s, int index)
@@ -266,6 +302,11 @@ static void bcm2838_gpio_reset(DeviceState *dev)
 
     memset(s->fsel, 0, sizeof(s->fsel));
 
+    s->sd_fsel = 0;
+
+    /* SDHCI is selected by default */
+    sdbus_reparent_card(&s->sdbus, s->sdbus_sdhci);
+
     s->lev0 = 0;
     s->lev1 = 0;
 
@@ -302,15 +343,25 @@ static void bcm2838_gpio_init(Object *obj)
     DeviceState *dev = DEVICE(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
 
-    memory_region_init_io(&s->iomem, obj, &bcm2838_gpio_ops, s,
-                          "bcm2838_gpio", BCM2838_GPIO_REGS_SIZE);
+    qbus_init(&s->sdbus, sizeof(s->sdbus), TYPE_SD_BUS, DEVICE(s), "sd-bus");
+
+    memory_region_init_io(
+        &s->iomem, obj,
+        &bcm2838_gpio_ops, s, "bcm2838_gpio", BCM2838_GPIO_REGS_SIZE);
     sysbus_init_mmio(sbd, &s->iomem);
     qdev_init_gpio_out(dev, s->out, BCM2838_GPIO_NUM);
 }
 
 static void bcm2838_gpio_realize(DeviceState *dev, Error **errp)
 {
-    /* Temporary stub. Do nothing */
+    BCM2838GpioState *s = BCM2838_GPIO(dev);
+    Object *obj;
+
+    obj = object_property_get_link(OBJECT(dev), "sdbus-sdhci", &error_abort);
+    s->sdbus_sdhci = SD_BUS(obj);
+
+    obj = object_property_get_link(OBJECT(dev), "sdbus-sdhost", &error_abort);
+    s->sdbus_sdhost = SD_BUS(obj);
 }
 
 static void bcm2838_gpio_class_init(ObjectClass *klass, void *data)
diff --git a/include/hw/gpio/bcm2838_gpio.h b/include/hw/gpio/bcm2838_gpio.h
index 06d48e0c19..f2a57a697f 100644
--- a/include/hw/gpio/bcm2838_gpio.h
+++ b/include/hw/gpio/bcm2838_gpio.h
@@ -14,6 +14,7 @@
 #ifndef BCM2838_GPIO_H
 #define BCM2838_GPIO_H
 
+#include "hw/sd/sd.h"
 #include "hw/sysbus.h"
 #include "qom/object.h"
 
@@ -29,6 +30,10 @@ struct BCM2838GpioState {
 
     MemoryRegion iomem;
 
+    /* SDBus selector */
+    SDBus sdbus;
+    SDBus *sdbus_sdhci;
+    SDBus *sdbus_sdhost;
 
     uint8_t fsel[BCM2838_GPIO_NUM];
     uint32_t lev0, lev1;
-- 
2.34.1


