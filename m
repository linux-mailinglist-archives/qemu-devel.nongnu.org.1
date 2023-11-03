Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 061787E04E2
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 15:46:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyvQm-0002Vz-BM; Fri, 03 Nov 2023 10:45:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qyvQi-0002VT-K0
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 10:45:49 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qyvQV-0001H8-1f
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 10:45:47 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-1ef36a04931so1175832fac.2
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 07:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1699022731; x=1699627531; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VMp5O8NYeZuv7yu7kCEH4LKUwrIZHAcbOBwEv1GrXts=;
 b=lNwZ8y86qhB0G5QQbWvAMV1RNFyLZfLEAg4+suEuBn/TuwssXdgeN3dyIvirqfJsol
 69rIZFa4V9BBEC/fKd0zQCGtXE+AqDM1/hhwXUmgW5CiAT4eoSCdI2yD8GZJbs76YQi4
 /4H8TNEMRZcQSgXV1xqBBWUFdL+bnpkgzeAvCuwOrt7Yyr/oloz5xNI0y4qQJ6wH6Dr7
 l0xFYAgQoTxGV7EvBMoogmm00r69FCeGtpJs4zoSg/xIrZgGYoRpQCuqMUyNQBv6VZHM
 rBTpfLq7oyNAZwoFEBrrLvGae0MdDAw/LfW5k5uNh9gJfT5im3cUxoHcmxV6TiyIelnb
 ktZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699022731; x=1699627531;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VMp5O8NYeZuv7yu7kCEH4LKUwrIZHAcbOBwEv1GrXts=;
 b=X6OSQyEVfwPstHVjK/O/S/pM3EAPtzZGUUQPfTJKSC0cY6DNlUhxObn3rU/SEFbV1D
 oJ9xOM5Lx/BZhhrBr8YYVKR9u28/Vk2o2cxvymGPjr6Hxi2tifsCsTug669zcxNDT/X9
 Y5fRE28Wwc7hX1NbEk4S8DAkecBVnnzrkoNoQGNYHcAix27UE6onFw4LE5EwGoboD8B7
 71ChHOLSBe28TA428pJ/TsGJdeZ5mokXYXb9dwg3InAITT2K+rS1q03R1AqgxRNJ29gM
 /LbJ/OSFfmXKgCMvK4l9sxeFov6Lh1HX7fBNlFZaBjYP3Vo82MHr5awM7ZhorRtC50LO
 uFrg==
X-Gm-Message-State: AOJu0Yyg8YksvpQP8JCP0RvMElAuICNeWVaFn0HUXwXzU0UaiqGkK9S7
 W7j3hfaM5+/FSRoHUIn6nOuPUw==
X-Google-Smtp-Source: AGHT+IH5+iPi3LmnlwgvBHY77b4ZSaCUZfktnc83OkyRJLCTs8Y31cLtZ+EPGpnyYwqZkdf2+IALtg==
X-Received: by 2002:a05:6871:7412:b0:1f0:597d:fe30 with SMTP id
 nw18-20020a056871741200b001f0597dfe30mr4883675oac.44.1699022730468; 
 Fri, 03 Nov 2023 07:45:30 -0700 (PDT)
Received: from [192.168.68.107] ([179.193.10.161])
 by smtp.gmail.com with ESMTPSA id
 fc10-20020a05690c314a00b005ad586d2691sm983912ywb.43.2023.11.03.07.45.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Nov 2023 07:45:30 -0700 (PDT)
Message-ID: <1bb44d7c-ddff-4c51-95fb-86d525b6c65d@ventanamicro.com>
Date: Fri, 3 Nov 2023 11:45:25 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] hw/ppc/e500: Pass array of CPUs as array of
 canonical QOM paths
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Luc Michel <luc.michel@amd.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Bernhard Beschow <shentey@gmail.com>, qemu-ppc@nongnu.org,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>
References: <20231030143957.82988-1-philmd@linaro.org>
 <81265616-df2d-460c-aea5-0af04b15cd8b@ventanamicro.com>
 <53bb2246-201c-a0c2-e109-fca6d536d4af@linaro.org>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <53bb2246-201c-a0c2-e109-fca6d536d4af@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x36.google.com
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



On 11/2/23 04:49, Philippe Mathieu-Daudé wrote:
> Hi Daniel,
> 
> On 31/10/23 22:49, Daniel Henrique Barboza wrote:
>> On 10/30/23 11:39, Philippe Mathieu-Daudé wrote:
>>> Following the discussion with Peter on my "cpus: Step toward
>>> removing global 'first_cpu'" series [*], we now pass the array
>>> of CPUs via property. Since we can not pass array of "link"
>>> properties, we pass the QOM path of each CPU as a QList(String).
>>>
>>> Tagged as RFC to discuss the idea of using qdev_prop_set_array
>>> with qlist_append_str(object_get_canonical_path). Personally I
>>> find it super simple.
>>
>> I probably misunderstood the concept/problem but "super simple" is not the first
>> thing that came to my mind in patch 5 hehe
>>
>> I didn't follow the whole thread, just the [*] message marked and a couple
>> of replies, but are we planning to deprecate qemu_get_cpu()? Patch 5 mentions
>> "Devices should avoid calling qemu_get_cpu() because this call doesn't work
>> as expected with heterogeneous machines". I'll take your word for it. But
>> e500 isn't an heterogeneous machine - we're creating ppc cpus only. So I'm
>> a bit confused here. Are you using e500 just as a simple PoC?
> 
> I'm using the e500 as the simplest complex device using qemu_get_cpu :)

