Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCB68242C4
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 14:38:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLNuV-0006B2-1e; Thu, 04 Jan 2024 08:37:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLNuS-00069A-KD
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 08:37:20 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLNuP-0006By-Ar
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 08:37:20 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40d5a41143fso4293505e9.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 05:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704375435; x=1704980235; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f+GEATtftaLC4WRJy+IobLm2QXvjmUhmkXYdWfYQTzc=;
 b=pF29FuncikzI/iJh0FEQizx6HmXvPSzLGOx8zCI/4CHem6LfpyCzC1Bx2yxHr5yX1P
 K+QFIK8CGjUP/T72yc+s4+sdLMeo8T8wCrUWxyeihWOWwgk55CybhCqOHht95/DxSQyQ
 zfjVX7jVVbez9fjJC8thyCA0z4tKwYW9Q/eZib+ZPl+9jyACQiMOWKfIKfruC0iPaDne
 yvRLNEi/F7ieUWofD6rs9OSfMEf9Vf1LVZFOUlBBs2uYmrhfiHQXcnZOFd1u5PIWxaLb
 P0oixMc2ffhycH5xbYPf5FaPcSiDiVqmH/P2DNEQZlM0pW1BMbgsmJTAEuHLVCUVjihS
 AYyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704375435; x=1704980235;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f+GEATtftaLC4WRJy+IobLm2QXvjmUhmkXYdWfYQTzc=;
 b=CZFnd65Fze3qWhgrX3JdfcB29UUw5KZmSIcfzkc+l9v75apnznzLifmzCX8oW9bN6X
 V4tbcvMexlh01TI5yo1s68q5IzK/gkl2FsxIKjrwT68Kk2RpEO0hpO0O9i4uS/pZtE6V
 ntnxWmOe3dRSvg+jUIALHAjv0iiPkQIHLb0E/phD55AquXNHvW72P/PJ1Cyb38tPZMl5
 UsgYC+hUf+j+FzS32n9qO5/KLnoLNkymz95rjX/2XDHkMGC/KZd9dxrKb6TaYOg5fQ1L
 grnIKd9TGMz5RzhnbvhI61aM76PSnqiCn4CVXOUTTSQlE/izHO+rvCvWATqtf7p3N2YG
 PGDA==
X-Gm-Message-State: AOJu0YyW9K4DZJzsAm1yiIY9d+lHGWedW1XCWAy8e+zTdVjlMQfnRt2k
 t1DNjWIgaEBR+n2VAgjS3yQ/c5x84F00Vg==
X-Google-Smtp-Source: AGHT+IHMT3+xGt60wNzryLJXjEaMJQKAlwGWUCpauNtHWb1VRTdUDbZ9oWHNm554ZUforVibUFGwhg==
X-Received: by 2002:a05:600c:84ce:b0:40c:2b01:e09e with SMTP id
 er14-20020a05600c84ce00b0040c2b01e09emr315806wmb.47.1704375435040; 
 Thu, 04 Jan 2024 05:37:15 -0800 (PST)
Received: from [192.168.69.100] ([176.187.194.232])
 by smtp.gmail.com with ESMTPSA id
 fc16-20020a05600c525000b0040d5c58c41dsm5733869wmb.24.2024.01.04.05.37.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jan 2024 05:37:14 -0800 (PST)
Message-ID: <f69286a2-cedf-428a-9c9f-a4b94d787507@linaro.org>
Date: Thu, 4 Jan 2024 14:37:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] tests/qtest: Add STM32L4x5 SYSCFG QTest testcase
Content-Language: en-US
To: =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
References: <20231229164915.133199-1-ines.varhol@telecom-paris.fr>
 <20231229164915.133199-3-ines.varhol@telecom-paris.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231229164915.133199-3-ines.varhol@telecom-paris.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 29/12/23 17:47, Inès Varhol wrote:
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> 
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
> ---
>   tests/qtest/meson.build             |   3 +-
>   tests/qtest/stm32l4x5_syscfg-test.c | 408 ++++++++++++++++++++++++++++
>   2 files changed, 410 insertions(+), 1 deletion(-)
>   create mode 100644 tests/qtest/stm32l4x5_syscfg-test.c

