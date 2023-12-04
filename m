Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC32802E56
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 10:17:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA53O-0008Qm-Fc; Mon, 04 Dec 2023 04:15:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1rA53I-0008QX-CS
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 04:15:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1rA53G-0002jS-Hs
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 04:15:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701681341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1QjiMoHk4v/3HBn8bKxE1O5OGhu52tOcpiOzyF2yMbs=;
 b=Y5GyLQlx1l1qEb1/8nlUwPOJkb3wi+bSFDu7zzAfUzeJPsA+meeGmdulBJhjjIHmBN6mW5
 rEjYOZiJVUcnfWc1XZhPSBsWqYRfh8tYbfHk32CXzOcXreQQu4LF9GbB+bvB1BUzgIdB/P
 NIrdLHGNpzRKW4zayp/iU4+YdPXiGpw=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-dYysPpFuNGOrzNfGTfxN7g-1; Mon, 04 Dec 2023 04:15:39 -0500
X-MC-Unique: dYysPpFuNGOrzNfGTfxN7g-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-286b48a631aso1020324a91.2
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 01:15:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701681338; x=1702286138;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1QjiMoHk4v/3HBn8bKxE1O5OGhu52tOcpiOzyF2yMbs=;
 b=vbLGbsKBmpihB4W6v0pQGX/mM3tG34an/XHgkRuWHKBK7DJVYuQVPDpPp6+RgoY8Fu
 65A9/ULEV/bTPgQX3gjA6p7ZemTI6W5Irmq89Ubl+WWwUCPc4f3xwO+ZZDDAuMLs+Pmg
 IwMjxhT7vU6WyK4+HXtUKx8l/CFI0s3smvBYApeD7Foz6usRsYphsPwpUvFD7n2Aaqc8
 YFwIFzTV576hqpbxuItbqj7xYWc7RMgwfwYM9tFp8cfBvmehxU1rqqMmXBGQ0Y3fdbfr
 z9X0Wq970Vq/OLp7HzUQZXoAYYqdtEf8NHQJ8QLFh2vNHvYRMWp9ai+HEXuTlWxw5Wj+
 FKTw==
X-Gm-Message-State: AOJu0YyjuzdwZjIvY+gL/NbzdmUZs8MSIZVcIysyS2mUOGYo51cs+pDZ
 atKcaGlcrm64WSnurxkPBaNsZEFgy7KpFHh+O9h28Rr9bZcyAjP9Umlf+leYRs74GpglpQmqI/S
 o2TJ9/j0fzhTcJy9B2GkZVdBKEN2CHl+vX/N6GAk=
X-Received: by 2002:a17:90a:4bcf:b0:286:9464:1bb7 with SMTP id
 u15-20020a17090a4bcf00b0028694641bb7mr1557130pjl.27.1701681338292; 
 Mon, 04 Dec 2023 01:15:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWzk2fjTGm8+IN/sh5ejH2Sxwh3HIu8R9VC/S1JdiO0g8SxcfEBumamrAoWZG8vjOglnGH6wMBIhYtCdz4aG0=
X-Received: by 2002:a17:90a:4bcf:b0:286:9464:1bb7 with SMTP id
 u15-20020a17090a4bcf00b0028694641bb7mr1557122pjl.27.1701681338017; Mon, 04
 Dec 2023 01:15:38 -0800 (PST)
MIME-Version: 1.0
References: <20231107093744.388099-1-aesteve@redhat.com>
 <CADSE00Ji6Gk8LJF-1Yr9VBmmcOFFAVYMVGQYsdT59kQQ2adyDA@mail.gmail.com>
 <20231204034947-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231204034947-mutt-send-email-mst@kernel.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 4 Dec 2023 10:15:26 +0100
Message-ID: <CADSE00KHRMM3Cuef1wVTgfZ24s5a11LEkb5MS-T6XGv9XQiS_Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] Virtio dmabuf improvements
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, stefanha@gmail.com, 
 marcandre.lureau@gmail.com
Content-Type: multipart/alternative; boundary="000000000000ac8012060bab8f85"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--000000000000ac8012060bab8f85
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 9:50=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com> =
wrote:

