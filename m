Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2288D7DF423
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 14:43:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyXyF-00047z-5q; Thu, 02 Nov 2023 09:42:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qyXy2-00046U-PU
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 09:42:39 -0400
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qyXxu-00021t-Ke
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 09:42:34 -0400
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-d9cbba16084so945980276.1
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 06:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698932549; x=1699537349; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zoXkdXobyKHldJGIKJblnim60kSA1J271FgC4O5SHJ0=;
 b=eRgshx+1qrqGBm9BK+g/GP4LmkYz1oCEW1+Lcn4ioF0JCYUQQI7f5lF3u/XjU2w1lQ
 HZgGgoBwbZ0TwgPLPvPcRjVzxPqfQcFf/Ny4/LkpSJLyPTO2/gJc62igxyrkA6oTv/C0
 j9lDe2zPaYykyPt2S7x2BFtzevUd/pNM5hKMtXJRpLUs5j4sY6HfwaXuLrAT5l/R4AyT
 HsiZWe7QPUmnp0uYKe+gl5FZLOFOAOQkxhqe1/WkeHbE/iMcSb3BGJWGFb8JDIGvwfpx
 VyKVSEFvFLJy1c09ghjsJ2ml2g9mw7amheerlFpwN4GvaqjUrd7ehCgrdwosgb5ddkNt
 OAaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698932549; x=1699537349;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zoXkdXobyKHldJGIKJblnim60kSA1J271FgC4O5SHJ0=;
 b=PnJP0Xp0cb1bAny3mTbgPRd6xr0m/gDMBnGgWQ2NoanVYsj1rf86t8uwTol/l/Y0E6
 AXDcdcrFiHDtQ+xkHRS8EMGzzMwmqAjcQTGGeEdGNKdUXBRbp2LtebFiK29mfXqG2Q9k
 Vgrq+ZWKrEOCxMMmrFkRBjOoJWBRruMfaBI9vwXz3sC5SZYLj7cUKc4zzvCKSxFyYNLF
 qs6h2BOh+FhNSBTI9trbRG3ApbMMGVHi4KLUjqGE43rFuV1BAUxmv/wDyDbgUPJDNOIl
 O2OhhWlz7gLxBFfIHdM+Bbvgjt+pOPkSSAk3uV3pFREQ22QIKJb+AAbuL/roKmr1vXhx
 XFTw==
X-Gm-Message-State: AOJu0YzbmGEIVNjktynpKMAwUcwuvHUu8KtOKApvg9ruYKITQMxpSTXq
 eo58pzlb8GsWlam1HWiOMWKiPg==
X-Google-Smtp-Source: AGHT+IHLZIKQtPRIcIm5amCZFFiyVvpzo+zRJ5Rv4wGda+0vmEMc2Mv7SbpU8Y3e69LeTRKykH7dVQ==
X-Received: by 2002:a25:8287:0:b0:d9a:4d6f:1b27 with SMTP id
 r7-20020a258287000000b00d9a4d6f1b27mr17181043ybk.10.1698932549401; 
 Thu, 02 Nov 2023 06:42:29 -0700 (PDT)
Received: from [192.168.68.107] ([179.193.10.161])
 by smtp.gmail.com with ESMTPSA id
 v207-20020a252fd8000000b00da041da21e7sm1077249ybv.65.2023.11.02.06.42.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Nov 2023 06:42:29 -0700 (PDT)
Message-ID: <05eb78d6-7563-4c5a-bae7-5ca14f4e91a2@ventanamicro.com>
Date: Thu, 2 Nov 2023 10:42:25 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/19] target/riscv/tcg: update priv_ver on user_set
 extensions
Content-Language: en-US
To: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com,
 palmer@rivosinc.com
References: <20231101204204.345470-1-dbarboza@ventanamicro.com>
 <20231101204204.345470-6-dbarboza@ventanamicro.com>
 <20231102-bdcd40a9183dbbfe6667a304@orel>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20231102-bdcd40a9183dbbfe6667a304@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b31;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yb1-xb31.google.com
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



On 11/2/23 06:47, Andrew Jones wrote:
> On Wed, Nov 01, 2023 at 05:41:50PM -0300, Daniel Henrique Barboza wrote:
>> We'll add a new bare CPU type that won't have any default priv_ver. This
>> means that the CPU will default to priv_ver = 0, i.e. 1.10.0.
>>
>> At the same we'll allow these CPUs to enable extensions at will, but
>> then, if the extension has a priv_ver newer than 1.10, we'll end up
>> disabling it. Users will then need to manually set priv_ver to something
>> other than 1.10 to enable the extensions they want, which is not ideal.
>>
>> Change the setter() of multi letter extensions to allow user enabled
>> extensions to bump the priv_ver of the CPU. This will make it
>> conveniente for users to enable extensions for CPUs that doesn't set a
>> default priv_ver.
>>
>> This change does not affect any existing CPU: vendor CPUs does not allow
>> extensions to be enabled, and generic CPUs are already set to priv_ver
>> LATEST.
>>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   target/riscv/tcg/tcg-cpu.c | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
>> index f54069d06f..b88fce98a4 100644
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
> 
> This will ignore user input. If the user, for example, does
> 
>   -cpu rv64,priv_spec=v1.10.0,zicbom=on


This won't ignore user input because "priv_spec=v1.10.0" will be evaluated during
finalize() time, in riscv_cpu_validate_priv_spec(). This change I made was made
with this behavior in mind.

In the case you mentioned, this will happen:

$ ./build/qemu-system-riscv64 -M virt -cpu rv64,priv_spec=v1.10.0,zicbom=on
qemu-system-riscv64: H extension requires priv spec 1.12.0

This happened because, although 'zicbom=true' would bump priv ver to 1.12.0 if needed
(it isn't - rv64 is already set to LATEST), "priv_spec=v1.10.0" is evaluated during
finalize() time and the CPU priv_ver is set to 1.10 before our validation step.

This means that doesn't matter where the 'priv_spec' option is in the command line,
it'll always be honored.


> 
> then, afaict, priv_spec will be silently bumped to 1.12. I think we should
> error out in that case instead. And, we should also error out for
> 
>   -cpu rv64,zicbom=on,priv_spec=v1.10.0
> 
> which means we should know when priv_spec is either
> 
>   - its default value
>   - has been bumped by an extension
>   - has been explicitly set by the user

> 
>> +}
>> +
>>   static void cpu_cfg_ext_auto_update(RISCVCPU *cpu, uint32_t ext_offset,
>>                                       bool value)
>>   {
>> @@ -829,6 +845,10 @@ static void cpu_set_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
>>           return;
>>       }
>>   
>> +    if (value) {
>> +        cpu_validate_multi_ext_priv_ver(&cpu->env, multi_ext_cfg->offset);
>> +    }
> 
> Some misa extensions also have priv spec version dependencies. See
> riscv_cpu_validate_misa_priv()

Yeah. I'll add this same mechanic to RVH, the only MISA bit we have that has a priv_ver
limitation. Thanks,

Daniel

> 
>> +
>>       isa_ext_update_enabled(cpu, multi_ext_cfg->offset, value);
>>   }
>>   
>> -- 
>> 2.41.0
>>
> 
> Thanks,
> drew

