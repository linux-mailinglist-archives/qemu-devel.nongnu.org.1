Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E15D9772325
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 13:55:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSyoy-000231-Ft; Mon, 07 Aug 2023 07:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qSyow-0001zN-Oy
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 07:54:46 -0400
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qSyov-0007zb-9E
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 07:54:46 -0400
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-40ff82320a7so17302251cf.3
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 04:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691409284; x=1692014084;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wfUpqExb76+zKuyrX7mszbm80LWi+23xAwRNNcp09Zo=;
 b=sZKW8zvFXqLBQ4t6IYM8lpq8d03kgZp+t93KQN3H1su9qcvHIQoxKCO863ePXFjGn3
 oo2i9Y8cCei3Qs1VvqD3BKDgb7DB5DbzR573JCoG96D0BmLWi6jMnGvQvwWyeD7jcA2Y
 +Kzw5ccBi5/TbEqc7GdRxcwALhEqv5yY+yeUm/8nvaMSZI/VaOs3C2xD6wtz2A6fXt8c
 b70b78/JsHD+AiGidO+EysMwBi0fgSoptFiKCTm5Q5+bGteBaXjPXVFpzUqZRzNxLwE5
 VkwyrPVkmx6LY4mSLfRNNApR9joPQfgLi9KYzZu/51V9MnpMrlI5erb6aPHuvq5uFHhs
 JYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691409284; x=1692014084;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wfUpqExb76+zKuyrX7mszbm80LWi+23xAwRNNcp09Zo=;
 b=WyzSiKd492Xc/ue8SE9hiHZPuhpux2iI1vF1FFIWAvFmrLeyzLGuXz3B50TCNGLMCF
 LtMbj7D/2RQNkUx11asczdAJjr1t5YSb/nfV+cYkDkVtvO/RCmpSpS+azMIhrUBQnA4k
 W0w3+AY/mJUGI/NJ+jPCrwqUWrJIXmz/1HIC0pQY+w3DVqmhvZ3JF+mJj2RWfAIFUodP
 qiMWUORoIL66ITxBklEOSR3rpuxuff9M+ZunR5vPEX7af3GxoVcd5ZbxdTSHZAQrxSLa
 p0IZn/euihW7uK+9ZFnIOYcpAOW03Jz8nymhaLKkt6oX4CEpCSaJCnSz38bXFrDE6hYt
 VbkA==
X-Gm-Message-State: AOJu0YwpQU+fGgurerPgXF3HLJIJ8VHQ/yuW0OtHAezKnyDGqLDm+w1+
 LGDrjXhe61ORGtT/PY7vC/v/VIwjri/V49hsQ+8=
X-Google-Smtp-Source: AGHT+IFZDVycpJ+FYBOoOeQPIDPm0vx8psvH84YrusbB7MLkuyhCiTSLo3URB2Icuo5eqpILHhRkdlpRxL4fL0XRJMg=
X-Received: by 2002:ac8:5b11:0:b0:40f:ffd3:6201 with SMTP id
 m17-20020ac85b11000000b0040fffd36201mr8891967qtw.66.1691409283752; Mon, 07
 Aug 2023 04:54:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230725001131.24017-1-dongwon.kim@intel.com>
In-Reply-To: <20230725001131.24017-1-dongwon.kim@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 7 Aug 2023 15:54:31 +0400
Message-ID: <CAJ+F1CLZJxAG+RUud3ugS=0SL+bR4DZE8LizixYgGS=dDP4nBg@mail.gmail.com>
Subject: Re: [PATCH] ui/gtk: set scanout mode in
 gd_egl/gd_gl_area_scanout_texture
To: Dongwon Kim <dongwon.kim@intel.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>, 
 Gerd Hoffmann <kraxel@redhat.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82b.google.com
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

On Tue, Jul 25, 2023 at 4:35=E2=80=AFAM Dongwon Kim <dongwon.kim@intel.com>=
 wrote:
>
> Fixing a regression (black screen) caused by a commit 92b58156e7
> ("ui/gtk: set scanout-mode right before scheduling draw").
>
> The commit 92b58156e7 was made with an assumption that the scanout
> mode needs to be set only if the guest scanout is a dmabuf but there
> are cases (e.g. virtio-gpu-virgl) where the scanout is still processed
> in a form of a texture but is not backed by dmabuf. So it is needed
> to put back the line that sets scanout mode in gd_egl_scanout_texture
> and gd_gl_area_scanout_texture.
>
> Fixes: 92b58156e7 ("ui/gtk: set scanout-mode right before scheduling draw=
)
> Reported-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  ui/gtk-egl.c     | 1 +
>  ui/gtk-gl-area.c | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
> index 4c29ac10d0..a1060fd80f 100644
> --- a/ui/gtk-egl.c
> +++ b/ui/gtk-egl.c
> @@ -246,6 +246,7 @@ void gd_egl_scanout_texture(DisplayChangeListener *dc=
l,
>      eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
>                     vc->gfx.esurface, vc->gfx.ectx);
>
> +    gtk_egl_set_scanout_mode(vc, true);
>      egl_fb_setup_for_tex(&vc->gfx.guest_fb, backing_width, backing_heigh=
t,
>                           backing_id, false);
>  }
> diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
> index 1ce34a249e..52dcac161e 100644
> --- a/ui/gtk-gl-area.c
> +++ b/ui/gtk-gl-area.c
> @@ -268,6 +268,7 @@ void gd_gl_area_scanout_texture(DisplayChangeListener=
 *dcl,
>          return;
>      }
>
> +    gtk_gl_area_set_scanout_mode(vc, true);
>      egl_fb_setup_for_tex(&vc->gfx.guest_fb, backing_width, backing_heigh=
t,
>                           backing_id, false);
>  }
> --
> 2.34.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

