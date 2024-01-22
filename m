Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0618D836541
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 15:21:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRvB1-0002Rm-El; Mon, 22 Jan 2024 09:21:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rRvB0-0002Rd-Bb
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 09:21:26 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rRvAx-00018Z-Lq
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 09:21:26 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40e72a567eeso39314495e9.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 06:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705933282; x=1706538082; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Hb24Duzw496P1ea+X19AanATjERY6jyqCWFSnlKPB+A=;
 b=sp3LYd1PBrLISsUIJCXR9GEXWRNM4LYcZoePA8IBIhgekpQwVDrdsuI1mePLosPZsD
 7jtTmBpNf3Ogn/JD1N8F8HUIwuy0dgMN7vtzbnvwVsTvBLjSH1/0pSvVfXGTyqLN/HRE
 c8g5a/4Yf80U0514+ZaRyKXEHuN9pZVgfUfQQpB4fMO5oJl4AJXnqkoyexuaXHhSJhB7
 LZA+dWrPNxN81WuvYEgQR+GPDJ9f5I8sKoiadR/vE2Pls50nsQLZ9Fb+M0M3ezW4AkJy
 ROzgE4FXdnZ8SubWzm/xDe0GKMX1e0Nr6f4xaLQBVXKiUONAaqmUxz220rnXhuLtl9E9
 eQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705933282; x=1706538082;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Hb24Duzw496P1ea+X19AanATjERY6jyqCWFSnlKPB+A=;
 b=Lg3OJfeIcbhle9g0EUVAJ7byEJG9xtrwJf7XnASmGK/ol0dzRr3r56xDpVAC7/Hk1J
 YBuTAZkEjHf6VskAeyntyK/2g+ps90d7jKOW21EVpYBSJlOTisS3Vn4QeGwJIwpSA3Ji
 d3nErn79vhwjQZ5nmEb7YtyFjv1/Opawz/3FKcw8/kgLBT7b+IxA8MO+LlT+43e+SV0p
 95a+aRkvWC7eRQ30OlewCurxLH2zvqtchJtS+fEgKHIVO5Uy6PnFQGDdP5hbYBZI6HFl
 lQCjMDyjVnqsi54gQZAs91Qn+8zurMGU2GHHjQTm4+NJe11iaxMvsFKcpLGvQIDTGxi6
 ES6w==
X-Gm-Message-State: AOJu0YxmY7Nio3a96d2PkwZN9NLjmSHuRap8KTStldCVgdC6PE51uFVT
 38VFJs0+wtFsgWSOmyPu0hM416iLoeNO9t9yexuzJ4T7886aDh0MIhabw3oGmuU=
X-Google-Smtp-Source: AGHT+IGc9ETFFlYaYpTR5SLNMr7mcUgXN79IoTPkE/6hQBCkJ5EsPknGDbVk/vD7sZ493eKRQk9tkA==
X-Received: by 2002:a05:600c:a001:b0:40e:66bc:1649 with SMTP id
 jg1-20020a05600ca00100b0040e66bc1649mr1247760wmb.119.1705933281917; 
 Mon, 22 Jan 2024 06:21:21 -0800 (PST)
Received: from [192.168.96.175] ([92.88.171.222])
 by smtp.gmail.com with ESMTPSA id
 o31-20020a05600c511f00b0040e703ad630sm30641442wms.22.2024.01.22.06.20.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jan 2024 06:21:06 -0800 (PST)
Message-ID: <cdef47c9-2fc2-48fe-b96a-38f6ec16a48f@linaro.org>
Date: Mon, 22 Jan 2024 15:20:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/38] tcg/aarch64: Generate CBNZ for TSTNE of
 UINT32_MAX
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20240110224408.10444-1-richard.henderson@linaro.org>
 <20240110224408.10444-20-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240110224408.10444-20-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 10/1/24 23:43, Richard Henderson wrote:
> ... and the inverse, CBZ for TSTEQ.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/aarch64/tcg-target.c.inc | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
> index 55225313ad..0c98c48f68 100644
> --- a/tcg/aarch64/tcg-target.c.inc
> +++ b/tcg/aarch64/tcg-target.c.inc
> @@ -1453,6 +1453,7 @@ static void tcg_out_brcond(TCGContext *s, TCGType ext, TCGCond c, TCGArg a,
>           break;
>       case TCG_COND_LT:
>       case TCG_COND_GE:
> +        /* cmp xN,0; b.mi L -> tbnz xN,63,L */
>           if (b_const && b == 0) {
>               c = (c == TCG_COND_LT ? TCG_COND_TSTNE : TCG_COND_TSTEQ);

This comment ...

>               tbit = ext ? 63 : 31;
> @@ -1461,6 +1462,13 @@ static void tcg_out_brcond(TCGContext *s, TCGType ext, TCGCond c, TCGArg a,
>           break;
>       case TCG_COND_TSTEQ:
>       case TCG_COND_TSTNE:
> +        /* tst xN,0xffffffff; b.ne L -> cbnz wN,L */
> +        if (b_const && b == UINT32_MAX) {
> +            ext = TCG_TYPE_I32;
> +            need_cmp = false;
> +            break;
> +        }
> +        /* tst xN,1<<B; b.ne L -> tbnz xN,B,L */

... and this one belong to the previous patch. Otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>           if (b_const && is_power_of_2(b)) {
>               tbit = ctz64(b);
>               need_cmp = false;


