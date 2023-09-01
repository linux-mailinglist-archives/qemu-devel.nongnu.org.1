Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71124790109
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 19:03:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc7XY-0001Yd-5p; Fri, 01 Sep 2023 13:02:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qc7XT-0001QU-Kc
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 13:02:33 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qc7XR-0001sc-7Z
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 13:02:31 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1c0d5b16aacso17833085ad.1
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 10:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693587747; x=1694192547; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Rt2Z4ZWPmB/wuN/gtbm45yySFn+Phmrx84Dxkvy7I/I=;
 b=jVBtfptcdW0KfdTK18JdH6T+mjBEYpTZm01DELGMBWQi6oyhop12d5cEMeagr4shI2
 6FysnxxI0t9iqRKPAGJ/ZN7BllPm+y0mqb/pakVMSFwWHv6viVWVDB7koyogaI6slt3C
 aOEkB7+Y90ohBmZu7JlXLu9qmUqGwcrepA96ud6rPZN7t3wlU9wzWHzK1rWt8m5OIVNg
 eoQmXbpwetEVxXsOVzjDn0KzslO3tolpM0itndFFYjKVO2x6xP/W+IWVVMyMrsApmG+a
 W/sCMbzzAEGwcUE57JpjFDLK8h+y2TBipjD9UT5MdKNARFtqnVIXxIO5sn2N5FYLOT8r
 xAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693587747; x=1694192547;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Rt2Z4ZWPmB/wuN/gtbm45yySFn+Phmrx84Dxkvy7I/I=;
 b=bLUsNtT6jQ5JCf/wDypLF2YMhOaQ0h4oSgfvAlmIEmdEfNm3Xy9QE2pc7YQI7tKSRp
 yiWFwslVLYxf/BmaHFF3xzeFnjS05pkuW4OZUQPbTdngA3OVzoPYakuSG/cuxAa2ltbN
 6lZzWxxOux8OuP0+7fERiCWpsNlVAJKfPgfmLCzWOSCL1E+URWkR0LMrbhwYOVKU35CT
 hP+di9upCE+4nKffbMQi1sDzsyDdAkXC2921Xpho4P+RP52WtyvEhIuL570dWLy+xLfS
 5jxKKKkjgQAV1V7OQZKTxHcdxDrAOsfy0Zw7+IGVqmAg6VCX0ech1AakLgFpRG3KCiBu
 IrlQ==
X-Gm-Message-State: AOJu0YyQX1cexKSWU4Nixtfb/p8o0NMKv1Qzcyvmh0m7gKs8awiiA0SU
 OAPW/W3yu14kdEbkP0nOn7o1Tw==
X-Google-Smtp-Source: AGHT+IG5pKYmzJNZA2TBoUAfYehoVhX6cTfKLN1Ng0PRAqJTfvm2faUC94SuS8sXaE/MIbYAgyJBGA==
X-Received: by 2002:a17:902:7442:b0:1c1:f1db:e86d with SMTP id
 e2-20020a170902744200b001c1f1dbe86dmr3285746plt.7.1693587747594; 
 Fri, 01 Sep 2023 10:02:27 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 t13-20020a1709028c8d00b001b5247cac3dsm3197223plo.110.2023.09.01.10.02.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Sep 2023 10:02:26 -0700 (PDT)
Message-ID: <52695ffb-9294-f6ad-85e2-da4c3841682b@linaro.org>
Date: Fri, 1 Sep 2023 10:02:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 05/19] host-utils: Add muldiv64_round_up
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20230808042001.411094-1-npiggin@gmail.com>
 <20230808042001.411094-6-npiggin@gmail.com>
 <ef43cbed-ac93-4be1-2a0a-54ffb608871a@kaod.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ef43cbed-ac93-4be1-2a0a-54ffb608871a@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.478,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/1/23 04:51, Cédric Le Goater wrote:
> Adding more reviewers since this patch is modifying a common service.
> 
> Thanks,
> 
> C.
> 
> 
> On 8/8/23 06:19, Nicholas Piggin wrote:
>> This will be used for converting time intervals in different base units
>> to host units, for the purpose of scheduling timers to emulate target
>> timers. Timers typically must not fire before their requested expiry
>> time but may fire some time afterward, so rounding up is the right way
>> to implement these.
>>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>   include/qemu/host-utils.h | 21 ++++++++++++++++++++-
>>   1 file changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/qemu/host-utils.h b/include/qemu/host-utils.h
>> index 011618373e..e2a50a567f 100644
>> --- a/include/qemu/host-utils.h
>> +++ b/include/qemu/host-utils.h
>> @@ -56,6 +56,11 @@ static inline uint64_t muldiv64(uint64_t a, uint32_t b, uint32_t c)
>>       return (__int128_t)a * b / c;
>>   }
>> +static inline uint64_t muldiv64_round_up(uint64_t a, uint32_t b, uint32_t c)
>> +{
>> +    return ((__int128_t)a * b + c - 1) / c;
>> +}
>> +
>>   static inline uint64_t divu128(uint64_t *plow, uint64_t *phigh,
>>                                  uint64_t divisor)
>>   {
>> @@ -83,7 +88,8 @@ void mulu64(uint64_t *plow, uint64_t *phigh, uint64_t a, uint64_t b);
>>   uint64_t divu128(uint64_t *plow, uint64_t *phigh, uint64_t divisor);
>>   int64_t divs128(uint64_t *plow, int64_t *phigh, int64_t divisor);
>> -static inline uint64_t muldiv64(uint64_t a, uint32_t b, uint32_t c)
>> +static inline uint64_t __muldiv64(uint64_t a, uint32_t b, uint32_t c,
>> +                                  bool round_up)

Perhaps better avoiding the reserved name: muldiv64_internal?

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


>>   {
>>       union {
>>           uint64_t ll;
>> @@ -99,12 +105,25 @@ static inline uint64_t muldiv64(uint64_t a, uint32_t b, uint32_t c)
>>       u.ll = a;
>>       rl = (uint64_t)u.l.low * (uint64_t)b;
>> +    if (round_up) {
>> +        rl += c - 1;
>> +    }
>>       rh = (uint64_t)u.l.high * (uint64_t)b;
>>       rh += (rl >> 32);
>>       res.l.high = rh / c;
>>       res.l.low = (((rh % c) << 32) + (rl & 0xffffffff)) / c;
>>       return res.ll;
>>   }
>> +
>> +static inline uint64_t muldiv64(uint64_t a, uint32_t b, uint32_t c)
>> +{
>> +    return __muldiv64(a, b, c, false);
>> +}
>> +
>> +static inline uint64_t muldiv64_round_up(uint64_t a, uint32_t b, uint32_t c)
>> +{
>> +    return __muldiv64(a, b, c, true);
>> +}
>>   #endif
>>   /**
> 
> 


