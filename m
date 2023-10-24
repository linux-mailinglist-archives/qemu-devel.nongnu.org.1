Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8B67D43CA
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 02:14:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv53t-0001Z3-7N; Mon, 23 Oct 2023 20:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qv53r-0001Yk-B7
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 20:14:19 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qv53n-0008KG-F8
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 20:14:17 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1ca3a54d2c4so32521715ad.3
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 17:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698106454; x=1698711254; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=goDJgFmC/OHRwJB6al5xSCQX5PH4KpPpXA3sInnNyAU=;
 b=LV2LoNAGar2k2j/GZsu8ZYhvF38Opr+wpW8jNPrErHQb3l3eqAG/+jQ99i4Cg/DPqH
 yW/MOPk0kPo57NlMnibgne/5kNmwFg7ZxV2LnnExfGn7BJ34WqXVpSUip1RRPl5iGBOu
 cfEC2UhRA+prvY5W3I4SfCHQNl3C0liYHZVx+S9psSvcGTjTim93uTR+TgdSxbvde9vi
 iuQvAVA8hhP4Pn6XjOPpxKXvz/qhizpYQXg/bnay31EroraGBrmmG04wnC8eBVjpZ77R
 fnDhPahJ59ZQY7/uXocrrprQGqYLnx7rUJZvm+fyFZFEBnqRFeNJ5PEBr7GXNBouov9k
 LHpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698106454; x=1698711254;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=goDJgFmC/OHRwJB6al5xSCQX5PH4KpPpXA3sInnNyAU=;
 b=sORivDx4qTBD9gxk1qYsqeNLFBFslGUDI3d3Hr5rDp/xMcIRhD/JRVoIaDmV3TDVoy
 fhzxTdyfRCr/ifAdMbUQ6HNsm2cwXNCsE8pLSDIu8C0e7hcBbfM0a/tS1IhkPipzQfCw
 2ZgGiTtHlD16JQPMTi4Ztkv6sl9HFFuPgz9UiyN3dRCLpyS/FuMdb8khDMSIN9leEZFZ
 U4HlzlX+4G8cNuJoH101VD6jS+h0+6vJlreGrnQ5czPnNaOOs9flexbTafgkEkTF8dNl
 SVlIQfoe2pJPvyirO+PoR5oJFZuxasj7kriWMc1TrHnFqXE+kIOgx2lnUXMul+yDmohA
 NeIA==
X-Gm-Message-State: AOJu0YxUGb1wXkTr19wMpNEcyWZExPdqwX7TqBML+eMx6PD1WkPw+NJD
 pa/ruQFCbWDoj283hDx5WVGX/PAYpKggOXyBC3M=
X-Google-Smtp-Source: AGHT+IF3H2UVdDgzTEeTrg10nTgh4wghJwq6Bj+di6oEyczotV751xuPxkKel1N7UUeekYw69gqw0w==
X-Received: by 2002:a17:902:c409:b0:1c5:a49e:7aa with SMTP id
 k9-20020a170902c40900b001c5a49e07aamr12873089plk.27.1698106453887; 
 Mon, 23 Oct 2023 17:14:13 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 12-20020a170902c14c00b001c75a07f62esm6519993plj.34.2023.10.23.17.14.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Oct 2023 17:14:13 -0700 (PDT)
Message-ID: <d9092d0e-852e-43f7-a087-be0781744e6e@linaro.org>
Date: Mon, 23 Oct 2023 17:14:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] target/mips: Use tcg_gen_sextract_tl
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
References: <20231023160944.10692-1-philmd@linaro.org>
 <20231023160944.10692-8-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231023160944.10692-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/23/23 09:09, Philippe Mathieu-Daudé wrote:
> Inspired-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/tcg/mxu_translate.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
> index c517258ac5..6eb73256b2 100644
> --- a/target/mips/tcg/mxu_translate.c
> +++ b/target/mips/tcg/mxu_translate.c
> @@ -3840,8 +3840,7 @@ static void gen_mxu_Q16SAT(DisasContext *ctx)
>               tcg_gen_movi_tl(t0, 255);
>   
>               gen_set_label(l_lo);
> -            tcg_gen_shli_tl(t1, mxu_gpr[XRb - 1], 16);
> -            tcg_gen_sari_tl(t1, t1, 16);
> +            tcg_gen_sextract_tl(t1, mxu_gpr[XRb - 1], 0, 16);

The most simple replacement here is tcg_gen_ext16s_tl.

I'll also note that the entire function should be replaced, e.g.

     TCGv min = tcg_constant_tl(0);
     TCGv max = tcg_constant_tl(0xff);
     TCGv tmp[2];

     tmp[0] = tcg_temp_new();
     tmp[1] = tcg_temp_new();

     for (i = 0; i < 4; i++) {
         int rs = i & 2 ? XRc : XRb;
         TCGv t = tmp[i & 1];

         gen_load_mxu_gpr(t, rs);
         tcg_gen_sextract_tl(t, t, (i & 1) * 16, 16);
         tcg_gen_smax_tl(t, t, min);
         tcg_gen_smin_tl(t, t, max);
         if (i != 0) {
             tcg_gen_shli_tl(t, t, i * 8);
             tcg_gen_or_tl(t, t, tmp[(i - 1) & 1];
         }
     }
     gen_store_mxu_gpr(tmp[1], XRa);


And lots of other similar work within this file.  :-/


r~

