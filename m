Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1E17CA7EF
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 14:25:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsMde-0006fP-5F; Mon, 16 Oct 2023 08:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qsMdc-0006eu-Aw
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 08:24:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qsMda-0003At-NM
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 08:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697459037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H686rEkqT0Uuuqev+wOErIOYXeKuI5uadVJZRVGGTDg=;
 b=b2QR0G3z4rdxpDuYgSeemNAO7S2sv6tSiOaM3GVew7IzZyhBJQSrHwzgm2XftQ58kI+uW3
 N6GaiLq9RVKgsHShTUuPgTR1bp+xRuKPULomT4HiVtPsP4OlVnPFl272424hWWVcbRJOW7
 DdoROGMXzys3HY+qvoW93TGUkhyPo+Y=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-j8nLcT6RPsaVhdvevJ5WYg-1; Mon, 16 Oct 2023 08:23:55 -0400
X-MC-Unique: j8nLcT6RPsaVhdvevJ5WYg-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-53e02a0ebfdso3257000a12.3
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 05:23:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697459034; x=1698063834;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H686rEkqT0Uuuqev+wOErIOYXeKuI5uadVJZRVGGTDg=;
 b=OKJ2NUBgk5RU0Am5RYAZoMzA7SG7ohaKoH3GaiZ53ZLhukm6PoR7uF6i3cdZl0LvWB
 9xd4aH1j91jQkmkEXwlt6034HY5aIeSm71fH8PMTKUp0tYOOuKZvm729ccUwK5RrfoFx
 CrUHWXDjIOl4ugArLo9yQY88iDcOX/hNm2wi7U0y/26bD2xBh2jKkafdzsNdjFJZdNDN
 yPFKTkeRr2DhL0YfqsXtsEh+iBYHx751FxBCMlRs9QyxExg1ZWBW0tNk2vyA36c6f++B
 VsI9GEvA2DxBqie6lQPYpa1awhcf1UOsepXQR/+/c9hk9Cd7s+rONezzmLm5fAPy1qT/
 5Ivw==
X-Gm-Message-State: AOJu0YzsBiuweom1wKM5ZBoR95uicWH3kRVNGMo+O42rjXhO4hiygTx3
 i7A0Azo9iLd4FZluzZPeceuB2lfzh9flIbwpXfwATVTI6aOAKHiSUINmHmIzOecZy2WFEi5K8du
 on0ujZKKqTAm4f9QMuqygTKrOl6UoGjk=
X-Received: by 2002:aa7:c998:0:b0:530:a226:1f25 with SMTP id
 c24-20020aa7c998000000b00530a2261f25mr27125074edt.17.1697459034572; 
 Mon, 16 Oct 2023 05:23:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJkq195uMxyk3BK64KMW//5U6SxM2Wd1PsFeuogGkAQPaICcvcB/Qb4CuNun9PxPgNi020/DSksIovsRRx04k=
X-Received: by 2002:aa7:c998:0:b0:530:a226:1f25 with SMTP id
 c24-20020aa7c998000000b00530a2261f25mr27125063edt.17.1697459034308; Mon, 16
 Oct 2023 05:23:54 -0700 (PDT)
MIME-Version: 1.0
References: <20231012104448.1251039-1-mironov@fintech.ru>
In-Reply-To: <20231012104448.1251039-1-mironov@fintech.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Oct 2023 16:23:42 +0400
Message-ID: <CAMxuvazb=kfGHoSxs7J95t9i_OGNdd_oTOmGgHe3hMYk2EwoOA@mail.gmail.com>
Subject: Re: [PATCH 1/1] ui: Replacing pointer in function
To: Sergey Mironov <mironov@fintech.ru>
Cc: kraxel@redhat.com, qemu-devel@nongnu.org, 
 Linux Verification Center <sdl.qemu@linuxtesting.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Oct 12, 2023 at 2:46=E2=80=AFPM Sergey Mironov <mironov@fintech.ru>=
 wrote:
>
> At the end of the first if we see 'vc->gfx.surface =3D NULL;',
> further checking of it is pointless. In the second if, ectx is taken.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Co-developed-by: Linux Verification Center <sdl.qemu@linuxtesting.org>
> Signed-off-by: Sergey Mironov <mironov@fintech.ru>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  ui/gtk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/ui/gtk.c b/ui/gtk.c
> index 935de1209b..5da3f9b022 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -1400,7 +1400,7 @@ static void gd_menu_untabify(GtkMenuItem *item, voi=
d *opaque)
>              eglDestroySurface(qemu_egl_display, vc->gfx.esurface);
>              vc->gfx.esurface =3D NULL;
>          }
> -        if (vc->gfx.esurface) {
> +        if (vc->gfx.ectx) {
>              eglDestroyContext(qemu_egl_display, vc->gfx.ectx);
>              vc->gfx.ectx =3D NULL;
>          }
> --
> 2.31.1
>


