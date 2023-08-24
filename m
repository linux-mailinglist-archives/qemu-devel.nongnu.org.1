Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BB67874E7
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 18:09:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZCtg-00011q-8b; Thu, 24 Aug 2023 12:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZCtb-0000yk-UN
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 12:09:20 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZCtZ-0002Yb-Q1
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 12:09:19 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-52683b68c2fso112565a12.0
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 09:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692893356; x=1693498156;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Uej7KS2UcaovjYPC1AF4EolyVdNxa6Am86KL1m8qa44=;
 b=jOznvTgUFKIVXCqEPoCEb80XHqdtfc0DWIT3A3sUOecLMTlVOjNUSYdCUys32B9fYG
 9lM5i0oB1b22ldQBiRyaot9UegSKnqIx/2dCWgMaD6SBND/f/4wcu1IEKZDtz1RU03MR
 YX/9MiyzsE6Vsk9dbWhQz0RdSybaKj/W2JE8mfPI0j7N8wBL2ICSRKyCw6hOCHAGxn6c
 /CFP52D/NQmFnPimfsMoO2t/6F4pnoikpvHprHdes6y9cfa7SH4YFpxo7n765++VR6z2
 ahiLhX5hZkNfEhtt8DOXJEOJIcyQM3p+8r72HDCjuU3PymmZpvhX7sNP4HZ3uLHT+IRJ
 LZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692893356; x=1693498156;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Uej7KS2UcaovjYPC1AF4EolyVdNxa6Am86KL1m8qa44=;
 b=CXVedCrf8+Z4cMS+HsX4vnTBx1sUUSMfmhNvL0yilXW9imHvd/YzsavFrDACOwOe9d
 N1BWLygEB4sEvVBnGHUDZmrCFa2Br4BxiVXM6CuhZ76ZsN1b7Fz6BIhDaPe0TfXOcceZ
 ssNZH9XJ7P/OBT7WztyyUVm3nhtyKnhWDwTwJqqE4l4Bw+2xL1baFlctwurAsuh7b55w
 lRIW8dmnsryjI6t3EadcIzzIM9vjQ8HV3tiNfzATkmc7D/PKurh/0lmOEjs8qk4CiPR1
 wPhMMBE2bcrXoSZHnqKYErpv/RHl9jbLKSb93N2EHyiFeJRrwNEB2aul41HX3Y46I8jr
 pZ9A==
X-Gm-Message-State: AOJu0YymdDNnhglzmrUM85gIaT47C1S2rZEJWD+55zkR8N/ZbBqFfGOD
 M0HgGy9j1lzluOGdOR+dVmeqsqGaS9a+07t3ep0vYA==
X-Google-Smtp-Source: AGHT+IFfaYjYJgToZUdySl44rugJvW0wAVEcVktZFpfPC4s8/g7ZyFgZfhU363jUuBbsedvhNZV6pzhAIW0hcUfofKM=
X-Received: by 2002:a05:6402:b29:b0:523:aef9:3b7b with SMTP id
 bo9-20020a0564020b2900b00523aef93b7bmr13068752edb.4.1692893356266; Thu, 24
 Aug 2023 09:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230811214031.171020-1-richard.henderson@linaro.org>
 <20230811214031.171020-10-richard.henderson@linaro.org>
In-Reply-To: <20230811214031.171020-10-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Aug 2023 17:09:05 +0100
Message-ID: <CAFEAcA8pRRv=-6JvLtXCtcUVvD-6X_Gs4DSPto7QnCJ4oX-23A@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] target/arm: Suppress FEAT_TRBE (Trace Buffer
 Extension)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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
> Like FEAT_TRF (Self-hosted Trace Extension), suppress tracing
> external to the cpu, which is out of scope for QEMU.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 85c02308e4..43c5ac6456 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -2088,6 +2088,9 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>          /* FEAT_SPE (Statistical Profiling Extension) */
>          cpu->isar.id_aa64dfr0 =
>              FIELD_DP64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, PMSVER, 0);
> +        /* FEAT_TRBE (Trace Buffer Extension) */
> +        cpu->isar.id_aa64dfr0 =
> +            FIELD_DP64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, TRACEBUFFER, 0);
>          /* FEAT_TRF (Self-hosted Trace Extension) */
>          cpu->isar.id_aa64dfr0 =
>              FIELD_DP64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, TRACEFILT, 0);
> --
> 2.34.1
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

