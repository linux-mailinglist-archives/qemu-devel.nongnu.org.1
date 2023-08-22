Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5269478485E
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 19:23:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYV5s-0002l1-1D; Tue, 22 Aug 2023 13:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYV5d-0002i6-Ki
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 13:22:49 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYV5b-0006ey-58
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 13:22:49 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fee600dce6so31512925e9.1
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 10:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692724964; x=1693329764;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Pew9QlFygzIit3zZO/KL++py1uZpNTLt5wxOEtYy9f4=;
 b=t2gjY1f9S9q2x6L6y0AwzQk1aWXfOjzjvIzBGJANK5fXeHs3LExKip2luO+8mBVuu9
 W3ZuifNd4H8zq5rkf4vvzUfcN/46bmrsnCft6qlIt+ZAT04mR6LZrlt7Od/3i0OLHf6/
 exsPmWrRSYKoo7M18bkT9j+Ezh6zJfSSjcKN6YCPRv34YZEy0E81shkHxZrmuRXZvAew
 xh8eXCfdKI2c3Qj5OhMDnnMNXzI/cZ2kmCQ9PaDU19Og35pg7kxblDrWWwJdw1lQPfb9
 3quN0e5LO8s0gmsxMhhVVaRVfRx+pq7hImAxqkU2Cvv9Fhn6lAQjAS+zbvRq+leLJxv7
 B0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692724964; x=1693329764;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Pew9QlFygzIit3zZO/KL++py1uZpNTLt5wxOEtYy9f4=;
 b=g1mOE8Sg4Dd1F0HEM7ehutpOiEiMkl03q+tGBFwKZ2r8mZKJZB2CilaCSK+q0K9uG5
 XA15ff9I9uNXaigNeDR06JiusNk4smKv37rr9eyW/IXfgcQGoY+zbLk3z6IF5lI+qBe7
 2x1W+0PAn2TyJ1Ie1SR6sOLhLwzJwQAiLyegJnn095nJCAMVpyCO7ISNcdbXCpxgM/6N
 Vf752e45YJVcab6+1tb69DhtqY81eihIScBymM1jgfLuW1SkCVhLyT/kJb52QbGD/hwj
 uHwd9hfcprQaDvfXKmjCuiocubKidgIc8YS7i5mde2fJgPKfBk1FwDC35CIMRR1tTuLP
 UoeA==
X-Gm-Message-State: AOJu0YydBtciUwpRiAsjyaEik0j+catpI091zVtZqcmG0e+Rof6oorvQ
 vSe+U0HFXM2aSqmMfWSPmA60wY4dURRNTN56UbxHNg==
X-Google-Smtp-Source: AGHT+IFceesgF3OcRhIsGAzIgNoe/U7dQzZ8Mh8USWN9SrmD0/3QpLNURr+lI5cNKHrw4hhdaZyMQA==
X-Received: by 2002:a7b:ca50:0:b0:3fe:1cd8:acf3 with SMTP id
 m16-20020a7bca50000000b003fe1cd8acf3mr7812134wml.17.1692724964016; 
 Tue, 22 Aug 2023 10:22:44 -0700 (PDT)
Received: from [10.2.0.2] ([37.19.214.4]) by smtp.gmail.com with ESMTPSA id
 u12-20020adff88c000000b003198a9d758dsm16484298wrp.78.2023.08.22.10.22.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 10:22:43 -0700 (PDT)
Message-ID: <09f4ba68-e7f3-8a90-e996-e475b760c64a@linaro.org>
Date: Tue, 22 Aug 2023 19:22:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 1/7] tcg/tcg-op: Document bswap16() byte pattern
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230822093712.38922-1-philmd@linaro.org>
 <20230822093712.38922-2-philmd@linaro.org>
 <c538a498-05e4-23ed-328e-7355436f6c7a@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <c538a498-05e4-23ed-328e-7355436f6c7a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.767,
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

