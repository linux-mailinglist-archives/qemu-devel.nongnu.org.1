Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB35811AAE
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 18:17:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDSrG-0004LV-9b; Wed, 13 Dec 2023 12:17:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDSrE-0004L5-UP
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 12:17:16 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDSrC-0000Hb-5j
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 12:17:16 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a1f6433bc1eso1152268766b.1
 for <qemu-devel@nongnu.org>; Wed, 13 Dec 2023 09:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702487832; x=1703092632; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YV1aVfliO0h/9ZxH/04CNNXbjdLWJq9x+ewRR5BBe3s=;
 b=a8+smenEAgwtYwlBoopgfeOlrn8v4nNBM7RzdX7nYM3NjdBAAugKShbPJ1ojDi6SGF
 6Ai/qRjS+ChMCOlzGkHFCto0hLHXTXEzgEfO5F1EOTrjDceeE43dF7KqWPjLJSviAWIX
 8k/hlCwJikgvXb95x4vqs0Qq0UM/DV0KFy6U0b8YBKmgGoYBkbheklMkGHADTJVfPoCM
 3sAB7QfaZwIezc0bIesCUrTE7+IPO4UmC4L/hPV+n+urbmTNdwEexYroGfaoyfYPIZ47
 B5fSCBgb2p6vE/tfeOgsZ9hh03mnHOiXmwEPm+GT5xaKlwf5FGBT6LwSxv6yzYN+J3k4
 HHhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702487832; x=1703092632;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YV1aVfliO0h/9ZxH/04CNNXbjdLWJq9x+ewRR5BBe3s=;
 b=HImUwVl8E+JiOh3e5zumlSpi780cU7AZ9QUeVlIk/nxAukc1vxNtduwTeos07x8bwN
 bDr+VmSd4Ns1/aUd/ZFVAvbXR3yTXkw2yIQqv2p9IciyAk4Vnlvj7EwBXT1iLPBc7XZr
 uYIhpWT5aX2+0UVeG6x3ZWKQoWQuVwhOTBvrQITHMlOZH2Sw6OLeTWEeZpHo2fEBzcUl
 eVeJZbPe4uWbDNVuxDmEa4vMAU6I97BpBX6Fzb8OeIl4HpYkt2YfvINPLfqsSofzOs/L
 RrX4aPlpu21Uv6wwYiCMvOBg4IlKo/1H1lISqrW+smoc8hNgsWAyKTwqrZtqKnIRlnQz
 O9GA==
X-Gm-Message-State: AOJu0Yxhus7eYuOkLeD7ruo5ABZd2w2rEZ4nJovzLCNq72uPMryxcNM/
 cOcrMmD9x3NdsJYKRDrqDtqvMQ==
X-Google-Smtp-Source: AGHT+IECUnwdgKitgSO5OcSWEofkUiqc3D0Pkrtyh8/ial3zFNDlyxrTSYZji166co/p4ETE3LybGw==
X-Received: by 2002:a17:906:1c9:b0:a1d:1fb9:da08 with SMTP id
 9-20020a17090601c900b00a1d1fb9da08mr6949578ejj.8.1702487832405; 
 Wed, 13 Dec 2023 09:17:12 -0800 (PST)
Received: from [192.168.79.175] ([93.23.251.22])
 by smtp.gmail.com with ESMTPSA id
 li18-20020a170907199200b009fd77d78f7fsm8047804ejc.116.2023.12.13.09.17.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Dec 2023 09:17:12 -0800 (PST)
Message-ID: <fbab82ef-bb45-417a-932e-99089dd4d4a5@linaro.org>
Date: Wed, 13 Dec 2023 18:17:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fsl-imx: Add simple RTC emulation for i.MX6 and i.MX7
 boards
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>
References: <20231112092232.131-1-n.ostrenkov@gmail.com>
 <CAFEAcA8A8sGjknad1QpeJ8qank-mWWw+gRvR4PVBHk2zAHrEnQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA8A8sGjknad1QpeJ8qank-mWWw+gRvR4PVBHk2zAHrEnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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

Hi Peter,

On 12/12/23 15:18, Peter Maydell wrote:
> On Sun, 12 Nov 2023 at 09:22, Nikita Ostrenkov <n.ostrenkov@gmail.com> wrote:
> 
> Hi; thanks for this patch, and sorry I haven't got round
> to reviewing it earlier.
> 
>> Signed-off-by: Nikita Ostrenkov <n.ostrenkov@gmail.com>
>> ---
>>   hw/misc/imx7_snvs.c         | 59 ++++++++++++++++++++++++++++++++-----
>>   hw/misc/trace-events        |  4 +--
>>   include/hw/misc/imx7_snvs.h | 14 ++++++++-
>>   3 files changed, 67 insertions(+), 10 deletions(-)


>> @@ -31,6 +33,16 @@ struct IMX7SNVSState {
>>       SysBusDevice parent_obj;
>>
>>       MemoryRegion mmio;
>> +
>> +    /*
>> +     * Needed to preserve the tick_count across migration, even if the
>> +     * absolute value of the rtc_clock is different on the source and
>> +     * destination.
>> +     */
>> +    int64_t tick_offset_vmstate;
> 
> You don't need tick_offset_vmstate -- it is only in the p031
> RTC device as a backwards-compatibility thing for older versions
> of QEMU. Migrating tick_offset alone is sufficient in a new
> device. (It seems to have been unfortunately copied-and-pasted
> into the goldfish RTC device; we should probably fix that bug.)
> 
>> +    int64_t tick_offset;
>> +
>> +    uint64_t lpcr;
> 
> We've now added state to this device, which means that it needs
> a VMState structure to handle migration, and it needs a reset
> function.

I just noticed your v1 review after reviewing v2. Indeed
'tick_offset' need to be migrated. Now about reset(), RTC
are somehow different. When resetting a machine in the same
QEMU process I'd expect the RTC offset to not be reset.

Could this be clarified by adding a reset handler with no
code but a comment /* RTC state is usually kept by CMOS
battery and is not reset */ maybe?

> 
>>   };
>>
>>   #endif /* IMX7_SNVS_H */
>> --
> 
> thanks
> -- PMM
> 


