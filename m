Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6EA74419E
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 19:52:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFIHe-0004fz-SZ; Fri, 30 Jun 2023 13:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFIHd-0004fj-Dp
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 13:51:49 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFIHb-0001Pg-K0
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 13:51:49 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-4f9fdb0ef35so3596938e87.0
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 10:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688147506; x=1690739506;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BMniqV8Qa24ce3aH/nfEq1ieh79OKRsSEbO0YUUdqc4=;
 b=fIF+UPmWasW2PfmGGUXn42ROcmwATgvJy90h3W0/BWfVvnfLWjBlOluXWCbBuUNwOk
 hsYIvuqCYlS5LCJBEuT/ueymBZoR4bnriSbEK2KDRwJgYOmLdh8B+jXG0r4TGRCRulqk
 9rORyDm97Hxio9vRmJWy6uuYIDXki69UuyCvsLpOxo+iydZV27WoA/nJxfu7PLvuCKu8
 s/paX3oDkgaZ4RIMYaZCaZ92CzHR6jXM8qdA5jBS+4+MqMT1lCg2X1exY7tOIeRpv6MC
 5NPqswzptQKNAEvA2LcySWRrKDDC9o1aoitsfp21bfkgV/6qeanzAVmy3SCVhGo7HDAt
 5v/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688147506; x=1690739506;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BMniqV8Qa24ce3aH/nfEq1ieh79OKRsSEbO0YUUdqc4=;
 b=b4KUdi957kfqG+Kb8WNVCSdBmaXND55nR1kGH7Os1CL48yYfGqiesIuG+RPyFGV+xR
 Lu46CS014GNOZ3sF5uPQEJ/arGkZy3UtdmJT4cYhd7hVwt0jm8kzOUtpO5MBn78Ml87j
 OxpLBrRyuNO1Ye10G80cGtSnLhHz5Fvj+9DChhJSTm5AkgVKSL4nChzDPnY2hl+Ga7qQ
 /O+fLS4okcLP2YuOOGbFmbiEpeVwmc6n8ECgJ1IDcT9SFwfW0KN5WnBheupZobWzzXF/
 bBCkfYEI3A2f7ZYNcX2srctnX+qMmjBbJpxregsDbbDOaQjv3tPJEZbxvWUQGicSeFR/
 2UmQ==
X-Gm-Message-State: ABy/qLZrdcVuukXhfvkg7jOxCy0XQiSAb2kAdA2F9USM7eO5Dm6ci9wT
 GvhWxnvb5ESJls4LeB6Dpa92hQ==
X-Google-Smtp-Source: APBJJlESa29bUtSPxqS248gMCmZETvtNnWupWDfKc+G1dpQMFgKHsMqEzcsLw16ZpXGSlQ8LrxtygA==
X-Received: by 2002:a05:6512:3c98:b0:4f8:7614:48a5 with SMTP id
 h24-20020a0565123c9800b004f8761448a5mr3210195lfv.66.1688147505772; 
 Fri, 30 Jun 2023 10:51:45 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 u20-20020a05600c211400b003fbb618f7adsm5479822wml.15.2023.06.30.10.51.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jun 2023 10:51:45 -0700 (PDT)
Message-ID: <e4997bdf-502e-5e45-f0a6-63f6fed0cef7@linaro.org>
Date: Fri, 30 Jun 2023 19:51:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 1/8] target/arm: Add ID_AA64ISAR2_EL1
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 Aaron Lindsay <aaron@os.amperecomputing.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Vincent Dehors <vincent.dehors@smile.fr>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20230609172324.982888-1-aaron@os.amperecomputing.com>
 <20230609172324.982888-2-aaron@os.amperecomputing.com>
 <a8db353d-b258-c856-d5ce-1236b0893a53@linaro.org>
 <ZIcbF8zShOr1N2Sl@strawberry.localdomain>
 <CAFEAcA8pjgXXnUcLxcnm-9mcakps4KcXKOvHQxzj7n_CzY2zSA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA8pjgXXnUcLxcnm-9mcakps4KcXKOvHQxzj7n_CzY2zSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 6/19/23 12:51, Peter Maydell wrote:
> On Mon, 12 Jun 2023 at 14:18, Aaron Lindsay
> <aaron@os.amperecomputing.com> wrote:
>>
>> On Jun 09 13:49, Richard Henderson wrote:
>>> On 6/9/23 10:23, Aaron Lindsay wrote:
>>>> --- a/target/arm/hvf/hvf.c
>>>> +++ b/target/arm/hvf/hvf.c
>>>> @@ -847,6 +847,7 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>>>>            { HV_SYS_REG_ID_AA64DFR1_EL1, &host_isar.id_aa64dfr1 },
>>>>            { HV_SYS_REG_ID_AA64ISAR0_EL1, &host_isar.id_aa64isar0 },
>>>>            { HV_SYS_REG_ID_AA64ISAR1_EL1, &host_isar.id_aa64isar1 },
>>>> +        { HV_SYS_REG_ID_AA64ISAR2_EL1, &host_isar.id_aa64isar2 },
>>>
>>> Sadly not defined for MacOSX13.1.sdk, and it's an enum so you can't #ifdef it either.
>>>
>>> You'll need a meson probe for it.
>>
>> I'm not very familiar with HVF or meson - I am not sure I understand
>> what you're suggesting here (and a few attempts to grep around for an
>> example didn't turn up anything that looked helpful). Are you suggesting
>> some sort of build-time auto-detection, a "dumb" configuration switch
>> that a user could use to manually enable this, or something else? And/or
>> is there an example you could point me to of what you're thinking?
> 
> So the first thing here is: where is HV_SYS_REG_ID_AA64ISAR2_EL1
> defined in the first place?
> https://developer.apple.com/documentation/hypervisor/hv_sys_reg_t
> does not list it.
> 
> If this is really the right name for the value, then:
> 
> We do our build-time detection of stuff that might or might
> not be present using meson's facilities or that kind of
> thing. These are all in meson.build. In this case I think
> that what you want to use is has_header_symbol(), which
> checks for presence of some symbol in a given header. There's
> examples in meson.build, you want something like
> 
> config_host_data.set('HAVE_HV_SYS_REG_ID_AA64ISAR2_EL1',
>                       cc.has_header_symbol('whatever.h',
> 'HV_SYS_REG_ID_AA64ISAR2_EL1'))
> 
> which tells meson "if this header has this symbol then define
> this preprocessor value HAVE_...". Then you can #ifdef on that.
> (We're inconsistent about whether we use CONFIG_FOO or HAVE_FOO
> for this sort of test.)
> 
> Or alternatively, since this is macos specific and Apple are
> quite careful about API versioning, it may be simpler to use
> macos's own version macros to ifdef things so we only try to
> use the enum value when building for a macos version that knows
> about it. Grepping for 'MAC_OS_VERSION' brings up examples of
> that approach.

AFAICS, there is no macos version that contains this register, because there is no Apple 
cpu that contains it.  I think we should be fine, for now, in omitting any HVF change, 
letting the register default to 0.


r~


