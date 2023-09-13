Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A02BE79E87B
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 14:59:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgPRx-0004lp-8p; Wed, 13 Sep 2023 08:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qgPRs-0004lM-82
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 08:58:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qgPRp-0005Kg-BT
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 08:58:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694609904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=39ec+42JeB+j1CbwXASOlDxqz4wzR2fUyc8rEMzvKgY=;
 b=XCQcJUhwALR6jbzeAJJk37m+vVTridoRwHwUf1v0UFXT9s1BYb9GSQRDhT2iA5rtAGIqnY
 Is5+rokWai6X0YiM5X5QNrA32NMMZk0E2j5uHK+BSuasFjfjuxnZH3A6caSKiQ5yaSP4zn
 d1Ind7kcxMh/HBQCsNeydSh/6CIJj6s=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-DlgmH5B7NZOyZq7JRqnKFw-1; Wed, 13 Sep 2023 08:58:20 -0400
X-MC-Unique: DlgmH5B7NZOyZq7JRqnKFw-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-267f666104aso890121a91.0
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 05:58:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694609899; x=1695214699;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=39ec+42JeB+j1CbwXASOlDxqz4wzR2fUyc8rEMzvKgY=;
 b=aPlK5Lmu+uTGhYSD1N92BUFSjqLv44Gssw3g7QSrSX7cQtWPRv06ve4+FOMHOUY0/H
 yQc04otDEixbn5Y5BTIa5TZVrt83W7kY8EHmBO9j6uY2ofI8Ifn/AYRw0K3YrZEehK0n
 4Vk0y4n+/+1drMAQbGswL5sMwo3elMZRAtDwi64oXOw8jd7Gz4Qlxq8ekHek5Czm/+j8
 ywrSPbby7eyr1KU/2klrooBUzJxvHCPgnCx951GSyqkdl5oK4YYAB/A8J34bMK2hJDi7
 rPGAC5fkCmYVYjqNefxlct6MOWBYyrFC2hLmroT/VPJRSpJssyeejTye/jJ4PfK5tdZv
 I19w==
X-Gm-Message-State: AOJu0YzYTDzZW9HwxFb+KR9ugPYpQ2HBuhScWWQ0mZCfvh/m1YtskRnv
 ZALWb7/N8wmTRYFNggySwswZOebH1ZUAvQG3Xg0V1BY2Oz2CyjhNv7aGKKhivMnAmuVDDMS6aRM
 BLrwfgAuZfcLj9FylWfvxih4yekx0sq0=
X-Received: by 2002:a17:90b:1902:b0:269:4fe8:687 with SMTP id
 mp2-20020a17090b190200b002694fe80687mr3917102pjb.19.1694609899652; 
 Wed, 13 Sep 2023 05:58:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH61qvMRdN3LPMiWAjCSRDtpzdel5iiJmmJEhut4Q0QbARnWkG/bcS1VhoV1g2d29bwNFmFQWLpet9R1u26/N8=
X-Received: by 2002:a17:90b:1902:b0:269:4fe8:687 with SMTP id
 mp2-20020a17090b190200b002694fe80687mr3917071pjb.19.1694609899262; Wed, 13
 Sep 2023 05:58:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230831093252.2461282-1-ray.huang@amd.com>
 <20230831093252.2461282-11-ray.huang@amd.com>
 <58a4e81f-b0ce-49db-8a6a-f6b5bdc3d2d6@daynix.com> <ZPw2UjxogIULU722@amd.com>
 <11c227e8-a464-41ce-a435-82c570746388@daynix.com>
 <CADSE00Kc1Jza7sbERRndWbXgoF1s2V-FNxEOWJ6WgvomzgvMPA@mail.gmail.com>
 <cf99ac00-6f48-4778-b319-6079a931ba5d@daynix.com>
 <CADSE00+6zcT7iKR0JW1Bk8es6HtBpzAKa9JW6u5yyjDoLPw2KQ@mail.gmail.com>
 <5e88f5d5-5aa2-4052-b250-69c2a443344f@daynix.com>
In-Reply-To: <5e88f5d5-5aa2-4052-b250-69c2a443344f@daynix.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 13 Sep 2023 14:58:07 +0200
Message-ID: <CADSE00+BUq-6jKH3v2PYNThn+9Z4UCFcr3Cv9Z48eUX0b=6ymA@mail.gmail.com>
Subject: Re: [QEMU PATCH v4 10/13] virtio-gpu: Resource UUID
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Huang Rui <ray.huang@amd.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony.perard@citrix.com>, 
 Antonio Caggiano <antonio.caggiano@collabora.com>, 
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, 
 Gurchetan Singh <gurchetansingh@chromium.org>,
 "ernunes@redhat.com" <ernunes@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, 
 "Ragiadakou, Xenia" <Xenia.Ragiadakou@amd.com>, 
 "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>, 
 "Huang, Honglei1" <Honglei1.Huang@amd.com>, "Zhang,
 Julia" <Julia.Zhang@amd.com>, "Chen, Jiqian" <Jiqian.Chen@amd.com>
