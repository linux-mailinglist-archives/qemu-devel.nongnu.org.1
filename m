Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9576F811EA8
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 20:17:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDUiP-0006Dr-LO; Wed, 13 Dec 2023 14:16:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDUiL-0006DU-EJ
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 14:16:13 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDUiJ-0002lS-MX
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 14:16:13 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40c41df5577so41589495e9.0
 for <qemu-devel@nongnu.org>; Wed, 13 Dec 2023 11:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702494970; x=1703099770; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rLenTaYJHXtibSc66pUowk+tsS9QMOhm/sOD6BaK368=;
 b=sHs/wabI2WCQ8y48rgwY77qNhdx5L7f5odUqaE1S/GXpMMO4I2Vp6dDhePWb53OstC
 0j2iHmAthOFXCQGxyhGnuCe+tv4hto/xHZqagANroa2TbrxghSQEuN2jWJfH9UTO4v+r
 da7HfgB/rMv8EBK/bCnxyTowjMvy6ybGzooNMR8xfenTIhggmeEdl9dTc9Ex9JqhDsm+
 z5tZdvZLV/Wc21LTCNCj3sOpkC7dYzCTXJ0PtnL2PBe7B9qugo5mThjNlVYqPGlDEOSC
 0nTIgBfdI6mv8R8uaXCoXn55p91YrKQC9oYpst3tXEMejHPpHHlDiCCpkU97IaX1QYBQ
 2eVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702494970; x=1703099770;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rLenTaYJHXtibSc66pUowk+tsS9QMOhm/sOD6BaK368=;
 b=ay9cKG4jZjXwEZYEdMPhHTExCILgXCkETIR0ygQKs7sMDEIXjga1DdH/Oj2zeE+vF4
 Xbt52rS1MJ3sMYLje0jwHBd/SaKYmI92Ri7F5n6F05hAl7EXG8ClWBEKxvkbc+T+wOGo
 /El5bevSXMZQhtN20IPxI4VGEg41dxbY5U8pxt1SV15Re83Aj4oJwg5eWEZTaUALZSeA
 CksvIYG/yVDR0lPgsyEJd7QADUcDhA8eF96MJeQrPsT+u693SjGLH20M8Qkk1xxP/EJm
 bow2+NCt12MJbK6/M2Q+rKB9fuI8XruQ6GEWo8CpU1AYGql/KOaqOOXFvVGQHpyPQuPG
 Sfrw==
X-Gm-Message-State: AOJu0YylczV9M3RJS9jdFw9bxbO0NB5AEWl1lwb5H9ct6SNTBh3xlnHR
 VF9G1gKP8z/CrC3IzXC4zxUXNA==
X-Google-Smtp-Source: AGHT+IEPdPMv2u/eBPS432P53eksOLrWaXVYL3iVKK10JhxrhGqUkWv1DrBGQ0jTQyt7Aed1EwIPuw==
X-Received: by 2002:a7b:c7c6:0:b0:40b:5e59:f741 with SMTP id
 z6-20020a7bc7c6000000b0040b5e59f741mr2416710wmk.179.1702494969713; 
 Wed, 13 Dec 2023 11:16:09 -0800 (PST)
Received: from [192.168.1.120] (tmo-066-178.customers.d1-online.com.
 [80.187.66.178]) by smtp.gmail.com with ESMTPSA id
 fj8-20020a1709069c8800b00a1d5c342674sm8175320ejc.27.2023.12.13.11.16.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Dec 2023 11:16:09 -0800 (PST)
Message-ID: <e4ce3b41-8a40-4a30-a615-a520ae881121@linaro.org>
Date: Wed, 13 Dec 2023 20:16:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fsl-imx: Add simple RTC emulation for i.MX6 and i.MX7
 boards
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Nikita Ostrenkov <n.ostrenkov@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Andrey Smirnov <andrew.smirnov@gmail.com>
References: <20231112092232.131-1-n.ostrenkov@gmail.com>
 <CAFEAcA8A8sGjknad1QpeJ8qank-mWWw+gRvR4PVBHk2zAHrEnQ@mail.gmail.com>
 <fbab82ef-bb45-417a-932e-99089dd4d4a5@linaro.org>
 <CAFEAcA-NVrx+q6XLX02vuwD274THh5N7NJExVzvtD5zKaFa4HQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA-NVrx+q6XLX02vuwD274THh5N7NJExVzvtD5zKaFa4HQ@mail.gmail.com>
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

On 13/12/23 18:20, Peter Maydell wrote:
> On Wed, 13 Dec 2023 at 17:17, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Hi Peter,
>>
>> On 12/12/23 15:18, Peter Maydell wrote:
>>> On Sun, 12 Nov 2023 at 09:22, Nikita Ostrenkov <n.ostrenkov@gmail.com> wrote:
>>>
>>> Hi; thanks for this patch, and sorry I haven't got round
>>> to reviewing it earlier.
>>>
>>>> Signed-off-by: Nikita Ostrenkov <n.ostrenkov@gmail.com>
>>>> ---
>>>>    hw/misc/imx7_snvs.c         | 59 ++++++++++++++++++++++++++++++++-----
>>>>    hw/misc/trace-events        |  4 +--
>>>>    include/hw/misc/imx7_snvs.h | 14 ++++++++-
>>>>    3 files changed, 67 insertions(+), 10 deletions(-)
>>
>>
>>>> @@ -31,6 +33,16 @@ struct IMX7SNVSState {
>>>>        SysBusDevice parent_obj;
>>>>
>>>>        MemoryRegion mmio;
>>>> +
>>>> +    /*
>>>> +     * Needed to preserve the tick_count across migration, even if the
>>>> +     * absolute value of the rtc_clock is different on the source and
>>>> +     * destination.
>>>> +     */
>>>> +    int64_t tick_offset_vmstate;
>>>
>>> You don't need tick_offset_vmstate -- it is only in the p031
>>> RTC device as a backwards-compatibility thing for older versions
>>> of QEMU. Migrating tick_offset alone is sufficient in a new
>>> device. (It seems to have been unfortunately copied-and-pasted
>>> into the goldfish RTC device; we should probably fix that bug.)
>>>
>>>> +    int64_t tick_offset;
>>>> +
>>>> +    uint64_t lpcr;
>>>
>>> We've now added state to this device, which means that it needs
>>> a VMState structure to handle migration, and it needs a reset
>>> function.
>>
>> I just noticed your v1 review after reviewing v2. Indeed
>> 'tick_offset' need to be migrated. Now about reset(), RTC
>> are somehow different. When resetting a machine in the same
>> QEMU process I'd expect the RTC offset to not be reset.
>>
>> Could this be clarified by adding a reset handler with no
>> code but a comment /* RTC state is usually kept by CMOS
>> battery and is not reset */ maybe?
> 
> The lpcr register state needs to be reset.

Oh, I missed its access in imx7_snvs_read().

> thanks
> -- PMM