On 22/8/23 17:58, Richard Henderson wrote:
> On 8/22/23 02:37, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   tcg/tcg-op.c | 48 ++++++++++++++++++++++++++++++++----------------
>>   1 file changed, 32 insertions(+), 16 deletions(-)
>>
>> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
>> index 7aadb37756..f164ddc95e 100644
>> --- a/tcg/tcg-op.c
>> +++ b/tcg/tcg-op.c
>> @@ -1021,6 +1021,13 @@ void tcg_gen_ext16u_i32(TCGv_i32 ret, TCGv_i32 
>> arg)
>>       }
>>   }
>> +/*
>> + * bswap16_i32: 16-bit byte swap on the low bits of a 32-bit value.
>> + *
>> + * Byte pattern:  bswap16_i32(xxab) -> ..ba             (TCG_BSWAP_OZ)
>> + *                bswap16_i32(xxab) -> ssba             (TCG_BSWAP_OS)
>> + *                bswap16_i32(xxab) -> xxba
>> + */
> 
> Don't forget TCG_BSWAP_IZ, which means the input is already zero-extended.
> Which makes
> 
>> +                                            /* arg = xxab */
>> +        tcg_gen_shri_i32(t0, arg, 8);       /*  t0 = .xxa */
> 
> this
> 
>>           if (!(flags & TCG_BSWAP_IZ)) {
>> -            tcg_gen_ext8u_i32(t0, t0);
>> +            tcg_gen_ext8u_i32(t0, t0);      /*  t0 = ...a */
>>           }
>>           if (flags & TCG_BSWAP_OS) {
>> -            tcg_gen_shli_i32(t1, arg, 24);
>> -            tcg_gen_sari_i32(t1, t1, 16);
>> +            tcg_gen_shli_i32(t1, arg, 24);  /*  t1 = b... */
>> +            tcg_gen_sari_i32(t1, t1, 16);   /*  t1 = ssb. */
>>           } else if (flags & TCG_BSWAP_OZ) {
>> -            tcg_gen_ext8u_i32(t1, arg);
>> -            tcg_gen_shli_i32(t1, t1, 8);
>> +            tcg_gen_ext8u_i32(t1, arg);     /*  t1 = ...b */
>> +            tcg_gen_shli_i32(t1, t1, 8);    /*  t1 = ..b. */
>>           } else {
>> -            tcg_gen_shli_i32(t1, arg, 8);
>> +            tcg_gen_shli_i32(t1, arg, 8);   /*  t1 = xab. */
> 
> and this slightly inaccurate.
> 
>>           }
>> -        tcg_gen_or_i32(ret, t0, t1);
>> +        tcg_gen_or_i32(ret, t0, t1);        /* ret = ssba */
> 
> This one is just confusing, since each of the three cases above have 
> different outputs.

Is that formatting OK with you?

/*
  * bswap16_i32: 16-bit byte swap on the low bits of a 32-bit value.
  *
  * Byte pattern:  bswap16_i32(..ab) -> ..ba             (TCG_BSWAP_IZ)
  *                bswap16_i32(xxab) -> ..ba             (TCG_BSWAP_OZ)
  *                bswap16_i32(xxab) -> ssba             (TCG_BSWAP_OS)
  *                bswap16_i32(xxab) -> xxba
  */
void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags)
{
     /* Only one extension flag may be present. */
     tcg_debug_assert(!(flags & TCG_BSWAP_OS) || !(flags & TCG_BSWAP_OZ));

     if (TCG_TARGET_HAS_bswap16_i32) {
         tcg_gen_op3i_i32(INDEX_op_bswap16_i32, ret, arg, flags);
     } else {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         TCGv_i32 t1 = tcg_temp_ebb_new_i32();

                                             /* arg = xxab (IZ=0) */
                                             /*       ..ab (IZ=1) */
         tcg_gen_shri_i32(t0, arg, 8);       /*  t0 = .xxa (IZ=0) */
                                             /*       ...a (IZ=1) */
         if (!(flags & TCG_BSWAP_IZ)) {
             tcg_gen_ext8u_i32(t0, t0);      /*  t0 = ...a */
         }

         if (flags & TCG_BSWAP_OS) {
             tcg_gen_shli_i32(t1, arg, 24);  /*  t1 = b... */
             tcg_gen_sari_i32(t1, t1, 16);   /*  t1 = ssb. */
         } else if (flags & TCG_BSWAP_OZ) {
             tcg_gen_ext8u_i32(t1, arg);     /*  t1 = ...b */
             tcg_gen_shli_i32(t1, t1, 8);    /*  t1 = ..b. */
         } else {
             tcg_gen_shli_i32(t1, arg, 8);   /*  t1 = xab. (IZ=0) */
                                             /*       .ab. (IZ=1) */
         }

         tcg_gen_or_i32(ret, t0, t1);        /* ret = ..ba (IZ=1 or OZ=1) */
                                             /*     = ssba (OS=1)         */
                                             /*     = xxba (no flag)      */
         tcg_temp_free_i32(t0);
         tcg_temp_free_i32(t1);
     }
}

---

