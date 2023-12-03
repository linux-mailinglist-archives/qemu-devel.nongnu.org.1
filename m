Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C01AF8027D8
	for <lists+qemu-devel@lfdr.de>; Sun,  3 Dec 2023 22:33:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9u1k-0001Ok-DB; Sun, 03 Dec 2023 16:29:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9u1f-0001NJ-Rq; Sun, 03 Dec 2023 16:29:19 -0500
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9u1e-0005Ot-0k; Sun, 03 Dec 2023 16:29:19 -0500
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-db3a09e96daso2128170276.3; 
 Sun, 03 Dec 2023 13:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701638956; x=1702243756; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ceI73nY+WORMm25Lfb079HY3yTTZKu7+HhKvNA+xgeM=;
 b=Oah9CitJ13UctO801oTxnEqWVER/3t97+ofgoWHYh+tGj1gaUwCboryjM/xgNi7ebG
 mtkMQBIkFXgOwmP0gMEATjZc3GsDE84Bn6321ysB8Gla/BRwkOExjGfpRApGUbpsX11k
 5SuMad2IxoyNE8ZT9TkRWVDWGX2LI2YyYBXFG/FwVsEOBk6SzDV5vsFtiJel22VnP3Rf
 P9zkkhUvpQ2V3m6zKcQa1QsJ2bUZK/0zdVXvtf8WrSyEelEudThVmqijLNnlMoTYqAFp
 WOcUfK6w2B0fp52mlnX2xz8nL7SgpRbW2ZMgpg1/E9HAlD7zRJ+MwhrHnLqBnk8AjA7h
 yIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701638956; x=1702243756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ceI73nY+WORMm25Lfb079HY3yTTZKu7+HhKvNA+xgeM=;
 b=dpRRHVDgbhWnIYCHzxBbk3XeidfAPARuB20ODlfLxIjjY5Q5PvF82GHxJyS5aWZ3ik
 wY7R60915MViGM+clMmcAyuf1flZmRNGrbRTySAp7LQk8eigeJElqzYK6P+B0Zv57ONa
 LSwzHSINuzbG1kdrwx8emYxb1hRmlItJYalMjxzw9gdeDjWRfnJ4haPS0qp77tJKYOPR
 oiJ+2uEw7RLp4sRnyLyjHiyuX8T0BXYRWcof5mr+MWW7Q5bgubFTdsbScKRDqAxWr4aT
 fIdFeqteVshBF56ltqhq7oSULA4A9KRKD/VuSRD8OcbEs0mVG3XkxKk6B4muH7jOe3p0
 g8lQ==
X-Gm-Message-State: AOJu0YyCN4PBugk6QVbRXolrj/NS7RMo3OfZZraQB+V7nrFRx58kIetb
 iuLj0CLpjsPs/mx/CDW6fw805ThX1wH49g==
X-Google-Smtp-Source: AGHT+IFDTfFgsk/TnUQ2S3RLz+B/nbiLOwS4odTaOMYc6UW0LumjJZ2c/YnhnXAYgyBlMbSQUUKkyQ==
X-Received: by 2002:a05:6902:1008:b0:db7:dad0:60d8 with SMTP id
 w8-20020a056902100800b00db7dad060d8mr2269016ybt.101.1701638956524; 
 Sun, 03 Dec 2023 13:29:16 -0800 (PST)
Received: from localhost.localdomain ([201.206.180.22])
 by smtp.gmail.com with ESMTPSA id
 c17-20020a25a291000000b00d9cc606c78csm1807318ybi.41.2023.12.03.13.29.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 13:29:16 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH 07/45] Implement BCM2838 GPIO functionality
Date: Sun,  3 Dec 2023 15:28:27 -0600
Message-Id: <20231203212905.1364036-8-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231203212905.1364036-7-sergey.kambalin@auriga.com>
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
 <20231203212905.1364036-1-sergey.kambalin@auriga.com>
 <20231203212905.1364036-2-sergey.kambalin@auriga.com>
 <20231203212905.1364036-3-sergey.kambalin@auriga.com>
 <20231203212905.1364036-4-sergey.kambalin@auriga.com>
 <20231203212905.1364036-5-sergey.kambalin@auriga.com>
 <20231203212905.1364036-6-sergey.kambalin@auriga.com>
 <20231203212905.1364036-7-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=serg.oker@gmail.com; helo=mail-yb1-xb35.google.com
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
 hw/gpio/bcm2838_gpio.c | 192 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 189 insertions(+), 3 deletions(-)

