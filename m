Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A66178C4F7
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 15:16:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qayZt-0002CA-1X; Tue, 29 Aug 2023 09:16:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qayZo-00028c-ED
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 09:16:12 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qayZj-0000V6-G6
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 09:16:11 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-1c4c7a83bcdso3141544fac.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 06:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1693314965; x=1693919765;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x29g9NjIG8Vvnom/ZSmXbnn29dsJLv83xMLgsW7L9WA=;
 b=XSJG7hBhj5fff+ZPpCJ0R391UBMKoJdoNMHzCJeRz+PBaAKPiIgEzRhKB5TdESd9Pv
 u4/H3FpgsJVx+kMORICzPDKOtegaHD5MOFr2Cwjbua67/RIaBUEao0tiNjIB6JfPzQ2m
 t4FGL4DENRr9NUoSxb9jdh1cT0pKG+N1BCLxNEB4rIJqPzC8urZJXljuJMWiHx4XYpVN
 swdc4MgbQlBkn3Zm8rEK9JCVsrnZY/C+mG69BijUcOqYfAxVzE1sEjFYwMFq981boLPg
 4/41Vo6VtWfKSuB0IGZ4fYOtUqTZAHME7jRQjiY4WB8d5GjBh38tZcAKwC6T1dkh+lGT
 ZX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693314965; x=1693919765;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x29g9NjIG8Vvnom/ZSmXbnn29dsJLv83xMLgsW7L9WA=;
 b=AcuJYR2CCfRUl+qP155ve/3uqbpaTmPHYq5gaM4LRvewvsRxHO7VQ3p/tKae7Z/xSP
 Yn2Ml9y/9gb3hzNt2PZus4NgJZzqnF+bApseyyouAB2A67n3EqYalhusjf70dH9QJfS2
 7i4gjEfEn/p12cfgi1Wd/i7wx76LiB8xGxQmFy8JGKHDQfcIk1aBDiiuc4ND0i9jIZCp
 kp+eCSayBdbA1CCL+0cJlQCGvXZFbeqzAgsXA/uqeLbA25jZ98BI7+gnLAeApp8bsbYW
 +R0CaDx4op92owg1jrkS0Gl2Wjx8HYIYzCS27wDe03g5CC7LdsEenFqH0Ej9cBd4HnMj
 /c/A==
X-Gm-Message-State: AOJu0YyjTvsyVAUePNgr5cUdTj348bS+dInayqQIVQ12hTXmJCOFnLsf
 Y2Gi+IhcYglccbnPGMM2l/6Giw==
X-Google-Smtp-Source: AGHT+IFKkn4g0RS60OegR3VbZf0hkVuLTX5XSuYklz1V5FYvnDmgLYMY1jIkW11Gji06IICq9hX+Bg==
X-Received: by 2002:a05:6871:553:b0:1c4:d735:38e9 with SMTP id
 t19-20020a056871055300b001c4d73538e9mr14981792oal.57.1693314965650; 
 Tue, 29 Aug 2023 06:16:05 -0700 (PDT)
Received: from [192.168.68.108] ([177.94.15.194])
 by smtp.gmail.com with ESMTPSA id
 h5-20020a056870538500b001babd036460sm5475116oan.19.2023.08.29.06.16.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 06:16:05 -0700 (PDT)
Message-ID: <f58ac06f-ec38-0814-748f-9ce2b36b644d@ventanamicro.com>
Date: Tue, 29 Aug 2023 10:16:00 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 11/20] target/riscv: introduce KVM AccelCPUClass
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
References: <20230825130853.511782-1-dbarboza@ventanamicro.com>
 <20230825130853.511782-12-dbarboza@ventanamicro.com>
 <ce33b3b2-564e-a8c5-dfc8-ae7f6644dc88@linaro.org>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <ce33b3b2-564e-a8c5-dfc8-ae7f6644dc88@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x29.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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



On 8/28/23 13:38, Philippe Mathieu-Daudé wrote:
> On 25/8/23 15:08, Daniel Henrique Barboza wrote:
>> Add a KVM accelerator class like we did with TCG. The difference is
>> that, at least for now, we won't be using a realize() implementation for
>> this accelerator.
>>
>> We'll start by assiging kvm_riscv_cpu_add_kvm_properties(), renamed to
>> kvm_cpu_instance_init(), as a 'cpu_instance_init' implementation. Change
>> riscv_cpu_post_init() to invoke accel_cpu_instance_init(), which will go
>> through the 'cpu_instance_init' impl of the current acceleration (if
>> available) and execute it. The end result is that the KVM initial setup,
>> i.e. starting registers and adding its specific properties, will be done
>> via this hook.
>>
>> riscv_cpu_add_user_properties() is still being called via the common
>> post_init() function, thus we still need the "if kvm then return" logic
>> inside it for now. We'll deal with it when TCG accel class get its own
>> 'cpu_instance_init' implementation.
>>
>> riscv_add_satp_mode_properties() is now being exported from cpu.c since
>> it's a common helper between KVM and TCG.
>>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   target/riscv/cpu.c       |  8 ++---
>>   target/riscv/cpu.h       |  1 +
>>   target/riscv/kvm.c       | 64 +++++++++++++++++++++++++++-------------
>>   target/riscv/kvm_riscv.h |  1 -
>>   4 files changed, 49 insertions(+), 25 deletions(-)
> 
> 
>> -static void riscv_add_satp_mode_properties(Object *obj)
>> +void riscv_add_satp_mode_properties(Object *obj)
>>   {
>>       RISCVCPU *cpu = RISCV_CPU(obj);
>> @@ -1199,6 +1199,8 @@ static void riscv_cpu_post_init(Object *obj)
>>       RISCVCPU *cpu = RISCV_CPU(obj);
>>       RISCVCPUClass *rcc = RISCV_CPU_GET_CLASS(cpu);
>> +    accel_cpu_instance_init(CPU(obj));
>> +
>>       if (rcc->user_extension_properties) {
>>           riscv_cpu_add_user_properties(obj);
>>       }
>> @@ -1561,12 +1563,10 @@ static void riscv_cpu_add_multiext_prop_array(Object *obj,
>>   static void riscv_cpu_add_user_properties(Object *obj)
>>   {
>>   #ifndef CONFIG_USER_ONLY
>> -    riscv_add_satp_mode_properties(obj);
>> -
>>       if (kvm_enabled()) {
>> -        kvm_riscv_cpu_add_kvm_properties(obj);
>>           return;
>>       }
> 
> Maybe in a preliminary patch:
> 
> if (tcg_enabled()) {
> 
>> +    riscv_add_satp_mode_properties(obj);
> 
> }
> 
> then remove the 'if kvm_enabled' in this patch?

I'll add a preliminary patch to make kvm_riscv_cpu_add_kvm_properties() call
riscv_add_satp_mode_properties() and change the order they're being called here
(i.e. call kvm_riscv_cpu_add_kvm_properties() first). Then this patch can safely
remove the 'if kvm_enabled' block as you suggested.


Thanks,

Daniel


> 
>>   #endif
> 

