Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A00835CDF
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 09:42:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRprx-0006N5-Vp; Mon, 22 Jan 2024 03:41:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rRprd-0006KG-TL
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 03:41:06 -0500
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rRprb-0005iP-MM
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 03:41:05 -0500
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-42a35982c09so10882901cf.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 00:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705912863; x=1706517663; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5M1U3PLwXexTP7FoEOoShW80d0ipsAq8WqxKIJJqwtU=;
 b=W99BD2U/yQhJBlTBvoKmMJAbELkv14tvMcTzBLX1fA51FrKAryN1M8CTPMIeeM9TDB
 C+I1741Cff/FGsTjUz/hyDxM418mfEbxxs6rx/YROMXJEdb0AQDikGGkytyLtBY/NdNt
 1hDD1T9Y+/KDmZPWG1DYiAS9keYNl72mJB/P/xgM0ylpgOCVEkXIH/QUWgTUAGqWHkcd
 un41mmAAEeTvXp5fTK3cnSWxyRz6knzCJ7i5yg/gojkJ8ivSMkeIcdLP64ghh4yphq5n
 zjp921qnJ6EW+PNFZZY/Tyldyzpk+SWiY9s8q6VQfaJcTAyQP0Nqp7hQmLnRpLsIK8+F
 ERfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705912863; x=1706517663;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5M1U3PLwXexTP7FoEOoShW80d0ipsAq8WqxKIJJqwtU=;
 b=uC3erVNPA6+VwAUFv4G/z1dIblofwzZcxIQd/GZWA3IUoIsqSQEX9gAPSkUDCGadl7
 RbFv1pH9a+UWvUYcvlrR+jwyN+S09oijIqHN3uVVxbxQxvFu5LrYDOjzH2PdJU3XyKXv
 ysXTUp9Zvb4FNkpHGi4wXwFHsCP7l9vuYkD+kwmk02NHPGHQhB6xGR6q/snGNmQ4Gm7S
 t+GR6qwJBnqyQHGqJElLzuq64WCfox1TmIfguKQ8qyC85hlt/I94o9ht+Ogb9+uPUHb6
 Ti1yZ7uW7DiVBY0SyeFetitjd3BsD0QBuKQExFTjSIZfNnhUVjZ+80d9Y7ooX4jOgwqZ
 5Epw==
X-Gm-Message-State: AOJu0Yykay534aMnUdBP8DJi9ZCv/ujKRaqRyUP0A+FGmMcEMCUDcHiy
 hEx2RUKWytU/aRdioBlV7ZGZuUwrUFVjURsBzFRheCBSGVFXOJjYdXT8381H6klbCWF1mLcEHWy
 1NQh9/F6XASSIsTRvPDwFvE/4Ix0=
X-Google-Smtp-Source: AGHT+IGa/e2k0xj8tFhsQBzQMqxv6cQ6WdMtGfOGjL4FfkkrFIkcnhMOPkMhIIixSMIN0BkvXMNRt4Ug5VKN62vwyzo=
X-Received: by 2002:a05:622a:181b:b0:42a:37cc:cb3c with SMTP id
 t27-20020a05622a181b00b0042a37cccb3cmr3590981qtc.73.1705912862713; Mon, 22
 Jan 2024 00:41:02 -0800 (PST)
MIME-Version: 1.0
References: <20240120003013.1829757-1-vivek.kasireddy@intel.com>
 <20240120003013.1829757-4-vivek.kasireddy@intel.com>
In-Reply-To: <20240120003013.1829757-4-vivek.kasireddy@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 22 Jan 2024 12:40:51 +0400
Message-ID: <CAJ+F1CKUr7dGjVG+Fcvc4sBRFAncBRTTQ76uZs9SkNCsQgBZUg@mail.gmail.com>
Subject: Re: [PATCH v1 3/7] ui/spice: Submit the gl_draw requests at 60 FPS
 for remote clients
To: Vivek Kasireddy <vivek.kasireddy@intel.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Frediano Ziglio <freddy77@gmail.com>, Dongwon Kim <dongwon.kim@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x830.google.com
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

On Sat, Jan 20, 2024 at 4:54=E2=80=AFAM Vivek Kasireddy
<vivek.kasireddy@intel.com> wrote:
>
> In the specific case where the display layer (virtio-gpu) is using
> dmabuf, and if remote clients are enabled (-spice gl=3Don,port=3Dxxxx),
> it makes sense to limit the maximum (streaming) rate to 60 FPS
> using the GUI timer. This matches the behavior of GTK UI where the
> display updates are submitted at 60 FPS (assuming the underlying
> mode is WxY@60).

