Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 298DE83926E
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 16:17:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSIWI-0006Zp-Bc; Tue, 23 Jan 2024 10:16:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manolodemedici@gmail.com>)
 id 1rSIWD-0006ZD-Eq
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 10:16:53 -0500
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manolodemedici@gmail.com>)
 id 1rSIWB-0003Vb-Nh
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 10:16:53 -0500
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-361af86c7f7so10357735ab.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 07:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706023010; x=1706627810; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f9lG+Y3I12WetBQ37KyI8fUwy+yGRZ4sEnJv/LjJ0Jk=;
 b=gGtUIw6FI+WL+m9+mfkU7ArBWWTwQ+KRsVs37J9ybhbBvBbi+13XNpyJEaOds0bXAW
 NFY5RZNKHzBu1qLOgbIN/A+hmCxRmm15v/ZfLKu/BGZWd0Rxm0js8wchcqJboCULmkFT
 JWkDvxIj4sG1dckEV8mQbZXgpQ6oDVkTnAQNckRFxn5g+b+LlfNlgvN+e6Fy953uFA6O
 W9wug2wZ+jJt4787MRzYlTq+IK6H8hCG48VF6GzuGtKy6DNg2aEgU54b2B+tid8qmqKq
 qBrbFu8dcchPmebJsgSizrsxEz58W/WciG1Adk/OXhs33nd5yDvJhj+XOJ0A/CLqBUDm
 CFmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706023010; x=1706627810;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f9lG+Y3I12WetBQ37KyI8fUwy+yGRZ4sEnJv/LjJ0Jk=;
 b=Yx6gLJnAyyglU5UJxmbga4Cg3t8qdWcBE57ESIcCsv6ZaGADuw7LlwiqU61um1g4el
 rVQQfq/nVXG1JOT+XySQ4+cIPeozk2bMA094Nr451QCurrHifsMz988wVRWM53YKYpwW
 NwLSyTBBt5kfPqvrJk5xpi3jTMfd7ByTbLL9D1sPmM7RJ1XXdLRkyYNB9Fq+wWlzn235
 oTny+nwgiTnZv9cxGtCgGmSA6/+D9xMDxQPMrig3hzAqRP0G5IxQXl/xzlib6ggQx5g+
 ZJ1Cx92wN6mjvEEg0NY7uYSJ9k+IbHpv/dEvhG6BKiY7Dfv/jsTQqMsmpHk8YFu5fj/G
 cMBA==
X-Gm-Message-State: AOJu0YxOQNhCYDCWHv+Fz+kYcs+REqX3mgFh3KSwMsUiSHpDwuHis7JL
 wTDhsA7oacjU8V69lDf/ttyDEr65Sse7Na6p/GOc4effgNj6I5qLf86LAcWXYCAFRMgb7hmxAlR
 M+jHzLpvJxgvXi2ekHpItay/+hn4=
X-Google-Smtp-Source: AGHT+IFsnfG42Vk8LuyY+yt5+cFiS91uhcRKaMLlHPKvGw1QyzK8V6kGnSjk+qJ4ZzgBG/pJ5IkkqrdZc7+rms2ADL8=
X-Received: by 2002:a92:c146:0:b0:35f:b2f4:506b with SMTP id
 b6-20020a92c146000000b0035fb2f4506bmr6723630ilh.17.1706023010062; Tue, 23 Jan
 2024 07:16:50 -0800 (PST)
MIME-Version: 1.0
References: <CAHP40mmk4cPk6ZHETfq5BtQxK63A6PiuCKrvv4yyOPBxVTW+OQ@mail.gmail.com>
 <Za6lUaLwYm1Y4gvj@redhat.com>
 <CAFEAcA--TgOV0rQ0x6UHG2d-DO=c6jsbgmgYNXcNorh_EJ+qzA@mail.gmail.com>
In-Reply-To: <CAFEAcA--TgOV0rQ0x6UHG2d-DO=c6jsbgmgYNXcNorh_EJ+qzA@mail.gmail.com>
From: Manolo de Medici <manolodemedici@gmail.com>
Date: Tue, 23 Jan 2024 16:16:43 +0100
Message-ID: <CAHP40mn25JM6FQBBUu=ywBB5BnXXkR4VKwB6uNXCd5YKG=o+zQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] Include new arbitrary limits if not already defined
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, bug-hurd@gnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::12b;
 envelope-from=manolodemedici@gmail.com; helo=mail-il1-x12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon, Jan 22, 2024 at 6:40=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Mon, 22 Jan 2024 at 17:27, Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
> >
> > On Thu, Jan 18, 2024 at 05:02:23PM +0100, Manolo de Medici wrote:
> > > qemu uses the PATH_MAX and IOV_MAX constants extensively
> > > in the code. Define these constants to sensible values ourselves
> > > if the system doesn't define them already.
> >
> > Please give details of what platform(s) lack these constants
> > in the commit message.
> >
> > Presumably this is a platform that is outside of our normal
> > support build target list, since we have at least build
> > coverage for everything mainstream.
>
> It's GNU Hurd. The patchset isn't threaded, but the cover
> letter is
> https://lore.kernel.org/qemu-devel/CAHP40m=3DUQ=3DF1-Vy4-wR18RjqzF9o+8UOj=
gpUsrTU8QXn=3D7eAeA@mail.gmail.com/
>
> and you can pick up the other patches in it by searching the list.
>
> > >
> > > Signed-off-by: Manolo de Medici <manolo.demedici@gmail.com>
> > > ---
> > >  include/qemu/osdep.h | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> > > index 9a405bed89..9fb6ac5c64 100644
> > > --- a/include/qemu/osdep.h
> > > +++ b/include/qemu/osdep.h
> > > @@ -363,6 +363,14 @@ void QEMU_ERROR("code path is reachable")
> > >  #define TIME_MAX TYPE_MAXIMUM(time_t)
> > >  #endif
> > >
> > > +#ifndef PATH_MAX
> > > +#define PATH_MAX 1024
> > > +#endif
> > > +
> > > +#ifndef IOV_MAX
> > > +#define IOV_MAX 1024
> > > +#endif
> >
> > If we're going to add this, since we should be removing the
> > later duplication:
> >
> >   #define IOV_MAX 1024
> >
> > in this same file
>
> Mmm, I wondered about that, although in that case it's
> "for when the host has no iov implementation at all
> and we're rolling our own".
>
> thanks
> -- PMM

I think that although the two cover different cases, in order for the
patch to be correct we should indeed remove the later duplication,
otherwise compilation will fail on systems lacking IOVEC. Thank you
both for the review

