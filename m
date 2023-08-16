Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 554A277D8BB
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 05:00:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW6l0-0000dv-PM; Tue, 15 Aug 2023 22:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jniethe5@gmail.com>)
 id 1qW6kt-0000dA-7e; Tue, 15 Aug 2023 22:59:31 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jniethe5@gmail.com>)
 id 1qW6kq-0000Aq-D8; Tue, 15 Aug 2023 22:59:31 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1bdeb022738so15360675ad.0; 
 Tue, 15 Aug 2023 19:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692154767; x=1692759567;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wgeCicBYMMTYFeSNuTJVOGONyTNa12yhCxzh8R2Ho+M=;
 b=i3saViQZzU1gLP8l7qvVinvc4g6vHqAsb7dC3NTLwQatZDHtljgR+GXCYQuwemWdI3
 tiBulQoMIl/BPySTzPUwuC3XGx1051KEnKxer//6uiS8lEnUxBNlTI7tx1Y9yQkMRXM1
 KXoqWtWCT8PrH3fEbxCwAme6rw9w6uimaNrcbWiYAlPN/1PjkwStLaRR1qFRfncURXkg
 I2SRiKtHjy7H0HjSysEEwaXmGYCZ01fLTOv1FMd0V23KEdZVuR2TryBIEukSy0AOTiII
 a4kftx6aWHw1goYk+4nn9H0bNAIfFl6/rrqqo+FMRpsIjRnCBkjDAfAQBgxQ3xP4mjOJ
 aERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692154767; x=1692759567;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wgeCicBYMMTYFeSNuTJVOGONyTNa12yhCxzh8R2Ho+M=;
 b=B89ASEgz1lx17niPRXQvc+jGHT30aqptYd8g0ocHk1d3boVzWtBkH5at3ZsGBGzCV8
 pVwELD9SIUAqhmjv3fUit+qrijgOUr2nNmnVANCRZdAeIj5VCNI439JxJGmViTEZvmby
 VA9+sTPM/wzYqx4ruOUvlkL2l888zpQiAHckegtJhJrNqJdKIFm49mCr4j1XhdfU0Wyo
 1grirNXdI6OMdvYrOPxC7ihaMgu/dLsf5+raCDei5fC8LVT96PuzaYi79O9zxTkhRtqI
 VdFNOYRoZO1jGclJ53xJPaVpjwBU8yFiHiTa+ftGngp4xXlGrBpapvSy6JTmcAJ4sLf/
 fzNg==
X-Gm-Message-State: AOJu0Yw3p4VmNu3ekXZ3Ruqv69cP73uNYXYZ4/blQUCA3xd5gDu7tMnU
 A70q9sjYU5+z+sWK2n05lqI=
X-Google-Smtp-Source: AGHT+IHScaliB48zW/U77pSWAfGLgAZxWV7Bzk8ENCezdboWlyH9Hoqhn7B45vd1GLqPItW7AIuAnQ==
X-Received: by 2002:a17:902:ab4e:b0:1bc:4b77:c74 with SMTP id
 ij14-20020a170902ab4e00b001bc4b770c74mr4257708plb.0.1692154766574; 
 Tue, 15 Aug 2023 19:59:26 -0700 (PDT)
Received: from localhost.localdomain ([146.112.118.69])
 by smtp.gmail.com with ESMTPSA id
 a12-20020a170902eccc00b001aadd0d7364sm11779416plh.83.2023.08.15.19.59.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Aug 2023 19:59:25 -0700 (PDT)
Subject: Re: [RFC PATCH] tcg/ppc: Enable direct branching tcg_out_goto_tb with
 TCG_REG_TB
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, bgray@linux.ibm.com
References: <20230815050117.34731-1-jniethe5@gmail.com>
 <bdea1e60-9368-4a56-66f5-26269033b5d9@linaro.org>
