Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC8B7D6420
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 09:54:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvYi5-0003rX-KP; Wed, 25 Oct 2023 03:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qvYi3-0003r8-2t
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:53:47 -0400
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qvYi1-0000xd-H0
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:53:46 -0400
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-41ccd38eaa5so4980041cf.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 00:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698220424; x=1698825224; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TwLlBeaFbzuIZ3zL7LYVmQnizB1iiUNhwx6rlFCD9e4=;
 b=PX3pdON947qHm56h7yjVJjB3Do4l0/9ETjjVp4OdNVML7RX583MmMhOrIx/GpJytuB
 8sQnlfv/Ew+yDq88CQMEE4QqkOW92VrlbJUKbhXOK6lsmy+yXk0UXGjdpErf8slXLc1g
 9am5WGYiFMju5Qir3IqzEtJT/sBrQXPeJwNOfayo01+9MkSXgpsXlzGMLbSYNX1albSd
 5fsvjkXn1kFRK0NLf7IvmxYmGP8V0Ej92ljk3g50gdnNMHIewsTyScrLO7OlIEEGNBAy
 XwqtQJcyCmG6GEDhpaRGdjQ9v2b9CPLpOIeQaqqhLzT8zL3oufirPYC8iOiFag72OFky
 UtMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698220424; x=1698825224;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TwLlBeaFbzuIZ3zL7LYVmQnizB1iiUNhwx6rlFCD9e4=;
 b=FC8W9B5U1D58LzTEOQWqhzBnRzI9RZyDOzzk7tSFj++XrEVrv+JvtsLIJ+YtOmp6pW
 CZ49i+1/VymxeRB+cARhqXryHOJSdMvDVj8z167nwuqMOrra1F6tpFlhLrADgbg6U9SH
 X1PsMCwQK2woNfkzI0XKTviImSS0LhF35J/i0xYMy1JP+JY2srNCWlPtu/SfB7BnAFWw
 reZNcZEk2k5d4fpLR1qzwqdx5FOUiOgQ7gX5C1d82ppUggbHcT49CAOgQFuj57yNcXZS
 nR6rC937GhZ0uSc1pbvpuYxV9aZh89g/4zTrc+dZS8sNiwFmjRQ2UtS3C2R5V/bC/4eS
 o3NA==
X-Gm-Message-State: AOJu0YxjsU1CSQeSNCHgmmimliNjou8MUZlLKYqOgcybNYb7DystTKhz
 QtJjC9nBXX6Jydxgr+D3UowvIVq0nypuCv8zdfk=
X-Google-Smtp-Source: AGHT+IGx99jbLDFC7eDgxbkUYcNEhOF/6UT24mKpE9NSiZVSn4xZMrX4/fHpBL9GhV4s773lOBEb20bb5WPR1alzKqs=
X-Received: by 2002:a05:622a:1447:b0:417:fe21:b254 with SMTP id
 v7-20020a05622a144700b00417fe21b254mr21695828qtx.18.1698220424249; Wed, 25
 Oct 2023 00:53:44 -0700 (PDT)
MIME-Version: 1.0
References: <20231012104448.1251039-1-mironov@fintech.ru>
 <CAMxuvazb=kfGHoSxs7J95t9i_OGNdd_oTOmGgHe3hMYk2EwoOA@mail.gmail.com>
 <8963b4b9de39416db776fcf9c96f348a@fintech.ru>
In-Reply-To: <8963b4b9de39416db776fcf9c96f348a@fintech.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 25 Oct 2023 11:53:32 +0400
Message-ID: <CAJ+F1C+6+_Qfa7aNyLg3snoO-cYJvD2-17by1PWGGDWg39jyPQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] ui: Replacing pointer in function
To: =?UTF-8?B?0JzQuNGA0L7QvdC+0LIg0KHQtdGA0LPQtdC5INCS0LvQsNC00LjQvNC40YDQvtCy0LjRhw==?=
 <mironov@fintech.ru>
Cc: "kraxel@redhat.com" <kraxel@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 Linux Verification Center <sdl.qemu@linuxtesting.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82d;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Oct 25, 2023 at 11:42=E2=80=AFAM =D0=9C=D0=B8=D1=80=D0=BE=D0=BD=D0=
=BE=D0=B2 =D0=A1=D0=B5=D1=80=D0=B3=D0=B5=D0=B9 =D0=92=D0=BB=D0=B0=D0=B4=D0=
=B8=D0=BC=D0=B8=D1=80=D0=BE=D0=B2=D0=B8=D1=87
<mironov@fintech.ru> wrote:
>
> Hello! Is there any progress on this patch?

I queued it, waiting for the freeze (in 2w) to focus on bug fixes.

thanks

>
> ________________________________
> =D0=9E=D1=82: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> =D0=9E=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=BE: 16 =D0=BE=
=D0=BA=D1=82=D1=8F=D0=B1=D1=80=D1=8F 2023 =D0=B3. 15:23:42
> =D0=9A=D0=BE=D0=BC=D1=83: =D0=9C=D0=B8=D1=80=D0=BE=D0=BD=D0=BE=D0=B2 =D0=
=A1=D0=B5=D1=80=D0=B3=D0=B5=D0=B9 =D0=92=D0=BB=D0=B0=D0=B4=D0=B8=D0=BC=D0=
=B8=D1=80=D0=BE=D0=B2=D0=B8=D1=87
> =D0=9A=D0=BE=D0=BF=D0=B8=D1=8F: kraxel@redhat.com; qemu-devel@nongnu.org;=
 Linux Verification Center
> =D0=A2=D0=B5=D0=BC=D0=B0: Re: [PATCH 1/1] ui: Replacing pointer in functi=
on
>
> On Thu, Oct 12, 2023 at 2:46=E2=80=AFPM Sergey Mironov <mironov@fintech.r=
u> wrote:
> >
> > At the end of the first if we see 'vc->gfx.surface =3D NULL;',
> > further checking of it is pointless. In the second if, ectx is taken.
> >
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> >
> > Co-developed-by: Linux Verification Center <sdl.qemu@linuxtesting.org>
> > Signed-off-by: Sergey Mironov <mironov@fintech.ru>
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> > ---
> >  ui/gtk.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/ui/gtk.c b/ui/gtk.c
> > index 935de1209b..5da3f9b022 100644
> > --- a/ui/gtk.c
> > +++ b/ui/gtk.c
> > @@ -1400,7 +1400,7 @@ static void gd_menu_untabify(GtkMenuItem *item, v=
oid *opaque)
> >              eglDestroySurface(qemu_egl_display, vc->gfx.esurface);
> >              vc->gfx.esurface =3D NULL;
> >          }
> > -        if (vc->gfx.esurface) {
> > +        if (vc->gfx.ectx) {
> >              eglDestroyContext(qemu_egl_display, vc->gfx.ectx);
> >              vc->gfx.ectx =3D NULL;
> >          }
> > --
> > 2.31.1
> >
>


--=20
Marc-Andr=C3=A9 Lureau

