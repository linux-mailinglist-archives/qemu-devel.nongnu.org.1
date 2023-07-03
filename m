Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CA2745C65
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 14:40:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGIph-0002I2-T0; Mon, 03 Jul 2023 08:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qGIpb-0002HX-Sm; Mon, 03 Jul 2023 08:39:03 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qGIpW-00053k-O5; Mon, 03 Jul 2023 08:39:03 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-560b7ac3cbfso2919892eaf.2; 
 Mon, 03 Jul 2023 05:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688387931; x=1690979931;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g8gDteoJKz2rtvPgD5zI80rtDIlWs89ILc6v4t+7RkA=;
 b=I7yVYZpI1EJxok3Z7f+9HR+nHx7JY4dLS31zOQgqZnnlVNH5DGP/knaK/4mK0Jz6rh
 xj1DJ/R724e6d9Na84flPf3jj49d1JjxAgzNeurpuoPdb2+3VCvzrvLjcz9Kmq9i7sZq
 8cCbtBanXWWomjuaE8do7PCyAgKi1Fzn76w+RoLSE5VXQb9Ci8z8fe1nFJJSzNlXW9zx
 VsFSX6CBjiJlSPrsR/WLlgbexPdDzgULseWWslkKTbMqt29t1XqVzd+J3WyksalIxaDr
 usGerC9jq5EUWEAklINzjyTTF+iNNDx7CBFjgkZylJM3iZY5hcwXzRverCDk8E3gLnBQ
 YH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688387931; x=1690979931;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g8gDteoJKz2rtvPgD5zI80rtDIlWs89ILc6v4t+7RkA=;
 b=Ey+zmgdZE2LHtly4FdBTFXG4gmKJCUw/H7p0AbdCN3yO/Cc2SC3WmA2FGiYYZyvImf
 pvIaB01Qr0qPziiTTOEvAjwAeR0LAdTVSDVIIaZP2fnp9W192TlWNngKg1oGeziOqs34
 Bqj6TDzo5tZt4kYWXW6WdmOSO6sxT+LKA5CYsXN4flH1s3ye9ItARzjpDyulQyp39JXL
 Oe/AWqS2fmjCB+59KjsI9taEtbHNsk3SkKjfxwfxOlbJVTSc5PtFvoig9YVRP0Xw3Zd5
 zj8NZN2s6Slko206Ijwj7WM3i1UsNHHWxwqGy9szFKwguhyKQwmzf/qn26p+yXB7Km52
 KCoQ==
X-Gm-Message-State: AC+VfDymffHtGL8EnKc/Blw3kjXrO0IUcueGamBbI1wMAsw9RP4vwa+f
 r9n1nQoVyOKLr4Br2FozjFI=
X-Google-Smtp-Source: ACHHUZ5heptGfBGvhSruq5LJoyZbWysbyVVpkCeeHj4uCVbC/if9GKXQj38PhrQaRK0TbVJ2gshvmA==
X-Received: by 2002:a05:6808:14c4:b0:3a3:67cb:61e3 with SMTP id
 f4-20020a05680814c400b003a367cb61e3mr10788411oiw.25.1688387931050; 
 Mon, 03 Jul 2023 05:38:51 -0700 (PDT)
Received: from ?IPV6:2804:14c:f435:9162::1004? ([2804:14c:f435:9162::1004])
 by smtp.gmail.com with ESMTPSA id
 g33-20020a0568080de100b003a365d2746esm4970007oic.9.2023.07.03.05.38.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jul 2023 05:38:50 -0700 (PDT)
Message-ID: <9e261c80-ecbb-8115-f40f-301bb217ca35@gmail.com>
Date: Mon, 3 Jul 2023 09:38:44 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3] target/ppc: Make checkstop actually stop the system
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20230703120340.45349-1-npiggin@gmail.com>
 <68789d6e-5bf8-88d6-2bd5-405339500f44@eik.bme.hu>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <68789d6e-5bf8-88d6-2bd5-405339500f44@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=danielhb413@gmail.com; helo=mail-oo1-xc2e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.09,
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



