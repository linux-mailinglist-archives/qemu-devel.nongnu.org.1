Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 173AA786053
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 21:06:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYtAJ-0006uo-Ge; Wed, 23 Aug 2023 15:05:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYtAE-0006tu-0a
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 15:05:11 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYtAA-0006j0-R1
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 15:05:08 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1bc83a96067so37173875ad.0
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 12:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692817505; x=1693422305;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0/5QDx9u3fypY3fUQquf8tMLJp4ZNjimjwfThaVydGc=;
 b=emnoYyLg981F6T5K7QkHt7vWpmeCqCpgJcQw3w/0ssi6t09A2pFPMpDEeCFI4MzOgb
 cDR+TmQtuKmZXnZBs0vnxpyFEZn+Gf/pFUyD6Wm4dA9n0Sehu+TiCWlXrw39v3fM84LV
 IoWM/fFwOK0CTB7hZRR7wDHtp4BwhogAeA1tZIfh10YfnpB01+XuTcVWU6iqii2cdGlP
 5DlvlT0ASVpIeLlGi7wkxf074WafN1hsEtsCYcrPiJMhcAqM08hVS3uLa/cXkKma9Zdh
 9hVrYbv9/MuvELxGj5C7PJ/unLQQc5glDqMxj75NQrN9XImUnV/a3vY8EOTflhVJDcrk
 xd+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692817505; x=1693422305;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0/5QDx9u3fypY3fUQquf8tMLJp4ZNjimjwfThaVydGc=;
 b=F/8cDZxY8Ke1psnzaLSFjpHCfVzITN/iGh48UX3MxsN2Ul+yTeyVbl8b5QiggyLhkK
 yy4pOnYVcWMYZMLS2hbQlwEorjeti6sqIEih7/zg/Y8Vkz/7qe6SwCPAovOVUqwht49P
 5h5vBeBwp9EzHmLgweM79oYDWnILfIsCemxRY9jNhdRgPPGZ0l2lg4ROBJq9ZAeqdSy4
 MMp7WK14ksS0iM+mIOj+RD7ehFgAvRsDxNJWPCosTtAQocc4zLlhnghA8RIVTwMMcwOQ
 xRsjvzmL3E4AwNqrlMMAp5EP4n5RDv6OozzJmdc2yDcuYlD88kXI5V5noI13uK7mDovD
 e+lw==
X-Gm-Message-State: AOJu0Yw/9BbhWIxTJEg5GJYRwHyUnngkFEnzP8kX9ycisqsxn5++jqEH
 B9tE7iC8b1XClAou1QbCqIwBUw==
X-Google-Smtp-Source: AGHT+IFvyWFaxT1fe3RD4XUFrRWWc4+luJs3Gf0GOO1dRR+jOduXrwV39AdYEHyAhk/cq+Smn/95eg==
X-Received: by 2002:a17:903:124b:b0:1bb:a367:a70 with SMTP id
 u11-20020a170903124b00b001bba3670a70mr12332382plh.17.1692817505139; 
 Wed, 23 Aug 2023 12:05:05 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:72f0:1ea7:85d2:141e?
 ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 n9-20020a170902968900b001b03a1a3151sm11331257plp.70.2023.08.23.12.05.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Aug 2023 12:05:04 -0700 (PDT)
Message-ID: <862d1957-cd73-0367-8e9c-adba16a55ab1@linaro.org>
Date: Wed, 23 Aug 2023 12:05:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 2/5] HACK: target/arm/tcg: Add some more caches to
 cpu=max
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Gavin Shan <gshan@redhat.com>,
 linuxarm@huawei.com, James Morse <james.morse@arm.com>,
 "peter . maydell @ linaro . org" <peter.maydell@linaro.org>,
 zhao1.liu@linux.intel.com,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Yicong Yang <yangyicong@huawei.com>
References: <20230808115713.2613-1-Jonathan.Cameron@huawei.com>
 <20230808115713.2613-3-Jonathan.Cameron@huawei.com>
 <87y1ierkuh.fsf@linaro.org> <20230823155949.000071d2@Huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230823155949.000071d2@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.684,
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

On 8/23/23 07:59, Jonathan Cameron via wrote:
> On Mon, 14 Aug 2023 11:13:58 +0100
> Alex Bennée <alex.bennee@linaro.org> wrote:
> 
>> Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:
>>
>>> Used to drive the MPAM cache intialization and to exercise more
>>> of the PPTT cache entry generation code. Perhaps a default
>>> L3 cache is acceptable for max?
>>>
>>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> ---
>>>   target/arm/tcg/cpu64.c | 12 ++++++++++++
>>>   1 file changed, 12 insertions(+)
>>>
>>> diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
>>> index 8019f00bc3..2af67739f6 100644
>>> --- a/target/arm/tcg/cpu64.c
>>> +++ b/target/arm/tcg/cpu64.c
>>> @@ -711,6 +711,17 @@ void aarch64_max_tcg_initfn(Object *obj)
>>>       uint64_t t;
>>>       uint32_t u;
>>>   
>>> +    /*
>>> +     * Expanded cache set
>>> +     */
>>> +    cpu->clidr = 0x8204923; /* 4 4 4 4 3 in 3 bit fields */
>>> +    cpu->ccsidr[0] = 0x000000ff0000001aull; /* 64KB L1 dcache */
>>> +    cpu->ccsidr[1] = 0x000000ff0000001aull; /* 64KB L1 icache */
>>> +    cpu->ccsidr[2] = 0x000007ff0000003aull; /* 1MB L2 unified cache */
>>> +    cpu->ccsidr[4] = 0x000007ff0000007cull; /* 2MB L3 cache 128B line */
>>> +    cpu->ccsidr[6] = 0x00007fff0000007cull; /* 16MB L4 cache 128B line */
>>> +    cpu->ccsidr[8] = 0x0007ffff0000007cull; /* 2048MB L5 cache 128B line */
>>> +
>>
>> I think Peter in another thread wondered if we should have a generic
>> function for expanding the cache idr registers based on a abstract lane
>> definition.
>>
> 
> Great!
> 
> This response?
> https://lore.kernel.org/qemu-devel/CAFEAcA_Lzj1LEutMro72fCfqiCWtOpd+5b-YPcfKv8Bg1f+rCg@mail.gmail.com/

Followed up with

https://lore.kernel.org/qemu-devel/20230811214031.171020-6-richard.henderson@linaro.org/


r~

