Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDAA75C282
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 11:09:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMm7e-0001sg-P7; Fri, 21 Jul 2023 05:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1qMm7c-0001s9-85
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 05:08:24 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1qMm7a-0006Kl-Gi
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 05:08:24 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fbef8ad9bbso15055395e9.0
 for <qemu-devel@nongnu.org>; Fri, 21 Jul 2023 02:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689930501; x=1690535301;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tXIcYzdjDyy1XFml4B0cFbaDdW32iu3U6rR5Cpot3Ig=;
 b=vzbUxzL51qFikedb8eCc/ToB1aTV7vL4/GW2xscrFe8S9lVPS+qyLZWD4zqWFnRVuX
 vtpAGvuEWJ5G1EkzBMakv87JjOeXcN89yhDFttwg2gYyZt8x2SKSoKylAGVBFh7jOCcB
 C0oJWqfHKJ0GssJ5qMcmJPnL3P7GtuCJXJNwY/Rj5aM8GS9MakYLu84XV4IYSomAetom
 m1A8pu3UEjnu/07ArNqu1//Zso+KS4ME6hF0zHuAY/y/zBKOt1XN4nC2dGD6XanEuuMZ
 5OsZBdpWs02qUaG2ITYmKq8a+0b/6JMLT/22SuJ49yYBc0b2tcCcwTq/0lnw8QAIf8Hp
 TOQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689930501; x=1690535301;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tXIcYzdjDyy1XFml4B0cFbaDdW32iu3U6rR5Cpot3Ig=;
 b=KYCMpbOsASv+7QwxNlXFiyAVhhRaisnmLi2xdGc7QfeR/MEMcvTKNJISWXsviefDbN
 coarrQdpw9TpmfwWK++gaA9y6Bn+JGCN2aqZHZzCLtcQZVtJ+D0l6btYR3SQ7gDsta0G
 2QsE2FBdTatowPpAjc8BA/FV7PVJjOgrgMQEpWJ5xV+KkVSnbj29qKQRZyF5a5nLOb/m
 3qyJ97YcpfwZNCihrJqX/tDnL6TMF7BAFmxRCfqX5VABuDKSLDUTnlkfCbLhyCGcLXeW
 BvCFZ1nrYcbfDDuUqIBPIlwE9O33KM9T4T5HIcoHlFD3PkXM6XQJ+6+7jw0zXjJRe6sV
 rlhg==
X-Gm-Message-State: ABy/qLZCMGI8nnCkrOQ2NcWfmS/Y0y84CC1XT5JKgrqgx4xcux4n91hE
 7egusEDXX6nPOGfL7mB3D6bvtrPi3CLmh7w5QUg=
X-Google-Smtp-Source: APBJJlFAHJQjepACUymK4HWTsnqAvDyh5mQZbtgKSOGZwuBGo96euZZMY4p40Av5YGhZG9gBvP5ZGw==
X-Received: by 2002:a05:600c:204:b0:3fb:e1ed:7f83 with SMTP id
 4-20020a05600c020400b003fbe1ed7f83mr901544wmi.33.1689930501144; 
 Fri, 21 Jul 2023 02:08:21 -0700 (PDT)
Received: from myrica ([2.219.138.198]) by smtp.gmail.com with ESMTPSA id
 c16-20020a7bc010000000b003fbe36a4ce6sm5829157wmb.10.2023.07.21.02.08.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jul 2023 02:08:20 -0700 (PDT)
Date: Fri, 21 Jul 2023 10:08:24 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: richard.henderson@linaro.org, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: Re: [PATCH 3/5] target/arm: Skip granule protection checks for AT
 instructions
Message-ID: <20230721090824.GB778079@myrica>
References: <20230719153018.1456180-2-jean-philippe@linaro.org>
 <20230719153018.1456180-5-jean-philippe@linaro.org>
 <CAFEAcA8e_-r6b4iaeDUv64iydFe7iAb4Y0eObyO4tUYizcYLVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8e_-r6b4iaeDUv64iydFe7iAb4Y0eObyO4tUYizcYLVA@mail.gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x330.google.com
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

