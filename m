Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CD0831616
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 10:45:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQOx1-0004bU-8d; Thu, 18 Jan 2024 04:44:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQOwz-0004bJ-9Q
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 04:44:41 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQOwr-0002JI-2B
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 04:44:38 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-55a179f5fa1so309736a12.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 01:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705571071; x=1706175871; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9wCUUAXleeoQERsXW3DJOWeLwhULLSJBAJzFRHzVKR4=;
 b=wnlg71oHG9CU4nG+XEdLhKnWcZGH0oqf6siipMuoaBjc0lr8vCALNeIiH9Zi8Y9HGH
 7yY0PVF6JKPkUFYKEoAZ2zBmPKmHLq6h/3bPr7dDiJVwamOPtWrHiBk9M/nFsCbNP+aO
 T1yLmFpMK09Oc6rqT/0zUkgVKJqE1+cKIg93/tNrTkYp78jiQtb5zFdhBVwEga0Sl0YN
 sPUKUAahqnEmOK13Pt4au9RgfcaXq8nmQKmAcqIaeaAcYjNeVf7cT5Mg3b7rGDqj07Qu
 jFi1qapFjNE6oY7SFBX+DuYV5PNNPU3TPki3EgOM6ewUiYFUb/lQ4G9HVMz9qyNvigtY
 PtSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705571071; x=1706175871;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9wCUUAXleeoQERsXW3DJOWeLwhULLSJBAJzFRHzVKR4=;
 b=MK1sJ2YlzvuROt34VYrX8KvelPxscCxhtriuwM2aTnX573LuwfUVdOIxG8+PXGXMtj
 oRfjdTyEJqduMhY3sMb9mOGJ5KS7h2rbD5qQcFFXO2uwUvEpZJ6+3GrCfIG9z01vIPlV
 SRpuo4s78FzrfxMZDCrGP8YJk/T91omqu0cOUXlh4TgHgU59zL6G1hq5k5b0cuKNXNDn
 n2XphwuSi6/1nvsfJhrDUYaALRcP7S2j6LrfmlEp5Z+DXdgZb0QeyIGh6TeymNs1ikY0
 cafoBwtdd1LVP0TvWm7KjM0bRMFQD03nv9s1woAgfn4yDsZuozGf+U1HZco5UlkW2nUo
 6qcQ==
X-Gm-Message-State: AOJu0Yw33cHLntqG3AzLFeVr3asckmk8hvzlLV9UFfP1zXMZtqes00Tj
 150pz4qcGSi8MN7BSNG1zPx6i4HHJGFJn6jWgmC6+DX31TYYKberN4w9DhuPkp3exHZhcPwg+c+
 +Ukhq8Xecjs4MfRMKAOm4pvycqSHu9jVfnXvNHQ==
X-Google-Smtp-Source: AGHT+IHeJRytunJBAUY3xFHXDQcg7qvkcZm4sL0K5lB+RyLYWJDRTbadNFQ97mcOJANsYYjF+qKl9KI9HYfkhMEOGbM=
X-Received: by 2002:a50:f683:0:b0:558:1700:70e6 with SMTP id
 d3-20020a50f683000000b00558170070e6mr366431edn.36.1705571071550; Thu, 18 Jan
 2024 01:44:31 -0800 (PST)
MIME-Version: 1.0
References: <20240111110505.1563291-1-peter.maydell@linaro.org>
 <20240111110505.1563291-9-peter.maydell@linaro.org> <877ck7d56n.fsf@suse.de>
In-Reply-To: <877ck7d56n.fsf@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jan 2024 09:44:19 +0000
Message-ID: <CAFEAcA-FW-CZga48B-id=uxmxjF7_rZiO+2jJRsZmT9or+_77g@mail.gmail.com>
Subject: Re: [PULL 08/41] target/arm: Set CTR_EL0.{IDC,DIC} for the 'max' CPU
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Wed, 17 Jan 2024 at 21:24, Fabiano Rosas <farosas@suse.de> wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> > diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
> > index fcda99e1583..40e7a45166f 100644
> > --- a/target/arm/tcg/cpu64.c
> > +++ b/target/arm/tcg/cpu64.c
> > @@ -1105,6 +1105,16 @@ void aarch64_max_tcg_initfn(Object *obj)
> >      u = FIELD_DP32(u, CLIDR_EL1, LOUU, 0);
> >      cpu->clidr = u;
> >
> > +    /*
> > +     * Set CTR_EL0.DIC and IDC to tell the guest it doesnt' need to
> > +     * do any cache maintenance for data-to-instruction or
> > +     * instruction-to-guest coherence. (Our cache ops are nops.)
> > +     */
> > +    t = cpu->ctr;
> > +    t = FIELD_DP64(t, CTR_EL0, IDC, 1);
> > +    t = FIELD_DP64(t, CTR_EL0, DIC, 1);
> > +    cpu->ctr = t;
> > +
> >      t = cpu->isar.id_aa64isar0;
> >      t = FIELD_DP64(t, ID_AA64ISAR0, AES, 2);      /* FEAT_PMULL */
> >      t = FIELD_DP64(t, ID_AA64ISAR0, SHA1, 1);     /* FEAT_SHA1 */
>
> Hi, we're introducing new regression tests to migration and this patch
> shows up in the bisect of an issue. I need some help figuring out
> whether this is an actual regression or something else.
>
> The migration is TCG QEMU 8.2.0 -> TCG QEMU master.
>
> On the destination side (contains this patch) we're hitting this
> condition:
>
> bool write_list_to_cpustate(ARMCPU *cpu)
> {
> ...
>         /*
>          * Write value and confirm it reads back as written
>          * (to catch read-only registers and partially read-only
>          * registers where the incoming migration value doesn't match)
>          */
>         write_raw_cp_reg(&cpu->env, ri, v);
>         if (read_raw_cp_reg(&cpu->env, ri) != v) {
> --->        ok = false;
>         }

This is (among other things) effectively checking that the
source and destination CPU agree about the values of constant
registers like the ID registers, of which this is one.

The "max" CPU is a moving target, so you shouldn't expect
to be able to migrate across QEMU versions using it:
it can have different features and thus different ID
register values between versions (as well as potentially
different actual-register-state if the added feature adds
new state).

thanks
-- PMM

