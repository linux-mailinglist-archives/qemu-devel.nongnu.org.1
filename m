Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 693BF7E0241
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 12:36:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qysRr-0008Bd-Tl; Fri, 03 Nov 2023 07:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qysRo-0008Al-Bs
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 07:34:44 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qysRm-0000gP-3F
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 07:34:44 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5a7c08b7744so22932107b3.3
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 04:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1699011280; x=1699616080; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TVthWHOeMSUoL30S6RAYdu1oozO27UFXFZZaSVCBYzY=;
 b=jCZIXhJZV4ChPA4Pceh/BrTJbJXiK/Shkv3lXUWF+u7Av+7MF3JkT40GRRTy5j6Jr+
 ESjxpGBkO72jPFM/dUTj0E1KG86w54xSlEPRzEOge5Ii7crUTEu5EUTgveIxWHMZUCF4
 4qIIli20TVLHmnIdQSDrufpkToYZxO+j2uabA+EFPZTFSIvPyF0XjEAZLeNKWb148c/c
 VUbZaWlDte5+O7s81choclhly3lmUIFGHRthPMDCSJiCPeqBwdCGSaQh2GOr5Y3JpO6U
 UfYIlPvL79BP84IWH6Z013bg/Xk8DllFE68aQwyhs/KqTbWcv+oFm76gqYxL/TD+P4Zi
 KhzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699011280; x=1699616080;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TVthWHOeMSUoL30S6RAYdu1oozO27UFXFZZaSVCBYzY=;
 b=hISMbN1Fsmt9E2hY3PYQluYbHW2A1khEu5nWmi3JVkVw9Wg8PNWt6okPkJlqMiVwqU
 hlq/L0xNRhR0NqmyrleVU7yiwVRvJJrR5i4MsIEmg6WJLmZk28g1ghG9AGJOd+I0qQOD
 TwKcAy+YdvhgbFHGTe8Olm8HTbxavKBfgLuqO8RoybU64j/9ZgZTpTYqmbL2zCBiqgh+
 v3LnspM+QfgICgQEA4YH/InGO2LO8zf2WpWKL7yF2MeaYRGPjnKBU2kUZkVhSlQQ9BDX
 BTJeuJPB0VzpiW+fFUbbnKnnyGFCx1K7Wq2XtsE4V40CNgvNwRvOoi+s+lFTmlnW/c3N
 i16w==
X-Gm-Message-State: AOJu0YyY29LRKCDhgZ254J2Uld1T8Z7guqo+NplBn8V6kwXlBp4g0X3G
 WGYOJwrEumo/lw9ItGcNJVNMMQ==
X-Google-Smtp-Source: AGHT+IH3VUVBzwDkW7jteZxgGtqpSr/g4XClJLqrgBZpze12YRh/M9/62ZRhtnUId+SNAWT73xXGHA==
X-Received: by 2002:a81:9916:0:b0:5a8:8330:6f20 with SMTP id
 q22-20020a819916000000b005a883306f20mr2205623ywg.23.1699011279938; 
 Fri, 03 Nov 2023 04:34:39 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bdcd:fb00:6501:2693:db52:c621?
 ([2804:7f0:bdcd:fb00:6501:2693:db52:c621])
 by smtp.gmail.com with ESMTPSA id
 i203-20020a0ddfd4000000b005af5ef0687fsm816896ywe.6.2023.11.03.04.34.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Nov 2023 04:34:39 -0700 (PDT)
Message-ID: <6280cd3f-7a00-45fa-96e5-cc83931746ff@ventanamicro.com>
Date: Fri, 3 Nov 2023 08:34:35 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 03/19] target/riscv/tcg: update priv_ver on user_set
 extensions
Content-Language: en-US
To: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com,
 palmer@rivosinc.com
References: <20231102224445.527355-1-dbarboza@ventanamicro.com>
 <20231102224445.527355-4-dbarboza@ventanamicro.com>
 <20231103-3aa3e1b2206f3a8b596c0813@orel>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20231103-3aa3e1b2206f3a8b596c0813@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yw1-x1135.google.com
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



