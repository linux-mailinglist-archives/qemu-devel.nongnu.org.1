Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6D978C8E9
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 17:54:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb12A-0004Wy-R7; Tue, 29 Aug 2023 11:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qb124-0004Pt-KU
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 11:53:32 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qb120-0007M5-19
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 11:53:32 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-50043cf2e29so7063679e87.2
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 08:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693324406; x=1693929206;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NPUupQhjPaZscIMuSsKoDXRu6UZtAAPe3Rb66X0uhb4=;
 b=zVrmFpwUKp9HPV15y93B4oadeW9RA4r+OjpXOQxqxfzJHCiwyFkvSwlAb1s95IOJda
 vV3ZGs2BwDxAJrsNyXtyR+t73rbcoV1UgBjFEWYceTqF0WgMOUhpiPcouRTPxfClINuy
 MO6rcoSBuxsq9DVwkaRyQi1AAmfaSpwkcJypzBRCQx0DYf+NFvXUbVMnxtU2XCxfenNA
 RmIyoXvA6UO4l3gPwkC+EHzNKSQpgtcXdNDXT8jnyIFlc11EL5EmUS/oJ2NzO2KAx1zk
 w/nHGj9G7FueQLsIoTMn44T5VQcql+EgMbU2YziNVFxEmKQlUNeBNlz1rhWa++I0RDcp
 NCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693324406; x=1693929206;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NPUupQhjPaZscIMuSsKoDXRu6UZtAAPe3Rb66X0uhb4=;
 b=fVijKeZd5STx/8vcW1xvPO7fE30nZSD+GHzXSz98FkXAe7wbvB6r/0hoNtf4Xz4Gxg
 pWvCBo26308Pw4cNKezu9m802x86cDMepDl9jP0TkrDq+a13Uiz7wB7IT+cMEjbDvIQG
 jPWFfJE0QTePZlrrzKVkq/248o3roY6jcEGAS22HRc4MEGvAaOLXvpnXVLGjDTxBkJb+
 gXoD8FKY7YGrGSdc4CjGTXZMxOzl/JrOFft8JS4Ir+578ktaTkPZk38xuQT0REtjbKTR
 u2D1vluhuJP14ojNJSzBrTjoJHO7WjvT3IQ7bPq6KvxQKfvZBAziXpRIxuZPB7LWqVAc
 4YzQ==
X-Gm-Message-State: AOJu0YyDKkuz0jEd7FWEoJS53QMc8tu8CUiofvRvQ7QNTOVOuZHRjVgd
 KATY+y5qhgGY4MVZcEm4ATbp279I5x/57EQ723w=
X-Google-Smtp-Source: AGHT+IGDaIeP6kNoO0BDl1wgH8ClajEv4jZTdZmyY7KDq1/GZgNEfgmRAdQIAs3UDBDTULjKgtdCYg==
X-Received: by 2002:a05:6512:ea4:b0:4f8:7897:55e6 with SMTP id
 bi36-20020a0565120ea400b004f8789755e6mr25619892lfb.45.1693324405943; 
 Tue, 29 Aug 2023 08:53:25 -0700 (PDT)
Received: from [192.168.69.115] (sml13-h01-176-184-15-56.dsl.sta.abo.bbox.fr.
 [176.184.15.56]) by smtp.gmail.com with ESMTPSA id
 h12-20020aa7c94c000000b00528922bb53bsm5786887edt.76.2023.08.29.08.53.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 08:53:25 -0700 (PDT)
Message-ID: <02cd3850-49f4-7a0c-7f92-2461582dabc1@linaro.org>
Date: Tue, 29 Aug 2023 17:53:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] target/arm: Use deposit_z() in BCF opcode
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20230822095156.39868-1-philmd@linaro.org>
 <CAFEAcA8CWDg8cBjr_KJdTE2AvvdksU7jGhfHp5sdQU7FHbAb4w@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA8CWDg8cBjr_KJdTE2AvvdksU7jGhfHp5sdQU7FHbAb4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 29/8/23 15:20, Peter Maydell wrote:
> On Tue, 22 Aug 2023 at 10:51, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> When clearing a bitfield we don't need to lead the
> 
> "load" ?
> 
>> source register. Use deposit_z_i32() with the BFC
>> opcode to save a load_reg() call.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/arm/tcg/translate.c | 9 ++++-----
>>   1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
>> index b71ac2d0d5..1a6938d1b3 100644
>> --- a/target/arm/tcg/translate.c
>> +++ b/target/arm/tcg/translate.c
>> @@ -7255,7 +7255,7 @@ static bool trans_UBFX(DisasContext *s, arg_UBFX *a)
>>   static bool trans_BFCI(DisasContext *s, arg_BFCI *a)
>>   {
>>       int msb = a->msb, lsb = a->lsb;
>> -    TCGv_i32 t_in, t_rd;
>> +    TCGv_i32 t_rd;
>>       int width;
>>
>>       if (!ENABLE_ARCH_6T2) {
>> @@ -7268,15 +7268,14 @@ static bool trans_BFCI(DisasContext *s, arg_BFCI *a)
>>       }
>>
>>       width = msb + 1 - lsb;
>> +    t_rd = load_reg(s, a->rd);
>>       if (a->rn == 15) {
>>           /* BFC */
>> -        t_in = tcg_constant_i32(0);
>> +        tcg_gen_deposit_z_i32(t_rd, t_rd, lsb, width);
>>       } else {
>>           /* BFI */
>> -        t_in = load_reg(s, a->rn);
>> +        tcg_gen_deposit_i32(t_rd, t_rd, load_reg(s, a->rn), lsb, width);
>>       }
>> -    t_rd = load_reg(s, a->rd);
>> -    tcg_gen_deposit_i32(t_rd, t_rd, t_in, lsb, width);
>>       store_reg(s, a->rd, t_rd);
>>       return true;
> 
> The comment says we are saving a load_reg() call, but the
> code change doesn't seem to do that. Before the change:
>   * for BFC we call load_reg for rd
>   * for BFI we call load_reg for rn and rd
> 
> After the change:
>   * for BFC we call load_reg for rd
>   * for BFI we call load_reg for rn and rd
> 
> So we're not saving any load_reg() calls as far as I can see ?

Indeed you are right.

The optimizations are in tcg_gen_deposit_z_i32() vs using
tcg_gen_deposit_i32(). I'll reword the description.

Thanks,

Phil.

