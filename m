Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2619479174F
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 14:43:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd8uf-0000aW-JV; Mon, 04 Sep 2023 08:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qd8uU-0000ZB-T4
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 08:42:30 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qd8uR-0004VQ-Qh
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 08:42:30 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3a81154c570so697785b6e.1
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 05:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693831346; x=1694436146; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cw3HIM5514WF/cylQUG43aOl2e22OtvqyjpBZvKGGVA=;
 b=JR1bBpIPESrVg0A9gRlPmA3+74fYbFETJnZnmv9c8/dfO0PS0k7L23JusancWxUgWN
 OiRFk/jSOCZlxRjYzS/vCT3Jfqb/ziHN5V2B1op3+siikpOpuAe/5MZ+luypQdHGUX5E
 B4S6vJg7EZxguwvM15Riw7jrR3wGliM0gEqJmmOnpUp/53LUjrnMWWndV4A0+gz7Rs1d
 9DSJCaw8jmbgCWxPJqSRkjuXUR+vtA0ZOhA2HNB16SVTFNfcUL1CVTdWq/hz4BLKMvI2
 H1LuGZojOahEC8wHKtIqSJNkanOCrEdbMBXIXJKZxdqNO6cagJvczm4KJMDhGXk88lkf
 4KMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693831346; x=1694436146;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cw3HIM5514WF/cylQUG43aOl2e22OtvqyjpBZvKGGVA=;
 b=MfQxjQTsl74epNDQjdtzUtJzFeRyy8zq3Y5KzzqJqpuRoMBjNE8s6S3YdVBJkql65Z
 cZBcPJQP8i/gWS6hvoS2FWiTAZuXY+l8G7IOHAc47ESjStc2Pe+h/3EaFcRxXWK6+yk0
 mM0m89fKzkXDTzLDD8kAH8y2GWP8L+un/hqGLNKMboBP42wAlB2FwZULTCfZIW3MKOsc
 gYrEc1YwbK9No4CYveTHA+kHjozaOg/v7DT1RQxVXA82cjvVMvt2LYyRBPNqbGt8tdJA
 NB9V1mha1VpBXATQtEabO8ErHmFlJ2lk+oR+rU1qgwm01L7ir8xp2STrSOb0MDNUq9fm
 wP8A==
X-Gm-Message-State: AOJu0YxMIfVNPzz4C3HX06XasYRjKgJe4mD0kxupMFs6ixo+ABewf/HR
 ifGRhaR89I7MXgh+FRxu8c5H4M6Kkr5SXpm7YM8=
X-Google-Smtp-Source: AGHT+IExK6K4sq5iWpUcyUsLakJHUzWYLIHB8K9QbXCGN/kym8oQ+ofY/5E+SBDemqSmMw4cdElyw9PR0RUQ4uhh65M=
X-Received: by 2002:a05:6808:64a:b0:3a7:4802:c3f with SMTP id
 z10-20020a056808064a00b003a748020c3fmr8174608oih.52.1693831345957; Mon, 04
 Sep 2023 05:42:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
 <20230830093843.3531473-46-marcandre.lureau@redhat.com>
 <96a49f28-d92c-4910-9f24-b031212ccfc2@daynix.com>
In-Reply-To: <96a49f28-d92c-4910-9f24-b031212ccfc2@daynix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 4 Sep 2023 16:42:14 +0400
Message-ID: <CAJ+F1CLCeOgjpS9Wm-V7xNg9QcP8TFcWz86_f9uxsLFpRREQsw@mail.gmail.com>
Subject: Re: [PATCH 45/67] ui/vc: remove kby_put_keysym() and update function
 calls
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-oi1-x236.google.com
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

