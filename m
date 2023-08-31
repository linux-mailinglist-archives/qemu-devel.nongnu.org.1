Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D3E78F411
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 22:32:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qboK6-0000E4-55; Thu, 31 Aug 2023 16:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qboK2-0000Dn-2Q
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 16:31:22 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qboJy-0002vD-N2
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 16:31:21 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-99bf1f632b8so157542566b.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 13:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693513877; x=1694118677; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mtdlEoylKfuaxgU9p9eMVnqnK5hAjzB7H2Xg8FvVw78=;
 b=v7qdJWYqGHSDaV+oRL/djfy4Ph0F+/FBHOD85uvRaPJwGDIWI/jpfaNaqQQk8Ne1Vf
 QwIiUNiSs49JQxg1Li/KQfRLolLw0X11A6KjdssY3lZrv2olVdQkJIvAoQknbzJqC9rQ
 sAQNDRvq7bGHocFypM4r4U30s4OSuo8oMeO8Rfq9rXwyoQiRnmX/o5e6rPauCj977SD6
 wjKJAYL2Oj7qiknMujLauQDpuNJB4wJplWO5M6L4ARNXmdSQW8ljfmqn2UQQfseTcHRK
 /b1lTf8qEL+R1XPLYrchy6UEDIxgTN7LbXym8EPULy++3LMejoLvvgXgaNjslgWZZlxE
 cf5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693513877; x=1694118677;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mtdlEoylKfuaxgU9p9eMVnqnK5hAjzB7H2Xg8FvVw78=;
 b=edexfPgewl0yABkTLUwkGvXpujBSestQAhZ8LTiNZmJA/xsTVWsjrY8TFFXzzAK0/o
 HfruXvjjAVRK/ReYq3J9Ixas6QuUrZNDcCc83iTiszczDK0A1nQ3keA8X5nWOYTIk8EO
 +g39lGWPROA91YfMXAaDHOllXzUgGVIZl7uT99ZKjPTqwoZ1Fp3TzO5zIFkOIIByTe3b
 3f4OPCq04JF0Oc85Ajp3ig6FDhy5+zGdzDzVO7wQE6IfUyrVH4Jtwzbd5AcRqVT4OxOS
 Ln2hx8rYuBVlNMoZ3EaKeCDb9tLnXXcpuu/A0WFtr4LDCE45EXE/S7ikt4A+DMcrXvxg
 Iliw==
X-Gm-Message-State: AOJu0YxF7AHLXAMqGMfHEuBLwIOSLunfi6cl5jk15OLqsghTH8/TsHRG
 jCQqvjDl0uFME6UeUsOEMazGSoO5HjETyLyrygw=
X-Google-Smtp-Source: AGHT+IFz0Fy0uCkPTwXOpUPwSRNG5Err4U9P7syZGnbTlYwnZCkBeT42d7kFaPVxoFSLVVF5h7csHA==
X-Received: by 2002:a17:906:70d6:b0:9a2:232f:6f79 with SMTP id
 g22-20020a17090670d600b009a2232f6f79mr324680ejk.25.1693513877374; 
 Thu, 31 Aug 2023 13:31:17 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.199.245])
 by smtp.gmail.com with ESMTPSA id
 kb3-20020a1709070f8300b009930c80b87csm1157638ejc.142.2023.08.31.13.31.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Aug 2023 13:31:16 -0700 (PDT)
Message-ID: <0be69905-4781-1d8e-8924-758570b7c5d0@linaro.org>
Date: Thu, 31 Aug 2023 22:31:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 6/6] target/mips: Convert Loongson [D]MULT[U].G opcodes to
 decodetree
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Huacai Chen
 <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20210112215504.2093955-1-f4bug@amsat.org>
 <20210112215504.2093955-7-f4bug@amsat.org>
 <aa2c30c2-deaf-29d4-b166-81690d5443d6@linaro.org>
 <e13600b3-cba5-6d04-1505-8f6c536370b0@linaro.org>
