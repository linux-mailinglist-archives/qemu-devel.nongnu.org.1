Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D188D7DF2EC
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 13:54:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyXD0-0006xA-Nv; Thu, 02 Nov 2023 08:54:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qyXCy-0006wO-3J
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 08:54:00 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qyXCu-00045p-GI
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 08:53:59 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-579de633419so10678217b3.3
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 05:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698929634; x=1699534434; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8mXcjNiyvs0rtaqJ955YaAlAiWk3HrSq/BkjhOLvAaU=;
 b=pbCm7n0oTQ61vcCCLrROwOm2KeTGhJlpLvzTJ8213KUkmF85K56kJXolTpZLp0iWnN
 E/D40IBJcmkYbJg7yoLnUrlhyin5tb/Bdlo7gJx3W50I8ibQJL/I6U2cSazahp7qRcQv
 feYF25J5pkP5ht/oZ7ESlj1WoFWhEv5FY+TT+GU4Aou53sSds5g6j1IcXOvghB4i3mWU
 1BEWx1Nl7bRew5je630AUcled305sNOBa3/NXRBLUhFHy4x2CjL+x0PIF+XzBAdUMaSA
 NOd+ng8HX1MlVVAX+yYcyRPObXDHc8Ozy2AWOg8/xYySIyxmolXF9WgKF8KJfYnkFWuG
 lwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698929634; x=1699534434;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8mXcjNiyvs0rtaqJ955YaAlAiWk3HrSq/BkjhOLvAaU=;
 b=cH5gIrc6mMDFh9X3qUm8hdWLsFg5UhtLc0RWBl0pyLPpo3uCh/hAt+bYfEGcmvGLfa
 Fy4kQJB1y2KHK407qk+EfR2mFyQ4iiAF4px9k40u1NXpAhSOlnaJxE1t5vAK1q6rODs6
 wI2u/E3izcPJqeCwXdkmYC5YOrP0eQ7OoDTaIj7vbXI/1iSX7BNaNFkhpUsIgcyBFeQz
 WwfqT+4ox6aguvcjvqziihkrNrD55mFSusqqN3EXdfH9VV9xZLb25nLP5T/p3y+tLRok
 E/bF2Otzjxl9dcg5YJ79fr+f2sHqJFVa5ZoegzC4Mvu8a2jUnPbO0A9DskPKP71XJPKY
 iCZA==
X-Gm-Message-State: AOJu0YxlOgCIUgbirXAk8k5NXOcmyENQbvKUyIWSBnqVlc2htIig8qJ7
 tReSYJh0VBiLevlhstqg9UBdxw==
X-Google-Smtp-Source: AGHT+IFVucBs5UjBdJclCrG6djGBgF/or4wrvr8+7YxiwyALVB5w1IIq2/rT1hrKTdJvhLejMdQs8g==
X-Received: by 2002:a25:770a:0:b0:da3:ab41:31f3 with SMTP id
 s10-20020a25770a000000b00da3ab4131f3mr6032326ybc.8.1698929633877; 
 Thu, 02 Nov 2023 05:53:53 -0700 (PDT)
Received: from [192.168.68.107] ([179.193.10.161])
 by smtp.gmail.com with ESMTPSA id
 e13-20020a25890d000000b00d814d8dfd69sm1011787ybl.27.2023.11.02.05.53.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Nov 2023 05:53:53 -0700 (PDT)
Message-ID: <c51fd5aa-22a9-40dd-9463-60ef23fb77c5@ventanamicro.com>
Date: Thu, 2 Nov 2023 09:53:50 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 03/19] target/riscv/cpu.c: set satp_max_supported in
 cpu_riscv_set_satp()
Content-Language: en-US
To: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com,
 palmer@rivosinc.com
References: <20231101204204.345470-1-dbarboza@ventanamicro.com>
 <20231101204204.345470-4-dbarboza@ventanamicro.com>
 <20231102-b74e75db47b353355c6e5d66@orel>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20231102-b74e75db47b353355c6e5d66@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yw1-x1133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



On 11/2/23 06:24, Andrew Jones wrote:
> On Wed, Nov 01, 2023 at 05:41:48PM -0300, Daniel Henrique Barboza wrote:
>> The setter() for the boolean attributes that set satp_mode (sv32, sv39,
>> sv48, sv57, sv64) considers that the CPU will always do a
>> set_satp_mode_max_supported() during cpu_init().
>>
>> This is not the case for the KVM 'host' CPU, and we'll add another CPU
>> that won't set satp_mode_max() during cpu_init(). Users should be able
>> to set a max_support in these circunstances.
>>
>> Allow cpu_riscv_set_satp() to set satp_mode_max_supported if the CPU
>> didn't set one prior.
>>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   target/riscv/cpu.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index 822970345c..9f6837ecb7 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -1100,6 +1100,7 @@ static void cpu_riscv_get_satp(Object *obj, Visitor *v, const char *name,
>>   static void cpu_riscv_set_satp(Object *obj, Visitor *v, const char *name,
>>                                  void *opaque, Error **errp)
>>   {
>> +    RISCVCPU *cpu = RISCV_CPU(obj);
>>       RISCVSATPMap *satp_map = opaque;
>>       uint8_t satp = satp_mode_from_str(name);
>>       bool value;
>> @@ -1108,6 +1109,16 @@ static void cpu_riscv_set_satp(Object *obj, Visitor *v, const char *name,
>>           return;
>>       }
>>   
>> +    /*
>> +     * Allow users to set satp max supported if the CPU didn't
>> +     * set any during cpu_init(). First value set to 'true'
>> +     * in this case is assumed to be the max supported for
>> +     * the CPU.
> 
> Hmm, doesn't that mean if a user does
> 
>   -cpu rv64,sv39=true,sv48=true
> 
> then the max is set to sv39 instead of sv48?
> 
> I made a mistake in my last review by stating we shouldn't set the max
> supported satp for rv64i to the maximum satp that TCG supports. I forgot
> how all of it worked. Setting the _supported_ modes to the maximum that
> TCG supports makes sense as long as we don't default to any of them for
> rv64i. So, I think we should return the set_satp_mode_max_supported() to
> rv64i's definition (passing VM_1_10_SV57 or maybe even VM_1_10_SV64) and
> then change set_satp_mode_default_map() to error out for rv64i (or maybe
> for all "bare" type cpus).

Ok, then let's set max supported mode to SV64 (the maximum we allow).

Then we don't need to do anything else - setting a max supported value will allow
TCG to handle it accordingly with OpenSBI and the kernel, and a suitable satp_mode
will be picked by them. We can leave finalize() untouched.

I'll make a note in cpu_init() to remind ourselves that we're not setting a default
satp_mode value, but a *limit* for the satp_mode value the CPU can handle. This can be
done in the 'rv64i' patch.


Thanks,


Daniel




> 
>> +     */
>> +    if (value && cpu->cfg.satp_mode.supported == 0) {
>> +        set_satp_mode_max_supported(cpu, satp);
>> +    }
>> +
>>       satp_map->map = deposit32(satp_map->map, satp, 1, value);
>>       satp_map->init |= 1 << satp;
>>   }
>> -- 
>> 2.41.0
>>
> 
> Thanks,
> drew

