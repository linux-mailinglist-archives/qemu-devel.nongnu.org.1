Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B59257B50A5
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 12:50:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnGV4-0008Ml-V9; Mon, 02 Oct 2023 06:50:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qnGUt-0008H2-TW
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 06:49:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qnGUr-0005vn-9j
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 06:49:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696243791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U38dwyTaNubqH3rEJUkTJOlArd7D3rIdNGE8DKD5ptQ=;
 b=ER15mTYA2BcY7qCy53sfLdvWIsQhf4PPig9+6db/TySDtuZHdHGKiiyBF+LILbRAy4GfQy
 S29RbuwXQKQMqmbvV9YtEugktXHAwLFZ0YHwRZpsgfHrC1cMhswE2aOnYNeG8TjtO+zMx1
 RqCtqq9IAP8X03qywT0l+sqrrZSQkH4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-L4IMIXGgP6mwOZWW7hVlpQ-1; Mon, 02 Oct 2023 06:49:44 -0400
X-MC-Unique: L4IMIXGgP6mwOZWW7hVlpQ-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-278f5b7a960so8642109a91.2
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 03:49:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696243783; x=1696848583;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U38dwyTaNubqH3rEJUkTJOlArd7D3rIdNGE8DKD5ptQ=;
 b=UTWwq44r6CT0eIZgo8xE4d9lOv1le7zTj45YP9VeNOj0nl1Y7DrH/+94ZllkX4SucB
 b9zG6HmcyPIiczU68iN+KodeitWKmd3q1BpXOuJrTdN5nrOkGk2jsYFlJPWkjlrZR9sG
 SIaFgRM9GGGK9uSepv528yh+q5EiodEbBFTX1ofq+HV4fJNJTfZdoTrBuCk+GoTqt3jT
 LYmoTBBOpNs1FMY7p/FRyi6wMyUlHuq2AekHwzXEnEbNUdfyRxGOhHtU5rXWXxJVmk3I
 4B3WtfRsHoW5aAzgjllPylpPQNpZPeNXWesO0SkSAkqJxoIoyqAiNr367IrzhLcR5IwS
 JAUQ==
X-Gm-Message-State: AOJu0YzMvnqYIx+XrR5rAgzCN96ZS78wSrOxY++F2FqCkYuRbHjK5E+s
 rPY0CLmoDPx4kLKpVnl3nQjOAUX6rTQDiBlnGP+eaotNfyYfKMWGOQFojcnAqdHGa+3YlxkyyLe
 1NLJQG2yEM2X2KtzSeug0HIYzGOq+FL2K8AR3Zyebvw==
X-Received: by 2002:a05:6a20:244e:b0:154:a9bc:12d0 with SMTP id
 t14-20020a056a20244e00b00154a9bc12d0mr13016676pzc.13.1696243783523; 
 Mon, 02 Oct 2023 03:49:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6Be4HOrdWpF24MbxFbK8wXe/35+cLjrTuMLZReRCcmXuo39rLA1ligoZkmgghDpI+y4vinynfmSK3uxzwOBY=
X-Received: by 2002:a05:6a20:244e:b0:154:a9bc:12d0 with SMTP id
 t14-20020a056a20244e00b00154a9bc12d0mr13016662pzc.13.1696243783128; Mon, 02
 Oct 2023 03:49:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230901122323.66183-1-aesteve@redhat.com>
 <20231002052550-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231002052550-mutt-send-email-mst@kernel.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 2 Oct 2023 12:49:31 +0200
Message-ID: <CADSE00JdS7RMbemmxP6DKHw3TpYHrFGZ6n287=XE_Q2gHh9bPw@mail.gmail.com>
Subject: Re: [PATCH] hw/virtio/vhost: check nvqs at dev_start
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000025716f0606b988c6"
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

--00000000000025716f0606b988c6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ah I see, I wanted to move the fail check as early as possible, and went a
bit too far ahead, before initialisation.

But is ok, it needs its own value either way. What about returning -EFAULT?
Or maybe -EINVAL? I think they would fit for this error.
And then I can use `VHOST_OPS_DEBUG` to make it consistent and print the
error number.

On Mon, Oct 2, 2023 at 11:27=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:

