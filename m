Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1B7782D74
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 17:46:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY75e-0007qY-8F; Mon, 21 Aug 2023 11:45:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1qY75a-0007qO-Ob
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 11:45:10 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1qY75W-0006Ij-VZ
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 11:45:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 54FE2616E1
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 15:45:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8BF5C433C7
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 15:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1692632704;
 bh=/N5K13dvgUyjDAMSC1Vh9tTUsG/POJt6cq/pm3eJeIk=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=EUV+uwO/qYF7TPQ+JK5u7Z8woMAbEnS+C+LoH56wuNm7plyrHBW0CQknCKpLtMj7q
 dXukPN2hXw2KUGfN7fqdDP+yX/Wgsx/MulDC7p9Qw/HwduQ6e+DjxraFUC9e+pM3jE
 Z9yKo3Msts/NMGulSLx+yzmPMRBxNTL8kxa9ZNaZfVGFK/5odor7DBx5+TZNluu6Sa
 4RASe21BoTOOzwQKRPHeNZ10Tjink1zgX0MFKQ6LGV21IuQZdOXBHOn0HuVEdcSm2y
 WcN9ERW1SsXWCOMzRsc6yarYHig0l6qG3TnTG3mBU6KGJr8d7XgUJUMKWEET7zKJZH
 bb3JPlSv/C64A==
Received: by mail-lf1-f41.google.com with SMTP id
 2adb3069b0e04-5007abb15e9so2211856e87.0
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 08:45:04 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz3+n4PYHaRuhwMYUPFAL0zyx09n+U/p7mowdnTtMrx66GT3mCo
 MsJBVUsAUsMtX4v9zgyTPMpsw7XFQGm+75oiH0s=
X-Google-Smtp-Source: AGHT+IHncQ5fpzHL4fm5fWPBQC6HBG3lcW7o4PAStdIjojLbzXeSHAllCECKfn5FyDV2b+qKpdqSWyBrIaAKMC61uZw=
X-Received: by 2002:a19:4f19:0:b0:4ff:ae42:19e2 with SMTP id
 d25-20020a194f19000000b004ffae4219e2mr3840867lfb.58.1692632702697; Mon, 21
 Aug 2023 08:45:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230819010218.192706-1-richard.henderson@linaro.org>
 <CAMj1kXFWeUzWkpt5o0Bh6CXzBHoxkZk7wUiLsidEvDjH_SSnHw@mail.gmail.com>
 <dcbfe992-303d-5472-e7c7-4c1c717cde7b@linaro.org>
In-Reply-To: <dcbfe992-303d-5472-e7c7-4c1c717cde7b@linaro.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 21 Aug 2023 17:44:51 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG1LTHySAwh1fOMQCWnK=raXs7pmvwoq2n3bJRd-QKK-A@mail.gmail.com>
Message-ID: <CAMj1kXG1LTHySAwh1fOMQCWnK=raXs7pmvwoq2n3bJRd-QKK-A@mail.gmail.com>
Subject: Re: [PATCH v2 00/18] crypto: Provide clmul.h and host accel
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=139.178.84.217; envelope-from=ardb@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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

On Mon, 21 Aug 2023 at 17:15, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 8/21/23 07:57, Ard Biesheuvel wrote:
> >> Richard Henderson (18):
> >>    crypto: Add generic 8-bit carry-less multiply routines
> >>    target/arm: Use clmul_8* routines
> >>    target/s390x: Use clmul_8* routines
> >>    target/ppc: Use clmul_8* routines
> >>    crypto: Add generic 16-bit carry-less multiply routines
> >>    target/arm: Use clmul_16* routines
> >>    target/s390x: Use clmul_16* routines
> >>    target/ppc: Use clmul_16* routines
> >>    crypto: Add generic 32-bit carry-less multiply routines
> >>    target/arm: Use clmul_32* routines
> >>    target/s390x: Use clmul_32* routines
> >>    target/ppc: Use clmul_32* routines
> >>    crypto: Add generic 64-bit carry-less multiply routine
> >>    target/arm: Use clmul_64
> >>    target/s390x: Use clmul_64
> >>    target/ppc: Use clmul_64
> >>    host/include/i386: Implement clmul.h
> >>    host/include/aarch64: Implement clmul.h
> >>
> >
> > I didn't re-run the OpenSSL benchmark, but the x86 Linux kernel still
> > passes all its crypto selftests when running under TCG emulation on a
> > TX2 arm64 host, so
> >
> > Tested-by: Ard Biesheuvel <ardb@kernel.org>
>
> Oh, whoops.  What's missing here?  Any target/i386 changes.
>

Ah yes - I hadn't spotted that. The below seems to do the trick.

--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -2156,7 +2156,10 @@ void glue(helper_pclmulqdq, SUFFIX)(CPUX86State
*env, Reg *d, Reg *v, Reg *s,
     for (i = 0; i < 1 << SHIFT; i += 2) {
         a = v->Q(((ctrl & 1) != 0) + i);
         b = s->Q(((ctrl & 16) != 0) + i);
-        clmulq(&d->Q(i), &d->Q(i + 1), a, b);
+
+        Int128 r = clmul_64(a, b);
+        d->Q(i) = int128_getlo(r);
+        d->Q(i + 1) = int128_gethi(r);
     }
 }

[and the #include added and clmulq() dropped]

I did a quick RFC4106 benchmark with tcrypt (which doesn't speed up as
much as OpenSSL but it is a bit of a hassle cross-rebuilding that)

no acceleration:

tcrypt: test 7 (160 bit key, 8192 byte blocks): 1547 operations in 1
seconds (12673024 bytes)

AES only:

tcrypt: test 7 (160 bit key, 8192 byte blocks): 1679 operations in 1
seconds (13754368 bytes)

AES and PMULL

tcrypt: test 7 (160 bit key, 8192 byte blocks): 3298 operations in 1
seconds (27017216 bytes)

