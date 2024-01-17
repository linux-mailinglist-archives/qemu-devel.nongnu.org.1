Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AF3830085
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 08:30:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ0Mj-0007vr-Jw; Wed, 17 Jan 2024 02:29:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rQ0Mh-0007va-J4
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 02:29:35 -0500
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rQ0Mf-00067g-I9
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 02:29:35 -0500
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-42a0fa5d202so1949481cf.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 23:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705476572; x=1706081372; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bdd8Jwi6Hv2mLPGzvgSH5lI919mxdqkjHNsqB7gue9c=;
 b=GtY0miuVOgAQFFbyggmKMWD2L40UCD1StV+6QijCxDaZOiOdiBDWXeG0hxVdRq4Iok
 bG24eYUIHRmvmwZ3V1kSCnw01kRl62kBebqoiHh5NnjcupBxiwK48Y8JwWVTnJ3u0j70
 9qIPWRXCG4J1lLTJXTog2iFQ5hKKD2Q0qmG8G7OTAlS7nQgUpPTv7KPtCxX/O61cwz64
 pDq3oJZnZeNqT2H0PLUJziakgH7tKSmwYI2r5IPlqW4YseZVNc1Wu1YwObWZTF3I6s17
 MdLpPTKWojyjPOdzZBLcSgLNZmEFHW3lz3TwsokaT+ThJoc7rEx/dgr9GdAXrMPaI+/y
 EFOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705476572; x=1706081372;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bdd8Jwi6Hv2mLPGzvgSH5lI919mxdqkjHNsqB7gue9c=;
 b=vv3vTnvDU3T5nmjBMxN2WICIY+LWu9nN46ocA7ekA35hANbT4HMcqf3fYZkQ5QuERh
 mWK/aAZhL3IiZWlhm0gDYho0htgCCEdMEJ3LbW5vGxTl5dYoaidS8H1JG+07Wgkzw6ja
 2gw6xy/ZBNPjhDM39sErHYAaSgcuUv8bDnqft0rve+Gpv7ltGFTZknxZYHGIs5N3IHE6
 YwGeQP40qN+g2yS/4hK4vKZZID5sqdO15FMytwUwKcX7Il15s2nY75uHsSGpkZvPcmuy
 P92KMFhzvk/OrIEl8bky3dCyLsMLaMbQ0XYBLwu933CHUm5dAuza6l05i4SKDz9us9eN
 QQZQ==
X-Gm-Message-State: AOJu0YyWBqr/O5DzqrOXjJJAOq/T5tpG6vYuvYqUK3DCRMId2Gso83oK
 f8pH7zIoNAvSimWWoPPMIuzkODZQxRHZDJqy0Oo=
X-Google-Smtp-Source: AGHT+IGtwzduZdQ4Fl16MKHzShEu4V09f5yWy/sNCWafBgI+3XeKUrUh9HhdcH+va29oRZlGpLChiqrvehcVY8XDhO0=
X-Received: by 2002:a05:622a:389:b0:429:e336:b2d8 with SMTP id
 j9-20020a05622a038900b00429e336b2d8mr6489108qtx.71.1705476572426; Tue, 16 Jan
 2024 23:29:32 -0800 (PST)
MIME-Version: 1.0
References: <20240117-asan-v2-1-26f9e1ea6e72@daynix.com>
 <CAJ+F1CK54eMkcUOm6Usomsrf=wp3dZQy33wn=47Emp3JTMKc-A@mail.gmail.com>
In-Reply-To: <CAJ+F1CK54eMkcUOm6Usomsrf=wp3dZQy33wn=47Emp3JTMKc-A@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 17 Jan 2024 11:29:21 +0400
Message-ID: <CAJ+F1CLHiGUsFmXKoFZaTTUJZYN0rj73+QMM5MnXTc3ai9mJhg@mail.gmail.com>
Subject: Re: [PATCH v2] coroutine-ucontext: Save fake stack for pooled
 coroutine
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Lingfeng Yang <lfy@google.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::829;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x829.google.com
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

Hi

