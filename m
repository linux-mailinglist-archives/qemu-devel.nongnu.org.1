Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F19A75DFCC
	for <lists+qemu-devel@lfdr.de>; Sun, 23 Jul 2023 05:44:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNPzn-0006NK-U8; Sat, 22 Jul 2023 23:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mborgerson@gmail.com>)
 id 1qNPzl-0006Ms-D0
 for qemu-devel@nongnu.org; Sat, 22 Jul 2023 23:42:57 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mborgerson@gmail.com>)
 id 1qNPzj-0001xz-LD
 for qemu-devel@nongnu.org; Sat, 22 Jul 2023 23:42:57 -0400
Received: by mail-lf1-f53.google.com with SMTP id
 2adb3069b0e04-4fbf09a9139so4951820e87.2
 for <qemu-devel@nongnu.org>; Sat, 22 Jul 2023 20:42:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690083773; x=1690688573;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vx4Egy+zLfRed1OzuTnQu7mCpqlrb8PHUnmfSN1Ntos=;
 b=TqJiXwzvI52c/osrByyO6Gc5Y+bpSYk+V/S+fWIPiNoKbI4cdvPzFz3dY5qLoDqLPb
 CNoqzm1Z7SyQFq0WPm6YM3veAfouOGDj0vcgbKB/ue3QYxBtWBVUK2KSutO7hmrPbIYv
 EKIn9hIWC9eaMQ27oi/tJGncr+w+2JEBl/usOhZfGlB1vL7sJJkgsUbHIxKz7K0E896v
 gE054GbP+QjU8THof0pMExobLH7R5wMnfCIS/ZtF62H7E+B5G6tVIxLpGpiBTPYVUtyt
 4DtUcN3yPeLQkzZS4KWrPNnGrTdHBhRD83JFaiOTCD0guiRe2/YQ9Ol2Gg84DD3rur3x
 xqbA==
X-Gm-Message-State: ABy/qLbVNzWjznMYmeh1c2/QR7yxIupwSxR7RrbndSI1bH4cs1eXgHfC
 PLexM3bdfmsmAt6IHYgXoElujLku6BCAlu+s
X-Google-Smtp-Source: APBJJlEOfuPZDS4lWSuhqkOYuhabdnp0JWKRSc8wwkwG6cSg+wn3sJI8N6T+G98cK4XyPetuT7huOQ==
X-Received: by 2002:ac2:5bc7:0:b0:4fb:7392:c72c with SMTP id
 u7-20020ac25bc7000000b004fb7392c72cmr2826703lfn.57.1690083772628; 
 Sat, 22 Jul 2023 20:42:52 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com.
 [209.85.208.169]) by smtp.gmail.com with ESMTPSA id
 n25-20020a195519000000b004fdd91e0386sm1463152lfe.259.2023.07.22.20.42.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 22 Jul 2023 20:42:52 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id
 38308e7fff4ca-2b701e41cd3so45570791fa.3
 for <qemu-devel@nongnu.org>; Sat, 22 Jul 2023 20:42:52 -0700 (PDT)
X-Received: by 2002:a2e:93cd:0:b0:2b4:75f0:b9e9 with SMTP id
 p13-20020a2e93cd000000b002b475f0b9e9mr3493028ljh.10.1690083772161; Sat, 22
 Jul 2023 20:42:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230718013531.1669100-1-contact@mborgerson.com>
 <ffb529cb-2d73-cefd-e6b6-30c0ab7334fa@linaro.org>
