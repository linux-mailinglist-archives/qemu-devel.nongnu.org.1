Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E076577B94C
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 15:02:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVXCm-0007U5-IR; Mon, 14 Aug 2023 09:01:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qVXCk-0007Ta-5a
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 09:01:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qVXCi-0002O7-Ds
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 09:01:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692018106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HNTgfWABibm77/UgkKGclET7VxRTH5MocqcH6xfsNZc=;
 b=BmRx2WAzlnwBugrhEyxLOliAM9JhEzA09DnA2euthTDufp7lrinbZW42BfRDGWWvejGrY6
 cylsCu4ithdXa8dnh3boxIfcIq9+RRXzZ6AMRoTsCrp2V28jlooMgL8ayO0HiSRS+lbtAq
 TCn7JgqJOIibV+WvAkkt60iEHV6FARQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-qOpaXun0PjGsq9qJQht9hg-1; Mon, 14 Aug 2023 09:01:43 -0400
X-MC-Unique: qOpaXun0PjGsq9qJQht9hg-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-523400c3638so2875724a12.3
 for <qemu-devel@nongnu.org>; Mon, 14 Aug 2023 06:01:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692018102; x=1692622902;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HNTgfWABibm77/UgkKGclET7VxRTH5MocqcH6xfsNZc=;
 b=j/qN+e0NkUxdPK1ACkJKYY7CouNl0eX8h7+WM5kk6RHYn80/G7/XG/C+80qK8/tagR
 cDMj/r7BLhg5AHFq/SlsCIPHcpN/MNNdUNDs4UiPsHfyAKOKzPuGuY4K8CncMoozLJdY
 pQFhFdUcyZAgdR76Oxt10TpruIow6EobG9vSxug1hmIFaP+ivoKWwHUF0vyjc+zopwJ+
 LtJ7G9Wab+ZfuwB4qAjCXoUsWznpBhs/dc8/Sq+WNRbq7310zcR2x3m4/ajX7uQtfhjW
 Ok+DQMqgJk3mk7HKpWspGGxonAowHVU5z+hQ117gNXsU4pS9x1iWtCd4q3y+lCJ3T1Hk
 NvvQ==
X-Gm-Message-State: AOJu0Yxun0ECU5oaMiOroz4ZG7L1JNQNsg//BLuAyKoM93WDKfCFEpNu
 4E2BJNS36NCq4jTLk6Os6wk1FitiCjL64hxXu6T7HK5Rf1UFhXxEUz1g9BzaXcfAWmXUi+l2zsj
 H3Q6X8JnQ+3aAhSK6ASyW8Eps6FDzGLg=
X-Received: by 2002:aa7:d390:0:b0:522:4c7a:d5a9 with SMTP id
 x16-20020aa7d390000000b005224c7ad5a9mr6441391edq.3.1692018102585; 
 Mon, 14 Aug 2023 06:01:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYipS+Ef/PU4kBbn9jp/N5nD4VPVn2e05fAEpgDp1ilh8Y2DngsfDCIRRWCnQT0O2I3Z+5igfm0d4s4Yk4lt0=
X-Received: by 2002:aa7:d390:0:b0:522:4c7a:d5a9 with SMTP id
 x16-20020aa7d390000000b005224c7ad5a9mr6441375edq.3.1692018102256; Mon, 14 Aug
 2023 06:01:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230814125802.102160-1-belmouss@redhat.com>
In-Reply-To: <20230814125802.102160-1-belmouss@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 14 Aug 2023 17:01:30 +0400
Message-ID: <CAMxuvawR2qcN51RBC2=CRYYib+=4G76b29X2Jrj_akn-RFp_rw@mail.gmail.com>
Subject: Re: [PATCH v2] ui/dbus: implement damage regions for GL
To: Bilal Elmoussaoui <belmouss@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Christian Hergert <chergert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Aug 14, 2023 at 4:58=E2=80=AFPM Bilal Elmoussaoui <belmouss@redhat.=
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

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

It could be considered as a fix, but I think we can delay it for the
next release. Fine with you?

> ---
>  ui/dbus-listener.c | 32 +++++++++++++++++++++++++-------
>  1 file changed, 25 insertions(+), 7 deletions(-)
>
> diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
> index 30917271ab..36548a7f52 100644
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
> +        /* TODO: Add a UpdateList call to send multiple updates at once =
*/
> +        dbus_call_update_gl(dcl, box->x1, box->y1,
> +                            box->x2 - box->x1, box->y2 - box->y1);
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
> @@ -738,6 +752,7 @@ dbus_display_listener_dispose(GObject *object)
>      g_clear_object(&ddl->d3d11_proxy);
>      g_clear_pointer(&ddl->peer_process, CloseHandle);
>  #ifdef CONFIG_OPENGL
> +    pixman_region32_fini(&ddl->gl_damage);
>      egl_fb_destroy(&ddl->fb);
>  #endif
>  #endif
> @@ -772,6 +787,9 @@ dbus_display_listener_class_init(DBusDisplayListenerC=
lass *klass)
>  static void
>  dbus_display_listener_init(DBusDisplayListener *ddl)
>  {
> +#ifdef CONFIG_OPENGL
> +    pixman_region32_init(&ddl->gl_damage);
> +#endif
>  }
>
>  const char *
> --
> 2.41.0
>


