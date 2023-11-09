Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2910D7E6D68
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 16:26:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r16vP-0004Oj-5e; Thu, 09 Nov 2023 10:26:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r16vL-0004Ig-84
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 10:26:27 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r16v1-0002C9-SH
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 10:26:26 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-53b32dca0bfso2105213a12.0
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 07:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699543565; x=1700148365; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PbB6rYFySaBCLBKmB9uJ/vqw8jOjEghYI3hQo+wrxDk=;
 b=hJhbdtTl6RNGobVTsuwA7Gd/MVPFIRmYjTJneWovnGxadX3d30PHZFSPLqNEIZTA7B
 8ZeXwKO7wZGPiBJxwCJ+T2FRBfYnhq+/bhVcUmSJ8F2DQwRRYDM/VlAkiRCsbbv9gslU
 mxsFIWrzDUxiwrzTbgs214kjEUudPtmoxOuHVo0MAEBlwC5YQJEfxbYiQN+mEiIHr1qg
 jRktpwsv9S9AZ8j7PE5TF1ycADIpqPAOGcfe/58QlgsYwAGo0obcJ3ViW5gZNE7fIl1z
 Y983e7UbakD7j5f/GIfMkSV7KRlNKD+TyCY7tjeGzKID0HOgbhhWXWzeNA8pNUUi7FB7
 2pxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699543565; x=1700148365;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PbB6rYFySaBCLBKmB9uJ/vqw8jOjEghYI3hQo+wrxDk=;
 b=GNvEfQKy9UoivwxWgeFiTzyplASqAFx92YyD7+Rel4Hmj2zpBzuep+l4v9iqRLVzCr
 /nNM3lBjCDhefW9SC3my1CMzG7bMV2WgM2vx93BtnTFceResAyb/KjN8AXsoJl/0dTsz
 efNokh5EhSxEs6J4FVyYhD9z5wJvZJzyGgFBwl/oD06tnYnE3DjhHm57yjChhtnT5we8
 k0N8b+ElIR9aVZwaSZdblYsFKRzuN2Oj3ddcmbAUtPHGNEvL1CgVEAFn6Af6zbOjRJp1
 qdU1u1hI2BWFIWwOpHQLL2TJqpGLjRNRvAnu3M7vMA5NlPQqfraGPTqnc9B1OEf0eM91
 sTbw==
X-Gm-Message-State: AOJu0Yw7TiR8AcCjgggEl0U+3Pzw3Y7P00tSLDnhCzCC+fVou4evswsh
 asMHslsXwKvtF/TIvHWfWOVuBQ==
X-Google-Smtp-Source: AGHT+IHyXlAGUG9fsEYNjFQ5Jb36GpccFmIrqf0iIU0r0YEqqKHB/aI6G/bn8Y2uXXdwrFIMvgYMeQ==
X-Received: by 2002:a05:6402:17c9:b0:52e:3ce8:e333 with SMTP id
 s9-20020a05640217c900b0052e3ce8e333mr5224257edy.18.1699543565341; 
 Thu, 09 Nov 2023 07:26:05 -0800 (PST)
Received: from [192.168.69.115] ([176.187.199.161])
 by smtp.gmail.com with ESMTPSA id
 g15-20020a50d0cf000000b0053e408aec8bsm8486932edf.6.2023.11.09.07.26.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Nov 2023 07:26:04 -0800 (PST)
Message-ID: <bf0c7c6d-a940-4968-ab18-4af6125b8d0b@linaro.org>
Date: Thu, 9 Nov 2023 16:26:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] hw/intc/riscv_aclint:Change the way to get CPUState
 from hard-base to pu_index
Content-Language: en-US
To: Dongxue Zhang <elta.era@gmail.com>, Leo Hou <LeoHou@canaan-creative.com>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Anup Patel <apatel@ventanamicro.com>, Bin Meng <bin.meng@windriver.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Leo Hou <houyingle@canaan-creative.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Palmer Dabbelt <palmer@rivosinc.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-riscv <qemu-riscv@nongnu.org>
References: <cover.1699496263.git.houyingle@canaan-creative.com>
 <6d1d8cc8c2b37b145e4a826095619097fa4a34d5.1699496263.git.houyingle@canaan-creative.com>
 <CAEomy4TmM0ShGkuV2mprB8Xm0Kn62ZWZA7Gnfvt07pioY9fCCA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAEomy4TmM0ShGkuV2mprB8Xm0Kn62ZWZA7Gnfvt07pioY9fCCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Leo,

First, I can't find your patch in my mailbox, so I'm replying to
Dongxue's review.

On 9/11/23 03:41, Dongxue Zhang wrote:
> Reviewed-by: Dongxue Zhang <zhangdongxue@canaan-creative.com>
> 
> 
> On Thu, Nov 9, 2023 at 10:22 AM Leo Hou <LeoHou@canaan-creative.com> wrote:
>>
>> From: Leo Hou <houyingle@canaan-creative.com>
>>
>> cpu_by_arch_id() uses hartid-base as the index to obtain the corresponding CPUState structure variable.
>> qemu_get_cpu() uses cpu_index as the index to obtain the corresponding CPUState structure variable.
>>
>> In heterogeneous CPU or multi-socket scenarios, multiple aclint needs to be instantiated,
>> and the hartid-base of each cpu bound by aclint can start from 0. If cpu_by_arch_id() is still used
>> in this case, all aclint will bind to the earliest initialized hart with hartid-base 0 and cause conflicts.
>>
>> So with cpu_index as the index, use qemu_get_cpu() to get the CPUState struct variable,
>> and connect the aclint interrupt line to the hart of the CPU indexed with cpu_index
>> (the corresponding hartid-base can start at 0). It's more reasonable.
 >>
>> Signed-off-by: Leo Hou <houyingle@canaan-creative.com>
>> ---
>>   hw/intc/riscv_aclint.c | 16 ++++++++--------
>>   1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
>> index ab1a0b4b3a..be8f539fcb 100644
>> --- a/hw/intc/riscv_aclint.c
>> +++ b/hw/intc/riscv_aclint.c
>> @@ -130,7 +130,7 @@ static uint64_t riscv_aclint_mtimer_read(void *opaque, hwaddr addr,
>>           addr < (mtimer->timecmp_base + (mtimer->num_harts << 3))) {
>>           size_t hartid = mtimer->hartid_base +
>>                           ((addr - mtimer->timecmp_base) >> 3);
>> -        CPUState *cpu = cpu_by_arch_id(hartid);
>> +        CPUState *cpu = qemu_get_cpu(hartid);

There is some code smell here. qemu_get_cpu() shouldn't be called by
device models, but only by accelerators.

Maybe the timer should get a link of the hart array it belongs to,
and offset to this array base hartid?

I'm going to
NACK
this patch until further review / clarifications.

Regards,

Phil.

