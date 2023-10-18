Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5EA7CD43E
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 08:19:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qszsR-0002xk-Cp; Wed, 18 Oct 2023 02:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qszsN-0002wS-1o
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 02:17:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qszs9-0006qo-DY
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 02:17:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697609856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZDDLzOIAg6GvgSicVc0pzO+zlRjHuWM4sAbID1q+nJc=;
 b=WN2pNBQKfJZTzs9y6KB6hYvio8SPCCi5RtgMcywdHyYDuFf7GAkbeVHJlIM9I1RCdt+2SG
 P54iEY7ObvTwJ7TwyTOHVBhUBX9Cj3qdKK/UIP5iUDAjiB9BupECnm/0nMN/tcpmG0m6DF
 WnviMaVyf6wFTyWaT/SYXAIPk57pOoA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-qGzyIOZbNwuGhqOJ602azg-1; Wed, 18 Oct 2023 02:17:34 -0400
X-MC-Unique: qGzyIOZbNwuGhqOJ602azg-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-53e1fe5b328so4631390a12.1
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 23:17:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697609853; x=1698214653;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZDDLzOIAg6GvgSicVc0pzO+zlRjHuWM4sAbID1q+nJc=;
 b=KZA9XXayyYeWek6pCV67cQElh+wVLvyEx3aSRng6lJ5MRCO76x1pdtlWtn1U+mQLxM
 kvkFVgGwVQrtcL3sVc2luIeSuMGjF652C5koERJoSUKfA5mTxgTV6Xy08bt80l9+bCbC
 1V5gTug6qvLBHaAXBH4dOyaYhdogvc7URCbGfP0WmDFaXIKN2dS+JnwwsaZIomlo1oad
 gF0H0CnipFdVZcVkDCZpLMa7JXKxL4tox2w8RAaejSMz2Vfixhlo5evYlp260fDpt5Fd
 /mvhemMVkePKZNQN4/S/70QBfgyFBErPldE43bdH5gXhO2Az2TzPYqQQ3ejOg2BR7lOY
 vkcw==
X-Gm-Message-State: AOJu0YwkU/J/qTTetN8l/fByzwhtP9DjZ4+nYtau5RM5wzTVxzJY16dN
 WrZYuJEr5bO2z8qGhNFgVUUrwUdla/KAayZPrVHTz8jsi9gSJstEbexmUeRXJLHArqkUVZfEZpQ
 +TQdJSBq613ULvQucEneHsVpL6QwtYZ3CQHKqjG0=
X-Received: by 2002:a05:6402:3550:b0:530:a186:f8a8 with SMTP id
 f16-20020a056402355000b00530a186f8a8mr3530557edd.37.1697609852971; 
 Tue, 17 Oct 2023 23:17:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJg+vCMHSDZ40B9EB7r4TV/oHhUqs1MTkzbIrl4cDDYp3wmxdwJlYRMQaxuXAIL6tCinU6nEKRQgf8w7AHIw8=
X-Received: by 2002:a05:6402:3550:b0:530:a186:f8a8 with SMTP id
 f16-20020a056402355000b00530a186f8a8mr3530545edd.37.1697609852663; Tue, 17
 Oct 2023 23:17:32 -0700 (PDT)
MIME-Version: 1.0
References: <20231012222438.13853-1-dongwon.kim@intel.com>
 <CAMxuvawxX8+o-dm3rNFHo-OtA-aMJfLFoaub299Zs-khzDLgxA@mail.gmail.com>
 <PH8PR11MB6879025B167EF9219023D91EFAD6A@PH8PR11MB6879.namprd11.prod.outlook.com>
In-Reply-To: <PH8PR11MB6879025B167EF9219023D91EFAD6A@PH8PR11MB6879.namprd11.prod.outlook.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 18 Oct 2023 10:17:21 +0400
Message-ID: <CAMxuvayrza86DssyJYVG3JTgjw-ZZFqJph-Y5kah6TtX26bkxQ@mail.gmail.com>
Subject: Re: [PATCH] ui/gtk: full-screening all detached windows
To: "Kim, Dongwon" <dongwon.kim@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
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

