Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDEC7E97A6
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 09:28:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2SHJ-0006m2-Ev; Mon, 13 Nov 2023 03:26:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1r2SHI-0006lp-BB
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 03:26:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1r2SH8-0001DJ-0a
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 03:26:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699863987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=06yXYidmqk9Nm6bwK41QH8HnV5UeRnm5mkkl07P0LAQ=;
 b=et/fzV8wC9xxmahU3m2YBhmImomeQ1jSZx93JXgvnqQw7WSv3Ny3FoZ2i7331CaMYrgix2
 EUkBf5rA5RYeymXG5y6AImdgvl0TNXrxY3C2SajwslaoUmx0JKHqSrX8OTsQ+7TaAEJc0u
 bamkzSHzKSk++O7dDJbSF/OvYzZUhQ0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-lHl6IjGZM5iU1ZroTD51xA-1; Mon, 13 Nov 2023 03:26:25 -0500
X-MC-Unique: lHl6IjGZM5iU1ZroTD51xA-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-53e02a0ebfdso2894380a12.3
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 00:26:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699863984; x=1700468784;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=06yXYidmqk9Nm6bwK41QH8HnV5UeRnm5mkkl07P0LAQ=;
 b=AkS9rsIrteMEZFVJiEgHYd61zk8tTINNYTtWnLPNxC6KFI7tmRz14oIejv9Kmi5UcE
 QAqht0gXY3Y2Fd3imN0E8j+/XysCRGsRLJMB+uqjKllSsEV2i7ONDq5S48Qpa2NiwM6a
 b+QbGY66DY9bn8jT2M2bvTTeH6a1Ph3faXACBo3Pjzebip6V93yl1iInNrLjRV9E5/gI
 kTD+XK5NXoYIlor8gb+g4Nn7OrqnyZx9adhJZFEbsOA6a/QezvxtYm/7EU/b4tIeFMIf
 Ms0/vMtfw8kI4hgUzQ4IF88AfoEDeNSv9sb8wJUddUt99gxeOCqpuOuiwcPXKdCTZIoi
 G3Rw==
X-Gm-Message-State: AOJu0YxCbyXbR9eBdKMhU4UMrEtCW+wxz0vcz8cyCZXZrBPufwMgQYX8
 mKwdnIaAeTxtyQfoKP6toVVi4xU3pA1ImjG1Ui981ILxgYvPUNFsh+mFLsNFoFDvZJI0wvuY6rl
 /DLmZGr5YLwP0DTBtPM/OHI4rTbxCU5g=
X-Received: by 2002:aa7:d90f:0:b0:543:e42e:128e with SMTP id
 a15-20020aa7d90f000000b00543e42e128emr4323817edr.37.1699863984633; 
 Mon, 13 Nov 2023 00:26:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrJo4Q2AyPBqolZ0gj3RpCPGStyAxa0unWdxClAuFNjCyQmS49/9GcjlMbuUd9tYx+zIitk+RHFnK9gI2Dr30=
X-Received: by 2002:aa7:d90f:0:b0:543:e42e:128e with SMTP id
 a15-20020aa7d90f000000b00543e42e128emr4323804edr.37.1699863984319; Mon, 13
 Nov 2023 00:26:24 -0800 (PST)
MIME-Version: 1.0
References: <20231111104020.26183-1-vr_qemu@t-online.de>
In-Reply-To: <20231111104020.26183-1-vr_qemu@t-online.de>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 13 Nov 2023 12:26:12 +0400
Message-ID: <CAMxuvayBODa5TnVYxYj5herX9EeWxTteNp3a83z-r9KHyfRHLw@mail.gmail.com>
Subject: Re: [PATCH for 8.2] ui/gtk-egl: move function calls back to regular
 code path
To: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Sat, Nov 11, 2023 at 2:40=E2=80=AFPM Volker R=C3=BCmelin <vr_qemu@t-onli=
ne.de> wrote:
>
> Commit 6f189a08c1 ("ui/gtk-egl: Check EGLSurface before doing
> scanout") introduced a regression when QEMU is running with a
> virtio-gpu-gl-device on a host under X11. After the guest has
> initialized the virtio-gpu-gl-device, the guest screen only
> shows "Display output is not active.".
>
> Commit 6f189a08c1 moved all function calls in
> gd_egl_scanout_texture() to a code path which is only called
> once after gd_egl_init() succeeds in gd_egl_scanout_texture().
> Move all function calls in gd_egl_scanout_texture() back to
> the regular code path so they get always called if one of the
> gd_egl_init() calls was successful.
>
> Fixes: 6f189a08c1 ("ui/gtk-egl: Check EGLSurface before doing scanout")
> Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  ui/gtk-egl.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
> index cd2f176502..3af5ac5bcf 100644
> --- a/ui/gtk-egl.c
> +++ b/ui/gtk-egl.c
> @@ -249,14 +249,14 @@ void gd_egl_scanout_texture(DisplayChangeListener *=
dcl,
>          if (!vc->gfx.esurface) {
>              return;
>          }
> +    }
>
> -        eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
> -                       vc->gfx.esurface, vc->gfx.ectx);
> +    eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
> +                   vc->gfx.esurface, vc->gfx.ectx);
>
> -        gtk_egl_set_scanout_mode(vc, true);
> -        egl_fb_setup_for_tex(&vc->gfx.guest_fb, backing_width, backing_h=
eight,
> -                             backing_id, false);
> -    }
> +    gtk_egl_set_scanout_mode(vc, true);
> +    egl_fb_setup_for_tex(&vc->gfx.guest_fb, backing_width, backing_heigh=
t,
> +                         backing_id, false);
>  }
>
>  void gd_egl_scanout_dmabuf(DisplayChangeListener *dcl,
> --
> 2.35.3
>


