Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4311F73FB7F
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 13:57:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE7Jp-0001Id-V6; Tue, 27 Jun 2023 07:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qE7Jk-0001HJ-W3
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 07:57:10 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qE7Ji-00060t-Ki
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 07:57:08 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2b5c231f842so41942751fa.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 04:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687867024; x=1690459024;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yJMsxsrrc0QKrPx72tF09MaSXOeDUyQgUy0Eu6ihfio=;
 b=NhL8RCQ4mH5ubxQVwUNMqvEuPxLnLOkkKlRDg1ZLJbdM+WrJHtW8BQ7MAOWzY49TLb
 OAcB8gJDZap576E/NQ71mgGtHHUx9xZw+zP1FCKLHqhgdkpqeqd7OEQAfDKV3bViwBLz
 PpkOIqbpw8WDGKeaicXt6ZVab6t7fBRLHlVtYDOaUoBNm6/SoSbuhhccCKIfrwsABvxr
 qWsjJQiKZLrIOYpO93fjLvpc8YeZIkfu4oSTvDm3aqBnmWEGMDMgRVaW1wk1AdgSLoVL
 wCCNdZWw8Rnqoe2LK9EiylLf2o0iJp5pJ2XO9lm3hceYkzr+WhrD6WMCqWaLePIKvAKk
 v8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687867024; x=1690459024;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yJMsxsrrc0QKrPx72tF09MaSXOeDUyQgUy0Eu6ihfio=;
 b=D2w90OrwYeah7Qdj8m98+ZIg4RxPB1hQqNzv0h83o9fUAAc0g5bymkDXiY7PEHMOAk
 k9x0M0P3zBN3tOT/FQ1AAs4M7FR7PFTLjjotg1dBUlNKltXsJCxdN+j9KJqxIn0dZGMQ
 RNWO201h5qV3wpM9oKyeCgGA33tpH7VM6GFvxjs2P+m3/VcKKHlqoBlAd7ZJKh7Uw/7G
 fob84SZXPqc/cqdP/18KM6Fm7AVEpI2L6FWBZq0sBCGCxXXw8RejOiNhOMoWWgBj3OKg
 4MPusjE0nNQXoxQ6VHtDMHM0qLRe/itDjZuMbQnE2ZRmUkVlkI9lxcAd/5K2jdy/xhdd
 +h5g==
X-Gm-Message-State: AC+VfDxKyyjvI7n0ftwgFO62IN+dP63W5JK8o/xhk/5FXxKeaGLoi7u+
 qQF1CtKfbQX+GVHoSth0DiubNw==
X-Google-Smtp-Source: ACHHUZ5FSc1JPwuGCcjTbxIdrWt06tN9iNduQ4SkaLJLO+NJP26UgXIaFe12ib+xU6Kbn4xZPjDTaA==
X-Received: by 2002:a19:505d:0:b0:4f8:5ede:d447 with SMTP id
 z29-20020a19505d000000b004f85eded447mr15548001lfj.28.1687867023559; 
 Tue, 27 Jun 2023 04:57:03 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.41.103])
 by smtp.gmail.com with ESMTPSA id
 d11-20020a1c730b000000b003fb416d732csm2984850wmb.6.2023.06.27.04.57.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jun 2023 04:57:03 -0700 (PDT)
Message-ID: <2a81d229-a2f7-2b4d-b32a-6dc418698c5e@linaro.org>
Date: Tue, 27 Jun 2023 13:57:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 0/8] target/sparc: Use tcg_gen_lookup_and_goto_ptr
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20230621180607.1516336-1-richard.henderson@linaro.org>
 <2f11ee14-9bf2-85fe-581c-e3024efd2124@ilande.co.uk>
 <c83c2500-08d1-bb03-24d6-990a2f07b01b@ilande.co.uk>
 <35013658-5131-19f6-c95a-c74b73f90ecc@linaro.org>
 <56781cd7-f0cd-3fbb-855f-de0e89b98984@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <56781cd7-f0cd-3fbb-855f-de0e89b98984@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x229.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.103,
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

