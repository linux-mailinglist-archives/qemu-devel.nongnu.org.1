Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4547A47FA
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 13:06:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiC5D-0006Bh-4L; Mon, 18 Sep 2023 07:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qiC5B-0006B5-19
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 07:06:25 -0400
Received: from mail-ua1-x933.google.com ([2607:f8b0:4864:20::933])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qiC59-0003R0-Eu
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 07:06:24 -0400
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-7aafa630ea2so145445241.3
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 04:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695035182; x=1695639982; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oh46n/tcXw73HMBKueaOPmURthqJ8ugZUPM692cp5fY=;
 b=murZTzSLBQmVc5Gn/bdwRPQKa0ILMbinyvwaG0gPE0ubeFae8aaoMfKTgiCzqm0JS+
 uBvYeMSopjBEDuXfFvimyBg+2veG048knkc/6ak+mJBBp73L4lwghX9BGp9V+w3y/Hiz
 46FwZLJazc5l2xbAxQmG9PYrd7/k99GwKuwoX4aoNPAS6nTfpj528aaCyPLqYIVwGF8w
 E++8tVvfemzUmlIsHNDsDmLhHS6zUTMD9pu1Vmt5boczrY0xHccvOJ0dl5i2MOvFIeNc
 geeg/9mIxAi/XZ2v1/vei0BFkOiJ48Gz88TCbzmF9U7ewyNH/EWn7ksvsxAMYNvvvOsr
 gsCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695035182; x=1695639982;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oh46n/tcXw73HMBKueaOPmURthqJ8ugZUPM692cp5fY=;
 b=aWMIwFIOJz0xLsbVd814FNyrH706r9G/RRV0nGIltHKhEax9dMYe/Uiy2F1F52XYn+
 AOVOw4qB0meMyFcB9SpdYQptfV4BjHUKw6rIwASKRpXfpPuHG2GyknGlySxfYRawMLrS
 rJ3ZCqKbgRHdeMiqmezlKqP8bG4mV+uj/hKjGadsEXbXvtEMvOYEid8aSixh+DpXMi+0
 R5/80tCvG9epx7FlzlNsrsdlRjehJiRubwmlIqS/gtCQICtz/s2C6xRWfSoeKPBh8Lir
 2tDiMGM2naxly7TYlzjP4mSVOwXUvni74/ixErEpVKjcq1MU4eZdYkDTaeyJYBxqhHMy
 PYHg==
X-Gm-Message-State: AOJu0YzNFGkFgRnJwG2ic+Z1+FF3x35FbIAnmR4SochP/F3Bl1l61NVD
 Fndz3APHdHEN69+vhp5mYc1Ce461j3i9cr8Py8g=
X-Google-Smtp-Source: AGHT+IEOdSF6W7l48HjxHpxifAqLicrMud5URbRQpWi5IltRRX90++5sLSyJxoi45QBCsp3C3nM1RSlDn6g9tsTm/A0=
X-Received: by 2002:a67:f859:0:b0:44d:5e99:74be with SMTP id
 b25-20020a67f859000000b0044d5e9974bemr7122241vsp.21.1695035182077; Mon, 18
 Sep 2023 04:06:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230915113637.2127644-1-marcandre.lureau@redhat.com>
 <0cae6d58-1476-9b92-0b48-f593b8e92ef2@tls.msk.ru>
In-Reply-To: <0cae6d58-1476-9b92-0b48-f593b8e92ef2@tls.msk.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 18 Sep 2023 15:06:10 +0400
Message-ID: <CAJ+F1C+hpx9z6+TxmPFqeFsAw_joZC881w0jPi8bOr=iZP-eag@mail.gmail.com>
Subject: Re: [PATCH] ui/gtk: fix UI info precondition
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, kraxel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::933;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ua1-x933.google.com
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

On Fri, Sep 15, 2023 at 4:46=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:
>
> 15.09.2023 14:36, marcandre.lureau@redhat.com:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > dpy_get_ui_info() shouldn't be called if the underlying GPU doesn't
> > support it.
> >
> > Before the assert() was added and the regression introduced, GTK code
> > used to get "zero" UI info, for ex with a simple VGA device. The assert
> > was added to prevent from calling when there are no console too. The
> > other display backend that calls dpy_get_ui_info() correctly checks tha=
t
> > pre-condition.
> >
> > Calling dpy_set_ui_info() is "safe" in this case, it will simply return
> > an error that can be generally ignored.
> >
> > Fixes: commit a92e7bb4c ("ui: add precondition for dpy_get_ui_info()")
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   ui/gtk.c | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> >
> > diff --git a/ui/gtk.c b/ui/gtk.c
> > index e09f97a86b..7b542da0c0 100644
> > --- a/ui/gtk.c
> > +++ b/ui/gtk.c
> > @@ -726,6 +726,10 @@ static void gd_set_ui_refresh_rate(VirtualConsole =
*vc, int refresh_rate)
> >   {
> >       QemuUIInfo info;
> >
> > +    if (!dpy_ui_info_supported(vc->gfx.dcl.con)) {
> > +        return;
> > +    }
> > +
> >       info =3D *dpy_get_ui_info(vc->gfx.dcl.con);
>
> Current dpy_ui_info_supported():
>
> bool dpy_ui_info_supported(QemuConsole *con)
> {
>      if (con =3D=3D NULL) {
>          con =3D active_console;
>      }
>      if (con =3D=3D NULL) {
>          return false;
>      }
>
>      return con->hw_ops->ui_info !=3D NULL;
> }
>
> This whole thing smells a bit wrong.  I'm not saying it *is* wrong, but
> the feeling is here.
>
> Where dpy_ui_info_supported() is called with a NULL con, so that an "acti=
ve"
> console needs to be used instead?
>
> Maybe we should instead use something like
>
>     if (!vc->gfx.dcl.con)
>
> here in gd_set_ui_refresh_rate() ?
>
> At the very least, the code is a bit, well, confusing.

I agree it's a bit confusing to have dpy_*() functions accept NULL
arguments to mean "active_console". I don't really have a good idea
what to do else. Just having "if (!vc->gfx.dcl.con)" is not quite
enough though, as we shouldn't get_ui_info() if it's not supported
(there are no errors returned then, just "invalid/zero" values).

--=20
Marc-Andr=C3=A9 Lureau