On Wed, Oct 18, 2023 at 3:45=E2=80=AFAM Kim, Dongwon <dongwon.kim@intel.com=
> wrote:
>
> Hi Marc-Andr=C3=A9,
>
> > Hi
> >
> > On Fri, Oct 13, 2023 at 2:51=E2=80=AFAM Dongwon Kim <dongwon.kim@intel.=
com>
> > wrote:
> > >
> > > When turning on or off full-screen menu, all detached windows should
> > > be full-screened or un-full-screened altogether.
> >
> > I am not convinced this is desirable. Not only having multiple fullscre=
en windows
> > on the same screen is usually a bit harder to deal with. You typically =
want one
> > imho.
> >
> > But the most annoying thing is probably that detached windows/consoles =
do not
> > have the same shortcuts as the main window, and you can't unfullscreen =
them
> > then...
> >
> > Wouldn't you prefer to have a working fullscreen keyboard shortcut for
> > detached tabs instead? This way, each window can be toggled full/unfull
> > individually.
>
> [DW] That is right. Two detached windows on the same display would be ove=
rlapped, which will be ugly. I also thought about that as well as other und=
esirable situations but my initial thought was the full-screen
> menu is global and all QEMU windows should be controlled by it. Anyhow, I=
 like your idea about individual control.. so we would probably need to add=
 more full-screen menus, like 'fullscreen1, fullscreen2, fullscreen3..."
> to the menu then also assign a hotkey to each one of them?

The same shortcut should be used, only it applies to the currently
focused window.

>
> >
> > thanks
> >
> > >
> > > Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > > Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> > > ---
> > >  ui/gtk.c | 44 ++++++++++++++++++++++++++++++++++----------
> > >  1 file changed, 34 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/ui/gtk.c b/ui/gtk.c
> > > index 935de1209b..3a380f8d59 100644
> > > --- a/ui/gtk.c
> > > +++ b/ui/gtk.c
> > > @@ -1452,29 +1452,53 @@ static void gd_accel_show_menubar(void
> > > *opaque)  static void gd_menu_full_screen(GtkMenuItem *item, void
> > > *opaque)  {
> > >      GtkDisplayState *s =3D opaque;
> > > -    VirtualConsole *vc =3D gd_vc_find_current(s);
> > > +    VirtualConsole *vc;
> > > +    int i;
> > >
> > >      if (!s->full_screen) {
> > >          gtk_notebook_set_show_tabs(GTK_NOTEBOOK(s->notebook), FALSE)=
;
> > >          gtk_widget_hide(s->menu_bar);
> > > -        if (vc->type =3D=3D GD_VC_GFX) {
> > > -            gtk_widget_set_size_request(vc->gfx.drawing_area, -1, -1=
);
> > > -        }
> > > -        gtk_window_fullscreen(GTK_WINDOW(s->window));
> > >          s->full_screen =3D TRUE;
> > > +        gtk_window_fullscreen(GTK_WINDOW(s->window));
> > > +
> > > +        for (i =3D 0; i < s->nb_vcs; i++) {
> > > +            vc =3D &s->vc[i];
> > > +            if (!vc->window) {
> > > +                continue;
> > > +            }
> > > +            if (vc->type =3D=3D GD_VC_GFX) {
> > > +                gtk_widget_set_size_request(vc->gfx.drawing_area, -1=
, -1);
> > > +            }
> > > +            gtk_window_fullscreen(GTK_WINDOW(vc->window));
> > > +        }
> > >      } else {
> > >          gtk_window_unfullscreen(GTK_WINDOW(s->window));
> > > +
> > > +        for (i =3D 0; i < s->nb_vcs; i++) {
> > > +            vc =3D &s->vc[i];
> > > +            if (!vc->window) {
> > > +                continue;
> > > +            }
> > > +            gtk_window_unfullscreen(GTK_WINDOW(vc->window));
> > > +
> > > +            if (vc->type =3D=3D GD_VC_GFX) {
> > > +                vc->gfx.scale_x =3D 1.0;
> > > +                vc->gfx.scale_y =3D 1.0;
> > > +                gd_update_windowsize(vc);
> > > +            }
> > > +        }
> > > +
> > >          gd_menu_show_tabs(GTK_MENU_ITEM(s->show_tabs_item), s);
> > >          if (gtk_check_menu_item_get_active(
> > >                      GTK_CHECK_MENU_ITEM(s->show_menubar_item))) {
> > >              gtk_widget_show(s->menu_bar);
> > >          }
> > >          s->full_screen =3D FALSE;
> > > -        if (vc->type =3D=3D GD_VC_GFX) {
> > > -            vc->gfx.scale_x =3D 1.0;
> > > -            vc->gfx.scale_y =3D 1.0;
> > > -            gd_update_windowsize(vc);
> > > -        }
> > > +    }
> > > +
> > > +    vc =3D gd_vc_find_current(s);
> > > +    if (!vc) {
> > > +        return;
> > >      }
> > >
> > >      gd_update_cursor(vc);
> > > --
> > > 2.20.1
> > >
>


