Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C5782EB0A
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 09:44:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPf28-0006Xs-LF; Tue, 16 Jan 2024 03:42:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rPf26-0006Xd-Vy
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 03:42:55 -0500
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rPf25-00074N-6p
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 03:42:54 -0500
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-429be9fe952so34972031cf.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 00:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705394572; x=1705999372; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sss/oRyzsTliiRU44c9pJUowXFl1yc5Z+cEfIHqlIRA=;
 b=bXQk0nQ82vI/DUB5Ox1JWwI1+jvzUnsKA9XqKCfm1XMupWRXh5EYdzYpsZKYMAEzDj
 W9dUCQiCq4Pq9+4XmB3/ncwbtd3Qq5ep0vXd4Ws9PrsGUmCWpkqFjNAh479PyszDlQRo
 FXjIned4Py90GMJsoxhBTSyAaITgX3pJZdXvVimcKvojxwv9Ued67uV9Z93AZmp6/dQT
 kgdFBETzEnyhOtO3Sha6nrqhadzv7qgY+LBW0Qqt/Gz8URMtw5W2EUNr0VL+yD9y6oxD
 i4KgSoBZwrxlqy/dHJCjAUcQZvKhy/zYVBaweYWa+QRCtA0aIkCGdUwMKxpxLfzwR773
 Cz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705394572; x=1705999372;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sss/oRyzsTliiRU44c9pJUowXFl1yc5Z+cEfIHqlIRA=;
 b=URti9qZNKZTlg/ljHujZH3bRoT57vOI3qwLlmBOkA44eaXxeHc9Q7fPAHx7Ja4CGq7
 kWcSBP9f0T7fQI6OEmAW5rfAMn/ohbgw8ZuIEmdEVYsm/AcUCGNXqQMZWAHmuupeV6kg
 aU475ToCiVa48Uu2TsYPII2IEIltzxp17HNnCuZa3k6gwmHXldMdE/saSGErnylamAAR
 CTOr3ocfQhsZqpsKfJWMVHHZ0Q5yDa8Q6FTHnI8GqrmylNxxN4ZTckx+9OudHsT3lKVJ
 WEmsaQrUysRgFYrMWshXfkxYYD4vLptUJQQI+LAdjIP7BId2Ymmgxm4tpqgs9HPj+2y6
 BzrA==
X-Gm-Message-State: AOJu0YzrC8BGunVaOlbsE3PamBB64X4qH6RjLq3EHYUuoAr210V7EVmi
 yPIg6n8I+9zeotcIdFj1kBWz0XLlTm67dxACW2A=
X-Google-Smtp-Source: AGHT+IH9B5Zb4tgWtqUTr5yUS461n6IRCXJ6Km2q89Nnm4yuO64bv0JSiCwcgxxsfYg8U21YWt+ZxeNxa9W2NwZrYJI=
X-Received: by 2002:ac8:5747:0:b0:42a:103:ab59 with SMTP id
 7-20020ac85747000000b0042a0103ab59mr1334163qtx.47.1705394571695; Tue, 16 Jan
 2024 00:42:51 -0800 (PST)
MIME-Version: 1.0
References: <20240112-asan-v1-1-e330f0d0032c@daynix.com>
 <20240115184739.GB1143584@fedora>
In-Reply-To: <20240115184739.GB1143584@fedora>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 16 Jan 2024 12:42:40 +0400
Message-ID: <CAJ+F1C+E+xXKe7eC6+KbDBZ7HHkdmuQ9sZPjk=meZLVk4Ekxbw@mail.gmail.com>
Subject: Re: [PATCH] coroutine-ucontext: Save fake stack for pooled coroutine
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Lingfeng Yang <lfy@google.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::831;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x831.google.com
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

On Mon, Jan 15, 2024 at 10:49=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.c=
om> wrote:
>
> On Fri, Jan 12, 2024 at 07:36:19PM +0900, Akihiko Odaki wrote:
> > Coroutine may be pooled even after COROUTINE_TERMINATE if
> > CONFIG_COROUTINE_POOL is enabled and fake stack should be saved in
> > such a case to keep AddressSanitizerUseAfterReturn working. Even worse,
> > I'm seeing stack corruption without fake stack being saved.
> >
> > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Thanks Akihiko, this is solving a crash when enabling ASAN!

