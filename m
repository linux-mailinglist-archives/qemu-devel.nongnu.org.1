Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 200517BF652
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 10:44:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq8Jx-0003D7-AY; Tue, 10 Oct 2023 04:42:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qq8Jr-0003CT-NC
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 04:42:23 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qq8Jm-0007gv-Ft
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 04:42:23 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4064876e8b8so52699115e9.0
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 01:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696927336; x=1697532136; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RiU0XrcaKel4UmncohJSLXbhs5Ek+d4oP0hUwEWnQKQ=;
 b=wvQM5BBzK6sZAs9x4q8BqoyAYzsyi7K8xVzQwWVtQCQIqLEw/OYwzNEWc4PxnvOLu0
 7GL6xHxyzfFTeTyK96neQMxhyDu4Ub7VvPon2JV/uqgKCVDP7J65kCIEgWntK+234Cn3
 9uFh6eGuAphUX2t9yU3FUEMsObXdY67/bFO0cSs5OdO/l2GJlLpGkJFb2LN3qYEAmOVr
 yZNWouAO05daVNsdXBgtVmhw+MqHA+57XQ/6uXJzDhbVbPxf50H2YCS1v4+gHbqGl1Gh
 40e0HPXTkmRB4F1FKozAcxPNyIgSifexE5yhY1x26M/TyYIW9qDKQSfb4U+T6rPoXgLw
 Mgow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696927336; x=1697532136;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RiU0XrcaKel4UmncohJSLXbhs5Ek+d4oP0hUwEWnQKQ=;
 b=YoU8QG2Bbrx/6QmVNFbjNUfVjokb+pX4xEJAtZUG8QhkFDFPPluQlQ5jlirxcr1QN8
 B2zOAoQyzA1Ku4QWETKrtuGD4omM31XWTZuJXPe1aYT31po1FoxOv5fmjgHHr0Ss5b1l
 3skk+hDU1IdNqCucE/pmat5G62dmftisSn7lehI3zaKvhENGeSTWG2TExUQdXidIlZbQ
 lWLBrEaM/wCQPtwDsP7PcMBBcHub0kd4UvCzbfUK0bzQo68jmbX+l+d1OLbPFgcetgke
 NS8BEn1bnUcergm7ZzT8x4RZKBW2lU3PW+6GCrkuYhFrXRxHVclVT8GL9D+6VdLFOCMx
 ITAQ==
X-Gm-Message-State: AOJu0YxtWOIHFGGJcbPTbi8kG3e/KzICMshKZW1uuiWjkANoLBfKwvS9
 afTc7+RzgcSjDKIZysa45Ved/rA15LpBiSPgxbSpLQ==
X-Google-Smtp-Source: AGHT+IEHKoCRKZDaipy/Sqys90c8HPqcuBUykYzNKGBebJvKIr80UUbFwsIWk1wie57rP4hVeKxVOg==
X-Received: by 2002:a7b:c45a:0:b0:403:e21:1355 with SMTP id
 l26-20020a7bc45a000000b004030e211355mr14670702wmi.36.1696927336477; 
 Tue, 10 Oct 2023 01:42:16 -0700 (PDT)
Received: from [192.168.69.115]
 (aif79-h01-176-172-113-148.dsl.sta.abo.bbox.fr. [176.172.113.148])
 by smtp.gmail.com with ESMTPSA id
 t15-20020a7bc3cf000000b00401e32b25adsm13554901wmj.4.2023.10.10.01.42.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 01:42:15 -0700 (PDT)
Message-ID: <c3b6a3a6-a320-f2f5-c200-da5b11e18c86@linaro.org>
Date: Tue, 10 Oct 2023 10:42:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 3/4] tests/libqtest: Introduce qtest_get_base_arch()
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, qemu-block@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>
References: <20231010074952.79165-1-philmd@linaro.org>
 <20231010074952.79165-4-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231010074952.79165-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/10/23 09:49, Philippe Mathieu-Daudé wrote:
> While qtest_get_arch() returns the target architecture name,
> such "i386" or "x86_64", qtest_get_base_arch() return the
> "base" (or real underlying) architecture, in this example
> that is "x86".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tests/qtest/libqtest.h |  7 +++++++
>   tests/qtest/libqtest.c | 28 ++++++++++++++++++++++++++++
>   2 files changed, 35 insertions(+)
> 
> diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
> index 1e1b42241d..54071e74ec 100644
> --- a/tests/qtest/libqtest.h
> +++ b/tests/qtest/libqtest.h
> @@ -654,6 +654,13 @@ bool qtest_big_endian(QTestState *s);
>    */
>   const char *qtest_get_arch(void);
>   
> +/**
> + * qtest_get_base_arch:
> + *
> + * Returns: The base architecture for the QEMU executable under test.
> + */
> +const char *qtest_get_base_arch(void);
> +
>   /**
>    * qtest_get_arch_bits:
>    *
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index a643a6309c..51cc92af21 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -925,6 +925,34 @@ const char *qtest_get_arch(void)
>       return end + 1;
>   }
>   
> +const char *qtest_get_base_arch(void)
> +{
> +    static const struct {
> +        const char *const arch;
> +        const char *const base;
> +    } basearch[] = {
> +        { "aarch64", "arm" },
> +        { "i386", "x86" },
> +        { "loongarch64", "loongarch" },
> +        { "mipsel", "mips" },
> +        { "mips64", "mips" },
> +        { "mips64el", "mips" },
> +        { "ppc64", "ppc" },
> +        { "riscv32", "riscv" },
> +        { "riscv64", "riscv" },
> +        { "sparc64", "sparc" },
> +        { "x86_64", "x86" },
> +    };
> +    const char *arch = qtest_get_arch();
> +
> +    for (unsigned i = 0; i < ARRAY_SIZE(basearch); i++) {
> +        if (!strcmp(arch, basearch[i].arch)) {
> +            return basearch[i].base;
> +        }
> +    }
> +    g_assert_not_reached();

Sorry, I forgot to commit this change:

-- >8 --
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -950,7 +950,8 @@ const char *qtest_get_base_arch(void)
              return basearch[i].base;
          }
      }
-    g_assert_not_reached();
+
+    return arch;
  }

---

> +}
> +
>   unsigned qtest_get_arch_bits(void)
>   {
>       static const char *const arch64[] = {


