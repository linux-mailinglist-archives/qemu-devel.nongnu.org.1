Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E851E74A0EF
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 17:27:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHQrc-0003Ti-V8; Thu, 06 Jul 2023 11:25:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1qHQrb-0003TT-5h
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 11:25:47 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1qHQrZ-0002uM-3i
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 11:25:46 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fbca8935bfso9352615e9.3
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 08:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688657143; x=1691249143;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0j3qXaZ3Stl2FgumpbB0sgqaqFPs8Mm2Du1b4tBRrjk=;
 b=xKUIW4QWq5NScuyIPKVm9awO0hBj0XXkksH66ea5DIhj9g6VOv1FNWKAMMBiP36jlr
 KQlF2yakGEcppAB17t9p6KFIzNXcCQ+J8TmTPLl5kTZQ/DW+uQPa1K8gymmYRnJVrotL
 NNJTwxzTGNASjSegYgJ9ac7EPWHbBTW91DVDWCETIJNVOpyu/DkjWPMGqhHTZBiQk8Eb
 xO0V+1c4x8MZCDIjSirA/RfYEX9ognVg8LikxlHWVyh8jGYSs20Yqfzj02hlOHSwcTy3
 Z7dE11Nio6Y64Fw4BzuMB6hWVfYJyRfZ5ypgt2166NsOMpTyDsddl3KECF5P0Bm85A8v
 BvMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688657143; x=1691249143;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0j3qXaZ3Stl2FgumpbB0sgqaqFPs8Mm2Du1b4tBRrjk=;
 b=lGE6dZ5QUdSS6wjqrwKl1A2y1aOekJ1SGsRvLUjBqyBlHt/szCsy++SBg7qkCNG+Xt
 GMEJ25kmrAHloa2Iaj26MwMAZ2fkJsBCwjddyXaC5nH6u89cqIzQO+zrpEy36G3urenP
 T7GITAxlvy7G1Vxq98Zpcz9sbnDULmd63YzTV5UEBXi+mdARTRpu1lFJpJGeNF4KwBt1
 wS3mc0PIDg6JH+OpZi/OpyWSzBpQMDRkRNj73NmJyAtciiK8tjvba6lcGkCW49kPRGIS
 DuMMXwkITpYpnNLgzppAl9d1yF48n7GAMx9PoNVxMvkVIjj7rG0mlBFuPyH/FKHTdnO8
 Srpw==
X-Gm-Message-State: ABy/qLZyfxDh3w8U8enX3BFalU8BJAZkrkId7LAHBNk/EoFyQQOdXa9o
 KvS4CjzYt8ElVL0g3rbB62vYmA==
X-Google-Smtp-Source: APBJJlF6/bphJ54N5A805eJ2XoYKsxGoqax9s3eJbE4bjugfUw72+XZRj5Fq8T76iYPbpN4RC5yg1A==
X-Received: by 2002:a7b:ce8e:0:b0:3fb:40ec:9483 with SMTP id
 q14-20020a7bce8e000000b003fb40ec9483mr1588548wmj.16.1688657143199; 
 Thu, 06 Jul 2023 08:25:43 -0700 (PDT)
Received: from myrica ([2.219.138.198]) by smtp.gmail.com with ESMTPSA id
 c3-20020adfef43000000b003141e9e2f81sm2180265wrp.4.2023.07.06.08.25.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 08:25:43 -0700 (PDT)
Date: Thu, 6 Jul 2023 16:25:43 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: richard.henderson@linaro.org, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: Re: [PATCH] target/arm: Fix ptw parameters in S1_ptw_translate() for
 debug contexts
Message-ID: <20230706152543.GB2570588@myrica>
References: <20230706140850.3007762-2-jean-philippe@linaro.org>
 <CAFEAcA8h-VXZkD0SBrjOYg-FFVk5AW0RrAs4AL4w6RXWZzWUsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8h-VXZkD0SBrjOYg-FFVk5AW0RrAs4AL4w6RXWZzWUsQ@mail.gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, Jul 06, 2023 at 03:28:32PM +0100, Peter Maydell wrote:
