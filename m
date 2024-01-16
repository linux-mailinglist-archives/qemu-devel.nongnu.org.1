Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2978E82F25B
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 17:26:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPmG7-0001ZH-CU; Tue, 16 Jan 2024 11:25:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPmG6-0001Z0-3K
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 11:25:50 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPmG4-0002WD-BY
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 11:25:49 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40e857ce803so7426055e9.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 08:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705422346; x=1706027146; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Sb8ewZWwHpfNyDhnqAuVoxp7WG7jOe/slKL1LcWRMgA=;
 b=zxOMuijY92OndJTcB0wQzIasE1uKoa1x0oPJL+iaJL/cpBlKUhUViJHuVTG+iNXsTD
 6kUWMXvkljq9Ecbq9Yo8Xwxhl555jMkS6L0B8YnvA+JiRU6mHGdmFmMbUh95XD49ENUz
 OvrAR0p02aTjlmnPO2qPVlVhE7tqgm4rcAnmhK7HpGbVjFq5CVXIIjFcRbE+TZBWL7cO
 a6DejvWHXR3Tg0lszNVDu1v3Sw0X7mWAvxIcd7+ndWebXKH+xbpCu/mIX+hRz6qfZee4
 o27dudSpBckmq13oIHtX4IfKsFML+d8q5B2bg4peJZpxL7/Dz8ZV3nNKdueRiKd7bOFq
 C8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705422346; x=1706027146;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Sb8ewZWwHpfNyDhnqAuVoxp7WG7jOe/slKL1LcWRMgA=;
 b=LxlFG1Kg9xgJZMAJJJXuFzTfQ37pmIwpa9VFYB/M/x4E/51emwYK/hsZvTLRf2sUAA
 XnkP7gX012eMgI+vHoCwh5G4AeDIrLJ9X/2URF8tOgcjLq7t4tF31gGQxnlyh6PEmDAG
 +WmbUJy0Q0Ma7FmCTp7ZezFLgDdTCgD2oMzUWPzkgdH+cqkjVZ1nESzibHA1mhLQugci
 Peeq910WIAcFp8THYZKT95d4uYv9/7W7Iz2dPVXRBtmON8JMUFmdoaI30zA5zHKemyVy
 0VvvFKfWBaXSKBahHSdhar2HXZddeTvWZQ7r/GiJRCWvBbiWaPT9U8uKJ03Nrp/LVjGv
 E5EQ==
X-Gm-Message-State: AOJu0YwrUX+Tp+PKEUO6ZAqH1S2hojjozpYr9jlwgazobSxrBYrMVYio
 YKD2VtMTZPJV0FXBSItsMQbtkFF7hJ7u5A==
X-Google-Smtp-Source: AGHT+IEd9iSQRr5FpCis06jN1hSBln9tMu7sGM83eRoAmH6A1XUDsRO3hLrvkGmIeRagMBTD2XPoSw==
X-Received: by 2002:a05:600c:5398:b0:40e:62b1:58a5 with SMTP id
 hg24-20020a05600c539800b0040e62b158a5mr3902845wmb.15.1705422346579; 
 Tue, 16 Jan 2024 08:25:46 -0800 (PST)
Received: from [192.168.1.102] ([176.176.156.199])
 by smtp.gmail.com with ESMTPSA id
 q14-20020a1709060f8e00b00a2a61b9c166sm6639819ejj.33.2024.01.16.08.25.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jan 2024 08:25:46 -0800 (PST)
Message-ID: <501c1bfe-fb26-42ab-a925-9888755c72ad@linaro.org>
Date: Tue, 16 Jan 2024 17:25:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/33] hw/cpu/arm: Handle 'has_el2/3' properties once in
 MPCore parent
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tyrone Ting <kfting@nuvoton.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Anton Johansson <anjo@rev.ng>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Hao Wu <wuhaotsh@google.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Rob Herring <robh@kernel.org>,
 qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20231212162935.42910-1-philmd@linaro.org>
 <20231212162935.42910-15-philmd@linaro.org> <87y1cudyp2.fsf@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87y1cudyp2.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 12/1/24 22:33, Fabiano Rosas wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> Move the 'has_el2' and 'has_el3' properties to the abstract
