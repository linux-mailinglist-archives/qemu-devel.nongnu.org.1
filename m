Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DFC7EE54E
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 17:38:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3fNd-0005cH-Tu; Thu, 16 Nov 2023 11:38:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r3fNa-0005YZ-UJ
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 11:38:10 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r3fNZ-0006ES-7l
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 11:38:10 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-9c3aec5f326so438994166b.1
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 08:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700152687; x=1700757487; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ktGhejA0i54v/J4kYe0bRHlQH8aSFbAJWN6VW2Ab7ws=;
 b=NOfmTgVcU8feKjQMn7/mvAQWrZfgpsNhw21u+VT+tfZ+DFfe1bxLUjDZs55az8KFrT
 pMcwN9rx4zmLKSaXV5P+sI4RMBIxHGAxdceGC1eK94nqAqo0w0ctIGSk4zxsvTnlXjE9
 4aVoh94q6UVUiMh1IiOkkbPHDknkddgVuoFMvX3PcUgzr5xz/vJDSwGU/YrR++e5jDQt
 9x4RRt4XNJgnlbfANOd9/3g+i6U4y3gGZ36qeAGM99hAcJ8QyKo48T4rnH0+g0cc2i5j
 83rALjb2+qVqRRV5QfNcJaEYdRt4po3PLsm9W+xomsmGZR6X6M6A/LKqnu7tFxZ1cItn
 fkOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700152687; x=1700757487;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ktGhejA0i54v/J4kYe0bRHlQH8aSFbAJWN6VW2Ab7ws=;
 b=FX1g1lsxlEAK0ZlKryyeL7V7BenU9vHu17sA5XOj7l4nQVFYqbi1iSes49HuC7jBUC
 2NeHWABrSqBLqssCm0n2yaA0tbDwj3Id33wkwMtP4c8dN6kmKrNzVyilIZVjdkVPRFG4
 G26spzLYIvM1RBsMXxkJbKY1K7xtN4Ir81XrcM4xoKTqakhfbhphikSFLNz5eAuEwhV5
 lAm+Mcx9B5iwlqu0gDlHXEyyeJJYBrEjok4MJ8Gcp1Y1B4/wRBFhqphuAelyTYGnLzht
 n4+24gbYyLFI0yq6sBYPP1VA2l3tdauXpVtzjGr38hvXfE390a3+HOZnTJBSMl7PjD+n
 J6bw==
X-Gm-Message-State: AOJu0YzwDo9SVAejblZFgvAEGjePsPLvXxqU0GptWWM9HiWcnozeVzwU
 aDcP7Cf+mUV8zNEsVpo98ZVf9N9dpo9aX12/dwtlMeqnhRCOIl1t
X-Google-Smtp-Source: AGHT+IF3JhKAcKFWwH022uLDZuHvnxXaEUUtFA6vXpojo/mxxKlMGse5YEPLRs1pm2sWpBz70EovqKHf721aYKhbsB8=
X-Received: by 2002:a17:906:4b42:b0:9dd:b919:79bf with SMTP id
 j2-20020a1709064b4200b009ddb91979bfmr1886337ejv.36.1700152686797; Thu, 16 Nov
 2023 08:38:06 -0800 (PST)
MIME-Version: 1.0
References: <20231114165404.681826-1-ben.dooks@codethink.co.uk>
 <CAFEAcA-MG+ak8+xVyqgpWqmKAryOXJtOckUmA=GysQwnpuz5SQ@mail.gmail.com>
 <78989536-e29c-4ce1-a972-36be6c70349c@codethink.co.uk>
In-Reply-To: <78989536-e29c-4ce1-a972-36be6c70349c@codethink.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Nov 2023 16:37:56 +0000
Message-ID: <CAFEAcA8vZUZBADX109gCohhxxX_mdOp6h6EEOW8VgBYE6mNYOg@mail.gmail.com>
Subject: Re: [PATCH] hw/intc/arm_gicv3: ICC_PMR_EL1 high bits should be RAZ
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62e.google.com
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

On Tue, 14 Nov 2023 at 17:23, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>
> On 14/11/2023 17:14, Peter Maydell wrote:
> > On Tue, 14 Nov 2023 at 16:54, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> >>
> >> The ICC_PMR_ELx bit msak returned from icc_fullprio_mask
> >> should technically also remove any bit above 7 as these
> >> are marked reserved (read 0) and should therefore should
> >> not be written as anything other than 0.
> >>
> >> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> >> ---
> >>   hw/intc/arm_gicv3_cpuif.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
> >> index d07b13eb27..986044df79 100644
> >> --- a/hw/intc/arm_gicv3_cpuif.c
> >> +++ b/hw/intc/arm_gicv3_cpuif.c
> >> @@ -803,7 +803,7 @@ static uint32_t icc_fullprio_mask(GICv3CPUState *cs)
> >>        * with the group priority, whose mask depends on the value of BPR
> >>        * for the interrupt group.)
> >>        */
> >> -    return ~0U << (8 - cs->pribits);
> >> +    return (~0U << (8 - cs->pribits)) & 0xff;
> >>   }
> >
> > The upper bits of ICC_PMR_ELx are defined as RES0, which has a
> > complicated technical definition which you can find in the GIC
> > architecture specification glossary. It's valid for RES0 bits to
> > be implemented as reads-as-written, which is the way our current
> > implementation works. Valid guest code should never be writing
> > any non-zero value into those bits.
>
> Yeah, got some proprietary test code that is trying write-1 and
> then assuming read-0.
>
> > What problem are you running into that you're trying to fix
> > with this patch? If our implementation misbehaves as a result
> > of letting these high bits through into cs->icc_pmr_el1 that
> > would be a good reason for making the change.
>
> See above, local test code issue.

Ah, right. That is technically bogus, but it wouldn't be
the first time test case code explored the UNPREDICTABLE
and IMPDEF reaches of the architecture :-)

Looking at our GIC code, we *will* do something wrong if the guest
writes to these high bits, because later on we do checks like
    if (cs->hppi.prio >= cs->icc_pmr_el1) {
that will do the wrong thing. So I think we do want to mask
out these high bits (being easier than trying to ignore them
later). But I think we should be consistent between the
icc and icv code paths.

So if you want to write a patch that either:
 * masks out the high bits in both icc_fullprio_mask() and
   icv_fullprio_mask()
 * clears out those high bits directly in icc_pmr_write()
(whichever you think looks nicer) I'd be happy to take that upstream.

(Currently icv_pmr_write() happens to be written in a way that
it discards those high bits as part of the deposit64() into
ich_vmcr_el2.)

thanks
-- PMM

