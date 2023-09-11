Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AD279A887
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 16:19:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfhk1-0000Bo-2O; Mon, 11 Sep 2023 10:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qfhjz-0000BR-4p
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 10:18:15 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qfhjv-0001IO-2J
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 10:18:14 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-31adc5c899fso4745855f8f.2
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 07:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694441889; x=1695046689; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CO5KUZ0HbXPAFPvyvpsqqPg5wltk7sxJyxmy2Eh0KyM=;
 b=X7aop9vWayS9AxLirlLJTzgtEHVOa3gK+nnd9XiQsRDdb6IFJ11gpAoC/3hxQk4ANh
 ULQo2Kub3PNj1p0lt2gWYr0obh9mb5XZzCCyB5iDIVsC021H/UQjh4maArbXix7dxL90
 smOmAjGAVBX4yc8pYhduQo3ZcIbkAIWY/PDxSfoCkk5lesx0dat+TYKLKgX5ey4IBw+n
 JR51r7gPy7PXwmB8w9LhcyPM4Xsw87gpNDnru+K3BLRMxQIbeXOr9MoO03fCs+LFlk/N
 pYCLLMO8fDHiXAF/Sh3SgXY9sC1y3gw55kennYJcPIyHukdpj3oOcCwjY7nMQAOPFbHK
 aRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694441889; x=1695046689;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CO5KUZ0HbXPAFPvyvpsqqPg5wltk7sxJyxmy2Eh0KyM=;
 b=bdWYLF2XcfiP5Tn8L0VKewDRuLVfj4ehq/+bsts1yxuNOoYHq4kOiyU2+9iT5pEtC5
 h7VkXP7ve2ZKKybZl8tJxP4HCmZu2MrgcavgHGD/gDBElUVTwlXlSR4I7HpiRcDPdGak
 7gc6F3+Hu0nLaWKfInYDTDYj6/U4FHwofpCKiaQa+x4zuWIjehLAveQYh0qN1sUU7/wL
 LT56ipnWBGLsm4ACh8AWpcCDDD81awbkApgE8d2w6IQ9c2SD2MFiFBVo4ZLY8/eMRi9f
 KlxVIFWn6CVMbJMdhhwZVkkHwZlcRGzmJP/ncPumWdQAxaksgHVn9Ucdde068GbLKvPq
 S70g==
X-Gm-Message-State: AOJu0Yy8GKPuYbXr2THIBYYbcauCFIVeBFG1xl54qXQE95ZQnVRbudfY
 Gc4lJ/SnZby0r052u2VLSL1rKCkhKY9yt0uBifvz2w==
X-Google-Smtp-Source: AGHT+IEKImN/Vm6UP17ufkfMv20FYSC3KU/hNfyjAkEgWJ1F+knGybQWs/3snwXSE+nZb0d8sOeEmMCFG0sDtbcdSqw=
X-Received: by 2002:a5d:6812:0:b0:317:f18b:a950 with SMTP id
 w18-20020a5d6812000000b00317f18ba950mr8175491wru.26.1694441888949; Mon, 11
 Sep 2023 07:18:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230907160340.260094-1-peter.maydell@linaro.org>
 <20230907160340.260094-12-peter.maydell@linaro.org>
 <fbc33e98-2f8e-d503-c219-20c2b6eb02d2@linaro.org>