Helper suggestion to ease readability:

static void syscfg_set_irq(int num, int level)
{
    qtest_set_irq_in(global_qtest, "/machine/soc/syscfg",
                     NULL, num, level);
}

When the SoC is parented to the machine, this patch needs:

-- >8 --
diff --git a/tests/qtest/stm32l4x5_syscfg-test.c 
b/tests/qtest/stm32l4x5_syscfg-test.c
index 3edd13b222..272ba91055 100644
--- a/tests/qtest/stm32l4x5_syscfg-test.c
+++ b/tests/qtest/stm32l4x5_syscfg-test.c
@@ -240,3 +240,3 @@ static void test_interrupt(void)
       */
-    qtest_irq_intercept_in(global_qtest, 
"/machine/unattached/device[0]/exti");
+    qtest_irq_intercept_in(global_qtest, "/machine/soc/exti");
      /* Enable interrupt on rising edge of GPIO PA[0] */
@@ -245,4 +245,3 @@ static void test_interrupt(void)

-    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/syscfg",
-                     NULL, 0, 1);
+    qtest_set_irq_in(global_qtest, "/machine/soc/syscfg", NULL, 0, 1);

@@ -254,4 +253,3 @@ static void test_interrupt(void)

-    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/syscfg",
-                     NULL, 15, 1);
+    qtest_set_irq_in(global_qtest, "/machine/soc/syscfg", NULL, 15, 1);

@@ -264,4 +262,3 @@ static void test_interrupt(void)

-    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/syscfg",
-                     NULL, 17, 1);
+    qtest_set_irq_in(global_qtest, "/machine/soc/syscfg", NULL, 17, 1);

@@ -271,8 +268,5 @@ static void test_interrupt(void)
      syscfg_writel(SYSCFG_EXTICR1, 0x00000000);
-    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/syscfg",
-                     NULL, 0, 0);
-    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/syscfg",
-                     NULL, 15, 0);
-    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/syscfg",
-                     NULL, 17, 0);
+    qtest_set_irq_in(global_qtest, "/machine/soc/syscfg", NULL, 0, 0);
+    qtest_set_irq_in(global_qtest, "/machine/soc/syscfg", NULL, 15, 0);
+    qtest_set_irq_in(global_qtest, "/machine/soc/syscfg", NULL, 17, 0);
  }
@@ -285,3 +279,3 @@ static void test_irq_pin_multiplexer(void)

-    qtest_irq_intercept_in(global_qtest, 
"/machine/unattached/device[0]/exti");
+    qtest_irq_intercept_in(global_qtest, "/machine/soc/exti");

@@ -291,4 +285,3 @@ static void test_irq_pin_multiplexer(void)

-    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/syscfg",
-                     NULL, 0, 1);
+    qtest_set_irq_in(global_qtest, "/machine/soc/syscfg", NULL, 0, 1);

@@ -299,4 +292,3 @@ static void test_irq_pin_multiplexer(void)
      /* Clean the test */
-    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/syscfg",
-                     NULL, 0, 0);
+    qtest_set_irq_in(global_qtest, "/machine/soc/syscfg", NULL, 0, 0);

@@ -306,4 +298,3 @@ static void test_irq_pin_multiplexer(void)

-    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/syscfg",
-                     NULL, 15, 1);
+    qtest_set_irq_in(global_qtest, "/machine/soc/syscfg", NULL, 15, 1);

@@ -314,4 +305,3 @@ static void test_irq_pin_multiplexer(void)
      /* Clean the test */
-    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/syscfg",
-                     NULL, 15, 0);
+    qtest_set_irq_in(global_qtest, "/machine/soc/syscfg", NULL, 15, 0);
  }
@@ -324,3 +314,3 @@ static void test_irq_gpio_multiplexer(void)

