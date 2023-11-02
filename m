Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDC77DEDAE
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 08:51:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qySSj-0006es-He; Thu, 02 Nov 2023 03:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qySSh-0006eI-65
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 03:49:55 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qySSf-0001Ef-62
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 03:49:54 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9d2e6c8b542so87006666b.0
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 00:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698911391; x=1699516191; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9wKUr03FDuwzopwuwLZ/lJ+nWMcPbE/8LK3R5PkAEdI=;
 b=sZkw437cybyiyYVQz3Tz1X4KpqOffPDRTXjnvo4ZA/BRKWuizG0Vc1ffgzeJBfRZuv
 EKsTY2SLf9W2VbwyoBisdwtUGWd4B2Wcbf2SlY/+NEzZJL4WE8Dhp31d2GLfobX0A1WI
 foLTZUZUic1AKJpqhyexYgsiuDU3sNA+RuvrvT/CAflNksh1agnk9o9+XYVhj+y3mPj4
 wPPDxUpTslCi2atHihhTUbHbL124gXswvY+kWM7NYe+tWs5A9TrwuYSSacwC0EpWthY8
 bgKca3ZJomU/WfkOLQCYZ8C/Jlub8BynSkI3RHExsNLLiUphArPQB232fm04iRkMhbf/
 9vtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698911391; x=1699516191;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9wKUr03FDuwzopwuwLZ/lJ+nWMcPbE/8LK3R5PkAEdI=;
 b=PEPHlLD8PIug1rL7JnSLY8FjLMkQTfUPKzYJXJlfV8HBdwIVH8097uIDwX7pbQta9z
 YhDVD7XleBJKrly45RE0YSgNdYrWTu9nCr9t4Hf7lWmozUDSCcUrEfOiJEzxX59MDGwN
 gVc+pS9UuxrsA3VdaIHJXfnbceCxIjOBFMqvEJAp+y5B47Wpu2/5JHzn8yZaiAHmLU77
 GSI7CWunzZrlR32vs3ldk7ZmaJD/2ojoPrwv/h6YYgYHeHFhKKPGinRZj6MyWBz1cm4D
 4H348Bkq3Er2etih9CXGpWxGAK2rZpCAyL2WnGXFWoo5HXiCooBv7H6DKNH7iN0uM4ed
 UmpA==
X-Gm-Message-State: AOJu0YwtUec4dXvWhyjFJLaPAVKVO0v5cGkH5wAHBDzSiJ37kWFkX5pq
 XlO7FyrWBOJMP9yeTi8BciDZLg==
X-Google-Smtp-Source: AGHT+IFYq8uJqAVCuTCdVLYMmTDwqpFc8R5qo6DPLhN/rHoJIh49Zqs0O22U2xxEK5QFN36LBFfMcA==
X-Received: by 2002:a17:906:fd89:b0:9b9:a1dd:5105 with SMTP id
 xa9-20020a170906fd8900b009b9a1dd5105mr4231545ejb.50.1698911390928; 
 Thu, 02 Nov 2023 00:49:50 -0700 (PDT)
Received: from [192.168.69.115] (176-131-219-113.abo.bbox.fr.
 [176.131.219.113]) by smtp.gmail.com with ESMTPSA id
 q10-20020a05600c46ca00b00407efbc4361sm2008476wmo.9.2023.11.02.00.49.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Nov 2023 00:49:50 -0700 (PDT)
Message-ID: <53bb2246-201c-a0c2-e109-fca6d536d4af@linaro.org>
Date: Thu, 2 Nov 2023 08:49:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 0/5] hw/ppc/e500: Pass array of CPUs as array of
 canonical QOM paths
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Luc Michel <luc.michel@amd.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Bernhard Beschow <shentey@gmail.com>, qemu-ppc@nongnu.org,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>
References: <20231030143957.82988-1-philmd@linaro.org>
 <81265616-df2d-460c-aea5-0af04b15cd8b@ventanamicro.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <81265616-df2d-460c-aea5-0af04b15cd8b@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.777,
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

Hi Daniel,

