Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7917A751147
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 21:34:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJfaH-0002kb-SJ; Wed, 12 Jul 2023 15:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qJfa8-0002i7-GT; Wed, 12 Jul 2023 15:33:00 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qJfa5-0001mC-U9; Wed, 12 Jul 2023 15:32:59 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4fbc0314a7bso12085851e87.2; 
 Wed, 12 Jul 2023 12:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689190374; x=1691782374;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UBfjKkVTvZxhpNBb8n6s+irV5YnHf21RgUuSgLDnLRo=;
 b=Po3zqU6Y949Wg5UgDdYTVqHm6y7LH0QsdYkYyaH8MBp0uY2tn7qPdNLb4G0FlhVv0U
 Sq7dAjCla9/4M8T792DLCIAlrKp1ZmweBLc+TBa6jyyCXuK33KEtvKpvPqfpjLyNjU8a
 KNvCTzBS3zzCTKpDO1Ow37j2DB8jax1DTBSYB0tbDaDyZWIEAiEcWTuG2nQHDGFuXJzA
 +m9y/wuYgv2MVdCTxhPkx6wR3gCO/QQVQcg8ciDs+E/LoJd5TrNUnqp3ZM+8X9oRso7S
 rpVJMg+rDFJd0E10pfTnIU6fvjhh+6rkuO7x6U4MR3nFfAj02jY+craDRzt43xwX6C1n
 u9qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689190374; x=1691782374;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UBfjKkVTvZxhpNBb8n6s+irV5YnHf21RgUuSgLDnLRo=;
 b=gFDGV08JBSy0nGISyGWTPISjzmjdBSp958ekGEggB4n2PeynVyEcaQG0kuV5ArpFtO
 07lLOa5By5vs3QtXS65yg5+Si28+ohtgMtuc4VFpaYIrgZLryAU5yelomw0myj84wEpd
 ZjKQskRVyedHl/k5K08hgTmZMfJpzAhMyUGH7+YX+N+47EP4n4y+QaTmV2KElg9wSySl
 gHFayxNxspAfCZrtKH9VDeYCEhRN0nmUxxYEL7YznPHmEQUs78cqNdTLETYekbuHx/Gh
 uY6KQW8+yxuTFKVmV1VI7NMIV8tBDANGwiqmD76bFau6sLXg4bNDnXIELfu5/Afjlpqh
 yRaA==
X-Gm-Message-State: ABy/qLYl/nN+T51oNQnVe9RXy6sLofAS5RA9VECh1QpaCdfpoXAjdrlk
 jjIjFOPCu4bP/NttqDBNO2Op+/Q9CQ0kTppAt88=
X-Google-Smtp-Source: APBJJlFuutYZvhsmkgD13Enwwx4F/NzAEgJj8+Dd3DBe1HRPGu6CGAOFQJ9gaavv5XOpnCTTXxNx6olqUrSpGZcgIrY=
X-Received: by 2002:a19:e049:0:b0:4fb:89f2:594d with SMTP id
 g9-20020a19e049000000b004fb89f2594dmr15099629lfj.63.1689190373653; Wed, 12
 Jul 2023 12:32:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230609083316.24629-1-hreitz@redhat.com>
 <20230711202321.GB154686@fedora>
 <d4459ee1-bdea-bff0-ab99-b38de004c2a7@redhat.com>
 <20230712141535.GA215287@fedora>
 <ee1afad7-daef-1217-fc2f-bd540f71e420@redhat.com>
In-Reply-To: <ee1afad7-daef-1217-fc2f-bd540f71e420@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 12 Jul 2023 15:32:39 -0400
Message-ID: <CAJSP0QV-GD9NHpVtseetCvu9GezsdoVUV4wJRNbO3ZzBdMgSzg@mail.gmail.com>
Subject: Re: [PATCH] block: Fix pad_request's request restriction
To: Hanna Czenczek <hreitz@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=stefanha@gmail.com; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, 12 Jul 2023 at 10:51, Hanna Czenczek <hreitz@redhat.com> wrote:
>
> On 12.07.23 16:15, Stefan Hajnoczi wrote:
> > On Wed, Jul 12, 2023 at 09:41:05AM +0200, Hanna Czenczek wrote:
> >> On 11.07.23 22:23, Stefan Hajnoczi wrote:
> >>> On Fri, Jun 09, 2023 at 10:33:16AM +0200, Hanna Czenczek wrote:
> >>>> bdrv_pad_request() relies on requests' lengths not to exceed SIZE_MA=
X,
> >>>> which bdrv_check_qiov_request() does not guarantee.
> >>>>
> >>>> bdrv_check_request32() however will guarantee this, and both of
> >>>> bdrv_pad_request()'s callers (bdrv_co_preadv_part() and
> >>>> bdrv_co_pwritev_part()) already run it before calling
> >>>> bdrv_pad_request().  Therefore, bdrv_pad_request() can safely call
> >>>> bdrv_check_request32() without expecting error, too.
> >>>>
> >>>> There is one difference between bdrv_check_qiov_request() and
> >>>> bdrv_check_request32(): The former takes an errp, the latter does no=
t,
> >>>> so we can no longer just pass &error_abort.  Instead, we need to che=
ck
> >>>> the returned value.  While we do expect success (because the callers
> >>>> have already run this function), an assert(ret =3D=3D 0) is not much=
 simpler
