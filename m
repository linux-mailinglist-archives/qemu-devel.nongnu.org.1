Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 684A0828C57
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 19:18:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNGfM-000715-6D; Tue, 09 Jan 2024 13:17:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNGf8-0006xE-UH
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 13:17:19 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNGf5-0007oJ-4i
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 13:17:17 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40e461c1f44so27040175e9.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 10:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704824232; x=1705429032; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Im1zlbdxa9TddRVz/6Jix3LDtFJyt0kZS2LzdsZk3es=;
 b=ry/N/kdhFA0Fby6FimNKjSkn39oTkmhQHWKcaLaSG3aFjO0VJaPDwBgjUQqnYbYyyZ
 PuAgoekPGwMie2Km+htvXnXP+bcj5cLabz3TgDIkpDa+7Nku4R2UUMfYvdfuQKNarIRw
 IEWaPS4lw2plpEz981QhZjDEvQag3WwD9Xu64e1FiyG//K0pSVW/vuJvyE2tNFXZczmh
 VJ4I/w28aPbOLVjGhh56itnEcZbYRTpthrgma9g6Ok2UiwJ4vq/dJqpBzIVQ0IA81VNx
 nIe2HxWviN1TbIC5vbmM0GBXxVFglrfgGGPea4CR297q0Gne0impNxrpHcQeSnBAKRDw
 VqHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704824232; x=1705429032;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Im1zlbdxa9TddRVz/6Jix3LDtFJyt0kZS2LzdsZk3es=;
 b=HRzSKz8VgnLiXLNQ8GJVQAr6jDARTUb+9hLGg0SG9Xh2U3+4ha/uG1j1ANJlX1adXa
 1g/NWfvtqUCOXFLlXXdLRgmi2/0sGNq4Cs9SAPwpErtQn4IIkM/xVkWdf0f/RYpcyUMO
 okRhhq9LmN1JIfdl+XYNwn95F9CoNzdlW11ziHAYSLaVuorHXfLhBavEpiKpRBNdVaHR
 v/qn0Wf/ACn46xd/ji2NFhJbQDERJQi6UVylEr471yMMfSjAbrSh2IFEr0vl3VHA+mc1
 XqQetIa8kqO6ACHX9rdK4tMrkq7o1cFTIxKK0KkBQ/sFSapi+kH+pSd2dKh2i+2H8Vk3
 leDA==
X-Gm-Message-State: AOJu0YxSruvJlo7mACGIYKxGocsIulqEcvOJztNrsC1u1pIFskhahARC
 U8hpMyifzkPHII9mrEmw1cvpqYzVqIlQv1PTYt5ppOekAydsFQ==
X-Google-Smtp-Source: AGHT+IE/67O/UX7j9V7C3AlbRGgZf9I0XmwLn5yB0vHa5Nh8BvHgWG1d9aiVabyT2d0U7VbWMHrPew==
X-Received: by 2002:a05:600c:3d1b:b0:40e:45a3:bf6d with SMTP id
 bh27-20020a05600c3d1b00b0040e45a3bf6dmr2003989wmb.90.1704824231828; 
 Tue, 09 Jan 2024 10:17:11 -0800 (PST)
Received: from [192.168.69.100] (rsa59-h02-176-184-32-47.dsl.sta.abo.bbox.fr.
 [176.184.32.47]) by smtp.gmail.com with ESMTPSA id
 j40-20020a05600c1c2800b0040e451fd602sm9533800wms.33.2024.01.09.10.17.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jan 2024 10:17:11 -0800 (PST)
Message-ID: <102e3be3-a574-4095-a6fa-7d23e7b0b0bc@linaro.org>
Date: Tue, 9 Jan 2024 19:17:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/14] hw/arm: Prefer arm_feature(EL3) over
 object_property_find(has_el3)
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
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
 <2fccc023-c10d-4d66-8f3a-9e119dd29ffe@linaro.org>
In-Reply-To: <2fccc023-c10d-4d66-8f3a-9e119dd29ffe@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 9/1/24 19:13, Philippe Mathieu-Daudé wrote:
> On 9/1/24 19:09, Philippe Mathieu-Daudé wrote:
>> The "has_el3" property is added to ARMCPU when the
>> ARM_FEATURE_EL3 feature is available. Rather than
>> checking whether the QOM property is present, directly
>> check the feature.
>>
>> Suggested-by: Markus Armbruster <armbru@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/arm/exynos4210.c   |  4 ++--
>>   hw/arm/integratorcp.c |  5 ++---
>>   hw/arm/realview.c     |  2 +-
>>   hw/arm/versatilepb.c  |  5 ++---
>>   hw/arm/xilinx_zynq.c  |  2 +-
>>   hw/cpu/a15mpcore.c    | 11 +++++++----
>>   hw/cpu/a9mpcore.c     |  6 +++---
>>   7 files changed, 18 insertions(+), 17 deletions(-)
> 
> 
>> diff --git a/hw/cpu/a9mpcore.c b/hw/cpu/a9mpcore.c
>> index d03f57e579..9355e8443b 100644
>> --- a/hw/cpu/a9mpcore.c
>> +++ b/hw/cpu/a9mpcore.c
>> @@ -52,7 +52,6 @@ static void a9mp_priv_realize(DeviceState *dev, 
>> Error **errp)
>>       SysBusDevice *scubusdev, *gicbusdev, *gtimerbusdev, *mptimerbusdev,
>>                    *wdtbusdev;
>>       int i;
>> -    bool has_el3;
>>       CPUState *cpu0;
>>       Object *cpuobj;
>> @@ -81,9 +80,10 @@ static void a9mp_priv_realize(DeviceState *dev, 
>> Error **errp)
>>       /* Make the GIC's TZ support match the CPUs. We assume that
>>        * either all the CPUs have TZ, or none do.
>>        */
>> -    has_el3 = object_property_find(cpuobj, "has_el3") &&
>> +    if (arm_feature(cpu_env(cpu0), ARM_FEATURE_EL3)) {
>>           object_property_get_bool(cpuobj, "has_el3", &error_abort);
> 
> Oops, something is wrong here...

This should be:

-- >8 --
@@ -84,3 +83,5 @@ static void a9mp_priv_realize(DeviceState *dev, Error 
**errp)
-    has_el3 = object_property_find(cpuobj, "has_el3") &&
-        object_property_get_bool(cpuobj, "has_el3", &error_abort);
-    qdev_prop_set_bit(gicdev, "has-security-extensions", has_el3);
+    if (arm_feature(cpu_env(cpu0), ARM_FEATURE_EL3)) {
+        qdev_prop_set_bit(gicdev, "has-security-extensions",
+                          object_property_get_bool(cpuobj, "has_el3",
+                                                   &error_abort));
+    }
---

>> -    qdev_prop_set_bit(gicdev, "has-security-extensions", has_el3);
>> +        qdev_prop_set_bit(gicdev, "has-security-extensions", true);
>> +    }
>>       if (!sysbus_realize(SYS_BUS_DEVICE(&s->gic), errp)) {
>>           return;
> 