One of the issues with this approach is that the DMABUF isn't owned by
the consumer. By delaying the usage of it, we risk having
damaged/invalid updates.

It would be great if we could have a mechanism for double/triple
buffering with virtio-gpu, as far as I know this is not possible yet.

I wonder if setting dpy_set_ui_info() with the fixed refresh_rate is
enough for the guest to have a fixed FPS. It will only work with gfx
hw that support ui_info() though.



>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Frediano Ziglio <freddy77@gmail.com>
> Cc: Dongwon Kim <dongwon.kim@intel.com>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> ---
>  ui/spice-display.c | 38 ++++++++++++++++++++++++++++----------
>  1 file changed, 28 insertions(+), 10 deletions(-)
>
> diff --git a/ui/spice-display.c b/ui/spice-display.c
> index 384b8508d4..90c04623ec 100644
> --- a/ui/spice-display.c
> +++ b/ui/spice-display.c
> @@ -841,12 +841,31 @@ static void qemu_spice_gl_block_timer(void *opaque)
>      warn_report("spice: no gl-draw-done within one second");
>  }
>
> +static void spice_gl_draw(SimpleSpiceDisplay *ssd,
> +                           uint32_t x, uint32_t y, uint32_t w, uint32_t =
h)
> +{
> +    uint64_t cookie;
> +
> +    cookie =3D (uintptr_t)qxl_cookie_new(QXL_COOKIE_TYPE_GL_DRAW_DONE, 0=
);
> +    spice_qxl_gl_draw_async(&ssd->qxl, x, y, w, h, cookie);
> +}
> +
>  static void spice_gl_refresh(DisplayChangeListener *dcl)
>  {
>      SimpleSpiceDisplay *ssd =3D container_of(dcl, SimpleSpiceDisplay, dc=
l);
> -    uint64_t cookie;
> +    QemuDmaBuf *dmabuf =3D ssd->guest_dmabuf;
>
> -    if (!ssd->ds || qemu_console_is_gl_blocked(ssd->dcl.con)) {
> +    if (!ssd->ds) {
> +        return;
> +    }
> +
> +    if (qemu_console_is_gl_blocked(ssd->dcl.con)) {
> +        if (remote_client && ssd->gl_updates && dmabuf) {
> +            spice_gl_draw(ssd, 0, 0, dmabuf->width, dmabuf->height);
> +            ssd->gl_updates =3D 0;
> +            /* To stream at 60 FPS, the (GUI) timer delay needs to be ~1=
7 ms */
> +            dcl->update_interval =3D 1000 / (2 * GUI_REFRESH_INTERVAL_DE=
FAULT) + 1;
> +        }
>          return;
>      }
>
> @@ -854,11 +873,8 @@ static void spice_gl_refresh(DisplayChangeListener *=
dcl)
>      if (ssd->gl_updates && ssd->have_surface) {
>          qemu_spice_gl_block(ssd, true);
>          glFlush();
> -        cookie =3D (uintptr_t)qxl_cookie_new(QXL_COOKIE_TYPE_GL_DRAW_DON=
E, 0);
> -        spice_qxl_gl_draw_async(&ssd->qxl, 0, 0,
> -                                surface_width(ssd->ds),
> -                                surface_height(ssd->ds),
> -                                cookie);
> +        spice_gl_draw(ssd, 0, 0,
> +                      surface_width(ssd->ds), surface_height(ssd->ds));
>          ssd->gl_updates =3D 0;
>      }
>  }
> @@ -1025,7 +1041,6 @@ static void qemu_spice_gl_update(DisplayChangeListe=
ner *dcl,
>      EGLint stride =3D 0, fourcc =3D 0;
>      bool render_cursor =3D false;
>      bool y_0_top =3D false; /* FIXME */
> -    uint64_t cookie;
>      int fd;
>
>      if (!ssd->have_scanout) {
> @@ -1098,8 +1113,11 @@ static void qemu_spice_gl_update(DisplayChangeList=
ener *dcl,
>      trace_qemu_spice_gl_update(ssd->qxl.id, w, h, x, y);
>      qemu_spice_gl_block(ssd, true);
>      glFlush();
> -    cookie =3D (uintptr_t)qxl_cookie_new(QXL_COOKIE_TYPE_GL_DRAW_DONE, 0=
);
> -    spice_qxl_gl_draw_async(&ssd->qxl, x, y, w, h, cookie);
> +    if (remote_client) {
> +        ssd->gl_updates++;
> +    } else {
> +        spice_gl_draw(ssd, x, y, w, h);
> +    }
>  }
>
>  static const DisplayChangeListenerOps display_listener_gl_ops =3D {
> --
> 2.39.2
>
>


--
Marc-Andr=C3=A9 Lureau

