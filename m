Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D33E97E5F54
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 21:42:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0pLz-0004wA-3q; Wed, 08 Nov 2023 15:40:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0pLx-0004w1-Ej
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 15:40:45 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0pLs-0000dh-2e
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 15:40:45 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-543c3756521so73986a12.2
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 12:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699476038; x=1700080838; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YyU5pE96yFKFzm7401ZBtLmMAI8TGG2Uv/3UTokNVAY=;
 b=cnfMQWGipyqPwIQ+73rg7JmPNpWPxpnYW7kyJ4veyP0iaYWFke8Uva2UJpQFfYMS8z
 4N7NkTrfGkwglVoFS0blTlwygeVuIg4zjjmXHPvrUOxgSIcHgfMu4PvrsdyLhRXKIWtQ
 qB0CJkZt15M/80Vcxa9mXy2rgzfUZXCwom0nE1jNfyPl6JO5TFJoxyneNiiyFFWUcGV+
 W6YrSKtr0AGU5pgUsetQ6DSGyPFa2SvBGYkAsVVoUqPgXXXPUdHHf884sYSgFaabx1GS
 tOakCgAaRya6SjHJFy4vckV7kVP0yKfHJ8cCSLXPIQdxzugr5XwlosTaFGCi0EQpJWiv
 f36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699476038; x=1700080838;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YyU5pE96yFKFzm7401ZBtLmMAI8TGG2Uv/3UTokNVAY=;
 b=eWKx3VZT5p7St4/g8Iw8XQWQKLOfydWTVfHtyd2QQ2VQEzlm5uc4Vf2OMGRa/tNG8i
 H10zg6auN6tIjzEW9qZd5S94PbOPFxRSRcgtm3XN3grIn+mBKcFNu15lXjhbhLyOMaqF
 c+Zrfypo0BZuPV4MWLerHH1KIJkkotojKgA3rpbMDzxkejsSr5X9SJtIdt+AD9p1xW42
 yUwGbclQQREPxsQ5yu/j4ZRPpJiPHH+GUV6UPBlmW6um0FC1KO1DSmz9DLV6sIj8qGP9
 sEGMGz8PLJ1aR0HxT6j0ILZI+5mB2jQPJ84F8WbFKW9+xAxsiP900Dd7xmfd+nBE7c+Q
 7ulw==
X-Gm-Message-State: AOJu0Yz47gbJEZRoRZuO2TO+pgzXsP7yjWqIoR6RbDaSgis0jFnXPvYC
 2oyLwD8IPqYoKambvJHmL2o3Fjs4+6OBWpfZnDU=
X-Google-Smtp-Source: AGHT+IE+pPZdbRA9N6FLHB5EmVPNHvkntg3fX79Qs/osKnVcdkiafSO7rn1FZo+L2PQgb8smwRt1ig==
X-Received: by 2002:a50:8712:0:b0:53e:fdeb:13c7 with SMTP id
 i18-20020a508712000000b0053efdeb13c7mr2452749edb.21.1699476038249; 
 Wed, 08 Nov 2023 12:40:38 -0800 (PST)
Received: from [192.168.69.115] ([176.187.199.60])
 by smtp.gmail.com with ESMTPSA id
 eg38-20020a05640228a600b0053ff311f388sm7081214edb.23.2023.11.08.12.40.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 12:40:37 -0800 (PST)
Message-ID: <6a4a2205-9abc-45d6-9c6b-f8d94d838e77@linaro.org>
Date: Wed, 8 Nov 2023 21:40:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 27/35] tcg/ppc: Support TCG_COND_TST{EQ,NE}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20231028194522.245170-1-richard.henderson@linaro.org>
 <20231028194522.245170-28-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231028194522.245170-28-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
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

Hi Richard,

On 28/10/23 21:45, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/ppc/tcg-target.c.inc | 105 ++++++++++++++++++++++++++++++++++++---
>   1 file changed, 98 insertions(+), 7 deletions(-)


> -static inline void tcg_out_rld(TCGContext *s, int op, TCGReg ra, TCGReg rs,
> -                               int sh, int mb)
> +static void tcg_out_rld_rc(TCGContext *s, int op, TCGReg ra, TCGReg rs,
> +                           int sh, int mb, bool rc)
>   {
>       tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
>       sh = SH(sh & 0x1f) | (((sh >> 5) & 1) << 1);
>       mb = MB64((mb >> 5) | ((mb << 1) & 0x3f));
> -    tcg_out32(s, op | RA(ra) | RS(rs) | sh | mb);
> +    tcg_out32(s, op | RA(ra) | RS(rs) | sh | mb | rc);
>   }
>   
> -static inline void tcg_out_rlw(TCGContext *s, int op, TCGReg ra, TCGReg rs,
> -                               int sh, int mb, int me)
> +static void tcg_out_rld(TCGContext *s, int op, TCGReg ra, TCGReg rs,
> +                        int sh, int mb)
> +{
> +    tcg_out_rld_rc(s, op, ra, rs, sh, mb, false);
> +}
> +
> +static void tcg_out_rlw_rc(TCGContext *s, int op, TCGReg ra, TCGReg rs,
> +                           int sh, int mb, int me, bool rc)
>   {
>       tcg_out32(s, op | RA(ra) | RS(rs) | SH(sh) | MB(mb) | ME(me));

Here I'm a bit confused because 'rc' is not used. Shouldn't we OR it
to tcg_out32()' second argument?

>   }
>   
> +static void tcg_out_rlw(TCGContext *s, int op, TCGReg ra, TCGReg rs,
> +                        int sh, int mb, int me)
> +{
> +    tcg_out_rlw_rc(s, op, ra, rs, sh, mb, me, false);
> +}


