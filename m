Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0560D74A14D
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 17:42:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHR7d-0007i5-6T; Thu, 06 Jul 2023 11:42:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qHR7b-0007hk-NZ
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 11:42:19 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qHR7X-0002ps-1q
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 11:42:16 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-51d91e9b533so1193800a12.3
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 08:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688658133; x=1691250133;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pDOcECtSDbMlz92ByLP87Yex2kID/Lk5R5n88ZL1IWE=;
 b=eaYDPjMWLcr5mCgZ5VgjMvxnWjnHSsbG5RrDUXFgWO+udchFMp844B8K93QPwAOuMw
 jtIZoZiKyVxtNj4ABc7uUarwvc71QNYFfdhYW6h+pOu0SBNxIUWT8wbqA+4EkDBsQ8di
 xPF0cEk74dXXW98u1LkLfiQMkYD9L3FkEpRTkAqpMhukjtGqYWw/FL9xKsVjIZ7LpMLA
 uLu8IymS7Hd/gHf49+1azdN5zxpjVTVzr5BRamsWMwHcb2vNNysO32d/u+6TBt0qCagw
 tNxg0YwKrQYKIxPzF4t3dsfzqC9MdA5IBQZjV7lf76yROACiOuaZoSHrw8sk8jJQvxtz
 ievw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688658133; x=1691250133;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pDOcECtSDbMlz92ByLP87Yex2kID/Lk5R5n88ZL1IWE=;
 b=U/zRob8QLqUeQAwSlxJEBQSSDRDIHOy3qPb/85+pugFV3t0X/3Fm3YCi4+tfbxQlBn
 G9yS2e42qqvySTOzvf7aK+38Noea+dAw74VBvG9z+47WQPKRoKcW4fdte3Gd79zqWCwP
 0lglCQtdr7GF1SvLoBPbqmqBkptNKRsl8R7VmIbjEYYU+TNKOC/Y9+ago6d4Uj0g/7mq
 uHjAFyUbDbJVUAZYa644HL+V0jwOWMJVNFTg8VkQG9ZxB+e7jv9ovaVjQ38QQAf2V67S
 vLouy7POEFcHf+VTMUt8uht5ESi2no/NblqyqHVGma/qxitTbUbzNjYVv/xLFd1XJnhQ
 VW4g==
X-Gm-Message-State: ABy/qLbMT4v/YtWoxd03OkKnmNUzT42TOrVtdc48G7lwcO5WKhzowSYL
 jJ9e4mN2zMnXpxjNVIBBIrLaTa0C8b6xfTrTCGqKInb+TTmspaVi
X-Google-Smtp-Source: APBJJlF7W9rvCMgbJ7rSAuE3DeHPcGyzH0eDjJYQvDFKYxLwOJWQ5jHVcKHxknfFXzOH6594LadogPl5IBgGrhcb4Tw=
X-Received: by 2002:a05:6402:12d8:b0:51d:9d59:7a11 with SMTP id
 k24-20020a05640212d800b0051d9d597a11mr1810925edx.4.1688658133000; Thu, 06 Jul
 2023 08:42:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230706140850.3007762-2-jean-philippe@linaro.org>
 <CAFEAcA8h-VXZkD0SBrjOYg-FFVk5AW0RrAs4AL4w6RXWZzWUsQ@mail.gmail.com>
 <20230706152543.GB2570588@myrica>