>> QOM parent.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/hw/cpu/cortex_mpcore.h |  5 +++++
>>   hw/arm/exynos4210.c            | 10 ++++++++--
>>   hw/arm/vexpress.c              |  6 ++++++
>>   hw/arm/xilinx_zynq.c           |  6 ++++++
>>   hw/cpu/a15mpcore.c             | 18 ++++++------------
>>   hw/cpu/a9mpcore.c              |  5 +----
>>   hw/cpu/cortex_mpcore.c         |  3 +++
>>   7 files changed, 35 insertions(+), 18 deletions(-)
>>
>> diff --git a/include/hw/cpu/cortex_mpcore.h b/include/hw/cpu/cortex_mpcore.h
>> index 0e7cca9e93..387552468c 100644
>> --- a/include/hw/cpu/cortex_mpcore.h
>> +++ b/include/hw/cpu/cortex_mpcore.h
>> @@ -30,6 +30,8 @@
>>    * QEMU interface:
>>    *  + QOM property "num-cores" which set the number of cores present in
>>    *    the cluster.
>> + *  + QOM properties "cpu-has-el3", "cpu-has-el2" which set whether the CPUs
>> + *    have the exception level features present.
>>    */
>>   #define TYPE_CORTEX_MPCORE_PRIV "cortex_mpcore_priv"
>>   OBJECT_DECLARE_TYPE(CortexMPPrivState, CortexMPPrivClass, CORTEX_MPCORE_PRIV)
>> @@ -53,6 +55,9 @@ struct CortexMPPrivState {
>>   
>>       /* Properties */
>>       uint32_t num_cores;
>> +
>> +    bool cpu_has_el3;
>> +    bool cpu_has_el2;
>>   };


>> diff --git a/hw/cpu/a9mpcore.c b/hw/cpu/a9mpcore.c
>> index 9c138f4442..54949314f8 100644
>> --- a/hw/cpu/a9mpcore.c
>> +++ b/hw/cpu/a9mpcore.c
>> @@ -51,7 +51,6 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
>>       SysBusDevice *scubusdev, *gicbusdev, *gtimerbusdev, *mptimerbusdev,
>>                    *wdtbusdev;
>>       Error *local_err = NULL;
>> -    bool has_el3;
>>       CPUState *cpu0;
>>       Object *cpuobj;
>>   
>> @@ -86,9 +85,7 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
>>       /* Make the GIC's TZ support match the CPUs. We assume that
>>        * either all the CPUs have TZ, or none do.
>>        */
>> -    has_el3 = object_property_find(cpuobj, "has_el3") &&
>> -        object_property_get_bool(cpuobj, "has_el3", &error_abort);
>> -    qdev_prop_set_bit(gicdev, "has-security-extensions", has_el3);
>> +    qdev_prop_set_bit(gicdev, "has-security-extensions", c->cpu_has_el3);
>>   
>>       if (!sysbus_realize(SYS_BUS_DEVICE(&s->gic), errp)) {
>>           return;
>> diff --git a/hw/cpu/cortex_mpcore.c b/hw/cpu/cortex_mpcore.c
>> index d7ea633e4e..549b81f708 100644
>> --- a/hw/cpu/cortex_mpcore.c
>> +++ b/hw/cpu/cortex_mpcore.c
>> @@ -27,6 +27,9 @@ static Property cortex_mpcore_priv_properties[] = {
>>       DEFINE_PROP_UINT32("num-cores", CortexMPPrivState, num_cores, 1),
>>       DEFINE_PROP_UINT32("num-cpu", CortexMPPrivState, num_cores, 1), /* alias */
>>   
>> +    DEFINE_PROP_BOOL("cpu-has-el3", CortexMPPrivState, cpu_has_el3, true),
>> +    DEFINE_PROP_BOOL("cpu-has-el2", CortexMPPrivState, cpu_has_el2, false),
> 
> Are we missing setting cpu_has_el2 somewhere else? This^ results in fewer
> cpregs being registered and is what breaks migration.
> 
> You can test with:
> 
> $ (echo "migrate file:migfile"; echo "quit") | ./qemu-system-arm -M ast2600-evb -monitor stdio
> $ ./scripts/analyze-migration.py -f migfile | grep array_len
> 
> Before series:
> $ ./scripts/analyze-migration.py -f migfile | grep array_len
>          "cpreg_vmstate_array_len": "0x0000010a",
>          "cpreg_vmstate_array_len": "0x0000010a",
> 
> After series:
> $ ./scripts/analyze-migration.py -f migfile | grep array_len
>          "cpreg_vmstate_array_len": "0x000000df",
>          "cpreg_vmstate_array_len": "0x000000df",

Thank you Fabiano for helping debugging. Indeed there is a problem
with properties, so this patch is bogus.

The good news is the QOM reparenting happened 2 commits earlier,
so this discarded the doubts on qom-path change possibly affecting
migration :)

Regards,

Phil.

