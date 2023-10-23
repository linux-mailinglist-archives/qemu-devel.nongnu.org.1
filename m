Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AB57D4361
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 01:42:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv4YD-0000Oe-1d; Mon, 23 Oct 2023 19:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qv4YA-0000Nw-8L
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 19:41:34 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qv4Y8-0001xD-HA
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 19:41:33 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6b77ab73c6fso2812476b3a.1
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 16:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698104491; x=1698709291; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hzEKh2Cso1+QBX1C2ZDTEkBn1WmsHGY9WBAyHVsVpZE=;
 b=ntUzoYHSA4EMVdkLlyazc1dupZ44d8xWdoLHUrriyked0iV8cwTdOGnf+rVArqXW+V
 bgpy0YO634o2KFfe0S99rg3C7PRJScotzjwwo/M1MDSpNERczzwykH20tkmNM4JTbRwt
 Ths+whRewstrae86Lwdj3RyTEWn+DRoM+X4YNWD5RPIrYWJUn0JdvIJFKv80Ha8eZCW5
 kr2y/m6Cg/+fe4Tc1j6p6ytqygkTgxq0Eq6q8qulexrIre4+r2+RnlmPtx6dKtAx5VXj
 recnH+JokNQRV0GBAl40g8R1z/TrnIH68dv5oy4tz52bUypYJNOusYDkpEoXLqlI/a92
 4Gmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698104491; x=1698709291;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hzEKh2Cso1+QBX1C2ZDTEkBn1WmsHGY9WBAyHVsVpZE=;
 b=NNIntNvhUc5HtbX0t47W3JgZm5qXFFVDDxS819K8wsZv3ON11LsOJvtWxslE7/r3vg
 8DI1q1Dd0Z7SXV3v/Uy/RNaAJnZZAPoqkBfq5j9ljUfeVZo4VZMZ2N6KveaagMiLZDlQ
 7dBCaFJLoSRLGrU1W9tLEwtbuXcG3Hva+CQQ6ydRCsoAIqDvyQ79Jpty9Tfi4MVX0ipb
 xgUXMnj2KA2d6C8gGmOKwXHJToFWh9uNNFbivE1l6NGvGVAj9Ug4u+W9y0h4Xw3VMyrj
 3sQw4ERuQHUhnSaDso57He/FJ44j+Zp3bDruU+WqRm/WaBnHlTKmVoWGfLXemLZQjjfc
 wb8w==
X-Gm-Message-State: AOJu0YyZ56IJLHdk2IVbd8nWI+NUaymZbQ77KI9BhLykxrOG2uOV74XA
 8yh2Vuz5TBuFquUwHBBD/hV65SBJdyiqLzlqAfY=
X-Google-Smtp-Source: AGHT+IHjbCMZjDfGkcP+mQymW9ivKFP0wakgjqRWxs+PsrWEZsFBOATXHtNRht7+EVSJIpLzwGsuXw==
X-Received: by 2002:a05:6a21:1a9:b0:f0:50c4:4c43 with SMTP id
 le41-20020a056a2101a900b000f050c44c43mr1595405pzb.5.1698104491043; 
 Mon, 23 Oct 2023 16:41:31 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 p26-20020aa79e9a000000b006bfb8a34c64sm1711555pfq.88.2023.10.23.16.41.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Oct 2023 16:41:30 -0700 (PDT)
Message-ID: <f8a39597-0b35-4c06-a5ea-cf251d89844b@linaro.org>
Date: Mon, 23 Oct 2023 16:41:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] target/sparc: Use tcg_gen_extract_tl
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20231023160944.10692-1-philmd@linaro.org>
 <20231023160944.10692-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231023160944.10692-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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
>   target/sparc/translate.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/target/sparc/translate.c b/target/sparc/translate.c
> index f92ff80ac8..16d9151b90 100644
> --- a/target/sparc/translate.c
> +++ b/target/sparc/translate.c
> @@ -740,14 +740,12 @@ static void gen_op_eval_bvc(TCGv dst, TCGv_i32 src)
>   static void gen_mov_reg_FCC0(TCGv reg, TCGv src,
>                                       unsigned int fcc_offset)
>   {
> -    tcg_gen_shri_tl(reg, src, FSR_FCC0_SHIFT + fcc_offset);
> -    tcg_gen_andi_tl(reg, reg, 0x1);
> +    tcg_gen_extract_tl(reg, src, FSR_FCC0_SHIFT + fcc_offset, 1);
>   }
>   
>   static void gen_mov_reg_FCC1(TCGv reg, TCGv src, unsigned int fcc_offset)
>   {
> -    tcg_gen_shri_tl(reg, src, FSR_FCC1_SHIFT + fcc_offset);
> -    tcg_gen_andi_tl(reg, reg, 0x1);
> +    tcg_gen_extract_tl(reg, src, FSR_FCC1_SHIFT + fcc_offset, 1);
>   }

I have patches as yet not published which remove these entirely.

But this is correct in the meantime,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


