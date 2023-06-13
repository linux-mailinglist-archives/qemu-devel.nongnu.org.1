Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EF472E1CF
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 13:38:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q91HS-000220-4f; Tue, 13 Jun 2023 06:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q91HQ-00021e-31
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 06:29:40 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q91HI-00058m-KY
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 06:29:39 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-19f3550bcceso3463274fac.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 03:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1686652167; x=1689244167;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a+Mfnoeh3AOyFqTecqx2KAWybt2AcUf0LkdEU9CaN2o=;
 b=OteUh0oLfs07ovhIF2f4ZMm56/8yxU9RnXHaERgKgTviJWUHyJbcSbfAJRRm6YtzYX
 MOfxKQXz2tvjLuOxMIwc82a7fNC815Bikx8L/5dInBz3zPFOeSOr3sf+Q12y3I6vb4Ci
 HA5qrN+kSvke2CpAKX1MLDNH9yNnJuEyVYAmS9uFhOCh6KO+xG+JVkbDDhDkLZCFWkQ2
 nDb3tOYuIvqjnTn1R7pXmGIx+4UIbiRIXqCmBhbygiyJOaRbHGrgqLlLfrnWgDYC7BCp
 3b3+w/xyygskV6GYUE2Fy7fx0KD2hIUrPkXdBgNQ+HOYV95qA2j4KFN1Y0MPXc2u84jn
 l1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686652167; x=1689244167;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a+Mfnoeh3AOyFqTecqx2KAWybt2AcUf0LkdEU9CaN2o=;
 b=WQv0IYRbtOPiUxvKtbrVXLAU1noPhP7ZcuSTuxpxIpZ0CRNW94xq76AcmP/VwXZ0fa
 vcotIrTf8oh2qtrs3uU7YalX+zo9OjQmNVRxy1H/mNkoIP4qY0qxwM/MzGyAWdJ/Vi7k
 1bt1KDqpRKyJQxMMTtK04sqzPxYh8nLDW37e3ft4u2jzzBSilVajLn0rxYXe+ECkjHKV
 LeXOAQPI+kH9PmO27Hz1Z5xcr5RSxwsWlZxNQo4BqA3NLOcZ4aKMm1xurpRO/ttWROjN
 hCtR+A8HpadWwuUR4mfv8Qrs4uOxWQJCXBFzTMo9SdsCebXPGywnY0t64nhNM0j/mKii
 DHjA==
X-Gm-Message-State: AC+VfDwdSItXeR/A+XCN0GrxwbDQBgzOM+2GWOobUIyqvF6JR8bTqb10
 2y0I2NrBl9Hv56A69B7+EVSHPg==
X-Google-Smtp-Source: ACHHUZ6pbSij34BScex3qXFzZ6B6G3EzWqa0myZ25D387FThTs9KMrXJRMGc4JwRvesrka+x5AnxDg==
X-Received: by 2002:a05:6870:d246:b0:177:a158:9ef6 with SMTP id
 h6-20020a056870d24600b00177a1589ef6mr8517369oac.52.1686652167556; 
 Tue, 13 Jun 2023 03:29:27 -0700 (PDT)
Received: from [192.168.68.107] ([177.170.117.210])
 by smtp.gmail.com with ESMTPSA id
 y39-20020a056870b4a700b0019e59515a0bsm7040875oap.33.2023.06.13.03.29.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jun 2023 03:29:27 -0700 (PDT)
Message-ID: <7a4217e2-163b-8e2d-e86b-97fb0733fef3@ventanamicro.com>
Date: Tue, 13 Jun 2023 07:29:23 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 14/16] target/riscv: adapt 'riscv_isa_string' for KVM
Content-Language: en-US
To: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com,
 palmer@rivosinc.com
References: <20230530194623.272652-1-dbarboza@ventanamicro.com>
 <20230530194623.272652-15-dbarboza@ventanamicro.com>
 <20230607-8e2b65e6a054c4f5f2962e85@orel>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20230607-8e2b65e6a054c4f5f2962e85@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x2a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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