In-Reply-To: <ffb529cb-2d73-cefd-e6b6-30c0ab7334fa@linaro.org>
From: Matt Borgerson <contact@mborgerson.com>
Date: Sat, 22 Jul 2023 20:42:40 -0700
X-Gmail-Original-Message-ID: <CADc=-s5eO_54nA+MD52wYxGGfNoOaVo5SPz8s4Fc4x2UMyDQtw@mail.gmail.com>
Message-ID: <CADc=-s5eO_54nA+MD52wYxGGfNoOaVo5SPz8s4Fc4x2UMyDQtw@mail.gmail.com>
Subject: Re: [PATCH] accel/tcg: Fix guest instruction address in output
 assembly log
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Matt Borgerson <contact@mborgerson.com>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.167.53; envelope-from=mborgerson@gmail.com;
 helo=mail-lf1-f53.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Sat, Jul 22, 2023 at 3:11=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 7/18/23 02:35, Matt Borgerson wrote:
> > If CF_PCREL is enabled, generated host assembly logging (command line
> > option `-d out_asm`) may incorrectly report guest instruction virtual
> > addresses as page offsets instead of absolute addresses. This patch
> > corrects the reported guest address.
> >
> > Signed-off-by: Matt Borgerson <contact@mborgerson.com>
> > ---
> >   accel/tcg/translate-all.c | 22 ++++++++++++++++++++--
> >   1 file changed, 20 insertions(+), 2 deletions(-)
> >
> > diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> > index a1782db5dd..859db95cf7 100644
> > --- a/accel/tcg/translate-all.c
> > +++ b/accel/tcg/translate-all.c
> > @@ -283,6 +283,24 @@ static int setjmp_gen_code(CPUArchState *env, Tran=
slationBlock *tb,
> >       return tcg_gen_code(tcg_ctx, tb, pc);
> >   }
> >
> > +static vaddr get_guest_insn_vaddr(TranslationBlock *tb, vaddr pc, size=
_t insn)
> > +{
> > +    g_assert(insn < tb->icount);
> > +
> > +    /* FIXME: This replicates the restore_state_to_opc() logic. */
> > +    vaddr addr =3D tcg_ctx->gen_insn_data[insn * TARGET_INSN_START_WOR=
DS];
> > +
> > +    if (tb_cflags(tb) & CF_PCREL) {
> > +        addr |=3D (pc & TARGET_PAGE_MASK);
> > +    } else {
> > +#if defined(TARGET_I386)
> > +        addr -=3D tb->cs_base;
> > +#endif
> > +    }
>
> I disagree with this.  The only bug I see is
>
> >                       "  -- guest addr 0x%016" PRIx64 " + tb prologue\n=
",
>
> "guest addr", which makes you believe this to be a guest virtual address.
>
> I think it is important to log what is actually in the data structures, w=
hich is the page
> offset.
>
> Why are you so keen to have the virtual address?  Why is this more reason=
able than the
> physical address, or anything else?
>
>
> r~

Hi Richard--

Thanks for the review.

> I disagree with this.  The only bug I see is
>
> >                       "  -- guest addr 0x%016" PRIx64 " + tb prologue\n=
",
>
> "guest addr", which makes you believe this to be a guest virtual address.

Yes, and because this was effectively the behavior of these log
messages prior to the introduction of PCREL.

> I think it is important to log what is actually in the data structures, w=
hich is the page
> offset.
>
> Why are you so keen to have the virtual address?

Printing virtual addresses with host translation allows me to plainly
see (and grep for) how translation-provoking guest instructions map to
corresponding translations without needing to cross-reference against
additional logging, in_asm or trace:translate_block for example. I
agree logging 'what is actually in the data structures' is important,
but page offset alone has limited utility when debugging translation
issues without additional logging to provide context.

> Why is this more reasonable than the physical address, or anything else?

For the same reason virtual addresses are used when logging input
block assembly, performance metrics, trace events, etc.


An oversight with this patch is that raw start words are still printed
with `OP*` log items--ideally those log items would be updated
accordingly, if that is the decision.

Ultimately I'm also fine with pulling the 'guest addr' message text
and only printing the raw start words, but would prefer not to require
extra cross-referencing. If this is the decision, feel free to drop
the patch.

Thanks,
Matt

