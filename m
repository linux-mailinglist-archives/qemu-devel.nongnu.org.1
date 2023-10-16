Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2357CA817
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 14:35:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsMns-0001YW-IX; Mon, 16 Oct 2023 08:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qsMne-0001Tg-1W
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 08:34:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qsMnb-00052B-6Q
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 08:34:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697459658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9QW6YFSV7BB/Pk2JungceJUOF9BWftd66Nx88g6lck4=;
 b=LKYw9xFRvhRRKQqB1/6/5CGlttiuQZ+/z53kdUf3Gec464BcfvQD/jycFeW7YG/Zh54zsK
 zvaDNrH+BXiXPJZnSGeGjALogUUwmF/zB2H25AwzfMu0ZC2w/1fH0Rw9H1r6F7o8I0m6QC
 xTVL+jbbp2nbZS56qB5hFFAI8NMsHRQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-q9X41H9APVqgynJnlaMRyg-1; Mon, 16 Oct 2023 08:34:16 -0400
X-MC-Unique: q9X41H9APVqgynJnlaMRyg-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5344aaf2703so3358344a12.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 05:34:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697459655; x=1698064455;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9QW6YFSV7BB/Pk2JungceJUOF9BWftd66Nx88g6lck4=;
 b=EpEZ/Fv8TrpmsxoqNjMHBkILbyjzeccW8jIZwFz27Qs66Mb9+u8Xz7Elo/xEnqTlbd
 EMsHczezvAYgnwjXY+E5X6O/Te7Bdh9Gk3DwuGUuZHyJVqNkVhs0y+HL9Tl03hDIP90Z
 Bjvxs2xAhxYvw2jTT4lO4TM3OQk3kIlJBEGJwckv6i6yU6AQc34xwhpK7UPoniinNWy+
 ia2ZP/D1a7evkd3zMVDbc8TLXsVjLKOGU6DBaRiSKN2Xp9JkI/kADU95/F3cXWtOvHL3
 1v2fKt5rc/wgZr+nC9o/gzpzbxDrJKs6R+M0U6pnlKyfF1YJE0AXPhKtIBcwrrWHLcyA
 ZQKA==
X-Gm-Message-State: AOJu0Yx4qD9NJni36mi8jum89uHpcdLAiH5IiaiYzA/j8245VhOy8BBU
 84fJbA3z3jWbaAYHuXylKy8hqThwXHgd1y1VsTWXEblaNil+g3cRCt1lRb91JzvaMmP31T4i02c
 R4HyYzy3Hu4Jxa0uHEcI2JHaQoeOxMFA=
X-Received: by 2002:a50:aa96:0:b0:53e:4762:9373 with SMTP id
 q22-20020a50aa96000000b0053e47629373mr7222301edc.18.1697459655628; 
 Mon, 16 Oct 2023 05:34:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgQsG2UEj9xHXuqF/O9vqZ1HmsvqLn8MSqM+0R7GvidK/K0Q1DC2GCwtNUlmFwkul9BoboDP3/SBueymzPxmI=
X-Received: by 2002:a50:aa96:0:b0:53e:4762:9373 with SMTP id
 q22-20020a50aa96000000b0053e47629373mr7222295edc.18.1697459655288; Mon, 16
 Oct 2023 05:34:15 -0700 (PDT)
MIME-Version: 1.0
References: <20231012222438.13853-1-dongwon.kim@intel.com>
In-Reply-To: <20231012222438.13853-1-dongwon.kim@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Oct 2023 16:34:03 +0400
Message-ID: <CAMxuvawxX8+o-dm3rNFHo-OtA-aMJfLFoaub299Zs-khzDLgxA@mail.gmail.com>
Subject: Re: [PATCH] ui/gtk: full-screening all detached windows
To: Dongwon Kim <dongwon.kim@intel.com>
Cc: qemu-devel@nongnu.org
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

Hi

On Fri, Oct 13, 2023 at 2:51=E2=80=AFAM Dongwon Kim <dongwon.kim@intel.com>=
 wrote:
>
> When turning on or off full-screen menu, all detached windows should
> be full-screened or un-full-screened altogether.

I am not convinced this is desirable. Not only having multiple
fullscreen windows on the same screen is usually a bit harder to deal
with. You typically want one imho.

But the most annoying thing is probably that detached windows/consoles
do not have the same shortcuts as the main window, and you can't
unfullscreen them then...

Wouldn't you prefer to have a working fullscreen keyboard shortcut for
detached tabs instead? This way, each window can be toggled
full/unfull individually.

thanks

>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> ---
>  ui/gtk.c | 44 ++++++++++++++++++++++++++++++++++----------
>  1 file changed, 34 insertions(+), 10 deletions(-)
>
> diff --git a/ui/gtk.c b/ui/gtk.c
> index 935de1209b..3a380f8d59 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -1452,29 +1452,53 @@ static void gd_accel_show_menubar(void *opaque)
>  static void gd_menu_full_screen(GtkMenuItem *item, void *opaque)
>  {
>      GtkDisplayState *s =3D opaque;
> -    VirtualConsole *vc =3D gd_vc_find_current(s);
> +    VirtualConsole *vc;
> +    int i;
>
>      if (!s->full_screen) {
>          gtk_notebook_set_show_tabs(GTK_NOTEBOOK(s->notebook), FALSE);
>          gtk_widget_hide(s->menu_bar);
> -        if (vc->type =3D=3D GD_VC_GFX) {
> -            gtk_widget_set_size_request(vc->gfx.drawing_area, -1, -1);
> -        }
> -        gtk_window_fullscreen(GTK_WINDOW(s->window));
>          s->full_screen =3D TRUE;
> +        gtk_window_fullscreen(GTK_WINDOW(s->window));
> +
> +        for (i =3D 0; i < s->nb_vcs; i++) {
> +            vc =3D &s->vc[i];
> +            if (!vc->window) {
> +                continue;
> +            }
> +            if (vc->type =3D=3D GD_VC_GFX) {
> +                gtk_widget_set_size_request(vc->gfx.drawing_area, -1, -1=
);
> +            }
> +            gtk_window_fullscreen(GTK_WINDOW(vc->window));
> +        }
>      } else {
>          gtk_window_unfullscreen(GTK_WINDOW(s->window));
> +
> +        for (i =3D 0; i < s->nb_vcs; i++) {
> +            vc =3D &s->vc[i];
> +            if (!vc->window) {
> +                continue;
> +            }
> +            gtk_window_unfullscreen(GTK_WINDOW(vc->window));
> +
> +            if (vc->type =3D=3D GD_VC_GFX) {
> +                vc->gfx.scale_x =3D 1.0;
> +                vc->gfx.scale_y =3D 1.0;
> +                gd_update_windowsize(vc);
> +            }
> +        }
> +
>          gd_menu_show_tabs(GTK_MENU_ITEM(s->show_tabs_item), s);
>          if (gtk_check_menu_item_get_active(
>                      GTK_CHECK_MENU_ITEM(s->show_menubar_item))) {
>              gtk_widget_show(s->menu_bar);
>          }
>          s->full_screen =3D FALSE;
> -        if (vc->type =3D=3D GD_VC_GFX) {
> -            vc->gfx.scale_x =3D 1.0;
> -            vc->gfx.scale_y =3D 1.0;
> -            gd_update_windowsize(vc);
> -        }
> +    }
> +
> +    vc =3D gd_vc_find_current(s);
> +    if (!vc) {
> +        return;
>      }
>
>      gd_update_cursor(vc);
> --
> 2.20.1
>


