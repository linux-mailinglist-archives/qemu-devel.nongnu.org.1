Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D86D7F758F
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 14:50:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6WYo-0007lD-1T; Fri, 24 Nov 2023 08:49:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r6WYk-0007kp-4v
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 08:49:30 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r6WYh-0007uW-Qi
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 08:49:29 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1cf80a7be0aso15925565ad.1
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 05:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1700833766; x=1701438566; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=aoShqFPmVKS4rNml+nxoI/5uq2LwLm8T+HBo2J8chE8=;
 b=gB0kpc7o+FIcux94oKm50RFnciN5rt0CYAkg7YYIIfM19LcRcBY0SGHJB8N1pfVeDR
 C/IDQ6OPE44HvyujfitcYbCJzwrf5LCHrswlPGem7pA01rbsu1cu+4/RGRusyAw7M2Pr
 scg4JHOUgEK7jWqERbe34piC8Q08w4T+MDu2DdYiP9xAb+gmPLhVPbw3HWD+EnyQ6BPz
 OfCsNJIHAhu+sKzof0KcPb61ilN3D+ekNCl8ZSW442rM8Z5389aH1URjo95OloSaJXMZ
 IEqZvbxZUYtzRprAbbjBOobYuHKKYb8DxaqN6RpDlG+nvfN35SyVVXPhKUbZLSTiFbpc
 rApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700833766; x=1701438566;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aoShqFPmVKS4rNml+nxoI/5uq2LwLm8T+HBo2J8chE8=;
 b=aqK+s+c2eaAn5sVmPrvxFgjf+1jpzxIBaujZMVh+ZSrBx/ey9AB5MNqQr9CvONgdHk
 yrxIHb/GkHhbZ/c1qfQ++DBr+uQXBjfCL0erJOmAXRx7DIGcf6JOxoeR8hsanhzn+hrk
 FjInE8AaSb+jR0benJQ2v1Cx/vRS9mn/1SU3VntJoROo0e7Z/RFyRDRN3DjOIGQMYYxQ
 cE8e7uQXLw8gF++ngymtY5l0x6PSi6ytgh18kl+prPw+1lGhmiPy+FVzueodPrEHdqRg
 bo4pcjxbNc2u3Lgem5IIK9uUtWgEA16AmaXgxyi/9HDskxBl7dKXDF0SSmd84gg4thaf
 qcOQ==
X-Gm-Message-State: AOJu0Yyk8vHTaGsk3MogaBBWlb5pwkkzeaR2h8ugyQ75bcq+XM3WYY7T
 wKR1oG+NY+f6ifoVgxGzxnQJNg==
X-Google-Smtp-Source: AGHT+IGDRFS5Ttbds5jEJRzvCYbkNJH1nCGa1oOSv/00xQOq2aYLajuSiX/kgoLu8nJLkisVnpeJNw==
X-Received: by 2002:a17:902:c94f:b0:1ca:28f3:5690 with SMTP id
 i15-20020a170902c94f00b001ca28f35690mr3734463pla.46.1700833766363; 
 Fri, 24 Nov 2023 05:49:26 -0800 (PST)
Received: from [192.168.68.109] ([152.250.131.119])
 by smtp.gmail.com with ESMTPSA id
 c5-20020a170903234500b001c61901ed37sm3165555plh.191.2023.11.24.05.49.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Nov 2023 05:49:25 -0800 (PST)
Message-ID: <82d8abb2-820e-450c-a370-3c7f1dbb8711@ventanamicro.com>
Date: Fri, 24 Nov 2023 10:49:22 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0 v11 03/18] target/riscv/tcg: update priv_ver on
 user_set extensions
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 palmer@rivosinc.com
References: <20231123185122.1100436-1-dbarboza@ventanamicro.com>
 <20231123185122.1100436-4-dbarboza@ventanamicro.com>
 <20231124-92b499e54aa4a447386fac16@orel>
 <6a902ab3-a95f-47a9-a3d4-251c0c116fd2@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <6a902ab3-a95f-47a9-a3d4-251c0c116fd2@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 11/24/23 08:55, Daniel Henrique Barboza wrote:
> 
> 
> On 11/24/23 06:23, Andrew Jones wrote:
>> On Thu, Nov 23, 2023 at 03:51:07PM -0300, Daniel Henrique Barboza wrote:
>>> We'll add a new bare CPU type that won't have any default priv_ver. This
>>> means that the CPU will default to priv_ver = 0, i.e. 1.10.0.
>>>
>>> At the same we'll allow these CPUs to enable extensions at will, but
>>> then, if the extension has a priv_ver newer than 1.10, we'll end up
>>> disabling it. Users will then need to manually set priv_ver to something
>>> other than 1.10 to enable the extensions they want, which is not ideal.
>>>
>>> Change the setter() of extensions to allow user enabled extensions to
>>> bump the priv_ver of the CPU. This will make it convenient for users to
>>> enable extensions for CPUs that doesn't set a default priv_ver.
>>>
>>> This change does not affect any existing CPU: vendor CPUs does not allow
>>> extensions to be enabled, and generic CPUs are already set to priv_ver
>>> LATEST.
>>>
>>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>>> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
>>> ---
>>>   target/riscv/tcg/tcg-cpu.c | 32 ++++++++++++++++++++++++++++++++
>>>   1 file changed, 32 insertions(+)
>>>
>>> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
>>> index 7670120673..d279314624 100644
>>> --- a/target/riscv/tcg/tcg-cpu.c
>>> +++ b/target/riscv/tcg/tcg-cpu.c
>>> @@ -114,6 +114,26 @@ static int cpu_cfg_ext_get_min_version(uint32_t ext_offset)
>>>       g_assert_not_reached();
>>>   }
>>> +static void cpu_validate_multi_ext_priv_ver(CPURISCVState *env,
>>> +                                            uint32_t ext_offset)
>>
>> We should probably name this cpu_bump_multi_ext_priv_ver(). "validate"
>> implies we're checking something and either returning an error when it's
>> not what we expect or asserting on unexpected input. We do neither here,
>> we just bump priv_ver, when necessary.
> 
> Having a look at all the instances we have of 'validate', including the rva22s64 series,
> I believe we can make the following name changes:> 
> riscv_cpu_validate_named_features() -> riscv_cpu_update_named_features()
> riscv_cpu_validate_svade() -> riscv_cpu_update_svade()
> riscv_cpu_validate_zic64b() -> riscv_cpu_update_zic64b()


Thinking a littme more about it, and I think you hinted at this in the review of rva22s64,
we could get rid of all these functions that are doing simple assignments and open-code
everything in riscv_cpu_update_named_features().

I'll do that for v12. Thanks,

Daniel

> 
> As you said a couple of times in recente reviews, 'validate' doesn't make much sense
> since we're not checking values and erroring out/send warnings about it. I suggest
> 'update' instead of 'set' because we're updating the value of these flags based on
> the resulting configuration during finalize(), instead of setting them to a certain
> 'value' param.
> 
> 
> Thanks,
> 
> Daniel
> 
> 
>>
>> Thanks,
>> drew

