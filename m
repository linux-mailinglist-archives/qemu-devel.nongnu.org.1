Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA46786C09
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 11:34:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6eJ-0004cM-Vf; Thu, 24 Aug 2023 05:29:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6e0-00044E-Dr
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:28:51 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6dt-0004xE-NV
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:28:46 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40078c4855fso11523085e9.3
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 02:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692869318; x=1693474118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2+oT7kMqYhvSyyz6Tbvx+jHqU2XcDlccNKL4oRSp59M=;
 b=bCR+cdV3LRthJ+azgzC3gYabHNFv7Q8nPZgr7SMOUHQhRAY/XuqHGpBxb59Wt+8F/n
 HpHdmt73d6x90mKUEi91FyPA5nOPP0bQMMVXCUrne5EUDSvYIpp0l6PO/gV2uQIVROlQ
 EcP5s7aQakm4wLShiNStDbEqf8XDtPo06qleMrEwXPkEubzkNyHUBMemBo/rHgJiN2Ay
 KjM8zEB16gvxLDRRn5iEz52ycgXQjnYurZxPaM2qv007//FBkHUYT66aPYTUpQhpJP5r
 r99IwETjXsVkH1LUuJE2Q49rxLI01Ag5B0QSF5YgsEtvuF/aESqxEzBNl864GMlJnykv
 3UrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692869318; x=1693474118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2+oT7kMqYhvSyyz6Tbvx+jHqU2XcDlccNKL4oRSp59M=;
 b=fsIZLaRqBuq99CpEFApeiQj9mIU1039Fra4peoecuD+m623YzJyD5WVs0u3Bgw7eUw
 xkOOtOpYH5aNDAmN/Xirqeu1zgKWZN/G0vRMNFYudDT5D6XbeMp6CNUxzKFf11NZPoVw
 5Z0+l7thYgrrDGk1LeL3ZDuRQe0UcKZ3h6t/KrtFe6RHKIRx+c9ip5UCspmPCR6qNHzp
 RtigimcaOYZEuAP12kPqcq27gmZDku5LnTba00GJMPVudt4LjwmG9W+wNAyoW/0eNYek
 o23+jlQ+/Wemjl+ZmpzlJBZTxOMXfjfCANUeVaUYAoT6JSrT2t+aQwTl99OE/qLfARYA
 w7cQ==
X-Gm-Message-State: AOJu0YxgLM5gkUBk2MyyhTu5zTXm7NXkg5bWfyNwdioR9nnrPDeTG+av
 84NCu3x+uXYDYWiK/wVGCkbTxF3iCslpo6iUYNA=
X-Google-Smtp-Source: AGHT+IF2fRyldL4C5lbH+WkNBTE/7U7xd4iczqqK45uCy5L3nS60xml8lhd+dwDvE6Nia4KRjGDNiw==
X-Received: by 2002:a1c:7908:0:b0:3fe:111b:7fc4 with SMTP id
 l8-20020a1c7908000000b003fe111b7fc4mr11238916wme.21.1692869318256; 
 Thu, 24 Aug 2023 02:28:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 s12-20020adfeccc000000b00317b5c8a4f1sm21844004wro.60.2023.08.24.02.28.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 02:28:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/35] hw/gpio/nrf51: implement DETECT signal
Date: Thu, 24 Aug 2023 10:28:02 +0100
Message-Id: <20230824092836.2239644-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824092836.2239644-1-peter.maydell@linaro.org>
References: <20230824092836.2239644-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Chris Laplante <chris@laplante.io>

Implement nRF51 DETECT signal in the GPIO peripheral.

The reference manual makes mention of a per-pin DETECT signal, but these
are not exposed to the user. See https://devzone.nordicsemi.com/f/nordic-q-a/39858/gpio-per-pin-detect-signal-available
for more information. Currently, I don't see a reason to model these.

Signed-off-by: Chris Laplante <chris@laplante.io>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20230728160324.1159090-2-chris@laplante.io
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/gpio/nrf51_gpio.h |  1 +
 hw/gpio/nrf51_gpio.c         | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/hw/gpio/nrf51_gpio.h b/include/hw/gpio/nrf51_gpio.h
index 8f9c2f86da3..fcfa2bac173 100644
--- a/include/hw/gpio/nrf51_gpio.h
+++ b/include/hw/gpio/nrf51_gpio.h
@@ -64,6 +64,7 @@ struct NRF51GPIOState {
     uint32_t old_out_connected;
 
     qemu_irq output[NRF51_GPIO_PINS];
+    qemu_irq detect;
 };
 
 
diff --git a/hw/gpio/nrf51_gpio.c b/hw/gpio/nrf51_gpio.c
index b47fddf4ed6..08396c69a4b 100644
--- a/hw/gpio/nrf51_gpio.c
+++ b/hw/gpio/nrf51_gpio.c
@@ -78,6 +78,7 @@ static void update_state(NRF51GPIOState *s)
     int pull;
     size_t i;
     bool connected_out, dir, connected_in, out, in, input;
+    bool assert_detect = false;
 
     for (i = 0; i < NRF51_GPIO_PINS; i++) {
         pull = pull_value(s->cnf[i]);
@@ -99,7 +100,15 @@ static void update_state(NRF51GPIOState *s)
                 qemu_log_mask(LOG_GUEST_ERROR,
                               "GPIO pin %zu short circuited\n", i);
             }
-            if (!connected_in) {
+            if (connected_in) {
+                uint32_t detect_config = extract32(s->cnf[i], 16, 2);
+                if ((detect_config == 2) && (in == 1)) {
+                    assert_detect = true;
+                }
+                if ((detect_config == 3) && (in == 0)) {
+                    assert_detect = true;
+                }
+            } else {
                 /*
                  * Floating input: the output stimulates IN if connected,
                  * otherwise pull-up/pull-down resistors put a value on both
@@ -116,6 +125,8 @@ static void update_state(NRF51GPIOState *s)
         }
         update_output_irq(s, i, connected_out, out);
     }
+
+    qemu_set_irq(s->detect, assert_detect);
 }
 
 /*
@@ -291,6 +302,7 @@ static void nrf51_gpio_init(Object *obj)
 
     qdev_init_gpio_in(DEVICE(s), nrf51_gpio_set, NRF51_GPIO_PINS);
     qdev_init_gpio_out(DEVICE(s), s->output, NRF51_GPIO_PINS);
+    qdev_init_gpio_out_named(DEVICE(s), &s->detect, "detect", 1);
 }
 
 static void nrf51_gpio_class_init(ObjectClass *klass, void *data)
-- 
2.34.1


