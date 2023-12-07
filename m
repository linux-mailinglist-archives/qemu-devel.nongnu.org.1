Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55975808407
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 10:15:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBATL-0004t5-K5; Thu, 07 Dec 2023 04:15:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1rBATF-0004sN-3b
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 04:15:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1rBATD-0007Fw-4j
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 04:15:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701940497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0siWpu4HJqIs2uzswZNhWXss5polQxjTnwXzZyn/lEs=;
 b=FJEdzz1BxLeOJgXEO8Mv/0Lz8TXjEoXYxgLhwCI18CRKJz26D9A/YDRpztWqvK1NLi4A/t
 qB+WnfuM83+OYRJ3PtloFTPk5dvBHmguIELohHxybvovLvJlmkSWJ19UE4LnocUKQI/q7B
 QJgNykLQHlIk6dK7/gCXfXoDLSCNtck=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-Gly-NRXuPKuYIt1XP4cqyg-1; Thu, 07 Dec 2023 04:14:55 -0500
X-MC-Unique: Gly-NRXuPKuYIt1XP4cqyg-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-28674705fddso581340a91.2
 for <qemu-devel@nongnu.org>; Thu, 07 Dec 2023 01:14:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701940494; x=1702545294;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0siWpu4HJqIs2uzswZNhWXss5polQxjTnwXzZyn/lEs=;
 b=CDEKSmkYCyU3gzPsuafzYvVYBsUS6wOjqgE6lvn7oAeDf2iygIPF1mxOrXjVNT2xAX
 vR94VlCF3w+6yLWw4Ges6W31WyOwNHcEyHVxdc7orbYt/RCikD/+Sl9Z9zzOeWLEpYtG
 5kI96q5Gkd3GgdmHyJEwHO7pjJ5UcBBapnt3aQRoagLr9FXZTXWpUqY0P74kE9qm1odi
 0cJ1as9vyenU+Z83RyYjVOicTqlqz38YEBIS97eBZmd79kJjYihtA4O+qJs8uol0S1Jl
 c7bdOZlSG6YPZzHTQPJuKvDTUvjMPCuCUEkDNa8/H8xLDoYdd8ehs6aFO9mMyNBbM8fD
 i22w==
X-Gm-Message-State: AOJu0YxmUHtm+AyFJfFaOgSioTLRENcEEXwESYSvk1yJp49RrteR+XMF
 64aQiB/fAHdu+IeHOdJ9KUBAJTtz3/Kd6OMa3YouQ3tl04+Q7fwplGVgLPQvroqzM/siA2jw8Ca
 DumfJQk1xdn5pR6Hk9K8P+rEW0FZ3zlo=
X-Received: by 2002:a17:90a:6f83:b0:286:c7c9:fde with SMTP id
 e3-20020a17090a6f8300b00286c7c90fdemr2039241pjk.79.1701940494117; 
 Thu, 07 Dec 2023 01:14:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFE0DM6lOuAZdkMPXTcGytRWBTV5tL27j/oKz7bg0QD0eiX32HwG+l444p8YItTJ8X16PYgQJlJIrK0+fejv7g=
X-Received: by 2002:a17:90a:6f83:b0:286:c7c9:fde with SMTP id
 e3-20020a17090a6f8300b00286c7c90fdemr2039234pjk.79.1701940493814; Thu, 07 Dec
 2023 01:14:53 -0800 (PST)
MIME-Version: 1.0
References: <20231107093744.388099-1-aesteve@redhat.com>
 <20231107093744.388099-2-aesteve@redhat.com>
 <CAJ+F1CLohGjKaKYk8x4MbNQ6e0M=E15VeJ5wjYW=O9nMapOZmg@mail.gmail.com>
In-Reply-To: <CAJ+F1CLohGjKaKYk8x4MbNQ6e0M=E15VeJ5wjYW=O9nMapOZmg@mail.gmail.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Thu, 7 Dec 2023 10:14:42 +0100
Message-ID: <CADSE00Jn0240p8nnPP0YxKdWvSADRUeSD2rGFSJAPysbk5WcTg@mail.gmail.com>
Subject: Re: [PATCH 1/3] hw/virtio: check owner for removing objects
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 kraxel@redhat.com, stefanha@gmail.com
Content-Type: multipart/alternative; boundary="0000000000009025ec060be7e6b4"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

