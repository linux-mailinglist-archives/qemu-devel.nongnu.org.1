Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C06F7D35DA
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 13:54:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qutUF-0000Nc-UQ; Mon, 23 Oct 2023 07:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qutUE-0000MY-3L
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 07:52:46 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qutUC-0007iM-H8
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 07:52:45 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-27dc1e4d8b6so2741772a91.0
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 04:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698061962; x=1698666762; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XtI0/mEmOegOjjoOpy6VkDZ4kolqZB5mAfMlHJhuaqw=;
 b=XMbH871e/ldfMLPdGC1aNT8vqRZGbg4nnD2WhyaiZNQsRaYziSeFuWowax7uoMC5s5
 CRahftWcAEk6ohliOq6KpIGQKL4JkQQ1iAeBWjdXCf/SNvnLwCbON1mqr8u3R0av5o7A
 7h95XwPeac/2BtnKWAwV8B+Sit+VqP+UyfXDSrzi6jbwpqhutiWtINBBCT4iLstMwgBH
 Q4L6BJfgfFCIwpbzwRGaeMc8SM1RgW+7G0gkveAb520MlJGXiyBXoROtDfaSv3/SzjR1
 NmB3fSHGvGTZ78NUwV0SxVnhrTCTcM2OZV7OMP/MJ4NuSsIfJtuqQvFsQgLQSwWRZ9k3
 ac4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698061962; x=1698666762;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XtI0/mEmOegOjjoOpy6VkDZ4kolqZB5mAfMlHJhuaqw=;
 b=NK75y3+wfpSDLC5d5y260/lbqwVKSQ5VRs8LqvZj4srNEaPV2dnpWE5+XEDE4jhSr3
 j9/WkoOxRKzWcW1Bh9KjDv38JlFV64YVPFVbZ76WrFRssgq47hzKElBpISEBCxDMKB0b
 kv52b3jZiJaoACF66ZyX5MrwCTs64PyI5u3pbaexZhOwnGsMBy7+GRmbcdut6MbOO6Vl
 uVzqHFNEZpdlFbtnLv1qfN3eOOpSSbh8JGvHZrOrJLqg41kyMI1XIsX1mmT3fS+DVI+e
 caQrTXmMGuEjZkvYy59PuofRNNB5R6y9ejkpCKQlom0rJFMPGTy5cZiLdHdEAbs/Rx3Q
 XzFQ==
X-Gm-Message-State: AOJu0Yxgk9xo8KCY+e3pRM8hyh3TqqkDTR1Bxm0xxD+fEIJObw78bifa
 6H+i2u0Xl7J2szVhtuHe0T6+Og==
X-Google-Smtp-Source: AGHT+IGNrrL0ck+DtHZiN74zoI8XtOf3c7gc270JU9/ZT8Y28AEhdI60rWPXoY7JiB9VrNp7XYia1w==
X-Received: by 2002:a17:90b:46c2:b0:27d:4283:b8a2 with SMTP id
 jx2-20020a17090b46c200b0027d4283b8a2mr8452861pjb.14.1698061962516; 
 Mon, 23 Oct 2023 04:52:42 -0700 (PDT)
Received: from [192.168.68.107] ([191.255.2.33])
 by smtp.gmail.com with ESMTPSA id
 t19-20020a1709028c9300b001b567bbe82dsm5746574plo.150.2023.10.23.04.52.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Oct 2023 04:52:42 -0700 (PDT)
Message-ID: <32e86f5b-ac1d-40a0-940f-6c3427584923@ventanamicro.com>
Date: Mon, 23 Oct 2023 08:52:38 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] target/riscv/tcg: add ext_zicntr disable support
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com,
 palmer@rivosinc.com
References: <20231017221226.136764-1-dbarboza@ventanamicro.com>
 <20231017221226.136764-3-dbarboza@ventanamicro.com>
 <CAKmqyKPn+t0WH+mztkMfT73Efoch-=21QcV782q8h7S-aaTm4g@mail.gmail.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <CAKmqyKPn+t0WH+mztkMfT73Efoch-=21QcV782q8h7S-aaTm4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 10/22/23 23:54, Alistair Francis wrote:
> On Wed, Oct 18, 2023 at 8:13 AM Daniel Henrique Barboza
> <dbarboza@ventanamicro.com> wrote:
>>
>> Support for the zicntr counters are already in place. We need a way to
>> disable them if the user wants to. This is done by restricting access to
>> the CYCLE, TIME, and INSTRET counters via the 'ctr()' predicate when
>> we're about to access them.
>>
>> Disabling zicntr happens via the command line or if its dependency,
>> zicsr, happens to be disabled. We'll check for zicsr during realize() and,
>> in case it's absent, disable zicntr. However, if the user was explicit
>> about having zicntr support, error out instead of disabling it.
>>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> 
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> 
> This should come before we expose the property to users though

I'll merge this patch with patch 1. Same thing with patch 4 and 5.


Thanks,

Daniel

> 
> Alistair
> 
>> ---
>>   target/riscv/csr.c         | 4 ++++
>>   target/riscv/tcg/tcg-cpu.c | 8 ++++++++
>>   2 files changed, 12 insertions(+)
>>
>> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
>> index a5be1c202c..05c6a69123 100644
>> --- a/target/riscv/csr.c
>> +++ b/target/riscv/csr.c
>> @@ -122,6 +122,10 @@ static RISCVException ctr(CPURISCVState *env, int csrno)
>>
>>       if ((csrno >= CSR_CYCLE && csrno <= CSR_INSTRET) ||
>>           (csrno >= CSR_CYCLEH && csrno <= CSR_INSTRETH)) {
>> +        if (!riscv_cpu_cfg(env)->ext_zicntr) {
>> +            return RISCV_EXCP_ILLEGAL_INST;
>> +        }
>> +
>>           goto skip_ext_pmu_check;
>>       }
>>
>> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
>> index bbce254ee1..a01b876621 100644
>> --- a/target/riscv/tcg/tcg-cpu.c
>> +++ b/target/riscv/tcg/tcg-cpu.c
>> @@ -541,6 +541,14 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>>           cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zksh), true);
>>       }
>>
>> +    if (cpu->cfg.ext_zicntr && !cpu->cfg.ext_zicsr) {
>> +        if (cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_zicntr))) {
>> +            error_setg(errp, "zicntr requires zicsr");
>> +            return;
>> +        }
>> +        cpu->cfg.ext_zicntr = false;
>> +    }
>> +
>>       /*
>>        * Disable isa extensions based on priv spec after we
>>        * validated and set everything we need.
>> --
>> 2.41.0
>>
>>