> On Fri, Sep 01, 2023 at 02:23:23PM +0200, Albert Esteve wrote:
> > While this is not expected to happen, it could still
> > be that a vhost_dev did not set its nvqs member.
> >
> > Since `vhost_dev_start` access the device's vqs array
> > later without checking its size, it would cause a
> > Segmentation fault when nvqs is 0.
> >
> > To avoid this `rare` case and made the code safer,
> > add a clause that ensures nvqs has been set, and
> > warn the user if it has not.
> >
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> >  hw/virtio/vhost.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > index e2f6ffb446..78805fe5b7 100644
> > --- a/hw/virtio/vhost.c
> > +++ b/hw/virtio/vhost.c
> > @@ -1935,6 +1935,11 @@ int vhost_dev_start(struct vhost_dev *hdev,
> VirtIODevice *vdev, bool vrings)
> >      hdev->started =3D true;
> >      hdev->vdev =3D vdev;
> >
> > +    if (!hdev->nvqs) {
> > +        error_report("device nvqs not set");
> > +        goto fail_nvqs;
> > +    }
> > +
> >      r =3D vhost_dev_set_features(hdev, hdev->log_enabled);
> >      if (r < 0) {
> >          goto fail_features;
> > @@ -2028,6 +2033,7 @@ fail_mem:
> >      if (vhost_dev_has_iommu(hdev)) {
> >          memory_listener_unregister(&hdev->iommu_listener);
> >      }
> > +fail_nvqs:
> >  fail_features:
> >      vdev->vhost_started =3D false;
> >      hdev->started =3D false;
>
> What do we want to return in this case?
> ATM the value we return (r) will be uninitialized.
>
> > --
> > 2.41.0
>
>

--00000000000025716f0606b988c6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Ah I see, I wanted to move the fail check as early as poss=
ible, and went a bit too far ahead, before initialisation.<div><br></div><d=
iv>But is ok, it needs its own value either way. What about returning -EFAU=
LT? Or maybe -EINVAL? I think they would fit for this error.</div><div>And =
then I can use `VHOST_OPS_DEBUG` to make it consistent and print the error =
number.</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">On Mon, Oct 2, 2023 at 11:27=E2=80=AFAM Michael S. Tsirkin &lt=
;<a href=3D"mailto:mst@redhat.com">mst@redhat.com</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">On Fri, Sep 01, 2023 at 02=
:23:23PM +0200, Albert Esteve wrote:<br>
&gt; While this is not expected to happen, it could still<br>
&gt; be that a vhost_dev did not set its nvqs member.<br>
&gt; <br>
&gt; Since `vhost_dev_start` access the device&#39;s vqs array<br>
&gt; later without checking its size, it would cause a<br>
&gt; Segmentation fault when nvqs is 0.<br>
&gt; <br>
&gt; To avoid this `rare` case and made the code safer,<br>
&gt; add a clause that ensures nvqs has been set, and<br>
&gt; warn the user if it has not.<br>
&gt; <br>
&gt; Signed-off-by: Albert Esteve &lt;<a href=3D"mailto:aesteve@redhat.com"=
 target=3D"_blank">aesteve@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/virtio/vhost.c | 6 ++++++<br>
&gt;=C2=A0 1 file changed, 6 insertions(+)<br>
&gt; <br>
&gt; diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c<br>
&gt; index e2f6ffb446..78805fe5b7 100644<br>
&gt; --- a/hw/virtio/vhost.c<br>
&gt; +++ b/hw/virtio/vhost.c<br>
&gt; @@ -1935,6 +1935,11 @@ int vhost_dev_start(struct vhost_dev *hdev, Vir=
tIODevice *vdev, bool vrings)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 hdev-&gt;started =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 hdev-&gt;vdev =3D vdev;<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 if (!hdev-&gt;nvqs) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;device nvqs not set&qu=
ot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail_nvqs;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 r =3D vhost_dev_set_features(hdev, hdev-&gt;log_en=
abled);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (r &lt; 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail_features;<br>
&gt; @@ -2028,6 +2033,7 @@ fail_mem:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (vhost_dev_has_iommu(hdev)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_listener_unregister(&amp;hdev=
-&gt;iommu_listener);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +fail_nvqs:<br>
&gt;=C2=A0 fail_features:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 vdev-&gt;vhost_started =3D false;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 hdev-&gt;started =3D false;<br>
<br>
What do we want to return in this case?<br>
ATM the value we return (r) will be uninitialized.<br>
<br>
&gt; -- <br>
&gt; 2.41.0<br>
<br>
</blockquote></div>

--00000000000025716f0606b988c6--