diff --git a/hw/gpio/bcm2838_gpio.c b/hw/gpio/bcm2838_gpio.c
index 15b66cb559..51eb55b00a 100644
--- a/hw/gpio/bcm2838_gpio.c
+++ b/hw/gpio/bcm2838_gpio.c
@@ -19,6 +19,7 @@
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/gpio/bcm2838_gpio.h"
+#include "hw/irq.h"
 
 #define GPFSEL0   0x00
 #define GPFSEL1   0x04
@@ -57,14 +58,139 @@
 #define RESET_VAL_CNTRL_REG2 0x50AAA95A;
 #define RESET_VAL_CNTRL_REG3 0x00055555;
 
+#define NUM_FSELN_IN_GPFSELN 10
+#define NUM_BITS_FSELN       3
+#define MASK_FSELN           0x7
+
 #define BYTES_IN_WORD        4
 
+static uint32_t gpfsel_get(BCM2838GpioState *s, uint8_t reg)
+{
+    int i;
+    uint32_t value = 0;
+    for (i = 0; i < NUM_FSELN_IN_GPFSELN; i++) {
+        uint32_t index = NUM_FSELN_IN_GPFSELN * reg + i;
+        if (index < sizeof(s->fsel)) {
+            value |= (s->fsel[index] & MASK_FSELN) << (NUM_BITS_FSELN * i);
+        }
+    }
+    return value;
+}
+
+static void gpfsel_set(BCM2838GpioState *s, uint8_t reg, uint32_t value)
+{
+    int i;
+    for (i = 0; i < NUM_FSELN_IN_GPFSELN; i++) {
+        uint32_t index = NUM_FSELN_IN_GPFSELN * reg + i;
+        if (index < sizeof(s->fsel)) {
+            int fsel = (value >> (NUM_BITS_FSELN * i)) & MASK_FSELN;
+            s->fsel[index] = fsel;
+        }
+    }
+}
+
+static int gpfsel_is_out(BCM2838GpioState *s, int index)
+{
+    if (index >= 0 && index < BCM2838_GPIO_NUM) {
+        return s->fsel[index] == 1;
+    }
+    return 0;
+}
+
+static void gpset(BCM2838GpioState *s, uint32_t val, uint8_t start,
+                  uint8_t count, uint32_t *lev)
+{
+    uint32_t changes = val & ~*lev;
+    uint32_t cur = 1;
+
+    int i;
+    for (i = 0; i < count; i++) {
+        if ((changes & cur) && (gpfsel_is_out(s, start + i))) {
+            qemu_set_irq(s->out[start + i], 1);
+        }
+        cur <<= 1;
+    }
+
+    *lev |= val;
+}
+
+static void gpclr(BCM2838GpioState *s, uint32_t val, uint8_t start,
+                  uint8_t count, uint32_t *lev)
+{
+    uint32_t changes = val & *lev;
+    uint32_t cur = 1;
+
+    int i;
+    for (i = 0; i < count; i++) {
+        if ((changes & cur) && (gpfsel_is_out(s, start + i))) {
+            qemu_set_irq(s->out[start + i], 0);
+        }
+        cur <<= 1;
+    }
+
+    *lev &= ~val;
+}
+
 static uint64_t bcm2838_gpio_read(void *opaque, hwaddr offset, unsigned size)
 {
+    BCM2838GpioState *s = (BCM2838GpioState *)opaque;
     uint64_t value = 0;
 
-    qemu_log_mask(LOG_UNIMP, "%s: %s: not implemented for %"HWADDR_PRIx"\n",
-                  TYPE_BCM2838_GPIO, __func__, offset);
+    switch (offset) {
+    case GPFSEL0:
+    case GPFSEL1:
+    case GPFSEL2:
+    case GPFSEL3:
+    case GPFSEL4:
+    case GPFSEL5:
+        value = gpfsel_get(s, offset / BYTES_IN_WORD);
+        break;
+    case GPSET0:
+    case GPSET1:
+    case GPCLR0:
+    case GPCLR1:
+        /* Write Only */
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: %s: Attempt reading from write only"
+                      " register. %lu will be returned. Address 0x%"HWADDR_PRIx
+                      ", size %u\n", TYPE_BCM2838_GPIO, __func__, value, offset,
+                      size);
+        break;
+    case GPLEV0:
+        value = s->lev0;
+        break;
+    case GPLEV1:
+        value = s->lev1;
+        break;
+    case GPEDS0:
+    case GPEDS1:
+    case GPREN0:
+    case GPREN1:
+    case GPFEN0:
+    case GPFEN1:
+    case GPHEN0:
+    case GPHEN1:
+    case GPLEN0:
+    case GPLEN1:
+    case GPAREN0:
+    case GPAREN1:
+    case GPAFEN0:
+    case GPAFEN1:
+        /* Not implemented */
+        qemu_log_mask(LOG_UNIMP, "%s: %s: not implemented for %"HWADDR_PRIx"\n",
+                      TYPE_BCM2838_GPIO, __func__, offset);
+        break;
+    case GPIO_PUP_PDN_CNTRL_REG0:
+    case GPIO_PUP_PDN_CNTRL_REG1:
+    case GPIO_PUP_PDN_CNTRL_REG2:
+    case GPIO_PUP_PDN_CNTRL_REG3:
+        value = s->pup_cntrl_reg[(offset - GPIO_PUP_PDN_CNTRL_REG0)
+                                 / sizeof(s->pup_cntrl_reg[0])];
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: %s: bad offset %"HWADDR_PRIx"\n",
+                      TYPE_BCM2838_GPIO, __func__, offset);
+        break;
+    }
 
     return value;
 }
