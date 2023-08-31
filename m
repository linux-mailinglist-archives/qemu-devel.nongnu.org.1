Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3F278F325
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 21:14:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbn6M-0004Ak-7q; Thu, 31 Aug 2023 15:13:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbn60-00046H-68
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 15:12:49 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbn5x-00013a-6U
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 15:12:47 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-9a21b6d105cso139654466b.3
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 12:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693509163; x=1694113963; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JU+uZG7slio/IEiiD/btpXK94Pz0x3aIB0M6+r48syQ=;
 b=tI9es1zR/D308eNm833L6HlnmaiLEoF94gVnCSzPrzK2LWCWC7wiyfaTfb6bPsIy6H
 q3DIxADRramWT7ftRY6om8rf+ziaMJcBhEfZUkfErKZ88VkMQtrPkwqt4trKmdlO/B9M
 hUECW953QEPXtcucjwrAlmUEsK1NrRfTFuuqtVQtLPME+t6AaFOPeve01lc3q031jLOi
 c3AsoSCZzxyKXgItY2Y1sZq0aTCBCEOzXtL6/ZPJsWICnAKZlQ8MfKlSNFZJhFRN72du
 o6bZh/oFUpAnJiLH4S3cFVhtJIokt2Ck7iZ3n7ne3LulPBAkhtOcq+1z71rkJHhkp1NE
 wWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693509163; x=1694113963;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JU+uZG7slio/IEiiD/btpXK94Pz0x3aIB0M6+r48syQ=;
 b=hZpAQGOzz/xZPvg6A+5MlN+Awq6zN4xrziXC8S6aXfQRsh5jOd+Arw8UzZF8cjDj9m
 Gs5FrFtoeQmIu7+LxTv0yeUKNM98PnBYCTk5uyH4nu254kRQACVfKYh6w4NNqeui5PCC
 YBNbQv6glww6OWADZ3wi0bx4cGMJP/xQrGexkqM992gaYX4nUl+nOvNTcRWGnCkxmMN/
 eUJe7aaefuBwtemLtI9TmPys/sdir1AjtfJdtgM3sOkCQrJuwXArrhmyOWjtj2S4oJe/
 YunilZgC8mOHC0nQKv0py+de9NO6nwZFg82MrhNxSG2EZTOnf9d2pTD0sL7m7ldcW/2N
 5XRA==
X-Gm-Message-State: AOJu0YyStdD+pcKMixYPGDrC8IxBVCCg2LHd5yof7D/Altn7Y7Wqxtay
 Asb9KRW8Yd4aWZw/8FkfMXj6vw==
X-Google-Smtp-Source: AGHT+IGVp+gTsctKPnQPu4j27tJgfhqJpq5J7jM0TBOhBLaWVos3JEg3sTmEIDUhtAiJLJrA/p2EKQ==
X-Received: by 2002:a17:906:2d4:b0:9a5:a6e2:5ea8 with SMTP id
 20-20020a17090602d400b009a5a6e25ea8mr225725ejk.29.1693509162966; 
 Thu, 31 Aug 2023 12:12:42 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.199.245])
 by smtp.gmail.com with ESMTPSA id
 gj17-20020a170906e11100b009929ab17bdfsm1048191ejb.168.2023.08.31.12.12.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Aug 2023 12:12:42 -0700 (PDT)
Message-ID: <e13600b3-cba5-6d04-1505-8f6c536370b0@linaro.org>
Date: Thu, 31 Aug 2023 21:12:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 6/6] target/mips: Convert Loongson [D]MULT[U].G opcodes to
 decodetree
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Huacai Chen
 <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20210112215504.2093955-1-f4bug@amsat.org>
 <20210112215504.2093955-7-f4bug@amsat.org>
 <aa2c30c2-deaf-29d4-b166-81690d5443d6@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <aa2c30c2-deaf-29d4-b166-81690d5443d6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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

