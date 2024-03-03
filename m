Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 242DD86F3D3
	for <lists+qemu-devel@lfdr.de>; Sun,  3 Mar 2024 07:45:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgfa8-0005e5-GV; Sun, 03 Mar 2024 01:44:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rgfZi-0005d1-79
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 01:43:55 -0500
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rgfZf-0002ww-Dw
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 01:43:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1709448227; x=1710053027; i=deller@gmx.de;
 bh=S3GVZYBg7lK3MSkaXg19GsNI/1CfaXmyizhHxEO8H4E=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=sJbNEoVHdVNIcH9wprAigbJ/Fhz4KWMb24bWFytaFLzrZOqtDcmRRii1RQ7ERiYA
 zDOP2Pr6sxNd2YeWhE3zp0CvXrDtLxsB1Hw30VTmWkmS8YzVOB7cPV265vBdX9fhB
 FzCMghtcqDBp9DrCUcDCjt+U37fkoOZQCPGeTL8/Q7KVttibKcxY/Kkcx1iyYlpcF
 rM7LAuqnosUp28UZPpm2rwZSLMcTZBSZZpi6psCSVZd/rNoHNPkGmkBvMdVumIb43
 V/psjKw7UvvaA8B+vGElJ3/AhJaR7Ib6069Ft9H1vUqabLUjXJ45Tt/D7YbNjGqI7
 Z09ZYwmPudKwsMu1/g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.157.166]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MyKDe-1qvY8l2rbY-00ygkv; Sun, 03
 Mar 2024 07:43:47 +0100
Message-ID: <6f44d208-5ba1-43e4-b6de-8e48f3cc497f@gmx.de>
Date: Sun, 3 Mar 2024 07:43:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] target/hppa: Fix assemble_16 insns for wide mode
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: svens@stackframe.org
References: <20240303021925.116609-1-richard.henderson@linaro.org>
 <20240303021925.116609-2-richard.henderson@linaro.org>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240303021925.116609-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jcvTgNW9Pa/+EKTHbpzdKag441EPuin1rWvYR4xqLcPMe3e7INq
 EWOx/PjBjHXm0PMy0HoEQzJd9M4+inVvKJ1r7bXpmrU5CyUZZZvqG+0ewI6I+iP1ZQXClo7
 /yiySiFAUbnhU3ZdRI7egeG26dF/Y5gyY1465aAS6iICWUC28l2PZRdlyVhWb8znwieFswP
 GcfZzqNIxkB6wRZPPhtyQ==
