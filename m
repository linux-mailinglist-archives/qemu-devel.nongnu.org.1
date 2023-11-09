Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A827E6581
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 09:43:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r10cU-0000C2-B3; Thu, 09 Nov 2023 03:42:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r10cS-0000Br-5v
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 03:42:32 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r10cM-0003rY-Uv
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 03:42:31 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40806e40fccso3390275e9.2
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 00:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699519345; x=1700124145; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NGOhSvyux0oM+kHsnHH/iijeKt8twpJH35IPyqWsDcs=;
 b=FwyFXUAKNl0yGgCcd1RTcah/KUyYHyDnUDZUlgaEHQ+vumHWmtA8+vw+3XzEFcYT3Z
 7INwF+GlR+tk0waejMio1d+hXn/ijK151DtULAimeuh21m4cN0pZy3UbqHpyVppXjJlo
 +FYcSmy5PFJCEFpBFKXNyt9ulebbuwGABUkHIU4axHXgqyTI9HXt49rXrRnQVjoFm0Ms
 C+wvnXA6QxaljLpyLV4HQpFD88xLOVZUrqh02PzFo+zt05bcDhRbhF+TgtwJqPMYOrgb
 VmuyUxYl5UyI1PcPq2OVmsnZ08l79ihtYB6XOuiivSXSgaHLKfXb634osmcddMD4LBIv
 JYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699519345; x=1700124145;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NGOhSvyux0oM+kHsnHH/iijeKt8twpJH35IPyqWsDcs=;
 b=YFvMIS5zR8Mnfhqj0COR/ghxIzGfgGFrcpc7FFVggGt93RfTPglklbFFg5RVWbh0cQ
 04w8WB4lpd3Z7vwGDj2QkcC3ze1BzuW3T6kiEdRcqo3pp1uL4Q17bT2rMKUwbu6WOYtJ
 aUV97spGx8X5FX1pAOPzapcyr7BK02dk/n7GNqH9z1RRzSX36aTxdJCFyWOmI4kPtdS2
 TmVGnupcLL7BjEdNbjrj/55FgpqhiyiJCD69bpDOe6fYpJRSsEcPM17gnkgOG3r1TDxE
 ILHzzbqvB7MtHEAM6ND86ssIL6STfhnQ3XYgLgIbXIVkij1fgFcrqFQv++4UDmqKJnpP
 jVKQ==
X-Gm-Message-State: AOJu0YzZmDVMgdDOnI8Kc3IMNpvlKUNOvOERH/Ay7udsSa+a+tk3iM2F
 QxKTFInByuOum3q2bxluq25Xww==
X-Google-Smtp-Source: AGHT+IFzbi/D7iL95DMzspd9KbL6SMKxl4ToWpOPiSMSjgIUhv9zEQ8OJjSD+LE0FiTvMezr9lNU4w==
X-Received: by 2002:a05:600c:2a18:b0:401:d947:c8a9 with SMTP id
 w24-20020a05600c2a1800b00401d947c8a9mr3834657wme.19.1699519344846; 
 Thu, 09 Nov 2023 00:42:24 -0800 (PST)
Received: from [192.168.23.175] (226.red-88-28-2.dynamicip.rima-tde.net.
 [88.28.2.226]) by smtp.gmail.com with ESMTPSA id
 c7-20020a7bc847000000b0040836519dd9sm1346330wml.25.2023.11.09.00.42.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Nov 2023 00:42:24 -0800 (PST)
Message-ID: <b8f049ce-942c-41bb-948f-8c5ba4427879@linaro.org>
Date: Thu, 9 Nov 2023 09:42:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 27/35] tcg/ppc: Support TCG_COND_TST{EQ,NE}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20231028194522.245170-1-richard.henderson@linaro.org>
 <20231028194522.245170-28-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231028194522.245170-28-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Hi Richard,

On 28/10/23 21:45, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/ppc/tcg-target.c.inc | 105 ++++++++++++++++++++++++++++++++++++---
>   1 file changed, 98 insertions(+), 7 deletions(-)


> +/*
> + * Set dest non-zero if and only if (arg1 & arg2) is non-zero.
> + * If RC, then also set RC0.
> + */
> +static void tcg_out_test(TCGContext *s, TCGReg dest, TCGReg arg1, TCGArg arg2,
> +                         bool const_arg2, TCGType type, bool rc)
> +{
> +    int mb, me;
> +
> +    if (!const_arg2) {
> +        tcg_out32(s, AND | SAB(arg1, dest, arg2) | rc);
> +        return;
> +    }
> +
> +    if (type == TCG_TYPE_I32) {
> +        arg2 = (uint32_t)arg2;
> +    } else if (arg2 == (uint32_t)arg2) {
> +        type = TCG_TYPE_I32;
> +    }
> +
> +    if ((arg2 & ~0xffff) == 0) {
> +        tcg_out32(s, ANDI | SAI(arg1, dest, arg2));

Is it SAI() we want here, since arg2 bits are all masked?

> +        return;
> +    }
> +    if ((arg2 & ~0xffff0000ull) == 0) {
> +        tcg_out32(s, ANDI | SAI(arg1, dest, arg2));
> +        return;
> +    }
> +    if (type == TCG_TYPE_I32) {
> +        if (mask_operand(arg2, &mb, &me)) {
> +            tcg_out_rlw_rc(s, RLWINM, dest, arg1, 0, mb, me, rc);
> +            return;
> +        }
> +    } else {
> +        int sh = clz64(arg2);
> +        if (mask64_operand(arg2 << sh, &mb, &me)) {
> +            tcg_out_rld_rc(s, RLDICR, dest, arg1, sh, me, rc);
> +            return;
> +        }
> +    }
> +    /* Constraints should satisfy this. */
> +    g_assert_not_reached();
> +}


