Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8EA971F08A
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 19:21:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4kEk-0002eo-BO; Thu, 01 Jun 2023 11:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>)
 id 1q4kEi-0002eH-6d; Thu, 01 Jun 2023 11:29:12 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>)
 id 1q4kEg-0004WP-8p; Thu, 01 Jun 2023 11:29:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 01FC56342E;
 Thu,  1 Jun 2023 15:29:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6552DC4339B;
 Thu,  1 Jun 2023 15:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1685633347;
 bh=vBJv4Uc0t8gua2ApVQioKbg9Il4lz1BvPgF/JwElDj0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=oka4Sma6u+AVM2PxFUaalPuy06uADBcKT81IaJMQ/3zqMoiK52u3sak9OSa5YdS0U
 mjj2vDfgXwgLDVRn4AkI+KOghn7XBf3XqWo57rhQvmZ2bHhV2/wjCZAwr3JfAAnDJe
 piTRlPcocJ9tF3NhbI4lPSG4SLeC5W4lDpM0ubnGdtPqXfr5IQDLD1D004tNgl6DS2
 otHd5vG8nmGbH7Gx4sRpoq+9fsdh5nIqqMgqpyWXA3FVAxWKbmYFBRedmoaeKVleXP
 LSpv46f/pnZQFPtxxqsssD+0fL/r/JUfBbaQHOKnKlNDkedwHjBDiAY825/X8wS78K
 luWfyx0DZYg9w==
Received: by mail-lj1-f173.google.com with SMTP id
 38308e7fff4ca-2b1a653b409so6355491fa.0; 
 Thu, 01 Jun 2023 08:29:07 -0700 (PDT)
X-Gm-Message-State: AC+VfDzb10mY2R6cYbR371Zvib+OwVmRnP2mMYYeRXOV84RNWFiHLHlT
 ICD7h++4jZo4+Jo31rb+LI7xvkPxY3lF2tx2vJg=
X-Google-Smtp-Source: ACHHUZ4mY/itY6ayiLHHVX8o4S1srmJ2SljhxZbAwBT8PedtCwbkQfOLrfMpMs7NZLGczcUrXWdgQklLMtIZCcwJYbc=
X-Received: by 2002:a2e:8195:0:b0:2a2:ac00:4de4 with SMTP id
 e21-20020a2e8195000000b002a2ac004de4mr829023ljg.22.1685633345317; Thu, 01 Jun
 2023 08:29:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230601123332.3297404-1-ardb@kernel.org>
 <20230601123332.3297404-2-ardb@kernel.org>
 <CAFEAcA_Z_3xNC6HjuyvRtf+s9pJjGsZeSZ87VG03J2yZZ60Wtw@mail.gmail.com>
In-Reply-To: <CAFEAcA_Z_3xNC6HjuyvRtf+s9pJjGsZeSZ87VG03J2yZZ60Wtw@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 1 Jun 2023 17:28:54 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEUUfvVRebCe0mAU5PBZzWHbe9r-1n2MOsJW+sDK86HcQ@mail.gmail.com>
Message-ID: <CAMj1kXEUUfvVRebCe0mAU5PBZzWHbe9r-1n2MOsJW+sDK86HcQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] target/arm: Use x86 intrinsics to implement PMULL.P64
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=139.178.84.217; envelope-from=ardb@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, 1 Jun 2023 at 15:01, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Thu, 1 Jun 2023 at 13:33, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  host/include/i386/host/cpuinfo.h |  1 +
> >  target/arm/tcg/vec_helper.c      | 26 +++++++++++++++++++-
> >  util/cpuinfo-i386.c              |  1 +
> >  3 files changed, 27 insertions(+), 1 deletion(-)
> >
> > diff --git a/host/include/i386/host/cpuinfo.h b/host/include/i386/host/cpuinfo.h
> > index 073d0a426f31487d..cf4ced844760d28f 100644
> > --- a/host/include/i386/host/cpuinfo.h
> > +++ b/host/include/i386/host/cpuinfo.h
> > @@ -27,6 +27,7 @@
> >  #define CPUINFO_ATOMIC_VMOVDQA  (1u << 16)
> >  #define CPUINFO_ATOMIC_VMOVDQU  (1u << 17)
> >  #define CPUINFO_AES             (1u << 18)
> > +#define CPUINFO_PMULL           (1u << 19)
> >
> >  /* Initialized with a constructor. */
> >  extern unsigned cpuinfo;
> > diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
> > index f59d3b26eacf08f8..fb422627588439b3 100644
> > --- a/target/arm/tcg/vec_helper.c
> > +++ b/target/arm/tcg/vec_helper.c
> > @@ -25,6 +25,14 @@
> >  #include "qemu/int128.h"
> >  #include "vec_internal.h"
> >
> > +#ifdef __x86_64__
> > +#include "host/cpuinfo.h"
> > +#include <wmmintrin.h>
> > +#define TARGET_PMULL  __attribute__((__target__("pclmul")))
> > +#else
> > +#define TARGET_PMULL
> > +#endif
> > +
> >  /*
> >   * Data for expanding active predicate bits to bytes, for byte elements.
> >   *
> > @@ -2010,12 +2018,28 @@ void HELPER(gvec_pmul_b)(void *vd, void *vn, void *vm, uint32_t desc)
> >   * Because of the lanes are not accessed in strict columns,
> >   * this probably cannot be turned into a generic helper.
> >   */
> > -void HELPER(gvec_pmull_q)(void *vd, void *vn, void *vm, uint32_t desc)
> > +void TARGET_PMULL HELPER(gvec_pmull_q)(void *vd, void *vn, void *vm, uint32_t desc)
> >  {
> >      intptr_t i, j, opr_sz = simd_oprsz(desc);
> >      intptr_t hi = simd_data(desc);
> >      uint64_t *d = vd, *n = vn, *m = vm;
> >
> > +#ifdef __x86_64__
> > +    if (cpuinfo & CPUINFO_PMULL) {
> > +       switch (hi) {
> > +       case 0:
> > +               *(__m128i *)vd = _mm_clmulepi64_si128(*(__m128i *)vm, *(__m128i *)vn, 0x0);
> > +               break;
> > +       case 1:
> > +               *(__m128i *)vd = _mm_clmulepi64_si128(*(__m128i *)vm, *(__m128i *)vn, 0x11);
> > +               break;
> > +       default:
> > +               g_assert_not_reached();
> > +       }
> > +        return;
> > +    }
> > +#endif
>
> This needs to cope with the input vectors being more than
> just 128 bits wide, I think. Also you probably still
> need the clear_tail() to clear any high bits of the register.
>

Ah yes, I missed that completely.

