Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CACE6793EFD
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 16:34:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdtbX-0003I3-TV; Wed, 06 Sep 2023 10:34:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qdtbS-0003H2-TK
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 10:33:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qdtbO-0005Ok-Iw
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 10:33:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694010833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DHjntRkLFzmJYk7uwRsCiAS1pEL4oG2Zc9/520jBckM=;
 b=POrcacEnAD2rKNBSv6X+uNHQFHpMmB4pucCfnH7TO4uEKvAvBzNe+tTzUG6s4cxj1eWqlS
 H5KOXR0aJ50JlNG/xB+U7WpRb5a44x0S9rrjS5Fm1bjqp+2d5/PuWesD3NslBhWEcDRaR5
 nH++S6Pd2+clsYpXPhfJruhdav1Z4gE=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-YjmnGbnOMwy_5qK7f5CXog-1; Wed, 06 Sep 2023 10:33:49 -0400
X-MC-Unique: YjmnGbnOMwy_5qK7f5CXog-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-56f89b2535dso4378659a12.2
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 07:33:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694010828; x=1694615628;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DHjntRkLFzmJYk7uwRsCiAS1pEL4oG2Zc9/520jBckM=;
 b=cp2dh5NFKyosbZREZQUrvbqeOPsz1pgykDZ2ctDu/xdODC7Imlbvgxv1Yx3SdFtKD0
 s/i3pBr0QLFjpQhI5GhcFHLIQUf5BP1n6BoVTOlM14R5YWFOQcshO72EbQhnZl7Xmt/J
 9npqI0IVi+vUUE7+K6QQIO7QAEzT4dH/1OucF5aR0wPB74/fxiCcN5zSbl+npBJQmy03
 P1O2/55AH3PD1beBvvS04T64OVbklf9j/LRb56UL1IBRV800MBm7dSaU/oE3+hQgxhVR
 MXCocqQJu/xGOgGNfi9NOwcEnfwPDhlYAqtaRTeayQR4hCdJ6cRDy6mS513fxIm2Lf4A
 IjgQ==
X-Gm-Message-State: AOJu0YzkGhLwbckl5lqjoet0/K2KON31qviWIRv3VKVRgp9ek1vJ9D+m
 gulyIrucacaqM2XTC59UX0SKUA09zanDTn637u0oYeVSED5Qfb5xovFkR+SIqz6cDX0vS1EE3Cz
 Z14cQfxZfX+7P3F5RuUa8I332+n5842A=
X-Received: by 2002:a05:6a20:9183:b0:14c:d494:77c5 with SMTP id
 v3-20020a056a20918300b0014cd49477c5mr19817039pzd.13.1694010827993; 
 Wed, 06 Sep 2023 07:33:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAEkcgS66UlEI72mD4Gcud8OYaH+X213O4vXdjzYmnBJrOicAiIVg1+GhBr1o0qsgEBtW9FyX88GazZzo6J2E=
X-Received: by 2002:a05:6a20:9183:b0:14c:d494:77c5 with SMTP id
 v3-20020a056a20918300b0014cd49477c5mr19817025pzd.13.1694010827692; Wed, 06
 Sep 2023 07:33:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230906111549.357178-1-aesteve@redhat.com>
 <20230906111549.357178-4-aesteve@redhat.com>
 <9d5377ba-c987-dce3-2813-d9c98f162d3f@linaro.org>
In-Reply-To: <9d5377ba-c987-dce3-2813-d9c98f162d3f@linaro.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 6 Sep 2023 16:33:36 +0200
Message-ID: <CADSE00Lv7ry403fE573dRv1xdz_-UEgoj1CA6OABXeXnndoP8g@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] vhost-user: add shared_object msg
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>, 
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com, kraxel@redhat.com, 
 marcandre.lureau@gmail.com
Content-Type: multipart/alternative; boundary="000000000000a1780b0604b1a1ec"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000a1780b0604b1a1ec
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 6, 2023 at 4:27=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org>
wrote:

> Hi Albert,
>
> On 6/9/23 13:15, Albert Esteve wrote:
> > Add three new vhost-user protocol
> > `VHOST_USER_BACKEND_SHARED_OBJECT_* messages`.
> > These new messages are sent from vhost-user
> > back-ends to interact with the virtio-dmabuf
> > table in order to add or remove themselves as
> > virtio exporters, or lookup for virtio dma-buf
> > shared objects.
> >
> > The action taken in the front-end depends
> > on the type stored in the virtio shared
> > object hash table.
> >
> > When the table holds a pointer to a vhost
> > backend for a given UUID, the front-end sends
> > a VHOST_USER_GET_SHARED_OBJECT to the
> > backend holding the shared object.
> >
> > In the libvhost-user library we need to add
> > helper functions to allow sending messages to
> > interact with the virtio shared objects
> > hash table.
> >
> > The messages can only be sent after successfully
> > negotiating a new VHOST_USER_PROTOCOL_F_SHARED_OBJECT
> > vhost-user protocol feature bit.
> >
> > Finally, refactor code to send response message so
> > that all common parts both for the common REPLY_ACK
> > case, and other data responses, can call it and
> > avoid code repetition.
> >
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> >   docs/interop/vhost-user.rst               |  57 +++++++
> >   hw/virtio/vhost-user.c                    | 174 ++++++++++++++++++++-=
-
> >   include/hw/virtio/vhost-backend.h         |   3 +
> >   subprojects/libvhost-user/libvhost-user.c | 118 +++++++++++++++
> >   subprojects/libvhost-user/libvhost-user.h |  55 ++++++-
> >   5 files changed, 393 insertions(+), 14 deletions(-)
>
> Almost 400 lines of changes is too much for me to review in a
> single patch. Looking at the names, can't we split virtio VS
> libvhost-user?
>

