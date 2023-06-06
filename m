Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 137E5724A7C
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 19:45:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6ajK-000527-3s; Tue, 06 Jun 2023 13:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6ajH-00050D-EV
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 13:44:23 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6ajC-0006cE-Sd
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 13:44:23 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-51475e981f0so9487902a12.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 10:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686073455; x=1688665455;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=s6lARYeDLFtfWIzJt1vVBEdFTwrLNwAnN/bcHBZwpd8=;
 b=JK1WJM+yLdU5hfyLiy1cKvPCJrLvrNCEue0gaFxP1IuEmyM63Lw+xouZhZqtTedSUU
 1tSLx7uj03W7zfENKJw3Dc83Zw6asw53LxvSjGzVupRHuYsWttN9S4sW0/rtbemf6g8U
 ub1ba58O6JzlIK14iWo76txJq+grjVWqNZBmTCiQfQhszPY7KB02U6v6wamb7DR60wuc
 5LaufdNBWbV7Lj+nUEOReRXjmAwZH01cSSngOiCUcJ/GB4wxRulxVfEmGRkatmiQZ+F2
 1G6BtpJfb0S0NX9p9RO6IrOYP3nhRvNwed4zT13xvcRGjrbbjovSFeTHNePRyHnnLT3v
 ugfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686073455; x=1688665455;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s6lARYeDLFtfWIzJt1vVBEdFTwrLNwAnN/bcHBZwpd8=;
 b=ft5FEDiHXdn8dBaEeRJnWRpnVlJWMhchl1EgtzwSFUy/C0rEcj6udA/WrBaxraoYhs
 b+W5dDFCqEwMttmHFuvr9KOUqpiLSUnu6M9wYPsCmhFoiH7URd8XWJZMo6oLvRchS6Ck
 AP6MRYPiNKpBVCGLMhj7Hol5gTXZ3gEuovBYD6UQ6ZxVHDmbvATuckT9H0DM3JxXKbuD
 XAbvDLrH59buJoxnjXSGqkmUuUwAWHKDqR3Qecen8BWzzvvG1QUPTwk3f6efz+DZMA85
 sCZsrksAw9gCekjQ0iG0vQ6e2u2YV077+8pthRgiDWbRQBVLn2XbqyDm4oWUqXSO05we
 cHZQ==
X-Gm-Message-State: AC+VfDwdA6eV6Zw3H4D2fRPCz3VASgulByHhtORqzqTjbhYNCDE3tjzt
 aXLXk4JylEi4jbR+UhzDPum8oZuiCgGOtNKxegvAdA==
X-Google-Smtp-Source: ACHHUZ5n3q0t7pydU29f8t1aZL1H8hHW0DsS8t2va1XfoTJPcgo9Vsx1ql8eK99I/5oaroZwOWrOuWlcTZGRtV1yt+0=
X-Received: by 2002:a50:ec82:0:b0:515:3103:631e with SMTP id
 e2-20020a50ec82000000b005153103631emr2907669edr.25.1686073455046; Tue, 06 Jun
 2023 10:44:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230606171629.98157-1-richard.henderson@linaro.org>
In-Reply-To: <20230606171629.98157-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Jun 2023 18:44:04 +0100
Message-ID: <CAFEAcA9zAdS+rEsocqG2NTXkBGHU1P-ro7r=rz6neenx+WrVbQ@mail.gmail.com>
Subject: Re: [PATCH] accel/tcg: Fix undefined shift in store_whole_le16
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Tue, 6 Jun 2023 at 18:16, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The computation is documented as unused in this case,
> but triggers an ubsan error:
>
> ../accel/tcg/ldst_atomicity.c.inc:837:33: runtime error: shift exponent -32 is negative
> SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../accel/tcg/ldst_atomicity.c.inc:837:33 in
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>
> Hi Peter.  Found this while merge testing FEAT_LSE.
> Clearly my bug, which I ought to have found earlier.
>
>
> r~
>
> ---
>  accel/tcg/ldst_atomicity.c.inc | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/accel/tcg/ldst_atomicity.c.inc b/accel/tcg/ldst_atomicity.c.inc
> index 2514899408..de70531a7a 100644
> --- a/accel/tcg/ldst_atomicity.c.inc
> +++ b/accel/tcg/ldst_atomicity.c.inc
> @@ -833,7 +833,9 @@ static uint64_t store_whole_le16(void *pv, int size, Int128 val_le)
>      }
>      store_atom_insert_al16(pv - o, v, m);
>
> -    /* Unused if sz <= 64. */
> +    if (sz <= 64) {
> +        return 0;
> +    }
>      return int128_gethi(val_le) >> (sz - 64);
>  }

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