On Thu, Jul 20, 2023 at 05:39:56PM +0100, Peter Maydell wrote:
> On Wed, 19 Jul 2023 at 16:56, Jean-Philippe Brucker
> <jean-philippe@linaro.org> wrote:
> >
> > GPC checks are not performed on the output address for AT instructions,
> > as stated by ARM DDI 0487J in D8.12.2:
> >
> >   When populating PAR_EL1 with the result of an address translation
> >   instruction, granule protection checks are not performed on the final
> >   output address of a successful translation.
> >
> > Rename get_phys_addr_with_secure(), since it's only used to handle AT
> > instructions.
> >
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> > This incidentally fixes a problem with AT S1E1 instructions which can
> > output an IPA and should definitely not cause a GPC.
> > ---
> >  target/arm/internals.h | 25 ++++++++++++++-----------
> >  target/arm/helper.c    |  8 ++++++--
> >  target/arm/ptw.c       | 11 ++++++-----
> >  3 files changed, 26 insertions(+), 18 deletions(-)
> >
> > diff --git a/target/arm/internals.h b/target/arm/internals.h
> > index 0f01bc32a8..fc90c364f7 100644
> > --- a/target/arm/internals.h
> > +++ b/target/arm/internals.h
> > @@ -1190,12 +1190,11 @@ typedef struct GetPhysAddrResult {
> >  } GetPhysAddrResult;
> >
> >  /**
> > - * get_phys_addr_with_secure: get the physical address for a virtual address
> > + * get_phys_addr: get the physical address for a virtual address
> >   * @env: CPUARMState
> >   * @address: virtual address to get physical address for
> >   * @access_type: 0 for read, 1 for write, 2 for execute
> >   * @mmu_idx: MMU index indicating required translation regime
> > - * @is_secure: security state for the access
> >   * @result: set on translation success.
> >   * @fi: set to fault info if the translation fails
> >   *
> > @@ -1212,26 +1211,30 @@ typedef struct GetPhysAddrResult {
> >   *  * for PSMAv5 based systems we don't bother to return a full FSR format
> >   *    value.
> >   */
> > -bool get_phys_addr_with_secure(CPUARMState *env, target_ulong address,
> > -                               MMUAccessType access_type,
> > -                               ARMMMUIdx mmu_idx, bool is_secure,
> > -                               GetPhysAddrResult *result, ARMMMUFaultInfo *fi)
> > +bool get_phys_addr(CPUARMState *env, target_ulong address,
> > +                   MMUAccessType access_type, ARMMMUIdx mmu_idx,
> > +                   GetPhysAddrResult *result, ARMMMUFaultInfo *fi)
> >      __attribute__((nonnull));
> 
> 
> What is going on in this bit of the patch ? We already
> have a prototype for get_phys_addr() with a doc comment.
> Is this git's diff-output producing something silly
> for a change that is not logically touching get_phys_addr()'s
> prototype and comment at all?

I swapped the two prototypes in order to make the new comment for
get_phys_addr_with_secure_nogpc() more clear. Tried to convey that
get_phys_addr() is the normal function and
get_phys_addr_with_secure_nogpc() is special. So git is working as
expected and this is a style change, I can switch them back if you prefer.

Thanks,
Jean

> 
> >  /**
> > - * get_phys_addr: get the physical address for a virtual address
> > + * get_phys_addr_with_secure_nogpc: get the physical address for a virtual
> > + *                                  address
> >   * @env: CPUARMState
> >   * @address: virtual address to get physical address for
> >   * @access_type: 0 for read, 1 for write, 2 for execute
> >   * @mmu_idx: MMU index indicating required translation regime
> > + * @is_secure: security state for the access
> >   * @result: set on translation success.
> >   * @fi: set to fault info if the translation fails
> >   *
> > - * Similarly, but use the security regime of @mmu_idx.
> > + * Similar to get_phys_addr, but use the given security regime and don't perform
> > + * a Granule Protection Check on the resulting address.
> >   */
> > -bool get_phys_addr(CPUARMState *env, target_ulong address,
> > -                   MMUAccessType access_type, ARMMMUIdx mmu_idx,
> > -                   GetPhysAddrResult *result, ARMMMUFaultInfo *fi)
> > +bool get_phys_addr_with_secure_nogpc(CPUARMState *env, target_ulong address,
> > +                                     MMUAccessType access_type,
> > +                                     ARMMMUIdx mmu_idx, bool is_secure,
> > +                                     GetPhysAddrResult *result,
> > +                                     ARMMMUFaultInfo *fi)
> >      __attribute__((nonnull));
> 
> thanks
> -- PMM

