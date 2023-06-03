Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4C0720D83
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 05:01:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5HVS-0004Ix-8S; Fri, 02 Jun 2023 23:00:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5HVQ-0004IK-HM
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 23:00:40 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5HVO-0005O1-UW
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 23:00:40 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-64d24136685so2150831b3a.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 20:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685761237; x=1688353237;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PzzInfARjmu0h8x+BvslioAWimTyXMzpW8JsFU6PKng=;
 b=YlWfalRuR2mKtllztJx5vmhgLetfjPaNhQlJNl+QYc9cR+940HuVtJYVQS0ik1i2Of
 DKCVysTWvURX/ZTpcReOF4DP9XVynjNdZ8mxvjcCib/5XXV3GJfc/l1841OqLylNZFrJ
 8nu1Q6NOhul+Tqt1S6QK12Jf4KGm0svI8b6tas1VH1b3bUfu5U3Of3AX99SUuqWtxFbl
 Ew+yN8X+a1rIVjOfM4WvVGvkTDHOiBoMcjkCU5ipCw9lV2CuqVCxsGOQa2C2u2pBvdeV
 fqCm8OneKkaEYiL1fQnICiLaV4vXIJXwSGDAtxvewMFgAnRxOizatRSlhH8aCo7jozCc
 vq1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685761237; x=1688353237;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PzzInfARjmu0h8x+BvslioAWimTyXMzpW8JsFU6PKng=;
 b=LhIG9kk2Uz7z3Y6AfAu9wMLLtwrJokUpf/YhPZKWV12J86d6voFF2MsfyoxXFcu8kv
 dGasczxGlrLJN6vl+6WHSZk5ipqJxvub9jjsxfvplT/susMy9MJaRVkLty2fK8Vlzqf2
 +JAY9v+cxI+l4Tkrm96jF4zIG6PSO92vlTxjhxlQXUMclfq8asTojFJdlxCpuPMKT8Le
 S41cYjoUgnmNBYv1bdMYRzKxry4J71dg9eFxzMbLKn/3UR9oORh4A6uNRQE0bHS8R3wi
 1rYl42vobqCM9lHhN/RINgPxg88H9n9epBMqvE2ZZXMYPYK0DjDCLm+Efu8779Ouizs+
 ThSw==
X-Gm-Message-State: AC+VfDyKBh/y0Di9BbhOJjMPZ/wEHD464njfBOxNzM9k6PJnfbMazZD1
 hbBDHqvDN4ROrfgnvr9POWcenw==
X-Google-Smtp-Source: ACHHUZ5ztqnXmOWVeHMo9AX27pm2UDTaMEZfkGTZKA3A/lNwdcu3OrUL22ohDZZafn4T/l+Z70bLPQ==
X-Received: by 2002:a05:6a00:2313:b0:650:21c0:70d6 with SMTP id
 h19-20020a056a00231300b0065021c070d6mr8017617pfh.15.1685761237109; 
 Fri, 02 Jun 2023 20:00:37 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:66a6:82c2:d794:68f6?
 ([2602:ae:1598:4c01:66a6:82c2:d794:68f6])
 by smtp.gmail.com with ESMTPSA id
 c14-20020aa78e0e000000b0063d24fcc2besm1565158pfr.125.2023.06.02.20.00.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 20:00:36 -0700 (PDT)
Message-ID: <42a13e2c-7fef-a2a4-3ef6-d0ca0c0bdd6e@linaro.org>
Date: Fri, 2 Jun 2023 20:00:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC v2] linux-user/riscv: Add syscall riscv_hwprobe
Content-Language: en-US
To: Andrew Jones <ajones@ventanamicro.com>, Robbin Ehn <rehn@rivosinc.com>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu, qemu-riscv@nongnu.org
References: <f59f948fc42fdf0b250afd6dcd6f232013480d9c.camel@rivosinc.com>
 <20230602-86a3d8d9fad1fb3464d28702@orel>
 <024ee92f725f4ffd2952f472861ba9b415f4cde3.camel@rivosinc.com>
 <20230602-6e13ca96e3e8064c96abf9bf@orel>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230602-6e13ca96e3e8064c96abf9bf@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 6/2/23 08:07, Andrew Jones wrote:
> On Fri, Jun 02, 2023 at 04:39:20PM +0200, Robbin Ehn wrote:
>> On Fri, 2023-06-02 at 16:02 +0200, Andrew Jones wrote:
>>> On Fri, Jun 02, 2023 at 11:41:11AM +0200, Robbin Ehn wrote:
> ...
>>>> +#if defined(TARGET_RISCV)
>>>> +    case TARGET_NR_riscv_hwprobe:
>>>> +        {
>>>
>>> The { goes under the c of case, which will shift all the below four spaces
>>> left as well.
>>
>> This was an attempt to blend in, i.e. same style as the preceding case.
>> I'll change, thanks.
> 
> Hmm, I see. This function does have many cases with the indented format,
> but not all of them, and the rest of the code base doesn't indent. I won't
> insist on changing this, as long as checkpatch isn't complaining.

Splitting the entire thing out to a helper function is even cleaner.
We have lots of those, but certainly not universal.

I have, from time to time, tried to clean all of this up, but no one wanted to look at a 
100+ RFC patch set which only scratched the surface.


r~