> On Thu, Nov 30, 2023 at 04:49:35PM +0100, Albert Esteve wrote:
> >
> >
> >
> > On Tue, Nov 7, 2023 at 10:37=E2=80=AFAM Albert Esteve <aesteve@redhat.c=
om>
> wrote:
> >
> >     Various improvements for the virtio-dmabuf module.
> >     This patch includes:
> >
> >     - Check for ownership before allowing a vhost device
> >       to remove an object from the table.
> >     - Properly cleanup shared resources if a vhost device
> >       object gets cleaned up.
> >     - Rename virtio dmabuf functions to `virtio_dmabuf_*`
> >
> >     Albert Esteve (3):
> >       hw/virtio: check owner for removing objects
> >       hw/virtio: cleanup shared resources
> >       hw/virtio: rename virtio dmabuf API
> >
> >      hw/display/virtio-dmabuf.c        | 14 +++++-----
> >      hw/virtio/vhost-user.c            | 33 ++++++++++++++++++-----
> >      hw/virtio/vhost.c                 |  5 ++++
> >      include/hw/virtio/vhost.h         |  6 +++++
> >      include/hw/virtio/virtio-dmabuf.h | 33 ++++++++++++-----------
> >      tests/unit/test-virtio-dmabuf.c   | 44
> +++++++++++++++----------------
> >      6 files changed, 83 insertions(+), 52 deletions(-)
> >
> >     --
> >     2.41.0
> >
> >
> >
> > Bump :)
> >
> > @Marc-Andr=C3=A9 Lureau could you please take a look? You suggested the=
 API
> > upgrades, so would be great if you could check if it is what you had in
> mind.
> >
> > Thanks!
>
> All this is post releas material, right?
>
>
Yes, it is.

--000000000000ac8012060bab8f85
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_sign=
ature"><div dir=3D"ltr"><br></div></div></div></div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Dec 4, 2023 at 9:50=
=E2=80=AFAM Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@re=
dhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">On Thu, Nov 30, 2023 at 04:49:35PM +0100, Albert Esteve wrote:<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; On Tue, Nov 7, 2023 at 10:37=E2=80=AFAM Albert Esteve &lt;<a href=3D"m=
ailto:aesteve@redhat.com" target=3D"_blank">aesteve@redhat.com</a>&gt; wrot=
e:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Various improvements for the virtio-dmabuf module.<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0This patch includes:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0- Check for ownership before allowing a vhost devic=
e<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 to remove an object from the table.<br>
&gt;=C2=A0 =C2=A0 =C2=A0- Properly cleanup shared resources if a vhost devi=
ce<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 object gets cleaned up.<br>
&gt;=C2=A0 =C2=A0 =C2=A0- Rename virtio dmabuf functions to `virtio_dmabuf_=
*`<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Albert Esteve (3):<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 hw/virtio: check owner for removing objects<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 hw/virtio: cleanup shared resources<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 hw/virtio: rename virtio dmabuf API<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0hw/display/virtio-dmabuf.c=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 14 +++++-----<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0hw/virtio/vhost-user.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 | 33 ++++++++++++++++++-----<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0hw/virtio/vhost.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 5 ++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0include/hw/virtio/vhost.h=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0|=C2=A0 6 +++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0include/hw/virtio/virtio-dmabuf.h | 33 ++++++=
++++++-----------<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0tests/unit/test-virtio-dmabuf.c=C2=A0 =C2=A0|=
 44 +++++++++++++++----------------<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A06 files changed, 83 insertions(+), 52 deletio=
ns(-)<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0--<br>
&gt;=C2=A0 =C2=A0 =C2=A02.41.0<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; Bump :)<br>
&gt; <br>
&gt; @Marc-Andr=C3=A9 Lureau=C2=A0could=C2=A0you please take a look? You su=
ggested the API<br>
&gt; upgrades, so would be great if you could check if it is what you had i=
n mind.<br>
&gt; <br>
&gt; Thanks!<br>
<br>
All this is post releas material, right?<br>
<br></blockquote><div><br></div><div>Yes, it is.=C2=A0</div></div></div>

--000000000000ac8012060bab8f85--