In-Reply-To: <20230706152543.GB2570588@myrica>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Jul 2023 16:42:02 +0100
Message-ID: <CAFEAcA8crpS3SBoCsmxaj4isMcGYrExOTDU=m5u8-gOkrrjERA@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Fix ptw parameters in S1_ptw_translate() for
 debug contexts
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: richard.henderson@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Thu, 6 Jul 2023 at 16:25, Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> On Thu, Jul 06, 2023 at 03:28:32PM +0100, Peter Maydell wrote:
> > On Thu, 6 Jul 2023 at 15:12, Jean-Philippe Brucker
> > <jean-philippe@linaro.org> wrote:
> > >
> > > Arm TF-A fails to boot via semihosting following a recent change to the
> > > MMU code. Semihosting attempts to read parameters passed by TF-A in
> > > secure RAM via cpu_memory_rw_debug(). While performing the S1
> > > translation, we call S1_ptw_translate() on the page table descriptor
> > > address, with an MMU index of ARMMMUIdx_Phys_S. At the moment
> > > S1_ptw_translate() doesn't interpret this as a secure access, and as a
> > > result we attempt to read the page table descriptor from the non-secure
> > > address space, which fails.
> > >
> > > Fixes: fe4a5472ccd6 ("target/arm: Use get_phys_addr_with_struct in S1_ptw_translate")
> > > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > ---
> > > I'm not entirely sure why the semihosting parameters are accessed
> > > through stage-1 translation rather than directly as physical addresses,
> > > but I'm not familiar with semihosting.
> >
> > The semihosting ABI says the guest code should pass "a pointer
> > to the parameter block". It doesn't say explicitly, but the
> > straightforward interpretation is "a pointer that the guest
> > itself could dereference to read/write the values", which means
> > a virtual address, not a physical one. It would be pretty
> > painful for the guest to have to figure out "what is the
> > physaddr for this virtual address" to pass it to the semihosting
> > call.
> >
> > Do you have a repro case for this bug? Did it work
> > before commit fe4a5472ccd6 ?
>
> Yes I bisected to fe4a5472ccd6 by trying to run TF-A, following
> instructions here:
> https://github.com/ARM-software/arm-trusted-firmware/blob/master/docs/plat/qemu.rst
>
> Building TF-A (HEAD 8e31faa05):
> make -j CROSS_COMPILE=aarch64-linux-gnu- BL33=edk2/Build/ArmVirtQemuKernel-AARCH64/DEBUG_GCC5/FV/QEMU_EFI.fd PLAT=qemu DEBUG=1 LOG_LEVEL=40 all fip
>
> Installing it to QEMU runtime dir:
> ln -sf tf-a/build/qemu/debug/bl1.bin build/qemu-cca/run/
> ln -sf tf-a/build/qemu/debug/bl2.bin build/qemu-cca/run/
> ln -sf tf-a/build/qemu/debug/bl31.bin build/qemu-cca/run/
> ln -sf edk2/Build/ArmVirtQemuKernel-AARCH64/DEBUG_GCC5/FV/QEMU_EFI.fd build/qemu-cca/run/bl33.bin

Could you put the necessary binary blobs up somewhere, to save
me trying to rebuild TF-A ?


> > > ---
> > >  target/arm/ptw.c | 6 ++----
> > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> > > index 9aaff1546a..e3a738c28e 100644
> > > --- a/target/arm/ptw.c
> > > +++ b/target/arm/ptw.c
> > > @@ -465,10 +465,8 @@ static bool S1_ptw_translate(CPUARMState *env, S1Translate *ptw,
> > >          S1Translate s2ptw = {
> > >              .in_mmu_idx = s2_mmu_idx,
> > >              .in_ptw_idx = ptw_idx_for_stage_2(env, s2_mmu_idx),
> > > -            .in_secure = s2_mmu_idx == ARMMMUIdx_Stage2_S,
> > > -            .in_space = (s2_mmu_idx == ARMMMUIdx_Stage2_S ? ARMSS_Secure
> > > -                         : space == ARMSS_Realm ? ARMSS_Realm
> > > -                         : ARMSS_NonSecure),
> > > +            .in_secure = is_secure,
> > > +            .in_space = space,
> >
> > If the problem is fe4a5472ccd6 then this seems an odd change to
> > be making, because in_secure and in_space were set that way
> > before that commit too...
>
> I think that commit merged both sides of the
> "regime_is_stage2(s2_mmu_idx)" test, but only kept testing for secure
> through ARMMMUIdx_Stage2_S, and removed the test through ARMMMUIdx_Phys_S

Yes, I agree. I'm not sure your proposed fix is the right one,
though. I need to re-work through what I did in fcc0b0418fff
to remind myself of what the various fields in a S1Translate
struct are supposed to be, but I think .in_secure (and now
.in_space) are supposed to always match .in_mmu_idx, and
that's not necessarily the same as what the local is_secure
holds. (is_secure is the original ptw's in_secure, which
matches that ptw's .in_mmu_idx, not its .in_ptw_idx.)
So probably the right thing for the .in_secure check is
to change to "(s2_mmu_idx == ARMMMUIdx_Stage2_S ||
s2_mmu_idx == ARMMMUIdx_Phys_S)". Less sure about .in_space,
because that conditional is a bit more complicated.

thanks
-- PMM