-    qtest_irq_intercept_in(global_qtest, 
"/machine/unattached/device[0]/exti");
+    qtest_irq_intercept_in(global_qtest, "/machine/soc/exti");

@@ -331,4 +321,3 @@ static void test_irq_gpio_multiplexer(void)
      /* Check that setting rising pin GPIOA[0] generates an irq */
-    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/syscfg",
-                     NULL, 0, 1);
+    qtest_set_irq_in(global_qtest, "/machine/soc/syscfg", NULL, 0, 1);

@@ -337,8 +326,6 @@ static void test_irq_gpio_multiplexer(void)
      /* Clean the test */
-    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/syscfg",
-                     NULL, 0, 0);
+    qtest_set_irq_in(global_qtest, "/machine/soc/syscfg", NULL, 0, 0);

      /* Check that setting rising pin GPIOB[0] doesn't generate an irq */
-    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/syscfg",
-                     NULL, 16, 1);
+    qtest_set_irq_in(global_qtest, "/machine/soc/syscfg", NULL, 16, 1);

@@ -347,4 +334,3 @@ static void test_irq_gpio_multiplexer(void)
      /* Clean the test */
-    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/syscfg",
-                     NULL, 16, 0);
+    qtest_set_irq_in(global_qtest, "/machine/soc/syscfg", NULL, 16, 0);

@@ -356,4 +342,3 @@ static void test_irq_gpio_multiplexer(void)
      /* Check that setting rising pin GPIOA[0] doesn't generate an irq */
-    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/syscfg",
-                     NULL, 0, 1);
+    qtest_set_irq_in(global_qtest, "/machine/soc/syscfg", NULL, 0, 1);

@@ -362,8 +347,6 @@ static void test_irq_gpio_multiplexer(void)
      /* Clean the test */
-    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/syscfg",
-                     NULL, 0, 0);
+    qtest_set_irq_in(global_qtest, "/machine/soc/syscfg", NULL, 0, 0);

      /* Check that setting rising pin GPIOB[0] generates an irq */
-    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/syscfg",
-                     NULL, 16, 1);
+    qtest_set_irq_in(global_qtest, "/machine/soc/syscfg", NULL, 16, 1);

@@ -372,4 +355,3 @@ static void test_irq_gpio_multiplexer(void)
      /* Clean the test */
-    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/syscfg",
-                     NULL, 16, 0);
+    qtest_set_irq_in(global_qtest, "/machine/soc/syscfg", NULL, 16, 0);
      syscfg_writel(SYSCFG_EXTICR1, 0x00000000);
---

With the helper included (since I tested it):

-- >8 --
diff --git a/tests/qtest/stm32l4x5_syscfg-test.c 
b/tests/qtest/stm32l4x5_syscfg-test.c
index 3edd13b222..19a5f83ebe 100644
--- a/tests/qtest/stm32l4x5_syscfg-test.c
+++ b/tests/qtest/stm32l4x5_syscfg-test.c
@@ -47,2 +47,8 @@ static void exti_writel(unsigned int offset, uint32_t 
value)

+static void syscfg_set_irq(int num, int level)
+{
+   qtest_set_irq_in(global_qtest, "/machine/soc/syscfg",
+                    NULL, num, level);
+}
+
  static void system_reset(void)
@@ -240,3 +246,3 @@ static void test_interrupt(void)
       */
-    qtest_irq_intercept_in(global_qtest, 
"/machine/unattached/device[0]/exti");
+    qtest_irq_intercept_in(global_qtest, "/machine/soc/exti");
      /* Enable interrupt on rising edge of GPIO PA[0] */
@@ -245,4 +251,3 @@ static void test_interrupt(void)

-    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/syscfg",
-                     NULL, 0, 1);
+    syscfg_set_irq(0, 1);

@@ -254,4 +259,3 @@ static void test_interrupt(void)

-    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/syscfg",
-                     NULL, 15, 1);
+    syscfg_set_irq(15, 1);

