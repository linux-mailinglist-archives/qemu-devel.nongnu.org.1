Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2019E777EB7
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 19:02:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU92y-0004LB-4T; Thu, 10 Aug 2023 13:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qU92s-0004KR-NX
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 13:01:59 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qU92r-00059B-2T
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 13:01:58 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1bba48b0bd2so8685265ad.3
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 10:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691686915; x=1692291715;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C1Jlf91BI9+pnbD1iVp4V+lXHBleNlxeJ8wB8wOxR44=;
 b=Uqvls/yrkUNM2yKwScYWcA20luF1lJyVB3CwaCAf2zsEUJ4wkD6jHwpaD9mUvGutGU
 52ZvO/jeqUMtjqjSQ8Ioe7dqCrTHx3aaENugJVWR9561jsIkTde+dduchgE30NK+LZSg
 BGNvfSdI7vVjxs44jH+l8Z+xEjSGJ2rFvcmgi/8QOUmc7PU21M3Om6lJzF+p8eZ7NLZl
 i86wAP0Kz8b3rQCWTb50dRUWoNnD2SY3+OwIBXa4h7QMwmK73JbieATBUG9QSODwRf5E
 HLn/YWJE20YQpW+AaNeZG3Ef5O22kBT3IaSz8i3O/cI4Gw280Z7OSCKlmvYrLxImtgie
 +S1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691686915; x=1692291715;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C1Jlf91BI9+pnbD1iVp4V+lXHBleNlxeJ8wB8wOxR44=;
 b=Pn4cXJssWTVLxe4RLUctr/jLv5cSEw9t/uxpcxXvMB9fYXbIie0Q2AQlGY+sXfsuC3
 LoM++tg7biiM64l8G55G/QvbHssvFRl1u/tMRwD/iP3SGkdHP5QJ6jWOt/PjwdyQ9AhR
 T5ONMjtd6fhy82H4zORKH6V9MggD5ybLO3mXwrNyngen3+NXS1S5z9MqQgARipFqvZh8
 VKKgzbyMdxvSwLr6xcNP3T7+hPeI/JRcb3sfyAgEjCMEaw4dWlfesdzLhW6vJw7wks24
 6cbBokuP5LnsFmCh3rJLAGgMXBkY/75/FPYTCirA4LcLCKUcKogIBJ0e7a35gGYlsQ9u
 p7hQ==
X-Gm-Message-State: AOJu0YzLryfLNqapMfhn9i9olbs9DP7n6GGPPw7JVoEIgnozL7rzG9k1
 JaI6IaKc609a2nE+ZOKHF/aDQQ==
X-Google-Smtp-Source: AGHT+IFQ2vydgzfUBgZoAsmXE7Dt9Baz8287uLKYQSLS+ddt8+tPvPUVcq9w/ApziBh0bqJbDRLkmA==
X-Received: by 2002:a17:902:a414:b0:1bd:b0b8:623f with SMTP id
 p20-20020a170902a41400b001bdb0b8623fmr784855plq.11.1691686915012; 
 Thu, 10 Aug 2023 10:01:55 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:9e4d:b830:d4fd:9164?
 ([2602:47:d483:7301:9e4d:b830:d4fd:9164])
 by smtp.gmail.com with ESMTPSA id
 h17-20020a170902f7d100b001bb889530adsm2024032plw.217.2023.08.10.10.01.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Aug 2023 10:01:54 -0700 (PDT)
Message-ID: <71a7293a-6cda-c195-8c84-55b40f1fca57@linaro.org>
Date: Thu, 10 Aug 2023 10:01:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 12/24] tcg/aarch64: Implement negsetcond_*
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
References: <20230808031143.50925-1-richard.henderson@linaro.org>
 <20230808031143.50925-13-richard.henderson@linaro.org>
 <CAFEAcA9dqnaqGrLz804UB8zHSnbCEWwhv1nzvdt_j0CS3=mCSg@mail.gmail.com>
 <6dbafe59-f7ce-12f6-e8c7-eefc7665f598@linaro.org>
 <CAFEAcA8j=AejoxGSO7wKQH9uM68jpL59KrgfSCQj78-sY3yxjw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA8j=AejoxGSO7wKQH9uM68jpL59KrgfSCQj78-sY3yxjw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.156,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

On 8/10/23 09:58, Peter Maydell wrote:
> On Thu, 10 Aug 2023 at 17:55, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 8/10/23 09:39, Peter Maydell wrote:
>>>> +    case INDEX_op_negsetcond_i32:
>>>> +        a2 = (int32_t)a2;
>>>> +        /* FALLTHRU */
>>>
>>> I see this is what we already do for setcond and movcond,
>>> but how does it work when the 2nd input is a register?
>>> Or is reg-reg guaranteed to always use the _i64 op?
>>
>> For reg-reg, a2 < 31, so the sign-extend does nothing.
> 
> OK. Do we document somewhere what a TCGArg is?

No.  I should do that...


r~


