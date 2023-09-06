Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D40793604
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 09:15:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdmj1-0004sy-3y; Wed, 06 Sep 2023 03:13:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qdmiz-0004sn-GS
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 03:13:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qdmiu-0007pV-Gv
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 03:13:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693984391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UdypeWNTfusUhdrOJ8/yCPKEZUv7DsEP4dTHo2Z5B4k=;
 b=Es1efp+lOGVmBYO0Y/R1o7J/lI5MK3LzfwlU/ywRkYmN8eNwRlJ7WNMx8GVuN9OGR6ggZO
 jZUPJirTYOmnkMaYDifq1Lj8/72HIRHtXEcLbHgipb5MGQHHjsJkWBQGpme0qwdNr225mz
 M2CIftEczWRJA7KI2SI/vKWIbrKaMr8=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-i8nwArd0MrCHcUfEWTh5gA-1; Wed, 06 Sep 2023 03:13:07 -0400
X-MC-Unique: i8nwArd0MrCHcUfEWTh5gA-1
Received: by mail-il1-f197.google.com with SMTP id
 e9e14a558f8ab-34df6d158dcso20578075ab.3
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 00:13:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693984387; x=1694589187;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UdypeWNTfusUhdrOJ8/yCPKEZUv7DsEP4dTHo2Z5B4k=;
 b=XvTza3Ch2bSdvlv4DvfgYvZoQUnWrNAlYlsSYL00YOFfzUvXedQOYye+xVjxPh+W3e
 C7cYvuUJxHXzncSiR2p6VJ8TyYUcOGuXV7ahn8IQuvopGs2c6z1N+NEbp3wlsHcOe7s4
 w1b4Kkj8ZXQtE0XFUkPxcf6ALGxYtPfBPKeyWLUMclNzO5o9n7j9XSFxorjFIftw91ds
 2I5MvDDixD5l+7b3HcNC4K3oC04H51tDZSSRYtDKoePJRoG/2+nPCMQI3WpYHbwUDw3r
 E5qz+tH0bAmtyvYlB6u1aT5Q+pnXOthHyUF7GdxqmXSP7ItnW9tSREdLjbYO0IWWTC2B
 P/Gw==
X-Gm-Message-State: AOJu0YzmvVXMYdiwITMFDANM+E4x6wNLcANdKOqyvqvOrqeuGDfiiQBX
 MxwbY7aFasCOEyFfVsqDoSARhRnvYbUV78DLlFz2FKHLscKJY90m/PfYXr/saMV5YDS2kZ5EuPN
 7V2TxvkUOBiVIAI547qvo1040Bcyso2Q=
X-Received: by 2002:a05:6e02:12ab:b0:345:df7f:efc4 with SMTP id
 f11-20020a056e0212ab00b00345df7fefc4mr15833220ilr.27.1693984386867; 
 Wed, 06 Sep 2023 00:13:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4kTp8+0XW9h+MWHS+MYXnbio09sg3YN6K0TcDp8y4y51atmme7sprbl2cfOOWsuHzgvkA1Sp4Megryeunvbg=
X-Received: by 2002:a05:6e02:12ab:b0:345:df7f:efc4 with SMTP id
 f11-20020a056e0212ab00b00345df7fefc4mr15833210ilr.27.1693984386616; Wed, 06
 Sep 2023 00:13:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230830134055.106812-1-lersek@redhat.com>
 <20230830134055.106812-2-lersek@redhat.com>
 <ce2b4c96-8a6b-247c-14eb-b3a6c81973f0@redhat.com>
In-Reply-To: <ce2b4c96-8a6b-247c-14eb-b3a6c81973f0@redhat.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 6 Sep 2023 09:12:55 +0200
Message-ID: <CADSE00+9s4etckQFqGbxc3xB281tffTRPs5CAO5b7J9PeQsyrA@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] vhost-user: strip superfluous whitespace
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>, 
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000009ea7020604ab7932"
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