@@ -264,4 +268,3 @@ static void test_interrupt(void)

-    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/syscfg",
-                     NULL, 17, 1);
+    syscfg_set_irq(17, 1);

@@ -271,8 +274,5 @@ static void test_interrupt(void)
      syscfg_writel(SYSCFG_EXTICR1, 0x00000000);
-    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/syscfg",
-                     NULL, 0, 0);
-    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/syscfg",
-                     NULL, 15, 0);
-    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/syscfg",
-                     NULL, 17, 0);
+    syscfg_set_irq(0, 0);
+    syscfg_set_irq(15, 0);
+    syscfg_set_irq(17, 0);
  }
@@ -285,3 +285,3 @@ static void test_irq_pin_multiplexer(void)

-    qtest_irq_intercept_in(global_qtest, 
"/machine/unattached/device[0]/exti");
+    qtest_irq_intercept_in(global_qtest, "/machine/soc/exti");

@@ -291,4 +291,3 @@ static void test_irq_pin_multiplexer(void)

-    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/syscfg",
-                     NULL, 0, 1);
+    syscfg_set_irq(0, 1);

@@ -299,4 +298,3 @@ static void test_irq_pin_multiplexer(void)
      /* Clean the test */
-    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/syscfg",
-                     NULL, 0, 0);
+    syscfg_set_irq(0, 0);

@@ -306,4 +304,3 @@ static void test_irq_pin_multiplexer(void)

-    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/syscfg",
-                     NULL, 15, 1);
+    syscfg_set_irq(15, 1);

@@ -314,4 +311,3 @@ static void test_irq_pin_multiplexer(void)
      /* Clean the test */
-    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/syscfg",
-                     NULL, 15, 0);
+    syscfg_set_irq(15, 0);
  }
@@ -324,3 +320,3 @@ static void test_irq_gpio_multiplexer(void)

-    qtest_irq_intercept_in(global_qtest, 
"/machine/unattached/device[0]/exti");
+    qtest_irq_intercept_in(global_qtest, "/machine/soc/exti");

@@ -331,4 +327,3 @@ static void test_irq_gpio_multiplexer(void)
      /* Check that setting rising pin GPIOA[0] generates an irq */
-    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/syscfg",
-                     NULL, 0, 1);
+    syscfg_set_irq(0, 1);

@@ -337,8 +332,6 @@ static void test_irq_gpio_multiplexer(void)
      /* Clean the test */
-    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/syscfg",
-                     NULL, 0, 0);
+    syscfg_set_irq(0, 0);

      /* Check that setting rising pin GPIOB[0] doesn't generate an irq */
-    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/syscfg",
-                     NULL, 16, 1);
+    syscfg_set_irq(16, 1);

@@ -347,4 +340,3 @@ static void test_irq_gpio_multiplexer(void)
      /* Clean the test */
-    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/syscfg",
-                     NULL, 16, 0);
+    syscfg_set_irq(16, 0);

@@ -356,4 +348,3 @@ static void test_irq_gpio_multiplexer(void)
      /* Check that setting rising pin GPIOA[0] doesn't generate an irq */
-    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/syscfg",
-                     NULL, 0, 1);
+    syscfg_set_irq(0, 1);

@@ -362,8 +353,6 @@ static void test_irq_gpio_multiplexer(void)
      /* Clean the test */
-    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/syscfg",
-                     NULL, 0, 0);
+    syscfg_set_irq(0, 0);

      /* Check that setting rising pin GPIOB[0] generates an irq */
-    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/syscfg",
-                     NULL, 16, 1);
+    syscfg_set_irq(16, 1);

@@ -372,4 +361,3 @@ static void test_irq_gpio_multiplexer(void)
      /* Clean the test */
-    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/syscfg",
-                     NULL, 16, 0);
+    syscfg_set_irq(16, 0);
      syscfg_writel(SYSCFG_EXTICR1, 0x00000000);
---

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Regards,

Phil.

