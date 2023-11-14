Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4EC7EAEC3
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 12:24:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2rWR-0005Sk-76; Tue, 14 Nov 2023 06:23:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r2rWQ-0005SY-3C
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 06:23:58 -0500
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r2rWN-0001t0-TP
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 06:23:57 -0500
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6ce31c4a653so3235159a34.3
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 03:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699961034; x=1700565834; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pxXrhXtuVEE8en6Z3skbD//YfGlpPEJORU5W0tu3Zu8=;
 b=aRI7O4DakykU9Tq+xBWgXjOtU9vTx1c9sZNMn10aln3DEP+FM5he3DEnkZQQieRF3r
 pJdVcImQg0m67ImYEL7+8BCDp33vNnx+Cg7DeGbvdaItL1xKifBzM7O109+pkjJNsyXK
 9g1tfyPCm7ScZSm5ZPPnoCgRj0lym7JWzbt5Ts7rcnNF8eYJmqjnbOFefqP18Uj8XX/l
 3wKOOTg1k8LgN6REdF8hQxoha8MhTF+2sV5eJB6oUFOrxtW2LmjQ7pNtYKmCCpSeA5VQ
 yrCCzVZ3lLH9cct/TLRM0JQXU8/htV9lE09PCnP4LD7HCh1IixcU6jGJy0tLaKhVjXmT
 nVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699961034; x=1700565834;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pxXrhXtuVEE8en6Z3skbD//YfGlpPEJORU5W0tu3Zu8=;
 b=QpW0PczYZ4jOs8yYXfl9FywzrDHw8l1DsSKRmZhIiZKADbQ//1BujjDxNZY7G4dCLy
 bLSIilotZiHg+OxnmnYvu4v9QHqpW+EjvW+Iw22o97jyrpnTYZ++DMwkowIo6cCXUy85
 mYpI+ZDBnhcI+LfsPqAkMA7U3m6gg23gRG4a+zlM/Rzj99Q9tUo8gZrcWv+s6vEWGNmT
 5Mi3D0LamyDMnU9ApSUQOKYVp0R21xEoMt9KdynRTaLuOfdmuphzCLqj5EDM2uOQhwTB
 TJnocIqwVrZ0wK2iy3SyRzuXW27JoDG1OvDOIyA842AppNv6HGVKwJi3pjYpOD0UmwhE
 cjRg==
X-Gm-Message-State: AOJu0Yy0B7uRWnVzP7SUpugz1GN2swwo3dk8nVNSMHbgXsrszTkSSveA
 wdSIPuJxGawaeJG4cWAH+8SCe/mUeGLKiUynalxo0Ts/C5JhhQ==
X-Google-Smtp-Source: AGHT+IG1EhBMSaD1Nh1kVPwNSSX0rdsw2vMneAGITzore/aMChDSV0o1zLsE8sHHcdmW0s6n2RfciT88198qyea3Vok=
X-Received: by 2002:a05:6870:bf14:b0:1ea:7bd1:c48f with SMTP id
 qh20-20020a056870bf1400b001ea7bd1c48fmr11167551oab.14.1699961034085; Tue, 14
 Nov 2023 03:23:54 -0800 (PST)
MIME-Version: 1.0
References: <20231108022139.12503-1-admin@xutaxkamay.com>
 <20231108022139.12503-2-admin@xutaxkamay.com>
In-Reply-To: <20231108022139.12503-2-admin@xutaxkamay.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 14 Nov 2023 15:23:42 +0400
Message-ID: <CAJ+F1CL=+Lwykncp83dh7SfJqB9vniAU6pKoyzLhahkaKJX01Q@mail.gmail.com>
Subject: Re: [PATCH RFC v1 1/1] ui/sdl2: clipboard sharing implementation for
 SDL
To: Kamay Xutax <admin@xutaxkamay.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ot1-x330.google.com
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