> >>>> than just to return an error if it occurs, so let us handle errors b=
y
> >>>> returning them up the stack now.
> >>> Is this patch intended to silence a Coverity warning or can this be
> >>> triggered by a guest?
> >> Neither.  There was a Coverity warning about the `assert(*bytes <=3D
> >> SIZE_MAX)`, which is always true on 32-bit architectures. Regardless o=
f
> >> Coverity, Peter inquired how bdrv_check_qiov_request() would guarantee=
 this
> >> condition (as the comments I=E2=80=99ve put above the assertions say).=
  It doesn=E2=80=99t,
> >> only bdrv_check_request32() does, which I was thinking of, and just co=
nfused
> >> the two.
> > It's unclear to me whether this patch silences a Coverity warning or
> > not? You said "neither", but then you acknowledged there was a Coverity
> > warning. Maybe "was" (past-tense) means something else already fixed it
> > but I don't see any relevant commits in the git log.
>
> There was and is no fix for the Coverity warning.  I have mentioned that
> warning because the question as to why the code uses
> bdrv_check_qiov_request() came in the context of discussing it
> (https://lists.nongnu.org/archive/html/qemu-devel/2023-06/msg01809.html).
>
> I=E2=80=99m not planning on fixing the Coverity warning in the code. `ass=
ert(x
> <=3D SIZE_MAX)` to me is an absolutely reasonable piece of code, even if
> always true (on some platforms), in fact, I find it a good thing if
> asserted conditions are always true, not least because then the compiler
> can optimize them out.  I don=E2=80=99t think we should make it more comp=
licated
> to make Coverity happier.
>
> >> As the commit message says, all callers already run bdrv_check_request=
32(),
> >> so I expect this change to functionally be a no-op.  (That is why the
> >> pre-patch code runs bdrv_check_qiov_request() with `&error_abort`.)
> > Okay, this means a guest cannot trigger the assertion failure.
> >
> > Please mention the intent in the commit description: a code cleanup
> > requested by Peter and/or a Coverity warning fix, but definitely not
> > guest triggerable assertion failure.
>
> Sure!
>
> >>> I find this commit description and patch confusing. Instead of checki=
ng
> >>> the actual SIZE_MAX value that bdrv_pad_request() relies on, we use a
> >>> 32-bit offsets/lengths helper because it checks INT_MAX or SIZE_MAX (=
but
> >>> really INT_MAX, because that's always smaller on host architectures t=
hat
> >>> QEMU supports).
> >> I preferred to use a bounds-checking function that we already use for
> >> requests, and that happens to be used to limit all I/O that ends up he=
re in
> >> bdrv_pad_request() anyway, instead of adding a new specific limit.
> >>
> >> It doesn=E2=80=99t matter to me, though.  The callers already ensure t=
hat everything
> >> is in bounds, so I=E2=80=99d be happy with anything, ranging from keep=
ing the bare
> >> assertions with no checks beforehand, over specifically checking SIZE_=
MAX
> >> and returning an error then, to bdrv_check_request32().
> >>
> >> (I thought repeating the simple bounds check that all callers already =
did
> >> for verbosity would be the most robust and obvious way to do it, but n=
ow I=E2=80=99m
> >> biting myself for not just using bare assertions annotated with =E2=80=
=9CCaller must
> >> guarantee this=E2=80=9D from the start...)
> > Okay. I looked at the code more and don't see a cleanup for the overall
> > problem of duplicated checks and type mismatches (size_t vs int64_t)
> > that is appropriate for this patch.
> >
> > I'm okay with this fix, but please clarify the intent as mentioned abov=
e.
>
> I can=E2=80=99t quite fit these two paragraphs together.  It sounds like =
you
> would rather not duplicate the call to bdrv_check_request32() in
> bdrv_pad_request() and just defer to the callers on that one, and also
> address the Coverity warning in the code (instead of just ignoring it).
> So would you rather have me remove the bdrv_check_request32() and/or
> somehow address the Coverity report in the code?

No, your code change is fine as is.

I think the overall situation with bdrv_check_request() vs
bdrv_check_request32(), the mixture of size_t and int64_t (and the
ensuing complications), two different constants BDRV_MAX_LENGTH and
BDRV_REQUEST_MAX_BYTES, and the duplication of checks in multiple
functions (not just the function you're fixing) is confusing. It would
be nice to fix all that, but it's outside the scope of this patch.

Stefan