UI-OutboundReport: notjunk:1;M01:P0:z8TlUZJKVK4=;EfatWoVvdYlrwTHSzTlgfJcEOmi
 CCMBXlirL0HzfVol2XNk/azQwHOCxjXz4I8TjCt03usBcvmQvNlrX9jTDrwQDb22wv8YBebi2
 cdQp9b+iBl2eHnpTxdaN3MUgp5uzLKEq4ZRtzhOXlD+kARlLqlePvPo7z51/U+9MSZPKLqulv
 NyHSwU4Z/sowyRpE/lshpemmxlWm5iT9f1pSGEEEJi9uOtJ7nX+ShGzRjLTXbda7EaSacYNSG
 E74f6Y/5SgwCjDy/L9uQNn5P6bLK1MDrW1DgQQCT/Jf18jfDi2UyoGtvG+ov73aSt2s8cmqH7
 FrBptymykXJA6TF24wLg5Bp1krgBOhJeSg9Y8AAxPP2Q+f9hKG8uNvjv5vBJwUb/lC8+V28WF
 ZvvRkug4B3876IfmLrRpGugZZ9uwXM4eECeOcRwUB/b53g9M+xF6W5v5dIuMi0LDMcTEsWw/o
 DJrhrHKzq5b2KWLpE7TkYxNJAxoGKTVzQmbVfsyJxQzXwg3Tzfc6nLEQCwXBT28AGF8dnsvJd
 eKwil78tg9B4SEeKk6G57ns0h6trGZ3vqImwlzQ9n6cz8h596m9Sx35vJ41OHEBGFfo5VKOU7
 H2UYDoP0F2gUjQEiyf1rjX7TtYqmbOW76urrIfzpIWUIm8zMxhWSYP50Y+5gumpeordG8XGYE
 75SM7oUHfRQN4Ctyv19DlOSnmmLBFglaLvmpGgFiw7DrJCD7Sn7JLQZKRHReW0gU7OWagG2AA
 1mgx0VTw5Q72MciQWOWNfhs0IhzeZbrwqFr5ycYE+5hF1w/Kl4HCOIK/UQn/3hne0dUsqx+t9
 menJ6M8pZQF5ltz+1OnCZzLrrWPuGLSS5T6TBqkCBp/AQ=
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 3/3/24 03:19, Richard Henderson wrote:
> Reported-by: Sven Schnelle <svens@stackframe.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/hppa/insns.decode | 15 +++++++++------
>   target/hppa/translate.c  | 21 +++++++++++++++++++++
>   2 files changed, 30 insertions(+), 6 deletions(-)
>
> diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
> index f5a3f02fd1..0d9f8159ec 100644
> --- a/target/hppa/insns.decode
> +++ b/target/hppa/insns.decode
> @@ -27,13 +27,14 @@
>   %assemble_11a   0:s1 4:10            !function=3Dexpand_shl3
>   %assemble_12    0:s1 2:1 3:10        !function=3Dexpand_shl2
>   %assemble_12a   0:s1 3:11            !function=3Dexpand_shl2
> +%assemble_16    0:16                 !function=3Dexpand_16
>   %assemble_17    0:s1 16:5 2:1 3:10   !function=3Dexpand_shl2
>   %assemble_22    0:s1 16:10 2:1 3:10  !function=3Dexpand_shl2
> +%assemble_sp    14:2                 !function=3Dsp0_if_wide
>
>   %assemble_21    0:s1 1:11 14:2 16:5 12:2  !function=3Dexpand_shl11
>
>   %lowsign_11     0:s1 1:10
> -%lowsign_14     0:s1 1:13
>
>   %sm_imm         16:10 !function=3Dexpand_sm_imm
>
> @@ -221,7 +222,7 @@ sub_b_tsv       000010 ..... ..... .... 110100 . ...=
..  @rrr_cf_d
>
>   ldil            001000 t:5 .....................        i=3D%assemble_=
21
>   addil           001010 r:5 .....................        i=3D%assemble_=
21
> -ldo             001101 b:5 t:5 -- ..............        i=3D%lowsign_14
> +ldo             001101 b:5 t:5  ................        i=3D%assemble_1=
6
>
>   addi            101101 ..... ..... .... 0 ...........   @rri_cf
>   addi_tsv        101101 ..... ..... .... 1 ...........   @rri_cf
> @@ -306,10 +307,12 @@ fstd            001011 ..... ..... .. . 1 -- 100 0=
 . .....      @fldstdi
>
>   @ldstim11       ...... b:5 t:5 sp:2 ..............      \
>                   &ldst disp=3D%assemble_11a m=3D%ma2_to_m x=3D0 scale=
=3D0 size=3D3
> -@ldstim14       ...... b:5 t:5 sp:2 ..............      \
> -                &ldst disp=3D%lowsign_14 x=3D0 scale=3D0 m=3D0
> -@ldstim14m      ...... b:5 t:5 sp:2 ..............      \
> -                &ldst disp=3D%lowsign_14 x=3D0 scale=3D0 m=3D%neg_to_m
> +@ldstim14       ...... b:5 t:5 ................          \
> +                &ldst sp=3D%assemble_sp disp=3D%assemble_16  \
> +                x=3D0 scale=3D0 m=3D0
> +@ldstim14m      ...... b:5 t:5 ................          \
> +                &ldst sp=3D%assemble_sp disp=3D%assemble_16  \
> +                x=3D0 scale=3D0 m=3D%neg_to_m
>   @ldstim12m      ...... b:5 t:5 sp:2 ..............      \
>                   &ldst disp=3D%assemble_12a x=3D0 scale=3D0 m=3D%pos_to=
_m
>
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index 01f3188656..585d836959 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -144,6 +144,27 @@ static int assemble_6(DisasContext *ctx, int val)
>       return (val ^ 31) + 1;
>   }
>
> +/* Expander for assemble_16(s,im14). */
> +static int expand_16(DisasContext *ctx, int val)
> +{
> +    /*
> +     * @val is bits [0:15], containing both im14 and s.
> +     * Swizzle thing around depending on PSW.W.
> +     */
> +    int i =3D (-(val & 1) << 13) | extract32(val, 1, 13);
> +
> +    if (ctx->tb_flags & PSW_W) {
> +        i ^=3D val & (3 << 13);

Patch boots when I change to:
+        i ^=3D ((val >> 14) & 3) << 13;

Helge

> +    }
> +    return i;
> +}
> +
> +/* The sp field is only present with !PSW_W. */
> +static int sp0_if_wide(DisasContext *ctx, int sp)
> +{
> +    return ctx->tb_flags & PSW_W ? 0 : sp;
> +}
> +
>   /* Translate CMPI doubleword conditions to standard. */
>   static int cmpbid_c(DisasContext *ctx, int val)
>   {


