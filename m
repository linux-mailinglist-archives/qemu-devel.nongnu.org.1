Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9ADC778C0A
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 12:27:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUPLi-0002fz-Ad; Fri, 11 Aug 2023 06:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qUPLc-0002en-7X
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 06:26:24 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qUPLW-0007DJ-5Y
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 06:26:22 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5234f46c6f9so2384944a12.3
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 03:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691749576; x=1692354376;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AxW4QMohZTd4ffGqz5mVyYv+XPVEgvrR1n8HhpUVgXw=;
 b=yhVR4tjOVidwv87lqVVJHDxHF6L1X7ukxRQiWMtFwUuWbgM6lugRU2o1HpRzxfTq6T
 STquIND3nn5cEEL8aU1YUtkZXSH5jjayubDJsdOy+hrT37IVMJqhKrqYkJ8vvP9aley9
 oNeYglWwMoilyw6Vxd2JlfaId8AoOVvXAR32y64XbyjvdrcQJ8i2WEwMkRoqOpNqJI/i
 qp95J2XiWL5GUM7MIAWbvkLbWT13fJFN3cEE84dl4unKjO7hFAmV1drqM0CPP4hHSFC1
 AfYQ4TbrsoFrk1ibQrIhmhG/vc0XXyd98qnqMfoCfyg+ghb9EwNeKfattBgDCmqYzTkA
 bUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691749576; x=1692354376;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AxW4QMohZTd4ffGqz5mVyYv+XPVEgvrR1n8HhpUVgXw=;
 b=CB957Wdp0gKK8L4Rw7cP/RzAdVK4vts/EDH+grms6e9YuFeiK7jYYY9LY4xvqBQfs+
 EdT8PVeMqMX8qqWTVSjY1ZU61qklEEiMb1+CMb54g9ZoM47qmIfLL7zu38IeF0AKA4Vx
 RA3kigRv+aoU+/bX4kA3PRWYc/SxnQUX2liMBD4JcGnSmFtSp4E0jb9x9+7PQD/kbqrs
 +YMxKUYaKh/O6DoyO2U4v61/5ZJauPBsxjusTJsZyCGl+YCevqg+cffOlbKOt9ABDHA6
 ordj4AlF/aFnOHn32HUySxOjW25HmyHKZRCImDUcFskDaJf8uVhYqxAYMCRGoGsNVEuV
 evcA==
X-Gm-Message-State: AOJu0YzJ+jA/f/YyD6TvhJK/BfthjAJYX/bBPKCOYrwm0MDg5sARfK4s
 U+KwcO1hYeE2v+AObL6wBXrl+wQuUwtdy5OcqjYJMA==
X-Google-Smtp-Source: AGHT+IGdtKJ1W/hcKSpKFcS62mzhtCPwus7xC/jgOS+0m/tNb8dq8AsERokfwBYfG7JbMG4D1kfWMoosiqdC5FlkyB0=
X-Received: by 2002:a05:6402:1846:b0:523:406a:5f6 with SMTP id
 v6-20020a056402184600b00523406a05f6mr1313950edy.12.1691749576480; Fri, 11 Aug
 2023 03:26:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230808031143.50925-1-richard.henderson@linaro.org>
 <20230808031143.50925-21-richard.henderson@linaro.org>
In-Reply-To: <20230808031143.50925-21-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 Aug 2023 11:26:05 +0100
Message-ID: <CAFEAcA-N-QWQXcHgMNnXTr+Bmf7fhdSKYQwS-kkWGdR+UHvT-Q@mail.gmail.com>
Subject: Re: [PATCH 20/24] tcg/i386: Add cf parameter to tcg_out_cmp
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, 
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Tue, 8 Aug 2023 at 04:13, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Add the parameter to avoid TEST and pass along to tgen_arithi.
> All current users pass false.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/i386/tcg-target.c.inc | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
> index b88fc14afd..56549ff2a0 100644
> --- a/tcg/i386/tcg-target.c.inc
> +++ b/tcg/i386/tcg-target.c.inc
> @@ -1418,15 +1418,15 @@ static void tcg_out_jxx(TCGContext *s, int opc, TCGLabel *l, bool small)
>      }
>  }
>
> -static void tcg_out_cmp(TCGContext *s, TCGArg arg1, TCGArg arg2,
> -                        int const_arg2, int rexw)
> +static void tcg_out_cmp(TCGContext *s, int rexw, TCGArg arg1, TCGArg arg2,
> +                        int const_arg2, bool cf)
>  {
>      if (const_arg2) {
> -        if (arg2 == 0) {
> +        if (arg2 == 0 && !cf) {
>              /* test r, r */
>              tcg_out_modrm(s, OPC_TESTL + rexw, arg1, arg1);
>          } else {
> -            tgen_arithi(s, ARITH_CMP + rexw, arg1, arg2, 0);
> +            tgen_arithi(s, ARITH_CMP + rexw, arg1, arg2, cf);
>          }
>      } else {
>          tgen_arithr(s, ARITH_CMP + rexw, arg1, arg2);

I don't really understand the motivation here.
Why are some uses of this function fine with using the TEST
insn, but some must avoid it? What does 'cf' stand for?
A comment would help here if there isn't a clearer argument
name available...

thanks
-- PMM