From: Jordan Niethe <jniethe5@gmail.com>
Message-ID: <e36dd7ab-cc02-fdce-4cc0-cca90faad3d8@gmail.com>
Date: Wed, 16 Aug 2023 12:59:21 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <bdea1e60-9368-4a56-66f5-26269033b5d9@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=jniethe5@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-1.045,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 16/8/23 2:07 am, Richard Henderson wrote:
> On 8/14/23 22:01, Jordan Niethe wrote:
>> Direct branch patching was disabled when using TCG_REG_TB in commit
>> 736a1588c1 ("tcg/ppc: Fix race in goto_tb implementation"). Commit
>> 7502f89c74 ("tcg/ppc: Use prefixed instructions for tcg_out_goto_tb")
>> used the support for pc relative ISAv3.1 instructions to re-enable
>> direct branch patching on POWER10.
>>
>> The issue with direct branch patching with TCG_REG_TB is the lack of
>> synchronization between the new TCG_REG_TB being established and the
>> direct branch being patched in.
>>
>> If each translation block is responsible for establishing its own
>> TCG_REG_TB then there can be no synchronization issue.
> 
> That's a good idea, and can be used for other things...
> 
> It also begs the question of whether power10 should continue to use 
> TCG_REG_TB, loading the address with PADDI.  Or whether power9 should, 
> like power10, disable USE_REG_TB and use ADDPCIS throughout.
> 
> I imagine it depends on usage frequency, whether use of TCG_REG_TB 
> allows 1 insn, where addpcis requires 2 insns and prefixed insns require 
> 2 or 3 insn slots (depending on alignment).

Yes, I agree. Your v3 series looks good, I'll try and get some 
performance numbers with it so we can make a decision about which way to 
go on power10 and power9.

> 
> 
>> +        tcg_out32(s, MFSPR | RT(TCG_REG_TMP1) | LR);
>> +        /* bcl 20,31,$+4 (Preferred form for getting nia.) */
>> +        tcg_out32(s, BC | BO_ALWAYS | BI(7, CR_SO) | 0x4 | LK);
>> +        tcg_out32(s, MFSPR | RT(TCG_REG_TB) | LR);
>> +        tcg_out32(s, ADDI | TAI(TCG_REG_TB, TCG_REG_TB, -8));
>> +        tcg_out32(s, MTSPR | RS(TCG_REG_TMP1) | LR);
> 
> Don't need to save/restore LR.  It is saved in the prologue and may be 
> clobbered within the tb itself (as we do for calls >
>> @@ -2678,6 +2693,12 @@ static void tcg_out_goto_tb(TCGContext *s, int 
>> which)
>>       tcg_out32(s, MTSPR | RS(TCG_REG_TMP1) | CTR);
>>       tcg_out32(s, BCCTR | BO_ALWAYS);
>>       set_jmp_reset_offset(s, which);
>> +
>> +    /* For the unlinked case, need to reset TCG_REG_TB.  */
>> +    if (USE_REG_TB) {
>> +        tcg_out_movi_int(s, TCG_TYPE_I64, TCG_REG_TB,
>> +                         (tcg_target_long)s->code_buf, true);
>> +    }
>>   }
> 
> Actually, we don't.  The only time we arrive here is when an unlinked TB 
> branches to itself.  TCG_REG_TB is still valid.

Ok, I was not sure how that was meant to work.

> 
>> diff --git a/tcg/tcg.c b/tcg/tcg.c
>> index ddfe9a96cb..20698131c2 100644
>> --- a/tcg/tcg.c
>> +++ b/tcg/tcg.c
>> @@ -6010,6 +6010,9 @@ int tcg_gen_code(TCGContext *s, TranslationBlock 
>> *tb, uint64_t pc_start)
>>           tcg_malloc(sizeof(uint64_t) * s->gen_tb->icount * start_words);
>>       num_insns = -1;
>> +#ifdef TCG_TARGET_NEED_ENTER_TB
>> +    tcg_out_enter_tb(s);
>> +#endif
> 
> Better would be to not have the ifdef, and add this symbol as an empty 
> function in all other tcg backends.
> 
> I might play around with this a bit.

Thank you for that, adding pcrel support on POWER9 too is really cool.

> 
> 
> r~
> 

