Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5637E7CA734
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 13:55:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsMB9-0002VG-CB; Mon, 16 Oct 2023 07:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qsMB5-0002V5-AX
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 07:54:31 -0400
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qsMB3-00052n-0r
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 07:54:30 -0400
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-419cc494824so31368361cf.2
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 04:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697457268; x=1698062068; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TkGcnTgRWBr6z7Eue5ruetKht8AUadKZ6hrEzetJzsg=;
 b=MXrAaPBVrCnfrMGzE5Payzb2FJ0lRDOBWMs8ucAEkPfM3bZ4l249vA6Y9ucv+SMBsY
 iebreJLG5fpMYoYS6TNTXr0I5lkBGmJY/r4f3xSVvZ9TcM8L1lVV2DVuWe9MABXLOhUt
 cuxyC0TkBNTnzR9UoJyHjQ14bhGcWFW9jKcFBJklp/uCzLRSfbjnOiUkw1PbAC7Nnt5I
 oYnqyfi1ohIX2+GcONBTNViSngCTPxuDY4jb02XzL5YfBQIfSWaQ2sgnTlubSH+xk2dP
 u9lJ8CzCXmmqRD7t9uOMB7CbnrdQqYv2XuI3/fQpPVgd/uweZuheolEqvx4E060I/Plk
 Jifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697457268; x=1698062068;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TkGcnTgRWBr6z7Eue5ruetKht8AUadKZ6hrEzetJzsg=;
 b=vzth7Oaz744O1Ipdjb+hcSJEktXER9DOL1NMeYN4LkTn2WmgngAfvNsFDYPgPaP1h+
 QTvOjYKmjms7tNXlWKc/ELthIEJb4tPqRKJEvjOYm459D3RwxWLRtQfjHfLNmQswXydV
 eUNhdi+CVLDOb4YuqsPFLfbH2JENvYarm34tyFc967qrJGLr4NNTwHcg7Dh0xhlcDYn/
 b1ueBC0qK2yxm3HW6eaJyNPx+ilngwruuVlgUDjOd/uGfwC1gKMaDmd14SvPj1XAxjTC
 prgOmvpoyW2GPxbz52rpPKwWdiRiTE53sazVwgKSyIAYPl3WcrvECuH2ql/0vL9QpZAG
 oyKg==
X-Gm-Message-State: AOJu0YzbDLN59H5qCAmQ3aN23Bd8L/CqgCue60U6FZQ2HZNcwTKmL/B4
 L6Li54dPjJEq+TJiUsz7OIez4/cGK/vU9qcyXdMhl5PAB3Cg7g==
X-Google-Smtp-Source: AGHT+IHW65hyyy3z5K5RocVFBc+zIR+VSNXuLnATVchsBSD1yHg3J/0IalS4uQ13QqyqawXDyY0yIsgQW+brAK+ZT0E=
X-Received: by 2002:ac8:5813:0:b0:418:1e88:83ca with SMTP id
 g19-20020ac85813000000b004181e8883camr45046993qtg.40.1697457267790; Mon, 16
 Oct 2023 04:54:27 -0700 (PDT)
MIME-Version: 1.0
References: <20231013151758.1472603-1-quic_acaggian@quicinc.com>
In-Reply-To: <20231013151758.1472603-1-quic_acaggian@quicinc.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 16 Oct 2023 15:54:16 +0400
Message-ID: <CAJ+F1CL0781JA30C4w_o2jWB9K=WampzGUeqLqj3q+RnTSw8qg@mail.gmail.com>
Subject: Re: [PATCH] ui/gtk-egl: Check EGLSurface before doing scanout
To: Antonio Caggiano <quic_acaggian@quicinc.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::836;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x836.google.com
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

On Fri, Oct 13, 2023 at 7:18=E2=80=AFPM Antonio Caggiano
<quic_acaggian@quicinc.com> wrote:
>
> The first time gd_egl_scanout_texture() is called, there's a possibility
> that the GTK drawing area might not be realized yet, in which case its
> associated GdkWindow is NULL. This means gd_egl_init() was also skipped
> and the EGLContext and EGLSurface stored in the VirtualGfxConsole are
> not valid yet.
>
> Continuing with the scanout in this conditions would result in hitting
> an assert in libepoxy: "Couldn't find current GLX or EGL context".
>
> A possible workaround is to just ignore the scanout request, giving the
> the GTK drawing area some time to finish its realization. At that point,
> the gd_egl_init() will succeed and the EGLContext and EGLSurface stored
> in the VirtualGfxConsole will be valid.
>
> Signed-off-by: Antonio Caggiano <quic_acaggian@quicinc.com>
> ---
>  ui/gtk-egl.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
> index a1060fd80f..2eefcd2cf4 100644
> --- a/ui/gtk-egl.c
> +++ b/ui/gtk-egl.c
> @@ -243,12 +243,19 @@ void gd_egl_scanout_texture(DisplayChangeListener *=
dcl,
>      vc->gfx.h =3D h;
>      vc->gfx.y0_top =3D backing_y_0_top;
>
> -    eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
> -                   vc->gfx.esurface, vc->gfx.ectx);
> +    if (!vc->gfx.esurface) {
> +        gd_egl_init(vc);
> +        if (!vc->gfx.esurface) {
> +            return;
> +        }
>
> -    gtk_egl_set_scanout_mode(vc, true);
> -    egl_fb_setup_for_tex(&vc->gfx.guest_fb, backing_width, backing_heigh=
t,
> -                         backing_id, false);
> +        eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
> +                       vc->gfx.esurface, vc->gfx.ectx);
> +

trailing whitespace

> +        gtk_egl_set_scanout_mode(vc, true);
> +        egl_fb_setup_for_tex(&vc->gfx.guest_fb, backing_width, backing_h=
eight,
> +                             backing_id, false);
> +    }
>  }
>
>  void gd_egl_scanout_dmabuf(DisplayChangeListener *dcl,

otherwise, lgtm
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

--=20
Marc-Andr=C3=A9 Lureau

