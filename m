Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 073C799DA05
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Oct 2024 01:14:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0UFt-0007pW-Dl; Mon, 14 Oct 2024 19:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t0UFr-0007pN-2m
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 19:13:35 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t0UFo-0005tF-BD
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 19:13:34 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7ea7ad1e01fso1214097a12.0
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 16:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728947611; x=1729552411; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7xKqYDdi2F1wIiWEqQxVVyXsDabCbw5l6EFGqv/RpBQ=;
 b=KM4fJqOLxeOCq7inxFI7X9oAJveaVm/YZ2fCXhDzZvVqWcQ6InUIBT5fcR6/HyV4Fu
 Ddq8m97JQt+5l9jEl90uMGBN1yEJaLdYhRv2ILmrE6ur9D0fs5VZQk76ecHjGF3i2s5+
 nROuZbMcu8nbI9DgxFAuaEoZhLP/72B3Ki4CGAD4w7u5nZx4dhDCWQusqM8hCSXldcJa
 VEm5fIU/vPrNvgHgd4+8FFOKBY3gB7TnDXSpyen0nZpqDXCU5Aq59XI60XciMeLbhdNF
 D04NufujUSqLqid7irVtljvgyvX3K0HNRR82YS83BTansaPZI0Th4gxc80VrrtMF5pTW
 ZJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728947611; x=1729552411;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7xKqYDdi2F1wIiWEqQxVVyXsDabCbw5l6EFGqv/RpBQ=;
 b=vzGoz8aw+IIF89Bxlejz5aiVB+qB5+jB7b9DpM8xtbZfaX74w354JziVDtoWTJ6jvn
 EAofJFEUd3UjpMAbQDk4FPvcKC/KfhkICWuEBmx1zLpmchEY/UXEKLIsUz+Sx20FknHZ
 1TbiqEVFFL7IAjUlV8FlL++D5tsO0KplUSi7jqMoeIXUejJfzEVhYLjdD0u1yFW+SZyY
 8ilJN/aVbmV5fl8BOOJWiIplikwBupVHqBFJg3HcV+25BffhpEjZFEq2V8JjytW373/p
 8v1cTEdXjqrPjnoF3NCFMJ03LOzq3occ1h4Etr1ZRmJn1a7mt3VzHcjBpOlAsszzbZ1W
 RTRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRu2SQoHw+R/MN0k3OgpaG2eTMVMzYxuFBrSBMzN5+xGY7hYnlv6pL66gFzRQbuKnVYTYjIhdqcox3@nongnu.org
X-Gm-Message-State: AOJu0YxY1Ph7A+wAsWiCHGyUuiAXpo8GJdtEuWy98jVxA5O8VXmnIbsX
 BHM8FnbHKLfk/CZa6ETQLDaZ3VzCGeSwAsvD1zvxguKCIR4Ph2YeZmct3/e/ptM=
X-Google-Smtp-Source: AGHT+IFJWt/p9LpRYNW8zGelQ2FRWVTsKwvc+KvVWUukiAorE+rWXwuVY1eT1V8QxG70hiAi1C575w==
X-Received: by 2002:a05:6a21:a4c2:b0:1d5:143d:5197 with SMTP id
 adf61e73a8af0-1d8bc8066e8mr17137593637.6.1728947610736; 
 Mon, 14 Oct 2024 16:13:30 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e774a42cfsm68295b3a.109.2024.10.14.16.13.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Oct 2024 16:13:30 -0700 (PDT)
Message-ID: <a3a9667c-5f02-4963-bdf9-ddf6aa164224@linaro.org>
Date: Mon, 14 Oct 2024 16:13:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/16] target/mips: Replace MO_TE by mo_endian()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, =?UTF-8?Q?Herv=C3=A9_Poussineau?=
 <hpoussin@reactos.org>, Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
References: <20241010215015.44326-1-philmd@linaro.org>
 <20241010215015.44326-11-philmd@linaro.org>
 <040de42c-619b-4f69-87e2-fafae27fd8cc@linaro.org>
 <7ffd1d50-197c-4c8a-8362-4f16237366a7@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <7ffd1d50-197c-4c8a-8362-4f16237366a7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/14/24 15:18, Philippe Mathieu-Daudé wrote:
> On 13/10/24 13:05, Richard Henderson wrote:
>> On 10/10/24 14:50, Philippe Mathieu-Daudé wrote:
>>> +++ b/target/mips/tcg/msa_helper.c
>>> @@ -8213,7 +8213,7 @@ void helper_msa_ffint_u_df(CPUMIPSState *env, uint32_t df, 
>>> uint32_t wd,
>>>   #if !defined(CONFIG_USER_ONLY)
>>>   #define MEMOP_IDX(DF)                                                   \
>>> -    MemOpIdx oi = make_memop_idx(MO_TE | DF | MO_UNALN,                 \
>>> +    MemOpIdx oi = make_memop_idx(mo_endian(dc) | DF | MO_UNALN,                 \
>>>                                    mips_env_mmu_index(env));
>>>   #else
>>
>> This one is not within a translation context.
>> Surely this should be mo_endian_env().
>>
>> I would have expected this not to compile?
> 
> Dead code since commit 948f88661c6 ("target/mips: Use cpu_*_data_ra
> for msa load/store"):
> 
> $ git grep -w MEMOP_IDX
> target/mips/tcg/msa_helper.c:8215:#define MEMOP_IDX(DF)                                  \
> target/mips/tcg/msa_helper.c:8219:#define MEMOP_IDX(DF)
> 
> I'll send a cleanup patch removing the #define lines.

Ah, excellent.

> Might I use your R-b tag on this patch, removing the tcg/msa_helper.c change?

Yes.

r~

