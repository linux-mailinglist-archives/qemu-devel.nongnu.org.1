Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BFC70A29D
	for <lists+qemu-devel@lfdr.de>; Sat, 20 May 2023 00:02:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q08Al-0000xX-SK; Fri, 19 May 2023 18:02:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q08Aj-0000xB-38
 for qemu-devel@nongnu.org; Fri, 19 May 2023 18:02:01 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q08Af-0005MJ-Gk
 for qemu-devel@nongnu.org; Fri, 19 May 2023 18:01:59 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-64d3e5e5980so963078b3a.2
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 15:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684533716; x=1687125716;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TngQurTO/1HqFGCrSsTC6ORhJ3EKlTAeoMUBWa0y2IQ=;
 b=csS1lIlbID/GNz2v/DIcmXeNilZGeVSwBLfkrJboKYVKYtyBGSsvNv6nLosWW/mvbZ
 k1UcLOfwP4LfxJftUXtNwlCWIz6eAhOvoYlKfk/ksbZHYbk5L0hf6wVITTkWCmpzp9rZ
 geZfsq5IA+EAD0YMGSiOhvQzoyEygfRJhgVH0w14HFkw2TUi4YhsGAj41f+ug5ClHZSe
 fvbga04QS+FVr18+bGB1ts5sKbXe4wvrjvvRcPxrjkD96xJFtIxVKXhpSTDpCGVKIRLP
 tn3W5ynT6GdiDaazXyXwXcKbokIfqmuoGQQnxF4SE0VWvqUaqC8/P4k4f3SZcM4G6HI5
 PIAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684533716; x=1687125716;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TngQurTO/1HqFGCrSsTC6ORhJ3EKlTAeoMUBWa0y2IQ=;
 b=VLOjeyrqYRKl0cMiL9YIJ0sIhh8zPC0MopOjFkbCBjOZJmKJRXq0YM4WvbolpWA+eX
 taJPJ6TcdcKE0Ix0Sgapa6zHFRHdbKzz22X09d0pk/fUBocrC7iBmVB6Rp7M/YmabBda
 9zBzDrHfP6uPXtCLnXI5LV+QByrPfHReIzMAe0zakNUPvKvFFG8XB1AtAB7VWXWA5exM
 WqGE/Fwb98TFCBWIkkj5uNgvjH+WaJyv2FXAu7ozGFx7/+ZJV/uBWOYepEI4ofrUKlLF
 vD3dCnBPHqx3wPCbhG8dega66c6R65aC7fLEhCGpVUKngSMhs3NxRbn1lIoF8MJt+c14
 PUOw==
X-Gm-Message-State: AC+VfDxvoFI7V/Fx+L+leMWofCWOT84WA4HmFVDiJFi00GCdejHIQkug
 XRnczx5Kl8tDEPP2yQby4eff3w==
X-Google-Smtp-Source: ACHHUZ74NIxIjB4SoyTKXVkrNbnE8wAAOmBuN+syj97QIfxFVUbxu8Gfa/2Xntlbj5cYfPtZVbY3Gg==
X-Received: by 2002:a05:6a00:1a4f:b0:646:74ce:a36c with SMTP id
 h15-20020a056a001a4f00b0064674cea36cmr4927000pfv.8.1684533715900; 
 Fri, 19 May 2023 15:01:55 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:686f:d1bb:8fc4:dc38?
 ([2602:ae:1598:4c01:686f:d1bb:8fc4:dc38])
 by smtp.gmail.com with ESMTPSA id
 x18-20020aa79192000000b00642ea56f06dsm165292pfa.26.2023.05.19.15.01.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 May 2023 15:01:55 -0700 (PDT)
Message-ID: <c40211b7-478e-6a00-2cd3-b1d143169f91@linaro.org>
Date: Fri, 19 May 2023 15:01:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v11 00/14] TCG code quality tracking
Content-Language: en-US
To: "Wu, Fei" <fei2.wu@intel.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20230421132421.1617479-1-fei2.wu@intel.com>
 <87wn259n4g.fsf@linaro.org> <680395c1-8d8e-4f0d-f4eb-27cc0b15f033@intel.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <680395c1-8d8e-4f0d-f4eb-27cc0b15f033@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.527,
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

On 5/18/23 18:16, Wu, Fei wrote:
> On 4/22/2023 12:42 AM, Alex Bennée wrote:
>>
>> Fei Wu <fei2.wu@intel.com> writes:
>>
>>> This patch series were done by Vanderson and Alex originally in 2019, I
>>> (Fei Wu) rebased them on latest upstream from:
>>>      https://github.com/stsquad/qemu/tree/tcg/tbstats-and-perf-v10
>>> and send out this review per Alex's request, I will continue to address
>>> any future review comments here. As it's been a very long time and there
>>> are lots of conflicts during rebase, it's my fault if I introduce any
>>> problems during the process.
>>
>> Hi Fei,
>>
>> Thanks for picking this up. I can confirm that this applies cleanly to
>> master and I have kicked the tyres and things still seem to work. I'm
>> not sure if I can provide much review on code I wrote but a few things
>> to point out:
>>
>>    - there are a number of CI failures, mainly qatomic on 32 bit guests
>>      see https://gitlab.com/stsquad/qemu/-/pipelines/844857279/failures
>>      maybe we just disable time accounting for 32 bit hosts?
>>
> I sent out v12 series which fixes some CI failures. qatomic is not
> touched yet, the current code with CONFIG_PROFILER should have the same
> issue, what's the policy of 32 bit guests support on qemu?

They should work.

> Besides time, there are some other counters with uint64_t using qatomic
> such as TCGProfile.table_op_count, we might switch to size_t instead?

Probably.  You probably don't need to represent times as uint64_t (or time64_t), but as 
differentials for elapsed time.

We could accumulate into 'float' if you were concerned about overflowing 2^32 units.  This 
is statistics after all; we don't really need exact numbers, we need magnitude and 2-3 
digits of precision.


r~

