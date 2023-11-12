Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D37B7E91BD
	for <lists+qemu-devel@lfdr.de>; Sun, 12 Nov 2023 18:03:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2Dr8-0001eQ-T6; Sun, 12 Nov 2023 12:02:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1r2Dr6-0001eD-8g; Sun, 12 Nov 2023 12:02:40 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1r2Dr4-0003mi-G9; Sun, 12 Nov 2023 12:02:40 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-280109daaaaso2634601a91.3; 
 Sun, 12 Nov 2023 09:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699808553; x=1700413353; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zQ/4kVMxDgVFBscaL5pK9uosa7HK5Qf+UQCYMWovAjo=;
 b=NeuwT/KPFhZ5BpMmI9KOpslAVmC9s3kgaarb0ETPIbVq+XYZjk3jaZyaAOXPxU4mau
 zB0d0yety3Bc6uzH7QtTa/g7KK78Titu2O8STnynBGSedifEbX/rxAyf4Vk2AqRqH3MV
 zzBEwAtTwBzBiY+wyft41eCDL7qtXn1tEgUUVWm0FdgWvoQHQNUa+5f6K8FzgXltF3de
 dlpUgvCVODI/uYg+treJ6ycJruSRtw4TNzOpf/wNcF2Wc+KN9rJQg2CRR0cw2r7qvifr
 8ctz51+VMoGeyzaZK/B49W1502gDX5wvfBqPAql2UKSkxgSjbi9zY+UcDX3RSrmWNn96
 hd0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699808553; x=1700413353;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zQ/4kVMxDgVFBscaL5pK9uosa7HK5Qf+UQCYMWovAjo=;
 b=AkHTqkdeu6fwIUcGFaTQcH+u0TG7WTOiYrVqgXrPNZFsI6kPbc0ZYm+HFaGdDwJZ8w
 Iv13MADWmMnHSiav8/dtlp1BM3+0NlV04AZTCd0Z49qod/tgOcRDZdt8JVzoXQZY+xNh
 ewO2HOTvRoI0lqJg3hlI5FYnWijJMwJw8brNtPq4SEVHP+F7gW04tXSsLB6wg4rmq7I/
 ZEBXPOtQe5uJbMOUFXC+xLVYEEE7pCd+BwS2j01IV+EctnQAuZfqqJNd1iz8YocqdNuP
 a0JHOuFPtiH/WRBuHRzFWgZ8D5iDIfRZC8Xs+D0+iCHMxI4Ou1OS0YJPygSv9fcAslJ+
 mzTw==
X-Gm-Message-State: AOJu0Yx6Axkf7uuf5fZugzxmlq1N56bN/AJQB5+HBDZaifJgwi6vPnDP
 ggxuj36FqzhUEcvjXXc+fGlh4HOIPKe0Q+Y4dsiw3/osPQcUOg==
X-Google-Smtp-Source: AGHT+IEedYOr8BQO6+aHN0VD63I9oVUDPmKgz/0ReWWPf3B3ktcoDFmN9US4mFCqqef8pfXa27WwXU5Spis94MleGeU=
X-Received: by 2002:a17:90b:4f45:b0:280:2935:af23 with SMTP id
 pj5-20020a17090b4f4500b002802935af23mr2735076pjb.5.1699808553051; Sun, 12 Nov
 2023 09:02:33 -0800 (PST)
MIME-Version: 1.0
References: <20231111112252.1387418-1-jcmvbkbc@gmail.com>
 <69b0cb84-329e-4636-b7a0-24ba69fa41b7@linaro.org>
In-Reply-To: <69b0cb84-329e-4636-b7a0-24ba69fa41b7@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun, 12 Nov 2023 09:02:21 -0800
Message-ID: <CAMo8BfLfqUPrpTrBGnv3rEcyyKByqA-NCP2yP0PtUr9bhH98ZQ@mail.gmail.com>
Subject: Re: [PATCH] linux-user: xtensa: fix signal delivery in FDPIC
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Sun, Nov 12, 2023 at 8:51=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 11/11/23 03:22, Max Filippov wrote:
> > In FDPIC signal handlers are passed around as FD pointers. Actual code
> > address and GOT pointer must be fetched from memory by the QEMU code
> > that implements kernel signal delivery functionality. This change is
> > equivalent to the following kernel change:
> > 9c2cc74fb31e ("xtensa: fix signal delivery to FDPIC process")
> >
> > Cc: qemu-stable@nongnu.org
> > Fixes: d2796be69d7c ("linux-user: add support for xtensa FDPIC")
> > Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> > ---
> >   linux-user/xtensa/signal.c | 28 ++++++++++++++++++++++++++--
> >   1 file changed, 26 insertions(+), 2 deletions(-)
> >
> > diff --git a/linux-user/xtensa/signal.c b/linux-user/xtensa/signal.c
> > index f5fb8b5cbebe..32dcfa522919 100644
> > --- a/linux-user/xtensa/signal.c
> > +++ b/linux-user/xtensa/signal.c
> > @@ -157,6 +157,9 @@ void setup_rt_frame(int sig, struct target_sigactio=
n *ka,
> >   {
> >       abi_ulong frame_addr;
> >       struct target_rt_sigframe *frame;
> > +    int is_fdpic =3D info_is_fdpic(((TaskState *)thread_cpu->opaque)->=
info);
> > +    abi_ulong handler =3D 0;
> > +    abi_ulong handler_fdpic_GOT =3D 0;
> >       uint32_t ra;
> >       bool abi_call0;
> >       unsigned base;
> > @@ -165,6 +168,17 @@ void setup_rt_frame(int sig, struct target_sigacti=
on *ka,
> >       frame_addr =3D get_sigframe(ka, env, sizeof(*frame));
> >       trace_user_setup_rt_frame(env, frame_addr);
> >
> > +    if (is_fdpic) {
> > +        abi_ulong funcdesc_ptr =3D ka->_sa_handler;
> > +
> > +        if (get_user_ual(handler, funcdesc_ptr)
> > +            || get_user_ual(handler_fdpic_GOT, funcdesc_ptr + 4)) {
> > +            goto give_sigsegv;
> > +        }
> > +    } else {
> > +        handler =3D ka->_sa_handler;
> > +    }
>
> This part is ok, with the last hunk, because it's taking care of the fd f=
or the handler.
>
> > @@ -185,14 +199,21 @@ void setup_rt_frame(int sig, struct target_sigact=
ion *ka,
> >       }
> >
> >       if (ka->sa_flags & TARGET_SA_RESTORER) {
> > -        ra =3D ka->sa_restorer;
> > +        if (is_fdpic) {
> > +            if (get_user_ual(ra, ka->sa_restorer)) {
> > +                unlock_user_struct(frame, frame_addr, 0);
> > +                goto give_sigsegv;
> > +            }
> > +        } else {
> > +            ra =3D ka->sa_restorer;
> > +        }
>
> This part is questionable.  It does match the kernel, so as far as that g=
oes,
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> However, it does not handle the GOT register for the restorer, like we do=
 on ARM.  That
> said, I can't find any libc sources for xtensa, or at least that aren't o=
ut of date by a

It's WIP, available at https://github.com/jcmvbkbc/uclibc-ng-xtensa
branch xtensa-1.0.44-fdpic

> decade, so I can't tell if libc *knows* the got register won't be loaded,=
 and it doesn't
> matter because it only uses the sigreturn syscall.

That's the case. AFAU the restorer field is not for public use and the func=
tion
used as a restorer by the uclibc does not care about the GOT pointer.

--=20
Thanks.
-- Max

