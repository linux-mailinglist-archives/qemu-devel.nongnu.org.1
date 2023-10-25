Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B21917D6300
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 09:33:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvYOD-00055g-JK; Wed, 25 Oct 2023 03:33:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvYOB-00054k-1d
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:33:15 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvYO9-0005b6-1T
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:33:14 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40837ebba42so39043605e9.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 00:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698219191; x=1698823991; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ePDxeLSTGVqNV4XXc9lMbomksN2eaY50MKvBZy/sYXc=;
 b=W0Pbxh+GpqJK4kdz73bGMfG9c95M8fyaT8HOR/RSV5TugrS+rHQhA3puUrOt8I/252
 wCkJRRUMtm9osooGhNkea5JNcXhxGt1Mx0baO7tIq+8KcLyiJvc9VQU0IixBRudeaaWt
 SKphS0/NuN8/0vroXKa94W7ElFUEmldx9iq1dmbtWYEAdKumVBp01jrXKslwHaJHJIjt
 2hU5HQuEIhoEE43SlJ8KQSpTGcGN9F9sXH3YgXoLzNI87XOeWItpaSOgBDt7iXVveDva
 5acTQxhdq+hoswYNLYMeQGDoEsf9jqlEpS3SVvWMSQd4QTQuqZhbW4UN2nYTub0DUxGc
 J92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698219191; x=1698823991;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ePDxeLSTGVqNV4XXc9lMbomksN2eaY50MKvBZy/sYXc=;
 b=AIFmH5yk2yRuzK42ebWyzddMKZjZPMjSbgQLwLfhi87v6YIjDc+a5BAGNyrGpnCun5
 T9RLES/IUkvufSB/CfpoUXcglS6ntxH8NSIdcaciecWuGu8kNa0J3vSSsT7L1eD9ObBa
 +UMKtgJmLHE1Khh704ItW04mBNIbftmvR80v9joVUyIi7cawsy4X+N60DgXkXIRhrzTD
 mjdwl248mfsCeZQQ0IlWFlxanjUj7NJDsf76ezX86Yk6AMK29tGzFAgsIOZPvUc4A8yl
 RJaeWQr9gefNMJiJYQTxH6ITteRySWJWEw/bav0zSQKUgYGf/5SHbgiQhuA7ZpcDueWL
 oS9Q==
X-Gm-Message-State: AOJu0Ywvzp4TCfC0RdMsAevqND6OaQpJqyJ70Oh/FKx0DzuOTIA8YUUf
 Qx2lmN78aqqxGJhlG45j0l/Jfw==
X-Google-Smtp-Source: AGHT+IGKKqN+5V0UqAKU1WabNPSZZrGWQDG7KjV0q9fdjRqa7+8rYl2QE8iqZ7VWqK38R7Q6y+ydRw==
X-Received: by 2002:a05:600c:5488:b0:408:4d0e:68ac with SMTP id
 iv8-20020a05600c548800b004084d0e68acmr11060701wmb.32.1698219191250; 
 Wed, 25 Oct 2023 00:33:11 -0700 (PDT)
Received: from [192.168.69.115] (ghy59-h01-176-171-219-76.dsl.sta.abo.bbox.fr.
 [176.171.219.76]) by smtp.gmail.com with ESMTPSA id
 z2-20020a05600c0a0200b004060f0a0fd5sm13893928wmp.13.2023.10.25.00.33.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Oct 2023 00:33:10 -0700 (PDT)
Message-ID: <9da94605-2320-d90d-7caf-847e615f730b@linaro.org>
Date: Wed, 25 Oct 2023 09:33:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 9/9] target/ppc: Use tcg_gen_sextract_tl
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
References: <20231023160944.10692-1-philmd@linaro.org>
 <20231023160944.10692-10-philmd@linaro.org>
 <b9d9c1a0-5b20-4d33-aaf2-f12097122004@linaro.org>
 <CWHBYSZE3X91.1YCI4JXJ3H2SE@wheely>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CWHBYSZE3X91.1YCI4JXJ3H2SE@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

Hi Nicholas,

On 25/10/23 09:09, Nicholas Piggin wrote:
> On Tue Oct 24, 2023 at 11:04 AM AEST, Richard Henderson wrote:
>> On 10/23/23 09:09, Philippe Mathieu-Daudé wrote:
>>> Inspired-by: Richard Henderson <richard.henderson@linaro.org>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>> RFC: Please double-check 32/64 & bits
>>> ---
>>>    target/ppc/translate.c | 22 ++++------------------
>>>    1 file changed, 4 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
>>> index c6e1f7c2ca..1370db9bd5 100644
>>> --- a/target/ppc/translate.c
>>> +++ b/target/ppc/translate.c
>>> @@ -2892,13 +2892,7 @@ static void gen_slw(DisasContext *ctx)
>>>    
>>>        t0 = tcg_temp_new();
>>>        /* AND rS with a mask that is 0 when rB >= 0x20 */
>>> -#if defined(TARGET_PPC64)
>>> -    tcg_gen_shli_tl(t0, cpu_gpr[rB(ctx->opcode)], 0x3a);
>>> -    tcg_gen_sari_tl(t0, t0, 0x3f);
>>> -#else
>>> -    tcg_gen_shli_tl(t0, cpu_gpr[rB(ctx->opcode)], 0x1a);
>>> -    tcg_gen_sari_tl(t0, t0, 0x1f);
>>> -#endif
>>> +    tcg_gen_sextract_tl(t0, cpu_gpr[rB(ctx->opcode)], 5, 1);
>>>        tcg_gen_andc_tl(t0, cpu_gpr[rS(ctx->opcode)], t0);
>>
>> Patch looks correct as is, so
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

So are you OK to take this patch as-is as a first iteration?

>> However:
>> I'd be tempted to use and+movcond instead of sext+andc.
> 
> That would be simpler / more mechnical following of specification
> in the ISA. Might be better to save that for a later patch though.
> Any downsides for backend generation? On host without cmov?
> 
>> Also there is a special case of 32-bit shifts with 64-bit shift count on ppc64.
>>
>> #ifdef TARGET_PPC64
>>       tcg_gen_andi_tl(t0, rb, 0x3f);
>> #else
>>       tcg_gen_andi_tl(t0, rb, 0x1f);
>>       tcg_gen_andi_tl(t1, rb, 0x20);
>>       tcg_gen_movcond_tl(TCG_COND_NE, t1, t1, zero, zero, rs);
>>       rs = t1;
>> #endif
>>       tcg_gen_shl_tl(ra, rs, t0);
>>       tcg_gen_ext32u_tl(ra, ra);
>>
>>
>> It also makes me wonder about adding some TCGCond for bit-test so that this could be
>>
>>       tcg_gen_movcond_tl(TCG_COND_TSTNE, t1, rb, 0x20, 0, 0, rs);
>>
>> and make use of the "test" vs "cmp" instructions on most hosts, but especially x86.
> 
> Might be useful.

Now closer:
https://lore.kernel.org/qemu-devel/20231025072707.833943-1-richard.henderson@linaro.org/

:)


