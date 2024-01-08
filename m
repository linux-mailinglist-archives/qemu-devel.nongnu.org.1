Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E688827477
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 16:50:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMrsO-0006EN-EG; Mon, 08 Jan 2024 10:49:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1rMrsM-0006E3-3f
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 10:49:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1rMrsK-0005nd-3E
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 10:49:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704728954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U4FI3fNhiRv9041dZfcGfRjkVMdbHliY07iAzmKgn/0=;
 b=URPom1wv0bxjDUL4JPeygStu6iD7Rm/soTDCxdMamiCz2s+jNkeyRjfWSUuOEghQZFkie+
 R+IBwg4nw5pM1AJZIVqTqMDj49NnFlUzGrSDJE1jXZ4OxOnlMBIeVF6m61oq6wBWMi+Vux
 in589GSqlmGum7cv6APJPAaR6ClRQxU=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-NWXUDnUWPoKb8NUovnCLQA-1; Mon, 08 Jan 2024 10:49:10 -0500
X-MC-Unique: NWXUDnUWPoKb8NUovnCLQA-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-28c26fe6068so1304694a91.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 07:49:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704728949; x=1705333749;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U4FI3fNhiRv9041dZfcGfRjkVMdbHliY07iAzmKgn/0=;
 b=dQq7DiV+JYRFUmb2D1zivsSPUHYIdliRvSq8kOlMF+dALafe6gmsTeArIHp+nJ3YUo
 RUdpowX+0Lc4x4S8jRSXoLE6yVvmj1MMkdMZ5sghyfQZHaVJWANtMq9k0yPJ8KJbX/te
 yQVvHiYL/0cM3Hy+YXWShd+sBa+Dzx57OV/y591bmQrdlPlrNZ+LdOVBbGU2UNdI0ODv
 13xpVAgGmfshsuGqu0mbIJujYE13XJ5NNPU6vjPicUvArlP29x1xHDkcO9yQNxydjZ1n
 ZX7MMyLwcEet00jdjT9LbuBJpscrCL0VOjSGOZWysPTlNN4FVj6QadP6bks9lagLGn1C
 Zitg==
X-Gm-Message-State: AOJu0YxhOco/1SnA8xIRUhZZ8mLviEzf1ZLB8ZxCNZx3hp1+IBUeFqEA
 VEtjMJCBavZNkltUadiW8vlmB/5bRRay56WuQyuCvvzaOh1DBpjVdj7a5Hb943/St7QfhpPgMYM
 o/MTme69lIF708qPrHpI+K/a6eicd35eMhWnFTB8=
X-Received: by 2002:a17:90a:a90:b0:28c:5a8e:d15 with SMTP id
 16-20020a17090a0a9000b0028c5a8e0d15mr1158819pjw.71.1704728949683; 
 Mon, 08 Jan 2024 07:49:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJZQnjw5TbE98sk73WDq2onT+APAKlaA1sHhKNy5yQiS6pQ/fA2ZFsdFFSjSRHqbKmUchBhzLdPatIsJ0Jc40=
X-Received: by 2002:a17:90a:a90:b0:28c:5a8e:d15 with SMTP id
 16-20020a17090a0a9000b0028c5a8e0d15mr1158806pjw.71.1704728949350; Mon, 08 Jan
 2024 07:49:09 -0800 (PST)
MIME-Version: 1.0
References: <20231207145545.783877-1-aesteve@redhat.com>
 <CAJSP0QVGwTOgtRSaN3JbRKs4h2c_wH1WGTDLaBKme+vhTuDQsQ@mail.gmail.com>
In-Reply-To: <CAJSP0QVGwTOgtRSaN3JbRKs4h2c_wH1WGTDLaBKme+vhTuDQsQ@mail.gmail.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 8 Jan 2024 16:48:58 +0100
Message-ID: <CADSE00Ja8fVJUfu5s+mHavoN-BYwSpxB35a44VwU0SWm5bbZzA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Virtio dmabuf improvements
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@gmail.com, kraxel@redhat.com, 
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000076f455060e7123ff"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--00000000000076f455060e7123ff
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 10:48=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.co=
m> wrote:

> On Thu, 7 Dec 2023 at 09:55, Albert Esteve <aesteve@redhat.com> wrote:
> >
> > v1: https://www.mail-archive.com/qemu-devel@nongnu.org/msg1005257.html
> > v1 -> v2:
> >   - Solved an unitialized uuid value on vhost-user source
> >   - Changed cleanup strategy, and traverse all objects in the
> >     table to remove them instead.
>
> Please update the vhost-user specification
> (docs/interop/vhost-user.rst) so people implementing front-ends and
> back-ends are aware that only the back-end that added a shared
> resource can remove it.
>
> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
>
>
Will do :)