On 11/3/23 05:33, Andrew Jones wrote:
> On Thu, Nov 02, 2023 at 07:44:29PM -0300, Daniel Henrique Barboza wrote:
>> We'll add a new bare CPU type that won't have any default priv_ver. This
>> means that the CPU will default to priv_ver = 0, i.e. 1.10.0.
>>
>> At the same we'll allow these CPUs to enable extensions at will, but
>> then, if the extension has a priv_ver newer than 1.10, we'll end up
>> disabling it. Users will then need to manually set priv_ver to something
>> other than 1.10 to enable the extensions they want, which is not ideal.
>>
>> Change the setter() of extensions to allow user enabled extensions to
>> bump the priv_ver of the CPU. This will make it convenient for users to
>> enable extensions for CPUs that doesn't set a default priv_ver.
>>
>> This change does not affect any existing CPU: vendor CPUs does not allow
>> extensions to be enabled, and generic CPUs are already set to priv_ver
>> LATEST.
> 
> The only problem I see is that priv_ver will be silently bumped for any
> CPU type which accepts extensions. While generic CPUs currently always
> select LATEST, meaning it doesn't matter, and the new bare CPU type needs
> this feature, we'll also eventually have CPU types that set a priv_ver
> in their definition which should not be changed. For example, when the
> rva22s64 profile is introduced it will set its priv_ver to 1.12, as
> mandated by the profile, if a user then adds an extension which requires
> a later profile, its priv_ver will get silently bumped. Maybe that won't
> matter, though, because later in realize we'll check that Ss1p12 is true
> and when it's false we'll complain that the profile is not compliant?
> Or maybe I'm reading the profile spec too strictly and/or am too
> pessimistic about later specs being backwards compatible. If we believe
> later specs are always compatible with older, then we could advertise
> compliance with a profile which mandates 1.12 as long as its spec is 1.12
> or later

TBH I have no idea if a profile that demands priv spec 1.12 (like rva22s64, the
profile we're adding next) would be compliant with a CPU that runs a newer priv
spec. We'll have to cross that bridge when we come to it I guess ...


Thanks,

Daniel

.
> 
> Anyway, just food for thought. I think we can address this later when
> we get the first CPU type which sets a priv_ver and accepts extensions.
> 
>>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   target/riscv/tcg/tcg-cpu.c | 32 ++++++++++++++++++++++++++++++++
>>   1 file changed, 32 insertions(+)
>>
>> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
>> index 08f8dded56..0e684ab86f 100644
>> --- a/target/riscv/tcg/tcg-cpu.c
>> +++ b/target/riscv/tcg/tcg-cpu.c
>> @@ -114,6 +114,22 @@ static int cpu_cfg_ext_get_min_version(uint32_t ext_offset)
>>       g_assert_not_reached();
>>   }
>>   
>> +static void cpu_validate_multi_ext_priv_ver(CPURISCVState *env,
>> +                                            uint32_t ext_offset)
>> +{
>> +    int ext_priv_ver;
>> +
>> +    if (env->priv_ver == PRIV_VERSION_LATEST) {
>> +        return;
>> +    }
>> +
>> +    ext_priv_ver = cpu_cfg_ext_get_min_version(ext_offset);
>> +
>> +    if (env->priv_ver < ext_priv_ver) {
>> +        env->priv_ver = ext_priv_ver;
>> +    }
>> +}
>> +
>>   static void cpu_cfg_ext_auto_update(RISCVCPU *cpu, uint32_t ext_offset,
>>                                       bool value)
>>   {
>> @@ -742,6 +758,14 @@ static void cpu_set_misa_ext_cfg(Object *obj, Visitor *v, const char *name,
>>               return;
>>           }
>>   
>> +        if (misa_bit == RVH && env->priv_ver < PRIV_VERSION_1_12_0) {
>> +            /*
>> +             * Note: the 'priv_spec' command line option, if present,
>> +             * will take precedence over this priv_ver bump.
>> +             */
>> +            env->priv_ver = PRIV_VERSION_1_12_0;
>> +        }
>> +
>>           env->misa_ext |= misa_bit;
>>           env->misa_ext_mask |= misa_bit;
>>       } else {
>> @@ -871,6 +895,14 @@ static void cpu_set_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
>>           return;
>>       }
>>   
>> +    if (value) {
>> +        /*
>> +         * Note: the 'priv_spec' command line option, if present,
>> +         * will take precedence over this priv_ver bump.
>> +         */
> 
> The above comment would be better in cpu_validate_multi_ext_priv_ver() at
> the line where the bumping is done.
> 
>> +        cpu_validate_multi_ext_priv_ver(&cpu->env, multi_ext_cfg->offset);
>> +    }
>> +
>>       isa_ext_update_enabled(cpu, multi_ext_cfg->offset, value);
>>   }
>>   
>> -- 
>> 2.41.0
>>
> 
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> 
> Thanks,
> drew