Content-Type: multipart/alternative; boundary="00000000000014281b06053d1d4f"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

--00000000000014281b06053d1d4f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2023 at 2:22=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com>
wrote:

> On 2023/09/13 20:34, Albert Esteve wrote:
> >
> >
> > On Wed, Sep 13, 2023 at 12:34=E2=80=AFPM Akihiko Odaki <akihiko.odaki@d=
aynix.com
> > <mailto:akihiko.odaki@daynix.com>> wrote:
> >
> >     On 2023/09/13 16:55, Albert Esteve wrote:
> >      > Hi Antonio,
> >      >
> >      > If I'm not mistaken, this patch is related with:
> >      >
> >     https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg01853.html
> >     <https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg01853.htm=
l
> >
> >      >
> >     <https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg01853.htm=
l
> >     <https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg01853.htm=
l
> >>
> >      > IMHO, ideally, virtio-gpu and vhost-user-gpu both, would use the
> >      > infrastructure from the patch I linked to store the
> >      > virtio objects, so that they can be later shared with other
> devices.
> >
> >     I don't think such sharing is possible because the resources are
> >     identified by IDs that are local to the device. That also complicat=
es
> >     migration.
> >
> >     Regards,
> >     Akihiko Odaki
> >
> > Hi Akihiko,
> >
> > As far as I understand, the feature to export dma-bufs from the
> > virtgpu was introduced as part of the virtio cross-device sharing
> > proposal [1]. Thus, it shall be posible. When virtgpu ASSING_UUID,
> > it exports and identifies the dmabuf resource, so that when the dmabuf
> gets
> > shared inside the guest (e.g., with virtio-video), we can use the
> assigned
> > UUID to find the dmabuf in the host (using the patch that I linked
> above),
> > and import it.
> >
> > [1] - https://lwn.net/Articles/828988/ <https://lwn.net/Articles/828988=
/
> >
>
> The problem is that virtio-gpu can have other kind of resources like
> pixman and OpenGL textures and manage them and DMA-BUFs with unified
> resource ID.
>

I see.


>
> So you cannot change:
> g_hash_table_insert(g->resource_uuids,
> GUINT_TO_POINTER(assign.resource_id), uuid);
> by:
> virtio_add_dmabuf(uuid, assign.resource_id);
>
> assign.resource_id is not DMA-BUF file descriptor, and the underlying
> resource my not be DMA-BUF at first place.
>

I didn't really look into the patch in-depth, so the code was intended
to give an idea of how the implementation would look like with
the cross-device patch API. Indeed, it is not the resource_id,
(I just took a brief look at the virtio specificacion 1.2), but the
underlying
resource what we want to use here.


>
> Also, since this lives in the common code that is not used only by
> virtio-gpu-gl but also virtio-gpu, which supports migration, we also
> need to take care of that. It is not a problem for DMA-BUF as DMA-BUF is
> not migratable anyway, but the situation is different in this case.
>
> Implementing cross-device sharing is certainly a possibility, but that
> requires more than dealing with DMA-BUFs.
>
>
So, if I understood correctly, dmabufs are just a subset of the resources
that the gpu manages, or can assign UUIDs to. I am not sure why
the virt gpu driver would want to send a ASSIGN_UUID for anything
that is not a dmabuf (are we sure it does?), but I am not super familiarize=
d
with virtgpu to begin with.
But I see that internally, the GPU specs relate a UUID with a resource_id,
so we still need both tables:
- one to relate UUID with resource_id to be able to locate the underlying
resource
- the table that holds the dmabuf with the UUID for cross-device sharing

With that in mind, sounds to me that the support for cross-device sharing
could
be added on top of this patch, once
https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg01850.html
lands.

I hope that makes sense.
Regards,
Albert