In-Reply-To: <e13600b3-cba5-6d04-1505-8f6c536370b0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.478,
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

On 31/8/23 21:12, Philippe Mathieu-Daudé wrote:
> On 21/1/21 21:06, Richard Henderson wrote:
>> On 1/12/21 11:55 AM, Philippe Mathieu-Daudé wrote:
>>> Convert the following opcodes to decodetree:
>>>
>>> - MULT.G - multiply 32-bit signed integers
>>> - MULTU.G - multiply 32-bit unsigned integers
>>> - DMULT.G - multiply 64-bit signed integers
>>> - DMULTU.G - multiply 64-bit unsigned integers
>>>
>>> Now that all opcodes from the extension have been converted, we
>>> can remove completely gen_loongson_integer() and its 2 calls in
>>> decode_opc_special2_legacy() and decode_opc_special3_legacy().
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> ---
>>>   target/mips/godson2.decode    |  5 ++
>>>   target/mips/loong-ext.decode  |  5 ++
>>>   target/mips/loong_translate.c | 58 ++++++++++++++++++++++
>>>   target/mips/translate.c       | 92 +----------------------------------
>>>   4 files changed, 70 insertions(+), 90 deletions(-)


>>> +static bool gen_lext_MULT_G(DisasContext *s, int rd, int rs, int rt,
>>> +                            bool is_double, bool is_unsigned)
>>> +{
>>> +    TCGv t0, t1;
>>> +
>>> +    if (is_double) {
>>> +        if (TARGET_LONG_BITS != 64) {
>>> +            return false;
>>> +        }
>>> +        check_mips_64(s);
>>> +    }
>>> +
>>> +    if (rd == 0) {
>>> +        /* Treat as NOP. */
>>> +        return true;
>>> +    }
>>> +
>>> +    t0 = tcg_temp_new();
>>> +    t1 = tcg_temp_new();
>>> +
>>> +    gen_load_gpr(t0, rs);
>>> +    gen_load_gpr(t1, rt);
>>> +
>>> +    if (is_unsigned && !is_double) {
>>> +        tcg_gen_ext32u_tl(t0, t0);
>>> +        tcg_gen_ext32u_tl(t1, t1);
>>> +    }
>>
>> While this is a faithful conversion of the existing code, these 
>> extensions make
>> no difference to the result.  They are redundant with
>>
>>> +    tcg_gen_mul_tl(cpu_gpr[rd], t0, t1);
>>> +    if (!is_double) {
>>> +        tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
>>
>> this one, which discards any bit that might have been set by the input 
>> bits
>> that are cleared.
> 
> I see.
> 
>> There is no actual difference between MULT.G and MULTU.G, or DMULT.G and
>> DMULTU.G, because they don't record the most significant bits of the 
>> infinite
>> result in any way.
> 
> Right.
> 
>>> +static bool trans_MULT_G(DisasContext *s, arg_muldiv *a)
>>> +{
>>> +    return gen_lext_MULT_G(s, a->rt, a->rs, a->rd, false, false);
>>> +}
>>> +
>>> +static bool trans_MULTU_G(DisasContext *s, arg_muldiv *a)
>>> +{
>>> +    return gen_lext_MULT_G(s, a->rt, a->rs, a->rd, false, true);
>>> +}
>>> +
>>> +static bool trans_DMULT_G(DisasContext *s, arg_muldiv *a)
>>> +{
>>> +    return gen_lext_MULT_G(s, a->rt, a->rs, a->rd, true, false);
>>> +}
>>> +
>>> +static bool trans_DMULTU_G(DisasContext *s, arg_muldiv *a)
>>> +{
>>> +    return gen_lext_MULT_G(s, a->rt, a->rs, a->rd, true, true);
>>> +}
>>
>> So... if you want to clean this up afterward, or before is up to you.

"before" ended being way simpler :>


