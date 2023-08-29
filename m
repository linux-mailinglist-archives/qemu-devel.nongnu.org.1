Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1251178C489
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 14:54:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qayDG-0006fz-Hx; Tue, 29 Aug 2023 08:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qayD6-0006ad-CQ
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 08:52:44 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qayD1-0007Ht-Kw
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 08:52:42 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5256d74dab9so5758244a12.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 05:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693313547; x=1693918347;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ybN8uNSc5PZTJ6TLlLfRoGWfX9zbzqTmwNSDNk+P1Pg=;
 b=uUZMwvG7q2+Q55ARgaikv4ykY81wCncu1KXyMXOHuQ2HSW2dKaBI+hWDjlNQr1LPz1
 FLAv9gsryhahd73dS1HBXCk8MJN7/PDW8LX/gr4dEVRcGgxXLVXO2rvp23FH8T2fOuRZ
 REwcmXSKSSjMHoiOJbIA8p0+sAfe1kjJf/Ur4WNrIoUHVg8SOyz2qLuC09UsGXjfZzo8
 hVcE1qMr4IHc1yrUafpuiflLBuFAksRI+L4OjS8eVroi/FhjNuDYIIs0iEoVvWBxRvFS
 jClNeYqjUtlyztU9zEaT408jvb6bGVRw7syPOvKf2BJoNZ8Sawc+l+8/6qxrNMU7UQpW
 fN4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693313547; x=1693918347;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ybN8uNSc5PZTJ6TLlLfRoGWfX9zbzqTmwNSDNk+P1Pg=;
 b=GggPl8kQwhpzJBXYSNasl3d/4lXw6M4KIdxxm9NsPynOiu4nJT+mNk3h/cKruL0OTu
 TIgS3AlZpp0uG+sc8oeloe2hw8LxjOMSQi5JkqE9qNCC4EcQSYhyJk9m2mPzWqsOwnvE
 GlppV9T8OkUAN4bqQUSBZu5zBPmAaIqCt7oD1JjeQRwm5ReELozjFa7PhxzFfY24aexQ
 GDXm++8hNTYG87nXhWKWX1j7rr28Is8yIP/9glEVXpvcDsTIIrXj6Dzhm90oWsmCr+ii
 1hWbY5qb9nOXSRRKQLE5vKZOHbYJ9AlfMEz/NhTZIgjh9xdpcb+x8zhmhD7ZW9JyIEeN
 wDJg==
X-Gm-Message-State: AOJu0Yyb56Bkuj/BtJ5qmANisyM0XOGaeAnhG0gcVL6/vhgKWmGwlCYA
 uQHsTG1W5qxK/gT1zqACOvp+kLMbqQnsJspw9IRC9Q==
X-Google-Smtp-Source: AGHT+IF65IiPVdBYi8cCyecxKgwbTcTvExbMtp6LXoSibhpUmag/7G7Dkcpq+vuY0eNTmOw2trgmjXOhNQC1+nNai48=
X-Received: by 2002:aa7:d6d3:0:b0:526:9c4:bc06 with SMTP id
 x19-20020aa7d6d3000000b0052609c4bc06mr19559979edr.18.1693313546757; Tue, 29
 Aug 2023 05:52:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230822042530.1026751-1-richard.henderson@linaro.org>
 <20230822042530.1026751-2-richard.henderson@linaro.org>
In-Reply-To: <20230822042530.1026751-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Aug 2023 13:52:15 +0100
Message-ID: <CAFEAcA9qHW4-OGnsPnNHHhn+fda0Qri_8iqcNwkc-nhxqYiCYw@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] tests/tcg/aarch64: Adjust pauth tests for FEAT_FPAC
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 22 Aug 2023 at 05:27, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> With FEAT_FPAC, AUT* instructions that fail authentication
> do not produce an error value but instead fault.
>
> For pauth-2, install a signal handler and verify it gets called.
>
> For pauth-4 and pauth-5, we are explicitly testing the error value,
> so there's nothing to test with FEAT_FPAC, so exit early.
> Adjust the makefile to use -cpu neoverse-v1, which has FEAT_EPAC
> but not FEAT_FPAC.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tests/tcg/aarch64/pauth-2.c       | 61 +++++++++++++++++++++++++++----
>  tests/tcg/aarch64/pauth-4.c       | 28 ++++++++++++--
>  tests/tcg/aarch64/pauth-5.c       | 20 ++++++++++
>  tests/tcg/aarch64/Makefile.target |  5 ++-
>  4 files changed, 101 insertions(+), 13 deletions(-)


>  int main()
>  {
> +    static const struct sigaction sa = {
> +        .sa_sigaction = sigill,
> +        .sa_flags = SA_SIGINFO
> +    };
> +    unsigned long isar1, isar2;
> +
> +    assert(getauxval(AT_HWCAP) & HWCAP_CPUID);
> +
> +    asm("mrs %0, id_aa64isar1_el1" : "=r"(isar1));
> +    asm("mrs %0, id_aa64isar2_el1" : "=r"(isar2));

You need to use the S3_n_Cn_Cn_n encoding for
ID_AA64ISAR2_EL1 in this test and the others,
to avoid problems with older binutils. Compare
how tests/tcg/aarch64/sysregs.c does it.

> diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
> index 681dfa077c..780ab3f183 100644
> --- a/tests/tcg/aarch64/Makefile.target
> +++ b/tests/tcg/aarch64/Makefile.target
> @@ -42,7 +42,10 @@ endif
>  ifneq ($(CROSS_CC_HAS_ARMV8_3),)
>  AARCH64_TESTS += pauth-1 pauth-2 pauth-4 pauth-5
>  pauth-%: CFLAGS += -march=armv8.3-a
> -run-pauth-%: QEMU_OPTS += -cpu max
> +run-pauth-1: QEMU_OPTS += -cpu max
> +run-pauth-2: QEMU_OPTS += -cpu max
> +run-pauth-4: QEMU_OPTS += -cpu neoverse-v1
> +run-pauth-5: QEMU_OPTS += -cpu neoverse-v1

Why do we need to specify neoverse-v1 here ? A comment
would help.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

