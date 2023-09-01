Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDE6790169
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 19:25:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc7t1-0001GZ-RF; Fri, 01 Sep 2023 13:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qc7t0-0001GK-AF
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 13:24:46 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qc7sy-0000pg-1t
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 13:24:46 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1bf6ea270b2so16159955ad.0
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 10:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693589082; x=1694193882; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T3sORw+IfOahxD67NwRgfAsAfeF2TMZB5CU22W6RV8o=;
 b=gDsvVLAe76qb3kSFWKrnwG6u7IlWuqiKEOFhy7MdJpyvLqtjIFIuGNG8WnBjYy/KFG
 zKMiqVWkJuRmcqs4pc5PCUT0HZEzdKDpTqMKjcc98Q6+koMnQEfRvbXqN7zRqs0rTYqJ
 S7eGMZG7Eqdytp1/rERI2ZcS7/9VwabZcR/4cK+cwWsmwdOdLBGtbtU9dmAmtYmjRZ/o
 Uyq+vQKCR78cV+wGXenbheV52ieTcR+0PhCzytfRxvLuK8B7ptHV1MAtUbaCAwBsiVD2
 mUAKoV0u124lM+8rePJ+tPBr8wLuyICqOA+As4qpguxqPghyro3Mjf82pgyKLz2vaQGo
 Oa0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693589082; x=1694193882;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T3sORw+IfOahxD67NwRgfAsAfeF2TMZB5CU22W6RV8o=;
 b=j0WKBV2xfY7WmJvhZ9Ir/6LwFCC3m6BsC9KKYIpJX2z2G/A2lLX7fXRT9wJPGvFUtO
 cBu3/WY1ijMi2aSI7zV1lchrVR1Pge2GwAhOg9gtHWChumeFcHxLFhrykqIlEC2xcXvO
 FuIzEReoHXae2lGCmKwX0KIhK53fHlDO+xWMwNFTiRP2UgtLi0R1GiUrMHASS7GHbSnQ
 wXHZesgekkpng2sXpfq80LiAqXQx11qhpr/CNUfLruIfNdC2iNvPt41TTu7l0J+rijaq
 xmql6jK//r3K1QUMZrQ6b5PZ4nMiRx1op458Susamrghoy9xLhcVJv3S6xSZ79wMiKxl
 lsmA==
X-Gm-Message-State: AOJu0Yw5VOHF8z9pcsqFwCHWL9rJo4F+aqN/xM807o0mivOASnjb2r1o
 wVPCGLfPb6E4BT4jIyjpoZfGyqsp3uIUOT7hiXA=
X-Google-Smtp-Source: AGHT+IHh6o+iIow7gPnZM59ufoCvf7UlbThRsVoZ85IGDeqdiVJTAjTdO6XVlpVC33cTwB1ga1BEmQ==
X-Received: by 2002:a17:90a:5aa3:b0:26d:355a:47e3 with SMTP id
 n32-20020a17090a5aa300b0026d355a47e3mr3066560pji.38.1693589082081; 
 Fri, 01 Sep 2023 10:24:42 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 dw24-20020a17090b095800b00265c742a262sm3286476pjb.4.2023.09.01.10.24.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Sep 2023 10:24:41 -0700 (PDT)
Message-ID: <1f963ece-d5b6-50c7-5e40-bc04867494f7@linaro.org>
Date: Fri, 1 Sep 2023 10:24:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 03/14] tcg/loongarch64: Lower cmp_vec to vseq/vsle/vslt
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, git@xen0n.name
References: <20230901093258.942357-1-c@jia.je>
 <20230901093258.942357-4-c@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230901093258.942357-4-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 9/1/23 02:30, Jiajie Chen wrote:
> Signed-off-by: Jiajie Chen <c@jia.je>
> ---
>   tcg/loongarch64/tcg-target-con-set.h |  1 +
>   tcg/loongarch64/tcg-target.c.inc     | 60 ++++++++++++++++++++++++++++
>   2 files changed, 61 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


> 
> diff --git a/tcg/loongarch64/tcg-target-con-set.h b/tcg/loongarch64/tcg-target-con-set.h
> index 37b3f80bf9..d04916db25 100644
> --- a/tcg/loongarch64/tcg-target-con-set.h
> +++ b/tcg/loongarch64/tcg-target-con-set.h
> @@ -31,4 +31,5 @@ C_O1_I2(r, 0, rZ)
>   C_O1_I2(r, rZ, ri)
>   C_O1_I2(r, rZ, rJ)
>   C_O1_I2(r, rZ, rZ)
> +C_O1_I2(w, w, wJ)

Notes for improvement: 'J' is a signed 32-bit immediate.

> +        if (const_args[2]) {
> +            /*
> +             * cmp_vec dest, src, value
> +             * Try vseqi/vslei/vslti
> +             */
> +            int64_t value = sextract64(a2, 0, 8 << vece);
> +            if ((cond == TCG_COND_EQ || cond == TCG_COND_LE || \
> +                 cond == TCG_COND_LT) && (-0x10 <= value && value <= 0x0f)) {
> +                tcg_out32(s, encode_vdvjsk5_insn(cmp_vec_imm_insn[cond][vece], \
> +                                                 a0, a1, value));
> +                break;
> +            } else if ((cond == TCG_COND_LEU || cond == TCG_COND_LTU) &&
> +                (0x00 <= value && value <= 0x1f)) {
> +                tcg_out32(s, encode_vdvjuk5_insn(cmp_vec_imm_insn[cond][vece], \
> +                                                 a0, a1, value));

Better would be a new constraint that only matches

     -0x10 <= x <= 0x1f

If the sign is wrong for the comparison, it can *always* be loaded with just vldi.

Whereas at present, using J,

> +            tcg_out_dupi_vec(s, type, vece, temp_vec, a2);
> +            a2 = temp_vec;

this may require 3 instructions (lu12i.w + ori + vreplgr2vr).

By constraining the constants allowed, you allow the register allocator to see that a 
register is required, which may be reused for another instruction.


r~

