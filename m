Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 787ED74D4D8
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 13:59:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIpWo-0002Kv-6E; Mon, 10 Jul 2023 07:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qIpWl-0002Io-C8
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 07:58:03 -0400
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qIpWj-0004Wj-Eb
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 07:58:03 -0400
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-403a85eb723so17379321cf.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 04:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688990280; x=1691582280;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0qCABeYd/Ag1cR/42aLixoOaMtodllQo0IKQHZ13erE=;
 b=k8tjEP6u1AX2JE7afUk6CTLxdsxNH4bO3miR9l3se6Pks7utOAil5b8DTpVI8NQnWJ
 fYU2yb3ORGLBHFZcdqc2MawaUdeSJVuS0oCGKHPwg9VvOBItVwDDzBf4N4/iCKXgVcF6
 9NjogmEmRmDWBtLnbeME7OTiYQzJD4I9Y0DYmoKCZW/8wmjSAgSbDT9S2Qlqs57XGxTS
 7KuyAClcvY+gemoCMbEy57Ex7u51ofhBiZj9vFAHu/2Lti8sFo6Gkb7zvgZZEdT/IRDc
 uhSrnhNmE0EOYqKjX/GxIumKFFuQstFG3lWft2+p1uXEVu89nqh4ji8Z8Tw15bGo3uca
 IUSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688990280; x=1691582280;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0qCABeYd/Ag1cR/42aLixoOaMtodllQo0IKQHZ13erE=;
 b=FclpM2N2a1rrNbcKPoaA6b7iPY5+Hock9U81rEFIHkfeG9hxicepduTTL34eqXZKPU
 V2Tg1vPEKUELcr6fEULMOtm43EjQQfqUA4NS9zvPiaN7r6bXkCrwJmtJ5PGG2eiw/uoV
 bujUwDdiJ+EMKq+9uGVe6x4FWiP9YcsXC6PmBeGr5mR11EK6z9KshsIluIBROH+4aasP
 rkC+BPZ3dO2za/MrvC47ORj3G4VeW+WIVO3aBYxWRTz5fmo/2Rz5Qy9baLmRepshKJw3
 r/7J4JblOxpndKLocA0uT8m10MZnefZlvsZuZbxeKXCzD3jJmAdpgIaVBqfIKVGV/TxC
 L5QA==
X-Gm-Message-State: ABy/qLZRfP3w1+K5x2MepJAkgjGo/nV6ffB6eYKkjCqgfWnDz/lKSxMI
 ugAodgm1ex0dkH5FAlV6okzW9E81xYeUx/VrLZA=
X-Google-Smtp-Source: APBJJlHRmycieDC494tVFrxcXYaCuRodQIyx0r+ZhD8vKo7sJXJ72kr3dR6Oed92jRw6tP+MyOPXtV6x7aB9NjROM7I=
X-Received: by 2002:ac8:7f50:0:b0:403:a4e9:c3d4 with SMTP id
 g16-20020ac87f50000000b00403a4e9c3d4mr7296606qtk.59.1688990280246; Mon, 10
 Jul 2023 04:58:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230705224635.25343-1-dongwon.kim@intel.com>
In-Reply-To: <20230705224635.25343-1-dongwon.kim@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 10 Jul 2023 15:57:49 +0400
Message-ID: <CAJ+F1CKOQxQQh0qNJteP9EPfrCM3JaLZx5PkgsHJpQ4y_hWtnw@mail.gmail.com>
Subject: Re: [PATCH] virtio-gpu-udmabuf: replacing scanout_width/height with
 backing_width/height
To: Dongwon Kim <dongwon.kim@intel.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Content-Type: multipart/alternative; boundary="000000000000aeedfd060020b1d5"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000aeedfd060020b1d5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Jul 6, 2023 at 3:10=E2=80=AFAM Dongwon Kim <dongwon.kim@intel.com> =
wrote:

> 'backing_width' and 'backing_height' are commonly used to indicate the si=
ze
> of the whole backing region so it makes sense to use those terms for
> VGAUDMABuf as well in place of 'scanout_width' and 'scanout_height'.
>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> ---
>  hw/display/virtio-gpu-udmabuf.c | 8 ++++----
>  include/ui/console.h            | 4 ++--
>  ui/dbus-listener.c              | 4 ++--
>  ui/egl-helpers.c                | 4 ++--
>  ui/gtk-egl.c                    | 4 ++--
>  ui/gtk-gl-area.c                | 4 ++--
>  6 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/hw/display/virtio-gpu-udmabuf.c
> b/hw/display/virtio-gpu-udmabuf.c
> index ef1a740de5..920d457d4a 100644
> --- a/hw/display/virtio-gpu-udmabuf.c
> +++ b/hw/display/virtio-gpu-udmabuf.c
> @@ -186,8 +186,8 @@ static VGPUDMABuf
>      dmabuf->buf.stride =3D fb->stride;
>      dmabuf->buf.x =3D r->x;
>      dmabuf->buf.y =3D r->y;
> -    dmabuf->buf.scanout_width =3D r->width;
> -    dmabuf->buf.scanout_height =3D r->height;
> +    dmabuf->buf.backing_width =3D r->width;
> +    dmabuf->buf.backing_height =3D r->height;
>      dmabuf->buf.fourcc =3D qemu_pixman_to_drm_format(fb->format);
>      dmabuf->buf.fd =3D res->dmabuf_fd;
>      dmabuf->buf.allow_fences =3D true;
> @@ -218,8 +218,8 @@ int virtio_gpu_update_dmabuf(VirtIOGPU *g,
>
>      g->dmabuf.primary[scanout_id] =3D new_primary;
>      qemu_console_resize(scanout->con,
> -                        new_primary->buf.scanout_width,
> -                        new_primary->buf.scanout_height);
> +                        new_primary->buf.backing_width,
> +                        new_primary->buf.backing_height);
>      dpy_gl_scanout_dmabuf(scanout->con, &new_primary->buf);
>
>      if (old_primary) {
> diff --git a/include/ui/console.h b/include/ui/console.h
> index f27b2aad4f..3e8b22d6c6 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -201,8 +201,8 @@ typedef struct QemuDmaBuf {
>      uint32_t  texture;
>      uint32_t  x;
>      uint32_t  y;
> -    uint32_t  scanout_width;
> -    uint32_t  scanout_height;
> +    uint32_t  backing_width;
> +    uint32_t  backing_height;
>      bool      y0_top;
>      void      *sync;
>      int       fence_fd;
> diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
> index 0240c39510..7d73681cbc 100644
> --- a/ui/dbus-listener.c
> +++ b/ui/dbus-listener.c
> @@ -420,8 +420,8 @@ static void dbus_scanout_texture(DisplayChangeListene=
r
> *dcl,
>          .y0_top =3D backing_y_0_top,
>          .x =3D x,
>          .y =3D y,
> -        .scanout_width =3D w,
> -        .scanout_height =3D h,
> +        .backing_width =3D w,
> +        .backing_height =3D h,
>

This is not consistent with the function arguments. I think it should be
after:

.width =3D w, .height =3D h, .backing_width =3D backing_wdth, .backing_heig=
ht =3D
backing_height

Hopefully this inconsistency is not repeated elsewhere.

thanks


>      };
>
>      assert(tex_id);
> diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
> index 8f9fbf583e..6b7be5753d 100644
> --- a/ui/egl-helpers.c
> +++ b/ui/egl-helpers.c
> @@ -148,8 +148,8 @@ void egl_fb_blit(egl_fb *dst, egl_fb *src, bool flip)
>      if (src->dmabuf) {
>          x1 =3D src->dmabuf->x;
>          y1 =3D src->dmabuf->y;
> -        w =3D src->dmabuf->scanout_width;
> -        h =3D src->dmabuf->scanout_height;
> +        w =3D src->dmabuf->backing_width;
> +        h =3D src->dmabuf->backing_height;
>      }
>
>      w =3D (x1 + w) > src->width ? src->width - x1 : w;
> diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
> index d59b8cd7d7..7604696d4a 100644
> --- a/ui/gtk-egl.c
> +++ b/ui/gtk-egl.c
> @@ -259,8 +259,8 @@ void gd_egl_scanout_dmabuf(DisplayChangeListener *dcl=
,
>
>      gd_egl_scanout_texture(dcl, dmabuf->texture,
>                             dmabuf->y0_top, dmabuf->width, dmabuf->height=
,
> -                           dmabuf->x, dmabuf->y, dmabuf->scanout_width,
> -                           dmabuf->scanout_height, NULL);
> +                           dmabuf->x, dmabuf->y, dmabuf->backing_width,
> +                           dmabuf->backing_height, NULL);
>
>      if (dmabuf->allow_fences) {
>          vc->gfx.guest_fb.dmabuf =3D dmabuf;
> diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
> index 7367dfd793..3337a4baa3 100644
> --- a/ui/gtk-gl-area.c
> +++ b/ui/gtk-gl-area.c
> @@ -300,8 +300,8 @@ void gd_gl_area_scanout_dmabuf(DisplayChangeListener
> *dcl,
>
>      gd_gl_area_scanout_texture(dcl, dmabuf->texture,
>                                 dmabuf->y0_top, dmabuf->width,
> dmabuf->height,
> -                               dmabuf->x, dmabuf->y,
> dmabuf->scanout_width,
> -                               dmabuf->scanout_height, NULL);
> +                               dmabuf->x, dmabuf->y,
> dmabuf->backing_width,
> +                               dmabuf->backing_height, NULL);
>
>      if (dmabuf->allow_fences) {
>          vc->gfx.guest_fb.dmabuf =3D dmabuf;
> --
> 2.34.1
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000aeedfd060020b1d5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jul 6, 2023 at 3:10=E2=80=
=AFAM Dongwon Kim &lt;<a href=3D"mailto:dongwon.kim@intel.com">dongwon.kim@=
intel.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">&#39;backing_width&#39; and &#39;backing_height&#39; are commonl=
y used to indicate the size<br>
of the whole backing region so it makes sense to use those terms for<br>
VGAUDMABuf as well in place of &#39;scanout_width&#39; and &#39;scanout_hei=
ght&#39;.<br>
<br>
Cc: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com" target=3D"_blank=
">kraxel@redhat.com</a>&gt;<br>
Cc: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.co=
m" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
Cc: Vivek Kasireddy &lt;<a href=3D"mailto:vivek.kasireddy@intel.com" target=
=3D"_blank">vivek.kasireddy@intel.com</a>&gt;<br>
Signed-off-by: Dongwon Kim &lt;<a href=3D"mailto:dongwon.kim@intel.com" tar=
get=3D"_blank">dongwon.kim@intel.com</a>&gt;<br>
---<br>
=C2=A0hw/display/virtio-gpu-udmabuf.c | 8 ++++----<br>
=C2=A0include/ui/console.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 4 ++-=
-<br>
=C2=A0ui/dbus-listener.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =
4 ++--<br>
=C2=A0ui/egl-helpers.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 4 ++--<br>
=C2=A0ui/gtk-egl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | 4 ++--<br>
=C2=A0ui/gtk-gl-area.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 4 ++--<br>
=C2=A06 files changed, 14 insertions(+), 14 deletions(-)<br>
<br>
diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udmabu=
f.c<br>
index ef1a740de5..920d457d4a 100644<br>
--- a/hw/display/virtio-gpu-udmabuf.c<br>
+++ b/hw/display/virtio-gpu-udmabuf.c<br>
@@ -186,8 +186,8 @@ static VGPUDMABuf<br>
=C2=A0 =C2=A0 =C2=A0dmabuf-&gt;buf.stride =3D fb-&gt;stride;<br>
=C2=A0 =C2=A0 =C2=A0dmabuf-&gt;buf.x =3D r-&gt;x;<br>
=C2=A0 =C2=A0 =C2=A0dmabuf-&gt;buf.y =3D r-&gt;y;<br>
-=C2=A0 =C2=A0 dmabuf-&gt;buf.scanout_width =3D r-&gt;width;<br>
-=C2=A0 =C2=A0 dmabuf-&gt;buf.scanout_height =3D r-&gt;height;<br>
+=C2=A0 =C2=A0 dmabuf-&gt;buf.backing_width =3D r-&gt;width;<br>
+=C2=A0 =C2=A0 dmabuf-&gt;buf.backing_height =3D r-&gt;height;<br>
=C2=A0 =C2=A0 =C2=A0dmabuf-&gt;buf.fourcc =3D qemu_pixman_to_drm_format(fb-=
&gt;format);<br>
=C2=A0 =C2=A0 =C2=A0dmabuf-&gt;buf.fd =3D res-&gt;dmabuf_fd;<br>
=C2=A0 =C2=A0 =C2=A0dmabuf-&gt;buf.allow_fences =3D true;<br>
@@ -218,8 +218,8 @@ int virtio_gpu_update_dmabuf(VirtIOGPU *g,<br>
<br>
=C2=A0 =C2=A0 =C2=A0g-&gt;dmabuf.primary[scanout_id] =3D new_primary;<br>
=C2=A0 =C2=A0 =C2=A0qemu_console_resize(scanout-&gt;con,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 new_primary-&gt;buf.scanout_width,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 new_primary-&gt;buf.scanout_height);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 new_primary-&gt;buf.backing_width,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 new_primary-&gt;buf.backing_height);<br>
=C2=A0 =C2=A0 =C2=A0dpy_gl_scanout_dmabuf(scanout-&gt;con, &amp;new_primary=
-&gt;buf);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (old_primary) {<br>
diff --git a/include/ui/console.h b/include/ui/console.h<br>
index f27b2aad4f..3e8b22d6c6 100644<br>
--- a/include/ui/console.h<br>
+++ b/include/ui/console.h<br>
@@ -201,8 +201,8 @@ typedef struct QemuDmaBuf {<br>
=C2=A0 =C2=A0 =C2=A0uint32_t=C2=A0 texture;<br>
=C2=A0 =C2=A0 =C2=A0uint32_t=C2=A0 x;<br>
=C2=A0 =C2=A0 =C2=A0uint32_t=C2=A0 y;<br>
-=C2=A0 =C2=A0 uint32_t=C2=A0 scanout_width;<br>
-=C2=A0 =C2=A0 uint32_t=C2=A0 scanout_height;<br>
+=C2=A0 =C2=A0 uint32_t=C2=A0 backing_width;<br>
+=C2=A0 =C2=A0 uint32_t=C2=A0 backing_height;<br>
=C2=A0 =C2=A0 =C2=A0bool=C2=A0 =C2=A0 =C2=A0 y0_top;<br>
=C2=A0 =C2=A0 =C2=A0void=C2=A0 =C2=A0 =C2=A0 *sync;<br>
=C2=A0 =C2=A0 =C2=A0int=C2=A0 =C2=A0 =C2=A0 =C2=A0fence_fd;<br>
diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c<br>
index 0240c39510..7d73681cbc 100644<br>
--- a/ui/dbus-listener.c<br>
+++ b/ui/dbus-listener.c<br>
@@ -420,8 +420,8 @@ static void dbus_scanout_texture(DisplayChangeListener =
*dcl,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.y0_top =3D backing_y_0_top,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.x =3D x,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.y =3D y,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 .scanout_width =3D w,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 .scanout_height =3D h,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .backing_width =3D w,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .backing_height =3D h,<br></blockquote></div><=
div class=3D"gmail_quote"><br></div><div class=3D"gmail_quote">This is not =
consistent with the function arguments. I think it should be after:<br></di=
v><div class=3D"gmail_quote"><br></div><div class=3D"gmail_quote">.width =
=3D w, .height =3D h, .backing_width =3D backing_wdth, .backing_height =3D =
backing_height</div><div class=3D"gmail_quote"><br></div><div class=3D"gmai=
l_quote">Hopefully this inconsistency is not repeated elsewhere.</div><div =
class=3D"gmail_quote"><br></div><div class=3D"gmail_quote">thanks<br></div>=
<div class=3D"gmail_quote"><div>=C2=A0<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0};<br>
<br>
=C2=A0 =C2=A0 =C2=A0assert(tex_id);<br>
diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c<br>
index 8f9fbf583e..6b7be5753d 100644<br>
--- a/ui/egl-helpers.c<br>
+++ b/ui/egl-helpers.c<br>
@@ -148,8 +148,8 @@ void egl_fb_blit(egl_fb *dst, egl_fb *src, bool flip)<b=
r>
=C2=A0 =C2=A0 =C2=A0if (src-&gt;dmabuf) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0x1 =3D src-&gt;dmabuf-&gt;x;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0y1 =3D src-&gt;dmabuf-&gt;y;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 w =3D src-&gt;dmabuf-&gt;scanout_width;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 h =3D src-&gt;dmabuf-&gt;scanout_height;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 w =3D src-&gt;dmabuf-&gt;backing_width;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 h =3D src-&gt;dmabuf-&gt;backing_height;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0w =3D (x1 + w) &gt; src-&gt;width ? src-&gt;width - x1 =
: w;<br>
diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c<br>
index d59b8cd7d7..7604696d4a 100644<br>
--- a/ui/gtk-egl.c<br>
+++ b/ui/gtk-egl.c<br>
@@ -259,8 +259,8 @@ void gd_egl_scanout_dmabuf(DisplayChangeListener *dcl,<=
br>
<br>
=C2=A0 =C2=A0 =C2=A0gd_egl_scanout_texture(dcl, dmabuf-&gt;texture,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 dmabuf-&gt;y0_top, dmabuf-&gt;width, dmabuf-&gt;he=
ight,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0dmabuf-&gt;x, dmabuf-&gt;y, dmabuf-&gt;scanout_widt=
h,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0dmabuf-&gt;scanout_height, NULL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0dmabuf-&gt;x, dmabuf-&gt;y, dmabuf-&gt;backing_widt=
h,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0dmabuf-&gt;backing_height, NULL);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (dmabuf-&gt;allow_fences) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vc-&gt;gfx.guest_fb.dmabuf =3D dmabuf;<br=
>
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c<br>
index 7367dfd793..3337a4baa3 100644<br>
--- a/ui/gtk-gl-area.c<br>
+++ b/ui/gtk-gl-area.c<br>
@@ -300,8 +300,8 @@ void gd_gl_area_scanout_dmabuf(DisplayChangeListener *d=
cl,<br>
<br>
=C2=A0 =C2=A0 =C2=A0gd_gl_area_scanout_texture(dcl, dmabuf-&gt;texture,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dmabuf-&gt;y0_top, dmabuf-&gt;width,=
 dmabuf-&gt;height,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dmabuf-&gt;x, dmabuf-&gt;y, dmabuf-&g=
t;scanout_width,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dmabuf-&gt;scanout_height, NULL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dmabuf-&gt;x, dmabuf-&gt;y, dmabuf-&g=
t;backing_width,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dmabuf-&gt;backing_height, NULL);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (dmabuf-&gt;allow_fences) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vc-&gt;gfx.guest_fb.dmabuf =3D dmabuf;<br=
>
-- <br>
2.34.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--000000000000aeedfd060020b1d5--

