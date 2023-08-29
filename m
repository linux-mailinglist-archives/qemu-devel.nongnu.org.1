Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5E278C7ED
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 16:47:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qazzp-0003G1-A3; Tue, 29 Aug 2023 10:47:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qazzh-00039H-6H
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 10:47:04 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qazzW-0004yN-Fd
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 10:46:58 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-52bcd4db4cbso1293902a12.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 07:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693320402; x=1693925202;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aZUifF96SYNJfQU6ue3OBEDjkcdrguBJLAdhtiSxLOw=;
 b=EWLFGPAEumDCW0i6h4uDTMmRq8uH65F3PniAIeHmMkhH509tbLfFTapX5U9fGGiZT/
 bpEjlqhwdOpXjLaYqMQchladlBaQAbxAPrmvQWQaKY8Bc1EfetedzFtdNxUE8EE4PEyP
 1sNB3p9FsyEC0S6VzP/dySiW/6c5zrmeWkqSash/1yLlxmIBlKnZP5FIo3JeAZHR3pRI
 wlrTlcHdVwiZ5bq/sKgSRh1+ZsIx1NxFTaqFrFkgsfg6+vNyCKcVqVZbzTxxZTtR9UxR
 K2Ui9azR6VhQEreUO1W9wZtAdh61F/yN4TX67CKAWPYAU3+gCEPe8MdeOlNUzUG3U3/q
 zVmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693320402; x=1693925202;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aZUifF96SYNJfQU6ue3OBEDjkcdrguBJLAdhtiSxLOw=;
 b=cKXLk88ElFQIZBFKNPpFbA9UREHQeXH57DCfjsFSglR+Jgl6/VZHK5jonnDpNnwt6e
 XVWYvyoDaLk9N4vbnvUBt3VfiAWrsoGLZdjqcw9jZfKE5Ay6mDCea+zJBYVmYdJRDrWG
 npmTnO6LtUwMLF5k3AKRbT7CESfJXelL5PM0PUcPapxCS4AFPj9Cm6B7Rsg3nR99ttcJ
 GH2YTPOwADhfecBdCuizagUWGRiSlcPd5sRoRKdwzky9JGwYAIw+yzbvsl5p9cG6STmr
 dyXqnEhXyy+wqf6mMFOivun3nk1dHwLTGAR8jrRO2oeaIEDFjMBSCeh3WAY4CWjUbBOy
 TTrw==
X-Gm-Message-State: AOJu0YzLO2sWB3rXRAwZXZ788b3kMA0fCNKhG0bBekOjwBJwTSKJ3mwq
 2ajJCmYCJ8QNOLhdCkailoW6/m5tr2HYdR5eOH/6AA==
X-Google-Smtp-Source: AGHT+IG2mPXrZuX9ccu0EuG6OS/6qMeoPJF1BcMhnDGgEGIfa3EafsK4b9XF5jXrHEDAcKTBda/FyBhL7T5qv0O41Vc=
X-Received: by 2002:aa7:df89:0:b0:523:1ce9:1f41 with SMTP id
 b9-20020aa7df89000000b005231ce91f41mr22084707edy.18.1693320402407; Tue, 29
 Aug 2023 07:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230822170209.1130173-1-richard.henderson@linaro.org>
 <20230822170209.1130173-4-richard.henderson@linaro.org>
In-Reply-To: <20230822170209.1130173-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Aug 2023 15:46:31 +0100
Message-ID: <CAFEAcA_5C8D+B1ad9RftcckknzS-WMC0o=t-zQKpzC7_9gfJ9g@mail.gmail.com>
Subject: Re: [PATCH 3/3] linux-user/aarch64: Add ESR signal frame for PACFAIL
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Tue, 22 Aug 2023 at 18:02, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The PACFAIL fault uses ILL_ILLOPN and includes ESR.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/aarch64/cpu_loop.c |  7 ++++++-
>  linux-user/aarch64/signal.c   |  6 ++++++
>  tests/tcg/aarch64/pauth-2.c   | 25 ++++++++++++++++++++++++-
>  3 files changed, 36 insertions(+), 2 deletions(-)
>
> diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
> index 22c9789326..5af17e8724 100644
> --- a/linux-user/aarch64/cpu_loop.c
> +++ b/linux-user/aarch64/cpu_loop.c
> @@ -110,7 +110,12 @@ void cpu_loop(CPUARMState *env)
>              /* just indicate that signals should be handled asap */
>              break;
>          case EXCP_UDEF:
> -            force_sig_fault(TARGET_SIGILL, TARGET_ILL_ILLOPC, env->pc);
> +            /* See kernel's do_el0_fpac, and our need_save_esr(). */
> +            if (syn_get_ec(env->exception.syndrome) == EC_PACFAIL) {
> +                force_sig_fault(TARGET_SIGILL, TARGET_ILL_ILLOPN, env->pc);
> +            } else {
> +                force_sig_fault(TARGET_SIGILL, TARGET_ILL_ILLOPC, env->pc);
> +            }
>              break;
>          case EXCP_PREFETCH_ABORT:
>          case EXCP_DATA_ABORT:
> diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
> index b2280fa9e3..bcdd796cc2 100644
> --- a/linux-user/aarch64/signal.c
> +++ b/linux-user/aarch64/signal.c
> @@ -582,6 +582,7 @@ static bool need_save_esr(target_siginfo_t *info, CPUARMState *env)
>  {
>      int sig = info->si_signo;
>      int type = info->si_code >> 16;
> +    int code = info->si_code & 0xffff;
>
>      if (type != QEMU_SI_FAULT) {
>          return false;
> @@ -592,6 +593,11 @@ static bool need_save_esr(target_siginfo_t *info, CPUARMState *env)
>          return true;
>      }
>
> +    /* See arch/arm64/kernel/traps.c, do_el0_fpac, and our cpu_loop(). */
> +    if (sig == TARGET_SIGILL && code == TARGET_ILL_ILLOPN) {
> +        return true;
> +    }

This works, but we'll need to do something else if the kernel adds
some other fault later that is reported as ILLOPN but without
an ESR record...

> +
>      return false;
>  }

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

