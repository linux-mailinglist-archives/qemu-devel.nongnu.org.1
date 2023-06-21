Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B29738FFE
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 21:24:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC3QN-0004Qs-1c; Wed, 21 Jun 2023 15:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qC3QH-0004QM-Mj
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 15:23:21 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qC3QF-0002lH-Tj
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 15:23:21 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2b46d4e1b0aso67255401fa.2
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 12:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687375396; x=1689967396;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D98fWOq/ufaLClSXbmaB44g4u1fVaXRgc4OO/ZyQ4/g=;
 b=IfowSHsp/8dQ4BzcPVRK+lBCX6J0My2DClWDk9wgkEihQA42kTOA3l38xr8hdvczOb
 jxjdYtCC1upOgJCjD05+t8DGtXiykY+rMZ1Dd508Cx+C5kphIm/9Ac7FCiku8Oh+jcnp
 vHKwHjatNxJpR9Lx0OLTxkgiPt5GobPHpFy/2I9ugf4HS6+MtZulIz/7XcubUCY2p4VO
 zPVAHeRRryjcfIS3QRVS3TJEozttOnqJu7gdjHPLynn0R3uxGhIe0S9P80SvPEV/cpU1
 SNTnRofMWLQPIKVFgpgHU8oN6stJbfu0yEl77CGBtC472SWg/O8rVluyOaZ0j5dijUtg
 ApYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687375396; x=1689967396;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D98fWOq/ufaLClSXbmaB44g4u1fVaXRgc4OO/ZyQ4/g=;
 b=k7WVEgI34cGWi6MxAWCl/wa5lAkdwKwndRyVrAfsGftQWbsFHh1pwtQtneYAiwNjkC
 rk33yb8HmwloBG6lOuoZRuhit2crfPNF0Zya/Xddyy/71ZSxHK9n0r8yS6S4aUfEhXMr
 quiXwYcIJ1njtnHfylknt4E/iGCP3xNXzpCXYBp8GEOwtaE9PPmJahwMCpj2ZdTbhNj0
 Gotlj4TxdOV22MOgAQFyiBpOeLLcqFRuHMIZqc27f5ll5e/z1mF/9f+3F19+hoaXgGqJ
 P1bFs49cEiiBK5yf7k+MlxFAkZmhjxiwoZKppwxJCKA5L8TS4dr8lMgANr9RyXA5Sm5R
 z+gQ==
X-Gm-Message-State: AC+VfDyarJvME11wlVhyvvZOhsNm1S5ufFQTbpsaoCvTaosFgd/UfAz/
 g+zTGZHvsIrkIQ6kmXEMDoaYtINAJFw8TC2rnBPYdw==
X-Google-Smtp-Source: ACHHUZ7ylidxA+rBgWGtOIX28U5Q7HYZD041fPyaDgd0p//bGDAh0g2uEIbyj21dM3NVylMsfyq7Uno2jQruliPXM/c=
X-Received: by 2002:a2e:8443:0:b0:2b1:edfe:8171 with SMTP id
 u3-20020a2e8443000000b002b1edfe8171mr9711250ljh.36.1687375396179; Wed, 21 Jun
 2023 12:23:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA_UkPyic7U8eJkzBdBNoQowMToJkK-ro9re51zwn9-CMw@mail.gmail.com>
 <CAFEAcA_EjzQvy67XpXeEn7zMbkoCPLAs3n5PGK2J5kuGkFEBhQ@mail.gmail.com>
 <87352li6kx.fsf@linaro.org>
 <CAFEAcA9JuKBZSjq6WaztNA74CU1g+b=5GQFO0KPqb2RzT3LcWg@mail.gmail.com>
 <87y1kdgmo8.fsf@linaro.org>
In-Reply-To: <87y1kdgmo8.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 21 Jun 2023 20:23:05 +0100
Message-ID: <CAFEAcA_+fSjhPBRTi5b64kcJAqZxrL+4oFiLyKG+TmobQhy5hw@mail.gmail.com>
Subject: Re: 'make check-tcg' fails with an assert in
 qemu_plugin_vcpu_init_hook
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22e.google.com
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

On Wed, 21 Jun 2023 at 11:00, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On Wed, 21 Jun 2023 at 09:05, Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
> >>   - I suspect the plugin core stuff could be build once (or maybe twic=
e,
> >>     system and user)
> >
> > It is already build-once, that's why it goes wrong...
>
> I thought it was the other way around:
>
>   specific_ss.add(when: 'CONFIG_PLUGIN', if_true: [files(
>     'loader.c',
>     'core.c',
>     'api.c',
>   ), declare_dependency(link_args: plugin_ldflags)])
>
> but if we built it for linux-user and softmmu this could be fixed (until
> the next breakage anyway). cpus-common.c is the common code that sets
> this once.

Oh, right, I got it the wrong way around.

> >>   - we need to have some guard rails somehow to make sure things don't
> >>     go out of sync
> >
> > We do, this is the poison.h stuff. CONFIG_USER_ONLY is a
> > special case which we don't poison because there would be
> > too much refactoring required...
>
> I guess a great big honking comment at the top of CPUState telling
> people not to do that or pushing softmmu and user specific bits of
> CPUState into their own de-referenced structures.

It's not specific to CPUState, though. The thing you must not
do is use CONFIG_USER_ONLY (or CONFIG_SOFTMMU, now) to ifdef
out any struct field anywhere in any struct that's visible to
compiled-once code, or otherwise do something that changes
the ABI of a global or of a type passed around between functions.

-- PMM

