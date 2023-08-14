Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC5A77B8DB
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 14:42:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVWt6-00031h-3f; Mon, 14 Aug 2023 08:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qVWt3-00031K-1X
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 08:41:33 -0400
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qVWt1-0005NS-71
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 08:41:32 -0400
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-4103fdba0fbso7071591cf.3
 for <qemu-devel@nongnu.org>; Mon, 14 Aug 2023 05:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692016889; x=1692621689;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IISetcy1XVngJ/1jiJ0zpngnX0ydjSF4XFZUmkCIZLg=;
 b=oChrz9hZvARuPvoiOYJtITLnWvq0H2VdjHmZkGBR+Za4oBSc0+5cfPJfcDbLdVti6Z
 0JnCD46oteQQXiPdagwxoMK73bFgoR4qahNxZn8IcLNzsYZzQt9V9En12C81tAWezttA
 HVk9qFYz0esU0YZWcHEAzi6zVo9Nkak9fj01t4pGb8KDTl5cMOvFmZwzyFryHPYm8OC6
 bkd9sUvllFFhHh10pDzRtXSBOqnn/BAn8QYDteDZrx2b9GaWMYNJrpJ2g9KJxdo2hxER
 slsbEKImoUf7ga2mTIIur8U6q9Agru5jgNdal1nvKnfZz9IaIfEauZfzV4rB5RdkxI4o
 GuGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692016889; x=1692621689;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IISetcy1XVngJ/1jiJ0zpngnX0ydjSF4XFZUmkCIZLg=;
 b=Zq1dXAgA4AiFJAAWNKxy52PxY2e34EqnpWx79VmsHxUV151meMj/IDCIeh510ZI+V7
 +DPNsSDD0ft7uw8JFRmPdsuNGbLnxPeMvQhngSewXtk+L2+rVPQ5KJJE+XUzDxCi/eAu
 E0fVp+smCCyMG1AAuLjdk6EZ8xUZSHU0MvvD7KRUVMLyHvLLCL+ztxiGMMwV/tDRGs0D
 /RgIwZZ/2AqzJOEhzus3Cnz3OS2aBe6tegnEOQQEnQuu/Ployr/T1k7BwpiMf2j3tWOv
 jK8S4QqCFL2SKZRrdcui6Cz+oE006+Yuh8Kdk8zr7mEe41a6MnoHKVIrM8PgquY6JxtO
 pn3A==
X-Gm-Message-State: AOJu0YzUrgJ/FIZLYc3wFJoDH5VaLzidsE2zMajX5I4fBHfqcJNzf2wF
 Imhc7bGjCyBI6JpxC/PjrfJQft7QtH08Ka9WmGQ=
X-Google-Smtp-Source: AGHT+IGKN3nVhA0u3ZHHyQNyuU81wwlOO0ys8lssxe63VlkWGMkv1kAKzzxUeqfOjzRkRTrjFpmxuRwVPqugRZZc7oM=
X-Received: by 2002:ac8:58ca:0:b0:405:3dcf:1182 with SMTP id
 u10-20020ac858ca000000b004053dcf1182mr9281402qta.50.1692016889615; Mon, 14
 Aug 2023 05:41:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230814120739.89213-1-belmouss@redhat.com>
In-Reply-To: <20230814120739.89213-1-belmouss@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 14 Aug 2023 16:41:18 +0400
Message-ID: <CAJ+F1CK2T30722z=Z=sOt4q0AcXpFs6qTAuVcLTWcoLrc2DjmA@mail.gmail.com>
Subject: Re: [PATCH] ui/dbus: implement damage regions for GL
To: Bilal Elmoussaoui <belmouss@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Christian Hergert <chergert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::829;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x829.google.com
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

