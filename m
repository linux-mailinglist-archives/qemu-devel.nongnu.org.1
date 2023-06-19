Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8007359BA
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 16:36:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBFxL-0005xX-Nk; Mon, 19 Jun 2023 10:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBFxF-0005gh-8f
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:34:06 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBFxD-00046t-JM
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:34:05 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-51a1d539ffaso6777810a12.0
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 07:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687185242; x=1689777242;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=joCqpxnInsdBF8L23FguZ5gdPBnskwiFVid4hjwIFKE=;
 b=OMLSfVU+8kbtNDieMhEkGnTQafau0xEAwXzbGcRlUDWcQKNJAM2HBSOqm96/Uj3ocm
 LuZrxs65VTgvgsJZI2bI60XLdKLvHSM7y2I6shRnekiK0rVuLiF0S/KQTY3Qy/3LvdFt
 GzgUqlxMHhbwSFnbUFLwSPi/oLPKqUttlgSXIXVwL2nw9RmA07zoCYFDOvN7dEBvfKWa
 D5XiZvs6gJmfGaEjo4c6S9PKla5s+ALlDGL2Gh3VZk6A6L9uQYATlyl/3EwYihwlAGgv
 E09MWh2JimGWekMJTj1w163QdrnS/L8wleCn2aQ22/eawqaNRfKdKMqAYMQOmeccS2vm
 ezzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687185242; x=1689777242;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=joCqpxnInsdBF8L23FguZ5gdPBnskwiFVid4hjwIFKE=;
 b=C+dkpc7gkKQA3SkGK5Q3BG4+ZCnWVdPIf2kwyqLnX1o+VhaZNwcZT/2h335AJegUcC
 VqNlbfTQSbEHjJYr3SfjvCL823R9VquZLOxZlL1Ms7x5Gmgeg6Tcq4BR892rDhjt/kFc
 0XxwSRrCe7lflvmD6CBhwPcKSN+Rg6En9Bx+SbJ5OIae4uQbvEoYBBV6laW+uKwfn/Mj
 6WprjKvJB0+G32zK+CI7AXt8HmOHsfJYbGaEAWGeSeFmsGEXrMVcTtwGhH+MeilphV1p
 tFy20pwrbqghNsteWeervS164HKegH+l7DpV6lza5ACHdZ4eWzeHQA8FpGm6vsL6Th1h
 ATTA==
X-Gm-Message-State: AC+VfDzXfBP9YkefKYYvxVqQCGZTe61kQKc2n140eH6vajeTBIt1bbiV
 a+td9ZX7+BBagH9Jc6a27nDluWPU8k1NES/PmHsziA==
X-Google-Smtp-Source: ACHHUZ4ia1Kbn4186KE8D2e+U2I1+p72+27wybgPQD4WKc4ITWSN74r3jiTM9W4qMilyfDNwmRmXDZIumutIF/Y7JkM=
X-Received: by 2002:a05:6402:26ce:b0:516:5b18:a9f1 with SMTP id
 x14-20020a05640226ce00b005165b18a9f1mr15478637edd.0.1687185242092; Mon, 19
 Jun 2023 07:34:02 -0700 (PDT)
MIME-Version: 1.0
References: <168656283612.26761.9869630057811681568-0@git.sr.ht>
 <168656283612.26761.9869630057811681568-2@git.sr.ht>
 <CAFEAcA-M=7DCRSONNFCdMGf_HjLV7V8-_NxL8_HnBXPOhSzuUw@mail.gmail.com>
 <185b0d737a18be5137e9443d317568359a0282ed.camel@ericsson.com>
In-Reply-To: <185b0d737a18be5137e9443d317568359a0282ed.camel@ericsson.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Jun 2023 15:33:51 +0100
Message-ID: <CAFEAcA8_QCE4uYeq=qE4mVbmEztTAw4NJvoYL-jvq-0d97wg-Q@mail.gmail.com>
Subject: Re: [PATCH qemu v2 2/2] tests/tcg/aarch64: Add testcases for IC IVAU
 and dual-mapped code
To: =?UTF-8?Q?John_H=C3=B6gberg?= <john.hogberg@ericsson.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Mon, 19 Jun 2023 at 15:31, John H=C3=B6gberg <john.hogberg@ericsson.com>=
 wrote:
>
> Thanks for the review! :)
>
> > All new source files must start with a license-and-copyright
> comment.
> > ... snip ...
> > Generally in QEMU we prefer to typedef the function type,
> not the pointer-to-function type.
> > ... snip ...
> > You should probably mark all these asm statements as 'volatile'
> > to ensure that the compiler doesn't decide it can helpfully
> > reorder or remove them.
>
> Got it, I'll fix those.
>
> > Your asm code may be position-independent, but you're copying the
> > entire function here including the preamble and postamble that the
> > compiler emits for it, and you don't do anything in the makefile
> > to ensure that it's going to be position-independent.
> > ... snip ...
> > Why use an explicit register variable for this rather than
> > having the __asm__ return its result via an output ?
>
> Good point, I'll rewrite this part to avoid these issues.
>
> > This is a QEMU test case, though, and QEMU doesn't care about
> > cache lines because we don't model the cache. So why does it
> > matter ?
>
> We're trying to catch code modification through the use of instructions
> that invalidate cache lines. I wanted the test to cover invalidation of
> the code that does the invalidation itself too as "what happens if we
> invalidate the current TB and return" came up in the discussion on the
> bug tracker, but I can certainly cut this or expand on it in a comment
> if you wish.

I think expanding it a little would help.

> > There's no guarantee on actual hardware that omitting this
> > flush will cause the test to fail. The hardware implementation
> > is permitted to drop stuff from the cache any time it feels
> > like it, and it might choose to do that right at this point.
> > So any attempt to test "fails if we don't flush the icache"
> > would be a flaky test. It would also fail on a hardware
> > implementation where the icache and dcache are transparently
> > coherent (which is a permitted implementation; the CTR_EL0
> > DIC and IDC bits exist to tell software it can happily
> > skip the cache ops).
> >
> > System mode QEMU works because we model an implementation
> > with no caches (which is also permitted architecturally).
>
> True, do you want me to change the comment to this effect or cut the
> comment altogether?

Similarly here tweaking the comment would be enough.

thanks
-- PMM

