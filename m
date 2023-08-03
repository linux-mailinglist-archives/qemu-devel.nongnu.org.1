Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 482E376E5E0
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 12:47:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRVq9-00063v-UH; Thu, 03 Aug 2023 06:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRVq8-00060H-Ag
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 06:45:56 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRVq3-0001od-KF
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 06:45:56 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-4fe15bfb1adso1468172e87.0
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 03:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691059548; x=1691664348;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JJW0Ny9oJMZ6xbArIoRPrTEIqOmJR3eX75Krzl3Pzao=;
 b=I170MhSNl658IRJLvPigzCCr7cDY2rhIOKI8XZXEkOtWkaTvrwXqcznpM3s5yS3FGd
 OOpbuNsDNUPj+NJy8tEgIgj6THCL5bkqe8qlCrBgE1GzqYDoIk/kYwwp8taD0c/ycZx0
 Mw8hH7CkiUy9Hw5yIx3JlCjDKzAkng2YW3gonej41VR3llp+PDD0PDUOAOiwvN53x6gD
 zNdlSl2JdfJnBpREDd0bAXwxlXKRhBC+T3jxJMQLTylAgkxbJGUckjZoETuWKvVvVlpv
 1jgxXlYARp4dz8iiq4mOqrhNDTA+qINwzK6xNMfDOLOFKDsGye+J/2Ct5BL3PgJhfx/p
 dkpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691059548; x=1691664348;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JJW0Ny9oJMZ6xbArIoRPrTEIqOmJR3eX75Krzl3Pzao=;
 b=HL5nj+4vVi9rcPineJGdX7U+BNoQaOj+PO3YnGrDgWjmrBA9l9jrS5ttE1jO0CQBoo
 ldwNV47GS+e55nbXGBS9uPybm7CuV/aaJ1z3vxWVm+ydQeElkwnbcH5eUAkSyyHwFk/B
 hcKwbMnO46ydP3GXfZKypLEYx2yhiALpNZYJXnaFRVie18MykwBeg9YcvE9j+FHIfhcS
 QPXMOnT+frNYTBZKxLd0AsXwcvyMBaRg3EJGshSn6knYU6HTqO1o2H0kDXpfrrwCFwFz
 x3p0TxfACLxeqFgh88P1zKMiEa1VnkaK0lB95sRZFgzm5mVC2kWxBsvtWzrbJbqZLLAb
 6n6Q==
X-Gm-Message-State: ABy/qLYTXldDq9gUShsjpkK/JaqqecVn/hLrIsR1eNm4WJtChFGzq0H9
 WxxrpKNospvhYcFmTnN/S5MqtEvd8rFY4FmNBh4yPA==
X-Google-Smtp-Source: APBJJlFEEvqTi2pxf5Da/8BSHMwQviVqLvQqnhF9rvLHQctWANa4wLHerAijVZ1kqIZOcaT7hasOYGaBRfwUOHz79aM=
X-Received: by 2002:a05:6512:3c99:b0:4f8:770f:1b01 with SMTP id
 h25-20020a0565123c9900b004f8770f1b01mr9152433lfv.19.1691059548271; Thu, 03
 Aug 2023 03:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230802161914.395443-1-keithp@keithp.com>
 <20230802161914.395443-4-keithp@keithp.com>
In-Reply-To: <20230802161914.395443-4-keithp@keithp.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Aug 2023 11:45:37 +0100
Message-ID: <CAFEAcA_1e=V+ZPFJZ=kt-DVgiyYS79CJvA_P9p5=whqQTTOkng@mail.gmail.com>
Subject: Re: [PATCH 3/3] target/m68k: Support semihosting on non-ColdFire
 targets
To: Keith Packard <keithp@keithp.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x133.google.com
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

On Wed, 2 Aug 2023 at 17:20, Keith Packard via <qemu-devel@nongnu.org> wrote:
>
> According to the m68k semihosting spec:
>
> "The instruction used to trigger a semihosting request depends on the
>  m68k processor variant.  On ColdFire, "halt" is used; on other processors
>  (which don't implement "halt"), "bkpt #0" may be used."
>
> Add support for non-CodeFire processors by matching BKPT #0
> instructions. When semihosting is disabled, convert those
> back to illegal op exceptions.
>
> Signed-off-by: Keith Packard <keithp@keithp.com>
> ---
>  target/m68k/cpu.h       |  1 +
>  target/m68k/op_helper.c | 16 ++++++++++++++++
>  target/m68k/translate.c |  4 ++++
>  3 files changed, 21 insertions(+)
>
> diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
> index cf70282717..b741c50a8f 100644
> --- a/target/m68k/cpu.h
> +++ b/target/m68k/cpu.h
> @@ -67,6 +67,7 @@
>
>  #define EXCP_RTE            0x100
>  #define EXCP_HALT_INSN      0x101
> +#define EXCP_BKPT_INSN      0x102
>
>  #define M68K_DTTR0   0
>  #define M68K_DTTR1   1
> diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
> index 1ce850bbc5..2d89db6dde 100644
> --- a/target/m68k/op_helper.c
> +++ b/target/m68k/op_helper.c
> @@ -295,6 +295,22 @@ static void m68k_interrupt_all(CPUM68KState *env, int is_hw)
>              /* Return from an exception.  */
>              m68k_rte(env);
>              return;
> +        case EXCP_BKPT_INSN:
> +            if (semihosting_enabled((env->sr & SR_S) == 0)
> +                    && (env->pc & 3) == 0
> +                    && cpu_lduw_code(env, env->pc - 4) == 0x4e71
> +                    && cpu_ldl_code(env, env->pc) == 0x4e7bf000) {

This long condition is identical to the one used for
semihosting-via-halt. It could usefully be moved out
to a function, which can then have a comment noting
what it's doing (i.e. checking for the required insns
preceding and following the bkpt or halt).

> +                env->pc += 4;
> +                do_m68k_semihosting(env, env->dregs[0]);
> +                return;
> +            }
> +            /*
> +             * When semihosting is not enabled, translate this back to
> +             * an illegal op exception.
> +             */
> +            cs->exception_index = EXCP_ILLEGAL;
> +            env->pc += 2;
> +            break;
>          }
>      }
>
> diff --git a/target/m68k/translate.c b/target/m68k/translate.c
> index e07161d76f..d037c57453 100644
> --- a/target/m68k/translate.c
> +++ b/target/m68k/translate.c
> @@ -2640,6 +2640,10 @@ DISAS_INSN(bkpt)
>  #if defined(CONFIG_USER_ONLY)
>      gen_exception(s, s->base.pc_next, EXCP_DEBUG);
>  #else
> +    if ((insn & 7) == 0) {
> +        gen_exception(s, s->pc, EXCP_BKPT_INSN);
> +        return;
> +    }
>      gen_exception(s, s->base.pc_next, EXCP_ILLEGAL);

This means that semihosting-via-bpkt will only work
in system emulation, because in user mode the
EXCP_DEBUG will take precedence. To handle that you
need to also check in linux-user/m68k/cpu_loop.c. But
this effectively also implies reverting most of
a638af09b6c6b (where we took out a lot of "m68k
usermode semihosting" because it wasn't reachable).
So it's probably not worthwhile.

-- PMM