On Mon, Aug 14, 2023 at 4:10=E2=80=AFPM Bilal Elmoussaoui <belmouss@redhat.=
com> wrote:
>
> Currently, when using `-display dbus,gl=3Don` all updates to the client
> become "full scanout" updates, meaning there is no way for the client to
> limit damage regions to the display server.
>
> Instead of using an "update count", this patch tracks the damage region
> and propagates it to the client.
>
> This was less of an issue when clients were using GtkGLArea for
> rendering,
> as you'd be doing full-surface redraw. To be efficient, the client needs
> both a DMA-BUF and the damage region to be updated.
>
> Co-authored-by: Christian Hergert <chergert@redhat.com>
> Signed-off-by: Bilal Elmoussaoui <belmouss@redhat.com>
> ---
>  ui/dbus-listener.c | 32 ++++++++++++++++++++++++--------
>  1 file changed, 24 insertions(+), 8 deletions(-)
>
> diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
> index 30917271ab..d015e8d759 100644
> --- a/ui/dbus-listener.c
> +++ b/ui/dbus-listener.c
> @@ -26,6 +26,9 @@
>  #include "qapi/error.h"
>  #include "sysemu/sysemu.h"
>  #include "dbus.h"
> +#ifdef CONFIG_OPENGL
> +#include <pixman.h>
> +#endif
>  #ifdef G_OS_UNIX
>  #include <gio/gunixfdlist.h>
>  #endif
> @@ -59,12 +62,15 @@ struct _DBusDisplayListener {
>
>      QemuDBusDisplay1Listener *proxy;
>
> +#ifdef CONFIG_OPENGL
> +    /* Keep track of the damage region */
> +    pixman_region32_t gl_damage;
> +#endif

I think it should call pixman_region32_init() in
dbus_display_listener_new(), & _fini() in _dispose()

> +
>      DisplayChangeListener dcl;
>      DisplaySurface *ds;
>      enum share_kind ds_share;
>
> -    int gl_updates;
> -
>      bool ds_mapped;
>      bool can_share_map;
>
> @@ -539,11 +545,16 @@ static void dbus_gl_refresh(DisplayChangeListener *=
dcl)
>          return;
>      }
>
> -    if (ddl->gl_updates) {
> -        dbus_call_update_gl(dcl, 0, 0,
> -                            surface_width(ddl->ds), surface_height(ddl->=
ds));
> -        ddl->gl_updates =3D 0;
> +    int n_rects =3D pixman_region32_n_rects(&ddl->gl_damage);
> +
> +    for (int i =3D 0; i < n_rects; i++) {
> +        pixman_box32_t *box;
> +        box =3D pixman_region32_rectangles(&ddl->gl_damage, NULL) + i;
> +
> +        dbus_call_update_gl(dcl, box->x1, box->y1,
> +                            box->x2 - box->x1, box->y2 - box->y1);

May be worth to add a "TODO: add Update*List methods" ?

>      }
> +    pixman_region32_clear(&ddl->gl_damage);
>  }
>  #endif /* OPENGL */
>
> @@ -558,7 +569,10 @@ static void dbus_gl_gfx_update(DisplayChangeListener=
 *dcl,
>  {
>      DBusDisplayListener *ddl =3D container_of(dcl, DBusDisplayListener, =
dcl);
>
> -    ddl->gl_updates++;
> +    pixman_region32_t rect_region;
> +    pixman_region32_init_rect(&rect_region, x, y, w, h);
> +    pixman_region32_union(&ddl->gl_damage, &ddl->gl_damage, &rect_region=
);
> +    pixman_region32_fini(&rect_region);
>  }
>  #endif
>
> @@ -933,7 +947,9 @@ dbus_display_listener_new(const char *bus_name,
>          g_object_unref(ddl);
>          return NULL;
>      }
> -
> +#ifdef CONFIG_OPENGL
> +    pixman_region32_init(&ddl->gl_damage);
> +#endif
>      ddl->bus_name =3D g_strdup(bus_name);
>      ddl->conn =3D conn;
>      ddl->console =3D console;
> --
> 2.41.0
>
>

otherwise, lgtm

--=20
Marc-Andr=C3=A9 Lureau

