Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A2382AB9D
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 11:09:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNrzU-0001QZ-Kc; Thu, 11 Jan 2024 05:08:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNrzB-0001Pv-30
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 05:08:37 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNrz9-0001K3-FZ
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 05:08:28 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40d87df95ddso53181805e9.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 02:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704967700; x=1705572500; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hhkXnq8B80M0ydMbTVSOkTWq3ohgOslq77oKCz4Ib2s=;
 b=rZ9tVUIpyyQNn+NRUuSFslGL9K0EJEnqwX03rtIDsodm6u8VO7KKB+aQOi911OCZGJ
 uI+09Y+IayKxV4Cd47Xu86rSRONH7rIRwXWVp1dsYV+bfbHj41mU6ReuQvG4teSB70Nx
 V1nyw006ECgNrNIYFcUwlM5nvoxXl1WKLRJGhJtmCZzve1G4SIrZZi4el99aj6+nbKbE
 59WCR2d7vvpfST9PR3diytTCOjjFshm7IVV2Yh9XUa5eWBrGxFCJ3dXBosg61hG4sGSm
 8aKTGgK5sFMhRe5VPOBsvF/YMyfxiobYmvcXe2RjmJCWlmykatsuFMaxA2PPtFB8/49K
 nItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704967700; x=1705572500;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hhkXnq8B80M0ydMbTVSOkTWq3ohgOslq77oKCz4Ib2s=;
 b=a0kmfYFDNhNoTftp0xcsf6VRN9V4tnsj1fhN/64Yfxzv8M3nFiE82DYAvVQJyZnq2z
 G/PZGmHy6k4ReWclIxuoBlilGgp190Tk5eyT0Gbb2Zpq/zWkZ5Q6nwN/BV42T/3B/a3v
 nJyNH0cjgAPIG1dSYhrrcHEwsJ7IXP8xUglNr9nZ9pXFnfCo4PoO53bDAVU0kT5LV8Gz
 CWoaJVINwC/V/nV5WX43pS1vFw/ZtyHOS8mFGRnbPyuT0ujIawUg+USsDFZ93GFnHAYI
 Mb8Eu8QY30szHnUI6xnTW8tTpyvQbXncwUIiRcWPMQO7xB0PwB8HCh2mJnG9JHbG/FpJ
 akVw==
X-Gm-Message-State: AOJu0YxztSytyS1XEq1ZXheTtzgTB/XU3RzpWOp/mM3euLxWkdk8vSIC
 CcZWA9Nf+Sj8X+eeGMhPL5Jiw31Ga+vyBw==
X-Google-Smtp-Source: AGHT+IHEZQQ1nWh1etXsfTJ4jmcHGHfQnXiBL8IdJfiUhrP/YIP0O6bQXWT1aXU1ySP5+q8Bz43Epw==
X-Received: by 2002:a05:600c:354c:b0:40d:514f:7305 with SMTP id
 i12-20020a05600c354c00b0040d514f7305mr152207wmq.300.1704967700604; 
 Thu, 11 Jan 2024 02:08:20 -0800 (PST)
Received: from [192.168.207.175] (83.red-88-28-3.dynamicip.rima-tde.net.
 [88.28.3.83]) by smtp.gmail.com with ESMTPSA id
 f9-20020a05600c4e8900b0040e3960f46asm1306211wmq.14.2024.01.11.02.08.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jan 2024 02:08:20 -0800 (PST)
Message-ID: <585e091b-d75c-408c-bc19-72728ff45e6f@linaro.org>
Date: Thu, 11 Jan 2024 11:08:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/14] hw/arm: Prefer arm_feature(AARCH64) over
 object_property_find(aarch64)
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Marc Zyngier <maz@kernel.org>,
 Andrew Jones <ajones@ventanamicro.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-arm@nongnu.org,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Radoslaw Biernacki
 <rad@semihalf.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Rob Herring <robh@kernel.org>,
 Alistair Francis <alistair@alistair23.me>
References: <20240110195329.3995-1-philmd@linaro.org>
 <20240110195329.3995-14-philmd@linaro.org>
 <ff57e1f5-ea78-459e-b51c-48040483bdea@linaro.org>
 <865y009p6b.wl-maz@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <865y009p6b.wl-maz@kernel.org>
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

On 11/1/24 10:47, Marc Zyngier wrote:
> On Thu, 11 Jan 2024 09:39:18 +0000,
> Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> On 10/1/24 20:53, Philippe Mathieu-Daudé wrote:
>>> The "aarch64" property is added to ARMCPU when the
>>> ARM_FEATURE_AARCH64 feature is available. Rather than
>>> checking whether the QOM property is present, directly
>>> check the feature.
>>>
>>> Suggested-by: Markus Armbruster <armbru@redhat.com>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>    hw/arm/virt.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>>> index 49ed5309ff..a43e87874c 100644
>>> --- a/hw/arm/virt.c
>>> +++ b/hw/arm/virt.c
>>> @@ -2140,7 +2140,7 @@ static void machvirt_init(MachineState *machine)
>>>            numa_cpu_pre_plug(&possible_cpus->cpus[cs->cpu_index], DEVICE(cpuobj),
>>>                              &error_fatal);
>>>    -        aarch64 &= object_property_get_bool(cpuobj, "aarch64",
>>> NULL);
>>> +        aarch64 &= arm_feature(cpu_env(cs), ARM_FEATURE_AARCH64);
>>
>> So after this patch there are no more use of the ARMCPU "aarch64"
>> property from code. Still it is exposed via the qom-tree. Thus it
>> can be set (see aarch64_cpu_set_aarch64). I could understand one
>> flip this feature to create a custom CPU (as a big-LITTLE setup
>> as Marc mentioned on IRC), but I don't understand what is the
>> expected behavior when this is flipped at runtime. Can that
>> happen in real hardware (how could the guest react to that...)?
> 
> I don't think it makes any sense to do that while a guest is running
> (and no HW I'm aware of would do this). However, it all depends what
> you consider "run time". You could imagine creating a skeletal VM with
> all features, and then apply a bunch of changes before the guest
> actually runs.

Thanks, this makes sense and confirms my guess.

> I don't know enough about the qom-tree and dynamic manipulation of
> these properties though, and I'm likely to be wrong about the expected
> usage model.

Kevin, Markus, this seems a good example of QOM "config" property that
is RW *before* Realize and should become RO *after* it.

QDev properties has PropertyInfo::realized_set_allowed set to false by
default, but here this property is added at the QOM (lower) layer, so
there is no such check IIUC.

Should "aarch64" become a static QDev property instead (registered via
device_class_set_props -> qdev_class_add_property)?

This just an analyzed example, unfortunately there are many more...

Thanks,

Phil.

