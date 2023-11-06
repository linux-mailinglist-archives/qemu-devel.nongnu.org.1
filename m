Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBD77E2E85
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 22:02:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r06ji-0002Xm-42; Mon, 06 Nov 2023 16:02:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r06jg-0002Wr-DD
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 16:02:16 -0500
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r06je-0003WF-Jj
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 16:02:16 -0500
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2c50cf61f6dso67851171fa.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 13:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699304532; x=1699909332; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UPnvQBFBIAtrnQKQjlf4jLk4ETb7GFIRfUoTiKwN86o=;
 b=L4wGBlSJTe3YACbPGWXkNQCLiSWKGHcokcctLlhYHSQNPU80dhAui0Jq7tGLX4CdPZ
 AP6pY+ESJnMlP/Z79g1Tp+Y5flB4NuaiER+c/qSvtAnSj2xamxvGGzrlJpx1iz4dy7Ng
 S6OMWYx7dXDhXwrUUOCBC+VK8kBvihuMabJiDjMpvesiTtbThxTv3Pz8nVsS1Vjh2atu
 EURA3yVrkfyv12Xe0Mfpb9bwRwkFfgSht1Znr121QDePMpq87ph/MYHb3KGfoQ4csxaj
 hgpKcl95BH3EhwEGR5Hk69mgD+EkbVV8HAnH5uyhixLcRIrZKgljq9GSdtnC2Sk+v0Xt
 8ryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699304532; x=1699909332;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UPnvQBFBIAtrnQKQjlf4jLk4ETb7GFIRfUoTiKwN86o=;
 b=bXR1GjtHwz3EMx25fksn+SbNWl8iJgFI//dLAT2ChJnfR9tj5t/HjL2fWTaOQOkuS7
 w0lCmp+Vk/YNO1Zs0e10zQtOyW5LlkOVSrtAqOIDu7bzqV6MkncMej9p6R4Hv/7+pReX
 8iZwgv8fFYmMtMvKMFo4JKUc1nHQwz6+ibi3oCQp1d+UuxiFq5iTe8RRgKGyb65pDEDt
 doQq9qO3FEcfjBDoFbujotSd3UvQ/Y5FdcdNzajxbqsSxTjnoyaTIHSgf9IIN4SJ2yBx
 doqPEQmqwog69niT9NZcyOE2BJda/WdZwjPPt3CNEUP2GJlsntFa1ZuPd4NWWkFwm8f3
 EzFg==
X-Gm-Message-State: AOJu0YwW3vi1PERpNsjOyRliawidpCkMThNrNEqbUCoo0wEaMQbSY8Pw
 a38Xu8XqzXw2/OyO5yZqosbQPA==
X-Google-Smtp-Source: AGHT+IF1JetaYqysycSid4M4iONMo4m9Pu4+G6zk4i/bGO5qbkR7eSUoUVatYrJQxXtyDz6vjlsZlg==
X-Received: by 2002:a05:651c:145:b0:2c6:f129:732e with SMTP id
 c5-20020a05651c014500b002c6f129732emr10561783ljd.11.1699304532541; 
 Mon, 06 Nov 2023 13:02:12 -0800 (PST)
Received: from [192.168.69.115] ([176.172.125.26])
 by smtp.gmail.com with ESMTPSA id
 q24-20020a7bce98000000b0040648217f4fsm13052818wmj.39.2023.11.06.13.02.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 13:02:12 -0800 (PST)
Message-ID: <d5e502b0-2175-4c66-87f6-1e581b4612fb@linaro.org>
Date: Mon, 6 Nov 2023 22:02:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/35] tcg/sparc64: Hoist read of tcg_cond_to_rcond
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20231028194522.245170-1-richard.henderson@linaro.org>
 <20231028194522.245170-21-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231028194522.245170-21-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 28/10/23 21:45, Richard Henderson wrote:
> Use a non-zero value here (an illegal encoding) as a better
> condition than is_unsigned_cond for when MOVR/BPR is usable.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/sparc64/tcg-target.c.inc | 25 ++++++++++++++-----------
>   1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
> index ac86b92b75..e16b25e309 100644
> --- a/tcg/sparc64/tcg-target.c.inc
> +++ b/tcg/sparc64/tcg-target.c.inc
> @@ -620,7 +620,7 @@ static const uint8_t tcg_cond_to_bcond[] = {
>       [TCG_COND_GTU] = COND_GU,
>   };
>   
> -static const uint8_t tcg_cond_to_rcond[] = {
> +static const uint8_t tcg_cond_to_rcond[16] = {


> -static void tcg_out_movr(TCGContext *s, TCGCond cond, TCGReg ret, TCGReg c1,
> +static void tcg_out_movr(TCGContext *s, int rcond, TCGReg ret, TCGReg c1,

Isn't rcond unsigned?

Regardless,
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>                            int32_t v1, int v1const)
>   {
> -    tcg_out32(s, ARITH_MOVR | INSN_RD(ret) | INSN_RS1(c1)
> -              | (tcg_cond_to_rcond[cond] << 10)
> +    tcg_out32(s, ARITH_MOVR | INSN_RD(ret) | INSN_RS1(c1) | (rcond << 10)
>                 | (v1const ? INSN_IMM10(v1) : INSN_RS2(v1)));
>   }


