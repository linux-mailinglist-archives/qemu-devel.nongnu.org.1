Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 401298112EF
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 14:31:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDPJx-0006Ex-7n; Wed, 13 Dec 2023 08:30:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1rDPJW-0006Db-RJ
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 08:30:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1rDPJU-0007gT-QX
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 08:30:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702474209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sPGSToMo5ssVQKr7z9m8a8dv1XMOgWRHVhLDaOr0qLs=;
 b=JmchXDqW5B4UEYsb+Hr7XIR/TLqpOA2LwcWGwnNQuzNLsG14mEzdXCr5Mls9ASWjnfwJyU
 xnBv/Z3dey5s7+QpuUlLqITF/6gV4G+oyYnsJ5XqNlyZOAZdBAd0sRgyFfcwOKd2GtFKs8
 vMI/GDp1HHDwNQDx8129CrbpDSsggpE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-OqeoPO26Mt-pNRlqXR0uDw-1; Wed, 13 Dec 2023 08:30:07 -0500
X-MC-Unique: OqeoPO26Mt-pNRlqXR0uDw-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-54c882dcb76so8037368a12.0
 for <qemu-devel@nongnu.org>; Wed, 13 Dec 2023 05:30:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702474206; x=1703079006;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sPGSToMo5ssVQKr7z9m8a8dv1XMOgWRHVhLDaOr0qLs=;
 b=ktwJJyBtIDPli49mSC3hZoClwuxPF2tYfaFh9Bkv2Qo459J/6EQrkRgYieFDSjRHFO
 BzYrUPTsNaW5I4TAOReI9aQ82pC6YHhiJBEdj00JBelUVvY50ouDkywcYc0tP6sU7xup
 uS5SC3tTLBM4SpKteaEhzbwjM3OGFadOu6h+T2L5JjeQrma0V3PAUps20guXUOLjAy5i
 M1kFcucy0PXBug3ATyKvz2vXynZaGdI/r+JAnxRe2V7upVKr+Y1Tdvyfq1s32oVhJLRg
 EvVr95uRmJTgrcAYJ9e67X18WuJ/tvC+LJ05IVbN4iz6NrV4xwyaMYXeMXR4l58OweCR
 ZMIQ==
X-Gm-Message-State: AOJu0YxiKXyuDuvfy0jL5kfbpegQDQ8rIILTw5CUy7WDaWQctUEeQ7hO
 6YHoxs4aijUscEG7SBxw+It8C++Bi42PNrpVwetcTO1TxAMNzo8C5SaZXGRai3RyNmeq1fBnh1K
 xWuvs3LjvIoBTVWmsNYEG1lTPA7W4i6wWGIy/2D4=
X-Received: by 2002:aa7:c912:0:b0:552:1eb3:84dd with SMTP id
 b18-20020aa7c912000000b005521eb384ddmr1007574edt.2.1702474205984; 
 Wed, 13 Dec 2023 05:30:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErT6VeoV3LpyRwMzWI7MPMdCFhLwLh2G/UdxrpjVETr4hX7/WOFeyOACl/GseIwJIbIe0fwlRfOhUyfUvtFWI=
X-Received: by 2002:aa7:c912:0:b0:552:1eb3:84dd with SMTP id
 b18-20020aa7c912000000b005521eb384ddmr1007559edt.2.1702474205616; Wed, 13 Dec
 2023 05:30:05 -0800 (PST)
MIME-Version: 1.0
References: <20231213065201.886391-1-frolov@swemel.ru>
 <CAMxuvay5gb6XBMpHB3gu-U=sJ-PqF-oB7jeuiD6rifhWg16bAw@mail.gmail.com>
 <7378b6a4-7abc-990a-9486-48c36dc70b9b@swemel.ru>
In-Reply-To: <7378b6a4-7abc-990a-9486-48c36dc70b9b@swemel.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 13 Dec 2023 17:29:53 +0400
Message-ID: <CAMxuvawp8txvp=EYNiDc80G38NusBTuXAMZvf9C+-6aTOYACjg@mail.gmail.com>
Subject: Re: [PATCH] ui: fix DIV_BY_ZERO in tightvnc
To: =?UTF-8?B?0JTQvNC40YLRgNC40Lkg0KTRgNC+0LvQvtCy?= <frolov@swemel.ru>
Cc: kraxel@redhat.com, sdl.qemu@linuxtesting.org, qemu-devel@nongnu.org
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

On Wed, Dec 13, 2023 at 11:39=E2=80=AFAM =D0=94=D0=BC=D0=B8=D1=82=D1=80=D0=
=B8=D0=B9 =D0=A4=D1=80=D0=BE=D0=BB=D0=BE=D0=B2 <frolov@swemel.ru> wrote:
>
>
>
> On 13.12.2023 10:31, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Wed, Dec 13, 2023 at 11:08=E2=80=AFAM Dmitry Frolov <frolov@swemel.r=
u> wrote:
> >> Division by zero may occur in rare constellation of conditions if:
> >> 1. not TrueColor mode on the client side
> >>     tight_detect_smooth_image16() and tight_detect_smooth_image32(),
> >>     defined by macro DEFINE_DETECT_FUNCTION()2, are affected.
> >> 2. if all pixels on the screen are equal, then pixels =3D=3D stats[0]
> >>
> >> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> >>
> >> Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
> > What about the tight_detect_smooth_image24() division?
> >      errors /=3D (pixels * 3 - stats[0]);
> Here everything is OK, because there is a check some lines above:
>      if (stats[0] * 33 / pixels >=3D 95) {
>          return 0;
>      }
> thus, stats[0] < pixels*95/33,
> 95/33 < 3.
> >


/me shivers.. looks legit, yet so easy to get wrong :)

> > It should probably have a similar safety check.
> >
> > The code is originally from libvncserver, but they completely changed
> > their implementation in:
> > https://github.com/LibVNC/libvncserver/commit/7124b5fbcf0df8db4d3f73023=
d77af6ea56409e7
> > otherwise,
> > Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> >> ---
> >>   ui/vnc-enc-tight.c | 3 +++
> >>   1 file changed, 3 insertions(+)
> >>
> >> diff --git a/ui/vnc-enc-tight.c b/ui/vnc-enc-tight.c
> >> index 41f559eb83..f1249ab136 100644
> >> --- a/ui/vnc-enc-tight.c
> >> +++ b/ui/vnc-enc-tight.c
> >> @@ -284,6 +284,9 @@ tight_detect_smooth_image24(VncState *vs, int w, i=
nt h)
> >>           for (; c < 256; c++) {                                      =
    \
> >>               errors +=3D stats[c] * (c * c);                         =
      \
> >>           }                                                           =
    \
> >> +        if (pixels =3D=3D stats[0]) {                                =
       \
> >> +            return 0;                                                =
   \
> >> +        }                                                            =
   \
> >>           errors /=3D (pixels - stats[0]);                            =
      \
> >>                                                                       =
    \
> >>           return errors;                                              =
    \
> >> --
> >> 2.34.1
> >>
>


