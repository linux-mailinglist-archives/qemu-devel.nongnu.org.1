Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5742A77B93D
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 15:00:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVXB7-0006RU-HI; Mon, 14 Aug 2023 09:00:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <belmouss@redhat.com>)
 id 1qVXAk-0006QB-0y
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 08:59:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <belmouss@redhat.com>)
 id 1qVXAi-0001nA-4n
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 08:59:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692017987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x2cuYxdCdA4gUn81gBhHQCrvELrO36bJrgwmZYTlJXc=;
 b=iGgAYuDpPrxvw0K9mZ7FEGJLmX8NNBXIyvUxApq2XOEeM1UoiY0RGLnapuG1ZICMZq3RAA
 NAEoj5maGc+/Xp2sjwZF6pGBONpPH4Zg5CesQn2tfXbIC4m4gbFj24aCnuPVvCTNceltI/
 ugDnyn9asNeScb0wC1Ph+QYL5IKHnGM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-MJKOTyS-MQiUXfhc4H5A1A-1; Mon, 14 Aug 2023 08:59:45 -0400
X-MC-Unique: MJKOTyS-MQiUXfhc4H5A1A-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5230741478cso3027707a12.0
 for <qemu-devel@nongnu.org>; Mon, 14 Aug 2023 05:59:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692017984; x=1692622784;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x2cuYxdCdA4gUn81gBhHQCrvELrO36bJrgwmZYTlJXc=;
 b=HgCy6IMNC6bQNZkUVfV3AH7cfrLi3c8Yr9Pw1aMfKf9j/dhja4B5K7zxkVSAift/cK
 o8pTb9Mdej8mZ4HOkRWDeLt98AwCQ9qx9+9TO2J+WZMYen06Uzldkp64ITE4lX06k0XR
 DDb2StdJwXYaHOiR8j0jdtbeGZZZ9HGSko5m22QeAo8iC0TkTYjD35KtzxojGi0jyydC
 o4Et+N3a00Oa3Of387s6JUooWBbNaFMctwObdfNfht4fnfO+H7NFpea6HZAhUx42rLRF
 0U7vSEJQL8I/yqDa9jE6XlnIrWBBQO/dwVNmGD/BCb7WVoQM8PO6ZwxPDavgSEAnUzAC
 5+pw==
X-Gm-Message-State: AOJu0Yz+04hvRhxLVjOxtJCVnVO92odXeTvNxNTKCy4UJZXycfY9ngo3
 pHRKGWA1x1YAZ0QYcg39IsRfo6GELLHFY7OTjq1RPpRkZF5GqMGtYCOUnjF37Kf7nhvuyu8lsdM
 lp8fqriL/KQ5LxPCWGJk9/q9R2DCTwtw=
X-Received: by 2002:a05:6402:124d:b0:525:4420:c425 with SMTP id
 l13-20020a056402124d00b005254420c425mr4922889edw.12.1692017984667; 
 Mon, 14 Aug 2023 05:59:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqjG2DnR2sjV6NTkzy3zouzWXlOBqiwsippLBeLefKkw/deca4a8QxibFcL5Jy8hjmGtCE5fS45aA9B43jbls=
X-Received: by 2002:a05:6402:124d:b0:525:4420:c425 with SMTP id
 l13-20020a056402124d00b005254420c425mr4922875edw.12.1692017984312; Mon, 14
 Aug 2023 05:59:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230814120739.89213-1-belmouss@redhat.com>
 <CAJ+F1CK2T30722z=Z=sOt4q0AcXpFs6qTAuVcLTWcoLrc2DjmA@mail.gmail.com>
In-Reply-To: <CAJ+F1CK2T30722z=Z=sOt4q0AcXpFs6qTAuVcLTWcoLrc2DjmA@mail.gmail.com>
From: Bilal Elmoussaoui <belmouss@redhat.com>
Date: Mon, 14 Aug 2023 14:59:33 +0200
Message-ID: <CALz9GzYCiLwP5o1AeMXf3Bg0xB_N8=0T0H8fQaAK1bJ853o5eA@mail.gmail.com>
Subject: Re: [PATCH] ui/dbus: implement damage regions for GL
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Christian Hergert <chergert@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e8ac790602e1a26b"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=belmouss@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--000000000000e8ac790602e1a26b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the quick review! I have sent a v2 with the requested changes.

On Mon, Aug 14, 2023 at 2:41=E2=80=AFPM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@gmail.com> wrote:

> Hi
>
> On Mon, Aug 14, 2023 at 4:10=E2=80=AFPM Bilal Elmoussaoui <belmouss@redha=
t.com>
> wrote:
> >
> > Currently, when using `-display dbus,gl=3Don` all updates to the client
> > become "full scanout" updates, meaning there is no way for the client t=
o
> > limit damage regions to the display server.
> >
> > Instead of using an "update count", this patch tracks the damage region
> > and propagates it to the client.
> >
> > This was less of an issue when clients were using GtkGLArea for
> > rendering,
> > as you'd be doing full-surface redraw. To be efficient, the client need=
s
> > both a DMA-BUF and the damage region to be updated.
> >
> > Co-authored-by: Christian Hergert <chergert@redhat.com>
> > Signed-off-by: Bilal Elmoussaoui <belmouss@redhat.com>
> > ---
> >  ui/dbus-listener.c | 32 ++++++++++++++++++++++++--------
> >  1 file changed, 24 insertions(+), 8 deletions(-)
> >
> > diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
> > index 30917271ab..d015e8d759 100644
> > --- a/ui/dbus-listener.c
> > +++ b/ui/dbus-listener.c
> > @@ -26,6 +26,9 @@
> >  #include "qapi/error.h"
> >  #include "sysemu/sysemu.h"
> >  #include "dbus.h"
> > +#ifdef CONFIG_OPENGL
> > +#include <pixman.h>
> > +#endif
> >  #ifdef G_OS_UNIX
> >  #include <gio/gunixfdlist.h>
> >  #endif
> > @@ -59,12 +62,15 @@ struct _DBusDisplayListener {
> >
> >      QemuDBusDisplay1Listener *proxy;
> >
> > +#ifdef CONFIG_OPENGL
> > +    /* Keep track of the damage region */
> > +    pixman_region32_t gl_damage;
> > +#endif
>
> I think it should call pixman_region32_init() in
> dbus_display_listener_new(), & _fini() in _dispose()
>
> > +
> >      DisplayChangeListener dcl;
> >      DisplaySurface *ds;
> >      enum share_kind ds_share;
> >
> > -    int gl_updates;
> > -
> >      bool ds_mapped;
> >      bool can_share_map;
> >
> > @@ -539,11 +545,16 @@ static void dbus_gl_refresh(DisplayChangeListener
> *dcl)
> >          return;
> >      }
> >
> > -    if (ddl->gl_updates) {
> > -        dbus_call_update_gl(dcl, 0, 0,
> > -                            surface_width(ddl->ds),
> surface_height(ddl->ds));
> > -        ddl->gl_updates =3D 0;
> > +    int n_rects =3D pixman_region32_n_rects(&ddl->gl_damage);
> > +
> > +    for (int i =3D 0; i < n_rects; i++) {
> > +        pixman_box32_t *box;
> > +        box =3D pixman_region32_rectangles(&ddl->gl_damage, NULL) + i;
> > +
> > +        dbus_call_update_gl(dcl, box->x1, box->y1,
> > +                            box->x2 - box->x1, box->y2 - box->y1);
>
> May be worth to add a "TODO: add Update*List methods" ?
>
> >      }
> > +    pixman_region32_clear(&ddl->gl_damage);
> >  }
> >  #endif /* OPENGL */
> >
> > @@ -558,7 +569,10 @@ static void
> dbus_gl_gfx_update(DisplayChangeListener *dcl,
> >  {
> >      DBusDisplayListener *ddl =3D container_of(dcl, DBusDisplayListener=
,
> dcl);
> >
> > -    ddl->gl_updates++;
> > +    pixman_region32_t rect_region;
> > +    pixman_region32_init_rect(&rect_region, x, y, w, h);
> > +    pixman_region32_union(&ddl->gl_damage, &ddl->gl_damage,
> &rect_region);
> > +    pixman_region32_fini(&rect_region);
> >  }
> >  #endif
> >
> > @@ -933,7 +947,9 @@ dbus_display_listener_new(const char *bus_name,
> >          g_object_unref(ddl);
> >          return NULL;
> >      }
> > -
> > +#ifdef CONFIG_OPENGL
> > +    pixman_region32_init(&ddl->gl_damage);
> > +#endif
> >      ddl->bus_name =3D g_strdup(bus_name);
> >      ddl->conn =3D conn;
> >      ddl->console =3D console;
> > --
> > 2.41.0
> >
> >
>
> otherwise, lgtm
>
> --
> Marc-Andr=C3=A9 Lureau
>
>

--000000000000e8ac790602e1a26b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Thanks for the quick review! I have sent a v2 with th=
e requested changes.<br></div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Mon, Aug 14, 2023 at 2:41=E2=80=AFPM Marc-=
Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@gmail.com">marcand=
re.lureau@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">Hi<br>
<br>
On Mon, Aug 14, 2023 at 4:10=E2=80=AFPM Bilal Elmoussaoui &lt;<a href=3D"ma=
ilto:belmouss@redhat.com" target=3D"_blank">belmouss@redhat.com</a>&gt; wro=
te:<br>
&gt;<br>
&gt; Currently, when using `-display dbus,gl=3Don` all updates to the clien=
t<br>
&gt; become &quot;full scanout&quot; updates, meaning there is no way for t=
he client to<br>
&gt; limit damage regions to the display server.<br>
&gt;<br>
&gt; Instead of using an &quot;update count&quot;, this patch tracks the da=
mage region<br>
&gt; and propagates it to the client.<br>
&gt;<br>
&gt; This was less of an issue when clients were using GtkGLArea for<br>
&gt; rendering,<br>
&gt; as you&#39;d be doing full-surface redraw. To be efficient, the client=
 needs<br>
&gt; both a DMA-BUF and the damage region to be updated.<br>
&gt;<br>
&gt; Co-authored-by: Christian Hergert &lt;<a href=3D"mailto:chergert@redha=
t.com" target=3D"_blank">chergert@redhat.com</a>&gt;<br>
&gt; Signed-off-by: Bilal Elmoussaoui &lt;<a href=3D"mailto:belmouss@redhat=
.com" target=3D"_blank">belmouss@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 ui/dbus-listener.c | 32 ++++++++++++++++++++++++--------<br>
&gt;=C2=A0 1 file changed, 24 insertions(+), 8 deletions(-)<br>
&gt;<br>
&gt; diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c<br>
&gt; index 30917271ab..d015e8d759 100644<br>
&gt; --- a/ui/dbus-listener.c<br>
&gt; +++ b/ui/dbus-listener.c<br>
&gt; @@ -26,6 +26,9 @@<br>
&gt;=C2=A0 #include &quot;qapi/error.h&quot;<br>
&gt;=C2=A0 #include &quot;sysemu/sysemu.h&quot;<br>
&gt;=C2=A0 #include &quot;dbus.h&quot;<br>
&gt; +#ifdef CONFIG_OPENGL<br>
&gt; +#include &lt;pixman.h&gt;<br>
&gt; +#endif<br>
&gt;=C2=A0 #ifdef G_OS_UNIX<br>
&gt;=C2=A0 #include &lt;gio/gunixfdlist.h&gt;<br>
&gt;=C2=A0 #endif<br>
&gt; @@ -59,12 +62,15 @@ struct _DBusDisplayListener {<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 QemuDBusDisplay1Listener *proxy;<br>
&gt;<br>
&gt; +#ifdef CONFIG_OPENGL<br>
&gt; +=C2=A0 =C2=A0 /* Keep track of the damage region */<br>
&gt; +=C2=A0 =C2=A0 pixman_region32_t gl_damage;<br>
&gt; +#endif<br>
<br>
I think it should call pixman_region32_init() in<br>
dbus_display_listener_new(), &amp; _fini() in _dispose()<br>
<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DisplayChangeListener dcl;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DisplaySurface *ds;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 enum share_kind ds_share;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 int gl_updates;<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bool ds_mapped;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bool can_share_map;<br>
&gt;<br>
&gt; @@ -539,11 +545,16 @@ static void dbus_gl_refresh(DisplayChangeListene=
r *dcl)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 if (ddl-&gt;gl_updates) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 dbus_call_update_gl(dcl, 0, 0,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 surface_width(ddl-&gt;ds), surface_height(ddl-=
&gt;ds));<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 ddl-&gt;gl_updates =3D 0;<br>
&gt; +=C2=A0 =C2=A0 int n_rects =3D pixman_region32_n_rects(&amp;ddl-&gt;gl=
_damage);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (int i =3D 0; i &lt; n_rects; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pixman_box32_t *box;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 box =3D pixman_region32_rectangles(&amp;d=
dl-&gt;gl_damage, NULL) + i;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dbus_call_update_gl(dcl, box-&gt;x1, box-=
&gt;y1,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 box-&gt;x2 - box-&gt;x1, box-&gt;y2 - box-&gt;=
y1);<br>
<br>
May be worth to add a &quot;TODO: add Update*List methods&quot; ?<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 pixman_region32_clear(&amp;ddl-&gt;gl_damage);<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 #endif /* OPENGL */<br>
&gt;<br>
&gt; @@ -558,7 +569,10 @@ static void dbus_gl_gfx_update(DisplayChangeListe=
ner *dcl,<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DBusDisplayListener *ddl =3D container_of(dcl, DBu=
sDisplayListener, dcl);<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 ddl-&gt;gl_updates++;<br>
&gt; +=C2=A0 =C2=A0 pixman_region32_t rect_region;<br>
&gt; +=C2=A0 =C2=A0 pixman_region32_init_rect(&amp;rect_region, x, y, w, h)=
;<br>
&gt; +=C2=A0 =C2=A0 pixman_region32_union(&amp;ddl-&gt;gl_damage, &amp;ddl-=
&gt;gl_damage, &amp;rect_region);<br>
&gt; +=C2=A0 =C2=A0 pixman_region32_fini(&amp;rect_region);<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 #endif<br>
&gt;<br>
&gt; @@ -933,7 +947,9 @@ dbus_display_listener_new(const char *bus_name,<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_object_unref(ddl);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -<br>
&gt; +#ifdef CONFIG_OPENGL<br>
&gt; +=C2=A0 =C2=A0 pixman_region32_init(&amp;ddl-&gt;gl_damage);<br>
&gt; +#endif<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ddl-&gt;bus_name =3D g_strdup(bus_name);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ddl-&gt;conn =3D conn;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ddl-&gt;console =3D console;<br>
&gt; --<br>
&gt; 2.41.0<br>
&gt;<br>
&gt;<br>
<br>
otherwise, lgtm<br>
<br>
-- <br>
Marc-Andr=C3=A9 Lureau<br>
<br>
</blockquote></div>

--000000000000e8ac790602e1a26b--


