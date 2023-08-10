Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE4A777E52
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 18:30:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU8Y8-0003DZ-Nj; Thu, 10 Aug 2023 12:30:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qU8Y6-0003Ct-S0
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 12:30:10 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qU8Y3-0006CB-Se
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 12:30:10 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-4fe700f9bf7so1709127e87.0
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 09:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691685006; x=1692289806;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gA4mnv26ntMrN4AAuQOG1RqRjz7KC9vkxL3VRP9zBNs=;
 b=BpkuZhKGU2D0Wl+SLS5EkvYyMoARq0QKbOSQxw1et7RKw8eeIfvLPJ6p60YkgRBGiZ
 hBSP20kUqwmro3UYyr9tqZJA6DiyWMSCKQufn4rSv6Ps+dmU+Oo73F2uOSwjXN05Zv9Q
 FP4PMjGFyEaZGTYrytkyvnOjrhXM92LBfu/MbYaeDpcqBIjYLgfgEm7RsUfdu1l6bIqD
 7TrxyNbC7sZiN3wDWxd6NNkI5NxPO1f7wGoZUxm5UthiJu41nvDXYAjgu3KRb06q2Q++
 rSo7LpSiy0qPpSkQo2ogDTZ5Ge7q5qE/sL3/QhMrFB4gDpIpnBFEPoP3JWTewQ0yKjzC
 8MAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691685006; x=1692289806;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gA4mnv26ntMrN4AAuQOG1RqRjz7KC9vkxL3VRP9zBNs=;
 b=HTnHLJjAPnwb5W6xkkGo4Z4p1BwgVnp0otLJqXsCY7MKUFlN+tLCW32vOY3ETXiCEI
 u7z3xgzv71mxOLauLzTyvbOjpS54Ha9wdi2pW/6BOqM8bnis2a3PUbD5P2nfyxL2yulw
 /Nw6hTK+oA8OXL47eiJs/j3+qILqlFqbzmNPWwhHV+LiP3QnCQgF+xCjkfzHbEDUWo7Z
 wx6jmNVKZb8JAJsrSn1e+rllQr7SOBI7VEJGsQM/Z8o8gpcVaWr6SvpAQi8CtpUlZAW7
 pN/dwBEtGpBksDPBEtS4oRMJvDHdIxEUE4XvrfIejRqO7NSIoXnN0FFZW3dhMvLgnimK
 VNSg==
X-Gm-Message-State: AOJu0YzbWlQAiTrlCJa/hcXnrq0ltjI4phJVWf+/ck9vXe/8pdFgSzn0
 9Qd+AHhcb5EODDdumxpCVVfOp9eBMUy/M/Y6NEtd5A==
X-Google-Smtp-Source: AGHT+IGPs1rSsBSyBOgM3RiQCy/W1E3nydCdJXio5HmBmyOmxGTA2aigvbmDhjt4puScoKmhwuYyWPieKinU8YC7cpE=
X-Received: by 2002:a05:6512:4896:b0:4fc:dcff:773b with SMTP id
 eq22-20020a056512489600b004fcdcff773bmr2158763lfb.3.1691685005905; Thu, 10
 Aug 2023 09:30:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230808031143.50925-1-richard.henderson@linaro.org>
 <20230808031143.50925-9-richard.henderson@linaro.org>
In-Reply-To: <20230808031143.50925-9-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Aug 2023 17:29:54 +0100
Message-ID: <CAFEAcA_f9CRaFzEc8-aA3Wgy7hY2KmcHjsijXA5v+3jMRd+R1w@mail.gmail.com>
Subject: Re: [PATCH 08/24] target/sparc: Use tcg_gen_movcond_i64 in gen_edge
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, 
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x135.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

On Tue, 8 Aug 2023 at 04:14, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The setcond + neg + or sequence is a complex method of
> performing a conditional move.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/sparc/translate.c | 17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)
>
> diff --git a/target/sparc/translate.c b/target/sparc/translate.c
> index bd877a5e4a..fa80a91161 100644
> --- a/target/sparc/translate.c
> +++ b/target/sparc/translate.c
> @@ -2916,7 +2916,7 @@ static void gen_edge(DisasContext *dc, TCGv dst, TCGv s1, TCGv s2,
>
>      tcg_gen_shr_tl(lo1, tcg_constant_tl(tabl), lo1);
>      tcg_gen_shr_tl(lo2, tcg_constant_tl(tabr), lo2);
> -    tcg_gen_andi_tl(dst, lo1, omask);
> +    tcg_gen_andi_tl(lo1, lo1, omask);
>      tcg_gen_andi_tl(lo2, lo2, omask);
>
>      amask = -8;
> @@ -2926,18 +2926,9 @@ static void gen_edge(DisasContext *dc, TCGv dst, TCGv s1, TCGv s2,
>      tcg_gen_andi_tl(s1, s1, amask);
>      tcg_gen_andi_tl(s2, s2, amask);
>
> -    /* We want to compute
> -        dst = (s1 == s2 ? lo1 : lo1 & lo2).
> -       We've already done dst = lo1, so this reduces to
> -        dst &= (s1 == s2 ? -1 : lo2)
> -       Which we perform by
> -        lo2 |= -(s1 == s2)
> -        dst &= lo2
> -    */
> -    tcg_gen_setcond_tl(TCG_COND_EQ, lo1, s1, s2);
> -    tcg_gen_neg_tl(lo1, lo1);
> -    tcg_gen_or_tl(lo2, lo2, lo1);
> -    tcg_gen_and_tl(dst, dst, lo2);
> +    /* Compute dst = (s1 == s2 ? lo1 : lo1 & lo2). */
> +    tcg_gen_and_tl(lo2, lo2, lo1);
> +    tcg_gen_movcond_tl(TCG_COND_EQ, dst, s1, s2, lo1, lo2);
>  }

I'm glad I didn't have to figure out exactly what this
exciting instruction actually does to review this :-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

