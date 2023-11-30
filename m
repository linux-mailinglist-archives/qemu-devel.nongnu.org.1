Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 839E27FF3F7
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 16:51:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8jIf-00086h-EN; Thu, 30 Nov 2023 10:50:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1r8jIY-00086L-2C
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 10:49:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1r8jIW-0008Cg-J6
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 10:49:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701359389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D+YfKw8uGywGPm543ylA7Iavjh/RnotcPrqKOh2ldGw=;
 b=anjZtWrPSCdL5b4KZy3p/rQ3iHZ7d53JNnjWBbJQT0J84jod50iDuDuoxMNUWvQ3w0ilTY
 UXTjmt0zs2z6LqaNk3Ww6EpbW47+YOwPYxmUsC5DCUYWAL2QhtGtmeUIypVVZLoj4R/3rD
 5ROlW79j7y2dd0PnhWvjS74EGa4WiCA=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-PqZfPK7zPtSa0uFhEA57dw-1; Thu, 30 Nov 2023 10:49:48 -0500
X-MC-Unique: PqZfPK7zPtSa0uFhEA57dw-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-285659dcba9so1305568a91.0
 for <qemu-devel@nongnu.org>; Thu, 30 Nov 2023 07:49:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701359387; x=1701964187;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D+YfKw8uGywGPm543ylA7Iavjh/RnotcPrqKOh2ldGw=;
 b=juTvbOGwyuKBzV6DIzcghxFZ4gDxTlNafEQUmQNNtyjnL7DRZuUZ61fHyZc/c2Dzy8
 l4IuLDsqhG/qOsaM5kkZ96P/3Fb3EpsKxk4wDxt8PBAbdLBYfToC8BXR++QVS+u+sjjw
 hMSieuu04NcO5z+J+NwMWYXTp5+MKB9ZsdXHxFbO+Tkye0FEnk8aDEC9JkxAXsQqWt6k
 wEgiJcViBoZiGaEirmXxQB7iBPOABQ4ea/P8PNfYO3UEueUMDWLtn9VN93fNnPNNcsv2
 HT+Nm5WySBh+omaA3lG+d7bJflNzTW8YGC+Gef4O/ObAB6+onk+8mpGHGdSvfPzz10dF
 lPlA==
X-Gm-Message-State: AOJu0YwQcZSLVPNEsPk6tOjpC15W5FZRZHt+Stz5UANhkPMQsEgwG8Gv
 InQWzyGz5plYlCpYlEWV2810wUIFXUN8CvTgkdsxPBjlo3eV6zcq7Xo+uOQnCpmYikY9beHxaCP
 OnnJaG+34dmWTwJQ08VsksyJtq1ux2tglN7vCgWs=
X-Received: by 2002:a17:90a:e7cf:b0:285:2518:39d2 with SMTP id
 kb15-20020a17090ae7cf00b00285251839d2mr21732318pjb.27.1701359386685; 
 Thu, 30 Nov 2023 07:49:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3oIolRe+LdKtUukeoeI9Jgz08xsYdURhTJg3obpkL6Nu5S/gUndEtb+cMlS7DcEHirqsXN1uZqwgq1ZlE9Os=
X-Received: by 2002:a17:90a:e7cf:b0:285:2518:39d2 with SMTP id
 kb15-20020a17090ae7cf00b00285251839d2mr21732300pjb.27.1701359386414; Thu, 30
 Nov 2023 07:49:46 -0800 (PST)
MIME-Version: 1.0
References: <20231107093744.388099-1-aesteve@redhat.com>
In-Reply-To: <20231107093744.388099-1-aesteve@redhat.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Thu, 30 Nov 2023 16:49:35 +0100
Message-ID: <CADSE00Ji6Gk8LJF-1Yr9VBmmcOFFAVYMVGQYsdT59kQQ2adyDA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Virtio dmabuf improvements
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, kraxel@redhat.com,
 stefanha@gmail.com, marcandre.lureau@gmail.com
