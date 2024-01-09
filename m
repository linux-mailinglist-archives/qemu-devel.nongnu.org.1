Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDFC828C42
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 19:13:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNGba-0004F4-1D; Tue, 09 Jan 2024 13:13:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNGbR-0004De-1f
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 13:13:30 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNGbO-0005iB-Nc
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 13:13:28 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40e54b2e437so605295e9.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 10:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704824005; x=1705428805; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5/858XesEX8oNeaCZG/kMKhZLCv5GHmvQ3J4ODyOadM=;
 b=OaxPlRkDkH+bZ2axOJ2BxKfsRp61oxjjgSm5oeUiyFHknx2z4F1Wvuj0COPBDGS0Ab
 OYlytKVjywzmqFW0DH3I/vsM/SsVDS31gPxew86knRqrZP+sU8DXLFosGQpB1TO0g1me
 ryXVskzmepD9r/CgzRi5sfHrDUCHYbztsy61riQvEB8R469/YjmRrcy4hk8yJiBSEvhS
 c3IJMDnX1kglw+IpoRB97eDh1Yi21H4NzSx00dCxExJwHigVPPTfxs0EbPC8QFBhT0Lq
 1rJaKbdUdIZQEg5uVFGjiyJW4wPKc6AH9RQN2ztnEtn01OyBG053YSfoWtzjyWpkKXnw
 qIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704824005; x=1705428805;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5/858XesEX8oNeaCZG/kMKhZLCv5GHmvQ3J4ODyOadM=;
 b=UqQ9+hJEBBLa+0rNdPsGvbiYXOFrBZMhfYCmhjqTl+YgAGNqR7EnlmGJ32OdJIGu5j
 nBWM4ir5S9G0Dp0UNM5iUH6PakayY+kWMV1/P6A5I9XirZQPZyF0Dj8Rll5s45XQgh0g
 dn3IHnjgO0s5zqxVhnd5wlZByi0H8YOU64+0d0f4YMgLxe7TplCviZ2S2n7G7yD2h8Uo
 xoSqxZjXS/E0bkTTQ6IRzda45ykLSkg7fdUyjgjRx7NAXeaPJ/fnVgqtaNMDlKPF7Jij
 WHoP6EAn8h1LKHk3w4Vu1HxuZ60nBfrhOFwMXt7E+dmbYYPBjWJCdg8lcUeuKcFeIiiu
 nvTA==
X-Gm-Message-State: AOJu0Yw4yAUgSa2a0dgXenuFoh1Aq+VQIB0JRMfkz9icq8WyUIN0j9SA
 NCWpa9XauT7X5ljZwyYsjYS/H72k+MoSkJ9F7qRUseb7UwTZ4g==
X-Google-Smtp-Source: AGHT+IGGLSiLqo35JZYqB7Fm4mO4NgbXxAnLphPDLsnl8mWyvKIgsiS30GuPBQ6YFSlnW00RpWev/A==
X-Received: by 2002:a05:600c:4ecc:b0:40e:49b9:98e8 with SMTP id
 g12-20020a05600c4ecc00b0040e49b998e8mr1418871wmq.89.1704824004991; 
 Tue, 09 Jan 2024 10:13:24 -0800 (PST)
Received: from [192.168.69.100] (rsa59-h02-176-184-32-47.dsl.sta.abo.bbox.fr.
 [176.184.32.47]) by smtp.gmail.com with ESMTPSA id
 n10-20020a5d420a000000b0033719111458sm2987751wrq.36.2024.01.09.10.13.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jan 2024 10:13:24 -0800 (PST)
Message-ID: <2fccc023-c10d-4d66-8f3a-9e119dd29ffe@linaro.org>
Date: Tue, 9 Jan 2024 19:13:22 +0100
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
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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


> diff --git a/hw/cpu/a9mpcore.c b/hw/cpu/a9mpcore.c
> index d03f57e579..9355e8443b 100644
> --- a/hw/cpu/a9mpcore.c
> +++ b/hw/cpu/a9mpcore.c
> @@ -52,7 +52,6 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
>       SysBusDevice *scubusdev, *gicbusdev, *gtimerbusdev, *mptimerbusdev,
>                    *wdtbusdev;
>       int i;
> -    bool has_el3;
>       CPUState *cpu0;
>       Object *cpuobj;
>   
> @@ -81,9 +80,10 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
>       /* Make the GIC's TZ support match the CPUs. We assume that
>        * either all the CPUs have TZ, or none do.
>        */
> -    has_el3 = object_property_find(cpuobj, "has_el3") &&
> +    if (arm_feature(cpu_env(cpu0), ARM_FEATURE_EL3)) {
>           object_property_get_bool(cpuobj, "has_el3", &error_abort);

Oops, something is wrong here...

> -    qdev_prop_set_bit(gicdev, "has-security-extensions", has_el3);
> +        qdev_prop_set_bit(gicdev, "has-security-extensions", true);
> +    }
>   
>       if (!sysbus_realize(SYS_BUS_DEVICE(&s->gic), errp)) {
>           return;


