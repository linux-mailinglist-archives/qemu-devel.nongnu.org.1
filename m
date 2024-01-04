Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD24C8242B7
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 14:35:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLNqa-0003ad-Qz; Thu, 04 Jan 2024 08:33:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLNqY-0003aC-Iq
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 08:33:18 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLNqV-0007xD-Cg
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 08:33:18 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3368abe1093so373550f8f.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 05:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704375193; x=1704979993; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QJS5zZy6zgomOyOtVRuyX1xTeTZW0jiOaotRDl0Z0zM=;
 b=Cf0J7aSEbFNH5RwhvVi1diVauptto6GfZrAA4vfRQqF8pxtqj6HUaSAIqHXltAw43+
 dsg3w846yNuRiJdoftzzLAUeqstcNFmz/PWFrUeD08A2YnkDy+8HDCGoJXA8fEy6O0S6
 RE+o7ggdMriqaOcGOv873kqdVWOpB5nUI6Mt16ACymXj0iuNVsLRHeqDNIanuMuIYs7W
 Xb4boV4pOIb4AV9NQn8Q1c59VR/f4rH58ni4nNEkVM5rTHEaKsWcq9OManhOuVb0ESJz
 OUGsUk6wVwhZIKLf7M4Ax72Ko+zZ01fTIxsIfY/UecO4xSlVT0elzGo223L5MZGUR7qt
 7MWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704375193; x=1704979993;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QJS5zZy6zgomOyOtVRuyX1xTeTZW0jiOaotRDl0Z0zM=;
 b=qud/Bs4W/Ac1Qsa4W7WAQJorEGEReL5iL97czt7nuU5wgAtv9Vh/ZZLkmSAB8jCh9L
 4SRzDgsdaCBEc+wtMXaJkD+DkK9NFwAUP8Ff2S8EXPDoAuCnAdLqvZmk0CtSGW5akATU
 sWYRSqovZKi7byJe5fRkiFGHU+erj7YKkVy4Jc5kwO77hrOms77Sih0EHTMmm2RhVUsP
 YG75gVSG8AiN5PkBse0cKPmCBHzOFSOCiRCtCjOtxcY9Jj0JagijqQv9Z55eX/DaSCfm
 uhfuv9VduPD5gs43Gg3qgRQ8hlHreQ80s8Z/d8D4DRUCfh5mMcE2JxvWUqlS5H4iHI8L
 J7fA==
X-Gm-Message-State: AOJu0YxrFu8VRaA5BjS2oy9mmIpVXmrkeksrh4I2cvX4CG7t9m5SJYt2
 K+TwPn5sfPyc7X3z8kJqA+UojAaGLaEZep66Yc+fK5otfbiWfw==
X-Google-Smtp-Source: AGHT+IGkXXz1ZZhrYwJ17d1aF5GzTmql3LiO/uS+4W4YMZDfaeKSO7LCnH+NMHHDiojMvBAVntgVeA==
X-Received: by 2002:adf:ce04:0:b0:333:4bd9:8e with SMTP id
 p4-20020adfce04000000b003334bd9008emr391520wrn.25.1704375193417; 
 Thu, 04 Jan 2024 05:33:13 -0800 (PST)
Received: from [192.168.69.100] ([176.187.194.232])
 by smtp.gmail.com with ESMTPSA id
 t18-20020a5d4612000000b003367bb8898dsm33094022wrq.66.2024.01.04.05.33.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jan 2024 05:33:13 -0800 (PST)
Message-ID: <cd41459a-b96d-4b51-bc2a-37724ccc4db1@linaro.org>
Date: Thu, 4 Jan 2024 14:33:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] tests/qtest: Add STM32L4x5 EXTI QTest testcase
Content-Language: en-US
To: =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org
References: <20231228161944.303768-1-ines.varhol@telecom-paris.fr>
 <20231228161944.303768-3-ines.varhol@telecom-paris.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231228161944.303768-3-ines.varhol@telecom-paris.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 28/12/23 17:19, Inès Varhol wrote:
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
> ---
>   tests/qtest/meson.build           |   5 +
>   tests/qtest/stm32l4x5_exti-test.c | 596 ++++++++++++++++++++++++++++++
>   2 files changed, 601 insertions(+)
>   create mode 100644 tests/qtest/stm32l4x5_exti-test.c