--00000000000014281b06053d1d4f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_sign=
ature"><div dir=3D"ltr"><br></div></div></div></div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 13, 2023 at 2:22=
=E2=80=AFPM Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com">a=
kihiko.odaki@daynix.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">On 2023/09/13 20:34, Albert Esteve wrote:<br>
&gt; <br>
&gt; <br>
&gt; On Wed, Sep 13, 2023 at 12:34=E2=80=AFPM Akihiko Odaki &lt;<a href=3D"=
mailto:akihiko.odaki@daynix.com" target=3D"_blank">akihiko.odaki@daynix.com=
</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:akihiko.odaki@daynix.com" target=3D"_blan=
k">akihiko.odaki@daynix.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 2023/09/13 16:55, Albert Esteve wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Hi Antonio,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; If I&#39;m not mistaken, this patch is relate=
d with:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://lists.gnu.org/archive/html/qemu-=
devel/2023-09/msg01853.html" rel=3D"noreferrer" target=3D"_blank">https://l=
ists.gnu.org/archive/html/qemu-devel/2023-09/msg01853.html</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://lists.gnu.org/archive/html/q=
emu-devel/2023-09/msg01853.html" rel=3D"noreferrer" target=3D"_blank">https=
://lists.gnu.org/archive/html/qemu-devel/2023-09/msg01853.html</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://lists.gnu.org/archive/html/q=
emu-devel/2023-09/msg01853.html" rel=3D"noreferrer" target=3D"_blank">https=
://lists.gnu.org/archive/html/qemu-devel/2023-09/msg01853.html</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://lists.gnu.org/archive/html/q=
emu-devel/2023-09/msg01853.html" rel=3D"noreferrer" target=3D"_blank">https=
://lists.gnu.org/archive/html/qemu-devel/2023-09/msg01853.html</a>&gt;&gt;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; IMHO, ideally, virtio-gpu and vhost-user-gpu =
both, would use the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; infrastructure from the patch I linked to sto=
re the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; virtio objects, so that they can be later sha=
red with other devices.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0I don&#39;t think such sharing is possible because =
the resources are<br>
&gt;=C2=A0 =C2=A0 =C2=A0identified by IDs that are local to the device. Tha=
t also complicates<br>
&gt;=C2=A0 =C2=A0 =C2=A0migration.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Regards,<br>
&gt;=C2=A0 =C2=A0 =C2=A0Akihiko Odaki<br>
&gt; <br>
&gt; Hi Akihiko,<br>
&gt; <br>
&gt; As far as I understand, the feature to export dma-bufs=C2=A0from the<b=
r>
&gt; virtgpu was introduced as part of the virtio cross-device sharing<br>
&gt; proposal [1]. Thus, it shall be posible. When virtgpu=C2=A0ASSING_UUID=
,<br>
&gt; it exports and identifies the dmabuf resource, so that when the dmabuf=
 gets<br>
&gt; shared inside the guest (e.g., with virtio-video), we can use the assi=
gned<br>
&gt; UUID to find the dmabuf in the host (using the patch that I linked abo=
ve),<br>
&gt; and import it.<br>
&gt; <br>
&gt; [1] - <a href=3D"https://lwn.net/Articles/828988/" rel=3D"noreferrer" =
target=3D"_blank">https://lwn.net/Articles/828988/</a> &lt;<a href=3D"https=
://lwn.net/Articles/828988/" rel=3D"noreferrer" target=3D"_blank">https://l=
wn.net/Articles/828988/</a>&gt;<br>
<br>
The problem is that virtio-gpu can have other kind of resources like <br>
pixman and OpenGL textures and manage them and DMA-BUFs with unified <br>
resource ID.<br></blockquote><div><br></div><div>I see.</div><div>=C2=A0</d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
So you cannot change:<br>
g_hash_table_insert(g-&gt;resource_uuids, <br>
GUINT_TO_POINTER(assign.resource_id), uuid);<br>
by:<br>
virtio_add_dmabuf(uuid, assign.resource_id);<br>
<br>
assign.resource_id is not DMA-BUF file descriptor, and the underlying <br>
resource my not be DMA-BUF at first place.<br></blockquote><div><br></div><=
div>I didn&#39;t really look into the patch in-depth, so the=C2=A0code was =
intended</div><div>to give an idea of how the implementation would look lik=
e with</div><div>the cross-device patch API. Indeed, it is not the resource=
_id,</div><div>(I just took a brief look at the virtio specificacion=C2=A01=
.2), but the underlying</div><div>resource what we want to use here.</div><=
div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Also, since this lives in the common code that is not used only by <br>
virtio-gpu-gl but also virtio-gpu, which supports migration, we also <br>
need to take care of that. It is not a problem for DMA-BUF as DMA-BUF is <b=
r>
not migratable anyway, but the situation is different in this case.<br>
<br>
Implementing cross-device sharing is certainly a possibility, but that <br>
requires more than dealing with DMA-BUFs.<br>
<br></blockquote><div><br></div><div>So, if I understood correctly, dmabufs=
=C2=A0are just a subset of the resources</div><div>that the gpu manages, or=
 can assign UUIDs to. I am not sure why</div><div>the virt gpu driver would=
 want to send a ASSIGN_UUID for anything</div><div>that is not a dmabuf (ar=
e we sure it does?), but I am not super familiarized</div><div>with virtgpu=
=C2=A0to begin with.</div><div>But I see that internally, the GPU specs rel=
ate a UUID with a resource_id,</div><div>so we still need both tables:</div=
><div>- one to relate UUID with resource_id to be able to locate the underl=
ying resource</div><div>- the table that holds the dmabuf with the UUID for=
 cross-device sharing</div><div><br></div><div>With that in mind, sounds to=
 me that the support for cross-device sharing could</div><div>be added on t=
op of this patch, once=C2=A0<a href=3D"https://lists.gnu.org/archive/html/q=
emu-devel/2023-09/msg01850.html">https://lists.gnu.org/archive/html/qemu-de=
vel/2023-09/msg01850.html</a></div><div>lands.</div><div><br></div><div>I h=
ope that makes sense.</div><div>Regards,</div><div>Albert</div></div></div>

--00000000000014281b06053d1d4f--