On 21/1/21 21:06, Richard Henderson wrote:
> On 1/12/21 11:55 AM, Philippe Mathieu-Daudé wrote:
>> Convert the following opcodes to decodetree:
>>
>> - MULT.G - multiply 32-bit signed integers
>> - MULTU.G - multiply 32-bit unsigned integers
>> - DMULT.G - multiply 64-bit signed integers
>> - DMULTU.G - multiply 64-bit unsigned integers
>>
>> Now that all opcodes from the extension have been converted, we
>> can remove completely gen_loongson_integer() and its 2 calls in
>> decode_opc_special2_legacy() and decode_opc_special3_legacy().
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>   target/mips/godson2.decode    |  5 ++
>>   target/mips/loong-ext.decode  |  5 ++
>>   target/mips/loong_translate.c | 58 ++++++++++++++++++++++
>>   target/mips/translate.c       | 92 +----------------------------------
>>   4 files changed, 70 insertions(+), 90 deletions(-)
>>
>> diff --git a/target/mips/godson2.decode b/target/mips/godson2.decode
>> index 805452fa975..cf12d9072ec 100644
>> --- a/target/mips/godson2.decode
>> +++ b/target/mips/godson2.decode
>> @@ -13,6 +13,11 @@
>>   
>>   @rs_rt_rd       ...... rs:5  rt:5  rd:5  ..... ......   &muldiv
>>   
>> +MULT.G          011111 ..... ..... ..... 00000 011000   @rs_rt_rd
>> +MULTU.G         011111 ..... ..... ..... 00000 011001   @rs_rt_rd
>> +DMULT.G         011111 ..... ..... ..... 00000 011100   @rs_rt_rd
>> +DMULTU.G        011111 ..... ..... ..... 00000 011101   @rs_rt_rd
>> +
>>   DIV.G           011111 ..... ..... ..... 00000 011010   @rs_rt_rd
>>   DIVU.G          011111 ..... ..... ..... 00000 011011   @rs_rt_rd
>>   DDIV.G          011111 ..... ..... ..... 00000 011110   @rs_rt_rd
>> diff --git a/target/mips/loong-ext.decode b/target/mips/loong-ext.decode
>> index b0715894ee1..2281afaad95 100644
>> --- a/target/mips/loong-ext.decode
>> +++ b/target/mips/loong-ext.decode
>> @@ -14,6 +14,11 @@
>>   
>>   @rs_rt_rd       ...... rs:5  rt:5  rd:5  ..... ......   &muldiv
>>   
>> +MULT.G          011100 ..... ..... ..... 00000 010000   @rs_rt_rd
>> +DMULT.G         011100 ..... ..... ..... 00000 010001   @rs_rt_rd
>> +MULTU.G         011100 ..... ..... ..... 00000 010010   @rs_rt_rd
>> +DMULTU.G        011100 ..... ..... ..... 00000 010011   @rs_rt_rd
>> +
>>   DIV.G           011100 ..... ..... ..... 00000 010100   @rs_rt_rd
>>   DDIV.G          011100 ..... ..... ..... 00000 010101   @rs_rt_rd
>>   DIVU.G          011100 ..... ..... ..... 00000 010110   @rs_rt_rd
>> diff --git a/target/mips/loong_translate.c b/target/mips/loong_translate.c
>> index 50609ce4178..2af94535921 100644
>> --- a/target/mips/loong_translate.c
>> +++ b/target/mips/loong_translate.c
>> @@ -263,6 +263,64 @@ static bool trans_DMODU_G(DisasContext *s, arg_muldiv *a)
>>       return gen_lext_MODU_G(s, a->rt, a->rs, a->rd, true);
>>   }
>>   
>> +static bool gen_lext_MULT_G(DisasContext *s, int rd, int rs, int rt,
>> +                            bool is_double, bool is_unsigned)
>> +{
>> +    TCGv t0, t1;
>> +
>> +    if (is_double) {
>> +        if (TARGET_LONG_BITS != 64) {
>> +            return false;
>> +        }
>> +        check_mips_64(s);
>> +    }
>> +
>> +    if (rd == 0) {
>> +        /* Treat as NOP. */
>> +        return true;
>> +    }
>> +
>> +    t0 = tcg_temp_new();
>> +    t1 = tcg_temp_new();
>> +
>> +    gen_load_gpr(t0, rs);
>> +    gen_load_gpr(t1, rt);
>> +
>> +    if (is_unsigned && !is_double) {
>> +        tcg_gen_ext32u_tl(t0, t0);
>> +        tcg_gen_ext32u_tl(t1, t1);
>> +    }
> 
> While this is a faithful conversion of the existing code, these extensions make
> no difference to the result.  They are redundant with
> 
>> +    tcg_gen_mul_tl(cpu_gpr[rd], t0, t1);
>> +    if (!is_double) {
>> +        tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
> 
> this one, which discards any bit that might have been set by the input bits
> that are cleared.

I see.

> There is no actual difference between MULT.G and MULTU.G, or DMULT.G and
> DMULTU.G, because they don't record the most significant bits of the infinite
> result in any way.

Right.

>> +static bool trans_MULT_G(DisasContext *s, arg_muldiv *a)
>> +{
>> +    return gen_lext_MULT_G(s, a->rt, a->rs, a->rd, false, false);
>> +}
>> +
>> +static bool trans_MULTU_G(DisasContext *s, arg_muldiv *a)
>> +{
>> +    return gen_lext_MULT_G(s, a->rt, a->rs, a->rd, false, true);
>> +}
>> +
>> +static bool trans_DMULT_G(DisasContext *s, arg_muldiv *a)
>> +{
>> +    return gen_lext_MULT_G(s, a->rt, a->rs, a->rd, true, false);
>> +}
>> +
>> +static bool trans_DMULTU_G(DisasContext *s, arg_muldiv *a)
>> +{
>> +    return gen_lext_MULT_G(s, a->rt, a->rs, a->rd, true, true);
>> +}
> 
> So... if you want to clean this up afterward, or before is up to you.

IIUC you are suggesting this simplification:

-- >8 --
diff --git a/target/mips/tcg/godson2.decode b/target/mips/tcg/godson2.decode
index 4fb8fdba9c..86015ac8e5 100644
--- a/target/mips/tcg/godson2.decode
+++ b/target/mips/tcg/godson2.decode
@@ -15,6 +15,4 @@

-MULT_G          011111 ..... ..... ..... 00000 011000   @rs_rt_rd
-MULTU_G         011111 ..... ..... ..... 00000 011001   @rs_rt_rd
-DMULT_G         011111 ..... ..... ..... 00000 011100   @rs_rt_rd
-DMULTU_G        011111 ..... ..... ..... 00000 011101   @rs_rt_rd
+MULTu_G         011111 ..... ..... ..... 00000 01100-   @rs_rt_rd
+DMULTu_G        011111 ..... ..... ..... 00000 01110-   @rs_rt_rd

diff --git a/target/mips/tcg/loong-ext.decode 
b/target/mips/tcg/loong-ext.decode
index d2c46d3110..b05236eb41 100644
--- a/target/mips/tcg/loong-ext.decode
+++ b/target/mips/tcg/loong-ext.decode
@@ -16,6 +16,4 @@

-MULT_G          011100 ..... ..... ..... 00000 010000   @rs_rt_rd
-DMULT_G         011100 ..... ..... ..... 00000 010001   @rs_rt_rd
-MULTU_G         011100 ..... ..... ..... 00000 010010   @rs_rt_rd
-DMULTU_G        011100 ..... ..... ..... 00000 010011   @rs_rt_rd
+MULTu_G         011100 ..... ..... ..... 00000 0100-0   @rs_rt_rd
+DMULTu_G        011100 ..... ..... ..... 00000 0100-1   @rs_rt_rd

diff --git a/target/mips/tcg/loong_translate.c 
b/target/mips/tcg/loong_translate.c
index 672d8b6163..4b6bdf28be 100644
--- a/target/mips/tcg/loong_translate.c
+++ b/target/mips/tcg/loong_translate.c
@@ -253,3 +253,3 @@ static bool trans_DMODU_G(DisasContext *s, 
arg_muldiv *a)
  static bool gen_lext_MULT_G(DisasContext *s, int rd, int rs, int rt,
-                            bool is_double, bool is_unsigned)
+                            bool is_double)
  {
@@ -275,6 +275,2 @@ static bool gen_lext_MULT_G(DisasContext *s, int rd, 
int rs, int rt,

-    if (is_unsigned && !is_double) {
-        tcg_gen_ext32u_tl(t0, t0);
-        tcg_gen_ext32u_tl(t1, t1);
-    }
      tcg_gen_mul_tl(cpu_gpr[rd], t0, t1);
@@ -287,20 +283,10 @@ static bool gen_lext_MULT_G(DisasContext *s, int 
rd, int rs, int rt,

-static bool trans_MULT_G(DisasContext *s, arg_muldiv *a)
+static bool trans_MULTu_G(DisasContext *s, arg_muldiv *a)
  {
-    return gen_lext_MULT_G(s, a->rt, a->rs, a->rd, false, false);
+    return gen_lext_MULT_G(s, a->rt, a->rs, a->rd, false);
  }

-static bool trans_MULTU_G(DisasContext *s, arg_muldiv *a)
+static bool trans_DMULTu_G(DisasContext *s, arg_muldiv *a)
  {
-    return gen_lext_MULT_G(s, a->rt, a->rs, a->rd, false, true);
-}
-
-static bool trans_DMULT_G(DisasContext *s, arg_muldiv *a)
-{
-    return gen_lext_MULT_G(s, a->rt, a->rs, a->rd, true, false);
-}
-
-static bool trans_DMULTU_G(DisasContext *s, arg_muldiv *a)
-{
-    return gen_lext_MULT_G(s, a->rt, a->rs, a->rd, true, true);
+    return gen_lext_MULT_G(s, a->rt, a->rs, a->rd, true);
  }
---

Is that correct?