Ack.


>
> > +static bool vhost_user_send_resp(QIOChannel *ioc, VhostUserHeader *hdr=
,
> > +                                 VhostUserPayload *payload)
> > +{
> > +    Error *local_err =3D NULL;
> > +    struct iovec iov[] =3D {
> > +        { .iov_base =3D hdr,      .iov_len =3D VHOST_USER_HDR_SIZE },
> > +        { .iov_base =3D payload,  .iov_len =3D hdr->size },
> > +    };
> > +
> > +    hdr->flags &=3D ~VHOST_USER_NEED_REPLY_MASK;
> > +    hdr->flags |=3D VHOST_USER_REPLY_MASK;
> > +
> > +    if (qio_channel_writev_all(ioc, iov, ARRAY_SIZE(iov), &local_err))=
 {
> > +        error_report_err(local_err);
> > +        return false;
> > +    }
> > +
> > +    return true;
> > +}
>
> I note you  ignored my comment regarding adding a 'Error **' argument in
> the previous version:
>
> https://lore.kernel.org/qemu-devel/911eef0c-d04f-2fcf-e78b-2475cd7af8f0@l=
inaro.org/
>
> Sorry I missed those comments somehow :/
I'll check them and resend.

BR,
Albert

--000000000000a1780b0604b1a1ec
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_sign=
ature"><div dir=3D"ltr"><br></div></div></div></div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 6, 2023 at 4:27=
=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro=
.org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">Hi Albert,<br>
<br>
On 6/9/23 13:15, Albert Esteve wrote:<br>
&gt; Add three new vhost-user protocol<br>
&gt; `VHOST_USER_BACKEND_SHARED_OBJECT_* messages`.<br>
&gt; These new messages are sent from vhost-user<br>
&gt; back-ends to interact with the virtio-dmabuf<br>
&gt; table in order to add or remove themselves as<br>
&gt; virtio exporters, or lookup for virtio dma-buf<br>
&gt; shared objects.<br>
&gt; <br>
&gt; The action taken in the front-end depends<br>
&gt; on the type stored in the virtio shared<br>
&gt; object hash table.<br>
&gt; <br>
&gt; When the table holds a pointer to a vhost<br>
&gt; backend for a given UUID, the front-end sends<br>
&gt; a VHOST_USER_GET_SHARED_OBJECT to the<br>
&gt; backend holding the shared object.<br>
&gt; <br>
&gt; In the libvhost-user library we need to add<br>
&gt; helper functions to allow sending messages to<br>
&gt; interact with the virtio shared objects<br>
&gt; hash table.<br>
&gt; <br>
&gt; The messages can only be sent after successfully<br>
&gt; negotiating a new VHOST_USER_PROTOCOL_F_SHARED_OBJECT<br>
&gt; vhost-user protocol feature bit.<br>
&gt; <br>
&gt; Finally, refactor code to send response message so<br>
&gt; that all common parts both for the common REPLY_ACK<br>
&gt; case, and other data responses, can call it and<br>
&gt; avoid code repetition.<br>
&gt; <br>
&gt; Signed-off-by: Albert Esteve &lt;<a href=3D"mailto:aesteve@redhat.com"=
 target=3D"_blank">aesteve@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0docs/interop/vhost-user.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 57 +++++++<br>
&gt;=C2=A0 =C2=A0hw/virtio/vhost-user.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 174 ++++++++++++++++++++--<br>
&gt;=C2=A0 =C2=A0include/hw/virtio/vhost-backend.h=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A03 +<br>
&gt;=C2=A0 =C2=A0subprojects/libvhost-user/libvhost-user.c | 118 ++++++++++=
+++++<br>
&gt;=C2=A0 =C2=A0subprojects/libvhost-user/libvhost-user.h |=C2=A0 55 +++++=
+-<br>
&gt;=C2=A0 =C2=A05 files changed, 393 insertions(+), 14 deletions(-)<br>
<br>
Almost 400 lines of changes is too much for me to review in a<br>
single patch. Looking at the names, can&#39;t we split virtio VS<br>
libvhost-user?<br></blockquote><div><br></div><div>Ack.</div><div>=C2=A0</d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +static bool vhost_user_send_resp(QIOChannel *ioc, VhostUserHeader *hd=
r,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VhostUserPayload *payload)=
<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 struct iovec iov[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 { .iov_base =3D hdr,=C2=A0 =C2=A0 =C2=A0 =
.iov_len =3D VHOST_USER_HDR_SIZE },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 { .iov_base =3D payload,=C2=A0 .iov_len =
=3D hdr-&gt;size },<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 hdr-&gt;flags &amp;=3D ~VHOST_USER_NEED_REPLY_MASK;<br>
&gt; +=C2=A0 =C2=A0 hdr-&gt;flags |=3D VHOST_USER_REPLY_MASK;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (qio_channel_writev_all(ioc, iov, ARRAY_SIZE(iov), &=
amp;local_err)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report_err(local_err);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return true;<br>
&gt; +}<br>
<br>
I note you=C2=A0 ignored my comment regarding adding a &#39;Error **&#39; a=
rgument in<br>
the previous version:<br>
<a href=3D"https://lore.kernel.org/qemu-devel/911eef0c-d04f-2fcf-e78b-2475c=
d7af8f0@linaro.org/" rel=3D"noreferrer" target=3D"_blank">https://lore.kern=
el.org/qemu-devel/911eef0c-d04f-2fcf-e78b-2475cd7af8f0@linaro.org/</a><br>
<br></blockquote><div>Sorry I missed those comments somehow :/</div><div>I&=
#39;ll check them and resend.</div><div><br></div><div>BR,</div><div>Albert=
</div></div></div>

--000000000000a1780b0604b1a1ec--