On Wed, Nov 8, 2023 at 7:56=E2=80=AFPM Kamay Xutax <admin@xutaxkamay.com> w=
rote:
>
> Signed-off-by: Kamay Xutax <admin@xutaxkamay.com>
> ---
>  include/ui/sdl2.h   |   5 ++
>  meson.build         |   1 +
>  ui/meson.build      |   1 +
>  ui/sdl2-clipboard.c | 147 ++++++++++++++++++++++++++++++++++++++++++++
>  ui/sdl2.c           |   8 +++
>  5 files changed, 162 insertions(+)
>  create mode 100644 ui/sdl2-clipboard.c
>
> diff --git a/include/ui/sdl2.h b/include/ui/sdl2.h
> index e3acc7c82a..120fe6f856 100644
> --- a/include/ui/sdl2.h
> +++ b/include/ui/sdl2.h
> @@ -21,6 +21,7 @@
>  # include <SDL_image.h>
>  #endif
>
> +#include "ui/clipboard.h"
>  #include "ui/kbd-state.h"
>  #ifdef CONFIG_OPENGL
>  # include "ui/egl-helpers.h"
> @@ -51,6 +52,7 @@ struct sdl2_console {
>      bool y0_top;
>      bool scanout_mode;
>  #endif
> +    QemuClipboardPeer cbpeer;
>  };
>
>  void sdl2_window_create(struct sdl2_console *scon);
> @@ -70,6 +72,9 @@ void sdl2_2d_redraw(struct sdl2_console *scon);
>  bool sdl2_2d_check_format(DisplayChangeListener *dcl,
>                            pixman_format_code_t format);
>
> +void sdl2_clipboard_handle_request(struct sdl2_console *scon);
> +void sdl2_clipboard_init(struct sdl2_console *scon);
> +
>  void sdl2_gl_update(DisplayChangeListener *dcl,
>                      int x, int y, int w, int h);
>  void sdl2_gl_switch(DisplayChangeListener *dcl,
> diff --git a/meson.build b/meson.build
> index 4848930680..1358d14b2e 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2157,6 +2157,7 @@ config_host_data.set('CONFIG_RDMA', rdma.found())
>  config_host_data.set('CONFIG_RELOCATABLE', get_option('relocatable'))
>  config_host_data.set('CONFIG_SAFESTACK', get_option('safe_stack'))
>  config_host_data.set('CONFIG_SDL', sdl.found())
> +config_host_data.set('CONFIG_SDL_CLIPBOARD', sdl.found())

'gtk_clipboard' option is there because it has some issues with the
glib loop - see https://gitlab.com/qemu-project/qemu/-/issues/1150.

Apparently this code could have similar kind of issues, since it's
reentering the main loop too.  it might be worth to have a similar
option and disclaimer...


>  config_host_data.set('CONFIG_SDL_IMAGE', sdl_image.found())
>  config_host_data.set('CONFIG_SECCOMP', seccomp.found())
>  if seccomp.found()
> diff --git a/ui/meson.build b/ui/meson.build
> index 0ccb3387ee..0cadd1a18f 100644
> --- a/ui/meson.build
> +++ b/ui/meson.build
> @@ -125,6 +125,7 @@ if sdl.found()
>    sdl_ss =3D ss.source_set()
>    sdl_ss.add(sdl, sdl_image, pixman, glib, files(
>      'sdl2-2d.c',
> +    'sdl2-clipboard.c',
>      'sdl2-input.c',
>      'sdl2.c',
>    ))
> diff --git a/ui/sdl2-clipboard.c b/ui/sdl2-clipboard.c
> new file mode 100644
> index 0000000000..405bb9ea8b
> --- /dev/null
> +++ b/ui/sdl2-clipboard.c
> @@ -0,0 +1,147 @@
> +/*
> + * SDL UI -- clipboard support
> + *
> + * Copyright (C) 2023 Kamay Xutax <admin@xutaxkamay.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/main-loop.h"
> +#include "ui/sdl2.h"
> +
> +static void sdl2_clipboard_update(struct sdl2_console *scon,
> +                                  QemuClipboardInfo *info)
> +{
> +    bool self_update =3D info->owner =3D=3D &scon->cbpeer;
> +    char *text;
> +    size_t text_size;
> +
> +    /*
> +     * In case of a self update,
> +     * set again the text in SDL
> +     *
> +     * This is a workaround for hosts that have clipboard history
> +     * or when they're copying again something,
> +     * so that SDL can accept a new request from the host
> +     * and make a new SDL_CLIPBOARDUPDATE event
> +     */
> +
> +    if (self_update) {
> +        text =3D SDL_GetClipboardText();
> +        SDL_SetClipboardText(text);
> +        SDL_free(text);
> +        return;
> +    }

Isn't this basically doing the work of a clipboard manager? it takes
the current clipboard data and makes qemu the new owner. It looks like
it could also run in a loop quite easily if it fights with a manager.

> +
> +    if (!info->types[QEMU_CLIPBOARD_TYPE_TEXT].available) {
> +        return;
> +    }
> +
> +    info =3D qemu_clipboard_info_ref(info);
> +    qemu_clipboard_request(info, QEMU_CLIPBOARD_TYPE_TEXT);
> +
> +    while (info =3D=3D qemu_clipboard_info(info->selection) &&
> +           info->types[QEMU_CLIPBOARD_TYPE_TEXT].available &&
> +           info->types[QEMU_CLIPBOARD_TYPE_TEXT].data =3D=3D NULL) {
> +        main_loop_wait(false);

Reentering the loop, that's annoying... same as gtk-clipboard.c..

 Have you tried to defer the handling of the update? That will add
extra state & logic though.

> +    }
> +
> +    /* clipboard info changed while waiting for data */
> +    if (info !=3D qemu_clipboard_info(info->selection)) {
> +        qemu_clipboard_info_unref(info);
> +        return;
> +    }
> +
> +    /* text is not null terminated in cb info, so we need to copy it */
> +    text_size =3D info->types[QEMU_CLIPBOARD_TYPE_TEXT].size;

hmm, I wonder why.. isn't it something we could fix from
qemu_clipboard_set_data() callers?

(gtk_selection_data_set_text() doc says it should be \0 terminated,
although it seems not required when len is given).

I am not sure if the spice/vdagent ensures \0 terminated strings, but
the qemu code could adjust it as necessary.


> +    if (!text_size) {
> +        qemu_clipboard_info_unref(info);
> +        return;
> +    }
> +
> +    text =3D malloc(text_size + 1);

We use g_malloc() and g_free() (even better with g_autofree).

> +
> +    if (!text) {

Then, no need to check for NULL results (it aborts on OOM).

> +        qemu_clipboard_info_unref(info);
> +        return;
> +    }
> +
> +    text[text_size] =3D 0;
> +    memcpy(text, info->types[QEMU_CLIPBOARD_TYPE_TEXT].data, text_size);
> +    /* unref as soon we copied the text */
> +    qemu_clipboard_info_unref(info);
> +    SDL_SetClipboardText(text);
> +
> +    free(text);
> +}
> +
> +static void sdl2_clipboard_notify(Notifier *notifier,
> +                                  void *data)
> +{
> +    QemuClipboardNotify *notify =3D data;
> +    struct sdl2_console *scon =3D
> +        container_of(notifier, struct sdl2_console, cbpeer.notifier);
> +
> +    switch (notify->type) {
> +    case QEMU_CLIPBOARD_UPDATE_INFO:
> +        sdl2_clipboard_update(scon, notify->info);
> +        break;
> +    case QEMU_CLIPBOARD_RESET_SERIAL:
> +        break;
> +    }
> +}
> +
> +static void sdl2_clipboard_request(QemuClipboardInfo *info,
> +                                   QemuClipboardType type)
> +{
> +    struct sdl2_console *scon =3D
> +        container_of(info->owner, struct sdl2_console, cbpeer);
> +    char *text;
> +
> +    switch (type) {
> +    case QEMU_CLIPBOARD_TYPE_TEXT:
> +        if (!SDL_HasClipboardText()) {
> +            return;
> +        }
> +
> +        text =3D SDL_GetClipboardText();
> +        qemu_clipboard_set_data(&scon->cbpeer, info, type,
> +                                strlen(text), text, true);

strlen() + 1  to have \0 then? (other backends would need similar fix)

> +
> +        SDL_free(text);
> +        break;
> +    default:
> +        return;
> +    }
> +}
> +
> +void sdl2_clipboard_handle_request(struct sdl2_console *scon)
> +{
> +    g_autoptr(QemuClipboardInfo) info =3D
> +        qemu_clipboard_info_new(&scon->cbpeer,
> +                                QEMU_CLIPBOARD_SELECTION_CLIPBOARD);
> +
> +    sdl2_clipboard_request(info, QEMU_CLIPBOARD_TYPE_TEXT);
> +}
> +
> +void sdl2_clipboard_init(struct sdl2_console *scon)
> +{
> +    scon->cbpeer.name =3D "sdl2";
> +    scon->cbpeer.notifier.notify =3D sdl2_clipboard_notify;
> +    /* requests will be handled from the SDL event loop */
> +    qemu_clipboard_peer_register(&scon->cbpeer);
> +}
> diff --git a/ui/sdl2.c b/ui/sdl2.c
> index fbfdb64e90..d674add7c5 100644
> --- a/ui/sdl2.c
> +++ b/ui/sdl2.c
> @@ -702,6 +702,11 @@ void sdl2_poll_events(struct sdl2_console *scon)
>          case SDL_WINDOWEVENT:
>              handle_windowevent(ev);
>              break;
> +#if defined(CONFIG_SDL_CLIPBOARD)
> +        case SDL_CLIPBOARDUPDATE:
> +            sdl2_clipboard_handle_request(scon);
> +            break;
> +#endif
>          default:
>              break;
>          }
> @@ -922,6 +927,9 @@ static void sdl2_display_init(DisplayState *ds, Displ=
ayOptions *o)
>              qemu_console_set_window_id(con, info.info.x11.window);
>  #endif
>          }
> +#endif
> +#if defined(CONFIG_SDL_CLIPBOARD)
> +        sdl2_clipboard_init(&sdl2_console[i]);
>  #endif
>      }
>
> --
> 2.41.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

