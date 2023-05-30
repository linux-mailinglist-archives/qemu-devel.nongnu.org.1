Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A816D716A55
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 19:00:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q42gp-0002u3-6I; Tue, 30 May 2023 12:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>)
 id 1q42gh-0002nO-S3; Tue, 30 May 2023 12:59:13 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>)
 id 1q42ge-0006O7-TE; Tue, 30 May 2023 12:59:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 038B763082;
 Tue, 30 May 2023 16:59:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99EEC433A4;
 Tue, 30 May 2023 16:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1685465946;
 bh=aiREaNoBxTIFPyj1qWO754P/cI+EmEr89qizdPzLSEI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=DCJqYTW/3TAxLjhsqgXAZ1GBAsWlDDKKfPX279o/zE2oe55OXudZTXOCPhZ/aUmzW
 F/mldylfTK3cZqxgEQZeFwHEdEVDqe9xApiVW/nJIRKYmbJdwc+KykVnvHgjOAXjox
 XPwsZqyhXwQA0kw5yDOFQVSb29MHsWQjiUWglDAmnO8HQ/+np0JIptfDDioj/wViZA
 d+ASNiGerjjlgMa/MlxJibn16fX8odHvQqONw5KaBDWOQLp1ib+yBZWR82RF9rM80K
 3TZgUOaNYSprbPmhVIrPELoXVXhtFdIA2LoxSOXxrfH2LCCi+A+UG+0g0HIz4Sdfwb
 bBFytMaXc9AGw==
Received: by mail-lj1-f177.google.com with SMTP id
 38308e7fff4ca-2af1e290921so49093921fa.3; 
 Tue, 30 May 2023 09:59:06 -0700 (PDT)
X-Gm-Message-State: AC+VfDyyBE8y4XiqCTkcSU+YwQPwYhoczOzgHc7fUL07nk1sC4QMkXU4
 PipOyV9LvEVhug8ro+7x2ZOyHE50W2hN2k5gdFc=
X-Google-Smtp-Source: ACHHUZ7Krh3tmQm20aFW3ye90u6YtXVYmUt09vaRdvuT5xxoEAqMl5GTBh0525dt1Qna4ZH/6N42MUIS3PuwhM4L674=
X-Received: by 2002:a2e:98c7:0:b0:2af:23fe:98ef with SMTP id
 s7-20020a2e98c7000000b002af23fe98efmr1130462ljj.50.1685465944845; Tue, 30 May
 2023 09:59:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230530135204.2903761-1-ardb@kernel.org>
 <666b4b6c-380e-142e-9348-823006b35312@linaro.org>
In-Reply-To: <666b4b6c-380e-142e-9348-823006b35312@linaro.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 30 May 2023 18:58:53 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEE3X=m9X9DkMu885w=Vperp100NWcJ33XOTDm0O+1sWQ@mail.gmail.com>
Message-ID: <CAMj1kXEE3X=m9X9DkMu885w=Vperp100NWcJ33XOTDm0O+1sWQ@mail.gmail.com>
Subject: Re: [RFC PATCH] target/arm: use x86 intrinsics to implement AES
 instructions
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=139.178.84.217; envelope-from=ardb@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
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

On Tue, 30 May 2023 at 18:43, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 5/30/23 06:52, Ard Biesheuvel wrote:
> > +#ifdef __x86_64__
> > +    if (have_aes()) {
> > +        __m128i *d = (__m128i *)rd;
> > +
> > +        *d = decrypt ? _mm_aesdeclast_si128(rk.vec ^ st.vec, (__m128i){})
> > +                     : _mm_aesenclast_si128(rk.vec ^ st.vec, (__m128i){});
>
> Do I correctly understand that the ARM xor is pre-shift
>
> > +        return;
> > +    }
> > +#endif
> > +
> >       /* xor state vector with round key */
> >       rk.l[0] ^= st.l[0];
> >       rk.l[1] ^= st.l[1];
>
> (like so)
>
> whereas the x86 xor is post-shift
>
> > void glue(helper_aesenclast, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
> > {
> >     int i;
> >     Reg st = *v;
> >     Reg rk = *s;
> >
> >     for (i = 0; i < 8 << SHIFT; i++) {
> >         d->B(i) = rk.B(i) ^ (AES_sbox[st.B(AES_shifts[i & 15] + (i & ~15))]);
> >     }
>
> (like so, from target/i386/ops_sse.h)?
>

Indeed. Using the primitive operations defined in the AES paper, we
basically have the following for n rounds of AES (for n in {10, 12,
14})

for (n-1 rounds) {
  AddRoundKey
  ShiftRows
  SubBytes
  MixColumns
}
AddRoundKey
ShiftRows
SubBytes
AddRoundKey

AddRoundKey is just XOR, but it is incorporated into the instructions
that combine a couple of these steps.

So on x86, we have

aesenc:
  ShiftRows
  SubBytes
  MixColumns
  AddRoundKey

aesenclast:
  ShiftRows
  SubBytes
  AddRoundKey

and on ARM we have

aese:
  AddRoundKey
  ShiftRows
  SubBytes

aesmc:
  MixColumns


> What might help: could we do the reverse -- emulate the x86 aesdeclast instruction with
> the aarch64 aesd instruction?
>

Help in what sense? To emulate the x86 instructions on a ARM host?

But yes, aesenclast can be implement using aese in a similar way,
i.e., by passing a {0} vector as the round key into the instruction,
and performing the XOR explicitly using the real round key afterwards.