--0000000000009025ec060be7e6b4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 8:54=E2=80=AFAM Marc-Andr=C3=A9 Lureau <marcandre.lu=
reau@gmail.com>
wrote:

> On Tue, Nov 7, 2023 at 1:37=E2=80=AFPM Albert Esteve <aesteve@redhat.com>=
 wrote:
> >
> > Shared objects lack spoofing protection.
> > For VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE messages
> > received by the vhost-user interface, any backend was
> > allowed to remove entries from the shared table just
> > by knowing the UUID. Only the owner of the entry
> > shall be allowed to removed their resources
> > from the table.
> >
> > To fix that, add a check for all
> > *SHARED_OBJECT_REMOVE messages received.
> > A vhost device can only remove TYPE_VHOST_DEV
> > entries that are owned by them, otherwise skip
> > the removal, and inform the device that the entry
> > has not been removed in the answer.
> >
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> >  hw/virtio/vhost-user.c | 21 +++++++++++++++++++--
> >  1 file changed, 19 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > index 7b42ae8aae..5fdff0241f 100644
> > --- a/hw/virtio/vhost-user.c
> > +++ b/hw/virtio/vhost-user.c
> > @@ -1602,10 +1602,26 @@
> vhost_user_backend_handle_shared_object_add(struct vhost_dev *dev,
> >  }
> >
> >  static int
> > -vhost_user_backend_handle_shared_object_remove(VhostUserShared *object=
)
> > +vhost_user_backend_handle_shared_object_remove(struct vhost_dev *dev,
> > +                                               VhostUserShared *object=
)
> >  {
> >      QemuUUID uuid;
> >
> > +    switch (virtio_object_type(&uuid)) {
>
> ../hw/virtio/vhost-user.c:1619:13: error: =E2=80=98uuid=E2=80=99 may be u=
sed
> uninitialized [-Werror=3Dmaybe-uninitialized]
>  1619 |     switch (virtio_object_type(&uuid)) {
>       |             ^~~~~~~~~~~~~~~~~~~~~~~~~
>
>
Oops I didn't notice this. Maybe I am missing the
`Werror` flag when I compile locally. I'll fix it.


> > +    case TYPE_VHOST_DEV:
> > +    {
> > +        struct vhost_dev *owner =3D virtio_lookup_vhost_device(&uuid);
> > +        if (owner =3D=3D NULL || dev !=3D owner) {
> > +            /* Not allowed to remove non-owned entries */
> > +            return 0;
> > +        }
> > +        break;
> > +    }
> > +    default:
> > +        /* Not allowed to remove non-owned entries */
> > +        return 0;
>
> How do you remove TYPE_DMABUF entries after this patch?
>
>
TYPE_DMABUF are meant for virtio devices that run with Qemu
(i.e., not vhost). So owners will not send these messages, but
access the hash table directly.


> > +    }
> > +
> >      memcpy(uuid.data, object->uuid, sizeof(object->uuid));
> >      return virtio_remove_resource(&uuid);
> >  }
> > @@ -1785,7 +1801,8 @@ static gboolean backend_read(QIOChannel *ioc,
> GIOCondition condition,
> >          ret =3D vhost_user_backend_handle_shared_object_add(dev,
> &payload.object);
> >          break;
> >      case VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE:
> > -        ret =3D
> vhost_user_backend_handle_shared_object_remove(&payload.object);
> > +        ret =3D vhost_user_backend_handle_shared_object_remove(dev,
> > +
>  &payload.object);
> >          break;
> >      case VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP:
> >          ret =3D
> vhost_user_backend_handle_shared_object_lookup(dev->opaque, ioc,
> > --
> > 2.41.0
> >
>
>
> --
> Marc-Andr=C3=A9 Lureau
>
>

--0000000000009025ec060be7e6b4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_sign=
ature"><div dir=3D"ltr"><br></div></div></div></div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Dec 4, 2023 at 8:54=
=E2=80=AFAM Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@g=
mail.com">marcandre.lureau@gmail.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">On Tue, Nov 7, 2023 at 1:37=E2=80=AFPM =
Albert Esteve &lt;<a href=3D"mailto:aesteve@redhat.com" target=3D"_blank">a=
esteve@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Shared objects lack spoofing protection.<br>
&gt; For VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE messages<br>
&gt; received by the vhost-user interface, any backend was<br>
&gt; allowed to remove entries from the shared table just<br>
&gt; by knowing the UUID. Only the owner of the entry<br>
&gt; shall be allowed to removed their resources<br>
&gt; from the table.<br>
&gt;<br>
&gt; To fix that, add a check for all<br>
&gt; *SHARED_OBJECT_REMOVE messages received.<br>
&gt; A vhost device can only remove TYPE_VHOST_DEV<br>
&gt; entries that are owned by them, otherwise skip<br>
&gt; the removal, and inform the device that the entry<br>
&gt; has not been removed in the answer.<br>
&gt;<br>
&gt; Signed-off-by: Albert Esteve &lt;<a href=3D"mailto:aesteve@redhat.com"=
 target=3D"_blank">aesteve@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/virtio/vhost-user.c | 21 +++++++++++++++++++--<br>
&gt;=C2=A0 1 file changed, 19 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c<br>
&gt; index 7b42ae8aae..5fdff0241f 100644<br>
&gt; --- a/hw/virtio/vhost-user.c<br>
&gt; +++ b/hw/virtio/vhost-user.c<br>
&gt; @@ -1602,10 +1602,26 @@ vhost_user_backend_handle_shared_object_add(st=
ruct vhost_dev *dev,<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 static int<br>
&gt; -vhost_user_backend_handle_shared_object_remove(VhostUserShared *objec=
t)<br>
&gt; +vhost_user_backend_handle_shared_object_remove(struct vhost_dev *dev,=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0VhostUserShared *object)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 QemuUUID uuid;<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 switch (virtio_object_type(&amp;uuid)) {<br>
<br>
../hw/virtio/vhost-user.c:1619:13: error: =E2=80=98uuid=E2=80=99 may be use=
d<br>
uninitialized [-Werror=3Dmaybe-uninitialized]<br>
=C2=A01619 |=C2=A0 =C2=A0 =C2=A0switch (virtio_object_type(&amp;uuid)) {<br=
>
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~=
~~~~~~~~~~~~~~~~~~~~<br>
<br></blockquote><div><br></div><div>Oops I didn&#39;t notice this. Maybe I=
 am missing the</div><div>`Werror` flag when I compile locally. I&#39;ll fi=
x it.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
&gt; +=C2=A0 =C2=A0 case TYPE_VHOST_DEV:<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct vhost_dev *owner =3D virtio_lookup=
_vhost_device(&amp;uuid);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (owner =3D=3D NULL || dev !=3D owner) =
{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Not allowed to remove no=
n-owned entries */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Not allowed to remove non-owned entrie=
s */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
<br>
How do you remove TYPE_DMABUF entries after this patch?<br>
<br></blockquote><div><br></div><div>TYPE_DMABUF are meant for virtio devic=
es that run with Qemu<br></div><div>(i.e., not vhost). So owners will not s=
end these messages, but</div><div>access the hash table directly.</div><div=
>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 memcpy(uuid.data, object-&gt;uuid, sizeof(object-&=
gt;uuid));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return virtio_remove_resource(&amp;uuid);<br>
&gt;=C2=A0 }<br>
&gt; @@ -1785,7 +1801,8 @@ static gboolean backend_read(QIOChannel *ioc, GI=
OCondition condition,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vhost_user_backend_handle_sh=
ared_object_add(dev, &amp;payload.object);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 case VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vhost_user_backend_handle_shared_=
object_remove(&amp;payload.object);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vhost_user_backend_handle_shared_=
object_remove(dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&a=
mp;payload.object);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 case VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vhost_user_backend_handle_sh=
ared_object_lookup(dev-&gt;opaque, ioc,<br>
&gt; --<br>
&gt; 2.41.0<br>
&gt;<br>
<br>
<br>
-- <br>
Marc-Andr=C3=A9 Lureau<br>
<br>
</blockquote></div></div>

--0000000000009025ec060be7e6b4--