On Thu, Aug 31, 2023 at 12:59=E2=80=AFAM Akihiko Odaki <akihiko.odaki@dayni=
x.com> wrote:
>
> On 2023/08/30 18:38, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > The function calls to `kbd_put_keysym` have been updated to now call
> > `kbd_put_keysym_console` with a NULL console parameter.
> >
> > Like most console functions, NULL argument is now for the active consol=
e.
> >
> > This will allow to rename the text console functions in a consistent ma=
nner.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   include/ui/console.h |  1 -
> >   ui/console.c         | 14 ++++++------
> >   ui/curses.c          |  2 +-
> >   ui/vnc.c             | 54 ++++++++++++++++++++++---------------------=
-
> >   ui/cocoa.m           |  2 +-
> >   5 files changed, 36 insertions(+), 37 deletions(-)
> >
> > diff --git a/include/ui/console.h b/include/ui/console.h
> > index 1ccd432b4d..9c362f0e87 100644
> > --- a/include/ui/console.h
> > +++ b/include/ui/console.h
> > @@ -115,7 +115,6 @@ bool qemu_mouse_set(int index, Error **errp);
> >   void kbd_put_keysym_console(QemuTextConsole *s, int keysym);
> >   bool kbd_put_qcode_console(QemuTextConsole *s, int qcode, bool ctrl);
> >   void kbd_put_string_console(QemuTextConsole *s, const char *str, int =
len);
> > -void kbd_put_keysym(int keysym);
> >
> >   /* Touch devices */
> >   typedef struct touch_slot {
> > diff --git a/ui/console.c b/ui/console.c
> > index a98adbb1b2..6068e02928 100644
> > --- a/ui/console.c
> > +++ b/ui/console.c
> > @@ -1141,6 +1141,13 @@ void kbd_put_keysym_console(QemuTextConsole *s, =
int keysym)
> >       int c;
> >       uint32_t num_free;
> >
> > +    if (!s) {
> > +        if (!QEMU_IS_TEXT_CONSOLE(active_console)) {
> > +            return;
> > +        }
> > +        s =3D QEMU_TEXT_CONSOLE(active_console);
> > +    }
> > +
> >       switch(keysym) {
> >       case QEMU_KEY_CTRL_UP:
> >           console_scroll(s, -1);
> > @@ -1231,13 +1238,6 @@ void kbd_put_string_console(QemuTextConsole *s, =
const char *str, int len)
> >       }
> >   }
> >
> > -void kbd_put_keysym(int keysym)
> > -{
> > -    if (QEMU_IS_TEXT_CONSOLE(active_console)) {
> > -        kbd_put_keysym_console(QEMU_TEXT_CONSOLE(active_console), keys=
ym);
> > -    }
> > -}
> > -
> >   static void text_console_invalidate(void *opaque)
> >   {
> >       QemuTextConsole *s =3D QEMU_TEXT_CONSOLE(opaque);
> > diff --git a/ui/curses.c b/ui/curses.c
> > index de962faa7c..4ddbbae7cd 100644
> > --- a/ui/curses.c
> > +++ b/ui/curses.c
> > @@ -400,7 +400,7 @@ static void curses_refresh(DisplayChangeListener *d=
cl)
> >               if (keysym =3D=3D -1)
> >                   keysym =3D chr;
> >
> > -            kbd_put_keysym(keysym);
> > +            kbd_put_keysym_console(NULL, keysym);
> >           }
> >       }
> >   }
> > diff --git a/ui/vnc.c b/ui/vnc.c
> > index 92964dcc0c..1fa4456744 100644
> > --- a/ui/vnc.c
> > +++ b/ui/vnc.c
> > @@ -1945,88 +1945,88 @@ static void do_key_event(VncState *vs, int down=
, int keycode, int sym)
> >               case 0xb8:                          /* Right ALT */
> >                   break;
> >               case 0xc8:
> > -                kbd_put_keysym(QEMU_KEY_UP);
> > +                kbd_put_keysym_console(NULL, QEMU_KEY_UP);
>
> vs->vd->dcl.con should be used instead. There may be VNC connections for
> consoles other than the "active console" and in such a case
> vs->vd->dcl.con !=3D NULL. Unfortunately it seems that ui/vnc is very
> buggy in such a situation.
>

That's not how the console & VNC server code works. VNC server will
send the key event to the hw anyway. But if the active_console is
text/vc, then it also sends (some) of the key events to it. There is
no "per-client" console either, the console switch is global
(console_select()).

Anyway, this patch is quite systematic. Further complicated changes
should be done later. please ack/r-b

thanks



--=20
Marc-Andr=C3=A9 Lureau