On 6/7/23 09:21, Andrew Jones wrote:
> On Tue, May 30, 2023 at 04:46:21PM -0300, Daniel Henrique Barboza wrote:
>> KVM is not using the same attributes as TCG, i.e. it doesn't use
>> isa_edata_arr[]. Add a new kvm_riscv_isa_string_ext() helper that does
>> basically the same thing, but using KVM internals instead.
>>
>> The decision to add this helper target/riscv/kvm.c is to foster the
>> separation between KVM and TCG logic, while still using
>> riscv_isa_string_ext() from target/riscv/cpu.c to retrieve the string
>> to not overcomplicate things.
>>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   target/riscv/cpu.c       |  5 +++++
>>   target/riscv/kvm.c       | 19 +++++++++++++++++++
>>   target/riscv/kvm_riscv.h |  2 ++
>>   3 files changed, 26 insertions(+)
>>
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index 3c348049a3..ec1d0c621a 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -1956,6 +1956,11 @@ static void riscv_isa_string_ext(RISCVCPU *cpu, char **isa_str,
>>       char *new = *isa_str;
>>       int i;
>>   
>> +    if (riscv_running_KVM()) {
>> +        kvm_riscv_isa_string_ext(cpu, isa_str, max_str_len);
>> +        return;
>> +    }
>> +
>>       for (i = 0; i < ARRAY_SIZE(isa_edata_arr); i++) {
>>           if (cpu->env.priv_ver >= isa_edata_arr[i].min_version &&
>>               isa_ext_is_enabled(cpu, &isa_edata_arr[i])) {
>> diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
>> index b4193a10d8..675e18df3b 100644
>> --- a/target/riscv/kvm.c
>> +++ b/target/riscv/kvm.c
>> @@ -320,6 +320,25 @@ static void kvm_riscv_add_cpu_user_properties(Object *cpu_obj)
>>       }
>>   }
>>   
>> +void kvm_riscv_isa_string_ext(RISCVCPU *cpu, char **isa_str,
>> +                              int max_str_len)
>> +{
>> +    char *old = *isa_str;
>> +    char *new = *isa_str;
>> +    int i;
>> +
>> +    for (i = 0; i < ARRAY_SIZE(kvm_multi_ext_cfgs); i++) {
>> +        RISCVCPUMultiExtConfig *multi_ext_cfg = &kvm_multi_ext_cfgs[i];
>> +        if (kvm_cpu_cfg_get(cpu, multi_ext_cfg)) {
>> +            new = g_strconcat(old, "_", multi_ext_cfg->name, NULL);
>> +            g_free(old);
>> +            old = new;
>> +        }
>> +    }
>> +
>> +    *isa_str = new;
>> +}
>> +
>>   static int kvm_riscv_get_regs_core(CPUState *cs)
>>   {
>>       int ret = 0;
>> diff --git a/target/riscv/kvm_riscv.h b/target/riscv/kvm_riscv.h
>> index e3ba935808..1a12efa8db 100644
>> --- a/target/riscv/kvm_riscv.h
>> +++ b/target/riscv/kvm_riscv.h
>> @@ -20,6 +20,8 @@
>>   #define QEMU_KVM_RISCV_H
>>   
>>   void kvm_riscv_init_user_properties(Object *cpu_obj);
>> +void kvm_riscv_isa_string_ext(RISCVCPU *cpu, char **isa_str,
>> +                              int max_str_len);
>>   void kvm_riscv_reset_vcpu(RISCVCPU *cpu);
>>   void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level);
>>   
>> -- 
>> 2.40.1
>>
>>
> 
> Hmm, more duplication. I think we need an abstraction which can support
> both TCG and KVM extension lists. Allowing functions like
> riscv_isa_string_ext() to be shared for them.

I tried to play around a bit and didn't manage to find a solution that covers
both.

The root cause is that the TCG only options are being ignored by KVM, but they
are still around. I made an attempt of re-using the existing isa_string()
function with KVM by changing all TCG-only extensions default to 'false'. This
doesn't change the fact that, with KVM, I can do:

sudo ./qemu/build/qemu-system-riscv64  -machine virt,accel=kvm \
-cpu host,zhinx=true,zhinxmin=true (...)

Note that zhinx and zhinxmin are TCG-only. And the ISA string showed these 2
extensions:

# cat /proc/device-tree/cpus/cpu@0/riscv,isa
rv64imafdc_zicbom_zicboz_zbb_zhinx_zhinxmin_sstc


Alternatives would be to change TCG code to allow for extra fields for KVM (e.g. the
'supported' flag) to allow the isa_string() function to ignore the TCG-only extensions.
Bear in mind that TCG has 63 extensions, so we would do 63 ioctls for each CPU in this
extension discovery and KVM only 8 support extensions ATM.

Another idea is to make the existing isa_string() compare isa_edata_arr[] with the
KVM counterpart kvm_multi_ext_cfgs[] and, if running KVM, check if the extension
in isa_edata_arr[] is also in the KVM array. This also seems a bit inefficient since
we're adding a search loop for 55 extensions when creating the string.

Another alternative is to exclude all TCG-only extensions from the command line when
running KVM. We would fork the API though, which is something that we're wanting to
avoid.

Duplicating this code as we're doing here guarantees that the KVM isa string won't
have anything that KVM doesn't know about, regardless of the user input. I am not a
fan of duplication, but at this moment it seems plausible to keep it. At least until
we sort a way of unifying both TCG and KVM options in a satisfying manner.

I mean, at least as far as a I can see. Suggestions always welcome.


Thanks,


Daniel




> 
> Thanks,
> drew