@@ -72,14 +198,74 @@ static uint64_t bcm2838_gpio_read(void *opaque, hwaddr offset, unsigned size)
 static void bcm2838_gpio_write(void *opaque, hwaddr offset, uint64_t value,
                                unsigned size)
 {
-    qemu_log_mask(LOG_UNIMP, "%s: %s: not implemented for %"HWADDR_PRIx"\n",
+    BCM2838GpioState *s = (BCM2838GpioState *)opaque;
+
+    switch (offset) {
+    case GPFSEL0:
+    case GPFSEL1:
+    case GPFSEL2:
+    case GPFSEL3:
+    case GPFSEL4:
+    case GPFSEL5:
+        gpfsel_set(s, offset / BYTES_IN_WORD, value);
+        break;
+    case GPSET0:
+        gpset(s, value, 0, 32, &s->lev0);
+        break;
+    case GPSET1:
+        gpset(s, value, 32, 22, &s->lev1);
+        break;
+    case GPCLR0:
+        gpclr(s, value, 0, 32, &s->lev0);
+        break;
+    case GPCLR1:
+        gpclr(s, value, 32, 22, &s->lev1);
+        break;
+    case GPLEV0:
+    case GPLEV1:
+        /* Read Only */
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: %s: Attempt writing %lu to read "
+                      "only register. Ignored. Address 0x%"HWADDR_PRIx", size "
+                      "%u\n", TYPE_BCM2838_GPIO, __func__, value, offset, size);
+        break;
+    case GPEDS0:
+    case GPEDS1:
+    case GPREN0:
+    case GPREN1:
+    case GPFEN0:
+    case GPFEN1:
+    case GPHEN0:
+    case GPHEN1:
+    case GPLEN0:
+    case GPLEN1:
+    case GPAREN0:
+    case GPAREN1:
+    case GPAFEN0:
+    case GPAFEN1:
+        /* Not implemented */
+        qemu_log_mask(LOG_UNIMP, "%s: %s: not implemented for %"HWADDR_PRIx"\n",
+                      TYPE_BCM2838_GPIO, __func__, offset);
+        break;
+    case GPIO_PUP_PDN_CNTRL_REG0:
+    case GPIO_PUP_PDN_CNTRL_REG1:
+    case GPIO_PUP_PDN_CNTRL_REG2:
+    case GPIO_PUP_PDN_CNTRL_REG3:
+        s->pup_cntrl_reg[(offset - GPIO_PUP_PDN_CNTRL_REG0)
+                         / sizeof(s->pup_cntrl_reg[0])] = value;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: %s: bad offset %"HWADDR_PRIx"\n",
                   TYPE_BCM2838_GPIO, __func__, offset);
+    }
+    return;
 }
 
 static void bcm2838_gpio_reset(DeviceState *dev)
 {
     BCM2838GpioState *s = BCM2838_GPIO(dev);
 
+    memset(s->fsel, 0, sizeof(s->fsel));
+
     s->lev0 = 0;
     s->lev1 = 0;
 
-- 
2.34.1