Should I add the `Acked-by` manually to the commits or does it
get automatically picked up later?

BR,
Albert

PS: Happy New Year!


> >
> > Various improvements for the virtio-dmabuf module.
> > This patch includes:
> >
> > - Check for ownership before allowing a vhost device
> >   to remove an object from the table.
> > - Properly cleanup shared resources if a vhost device
> >   object gets cleaned up.
> > - Rename virtio dmabuf functions to `virtio_dmabuf_*`
> >
> > Albert Esteve (3):
> >   hw/virtio: check owner for removing objects
> >   hw/virtio: cleanup shared resources
> >   hw/virtio: rename virtio dmabuf API
> >
> >  hw/display/virtio-dmabuf.c        | 36 ++++++++++++---
> >  hw/virtio/vhost-user.c            | 31 ++++++++++---
> >  hw/virtio/vhost.c                 |  3 ++
> >  include/hw/virtio/virtio-dmabuf.h | 43 ++++++++++-------
> >  tests/unit/test-virtio-dmabuf.c   | 77 ++++++++++++++++++++++---------
> >  5 files changed, 138 insertions(+), 52 deletions(-)
> >
> > --
> > 2.43.0
> >
>
>

--00000000000076f455060e7123ff
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_sign=
ature"><div dir=3D"ltr"><br></div></div></div></div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Dec 11, 2023 at 10:48=
=E2=80=AFPM Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@gmail.com">stefa=
nha@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">On Thu, 7 Dec 2023 at 09:55, Albert Esteve &lt;<a href=3D"mail=
to:aesteve@redhat.com" target=3D"_blank">aesteve@redhat.com</a>&gt; wrote:<=
br>
&gt;<br>
&gt; v1: <a href=3D"https://www.mail-archive.com/qemu-devel@nongnu.org/msg1=
005257.html" rel=3D"noreferrer" target=3D"_blank">https://www.mail-archive.=
com/qemu-devel@nongnu.org/msg1005257.html</a><br>
&gt; v1 -&gt; v2:<br>
&gt;=C2=A0 =C2=A0- Solved an unitialized uuid value on vhost-user source<br=
>
&gt;=C2=A0 =C2=A0- Changed cleanup strategy, and traverse all objects in th=
e<br>
&gt;=C2=A0 =C2=A0 =C2=A0table to remove them instead.<br>
<br>
Please update the vhost-user specification<br>
(docs/interop/vhost-user.rst) so people implementing front-ends and<br>
back-ends are aware that only the back-end that added a shared<br>
resource can remove it.<br>
<br>
Acked-by: Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com" target=
=3D"_blank">stefanha@redhat.com</a>&gt;<br>
<br></blockquote><div><br></div><div>Will do :)</div><div><br></div><div>Sh=
ould I add the `Acked-by` manually to the commits or does it get=C2=A0autom=
atically picked up later?</div><div><br></div><div>BR,</div><div>Albert</di=
v><div><br></div><div>PS: Happy New Year!</div><div>=C2=A0</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
&gt;<br>
&gt; Various improvements for the virtio-dmabuf module.<br>
&gt; This patch includes:<br>
&gt;<br>
&gt; - Check for ownership before allowing a vhost device<br>
&gt;=C2=A0 =C2=A0to remove an object from the table.<br>
&gt; - Properly cleanup shared resources if a vhost device<br>
&gt;=C2=A0 =C2=A0object gets cleaned up.<br>
&gt; - Rename virtio dmabuf functions to `virtio_dmabuf_*`<br>
&gt;<br>
&gt; Albert Esteve (3):<br>
&gt;=C2=A0 =C2=A0hw/virtio: check owner for removing objects<br>
&gt;=C2=A0 =C2=A0hw/virtio: cleanup shared resources<br>
&gt;=C2=A0 =C2=A0hw/virtio: rename virtio dmabuf API<br>
&gt;<br>
&gt;=C2=A0 hw/display/virtio-dmabuf.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 36 +++++=
+++++++---<br>
&gt;=C2=A0 hw/virtio/vhost-user.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
| 31 ++++++++++---<br>
&gt;=C2=A0 hw/virtio/vhost.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 3 ++<br>
&gt;=C2=A0 include/hw/virtio/virtio-dmabuf.h | 43 ++++++++++-------<br>
&gt;=C2=A0 tests/unit/test-virtio-dmabuf.c=C2=A0 =C2=A0| 77 +++++++++++++++=
+++++++---------<br>
&gt;=C2=A0 5 files changed, 138 insertions(+), 52 deletions(-)<br>
&gt;<br>
&gt; --<br>
&gt; 2.43.0<br>
&gt;<br>
<br>
</blockquote></div></div>

--00000000000076f455060e7123ff--


