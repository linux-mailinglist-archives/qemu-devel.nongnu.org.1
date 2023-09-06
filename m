Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A46847935C0
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 08:56:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdmRl-00009y-CV; Wed, 06 Sep 2023 02:55:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qdmRg-00009V-Qr
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 02:55:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qdmRR-0004qA-8A
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 02:55:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693983306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f42J4JcYHAOcVzqs37QXQslp8d60XVjt5m7p3vles0Q=;
 b=Wy+b1E/89m8cg08MbkRYvM3i7s+X/aWLnvXHod2rBgu6nOJIUPNAYDR3thdFiwiHB69a4K
 uQvkFfEg1IJLV/UyqO4hlV+icEd2B5tWww/qu3ej36f443TdtSHyalQZronwUA+bc0NwKt
 /+JMzkta4g2xUygDZHEyBAI7fiLiZDQ=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-9hSSyh6gMVCSKdIAsk54Fg-1; Wed, 06 Sep 2023 02:55:05 -0400
X-MC-Unique: 9hSSyh6gMVCSKdIAsk54Fg-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-271cf74f2a2so4956947a91.2
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 23:55:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693983304; x=1694588104;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f42J4JcYHAOcVzqs37QXQslp8d60XVjt5m7p3vles0Q=;
 b=M38AUmRpx/w6pFWq8QvRfkytnO39U/bAfbhVJ8mlho68x1/ANiSGykyINu3uA+tAC6
 UyM65Uf5psaNCy5Jkpec07mtXofoYIQWaP1XdP9L77xYWjhl04OhHk/3doflEO7LZNEQ
 yrYaZYbjm7tgEV9Ipel5phfhtaduDmywj2lDHKGY1Gix7Ulfgt0P7lcZtV6jTMRhsfVq
 /i+SGgHPP/QkCUy1nxskC+v518tSWK0ljgsLBsivSK8ipguFnl/st2p52uQRWgBCOJe8
 Q8AewNM7M0osjzGw0DOeySr5LVrMUnLk0J/bB9HQ8BotykECMQOdU29yloH4klqJJAso
 YC/A==
X-Gm-Message-State: AOJu0YzkJ3QUh1iYRLAS1miDGo6jKlcEIF/RZMCWx8wgkut/3lxwDDi4
 YTkt0LG4XX6LGIl5nf3YoN1+aH56u3LRtZbz2DGveoQXzAykhE+m5LQfhoKgE3B9kwIOdF5gPiF
 fsve17NX2hMuEqOeQCtgkL8ti6Cm33bQ=
X-Received: by 2002:a17:90b:3b49:b0:267:f66a:f25f with SMTP id
 ot9-20020a17090b3b4900b00267f66af25fmr13698910pjb.11.1693983304284; 
 Tue, 05 Sep 2023 23:55:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6MoUTi01HXDJmxbeZA4gHAg/jzIfRfgQVviqY/hnLV641ZJx/lYwY03ZX+unuFNlPpoj15wpzEJP/s7dEOcc=
X-Received: by 2002:a17:90b:3b49:b0:267:f66a:f25f with SMTP id
 ot9-20020a17090b3b4900b00267f66af25fmr13698901pjb.11.1693983303998; Tue, 05
 Sep 2023 23:55:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230802090824.91688-1-aesteve@redhat.com>
 <20230802090824.91688-4-aesteve@redhat.com>
 <911eef0c-d04f-2fcf-e78b-2475cd7af8f0@linaro.org>
 <f53d7977-3e69-cffb-de28-79f883ef2412@linaro.org>
In-Reply-To: <f53d7977-3e69-cffb-de28-79f883ef2412@linaro.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 6 Sep 2023 08:54:52 +0200
Message-ID: <CADSE00LmA1RxcBeu-SO1cOsg6JpY3Wd+TaqxRp_np+L=xYBvmw@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] vhost-user: add shared_object msg
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, marcandre.lureau@gmail.com, kraxel@redhat.com, 
 cohuck@redhat.com, Fam Zheng <fam@euphon.net>,
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000001738170604ab398f"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
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

--0000000000001738170604ab398f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 6, 2023 at 8:10=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org>
wrote:

