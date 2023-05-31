Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D907187C3
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 18:48:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Oyz-0002Fg-N8; Wed, 31 May 2023 12:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>)
 id 1q4Oyw-0002Em-Uh; Wed, 31 May 2023 12:47:30 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>)
 id 1q4Oyr-00014G-89; Wed, 31 May 2023 12:47:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 22B5C60FA7;
 Wed, 31 May 2023 16:47:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88138C4339C;
 Wed, 31 May 2023 16:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1685551636;
 bh=hWQvyC99yol6jcmVA70uv8y0HTzTSGZUK01vDfymdiM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=OEiC0aF9crMv8JtI7+tX7XBMSYwSURF936T+2x93tv8WE6JGmMHgNZD08EXp0Fssk
 jT/tMJkfqM7m+ufxyLUtiNy66fA9RC/e7Fnou7iiA8W3lp48L1l3hB+qzGbzgB9yfd
 W5UyP3RFTdDFiB14aFzGOYS7AjsBSQSV+RQs8HOcoN+prTzF3e7bRMCe2MEoIa4Sx0
 1kZoSjag36UniZoN3zuSiDSYDy8qXMe7OlyluskwjEcmgynfNVlxoviunYtj82GvUJ
 Vcxy1ToqOidCKOUKwhF0r812Yc7dxZ7nHOI2SEJwoHBsC3XfDvdLIeAT+mDPX5zhbn
 4tfijasLjxZ4A==
Received: by mail-lj1-f182.google.com with SMTP id
 38308e7fff4ca-2af2c7f2883so65870341fa.3; 
 Wed, 31 May 2023 09:47:16 -0700 (PDT)
X-Gm-Message-State: AC+VfDwW093zi2EELZoqPPE/tdnwAljnoLmpG2a6VlIV42V60MLA6LWr
 MNygc4EgFbdzbhYiCzTbGi6r1yZ0yMcgp+VLjeY=
X-Google-Smtp-Source: ACHHUZ7sAgrtvrlyWxV7eiZDoTA/+MqGSsP4hjrZxM/eDWDEBrr5aJ9MB67X5WoBBHphT0B/kA4It8Fs5r/DoMsWDfc=
X-Received: by 2002:a2e:8050:0:b0:2a8:c75d:8167 with SMTP id
 p16-20020a2e8050000000b002a8c75d8167mr3179610ljg.4.1685551634509; Wed, 31 May
 2023 09:47:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230531112239.3164777-1-ardb@kernel.org>
 <722d7683-80b4-bb23-3ca2-77f8de23b801@linaro.org>
In-Reply-To: <722d7683-80b4-bb23-3ca2-77f8de23b801@linaro.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 31 May 2023 18:47:03 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEH4zFcOZGz0HvTbpcMUup+cyZEr0JQxH1uXpGcbAc6ow@mail.gmail.com>
Message-ID: <CAMj1kXEH4zFcOZGz0HvTbpcMUup+cyZEr0JQxH1uXpGcbAc6ow@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Implement AES on ARM using x86 instructions and vv
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=ardb@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, 31 May 2023 at 18:33, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 5/31/23 04:22, Ard Biesheuvel wrote:
> > Use the host native instructions to implement the AES instructions
> > exposed by the emulated target. The mapping is not 1:1, so it requires a
> > bit of fiddling to get the right result.
> >
> > This is still RFC material - the current approach feels too ad-hoc, but
> > given the non-1:1 correspondence, doing a proper abstraction is rather
> > difficult.
> >
> > Changes since v1/RFC:
> > - add second patch to implement x86 AES instructions on ARM hosts - this
> >    helps illustrate what an abstraction should cover.
> > - use cpuinfo framework to detect host support for AES instructions.
> > - implement ARM aesimc using x86 aesimc directly
> >
> > Patch #1 produces a 1.5-2x speedup in tests using the Linux kernel's
> > tcrypt benchmark (mode=500)
> >
> > Patch #2 produces a 2-3x speedup. The discrepancy is most likely due to
> > the fact that ARM uses two instructions to implement a single AES round,
> > whereas x86 only uses one.
>
> Thanks.  I spent some time yesterday looking at this, with an encrypted disk test case and
> could only measure 0.6% and 0.5% for total overhead of decrypt and encrypt respectively.
>

I don't understand what 'overhead' means in this context. Are you
saying you saw barely any improvement?

> > As for the design of an abstraction: I imagine we could introduce a
> > host/aes.h API that implements some building blocks that the TCG helper
> > implementation could use.
>
> Indeed.  I was considering interfaces like
>
> /* Perform SubBytes + ShiftRows on state. */
> Int128 aesenc_SB_SR(Int128 state);
>
> /* Perform MixColumns on state. */
> Int128 aesenc_MC(Int128 state);
>
> /* Perform SubBytes + ShiftRows + MixColumns on state. */
> Int128 aesenc_SB_SR_MC(Int128 state);
>
> /* Perform SubBytes + ShiftRows + MixColumns + AddRoundKey. */
> Int128 aesenc_SB_SR_MC_AK(Int128 state, Int128 roundkey);
>
> and so forth for aesdec as well.  All but aesenc_MC should be implementable on x86 and
> Power7, and all of them on aarch64.
>

aesenc_MC() can be implemented on x86 the way I did in patch #!, using
aesdeclast+aesenc


> > I suppose it really depends on whether there is a third host
> > architecture that could make use of this, and how its AES instructions
> > map onto the primitive AES ops above.
>
> There is Power6 (v{,n}cipher{,last}) and RISC-V Zkn (aes64{es,esm,ds,dsm,im})
>
> I got hung up yesterday was understanding the different endian requirements of x86 vs Power.
>
> ppc64:
>
>      asm("lxvd2x 32,0,%1;"
>          "lxvd2x 33,0,%2;"
>          "vcipher 0,0,1;"
>          "stxvd2x 32,0,%0"
>          : : "r"(o), "r"(i), "r"(k), : "memory", "v0", "v1", "v2");
>
> ppc64le:
>
>      unsigned char le[16] = {8,9,10,11,12,13,14,15,0,1,2,3,4,5,6,7};
>      asm("lxvd2x 32,0,%1;"
>          "lxvd2x 33,0,%2;"
>          "lxvd2x 34,0,%3;"
>          "vperm 0,0,0,2;"
>          "vperm 1,1,1,2;"
>          "vcipher 0,0,1;"
>          "vperm 0,0,0,2;"
>          "stxvd2x 32,0,%0"
>          : : "r"(o), "r"(i), "r"(k), "r"(le) : "memory", "v0", "v1", "v2");
>
> There are also differences in their AES_Te* based C routines as well, which made me wonder
> if we are handling host endianness differences correctly in emulation right now.  I think
> I should most definitely add some generic-ish tests for this...
>

The above kind of sums it up, no? Or isn't this working code?

