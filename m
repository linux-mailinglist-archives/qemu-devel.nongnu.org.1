Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDB573F9BB
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 12:12:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE5g9-0002tw-52; Tue, 27 Jun 2023 06:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qE5g7-0002tk-8f
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 06:12:07 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qE5g5-0007H0-Aq
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 06:12:07 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-4fb7dc16ff0so1477769e87.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 03:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687860723; x=1690452723;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8wuPR2V1X3wwV7qAbJFhwUNsdL1xWCne/bgD1hAOyMk=;
 b=StdI8RNdmnq6QE06gDapx1Fhdc1Ga1vTIB4BbnHMxx5kK7DC+0ET8JTsY68fWhoBDT
 76l8XGXBkALzlQAuluviqQsy/HHUAz1mE20K1N4P8QpmmtMa0XwPsbsyuovsJrswxzkY
 W+DeNlyg9ziRtCba0My1OQ5jbRuffqJXYhHNr+eQaLQzRR3eBOyNFoJShTqhYdXLVKws
 CLfiZWp2WUDhu9bOyJhFrtaP3mWN3yR4ZvXbmj8M8KcDuMMDO+1byW38HDexCraaXcQ4
 LHYxdBTjvAneEDjGu3HR212BjZQdlspt2/hx+08XRCCPDLxy+iwcLLS0JxeQ1hHtcdoM
 pDsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687860723; x=1690452723;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8wuPR2V1X3wwV7qAbJFhwUNsdL1xWCne/bgD1hAOyMk=;
 b=FEFCXrrfix5lJheJAjInkg8aCO2NOUPjLDGJGv2s1CCjYaIIoDNvkw6K28UPWoFwfH
 qlGHpzaayOAbND1DVSWDT6Q3SSeVHpnvcssBJBG9CbclYfT6v0rP0WFg5vMB630F6Jgi
 znzzYVQS/Do7wQCoZCVJt4g6qS/xjU4XwKtyg3cLK17/bJsFWOkVH3+5IWWEN0SeeD0Q
 n14gZWcbMsEx7EjFmW6UTRzpjfDZwgUCZ8/qwFq96IOYs2ouT6i8RpsLfBUoz9f5BUM/
 kLwrWYi6r4seiGDwrkyTCbSjQAH+ulcJ+mREsn8aqbRBKvjdTiPo2p9N5FuGM0GF7K4r
 Uwaw==
X-Gm-Message-State: AC+VfDwH+goZvOzTRscWcJuh0D+LcZYQCl8JmIaBvHLGb7gh17ikLPbr
 MyzeY0r/iMt7hSSHrj2p4Xt9PA==
X-Google-Smtp-Source: ACHHUZ4VU+y3+eWdeFnVkLPHkMk7TiC+IDWdf+Q+RmZVA8TofwW07UaPubSsB2O7C9dvo4Xzv2mDFg==
X-Received: by 2002:a05:6512:108d:b0:4f9:6842:afc with SMTP id
 j13-20020a056512108d00b004f968420afcmr10703110lfg.64.1687860722841; 
 Tue, 27 Jun 2023 03:12:02 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.41.103])
 by smtp.gmail.com with ESMTPSA id
 k10-20020a05600c1c8a00b003f9b3829269sm2114722wms.2.2023.06.27.03.12.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jun 2023 03:12:02 -0700 (PDT)
Message-ID: <f124cd3a-f97b-cf61-6147-ba906bd3e7cd@linaro.org>
Date: Tue, 27 Jun 2023 12:12:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 0/8] target/sparc: Use tcg_gen_lookup_and_goto_ptr
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20230621180607.1516336-1-richard.henderson@linaro.org>
 <2f11ee14-9bf2-85fe-581c-e3024efd2124@ilande.co.uk>
 <c83c2500-08d1-bb03-24d6-990a2f07b01b@ilande.co.uk>
 <35013658-5131-19f6-c95a-c74b73f90ecc@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <35013658-5131-19f6-c95a-c74b73f90ecc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x133.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/27/23 11:37, Philippe Mathieu-Daudé wrote:
> On 27/6/23 08:46, Mark Cave-Ayland wrote:
>> On 22/06/2023 13:26, Mark Cave-Ayland wrote:
>>
>>> On 21/06/2023 19:05, Richard Henderson wrote:
>>>
>>>> Changes from v1:
>>>>    * Split into teeny weeny pieces.
>>>>
>>>>    * It turns out the sparc_tr_tb_stop hunk of v1 was buggy,
>>>>      in that things that are not simple branches use DYNAMIC_PC,
>>>>      e.g. the RETT (return from trap) instruction.
>>>>
>>>>      Introduce DYNAMIC_PC_LOOKUP to distinguish the couple of
>>>>      places where we have a dynamic pc, but no other change
>>>>      of state (conditional branches, JMPL, RETURN).
>>>>
>>>>    * Drop the change for WRFPRS, because it's too infrequent.
>>>>      The WRASI change affects memcpy/memset, so that's more important.
>>>>
>>>> Boots Mark's sol8 install cdrom.  :-)
>>>>
>>>> Top of the profile changes from
>>>>
>>>>      41.55%  qemu-system-sparc              [.] cpu_exec_loop
>>>>      14.02%  qemu-system-sparc              [.] cpu_tb_exec
>>>>       8.74%  qemu-system-sparc              [.] tb_lookup
>>>>       2.11%  qemu-system-sparc              [.] tcg_splitwx_to_rw
>>>>       1.63%  memfd:tcg-jit (deleted)        [.] 0x0000000000000004
>>>>
>>>> to
>>>>
>>>>      31.59%  qemu-system-sparc              [.] helper_lookup_tb_ptr
>>>>      17.79%  qemu-system-sparc              [.] tb_lookup
>>>>       5.38%  qemu-system-sparc              [.] compute_all_sub
>>>>       2.38%  qemu-system-sparc              [.] helper_compute_psr
>>>>       2.36%  qemu-system-sparc              [.] helper_check_align
>>>>       1.79%  memfd:tcg-jit (deleted)        [.] 0x000000000063fc8e
>>>>
>>>> This probably indicates that cpu_get_tb_cpu_state could be
>>>> improved to not consume so much overhead.
>>>
>>> Nice! I've just run this through all of my sun4m/sun4u/sun4v test images and I don't 
>>> see any regressions with v2. The guests feel noticeably more responsive too :)
>>>
>>> Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>>
>>> I've skimmed the patches and without looking in too much detail they seem to be okay so 
>>> I'm happy to give:
>>>
>>> Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>>
>>> Side note: the niagara tests require the patch at 
>>> https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg03537.html which still hasn't 
>>> been merged yet.
>>>
>>>> Richard Henderson (8):
>>>>    target/sparc: Use tcg_gen_lookup_and_goto_ptr in gen_goto_tb
>>>>    target/sparc: Fix npc comparison in sparc_tr_insn_start
>>>>    target/sparc: Drop inline markers from translate.c
>>>>    target/sparc: Introduce DYNAMIC_PC_LOOKUP
>>>>    target/sparc: Use DYNAMIC_PC_LOOKUP for conditional branches
>>>>    target/sparc: Use DYNAMIC_PC_LOOKUP for JMPL
>>>>    target/sparc: Use DYNAMIC_PC_LOOKUP for v9 RETURN
>>>>    target/sparc: Use tcg_gen_lookup_and_goto_ptr for v9 WRASI
>>>>
>>>>   target/sparc/translate.c | 410 ++++++++++++++++++++++-----------------
>>>>   1 file changed, 233 insertions(+), 177 deletions(-)
>>
>> I've just noticed during testing there is an issue with this series when used with a 
>> real SS-5 PROM image (I was using OpenBIOS for my previous tests) which causes it to 
>> assert() almost immediately on startup:
>>
>> $ ./qemu-system-sparc -bios ss5.bin
>> ERROR:../target/sparc/translate.c:5695:sparc_tr_tb_stop: code should not be reached
>> Bail out! ERROR:../target/sparc/translate.c:5695:sparc_tr_tb_stop: code should not be 
>> reached
>> Aborted
> 
> Could you try this fix:
> 
> -- >8 --
> --- a/target/sparc/translate.c
> +++ b/target/sparc/translate.c
> @@ -5682,5 +5682,5 @@ static void sparc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
> 
>           save_npc(dc);
> -        switch (dc->npc) {
> +        switch (dc->npc & 3) {
>           case DYNAMIC_PC_LOOKUP:
>               if (may_lookup) {
> ---
> 
> ?

No, we should have exact equality on those two values.


r~