Fair enough :D

> 
> Indeed, in [*] Peter said not all qemu_get_cpu() calls are harmful. In
> particular in homogeneous machines.
> 
> Looking back at the e500, the problem isn't the *machine*, but a device
> it is using.
> 
> Taking "dynamic machines" as a step toward "heterogeneous machines",
> I'm considering all devices potentially creatable dynamically, again
> potentially ending being use in some heterogeneous prototype. So I'd
> rather have all devices using the same API without worrying whether
> the device is designed for heterogeneous machine or not. The simplest
> way I found to achieve that, is to restrict qemu_get_cpu() to accel/
> and system/ -- where a vCPU arch is irrelevant --, but prohibit it for
> hw/ files. Maybe I'm wrong and this isn't the best way to go, which is
> why I tried this RFC, expecting constructive comments like yours, thanks
> for that!

Thanks for the clarification! Let's see what the QOM experts have to say
about it.



Thanks,

Daniel

> 
>> Regardless of the reason to use e500 in this RFC, I believe we would benefit
>> from having common helpers/magic sauce macros to add all this apparently
>> boilerplate code to replace qemu_get_cpu().
>>
>> I mean, we're changing this:
>>
>> -    cpu = qemu_get_cpu(env_idx);
>> -    if (cpu == NULL) {
>> -        /* Unknown CPU */
>> -        return;
>> -    }
>> -
>>
>> For a lot of QOM stuff like this:
>>
>>
>> +        cpu_qompath = object_get_canonical_path(OBJECT(cs));
>> +        qlist_append_str(spin_cpu_list, cpu_qompath);
>> +    qdev_prop_set_array(dev, "cpus-qom-path", spin_cpu_list);
>>
>>
>> +    if (s->cpu_count == 0) {
>> +        error_setg(errp, "'cpus-qom-path' property array must be set");
>> +        return;
>> +    } else if (s->cpu_count > MAX_CPUS) {
>> +        error_setg(errp, "at most %d CPUs are supported", MAX_CPUS);
>> +        return;
>> +    }
>> +
>> +    s->cpu = g_new(CPUState *, s->cpu_count);
>> +    for (unsigned i = 0; i < s->cpu_count; i++) {
>> +        bool ambiguous;
>> +        Object *obj;
>> +
>> +        obj = object_resolve_path(s->cpu_canonical_path[i], &ambiguous);
>> +        assert(!ambiguous);
>> +        s->cpu[i] = CPU(obj);
>> +    }
>> +
>> +static Property ppce500_spin_properties[] = {
>> +    DEFINE_PROP_ARRAY("cpus-qom-path", SpinState, cpu_count,
>> +                      cpu_canonical_path, qdev_prop_string, char *),
>> +    DEFINE_PROP_END_OF_LIST(),
>> +};
>> +
>>
>> So anything that makes the QOM stuff more palatable to deal with would be
>> really appreciated. Thanks,
> 
> Yeah, I'll see what I can do here. But first I'd like some feedback
> from QOM experts on whether using QOM canonical path is good or not.
> 
> Markus, Paolo (which I forgot to Cc...)?
> 
>> Daniel
>>
>>>
>>> Regards,
>>>
>>> Phil.
>>>
>>> [*] https://lore.kernel.org/qemu-devel/CAFEAcA9FT+QMyQSLCeLjd7tEfaoS9JazmkYWQE++s1AmF7Nfvw@mail.gmail.com/
>>>
>>> Kevin Wolf (1):
>>>    qdev: Add qdev_prop_set_array()
>>>
>>> Philippe Mathieu-Daudé (4):
>>>    hw/ppc/e500: Declare CPU QOM types using DEFINE_TYPES() macro
>>>    hw/ppc/e500: QOM-attach CPUs to the machine container
>>>    hw/ppc/e500: Inline sysbus_create_simple(E500_SPIN)
>>>    hw/ppc/e500: Pass array of CPUs as array of canonical QOM paths
>>>
>>>   include/hw/qdev-properties.h |  3 ++
>>>   hw/core/qdev-properties.c    | 21 +++++++++++
>>>   hw/ppc/e500.c                | 11 +++++-
>>>   hw/ppc/ppce500_spin.c        | 69 ++++++++++++++++++++++++++----------
>>>   4 files changed, 84 insertions(+), 20 deletions(-)
>>>
> 