> > ---
> >  util/coroutine-ucontext.c | 21 +++++++++++++++++++--
> >  1 file changed, 19 insertions(+), 2 deletions(-)
>
> Adding Marc-Andr=C3=A9 Lureau and Lingfeng Yang, who authored the code in
> question.

Side note:
I am surprised that commit 0aebab04b9  "configure: add --enable-tsan
flag + fiber annotations" changed code like this:
 {
 #ifdef CONFIG_ASAN
-    __sanitizer_start_switch_fiber(fake_stack_save, bottom, size);
+    __sanitizer_start_switch_fiber(
+            action =3D=3D COROUTINE_TERMINATE ? NULL : fake_stack_save,
+            bottom, size);
+#endif
+#ifdef CONFIG_TSAN
+    void *curr_fiber =3D
+        __tsan_get_current_fiber();
+    __tsan_acquire(curr_fiber);
+
+    *fake_stack_save =3D curr_fiber;
+    __tsan_switch_to_fiber(new_fiber, 0);  /* 0=3Dsynchronize */
 #endif

*fake_stack_save =3D curr_fiber:
Is TSAN compatible with ASAN ? I guess not.

It would probably help to have more explicit comments & errors if such
a case happens.

>
> Stefan
>
> >
> > diff --git a/util/coroutine-ucontext.c b/util/coroutine-ucontext.c
> > index 7b304c79d942..e62ced5d6779 100644
> > --- a/util/coroutine-ucontext.c
> > +++ b/util/coroutine-ucontext.c
> > @@ -124,8 +124,9 @@ void start_switch_fiber_asan(CoroutineAction action=
, void **fake_stack_save,
> >  {
> >  #ifdef CONFIG_ASAN
> >      __sanitizer_start_switch_fiber(
> > -            action =3D=3D COROUTINE_TERMINATE ? NULL : fake_stack_save=
,
> > -            bottom, size);
> > +        !IS_ENABLED(CONFIG_COROUTINE_POOL) && action =3D=3D COROUTINE_=
TERMINATE ?
> > +            NULL : fake_stack_save,
> > +        bottom, size);


Ok, changing back the commit from Lingfeng when coroutine pools are enabled=
.

> >  #endif
> >  }
> >
> > @@ -269,10 +270,26 @@ static inline void valgrind_stack_deregister(Coro=
utineUContext *co)
> >  #endif
> >  #endif
> >
> > +#if defined(CONFIG_ASAN) && defined(CONFIG_COROUTINE_POOL)
> > +static void coroutine_fn terminate(void *opaque)
> > +{
> > +    CoroutineUContext *to =3D DO_UPCAST(CoroutineUContext, base, opaqu=
e);
> > +
> > +    __sanitizer_start_switch_fiber(NULL, to->stack, to->stack_size);
> > +    siglongjmp(to->env, COROUTINE_ENTER);
> > +}

looking at https://github.com/llvm/llvm-project/blob/main/compiler-rt/test/=
asan/TestCases/Linux/swapcontext_annotation.cpp,
that seems correct to me to destroy the fake_stack.

However, not switching back with qemu_coroutine_switch() may create
issues: set_current() (and tsan) not being called appropriately.

Should we introduce another action like COROUTINE_DELETE?

> > +#endif
> > +
> >  void qemu_coroutine_delete(Coroutine *co_)
> >  {
> >      CoroutineUContext *co =3D DO_UPCAST(CoroutineUContext, base, co_);
> >
> > +#if defined(CONFIG_ASAN) && defined(CONFIG_COROUTINE_POOL)
> > +    co_->entry_arg =3D qemu_coroutine_self();
> > +    co_->entry =3D terminate;
> > +    qemu_coroutine_switch(co_->entry_arg, co_, COROUTINE_ENTER);
> > +#endif
> > +
> >  #ifdef CONFIG_VALGRIND_H
> >      valgrind_stack_deregister(co);
> >  #endif
> >
> > ---
> > base-commit: f614acb7450282a119d85d759f27eae190476058
> > change-id: 20240112-asan-eb695c769f40
> >
> > Best regards,
> > --
> > Akihiko Odaki <akihiko.odaki@daynix.com>
> >



--=20
Marc-Andr=C3=A9 Lureau

