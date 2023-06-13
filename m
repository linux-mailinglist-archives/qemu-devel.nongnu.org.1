Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E245A72E16B
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 13:25:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q90Ue-0005Zt-C3; Tue, 13 Jun 2023 05:39:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q90Uc-0005Zc-GR
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 05:39:14 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q90UZ-0005be-Ff
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 05:39:14 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-9786fc23505so778218566b.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 02:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686649150; x=1689241150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/D7wkI1JesyjQo8qFwOoKcnfGvIlymgwtmf2GQlKJIc=;
 b=fq/uTziqCef/oigNwOx9ee1rF0B1HfKKLDByBWHosf8Qghsd7AGtYqSrMdRs2xISSD
 kIbNbd7kgxBpiLctHOKykmDUkzvWzVNRKoLq+2gM7vDrHdv10XadNjkqAju+jmO6kLI9
 R9+Tt0qucT1DkwnL9Vybo1b+j81Fff14Sb1mM5vdBW0GzSF7MaZo0Mp2eqFf4Ox1t8aa
 E/dC/X//80g3rFgNzqC0A5XebbpQnG27UbH1dyQIFh0HRQtHUwMddQh54MeChPl+vSwq
 iAGCznSt5aPC7oLkOQoYu1DQ3c/bvWDBg6AHjOHJfQhOpyq5/Fz7aA+y4I5SIexycWSM
 BLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686649150; x=1689241150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/D7wkI1JesyjQo8qFwOoKcnfGvIlymgwtmf2GQlKJIc=;
 b=FCzzfaDKJtAA6VtzwZT5k7dtAShdUNcWwYDrkcZr9Yru9YQAJKmH/cmEMFDf3cuJg2
 iDObeMcXTnhgrrq0UyzdoWNL0cUWH5D+qIyDv/yhIJIvR0kmSxJqR3SpNo66XSNj3LmW
 l+vv6DzshlAYO+MzOhQSdTh0/8JW1f3zxlxKkhFVCIkuVjka3gMzFapt2SkRdM0kUZYt
 MEHnGaEnYDQnl86TkR2klQU4ki7IHvKClfZPNFiMF1+P/9sxUU+j/Gg3vxmylTODsHyX
 one/e60uKBxxiy5QBOx+tcmBhRxefQN8D4nk79vnlsel4stjLGFzkQ6haBSyYIe6tc/6
 rPUg==
X-Gm-Message-State: AC+VfDxrwWsa+3s/mIgM8j3gdE4UdaUebCIEisnrNKpDpRHTwTzUx2iV
 +3j4IecitySzJvIhyOt7zeME59o5oSwbyX9GH/nBZA==
X-Google-Smtp-Source: ACHHUZ6T6NHUuFXZEdMwWG/kufwmZjuaQ970KtqwsIYl12N5QG017sERYexedTEW0hGBrjgsP3ItLA==
X-Received: by 2002:a17:907:7f0f:b0:97e:ab93:b246 with SMTP id
 qf15-20020a1709077f0f00b0097eab93b246mr8731430ejc.66.1686649149808; 
 Tue, 13 Jun 2023 02:39:09 -0700 (PDT)
Received: from localhost.localdomain ([185.140.244.249])
 by smtp.gmail.com with ESMTPSA id
 w23-20020a170906b19700b009746394662asm6403119ejy.53.2023.06.13.02.39.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Jun 2023 02:39:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Patrick Venture <venture@google.com>,
 Hao Wu <wuhaotsh@google.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Corey Minyard <cminyard@mvista.com>
Subject: [PULL 10/17] hw/i2c: Enable an id for the pca954x devices
Date: Tue, 13 Jun 2023 11:38:15 +0200
Message-Id: <20230613093822.63750-11-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230613093822.63750-1-philmd@linaro.org>
References: <20230613093822.63750-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Patrick Venture <venture@google.com>

This allows the devices to be more readily found and specified.
Without setting the name field, they can only be found by device type
name, which doesn't let you specify the second of the same device type
behind a bus.

Tested: Verified that by default the device was findable with the name
'pca954x[77]', for an instance attached at that address.

Signed-off-by: Patrick Venture <venture@google.com>
Reviewed-by: Hao Wu <wuhaotsh@google.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Corey Minyard <cminyard@mvista.com>
Message-Id: <20230322172136.48010-1-venture@google.com>
[PMD: Fix typo in property name]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i2c/i2c_mux_pca954x.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/hw/i2c/i2c_mux_pca954x.c b/hw/i2c/i2c_mux_pca954x.c
index 3945de795c..db5db956a6 100644
--- a/hw/i2c/i2c_mux_pca954x.c
+++ b/hw/i2c/i2c_mux_pca954x.c
@@ -20,6 +20,7 @@
 #include "hw/i2c/i2c_mux_pca954x.h"
 #include "hw/i2c/smbus_slave.h"
 #include "hw/qdev-core.h"
+#include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
@@ -43,6 +44,8 @@ typedef struct Pca954xState {
 
     bool enabled[PCA9548_CHANNEL_COUNT];
     I2CBus *bus[PCA9548_CHANNEL_COUNT];
+
+    char *name;
 } Pca954xState;
 
 /*
@@ -181,6 +184,17 @@ static void pca9548_class_init(ObjectClass *klass, void *data)
     s->nchans = PCA9548_CHANNEL_COUNT;
 }
 
+static void pca954x_realize(DeviceState *dev, Error **errp)
+{
+    Pca954xState *s = PCA954X(dev);
+    DeviceState *d = DEVICE(s);
+    if (s->name) {
+        d->id = g_strdup(s->name);
+    } else {
+        d->id = g_strdup_printf("pca954x[%x]", s->parent.i2c.address);
+    }
+}
+
 static void pca954x_init(Object *obj)
 {
     Pca954xState *s = PCA954X(obj);
@@ -197,6 +211,11 @@ static void pca954x_init(Object *obj)
     }
 }
 
+static Property pca954x_props[] = {
+    DEFINE_PROP_STRING("name", Pca954xState, name),
+    DEFINE_PROP_END_OF_LIST()
+};
+
 static void pca954x_class_init(ObjectClass *klass, void *data)
 {
     I2CSlaveClass *sc = I2C_SLAVE_CLASS(klass);
@@ -209,9 +228,12 @@ static void pca954x_class_init(ObjectClass *klass, void *data)
     rc->phases.enter = pca954x_enter_reset;
 
     dc->desc = "Pca954x i2c-mux";
+    dc->realize = pca954x_realize;
 
     k->write_data = pca954x_write_data;
     k->receive_byte = pca954x_read_byte;
+
+    device_class_set_props(dc, pca954x_props);
 }
 
 static const TypeInfo pca954x_info[] = {
-- 
2.38.1


