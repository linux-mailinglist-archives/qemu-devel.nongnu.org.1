Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B397CAA1B
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 15:44:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsNtd-0005Qv-1V; Mon, 16 Oct 2023 09:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qsNtZ-0005Qj-Iw
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 09:44:33 -0400
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qsNtX-0003h4-DG
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 09:44:32 -0400
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-4194c3cf04aso31980241cf.3
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 06:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697463869; x=1698068669; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M1VDmihaTLElzDm61kNRJgfpjUUt7BzYCjyrutSPMjs=;
 b=TaAFovNczDoAD4WqBFoomp7wS5QKeFOaWH8nEvXa8Y6Wu3qFZkhU5RezvyYZLEBZr7
 kbxcDA2013g+5CgUvEXz1L6uypoUtsZwbhV1Nka1wgz+1DmY/vB22NzDMEFly/zVFZEF
 +xlMmmRBCj8fwAFzJKnaI7ocEz/kc011+Ew+hoY6y2xbTDQJmjtlJdgRZ2WUYw38iUNM
 FCTWzQH5LkpttupMTAYuf6FEsmryIkg1yuVH6Om30WGYsfnC2v+1ShR6VQDyuJyqDJ5R
 Jl/8ZVmGH2yek7bB84msgPjM3XqMOiDjMRbXsfk7ZDJxMDqM9unnFKeDVJd68pVfv1zz
 on/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697463869; x=1698068669;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M1VDmihaTLElzDm61kNRJgfpjUUt7BzYCjyrutSPMjs=;
 b=To0c4YU9L5AcaLaHYrRUqMwvUF2l8aYwHhQhwucE+7CrAslvUP1yCo0B7kczt4o0rO
 4nObpZRM4DQqBlQ8eOeJ1Vvjh/SmoklN+Bzv1ro0lvNVxf50DHSoznuqPJNI2K25yLKE
 oEkxbLkf8+E2wgUaMddMI46HOeU2Xfq7DeDGjSDBOwXB1pNIadjWe6AzJABCXL5GAEAs
 yEkYJzElcvnU7WxMSXPKu39GRzhPC1APV1xgmFWNNZei8g6GozqTTRNnhryQcykFtzZH
 K11ZdE5eY42BgydV1KVYx5x85pA6bN5BRmMZ9P9b8vk+H2H6GbYfYz9HZSbnfR6eVEaj
 gXFQ==
X-Gm-Message-State: AOJu0YypIVqQPmw9he1Lwj45R9cA9DxrRKQ1XAFNUnhUpj8vz440Cqee
 oZD7bkaIfY5I6ab5VQyvi9EOSPSR2ms43GIR974+tiiv5lt+Sg==
X-Google-Smtp-Source: AGHT+IGKGfkVVo+wOodBhInh2miwZqnSMtHuLg9AJCk52e6v2w8xl9HKF8BqBEd0APgriUfJm/6qTRUDWZvvBe9rHFg=
X-Received: by 2002:a05:622a:199d:b0:418:ff8:3833 with SMTP id
 u29-20020a05622a199d00b004180ff83833mr41201606qtc.52.1697463869428; Mon, 16
 Oct 2023 06:44:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231012222643.13996-1-dongwon.kim@intel.com>
In-Reply-To: <20231012222643.13996-1-dongwon.kim@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 16 Oct 2023 17:44:17 +0400
Message-ID: <CAJ+F1CJ3qVG6-aGMFh2L1VW9qwpBZNwZcnU+Tnt+zuh+7-vL0Q@mail.gmail.com>
Subject: Re: [PATCH] ui/gtk-egl: apply scale factor when calculating window's
 dimension
To: Dongwon Kim <dongwon.kim@intel.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x830.google.com
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

On Fri, Oct 13, 2023 at 2:54=E2=80=AFAM Dongwon Kim <dongwon.kim@intel.com>=
 wrote:
>
> Scale factor needs to be applied when calculating width/height of the
> GTK windows.
>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  ui/gtk-egl.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
> index a1060fd80f..45c7544337 100644
> --- a/ui/gtk-egl.c
> +++ b/ui/gtk-egl.c
> @@ -69,15 +69,16 @@ void gd_egl_draw(VirtualConsole *vc)
>  #ifdef CONFIG_GBM
>      QemuDmaBuf *dmabuf =3D vc->gfx.guest_fb.dmabuf;
>  #endif
> -    int ww, wh;
> +    int ww, wh, ws;
>
>      if (!vc->gfx.gls) {
>          return;
>      }
>
>      window =3D gtk_widget_get_window(vc->gfx.drawing_area);
> -    ww =3D gdk_window_get_width(window);
> -    wh =3D gdk_window_get_height(window);
> +    ws =3D gdk_window_get_scale_factor(window);
> +    ww =3D gdk_window_get_width(window) * ws;
> +    wh =3D gdk_window_get_height(window) * ws;
>
>      if (vc->gfx.scanout_mode) {
>  #ifdef CONFIG_GBM
> @@ -312,7 +313,7 @@ void gd_egl_scanout_flush(DisplayChangeListener *dcl,
>  {
>      VirtualConsole *vc =3D container_of(dcl, VirtualConsole, gfx.dcl);
>      GdkWindow *window;
> -    int ww, wh;
> +    int ww, wh, ws;
>
>      if (!vc->gfx.scanout_mode) {
>          return;
> @@ -325,8 +326,9 @@ void gd_egl_scanout_flush(DisplayChangeListener *dcl,
>                     vc->gfx.esurface, vc->gfx.ectx);
>
>      window =3D gtk_widget_get_window(vc->gfx.drawing_area);
> -    ww =3D gdk_window_get_width(window);
> -    wh =3D gdk_window_get_height(window);
> +    ws =3D gdk_window_get_scale_factor(window);
> +    ww =3D gdk_window_get_width(window) * ws;
> +    wh =3D gdk_window_get_height(window) * ws;
>      egl_fb_setup_default(&vc->gfx.win_fb, ww, wh);
>      if (vc->gfx.cursor_fb.texture) {
>          egl_texture_blit(vc->gfx.gls, &vc->gfx.win_fb, &vc->gfx.guest_fb=
,
> --
> 2.20.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

