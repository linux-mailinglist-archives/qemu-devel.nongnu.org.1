Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8181B7EAFF6
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 13:38:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2sfA-0006ya-F1; Tue, 14 Nov 2023 07:37:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r2sf8-0006yQ-N8
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 07:37:02 -0500
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r2sf6-0000Bb-Lm
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 07:37:02 -0500
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3b40d5ea323so3538458b6e.0
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 04:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699965419; x=1700570219; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0H9xAs0KmHEIcmnNnhB4/Gv5g8i+0+dfkU65x7HO6PE=;
 b=cTvn6yy1uqV4Rocqje8j+gfTAZeFEqj/GYgyIMHh0Fb0Pq+ll0udzop7pl0gfv1Pm2
 I5nN6Kw50kNX29bHQOdzBxJxTP+nmLTfzrI7pvybJXepZxOPhV3VpaTsWqIr753oj3L5
 8Izk1VVCWimmeEbpy35oKS5K3XOXkSbAwurZx15TNJTxlmM+kGO0mDiDyp3G5CGon7hQ
 qWqf5WZqxURMzQE+6TyOwvHtJtiJO5wjrgnd7JcTpcueqWwbD9jFtBA44DsqdDozICaf
 DzuEv8UUMjLxoL42fb2OxoC8usrzL7OZikHgPJJXcfPCq7PIqJx1ZQaKvhfHhw2vhiAD
 rh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699965419; x=1700570219;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0H9xAs0KmHEIcmnNnhB4/Gv5g8i+0+dfkU65x7HO6PE=;
 b=D3USm6SGBjm0orNp59ip3m9/q5b7PGV5JCrigLWFbS4PLTpLrdPH3lpk840t+dM5lS
 e7/i3ykl2lWXgAs4SVQIojdWv0duT25WATIFE4Ymv8o1OT3B2WsdHYhrltrahisjsuDH
 gqfl3qy98UqYYh+tKttdpj2D8WQ8q01UswvWvDWrBInAGLIks3lzTxHdWxhq+s2zYTcv
 jGcgtR4GurrF2aXYY31bauQ4zX7m4BD/Oz0BvyRaFxVdP4fQwoA0ZqgWmVm0ytYme1fG
 1psoo7zaEEBJnWselg4kAhHfstkFsSHoDR46745cTWW0mQPRnN7JcFEc9SyPHi+P1OX+
 dGMg==
X-Gm-Message-State: AOJu0Yxo2Ql0S4i6Q/I5mUC6Pjz608r8gb7YpW41yV0Zskgwe6p9EwwM
 +tid2fw3DgkhCXQ43o0yfom79UE9q38wR972EQU=
X-Google-Smtp-Source: AGHT+IFRF1A9TSNtK6DDz4TazQ+cz7MvHpvjGoT45/dc02hkCCnxF8IzkPcBYd7pzBxtnS8w+0GMekLdsciv7A5x0aY=
X-Received: by 2002:a05:6870:288a:b0:1f0:3fdc:5995 with SMTP id
 gy10-20020a056870288a00b001f03fdc5995mr13111598oab.50.1699965419226; Tue, 14
 Nov 2023 04:36:59 -0800 (PST)
MIME-Version: 1.0
References: <20231108022139.12503-1-admin@xutaxkamay.com>
 <20231108022139.12503-2-admin@xutaxkamay.com>
 <CAJ+F1CL=+Lwykncp83dh7SfJqB9vniAU6pKoyzLhahkaKJX01Q@mail.gmail.com>
 <5c80a8c7-7a1d-d23d-c0c0-829e99f750e1@eik.bme.hu>
In-Reply-To: <5c80a8c7-7a1d-d23d-c0c0-829e99f750e1@eik.bme.hu>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 14 Nov 2023 16:36:48 +0400
Message-ID: <CAJ+F1CLEO62xX0oDi53MJGnyK1pSiTyPEGzY3TRmzKj1V-3HGQ@mail.gmail.com>
Subject: Re: [PATCH RFC v1 1/1] ui/sdl2: clipboard sharing implementation for
 SDL
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Kamay Xutax <admin@xutaxkamay.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-oi1-x233.google.com
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