> On Thu, 6 Jul 2023 at 15:12, Jean-Philippe Brucker
> <jean-philippe@linaro.org> wrote:
> >
> > Arm TF-A fails to boot via semihosting following a recent change to the
> > MMU code. Semihosting attempts to read parameters passed by TF-A in
> > secure RAM via cpu_memory_rw_debug(). While performing the S1
> > translation, we call S1_ptw_translate() on the page table descriptor
> > address, with an MMU index of ARMMMUIdx_Phys_S. At the moment
> > S1_ptw_translate() doesn't interpret this as a secure access, and as a
> > result we attempt to read the page table descriptor from the non-secure
> > address space, which fails.
> >
> > Fixes: fe4a5472ccd6 ("target/arm: Use get_phys_addr_with_struct in S1_ptw_translate")
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> > I'm not entirely sure why the semihosting parameters are accessed
> > through stage-1 translation rather than directly as physical addresses,
> > but I'm not familiar with semihosting.
> 
> The semihosting ABI says the guest code should pass "a pointer
> to the parameter block". It doesn't say explicitly, but the
> straightforward interpretation is "a pointer that the guest
> itself could dereference to read/write the values", which means
> a virtual address, not a physical one. It would be pretty
> painful for the guest to have to figure out "what is the
> physaddr for this virtual address" to pass it to the semihosting
> call.
> 
> Do you have a repro case for this bug? Did it work
> before commit fe4a5472ccd6 ?

Yes I bisected to fe4a5472ccd6 by trying to run TF-A, following
instructions here:
https://github.com/ARM-software/arm-trusted-firmware/blob/master/docs/plat/qemu.rst

Building TF-A (HEAD 8e31faa05):
make -j CROSS_COMPILE=aarch64-linux-gnu- BL33=edk2/Build/ArmVirtQemuKernel-AARCH64/DEBUG_GCC5/FV/QEMU_EFI.fd PLAT=qemu DEBUG=1 LOG_LEVEL=40 all fip

Installing it to QEMU runtime dir:
ln -sf tf-a/build/qemu/debug/bl1.bin build/qemu-cca/run/
ln -sf tf-a/build/qemu/debug/bl2.bin build/qemu-cca/run/
ln -sf tf-a/build/qemu/debug/bl31.bin build/qemu-cca/run/
ln -sf edk2/Build/ArmVirtQemuKernel-AARCH64/DEBUG_GCC5/FV/QEMU_EFI.fd build/qemu-cca/run/bl33.bin

Running QEMU with HEAD=fe4a5472cc:
qemu-system-aarch64 -M virt,secure=on -cpu max -m 1G -nographic -bios bl1.bin -semihosting-config enable=on,target=native -d guest_errors

    NOTICE:  Booting Trusted Firmware
    NOTICE:  BL1: v2.9(debug):v2.9.0-280-g8e31faa05
    NOTICE:  BL1: Built : 16:23:20, Jul  6 2023
    INFO:    BL1: RAM 0xe0ee000 - 0xe0f6000
    INFO:    BL1: Loading BL2
    WARNING: Firmware Image Package header check failed.
    Invalid read at addr 0xE0EF900, size 8, region '(null)', reason: rejected
    WARNING: Failed to obtain reference to image id=1 (-2)
    ERROR:   Failed to load BL2 firmware.

with HEAD=4a7d7702cd:
    ...
    INFO:    BL1: Loading BL2
    WARNING: Firmware Image Package header check failed.
    INFO:    Loading image id=1 at address 0xe06b000
    INFO:    Image id=1 loaded: 0xe06b000 - 0xe073201
    NOTICE:  BL1: Booting BL2
    INFO:    Entry point address = 0xe06b000
    INFO:    SPSR = 0x3c5
    ...


(Note that there is an issue with TF-A missing ENABLE_FEAT_FGT for qemu at
the moment, which prevents booting Linux with -cpu max. I'll send the fix
to TF-A after this, but this reproducer should at least boot edk2.)

> > ---
> >  target/arm/ptw.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> > index 9aaff1546a..e3a738c28e 100644
> > --- a/target/arm/ptw.c
> > +++ b/target/arm/ptw.c
> > @@ -465,10 +465,8 @@ static bool S1_ptw_translate(CPUARMState *env, S1Translate *ptw,
> >          S1Translate s2ptw = {
> >              .in_mmu_idx = s2_mmu_idx,
> >              .in_ptw_idx = ptw_idx_for_stage_2(env, s2_mmu_idx),
> > -            .in_secure = s2_mmu_idx == ARMMMUIdx_Stage2_S,
> > -            .in_space = (s2_mmu_idx == ARMMMUIdx_Stage2_S ? ARMSS_Secure
> > -                         : space == ARMSS_Realm ? ARMSS_Realm
> > -                         : ARMSS_NonSecure),
> > +            .in_secure = is_secure,
> > +            .in_space = space,
> 
> If the problem is fe4a5472ccd6 then this seems an odd change to
> be making, because in_secure and in_space were set that way
> before that commit too...

I think that commit merged both sides of the
"regime_is_stage2(s2_mmu_idx)" test, but only kept testing for secure
through ARMMMUIdx_Stage2_S, and removed the test through ARMMMUIdx_Phys_S

Thanks,
Jean


