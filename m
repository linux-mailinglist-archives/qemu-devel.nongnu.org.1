Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02426828C80
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 19:23:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNGk4-0000PS-6S; Tue, 09 Jan 2024 13:22:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNGjt-0000NR-O6
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 13:22:15 -0500
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNGjr-0001Or-K4
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 13:22:13 -0500
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-50eab4bf47aso2923245e87.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 10:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704824528; x=1705429328; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vnaDIUIfoY2hYCZsgiQ6ORd4ONxMPiat5cTnt+biCyo=;
 b=KuI9SHMgyEtfW07/WgYs/lzQZaTf3WFPIHCtc2zUjkXMzAsHdYHYjkt0I37kLSRy3E
 i7jnDw/dUuy9uS3FAXbz6DGqAIhwxwp3Izrlec/kbjdyZENbdTMHN72f95GmovIU6GBS
 RJ9hqssh+74TjXpEnIo+cQSBFu9qXZWCcgjbSm3H5WT5i7Mw7Ss1SoFyxxVHGttBQWv9
 htrB22R8qQwMVEi6d4Lm62U8tWJ58c1Lav9nCHu/aYRl4Z/tGVGX1bMv2A6Pvb57jmk2
 GbSU8zCPowmiiS+Zz145pBsjBoxs3NSDT4ivGT0XrFkOuJW0b3tb+bfhxaLgk32nGRH8
 b54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704824528; x=1705429328;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vnaDIUIfoY2hYCZsgiQ6ORd4ONxMPiat5cTnt+biCyo=;
 b=te0/4CbPLr4ZXeOgdaFmHuofH5Ez/MlK/YIYT9QqSXpwAScvHoYLaYrePlelodiq6L
 6aDP/KGc3Ei78yoCj6ZFIfal3PpJyehib0tw9uKWP4pvqDtYw2etzRmvJfl4lcbFUV8y
 d2ONnlveDlQfmz1NrWclEU5rkagaPv6RzpgFhSgRrfMJmCnKE5qRVbBslO1SnRMOPNp0
 AlNReHqCtzdPiG18Dpgo6457LTjrduEaUd88HJ+1ff//DkrUmPStqqXyidzP7DnAFHhg
 UlO4e8Ksl4m6V3cQOQigwrUEiDgmx3kI8bS/6CU99VxnpZIfEFzZzHpzyOwlma9poPFE
 v+1w==
X-Gm-Message-State: AOJu0YyJoBeYNilXAsEYENeKSy0qW06golbb18wNBW5KQledoMtkcCla
 Su/ucOdhDS/xk4XgotqSupKhip0Bt4vOEYzFdA8I42tiHgEyow==
X-Google-Smtp-Source: AGHT+IH0X1Qq1R2tBkRAsm+nBYM29efXSYqnKue2nJe3obXJPfbLVFNziFfxi7kU4EpHwE6btty4FA==
X-Received: by 2002:a05:6512:36cc:b0:50e:59d2:aaf0 with SMTP id
 e12-20020a05651236cc00b0050e59d2aaf0mr571253lfs.10.1704824527848; 
 Tue, 09 Jan 2024 10:22:07 -0800 (PST)
Received: from [192.168.69.100] (rsa59-h02-176-184-32-47.dsl.sta.abo.bbox.fr.
 [176.184.32.47]) by smtp.gmail.com with ESMTPSA id
 o15-20020a198c0f000000b0050e7dcc05a5sm425817lfd.102.2024.01.09.10.22.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jan 2024 10:22:07 -0800 (PST)
Message-ID: <e233582b-67db-481d-90bd-bb2677ff8734@linaro.org>
Date: Tue, 9 Jan 2024 19:22:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/14] hw/arm: Prefer arm_feature(EL3) over
 object_property_find(has_el3)
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Leif Lindholm <quic_llindhol@quicinc.com>,
 Radoslaw Biernacki <rad@semihalf.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Rob Herring <robh@kernel.org>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
References: <20240109180930.90793-1-philmd@linaro.org>
 <20240109180930.90793-10-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240109180930.90793-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
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

On 9/1/24 19:09, Philippe Mathieu-Daudé wrote:
> The "has_el3" property is added to ARMCPU when the
> ARM_FEATURE_EL3 feature is available. Rather than
> checking whether the QOM property is present, directly
> check the feature.
> 
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/arm/exynos4210.c   |  4 ++--
>   hw/arm/integratorcp.c |  5 ++---
>   hw/arm/realview.c     |  2 +-
>   hw/arm/versatilepb.c  |  5 ++---
>   hw/arm/xilinx_zynq.c  |  2 +-
>   hw/cpu/a15mpcore.c    | 11 +++++++----
>   hw/cpu/a9mpcore.c     |  6 +++---
>   7 files changed, 18 insertions(+), 17 deletions(-)


> diff --git a/hw/cpu/a15mpcore.c b/hw/cpu/a15mpcore.c
> index bfd8aa5644..cebfe142cf 100644
> --- a/hw/cpu/a15mpcore.c
> +++ b/hw/cpu/a15mpcore.c
> @@ -53,7 +53,6 @@ static void a15mp_priv_realize(DeviceState *dev, Error **errp)
>       DeviceState *gicdev;
>       SysBusDevice *busdev;
>       int i;
> -    bool has_el3;
>       bool has_el2 = false;
>       Object *cpuobj;
>   
> @@ -62,13 +61,17 @@ static void a15mp_priv_realize(DeviceState *dev, Error **errp)
>       qdev_prop_set_uint32(gicdev, "num-irq", s->num_irq);
>   
>       if (!kvm_irqchip_in_kernel()) {
> +        CPUState *cpu;
> +
>           /* Make the GIC's TZ support match the CPUs. We assume that
>            * either all the CPUs have TZ, or none do.
>            */
> -        cpuobj = OBJECT(qemu_get_cpu(0));
> -        has_el3 = object_property_find(cpuobj, "has_el3") &&
> +        cpu = qemu_get_cpu(0);
> +        cpuobj = OBJECT(cpu);
> +        if (arm_feature(cpu_env(cpu), ARM_FEATURE_EL3)) {
>               object_property_get_bool(cpuobj, "has_el3", &error_abort);

This requires the same change than a9mp_priv_realize(), so squashing:

-- >8 --
          if (arm_feature(cpu_env(cpu), ARM_FEATURE_EL3)) {
-            object_property_get_bool(cpuobj, "has_el3", &error_abort);
-            qdev_prop_set_bit(gicdev, "has-security-extensions", true);
+            qdev_prop_set_bit(gicdev, "has-security-extensions",
+                              object_property_get_bool(cpuobj, "has_el3",
+                                                       &error_abort));
          }
---

> -        qdev_prop_set_bit(gicdev, "has-security-extensions", has_el3);
> +            qdev_prop_set_bit(gicdev, "has-security-extensions", true);
> +        }
>           /* Similarly for virtualization support */
>           has_el2 = object_property_find(cpuobj, "has_el2") &&
>               object_property_get_bool(cpuobj, "has_el2", &error_abort);