Once the SoC parentship fixed in based series, this patch
requires:

-- >8 --
diff --git a/tests/qtest/stm32l4x5_exti-test.c 
b/tests/qtest/stm32l4x5_exti-test.c
index 60c8297246..543199cd4d 100644
--- a/tests/qtest/stm32l4x5_exti-test.c
+++ b/tests/qtest/stm32l4x5_exti-test.c
@@ -287,4 +287,3 @@ static void test_edge_selector(void)
      /* Configure EXTI line 0 irq on rising edge */
-    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/exti",
-                     NULL, 0, 1);
+    qtest_set_irq_in(global_qtest, "/machine/soc/exti", NULL, 0, 1);
      exti_writel(EXTI_IMR1, 0x00000001);
@@ -294,4 +293,3 @@ static void test_edge_selector(void)
      /* Test that an irq is raised on rising edge only */
-    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/exti",
-                     NULL, 0, 0);
+    qtest_set_irq_in(global_qtest, "/machine/soc/exti", NULL, 0, 0);

@@ -301,4 +299,3 @@ static void test_edge_selector(void)

-    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/exti",
-                     NULL, 0, 1);
+    qtest_set_irq_in(global_qtest, "/machine/soc/exti", NULL, 0, 1);

@@ -316,4 +313,3 @@ static void test_edge_selector(void)
      /* Configure EXTI line 0 irq on falling edge */
-    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/exti",
-                     NULL, 0, 0);
+    qtest_set_irq_in(global_qtest, "/machine/soc/exti", NULL, 0, 0);
      exti_writel(EXTI_IMR1, 0x00000001);
@@ -323,4 +319,3 @@ static void test_edge_selector(void)
      /* Test that an irq is raised on falling edge only */
-    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/exti",
-                     NULL, 0, 1);
+    qtest_set_irq_in(global_qtest, "/machine/soc/exti", NULL, 0, 1);

@@ -330,4 +325,3 @@ static void test_edge_selector(void)

-    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/exti",
-                     NULL, 0, 0);
+    qtest_set_irq_in(global_qtest, "/machine/soc/exti", NULL, 0, 0);

@@ -350,4 +344,3 @@ static void test_edge_selector(void)
      /* Test that an irq is raised on rising and falling edge */
-    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/exti",
-                     NULL, 0, 1);
+    qtest_set_irq_in(global_qtest, "/machine/soc/exti", NULL, 0, 1);

@@ -357,4 +350,3 @@ static void test_edge_selector(void)

-    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/exti",
-                     NULL, 0, 0);
+    qtest_set_irq_in(global_qtest, "/machine/soc/exti", NULL, 0, 0);

@@ -377,4 +369,3 @@ static void test_edge_selector(void)
      /* Test that no irq is raised */
-    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/exti",
-                     NULL, 0, 1);
+    qtest_set_irq_in(global_qtest, "/machine/soc/exti", NULL, 0, 1);

@@ -384,4 +375,3 @@ static void test_edge_selector(void)

-    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/exti",
-                     NULL, 0, 0);
+    qtest_set_irq_in(global_qtest, "/machine/soc/exti", NULL, 0, 0);

@@ -500,4 +490,3 @@ static void test_masked_interrupt(void)
      /* Simulate rising edge from GPIO line 1 */
-    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/exti",
-                     NULL, 1, 1);
+    qtest_set_irq_in(global_qtest, "/machine/soc/exti", NULL, 1, 1);

@@ -550,4 +539,3 @@ static void test_interrupt(void)
      /* Simulate rising edge from GPIO line 1 */
-    qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/exti",
-                     NULL, 1, 1);
+    qtest_set_irq_in(global_qtest, "/machine/soc/exti", NULL, 1, 1);
---

Note you could use a helper to ease readability:

static void exti_set_irq(int num, int lvl)
{
    qtest_set_irq_in(global_qtest, "/machine/soc/exti", NULL, num, lvl);
}

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

