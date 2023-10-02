Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B119B7B4FC2
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 11:59:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnFhf-0000Ks-4O; Mon, 02 Oct 2023 05:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qnFhd-0000KD-9H
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 05:59:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qnFhb-0005QX-3s
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 05:59:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696240738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FHsbewKFBfVztItRvIWFoV222Sh+JP/n2uvNaUXcAmw=;
 b=BfjTBVC3lEf7WWlhr7pGhqy/zUs6OS1DVw5gCSwcK3glwO9WjVvmR/JzLl1fXAM0UO4VZm
 0TaZx++yEXjbMCq9MdhW/DplKySypjbi6PPMew3d271qba0PoNGzAyEMgun+Xkbflins19
 JP5+62ITQqXFIlsJbJ+LddgMm5E1/SM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-nk0tXeZZNtCYpxS4OCor4Q-1; Mon, 02 Oct 2023 05:58:41 -0400
X-MC-Unique: nk0tXeZZNtCYpxS4OCor4Q-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-534695ab33eso7540169a12.0
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 02:58:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696240719; x=1696845519;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FHsbewKFBfVztItRvIWFoV222Sh+JP/n2uvNaUXcAmw=;
 b=pKub0DNaWBp+/ELM3ZYVumPenfnEHNK+5iL4fhdCTYm7ZW/XE4M0XRHu6wE5UMhRcr
 1tvx4LEXa+4TX2hfsZLVVH1Cpg7mx5IFFM0aenZuFYCWReB4Z7oCPql4Hg/YUj9+7oTw
 xgyOnhHmLYNg7HiQ4nNbfeyP1RgEjeWa3KYpCpXc22qBInd7X3zvwky0qaaX2ctiuyWx
 26S8RCgQgjQ0TNBQ/tAjyqmQx+mbfRwKrEDw8DAhj+9orYBxbgx452INr+LquizM9ZUS
 hBikd4GnFRXwP4F0zZSljj5kcSpzPi4e4/7PK2/TMR3xBqYBpOgs6/gAsxxefKGOPjA4
 mWDg==
X-Gm-Message-State: AOJu0YxYr5b+6ym8krxcWnZX7mp0gJnIUNxib2VYK7oeM91i+3L2QvN7
 GaukG17RlooHg7+GF/krC0IGE89x16pwFWvoeacmxz8CsfjTWrrHq/GGC97PKwJ2Il0zf9dDWBi
 tiy2oQ9U9XJPsV9meGxNcHu8C28U1T00cAMoPsPoecw==
X-Received: by 2002:a50:fa85:0:b0:525:570c:566b with SMTP id
 w5-20020a50fa85000000b00525570c566bmr9411153edr.22.1696240719457; 
 Mon, 02 Oct 2023 02:58:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpusuz99FDsO5MYipAINUUfTDYjoXNMGM3+6aqQBpVEKlov+u+GK2hIUu+4IMC8VvWiFBkeKWGAexG5v+//Yw=
X-Received: by 2002:a50:fa85:0:b0:525:570c:566b with SMTP id
 w5-20020a50fa85000000b00525570c566bmr9411143edr.22.1696240719153; Mon, 02 Oct
 2023 02:58:39 -0700 (PDT)
MIME-Version: 1.0
References: <20231002095445.65311-1-pbonzini@redhat.com>
In-Reply-To: <20231002095445.65311-1-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 2 Oct 2023 13:58:27 +0400
Message-ID: <CAMxuvazkydMV9YP9HJrdwNnTOAyy8W8DqJykRM2civmPmk2m2Q@mail.gmail.com>
Subject: Re: [PATCH v2] ui: fix dpy_ui_info_supported(con) assertion
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Hi

On Mon, Oct 2, 2023 at 1:54=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> VGA does not support getting the physical video size or refresh rate.
> This is causing an assertion failure when the GTK+ user interface
> calls dpy_get_ui_info().  Return NULL from dpy_get_ui_info() if the
> information is not supported, and just ignore the request to set
> refresh rate or size in that case.
>
> While the assertion failure was introduced by commit a92e7bb4cad
> ("ui: add precondition for dpy_get_ui_info()", 2023-09-12), QEMU had
> been using con->ui_info incorrectly since before.
>
> Fixes: a92e7bb4cad ("ui: add precondition for dpy_get_ui_info()", 2023-09=
-12)
> Fixes: aeffd071ed8 ("ui: Deliver refresh rate via QemuUIInfo", 2022-06-14=
)
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Did you see my patch ?
https://lore.kernel.org/qemu-devel/20230915113637.2127644-1-marcandre.lurea=
u@redhat.com/

I think I prefer mine :)

> ---
>  ui/console.c |  4 +++-
>  ui/gtk.c     | 18 ++++++++++++++++--
>  2 files changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/ui/console.c b/ui/console.c
> index 4a4f19ed33e..24438b187c8 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -815,7 +815,9 @@ bool dpy_ui_info_supported(const QemuConsole *con)
>
>  const QemuUIInfo *dpy_get_ui_info(const QemuConsole *con)
>  {
> -    assert(dpy_ui_info_supported(con));
> +    if (!dpy_ui_info_supported(con)) {
> +        return NULL;
> +    }
>
>      if (con =3D=3D NULL) {
>          con =3D active_console;
> diff --git a/ui/gtk.c b/ui/gtk.c
> index e09f97a86b7..0b5e314cf0d 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -724,18 +724,32 @@ static gboolean gd_window_close(GtkWidget *widget, =
GdkEvent *event,
>
>  static void gd_set_ui_refresh_rate(VirtualConsole *vc, int refresh_rate)
>  {
> +    const QemuUIInfo *p_info;
>      QemuUIInfo info;
>
> -    info =3D *dpy_get_ui_info(vc->gfx.dcl.con);
> +    p_info =3D dpy_get_ui_info(vc->gfx.dcl.con);
> +    if (!p_info) {
> +        /* not supported by guest */
> +        return;
> +    }
> +
> +    info =3D *p_info;
>      info.refresh_rate =3D refresh_rate;
>      dpy_set_ui_info(vc->gfx.dcl.con, &info, true);
>  }
>
>  static void gd_set_ui_size(VirtualConsole *vc, gint width, gint height)
>  {
> +    const QemuUIInfo *p_info;
>      QemuUIInfo info;
>
> -    info =3D *dpy_get_ui_info(vc->gfx.dcl.con);
> +    p_info =3D dpy_get_ui_info(vc->gfx.dcl.con);
> +    if (!p_info) {
> +        /* not supported by guest */
> +        return;
> +    }
> +
> +    info =3D *p_info;
>      info.width =3D width;
>      info.height =3D height;
>      dpy_set_ui_info(vc->gfx.dcl.con, &info, true);
> --
> 2.41.0
>


