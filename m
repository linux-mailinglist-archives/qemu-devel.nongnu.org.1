Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 034E07128CA
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 16:44:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2YfI-0001li-13; Fri, 26 May 2023 10:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2YfG-0001lT-Km
 for qemu-devel@nongnu.org; Fri, 26 May 2023 10:43:34 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2YfE-0002n5-Un
 for qemu-devel@nongnu.org; Fri, 26 May 2023 10:43:34 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1b01d912924so2790885ad.1
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 07:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685112211; x=1687704211;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WztnphZLEEeEQr5+KwHAmPlH2eB1wGQQqMl99B4fNXk=;
 b=ZMIM2Bs5LlGeZv7M69TGQzJHuAgb8GGN9DdYSW8WOnixhI2mcdsUNoWE7mpcD7f30T
 nHO2sYPIMDLXKB+WQvi9itV69MnRFf20jZUCgJdlMFvw8fJK4wZA0OGQrLL+HseE9v4P
 1jUH8zFRYPa30c+SlfeNjgoy2Sko9kjtdattbILpQkjYDNl7pzJr2T3HOtmldr/BVDmA
 Edubmh8DgdiN/QZ4SlydBIh1WsHJaeZnR4ccTRgJRRDHaUWSzJeMdwIFneOiBtgH+2w4
 0hHxTo1oxS5n6mGBPMwVWVK6DdGNVmfprDAw7VVnixjo5RBw38m/I5x5V4+tJq9gRoWq
 e+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685112211; x=1687704211;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WztnphZLEEeEQr5+KwHAmPlH2eB1wGQQqMl99B4fNXk=;
 b=kYNMCGIR2PSxmei9RsKkkAafxoSRs24LlvlJszYY1AI7+N/yShJZQB32D+16i84TZb
 myLBTuysKwY+tD/gyXb/3QkvCL+hEqfv9xWnZuoI/Y6L8v53VK6qzg9ds0MPpdvR4KPM
 SCXdInOpa10JRX24VxDwkyhagr4Hv3wvR2o/XjniryEzhkZAv4VLDwwrfmWt1YYTGISi
 xVih2sRmEB5/GQjvUQMNFS2u9a398YI3pZVW4XsdoilD5hCDhyhJsNBFw+Yt3V/KOM/0
 bQB0085iRL3bhiBQPOKF/Ej5h1XADzDRHgI8sI9XLIr0/Z9NZATEWepQB2u6oVSTmzqJ
 ccpQ==
X-Gm-Message-State: AC+VfDxf3nnNSMaYdCkqgVosc2lQPKoKsi/HODniVyTdrrYbxgxRA2/n
 er+zDxzUOnaExE+yJuW/YO7/og==
X-Google-Smtp-Source: ACHHUZ6Ix8OWNZTqsunhcG2GycrWo+C/EdpITtCSenLZGEnPRkeseuNBZXBPkKw8rO3XZAt9qSX+oA==
X-Received: by 2002:a17:902:ab5a:b0:1a9:b8c3:c2c2 with SMTP id
 ij26-20020a170902ab5a00b001a9b8c3c2c2mr2573715plb.37.1685112211093; 
 Fri, 26 May 2023 07:43:31 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:86cc:4482:68db:2c0f?
 ([2602:ae:1598:4c01:86cc:4482:68db:2c0f])
 by smtp.gmail.com with ESMTPSA id
 t13-20020a1709027fcd00b001aaf536b1e3sm3401188plb.123.2023.05.26.07.43.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 May 2023 07:43:30 -0700 (PDT)
Message-ID: <8f315f7c-2778-855a-0879-f928f9ca8054@linaro.org>
Date: Fri, 26 May 2023 07:43:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 01/20] target/arm: Add commentary for
 CPUARMState.exclusive_high
Content-Language: en-US
To: quintela@redhat.com, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20230525232558.1758967-1-richard.henderson@linaro.org>
 <20230525232558.1758967-2-richard.henderson@linaro.org>
 <dbb368d0-839c-ad09-01de-09b1a62416af@linaro.org>
 <87zg5r1kxx.fsf@secure.mitica>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <87zg5r1kxx.fsf@secure.mitica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

On 5/26/23 02:49, Juan Quintela wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>> Hi,
>>
>> On 26/5/23 01:25, Richard Henderson wrote:
>>> Document the meaning of exclusive_high in a big-endian context,
>>> and why we can't change it now.
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>    target/arm/cpu.h | 7 +++++++
>>>    1 file changed, 7 insertions(+)
>>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>>> index d469a2637b..4e16eab82e 100644
>>> --- a/target/arm/cpu.h
>>> +++ b/target/arm/cpu.h
>>> @@ -677,8 +677,15 @@ typedef struct CPUArchState {
>>>            uint64_t zcr_el[4];   /* ZCR_EL[1-3] */
>>>            uint64_t smcr_el[4];  /* SMCR_EL[1-3] */
>>>        } vfp;
>>> +
>>>        uint64_t exclusive_addr;
>>>        uint64_t exclusive_val;
>>> +    /*
>>> +     * Contains the 'val' for the second 64-bit register of LDXP, which comes
>>> +     * from the higher address, not the high part of a complete 128-bit value.
>>> +     * This is perhaps confusingly named, but the name is now baked into the
>>> +     * migration format.
>>> +     */
>>>        uint64_t exclusive_high;
>>
>> Can't we rename the field if we add the old name to check_fields_match()
>> in scripts/vmstate-static-checker.py?
>>
>> Juan, could we store this renamed information directly in the code in
>> VMState? Maybe adding some VMSTATE_KEY_ALIAS(_old_key, _new_key) macro
>> and have the migration/ code magically deal with that :)
>>
>> I.e. here:
>>
>>    VMSTATE_KEY_ALIAS("exclusive_val", high_addr),
> 
> You are asking for magic?
> In VMState, that nobody understands.
> 
> Sniff.
> 
> I remembered that VMState only cares about values, not for field names.
> We can rename fields without any trouble....
> 
> Until we arrive to dump_vmstate_vmsf().
> 
> But I think we can have both things, the only thing that we really care
> about vmstate dump is to do comparisons.  And for doing comparisons you
> should be using vmstate-static-checker.py
> 
> That already have support for this.  Look up:
> 
> check_fields_match()
> 
> and see how it renamed other fields.
> 
> As you know better how to do this, can you play with the script and see
> if you can get what you want?
> 
> If not, I can try to modify the script to get to what you need.

It's not worth any effort to rename.  Just needed documentation.


r~


