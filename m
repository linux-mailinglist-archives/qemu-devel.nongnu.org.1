Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF93719F45
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 16:11:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4j0a-0004sW-KO; Thu, 01 Jun 2023 10:10:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4j0Y-0004re-2Y
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 10:10:30 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4j0W-0004tZ-6L
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 10:10:29 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-64d30ab1f89so568022b3a.3
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 07:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685628625; x=1688220625;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uv0NgmcChl4Z2nY9W7VMiTbMkc88jdInND4AksY4Ozc=;
 b=K2GU7DzTLPtnRSJrez/QEsZxmC7YEARBn6vk/Q6DwuR5eJw+iK2CAzbgjdYyBDBlMq
 Vdh3syPnc5VvogO9tJpZ8sGpgoQcUGW0jZTs95X7VOkyhYpIdf7FopmJcdoNEDASBHnF
 SIaWla4V3ZYEw/adj5Ysg8Z+UJwjRIFZXDbxoxPlzyKtuWGP6Mwei52U3ONBBAAezDpg
 fSvx5LEaP2EWXykz2VtIJmmS8AyH1g0xVoEUMruP1yZ9auI9xJ2c/Gsfu0U0IQn0XRd0
 PnYESxadOCp4QlaQI8SLBaQOeWTuLIsZjSjVweW7+jhnmL1niibi6WsTwA+KDfdsGubk
 2zMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685628625; x=1688220625;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uv0NgmcChl4Z2nY9W7VMiTbMkc88jdInND4AksY4Ozc=;
 b=ffKP2LrvxCRyph9E7LI/R36lswxzGqJJ8ilwholgzPdhwcTn/t3lBp5kBwJub3shM4
 kNMhC8HAWWflEX0uUFjifT8xERdGfM3y6i0gQVwD5+kT2T//cqB5Ziq095bnbUKToPr0
 VaO9BVEOgUL1O0Zo5dNjsjLx4D0gcJXDu2inPZgMsBTaR85yFDcnWrEos+HAekqi/Wmp
 ajv33E5lwlUVWEXwi8h8bFuGKsgXfr/2LyT59/h0mrxH00nWpdoGEZEZ/4Nfp3pTKXkl
 hc8OQdzNwfabJIXxWxvUnDGMEV9lQp4HiNdJvCEDZdAQcqm2eINqqOkLNVVo6q1ObHao
 Vwcg==
X-Gm-Message-State: AC+VfDzppj2tB3zr+bbjpcE27/mjh25R15nAMYoq9RbmUmziFiRWjOiy
 aEwc/aRaSJUW4XLUZRCgiek/PA==
X-Google-Smtp-Source: ACHHUZ5z+4Q87Cjo2cB+EB8bNQS+C0+dViGN5IB912fV5MsRmlSqcXcsZHSVTR2OeABhMyBBEGICzQ==
X-Received: by 2002:a05:6a00:9a5:b0:627:e49a:871a with SMTP id
 u37-20020a056a0009a500b00627e49a871amr8940443pfg.23.1685628624949; 
 Thu, 01 Jun 2023 07:10:24 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:c935:f07f:4b59:7091?
 ([2602:ae:1598:4c01:c935:f07f:4b59:7091])
 by smtp.gmail.com with ESMTPSA id
 f4-20020aa78b04000000b0063d2cd02d69sm5113364pfd.54.2023.06.01.07.10.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jun 2023 07:10:24 -0700 (PDT)
Message-ID: <1f305f3c-d975-b117-106a-021c31bbca76@linaro.org>
Date: Thu, 1 Jun 2023 07:10:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v14 04/10] accel/tcg: add jit stats and time to
 TBStatistics
Content-Language: en-US
To: "Wu, Fei" <fei2.wu@intel.com>, alex.bennee@linaro.org,
 qemu-devel@nongnu.org
Cc: "Vanderson M . do Rosario" <vandersonmr2@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
References: <20230530083526.2174430-1-fei2.wu@intel.com>
 <20230530083526.2174430-5-fei2.wu@intel.com>
 <3cc014aa-96ef-9a5a-f567-2e55ce37b469@linaro.org>
 <7345653a-6237-afc3-3e9f-63e31e0539b1@intel.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <7345653a-6237-afc3-3e9f-63e31e0539b1@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.1,
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

On 5/31/23 23:48, Wu, Fei wrote:
>>> -int64_t tcg_cpu_exec_time(void);
>>> +uint64_t tcg_cpu_exec_time(void);
>>
>> Why?  (Also, probably wants removing, per above.)
>>
> The original patch mentioned 'make it an uint64_t as we won't be dealing
> in negative numbers.'

The signed vs unsigned thing is something that should be handled throughout everything 
that handles times, not adjusted here and there by only profiling.

>>> --- a/softmmu/runstate.c
>>> +++ b/softmmu/runstate.c
>>> @@ -728,9 +728,18 @@ static bool main_loop_should_exit(int *status)
>>>    int qemu_main_loop(void)
>>>    {
>>>        int status = EXIT_SUCCESS;
>>> +#ifdef CONFIG_TCG
>>> +    uint64_t ti;
>>> +#endif
>>>          while (!main_loop_should_exit(&status)) {
>>> +#ifdef CONFIG_TCG
>>> +        ti = profile_getclock();
>>> +#endif
>>>            main_loop_wait(false);
>>> +#ifdef CONFIG_TCG
>>> +        dev_time += profile_getclock() - ti;
>>> +#endif
>>>        }
>>
>> What is this intending to collect?  Because I don't think it measures
>> anything.  Certainly nothing related to TCG, CPUs or even devices.
>>
> It's exported to hmp cmd in dump_jit_exec_time_info() together with
> cpu_exec_time.

That doesn't answer my question: What do you think it measures?

r~