--0000000000009ea7020604ab7932
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 31, 2023 at 9:14=E2=80=AFAM Laszlo Ersek <lersek@redhat.com> wr=
ote:

> On 8/30/23 15:40, Laszlo Ersek wrote:
> > Cc: "Michael S. Tsirkin" <mst@redhat.com> (supporter:vhost)
> > Cc: Eugenio Perez Martin <eperezma@redhat.com>
> > Cc: German Maglione <gmaglione@redhat.com>
> > Cc: Liu Jiang <gerry@linux.alibaba.com>
> > Cc: Sergio Lopez Pascual <slp@redhat.com>
> > Cc: Stefano Garzarella <sgarzare@redhat.com>
> > Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> > Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> >
> > Notes:
> >     v2:
> >
> >     - pick up Stefano's R-b
> >
> >  hw/virtio/vhost-user.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> This has been
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
> under the (identical) v1 posting:
>
> http://mid.mail-archive.com/cd0604a1-6826-ac6c-6c47-dcb6def64b28@linaro.o=
rg
>
> Thanks, Phil! (and sorry that I posted v2 too quickly -- I forgot that
> sometimes reviewers split a review over multiple days.)
>
> Laszlo
>
> >
> > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > index 8dcf049d422b..b4b677c1ce66 100644
> > --- a/hw/virtio/vhost-user.c
> > +++ b/hw/virtio/vhost-user.c
> > @@ -398,7 +398,7 @@ static int vhost_user_write(struct vhost_dev *dev,
> VhostUserMsg *msg,
> >       * operations such as configuring device memory mappings or issuin=
g
> device
> >       * resets, which affect the whole device instead of individual VQs=
,
> >       * vhost-user messages should only be sent once.
> > -     *
> > +     *
> >       * Devices with multiple vhost_devs are given an associated
> dev->vq_index
> >       * so per_device requests are only sent if vq_index is 0.
> >       */
> >
>
>
Thanks for the series!
I had a timeout problem with a virtio device I am developing, and I was not
sure yet what was going on.
Your description of the problem seemed to fit mine, in my case the driver
sent a command through the data plane
right after the feature negotiation that reached the backend too soon.
Adding delays alleviated the issue, so it
already hinted me to a race condition.

I tested using this patch series and according to my experiments, it really
lowers the chances to get the deadlock.
Sadly, I do still get the issue sometimes, though (not frequently)...
However, I think probably the solution comes not
from the Qemu side, but from the rust-vmm vhost-user-backend crate. I am
looking for that solution on my side.

But that does not invalidate this patch, which I think is a necessary
improvement, and in my tests it really
helps a lot with the described issue. Therefore:

Tested-by: Albert Esteve <aesteve@redhat.com>

BR,
Albert

--0000000000009ea7020604ab7932
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_sign=
ature"><div dir=3D"ltr"><br></div></div></div></div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Aug 31, 2023 at 9:14=
=E2=80=AFAM Laszlo Ersek &lt;<a href=3D"mailto:lersek@redhat.com">lersek@re=
dhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">On 8/30/23 15:40, Laszlo Ersek wrote:<br>
&gt; Cc: &quot;Michael S. Tsirkin&quot; &lt;<a href=3D"mailto:mst@redhat.co=
m" target=3D"_blank">mst@redhat.com</a>&gt; (supporter:vhost)<br>
&gt; Cc: Eugenio Perez Martin &lt;<a href=3D"mailto:eperezma@redhat.com" ta=
rget=3D"_blank">eperezma@redhat.com</a>&gt;<br>
&gt; Cc: German Maglione &lt;<a href=3D"mailto:gmaglione@redhat.com" target=
=3D"_blank">gmaglione@redhat.com</a>&gt;<br>
&gt; Cc: Liu Jiang &lt;<a href=3D"mailto:gerry@linux.alibaba.com" target=3D=
"_blank">gerry@linux.alibaba.com</a>&gt;<br>
&gt; Cc: Sergio Lopez Pascual &lt;<a href=3D"mailto:slp@redhat.com" target=
=3D"_blank">slp@redhat.com</a>&gt;<br>
&gt; Cc: Stefano Garzarella &lt;<a href=3D"mailto:sgarzare@redhat.com" targ=
et=3D"_blank">sgarzare@redhat.com</a>&gt;<br>
&gt; Signed-off-by: Laszlo Ersek &lt;<a href=3D"mailto:lersek@redhat.com" t=
arget=3D"_blank">lersek@redhat.com</a>&gt;<br>
&gt; Reviewed-by: Stefano Garzarella &lt;<a href=3D"mailto:sgarzare@redhat.=
com" target=3D"_blank">sgarzare@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt; <br>
&gt; Notes:<br>
&gt;=C2=A0 =C2=A0 =C2=A0v2:<br>
&gt;=C2=A0 =C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0- pick up Stefano&#39;s R-b<br>
&gt; <br>
&gt;=C2=A0 hw/virtio/vhost-user.c | 2 +-<br>
&gt;=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
This has been<br>
<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linar=
o.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
<br>
under the (identical) v1 posting:<br>
<br>
<a href=3D"http://mid.mail-archive.com/cd0604a1-6826-ac6c-6c47-dcb6def64b28=
@linaro.org" rel=3D"noreferrer" target=3D"_blank">http://mid.mail-archive.c=
om/cd0604a1-6826-ac6c-6c47-dcb6def64b28@linaro.org</a><br>
<br>
Thanks, Phil! (and sorry that I posted v2 too quickly -- I forgot that<br>
sometimes reviewers split a review over multiple days.)<br>
<br>
Laszlo<br>
<br>
&gt; <br>
&gt; diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c<br>
&gt; index 8dcf049d422b..b4b677c1ce66 100644<br>
&gt; --- a/hw/virtio/vhost-user.c<br>
&gt; +++ b/hw/virtio/vhost-user.c<br>
&gt; @@ -398,7 +398,7 @@ static int vhost_user_write(struct vhost_dev *dev,=
 VhostUserMsg *msg,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* operations such as configuring device memo=
ry mappings or issuing device<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* resets, which affect the whole device inst=
ead of individual VQs,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* vhost-user messages should only be sent on=
ce.<br>
&gt; -=C2=A0 =C2=A0 =C2=A0* <br>
&gt; +=C2=A0 =C2=A0 =C2=A0*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* Devices with multiple vhost_devs are given=
 an associated dev-&gt;vq_index<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* so per_device requests are only sent if vq=
_index is 0.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; <br>
<br></blockquote><div><br></div><div>Thanks for the series!</div><div>I had=
 a timeout problem with a virtio device I am developing, and I was not sure=
 yet what was going on.</div><div>Your description of the problem seemed to=
 fit mine, in my case the driver sent a command through the data plane</div=
><div>right after the feature negotiation that reached the backend too soon=
. Adding delays alleviated the issue, so it</div><div>already hinted me to =
a race condition.</div><div><br></div><div>I tested using this patch series=
 and according to my experiments, it really lowers the chances to get the d=
eadlock.</div><div>Sadly, I do still get the issue sometimes, though (not f=
requently)... However, I think probably the solution comes not</div><div>fr=
om the Qemu side, but from the rust-vmm vhost-user-backend crate. I am look=
ing for that solution on my side.</div><div><br></div><div>But that does no=
t invalidate this patch, which I think is a necessary improvement,=C2=A0and=
 in my tests it really</div><div>helps a lot with the=C2=A0described issue.=
 Therefore:</div><div><br></div><div>Tested-by: Albert Esteve &lt;<a href=
=3D"mailto:aesteve@redhat.com">aesteve@redhat.com</a>&gt;</div><div><br></d=
iv><div>BR,</div><div>Albert</div></div></div>

--0000000000009ea7020604ab7932--