On Wed, Jan 17, 2024 at 11:26=E2=80=AFAM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi
>
> On Wed, Jan 17, 2024 at 11:06=E2=80=AFAM Akihiko Odaki <akihiko.odaki@day=
nix.com> wrote:
> >
> > Coroutine may be pooled even after COROUTINE_TERMINATE if
> > CONFIG_COROUTINE_POOL is enabled and fake stack should be saved in
> > such a case to keep AddressSanitizerUseAfterReturn working. Even worse,
> > I'm seeing stack corruption without fake stack being saved.
> >
> > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > ---
> > Changes in v2:
> > - Added missing set_current() (Marc-Andr=C3=A9 Lureau)
> > - Added G_STATIC_ASSERT(!IS_ENABLED(CONFIG_TSAN)) (Marc-Andr=C3=A9 Lure=
au)
> > - Renamed terminate() to terminate_asan() for clarity and consistency.
> > - Changed terminate_asan() to call start_switch_fiber_asan() for
> >   consistency.
> > - Link to v1: https://lore.kernel.org/r/20240112-asan-v1-1-e330f0d0032c=
@daynix.com
> > ---
> >  util/coroutine-ucontext.c | 35 ++++++++++++++++++++++++++---------
> >  1 file changed, 26 insertions(+), 9 deletions(-)
> >
> > diff --git a/util/coroutine-ucontext.c b/util/coroutine-ucontext.c
> > index 7b304c79d942..8ef603d081ea 100644
> > --- a/util/coroutine-ucontext.c
> > +++ b/util/coroutine-ucontext.c
> > @@ -119,13 +119,11 @@ void finish_switch_fiber(void *fake_stack_save)
> >
> >  /* always_inline is required to avoid TSan runtime fatal errors. */
> >  static inline __attribute__((always_inline))
> > -void start_switch_fiber_asan(CoroutineAction action, void **fake_stack=
_save,
> > +void start_switch_fiber_asan(void **fake_stack_save,
> >                               const void *bottom, size_t size)
> >  {
> >  #ifdef CONFIG_ASAN
> > -    __sanitizer_start_switch_fiber(
> > -            action =3D=3D COROUTINE_TERMINATE ? NULL : fake_stack_save=
,
> > -            bottom, size);
> > +    __sanitizer_start_switch_fiber(fake_stack_save, bottom, size);
> >  #endif
> >  }
> >
> > @@ -165,7 +163,7 @@ static void coroutine_trampoline(int i0, int i1)
> >      if (!sigsetjmp(self->env, 0)) {
> >          CoroutineUContext *leaderp =3D get_ptr_leader();
> >
> > -        start_switch_fiber_asan(COROUTINE_YIELD, &fake_stack_save,
> > +        start_switch_fiber_asan(&fake_stack_save,
> >                                  leaderp->stack, leaderp->stack_size);
> >          start_switch_fiber_tsan(&fake_stack_save, self, true); /* true=
=3Dcaller */
> >          siglongjmp(*(sigjmp_buf *)co->entry_arg, 1);
> > @@ -226,8 +224,7 @@ Coroutine *qemu_coroutine_new(void)
> >
> >      /* swapcontext() in, siglongjmp() back out */
> >      if (!sigsetjmp(old_env, 0)) {
> > -        start_switch_fiber_asan(COROUTINE_YIELD, &fake_stack_save, co-=
>stack,
> > -                                co->stack_size);
> > +        start_switch_fiber_asan(&fake_stack_save, co->stack, co->stack=
_size);
> >          start_switch_fiber_tsan(&fake_stack_save,
> >                                  co, false); /* false=3Dnot caller */
> >
> > @@ -269,10 +266,28 @@ static inline void valgrind_stack_deregister(Coro=
utineUContext *co)
> >  #endif
> >  #endif
> >
> > +#if defined(CONFIG_ASAN) && defined(CONFIG_COROUTINE_POOL)
> > +static void coroutine_fn terminate_asan(void *opaque)
> > +{
> > +    CoroutineUContext *to =3D DO_UPCAST(CoroutineUContext, base, opaqu=
e);
> > +
> > +    set_current(opaque);
> > +    start_switch_fiber_asan(NULL, to->stack, to->stack_size);
> > +    G_STATIC_ASSERT(!IS_ENABLED(CONFIG_TSAN));
> > +    siglongjmp(to->env, COROUTINE_ENTER);
> > +}
> > +#endif
> > +
> >  void qemu_coroutine_delete(Coroutine *co_)
> >  {
> >      CoroutineUContext *co =3D DO_UPCAST(CoroutineUContext, base, co_);
> >
> > +#if defined(CONFIG_ASAN) && defined(CONFIG_COROUTINE_POOL)
> > +    co_->entry_arg =3D qemu_coroutine_self();
> > +    co_->entry =3D terminate_asan;
> > +    qemu_coroutine_switch(co_->entry_arg, co_, COROUTINE_ENTER);
> > +#endif
> > +
> >  #ifdef CONFIG_VALGRIND_H
> >      valgrind_stack_deregister(co);
> >  #endif
> > @@ -305,8 +320,10 @@ qemu_coroutine_switch(Coroutine *from_, Coroutine =
*to_,
> >
> >      ret =3D sigsetjmp(from->env, 0);
> >      if (ret =3D=3D 0) {
> > -        start_switch_fiber_asan(action, &fake_stack_save, to->stack,
> > -                                to->stack_size);
> > +        start_switch_fiber_asan(IS_ENABLED(CONFIG_COROUTINE_POOL) ||
> > +                                action !=3D COROUTINE_TERMINATE ?
> > +                                    &fake_stack_save : NULL,
> > +                                to->stack, to->stack_size);
>
> given that the coroutine is reentered on delete to clear the fake
> stack, can we just pass &fake_stack_save here?
>

Ah, terminate_asan() is only called when the pool is enabled.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>




--=20
Marc-Andr=C3=A9 Lureau

