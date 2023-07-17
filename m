Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C94755F31
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 11:26:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLKTo-0005CM-3p; Mon, 17 Jul 2023 05:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qLKTl-0005C4-3j
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 05:25:17 -0400
Received: from mail-qk1-x72d.google.com ([2607:f8b0:4864:20::72d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qLKTi-0001fk-9X
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 05:25:16 -0400
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-76595a7b111so343381785a.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 02:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689585912; x=1692177912;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MxlYcWs29losbM1i1uwoAveZDDJ+G5PhPPh8kuR9Pjc=;
 b=OCSF9k+/TPbAdftreUuKTHT79yqT9KbSsu0FoTfAY5jSUP9ggbB7LJW5cJHxzvsXkp
 xfVXCtzpFlOJ+KyF7zxrpTYBVxX/1pZ1hGGseJOQWWMjdUkZ8tGNGhTApm8RGeK+YXXQ
 nEherWqo3NPqHgaspszVJPRvSUgb2EuS+9M4Hag3IRqJURJbixScWFPRHeIGuGPLFMP/
 OvBAeRLwdP16Ge+eMlwP8+aQ1G3UYCaB4Pl0g7xRKG8faCjO25UdibCDIMcbqMANk71k
 ZpIIdfEKBsbDDUxyrwJ7vrpFFtjfjo1HggIK3U9olX1VeshMGXfJFmQLmMV1qx9U5ecU
 4ZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689585912; x=1692177912;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MxlYcWs29losbM1i1uwoAveZDDJ+G5PhPPh8kuR9Pjc=;
 b=PvUMBWQgzZrPnyh9luMhFCMxPuo+2Su/KvhIp74+pCAmPRKFfAAluC0MCkrbMLmMfC
 Ty+Mc/b7aVOR8YBQN7PmiGBdVNqvKv3KDoACdk7CjLzcxfZkaLlbNxZDbiFR07qpC5Ko
 FDkwVm1+4xVDhSehTsxHHWr0t4DDCxwYAFNRPkor72ZCU0rHmk8FS35MxWzcCFYUKUYz
 6yYtF9l53QWn5NNr7s2qkvalLxubyStTf75CW0texaoDQbqWbxsE366/236LxFqwnyXS
 ZI+HYt0aZRUL1nlX5ZYHAUC4qmotjJAhtrBwBI+piMHfpL3b5hxPfYOFKp98LByKjgB2
 RBNQ==
X-Gm-Message-State: ABy/qLahfKG40q2Cs4FrQJKSP0k/MygrOfEJ6lZLLmdFGvpRRjs3UqYt
 pfjP2cDU01OQjrOlmnivaOh6xJ+F/7aPdlOlcsI=
X-Google-Smtp-Source: APBJJlFAeUFI5QG0tuYFaHWvYeTaqntTvMlAMNS7vVtH1+2j0elgHKaivkpZLHFDoEW3vOrjPaKzpufwPGExaBaCHF4=
X-Received: by 2002:ac8:5ad4:0:b0:403:aabf:4efb with SMTP id
 d20-20020ac85ad4000000b00403aabf4efbmr13704002qtd.44.1689585912277; Mon, 17
 Jul 2023 02:25:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+F1CKOQxQQh0qNJteP9EPfrCM3JaLZx5PkgsHJpQ4y_hWtnw@mail.gmail.com>
 <20230713040444.32267-1-dongwon.kim@intel.com>
In-Reply-To: <20230713040444.32267-1-dongwon.kim@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 17 Jul 2023 13:25:00 +0400
Message-ID: <CAJ+F1CLpoGQKQq5BgyUBpRq4uhiUa6yR8gYfjE=70mx=RSxrKg@mail.gmail.com>
Subject: Re: [PATCH] virtio-gpu-udmabuf: correct naming of QemuDmaBuf size
 properties
To: Dongwon Kim <dongwon.kim@intel.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Content-Type: multipart/alternative; boundary="0000000000001e70ad0600ab601c"
Received-SPF: pass client-ip=2607:f8b0:4864:20::72d;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qk1-x72d.google.com
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

--0000000000001e70ad0600ab601c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 13, 2023 at 8:28=E2=80=AFAM Dongwon Kim <dongwon.kim@intel.com>=
 wrote:

> Replace 'width' and 'height' in QemuDmaBuf with 'backing_widht'
> and 'backing_height' as these commonly indicate the size of the
> whole surface (e.g. guest's Xorg extended display). Then use
> 'width' and 'height' for sub region in there (e.g. guest's
> scanouts).
>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  hw/display/virtio-gpu-udmabuf.c | 12 ++++++------
>  include/ui/console.h            |  4 ++--
>  ui/dbus-listener.c              |  8 ++++----
>  ui/egl-helpers.c                |  8 ++++----
>  ui/gtk-egl.c                    |  8 ++++----
>  ui/gtk-gl-area.c                |  6 +++---
>  6 files changed, 23 insertions(+), 23 deletions(-)
>
> diff --git a/hw/display/virtio-gpu-udmabuf.c
> b/hw/display/virtio-gpu-udmabuf.c
> index ef1a740de5..047758582c 100644
> --- a/hw/display/virtio-gpu-udmabuf.c
> +++ b/hw/display/virtio-gpu-udmabuf.c
> @@ -181,13 +181,13 @@ static VGPUDMABuf
>      }
>
>      dmabuf =3D g_new0(VGPUDMABuf, 1);
> -    dmabuf->buf.width =3D fb->width;
> -    dmabuf->buf.height =3D fb->height;
> +    dmabuf->buf.width =3D r->width;
> +    dmabuf->buf.height =3D r->height;
>      dmabuf->buf.stride =3D fb->stride;
>      dmabuf->buf.x =3D r->x;
>      dmabuf->buf.y =3D r->y;
> -    dmabuf->buf.scanout_width =3D r->width;
> -    dmabuf->buf.scanout_height =3D r->height;
> +    dmabuf->buf.backing_width =3D fb->width;
> +    dmabuf->buf.backing_height =3D fb->height;;
>      dmabuf->buf.fourcc =3D qemu_pixman_to_drm_format(fb->format);
>      dmabuf->buf.fd =3D res->dmabuf_fd;
>      dmabuf->buf.allow_fences =3D true;
> @@ -218,8 +218,8 @@ int virtio_gpu_update_dmabuf(VirtIOGPU *g,
>
>      g->dmabuf.primary[scanout_id] =3D new_primary;
>      qemu_console_resize(scanout->con,
> -                        new_primary->buf.scanout_width,
> -                        new_primary->buf.scanout_height);
> +                        new_primary->buf.width,
> +                        new_primary->buf.height);
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
> index 0240c39510..68ff343799 100644
> --- a/ui/dbus-listener.c
> +++ b/ui/dbus-listener.c
> @@ -415,13 +415,13 @@ static void
> dbus_scanout_texture(DisplayChangeListener *dcl,
>                                 backing_width, backing_height, x, y, w, h=
);
>  #ifdef CONFIG_GBM
>      QemuDmaBuf dmabuf =3D {
> -        .width =3D backing_width,
> -        .height =3D backing_height,
> +        .width =3D w,
> +        .height =3D h,
>          .y0_top =3D backing_y_0_top,
>          .x =3D x,
>          .y =3D y,
> -        .scanout_width =3D w,
> -        .scanout_height =3D h,
> +        .backing_width =3D backing_width,
> +        .backing_height =3D backing_height,
>      };
>
>      assert(tex_id);
> diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
> index 8f9fbf583e..bc0960a9ec 100644
> --- a/ui/egl-helpers.c
> +++ b/ui/egl-helpers.c
> @@ -148,8 +148,8 @@ void egl_fb_blit(egl_fb *dst, egl_fb *src, bool flip)
>      if (src->dmabuf) {
>          x1 =3D src->dmabuf->x;
>          y1 =3D src->dmabuf->y;
> -        w =3D src->dmabuf->scanout_width;
> -        h =3D src->dmabuf->scanout_height;
> +        w =3D src->dmabuf->width;
> +        h =3D src->dmabuf->height;
>      }
>
>      w =3D (x1 + w) > src->width ? src->width - x1 : w;
> @@ -314,9 +314,9 @@ void egl_dmabuf_import_texture(QemuDmaBuf *dmabuf)
>      }
>
>      attrs[i++] =3D EGL_WIDTH;
> -    attrs[i++] =3D dmabuf->width;
> +    attrs[i++] =3D dmabuf->backing_width;
>      attrs[i++] =3D EGL_HEIGHT;
> -    attrs[i++] =3D dmabuf->height;
> +    attrs[i++] =3D dmabuf->backing_height;;
>      attrs[i++] =3D EGL_LINUX_DRM_FOURCC_EXT;
>      attrs[i++] =3D dmabuf->fourcc;
>
> diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
> index d59b8cd7d7..a37ad6c9db 100644
> --- a/ui/gtk-egl.c
> +++ b/ui/gtk-egl.c
> @@ -258,9 +258,9 @@ void gd_egl_scanout_dmabuf(DisplayChangeListener *dcl=
,
>      }
>
>      gd_egl_scanout_texture(dcl, dmabuf->texture,
> -                           dmabuf->y0_top, dmabuf->width, dmabuf->height=
,
> -                           dmabuf->x, dmabuf->y, dmabuf->scanout_width,
> -                           dmabuf->scanout_height, NULL);
> +                           dmabuf->y0_top, dmabuf->backing_width,
> dmabuf->backing_height,
> +                           dmabuf->x, dmabuf->y, dmabuf->width,
> +                           dmabuf->height, NULL);
>
>      if (dmabuf->allow_fences) {
>          vc->gfx.guest_fb.dmabuf =3D dmabuf;
> @@ -280,7 +280,7 @@ void gd_egl_cursor_dmabuf(DisplayChangeListener *dcl,
>          if (!dmabuf->texture) {
>              return;
>          }
> -        egl_fb_setup_for_tex(&vc->gfx.cursor_fb, dmabuf->width,
> dmabuf->height,
> +        egl_fb_setup_for_tex(&vc->gfx.cursor_fb, dmabuf->backing_width,
> dmabuf->backing_height,
>                               dmabuf->texture, false);
>      } else {
>          egl_fb_destroy(&vc->gfx.cursor_fb);
> diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
> index 7367dfd793..ea3d50598e 100644
> --- a/ui/gtk-gl-area.c
> +++ b/ui/gtk-gl-area.c
> @@ -299,9 +299,9 @@ void gd_gl_area_scanout_dmabuf(DisplayChangeListener
> *dcl,
>      }
>
>      gd_gl_area_scanout_texture(dcl, dmabuf->texture,
> -                               dmabuf->y0_top, dmabuf->width,
> dmabuf->height,
> -                               dmabuf->x, dmabuf->y,
> dmabuf->scanout_width,
> -                               dmabuf->scanout_height, NULL);
> +                               dmabuf->y0_top, dmabuf->backing_width,
> dmabuf->backing_height,
> +                               dmabuf->x, dmabuf->y, dmabuf->width,
> +                               dmabuf->height, NULL);
>
>      if (dmabuf->allow_fences) {
>          vc->gfx.guest_fb.dmabuf =3D dmabuf;
> --
> 2.20.1
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--0000000000001e70ad0600ab601c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jul 13, 2023 at 8:28=E2=80=AF=
AM Dongwon Kim &lt;<a href=3D"mailto:dongwon.kim@intel.com">dongwon.kim@int=
el.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">Replace &#39;width&#39; and &#39;height&#39; in QemuDmaBuf with &#39;=
backing_widht&#39;<br>
and &#39;backing_height&#39; as these commonly indicate the size of the<br>
whole surface (e.g. guest&#39;s Xorg extended display). Then use<br>
&#39;width&#39; and &#39;height&#39; for sub region in there (e.g. guest&#3=
9;s<br>
scanouts).<br>
<br>
Cc: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com" target=3D"_blank=
">kraxel@redhat.com</a>&gt;<br>
Cc: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.co=
m" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
Cc: Vivek Kasireddy &lt;<a href=3D"mailto:vivek.kasireddy@intel.com" target=
=3D"_blank">vivek.kasireddy@intel.com</a>&gt;<br>
Signed-off-by: Dongwon Kim &lt;<a href=3D"mailto:dongwon.kim@intel.com" tar=
get=3D"_blank">dongwon.kim@intel.com</a>&gt;<br></blockquote><div><br></div=
><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.l=
ureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div>=C2=A0<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0hw/display/virtio-gpu-udmabuf.c | 12 ++++++------<br>
=C2=A0include/ui/console.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0=
 4 ++--<br>
=C2=A0ui/dbus-listener.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 8 ++++----<br>
=C2=A0ui/egl-helpers.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 8 ++++----<br>
=C2=A0ui/gtk-egl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 8 ++++----<br>
=C2=A0ui/gtk-gl-area.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 6 +++---<br>
=C2=A06 files changed, 23 insertions(+), 23 deletions(-)<br>
<br>
diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udmabu=
f.c<br>
index ef1a740de5..047758582c 100644<br>
--- a/hw/display/virtio-gpu-udmabuf.c<br>
+++ b/hw/display/virtio-gpu-udmabuf.c<br>
@@ -181,13 +181,13 @@ static VGPUDMABuf<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0dmabuf =3D g_new0(VGPUDMABuf, 1);<br>
-=C2=A0 =C2=A0 dmabuf-&gt;buf.width =3D fb-&gt;width;<br>
-=C2=A0 =C2=A0 dmabuf-&gt;buf.height =3D fb-&gt;height;<br>
+=C2=A0 =C2=A0 dmabuf-&gt;buf.width =3D r-&gt;width;<br>
+=C2=A0 =C2=A0 dmabuf-&gt;buf.height =3D r-&gt;height;<br>
=C2=A0 =C2=A0 =C2=A0dmabuf-&gt;buf.stride =3D fb-&gt;stride;<br>
=C2=A0 =C2=A0 =C2=A0dmabuf-&gt;buf.x =3D r-&gt;x;<br>
=C2=A0 =C2=A0 =C2=A0dmabuf-&gt;buf.y =3D r-&gt;y;<br>
-=C2=A0 =C2=A0 dmabuf-&gt;buf.scanout_width =3D r-&gt;width;<br>
-=C2=A0 =C2=A0 dmabuf-&gt;buf.scanout_height =3D r-&gt;height;<br>
+=C2=A0 =C2=A0 dmabuf-&gt;buf.backing_width =3D fb-&gt;width;<br>
+=C2=A0 =C2=A0 dmabuf-&gt;buf.backing_height =3D fb-&gt;height;;<br>
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
=A0 =C2=A0 new_primary-&gt;buf.width,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 new_primary-&gt;buf.height);<br>
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
index 0240c39510..68ff343799 100644<br>
--- a/ui/dbus-listener.c<br>
+++ b/ui/dbus-listener.c<br>
@@ -415,13 +415,13 @@ static void dbus_scanout_texture(DisplayChangeListene=
r *dcl,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 backing_width, backing_height, x, y,=
 w, h);<br>
=C2=A0#ifdef CONFIG_GBM<br>
=C2=A0 =C2=A0 =C2=A0QemuDmaBuf dmabuf =3D {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 .width =3D backing_width,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 .height =3D backing_height,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .width =3D w,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .height =3D h,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.y0_top =3D backing_y_0_top,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.x =3D x,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.y =3D y,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 .scanout_width =3D w,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 .scanout_height =3D h,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .backing_width =3D backing_width,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .backing_height =3D backing_height,<br>
=C2=A0 =C2=A0 =C2=A0};<br>
<br>
=C2=A0 =C2=A0 =C2=A0assert(tex_id);<br>
diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c<br>
index 8f9fbf583e..bc0960a9ec 100644<br>
--- a/ui/egl-helpers.c<br>
+++ b/ui/egl-helpers.c<br>
@@ -148,8 +148,8 @@ void egl_fb_blit(egl_fb *dst, egl_fb *src, bool flip)<b=
r>
=C2=A0 =C2=A0 =C2=A0if (src-&gt;dmabuf) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0x1 =3D src-&gt;dmabuf-&gt;x;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0y1 =3D src-&gt;dmabuf-&gt;y;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 w =3D src-&gt;dmabuf-&gt;scanout_width;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 h =3D src-&gt;dmabuf-&gt;scanout_height;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 w =3D src-&gt;dmabuf-&gt;width;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 h =3D src-&gt;dmabuf-&gt;height;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0w =3D (x1 + w) &gt; src-&gt;width ? src-&gt;width - x1 =
: w;<br>
@@ -314,9 +314,9 @@ void egl_dmabuf_import_texture(QemuDmaBuf *dmabuf)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0attrs[i++] =3D EGL_WIDTH;<br>
-=C2=A0 =C2=A0 attrs[i++] =3D dmabuf-&gt;width;<br>
+=C2=A0 =C2=A0 attrs[i++] =3D dmabuf-&gt;backing_width;<br>
=C2=A0 =C2=A0 =C2=A0attrs[i++] =3D EGL_HEIGHT;<br>
-=C2=A0 =C2=A0 attrs[i++] =3D dmabuf-&gt;height;<br>
+=C2=A0 =C2=A0 attrs[i++] =3D dmabuf-&gt;backing_height;;<br>
=C2=A0 =C2=A0 =C2=A0attrs[i++] =3D EGL_LINUX_DRM_FOURCC_EXT;<br>
=C2=A0 =C2=A0 =C2=A0attrs[i++] =3D dmabuf-&gt;fourcc;<br>
<br>
diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c<br>
index d59b8cd7d7..a37ad6c9db 100644<br>
--- a/ui/gtk-egl.c<br>
+++ b/ui/gtk-egl.c<br>
@@ -258,9 +258,9 @@ void gd_egl_scanout_dmabuf(DisplayChangeListener *dcl,<=
br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0gd_egl_scanout_texture(dcl, dmabuf-&gt;texture,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0dmabuf-&gt;y0_top, dmabuf-&gt;width, dmabuf-&gt;hei=
ght,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0dmabuf-&gt;x, dmabuf-&gt;y, dmabuf-&gt;scanout_widt=
h,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0dmabuf-&gt;scanout_height, NULL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0dmabuf-&gt;y0_top, dmabuf-&gt;backing_width, dmabuf=
-&gt;backing_height,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0dmabuf-&gt;x, dmabuf-&gt;y, dmabuf-&gt;width,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0dmabuf-&gt;height, NULL);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (dmabuf-&gt;allow_fences) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vc-&gt;gfx.guest_fb.dmabuf =3D dmabuf;<br=
>
@@ -280,7 +280,7 @@ void gd_egl_cursor_dmabuf(DisplayChangeListener *dcl,<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!dmabuf-&gt;texture) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 egl_fb_setup_for_tex(&amp;vc-&gt;gfx.cursor_fb=
, dmabuf-&gt;width, dmabuf-&gt;height,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 egl_fb_setup_for_tex(&amp;vc-&gt;gfx.cursor_fb=
, dmabuf-&gt;backing_width, dmabuf-&gt;backing_height,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dmabuf-&gt;texture, false);<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0egl_fb_destroy(&amp;vc-&gt;gfx.cursor_fb)=
;<br>
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c<br>
index 7367dfd793..ea3d50598e 100644<br>
--- a/ui/gtk-gl-area.c<br>
+++ b/ui/gtk-gl-area.c<br>
@@ -299,9 +299,9 @@ void gd_gl_area_scanout_dmabuf(DisplayChangeListener *d=
cl,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0gd_gl_area_scanout_texture(dcl, dmabuf-&gt;texture,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dmabuf-&gt;y0_top, dmabuf-&gt;width, =
dmabuf-&gt;height,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dmabuf-&gt;x, dmabuf-&gt;y, dmabuf-&g=
t;scanout_width,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dmabuf-&gt;scanout_height, NULL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dmabuf-&gt;y0_top, dmabuf-&gt;backing=
_width, dmabuf-&gt;backing_height,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dmabuf-&gt;x, dmabuf-&gt;y, dmabuf-&g=
t;width,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dmabuf-&gt;height, NULL);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (dmabuf-&gt;allow_fences) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vc-&gt;gfx.guest_fb.dmabuf =3D dmabuf;<br=
>
-- <br>
2.20.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--0000000000001e70ad0600ab601c--