On 7/3/23 09:26, BALATON Zoltan wrote:
> On Mon, 3 Jul 2023, Nicholas Piggin wrote:
>> checkstop state does not halt the system, interrupts continue to be
>> serviced, and other CPUs run. Stop the machine with
>> qemu_system_guest_panicked.
>>
>> Change the logging not to print separately to stderr because a
>> checkstop is a guest error (or perhaps a simulated machine error)
>> rather than a QEMU error. CPU registers are dumped.
>>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>
>> Since v1:
>> - Fix loop exit so it stops on the checkstop-causing instruction, rather than
>>  after it.
>>
>> Since v2:
>> - Rebase on ppc-next.
> 
> Is this really based on ppc-next or on my series or another patch from you? I think the patch from my series that introduces the checksrop function that this patch is changing is not yet in ppc-next so this may not apply there. I think you've posted an alternative to the patch moving checkstop handling to a function and the sc patch which may clash with the not yet merged parts in my series but i could not follow all these patches. I'm not sure Daniel could so maybe you could send it as a series to include all patches you want to add or state what it's based on.

What patch are we talking about?

If the patch is built on top of something that isn't on master or ppc-next you can add
a note in the cover-letter mentioning it and I'll grab both. Thanks,


Daniel


> 
> Regards,
> BALATON Zoltan
> 
>> - Use qemu_system_guest_panicked rather than vm_stop (Richard)
>> - Move away from printing to stderr (Zoltan)
>> - Reduce changes to log messages.
>> - Split out from larger series since it's independent (will skip attn
>>  instruction for now).
>> ---
>> target/ppc/excp_helper.c | 26 ++++++++++++++++++--------
>> 1 file changed, 18 insertions(+), 8 deletions(-)
>>
>> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
>> index e49e13a30d..a588285ef1 100644
>> --- a/target/ppc/excp_helper.c
>> +++ b/target/ppc/excp_helper.c
>> @@ -19,6 +19,7 @@
>> #include "qemu/osdep.h"
>> #include "qemu/main-loop.h"
>> #include "qemu/log.h"
>> +#include "sysemu/runstate.h"
>> #include "cpu.h"
>> #include "exec/exec-all.h"
>> #include "internal.h"
>> @@ -427,20 +428,29 @@ static void powerpc_set_excp_state(PowerPCCPU *cpu, target_ulong vector,
>> static void powerpc_mcheck_checkstop(CPUPPCState *env)
>> {
>>     CPUState *cs = env_cpu(env);
>> +    FILE *f;
>>
>>     if (FIELD_EX64(env->msr, MSR, ME)) {
>>         return;
>>     }
>>
>> -    /* Machine check exception is not enabled. Enter checkstop state. */
>> -    fprintf(stderr, "Machine check while not allowed. "
>> -            "Entering checkstop state\n");
>> -    if (qemu_log_separate()) {
>> -        qemu_log("Machine check while not allowed. "
>> -                 "Entering checkstop state\n");
>> +    /*
>> +     * This stops the machine and logs CPU state without killing QEMU
>> +     * (like cpu_abort()) so the machine can still be debugged (because
>> +     * it is often a guest error).
>> +     */
>> +
>> +    f = qemu_log_trylock();
>> +    if (f) {
>> +        fprintf(f, "Machine check while not allowed. "
>> +                "Entering checkstop state.\n");
>> +        cpu_dump_state(cs, f, CPU_DUMP_FPU | CPU_DUMP_CCOP);
>> +        qemu_log_unlock(f);
>>     }
>> -    cs->halted = 1;
>> -    cpu_interrupt_exittb(cs);
>> +
>> +    qemu_system_guest_panicked(NULL);
>> +
>> +    cpu_loop_exit_noexc(cs);
>> }
>>
>> static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
>>