> On 6/9/23 08:04, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 2/8/23 11:08, Albert Esteve wrote:
> >> Add three new vhost-user protocol
> >> `VHOST_USER_BACKEND_SHARED_OBJECT_* messages`.
> >> These new messages are sent from vhost-user
> >> back-ends to interact with the virtio-dmabuf
> >> table in order to add or remove themselves as
> >> virtio exporters, or lookup for virtio dma-buf
> >> shared objects.
> >>
> >> The action taken in the front-end depends
> >> on the type stored in the virtio shared
> >> object hash table.
> >>
> >> When the table holds a pointer to a vhost
> >> backend for a given UUID, the front-end sends
> >> a VHOST_USER_GET_SHARED_OBJECT to the
> >> backend holding the shared object.
> >>
> >> In the libvhost-user library we need to add
> >> helper functions to allow sending messages to
> >> interact with the virtio shared objects
> >> hash table.
> >>
> >> The messages can only be sent after successfully
> >> negotiating a new VHOST_USER_PROTOCOL_F_SHARED_OBJECT
> >> vhost-user protocol feature bit.
> >>
> >> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> >> ---
> >>   docs/interop/vhost-user.rst               |  57 ++++++++
> >>   hw/virtio/vhost-user.c                    | 166 ++++++++++++++++++++=
++
> >>   include/hw/virtio/vhost-backend.h         |   3 +
> >>   subprojects/libvhost-user/libvhost-user.c | 118 +++++++++++++++
> >>   subprojects/libvhost-user/libvhost-user.h |  55 ++++++-
> >>   5 files changed, 398 insertions(+), 1 deletion(-)
> >
> >
> >> +static bool
> >> +vhost_user_backend_send_dmabuf_fd(QIOChannel *ioc, VhostUserHeader
> *hdr,
> >> +                                  VhostUserPayload *payload)
> >> +{
> >> +    Error *local_err =3D NULL;
> >> +    struct iovec iov[2];
> >> +
> >> +    if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
> >> +        hdr->flags &=3D ~VHOST_USER_NEED_REPLY_MASK;
> >> +    }
> >> +    hdr->flags |=3D VHOST_USER_REPLY_MASK;
> >> +
> >> +    hdr->size =3D sizeof(payload->u64);
> >> +
> >> +    iov[0].iov_base =3D hdr;
> >> +    iov[0].iov_len =3D VHOST_USER_HDR_SIZE;
> >> +    iov[1].iov_base =3D payload;
> >> +    iov[1].iov_len =3D hdr->size;
> >> +
> >> +    if (qio_channel_writev_all(ioc, iov, ARRAY_SIZE(iov), &local_err)=
)
> {
> >> +        error_report_err(local_err);
> >
> > This function could have a 'Error **errp' parameter to propagate
> > the error to the caller.
> >
> >> +        return false;
> >> +    }
> >> +    return true;
> >> +}
> >> +
> >> +static bool
> >> +vhost_user_backend_send_dmabuf_fd(QIOChannel *ioc, VhostUserHeader
> *hdr,
> >> +                                  VhostUserPayload *payload)
> >> +{
> >> +    hdr->size =3D sizeof(payload->u64);
> >> +    return vhost_user_send_resp(ioc, hdr, payload);
> >> +}
> >
> > I'm confused by having two vhost_user_backend_send_dmabuf_fd() function=
s
> > with different body...
>
> This patch doesn't compile:
>
> ../../hw/virtio/vhost-user.c:1662:1: error: redefinition of
> =E2=80=98vhost_user_backend_send_dmabuf_fd=E2=80=99
>   1662 | vhost_user_backend_send_dmabuf_fd(QIOChannel *ioc,
> VhostUserHeader *hdr,
>        | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../../hw/virtio/vhost-user.c:1636:1: note: previous definition of
> =E2=80=98vhost_user_backend_send_dmabuf_fd=E2=80=99 with type =E2=80=98_B=
ool(QIOChannel *,
> VhostUserHeader *, VhostUserPayload *)=E2=80=99
>   1636 | vhost_user_backend_send_dmabuf_fd(QIOChannel *ioc,
> VhostUserHeader *hdr,
>        | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../../hw/virtio/vhost-user.c: In function
> =E2=80=98vhost_user_backend_send_dmabuf_fd=E2=80=99:
> ../../hw/virtio/vhost-user.c:1666:12: error: implicit declaration of
> function =E2=80=98vhost_user_send_resp=E2=80=99; did you mean =E2=80=98vh=
ost_user_set_u64=E2=80=99?
> [-Werror=3Dimplicit-function-declaration]
>   1666 |     return vhost_user_send_resp(ioc, hdr, payload);
>        |            ^~~~~~~~~~~~~~~~~~~~
>        |            vhost_user_set_u64
> ../../hw/virtio/vhost-user.c:1666:12: error: nested extern declaration
> of =E2=80=98vhost_user_send_resp=E2=80=99 [-Werror=3Dnested-externs]
> At top level:
> ../../hw/virtio/vhost-user.c:1636:1: error:
> =E2=80=98vhost_user_backend_send_dmabuf_fd=E2=80=99 defined but not used
> [-Werror=3Dunused-function]
>   1636 | vhost_user_backend_send_dmabuf_fd(QIOChannel *ioc,
> VhostUserHeader *hdr,
>        | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
>
>
Uh, nice catch.
This was not happening before, but I did not try the patches individually
for the few last reviews.
I will squash it as suggested with the next patch.
Thanks for checking!

--0000000000001738170604ab398f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br clear=3D"all"><div><div dir=3D"ltr" c=
lass=3D"gmail_signature"><div dir=3D"ltr"><p style=3D"color:rgb(0,0,0);font=
-family:RedHatText,sans-serif;font-weight:bold;margin:0px;padding:0px;font-=
size:14px"><br></p></div></div></div></div><br><div class=3D"gmail_quote"><=
div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 6, 2023 at 8:10=E2=80=AFAM=
 Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">philm=
d@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">On 6/9/23 08:04, Philippe Mathieu-Daud=C3=A9 wrote:<br>
&gt; On 2/8/23 11:08, Albert Esteve wrote:<br>
&gt;&gt; Add three new vhost-user protocol<br>
&gt;&gt; `VHOST_USER_BACKEND_SHARED_OBJECT_* messages`.<br>
&gt;&gt; These new messages are sent from vhost-user<br>
&gt;&gt; back-ends to interact with the virtio-dmabuf<br>
&gt;&gt; table in order to add or remove themselves as<br>
&gt;&gt; virtio exporters, or lookup for virtio dma-buf<br>
&gt;&gt; shared objects.<br>
&gt;&gt;<br>
&gt;&gt; The action taken in the front-end depends<br>
&gt;&gt; on the type stored in the virtio shared<br>
&gt;&gt; object hash table.<br>
&gt;&gt;<br>
&gt;&gt; When the table holds a pointer to a vhost<br>
&gt;&gt; backend for a given UUID, the front-end sends<br>
&gt;&gt; a VHOST_USER_GET_SHARED_OBJECT to the<br>
&gt;&gt; backend holding the shared object.<br>
&gt;&gt;<br>
&gt;&gt; In the libvhost-user library we need to add<br>
&gt;&gt; helper functions to allow sending messages to<br>
&gt;&gt; interact with the virtio shared objects<br>
&gt;&gt; hash table.<br>
&gt;&gt;<br>
&gt;&gt; The messages can only be sent after successfully<br>
&gt;&gt; negotiating a new VHOST_USER_PROTOCOL_F_SHARED_OBJECT<br>
&gt;&gt; vhost-user protocol feature bit.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Albert Esteve &lt;<a href=3D"mailto:aesteve@redhat.=
com" target=3D"_blank">aesteve@redhat.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt; =C2=A0 docs/interop/vhost-user.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 57 ++++++++<=
br>
&gt;&gt; =C2=A0 hw/virtio/vhost-user.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 166 ++++++++++++++++++++++<br>
&gt;&gt; =C2=A0 include/hw/virtio/vhost-backend.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +<br>
&gt;&gt; =C2=A0 subprojects/libvhost-user/libvhost-user.c | 118 +++++++++++=
++++<br>
&gt;&gt; =C2=A0 subprojects/libvhost-user/libvhost-user.h |=C2=A0 55 ++++++=
-<br>
&gt;&gt; =C2=A0 5 files changed, 398 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; <br>
&gt;&gt; +static bool<br>
&gt;&gt; +vhost_user_backend_send_dmabuf_fd(QIOChannel *ioc, VhostUserHeade=
r *hdr,<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VhostUserPaylo=
ad *payload)<br>
&gt;&gt; +{<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 Error *local_err =3D NULL;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 struct iovec iov[2];<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 if (hdr-&gt;flags &amp; VHOST_USER_NEED_REPLY_=
MASK) {<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hdr-&gt;flags &amp;=3D=
 ~VHOST_USER_NEED_REPLY_MASK;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 hdr-&gt;flags |=3D VHOST_USER_REPLY_MASK;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 hdr-&gt;size =3D sizeof(payload-&gt;u64);<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 iov[0].iov_base =3D hdr;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 iov[0].iov_len =3D VHOST_USER_HDR_SIZE;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 iov[1].iov_base =3D payload;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 iov[1].iov_len =3D hdr-&gt;size;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 if (qio_channel_writev_all(ioc, iov, ARRAY_SIZ=
E(iov), &amp;local_err)) {<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report_err(local=
_err);<br>
&gt; <br>
&gt; This function could have a &#39;Error **errp&#39; parameter to propaga=
te<br>
&gt; the error to the caller.<br>
&gt; <br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 return true;<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt; +static bool<br>
&gt;&gt; +vhost_user_backend_send_dmabuf_fd(QIOChannel *ioc, VhostUserHeade=
r *hdr,<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VhostUserPaylo=
ad *payload)<br>
&gt;&gt; +{<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 hdr-&gt;size =3D sizeof(payload-&gt;u64);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 return vhost_user_send_resp(ioc, hdr, payload)=
;<br>
&gt;&gt; +}<br>
&gt; <br>
&gt; I&#39;m confused by having two vhost_user_backend_send_dmabuf_fd() fun=
ctions<br>
&gt; with different body...<br>
<br>
This patch doesn&#39;t compile:<br>
<br>
../../hw/virtio/vhost-user.c:1662:1: error: redefinition of <br>
=E2=80=98vhost_user_backend_send_dmabuf_fd=E2=80=99<br>
=C2=A0 1662 | vhost_user_backend_send_dmabuf_fd(QIOChannel *ioc, <br>
VhostUserHeader *hdr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0| ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<br>
../../hw/virtio/vhost-user.c:1636:1: note: previous definition of <br>
=E2=80=98vhost_user_backend_send_dmabuf_fd=E2=80=99 with type =E2=80=98_Boo=
l(QIOChannel *, <br>
VhostUserHeader *, VhostUserPayload *)=E2=80=99<br>
=C2=A0 1636 | vhost_user_backend_send_dmabuf_fd(QIOChannel *ioc, <br>
VhostUserHeader *hdr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0| ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<br>
../../hw/virtio/vhost-user.c: In function <br>
=E2=80=98vhost_user_backend_send_dmabuf_fd=E2=80=99:<br>
../../hw/virtio/vhost-user.c:1666:12: error: implicit declaration of <br>
function =E2=80=98vhost_user_send_resp=E2=80=99; did you mean =E2=80=98vhos=
t_user_set_u64=E2=80=99? <br>
[-Werror=3Dimplicit-function-declaration]<br>
=C2=A0 1666 |=C2=A0 =C2=A0 =C2=A0return vhost_user_send_resp(ioc, hdr, payl=
oad);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~=
~~~~~~~~~~~~~~~<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vhost=
_user_set_u64<br>
../../hw/virtio/vhost-user.c:1666:12: error: nested extern declaration <br>
of =E2=80=98vhost_user_send_resp=E2=80=99 [-Werror=3Dnested-externs]<br>
At top level:<br>
../../hw/virtio/vhost-user.c:1636:1: error: <br>
=E2=80=98vhost_user_backend_send_dmabuf_fd=E2=80=99 defined but not used <b=
r>
[-Werror=3Dunused-function]<br>
=C2=A0 1636 | vhost_user_backend_send_dmabuf_fd(QIOChannel *ioc, <br>
VhostUserHeader *hdr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0| ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<br>
cc1: all warnings being treated as errors<br>
<br></blockquote><div><br></div><div>Uh, nice catch.</div><div>This was not=
 happening before, but I did not try the patches individually for the few l=
ast reviews.</div><div>I will squash it as suggested with the next patch.=
=C2=A0</div><div>Thanks for checking!</div></div></div>

--0000000000001738170604ab398f--


