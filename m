Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCD477B968
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 15:08:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVXI6-0001LU-Ui; Mon, 14 Aug 2023 09:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <belmouss@redhat.com>)
 id 1qVXHt-0001Fi-I6
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 09:07:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <belmouss@redhat.com>)
 id 1qVXHq-0003Qb-EO
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 09:07:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692018428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XoW7K5SMBPt2HGYSeaMM4oY4RJEeGon9WMbhRoNGiDo=;
 b=fxg17bEuHPKkqgTihDC9W1KjjkZZYOk51pDGE3uub8ilw/SPwLK+Pn+eA4mhDKFkdzRdsx
 eZVGzQX5yj/87RMuMlqrTXhkcZAgjUWiv8YooERVWp7fzAMZjt/eURRPsHF4zpoOyXbG3k
 Hg4u0fZjmQRH1w86jhrgVXrfLGSWVtM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-wCvfmu2COB-paBLsmQ-nGw-1; Mon, 14 Aug 2023 09:07:06 -0400
X-MC-Unique: wCvfmu2COB-paBLsmQ-nGw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-99bfe3dd009so670560966b.0
 for <qemu-devel@nongnu.org>; Mon, 14 Aug 2023 06:07:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692018425; x=1692623225;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XoW7K5SMBPt2HGYSeaMM4oY4RJEeGon9WMbhRoNGiDo=;
 b=GXE90PrHYl29Zm+ianwXxXY17D5rajFvijGTdSznGM4XQViK6l2T++orQ9TAqn7BiS
 Zg3ATb7RHV26djWt/8YCtar33vjFW7DQ28W4th5bfSa/UlAYz8W7bHnccWJ0PFGRTVQA
 JyZw/bAcnAo0kEbPDZNj3CdsEmQwLbXDQYcu4olIsoPm7JC8Wyjx0QSONYKXwEZjZEWo
 1WSfuVomEqu0dev9HNaLAYA8mUAx4w4VOGufWDn+KpGn0sFB4dY0EvnmtnHGabABcpzS
 Hy9B+4Uu36jrEHzGvvEwwrrZlHMZ47ETsU6canJgQM3q9GiYwgGCbP5zjQUhvwq6WivD
 3iYQ==
X-Gm-Message-State: AOJu0YxWLfr3rBO9w0CkCwRpeBLaCD41TMHhW3t8G1k6vfmYuzmUdPuC
 BfuXK0XKrjwsUhltB7RDoU78vXnBH5SuPa+PPZq4JKvz59l75np1BschTJHhV1j7WxrVELtXuJx
 ZnaqpUV9CvXSsemY6keI8pUqWQ00I6/0=
X-Received: by 2002:a17:907:3d94:b0:99c:78d4:32f9 with SMTP id
 he20-20020a1709073d9400b0099c78d432f9mr14217606ejc.10.1692018425513; 
 Mon, 14 Aug 2023 06:07:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgHo4fdD5AKkjNi1/AU2LiRShGkWelUnoLUyFr7zJm+0O8iZpVYJ3dvUU64gYiGGmQPYH6yV2Vt/zuqZT1cvQ=
X-Received: by 2002:a17:907:3d94:b0:99c:78d4:32f9 with SMTP id
 he20-20020a1709073d9400b0099c78d432f9mr14217588ejc.10.1692018425240; Mon, 14
 Aug 2023 06:07:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230814125802.102160-1-belmouss@redhat.com>
 <CAMxuvawR2qcN51RBC2=CRYYib+=4G76b29X2Jrj_akn-RFp_rw@mail.gmail.com>
In-Reply-To: <CAMxuvawR2qcN51RBC2=CRYYib+=4G76b29X2Jrj_akn-RFp_rw@mail.gmail.com>
From: Bilal Elmoussaoui <belmouss@redhat.com>
Date: Mon, 14 Aug 2023 15:06:54 +0200
Message-ID: <CALz9GzZwJE2w=dRp96T51K-R6jNoPuY0o_N_Y6wzEH34WFzjfg@mail.gmail.com>
Subject: Re: [PATCH v2] ui/dbus: implement damage regions for GL
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Christian Hergert <chergert@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000030b2750602e1bd53"
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

--00000000000030b2750602e1bd53
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

That is fine, it is not something we need urgently as we still need a
kernel patch to make virtio gpu use the KMS atomic API in Mutter. Am I
supposed to send a new patch with the "Reviewed-by" part in the commit
message or?

