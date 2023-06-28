Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCAE74131D
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 15:56:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEVdZ-0002Ho-5Z; Wed, 28 Jun 2023 09:55:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qEVdT-0002HD-0W
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 09:55:07 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qEVdR-0005Us-8f
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 09:55:06 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-307d58b3efbso5221168f8f.0
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 06:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687960503; x=1690552503;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J4oQgtM+eJxWu8/OmEL9gyUEfN79NG26Bp/O0pvgx4E=;
 b=HslIOAFZThJZdYodA4H7GMPEUVcBAYB/emsq6Tv3IBql+f03b+Cy15f2Xtd5VLlJKp
 VxJqvp30bPR8oRi2qyjD9EU6bVlTPEhHWsL+FGEZ+OE77OCuSbgqDt1xZI3R6Oju0+b8
 ChsGJA9A/5kMFx+HyuFsOya8FXeu+BLLNLIZvV5cLS00TbaVISZlYRfTh/C/wYB2/zd0
 6dFWogPFToPemOeAGdjXATeqKBVyElVctuqHF/HEHm4JQtBZnfgETp53LYGJk59xc/0+
 JNJ2eu1vnSdnZFd6i3RxqW9clzZh/x8D8VgDj6/KD4s5VtUQk3UjkTvAYOYlf8lWXRyj
 woDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687960503; x=1690552503;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J4oQgtM+eJxWu8/OmEL9gyUEfN79NG26Bp/O0pvgx4E=;
 b=LCSBOUW1UsYF0cWiM3gIeZ/AbTV9x3ZlTsklXBVVUUF1kMe50q4pPTCxXpomLvDW4c
 rwmUg2YYiWGLVdMscHewDyeR4Um6Nr9tC/bM1oaoPeH3+j/0KyPwe0HCIFN+UNUn8pf9
 hWkaTwpRC957tMMbEbLR8G81x7PQIsO9bnuxiNw9+piVUqMxXaHygRVyKR/UxySmZm8j
 FJbMwVQCMKaWwgtqKvGCGipttB8t5xLwhp8olmCvcn419B+xs6i5Ac2Z0yuXDTsUhj6A
 Day8gfdQ7YO9dpxDKbW4RjY+FDztI9IkGFmki7tDh0NxJastvdPaazWLZoHAS29EJQjm
 aC8g==
X-Gm-Message-State: AC+VfDxRgIUdgeoUlJOnldZntmKvfKCOf/iNM9gQeNckFMfKBFnXhgiI
 3mEhbBw63ry6XFVF9VX9WNts5A==
X-Google-Smtp-Source: ACHHUZ4NpSKDIehoe7ymFv385kaZEg8uTeR+tDrYIDs0gd+T9sqUAs/vJiCC++K1Su5RHtlD90Fhpw==
X-Received: by 2002:adf:e408:0:b0:313:ec90:ac25 with SMTP id
 g8-20020adfe408000000b00313ec90ac25mr7364697wrm.11.1687960503570; 
 Wed, 28 Jun 2023 06:55:03 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.41.103])
 by smtp.gmail.com with ESMTPSA id
 a10-20020adfeeca000000b00314103d6daesm950642wrp.47.2023.06.28.06.55.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jun 2023 06:55:03 -0700 (PDT)
Message-ID: <1cc1cbce-50be-b714-68d3-205bf9d54c78@linaro.org>
Date: Wed, 28 Jun 2023 15:55:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 02/10] target/sparc: Use tcg_gen_lookup_and_goto_ptr in
 gen_goto_tb
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
References: <20230628114504.546265-1-mark.cave-ayland@ilande.co.uk>
 <20230628114504.546265-3-mark.cave-ayland@ilande.co.uk>
 <813defa4-a833-2486-a89e-3a0f4e0b8d10@eik.bme.hu>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <813defa4-a833-2486-a89e-3a0f4e0b8d10@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 6/28/23 15:00, BALATON Zoltan wrote:
> On Wed, 28 Jun 2023, Mark Cave-Ayland wrote:
>> From: Richard Henderson <richard.henderson@linaro.org>
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> Message-Id: <20230628071202.230991-2-richard.henderson@linaro.org>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>> target/sparc/translate.c | 4 ++--
>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/sparc/translate.c b/target/sparc/translate.c
>> index bad2ec90a0..28d4cdb8b4 100644
>> --- a/target/sparc/translate.c
>> +++ b/target/sparc/translate.c
>> @@ -318,10 +318,10 @@ static void gen_goto_tb(DisasContext *s, int tb_num,
>>         tcg_gen_movi_tl(cpu_npc, npc);
>>         tcg_gen_exit_tb(s->base.tb, tb_num);
>>     } else {
>> -        /* jump to another page: currently not optimized */
>> +        /* jump to another page: we can use an indirect jump */
>>         tcg_gen_movi_tl(cpu_pc, pc);
>>         tcg_gen_movi_tl(cpu_npc, npc);
>> -        tcg_gen_exit_tb(NULL, 0);
>> +        tcg_gen_lookup_and_goto_ptr();
> 
> Out of curiosity, did you test this is actually faster? The reason I ask is because I've 
> tried to optimise similar case in target/ppc by using lookup_and_goto_ptr but found it was 
> slower than without that. I think this may depend on the usage but I wonder if that could 
> be a generic issue with lookup_and_goto_ptr or only specific for the case I've tried.

It is faster.

It should be *always* faster, because returning to the main cpu loop will always do more 
work than merely checking to see if we already have built the required TB.

If you see slowdowns, then *probably* you are using lookup_and_goto_ptr incorrectly in 
some instance, such that an interrupt has gotten overly delayed.  (One must always return 
to the main loop after anything that might re-enable interrupts.  Otherwise the interrupt 
handler may be delayed indefinitely.  This was in fact the problem with v1 of this patch set.)


r~

