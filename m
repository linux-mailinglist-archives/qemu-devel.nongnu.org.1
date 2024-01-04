Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A03388245C3
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 17:05:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLQCT-0003OU-1j; Thu, 04 Jan 2024 11:04:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rLQCP-0003Nq-J2
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:04:01 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rLQCN-0007AL-AP
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:04:01 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5570bef7cb8so651962a12.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 08:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704384237; x=1704989037; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wbj9XQjH4wjaQmwUCu7Uppgeic/eprNUAiwgWhRgsuM=;
 b=aeyi/vMtQiLxW1EuHx0q1Vl7K7CZ0RNQkAByriRYW0V5YZbvpq1MrURd1AmJEMtA54
 RciNskCCAGyvfr4f30rXh1Ds3CxEIO4pNHpRpqQ5MajioF4vfvsRRAXd8PNyQorfFkQU
 nw8ROCenhte8WyYvRw6sDKhI4OK5C14dmWmJl9VpNDLyoGaR3YdxUyHFxizOhDkO3Ul6
 URy8Fuxwld7eIa22lFa9vBW1RKROGq/Hfa+KaUWaSkcwZGcA989juHYDnsUIErmm2tIe
 7xpGKVG3vTU7fy7zQIzKogBiGm/WzsDmhomSNzMl9OZ3niisGrm9A6jFk1E2FfiAthhM
 E8mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704384237; x=1704989037;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wbj9XQjH4wjaQmwUCu7Uppgeic/eprNUAiwgWhRgsuM=;
 b=MHAeOmA5bLYHqd7JB8Ty2CiVeX4W/v3P+X61lkffcZCeirHOQ+rbWtJ1zJ4iqcRwy5
 DcijmRNvPW8FY09K83rQxgQbSQI+nAzNiLUD1NLZTwOZ0yEMJpH+7bKpF7f5BQ6QSt54
 dGU2r1BKJRsEURBk9uNpVRFe1Wl7NA4D7GBeba1xH5cz0sAH/xo+k9/aQyEbbaZ/Odof
 xzXXkzoXSBaYJCYvRg94z8wCs+1MZSJOwXo/WCt3YqKS0q6HKcG3Vl26NGAhrIAsbsOs
 2ZxdP+bVvZLW0PbPWB359I/J1PLqCKo28NyR2Q3oOdXe57xNyW37dJeevf3xkKTl866m
 JN0A==
X-Gm-Message-State: AOJu0YxFM4//xmi2Ee6g/taOxYPVvn3pncD8warJIILVlw0/wsVbDVEa
 pYlZPh1CP2h502ZrF9N3vk6hfkkoqSiZJ/1M5n8li54CfKL/IAjokGNdJa09
X-Google-Smtp-Source: AGHT+IHjO4KK55HvNTrDa+EaSkzrIVOHiNg53hcSwQpwdsYVfL09TBkK+R3Se6ezndhN1dqcEigHZx63UKIQ2wdIu/A=
X-Received: by 2002:a50:d59a:0:b0:554:3ba8:6896 with SMTP id
 v26-20020a50d59a000000b005543ba86896mr542553edi.79.1704384237519; Thu, 04 Jan
 2024 08:03:57 -0800 (PST)
MIME-Version: 1.0
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
 <20231218113305.2511480-25-peter.maydell@linaro.org>
 <cd9c4cc1-be3b-49d4-a049-c8157a9cae03@linaro.org>
In-Reply-To: <cd9c4cc1-be3b-49d4-a049-c8157a9cae03@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Jan 2024 16:03:46 +0000
Message-ID: <CAFEAcA96cVE+upOzMow-qiH-S-fWKKMYj6FuhhvGn1jWc7EVxQ@mail.gmail.com>
Subject: Re: [PATCH 24/35] target/arm: Handle FEAT_NV2 changes to when
 SPSR_EL1.M reports EL2
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Wed, 27 Dec 2023 at 23:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 12/18/23 22:32, Peter Maydell wrote:
> > With FEAT_NV2, the condition for when SPSR_EL1.M should report that
> > an exception was taken from EL2 changes.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   target/arm/helper.c | 16 ++++++++++++----
> >   1 file changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/target/arm/helper.c b/target/arm/helper.c
> > index 45444360f95..38e16c2f8a5 100644
> > --- a/target/arm/helper.c
> > +++ b/target/arm/helper.c
> > @@ -11405,10 +11405,18 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
> >           aarch64_save_sp(env, arm_current_el(env));
> >           env->elr_el[new_el] = env->pc;
> >
> > -        if (cur_el == 1 && new_el == 1 &&
> > -            ((arm_hcr_el2_eff(env) & (HCR_NV | HCR_NV1)) == HCR_NV)) {
> > -            /* I_ZJRNN: report EL2 in the SPSR by setting M[3:2] to 0b10 */
> > -            old_mode = deposit32(old_mode, 2, 2, 2);
> > +        if (cur_el == 1 && new_el == 1) {
> > +            uint64_t hcr = arm_hcr_el2_eff(env);
> > +            if ((hcr & (HCR_NV | HCR_NV1 | HCR_NV2)) == HCR_NV ||
> > +                (hcr & (HCR_NV | HCR_NV2)) == (HCR_NV | HCR_NV2)) {
>
> Maybe clearer as
>
>         if ((hcr & HCR_NV) && ((hcr & HCR_NV2) || !(hcr & HCR_NV1)))
>
> ?

I dunno; I went back and forth a bit on how to write this, but
I think what I have is a little closer to how the Arm ARM
defines it (as separate FEAT_NV vs FEAT_NV2 conditions). At any rate,
I don't think your suggestion sufficiently better to do the
work to make the change :-)

-- PMM