On Mon, Aug 14, 2023 at 3:02=E2=80=AFPM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@redhat.com> wrote:

> Hi
>
> On Mon, Aug 14, 2023 at 4:58=E2=80=AFPM Bilal Elmoussaoui <belmouss@redha=
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
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> It could be considered as a fix, but I think we can delay it for the
> next release. Fine with you?
>
> > ---
> >  ui/dbus-listener.c | 32 +++++++++++++++++++++++++-------
> >  1 file changed, 25 insertions(+), 7 deletions(-)
> >
> > diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
> > index 30917271ab..36548a7f52 100644
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
> > +        /* TODO: Add a UpdateList call to send multiple updates at onc=
e
> */
> > +        dbus_call_update_gl(dcl, box->x1, box->y1,
> > +                            box->x2 - box->x1, box->y2 - box->y1);
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
> > @@ -738,6 +752,7 @@ dbus_display_listener_dispose(GObject *object)
> >      g_clear_object(&ddl->d3d11_proxy);
> >      g_clear_pointer(&ddl->peer_process, CloseHandle);
> >  #ifdef CONFIG_OPENGL
> > +    pixman_region32_fini(&ddl->gl_damage);
> >      egl_fb_destroy(&ddl->fb);
> >  #endif
> >  #endif
> > @@ -772,6 +787,9 @@
> dbus_display_listener_class_init(DBusDisplayListenerClass *klass)
> >  static void
> >  dbus_display_listener_init(DBusDisplayListener *ddl)
> >  {
> > +#ifdef CONFIG_OPENGL
> > +    pixman_region32_init(&ddl->gl_damage);
> > +#endif
> >  }
> >
> >  const char *
> > --
> > 2.41.0
> >
>
>

--00000000000030b2750602e1bd53
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">That is fine, it is not something we need urgently as we s=
till need a kernel patch to make virtio gpu use the KMS atomic API in Mutte=
r. Am I supposed to send a new patch with the &quot;Reviewed-by&quot; part =
in the commit message or?<br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Mon, Aug 14, 2023 at 3:02=E2=80=AFPM Marc-=
Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marcan=
dre.lureau@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">Hi<br>
<br>
On Mon, Aug 14, 2023 at 4:58=E2=80=AFPM Bilal Elmoussaoui &lt;<a href=3D"ma=
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
<br>
Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@=
redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
<br>
It could be considered as a fix, but I think we can delay it for the<br>
next release. Fine with you?<br>
<br>
&gt; ---<br>
&gt;=C2=A0 ui/dbus-listener.c | 32 +++++++++++++++++++++++++-------<br>
&gt;=C2=A0 1 file changed, 25 insertions(+), 7 deletions(-)<br>
&gt;<br>
&gt; diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c<br>
&gt; index 30917271ab..36548a7f52 100644<br>
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
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* TODO: Add a UpdateList call to send mu=
ltiple updates at once */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dbus_call_update_gl(dcl, box-&gt;x1, box-=
&gt;y1,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 box-&gt;x2 - box-&gt;x1, box-&gt;y2 - box-&gt;=
y1);<br>
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
&gt; @@ -738,6 +752,7 @@ dbus_display_listener_dispose(GObject *object)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_clear_object(&amp;ddl-&gt;d3d11_proxy);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_clear_pointer(&amp;ddl-&gt;peer_process, CloseHa=
ndle);<br>
&gt;=C2=A0 #ifdef CONFIG_OPENGL<br>
&gt; +=C2=A0 =C2=A0 pixman_region32_fini(&amp;ddl-&gt;gl_damage);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 egl_fb_destroy(&amp;ddl-&gt;fb);<br>
&gt;=C2=A0 #endif<br>
&gt;=C2=A0 #endif<br>
&gt; @@ -772,6 +787,9 @@ dbus_display_listener_class_init(DBusDisplayListen=
erClass *klass)<br>
&gt;=C2=A0 static void<br>
&gt;=C2=A0 dbus_display_listener_init(DBusDisplayListener *ddl)<br>
&gt;=C2=A0 {<br>
&gt; +#ifdef CONFIG_OPENGL<br>
&gt; +=C2=A0 =C2=A0 pixman_region32_init(&amp;ddl-&gt;gl_damage);<br>
&gt; +#endif<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 const char *<br>
&gt; --<br>
&gt; 2.41.0<br>
&gt;<br>
<br>
</blockquote></div>

--00000000000030b2750602e1bd53--


