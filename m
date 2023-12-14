Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 622F0813A81
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 20:12:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDr6q-0005WU-Bb; Thu, 14 Dec 2023 14:11:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1rDr6j-0005W1-PT
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 14:10:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1rDr6h-0006rP-No
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 14:10:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702581050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DDK9LbNcwepmCLuQUn7sZNwGzYi5VpWXYAMrSIHovq8=;
 b=RpNjNa9uqy391MoMR/wP34kKctY0Yy36KSqQ22so9eCAM6P+Q8lHmH3dKVVu4UjKxlLWOd
 etbYhbCC+ZHNotqWTA7UdYpfewh6p4EIzoDwSUm6lj3jwIkEDDluNFRX/bW+Vo7VltY1oT
 5tdHYB0xoV9N0RQ+TYlS3k6S8hDT+JY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-kDmZJ4ZaPDi-GV4G18Dajw-1; Thu, 14 Dec 2023 14:10:48 -0500
X-MC-Unique: kDmZJ4ZaPDi-GV4G18Dajw-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5528b4ab7bbso227302a12.0
 for <qemu-devel@nongnu.org>; Thu, 14 Dec 2023 11:10:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702581047; x=1703185847;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DDK9LbNcwepmCLuQUn7sZNwGzYi5VpWXYAMrSIHovq8=;
 b=cRg06t5f0cNFPcXqozdLr5ZgeiHFRWm/HC1fDuHh8LFmcGewp4W69XgbQ2ffbSuy4/
 +OcDYt4/veBTe+u4nmdNz9MMgRCMV+QKBhbLK8L+T/YWf/H7xZjj0R+cukQ1GScUTiZe
 i3eZgViJdxxF46XFlHPw2s/gFnmRVQF1ARozGueSjKepLj3G8dt/Ar0DuCqGbYfmmNk6
 HoSwXi4y1FbClTBjBJzqP2UmBwTFFCl+YFenKSY4iiS4taaJmld6afhcTETPnu5uX/Qy
 nO2jutj0pGZwpU2EecC87KEZibeJY3YwqSe/BeF2CcpvKLkWaIRFRccAb7ifhpFmeTMO
 GtSQ==
X-Gm-Message-State: AOJu0YwgthXs4lqI/ERW33LI2aOmE9HaNEqR2UZuT/b7UQWXct31et6K
 7hVm2DtawOc+j8tcxDcNdOzS2aUUdyjKvLVr+ZvFVDb6NO7hX1kar0Rc9Dz+HoOl7oJ8af2w4go
 9sPqI2AvEmCqCMPAZjCDscNkxJEJixcc=
X-Received: by 2002:a50:99d6:0:b0:552:2086:f1f2 with SMTP id
 n22-20020a5099d6000000b005522086f1f2mr741949edb.83.1702581047000; 
 Thu, 14 Dec 2023 11:10:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkSA8HuRkepxjXo4uRd9S7nGAsxFiXJbCjTrOKrDyIlM5D46ka2e4IShL39LlyfAP84meNe+gDfotyGTcpcm4=
X-Received: by 2002:a50:99d6:0:b0:552:2086:f1f2 with SMTP id
 n22-20020a5099d6000000b005522086f1f2mr741947edb.83.1702581046711; Thu, 14 Dec
 2023 11:10:46 -0800 (PST)
MIME-Version: 1.0
References: <20231214-help-v1-1-23823ac5a023@daynix.com>
 <9443821d-5eff-46e6-be69-707cca9cd0d0@linaro.org>
In-Reply-To: <9443821d-5eff-46e6-be69-707cca9cd0d0@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 14 Dec 2023 23:10:35 +0400
Message-ID: <CAMxuvaxMUcOgs8KC_6ffh4N3E4A-hnRin5r7Rxbmdv-BPZZgaA@mail.gmail.com>
Subject: Re: [PATCH] vl: Print display options for -display help
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 qemu-devel@nongnu.org
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Dec 14, 2023 at 1:29=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Hi Akihiko,
>
> On 14/12/23 07:47, Akihiko Odaki wrote:
> > -display lists display backends, but does not tell their options.
> > Use the help messages from qemu-options.def, which include the list of
> > options.
> >
> > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > ---
> >   include/ui/console.h |  1 -
> >   system/vl.c          | 11 ++++++-----
> >   ui/console.c         | 20 --------------------
> >   3 files changed, 6 insertions(+), 26 deletions(-)
>
>
> > diff --git a/ui/console.c b/ui/console.c
> > index 7db921e3b7d6..6aee5e9a7ffb 100644
> > --- a/ui/console.c
> > +++ b/ui/console.c
> > @@ -1691,23 +1691,3 @@ const char *qemu_display_get_vc(DisplayOptions *=
opts)
> >       }
> >       return vc;
> >   }
> > -
> > -void qemu_display_help(void)
> > -{
> > -    int idx;
> > -
> > -    printf("Available display backend types:\n");
> > -    printf("none\n");
> > -    for (idx =3D DISPLAY_TYPE_NONE; idx < DISPLAY_TYPE__MAX; idx++) {
> > -        if (!dpys[idx]) {
> > -            Error *local_err =3D NULL;
> > -            int rv =3D ui_module_load(DisplayType_str(idx), &local_err=
);
> > -            if (rv < 0) {
> > -                error_report_err(local_err);
> > -            }
> > -        }
> > -        if (dpys[idx]) {
> > -            printf("%s\n",  DisplayType_str(dpys[idx]->type));
>
> Is the "qapi/qapi-commands-ui.h" header still necessary?
>
> > -        }
> > -    }
> > -}
>
> So we go from:
>
> $ ./qemu-system-aarch64 -display help
> Available display backend types:
> none
> gtk
> sdl
> curses
> cocoa
> dbus

I think this used to show only the available display/ui modules

>
> to:
>
> $ ./qemu-system-aarch64 -display help
> -display sdl[,gl=3Don|core|es|off][,grab-mod=3D<mod>][,show-cursor=3Don|o=
ff]
>              [,window-close=3Don|off]
> -display gtk[,full-screen=3Don|off][,gl=3Don|off][,grab-on-hover=3Don|off=
]
>              [,show-tabs=3Don|off][,show-cursor=3Don|off][,window-close=
=3Don|off]
>              [,show-menubar=3Don|off]
> -display vnc=3D<display>[,<optargs>]
> -display curses[,charset=3D<encoding>]
> -display cocoa[,full-grab=3Don|off][,swap-opt-cmd=3Don|off]
> -display dbus[,addr=3D<dbusaddr>]
>               [,gl=3Don|core|es|off][,rendernode=3D<file>]
> -display cocoa[,show-cursor=3Don|off][,left-command-key=3Don|off]
> -display none
>                  select display backend type
>                  The default display is equivalent to
>                  "-display gtk"
>
> The latter is indeed more helpful.

While this will provide help for all the modules built.

Not a big deal to me, but probably worth mentioning in the commit message.


