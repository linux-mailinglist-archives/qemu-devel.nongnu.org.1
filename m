Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 862457E5D08
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 19:18:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0n6o-0004ow-5X; Wed, 08 Nov 2023 13:16:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0n6m-0004oo-22
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 13:16:56 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0n6k-0008N5-9J
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 13:16:55 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-408002b5b9fso53420615e9.3
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 10:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699467412; x=1700072212; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XC1GWaYbosIWp31yMZBsOkOClRZdf+8ncPwz2MqSrUM=;
 b=C9Wb3Hjj5kNZqdWh71uxRyBBrRd7gA/olAybT05JRSEpYGolgwaN0nOG/Bseo7QYnO
 DU1OVJYCiwRzaz95J6l4U6yw9HL0PfB4HboejFoK/XLUPgCJSySHxe8zB3aHHAFrJzg8
 nmz3P2fxjDgbuIYd3Qj8wNbc/pO4snIdXKjnW7/NrCUtcFwi7tJdU56c/k6EGny+al0D
 cn0Lvf8sW8H8pml4TL+LVW3Ff59AuHs63fq7dreGTXpLP2vNtJgmDoZIDw+e082r81Jr
 GNaZvsNSBqfRnl6aemFzuR311jqEL+2j4KUL0AoGQvtOVcIsurjGgDJtBgZj/ioeNP2X
 /Czg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699467412; x=1700072212;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XC1GWaYbosIWp31yMZBsOkOClRZdf+8ncPwz2MqSrUM=;
 b=enj9BRLN+YDnyd9C95Q9h6TgEvufeopMr53IR6uXviT0MbOJZHg/XR4/aQ3aGsWWki
 hiVZ4vcOWJN1br3F++jYzPtUAVi/qjA615XugmeR5N0cIlAoxevs5kRYUk9rWDPoTdWp
 kAcUQttgmuRGKkmx1KS9naz+85KkDpfEDcykGpRc/3b5V3ySDtKaH4rzGPKEYMMaB9mx
 TvC9omjexipDFOiAmMaBIFkyxLed30awdfEuptDpBC0UmDYnbVivOOPhkzSDOOB1SLcY
 Bsk5FaA8QVAote/v4vn9nZmX6EH/kWg2oHwJqWDhbh7/sliIloY5LSs40yyP1AH2a8Ie
 X+zg==
X-Gm-Message-State: AOJu0YxCmxw/L+hf0cngXrzJGmMaPxHZxs9JuVtDPoNXapeuZv8qFGg5
 65ej0+QwW1EZE21RjZ+ubihHBw==
X-Google-Smtp-Source: AGHT+IGx6BSxO3EWzMBgo2lQ5jLMZqB2yBfVmq5PtdYBPJDmp/A4o9R/pwgVz1A5gpFLO/A486Wxdg==
X-Received: by 2002:a05:600c:3d85:b0:402:ea96:c09a with SMTP id
 bi5-20020a05600c3d8500b00402ea96c09amr2699357wmb.16.1699467412105; 
 Wed, 08 Nov 2023 10:16:52 -0800 (PST)
Received: from [192.168.69.115] ([176.187.199.60])
 by smtp.gmail.com with ESMTPSA id
 ha7-20020a05600c860700b004080f0376a0sm19460727wmb.42.2023.11.08.10.16.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 10:16:51 -0800 (PST)
Message-ID: <bd3556de-553f-4f56-aeb2-fa38d6fd52a6@linaro.org>
Date: Wed, 8 Nov 2023 19:16:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/35] tcg/i386: Support TCG_COND_TST{EQ,NE}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20231028194522.245170-1-richard.henderson@linaro.org>
 <20231028194522.245170-15-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231028194522.245170-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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
> Merge tcg_out_testi into tcg_out_cmp and adjust the two uses.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/i386/tcg-target.c.inc | 83 ++++++++++++++++++++++-----------------
>   1 file changed, 47 insertions(+), 36 deletions(-)


>   #if TCG_TARGET_REG_BITS == 64
> @@ -1422,15 +1424,35 @@ static void tcg_out_jxx(TCGContext *s, int opc, TCGLabel *l, bool small)
>   static int tcg_out_cmp(TCGContext *s, TCGCond cond, TCGArg arg1,
>                          TCGArg arg2, int const_arg2, int rexw)
>   {
> -    if (const_arg2) {
> -        if (arg2 == 0) {
> -            /* test r, r */
> -            tcg_out_modrm(s, OPC_TESTL + rexw, arg1, arg1);
> +    if (is_tst_cond(cond)) {
> +        if (!const_arg2) {
> +            tcg_out_modrm(s, OPC_TESTL + rexw, arg1, arg2);
> +        } else if (arg2 <= 0xff && (TCG_TARGET_REG_BITS == 64 || arg1 < 4)) {
> +            tcg_out_modrm(s, OPC_GRP3_Eb | P_REXB_RM, EXT3_TESTi, arg1);
> +            tcg_out8(s, arg2);
> +        } else if ((arg2 & ~0xff00) == 0 && arg1 < 4) {
> +            tcg_out_modrm(s, OPC_GRP3_Eb, EXT3_TESTi, arg1 + 4);
> +            tcg_out8(s, arg2 >> 8);
>           } else {

For this part, a double-review from x86 developer is welcomed,

> -            tgen_arithi(s, ARITH_CMP + rexw, arg1, arg2, 0);
> +            if (rexw) {
> +                if (arg2 == (uint32_t)arg2) {
> +                    rexw = 0;
> +                } else {
> +                    tcg_debug_assert(arg2 == (int32_t)arg2);
> +                }
> +            }
> +            tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_TESTi, arg1);
> +            tcg_out32(s, arg2);
>           }
>       } else {

then the rest is OK.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


