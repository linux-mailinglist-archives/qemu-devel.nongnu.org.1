Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBCE78C461
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 14:41:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qay0q-00019f-V8; Tue, 29 Aug 2023 08:40:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qay0Z-00012b-Of
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 08:39:48 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qaxzu-0000H7-GL
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 08:39:46 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-500c7796d8eso193829e87.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 05:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693312745; x=1693917545;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xZG8uaKcPAMVy0Ke2IMkNxH7jZBTQ/7D2hYKfosjHu4=;
 b=ZDMcXaHDdLb11U1CldA5tuBUelgVt258ehZRjoEpXBj3S8Ehf9ymeIjHWjqlOBY3DX
 uQVVP8Gsh5OL7Y5mcpmiCP7wWvfD3BSecmoBYKPKtpxo8HCggqCoao5YdoYkqckANwe1
 dTrES3qM5m0TAqNCE1/r77SQrMQMGuuPmyGawgjCxwrBQJT2yVX8TfO6DauzEEegF6BS
 A2addOHwjtXazBr2lUHVwLtvwAwDK6aOd9RDh229KUYNklTSr9vGzG0aaHg4wYMqGPfy
 x9U77Ku1EQw7G8tFOWCRivok3ysSkg2BoYA4i2kceuuaKNKPyQMmLbIvPzVmnhdKnTos
 00Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693312745; x=1693917545;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xZG8uaKcPAMVy0Ke2IMkNxH7jZBTQ/7D2hYKfosjHu4=;
 b=FFUBgtYpOFuevqfOM3wE1k1zPaaHglJsplOcLQfr2WszaH4EoSjLCQiNSFfy87Vijk
 buTlDE1ELALO2LIqFClYMsqL9ZKJR7kuiqgRHjPRr1OrwpJG9C1aF9o9iGcd0qQpquGu
 8lSx/Oc+nPCoh9sseHWDIAQddK/uQYoddtdb1Q9zkYBLImJsEToQPzwcGDpX1KO13K62
 G7rc5uzeggtfo11afwgKfutbCLk802WwU3Q/hiMFFiFY+B7/zsu0EAgFkg6oJtPcSQIu
 vI/PZFzPNTNMYwqExZhF3O5q0VoQ+pGSEApMuPPWm/wIAth6ZAFxnFQv83YcjNX7zB2G
 1KCQ==
X-Gm-Message-State: AOJu0YytQaEm0Mx7HfVag9ZWivP2UBHMeirkYeIvLunZI8qEs0No7d+C
 NDvz/7aSZqlmaYXt3imTCMHeLUOiSoBkahhKsNYQW0XNz4lm/qzE
X-Google-Smtp-Source: AGHT+IE1/uov9CpvQGeL3dWsAMCz0ilBbtHMynW+woxWe0Nw0QF9mCoKI096fKu77cX8HMPu2i+FDdWrrE/qPiAAljc=
X-Received: by 2002:ac2:4e0d:0:b0:4f8:77db:1d9e with SMTP id
 e13-20020ac24e0d000000b004f877db1d9emr24715379lfr.12.1693312744647; Tue, 29
 Aug 2023 05:39:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230811214031.171020-1-richard.henderson@linaro.org>
 <20230811214031.171020-12-richard.henderson@linaro.org>
In-Reply-To: <20230811214031.171020-12-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Aug 2023 13:38:53 +0100
Message-ID: <CAFEAcA-XXC1WJgp8EvviC9Pz+C-LHNmsUqzK4sjM13Q75wbJgQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] target/arm: Implement cortex-a710
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x129.google.com
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

On Fri, 11 Aug 2023 at 22:42, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The cortex-a710 is a first generation ARMv9.0-A processor.

> diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
> index b12e10d3ab..81c27c70e8 100644
> --- a/target/arm/tcg/cpu64.c
> +++ b/target/arm/tcg/cpu64.c
> @@ -758,6 +758,239 @@ static void aarch64_neoverse_v1_initfn(Object *obj)
>      aarch64_add_sve_properties(obj);
>  }
>
> +static bool trap_tidcp(CPUARMState *env)
> +{
> +    return arm_current_el(env) < 2 && (arm_hcr_el2_eff(env) & HCR_TIDCP);
> +}
> +
> +static CPAccessResult access_tidcp(CPUARMState *env, const ARMCPRegInfo *r,
> +                                   bool read)
> +{
> +    return trap_tidcp(env) ? CP_ACCESS_TRAP_EL2 : CP_ACCESS_OK;
> +}
> +
> +static CPAccessResult access_tidcp_actlr_w(CPUARMState *env,
> +                                           const ARMCPRegInfo *r, bool read)
> +{
> +    if (trap_tidcp(env)) {
> +        return CP_ACCESS_TRAP_EL2;
> +    }
> +    return access_actlr_w(env, r, read);
> +}

HCR_EL2.TIDCP traps accesses to a whole IMPDEF range, not
just to the registers that the implementation happens to
define. We should implement this in translate.c, translate-a64.c
and op_helper.c in a similar way to what we do for the aa64_ids
feature, so that we correctly prioritize the trap over the
UNDEF for registers in the space that don't exist, and so
that we don't need to explicitly add the TICDP check to
every IMPDEF register.

Since we already don't implement this correctly for the
other CPUs, we don't need to gate Cortex-A710 on doing
it right.

thanks
-- PMM

