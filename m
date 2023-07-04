Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AD17475B8
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 17:55:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGiNB-0000wI-9c; Tue, 04 Jul 2023 11:55:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGiN9-0000nZ-6H
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 11:55:23 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGiN6-0000Cs-Q3
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 11:55:22 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fbc656873eso70494265e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 08:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688486118; x=1691078118;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZdLEPOxD/HyhG5wNqOjEnxU/l6nQQKaD+xXft6APAPA=;
 b=Op2F41urZdcsmpF2+pTPpVZ6ozdXRm+afzVUXck/jwnWvZKDoHyMf4A+5cdul40xm+
 T16qUn2kbGW4YYCprtwxMk/JdomuD+YVFeIgeDO4qF0yqAqWII4SwWjMdBU68bxVIASu
 bUAYJ1qwyEbSQ9cjB7Ko+AIAhtkkJA9SuBMxdr+ngw3XaSdnKTHorY7AOexlmwi1x+JZ
 6mr33CnDbegZ+5RddP2u1Z6G+glV0CRkB09Y8sjvEs1XetXRPuxfUlJtY+7lim03M03Q
 hASkyP1pdUj7FRXD/RNDTQJTYNbWNgiPehhAKUl7pmevnIWpniM7XpgdyJYzPmdguhCR
 a1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688486118; x=1691078118;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZdLEPOxD/HyhG5wNqOjEnxU/l6nQQKaD+xXft6APAPA=;
 b=CEVvopu12kZcdzhiec7QLeuXM8NHMxXVkFLzX1rSq6wKttJtjxHlJEp9s+OaeK6k+v
 GQwvFH0XRHER08Unay27lz8kSfA1cGJf4g0qcXqrEr8i+zhiEClnNEMuUf2UwbKd4jsm
 fYy5VQ2hvcVhobSVgTfGWwCJCjzGauk4DY6xZzd2vN3KHPbwo7LIwUhGRj9GQv0Vy/g6
 IIwFVEiLdlBLcHxVGItUSXDsIn/riWMeBORM0B5qwm3R/S2Pab7x7mIz1lGks3gJwgRv
 8Q4/va2U6N0bhwIQYf6SkQwY1lskGkvMToZcYvLSrmzl1k8nQG046EF6M+zaEP36N4UG
 bvJQ==
X-Gm-Message-State: AC+VfDz1d2qGF+gLZp1qLcQ8ZXIbgdwWurmG5O/0cC9WW+92EQzanIa/
 hIHgrsuB0TT8lkZPzSaXbNBr4w==
X-Google-Smtp-Source: ACHHUZ4Qf8YCIJq2aj5LWwMvOyico2GJnQD0TpKX4p7qPtMh6q/xu+d9tVZ9BGdCWPMweqAPv9/kVQ==
X-Received: by 2002:a1c:e909:0:b0:3fb:b05d:f274 with SMTP id
 q9-20020a1ce909000000b003fbb05df274mr18371060wmc.4.1688486118604; 
 Tue, 04 Jul 2023 08:55:18 -0700 (PDT)
Received: from [192.168.1.102] ([176.176.157.122])
 by smtp.gmail.com with ESMTPSA id
 l25-20020a1c7919000000b003fbb25da65bsm18195169wme.30.2023.07.04.08.55.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 08:55:18 -0700 (PDT)
Message-ID: <e7575e49-5a22-49b1-9e8c-4e85372c203f@linaro.org>
Date: Tue, 4 Jul 2023 17:55:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] target/arm: gdbstub: Guard M-profile code with CONFIG_TCG
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20230628164821.16771-1-farosas@suse.de>
 <d8f954dc-8a69-7593-716c-e360d2c8e47b@linaro.org>
 <CAFEAcA9QSS7qs2kcCuyrDrRc6tb_0euMD3vFJ=_Q8s8dJYBRfw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA9QSS7qs2kcCuyrDrRc6tb_0euMD3vFJ=_Q8s8dJYBRfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 4/7/23 17:44, Peter Maydell wrote:
> On Tue, 4 Jul 2023 at 16:21, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> On 28/6/23 18:48, Fabiano Rosas wrote:
>>> This code is only relevant when TCG is present in the build. Building
>>> with --disable-tcg --enable-xen on an x86 host we get:
>>>
>>> $ ../configure --target-list=x86_64-softmmu,aarch64-softmmu --disable-tcg --enable-xen
>>> $ make -j$(nproc)
>>> ...
>>> libqemu-aarch64-softmmu.fa.p/target_arm_gdbstub.c.o: in function `m_sysreg_ptr':
>>>    ../target/arm/gdbstub.c:358: undefined reference to `arm_v7m_get_sp_ptr'
>>>    ../target/arm/gdbstub.c:361: undefined reference to `arm_v7m_get_sp_ptr'
>>>
>>> libqemu-aarch64-softmmu.fa.p/target_arm_gdbstub.c.o: in function `arm_gdb_get_m_systemreg':
>>> ../target/arm/gdbstub.c:405: undefined reference to `arm_v7m_mrs_control'
>>>
>>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>> ---
>>> This is a respin of:
>>> https://lore.kernel.org/r/20230313151058.19645-5-farosas@suse.de
>>> ---
>>>    target/arm/gdbstub.c | 4 ++++
>>>    1 file changed, 4 insertions(+)
>>>
>>> diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
>>> index 03b17c814f..f421c5d041 100644
>>> --- a/target/arm/gdbstub.c
>>> +++ b/target/arm/gdbstub.c
>>> @@ -324,6 +324,7 @@ static int arm_gen_dynamic_sysreg_xml(CPUState *cs, int base_reg)
>>>        return cpu->dyn_sysreg_xml.num;
>>>    }
>>>
>>> +#ifdef CONFIG_TCG
>>
>> OK.
>>
>>>    typedef enum {
>>>        M_SYSREG_MSP,
>>>        M_SYSREG_PSP,
>>> @@ -481,6 +482,7 @@ static int arm_gen_dynamic_m_secextreg_xml(CPUState *cs, int orig_base_reg)
>>>        return cpu->dyn_m_secextreg_xml.num;
>>>    }
>>>    #endif
>>> +#endif /* CONFIG_TCG */
>>>
>>>    const char *arm_gdb_get_dynamic_xml(CPUState *cs, const char *xmlname)
>>>    {
>>> @@ -561,6 +563,7 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
>>>                                 arm_gen_dynamic_sysreg_xml(cs, cs->gdb_num_regs),
>>>                                 "system-registers.xml", 0);
>>>
>>> +#ifdef CONFIG_TCG
>>
>> IIUC tcg_enabled(), this guard shouldn't be necessary; if CONFIG_TCG
>> is not defined, tcg_enabled() evaluates to 0, and the compiler should
>> elide the whole block.
> 
> IME it's a bit optimistic to assume that the compiler will always
> do that, especially with no optimisation enabled.

OK I see, thanks.