On Tue, Nov 14, 2023 at 4:27=E2=80=AFPM BALATON Zoltan <balaton@eik.bme.hu>=
 wrote:
>
> On Tue, 14 Nov 2023, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Wed, Nov 8, 2023 at 7:56=E2=80=AFPM Kamay Xutax <admin@xutaxkamay.co=
m> wrote:
> >>
> >> Signed-off-by: Kamay Xutax <admin@xutaxkamay.com>
> >> ---
> >>  include/ui/sdl2.h   |   5 ++
> >>  meson.build         |   1 +
> >>  ui/meson.build      |   1 +
> >>  ui/sdl2-clipboard.c | 147 +++++++++++++++++++++++++++++++++++++++++++=
+
> >>  ui/sdl2.c           |   8 +++
> >>  5 files changed, 162 insertions(+)
> >>  create mode 100644 ui/sdl2-clipboard.c
> >>
> >> diff --git a/include/ui/sdl2.h b/include/ui/sdl2.h
> >> index e3acc7c82a..120fe6f856 100644
> >> --- a/include/ui/sdl2.h
> >> +++ b/include/ui/sdl2.h
> >> @@ -21,6 +21,7 @@
> >>  # include <SDL_image.h>
> >>  #endif
> >>
> >> +#include "ui/clipboard.h"
> >>  #include "ui/kbd-state.h"
> >>  #ifdef CONFIG_OPENGL
> >>  # include "ui/egl-helpers.h"
> >> @@ -51,6 +52,7 @@ struct sdl2_console {
> >>      bool y0_top;
> >>      bool scanout_mode;
> >>  #endif
> >> +    QemuClipboardPeer cbpeer;
> >>  };
> >>
> >>  void sdl2_window_create(struct sdl2_console *scon);
> >> @@ -70,6 +72,9 @@ void sdl2_2d_redraw(struct sdl2_console *scon);
> >>  bool sdl2_2d_check_format(DisplayChangeListener *dcl,
> >>                            pixman_format_code_t format);
> >>
> >> +void sdl2_clipboard_handle_request(struct sdl2_console *scon);
> >> +void sdl2_clipboard_init(struct sdl2_console *scon);
> >> +
> >>  void sdl2_gl_update(DisplayChangeListener *dcl,
> >>                      int x, int y, int w, int h);
> >>  void sdl2_gl_switch(DisplayChangeListener *dcl,
> >> diff --git a/meson.build b/meson.build
> >> index 4848930680..1358d14b2e 100644
> >> --- a/meson.build
> >> +++ b/meson.build
> >> @@ -2157,6 +2157,7 @@ config_host_data.set('CONFIG_RDMA', rdma.found()=
)
> >>  config_host_data.set('CONFIG_RELOCATABLE', get_option('relocatable'))
> >>  config_host_data.set('CONFIG_SAFESTACK', get_option('safe_stack'))
> >>  config_host_data.set('CONFIG_SDL', sdl.found())
> >> +config_host_data.set('CONFIG_SDL_CLIPBOARD', sdl.found())
> >
> > 'gtk_clipboard' option is there because it has some issues with the
> > glib loop - see https://gitlab.com/qemu-project/qemu/-/issues/1150.
> >
> > Apparently this code could have similar kind of issues, since it's
> > reentering the main loop too.  it might be worth to have a similar
> > option and disclaimer...
> >
> >
> >>  config_host_data.set('CONFIG_SDL_IMAGE', sdl_image.found())
> >>  config_host_data.set('CONFIG_SECCOMP', seccomp.found())
> >>  if seccomp.found()
> >> diff --git a/ui/meson.build b/ui/meson.build
> >> index 0ccb3387ee..0cadd1a18f 100644
> >> --- a/ui/meson.build
> >> +++ b/ui/meson.build
> >> @@ -125,6 +125,7 @@ if sdl.found()
> >>    sdl_ss =3D ss.source_set()
> >>    sdl_ss.add(sdl, sdl_image, pixman, glib, files(
> >>      'sdl2-2d.c',
> >> +    'sdl2-clipboard.c',
> >>      'sdl2-input.c',
> >>      'sdl2.c',
> >>    ))
> >> diff --git a/ui/sdl2-clipboard.c b/ui/sdl2-clipboard.c
> >> new file mode 100644
> >> index 0000000000..405bb9ea8b
> >> --- /dev/null
> >> +++ b/ui/sdl2-clipboard.c
> >> @@ -0,0 +1,147 @@
> >> +/*
> >> + * SDL UI -- clipboard support
> >> + *
> >> + * Copyright (C) 2023 Kamay Xutax <admin@xutaxkamay.com>
> >> + *
> >> + * This program is free software; you can redistribute it and/or modi=
fy
> >> + * it under the terms of the GNU General Public License as published =
by
> >> + * the Free Software Foundation; either version 2 of the License, or
> >> + * (at your option) any later version.
> >> + *
> >> + * This program is distributed in the hope that it will be useful,
> >> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> >> + * General Public License for more details.
> >> + *
> >> + * You should have received a copy of the GNU General Public License
> >> + * along with this program; if not, see <http://www.gnu.org/licenses/=
>.
> >> + *
> >> + */
> >> +
> >> +#include "qemu/osdep.h"
> >> +#include "qemu/main-loop.h"
> >> +#include "ui/sdl2.h"
> >> +
> >> +static void sdl2_clipboard_update(struct sdl2_console *scon,
> >> +                                  QemuClipboardInfo *info)
> >> +{
> >> +    bool self_update =3D info->owner =3D=3D &scon->cbpeer;
> >> +    char *text;
> >> +    size_t text_size;
> >> +
> >> +    /*
> >> +     * In case of a self update,
> >> +     * set again the text in SDL
> >> +     *
> >> +     * This is a workaround for hosts that have clipboard history
> >> +     * or when they're copying again something,
> >> +     * so that SDL can accept a new request from the host
> >> +     * and make a new SDL_CLIPBOARDUPDATE event
> >> +     */
> >> +
> >> +    if (self_update) {
> >> +        text =3D SDL_GetClipboardText();
> >> +        SDL_SetClipboardText(text);
> >> +        SDL_free(text);
> >> +        return;
> >> +    }
> >
> > Isn't this basically doing the work of a clipboard manager? it takes
> > the current clipboard data and makes qemu the new owner. It looks like
> > it could also run in a loop quite easily if it fights with a manager.
> >
> >> +
> >> +    if (!info->types[QEMU_CLIPBOARD_TYPE_TEXT].available) {
> >> +        return;
> >> +    }
> >> +
> >> +    info =3D qemu_clipboard_info_ref(info);
> >> +    qemu_clipboard_request(info, QEMU_CLIPBOARD_TYPE_TEXT);
> >> +
> >> +    while (info =3D=3D qemu_clipboard_info(info->selection) &&
> >> +           info->types[QEMU_CLIPBOARD_TYPE_TEXT].available &&
> >> +           info->types[QEMU_CLIPBOARD_TYPE_TEXT].data =3D=3D NULL) {
> >> +        main_loop_wait(false);
> >
> > Reentering the loop, that's annoying... same as gtk-clipboard.c..
> >
> > Have you tried to defer the handling of the update? That will add
> > extra state & logic though.
> >
> >> +    }
> >> +
> >> +    /* clipboard info changed while waiting for data */
> >> +    if (info !=3D qemu_clipboard_info(info->selection)) {
> >> +        qemu_clipboard_info_unref(info);
> >> +        return;
> >> +    }
> >> +
> >> +    /* text is not null terminated in cb info, so we need to copy it =
*/
> >> +    text_size =3D info->types[QEMU_CLIPBOARD_TYPE_TEXT].size;
> >
> > hmm, I wonder why.. isn't it something we could fix from
> > qemu_clipboard_set_data() callers?
> >
> > (gtk_selection_data_set_text() doc says it should be \0 terminated,
> > although it seems not required when len is given).
> >
> > I am not sure if the spice/vdagent ensures \0 terminated strings, but
> > the qemu code could adjust it as necessary.
>
> What if copied text contains \0?
>

I don't think that's a valid utf8 string then:

@QEMU_CLIPBOARD_TYPE_TEXT: text/plain; charset=3Dutf-8

or could it be?

--=20
Marc-Andr=C3=A9 Lureau