Content-Type: multipart/alternative; boundary="000000000000dcf03a060b6099d5"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

--000000000000dcf03a060b6099d5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 7, 2023 at 10:37=E2=80=AFAM Albert Esteve <aesteve@redhat.com> =
wrote:

> Various improvements for the virtio-dmabuf module.
> This patch includes:
>
> - Check for ownership before allowing a vhost device
>   to remove an object from the table.
> - Properly cleanup shared resources if a vhost device
>   object gets cleaned up.
> - Rename virtio dmabuf functions to `virtio_dmabuf_*`
>
> Albert Esteve (3):
>   hw/virtio: check owner for removing objects
>   hw/virtio: cleanup shared resources
>   hw/virtio: rename virtio dmabuf API
>
>  hw/display/virtio-dmabuf.c        | 14 +++++-----
>  hw/virtio/vhost-user.c            | 33 ++++++++++++++++++-----
>  hw/virtio/vhost.c                 |  5 ++++
>  include/hw/virtio/vhost.h         |  6 +++++
>  include/hw/virtio/virtio-dmabuf.h | 33 ++++++++++++-----------
>  tests/unit/test-virtio-dmabuf.c   | 44 +++++++++++++++----------------
>  6 files changed, 83 insertions(+), 52 deletions(-)
>
> --
> 2.41.0
>
>
Bump :)

@Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> could you please take =
a
look? You suggested the API upgrades, so would be great if you could check
if it is what you had in mind.

Thanks!

--000000000000dcf03a060b6099d5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_sign=
ature"><br></div></div><br></div><br><div class=3D"gmail_quote"><div dir=3D=
"ltr" class=3D"gmail_attr">On Tue, Nov 7, 2023 at 10:37=E2=80=AFAM Albert E=
steve &lt;<a href=3D"mailto:aesteve@redhat.com">aesteve@redhat.com</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Various i=
mprovements for the virtio-dmabuf module.<br>
This patch includes:<br>
<br>
- Check for ownership before allowing a vhost device<br>
=C2=A0 to remove an object from the table.<br>
- Properly cleanup shared resources if a vhost device<br>
=C2=A0 object gets cleaned up.<br>
- Rename virtio dmabuf functions to `virtio_dmabuf_*`<br>
<br>
Albert Esteve (3):<br>
=C2=A0 hw/virtio: check owner for removing objects<br>
=C2=A0 hw/virtio: cleanup shared resources<br>
=C2=A0 hw/virtio: rename virtio dmabuf API<br>
<br>
=C2=A0hw/display/virtio-dmabuf.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 14 +++++-----=
<br>
=C2=A0hw/virtio/vhost-user.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 33 =
++++++++++++++++++-----<br>
=C2=A0hw/virtio/vhost.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 5 ++++<br>
=C2=A0include/hw/virtio/vhost.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 6 =
+++++<br>
=C2=A0include/hw/virtio/virtio-dmabuf.h | 33 ++++++++++++-----------<br>
=C2=A0tests/unit/test-virtio-dmabuf.c=C2=A0 =C2=A0| 44 +++++++++++++++-----=
-----------<br>
=C2=A06 files changed, 83 insertions(+), 52 deletions(-)<br>
<br>
-- <br>
2.41.0<br>
<br></blockquote><div><br></div><div>Bump :)</div><div><br></div><div><a cl=
ass=3D"gmail_plusreply" id=3D"plusReplyChip-0" href=3D"mailto:marcandre.lur=
eau@gmail.com" tabindex=3D"-1">@Marc-Andr=C3=A9 Lureau</a>=C2=A0could=C2=A0=
you please take a look? You suggested the API upgrades, so would be great i=
f you could check if it is what you had in mind.</div><div><br></div><div>T=
hanks!</div></div></div>

--000000000000dcf03a060b6099d5--


