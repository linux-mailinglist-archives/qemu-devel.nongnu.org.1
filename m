Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1681D73B9AF
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 16:16:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qChZN-0005xi-7m; Fri, 23 Jun 2023 10:15:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qChYy-0005r5-7J
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 10:15:10 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qChYt-000353-Qg
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 10:14:59 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6b45803edfcso588465a34.3
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 07:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1687529690; x=1690121690;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UkU0gPbUQ0b+l9A5WnMZVBNWMdtrSCW5PnNLDkgFG00=;
 b=av5d0JQm0SDHDti3B0IoBddo9BGLUaeTi6zZZTxLBEXNudH9XGGSyo9LvSVf1HpfcA
 EkO0A6HyqlNfNWAOhqLR/0A/kuP+42Se9FlxQQcMeI48J5g6llF6aip3v2RF2TXbQaMk
 2EldTf0jYoJICZ3jA1VwVBV6eHW791PndDQzP+/2Qaah5UD01GAIchEuEUIZm/gOkJX4
 gTtLJlDgB9AX1fWIOe84eGak74LlIOiAuIt2U8OEROr7tYHcLBGAGoZhsfxPPLxhZ63G
 vmOZSUznk4DmKl4oOUJ1yt4J3ERkB7XROGlTaY/LmrefwXwYMPR4q7SIcP6afEphwTDT
 LlwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687529690; x=1690121690;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UkU0gPbUQ0b+l9A5WnMZVBNWMdtrSCW5PnNLDkgFG00=;
 b=bK5UvBIYHpabgaX7P95+u6fh+MgrIeAeznJI2ZJ2QQiA902PJx1TxNfD3o92JEWQ7j
 AHzcnau2pcxYdGPPwcjYYhzoP0DG1LMrubM1uJKib52yW9oStafo9jeiGmz0kohm2DkF
 4D1ACudnKHAARW4lldJ9dblwZpXHPz4YQDVrTUI0A7sMhug3NZunXU0QR9rT52ySFFSb
 vU8sWknJScyVBeii5NlR3KcBQJoS2cBtC3AJc1xn3rBb4RRzJMtTqdaxHUQzQWxbwdgT
 x6b+XwkdIQnVREB46Zw48yA5x+at40fHsNYgGjwzRb9w1dnK68fyGANSrUQDiT6g2J/v
 H2hQ==
X-Gm-Message-State: AC+VfDwKApHdKqoOckrda+9in3itFfsZ3FYDoixpntnDdJalO7JqImBi
 Ag8fzuDSaSjitb55cK96xxnraA==
X-Google-Smtp-Source: ACHHUZ57SkgvqwjiM0JLK7CqkbjveG1xX6pE4Jo15E/6PuCbq9X86FsOZ2LI+DBz5dYEAkI/aYFgmg==
X-Received: by 2002:a9d:6e14:0:b0:6b5:af89:a813 with SMTP id
 e20-20020a9d6e14000000b006b5af89a813mr8983843otr.21.1687529689962; 
 Fri, 23 Jun 2023 07:14:49 -0700 (PDT)
Received: from [192.168.68.108] (201-69-66-110.dial-up.telesp.net.br.
 [201.69.66.110]) by smtp.gmail.com with ESMTPSA id
 r21-20020a9d7cd5000000b006a44338c8efsm3843409otn.44.2023.06.23.07.14.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Jun 2023 07:14:49 -0700 (PDT)
Message-ID: <6da71298-8345-f0b1-b086-830425db6ec5@ventanamicro.com>
Date: Fri, 23 Jun 2023 11:14:45 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 12/19] target/riscv: add KVM specific MISA properties
To: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com,
 palmer@rivosinc.com
References: <20230622135700.105383-1-dbarboza@ventanamicro.com>
 <20230622135700.105383-13-dbarboza@ventanamicro.com>
 <20230623-df5c527b7dae3e28123be577@orel>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20230623-df5c527b7dae3e28123be577@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x32c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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



On 6/23/23 06:38, Andrew Jones wrote:
> On Thu, Jun 22, 2023 at 10:56:53AM -0300, Daniel Henrique Barboza wrote:
> ...
>> +#define KVM_MISA_CFG(_bit, _reg_id) \
>> +    {.offset = _bit, .kvm_reg_id = _reg_id}
>> +
>> +/* KVM ISA extensions */
>> +static KVMCPUConfig kvm_misa_ext_cfgs[] = {
>> +    KVM_MISA_CFG(RVA, KVM_RISCV_ISA_EXT_A),
>> +    KVM_MISA_CFG(RVC, KVM_RISCV_ISA_EXT_C),
>> +    KVM_MISA_CFG(RVD, KVM_RISCV_ISA_EXT_D),
>> +    KVM_MISA_CFG(RVF, KVM_RISCV_ISA_EXT_F),
>> +    KVM_MISA_CFG(RVH, KVM_RISCV_ISA_EXT_H),
>> +    KVM_MISA_CFG(RVI, KVM_RISCV_ISA_EXT_I),
>> +    KVM_MISA_CFG(RVM, KVM_RISCV_ISA_EXT_M),
>> +};
>> +
> ...
>> +static void kvm_riscv_add_cpu_user_properties(Object *cpu_obj)
>> +{
>> +    int i;
>> +
>> +    for (i = 0; i < ARRAY_SIZE(kvm_misa_ext_cfgs); i++) {
>> +        KVMCPUConfig *misa_cfg = &kvm_misa_ext_cfgs[i];
>> +        int bit = misa_cfg->offset;
>> +
>> +        misa_cfg->name = misa_ext_info_arr[bit].name;
>> +        misa_cfg->description = misa_ext_info_arr[bit].description;
> 
> I'd prefer these be set by KVM_MISA_CFG(), since we can. No need to wait
> until runtime if we can do it at compile-time.

The compiler will complain about "error: initializer element is not constant" and
the build will fail. This happens because, apparently, the compiler doesn't see the
imported array as a constant, regardless of the 'const' type.

If there's a trick that allow us to set these inside that macro I'm all ears. I tried
a bit, failed, and ended up adding these 2 extra lines. Thanks,


Daniel



> 
> Thanks,
> drew
> 
>> +
>> +        object_property_add(cpu_obj, misa_cfg->name, "bool",
>> +                            NULL,
>> +                            kvm_cpu_set_misa_ext_cfg,
>> +                            NULL, misa_cfg);
>> +        object_property_set_description(cpu_obj, misa_cfg->name,
>> +                                        misa_cfg->description);
>> +    }
>> +}
>> +
>>   static int kvm_riscv_get_regs_core(CPUState *cs)
>>   {
>>       int ret = 0;
>> @@ -427,6 +504,7 @@ void kvm_riscv_init_user_properties(Object *cpu_obj)
>>           return;
>>       }
>>   
>> +    kvm_riscv_add_cpu_user_properties(cpu_obj);
>>       kvm_riscv_init_machine_ids(cpu, &kvmcpu);
>>       kvm_riscv_init_misa_ext_mask(cpu, &kvmcpu);
>>   
>> -- 
>> 2.41.0
>>