In-Reply-To: <fbc33e98-2f8e-d503-c219-20c2b6eb02d2@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Sep 2023 15:17:57 +0100
Message-ID: <CAFEAcA8V_8wFpLJd7mNygEeU2iCdmMEZz4cXANXfwzD=FBGqkw@mail.gmail.com>
Subject: Re: [PATCH 11/14] target/arm: Implement the SETG* instructions
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sat, 9 Sept 2023 at 17:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 9/7/23 09:03, Peter Maydell wrote:
> > The FEAT_MOPS SETG* instructions are very similar to the SET*
> > instructions, but as well as setting memory contents they also
> > set the MTE tags. They are architecturally required to operate
> > on tag-granule aligned regions only.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   target/arm/internals.h         | 10 ++++
> >   target/arm/tcg/a64.decode      |  5 ++
> >   target/arm/tcg/helper-a64.c    | 92 +++++++++++++++++++++++++++++++---
> >   target/arm/tcg/mte_helper.c    | 40 +++++++++++++++
> >   target/arm/tcg/translate-a64.c | 20 +++++---
> >   5 files changed, 155 insertions(+), 12 deletions(-)
> >
> > diff --git a/target/arm/internals.h b/target/arm/internals.h
> > index a70a7fd50f6..642f77df29b 100644
> > --- a/target/arm/internals.h
> > +++ b/target/arm/internals.h
> > @@ -1300,6 +1300,16 @@ uint64_t mte_mops_probe(CPUARMState *env, uint64_t ptr, uint64_t size,
> >   void mte_check_fail(CPUARMState *env, uint32_t desc,
> >                       uint64_t dirty_ptr, uintptr_t ra);
> >
> > +/**
> > + * mte_mops_set_tags: Set MTE tags for a portion of a FEAT_MOPS operation
> > + * @env: CPU env
> > + * @dirty_ptr: Start address of memory region (dirty pointer)
> > + * @size: length of region (guaranteed not to cross page boundary)
> > + * @desc: MTEDESC descriptor word
> > + */
> > +void mte_mops_set_tags(CPUARMState *env, uint64_t dirty_ptr, uint64_t size,
> > +                       uint32_t desc);
> > +
> >   static inline int allocation_tag_from_addr(uint64_t ptr)
> >   {
> >       return extract64(ptr, 56, 4);
> > diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
> > index 8cddc207a6f..46caeb59fe5 100644
> > --- a/target/arm/tcg/a64.decode
> > +++ b/target/arm/tcg/a64.decode
> > @@ -569,3 +569,8 @@ STZ2G           11011001 11 1 ......... 11 ..... ..... @ldst_tag p=0 w=1
> >   SETP            00 011001110 ..... 00 . . 01 ..... ..... @set
> >   SETM            00 011001110 ..... 01 . . 01 ..... ..... @set
> >   SETE            00 011001110 ..... 10 . . 01 ..... ..... @set
> > +
> > +# Like SET, but also setting MTE tags
> > +SETGP           00 011101110 ..... 00 . . 01 ..... ..... @set
> > +SETGM           00 011101110 ..... 01 . . 01 ..... ..... @set
> > +SETGE           00 011101110 ..... 10 . . 01 ..... ..... @set
> > diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
> > index 73169eb0b56..96780067262 100644
> > --- a/target/arm/tcg/helper-a64.c
> > +++ b/target/arm/tcg/helper-a64.c
> > @@ -1103,6 +1103,54 @@ static uint64_t set_step(CPUARMState *env, uint64_t toaddr,
> >       return setsize;
> >   }
> >
> > +/*
> > + * Similar, but setting tags. The architecture requires us to do this
> > + * in 16-byte chunks. SETP accesses are not tag checked; they set
> > + * the tags.
> > + */
> > +static uint64_t set_step_tags(CPUARMState *env, uint64_t toaddr,
> > +                              uint64_t setsize, uint32_t data, int memidx,
> > +                              uint32_t *mtedesc, uintptr_t ra)
> > +{
> > +    void *mem;
> > +    uint64_t cleanaddr;
> > +
> > +    setsize = MIN(setsize, page_limit(toaddr));
> > +
> > +    cleanaddr = useronly_clean_ptr(toaddr);
> > +    /*
> > +     * Trapless lookup: returns NULL for invalid page, I/O,
> > +     * watchpoints, clean pages, etc.
> > +     */
> > +    mem = tlb_vaddr_to_host(env, cleanaddr, MMU_DATA_STORE, memidx);
> > +
> > +#ifndef CONFIG_USER_ONLY
> > +    if (unlikely(!mem)) {
> > +        /*
> > +         * Slow-path: just do one write. This will handle the
> > +         * watchpoint, invalid page, etc handling correctly.
> > +         * The architecture requires that we do 16 bytes at a time,
> > +         * and we know both ptr and size are 16 byte aligned.
> > +         * For clean code pages, the next iteration will see
> > +         * the page dirty and will use the fast path.
> > +         */
> > +        uint64_t repldata = data * 0x0101010101010101ULL;
> > +        cpu_stq_mmuidx_ra(env, toaddr, repldata, memidx, ra);
> > +        cpu_stq_mmuidx_ra(env, toaddr + 8, repldata, memidx, ra);
> > +        mte_mops_set_tags(env, toaddr, 16, *mtedesc);
> > +        return 16;
>
> You can use cpu_st16_mmu for one store.
>
> > @@ -1154,20 +1219,27 @@ void HELPER(setp)(CPUARMState *env, uint32_t syndrome, uint32_t mtedesc)
> >       int rd = mops_destreg(syndrome);
> >       int rs = mops_srcreg(syndrome);
> >       int rn = mops_sizereg(syndrome);
> > +    bool set_tags = mops_is_setg(syndrome);
> >       uint8_t data = env->xregs[rs];
> >       uint32_t memidx = FIELD_EX32(mtedesc, MTEDESC, MIDX);
> >       uint64_t toaddr = env->xregs[rd];
> >       uint64_t setsize = env->xregs[rn];
> >       uint64_t stagesetsize, step;
> >       uintptr_t ra = GETPC();
> > +    StepFn *stepfn = set_tags ? set_step_tags : set_step;
> >
> >       check_mops_enabled(env, ra);
> >
> >       if (setsize > INT64_MAX) {
> >           setsize = INT64_MAX;
> > +        if (set_tags) {
> > +            setsize &= ~0xf;
> > +        }
> >       }
>
> I think it would be a little better if set_tags was visible to the compiler, via inlining,
> so that all of the conditions can be folded away.

Do you mean having a separate triplet of helper functions
for setg, which then call an inline function shared with
the normal setp/setm/sete to do the actual work, rather than
passing "is this setg" via the syndrome ?

thanks
-- PMM