On 6/27/23 13:19, Mark Cave-Ayland wrote:
> On 27/06/2023 10:37, Philippe Mathieu-Daudé wrote:
> 
>> On 27/6/23 08:46, Mark Cave-Ayland wrote:
>>> On 22/06/2023 13:26, Mark Cave-Ayland wrote:
>>>
>>>> On 21/06/2023 19:05, Richard Henderson wrote:
>>>>
>>>>> Changes from v1:
>>>>>    * Split into teeny weeny pieces.
>>>>>
>>>>>    * It turns out the sparc_tr_tb_stop hunk of v1 was buggy,
>>>>>      in that things that are not simple branches use DYNAMIC_PC,
>>>>>      e.g. the RETT (return from trap) instruction.
>>>>>
>>>>>      Introduce DYNAMIC_PC_LOOKUP to distinguish the couple of
>>>>>      places where we have a dynamic pc, but no other change
>>>>>      of state (conditional branches, JMPL, RETURN).
>>>>>
>>>>>    * Drop the change for WRFPRS, because it's too infrequent.
>>>>>      The WRASI change affects memcpy/memset, so that's more important.
>>>>>
>>>>> Boots Mark's sol8 install cdrom.  :-)
>>>>>
>>>>> Top of the profile changes from
>>>>>
>>>>>      41.55%  qemu-system-sparc              [.] cpu_exec_loop
>>>>>      14.02%  qemu-system-sparc              [.] cpu_tb_exec
>>>>>       8.74%  qemu-system-sparc              [.] tb_lookup
>>>>>       2.11%  qemu-system-sparc              [.] tcg_splitwx_to_rw
>>>>>       1.63%  memfd:tcg-jit (deleted)        [.] 0x0000000000000004
>>>>>
>>>>> to
>>>>>
>>>>>      31.59%  qemu-system-sparc              [.] helper_lookup_tb_ptr
>>>>>      17.79%  qemu-system-sparc              [.] tb_lookup
>>>>>       5.38%  qemu-system-sparc              [.] compute_all_sub
>>>>>       2.38%  qemu-system-sparc              [.] helper_compute_psr
>>>>>       2.36%  qemu-system-sparc              [.] helper_check_align
>>>>>       1.79%  memfd:tcg-jit (deleted)        [.] 0x000000000063fc8e
>>>>>
>>>>> This probably indicates that cpu_get_tb_cpu_state could be
>>>>> improved to not consume so much overhead.
>>>>
>>>> Nice! I've just run this through all of my sun4m/sun4u/sun4v test images and I don't 
>>>> see any regressions with v2. The guests feel noticeably more responsive too :)
>>>>
>>>> Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>>>
>>>> I've skimmed the patches and without looking in too much detail they seem to be okay 
>>>> so I'm happy to give:
>>>>
>>>> Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>>>
>>>> Side note: the niagara tests require the patch at 
>>>> https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg03537.html which still hasn't 
>>>> been merged yet.
>>>>
>>>>> Richard Henderson (8):
>>>>>    target/sparc: Use tcg_gen_lookup_and_goto_ptr in gen_goto_tb
>>>>>    target/sparc: Fix npc comparison in sparc_tr_insn_start
>>>>>    target/sparc: Drop inline markers from translate.c
>>>>>    target/sparc: Introduce DYNAMIC_PC_LOOKUP
>>>>>    target/sparc: Use DYNAMIC_PC_LOOKUP for conditional branches
>>>>>    target/sparc: Use DYNAMIC_PC_LOOKUP for JMPL
>>>>>    target/sparc: Use DYNAMIC_PC_LOOKUP for v9 RETURN
>>>>>    target/sparc: Use tcg_gen_lookup_and_goto_ptr for v9 WRASI
>>>>>
>>>>>   target/sparc/translate.c | 410 ++++++++++++++++++++++-----------------
>>>>>   1 file changed, 233 insertions(+), 177 deletions(-)
>>>
>>> I've just noticed during testing there is an issue with this series when used with a 
>>> real SS-5 PROM image (I was using OpenBIOS for my previous tests) which causes it to 
>>> assert() almost immediately on startup:
>>>
>>> $ ./qemu-system-sparc -bios ss5.bin
>>> ERROR:../target/sparc/translate.c:5695:sparc_tr_tb_stop: code should not be reached
>>> Bail out! ERROR:../target/sparc/translate.c:5695:sparc_tr_tb_stop: code should not be 
>>> reached
>>> Aborted
>>
>> Could you try this fix:
>>
>> -- >8 --
>> --- a/target/sparc/translate.c
>> +++ b/target/sparc/translate.c
>> @@ -5682,5 +5682,5 @@ static void sparc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
>>
>>           save_npc(dc);
>> -        switch (dc->npc) {
>> +        switch (dc->npc & 3) {
>>           case DYNAMIC_PC_LOOKUP:
>>               if (may_lookup) {
>> ---
>>
>> ?
> 
> Unfortunately that doesn't fix the issue. A quick lunchtime debugging session with 
> printf() shows this just before the assert() fires:
> 
> ### dc->pc: 0x3
> ### dc->npc: 0xffd26c70
> **
> ERROR:../target/sparc/translate.c:5699:sparc_tr_tb_stop: code should not be reached
> Bail out! ERROR:../target/sparc/translate.c:5699:sparc_tr_tb_stop: code should not be reached
> Aborted

That makes no sense -- dynamic lookup pc with static npc?

Of course this happens before in_asm dump, so can you use -singlestep to figure out what 
pc, and thence instruction for which this is happening?


r~