On 31/10/23 22:49, Daniel Henrique Barboza wrote:
> On 10/30/23 11:39, Philippe Mathieu-Daudé wrote:
>> Following the discussion with Peter on my "cpus: Step toward
>> removing global 'first_cpu'" series [*], we now pass the array
>> of CPUs via property. Since we can not pass array of "link"
>> properties, we pass the QOM path of each CPU as a QList(String).
>>
>> Tagged as RFC to discuss the idea of using qdev_prop_set_array
>> with qlist_append_str(object_get_canonical_path). Personally I
>> find it super simple.
> 
> I probably misunderstood the concept/problem but "super simple" is not 
> the first
> thing that came to my mind in patch 5 hehe
> 
> I didn't follow the whole thread, just the [*] message marked and a couple
> of replies, but are we planning to deprecate qemu_get_cpu()? Patch 5 
> mentions
> "Devices should avoid calling qemu_get_cpu() because this call doesn't work
> as expected with heterogeneous machines". I'll take your word for it. But
> e500 isn't an heterogeneous machine - we're creating ppc cpus only. So I'm
> a bit confused here. Are you using e500 just as a simple PoC?

I'm using the e500 as the simplest complex device using qemu_get_cpu :)

Indeed, in [*] Peter said not all qemu_get_cpu() calls are harmful. In
particular in homogeneous machines.

Looking back at the e500, the problem isn't the *machine*, but a device
it is using.

Taking "dynamic machines" as a step toward "heterogeneous machines",
I'm considering all devices potentially creatable dynamically, again
potentially ending being use in some heterogeneous prototype. So I'd
rather have all devices using the same API without worrying whether
the device is designed for heterogeneous machine or not. The simplest
way I found to achieve that, is to restrict qemu_get_cpu() to accel/
and system/ -- where a vCPU arch is irrelevant --, but prohibit it for
hw/ files. Maybe I'm wrong and this isn't the best way to go, which is
why I tried this RFC, expecting constructive comments like yours, thanks
for that!

> Regardless of the reason to use e500 in this RFC, I believe we would 
> benefit
> from having common helpers/magic sauce macros to add all this apparently
> boilerplate code to replace qemu_get_cpu().
> 
> I mean, we're changing this:
> 
> -    cpu = qemu_get_cpu(env_idx);
> -    if (cpu == NULL) {
> -        /* Unknown CPU */
> -        return;
> -    }
> -
> 
> For a lot of QOM stuff like this:
> 
> 
> +        cpu_qompath = object_get_canonical_path(OBJECT(cs));
> +        qlist_append_str(spin_cpu_list, cpu_qompath);
> +    qdev_prop_set_array(dev, "cpus-qom-path", spin_cpu_list);
> 
> 
> +    if (s->cpu_count == 0) {
> +        error_setg(errp, "'cpus-qom-path' property array must be set");
> +        return;
> +    } else if (s->cpu_count > MAX_CPUS) {
> +        error_setg(errp, "at most %d CPUs are supported", MAX_CPUS);
> +        return;
> +    }
> +
> +    s->cpu = g_new(CPUState *, s->cpu_count);
> +    for (unsigned i = 0; i < s->cpu_count; i++) {
> +        bool ambiguous;
> +        Object *obj;
> +
> +        obj = object_resolve_path(s->cpu_canonical_path[i], &ambiguous);
> +        assert(!ambiguous);
> +        s->cpu[i] = CPU(obj);
> +    }
> +
> +static Property ppce500_spin_properties[] = {
> +    DEFINE_PROP_ARRAY("cpus-qom-path", SpinState, cpu_count,
> +                      cpu_canonical_path, qdev_prop_string, char *),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> 
> So anything that makes the QOM stuff more palatable to deal with would be
> really appreciated. Thanks,

Yeah, I'll see what I can do here. But first I'd like some feedback
from QOM experts on whether using QOM canonical path is good or not.

Markus, Paolo (which I forgot to Cc...)?

> Daniel
> 
>>
>> Regards,
>>
>> Phil.
>>
>> [*] 
>> https://lore.kernel.org/qemu-devel/CAFEAcA9FT+QMyQSLCeLjd7tEfaoS9JazmkYWQE++s1AmF7Nfvw@mail.gmail.com/
>>
>> Kevin Wolf (1):
>>    qdev: Add qdev_prop_set_array()
>>
>> Philippe Mathieu-Daudé (4):
>>    hw/ppc/e500: Declare CPU QOM types using DEFINE_TYPES() macro
>>    hw/ppc/e500: QOM-attach CPUs to the machine container
>>    hw/ppc/e500: Inline sysbus_create_simple(E500_SPIN)
>>    hw/ppc/e500: Pass array of CPUs as array of canonical QOM paths
>>
>>   include/hw/qdev-properties.h |  3 ++
>>   hw/core/qdev-properties.c    | 21 +++++++++++
>>   hw/ppc/e500.c                | 11 +++++-
>>   hw/ppc/ppce500_spin.c        | 69 ++++++++++++++++++++++++++----------
>>   4 files changed, 84 insertions(+), 20 deletions(-)
>>


