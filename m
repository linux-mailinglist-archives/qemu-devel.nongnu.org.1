Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5E6866728
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Feb 2024 01:07:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reOSp-0006bi-Rb; Sun, 25 Feb 2024 19:03:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1reOSm-0006ZS-9d; Sun, 25 Feb 2024 19:03:20 -0500
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1reOSg-0000IC-G0; Sun, 25 Feb 2024 19:03:18 -0500
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-608959cfcbfso24496677b3.3; 
 Sun, 25 Feb 2024 16:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708905793; x=1709510593; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xum/tGNEorhEX610bWwHZPsDiBGT2east0eAc/ZxI8w=;
 b=EIR7ZUWOvMEfEqQO8jPe+/RRNpmMAAuNH9gWLPaHz0CkmC29IaFDUFgFOyd/5qjiXY
 Dmj4SRijPAVdHAAInM4ts1arrl2hw5nQjABROmtp+pJ86uXMptJXRpxJwZXtaZmNeKHV
 yMIavoPuPrIN7SyOf9wP5wtVKCs+2amtXAR5w1Zsd10+LLT1NCKdhRz8mrKtYYi0R9X0
 bge9gvHaP6F/ve540e5KT+cSiLDxncENDoSf6xmwIQ11WvySWGCRLQN6rVO7ThR52sDY
 bzLZ/h8QwMrM3jMcuzGm8SQGM1C0qAiZKFUgXUG//C+oR1bLoYfHJcDqiOSuekA27wdR
 UF1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708905793; x=1709510593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xum/tGNEorhEX610bWwHZPsDiBGT2east0eAc/ZxI8w=;
 b=vtBfcbQXWkQyeBnAZJqeRdCpbwNmSXSQ6xQdgv8m2KH/icwyvpR8F0ua/Jah6Q9YNd
 hR2YuoMq/47XSN+PqeJl9vld90jVrLlwjyy+PDyMIaPm0qmg+T9lC6OZotoveENeVJ3Y
 JbP4BUKhFQ7bVux+WKRKZAN5EADE7Xtq84sHODbszciK8l+4B1fqADkMoriQcOhLVPmY
 egit0kUhLXLaXBvk2H+MocqD9VDh4v1QNCFBOSopVwjEPXGamnNbV0OUgTcrf1cJdiwA
 a2I7u/O+VifZKn0R1e1V+HAavy9zXawqgE43g1eFODCovt5msBNt0Rk87Oi4mHNfZmRa
 eIPQ==
X-Gm-Message-State: AOJu0Yw71LZtSN3jHiDEv5SpbIu03gbsAqRXoKKRYkI1ehAAGZvqml5d
 TMxfT4FrDx5/r59wnnuWhgtAxi5PmVP1MXur1PZV/nWAFAK6Bw1k/0t/jrDInvimXg==
X-Google-Smtp-Source: AGHT+IGIknjl47B+VYRHu83Wv7206hEJJpGLErUhPumGEfuWP4NWZQxENLcYzeEloycWztuHhc3/sg==
X-Received: by 2002:a81:a012:0:b0:608:b9cb:ad40 with SMTP id
 x18-20020a81a012000000b00608b9cbad40mr5333870ywg.35.1708905792731; 
 Sun, 25 Feb 2024 16:03:12 -0800 (PST)
Received: from localhost.localdomain ([201.203.117.224])
 by smtp.gmail.com with ESMTPSA id
 t18-20020a818312000000b00607bfa1913csm938171ywf.114.2024.02.25.16.03.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Feb 2024 16:03:12 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Sergey Kambalin <sergey.kambalin@auriga.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v6 08/41] Connect SD controller to BCM2838 GPIO
Date: Sun, 25 Feb 2024 18:02:26 -0600
Message-Id: <20240226000259.2752893-9-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226000259.2752893-1-sergey.kambalin@auriga.com>
References: <20240226000259.2752893-1-sergey.kambalin@auriga.com>
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/gpio/bcm2838_gpio.c         | 52 +++++++++++++++++++++++++++++++++-
 include/hw/gpio/bcm2838_gpio.h |  5 ++++
 2 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/hw/gpio/bcm2838_gpio.c b/hw/gpio/bcm2838_gpio.c
index 69d15dbb49..2ddf62f695 100644
--- a/hw/gpio/bcm2838_gpio.c
+++ b/hw/gpio/bcm2838_gpio.c
@@ -17,6 +17,7 @@
 #include "qapi/error.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
+#include "hw/sd/sd.h"
 #include "hw/gpio/bcm2838_gpio.h"
 #include "hw/irq.h"
 
@@ -63,6 +64,16 @@
 
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
@@ -86,6 +97,31 @@ static void gpfsel_set(BCM2838GpioState *s, uint8_t reg, uint32_t value)
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
 
@@ -304,6 +345,8 @@ static void bcm2838_gpio_init(Object *obj)
     DeviceState *dev = DEVICE(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
 
+    qbus_init(&s->sdbus, sizeof(s->sdbus), TYPE_SD_BUS, DEVICE(s), "sd-bus");
+
     memory_region_init_io(&s->iomem, obj, &bcm2838_gpio_ops, s,
                           "bcm2838_gpio", BCM2838_GPIO_REGS_SIZE);
     sysbus_init_mmio(sbd, &s->iomem);
@@ -312,7 +355,14 @@ static void bcm2838_gpio_init(Object *obj)
 
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


